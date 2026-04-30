import LearningTheory.Complexity.MachineModel

namespace LearningTheory
namespace Complexity

namespace BitComplexity

open Polynomial

/-- Encode a Boolean output as a one-symbol bit string. -/
def boolOutput (b : Bool) : List Bool :=
  [b]

/-- Encode a fixed-length random string by listing its bits in order. -/
def encodeRandom {n : Nat} (r : Fin n -> Bool) : List Bool :=
  (List.finRange n).map r

/--
A deterministic polynomial-time decider for an encoded bit problem, using
CSLib's single-tape machine model for the underlying string function.
-/
structure PolyTimeDecider (A : EncodedDecisionProblem Bool) where
  decide : List Bool -> Bool
  polytime :
    Turing.SingleTapeTM.PolyTimeComputable
      (fun w => boolOutput (decide w))
  correct :
    forall x : A.Input, decide (A.encode x) = true <-> A.accepts x

/--
A deterministic polynomial-time decider whose selected CSLib time bound is
monotone. This is the decider analogue of `MonotoneEncodedManyOneReduction`.
-/
structure MonotonePolyTimeDecider (A : EncodedDecisionProblem Bool)
    extends PolyTimeDecider A where
  polytime_mono : Monotone polytime.time_bound

/-- Concrete deterministic polynomial time over encoded bit problems. -/
def P : EncodedComplexityClass Bool where
  contains := fun A => Nonempty (PolyTimeDecider A)

/--
A polynomial-time verifier with polynomially bounded bit certificates.

The verifier is a concrete bit-string machine. On mathematical instances, it is
only required to behave correctly on strings of the form `A.encode x ++ cert`.
-/
structure NPVerifier (A : EncodedDecisionProblem Bool) where
  verify : List Bool -> Bool
  polytime :
    Turing.SingleTapeTM.PolyTimeComputable
      (fun w => boolOutput (verify w))
  certBound : Nat -> Nat
  certPoly : Polynomial Nat
  certBound_poly : forall n : Nat, certBound n <= certPoly.eval n
  sound :
    forall (x : A.Input) (cert : List Bool),
      cert.length <= certBound (A.encode x).length ->
      verify (A.encode x ++ cert) = true -> A.accepts x
  complete :
    forall x : A.Input, A.accepts x ->
      Exists fun cert : List Bool =>
        cert.length <= certBound (A.encode x).length
          /\ verify (A.encode x ++ cert) = true

/-- Concrete NP over encoded bit problems. -/
def NP : EncodedComplexityClass Bool where
  contains := fun A => Nonempty (NPVerifier A)

namespace PolyTimeDecider

/-- A deterministic polynomial-time decider is an NP verifier with empty certificates. -/
noncomputable def toNPVerifier {A : EncodedDecisionProblem Bool}
    (d : PolyTimeDecider A) : NPVerifier A where
  verify := d.decide
  polytime := d.polytime
  certBound := fun _ => 0
  certPoly := 0
  certBound_poly := by
    intro _
    simp
  sound := by
    intro x cert hLen hVerify
    have hCertLength : cert.length = 0 := Nat.eq_zero_of_le_zero hLen
    have hCert : cert = [] := List.eq_nil_of_length_eq_zero hCertLength
    subst hCert
    have hDec : d.decide (A.encode x) = true := by
      simpa using hVerify
    exact (d.correct x).mp hDec
  complete := by
    intro x hAccept
    exists []
    constructor
    · simp
    · simpa using (d.correct x).mpr hAccept

end PolyTimeDecider

namespace MonotonePolyTimeDecider

/-- Repackage the decision string function as monotone polynomial-time computable. -/
def monotonePolytime {A : EncodedDecisionProblem Bool}
    (d : MonotonePolyTimeDecider A) :
    MonotonePolyTimeComputable (fun w => boolOutput (d.decide w)) where
  toPolyTimeComputable := d.polytime
  time_bound_mono := d.polytime_mono

end MonotonePolyTimeDecider

/--
Deterministic polynomial time is closed downward under encoded many-one
reductions, provided CSLib can compose the reduction machine with a decider whose
time bound is monotone.
-/
noncomputable def P_of_encodedManyOneReduction
    {A B : EncodedDecisionProblem Bool}
    (red : EncodedManyOneReduction A B)
    (decB : PolyTimeDecider B)
    (hMono : Monotone decB.polytime.time_bound) :
    P.contains A := by
  exact ⟨{
    decide := fun w => decB.decide (red.encodedMap w)
    polytime := by
      simpa [Function.comp_def, boolOutput]
        using Turing.SingleTapeTM.PolyTimeComputable.comp
          red.polytime decB.polytime hMono
    correct := by
      intro x
      rw [red.encodedMap_correct x]
      constructor
      · intro hAccept
        exact red.complete x ((decB.correct (red.map x)).mp hAccept)
      · intro hAccept
        exact (decB.correct (red.map x)).mpr (red.sound x hAccept)
  }⟩

/--
Deterministic polynomial time is closed downward under encoded many-one
reductions after retiming the reduction and decider machines to monotone
polynomial bounds.
-/
noncomputable def P_of_encodedManyOneReduction_retimed
    {A B : EncodedDecisionProblem Bool}
    (red : EncodedManyOneReduction A B)
    (decB : PolyTimeDecider B) :
    P.contains A := by
  exact ⟨{
    decide := fun w => decB.decide (red.encodedMap w)
    polytime := by
      simpa [Function.comp_def, boolOutput]
        using PolyTimeComputable.compRetimed red.polytime decB.polytime
    correct := by
      intro x
      rw [red.encodedMap_correct x]
      constructor
      · intro hAccept
        exact red.complete x ((decB.correct (red.map x)).mp hAccept)
      · intro hAccept
        exact (decB.correct (red.map x)).mpr (red.sound x hAccept)
  }⟩

/--
Deterministic polynomial time is closed downward under monotone encoded
many-one reductions and monotone deterministic deciders.
-/
noncomputable def MonotonePolyTimeDecider.of_monotoneEncodedManyOneReduction
    {A B : EncodedDecisionProblem Bool}
    (red : MonotoneEncodedManyOneReduction A B)
    (decB : MonotonePolyTimeDecider B) :
    MonotonePolyTimeDecider A where
  decide := fun w => decB.decide (red.encodedMap w)
  polytime := by
    simpa [Function.comp_def, boolOutput]
      using (MonotonePolyTimeComputable.comp
        red.monotonePolytime decB.monotonePolytime).toPolyTimeComputable
  correct := by
    intro x
    rw [red.encodedMap_correct x]
    constructor
    · intro hAccept
      exact red.complete x ((decB.correct (red.map x)).mp hAccept)
    · intro hAccept
      exact (decB.correct (red.map x)).mpr (red.sound x hAccept)
  polytime_mono := by
    simpa [Function.comp_def, boolOutput]
      using (MonotonePolyTimeComputable.comp
        red.monotonePolytime decB.monotonePolytime).time_bound_mono

/-- The corresponding `P` closure statement for monotone encoded reductions. -/
noncomputable def P_of_monotoneEncodedManyOneReduction
    {A B : EncodedDecisionProblem Bool}
    (red : MonotoneEncodedManyOneReduction A B)
    (decB : MonotonePolyTimeDecider B) :
    P.contains A :=
  ⟨(MonotonePolyTimeDecider.of_monotoneEncodedManyOneReduction red decB).toPolyTimeDecider⟩

/-- Deterministic polynomial time is contained in NP in the concrete bit model. -/
theorem P_subset_NP : EncodedSubset P NP := by
  intro A hA
  rcases hA with ⟨d⟩
  exact ⟨d.toNPVerifier⟩

/-- Number of random strings accepted by a bit predicate at a fixed length. -/
def acceptingRandomCount
    (decide : List Bool -> Bool) (code : List Bool) (m : Nat) : Nat :=
  ((Finset.univ : Finset (Fin m -> Bool)).filter
    (fun r => decide (code ++ encodeRandom r) = true)).card

/--
An RP-style one-sided randomized polynomial-time decider.

The random string length is polynomially bounded. Soundness is one-sided:
accepting on any random string implies membership. Completeness asks at least
half of all random strings of the chosen length to accept.
-/
structure RPDecider (A : EncodedDecisionProblem Bool) where
  decide : List Bool -> Bool
  polytime :
    Turing.SingleTapeTM.PolyTimeComputable
      (fun w => boolOutput (decide w))
  randomLength : Nat -> Nat
  randomPoly : Polynomial Nat
  randomLength_poly : forall n : Nat, randomLength n <= randomPoly.eval n
  sound :
    forall (x : A.Input) (suffix : List Bool),
      suffix.length <= randomLength (A.encode x).length ->
      decide (A.encode x ++ suffix) = true -> A.accepts x
  complete :
    forall x : A.Input, A.accepts x ->
      Fintype.card (Fin (randomLength (A.encode x).length) -> Bool)
        <= 2 * acceptingRandomCount
          decide (A.encode x) (randomLength (A.encode x).length)

/--
An RP decider whose selected CSLib running-time bound is monotone. This is the
randomized analogue of `MonotonePolyTimeDecider`.
-/
structure MonotoneRPDecider (A : EncodedDecisionProblem Bool)
    extends RPDecider A where
  polytime_mono : Monotone polytime.time_bound

/-- Concrete RP over encoded bit problems. -/
def RP : EncodedComplexityClass Bool where
  contains := fun A => Nonempty (RPDecider A)

/--
An RP-style decider whose random length is allowed to depend on the encoded
instance string, not just its length.

This code-dependent variant is better behaved under encoded reductions: after a
string transformer maps `A.encode x` to `B.encode (f x)`, the source decider can
use exactly the target decider's random length on the transformed code.
-/
structure CodeRPDecider (A : EncodedDecisionProblem Bool) where
  decide : List Bool -> Bool
  polytime :
    Turing.SingleTapeTM.PolyTimeComputable
      (fun w => boolOutput (decide w))
  randomLength : List Bool -> Nat
  randomPoly : Polynomial Nat
  randomLength_poly :
    forall x : A.Input,
      randomLength (A.encode x) <= randomPoly.eval (A.encode x).length
  sound :
    forall (x : A.Input) (suffix : List Bool),
      suffix.length <= randomLength (A.encode x) ->
      decide (A.encode x ++ suffix) = true -> A.accepts x
  complete :
    forall x : A.Input, A.accepts x ->
      Fintype.card (Fin (randomLength (A.encode x)) -> Bool)
        <= 2 * acceptingRandomCount
          decide (A.encode x) (randomLength (A.encode x))

/-- Concrete code-dependent RP over encoded bit problems. -/
def CodeRP : EncodedComplexityClass Bool where
  contains := fun A => Nonempty (CodeRPDecider A)

namespace PolyTimeDecider

/-- A deterministic polynomial-time decider is an RP decider using no random bits. -/
noncomputable def toRPDecider {A : EncodedDecisionProblem Bool}
    (d : PolyTimeDecider A) : RPDecider A where
  decide := d.decide
  polytime := d.polytime
  randomLength := fun _ => 0
  randomPoly := 0
  randomLength_poly := by
    intro _
    simp
  sound := by
    intro x suffix hLen h
    have hSuffixLength : suffix.length = 0 := Nat.eq_zero_of_le_zero hLen
    have hSuffix : suffix = [] := List.eq_nil_of_length_eq_zero hSuffixLength
    subst hSuffix
    have hDec : d.decide (A.encode x) = true := by
      simpa using h
    exact (d.correct x).mp hDec
  complete := by
    intro x hAccept
    have hDec : d.decide (A.encode x) = true := (d.correct x).mpr hAccept
    have hCount :
        acceptingRandomCount d.decide (A.encode x) 0 = 1 := by
      unfold acceptingRandomCount
      simp [encodeRandom, hDec]
    simp [hCount]

end PolyTimeDecider

namespace RPDecider

/-- A length-based RP decider is also a code-dependent RP decider. -/
noncomputable def toCodeRPDecider {A : EncodedDecisionProblem Bool}
    (d : RPDecider A) : CodeRPDecider A where
  decide := d.decide
  polytime := d.polytime
  randomLength := fun code => d.randomLength code.length
  randomPoly := d.randomPoly
  randomLength_poly := by
    intro x
    exact d.randomLength_poly (A.encode x).length
  sound := by
    intro x suffix hLen hVerify
    exact d.sound x suffix hLen hVerify
  complete := by
    intro x hAccept
    exact d.complete x hAccept

end RPDecider

/-- Length-based RP is contained in code-dependent RP. -/
theorem RP_subset_CodeRP : EncodedSubset RP CodeRP := by
  intro A hA
  rcases hA with ⟨d⟩
  exact ⟨d.toCodeRPDecider⟩

/-- Deterministic polynomial time is contained in RP in the concrete bit model. -/
theorem P_subset_RP : EncodedSubset P RP := by
  intro A hA
  rcases hA with ⟨d⟩
  exact ⟨d.toRPDecider⟩

namespace RPDecider

/-- An RP decider gives an NP verifier by using the random string as a certificate. -/
noncomputable def toNPVerifier {A : EncodedDecisionProblem Bool}
    (d : RPDecider A) : NPVerifier A where
  verify := d.decide
  polytime := d.polytime
  certBound := d.randomLength
  certPoly := d.randomPoly
  certBound_poly := d.randomLength_poly
  sound := by
    intro x cert hLen hVerify
    exact d.sound x cert hLen hVerify
  complete := by
    intro x hAccept
    let m := d.randomLength (A.encode x).length
    have hComplete := d.complete x hAccept
    have hCardPos :
        0 < Fintype.card (Fin m -> Bool) :=
      Fintype.card_pos_iff.mpr ⟨fun _ => false⟩
    have hCountPos :
        0 < acceptingRandomCount d.decide (A.encode x) m := by
      by_contra hNot
      have hZero :
          acceptingRandomCount d.decide (A.encode x) m = 0 :=
        Nat.eq_zero_of_not_pos hNot
      have hCardZero :
          Fintype.card (Fin m -> Bool) <= 0 := by
        have hCompleteZero := hComplete
        simp [m, hZero] at hCompleteZero
      exact Nat.not_lt_zero _ (Nat.lt_of_lt_of_le hCardPos hCardZero)
    have hNonempty :
        ((Finset.univ : Finset (Fin m -> Bool)).filter
          (fun r => d.decide (A.encode x ++ encodeRandom r) = true)).Nonempty := by
      exact Finset.card_pos.mp hCountPos
    rcases hNonempty with ⟨r, hr⟩
    exists encodeRandom r
    constructor
    · simp [encodeRandom, m]
    · simpa using (Finset.mem_filter.mp hr).right

end RPDecider

/-- RP is contained in NP in the concrete bit model. -/
theorem RP_subset_NP : EncodedSubset RP NP := by
  intro A hA
  rcases hA with ⟨d⟩
  exact ⟨d.toNPVerifier⟩

namespace MonotoneRPDecider

/-- Repackage the randomized decision string function as monotone polynomial-time computable. -/
def monotonePolytime {A : EncodedDecisionProblem Bool}
    (d : MonotoneRPDecider A) :
    MonotonePolyTimeComputable (fun w => boolOutput (d.decide w)) where
  toPolyTimeComputable := d.polytime
  time_bound_mono := d.polytime_mono

end MonotoneRPDecider

/--
RP is closed under suffix-preserving encoded reductions when the source
random-length function exactly matches the target random length of the reduced
instance.

This states the compatibility condition needed by the current `RPDecider`
interface: random strings are appended to the encoding, so the reduction must
preserve that suffix, and the source decider must use the same random length as
the target decider after reduction.
-/
noncomputable def RP_of_suffixEncodedManyOneReduction_compatibleRandomLength
    {A B : EncodedDecisionProblem Bool}
    (red : SuffixEncodedManyOneReduction A B)
    (decB : MonotoneRPDecider B)
    (randomLengthA : Nat -> Nat)
    (randomPolyA : Polynomial Nat)
    (hRandomPolyA : forall n : Nat, randomLengthA n <= randomPolyA.eval n)
    (hRandomCompat :
      forall x : A.Input,
        randomLengthA (A.encode x).length =
          decB.randomLength
            ((B.encode (red.map x)).length)) :
    RP.contains A := by
  exact ⟨{
    decide := fun w => decB.decide (red.encodedMap w)
    polytime := by
      simpa [Function.comp_def, boolOutput]
        using Turing.SingleTapeTM.PolyTimeComputable.comp
          red.polytime decB.polytime decB.polytime_mono
    randomLength := randomLengthA
    randomPoly := randomPolyA
    randomLength_poly := hRandomPolyA
    sound := by
      intro x suffix hLen hAccept
      have hLenB :
          suffix.length <=
            decB.randomLength ((B.encode (red.map x)).length) := by
        simpa [hRandomCompat x] using hLen
      have hAcceptB :
          decB.decide (B.encode (red.map x) ++ suffix) = true := by
        simpa [red.encodedMap_correct_append x suffix] using hAccept
      exact red.complete x (decB.sound (red.map x) suffix hLenB hAcceptB)
    complete := by
      intro x hAccept
      have hCompleteB :=
        decB.complete (red.map x) (red.sound x hAccept)
      rw [hRandomCompat x]
      simpa [acceptingRandomCount, red.encodedMap_correct_append x]
        using hCompleteB
  }⟩

/--
Retimed version of `RP_of_suffixEncodedManyOneReduction_compatibleRandomLength`,
which accepts any target `RPDecider`.
-/
noncomputable def RP_of_suffixEncodedManyOneReduction_compatibleRandomLength_retimed
    {A B : EncodedDecisionProblem Bool}
    (red : SuffixEncodedManyOneReduction A B)
    (decB : RPDecider B)
    (randomLengthA : Nat -> Nat)
    (randomPolyA : Polynomial Nat)
    (hRandomPolyA : forall n : Nat, randomLengthA n <= randomPolyA.eval n)
    (hRandomCompat :
      forall x : A.Input,
        randomLengthA (A.encode x).length =
          decB.randomLength
            ((B.encode (red.map x)).length)) :
    RP.contains A := by
  exact ⟨{
    decide := fun w => decB.decide (red.encodedMap w)
    polytime := by
      simpa [Function.comp_def, boolOutput]
        using PolyTimeComputable.compRetimed red.polytime decB.polytime
    randomLength := randomLengthA
    randomPoly := randomPolyA
    randomLength_poly := hRandomPolyA
    sound := by
      intro x suffix hLen hAccept
      have hLenB :
          suffix.length <=
            decB.randomLength ((B.encode (red.map x)).length) := by
        simpa [hRandomCompat x] using hLen
      have hAcceptB :
          decB.decide (B.encode (red.map x) ++ suffix) = true := by
        simpa [red.encodedMap_correct_append x suffix] using hAccept
      exact red.complete x (decB.sound (red.map x) suffix hLenB hAcceptB)
    complete := by
      intro x hAccept
      have hCompleteB :=
        decB.complete (red.map x) (red.sound x hAccept)
      rw [hRandomCompat x]
      simpa [acceptingRandomCount, red.encodedMap_correct_append x]
        using hCompleteB
  }⟩

/--
Code-dependent RP is closed downward under suffix-preserving encoded many-one
reductions.
-/
noncomputable def CodeRP_of_suffixEncodedManyOneReduction
    {A B : EncodedDecisionProblem Bool}
    (red : SuffixEncodedManyOneReduction A B)
    (decB : CodeRPDecider B) :
    CodeRP.contains A := by
  exact ⟨{
    decide := fun w => decB.decide (red.encodedMap w)
    polytime := by
      simpa [Function.comp_def, boolOutput]
        using PolyTimeComputable.compRetimed red.polytime decB.polytime
    randomLength := fun code => decB.randomLength (red.encodedMap code)
    randomPoly := decB.randomPoly.comp red.outputLengthPoly
    randomLength_poly := by
      intro x
      have hMapLen :
          (B.encode (red.map x)).length
            <= red.outputLengthPoly.eval (A.encode x).length := by
        simpa [red.encodedMap_correct x]
          using red.encodedMap_length_le_outputLengthPoly (A.encode x)
      calc
        decB.randomLength (red.encodedMap (A.encode x))
            = decB.randomLength (B.encode (red.map x)) := by
                rw [red.encodedMap_correct x]
        _ <= decB.randomPoly.eval (B.encode (red.map x)).length :=
            decB.randomLength_poly (red.map x)
        _ <= decB.randomPoly.eval (red.outputLengthPoly.eval (A.encode x).length) :=
            polynomial_eval_mono_nat decB.randomPoly hMapLen
        _ = (decB.randomPoly.comp red.outputLengthPoly).eval (A.encode x).length := by
            simp [Polynomial.eval_comp]
    sound := by
      intro x suffix hLen hAccept
      have hLenB :
          suffix.length <= decB.randomLength (B.encode (red.map x)) := by
        simpa [red.encodedMap_correct x] using hLen
      have hAcceptB :
          decB.decide (B.encode (red.map x) ++ suffix) = true := by
        simpa [red.encodedMap_correct_append x suffix] using hAccept
      exact red.complete x (decB.sound (red.map x) suffix hLenB hAcceptB)
    complete := by
      intro x hAccept
      have hCompleteB :=
        decB.complete (red.map x) (red.sound x hAccept)
      rw [red.encodedMap_correct x]
      simpa [acceptingRandomCount, red.encodedMap_correct_append x]
        using hCompleteB
  }⟩

/-- Code-dependent RP is closed downward under suffix-preserving encoded reductions. -/
theorem CodeRP_closed_under_suffix_encoded_many_one :
    forall A B : EncodedDecisionProblem Bool,
      SuffixEncodedManyOneReduction A B ->
        CodeRP.contains B -> CodeRP.contains A := by
  intro A B red hB
  rcases hB with ⟨decB⟩
  exact CodeRP_of_suffixEncodedManyOneReduction red decB

/--
The concrete bit-complexity landscape, once closure of `RP` under encoded
many-one reductions is supplied.

The inclusions `P ⊆ RP` and `RP ⊆ NP` are proved above. The closure theorem
requires concrete machine constructions for composing randomized deciders with
encoded reductions, so it remains an explicit parameter.
-/
def landscape
    (hRPClosed : EncodedClosedUnderManyOne RP) :
    EncodedComplexityLandscape Bool where
  P := P
  NP := NP
  RP := RP
  P_subset_RP := P_subset_RP
  RP_subset_NP := RP_subset_NP
  RP_closed_under_many_one := hRPClosed

end BitComplexity

end Complexity
end LearningTheory
