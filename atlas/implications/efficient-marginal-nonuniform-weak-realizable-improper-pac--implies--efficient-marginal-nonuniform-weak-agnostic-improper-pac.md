---
type: implication
id: efficient-marginal-nonuniform-weak-realizable-improper-pac__implies__efficient-marginal-nonuniform-weak-agnostic-improper-pac
source: efficient-marginal-nonuniform-weak-realizable-improper-pac
target: efficient-marginal-nonuniform-weak-agnostic-improper-pac
source_note: "[[efficient-marginal-nonuniform-weak-realizable-improper-pac|Efficient Marginal-Nonuniform Weak Realizable Improper PAC Learning]]"
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
  - benedek1991fixed
  - hanneke2025marginalnonuniform
refs:
  - "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
  - "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
summary: "True: a marginal-preserving low-noise robustification converts the P-dependent weak realizable advantage into a P-dependent weak agnostic tolerance, with constants neutralizing the high-noise regime."
family: low-noise-weak-agnostic-robustification
axis_delta:
  resource: same
  distribution: same
  strength: same
  realizability: realizable-to-agnostic
  properness: same
argument_note: "[[low-noise-weak-agnostic-robustification|Low-Noise Weak Agnostic Robustification]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Weak Realizable Improper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning

## Verdict

`true`, by a marginal-preserving low-noise robustification.

The target keeps the same marginal-nonuniform weak convention as the source, so the weak gap may remain $P$-dependent. Constants are legal improper hypotheses and neutralize the high-noise regime.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le 1/2-\gamma_P(s)$. For every marginal $P$ there is a polynomial $p_P$ and an inverse-polynomial weak gap $\gamma_P(s)>0$ such that the worst-case sample size and running time are bounded by $p_P(s,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ and $\gamma_P$ may depend on $P$ but not on the target concept or $\delta$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+1/2-\gamma_P(s)$. For every marginal $P$ there is a polynomial $p_P$ and an inverse-polynomial weak gap $\gamma_P(s)>0$ such that the worst-case sample size and running time are bounded by $p_P(s,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ and $\gamma_P$ may depend on $P$ but not on the conditional label distribution or $\delta$.

The theorem asserts that every class satisfying the source guarantee also satisfies the target guarantee.

## Proof Status

**Goal.** Build a weak agnostic improper learner while keeping all marginal-dependent bounds attached to the original marginal $P$.

Fix $P$. Let $A$ be the marginal-nonuniform weak realizable improper learner. For a constant-confidence invocation, write $m_P(s)$ for its $P$-dependent sample/time bound and $\gamma_P(s)$ for its weak realizable advantage. Set

$$
\alpha_P(s)=\min\{\gamma_P(s)/8,1/(256m_P(s)),1/256\},
\qquad
\beta_P(s)=1/2-\alpha_P(s).
$$

The agnostic learner includes the two constant classifiers, runs $A$ several times on fresh agnostic samples, validates the returned hypotheses and the constants, and outputs the empirically best candidate.

If $\operatorname{OPT}_{\mathcal C}(\mathcal D)\ge 2\alpha_P(s)$, a constant classifier of error at most $1/2$ satisfies the target after validation. If $\operatorname{OPT}_{\mathcal C}(\mathcal D)=\eta<2\alpha_P(s)$, choose a near-optimal concept $c^\star$. Couple each noisy invocation with a realizable invocation on $(X,c^\star(X))$ using the same original $P$-distributed instances and the same learner randomness. Since the invocation reads at most $m_P(s)$ labels, the chance of any corrupted inspected label is at most $m_P(s)\eta\le 1/128$. On the no-corruption event, the noisy transcript is a valid realizable transcript under the original marginal $P$, so the source guarantee gives a hypothesis with error at most $1/2-\gamma_P(s)$ against $c^\star$. Its agnostic error is therefore at most $\eta+1/2-\gamma_P(s)$, which is stronger than $\eta+1/2-\alpha_P(s)$. Repetition and validation amplify the success probability to $1-\delta$.

The proof never invokes the learner under a conditional clean marginal; all resource and weak-gap quantities remain attached to the original marginal $P$.

## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
