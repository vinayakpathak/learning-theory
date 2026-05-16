## Summary

The explorer’s main conclusion survives: public, efficiently sliceable parity amplifications are very unlikely to produce the desired fixed-constant-slack separation. If the amplified class still contains an efficiently addressable parity slice, then a fixed-slack weak learner for the amplified class gives a fixed-slack weak learner for ordinary parities. On uniform RCN labels with noise $\eta=\gamma/2$, that yields constant correlation with the hidden parity, conflicting with standard LPN hardness.

The report should not be upgraded to a full impossibility theorem. It is best recorded as a strong obstruction for public products, mixtures, padding, and other constructions preserving parity restrictions.

## Issue List

1. **Missing assumption: efficient pullback/evaluation.**  
   The slice pullback lemma needs the embedding $\phi:X\to X'$ to be efficiently computable and the learner’s output hypothesis $h'$ to be efficiently evaluable on $\phi(x)$. This is standard in PAC learning, but it should be stated.

2. **Missing assumption: support-restricted query distributions are allowed.**  
   The reduction queries the amplified learner on distributions supported entirely on the slice $\phi(X)$. This is fine for distribution-free learning, but the lemma relies on the amplified domain allowing such arbitrary marginals.

3. **Plausible but incomplete: “Goldreich-Levin-style recovery.”**  
   Constant correlation with $\chi_s$ under the uniform marginal gives recovery via GL only if the output predictor can be queried/evaluated on chosen uniform points in polynomial time. Otherwise the weaker consequence is still a validation distinguisher/predictor, but search recovery needs the evaluation-oracle model.

4. **Unsupported citation / assumption: LPN hardness form.**  
   The report invokes “standard LPN-style hardness.” It should specify whether it assumes search LPN, prediction LPN, or decision/refutation hardness at constant noise. The claimed contradiction is strongest under search/prediction LPN plus efficient hypothesis evaluation.

5. **Plausible but incomplete: majority products.**  
   The majority-product slice argument needs constants, complements, inactive helper blocks, or fixed helper settings that create a tie independently of the hidden parity. Some constrained majority meta-classes may not expose such a slice. The explorer acknowledges this, so it is not fatal.

6. **Worth pursuing: formal slice lemma.**  
   The slice lemma is clean and should be recorded, but with exact quantifiers: for every parity $\chi_s$ there must be a concept $c'_s$ whose restriction to $\phi(X)$ equals $\chi_s$ or $-\chi_s$.

## Counterexamples Or Stress Tests

- **Shared-parameter majority product.** If all parity blocks must use the same hidden $s$, fixing helper inputs to produce a tie may fail because $\chi_s(a)$ is not a known constant for $a\ne 0$. This tests the boundary of the majority-product claim.

- **Non-sliceable code/meta-class.** A construction that hides parities only globally, with no efficiently addressable parity restriction, evades the slice lemma. It then needs an independent proof of distribution-free constant-slack weak learning.

- **Public padding coordinate.** If padding is public, conditioning on an unpadded or fixed-padding slice restores the parity problem. This supports the explorer’s obstruction.

- **Constant-size blocks.** Making blocks small enough for weak learning risks polynomial-domain/table-learning or validation escapes, matching existing finite-domain obstructions.

## Literature Or Known-Result Conflicts

No conflict with the current ledger. The explorer’s claims align with:

- hard-band silence for fixed slack;
- weak learning below $\gamma$ refuting planted low-noise labels;
- parity/LPN failing as a fixed-constant weak source;
- finite-domain/table-learning escapes for small public block constructions.

The only literature-sensitive point is the exact LPN assumption. State it explicitly before using the claim as theorem-level support.

## What Survives The Critique

The main obstruction survives:

> Any natural amplification that preserves an efficient public parity slice cannot be both fixed-constant weakly learnable and LPN-hard on the strong side.

The constant-noise calculation is sound:
$$
\eta=\gamma/2,\quad \beta=1/2-\gamma
$$
gives
$$
\operatorname{err}(h,Y)\le 1/2-\gamma/2,
$$
so
$$
\mathbb E[hY]\ge \gamma,\qquad
\mathbb E[h\chi_s]\ge \gamma/(1-\gamma).
$$

This is constant advantage against the hidden parity.

## Recommended Next Checks

1. Write the slice pullback lemma formally with evaluation, sign-flip, support, and distribution-free assumptions.

2. Replace “Goldreich-Levin-style” with a precise conditional statement: constant-correlation evaluable predictor for uniform parity labels implies search/prediction LPN break.

3. Test only genuinely non-sliceable parity/meta-class constructions next. Public mixtures, padding, XOR products, and ordinary block products should be deprioritized.

4. Record this as an obstruction, not an impossibility theorem for all exotic meta-classes.