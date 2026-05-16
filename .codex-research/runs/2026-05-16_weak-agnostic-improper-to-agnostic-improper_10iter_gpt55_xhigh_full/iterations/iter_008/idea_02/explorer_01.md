## Summary

I found no viable construction that amplifies the inverse-polynomial parity near-separation to the fixed-constant `gamma` edge. The main obstruction is simple and robust: any transformation that still contains an efficiently sampleable parity slice makes the fixed-slack weak learner solve constant-noise LPN on that slice.

So direct products, block mixtures, noise padding, and most meta-class variants do not just fail technically; they fail for the same quantifier reason. The source learner is distribution-free, so it must work on adversarial distributions concentrated on the hard parity component, not only on the intended padded or averaged distribution.

## Concrete Progress

The useful diagnostic is:

If a transformed class `C'` contains an efficiently sampleable embedding of parities, meaning there is a map `phi(x)` and concepts `c_s in C'` with

$$
c_s(\phi(x))=\chi_s(x),
$$

then a fixed-constant `OPT + beta` weak learner for `C'`, with `beta=1/2-gamma`, implies a constant-advantage learner for noisy parity at every constant noise `eta < gamma`.

Indeed, under uniform RCN labels

$$
Y=\chi_s(X)N_\eta,
$$

the transformed distribution has `OPT_{C'} <= eta`. The weak learner returns `h` with

$$
\operatorname{err}(h,Y)\le \eta + \frac12-\gamma,
$$

so

$$
\mathbb E[hY]\ge 2(\gamma-\eta).
$$

Since `Y=chi_s(X)N_eta` with fresh noise,

$$
\mathbb E[h(\phi(X))\chi_s(X)]
\ge
\frac{2(\gamma-\eta)}{1-2\eta}.
$$

Taking, for example, `eta=gamma/2` gives constant correlation. An evaluable predictor with constant correlation to a parity is enough for the usual Goldreich-Levin/LPN-style recovery or distinguishing route.

This kills any construction whose strong hardness still embeds ordinary parity prediction in this way.

## Claims Or Lemmas

**Lemma 1: Parity-slice obstruction.**  
Assume a transformed class `C'` has an efficiently sampleable parity restriction. Then a fixed-constant weak agnostic improper learner for `C'` breaks constant-noise LPN.

Status: proof sketch solid, conditional on the standard LPN/Goldreich-Levin recovery assumption.

**Lemma 2: Padding does not hide a hard slice in distribution-free PAC.**  
If a construction puts hard parity behavior on a small region `R` and easy/public labels elsewhere, the intended mixture may make the public anchor a legal weak answer. But the weak learner must also handle distributions supported entirely on `R`. With low constant RCN on `R`, this is again noisy parity.

Status: accepted obstruction to noise padding and block mixtures.

**Lemma 3: Block dimension trilemma.**  
For block/meta parity constructions:

- growing parity dimension gives LPN-hard weak learning at constant noise;
- constant block dimension makes the weak side easy but usually makes the strong side table-learnable or enumerable;
- exponentially many constant blocks require a succinct hidden generator, which makes uniform low-noise weak prediction hard unless public handles reveal enough to also help strong learning.

Status: construction-search diagnostic, not a formal impossibility theorem.

## Proof Attempts

**Direct products.**  
XOR products are just larger parities, so fixed-constant weak learning is immediately noisy-parity hard. Majority or threshold products also contain parity slices: fix the padding blocks to known values so the threshold output is controlled by one active parity. A weak learner for the product class would weakly learn that active parity.

**Block mixtures.**  
Let examples include a block index and let each block carry a parity. If a distribution can concentrate on one block, the source learner must weakly learn noisy parity on that block. If blocks are small enough to avoid this, the strong hardness disappears unless a succinct generator is introduced, which reintroduces weak-side hardness.

**Noise padding.**  
A mixture with mass `1-lambda` on a public anchor and mass `lambda` on a hard parity task can make the public anchor a legal answer on the full mixture. But distribution-free learning also quantifies over the conditional hard component. Padding changes the intended hard distribution, not the source requirement.

**Meta-classes with hints.**  
Adding public weak hints only helps if they correlate with the hidden parity. But then validation and Goldreich-Levin-style decoding threaten the strong hardness side. If the hints do not correlate on the parity slice, the weak learner still faces LPN.

## Gaps And Risks

The parity-slice obstruction rules out direct amplification templates, not every conceivable class. A more exotic class might have easy constant low-noise weak prediction but hard high-noise strong improper prediction without containing an efficiently sampleable parity slice.

The no-go also depends on the usual LPN hardness interpretation: producing an evaluable predictor with constant correlation to a hidden parity is assumed hard or sufficient for recovery/distinguishing.

## Counterexamples Or Obstructions

The decisive obstruction is conditionalization: distribution-free PAC lets the adversary ignore the padding and query the hard component directly.

This is why inverse-polynomial parity works only as a near-separation. When `gamma=Theta(1/n)`, clean-batch/span-capture methods can plausibly weakly learn. When `gamma` is constant, the same source must tolerate constant-noise parity, which is exactly the LPN-hard regime.

## Sources Consulted

- `problem.md`
- `working_notes/canonical_summary.md`
- `working_notes/claim_ledger.md`
- `working_notes/lemma_bank.md`
- `working_notes/failed_attempts.md`
- `working_notes/counterexamples.md`
- `working_notes/literature_map.md`
- `working_notes/promising_directions.md`
- `working_notes/iteration_summaries.md`
- `iterations/iter_008/solver_attempt.md`
- `iterations/iter_008/idea_02/idea.md`
- Run bibliography entry for Blum-Kalai-Wasserman 2003 on noisy parity/LPN: https://arxiv.org/abs/cs/0010022

No live web search used.

## Recommended Next Steps

Do not spend more effort on direct parity amplification by products, mixtures, or padding.

The useful next move is to formalize the parity-slice obstruction as a reusable lemma, then redirect construction search to non-parity hard-band candidates: classes with an independently available constant low-noise signed weak learner, but conjecturally hard `OPT+epsilon` improper prediction at noise `eta >= gamma`.