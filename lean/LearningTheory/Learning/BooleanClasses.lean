import LearningTheory.Boolean.DNFSizeBound
import LearningTheory.Learning.Exact

namespace LearningTheory
namespace Learning
namespace BooleanClasses

open LearningTheory.Boolean

/--
A DNF formula together with a proof that it has at most `k` terms.

This models the fixed-`k` term DNF target class at the representation level.
-/
structure KTermDNF (Var : Type) (k : Nat) where
  formula : DNF Var
  length_le : formula.length <= k

/--
A CNF formula together with a proof that each clause has width at most `k`.

This models the `k`-CNF improper hypothesis class used to represent fixed-`k`
term DNF targets.
-/
structure KCNF (Var : Type) (k : Nat) where
  formula : CNF Var
  width_bounded : CNF.widthBounded k formula

namespace KTermDNF

/-- Evaluate a fixed-`k` term DNF. -/
def eval {Var : Type} {k : Nat} (φ : KTermDNF Var k) (σ : Var -> Bool) : Bool :=
  DNF.eval φ.formula σ

end KTermDNF

namespace KCNF

/-- Evaluate a `k`-CNF. -/
def eval {Var : Type} {k : Nat} (φ : KCNF Var k) (σ : Var -> Bool) : Bool :=
  CNF.eval φ.formula σ

end KCNF

/-- Convert a fixed-`k` term DNF to an equivalent `k`-CNF. -/
def KTermDNF.toKCNF {Var : Type} {k : Nat}
    (φ : KTermDNF Var k) : KCNF Var k where
  formula := DNF.toCNF φ.formula
  width_bounded := DNF.toCNF_widthBounded_of_length_le φ.length_le

/-- Semantic correctness of the fixed-`k` DNF to `k`-CNF conversion. -/
theorem KTermDNF.eval_toKCNF {Var : Type} {k : Nat}
    (φ : KTermDNF Var k) (σ : Var -> Bool) :
    KCNF.eval (KTermDNF.toKCNF φ) σ = KTermDNF.eval φ σ := by
  exact DNF.eval_toCNF φ.formula σ

/--
For fixed `k`, the generated improper `k`-CNF has polynomially many clauses
in the number of literal occurrences of the target DNF.
-/
theorem KTermDNF.toKCNF_clauseCount_le {Var : Type} {k : Nat}
    (φ : KTermDNF Var k) :
    CNF.clauseCount (KTermDNF.toKCNF φ).formula
      <= (DNF.literalCount φ.formula + 1) ^ k := by
  exact DNF.clauseCount_toCNF_le_of_length_le φ.length_le

/--
The generated improper `k`-CNF has polynomially bounded total literal count
for fixed `k`.
-/
theorem KTermDNF.toKCNF_literalCount_le {Var : Type} {k : Nat}
    (φ : KTermDNF Var k) :
    CNF.literalCount (KTermDNF.toKCNF φ).formula
      <= (DNF.literalCount φ.formula + 1) ^ k * k := by
  exact DNF.literalCount_toCNF_le_of_length_le φ.length_le

/--
The representation problem whose targets and proper hypotheses are fixed-`k`
term DNFs and whose improper hypotheses are `k`-CNFs.
-/
def fixedKDNFImproperProblem (Var : Type) (k : Nat) :
    BinaryRepresentationProblem where
  Instance := Var -> Bool
  Target := KTermDNF Var k
  ProperHyp := KTermDNF Var k
  ImproperHyp := KCNF Var k
  targetEval := fun φ σ => KTermDNF.eval φ σ
  properEval := fun φ σ => KTermDNF.eval φ σ
  improperEval := fun ψ σ => KCNF.eval ψ σ

/-- Proper representation is trivial in the fixed-`k` DNF representation problem. -/
theorem fixedKDNF_hasProperRepresentations
    (Var : Type) (k : Nat) :
    (fixedKDNFImproperProblem Var k).HasProperRepresentations := by
  intro φ
  exists φ
  intro σ
  rfl

/--
Every fixed-`k` term DNF target has an exact improper representation as a
`k`-CNF.
-/
theorem fixedKDNF_hasImproperKCNFRepresentations
    (Var : Type) (k : Nat) :
    (fixedKDNFImproperProblem Var k).HasImproperRepresentations := by
  intro φ
  exists KTermDNF.toKCNF φ
  intro σ
  exact KTermDNF.eval_toKCNF φ σ

end BooleanClasses
end Learning
end LearningTheory
