## Accepted Progress
The edge remains open. I consolidated three iteration 7 advances: Set-Cover hardness for generic exact DCHP sparse-majority ERM over arbitrary bags, rare-slice junk showing no free `Range(A)`/dual-VC control from weak correctness alone, and the hard-band correction for CSP/refutation candidates.

## Candidate Routes
The positive route remains `HiddenCleanTranscriptGenerator + PolynomialFinalSelector/ListGenerator`, but a universal `ApproxSparseMajorityERM(B,T)` is now treated as unavailable in worst case.

The conditional negative route remains approximation-gap separation, now requiring a hard-band `eta >= gamma` improper prediction/refutation assumption plus an independent low-noise signed weak approximator.

## Refuted Or Weakened Claims
Generic sparse-majority ERM is not a free primitive. Free regularization of an arbitrary supplied weak learner is unsupported. Off-the-shelf succinct signed-CSP/refutation candidates did not pass the checklist, especially low-noise refutation hardness below `gamma`.

## Working Notes Updated
Updated `canonical_summary.md`, `claim_ledger.md`, `lemma_bank.md`, `failed_attempts.md`, `counterexamples.md`, `literature_map.md`, `promising_directions.md`, `bibliography.md`, and `iteration_summaries.md`.

I read all 23 files under `iterations/iter_007`. No atlas validation was run because only `working_notes/` files changed.

## Next Iteration Focus
Formalize the sparse-majority Set-Cover lemma with exact selector assumptions and gap parameters. Then audit whether DCHP bags can include constants or realize arbitrary hardness matrices. In parallel, define a precise hard-band RRHS/RCN assumption for a candidate succinct signed class.