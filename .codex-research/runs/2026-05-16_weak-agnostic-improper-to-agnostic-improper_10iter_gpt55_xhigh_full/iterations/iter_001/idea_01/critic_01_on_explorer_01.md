## Summary

The explorer’s bottom-line verdict survives: `idea_01` does not settle the atlas edge, and da Cunha--Hogsgaard--Paudice 2026 is only a near miss because its runtime is polynomial in sample size only with other parameters fixed.

Main break: the claimed fixed-additive-to-correlation translation is false as stated when the best class correlation can be negative. It is salvageable with stronger parameter choices or an added assumption such as $\sup_{c\in C}\operatorname{corr}(c,Y)\ge 0$.

## Issue List

1. **False claim:** Lemma 2 says the atlas oracle implies da-Cunha-style weak learning for any $\epsilon_0\ge 2\beta$ and $\gamma_0\le 1$.

   Let $\rho=\sup_{c\in C}\operatorname{corr}(c,Y)$. The atlas oracle gives
   $$
   \operatorname{corr}(h,Y)\ge \rho-2\beta.
   $$
   To imply
   $$
   \operatorname{corr}(h,Y)\ge \gamma_0\rho-\epsilon_0
   $$
   for all possible $\rho$, we need
   $$
   \epsilon_0\ge 2\beta-(1-\gamma_0)\rho.
   $$
   If $\rho$ may be negative, the worst case $\rho=-1$ requires
   $$
   \epsilon_0\ge 2\beta+1-\gamma_0.
   $$
   Thus $\epsilon_0\ge 2\beta$ is enough only under a nonnegative-best-correlation assumption.

2. **Missing assumption:** The da Cunha route needs a fixed base class $H$ containing all weak outputs, with controlled VC dimension, dual VC dimension, and evaluation time. The atlas source only promises an efficient improper binary output; it does not by itself supply a small-capacity output class.

3. **Fatal gap for atlas efficiency:** Even if the weak learner has sample complexity $m_0=\operatorname{poly}(s)$, da Cunha’s algorithm makes about $n^{m_0+3}$ weak calls and has runtime like
   $$
   n^{O(m_0\min\{d^*,\log n\}/\theta^2)}.
   $$
   Since $n=\operatorname{poly}(1/\epsilon)$, this is generally $(1/\epsilon)^{\operatorname{poly}(s)}$, not polynomial in $(s,1/\epsilon)$ with a fixed exponent. A conditional theorem would need much stronger “fixed parameter” assumptions, not merely polynomial $m_0,d,d^*$.

4. **Plausible but incomplete:** The report’s KMV/Feldman and Ghai/Kalai-style residual arguments look directionally correct, but the critic report should not promote them without theorem-number-level verification. The da Cunha primary source does support the key near-miss runtime claim.

5. **Worth pursuing:** The corrected da Cunha translation may still yield a conditional positive statement if one assumes $\rho\ge 0$, or chooses parameters satisfying $\epsilon_0\ge 2\beta+1-\gamma_0$ and $\gamma_0>\epsilon_0$. This is possible iff $\gamma_0>1/2+\beta$.

## Counterexamples Or Stress Tests

- **Negative-correlation stress test:** Let $C$ contain only the constant $-1$ classifier and let labels be always $+1$. Then $\rho=-1$. With $\epsilon_0=2\beta$, the claimed implication to da Cunha’s weak condition fails unless $\gamma_0=1$ exactly.

- **Runtime stress test:** Suppose $m_0=s$ and $d^*=O(1)$. Then the weak-call count alone is $n^{s+3}$. For $n=\operatorname{poly}(1/\epsilon)$ this is not an atlas-efficient learner.

- **Capacity stress test:** Taking $H$ to be “all outputs of $A$ on all samples/random seeds” can make $H$ much more complex than $C$. The strong learner’s sample and runtime bounds then depend on the artifact class $H$, not just the benchmark representation size.

## Literature Or Known-Result Conflicts

No conflict found with the primary da Cunha et al. source. The arXiv record states the algorithm is polynomial in sample size when other parameters are fixed, and the theorem statement includes weak-call and runtime bounds with $m_0$ and $d^*$ in exponents: https://arxiv.org/abs/2601.11265

This supports the explorer’s “near miss, not atlas proof” conclusion.

## What Survives The Critique

- The main audit verdict survives.
- The fixed-slack source is close to da Cunha’s weak-learner model.
- Known efficient boosters that require tunable weak slack still do not obviously settle the edge.
- The clean-witness/exhaustive-subsample bottleneck remains a real obstruction.

## Recommended Next Checks

1. Formalize the corrected parameter translation for arbitrary $\rho\in[-1,1]$.
2. Check whether atlas conventions implicitly ensure $\rho\ge 0$ through complements, constants, or relabeling closure.
3. State a precise conditional theorem: constant $m_0$, constant dual VC, controlled VC, known/evaluable output class.
4. Verify KMV, Feldman, Kalai--Kanade, and Ghai--Singh claims against exact theorem statements before adding them to the claim ledger.