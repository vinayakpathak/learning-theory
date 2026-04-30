import LearningTheory.Boolean.Formulas

namespace LearningTheory
namespace Boolean

namespace DNF

/-- Number of terms in a DNF formula. -/
def termCount {Var : Type} (φ : DNF Var) : Nat :=
  φ.length

/-- Total number of literal occurrences in a DNF formula. -/
def literalCount {Var : Type} : DNF Var -> Nat
  | [] => 0
  | t :: ts => Term.width t + literalCount ts

@[simp]
theorem termCount_nil {Var : Type} :
    termCount ([] : DNF Var) = 0 := by
  rfl

@[simp]
theorem termCount_cons {Var : Type}
    (t : Term Var) (ts : DNF Var) :
    termCount (t :: ts) = Nat.succ (termCount ts) := by
  rfl

@[simp]
theorem literalCount_nil {Var : Type} :
    literalCount ([] : DNF Var) = 0 := by
  rfl

@[simp]
theorem literalCount_cons {Var : Type}
    (t : Term Var) (ts : DNF Var) :
    literalCount (t :: ts) = Term.width t + literalCount ts := by
  rfl

end DNF

namespace CNF

/-- Number of clauses in a CNF formula. -/
def clauseCount {Var : Type} (φ : CNF Var) : Nat :=
  φ.length

/-- Total number of literal occurrences in a CNF formula. -/
def literalCount {Var : Type} : CNF Var -> Nat
  | [] => 0
  | c :: cs => c.length + literalCount cs

@[simp]
theorem clauseCount_nil {Var : Type} :
    clauseCount ([] : CNF Var) = 0 := by
  rfl

@[simp]
theorem clauseCount_cons {Var : Type}
    (c : Clause Var) (cs : CNF Var) :
    clauseCount (c :: cs) = Nat.succ (clauseCount cs) := by
  rfl

@[simp]
theorem literalCount_nil {Var : Type} :
    literalCount ([] : CNF Var) = 0 := by
  rfl

@[simp]
theorem literalCount_cons {Var : Type}
    (c : Clause Var) (cs : CNF Var) :
    literalCount (c :: cs) = c.length + literalCount cs := by
  rfl

end CNF

end Boolean
end LearningTheory
