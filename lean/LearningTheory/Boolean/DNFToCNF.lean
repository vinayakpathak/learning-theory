import LearningTheory.Boolean.Formulas

namespace LearningTheory
namespace Boolean

namespace Clause

/-- Evaluation of clauses respects list append as Boolean disjunction. -/
theorem eval_append {Var : Type} (c d : Clause Var) (σ : Var -> Bool) :
    eval (c ++ d) σ = (eval c σ || eval d σ) := by
  induction c with
  | nil =>
      rfl
  | cons l ls ih =>
      simp [eval, ih]
      cases Literal.eval σ l <;> cases eval ls σ <;> cases eval d σ <;> rfl

end Clause

namespace CNF

/--
A structurally recursive version of `CNF.widthBounded`.

This is convenient for proofs about recursively generated CNFs. The theorem
`widthBounded_of_structurallyWidthBounded` below connects it back to the
membership-based definition in `Formulas.lean`.
-/
def structurallyWidthBounded {Var : Type} (k : Nat) : CNF Var -> Prop
  | [] => True
  | c :: cs => c.length <= k /\ structurallyWidthBounded k cs

/-- Structural width bounds imply the membership-based width bound. -/
theorem widthBounded_of_structurallyWidthBounded {Var : Type}
    {k : Nat} {φ : CNF Var}
    (h : structurallyWidthBounded k φ) :
    widthBounded k φ := by
  intro c hc
  induction φ with
  | nil =>
      cases hc
  | cons d ds ih =>
      cases h with
      | intro hd hds =>
          cases hc with
          | head =>
              exact hd
          | tail _ hTail =>
              exact ih hds hTail

/-- Width bounds can be weakened. -/
theorem widthBounded_mono {Var : Type}
    {m n : Nat} {φ : CNF Var}
    (hφ : widthBounded m φ) (hmn : m <= n) :
    widthBounded n φ := by
  intro c hc
  exact Nat.le_trans (hφ c hc) hmn

/-- Structural width bounds are preserved by appending CNFs. -/
theorem structurallyWidthBounded_append {Var : Type}
    {k : Nat} {φ ψ : CNF Var}
    (hφ : structurallyWidthBounded k φ)
    (hψ : structurallyWidthBounded k ψ) :
    structurallyWidthBounded k (φ ++ ψ) := by
  induction φ with
  | nil =>
      exact hψ
  | cons c cs ih =>
      cases hφ with
      | intro hc hcs =>
          exact And.intro hc (ih hcs)

/-- Evaluation of CNFs respects list append as Boolean conjunction. -/
theorem eval_append {Var : Type} (φ ψ : CNF Var) (σ : Var -> Bool) :
    eval (φ ++ ψ) σ = (eval φ σ && eval ψ σ) := by
  induction φ with
  | nil =>
      rfl
  | cons c cs ih =>
      simp [eval, ih]
      cases Clause.eval c σ <;> cases eval cs σ <;> cases eval ψ σ <;> rfl

/--
Disjoin one clause with every clause in a CNF.

Semantically this is the CNF for `c OR ψ`, where `c` is treated as a one-clause
CNF and `ψ` is already in CNF.
-/
def disjoinClause {Var : Type} (c : Clause Var) (ψ : CNF Var) : CNF Var :=
  match ψ with
  | [] => []
  | d :: ds => (c ++ d) :: disjoinClause c ds

/-- Correctness of `disjoinClause`. -/
theorem eval_disjoinClause {Var : Type}
    (c : Clause Var) (ψ : CNF Var) (σ : Var -> Bool) :
    eval (disjoinClause c ψ) σ = (Clause.eval c σ || eval ψ σ) := by
  induction ψ with
  | nil =>
      simp [disjoinClause, eval]
  | cons d ds ih =>
      change
        ((Clause.eval (c ++ d) σ) && eval (disjoinClause c ds) σ)
          = (Clause.eval c σ || (Clause.eval d σ && eval ds σ))
      rw [Clause.eval_append, ih]
      cases Clause.eval c σ <;> cases Clause.eval d σ <;> cases eval ds σ <;> rfl

/--
If every clause in `ψ` has width at most `k`, then disjoining a singleton
clause with `ψ` produces clauses of width at most `k + 1`.
-/
theorem structurallyWidthBounded_disjoinClause_singleton {Var : Type}
    (l : Literal Var) {ψ : CNF Var} {k : Nat}
    (hψ : structurallyWidthBounded k ψ) :
    structurallyWidthBounded (Nat.succ k) (disjoinClause [l] ψ) := by
  induction ψ with
  | nil =>
      trivial
  | cons d ds ih =>
      cases hψ with
      | intro hd hds =>
          constructor
          · simpa using Nat.succ_le_succ hd
          · exact ih hds

/--
Disjoin two CNFs.

If `φ` represents `A` and `ψ` represents `B`, then `disjoin φ ψ` represents
`A OR B`, using the usual distributive product of clauses.
-/
def disjoin {Var : Type} (φ ψ : CNF Var) : CNF Var :=
  match φ with
  | [] => []
  | c :: cs => disjoinClause c ψ ++ disjoin cs ψ

/-- Correctness of CNF disjunction. -/
theorem eval_disjoin {Var : Type}
    (φ ψ : CNF Var) (σ : Var -> Bool) :
    eval (disjoin φ ψ) σ = (eval φ σ || eval ψ σ) := by
  induction φ with
  | nil =>
      simp [disjoin, eval]
  | cons c cs ih =>
      change
        eval (disjoinClause c ψ ++ disjoin cs ψ) σ
          = ((Clause.eval c σ && eval cs σ) || eval ψ σ)
      rw [eval_append, eval_disjoinClause, ih]
      cases Clause.eval c σ <;> cases eval cs σ <;> cases eval ψ σ <;> rfl

end CNF

namespace Term

/--
View a term as a CNF: each literal becomes a singleton clause.

The conjunction of singleton clauses is equivalent to the original conjunction
of literals.
-/
def toCNF {Var : Type} (t : Term Var) : CNF Var :=
  match t with
  | [] => []
  | l :: ls => [l] :: toCNF ls

/-- Correctness of `Term.toCNF`. -/
theorem eval_toCNF {Var : Type} (t : Term Var) (σ : Var -> Bool) :
    CNF.eval (toCNF t) σ = eval t σ := by
  induction t with
  | nil =>
      rfl
  | cons l ls ih =>
      change
        ((Literal.eval σ l || false) && CNF.eval (toCNF ls) σ)
          = (Literal.eval σ l && eval ls σ)
      rw [ih]
      cases Literal.eval σ l <;> rfl

end Term

namespace CNF

/--
Disjoining a term, viewed as a CNF of singleton clauses, with a width-`k` CNF
produces a width-`k+1` CNF.
-/
theorem structurallyWidthBounded_disjoin_termToCNF {Var : Type}
    (t : Term Var) {ψ : CNF Var} {k : Nat}
    (hψ : structurallyWidthBounded k ψ) :
    structurallyWidthBounded (Nat.succ k) (disjoin (Term.toCNF t) ψ) := by
  induction t with
  | nil =>
      trivial
  | cons l ls ih =>
      change
        structurallyWidthBounded (Nat.succ k)
          (disjoinClause [l] ψ ++ disjoin (Term.toCNF ls) ψ)
      exact structurallyWidthBounded_append
        (structurallyWidthBounded_disjoinClause_singleton l hψ)
        ih

end CNF

namespace DNF

/-- A CNF representation of Boolean false: one empty clause. -/
def falseCNF {Var : Type} : CNF Var :=
  [[]]

@[simp]
theorem eval_falseCNF {Var : Type} (σ : Var -> Bool) :
    CNF.eval (falseCNF : CNF Var) σ = false := by
  rfl

/--
Convert a DNF formula to an equivalent CNF formula by repeated distribution.

This conversion can be exponentially large in general, but for a fixed number
of terms it is polynomial in the term lengths. The size bound is formalized
separately from the semantic theorem.
-/
def toCNF {Var : Type} : DNF Var -> CNF Var
  | [] => falseCNF
  | t :: ts => CNF.disjoin (Term.toCNF t) (toCNF ts)

/-- Semantic correctness of DNF-to-CNF conversion. -/
theorem eval_toCNF {Var : Type} (φ : DNF Var) (σ : Var -> Bool) :
    CNF.eval (toCNF φ) σ = eval φ σ := by
  induction φ with
  | nil =>
      rfl
  | cons t ts ih =>
      change
        CNF.eval (CNF.disjoin (Term.toCNF t) (toCNF ts)) σ
          = (Term.eval t σ || eval ts σ)
      rw [CNF.eval_disjoin, Term.eval_toCNF, ih]

/-- The generated CNF has clause width bounded by the number of DNF terms. -/
theorem toCNF_structurallyWidthBounded {Var : Type} (φ : DNF Var) :
    CNF.structurallyWidthBounded φ.length (toCNF φ) := by
  induction φ with
  | nil =>
      exact And.intro (Nat.le_refl 0) trivial
  | cons t ts ih =>
      change
        CNF.structurallyWidthBounded (Nat.succ ts.length)
          (CNF.disjoin (Term.toCNF t) (toCNF ts))
      exact CNF.structurallyWidthBounded_disjoin_termToCNF t ih

/--
Membership-form width bound for the DNF-to-CNF conversion.

In particular, a DNF with at most `k` terms converts to a CNF whose clauses
have width at most `k`, after weakening the bound from `φ.length` to `k`.
-/
theorem toCNF_widthBounded_by_length {Var : Type} (φ : DNF Var) :
    CNF.widthBounded φ.length (toCNF φ) := by
  exact CNF.widthBounded_of_structurallyWidthBounded
    (toCNF_structurallyWidthBounded φ)

/--
If a DNF has at most `k` terms, its distributed CNF has clause width at most
`k`.
-/
theorem toCNF_widthBounded_of_length_le {Var : Type}
    {φ : DNF Var} {k : Nat}
    (hLength : φ.length <= k) :
    CNF.widthBounded k (toCNF φ) := by
  exact CNF.widthBounded_mono (toCNF_widthBounded_by_length φ) hLength

end DNF

end Boolean
end LearningTheory
