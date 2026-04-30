namespace LearningTheory
namespace Complexity

universe u v w

/-- A decision problem, represented by its input type and accepted instances. -/
structure DecisionProblem where
  Input : Type u
  accepts : Input -> Prop

/-- A many-one reduction between decision problems. -/
structure ManyOneReduction (A : DecisionProblem.{u}) (B : DecisionProblem.{v}) where
  map : A.Input -> B.Input
  sound : forall x : A.Input, A.accepts x -> B.accepts (map x)
  complete : forall x : A.Input, B.accepts (map x) -> A.accepts x

namespace ManyOneReduction

/-- Many-one reductions compose. -/
def comp {A : DecisionProblem.{u}} {B : DecisionProblem.{v}}
    {C : DecisionProblem.{w}}
    (f : ManyOneReduction A B) (g : ManyOneReduction B C) :
    ManyOneReduction A C where
  map := fun x => g.map (f.map x)
  sound := by
    intro x h
    exact g.sound (f.map x) (f.sound x h)
  complete := by
    intro x h
    exact f.complete x (g.complete (f.map x) h)

end ManyOneReduction

/-- A complexity class as a predicate on decision problems. -/
structure ComplexityClass where
  contains : DecisionProblem.{u} -> Prop

/-- A complexity class is closed downward under many-one reductions. -/
def ClosedUnderManyOne (K : ComplexityClass.{u}) : Prop :=
  forall A B : DecisionProblem.{u},
    ManyOneReduction A B -> K.contains B -> K.contains A

/-- Inclusion of complexity classes. -/
def Subset (A B : ComplexityClass.{u}) : Prop :=
  forall L : DecisionProblem, A.contains L -> B.contains L

/-- Equality of complexity classes as mutual inclusion. -/
def Equal (A B : ComplexityClass.{u}) : Prop :=
  Subset A B /\ Subset B A

/-- A witness that one class is not included in another. -/
structure SeparationWitness (A B : ComplexityClass.{u}) where
  problem : DecisionProblem
  in_left : A.contains problem
  not_in_right : Not (B.contains problem)

/-- A separation witness refutes class inclusion. -/
theorem separationWitness_refutes_subset
    {A B : ComplexityClass.{u}} (W : SeparationWitness A B) :
    Not (Subset A B) := by
  intro h
  exact W.not_in_right (h W.problem W.in_left)

/-- If `A` is not included in `B`, then the two classes are not equal. -/
theorem not_equal_of_not_subset_left
    {A B : ComplexityClass.{u}} :
    Not (Subset A B) -> Not (Equal A B) := by
  intro hSubset hEq
  exact hSubset hEq.left

/--
If `A` many-one reduces to `B` and a class is closed under such reductions,
then non-membership of `A` implies non-membership of `B`.
-/
theorem not_contains_target_of_reduction
    {K : ComplexityClass.{u}}
    (hClosed : ClosedUnderManyOne K)
    {A B : DecisionProblem.{u}}
    (red : ManyOneReduction A B)
    (hNotA : Not (K.contains A)) :
    Not (K.contains B) := by
  intro hB
  exact hNotA (hClosed A B red hB)

end Complexity
end LearningTheory
