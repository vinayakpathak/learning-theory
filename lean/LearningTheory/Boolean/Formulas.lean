namespace LearningTheory
namespace Boolean

/-- A Boolean literal over a variable type. -/
inductive Literal (Var : Type) where
  | pos : Var -> Literal Var
  | neg : Var -> Literal Var
deriving DecidableEq

namespace Literal

/-- Evaluate a literal under a Boolean assignment. -/
def eval {Var : Type} (σ : Var -> Bool) : Literal Var -> Bool
  | pos v => σ v
  | neg v => not (σ v)

@[simp]
theorem eval_pos {Var : Type} (σ : Var -> Bool) (v : Var) :
    eval σ (pos v) = σ v := by
  rfl

@[simp]
theorem eval_neg {Var : Type} (σ : Var -> Bool) (v : Var) :
    eval σ (neg v) = not (σ v) := by
  rfl

/-- Negate a literal syntactically. -/
def complement {Var : Type} : Literal Var -> Literal Var
  | pos v => neg v
  | neg v => pos v

@[simp]
theorem complement_complement {Var : Type} (l : Literal Var) :
    complement (complement l) = l := by
  cases l <;> rfl

end Literal

/-- A term is a conjunction of literals. -/
abbrev Term (Var : Type) := List (Literal Var)

namespace Term

/-- Evaluate a term as the conjunction of its literals. -/
def eval {Var : Type} : Term Var -> (Var -> Bool) -> Bool
  | [], _ => true
  | l :: ls, σ => Literal.eval σ l && eval ls σ

/-- The number of literals in a term. -/
def width {Var : Type} (t : Term Var) : Nat :=
  t.length

@[simp]
theorem eval_nil {Var : Type} (σ : Var -> Bool) :
    eval ([] : Term Var) σ = true := by
  rfl

@[simp]
theorem eval_cons {Var : Type} (l : Literal Var) (ls : Term Var)
    (σ : Var -> Bool) :
    eval (l :: ls) σ = (Literal.eval σ l && eval ls σ) := by
  rfl

@[simp]
theorem width_nil {Var : Type} :
    width ([] : Term Var) = 0 := by
  rfl

@[simp]
theorem width_cons {Var : Type} (l : Literal Var) (ls : Term Var) :
    width (l :: ls) = Nat.succ (width ls) := by
  rfl

/-- Term evaluation is true exactly when every listed literal evaluates true. -/
theorem eval_eq_true_iff_forall_mem {Var : Type}
    (t : Term Var) (σ : Var -> Bool) :
    eval t σ = true <->
      forall l : Literal Var, l ∈ t -> Literal.eval σ l = true := by
  induction t with
  | nil =>
      simp [eval]
  | cons l ls ih =>
      constructor
      · intro h l' hMem
        simp [eval] at h
        cases hMem with
        | head =>
            exact h.left
        | tail _ hTail =>
            exact ih.mp h.right l' hTail
      · intro h
        simp [eval]
        constructor
        · exact h l (List.Mem.head ls)
        · exact ih.mpr
            (fun l' hTail => h l' (List.Mem.tail l hTail))

end Term

/-- A clause is a disjunction of literals. -/
abbrev Clause (Var : Type) := List (Literal Var)

namespace Clause

/-- Evaluate a clause as the disjunction of its literals. -/
def eval {Var : Type} : Clause Var -> (Var -> Bool) -> Bool
  | [], _ => false
  | l :: ls, σ => Literal.eval σ l || eval ls σ

@[simp]
theorem eval_nil {Var : Type} (σ : Var -> Bool) :
    eval ([] : Clause Var) σ = false := by
  rfl

@[simp]
theorem eval_cons {Var : Type} (l : Literal Var) (ls : Clause Var)
    (σ : Var -> Bool) :
    eval (l :: ls) σ = (Literal.eval σ l || eval ls σ) := by
  rfl

end Clause

/-- A DNF formula is a disjunction of terms. -/
abbrev DNF (Var : Type) := List (Term Var)

namespace DNF

/-- Evaluate a DNF formula as the disjunction of its terms. -/
def eval {Var : Type} : DNF Var -> (Var -> Bool) -> Bool
  | [], _ => false
  | t :: ts, σ => Term.eval t σ || eval ts σ

/-- All terms in a DNF formula have width at most `k`. -/
def widthBounded {Var : Type} (k : Nat) (φ : DNF Var) : Prop :=
  forall t : Term Var, t ∈ φ -> Term.width t <= k

@[simp]
theorem eval_nil {Var : Type} (σ : Var -> Bool) :
    eval ([] : DNF Var) σ = false := by
  rfl

@[simp]
theorem eval_cons {Var : Type} (t : Term Var) (ts : DNF Var)
    (σ : Var -> Bool) :
    eval (t :: ts) σ = (Term.eval t σ || eval ts σ) := by
  rfl

/-- DNF evaluation is true exactly when some listed term evaluates true. -/
theorem eval_eq_true_iff_exists_mem {Var : Type}
    (φ : DNF Var) (σ : Var -> Bool) :
    eval φ σ = true <->
      Exists fun t : Term Var => t ∈ φ /\ Term.eval t σ = true := by
  induction φ with
  | nil =>
      simp [eval]
  | cons t ts ih =>
      constructor
      · intro h
        simp [eval] at h
        cases h with
        | inl hHead =>
            exact ⟨t, List.Mem.head ts, hHead⟩
        | inr hTail =>
            rcases ih.mp hTail with ⟨t', hMem, hEval⟩
            exact ⟨t', List.Mem.tail t hMem, hEval⟩
      · intro h
        rcases h with ⟨t', hMem, hEval⟩
        cases hMem with
        | head =>
            simp [eval, hEval]
        | tail _ hTail =>
            simp [eval, ih.mpr ⟨t', hTail, hEval⟩]

theorem widthBounded_nil {Var : Type} (k : Nat) :
    widthBounded k ([] : DNF Var) := by
  intro t h
  cases h

end DNF

/-- A CNF formula is a conjunction of clauses. -/
abbrev CNF (Var : Type) := List (Clause Var)

namespace CNF

/-- Evaluate a CNF formula as the conjunction of its clauses. -/
def eval {Var : Type} : CNF Var -> (Var -> Bool) -> Bool
  | [], _ => true
  | c :: cs, σ => Clause.eval c σ && eval cs σ

/-- All clauses in a CNF formula have width at most `k`. -/
def widthBounded {Var : Type} (k : Nat) (φ : CNF Var) : Prop :=
  forall c : Clause Var, c ∈ φ -> c.length <= k

@[simp]
theorem eval_nil {Var : Type} (σ : Var -> Bool) :
    eval ([] : CNF Var) σ = true := by
  rfl

@[simp]
theorem eval_cons {Var : Type} (c : Clause Var) (cs : CNF Var)
    (σ : Var -> Bool) :
    eval (c :: cs) σ = (Clause.eval c σ && eval cs σ) := by
  rfl

theorem widthBounded_nil {Var : Type} (k : Nat) :
    widthBounded k ([] : CNF Var) := by
  intro c h
  cases h

end CNF

end Boolean
end LearningTheory
