import LearningTheory.Complexity.BitComplexity
import LearningTheory.Complexity.GraphColoringEncoding
import LearningTheory.Learning.IndexedDNFConsistency

namespace LearningTheory
namespace Complexity

open Polynomial
open LearningTheory.Learning
open LearningTheory.Learning.BooleanClasses

/-- Polynomial matching the indexed graph-coloring certificate-length bound. -/
noncomputable def indexedGraphColoringCertificateBoundPoly :
    Polynomial Nat :=
  X * ((X * ((X + 1) + 1) + 1) + 1) + 1

/-- The graph-coloring certificate-bound polynomial evaluates to the concrete bound. -/
theorem indexedGraphColoringCertificateBoundPoly_eval
    (n : Nat) :
    indexedGraphColoringCertificateBoundPoly.eval n =
      IndexedGraphColoringInstance.certificateLengthBound n := by
  simp [indexedGraphColoringCertificateBoundPoly,
    IndexedGraphColoringInstance.certificateLengthBound]

/--
Conditional concrete NP verifier for indexed graph coloring.

The mathematical verifier, certificate bound, soundness, and completeness are
proved. The remaining input is the CSLib polynomial-time proof for the combined
bit-string verifier.
-/
noncomputable def indexedGraphColoringNPVerifierOfPolytime
    (hPolytime :
      Turing.SingleTapeTM.PolyTimeComputable
        (fun w =>
          BitComplexity.boolOutput
            (IndexedGraphColoringInstance.verifyCertificateString w))) :
    BitComplexity.NPVerifier encodedIndexedGraphColoringDecisionProblem where
  verify := IndexedGraphColoringInstance.verifyCertificateString
  polytime := hPolytime
  certBound := IndexedGraphColoringInstance.certificateLengthBound
  certPoly := indexedGraphColoringCertificateBoundPoly
  certBound_poly := by
    intro n
    rw [indexedGraphColoringCertificateBoundPoly_eval]
  sound := by
    intro G certBits _ hVerify
    exact indexedGraphColoring_verifyCertificateString_sound
      G certBits hVerify
  complete := by
    intro G hAccept
    exact indexedGraphColoring_exists_bounded_certificateString
      G hAccept

/-- Polynomial matching the indexed DNF-consistency certificate-length bound. -/
noncomputable def indexedDNFConsistencyCertificateBoundPoly :
    Polynomial Nat :=
  X * ((((X * 2) * ((X + 2) + 1) + 1)) + 1) + 1

/-- The DNF-consistency certificate-bound polynomial evaluates to the concrete bound. -/
theorem indexedDNFConsistencyCertificateBoundPoly_eval
    (n : Nat) :
    indexedDNFConsistencyCertificateBoundPoly.eval n =
      IndexedKTermDNFConsistencyInput.certificateLengthBound n := by
  simp [indexedDNFConsistencyCertificateBoundPoly,
    IndexedKTermDNFConsistencyInput.certificateLengthBound]

/--
Conditional concrete NP verifier for indexed fixed-`k` DNF consistency.

The mathematical verifier, certificate bound, soundness, and completeness are
proved. The remaining input is the CSLib polynomial-time proof for the combined
bit-string verifier.
-/
noncomputable def indexedProperKTermDNFConsistencyNPVerifierOfPolytime
    (hPolytime :
      Turing.SingleTapeTM.PolyTimeComputable
        (fun w =>
          BitComplexity.boolOutput
            (IndexedKTermDNFConsistencyInput.verifyCertificateString w))) :
    BitComplexity.NPVerifier
      encodedIndexedProperKTermDNFConsistencyDecisionProblem where
  verify := IndexedKTermDNFConsistencyInput.verifyCertificateString
  polytime := hPolytime
  certBound := IndexedKTermDNFConsistencyInput.certificateLengthBound
  certPoly := indexedDNFConsistencyCertificateBoundPoly
  certBound_poly := by
    intro n
    rw [indexedDNFConsistencyCertificateBoundPoly_eval]
  sound := by
    intro I certBits _ hVerify
    exact indexedProperKTermDNFConsistency_verifyCertificateString_sound
      I certBits hVerify
  complete := by
    intro I hAccept
    exact indexedProperKTermDNFConsistency_exists_bounded_certificateString
      I hAccept

end Complexity
end LearningTheory
