---
type: implication
id: efficient-marginal-nonuniform-weak-realizable-proper-pac__implies__efficient-marginal-nonuniform-weak-agnostic-improper-pac
source: efficient-marginal-nonuniform-weak-realizable-proper-pac
target: efficient-marginal-nonuniform-weak-agnostic-improper-pac
source_note: "[[efficient-marginal-nonuniform-weak-realizable-proper-pac|Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]]"
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
summary: "True: a marginal-preserving low-noise robustification converts the P-dependent weak realizable advantage into a P-dependent weak agnostic tolerance, and constants neutralize the high-noise regime because the target is improper."
family: low-noise-weak-agnostic-robustification
axis_delta:
  resource: same
  distribution: same
  strength: same
  realizability: realizable-to-agnostic
  properness: proper-to-improper
argument_note: "[[low-noise-weak-agnostic-robustification|Low-Noise Weak Agnostic Robustification]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning

## Verdict

`true`, by marginal-preserving low-noise robustification.

The target is improper, so the wrapper may use the two constant classifiers to handle the high-noise regime. In the low-noise regime, the source learner is run on the original marginal $P$, not on a conditional clean marginal.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le 1/2-\gamma_P(s)$. For every marginal $P$ there is a polynomial $p_P$ and an inverse-polynomial weak gap $\gamma_P(s)>0$ such that the worst-case sample size and running time are bounded by $p_P(s,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ and $\gamma_P$ may depend on $P$ but not on the target concept or $\delta$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+1/2-\gamma_P(s)$. For every marginal $P$ there is a polynomial $p_P$ and an inverse-polynomial weak gap $\gamma_P(s)>0$ such that the worst-case sample size and running time are bounded by $p_P(s,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ and $\gamma_P$ may depend on $P$ but not on the conditional label distribution or $\delta$.

The theorem asserts that every class satisfying the source guarantee also satisfies the target guarantee.

## Proof Status

**Goal.** Build a marginal-nonuniform weak agnostic improper learner from a marginal-nonuniform weak realizable proper learner.

Fix an instance marginal $P$. Let $A$ be the source learner. For a constant-confidence invocation, write $m_P(s)$ for a $P$-dependent polynomial sample/time bound and $\gamma_P(s)$ for the weak realizable advantage. Set

$$
\alpha_P(s)=\min\{\gamma_P(s)/16,1/(512m_P(s)),1/512\}.
$$

The agnostic wrapper includes the two constant classifiers, runs $A$ several times on fresh agnostic samples while pretending the labels are realizable, validates all returned hypotheses and the constants on a holdout sample, and outputs the empirically best candidate.

If $\operatorname{OPT}_{\mathcal C}(\mathcal D)\ge 2\alpha_P(s)$, one constant has error at most $1/2$, which is within $\operatorname{OPT}_{\mathcal C}(\mathcal D)+1/2-\alpha_P(s)$ after choosing the holdout accuracy small enough.

If $\operatorname{OPT}_{\mathcal C}(\mathcal D)=\eta<2\alpha_P(s)$, choose a near-optimal $c^\star\in\mathcal C$. Couple each noisy run of $A$ with a clean run on the same $P$-distributed instances labeled by $c^\star$, using the same internal randomness. The invocation reads at most $m_P(s)$ labels, so the probability of seeing any corrupted inspected label is at most $m_P(s)(\eta+o(1))\le 3/512$. On the no-corruption event, the noisy and clean transcripts coincide, and the clean transcript is a source execution under the original marginal $P$. Thus with constant probability $A$ returns a proper $h\in\mathcal C$ with

$$
\operatorname{err}_P(h,c^\star)\le 1/2-\gamma_P(s).
$$

Then

$$
\operatorname{err}_{\mathcal D}(h)
\le \operatorname{err}_{\mathcal D}(c^\star)+\operatorname{err}_P(h,c^\star)
\le \eta+1/2-\gamma_P(s)+o(1)
\le \eta+1/2-\alpha_P(s).
$$

Repeating the source invocation and validating candidates gives success probability $1-\delta$ with sample and time bounded by a $P$-dependent polynomial. The proof uses the source properness only in the low-noise branch; the high-noise branch relies on improper constants, which is why the neighboring proper-target edge remains separate.

## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
