## Summary

The explorer’s main verdict survives: log-arity signed Max-LIN / sparse parity does **not** instantiate the approximation-gap separation. The useful output is a sharper no-go pattern, not a candidate separation.

The decisive obstruction is the weak side. For fixed slack `beta=1/2-gamma`, any source learner must handle low-noise sparse parity instances with `eta < gamma`; on those instances it returns a predictor with nontrivial correlation. That is essentially the sparse-LPN task one would like to assume hard.

## Issue List

- **Fatal gap, if treated as a separation:** no independently supplied distribution-free signed weak approximator is given. Random assignment only gives error `1/2`, i.e. slack `beta=1/2`, not `beta<1/2`.

- **Plausible but incomplete:** the strong-side sparse-LPN hardness is only sketched. It must be formalized as prediction hardness against arbitrary evaluable improper predictors for a specific marginal `mu`, hidden `a`, arity `k`, noise `eta >= gamma`, and advantage threshold.

- **Missing assumption:** the report should explicitly fix the representation model for `C_{n,k}`, the encoding length of `S`, and runtime measured polynomially in `n`, not in `|X|`.

- **Missing assumption:** hardness cannot hold uniformly over all hidden assignments `a`; e.g. `a=(1,...,1)` makes the concept constant. Use random or balanced hidden `a`.

- **Unsupported citation / scope issue:** Håstad-style Max-E3-LIN inapproximability supports proper assignment-optimization hardness, not improper PAC prediction hardness, and not directly log-arity sparse parity.

- **Unsupported citation / scope issue:** Daniely and Kothari-Livni are relevant frameworks for improper/refutation hardness, but the explorer does not cite a theorem that applies to this exact signed Max-LIN class.

- **Worth pursuing:** the trilemma is valuable: constant arity gives table learning; growing arity makes strong hardness plausible but weak learning hard; public RHS/sign encodings are invalid.

## Counterexamples Or Stress Tests

- Take `k=3`. Then `|X|=O(n^3)`, so empirical-majority table learning gives strong improper agnostic learning, regardless of Max-3-LIN optimization hardness.

- Take `k=Theta(log n)`, uniform `S`, random balanced `a`, and RCN noise `eta=gamma/2`. A fixed-slack weak learner must output error at most `1/2-gamma/2`, hence a constant-correlated sparse-parity predictor.

- If the RHS/sign is included in `x`, an improper learner can read it or output a public trivial predictor. The report correctly avoids this, but it should remain an explicit checklist item.

- If `mu` is concentrated on polynomially many `S`, table/majority learning works. Strong hardness needs a high-entropy marginal such as uniform `k`-subsets.

## Literature Or Known-Result Conflicts

No direct conflict, but several citations are only background:

- Håstad’s Max-E3-LIN hardness is about inapproximability of assignment optimization, not arbitrary improper prediction: https://www.cs.umd.edu/~gasarch/BLOGPAPERS/max3satl.pdf
- Daniely gives improper agnostic halfspace hardness machinery, not this sparse-parity candidate directly: https://arxiv.org/abs/1505.05800
- Kothari-Livni is relevant for refutation-based learning reductions, but still needs an instantiated signed class and weak approximator: https://arxiv.org/abs/1709.03871
- Blum-Kalai-Wasserman is LPN/SQ background; it is not by itself the required arbitrary-predictor sparse-LPN hardness assumption: https://arxiv.org/abs/cs/0010022

## What Survives The Critique

- Constant-arity signed Max-LIN cannot separate the improper edge because the descriptor domain is polynomial.

- Log-arity signed Max-LIN has the right *shape* for hard-band prediction assumptions.

- The RCN reduction is valid: an `OPT+epsilon` learner at noise `eta` gives target prediction error `epsilon/(1-2 eta)`.

- The weak-side obstruction is real: fixed-slack weak learning below `gamma` already solves low-noise sparse parity prediction.

## Recommended Next Checks

1. Record this as a failed candidate/no-go checklist, not as a separation.

2. Formalize the low-noise weak-side obstruction with `eta=gamma/2` and the exact correlation calculation.

3. If continuing the approximation-gap route, search only for classes with an actual low-noise signed weak approximator independent of the assumed weak learner.

4. Treat any strong-side hardness as prediction hardness against arbitrary evaluable hypotheses, not recovery or proper optimization hardness.