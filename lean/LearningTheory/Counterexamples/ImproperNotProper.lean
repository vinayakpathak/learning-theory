import LearningTheory.Learning.Computational
import LearningTheory.Learning.Exact

namespace LearningTheory
namespace Learning
namespace Counterexamples

/--
Two target concepts for a small representation-level separation.

This is not the Pitt-Valiant theorem; it is a compiled countermodel that tests
the formal plumbing for proper/improper separations without using external
complexity-theoretic results.
-/
inductive ToyTarget where
  | left : ToyTarget
  | right : ToyTarget

/-- One proper hypothesis: the constant-true hypothesis. -/
inductive ToyProperHyp where
  | trueOnly : ToyProperHyp

/-- Two improper hypotheses: both constant Boolean hypotheses. -/
inductive ToyImproperHyp where
  | trueHyp : ToyImproperHyp
  | falseHyp : ToyImproperHyp

/-- The instance type is irrelevant in this minimal example. -/
inductive ToyInstance where
  | point : ToyInstance

def toyTargetEval : ToyTarget -> ToyInstance -> Bool
  | ToyTarget.left, ToyInstance.point => true
  | ToyTarget.right, ToyInstance.point => false

def toyProperEval : ToyProperHyp -> ToyInstance -> Bool
  | ToyProperHyp.trueOnly, ToyInstance.point => true

def toyImproperEval : ToyImproperHyp -> ToyInstance -> Bool
  | ToyImproperHyp.trueHyp, ToyInstance.point => true
  | ToyImproperHyp.falseHyp, ToyInstance.point => false

/--
The representation-level toy problem. The evaluation functions agree on the
`left` target with the proper hypothesis, but the `right` target requires the
larger improper hypothesis family.
-/
def toyRepresentationProblem : BinaryRepresentationProblem where
  Instance := ToyInstance
  Target := ToyTarget
  ProperHyp := ToyProperHyp
  ImproperHyp := ToyImproperHyp
  targetEval := toyTargetEval
  properEval := toyProperEval
  improperEval := toyImproperEval

/-- The toy representation problem has exact improper representations. -/
theorem toy_representation_improper :
    toyRepresentationProblem.HasImproperRepresentations := by
  intro c
  cases c with
  | left =>
      exists ToyImproperHyp.trueHyp
      intro x
      cases x
      rfl
  | right =>
      exists ToyImproperHyp.falseHyp
      intro x
      cases x
      rfl

/-- The toy representation problem lacks exact proper representations. -/
theorem toy_representation_not_proper :
    Not toyRepresentationProblem.HasProperRepresentations := by
  intro h
  rcases h ToyTarget.right with ⟨hProper, hh⟩
  cases hProper
  have hAtPoint := hh ToyInstance.point
  exact Bool.noConfusion hAtPoint

/-- The abstract concept-class universe for the compiled plumbing test. -/
inductive ToyClass where
  | fixedWitness : ToyClass

/-- A minimal computational model with one separating concept class. -/
def toyComputationalModel : ComputationalLearningModel where
  ConceptClass := ToyClass
  efficientRealizableImproper
    | ToyClass.fixedWitness => True
  efficientRealizableProper
    | ToyClass.fixedWitness => False

/-- The separating class is improperly learnable in the toy model. -/
theorem toy_improper :
    toyComputationalModel.efficientRealizableImproper ToyClass.fixedWitness := by
  trivial

/-- The separating class is not properly learnable in the toy model. -/
theorem toy_not_proper :
    Not (toyComputationalModel.efficientRealizableProper ToyClass.fixedWitness) := by
  intro h
  exact h

/-- The toy model has a witness against the universal implication. -/
def toyWitness :
    ComputationalLearningModel.ImproperNotProperWitness toyComputationalModel where
  class_ := ToyClass.fixedWitness
  improper := toy_improper
  not_proper := toy_not_proper

/--
In the toy computational model, efficient realizable improper learning does not
imply efficient realizable proper learning.
-/
theorem toy_improper_does_not_imply_proper :
    Not (ComputationalLearningModel.ImproperImpliesProper toyComputationalModel) := by
  exact ComputationalLearningModel.witness_refutes_improper_implies_proper toyWitness

end Counterexamples
end Learning
end LearningTheory
