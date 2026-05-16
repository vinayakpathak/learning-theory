# Iteration Summaries

## Iteration 1

No solution to the atlas edge was found. Accepted progress consists of elementary reductions and sharper bottlenecks:

- fixed `OPT + beta` learning is an additive best-correlation approximation;
- the hard band `gamma <= OPT_C <= 1/2-epsilon` is where the source may be silent;
- clean-conditional learning of a near-optimal comparator suffices for agnostic excess;
- da Cunha-style residual-free boosting is the closest known positive route, but current generic runtimes are not representation-uniform polynomial.

The strongest candidate positive direction is a polynomial clean-witness menu theorem, with random clean witnesses and enumerable compression witnesses as possible sufficient conditions. The strongest negative direction is a restricted black-box oracle barrier, but it must handle point-mass queries, empirical queries, artificial relabeling, adaptivity, and information leakage.


# Iteration 1 Consolidation

## Accepted Progress

The edge remains open. I consolidated the accepted pieces: fixed `OPT + beta` equals additive best-correlation approximation; the hard band is `gamma <= OPT_C <= 1/2 - epsilon`; and the clean-conditional lemma gives a real reduction from agnostic learning to finding a hypothesis good on `D_c^+`.

The da Cunha-style residual-free boosting route is recorded as the strongest near miss: semantically compatible with fixed slack, but not representation-uniform polynomial with the known generic runtime.

## Candidate Routes

The main positive route is now a polynomial clean-witness menu theorem. Two possible sufficient mechanisms are recorded: random clean witnesses with total witness size `K = O(log poly(s,1/epsilon))`, and enumerable compression witnesses with controlled final selection.

The main negative route is a restricted black-box oracle barrier, explicitly not an atlas separation yet.

## Refuted Or Weakened Claims

I recorded the corrected da Cunha parameter translation. The claim "`epsilon_0 >= 2 beta` works for all `gamma_0 <= 1`" is false unless `rho >= 0` is assumed or `gamma_0=1`.

I also recorded that ordinary sample compression, small weak-call sample size, and unrestricted hidden-set oracle lower bounds do not suffice as stated.

## Working Notes Updated

Updated under `working_notes/`:

- [canonical_summary.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/canonical_summary.md:1)
- [claim_ledger.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/claim_ledger.md:1)
- [lemma_bank.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/lemma_bank.md:1)
- [failed_attempts.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/failed_attempts.md:1)
- [counterexamples.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/counterexamples.md:1)
- [literature_map.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/literature_map.md:1)
- [promising_directions.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/promising_directions.md:1)
- [bibliography.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/bibliography.md:1)
- [iteration_summaries.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/iteration_summaries.md:1)

## Next Iteration Focus

Formalize the clean-witness menu theorem first, then audit da Cunha 2025/2026 at algorithm level to isolate the exact exponential step. In parallel, define the restricted oracle-barrier model precisely enough that point-mass, empirical, artificial-label, and adaptive leakage issues are not swept under the rug.

## Iteration 2 Consolidation

## Accepted Progress

The edge remains open. Accepted new progress consists of sharper local obstructions and one clean restricted identity:

- excess over a comparator does not force high-loss or mistake residuals to have comparator error below `gamma`;
- in RCN, aggregate agreement filtering crosses below `gamma` only after correlation exceeds `(eta-gamma)/(eta+gamma-2 eta gamma)`, and mistake filtering is worse for nonnegative correlation;
- the soft public-filter identity exactly characterizes when a target-preserving filter lowers RCN noise below `gamma`;
- the da Cunha 2026 audit identifies the concrete tuple-enumeration, final-vote-search, and output-range-capacity assumptions blocking an atlas proof.

## Candidate Routes

The best positive route is now a precise conditional da Cunha theorem with controlled `H=Range(A)`, bounded or de-enumerated `m0`, safe dual VC, and a polynomial final selector. The best negative route is a restricted public-filter information barrier using the soft-filter identity plus a transcript information budget.

## Refuted Or Weakened Claims

The broad claim that global below-threshold `E[Zf]` rules out all one-sample observable RCN filters is refuted by sign-specific cells. The public-filter barrier is also weakened: low noise relative to planted `f` is not the same as low `OPT_C`, because public constants, public relabelings, and other concepts may certify low `OPT` without revealing `f`.

Directly instantiating the 2026 da Cunha theorem from the atlas source is still invalid without extra capacity and uniformity assumptions.

## Working Notes Updated

Updated the canonical summary, claim ledger, lemma bank, failed attempts, counterexamples, literature map, promising directions, bibliography, and this iteration summary.

## Next Iteration Focus

First, write the conditional da Cunha theorem with all parameters explicit, including the interior endpoint repair. Second, formalize the public-filter information lemma with the corrected KL transfer and an oracle-output leakage budget. Third, define a taxonomy of low-`OPT` queries so public-witness and empirical/spike loopholes are handled explicitly.


# Iteration 2 Consolidation

## Accepted Progress
The edge remains open. I consolidated iteration 2’s accepted progress: residual forcing from excess alone fails for high-loss/mistake filters; RCN agreement filtering has the correlation threshold; the soft public-filter identity is a clean restricted lemma; and the da Cunha 2026 route is a near miss with explicit capacity/runtime bottlenecks.

## Candidate Routes
The best positive route is now a conditional da Cunha theorem with controlled `Range(A)`, `m0`, VC/dual-VC, endpoint repair, and final vote selection.

The best negative route is a restricted public-filter information barrier with smoothness, mass, query taxonomy, and oracle-output leakage made explicit.

## Refuted Or Weakened Claims
I recorded the global-`r` one-sample RCN no-go as refuted by sign-specific cells. I also weakened the public-filter barrier: low noise relative to planted `f` is not the same as low `OPT_C`, because public constants/relabelings or other concepts can certify low `OPT`.

Directly invoking da Cunha 2026 from the atlas source remains invalid without extra uniformity and capacity assumptions.

## Working Notes Updated
Updated under `working_notes/` only:

- [canonical_summary.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/canonical_summary.md:1)
- [claim_ledger.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/claim_ledger.md:120)
- [lemma_bank.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/lemma_bank.md:90)
- [failed_attempts.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/failed_attempts.md:57)
- [counterexamples.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/counterexamples.md:45)
- [literature_map.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/literature_map.md:28)
- [promising_directions.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/promising_directions.md:52)
- [bibliography.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/bibliography.md:9)
- [iteration_summaries.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/iteration_summaries.md:52)

No atlas validation was run because no `atlas/` source files were edited.

## Next Iteration Focus
Write the conditional da Cunha theorem with all parameters explicit. Then formalize the public-filter information lemma with the corrected KL transfer and an oracle-output leakage budget. Finally, define the low-`OPT` query taxonomy so public-witness, empirical/spike, and other-concept loopholes are handled explicitly.

## Iteration 3 Consolidation

## Accepted Progress
The edge remains open. Iteration 3 sharpened three reusable pieces:

- finite-list validation is sound for validation-independent polynomial lists of complete final classifiers, and it avoids global `Range(A)` capacity only at the final selection step;
- a global clean-transcript menu lemma gives the right accounting: raw discovery costs roughly `p^{-K}q^{-1}` times advice/search cost, so total witness length `K`, not per-call sample size, is the bottleneck;
- the adaptive smooth public-filter information lemma is now a clean random-target toy theorem using fixed-filter Hoeffding plus binary-event KL transfer.

## Candidate Routes
The best positive route is a conditional theorem with two explicit primitives: a polynomial hidden-clean transcript generator and a polynomial final selector/list generator. The da Cunha weak-condition translation should use the L009 interior repair unless the `gamma0=1` endpoint is audited.

The best negative route is a stopped-process public-filter oracle model with full output-leakage accounting and a formal low-`OPT` routing lemma.

## Refuted Or Weakened Claims
Finite bag size alone does not imply clean-slice population accuracy; a singleton bag can memorize the hidden clean sample. A polynomial base bag plus all `T`-wise votes is not computationally polynomial when `T` grows.

The hidden-mask `Lp^K` anti-hitting bound is only a restricted proof-skeleton obstruction. It does not rule out repeated-sample denoising, posterior-biased filtering, class structure, implicit optimization, or final classifiers that avoid literal all-clean transcripts.

The public-filter information theorem controls hidden-target noise, not `OPT_C` in general. Public witnesses, empirical/spike queries, arbitrary relabelings, other concepts, and oracle handle leakage remain separate cases.

## Working Notes Updated
Updated the canonical summary, claim ledger, lemma bank, failed attempts, counterexamples, literature map, promising directions, bibliography, and this iteration summary.

## Next Iteration Focus
Write the formal conditional clean-transcript theorem with exact `p,K,q`, advice/randomness, near-endpoint, and validation constants. In parallel, audit the da Cunha proof to identify the true total hidden-clean witness length and which `VC(H)` uses are final-validation artifacts versus clean-population necessities. For the barrier route, define the stopped transcript/oracle-output model before trying to prove a lower bound.


# Iteration 3 Consolidation

## Accepted Progress

The atlas edge remains open. I consolidated finite-list validation, realized adaptive weak-call union bounds, the global clean-transcript menu lemma, the restricted hidden-mask anti-hitting lemma, and the adaptive smooth public-filter information theorem.

## Candidate Routes

Best positive route: a conditional theorem with `HiddenCleanTranscriptGenerator` plus `PolynomialFinalSelector/ListGenerator`.

Best negative route: a stopped-process public-filter oracle model with explicit output-leakage accounting and low-`OPT` query routing.

## Refuted Or Weakened Claims

Finite bag size alone does not prove clean-slice population accuracy. Per-call logarithmic witnesses do not de-enumerate full transcripts if total `K=m0T` is superlogarithmic. The public-filter theorem controls hidden-target noise, not `OPT_C` in general.

## Working Notes Updated

Updated `canonical_summary.md`, `claim_ledger.md`, `lemma_bank.md`, `failed_attempts.md`, `counterexamples.md`, `literature_map.md`, `promising_directions.md`, `bibliography.md`, and `iteration_summaries.md`.

No atlas validation was run because only `working_notes/` files changed.

## Next Iteration Focus

Write the exact clean-transcript theorem with `p,K,q`, advice/randomness, near-endpoint, and validation constants. Then audit da Cunha 2026 for the true total hidden-clean witness length and which VC uses are final-validation artifacts versus clean-population necessities.

## Iteration 4 Consolidation

## Accepted Progress

The atlas edge remains open. Iteration 4 added four reusable pieces:

- a public-posterior obstruction: if all public cells have comparator-error posterior `eta>gamma`, public filtering/relabeling cannot force a low-noise weak query;
- an information-charged hidden-certificate anti-hitting lemma, refining `Lp^K` by KL transfer through `I(S;T)`;
- a conditional vote-selector lemma separating hidden-clean bag generation from final threshold-vote optimization;
- a finite-domain table-learning obstruction showing explicit polynomial block-code hardness cannot separate improper agnostic PAC learning.

## Candidate Routes

Best positive route: `HiddenCleanTranscriptGenerator` plus `PolynomialFinalSelector/ListGenerator`, now with the selector treated as a genuine extra primitive. For unrestricted weighted votes this is agnostic halfspace selection over generated features; restricted vote classes need their own formulation.

Best negative route: a restricted hidden-mask or public-filter stopped-process model with explicit information budgets for clean masks, targets, oracle handles, and public certificates.

Best separation template: succinct-domain RCN prediction hardness with efficient distribution-free weighted/soft low-noise weak learning. Classical nearest-codeword hardness is not the right target.

## Refuted Or Weakened Claims

Clean-transcript anti-hitting is not a general necessity theorem; it assumes explicit all-clean certificates and controlled mask information. Implicit vote selection is not a free optimization step supplied by the weak learner. Classical decoding hardness for deterministic received words or polynomial blocklength codes does not imply improper PAC hardness.

## Working Notes Updated

Updated `canonical_summary.md`, `claim_ledger.md`, `lemma_bank.md`, `failed_attempts.md`, `counterexamples.md`, `literature_map.md`, `promising_directions.md`, `bibliography.md`, and `iteration_summaries.md`.

No atlas validation was run because only `working_notes/` files changed.

## Next Iteration Focus

First, formalize `ExplicitCleanTranscriptWrapper` with certificate weights, distinct clean positions, validation independence, and an `I(S;T)` or `I((F,S);T)` budget. Second, extract the exact da Cunha final vote class before assuming any selector. Third, test one succinct-code candidate against the stricter checklist: weighted/soft weak learning, no polynomial list-validation escape, and direct improper RCN prediction hardness.


# Iteration 4 Consolidation

## Accepted Progress

The edge remains open. I consolidated iteration 4’s accepted pieces: public-posterior filtering obstruction, information-charged clean-certificate anti-hitting, conditional final vote selector lemma, finite-domain improper table-learning obstruction, and the sharpened coding-route mismatch.

## Candidate Routes

Best positive route remains: `HiddenCleanTranscriptGenerator + PolynomialFinalSelector/ListGenerator`.

Best negative route: a restricted stopped-process hidden-mask/public-filter model with explicit information budgets.

Best separation route: succinct-domain RCN prediction hardness plus efficient distribution-free weighted/soft low-noise weak learning.

## Refuted Or Weakened Claims

Clean-transcript anti-hitting is not a general necessity theorem. Implicit vote selection is not a free optimization primitive. Classical nearest-codeword or ML-decoding hardness does not give an improper PAC separation, especially on polynomial coordinate domains.

## Working Notes Updated

Updated only `working_notes/`:

- [canonical_summary.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/canonical_summary.md)
- [claim_ledger.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/claim_ledger.md)
- [lemma_bank.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/lemma_bank.md)
- [failed_attempts.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/failed_attempts.md)
- [counterexamples.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/counterexamples.md)
- [literature_map.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/literature_map.md)
- [promising_directions.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/promising_directions.md)
- [bibliography.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/bibliography.md)
- [iteration_summaries.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/iteration_summaries.md)

I checked numbering/trailing whitespace. No atlas validation was run because no `atlas/` files changed.

## Next Iteration Focus

Formalize `ExplicitCleanTranscriptWrapper` with certificate weights and an `I(S;T)` or `I((F,S);T)` budget. Extract the exact da Cunha final vote class before assuming a selector. Test one succinct-code candidate against the stricter weighted/soft weak-learning and improper RCN prediction checklist.

## Iteration 5 Consolidation

## Accepted Progress

The edge remains open. Iteration 5 added three restricted but useful obstructions:

- one-step public residual forcing is exactly a public-posterior lower-tail problem: public filters and sign relabelings can only exploit cells where `min(eta_G,1-eta_G)` is small;
- direct anchor doping cannot refine a fixed-additive oracle at epsilon scale without strong separation of the full legal bad-output set;
- hard-core/CVaR duality over public filters does not create a low-OPT chunk from excess alone.

The per-example information bound `I(S_c;G) >= mu kl(gamma'||eta)` was also recorded as a diagnostic for public low-noise chunks.

## Candidate Routes

Best positive route remains `HiddenCleanTranscriptGenerator + PolynomialFinalSelector/ListGenerator`.

Best negative route is a stopped-process public-posterior/public-filter model with explicit routing for public witnesses, empirical/spike queries, other concepts, and oracle-output leakage.

Additional candidate: search for approximation-gap classes where constant-factor agnostic approximation gives fixed-slack weak learning but `OPT+epsilon` improper learning remains hard.

## Refuted Or Weakened Claims

Positive excess over a comparator does not imply any one-step public residual query with comparator error below `gamma`.

Anchor-doping finite differences fail in the small-mixture regime because the public anchor is a legal improper answer for `lambda <= beta`; the proper cap-separation criterion is not enough for the atlas-improper source.

Hard-core analogies are only motivational unless they produce a public posterior tail and a usable boosting update.

## Working Notes Updated

Updated `canonical_summary.md`, `claim_ledger.md`, `lemma_bank.md`, `failed_attempts.md`, `counterexamples.md`, `literature_map.md`, `promising_directions.md`, `bibliography.md`, and `iteration_summaries.md`.

No atlas validation was run because only `working_notes/` files changed.

## Next Iteration Focus

First, formalize the sigma-field public residual lemma and the CVaR lower-tail lemma cleanly enough for future citation. Second, pursue a stopped-process barrier that charges the first low-posterior public chunk. Third, either extract the exact da Cunha vote class or test an approximation-gap candidate against the improper-hardness checklist.


# Iteration 5 Consolidation

## Accepted Progress
The edge remains open. Iteration 5 adds restricted but useful obstructions: public residual forcing is a posterior-tail problem, anchor doping cannot beat fixed additive slack without strong legal-output separation, and hard-core/CVaR duality does not create low-OPT chunks from excess alone.

## Candidate Routes
Best positive route remains `HiddenCleanTranscriptGenerator + PolynomialFinalSelector/ListGenerator`.

Best negative route is a stopped-process public-posterior/public-filter model with explicit accounting for public witnesses, empirical/spike queries, other concepts, and oracle-output leakage.

## Refuted Or Weakened Claims
Positive excess over a comparator does not imply a one-step public residual query below `gamma`.

Anchor-doping finite differences fail for `lambda <= beta`, because the public anchor is a legal improper weak answer.

Hard-core analogies remain motivational unless they produce a public posterior tail and a usable update rule.

## Working Notes Updated
Updated `working_notes/canonical_summary.md`, `claim_ledger.md`, `lemma_bank.md`, `failed_attempts.md`, `counterexamples.md`, `literature_map.md`, `promising_directions.md`, `bibliography.md`, and `iteration_summaries.md`.

I also checked heading/numbering continuity and trailing whitespace. No atlas validation was run because no `atlas/` files changed.

## Next Iteration Focus
Formalize the sigma-field public residual lemma and CVaR lower-tail lemma cleanly. Then pursue a stopped-process barrier charging the first low-posterior public chunk, while separately extracting the exact da Cunha vote class or testing an approximation-gap candidate against the improper-hardness checklist.

## Iteration 6 Consolidation

## Accepted Progress
The edge remains open. Iteration 6 adds four durable pieces: the approximation-gap-to-fixed-slack lemma, the signed-CSP weak-side formulation, the public randomized-kernel posterior envelope, and the exact DCHP sparse-majority selector audit.

An `a`-approximate improper agnostic learner with tunable additive error gives fixed-slack weak learning for every `beta>(a-1)/(2a)`, after adding constants and validation. The exact DCHP final class is `sign(B^(T))`, a zero-threshold nonnegative integer `T`-wise majority; the known algorithm uses exhaustive ERM over this class.

## Candidate Routes
Best positive route remains `HiddenCleanTranscriptGenerator + PolynomialFinalSelector/ListGenerator`, now with the final selector sharpened to `ApproxSparseMajorityERM(B,T)` for the exact DCHP class.

Best negative route remains a stopped-process public-posterior/public-filter model, now using the randomized-kernel envelope and carefully separating coarse public views from full-instance random-target models.

The approximation-gap route is a live conditional separation template, but it needs a class with efficient signed/weighted weak approximation and hard `OPT+epsilon` improper prediction.

## Refuted Or Weakened Claims
Ordinary fixed-arity CSP approximation gaps do not survive improper learning: public-label encodings are trivial, RHS-exposed encodings are readable, and polynomial constraint domains are table-learnable.

The residual-kernel lemma is not a general `OPT_C` lower bound. It controls one comparator relative to a chosen public view; full `X` measurability, public witnesses, empirical spikes, and other concepts must be routed separately.

The DCHP hidden-clean margin does not justify noisy-label convex surrogate selection, and generic halfspace-hardness warnings do not yet prove hardness for the exact bounded nonnegative `T`-majority class.

## Working Notes Updated
Updated `working_notes/canonical_summary.md`, `claim_ledger.md`, `lemma_bank.md`, `failed_attempts.md`, `counterexamples.md`, `literature_map.md`, `promising_directions.md`, `bibliography.md`, and `iteration_summaries.md`.

## Next Iteration Focus
First, formalize `ApproxSparseMajorityERM(B,T,xi,delta)` with empirical-risk and finite-list/VC generalization guarantees. Second, test one concrete succinct signed-CSP/refutation candidate against both sides of the approximation-gap checklist. Third, build the stopped-process residual barrier in a random-hidden-target model so conditioning on full `X` is handled correctly.


# Iteration 6 Consolidation

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

## Iteration 7 Consolidation

## Accepted Progress

The edge remains open. Iteration 7 adds three durable pieces:

- exact sparse-majority selector hardness: worst-case proper ERM over arbitrary DCHP-style `sign(B^(T))` bags is Set-Cover hard, NP-hard, and W[2]-hard in `T`; inverse-polynomial additive empirical ERM is also enough to decide zero-error instances;
- no-free-range-control: rare-slice junk weak learners show that semantic `OPT+beta` correctness alone does not bound full `Range(A)` or dual VC for a supplied learner;
- signed-CSP hard-band correction: refutation hardness below the weak threshold `gamma` conflicts with the assumed weak learner, because weak learning plus fresh validation already refutes planted labels with `OPT<gamma`.

The signed approximation algebra was also sharpened: multiplicative agreement `alpha` gives slack at most `1-alpha`; for a prescribed `beta`, require `alpha >= 1-beta` in the worst case.

## Candidate Routes

Best positive route remains `HiddenCleanTranscriptGenerator + PolynomialFinalSelector/ListGenerator`, but a universal worst-case `ApproxSparseMajorityERM(B,T)` should now be treated as unavailable. Future selector work must exploit generated-bag structure, constants/complements restrictions, no-constant variants, margins, surrogates with calibration, or explicit polynomial final lists.

Best negative/conditional route remains the approximation-gap template. The CSP/refutation version now needs an explicit hard-band RRHS/RCN improper prediction assumption at `eta in [gamma,1/2)`, plus an independently supplied low-noise signed/weighted weak approximator.

The regularization route remains open only in refined forms: realized-bag analyses, high-probability ranges, distribution-dependent quotients, or white-box/class-aware canonical weak learners. Full semantic range control is not free.

## Refuted Or Weakened Claims

Generic exact sparse-majority ERM over arbitrary bags is not a reasonable unconditional primitive. The hardness is scoped and does not apply automatically to DCHP-generated or margin-promised bags.

The rare-slice construction refutes free `Range(A)`/dual-VC control but not the atlas implication, not class-aware regularization, and not compression or stability without separate definitions.

No off-the-shelf succinct signed-CSP/refutation candidate passed the checklist. Low-noise refutation hardness, all-positive labels, public RHS encodings, fixed-arity explicit domains, and log-arity XOR all fail for different reasons.

## Working Notes Updated

Updated `working_notes/canonical_summary.md`, `claim_ledger.md`, `lemma_bank.md`, `failed_attempts.md`, `counterexamples.md`, `literature_map.md`, `promising_directions.md`, `bibliography.md`, and `iteration_summaries.md`.

I read all 23 files under `iterations/iter_007`. No atlas validation was run because no `atlas/` files were edited.

## Next Iteration Focus

First, formalize the sparse-majority Set-Cover lemma with exact input model, proper selector assumption, odd/even `T` variants, and inverse-polynomial additive gap. Second, audit whether DCHP can append constants or whether generated bags can realize arbitrary selector-hardness matrices. Third, define a hard-band RRHS/RCN assumption for a candidate succinct signed class and search only for candidates with an independently available low-noise signed weak approximator.


# Iteration 7 Consolidation

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

## Iteration 8 Consolidation

## Accepted Progress
The fixed-constant atlas edge remains open. Iteration 8 adds three scoped pieces:

- parities give a credible conditional near-separation only for size-dependent weak slack `gamma_n=O(log n/n)`, using all-clean `Theta(n)` batches and span capture over the clean conditional marginal;
- public parity amplification is blocked whenever the amplified class retains an efficiently sampleable/evaluable parity slice, since fixed-slack weak learning on that slice gives constant-correlation noisy-parity prediction below the weak threshold;
- rare-slice programming can make semantically valid weak learners hide arbitrary selector columns on query-small key slices, showing that generated bags are not automatically benign in black-box models.

## Candidate Routes
Best positive route remains `HiddenCleanTranscriptGenerator + PolynomialFinalSelector/ListGenerator`.

Best negative route remains hard-band approximation/prediction hardness, but parity now serves mainly as a boundary warning: it supplies LPN hardness intuition, not a constant-slack weak source.

Best selector-obstruction route is now a generated-bag pollution audit: formalize rare-slice programming for a standalone generated-bag selector, then separately test whether actual DCHP calls, constants, extra columns, iid sampling, and `T` alignment permit the construction.

## Refuted Or Weakened Claims
Parity/LPN does not separate the current fixed-constant edge. The weak learner only works when `n gamma=O(log n)`; for constant `gamma`, the weak side is already constant-noise parity learning.

Direct parity amplification by public products, mixtures, or padding is refuted when an efficient parity slice remains. This is not a theorem against genuinely non-sliceable classes.

Rare-slice generated-bag programming does not prove literal DCHP-generated Set-Cover hardness. It is currently a black-box selector obstruction with missing DCHP compatibility and population-relevance assumptions.

## Working Notes Updated
Updated `canonical_summary.md`, `claim_ledger.md`, `lemma_bank.md`, `failed_attempts.md`, `counterexamples.md`, `literature_map.md`, `promising_directions.md`, `bibliography.md`, and `iteration_summaries.md`.

I read all 23 Markdown reports/critics under `iterations/iter_008` plus the iteration ideas JSON. No atlas validation was run because only `working_notes/` files changed.

## Next Iteration Focus
First, formalize the shrinking-gap parity theorem only as a separate warning note, with exact constants and validation accounting. Second, write the parity-slice pullback lemma with sampler/evaluator/sign assumptions. Third, audit rare-slice generated-bag pollution against the literal DCHP procedure: weak-call distributions, constants or offsets, stateless scheduling, extra columns, iid realization, confidence/key-hit tension, and `T` alignment.


# Iteration 8 Consolidation

## Accepted Progress
The fixed-constant atlas edge remains open. Iteration 8 adds three scoped advances:

- Parity/LPN gives a credible near-separation only for shrinking weak slack `gamma_n=O(log n/n)`, not the current fixed-constant source.
- A parity-slice pullback lemma blocks public product/mixture/padding amplifications that preserve an efficiently sampleable parity slice.
- Rare-slice programming shows generated bags are not automatically benign in black-box weak-learner models, but only as a selector-structure warning.

## Candidate Routes
The positive route remains `HiddenCleanTranscriptGenerator + PolynomialFinalSelector/ListGenerator`.

The negative route remains hard-band approximation/prediction hardness. Parity is now best treated as a boundary example, not a fixed-slack candidate.

## Refuted Or Weakened Claims
Parity/LPN does not separate the current edge. Direct public parity amplification is blocked when a slice remains. Rare-slice generated-bag programming does not prove DCHP-generated Set-Cover hardness without additional compatibility, iid, constants/offset, extra-column, and `T`-alignment assumptions.

## Working Notes Updated
Updated `canonical_summary.md`, `claim_ledger.md`, `lemma_bank.md`, `failed_attempts.md`, `counterexamples.md`, `literature_map.md`, `promising_directions.md`, `bibliography.md`, and `iteration_summaries.md`.

I read all 23 Markdown reports/critics under `iterations/iter_008` plus the ideas JSON. No atlas validation was run because only `working_notes/` changed.

## Next Iteration Focus
Formalize the shrinking-gap parity warning theorem with exact constants. Then write the parity-slice pullback lemma cleanly. In parallel, audit rare-slice generated-bag pollution against the literal DCHP procedure: weak-call distributions, constants/offsets, scheduling, iid realization, extra columns, confidence/key-hit tension, and `T` alignment.

## Iteration 9 Consolidation

## Accepted Progress
The fixed-constant atlas edge remains open. Iteration 9 adds three scoped refinements:

- Log-arity signed XOR/sparse parity is now a failed approximation-gap candidate: fixed-slack weak learning at `eta<gamma` already gives nontrivial sparse-parity prediction, so it does not supply an independent weak-side algorithm.
- The DCHP route is cleanly decomposed into realized weak-call validity, hidden-clean population transfer, and final selector/list generation. Realized calls can be union-bounded locally under fresh-sampling assumptions, but the middle and final layers remain open bottlenecks.
- Rare-slice generated-bag pollution remains a black-box selector warning, but literal DCHP-generated Set-Cover hardness is still blocked by final-relevance versus weak-lightness tension, spike tuple calls, key scheduling/adaptivity, extra columns, and `T` alignment.

## Candidate Routes
The best positive route remains `HiddenCleanTranscriptGenerator + PolynomialFinalSelector/ListGenerator`, now sharpened into the three DCHP layers above.

The best conditional negative route remains approximation-gap separation, but future candidates must have an independent distribution-free low-noise signed approximator and hard-band improper prediction hardness. Parity-like slice candidates should first pass the low-noise sparse-XOR stress test.

## Refuted Or Weakened Claims
Log-arity signed XOR does not instantiate the approximation-gap separation. Realized-call accounting does not prove the DCHP implication because it leaves hidden-clean population transfer and sparse-majority optimization untouched. Rare-slice programming does not prove literal DCHP-generated bag hardness or any atlas separation.

## Working Notes Updated
Updated `canonical_summary.md`, `claim_ledger.md`, `lemma_bank.md`, `failed_attempts.md`, `counterexamples.md`, `literature_map.md`, `promising_directions.md`, `bibliography.md`, and `iteration_summaries.md`.

I read all 23 files under `iterations/iter_009` plus `promising_ideas.json`. No atlas validation was run because only `working_notes/` changed.

## Next Iteration Focus
First, formalize the three-layer DCHP conditional theorem with exact quantifiers. Second, search for a non-parity approximation-gap candidate with a real low-noise signed approximator. Third, prove the restricted query-light generated-bag theorem and separately test the spike-tuple/mass-tension obstruction against the literal DCHP procedure.


# Iteration 9 Consolidation

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

## Iteration 10 Consolidation

## Accepted Progress
The edge remains open. Iteration 10 added three conditional modules and scope refinements:

- Ideal ghost-clean transfer is a valid finite-class/statistical lemma when the final class is independent of the clean ghost sample, including covariates. It is analysis-only: it does not produce ghost-good bags or reveal the clean mask.
- Random final lists work if a public sampler over complete votes has inverse-polynomial clean-good mass. A public high-mass pointwise margin distribution over the bag is a sufficient condition.
- Stability, compression, and distribution-dependent quotients can support the DCHP middle layer only when they apply to complete final classifiers or the whole clean-to-final mechanism.

The notes also record corrected scope for ghost anti-hitting: raw holdouts contain hidden clean points at `O(K/p)` scale; `p^{-K}` is the cost of explicitly naming all-clean certificates without mask information.

## Candidate Routes
Best positive route remains `CleanDiscovery + CleanPopulationTransfer + PolynomialFinalSelectorOrList`.

The most concrete subroutes are now: total final-classifier compression with polynomial `p^{-K}2^b/q`, whole-generator stability under `D_c^+`, effective final quotients with computable representatives, and random vote lists from a proved public sampler-mass or pointwise-margin lemma.

## Refuted Or Weakened Claims
Ghost samples alone do not solve clean-population transfer; generation-sample clean success need not imply ghost-clean success.

Random vote lists do not bypass sparse-majority selection from mere existence of a good vote. Needle-cover arbitrary bags give quasi-polynomially small mass for label-oblivious or insufficiently informed product samplers.

Per-call weak-learner stability, compression, or small quotients do not imply the edge unless final selector state, adaptive transcript information, randomness, advice, aggregation, and clean-population transfer are included.

## Working Notes Updated
Updated all requested run-local notes under `working_notes/`: `canonical_summary.md`, `claim_ledger.md`, `lemma_bank.md`, `failed_attempts.md`, `counterexamples.md`, `literature_map.md`, `promising_directions.md`, `bibliography.md`, and `iteration_summaries.md`.

I read all reports and critiques under `iterations/iter_010` plus `promising_ideas.json`. No atlas validation was run because only `working_notes/` files changed.

## Next Iteration Focus
First, formalize the three-module conditional theorem with exact quantifiers over `D`, near-optimal `c`, `P=D_c^+`, endpoint handling, validation independence, and failure probabilities.

Second, pick one subroute and make it theorem-level: either total final-transcript compression, full-generator stability with a named high-probability stability bound, or public pointwise-margin random vote sampling.

Third, keep negative work scoped: write the needle-cover random-list obstruction and ghost anti-hitting theorem with explicit information models, without presenting arbitrary-bag or mask-neutral results as DCHP lower bounds.


# Iteration 10 Consolidation

## Accepted Progress
The edge remains open. Iteration 10 added accepted conditional modules: ideal ghost-clean transfer, random final-list sufficiency under inverse-polynomial sampler mass, and final-level stability/compression/quotient requirements.

I recorded the corrected ghost-sample scope: raw holdouts contain hidden clean points at `O(K/p)` scale; `p^{-K}` is only for explicitly naming all-clean certificates without mask information.

## Candidate Routes
Best route remains:
`CleanDiscovery + CleanPopulationTransfer + PolynomialFinalSelectorOrList`.

Most promising subroutes now are total final-classifier compression, whole-generator stability under `D_c^+`, effective final quotients, and public pointwise-margin random vote sampling.

## Refuted Or Weakened Claims
Ghost samples alone do not solve clean-population transfer.

Random vote lists do not bypass sparse-majority selection merely from existence of a good vote; needle-cover bags give quasi-polynomially small sampler mass.

Per-call weak-learner stability or compression is insufficient unless it controls complete final classifiers and selector state.

## Working Notes Updated
Updated all requested `working_notes/` files, including:

- [canonical_summary.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/canonical_summary.md)
- [claim_ledger.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/claim_ledger.md)
- [lemma_bank.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/lemma_bank.md)
- [failed_attempts.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/failed_attempts.md)
- [counterexamples.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/counterexamples.md)
- [literature_map.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/literature_map.md)
- [promising_directions.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/promising_directions.md)
- [bibliography.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/bibliography.md)

I also appended the iteration 10 consolidation to [iteration_summaries.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes/iteration_summaries.md). `git diff --check -- working_notes` passed. No atlas validation was run because no `atlas/` files changed.

## Next Iteration Focus
Formalize the three-module conditional theorem with exact quantifiers. Then choose one route to make theorem-level: total final-transcript compression, full-generator stability, or public pointwise-margin random vote sampling. Keep negative results scoped to their information model.
