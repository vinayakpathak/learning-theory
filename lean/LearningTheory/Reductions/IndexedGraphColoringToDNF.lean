import LearningTheory.Complexity.GraphColoringEncoding
import LearningTheory.Learning.IndexedDNFConsistency
import LearningTheory.Reductions.GraphColoringToDNF

namespace LearningTheory
namespace Reductions

open LearningTheory.Complexity
open LearningTheory.Learning
open LearningTheory.Learning.BooleanClasses
open Polynomial

/-- The indexed fixed-`k` DNF consistency input produced from an indexed graph. -/
def indexedGraphColoringDNFInput (G : IndexedGraphColoringInstance) :
    IndexedKTermDNFConsistencyInput where
  n := G.n
  budget := G.budget
  sample := graphColoringSample G.toGraphColoringInstance

/-- The indexed reduction output has one sample point per vertex and per edge. -/
theorem indexedGraphColoringDNFInput_sample_length
    (G : IndexedGraphColoringInstance) :
    (indexedGraphColoringDNFInput G).sample.length =
      G.n + G.edges.length := by
  unfold indexedGraphColoringDNFInput
  change (graphColoringSample G.toGraphColoringInstance).length =
    G.n + G.edges.length
  rw [graphColoringSample_length]
  simp [IndexedGraphColoringInstance.toGraphColoringInstance,
    IndexedGraphColoringInstance.vertices]

/-- A polynomial output-length bound for the encoded graph-to-DNF reduction. -/
def encodedGraphColoringToDNFOutputLengthBound (inputLength : Nat) : Nat :=
  (inputLength + 1) + (inputLength + 1)
    + (inputLength + inputLength) * ((inputLength + 1) + 1) + 1

/-- Polynomial matching the encoded graph-to-DNF output-length bound. -/
noncomputable def encodedGraphColoringToDNFOutputLengthBoundPoly :
    Polynomial Nat :=
  (X + 1) + (X + 1) + (X + X) * ((X + 1) + 1) + 1

/-- The output-length polynomial evaluates to the concrete output-length bound. -/
theorem encodedGraphColoringToDNFOutputLengthBoundPoly_eval
    (n : Nat) :
    encodedGraphColoringToDNFOutputLengthBoundPoly.eval n =
      encodedGraphColoringToDNFOutputLengthBound n := by
  simp [encodedGraphColoringToDNFOutputLengthBoundPoly,
    encodedGraphColoringToDNFOutputLengthBound]

/-- A polynomial all-input output-length bound for the graph-to-DNF string transformer. -/
def encodedGraphColoringToDNFAllInputOutputLengthBound (inputLength : Nat) : Nat :=
  encodedGraphColoringToDNFOutputLengthBound inputLength + inputLength

/-- Polynomial matching the all-input graph-to-DNF output-length bound. -/
noncomputable def encodedGraphColoringToDNFAllInputOutputLengthBoundPoly :
    Polynomial Nat :=
  encodedGraphColoringToDNFOutputLengthBoundPoly + X

/-- The all-input output-length polynomial evaluates to the concrete bound. -/
theorem encodedGraphColoringToDNFAllInputOutputLengthBoundPoly_eval
    (n : Nat) :
    encodedGraphColoringToDNFAllInputOutputLengthBoundPoly.eval n =
      encodedGraphColoringToDNFAllInputOutputLengthBound n := by
  simp [encodedGraphColoringToDNFAllInputOutputLengthBoundPoly,
    encodedGraphColoringToDNFAllInputOutputLengthBound,
    encodedGraphColoringToDNFOutputLengthBoundPoly_eval]

/--
The encoded output of the indexed graph-to-DNF reduction has length bounded by a
polynomial in the source graph encoding length.
-/
theorem indexedGraphColoringDNFInput_encode_length_le
    (G : IndexedGraphColoringInstance) :
    (indexedGraphColoringDNFInput G).encode.length
      <= encodedGraphColoringToDNFOutputLengthBound G.encode.length := by
  let I := indexedGraphColoringDNFInput G
  let L := G.encode.length
  change I.encode.length <= encodedGraphColoringToDNFOutputLengthBound L
  have hInput := I.encode_length_le
  have hn : I.n <= L := by
    simpa [I, L, indexedGraphColoringDNFInput]
      using G.n_le_encode_length
  have hb : I.budget <= L := by
    simpa [I, L, indexedGraphColoringDNFInput]
      using G.budget_le_encode_length
  have hSample : I.sample.length <= L + L := by
    rw [show I.sample.length =
        (indexedGraphColoringDNFInput G).sample.length by rfl]
    rw [indexedGraphColoringDNFInput_sample_length]
    have hnG : G.n <= L := by
      simpa [L] using G.n_le_encode_length
    have heG : G.edges.length <= L := by
      simpa [L] using G.edges_length_le_encode_length
    omega
  have hFactor : (I.n + 1) + 1 <= (L + 1) + 1 := by
    omega
  have hProduct :
      I.sample.length * ((I.n + 1) + 1)
        <= (L + L) * ((L + 1) + 1) :=
    Nat.mul_le_mul hSample hFactor
  calc
    I.encode.length
        <= (I.n + 1) + (I.budget + 1)
          + I.sample.length * ((I.n + 1) + 1) + 1 := hInput
    _ <= encodedGraphColoringToDNFOutputLengthBound L := by
          unfold encodedGraphColoringToDNFOutputLengthBound
          omega

/-- Correctness of the indexed graph-coloring-to-DNF-consistency construction. -/
theorem indexedGraphColoring_to_indexedDNFConsistency_correct
    (G : IndexedGraphColoringInstance) :
    indexedGraphColoringDecisionProblem.accepts G
      <->
    indexedProperKTermDNFConsistencyDecisionProblem.accepts
      (indexedGraphColoringDNFInput G) := by
  exact graphColoring_to_properDNFConsistency_correct
    G.toGraphColoringInstance

/-- A graph-coloring certificate maps to a DNF-consistency certificate. -/
def consistencyCertificate_of_coloringCertificate
    (G : IndexedGraphColoringInstance)
    (cert : G.ColoringCertificate) :
    (indexedGraphColoringDNFInput G).ConsistencyCertificate where
  hypothesis :=
    kTermDNFOfColorClasses G.toGraphColoringInstance
      cert.classes cert.length_le
  consistent := by
    simpa [indexedGraphColoringDNFInput]
      using graphColoringSample_consistent_of_coloring
        G.toGraphColoringInstance cert.classes cert.length_le
        cert.covers cert.separates

/-- A DNF-consistency certificate for the reduced instance maps back to a coloring certificate. -/
def coloringCertificate_of_consistencyCertificate
    (G : IndexedGraphColoringInstance)
    (cert : (indexedGraphColoringDNFInput G).ConsistencyCertificate) :
    G.ColoringCertificate where
  classes :=
    colorClassesOfDNF G.toGraphColoringInstance cert.hypothesis
  length_le := by
    letI := G.toGraphColoringInstance.decEq
    unfold colorClassesOfDNF
    have hLen :
        (List.map
          (fun t =>
            verticesAcceptedByTerm G.toGraphColoringInstance.vertices t)
          cert.hypothesis.formula).length
          =
        cert.hypothesis.formula.length := by
      exact List.length_map
        (fun t =>
          verticesAcceptedByTerm G.toGraphColoringInstance.vertices t)
    calc
      (List.map
        (fun t =>
          verticesAcceptedByTerm G.toGraphColoringInstance.vertices t)
        cert.hypothesis.formula).length
          = cert.hypothesis.formula.length := hLen
      _ <= G.budget := by
          simpa [indexedGraphColoringDNFInput]
            using cert.hypothesis.length_le
  covers := by
    have hConsistent :
        Sample.Consistent
          (fun σ => KTermDNF.eval cert.hypothesis σ)
          (graphColoringSample G.toGraphColoringInstance) := by
      simpa [indexedGraphColoringDNFInput] using cert.consistent
    have hSplit := (Sample.consistent_append_iff
      (fun σ => KTermDNF.eval cert.hypothesis σ)
      (positiveExamples G.toGraphColoringInstance)
      (negativeExamples G.toGraphColoringInstance)).mp hConsistent
    exact colorClasses_cover_vertices_of_positive_consistent
      G.toGraphColoringInstance cert.hypothesis hSplit.left
  separates := by
    have hConsistent :
        Sample.Consistent
          (fun σ => KTermDNF.eval cert.hypothesis σ)
          (graphColoringSample G.toGraphColoringInstance) := by
      simpa [indexedGraphColoringDNFInput] using cert.consistent
    have hSplit := (Sample.consistent_append_iff
      (fun σ => KTermDNF.eval cert.hypothesis σ)
      (positiveExamples G.toGraphColoringInstance)
      (negativeExamples G.toGraphColoringInstance)).mp hConsistent
    exact colorClasses_separate_edges_of_negative_consistent
      G.toGraphColoringInstance cert.hypothesis hSplit.right

/-- The many-one reduction from indexed graph coloring to indexed DNF consistency. -/
def indexedGraphColoringToIndexedProperKTermDNFConsistency :
    ManyOneReduction
      indexedGraphColoringDecisionProblem
      indexedProperKTermDNFConsistencyDecisionProblem where
  map := indexedGraphColoringDNFInput
  sound := by
    intro G h
    exact (indexedGraphColoring_to_indexedDNFConsistency_correct G).mp h
  complete := by
    intro G h
    exact (indexedGraphColoring_to_indexedDNFConsistency_correct G).mpr h

/--
The concrete bit-string transformer corresponding to the indexed
graph-coloring-to-DNF-consistency map.

It parses a graph encoding using length-based fuel. On malformed inputs it
returns the empty string; on valid graph encodings the theorem below proves it
returns exactly the encoded target DNF-consistency instance.
-/
def encodedGraphColoringToDNFStringMap (bits : List Bool) : List Bool :=
  match IndexedGraphColoringInstance.decodeWithEdgeFuel (bits.length + 1) bits with
  | none => []
  | some (G, rest) => (indexedGraphColoringDNFInput G).encode ++ rest

/-- The concrete string transformer agrees with the mathematical reduction on valid encodings. -/
theorem encodedGraphColoringToDNFStringMap_correct
    (G : IndexedGraphColoringInstance) :
    encodedGraphColoringToDNFStringMap
        (encodedIndexedGraphColoringDecisionProblem.encode G)
      =
    encodedIndexedProperKTermDNFConsistencyDecisionProblem.encode
        (indexedGraphColoringDNFInput G) := by
  unfold encodedGraphColoringToDNFStringMap
  change
    (match
      IndexedGraphColoringInstance.decodeWithEdgeFuel
        (G.encode.length + 1) G.encode with
    | none => []
    | some (G, rest) => (indexedGraphColoringDNFInput G).encode ++ rest)
      =
    (indexedGraphColoringDNFInput G).encode
  rw [IndexedGraphColoringInstance.decodeWithLengthFuel_encode G]
  simp

/--
The concrete string transformer is suffix preserving on valid source encodings.
This is the form needed when encoded verifiers receive an instance followed by a
certificate or random string.
-/
theorem encodedGraphColoringToDNFStringMap_correct_append
    (G : IndexedGraphColoringInstance) (rest : List Bool) :
    encodedGraphColoringToDNFStringMap (G.encode ++ rest)
      =
    (indexedGraphColoringDNFInput G).encode ++ rest := by
  unfold encodedGraphColoringToDNFStringMap
  change
    (match
      IndexedGraphColoringInstance.decodeWithEdgeFuel
        ((G.encode ++ rest).length + 1) (G.encode ++ rest) with
    | none => []
    | some (G, rest) => (indexedGraphColoringDNFInput G).encode ++ rest)
      =
    (indexedGraphColoringDNFInput G).encode ++ rest
  rw [IndexedGraphColoringInstance.decodeWithEdgeFuel_encode_append_of_checkedEdges_length_lt
    G rest (by
      have hFuel :=
        IndexedGraphColoringInstance.checkedEdges_length_lt_encode_length_succ G
      simp [List.length_append] at hFuel ⊢
      omega)]

/-- The concrete transformer has polynomially bounded output length on valid encodings. -/
theorem encodedGraphColoringToDNFStringMap_length_le
    (G : IndexedGraphColoringInstance) :
    (encodedGraphColoringToDNFStringMap G.encode).length
      <= encodedGraphColoringToDNFOutputLengthBound G.encode.length := by
  change
    (encodedGraphColoringToDNFStringMap
      (encodedIndexedGraphColoringDecisionProblem.encode G)).length
      <= encodedGraphColoringToDNFOutputLengthBound G.encode.length
  rw [encodedGraphColoringToDNFStringMap_correct G]
  exact indexedGraphColoringDNFInput_encode_length_le G

/--
The suffix-preserving transformer has polynomially bounded output length plus
the unchanged suffix length on valid source encodings.
-/
theorem encodedGraphColoringToDNFStringMap_length_le_append
    (G : IndexedGraphColoringInstance) (rest : List Bool) :
    (encodedGraphColoringToDNFStringMap (G.encode ++ rest)).length
      <= encodedGraphColoringToDNFOutputLengthBound G.encode.length
        + rest.length := by
  rw [encodedGraphColoringToDNFStringMap_correct_append G rest]
  simp [List.length_append]
  exact indexedGraphColoringDNFInput_encode_length_le G

/-- The concrete graph-to-DNF string transformer has polynomial output length on every input. -/
theorem encodedGraphColoringToDNFStringMap_length_le_all
    (bits : List Bool) :
    (encodedGraphColoringToDNFStringMap bits).length
      <= encodedGraphColoringToDNFAllInputOutputLengthBound bits.length := by
  unfold encodedGraphColoringToDNFStringMap
  cases hDecode :
      IndexedGraphColoringInstance.decodeWithEdgeFuel
        (bits.length + 1) bits with
  | none =>
      simp [encodedGraphColoringToDNFAllInputOutputLengthBound,
        encodedGraphColoringToDNFOutputLengthBound]
  | some decoded =>
      rcases decoded with ⟨G, rest⟩
      have hRecon :
          bits = G.encode ++ rest :=
        IndexedGraphColoringInstance.decodeWithEdgeFuel_eq_some_imp_eq_encode_append
          (bits.length + 1) bits G rest hDecode
      have hMapLen :
          ((indexedGraphColoringDNFInput G).encode ++ rest).length
            <= encodedGraphColoringToDNFOutputLengthBound G.encode.length
              + rest.length := by
        rw [List.length_append]
        exact Nat.add_le_add_right
          (indexedGraphColoringDNFInput_encode_length_le G) rest.length
      have hGLength : G.encode.length <= bits.length := by
        rw [hRecon]
        simp [List.length_append]
      have hRestLength : rest.length <= bits.length := by
        rw [hRecon]
        simp [List.length_append]
      have hBoundMono :
          encodedGraphColoringToDNFOutputLengthBound G.encode.length
            <= encodedGraphColoringToDNFOutputLengthBound bits.length := by
        rw [← encodedGraphColoringToDNFOutputLengthBoundPoly_eval,
          ← encodedGraphColoringToDNFOutputLengthBoundPoly_eval]
        exact polynomial_eval_mono_nat
          encodedGraphColoringToDNFOutputLengthBoundPoly hGLength
      calc
        ((indexedGraphColoringDNFInput G).encode ++ rest).length
            <= encodedGraphColoringToDNFOutputLengthBound G.encode.length
              + rest.length := hMapLen
        _ <= encodedGraphColoringToDNFOutputLengthBound bits.length
              + bits.length := by
            exact Nat.add_le_add hBoundMono hRestLength
        _ = encodedGraphColoringToDNFAllInputOutputLengthBound bits.length := by
            rfl

/--
After the graph-to-DNF string map, the target combined verifier sees the reduced
DNF input with the original certificate suffix.
-/
theorem verifyTarget_after_encodedGraphColoringToDNFStringMap_append
    (G : IndexedGraphColoringInstance) (certBits : List Bool) :
    IndexedKTermDNFConsistencyInput.verifyCertificateString
        (encodedGraphColoringToDNFStringMap (G.encode ++ certBits))
      =
    IndexedKTermDNFConsistencyInput.verifyCertificateString
        ((indexedGraphColoringDNFInput G).encode ++ certBits) := by
  rw [encodedGraphColoringToDNFStringMap_correct_append G certBits]

/--
If a certificate makes the reduced target verifier accept after applying the
encoded graph-to-DNF map, then the original graph is colorable.
-/
theorem graphColoring_accepts_of_targetVerifier_after_encodedMap
    (G : IndexedGraphColoringInstance) (certBits : List Bool)
    (hVerify :
      IndexedKTermDNFConsistencyInput.verifyCertificateString
        (encodedGraphColoringToDNFStringMap (G.encode ++ certBits)) = true) :
    indexedGraphColoringDecisionProblem.accepts G := by
  rw [verifyTarget_after_encodedGraphColoringToDNFStringMap_append] at hVerify
  have hTarget :
      indexedProperKTermDNFConsistencyDecisionProblem.accepts
        (indexedGraphColoringDNFInput G) :=
    indexedProperKTermDNFConsistency_verifyCertificateString_sound
      (indexedGraphColoringDNFInput G) certBits hVerify
  exact (indexedGraphColoring_to_indexedDNFConsistency_correct G).mpr hTarget

/--
If the original graph is colorable, then some certificate suffix makes the target
verifier accept after applying the encoded graph-to-DNF map.
-/
theorem exists_targetVerifier_after_encodedMap_of_graphColoring_accepts
    (G : IndexedGraphColoringInstance)
    (hGraph : indexedGraphColoringDecisionProblem.accepts G) :
    Exists fun certBits : List Bool =>
      IndexedKTermDNFConsistencyInput.verifyCertificateString
        (encodedGraphColoringToDNFStringMap (G.encode ++ certBits)) = true := by
  have hTarget :
      indexedProperKTermDNFConsistencyDecisionProblem.accepts
        (indexedGraphColoringDNFInput G) :=
    (indexedGraphColoring_to_indexedDNFConsistency_correct G).mp hGraph
  rcases
    indexedProperKTermDNFConsistency_exists_bounded_certificateString
      (indexedGraphColoringDNFInput G) hTarget with
    ⟨certBits, _, hVerify⟩
  exact ⟨certBits, by
    simpa [verifyTarget_after_encodedGraphColoringToDNFStringMap_append G certBits]
      using hVerify⟩

/-- The concrete string transformer produces a decodable target input on valid graph encodings. -/
theorem decode_target_encodedGraphColoringToDNFStringMap
    (G : IndexedGraphColoringInstance) :
    IndexedKTermDNFConsistencyInput.decodeWithSampleFuel
        ((encodedGraphColoringToDNFStringMap G.encode).length + 1)
        (encodedGraphColoringToDNFStringMap G.encode)
      =
    some (indexedGraphColoringDNFInput G, []) := by
  have hMap := encodedGraphColoringToDNFStringMap_correct G
  change
    encodedGraphColoringToDNFStringMap G.encode
      =
    (indexedGraphColoringDNFInput G).encode at hMap
  rw [hMap]
  exact IndexedKTermDNFConsistencyInput.decodeWithLengthFuel_encode
    (indexedGraphColoringDNFInput G)

/--
Machine-level lifting of the indexed reduction.

The mathematical reduction is fully proved above. To obtain a CSLib-backed
encoded reduction, it remains only to provide a polynomial-time bit-string
implementation of the same map and prove that it agrees with the encodings on
valid graph-coloring inputs.
-/
def encodedIndexedGraphColoringToIndexedProperKTermDNFConsistency
    (encodedMap : List Bool -> List Bool)
    (hEncodedMap :
      forall G : IndexedGraphColoringInstance,
        encodedMap
            (encodedIndexedGraphColoringDecisionProblem.encode G)
          =
        encodedIndexedProperKTermDNFConsistencyDecisionProblem.encode
            (indexedGraphColoringDNFInput G))
    (hPolytime :
      Turing.SingleTapeTM.PolyTimeComputable encodedMap) :
    EncodedManyOneReduction
      encodedIndexedGraphColoringDecisionProblem
      encodedIndexedProperKTermDNFConsistencyDecisionProblem where
  map := indexedGraphColoringDNFInput
  sound := by
    intro G h
    exact (indexedGraphColoring_to_indexedDNFConsistency_correct G).mp h
  complete := by
    intro G h
    exact (indexedGraphColoring_to_indexedDNFConsistency_correct G).mpr h
  encodedMap := encodedMap
  encodedMap_correct := hEncodedMap
  polytime := hPolytime

/--
Monotone-time version of the encoded lifting theorem. This is useful when the
resulting reduction must be composed using CSLib's single-tape composition
theorem.
-/
def monotoneEncodedIndexedGraphColoringToIndexedProperKTermDNFConsistency
    (encodedMap : List Bool -> List Bool)
    (hEncodedMap :
      forall G : IndexedGraphColoringInstance,
        encodedMap
            (encodedIndexedGraphColoringDecisionProblem.encode G)
          =
        encodedIndexedProperKTermDNFConsistencyDecisionProblem.encode
            (indexedGraphColoringDNFInput G))
    (hPolytime :
      MonotonePolyTimeComputable encodedMap) :
    MonotoneEncodedManyOneReduction
      encodedIndexedGraphColoringDecisionProblem
      encodedIndexedProperKTermDNFConsistencyDecisionProblem where
  toEncodedManyOneReduction :=
    encodedIndexedGraphColoringToIndexedProperKTermDNFConsistency
      encodedMap hEncodedMap hPolytime.toPolyTimeComputable
  polytime_mono := hPolytime.time_bound_mono

/--
Machine-level lifting specialized to the concrete string transformer. The only
remaining proof obligation is CSLib polynomial-time computability of
`encodedGraphColoringToDNFStringMap`.
-/
def encodedIndexedGraphColoringToIndexedProperKTermDNFConsistencyOfPolytime
    (hPolytime :
      Turing.SingleTapeTM.PolyTimeComputable
        encodedGraphColoringToDNFStringMap) :
    EncodedManyOneReduction
      encodedIndexedGraphColoringDecisionProblem
      encodedIndexedProperKTermDNFConsistencyDecisionProblem :=
  encodedIndexedGraphColoringToIndexedProperKTermDNFConsistency
    encodedGraphColoringToDNFStringMap
    encodedGraphColoringToDNFStringMap_correct
    hPolytime

/--
Monotone-time machine-level lifting specialized to
`encodedGraphColoringToDNFStringMap`.
-/
def monotoneEncodedIndexedGraphColoringToIndexedProperKTermDNFConsistencyOfPolytime
    (hPolytime :
      MonotonePolyTimeComputable
        encodedGraphColoringToDNFStringMap) :
    MonotoneEncodedManyOneReduction
      encodedIndexedGraphColoringDecisionProblem
      encodedIndexedProperKTermDNFConsistencyDecisionProblem :=
  monotoneEncodedIndexedGraphColoringToIndexedProperKTermDNFConsistency
    encodedGraphColoringToDNFStringMap
    encodedGraphColoringToDNFStringMap_correct
    hPolytime

/--
The concrete indexed graph-to-DNF reduction as a suffix-preserving encoded
many-one reduction, assuming the CSLib polynomial-time implementation proof for
the string transformer.
-/
def suffixEncodedIndexedGraphColoringToIndexedProperKTermDNFConsistencyOfPolytime
    (hPolytime :
      Turing.SingleTapeTM.PolyTimeComputable
        encodedGraphColoringToDNFStringMap) :
    SuffixEncodedManyOneReduction
      encodedIndexedGraphColoringDecisionProblem
      encodedIndexedProperKTermDNFConsistencyDecisionProblem where
  toEncodedManyOneReduction :=
    encodedIndexedGraphColoringToIndexedProperKTermDNFConsistencyOfPolytime
      hPolytime
  encodedMap_correct_append := by
    intro G suffix
    exact encodedGraphColoringToDNFStringMap_correct_append G suffix

/--
Monotone-time suffix-preserving version of the concrete indexed graph-to-DNF
reduction.
-/
def monotoneSuffixEncodedIndexedGraphColoringToIndexedProperKTermDNFConsistencyOfPolytime
    (hPolytime :
      MonotonePolyTimeComputable
        encodedGraphColoringToDNFStringMap) :
    MonotoneSuffixEncodedManyOneReduction
      encodedIndexedGraphColoringDecisionProblem
      encodedIndexedProperKTermDNFConsistencyDecisionProblem where
  toSuffixEncodedManyOneReduction :=
    suffixEncodedIndexedGraphColoringToIndexedProperKTermDNFConsistencyOfPolytime
      hPolytime.toPolyTimeComputable
  polytime_mono := hPolytime.time_bound_mono

/--
The many-one reduction from indexed graph coloring to the generic packaged DNF
consistency problem. This reduction is heterogeneous in universe level because
the packaged input stores an arbitrary `Type`.
-/
def indexedGraphColoringToProperKTermDNFConsistency :
    ManyOneReduction
      indexedGraphColoringDecisionProblem
      properKTermDNFConsistencyDecisionProblem :=
  ManyOneReduction.comp
    indexedGraphColoringToIndexedProperKTermDNFConsistency
    indexedProperKTermDNFConsistencyToPackaged

/--
If a class is closed under many-one reductions and indexed graph coloring is
not in it, then indexed proper fixed-`k` DNF consistency is not in it either.
-/
theorem indexedProperKTermDNFConsistency_not_in_class_of_indexedGraphColoring_not_in_class
    {K : ComplexityClass}
    (hClosed : ClosedUnderManyOne K)
    (hIndexedGraph : Not (K.contains indexedGraphColoringDecisionProblem)) :
    Not (K.contains indexedProperKTermDNFConsistencyDecisionProblem) := by
  exact not_contains_target_of_reduction hClosed
    indexedGraphColoringToIndexedProperKTermDNFConsistency hIndexedGraph

/--
If indexed graph coloring is NP-hard in a landscape and `RP != NP`, then the
indexed proper fixed-`k` DNF consistency problem is not in `RP`.
-/
theorem indexedProperKTermDNFConsistency_not_in_RP_of_indexedGraphColoring_hard
    (L : ComplexityLandscape)
    (hRPClosed : ClosedUnderManyOne L.RP)
    (hIndexedHard : L.NPHard indexedGraphColoringDecisionProblem)
    (hRPNeNP : L.RPNeNP) :
    Not (L.RP.contains indexedProperKTermDNFConsistencyDecisionProblem) := by
  intro hTargetRP
  apply hRPNeNP
  constructor
  · exact L.RP_subset_NP
  · intro A hANP
    have hAtoIndexed :
        ManyOneReduction A indexedGraphColoringDecisionProblem :=
      Classical.choice (hIndexedHard A hANP)
    have hAtoTarget :
        ManyOneReduction A indexedProperKTermDNFConsistencyDecisionProblem :=
      ManyOneReduction.comp hAtoIndexed
        indexedGraphColoringToIndexedProperKTermDNFConsistency
    exact hRPClosed A indexedProperKTermDNFConsistencyDecisionProblem
      hAtoTarget hTargetRP

/--
Encoded conditional lower bound: if indexed graph coloring is NP-hard in an
encoded landscape and the graph-to-DNF map has a concrete encoded
polynomial-time implementation, then indexed proper fixed-`k` DNF consistency
is not in encoded `RP` under `RP != NP`.
-/
theorem encodedIndexedProperKTermDNFConsistency_not_in_RP_of_encodedIndexedGraphColoring_hard
    (L : EncodedComplexityLandscape Bool)
    (hIndexedHard :
      L.NPHard encodedIndexedGraphColoringDecisionProblem)
    (red :
      EncodedManyOneReduction
        encodedIndexedGraphColoringDecisionProblem
        encodedIndexedProperKTermDNFConsistencyDecisionProblem)
    (hRedMono : Monotone red.polytime.time_bound)
    (hRPNeNP : L.RPNeNP) :
    Not (L.RP.contains
      encodedIndexedProperKTermDNFConsistencyDecisionProblem) := by
  intro hTargetRP
  apply hRPNeNP
  constructor
  · exact L.RP_subset_NP
  · intro A hANP
    have hAtoIndexed :
        EncodedManyOneReduction A
          encodedIndexedGraphColoringDecisionProblem :=
      Classical.choice (hIndexedHard A hANP)
    have hAtoTarget :
        EncodedManyOneReduction A
          encodedIndexedProperKTermDNFConsistencyDecisionProblem :=
      EncodedManyOneReduction.comp hAtoIndexed red hRedMono
    exact L.RP_closed_under_many_one A
      encodedIndexedProperKTermDNFConsistencyDecisionProblem
      hAtoTarget hTargetRP

/--
Retimed version of the encoded conditional lower bound. The reduction only
needs a CSLib polynomial-time implementation; composition retimes the machines
to monotone polynomial bounds internally.
-/
theorem encodedIndexedProperKTermDNFConsistency_not_in_RP_of_encodedIndexedGraphColoring_hard_retimed
    (L : EncodedComplexityLandscape Bool)
    (hIndexedHard :
      L.NPHard encodedIndexedGraphColoringDecisionProblem)
    (red :
      EncodedManyOneReduction
        encodedIndexedGraphColoringDecisionProblem
        encodedIndexedProperKTermDNFConsistencyDecisionProblem)
    (hRPNeNP : L.RPNeNP) :
    Not (L.RP.contains
      encodedIndexedProperKTermDNFConsistencyDecisionProblem) := by
  intro hTargetRP
  apply hRPNeNP
  constructor
  · exact L.RP_subset_NP
  · intro A hANP
    have hAtoIndexed :
        EncodedManyOneReduction A
          encodedIndexedGraphColoringDecisionProblem :=
      Classical.choice (hIndexedHard A hANP)
    have hAtoTarget :
        EncodedManyOneReduction A
          encodedIndexedProperKTermDNFConsistencyDecisionProblem :=
      EncodedManyOneReduction.compRetimed hAtoIndexed red
    exact L.RP_closed_under_many_one A
      encodedIndexedProperKTermDNFConsistencyDecisionProblem
      hAtoTarget hTargetRP

/--
Monotone-reduction variant of the encoded conditional lower bound. The
monotonicity proof is carried by the reduction package itself.
-/
theorem encodedIndexedProperKTermDNFConsistency_not_in_RP_of_encodedIndexedGraphColoring_hard_monotone
    (L : EncodedComplexityLandscape Bool)
    (hIndexedHard :
      L.NPHard encodedIndexedGraphColoringDecisionProblem)
    (red :
      MonotoneEncodedManyOneReduction
        encodedIndexedGraphColoringDecisionProblem
        encodedIndexedProperKTermDNFConsistencyDecisionProblem)
    (hRPNeNP : L.RPNeNP) :
    Not (L.RP.contains
      encodedIndexedProperKTermDNFConsistencyDecisionProblem) :=
  encodedIndexedProperKTermDNFConsistency_not_in_RP_of_encodedIndexedGraphColoring_hard
    L hIndexedHard red.toEncodedManyOneReduction red.polytime_mono hRPNeNP

end Reductions
end LearningTheory
