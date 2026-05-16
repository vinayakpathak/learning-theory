## Accepted Progress
The edge remains open. Iteration 9 added three scoped refinements: log-arity signed XOR is a failed approximation-gap candidate, DCHP is now decomposed into realized calls / clean-population transfer / final selection, and rare-slice generated-bag pollution remains only a black-box selector warning.

## Candidate Routes
Best positive route: `HiddenCleanTranscriptGenerator + PolynomialFinalSelector/ListGenerator`, now sharpened into the three DCHP layers.

Best conditional negative route: approximation-gap separation, but only with an independent low-noise signed approximator and hard-band improper prediction hardness.

## Refuted Or Weakened Claims
Log-arity signed XOR does not instantiate the separation: fixed-slack weak learning at `eta < gamma` already gives sparse-parity prediction.

Realized-call accounting does not prove DCHP works; it leaves clean-population transfer and sparse-majority optimization open.

Rare-slice programming does not prove literal DCHP-generated Set-Cover hardness.

## Working Notes Updated
Updated all requested run-local notes under `working_notes/`: `canonical_summary.md`, `claim_ledger.md`, `lemma_bank.md`, `failed_attempts.md`, `counterexamples.md`, `literature_map.md`, `promising_directions.md`, `bibliography.md`, and `iteration_summaries.md`.

I also checked the new sparse-XOR bibliography entries against DBLP and arXiv: [Bogdanov-Sabin-Vasudevan 2019](https://dblp.org/rec/conf/soda/BogdanovSV19), [Mao 2026](https://arxiv.org/abs/2604.10457). No atlas validation was run because only `working_notes/` changed.

## Next Iteration Focus
Formalize the three-layer DCHP conditional theorem with exact quantifiers. Then search for a non-parity approximation-gap candidate with a real low-noise signed approximator. In parallel, prove the restricted query-light generated-bag theorem and test the spike-tuple/mass-tension obstruction against literal DCHP.