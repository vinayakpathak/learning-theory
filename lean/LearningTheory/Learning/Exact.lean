namespace LearningTheory
namespace Learning

/--
A representation-level binary classification problem.

This is weaker than computational PAC learning. It is useful for checking the
shape of proper/improper statements before adding samples, probability, and
runtime.
-/
structure BinaryRepresentationProblem where
  Instance : Type
  Target : Type
  ProperHyp : Type
  ImproperHyp : Type
  targetEval : Target -> Instance -> Bool
  properEval : ProperHyp -> Instance -> Bool
  improperEval : ImproperHyp -> Instance -> Bool

namespace BinaryRepresentationProblem

/-- A proper hypothesis represents a target exactly. -/
def ProperRepresents (P : BinaryRepresentationProblem)
    (h : P.ProperHyp) (c : P.Target) : Prop :=
  forall x : P.Instance, P.properEval h x = P.targetEval c x

/-- An improper hypothesis represents a target exactly. -/
def ImproperRepresents (P : BinaryRepresentationProblem)
    (h : P.ImproperHyp) (c : P.Target) : Prop :=
  forall x : P.Instance, P.improperEval h x = P.targetEval c x

/-- Every target has an exact proper representation. -/
def HasProperRepresentations (P : BinaryRepresentationProblem) : Prop :=
  forall c : P.Target, Exists fun h : P.ProperHyp => P.ProperRepresents h c

/-- Every target has an exact improper representation. -/
def HasImproperRepresentations (P : BinaryRepresentationProblem) : Prop :=
  forall c : P.Target, Exists fun h : P.ImproperHyp => P.ImproperRepresents h c

/-- One unrepresented target refutes exact proper representability. -/
theorem not_hasProperRepresentations_of_target
    {P : BinaryRepresentationProblem} {c : P.Target}
    (hMissing : forall h : P.ProperHyp, Not (P.ProperRepresents h c)) :
    Not P.HasProperRepresentations := by
  intro hAll
  rcases hAll c with ⟨h, hh⟩
  exact hMissing h hh

/--
If proper hypotheses are included among improper hypotheses, exact proper
representability implies exact improper representability.
-/
theorem hasImproperRepresentations_of_hasProperRepresentations
    {P : BinaryRepresentationProblem}
    (embed : P.ProperHyp -> P.ImproperHyp)
    (hEmbed :
      forall (h : P.ProperHyp) (x : P.Instance),
        P.improperEval (embed h) x = P.properEval h x)
    (hProper : P.HasProperRepresentations) :
    P.HasImproperRepresentations := by
  intro c
  rcases hProper c with ⟨h, hh⟩
  exists embed h
  intro x
  rw [hEmbed h x, hh x]

end BinaryRepresentationProblem

end Learning
end LearningTheory
