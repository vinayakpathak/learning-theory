## Summary

The parity/LPN idea is a valid **parameterized near-separation** when the weak gap is allowed to shrink, e.g. \(\gamma=1/2-\beta=\Theta(1/n)\). It does **not** solve the atlas edge as stated for a representation-uniform constant \(\beta<1/2\).

The proof sketch can be repaired and made fairly clean: the span-capture argument should be applied to the **clean-conditioned marginal** \(D_{c^\star}^+\), not the original marginal.

## Concrete Progress

For \(C_n=\{\chi_s(x)=(-1)^{s\cdot x}:s\in\mathbb F_2^n\}\), there is a plausible polynomial-time weak learner for tolerance
\[
\beta_n=1/2-\gamma_n,\qquad \gamma_n=a/n
\]
for fixed constant \(a\).

The key accounting is:

- If \(\eta=\operatorname{OPT}_{C_n}(D)\ge 2\gamma\), the better constant has error \(\le 1/2\le \eta+\beta-\gamma\).
- If \(\eta<2\gamma\), draw \(m=\Theta(n)\) examples. With probability \(\exp(-O(n\gamma))\), all are clean relative to an optimal parity \(c^\star\). For \(\gamma=a/n\), this is constant.
- Conditional on being clean, the \(X_i\)'s are iid from the clean marginal \(D_{c^\star}^+\). Their span captures \(>1/2+2\gamma\) mass with high probability.
- Any parity consistent with the clean batch agrees with \(c^\star\) on the span, hence has clean-conditional error \(\le 1/2-2\gamma\).
- By the clean-conditional excess lemma, this gives noisy error \(\le \operatorname{OPT}+\beta-\gamma\), leaving enough margin for validation.

## Claims Or Lemmas

**Lemma 1: Span capture.**  
Let \(\nu\) be any distribution on \(\mathbb F_2^n\), and sample \(x_1,\dots,x_m\sim\nu\). Let \(V_m=\operatorname{span}(x_1,\dots,x_m)\). If \(\gamma\le 1/8\) and \(m=8n\), then
\[
\Pr[\nu(V_m)<1/2+2\gamma]\le \exp(-\Omega(n)).
\]
Reason: until \(\nu(V_t)\ge 1/2+2\gamma\), the next sample increases the span with probability at least \(1/2-2\gamma\ge 1/4\). Failure after \(8n\) samples implies fewer than \(n\) span increases.

**Lemma 2: Parameterized weak parity learner.**  
For \(\gamma=a/n\) with fixed \(a\), parities have an efficient distribution-free improper learner with error
\[
\operatorname{err}(h)\le \operatorname{OPT}_{C_n}+\left(1/2-\gamma\right).
\]
More generally, the same proof has repetition cost \(\exp(O(n\gamma))\), so it remains polynomial if \(n\gamma=O(\log n)\), but not for constant \(\gamma\).

**Lemma 3: Strong improper agnostic parity learner breaks LPN.**  
Under uniform RCN labels \(Y=\chi_s(X)N_\eta\),
\[
\operatorname{err}(h,Y)=\eta+(1-2\eta)\operatorname{err}(h,\chi_s).
\]
An \(\operatorname{OPT}+\epsilon\) learner with \(\epsilon<(1-2\eta)/4\) outputs an evaluable predictor with noticeable correlation with \(\chi_s\). Goldreich-Levin/Hadamard list decoding then recovers \(s\) in polynomial time, contradicting standard LPN hardness.

## Proof Attempts

The weak-side proof works after two fixes.

First, use the threshold split at \(2\gamma\), not \(\gamma\), to leave validation margin. For \(\eta\ge 2\gamma\), constants are legal with margin \(\gamma\). For \(\eta<2\gamma\), the clean-batch route gives a good parity with margin \(\gamma\).

Second, span capture must be over \(D_{c^\star}^+\). The raw clean-batch event biases the \(X\)-marginal toward clean points, so the original solver wording using the original marginal is not correct under agnostic, \(x\)-dependent noise. The clean-conditional lemma exactly repairs this.

## Gaps And Risks

The decisive gap is definitional: \(\beta_n=1/2-a/n\) is not a fixed representation-uniform constant. For the current atlas edge, \(\gamma\) must be constant.

For constant \(\gamma\), this proof needs \(\Theta(n)\) clean examples while \(\eta<2\gamma\) can be constant, so the all-clean probability is \(\exp(-\Omega(n))\). That is not a loose artifact.

The LPN reduction assumes the strong learner outputs an efficiently evaluable hypothesis so that Goldreich-Levin can query it on fresh uniform \(x\)'s. This is standard for PAC hypotheses, but it should be stated.

## Counterexamples Or Obstructions

Uniform \(X\) is a worst-case obstruction for improving the span argument. Any proper subspace of \(\mathbb F_2^n\) has uniform mass at most \(1/2\), so capturing \(>1/2+2\gamma\) requires full rank, hence essentially \(n\) independent clean equations.

Thus the parity weak learner cannot be upgraded to constant weak gap by this method. In fact, a constant-gap weak learner for parities under low constant RCN would itself give a noticeable predictor and would already threaten LPN.

## Sources Consulted

Local run files: `problem.md`, all requested `working_notes/*.md`, `iterations/iter_008/idea_01/idea.md`, and `iterations/iter_008/solver_attempt.md`.

External sources: Blum, Kalai, and Wasserman, [“Noise-Tolerant Learning, the Parity Problem, and the Statistical Query Model”](https://www.microsoft.com/en-us/research/wp-content/uploads/2016/11/2003-Noise-Tolerant_Learning.pdf); Goldreich and Levin, [“A Hard-Core Predicate for all One-Way Functions”](https://www.cs.bu.edu/fac/lnd/pdf/hard.pdf), plus Goldreich’s [paper page](https://www.wisdom.weizmann.ac.il/~oded/gl.html).

## Recommended Next Steps

Record this as a separate parameterized warning: fixed-constant slack and inverse-polynomial slack behave differently.

If formalized, state the weak learner with explicit constants: \(m=8n\), low-noise regime \(\eta<2\gamma\), span target \(1/2+2\gamma\), repetition \(\exp(O(n\gamma))\), and validation tolerance \(O(\gamma)\).

Do not use this as evidence for the atlas edge unless the definition is intentionally changed to allow \(\gamma\) to shrink with representation size.