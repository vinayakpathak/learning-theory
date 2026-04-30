namespace LearningTheory
namespace Boolean

/-- A Boolean assignment to `n` variables. -/
abbrev Assignment (n : Nat) :=
  Fin n -> Bool

namespace Assignment

/-- The all-false assignment. -/
def allFalse (n : Nat) : Assignment n :=
  fun _ => false

/-- The all-true assignment. -/
def allTrue (n : Nat) : Assignment n :=
  fun _ => true

@[simp]
theorem allFalse_apply {n : Nat} (i : Fin n) :
    allFalse n i = false := by
  rfl

@[simp]
theorem allTrue_apply {n : Nat} (i : Fin n) :
    allTrue n i = true := by
  rfl

/-- Override one coordinate of an assignment. -/
def set {n : Nat} (σ : Assignment n) (i : Fin n) (b : Bool) : Assignment n :=
  fun j => if j = i then b else σ j

@[simp]
theorem set_self {n : Nat} (σ : Assignment n) (i : Fin n) (b : Bool) :
    set σ i b i = b := by
  unfold set
  simp

theorem set_of_ne {n : Nat} (σ : Assignment n) {i j : Fin n} (b : Bool)
    (h : j ≠ i) :
    set σ i b j = σ j := by
  unfold set
  simp [h]

theorem set_idempotent {n : Nat} (σ : Assignment n) (i : Fin n) (b : Bool) :
    set (set σ i b) i b = set σ i b := by
  funext j
  by_cases h : j = i
  · subst h
    simp
  · rw [set_of_ne _ b h, set_of_ne _ b h]

end Assignment

end Boolean
end LearningTheory
