---
type: argument
id: pcp-active-slice-weak-proper-hardness
title: PCP Active-Slice Weak Proper Hardness
domain: binary-classification
model: pac
status: "false"
evidence: conditional-counterexample
witnesses:
  - pcp-active-slice-lookup-class
witness_note: "[[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]]"
assumptions:
  - "NP not subset RP"
ref_keys:
  - hastad2005query
  - karp1972
refs:
  - "[Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)"
  - "[Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)"
tags:
  - atlas/argument
  - learning/binary-classification
---

# PCP Active-Slice Weak Proper Hardness

## Verdict

`false`, under the assumption $\mathrm{NP}\nsubseteq\mathrm{RP}$.

The PCP active-slice lookup class is efficiently learnable by an improper memorization learner, and even by an agnostic improper one-slice lookup-table ERM. An efficient weak proper learner would decide an NP-complete language with one-sided randomized error.

## Theorem Statement

Assuming $\mathrm{NP}\nsubseteq\mathrm{RP}$, there is a binary concept class built from a perfect-completeness PCP verifier with logarithmic randomness such that the class is efficiently distribution-free learnable by improper memorization and efficiently agnostically learnable by improper one-slice lookup-table empirical risk minimization, but it has no polynomial-time proper learner that achieves even inverse-polynomial weak advantage in the realizable PAC setting. Such a weak proper learner would distinguish satisfiable from unsatisfiable instances of an NP-complete language by learning on the active verifier-randomness slice.

## Proof Sketch

Use a perfect-completeness PCP with logarithmic randomness and soundness $s<1/2$, as in Håstad and Khot. A proper concept is indexed by an NP instance $\varphi$ and a proof string $\pi$. On an example $(\psi,r)$, it outputs the verifier decision $V(\varphi,\pi,r)$ if $\psi=\varphi$, and outputs $0$ otherwise.

The active slice for a fixed $\varphi$ has polynomial size because the verifier uses $O(\log |\varphi|)$ random bits. An improper learner can memorize the positive sample points on that active slice and predict $0$ elsewhere, giving distribution-free realizable improper learning.

For weak agnostic improper sources, use the finite class of all one-slice lookup tables, plus the all-zero hypothesis. Its logarithmic size is polynomial: choose the active slice and then a Boolean table over polynomially many verifier random strings. ERM is polynomial on a sample because only sampled slices can beat the all-zero hypothesis, and the best table on such a slice is obtained by empirical majority vote. Since every proper hypothesis is contained in this improper class, finite-class uniform convergence gives agnostic improper learning against $\mathcal C$.

If a weak proper learner existed, then on input $\varphi$ we could sample uniformly from the active slice $\{(\varphi,r)\}$ and label every example by $1$. If $\varphi$ is satisfiable, perfect completeness makes this distribution realizable by some proper concept, so the learner returns a proper hypothesis accepted on more than half the verifier random strings. If $\varphi$ is unsatisfiable, every proper hypothesis on the $\varphi$ slice is accepted on at most an $s<1/2$ fraction. Since the active slice is polynomial, the reduction can estimate or enumerate acceptance and distinguish the two cases with one-sided randomized error.

## References

- [Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)
- [Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)
