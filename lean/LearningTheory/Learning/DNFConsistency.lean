import LearningTheory.Complexity.Classes
import LearningTheory.Learning.BooleanClasses
import LearningTheory.Learning.Samples

namespace LearningTheory
namespace Learning
namespace BooleanClasses

/-- A packaged input to proper fixed-`k` term DNF consistency. -/
structure KTermDNFConsistencyInput where
  Var : Type
  decEq : DecidableEq Var
  budget : Nat
  sample : Sample (Var -> Bool)

namespace KTermDNFConsistencyInput

/-- The input is accepted if some fixed-`k` term DNF is consistent with the sample. -/
def Accepts (I : KTermDNFConsistencyInput) : Prop :=
  letI := I.decEq
  Exists fun φ : KTermDNF I.Var I.budget =>
    Sample.Consistent (fun σ => KTermDNF.eval φ σ) I.sample

end KTermDNFConsistencyInput

/-- The universal proper fixed-`k` term DNF consistency decision problem. -/
def properKTermDNFConsistencyDecisionProblem :
    Complexity.DecisionProblem where
  Input := KTermDNFConsistencyInput
  accepts := fun I => I.Accepts

end BooleanClasses
end Learning
end LearningTheory
