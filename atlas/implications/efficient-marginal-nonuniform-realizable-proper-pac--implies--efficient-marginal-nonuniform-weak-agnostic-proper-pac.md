---
type: implication
id: efficient-marginal-nonuniform-realizable-proper-pac__implies__efficient-marginal-nonuniform-weak-agnostic-proper-pac
source: efficient-marginal-nonuniform-realizable-proper-pac
target: efficient-marginal-nonuniform-weak-agnostic-proper-pac
source_note: "[[efficient-marginal-nonuniform-realizable-proper-pac|Efficient Marginal-Nonuniform Realizable Proper PAC Learning]]"
target_note: "[[efficient-marginal-nonuniform-weak-agnostic-proper-pac|Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - benedek1991fixed
  - hanneke2025marginalnonuniform
  - tiegel2023
  - feldman2012monomials
refs:
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
  - "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
  - "[Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)"
  - "[Feldman et al. 2012](https://doi.org/10.1137/120865094)"
summary: "Open: marginal-preserving low-noise coupling gives proper weak agnostic candidates when OPT is below the fixed-marginal clean-transcript scale, but the middle-OPT regime needs an efficient proper residual selector or neutralizer; known halfspace, monomial, PCP, parity/code, and one-way routes either vary the marginal, prove only strong hardness, or leave legal weak proper handles."
family: marginal-agnostic-hardness-open
axis_delta:
  resource: same
  distribution: same
  strength: strong-to-weak
  realizability: realizable-to-agnostic
  properness: same
argument_note: "[[marginal-agnostic-hardness-open|Marginal-Nonuniform Agnostic Hardness Open]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Realizable Proper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning

## Verdict

`open`.

The low-noise part is understood, but the middle-OPT regime still needs an efficient fixed-marginal proper residual selector or neutralizer.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le\varepsilon$. For every marginal $P$ there is a polynomial $p_P$ such that the worst-case sample size and running time are bounded by $p_P(s,1/\varepsilon,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ may depend on $P$ but not on the target concept, $\varepsilon$, or $\delta$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+1/2-\gamma_P(s)$. For every marginal $P$ there is a polynomial $p_P$ and an inverse-polynomial weak gap $\gamma_P(s)>0$ such that the worst-case sample size and running time are bounded by $p_P(s,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ and $\gamma_P$ may depend on $P$ but not on the conditional label distribution or $\delta$.

Open problem: Does every binary concept class satisfying the source guarantee also satisfy the target guarantee?

## Proof Status

**Goal.** Decide whether a realizable marginal-nonuniform proper learner implies the agnostic marginal-nonuniform weak proper target.

**Low-noise branch.** Fix a marginal $P$ and run the realizable proper learner at constant clean accuracy. If $\operatorname{OPT}_{\mathcal C}(\mathcal D)$ is below the inverse of the resulting $P$-dependent transcript bound, couple the noisy run to a clean realizable run for a near-optimal concept using the same original $P$-distributed instance sequence. On the no-corruption event the source learner returns a proper concept, and validation finds a proper weak agnostic candidate.

**Middle-OPT obstruction.** In $\{\pm1\}$ notation, write $\mu(x)=\mathbf E[Y\mid X=x]$ and
$$
M_{\mathcal C}(\mu)=\sup_{c\in\mathcal C_s}\mathbf E_P[c(X)\mu(X)] .
$$
The target needs a proper $h$ satisfying
$$
\mathbf E_P[h(X)\mu(X)]\ge M_{\mathcal C}(\mu)+2\gamma_P(s)-1 .
$$
When $M_{\mathcal C}(\mu)$ is below the clean-transcript regime, this is only a weak residual selector requirement, but no efficient selector follows from clean realizable proper learning alone. The improper sibling can fall back to the better constant classifier; constants need not be legal concepts here.

**Conditional positive structures.** The edge would be true under extra structure such as proper constants, an efficiently findable anchor and complement, efficient approximate proper neutralizers, or searchable fixed-marginal weak residual covers. These are real additional assumptions, not consequences of the source node.

**Why known hardness is insufficient.** Halfspaces have proper constant fallbacks and their fixed-marginal hardness is strong rather than weak. Monomial/FGRW and PCP routes vary or encode the hard instance in the marginal. Parity, LPN, and code routes leave neutral wrong proper hypotheses that satisfy the weak threshold. One-way and PRF-style routes either break the clean proper source or leak weak handles. Noisy-code attempts that make every wrong proper concept fail need inverse-polynomially negative pairwise correlations, and PSD/Plotkin bounds then leave only polynomially many hidden targets.

**Conclusion.** The edge remains open. A proof needs an efficient fixed-marginal residual proper selector or neutralizer; a counterexample must rule out all weak handles, not merely make exact recovery hard.

## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
- [Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)
- [Feldman et al. 2012](https://doi.org/10.1137/120865094)
