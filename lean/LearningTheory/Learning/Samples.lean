namespace LearningTheory
namespace Learning

/-- A labeled binary example. -/
structure Example (Instance : Type) where
  x : Instance
  y : Bool

/-- A finite labeled sample. -/
abbrev Sample (Instance : Type) :=
  List (Example Instance)

namespace Sample

/-- A Boolean-valued hypothesis is consistent with one labeled example. -/
def consistentExample {Instance : Type}
    (eval : Instance -> Bool) (e : Example Instance) : Prop :=
  eval e.x = e.y

/-- A Boolean-valued hypothesis is consistent with every example in a sample. -/
def Consistent {Instance : Type}
    (eval : Instance -> Bool) : Sample Instance -> Prop
  | [] => True
  | e :: es => consistentExample eval e /\ Consistent eval es

/-- Boolean version of sample consistency. -/
def consistencyCheck {Instance : Type}
    (eval : Instance -> Bool) : Sample Instance -> Bool
  | [] => true
  | e :: es => (eval e.x == e.y) && consistencyCheck eval es

@[simp]
theorem consistent_nil {Instance : Type}
    (eval : Instance -> Bool) :
    Consistent eval ([] : Sample Instance) := by
  trivial

@[simp]
theorem consistent_cons {Instance : Type}
    (eval : Instance -> Bool) (e : Example Instance)
    (es : Sample Instance) :
    Consistent eval (e :: es)
      = (consistentExample eval e /\ Consistent eval es) := by
  rfl

@[simp]
theorem consistencyCheck_nil {Instance : Type}
    (eval : Instance -> Bool) :
    consistencyCheck eval ([] : Sample Instance) = true := by
  rfl

@[simp]
theorem consistencyCheck_cons {Instance : Type}
    (eval : Instance -> Bool) (e : Example Instance)
    (es : Sample Instance) :
    consistencyCheck eval (e :: es)
      = ((eval e.x == e.y) && consistencyCheck eval es) := by
  rfl

/-- Boolean consistency checking is equivalent to Prop-level consistency. -/
theorem consistencyCheck_eq_true_iff {Instance : Type}
    (eval : Instance -> Bool) (s : Sample Instance) :
    consistencyCheck eval s = true <-> Consistent eval s := by
  induction s with
  | nil =>
      simp [Consistent, consistencyCheck]
  | cons e es ih =>
      constructor
      · intro h
        simp [consistencyCheck] at h
        exact ⟨h.left, ih.mp h.right⟩
      · intro h
        rcases h with ⟨hHead, hTail⟩
        unfold consistentExample at hHead
        simp [consistencyCheck, hHead, ih.mpr hTail]

/-- Consistency over appended samples is conjunction of consistency. -/
theorem consistent_append_iff {Instance : Type}
    (eval : Instance -> Bool)
    (s t : Sample Instance) :
    Consistent eval (s ++ t) <-> (Consistent eval s /\ Consistent eval t) := by
  induction s with
  | nil =>
      constructor
      · intro h
        exact And.intro trivial h
      · intro h
        exact h.right
  | cons e es ih =>
      constructor
      · intro h
        cases h with
        | intro hHead hTail =>
            have hSplit := (ih.mp hTail)
            exact And.intro
              (And.intro hHead hSplit.left)
              hSplit.right
      · intro h
        cases h with
        | intro hLeft hRight =>
            cases hLeft with
            | intro hHead hTail =>
                exact And.intro hHead (ih.mpr (And.intro hTail hRight))

/-- If an evaluator is pointwise equal to another, consistency transfers. -/
theorem consistent_of_pointwise_eq {Instance : Type}
    {eval₁ eval₂ : Instance -> Bool}
    (hEq : forall x : Instance, eval₁ x = eval₂ x)
    {s : Sample Instance}
    (hConsistent : Consistent eval₁ s) :
    Consistent eval₂ s := by
  induction s with
  | nil =>
      trivial
  | cons e es ih =>
      cases hConsistent with
      | intro hHead hTail =>
          constructor
          · unfold consistentExample at hHead ⊢
            rw [← hEq e.x]
            exact hHead
          · exact ih hTail

/-- Pointwise equivalent evaluators have equivalent consistency predicates. -/
theorem consistent_iff_of_pointwise_eq {Instance : Type}
    {eval₁ eval₂ : Instance -> Bool}
    (hEq : forall x : Instance, eval₁ x = eval₂ x)
    (s : Sample Instance) :
    Consistent eval₁ s <-> Consistent eval₂ s := by
  constructor
  · exact consistent_of_pointwise_eq hEq
  · exact consistent_of_pointwise_eq (fun x => Eq.symm (hEq x))

end Sample

end Learning
end LearningTheory
