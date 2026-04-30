import Mathlib.Data.List.FinRange
import LearningTheory.Boolean.Formulas
import LearningTheory.Complexity.MachineModel

namespace LearningTheory
namespace Boolean

open LearningTheory.Complexity

namespace FinBitEncoding

/-- Unary encoding of a bounded index. -/
def encodeFin {n : Nat} (i : Fin n) : List BitEncoding.Bit :=
  BitEncoding.encodeNatUnary i.val

/-- Decode a bounded index. -/
def decodeFin (n : Nat) :
    List BitEncoding.Bit -> Option (Fin n × List BitEncoding.Bit) :=
  fun bits =>
    match BitEncoding.decodeNatUnary bits with
    | none => none
    | some (i, rest) =>
        if h : i < n then
          some (⟨i, h⟩, rest)
        else
          none

/-- `decodeFin` is a left inverse to `encodeFin`, with suffixes. -/
theorem decodeFin_encodeFin_append {n : Nat}
    (i : Fin n) (rest : List BitEncoding.Bit) :
    decodeFin n (encodeFin i ++ rest) = some (i, rest) := by
  unfold decodeFin encodeFin
  rw [BitEncoding.decodeNatUnary_encodeNatUnary_append]
  simp [i.isLt]

end FinBitEncoding

namespace Literal

/-- Encode a finite-variable literal. `false` tags positive literals, `true` negative literals. -/
def encodeFinLiteral {n : Nat} :
    Literal (Fin n) -> List BitEncoding.Bit
  | pos i => false :: FinBitEncoding.encodeFin i
  | neg i => true :: FinBitEncoding.encodeFin i

/-- Decode a finite-variable literal. -/
def decodeFinLiteral (n : Nat) :
    List BitEncoding.Bit -> Option (Literal (Fin n) × List BitEncoding.Bit)
  | [] => none
  | false :: bits =>
      match FinBitEncoding.decodeFin n bits with
      | none => none
      | some (i, rest) => some (pos i, rest)
  | true :: bits =>
      match FinBitEncoding.decodeFin n bits with
      | none => none
      | some (i, rest) => some (neg i, rest)

/-- Literal decoding is a left inverse to literal encoding, with suffixes. -/
theorem decodeFinLiteral_encodeFinLiteral_append {n : Nat}
    (l : Literal (Fin n)) (rest : List BitEncoding.Bit) :
    decodeFinLiteral n (encodeFinLiteral l ++ rest) = some (l, rest) := by
  cases l with
  | pos i =>
      simp [encodeFinLiteral, decodeFinLiteral,
        FinBitEncoding.decodeFin_encodeFin_append]
  | neg i =>
      simp [encodeFinLiteral, decodeFinLiteral,
        FinBitEncoding.decodeFin_encodeFin_append]

/-- The list of all signed literals over `Fin n`. -/
def allFinLiterals (n : Nat) : List (Literal (Fin n)) :=
  (List.finRange n).flatMap fun v => [pos v, neg v]

/-- Every finite-variable literal appears in `allFinLiterals`. -/
theorem mem_allFinLiterals {n : Nat} (l : Literal (Fin n)) :
    l ∈ allFinLiterals n := by
  cases l <;> simp [allFinLiterals]

/-- `allFinLiterals` has exactly two signed literals per variable. -/
theorem allFinLiterals_length (n : Nat) :
    (allFinLiterals n).length = n * 2 := by
  simp [allFinLiterals]

/-- Finite-variable literal encodings have length at most `n + 2`. -/
theorem encodeFinLiteral_length_le {n : Nat}
    (l : Literal (Fin n)) :
    (encodeFinLiteral l).length <= n + 2 := by
  cases l <;>
    simp [encodeFinLiteral, FinBitEncoding.encodeFin,
      BitEncoding.encodeNatUnary]

end Literal

namespace Term

/-- Boolean membership test for finite-variable terms. -/
def containsFinLiteral {n : Nat}
    (l : Literal (Fin n)) : Term (Fin n) -> Bool
  | [] => false
  | l' :: ls => if l' = l then true else containsFinLiteral l ls

/-- The Boolean term-membership test agrees with list membership. -/
theorem containsFinLiteral_eq_true_iff {n : Nat}
    (l : Literal (Fin n)) (t : Term (Fin n)) :
    containsFinLiteral l t = true <-> l ∈ t := by
  induction t with
  | nil =>
      simp [containsFinLiteral]
  | cons l' ls ih =>
      by_cases h : l' = l
      · subst h
        simp [containsFinLiteral]
      · constructor
        · intro hEval
          exact List.Mem.tail l' (ih.mp (by
            simpa [containsFinLiteral, h] using hEval))
        · intro hMem
          cases hMem with
          | head =>
              exact False.elim (h rfl)
          | tail _ hTail =>
              simpa [containsFinLiteral, h] using ih.mpr hTail

/--
Normalize a finite-variable term by replacing it with the sublist of all signed
literals that occur in the term.
-/
def normalizeFin (n : Nat) (t : Term (Fin n)) : Term (Fin n) :=
  (Literal.allFinLiterals n).filter
    (fun l => containsFinLiteral l t)

/-- Term normalization preserves literal membership. -/
theorem mem_normalizeFin_iff {n : Nat}
    (t : Term (Fin n)) (l : Literal (Fin n)) :
    l ∈ normalizeFin n t <-> l ∈ t := by
  unfold normalizeFin
  simp [Literal.mem_allFinLiterals l,
    containsFinLiteral_eq_true_iff l t]

/-- A normalized term contains at most the `2n` possible signed literals. -/
theorem normalizeFin_length_le {n : Nat}
    (t : Term (Fin n)) :
    (normalizeFin n t).length <= n * 2 := by
  calc
    (normalizeFin n t).length
        <= (Literal.allFinLiterals n).length := by
          unfold normalizeFin
          exact List.length_filter_le
            (fun l : Literal (Fin n) => containsFinLiteral l t)
            (Literal.allFinLiterals n)
    _ = n * 2 := Literal.allFinLiterals_length n

/-- Term normalization preserves Boolean evaluation. -/
theorem eval_normalizeFin {n : Nat}
    (t : Term (Fin n)) (σ : Fin n -> Bool) :
    Term.eval (normalizeFin n t) σ = Term.eval t σ := by
  apply Bool.eq_iff_iff.mpr
  rw [Term.eval_eq_true_iff_forall_mem,
    Term.eval_eq_true_iff_forall_mem]
  constructor
  · intro h l hl
    exact h l ((mem_normalizeFin_iff t l).mpr hl)
  · intro h l hl
    exact h l ((mem_normalizeFin_iff t l).mp hl)

/-- Encode a term over finite variables. -/
def encodeFinTerm {n : Nat} (t : Term (Fin n)) :
    List BitEncoding.Bit :=
  BitEncoding.encodeList Literal.encodeFinLiteral t

/-- Decode a term over finite variables using explicit literal-list fuel. -/
def decodeFinTerm (n : Nat) (fuel : Nat) :
    List BitEncoding.Bit -> Option (Term (Fin n) × List BitEncoding.Bit) :=
  BitEncoding.decodeListFuel (Literal.decodeFinLiteral n) fuel

/-- Term decoding is a left inverse to term encoding, with suffixes. -/
theorem decodeFinTerm_encodeFinTerm_append {n : Nat}
    (t : Term (Fin n)) (rest : List BitEncoding.Bit) :
    decodeFinTerm n (t.length + 1) (encodeFinTerm t ++ rest) =
      some (t, rest) := by
  unfold decodeFinTerm encodeFinTerm
  exact BitEncoding.decodeListFuel_encodeList_append
    Literal.decodeFinLiteral_encodeFinLiteral_append t rest

/-- Term decoding works with any fuel larger than the term length. -/
theorem decodeFinTerm_encodeFinTerm_append_of_length_lt {n : Nat}
    (t : Term (Fin n)) (rest : List BitEncoding.Bit)
    {fuel : Nat} (hFuel : t.length < fuel) :
    decodeFinTerm n fuel (encodeFinTerm t ++ rest) =
      some (t, rest) := by
  unfold decodeFinTerm encodeFinTerm
  exact BitEncoding.decodeListFuel_encodeList_append_of_length_lt
    Literal.decodeFinLiteral_encodeFinLiteral_append t rest hFuel

/-- Decode a term using the total bit length as fuel. -/
def decodeFinTermWithLengthFuel (n : Nat) :
    List BitEncoding.Bit -> Option (Term (Fin n) × List BitEncoding.Bit) :=
  fun bits => decodeFinTerm n (bits.length + 1) bits

/-- Length-fuel term decoding is a left inverse to term encoding. -/
theorem decodeFinTermWithLengthFuel_encodeFinTerm_append {n : Nat}
    (t : Term (Fin n)) (rest : List BitEncoding.Bit) :
    decodeFinTermWithLengthFuel n (encodeFinTerm t ++ rest) =
      some (t, rest) := by
  unfold decodeFinTermWithLengthFuel
  exact decodeFinTerm_encodeFinTerm_append_of_length_lt t rest (by
    have hList :
        t.length + 1 <= (encodeFinTerm t).length :=
      BitEncoding.length_succ_le_encodeList_length
        Literal.encodeFinLiteral t
    simp [List.length_append]
    omega)

/-- Encoded finite terms are bounded by their literal count and variable count. -/
theorem encodeFinTerm_length_le_of_length_le {n w : Nat}
    (t : Term (Fin n)) (hLength : t.length <= w) :
    (encodeFinTerm t).length <=
      w * ((n + 2) + 1) + 1 := by
  have hList :=
    BitEncoding.encodeList_length_le_of_forall_le
      Literal.encodeFinLiteral (n + 2) t
      (fun l _ => Literal.encodeFinLiteral_length_le l)
  calc
    (encodeFinTerm t).length
        <= t.length * ((n + 2) + 1) + 1 := by
          simpa [encodeFinTerm] using hList
    _ <= w * ((n + 2) + 1) + 1 := by
          exact Nat.add_le_add_right
            (Nat.mul_le_mul_right ((n + 2) + 1) hLength)
            1

/-- Encoded normalized finite terms have polynomial length in the variable count. -/
theorem encodeFinTerm_normalizeFin_length_le {n : Nat}
    (t : Term (Fin n)) :
    (encodeFinTerm (normalizeFin n t)).length <=
      (n * 2) * ((n + 2) + 1) + 1 :=
  encodeFinTerm_length_le_of_length_le
    (normalizeFin n t) (normalizeFin_length_le t)

end Term

namespace DNF

/-- Normalize every term of a finite-variable DNF. -/
def normalizeFin (n : Nat) (φ : DNF (Fin n)) : DNF (Fin n) :=
  φ.map (fun t => Term.normalizeFin n t)

/-- DNF normalization preserves the number of terms. -/
theorem normalizeFin_length {n : Nat}
    (φ : DNF (Fin n)) :
    (normalizeFin n φ).length = φ.length := by
  simp [normalizeFin]

/-- DNF normalization preserves Boolean evaluation. -/
theorem eval_normalizeFin {n : Nat}
    (φ : DNF (Fin n)) (σ : Fin n -> Bool) :
    DNF.eval (normalizeFin n φ) σ = DNF.eval φ σ := by
  induction φ with
  | nil =>
      rfl
  | cons t ts ih =>
      change
        (Term.eval (Term.normalizeFin n t) σ
            || DNF.eval (normalizeFin n ts) σ)
          =
        (Term.eval t σ || DNF.eval ts σ)
      rw [Term.eval_normalizeFin, ih]

/-- Encode a DNF over finite variables. -/
def encodeFinDNF {n : Nat} (phi : DNF (Fin n)) :
    List BitEncoding.Bit :=
  BitEncoding.encodeList Term.encodeFinTerm phi

/-- Decode a DNF over finite variables using explicit term-list fuel. -/
def decodeFinDNF (n : Nat) (fuel : Nat) :
    List BitEncoding.Bit -> Option (DNF (Fin n) × List BitEncoding.Bit) :=
  BitEncoding.decodeListFuel (Term.decodeFinTermWithLengthFuel n) fuel

/-- DNF decoding is a left inverse to DNF encoding, with suffixes. -/
theorem decodeFinDNF_encodeFinDNF_append {n : Nat}
    (phi : DNF (Fin n)) (rest : List BitEncoding.Bit) :
    decodeFinDNF n (phi.length + 1) (encodeFinDNF phi ++ rest) =
      some (phi, rest) := by
  unfold decodeFinDNF encodeFinDNF
  exact BitEncoding.decodeListFuel_encodeList_append
    Term.decodeFinTermWithLengthFuel_encodeFinTerm_append phi rest

/-- DNF decoding works with any fuel larger than the number of terms. -/
theorem decodeFinDNF_encodeFinDNF_append_of_length_lt {n : Nat}
    (phi : DNF (Fin n)) (rest : List BitEncoding.Bit)
    {fuel : Nat} (hFuel : phi.length < fuel) :
    decodeFinDNF n fuel (encodeFinDNF phi ++ rest) =
      some (phi, rest) := by
  unfold decodeFinDNF encodeFinDNF
  exact BitEncoding.decodeListFuel_encodeList_append_of_length_lt
    Term.decodeFinTermWithLengthFuel_encodeFinTerm_append phi rest hFuel

/-- Decode a DNF using the total bit length as fuel. -/
def decodeFinDNFWithLengthFuel (n : Nat) :
    List BitEncoding.Bit -> Option (DNF (Fin n) × List BitEncoding.Bit) :=
  fun bits => decodeFinDNF n (bits.length + 1) bits

/-- Length-fuel DNF decoding is a left inverse to DNF encoding. -/
theorem decodeFinDNFWithLengthFuel_encodeFinDNF_append {n : Nat}
    (phi : DNF (Fin n)) (rest : List BitEncoding.Bit) :
    decodeFinDNFWithLengthFuel n (encodeFinDNF phi ++ rest) =
      some (phi, rest) := by
  unfold decodeFinDNFWithLengthFuel
  exact decodeFinDNF_encodeFinDNF_append_of_length_lt phi rest (by
    have hList :
        phi.length + 1 <= (encodeFinDNF phi).length :=
      BitEncoding.length_succ_le_encodeList_length
        Term.encodeFinTerm phi
    simp [List.length_append]
    omega)

/--
Encoded normalized finite-variable DNFs with at most `k` terms have polynomial
length in `n` and `k`.
-/
theorem encodeFinDNF_normalizeFin_length_le {n k : Nat}
    (φ : DNF (Fin n)) (hLength : φ.length <= k) :
    (encodeFinDNF (normalizeFin n φ)).length <=
      k * ((((n * 2) * ((n + 2) + 1) + 1)) + 1) + 1 := by
  have hEach :
      forall t : Term (Fin n),
        t ∈ normalizeFin n φ ->
          (Term.encodeFinTerm t).length
            <= (n * 2) * ((n + 2) + 1) + 1 := by
    intro t hMem
    rcases List.mem_map.mp hMem with ⟨original, _, hEq⟩
    subst hEq
    exact Term.encodeFinTerm_normalizeFin_length_le original
  have hList :=
    BitEncoding.encodeList_length_le_of_forall_le
      Term.encodeFinTerm
      ((n * 2) * ((n + 2) + 1) + 1)
      (normalizeFin n φ) hEach
  have hTermCount : (normalizeFin n φ).length <= k := by
    simpa [normalizeFin_length φ] using hLength
  calc
    (encodeFinDNF (normalizeFin n φ)).length
        <=
      (normalizeFin n φ).length
        * ((((n * 2) * ((n + 2) + 1) + 1)) + 1) + 1 := by
          simpa [encodeFinDNF] using hList
    _ <= k * ((((n * 2) * ((n + 2) + 1) + 1)) + 1) + 1 := by
          exact Nat.add_le_add_right
            (Nat.mul_le_mul_right
              ((((n * 2) * ((n + 2) + 1) + 1)) + 1)
              hTermCount)
            1

end DNF

end Boolean
end LearningTheory
