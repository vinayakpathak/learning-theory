import LearningTheory.Boolean.DNFToCNF
import LearningTheory.Boolean.Size

namespace LearningTheory
namespace Boolean

namespace CNF

/-- Disjoining one clause with every clause does not change the clause count. -/
theorem clauseCount_disjoinClause {Var : Type}
    (c : Clause Var) (ψ : CNF Var) :
    clauseCount (disjoinClause c ψ) = clauseCount ψ := by
  induction ψ with
  | nil =>
      rfl
  | cons d ds ih =>
      simpa [disjoinClause, clauseCount] using ih

/-- Distributed CNF disjunction multiplies clause counts. -/
theorem clauseCount_disjoin {Var : Type}
    (φ ψ : CNF Var) :
    clauseCount (disjoin φ ψ) = clauseCount φ * clauseCount ψ := by
  induction φ with
  | nil =>
      simp [disjoin, clauseCount]
  | cons c cs ih =>
      have hClause := clauseCount_disjoinClause c ψ
      have hClauseLen :
          (disjoinClause c ψ).length = ψ.length := by
        simpa [clauseCount] using hClause
      have ihLen :
          (disjoin cs ψ).length = cs.length * ψ.length := by
        simpa [clauseCount] using ih
      simp [disjoin, clauseCount, List.length_append, hClauseLen, ihLen]
      rw [Nat.add_one_mul, Nat.add_comm]

/-- Width-bounded CNFs have total literal count bounded by clause count times width. -/
theorem literalCount_le_clauseCount_mul_of_widthBounded {Var : Type}
    {φ : CNF Var} {k : Nat}
    (hWidth : widthBounded k φ) :
    literalCount φ <= clauseCount φ * k := by
  induction φ with
  | nil =>
      simp [literalCount, clauseCount]
  | cons c cs ih =>
      have hHead : c.length <= k := hWidth c (List.Mem.head cs)
      have hTailWidth : widthBounded k cs := by
        intro d hd
        exact hWidth d (List.Mem.tail c hd)
      have hTail := ih hTailWidth
      calc
        literalCount (c :: cs)
            = c.length + literalCount cs := rfl
        _ <= k + clauseCount cs * k := Nat.add_le_add hHead hTail
        _ = clauseCount (c :: cs) * k := by
          simp [clauseCount]
          rw [Nat.add_one_mul, Nat.add_comm]

end CNF

namespace Term

/-- Viewing a term as a CNF creates one clause per literal. -/
theorem clauseCount_toCNF {Var : Type} (t : Term Var) :
    CNF.clauseCount (toCNF t) = width t := by
  induction t with
  | nil =>
      rfl
  | cons l ls ih =>
      simpa [toCNF, CNF.clauseCount, width] using ih

end Term

namespace DNF

/-- Clause-count recurrence for the distributed DNF-to-CNF conversion. -/
theorem clauseCount_toCNF_cons {Var : Type}
    (t : Term Var) (ts : DNF Var) :
    CNF.clauseCount (toCNF (t :: ts))
      = Term.width t * CNF.clauseCount (toCNF ts) := by
  change
    CNF.clauseCount
        (CNF.disjoin (Term.toCNF t) (toCNF ts))
      = Term.width t * CNF.clauseCount (toCNF ts)
  rw [CNF.clauseCount_disjoin, Term.clauseCount_toCNF]

/--
For a DNF with `k` terms, the distributed CNF has at most
`(literalCount φ + 1)^k` clauses.

This is the formal polynomial-size statement for the fixed-`k` case.
-/
theorem clauseCount_toCNF_le_polynomial {Var : Type}
    (φ : DNF Var) :
    CNF.clauseCount (toCNF φ) <=
      (literalCount φ + 1) ^ φ.length := by
  induction φ with
  | nil =>
      simp [toCNF, falseCNF, CNF.clauseCount, literalCount]
  | cons t ts ih =>
      rw [clauseCount_toCNF_cons]
      have hTerm :
          Term.width t <= Term.width t + literalCount ts + 1 := by
        omega
      have hTail :
          literalCount ts + 1 <= Term.width t + literalCount ts + 1 := by
        omega
      have hPow :
          (literalCount ts + 1) ^ ts.length
            <= (Term.width t + literalCount ts + 1) ^ ts.length :=
        Nat.pow_le_pow_left hTail ts.length
      have hMul :
          Term.width t * CNF.clauseCount (toCNF ts)
            <= (Term.width t + literalCount ts + 1)
              * (Term.width t + literalCount ts + 1) ^ ts.length :=
        Nat.mul_le_mul hTerm (Nat.le_trans ih hPow)
      have hPowSucc :
          (Term.width t + literalCount ts + 1)
              * (Term.width t + literalCount ts + 1) ^ ts.length
            =
          (Term.width t + literalCount ts + 1) ^ (ts.length + 1) := by
        rw [Nat.pow_succ']
      simpa [literalCount, Nat.succ_eq_add_one, hPowSucc]
        using hMul

/--
Specialized bound for a fixed-`k` term DNF, expressed in the form used by the
learning-theory representation.
-/
theorem clauseCount_toCNF_le_of_length_le {Var : Type}
    {φ : DNF Var} {k : Nat}
    (hLength : φ.length <= k) :
    CNF.clauseCount (toCNF φ) <= (literalCount φ + 1) ^ k := by
  exact Nat.le_trans (clauseCount_toCNF_le_polynomial φ)
    (Nat.pow_le_pow_right (by omega : literalCount φ + 1 > 0) hLength)

/--
For a DNF with at most `k` terms, the generated CNF has total literal count at
most `k * (literalCount φ + 1)^k`.
-/
theorem literalCount_toCNF_le_of_length_le {Var : Type}
    {φ : DNF Var} {k : Nat}
    (hLength : φ.length <= k) :
    CNF.literalCount (toCNF φ)
      <= (literalCount φ + 1) ^ k * k := by
  have hWidth : CNF.widthBounded k (toCNF φ) :=
    toCNF_widthBounded_of_length_le hLength
  have hLit :
      CNF.literalCount (toCNF φ)
        <= CNF.clauseCount (toCNF φ) * k :=
    CNF.literalCount_le_clauseCount_mul_of_widthBounded hWidth
  have hClauses :
      CNF.clauseCount (toCNF φ) <= (literalCount φ + 1) ^ k :=
    clauseCount_toCNF_le_of_length_le hLength
  exact Nat.le_trans hLit (Nat.mul_le_mul_right k hClauses)

end DNF

end Boolean
end LearningTheory
