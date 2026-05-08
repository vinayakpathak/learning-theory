---
type: argument
id: low-noise-weak-agnostic-robustification
title: Low-Noise Weak Agnostic Robustification
domain: binary-classification
model: pac
status: "true"
evidence: theorem
ref_keys:
  - valiant1984
  - blumer1989
refs:
  - "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
tags:
  - atlas/argument
  - learning/binary-classification
---

# Low-Noise Weak Agnostic Robustification

## Verdict

`true`.

Distribution-free realizable learning gives a weak agnostic improper learner with an inverse-polynomial gap. The target's marginal-nonuniform weak agnostic node only asks for such an inverse-polynomial gap, not a fixed constant gap.

## Theorem Statement

Let $\mathcal C$ be a binary concept class. If $\mathcal C$ has a distribution-free realizable PAC learner, either strong or weak, with polynomial sample and time bounds, then $\mathcal C$ has an improper weak agnostic PAC learner with inverse-polynomial additive advantage: for every joint distribution $\mathcal D$ over $\mathcal X\times\{0,1\}$, the learner outputs a binary hypothesis $h$ with $\operatorname{err}_{\mathcal D}(h)\le \inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+1/2-1/\operatorname{poly}(s)$. If the realizable learner has only marginal-dependent polynomial bounds, the same conclusion holds marginal-by-marginal, with the weak agnostic gap and polynomial bound allowed to depend on the instance marginal.

## Proof Sketch

Let $L$ be a distribution-free realizable learner. For a weak source, let $\gamma(s)$ be its realizable advantage and let $m(s)$ be its polynomial sample bound. For a strong source, run the learner to a fixed clean accuracy and take the resulting clean advantage as a constant $\gamma$.

Set
$$
\alpha(s) \le \min\{\gamma(s)/4, 1/(8m(s))\}.
$$

On agnostic data, include the two constant classifiers and repeatedly run $L$ on fresh batches of $m(s)$ examples, pretending the labels are realizable. Validate all candidates on a fresh sample and output the empirically best one.

If $\operatorname{OPT}_{\mathcal C}(\mathcal D) \ge 2\alpha(s)$, a constant classifier already has error at most $1/2$, which is within
$$
\operatorname{OPT}_{\mathcal C}(\mathcal D)+1/2-\alpha(s).
$$

If $\operatorname{OPT}_{\mathcal C}(\mathcal D)=\eta<2\alpha(s)$, choose $c^\star\in\mathcal C$ with error $\eta$. A fresh batch is entirely consistent with $c^\star$ with probability at least $1-m(s)\eta$, which is still inverse-polynomially bounded away from zero by the choice of $\alpha$. Conditioned on this clean-batch event, the examples are realizable by $c^\star$ under a conditional marginal $Q$. Because the original learner is distribution-free, its same polynomial bound applies to $Q$. The conditional marginal differs from the original marginal by $O(\eta)$ in total variation, so a weakly good clean hypothesis remains weakly good on the original agnostic distribution. Repetition and validation preserve polynomial sample and time bounds.

The proof does not give a fixed constant weak-agnostic tolerance. For marginal-nonuniform realizable sources, use the equivalent marginal-preserving coupling form rather than conditioning on a clean batch: couple the noisy run and the realizable run on the same original $P$-distributed instance sequence, and choose the weak gap below the inverse of the $P$-specific sample bound. Then the only polynomial used is the one attached to the original marginal $P$.

## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
