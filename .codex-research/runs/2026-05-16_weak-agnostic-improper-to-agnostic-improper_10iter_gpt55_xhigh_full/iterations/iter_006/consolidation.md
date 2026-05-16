## Accepted Progress

The edge remains open. Iteration 6 contributed:

- approximation-gap lemma: an `a`-approximate improper agnostic learner gives fixed-slack weak learning for `beta > (a-1)/(2a)`;
- exact DCHP selector audit: final class is `sign(B^(T))`, a zero-threshold nonnegative integer `T`-wise majority, and the paper still uses exhaustive ERM;
- public randomized-kernel envelope: valid as a restricted fixed-comparator/public-view obstruction;
- CSP weak-side formulation for signed/weighted assignment-induced classes.

## Candidate Routes

Best positive route remains `HiddenCleanTranscriptGenerator + PolynomialFinalSelector/ListGenerator`, now sharpened to an `ApproxSparseMajorityERM(B,T)` primitive for the exact DCHP class.

Best conditional negative route is approximation-gap separation, but it needs a concrete succinct-domain class with both signed/weighted weak approximation and hard `OPT+epsilon` improper prediction.

## Refuted Or Weakened Claims

Ordinary fixed-arity CSP gaps are not viable improper separations: public-label encodings are trivial, RHS-exposed encodings are readable, and polynomial constraint domains are table-learnable.

The residual-kernel lemma is not a general `OPT_C` lower bound; full-`X` measurability, public witnesses, spikes, and other concepts must be routed separately.

The DCHP hidden-clean margin does not justify noisy-label convex surrogate selection.

## Working Notes Updated

Updated `working_notes/canonical_summary.md`, `claim_ledger.md`, `lemma_bank.md`, `failed_attempts.md`, `counterexamples.md`, `literature_map.md`, `promising_directions.md`, `bibliography.md`, and `iteration_summaries.md`.

I read all 23 files under `iterations/iter_006`. I also checked heading continuity and trailing whitespace. No atlas validation was run because no `atlas/` files were edited.

## Next Iteration Focus

Formalize `ApproxSparseMajorityERM(B,T,xi,delta)`, then test one concrete succinct signed-CSP/refutation candidate against both sides of the approximation-gap checklist. For the residual route, build the stopped-process model in a random-hidden-target setting so conditioning on full `X` is handled correctly.