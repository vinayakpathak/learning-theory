---
type: implication
id: efficient-weak-realizable-proper-pac__implies__efficient-agnostic-proper-pac
source: efficient-weak-realizable-proper-pac
target: efficient-agnostic-proper-pac
source_note: "[[efficient-weak-realizable-proper-pac|Efficient Weak Realizable Proper PAC Learning]]"
target_note: "[[efficient-agnostic-proper-pac|Efficient Agnostic Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "false"
evidence: conditional-counterexample
result_origin: "known"
assumptions:
  - RP != NP
witnesses:
  - conjunctions
ref_keys:
  - valiant1984
  - kearns1994
refs:
  - "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
  - "[Kearns et al. 1994](https://doi.org/10.1023/A:1022615600103)"
summary: "Conjunctions are weakly realizably properly learnable, but strong proper agnostic learning is hard unless RP = NP."
family: conjunction-agnostic-hardness
axis_delta:
  resource: same
  distribution: same
  strength: weak-to-strong
  realizability: realizable-to-agnostic
  properness: same
argument_note: "[[conjunction-agnostic-hardness|Conjunction Agnostic Hardness]]"
witness_note: "[[conjunctions|Conjunctions]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Realizable Proper PAC Learning $\Rightarrow$ Efficient Agnostic Proper PAC Learning

## Verdict

`false`, under RP != NP.

Conjunctions are weakly realizably properly learnable, but strong proper agnostic learning is hard unless RP = NP.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le 1/2-\gamma(s)$. There is one polynomial $p$ and an inverse-polynomial weak gap $\gamma(s)>0$, independent of $P$ and $c$, such that the worst-case sample size and running time are bounded by $p(s,\log(1/\delta))$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+\varepsilon$. There is one polynomial $p$, independent of $P$ and $\mathcal D$, such that the worst-case sample size and running time are bounded by $p(s,1/\varepsilon,\log(1/\delta))$.

Assuming $\mathrm{RP}\ne\mathrm{NP}$, there exists a binary concept class $\mathcal C$ for which the source guarantee holds and the target guarantee fails.

## Proof Sketch

**Goal.** Refute the implication under $\mathrm{RP}\ne\mathrm{NP}$.

**Construction.** Use conjunctions. The classical realizable proper learner for conjunctions is already strong, hence also weak.

**Why the target fails.** Kearns, Schapire, and Sellie show that efficient proper agnostic learning of conjunctions would yield a randomized polynomial-time algorithm for minimum set cover.

**Conclusion.** The source node holds for conjunctions, while the target node fails unless $\mathrm{RP}=\mathrm{NP}$.

## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Kearns et al. 1994](https://doi.org/10.1023/A:1022615600103)
