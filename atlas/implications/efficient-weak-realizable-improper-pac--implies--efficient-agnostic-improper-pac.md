---
type: implication
id: efficient-weak-realizable-improper-pac__implies__efficient-agnostic-improper-pac
source: efficient-weak-realizable-improper-pac
target: efficient-agnostic-improper-pac
source_note: "[[efficient-weak-realizable-improper-pac|Efficient Weak Realizable Improper PAC Learning]]"
target_note: "[[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "false"
evidence: conditional-counterexample
result_origin: "known"
assumptions:
  - worst-case lattice hardness
witnesses:
  - halfspaces
ref_keys:
  - tiegel2023
refs:
  - "[Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)"
summary: "Halfspaces are weakly realizably improperly learnable, but strong improper agnostic learning is hard under worst-case lattice assumptions."
family: halfspace-agnostic-hardness
axis_delta:
  resource: same
  distribution: same
  strength: weak-to-strong
  realizability: realizable-to-agnostic
  properness: same
argument_note: "[[halfspace-agnostic-hardness|Halfspace Agnostic Hardness]]"
witness_note: "[[halfspaces|Halfspaces]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Realizable Improper PAC Learning $\Rightarrow$ Efficient Agnostic Improper PAC Learning

## Verdict

`false`, under worst-case lattice hardness.

Halfspaces are weakly realizably improperly learnable, but strong improper agnostic learning is hard under worst-case lattice assumptions.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le 1/2-\gamma(s)$. There is one polynomial $p$ and an inverse-polynomial weak gap $\gamma(s)>0$, independent of $P$ and $c$, such that the worst-case sample size and running time are bounded by $p(s,\log(1/\delta))$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+\varepsilon$. There is one polynomial $p$, independent of $P$ and $\mathcal D$, such that the worst-case sample size and running time are bounded by $p(s,1/\varepsilon,\log(1/\delta))$.

Assuming the worst-case lattice hardness assumption used in Tiegel's halfspace lower bound, there exists a binary concept class $\mathcal C$ for which the source guarantee holds and the target guarantee fails.

## Proof Sketch

**Goal.** Refute the implication under worst-case lattice hardness assumptions.

**Construction.** Use halfspaces. They are efficiently realizably properly learnable, hence also weakly realizably improperly learnable.

**Why the target fails.** Tiegel rules out efficient distribution-free improper agnostic learning of halfspaces under worst-case lattice assumptions.

**Conclusion.** The source node holds for halfspaces, while the target node fails under the stated assumption.

## References

- [Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)
