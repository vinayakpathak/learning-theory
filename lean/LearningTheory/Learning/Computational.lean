namespace LearningTheory
namespace Learning

/--
An abstract computational learning model over concept classes.

The predicates are intentionally parameters. Later files can instantiate them
with concrete notions of randomized polynomial-time PAC learning.
-/
structure ComputationalLearningModel where
  ConceptClass : Type
  efficientRealizableImproper : ConceptClass -> Prop
  efficientRealizableProper : ConceptClass -> Prop

namespace ComputationalLearningModel

/--
The universal implication from efficient realizable improper learning to
efficient realizable proper learning, inside a fixed model.
-/
def ImproperImpliesProper (M : ComputationalLearningModel) : Prop :=
  forall C : M.ConceptClass,
    M.efficientRealizableImproper C -> M.efficientRealizableProper C

/-- A concept class witnessing failure of the implication. -/
structure ImproperNotProperWitness (M : ComputationalLearningModel) where
  class_ : M.ConceptClass
  improper : M.efficientRealizableImproper class_
  not_proper : Not (M.efficientRealizableProper class_)

/-- Any witness refutes the universal implication. -/
theorem witness_refutes_improper_implies_proper
    {M : ComputationalLearningModel}
    (W : ImproperNotProperWitness M) :
    Not (ImproperImpliesProper M) := by
  intro h
  exact W.not_proper (h W.class_ W.improper)

end ComputationalLearningModel

end Learning
end LearningTheory
