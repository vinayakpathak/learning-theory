---
type: implication
id: efficient-marginal-nonuniform-realizable-improper-pac__implies__efficient-marginal-nonuniform-weak-agnostic-improper-pac
source: efficient-marginal-nonuniform-realizable-improper-pac
target: efficient-marginal-nonuniform-weak-agnostic-improper-pac
source_note: "[[efficient-marginal-nonuniform-realizable-improper-pac|Efficient Marginal-Nonuniform Realizable Improper PAC Learning]]"
target_note: "[[efficient-marginal-nonuniform-weak-agnostic-improper-pac|Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: theorem
result_origin: "unclear"
assumptions: []
witnesses: []
ref_keys:
  - valiant1984
  - blumer1989
refs:
  - "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
summary: "True: a low-noise coupling robustifies the marginal-nonuniform realizable improper learner without changing the marginal."
family: low-noise-weak-agnostic-robustification
axis_delta:
  resource: same
  distribution: same
  strength: strong-to-weak
  realizability: realizable-to-agnostic
  properness: same
argument_note: "[[low-noise-weak-agnostic-robustification|Low-Noise Weak Agnostic Robustification]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Realizable Improper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning

## Verdict

`true`, by a marginal-preserving low-noise robustification.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le\varepsilon$. For every marginal $P$ there is a polynomial $p_P$ such that the worst-case sample size and running time are bounded by $p_P(s,1/\varepsilon,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ may depend on $P$ but not on the target concept, $\varepsilon$, or $\delta$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+1/2-\gamma_P(s)$. For every marginal $P$ there is a polynomial $p_P$ and an inverse-polynomial weak gap $\gamma_P(s)>0$ such that the worst-case sample size and running time are bounded by $p_P(s,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ and $\gamma_P$ may depend on $P$ but not on the conditional label distribution or $\delta$.

The theorem asserts that every class satisfying the source guarantee also satisfies the target guarantee.

## Proof Status

**Goal.** Build a weak agnostic learner while keeping all marginal-dependent bounds attached to the original marginal $P$.

Fix $P$ and let $A$ be the marginal-nonuniform realizable improper learner. Run $A$ with constant accuracy and confidence, and let $m_P(s)$ be the resulting $P$-dependent polynomial sample/time bound. Set
$$
\alpha_P(s)=\min\{1/64,1/(64m_P(s))\},
\qquad
\beta_P(s)=1/2-\alpha_P(s).
$$

The weak agnostic learner includes the two constant classifiers, runs $A$ a polynomial number of times on fresh agnostic samples, validates all returned hypotheses, and outputs the empirically best candidate.

If $\operatorname{OPT}_{\mathcal C}(\mathcal D)\ge \alpha_P(s)$, a constant classifier of error at most $1/2$ already satisfies the weak agnostic target. If $\operatorname{OPT}_{\mathcal C}(\mathcal D)=\eta<\alpha_P(s)$, choose $c^\star\in\mathcal C$ with error $\eta$ up to negligible slack. Couple a noisy run of $A$ with a realizable run on $(X,c^\star(X))$, using the same $P$-distributed instance sequence and the same internal randomness. Since the run inspects at most $m_P(s)$ labels, a union bound gives corruption probability at most $m_P(s)\eta<1/64$. On the no-corruption event, the noisy transcript is the realizable transcript under the original marginal $P$, so the source guarantee applies. The returned hypothesis has constant error against $c^\star$, and therefore weak agnostic error at most $\eta+1/2-\alpha_P(s)$. Repetition and validation amplify to confidence $1-\delta$.

The proof avoids the conditional-marginal obstruction: it never calls the realizable learner under a clean conditional marginal $Q$, only under the original marginal $P$.

## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
