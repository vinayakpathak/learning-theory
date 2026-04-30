import Mathlib.Data.List.FinRange
import LearningTheory.Boolean.FormulaEncoding
import LearningTheory.Complexity.MachineModel
import LearningTheory.Learning.DNFConsistency

namespace LearningTheory
namespace Learning
namespace BooleanClasses

open LearningTheory.Complexity
open LearningTheory.Boolean

namespace KTermDNF

/-- Encode a finite-variable fixed-`k` DNF hypothesis by encoding its formula. -/
def encodeFin {n k : Nat} (phi : KTermDNF (Fin n) k) :
    List BitEncoding.Bit :=
  DNF.encodeFinDNF phi.formula

/-- Decode a finite-variable fixed-`k` DNF hypothesis. -/
def decodeFin (n k : Nat) :
    List BitEncoding.Bit -> Option (KTermDNF (Fin n) k × List BitEncoding.Bit) :=
  fun bits =>
    match DNF.decodeFinDNFWithLengthFuel n bits with
    | none => none
    | some (formula, rest) =>
        if h : formula.length <= k then
          some ({ formula := formula, length_le := h }, rest)
        else
          none

/-- `decodeFin` is a left inverse to `encodeFin`, with suffixes. -/
theorem decodeFin_encodeFin_append {n k : Nat}
    (phi : KTermDNF (Fin n) k) (rest : List BitEncoding.Bit) :
    decodeFin n k (encodeFin phi ++ rest) = some (phi, rest) := by
  cases phi with
  | mk formula hLength =>
      unfold decodeFin encodeFin
      rw [DNF.decodeFinDNFWithLengthFuel_encodeFinDNF_append]
      simp [hLength]

/-- Normalize every term of a finite-variable fixed-`k` DNF. -/
def normalizeFin {n k : Nat}
    (phi : KTermDNF (Fin n) k) : KTermDNF (Fin n) k where
  formula := DNF.normalizeFin n phi.formula
  length_le := by
    simpa [DNF.normalizeFin_length phi.formula] using phi.length_le

/-- Normalization preserves fixed-`k` DNF evaluation. -/
theorem eval_normalizeFin {n k : Nat}
    (phi : KTermDNF (Fin n) k) (sigma : Fin n -> Bool) :
    KTermDNF.eval (normalizeFin phi) sigma = KTermDNF.eval phi sigma := by
  unfold KTermDNF.eval normalizeFin
  exact DNF.eval_normalizeFin phi.formula sigma

/-- Encoded normalized fixed-`k` DNFs have polynomial length in `n` and `k`. -/
theorem encodeFin_normalizeFin_length_le {n k : Nat}
    (phi : KTermDNF (Fin n) k) :
    (encodeFin (normalizeFin phi)).length <=
      k * ((((n * 2) * ((n + 2) + 1) + 1)) + 1) + 1 := by
  cases phi with
  | mk formula hLength =>
      unfold encodeFin normalizeFin
      exact DNF.encodeFinDNF_normalizeFin_length_le formula hLength

end KTermDNF

/--
Concrete fixed-`k` DNF consistency inputs over variables `Fin n`.

The earlier `KTermDNFConsistencyInput` allows an arbitrary variable type. This
indexed form is the finite, encodable version used for concrete reductions.
-/
structure IndexedKTermDNFConsistencyInput where
  n : Nat
  budget : Nat
  sample : Sample (Fin n -> Bool)

namespace IndexedKTermDNFConsistencyInput

/-- The input is accepted if some fixed-`k` term DNF is consistent with the sample. -/
def Accepts (I : IndexedKTermDNFConsistencyInput) : Prop :=
  Exists fun phi : KTermDNF (Fin I.n) I.budget =>
    Sample.Consistent (fun sigma => KTermDNF.eval phi sigma) I.sample

/-- A certificate for indexed fixed-`k` DNF consistency. -/
structure ConsistencyCertificate (I : IndexedKTermDNFConsistencyInput) where
  hypothesis : KTermDNF (Fin I.n) I.budget
  consistent :
    Sample.Consistent
      (fun sigma => KTermDNF.eval hypothesis sigma)
      I.sample

namespace ConsistencyCertificate

/-- Encode a consistency certificate by encoding its hypothesis. -/
def encode {I : IndexedKTermDNFConsistencyInput}
    (cert : ConsistencyCertificate I) : List BitEncoding.Bit :=
  cert.hypothesis.encodeFin

/-- Decode a consistency certificate for a fixed indexed DNF-consistency input. -/
def decode (I : IndexedKTermDNFConsistencyInput) :
    List BitEncoding.Bit ->
      Option (ConsistencyCertificate I × List BitEncoding.Bit) :=
  fun bits =>
    match KTermDNF.decodeFin I.n I.budget bits with
    | none => none
    | some (hypothesis, rest) =>
        if hCheck :
          Sample.consistencyCheck
            (fun sigma => KTermDNF.eval hypothesis sigma)
            I.sample = true then
          some ({
            hypothesis := hypothesis
            consistent :=
              (Sample.consistencyCheck_eq_true_iff
                (fun sigma => KTermDNF.eval hypothesis sigma)
                I.sample).mp hCheck
          }, rest)
        else
          none

/-- Certificate decoding is a left inverse to certificate encoding, with suffixes. -/
theorem decode_encode_append {I : IndexedKTermDNFConsistencyInput}
    (cert : ConsistencyCertificate I) (rest : List BitEncoding.Bit) :
    decode I (encode cert ++ rest) = some (cert, rest) := by
  cases cert with
  | mk hypothesis consistent =>
      unfold decode encode
      rw [KTermDNF.decodeFin_encodeFin_append]
      have hCheck :
          Sample.consistencyCheck
            (fun sigma => KTermDNF.eval hypothesis sigma)
            I.sample = true :=
        (Sample.consistencyCheck_eq_true_iff
          (fun sigma => KTermDNF.eval hypothesis sigma)
          I.sample).mpr consistent
      simp [hCheck]

/-- Verify an encoded consistency certificate string for a fixed input. -/
def verifyString (I : IndexedKTermDNFConsistencyInput)
    (certBits : List BitEncoding.Bit) : Bool :=
  match decode I certBits with
  | some (_, []) => true
  | _ => false

/-- A verifying consistency-certificate string proves acceptance. -/
theorem verifyString_sound
    (I : IndexedKTermDNFConsistencyInput)
    (certBits : List BitEncoding.Bit)
    (hVerify : verifyString I certBits = true) :
    I.Accepts := by
  unfold verifyString at hVerify
  cases hDecode : decode I certBits with
  | none =>
      simp [hDecode] at hVerify
  | some decoded =>
      rcases decoded with ⟨cert, rest⟩
      cases rest with
      | nil =>
          exact ⟨cert.hypothesis, cert.consistent⟩
      | cons b bs =>
          simp [hDecode] at hVerify

/-- Encoding a consistency certificate produces a verifying string. -/
theorem verifyString_encode
    {I : IndexedKTermDNFConsistencyInput}
    (cert : ConsistencyCertificate I) :
    verifyString I (encode cert) = true := by
  unfold verifyString
  rw [show encode cert = encode cert ++ [] by simp]
  rw [decode_encode_append cert []]

/-- Normalize the hypothesis inside a consistency certificate. -/
def normalized {I : IndexedKTermDNFConsistencyInput}
    (cert : ConsistencyCertificate I) : ConsistencyCertificate I where
  hypothesis := cert.hypothesis.normalizeFin
  consistent :=
    Sample.consistent_of_pointwise_eq
      (fun sigma => Eq.symm
        (KTermDNF.eval_normalizeFin cert.hypothesis sigma))
      cert.consistent

/-- The normalized certificate encoding has an explicit polynomial size bound. -/
theorem encode_normalized_length_le
    {I : IndexedKTermDNFConsistencyInput}
    (cert : ConsistencyCertificate I) :
    (encode cert.normalized).length <=
      I.budget * ((((I.n * 2) * ((I.n + 2) + 1) + 1)) + 1) + 1 := by
  unfold encode normalized
  exact KTermDNF.encodeFin_normalizeFin_length_le cert.hypothesis

/-- A consistency certificate proves acceptance of the indexed DNF input. -/
theorem accepts {I : IndexedKTermDNFConsistencyInput}
    (cert : ConsistencyCertificate I) :
    I.Accepts := by
  exact ⟨cert.hypothesis, cert.consistent⟩

end ConsistencyCertificate

/-- Indexed DNF consistency accepts exactly the inputs with a consistency certificate. -/
theorem accepts_iff_exists_consistencyCertificate
    (I : IndexedKTermDNFConsistencyInput) :
    I.Accepts <-> Nonempty (ConsistencyCertificate I) := by
  constructor
  · intro h
    rcases h with ⟨phi, hConsistent⟩
    exact ⟨{
      hypothesis := phi
      consistent := hConsistent
    }⟩
  · intro h
    rcases h with ⟨cert⟩
    exact cert.accepts

/-- Indexed DNF consistency accepts exactly inputs with a verifying certificate string. -/
theorem accepts_iff_exists_verifyingString
    (I : IndexedKTermDNFConsistencyInput) :
    I.Accepts
      <->
    Exists fun certBits : List BitEncoding.Bit =>
      ConsistencyCertificate.verifyString I certBits = true := by
  constructor
  · intro h
    rcases (I.accepts_iff_exists_consistencyCertificate.mp h) with ⟨cert⟩
    exact ⟨cert.encode, ConsistencyCertificate.verifyString_encode cert⟩
  · intro h
    rcases h with ⟨certBits, hVerify⟩
    exact ConsistencyCertificate.verifyString_sound I certBits hVerify

/--
Accepted indexed DNF-consistency inputs have a verifying certificate string with
an explicit polynomial size bound in the variable count and term budget.
-/
theorem exists_bounded_verifyingString_of_accepts
    (I : IndexedKTermDNFConsistencyInput)
    (h : I.Accepts) :
    Exists fun certBits : List BitEncoding.Bit =>
      certBits.length
        <= I.budget * ((((I.n * 2) * ((I.n + 2) + 1) + 1)) + 1) + 1
        /\ ConsistencyCertificate.verifyString I certBits = true := by
  rcases (I.accepts_iff_exists_consistencyCertificate.mp h) with ⟨cert⟩
  let normalized := cert.normalized
  exact ⟨normalized.encode,
    ⟨ConsistencyCertificate.encode_normalized_length_le cert,
      ConsistencyCertificate.verifyString_encode normalized⟩⟩

/--
Indexed DNF consistency accepts exactly inputs with a polynomially bounded
verifying certificate string.
-/
theorem accepts_iff_exists_boundedVerifyingString
    (I : IndexedKTermDNFConsistencyInput) :
    I.Accepts
      <->
    Exists fun certBits : List BitEncoding.Bit =>
      certBits.length
        <= I.budget * ((((I.n * 2) * ((I.n + 2) + 1) + 1)) + 1) + 1
        /\ ConsistencyCertificate.verifyString I certBits = true := by
  constructor
  · intro h
    exact I.exists_bounded_verifyingString_of_accepts h
  · intro h
    rcases h with ⟨certBits, _, hVerify⟩
    exact ConsistencyCertificate.verifyString_sound I certBits hVerify

/-- Repackage an indexed input as the generic universe-polymorphic input. -/
def toKTermDNFConsistencyInput (I : IndexedKTermDNFConsistencyInput) :
    KTermDNFConsistencyInput where
  Var := Fin I.n
  decEq := inferInstance
  budget := I.budget
  sample := I.sample

theorem accepts_iff_packaged (I : IndexedKTermDNFConsistencyInput) :
    I.Accepts <-> I.toKTermDNFConsistencyInput.Accepts := by
  rfl

/-- Encode an assignment by listing the value of every variable in order. -/
def encodeAssignment {n : Nat} (sigma : Fin n -> Bool) :
    List BitEncoding.Bit :=
  List.ofFn sigma

/-- Prepend one bit to an assignment over the remaining variables. -/
def consAssignment {n : Nat} (b : Bool) (sigma : Fin n -> Bool) :
    Fin (n + 1) -> Bool :=
  Fin.cases b sigma

/-- Decode an assignment over `Fin n`, returning the unconsumed suffix. -/
def decodeAssignment :
    (n : Nat) ->
      List BitEncoding.Bit -> Option ((Fin n -> Bool) × List BitEncoding.Bit)
  | 0, bits => some (Fin.elim0, bits)
  | _ + 1, [] => none
  | n + 1, b :: bits =>
      match decodeAssignment n bits with
      | none => none
      | some (sigma, rest) => some (consAssignment b sigma, rest)

/-- Assignment decoding is a left inverse to assignment encoding, with suffixes. -/
theorem decodeAssignment_encodeAssignment_append {n : Nat}
    (sigma : Fin n -> Bool) (rest : List BitEncoding.Bit) :
    decodeAssignment n (encodeAssignment sigma ++ rest) =
      some (sigma, rest) := by
  induction n generalizing rest with
  | zero =>
      have hSigma : (Fin.elim0 : Fin 0 -> Bool) = sigma := by
        funext i
        exact Fin.elim0 i
      simp [decodeAssignment, encodeAssignment, hSigma]
  | succ n ih =>
      rw [encodeAssignment, List.ofFn_succ]
      change
        decodeAssignment (n + 1)
          (sigma 0 :: List.ofFn (fun i => sigma i.succ) ++ rest)
          = some (sigma, rest)
      rw [show
          sigma 0 :: List.ofFn (fun i => sigma i.succ) ++ rest
            =
          sigma 0 :: (List.ofFn (fun i => sigma i.succ) ++ rest) by rfl]
      have hCons :
          consAssignment (sigma 0) (fun i : Fin n => sigma i.succ)
            = sigma := by
        funext i
        exact Fin.cases rfl (fun _ => rfl) i
      have hDecode := ih (fun i : Fin n => sigma i.succ) rest
      simp [encodeAssignment] at hDecode
      change
        (match
          decodeAssignment n
            ((List.ofFn fun i : Fin n => sigma i.succ) ++ rest)
        with
        | none => none
        | some (sigmaTail, restTail) =>
            some (consAssignment (sigma 0) sigmaTail, restTail))
          = some (sigma, rest)
      rw [hDecode]
      simp [hCons]

/-- Encoding a cons assignment exposes the leading bit. -/
theorem encodeAssignment_consAssignment {n : Nat}
    (b : Bool) (sigma : Fin n -> Bool) :
    encodeAssignment (consAssignment b sigma) =
      b :: encodeAssignment sigma := by
  simp [encodeAssignment, consAssignment, List.ofFn_succ]

/-- If assignment decoding succeeds, the input has the encoded-assignment prefix. -/
theorem decodeAssignment_eq_some_imp_eq_encodeAssignment_append :
    forall (n : Nat) (bits : List BitEncoding.Bit)
      (sigma : Fin n -> Bool) (rest : List BitEncoding.Bit),
      decodeAssignment n bits = some (sigma, rest) ->
        bits = encodeAssignment sigma ++ rest
  | 0, bits, sigma, rest, hDecode => by
      simp [decodeAssignment] at hDecode
      rcases hDecode with ⟨_, hrest⟩
      subst rest
      simp [encodeAssignment]
  | n + 1, [], sigma, rest, hDecode => by
      simp [decodeAssignment] at hDecode
  | n + 1, b :: bits, sigma, rest, hDecode => by
      unfold decodeAssignment at hDecode
      cases hTailDecode : decodeAssignment n bits with
      | none =>
          simp [hTailDecode] at hDecode
      | some decoded =>
          rcases decoded with ⟨sigmaTail, restTail⟩
          simp [hTailDecode] at hDecode
          rcases hDecode with ⟨hsigma, hrest⟩
          subst sigma
          subst rest
          have hTail :=
            decodeAssignment_eq_some_imp_eq_encodeAssignment_append
              n bits sigmaTail restTail hTailDecode
          rw [hTail, encodeAssignment_consAssignment]
          rfl

/-- Encode one labeled example. -/
def encodeExample {n : Nat} (e : Example (Fin n -> Bool)) :
    List BitEncoding.Bit :=
  encodeAssignment e.x ++ [e.y]

/-- Assignment encodings have exactly one bit per variable. -/
theorem encodeAssignment_length {n : Nat}
    (sigma : Fin n -> Bool) :
    (encodeAssignment sigma).length = n := by
  simp [encodeAssignment]

/-- Example encodings contain the assignment bits and one label bit. -/
theorem encodeExample_length {n : Nat}
    (e : Example (Fin n -> Bool)) :
    (encodeExample e).length = n + 1 := by
  cases e
  simp [encodeExample, encodeAssignment]

/-- Decode one labeled example. -/
def decodeExample (n : Nat) :
    List BitEncoding.Bit ->
      Option (Example (Fin n -> Bool) × List BitEncoding.Bit) :=
  fun bits =>
    match decodeAssignment n bits with
    | none => none
    | some (_, []) => none
    | some (sigma, y :: rest) =>
        some ({ x := sigma, y := y }, rest)

/-- Example decoding is a left inverse to example encoding, with suffixes. -/
theorem decodeExample_encodeExample_append {n : Nat}
    (e : Example (Fin n -> Bool)) (rest : List BitEncoding.Bit) :
    decodeExample n (encodeExample e ++ rest) = some (e, rest) := by
  cases e with
  | mk sigma y =>
      simp [decodeExample, encodeExample, List.append_assoc,
        decodeAssignment_encodeAssignment_append]

/-- If example decoding succeeds, the input has the encoded-example prefix. -/
theorem decodeExample_eq_some_imp_eq_encodeExample_append {n : Nat}
    (bits : List BitEncoding.Bit) (e : Example (Fin n -> Bool))
    (rest : List BitEncoding.Bit)
    (hDecode : decodeExample n bits = some (e, rest)) :
    bits = encodeExample e ++ rest := by
  unfold decodeExample at hDecode
  cases hAssign : decodeAssignment n bits with
  | none =>
      simp [hAssign] at hDecode
  | some decoded =>
      rcases decoded with ⟨sigma, suffix⟩
      cases suffix with
      | nil =>
          simp [hAssign] at hDecode
      | cons y restTail =>
          simp [hAssign] at hDecode
          rcases hDecode with ⟨he, hrest⟩
          subst e
          subst rest
          have hAssignBits :=
            decodeAssignment_eq_some_imp_eq_encodeAssignment_append
              n bits sigma (y :: restTail) hAssign
          rw [hAssignBits]
          simp [encodeExample, List.append_assoc]

/-- Decode a sample using explicit list-cell fuel. -/
def decodeSample (n : Nat) (fuel : Nat) :
    List BitEncoding.Bit ->
      Option (Sample (Fin n -> Bool) × List BitEncoding.Bit) :=
  BitEncoding.decodeListFuel (decodeExample n) fuel

/-- Sample decoding is a left inverse to sample encoding, with suffixes. -/
theorem decodeSample_encodeList_append {n : Nat}
    (sample : Sample (Fin n -> Bool)) (rest : List BitEncoding.Bit) :
    decodeSample n (sample.length + 1)
        (BitEncoding.encodeList encodeExample sample ++ rest)
      =
    some (sample, rest) := by
  unfold decodeSample
  exact BitEncoding.decodeListFuel_encodeList_append
    decodeExample_encodeExample_append sample rest

/-- Sample decoding works with any fuel larger than the sample length. -/
theorem decodeSample_encodeList_append_of_length_lt {n : Nat}
    (sample : Sample (Fin n -> Bool)) (rest : List BitEncoding.Bit)
    {fuel : Nat} (hFuel : sample.length < fuel) :
    decodeSample n fuel
        (BitEncoding.encodeList encodeExample sample ++ rest)
      =
    some (sample, rest) := by
  unfold decodeSample
  exact BitEncoding.decodeListFuel_encodeList_append_of_length_lt
    decodeExample_encodeExample_append sample rest hFuel

/-- If sample decoding succeeds, the input has the encoded-sample prefix. -/
theorem decodeSample_eq_some_imp_eq_encode_append {n : Nat}
    (fuel : Nat) (bits : List BitEncoding.Bit)
    (sample : Sample (Fin n -> Bool)) (rest : List BitEncoding.Bit)
    (hDecode : decodeSample n fuel bits = some (sample, rest)) :
    bits = BitEncoding.encodeList encodeExample sample ++ rest := by
  unfold decodeSample at hDecode
  exact BitEncoding.decodeListFuel_eq_some_imp_eq_encodeList_append
    decodeExample_eq_some_imp_eq_encodeExample_append
    fuel bits sample rest hDecode

/-- Sample encodings are linearly bounded by sample length and assignment width. -/
theorem encodeSample_length_le {n : Nat}
    (sample : Sample (Fin n -> Bool)) :
    (BitEncoding.encodeList encodeExample sample).length
      <= sample.length * ((n + 1) + 1) + 1 := by
  exact BitEncoding.encodeList_length_le_of_forall_le
    encodeExample (n + 1) sample
    (fun e _ => by simp [encodeExample_length e])

/-- Bit encoding of an indexed DNF consistency input. -/
def encode (I : IndexedKTermDNFConsistencyInput) :
    List BitEncoding.Bit :=
  BitEncoding.encodeNatUnary I.n
    ++ BitEncoding.encodeNatUnary I.budget
    ++ BitEncoding.encodeList
      (fun e : Example (Fin I.n -> Bool) => encodeExample e)
      I.sample

/-- Decode an indexed DNF consistency input using explicit sample-list fuel. -/
def decodeWithSampleFuel (sampleFuel : Nat) :
    List BitEncoding.Bit ->
      Option (IndexedKTermDNFConsistencyInput × List BitEncoding.Bit) :=
  fun bits =>
    match BitEncoding.decodeNatUnary bits with
    | none => none
    | some (n, rest₁) =>
        match BitEncoding.decodeNatUnary rest₁ with
        | none => none
        | some (budget, rest₂) =>
            match decodeSample n sampleFuel rest₂ with
            | none => none
            | some (sample, rest₃) =>
                some ({ n := n, budget := budget, sample := sample }, rest₃)

/-- DNF-consistency input decoding is a left inverse to input encoding, with suffixes. -/
theorem decodeWithSampleFuel_encode_append
    (I : IndexedKTermDNFConsistencyInput)
    (rest : List BitEncoding.Bit) :
    decodeWithSampleFuel (I.sample.length + 1)
        (I.encode ++ rest)
      =
    some (I, rest) := by
  unfold decodeWithSampleFuel encode
  simp only [List.append_assoc]
  simp [BitEncoding.decodeNatUnary_encodeNatUnary_append,
    decodeSample_encodeList_append]

/-- DNF-consistency input decoding works with any fuel larger than the sample length. -/
theorem decodeWithSampleFuel_encode_append_of_sample_length_lt
    (I : IndexedKTermDNFConsistencyInput)
    (rest : List BitEncoding.Bit) {sampleFuel : Nat}
    (hFuel : I.sample.length < sampleFuel) :
    decodeWithSampleFuel sampleFuel (I.encode ++ rest) =
      some (I, rest) := by
  unfold decodeWithSampleFuel encode
  simp only [List.append_assoc]
  simp [BitEncoding.decodeNatUnary_encodeNatUnary_append,
    decodeSample_encodeList_append_of_length_lt I.sample rest hFuel]

/-- If DNF-consistency input decoding succeeds, the input has the encoded-input prefix. -/
theorem decodeWithSampleFuel_eq_some_imp_eq_encode_append
    (sampleFuel : Nat) (bits : List BitEncoding.Bit)
    (I : IndexedKTermDNFConsistencyInput) (rest : List BitEncoding.Bit)
    (hDecode : decodeWithSampleFuel sampleFuel bits = some (I, rest)) :
    bits = I.encode ++ rest := by
  unfold decodeWithSampleFuel at hDecode
  cases hN : BitEncoding.decodeNatUnary bits with
  | none =>
      simp [hN] at hDecode
  | some decodedN =>
      rcases decodedN with ⟨n, rest₁⟩
      cases hBudget : BitEncoding.decodeNatUnary rest₁ with
      | none =>
          simp [hN, hBudget] at hDecode
      | some decodedBudget =>
          rcases decodedBudget with ⟨budget, rest₂⟩
          cases hSample : decodeSample n sampleFuel rest₂ with
          | none =>
              simp [hN, hBudget, hSample] at hDecode
          | some decodedSample =>
              rcases decodedSample with ⟨sample, rest₃⟩
              simp [hN, hBudget, hSample] at hDecode
              rcases hDecode with ⟨hI, hrest⟩
              subst rest
              have hBits :
                  bits = BitEncoding.encodeNatUnary n ++ rest₁ :=
                BitEncoding.decodeNatUnary_eq_some_imp_eq_encodeNatUnary_append
                  bits n rest₁ hN
              have hBudgetBits :
                  rest₁ = BitEncoding.encodeNatUnary budget ++ rest₂ :=
                BitEncoding.decodeNatUnary_eq_some_imp_eq_encodeNatUnary_append
                  rest₁ budget rest₂ hBudget
              have hSampleBits :
                  rest₂ = BitEncoding.encodeList encodeExample sample ++ rest₃ :=
                decodeSample_eq_some_imp_eq_encode_append
                  sampleFuel rest₂ sample rest₃ hSample
              have hEncodeI :
                  I.encode =
                    BitEncoding.encodeNatUnary n
                      ++ BitEncoding.encodeNatUnary budget
                      ++ BitEncoding.encodeList encodeExample sample := by
                rw [← hI]
                rfl
              rw [hBits, hBudgetBits, hSampleBits]
              rw [hEncodeI]
              simp [List.append_assoc]

/-- The sample length is bounded by the bit length of the full input encoding. -/
theorem sample_length_lt_encode_length_succ
    (I : IndexedKTermDNFConsistencyInput) :
    I.sample.length < I.encode.length + 1 := by
  have hList :
      I.sample.length + 1
        <= (BitEncoding.encodeList
          (fun e : Example (Fin I.n -> Bool) => encodeExample e)
          I.sample).length :=
    BitEncoding.length_succ_le_encodeList_length
      (fun e : Example (Fin I.n -> Bool) => encodeExample e)
      I.sample
  unfold encode
  simp [List.length_append]
  omega

/-- Indexed DNF-consistency input encodings have a simple size bound. -/
theorem encode_length_le
    (I : IndexedKTermDNFConsistencyInput) :
    I.encode.length
      <= (I.n + 1) + (I.budget + 1)
        + I.sample.length * ((I.n + 1) + 1) + 1 := by
  have hSample :
      (BitEncoding.encodeList
          (fun e : Example (Fin I.n -> Bool) => encodeExample e)
          I.sample).length
        <= I.sample.length * ((I.n + 1) + 1) + 1 := by
    simpa using encodeSample_length_le I.sample
  unfold encode BitEncoding.encodeNatUnary
  simp [List.length_append]
  omega

/--
DNF-consistency input decoding with fuel `bits.length + 1` is a left inverse
on exact valid encodings.
-/
theorem decodeWithLengthFuel_encode
    (I : IndexedKTermDNFConsistencyInput) :
    decodeWithSampleFuel (I.encode.length + 1) I.encode =
      some (I, []) := by
  simpa using
    decodeWithSampleFuel_encode_append_of_sample_length_lt
      I [] (sample_length_lt_encode_length_succ I)

/-- A polynomial certificate bound as a function of encoded input length. -/
def certificateLengthBound (codeLength : Nat) : Nat :=
  codeLength * ((((codeLength * 2) * ((codeLength + 2) + 1) + 1)) + 1) + 1

/-- The variable count is bounded by the bit length of the DNF-consistency encoding. -/
theorem n_le_encode_length
    (I : IndexedKTermDNFConsistencyInput) :
    I.n <= I.encode.length := by
  unfold encode BitEncoding.encodeNatUnary
  simp [List.length_append]

/-- The term budget is bounded by the bit length of the DNF-consistency encoding. -/
theorem budget_le_encode_length
    (I : IndexedKTermDNFConsistencyInput) :
    I.budget <= I.encode.length := by
  unfold encode BitEncoding.encodeNatUnary
  simp [List.length_append]
  omega

/--
The normalized DNF-certificate bound in terms of `n` and the budget is bounded
by the polynomial certificate bound in terms of encoded input length.
-/
theorem certificate_bound_le_codeLength_bound
    (I : IndexedKTermDNFConsistencyInput) :
    I.budget * ((((I.n * 2) * ((I.n + 2) + 1) + 1)) + 1) + 1
      <= certificateLengthBound I.encode.length := by
  let L := I.encode.length
  have hn : I.n <= L := by
    simpa [L] using I.n_le_encode_length
  have hb : I.budget <= L := by
    simpa [L] using I.budget_le_encode_length
  have hDouble : I.n * 2 <= L * 2 :=
    Nat.mul_le_mul_right 2 hn
  have hFactor : (I.n + 2) + 1 <= (L + 2) + 1 := by
    omega
  have hInner :
      (I.n * 2) * ((I.n + 2) + 1)
        <= (L * 2) * ((L + 2) + 1) :=
    Nat.mul_le_mul hDouble hFactor
  have hOuter :
      (((I.n * 2) * ((I.n + 2) + 1) + 1)) + 1
        <= (((L * 2) * ((L + 2) + 1) + 1)) + 1 := by
    omega
  have hMul :
      I.budget * ((((I.n * 2) * ((I.n + 2) + 1) + 1)) + 1)
        <= L * ((((L * 2) * ((L + 2) + 1) + 1)) + 1) :=
    Nat.mul_le_mul hb hOuter
  simpa [certificateLengthBound, L] using Nat.add_le_add_right hMul 1

/--
Combined DNF-consistency verifier for strings of the form
`encodedInput ++ certificate`.
-/
def verifyCertificateString (bits : List BitEncoding.Bit) : Bool :=
  match decodeWithSampleFuel (bits.length + 1) bits with
  | none => false
  | some (I, certBits) => ConsistencyCertificate.verifyString I certBits

/-- The combined verifier agrees with certificate verification after a valid encoding. -/
theorem verifyCertificateString_encode_append
    (I : IndexedKTermDNFConsistencyInput)
    (certBits : List BitEncoding.Bit) :
    verifyCertificateString (I.encode ++ certBits)
      =
    ConsistencyCertificate.verifyString I certBits := by
  unfold verifyCertificateString
  rw [decodeWithSampleFuel_encode_append_of_sample_length_lt
    I certBits (by
      have hFuel := sample_length_lt_encode_length_succ I
      simp [List.length_append] at hFuel ⊢
      omega)]

/-- Soundness of the combined DNF-consistency certificate verifier. -/
theorem verifyCertificateString_sound
    (I : IndexedKTermDNFConsistencyInput)
    (certBits : List BitEncoding.Bit)
    (hVerify : verifyCertificateString (I.encode ++ certBits) = true) :
    I.Accepts := by
  rw [verifyCertificateString_encode_append] at hVerify
  exact ConsistencyCertificate.verifyString_sound I certBits hVerify

/--
Accepted DNF-consistency inputs have polynomially bounded certificate strings
for the combined verifier, with the bound expressed in terms of input length.
-/
theorem exists_bounded_certificateString_of_accepts
    (I : IndexedKTermDNFConsistencyInput)
    (h : I.Accepts) :
    Exists fun certBits : List BitEncoding.Bit =>
      certBits.length <= certificateLengthBound I.encode.length
        /\ verifyCertificateString (I.encode ++ certBits) = true := by
  rcases I.exists_bounded_verifyingString_of_accepts h with
    ⟨certBits, hLength, hVerify⟩
  exact ⟨certBits,
    ⟨le_trans hLength (I.certificate_bound_le_codeLength_bound),
      by simpa [verifyCertificateString_encode_append I certBits] using hVerify⟩⟩

end IndexedKTermDNFConsistencyInput

/-- The indexed proper fixed-`k` DNF consistency decision problem. -/
def indexedProperKTermDNFConsistencyDecisionProblem :
    Complexity.DecisionProblem where
  Input := IndexedKTermDNFConsistencyInput
  accepts := fun I => I.Accepts

/-- The indexed DNF consistency problem accepts exactly certificate-bearing inputs. -/
theorem indexedProperKTermDNFConsistency_accepts_iff_exists_certificate
    (I : IndexedKTermDNFConsistencyInput) :
    indexedProperKTermDNFConsistencyDecisionProblem.accepts I
      <->
    Nonempty (I.ConsistencyCertificate) := by
  exact I.accepts_iff_exists_consistencyCertificate

/-- Soundness of the combined verifier for the indexed DNF-consistency decision problem. -/
theorem indexedProperKTermDNFConsistency_verifyCertificateString_sound
    (I : IndexedKTermDNFConsistencyInput)
    (certBits : List BitEncoding.Bit)
    (hVerify :
      IndexedKTermDNFConsistencyInput.verifyCertificateString
        (I.encode ++ certBits) = true) :
    indexedProperKTermDNFConsistencyDecisionProblem.accepts I :=
  I.verifyCertificateString_sound certBits hVerify

/--
Accepted indexed DNF-consistency inputs have polynomially bounded certificate
strings for the combined verifier.
-/
theorem indexedProperKTermDNFConsistency_exists_bounded_certificateString
    (I : IndexedKTermDNFConsistencyInput)
    (h : indexedProperKTermDNFConsistencyDecisionProblem.accepts I) :
    Exists fun certBits : List BitEncoding.Bit =>
      certBits.length
        <= IndexedKTermDNFConsistencyInput.certificateLengthBound I.encode.length
        /\ IndexedKTermDNFConsistencyInput.verifyCertificateString
          (I.encode ++ certBits) = true :=
  I.exists_bounded_certificateString_of_accepts h

/-- The indexed proper fixed-`k` DNF consistency problem with concrete bit encoding. -/
def encodedIndexedProperKTermDNFConsistencyDecisionProblem :
    EncodedDecisionProblem Bool where
  Input := IndexedKTermDNFConsistencyInput
  encode := IndexedKTermDNFConsistencyInput.encode
  accepts := indexedProperKTermDNFConsistencyDecisionProblem.accepts

/-- The indexed problem reduces to the earlier generic packaged problem. -/
def indexedProperKTermDNFConsistencyToPackaged :
    Complexity.ManyOneReduction
      indexedProperKTermDNFConsistencyDecisionProblem
      properKTermDNFConsistencyDecisionProblem where
  map := IndexedKTermDNFConsistencyInput.toKTermDNFConsistencyInput
  sound := by
    intro _ h
    exact h
  complete := by
    intro _ h
    exact h

end BooleanClasses
end Learning
end LearningTheory
