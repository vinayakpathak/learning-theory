import LearningTheory.Complexity.Classes

namespace LearningTheory
namespace Complexity

/-- A Set Cover instance. -/
structure SetCoverInstance where
  Element : Type
  SetId : Type
  covers : SetId -> Element -> Prop
  budget : Nat

namespace SetCoverInstance

/-- A list of sets covers every element. -/
def CoversAll (I : SetCoverInstance) (chosen : List I.SetId) : Prop :=
  forall e : I.Element, Exists fun s : I.SetId => s ∈ chosen /\ I.covers s e

/-- A chosen list is a valid cover within the budget. -/
def HasCover (I : SetCoverInstance) : Prop :=
  Exists fun chosen : List I.SetId =>
    chosen.length <= I.budget /\ I.CoversAll chosen

end SetCoverInstance

/-- The Set Cover decision problem. -/
def setCoverDecisionProblem : DecisionProblem where
  Input := SetCoverInstance
  accepts := fun I => I.HasCover

/-- A direct constructor for accepted Set Cover instances. -/
theorem setCover_accepts_of_cover
    (I : SetCoverInstance) (chosen : List I.SetId)
    (hBudget : chosen.length <= I.budget)
    (hCovers : I.CoversAll chosen) :
    setCoverDecisionProblem.accepts I := by
  exact Exists.intro chosen (And.intro hBudget hCovers)

/-- Accepted Set Cover instances expose a cover witness. -/
theorem exists_cover_of_setCover_accepts
    (I : SetCoverInstance)
    (hAccepts : setCoverDecisionProblem.accepts I) :
    Exists fun chosen : List I.SetId =>
      chosen.length <= I.budget /\ I.CoversAll chosen := by
  exact hAccepts

end Complexity
end LearningTheory
