import LearningTheory.Complexity.Classes
import LearningTheory.Learning.Exact
import LearningTheory.Learning.Samples

namespace LearningTheory
namespace Learning

namespace BinaryRepresentationProblem

/-- A proper hypothesis is consistent with a finite labeled sample. -/
def ProperConsistentWithSample
    (P : BinaryRepresentationProblem)
    (h : P.ProperHyp) (s : Sample P.Instance) : Prop :=
  Sample.Consistent (fun x => P.properEval h x) s

/-- An improper hypothesis is consistent with a finite labeled sample. -/
def ImproperConsistentWithSample
    (P : BinaryRepresentationProblem)
    (h : P.ImproperHyp) (s : Sample P.Instance) : Prop :=
  Sample.Consistent (fun x => P.improperEval h x) s

/-- The proper consistency/search decision problem for finite samples. -/
def properConsistencyDecisionProblem
    (P : BinaryRepresentationProblem) : Complexity.DecisionProblem where
  Input := Sample P.Instance
  accepts := fun s =>
    Exists fun h : P.ProperHyp => P.ProperConsistentWithSample h s

/-- The improper consistency/search decision problem for finite samples. -/
def improperConsistencyDecisionProblem
    (P : BinaryRepresentationProblem) : Complexity.DecisionProblem where
  Input := Sample P.Instance
  accepts := fun s =>
    Exists fun h : P.ImproperHyp => P.ImproperConsistentWithSample h s

/--
If a proper hypothesis has an equivalent improper embedding, then proper sample
consistency implies improper sample consistency.
-/
theorem improperConsistent_of_properConsistent
    {P : BinaryRepresentationProblem}
    (embed : P.ProperHyp -> P.ImproperHyp)
    (hEmbed :
      forall (h : P.ProperHyp) (x : P.Instance),
        P.improperEval (embed h) x = P.properEval h x)
    {h : P.ProperHyp} {s : Sample P.Instance}
    (hConsistent : P.ProperConsistentWithSample h s) :
    P.ImproperConsistentWithSample (embed h) s := by
  unfold ProperConsistentWithSample at hConsistent
  unfold ImproperConsistentWithSample
  exact Sample.consistent_of_pointwise_eq
    (fun x => Eq.symm (hEmbed h x))
    hConsistent

/--
An embedding of proper hypotheses into improper hypotheses gives a many-one
identity reduction from proper consistency to improper consistency.
-/
def properConsistencyReducesToImproperConsistency
    {P : BinaryRepresentationProblem}
    (embed : P.ProperHyp -> P.ImproperHyp)
    (hEmbed :
      forall (h : P.ProperHyp) (x : P.Instance),
        P.improperEval (embed h) x = P.properEval h x)
    (hBack :
      forall (g : P.ImproperHyp), Exists fun h : P.ProperHyp =>
        forall x : P.Instance, P.properEval h x = P.improperEval g x) :
    Complexity.ManyOneReduction
      (P.properConsistencyDecisionProblem)
      (P.improperConsistencyDecisionProblem) where
  map := fun s => s
  sound := by
    intro s hAccept
    rcases hAccept with ⟨h, hConsistent⟩
    exists embed h
    exact improperConsistent_of_properConsistent embed hEmbed hConsistent
  complete := by
    intro s hAccept
    rcases hAccept with ⟨g, hConsistent⟩
    rcases hBack g with ⟨h, hPointwise⟩
    exists h
    unfold ProperConsistentWithSample
    unfold ImproperConsistentWithSample at hConsistent
    exact Sample.consistent_of_pointwise_eq
      (fun x => Eq.symm (hPointwise x))
      hConsistent

end BinaryRepresentationProblem

end Learning
end LearningTheory
