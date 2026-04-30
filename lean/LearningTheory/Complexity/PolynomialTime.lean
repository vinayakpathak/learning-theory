import LearningTheory.Complexity.Classes

namespace LearningTheory
namespace Complexity

universe u

/--
An interface for polynomial-time complexity classes over a fixed universe of
decision problems.

This file does not define a concrete Turing-machine or circuit model. It gives
the named class interface that the learning-theory reductions will target. A
future machine model can instantiate these fields.
-/
structure ComplexityLandscape where
  P : ComplexityClass.{u}
  NP : ComplexityClass.{u}
  RP : ComplexityClass.{u}
  P_subset_RP : Subset P RP
  RP_subset_NP : Subset RP NP

namespace ComplexityLandscape

/-- The usual separation assumption, stated inside a chosen landscape. -/
def RPNeNP (L : ComplexityLandscape.{u}) : Prop :=
  Not (Equal L.RP L.NP)

/-- A decision problem is NP-hard in a chosen complexity landscape. -/
def NPHard (L : ComplexityLandscape.{u}) (A : DecisionProblem.{u}) : Prop :=
  forall B : DecisionProblem.{u}, L.NP.contains B -> Nonempty (ManyOneReduction B A)

/-- A decision problem is NP-complete in a chosen complexity landscape. -/
def NPComplete (L : ComplexityLandscape.{u}) (A : DecisionProblem.{u}) : Prop :=
  L.NP.contains A /\ L.NPHard A

/-- A problem in `NP` but not in `RP` witnesses `RP != NP`. -/
theorem rp_ne_np_of_np_not_rp
    (L : ComplexityLandscape.{u})
    {A : DecisionProblem.{u}}
    (hNP : L.NP.contains A)
    (hNotRP : Not (L.RP.contains A)) :
    L.RPNeNP := by
  intro hEq
  exact hNotRP (hEq.right A hNP)

/-- Under `RP = NP`, every `NP` problem is in `RP`. -/
theorem rp_contains_of_np_contains_of_equal
    (L : ComplexityLandscape.{u})
    (hEq : Equal L.RP L.NP)
    {A : DecisionProblem.{u}}
    (hNP : L.NP.contains A) :
    L.RP.contains A := by
  exact hEq.right A hNP

end ComplexityLandscape

end Complexity
end LearningTheory
