---
type: implication
id: efficient-marginal-nonuniform-agnostic-improper-pac__implies__efficient-marginal-nonuniform-agnostic-proper-pac
source: efficient-marginal-nonuniform-agnostic-improper-pac
target: efficient-marginal-nonuniform-agnostic-proper-pac
source_note: "[[efficient-marginal-nonuniform-agnostic-improper-pac|Efficient Marginal-Nonuniform Agnostic Improper PAC Learning]]"
target_note: "[[efficient-marginal-nonuniform-agnostic-proper-pac|Efficient Marginal-Nonuniform Agnostic Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "false"
evidence: conditional-counterexample
result_origin: "unclear"
assumptions:
  - "NP not subset RP"
witnesses:
  - clause-satisfaction-lookup-class
ref_keys:
  - blumer1989
  - karp1972
refs:
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
  - "[Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)"
summary: "False under NP not subset RP: a fixed-uniform-marginal clause lookup class is agnostically learnable improperly, but proper learning would decide 3-SAT."
family: clause-satisfaction-proper-hardness
axis_delta:
  resource: same
  distribution: same
  strength: same
  realizability: same
  properness: improper-to-proper
argument_note: "[[clause-satisfaction-proper-hardness|Clause-Satisfaction Proper Hardness]]"
witness_note: "[[clause-satisfaction-lookup-class|Clause-Satisfaction Lookup Class]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Agnostic Improper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Agnostic Proper PAC Learning

## Verdict

`false`, under the assumption $\mathrm{NP}\nsubseteq\mathrm{RP}$.

The clause-satisfaction lookup class is agnostically learnable by an improper lookup-table learner, but a marginal-nonuniform proper agnostic learner under one fixed clause marginal would decide 3-SAT.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+\varepsilon$. For every marginal $P$ there is a polynomial $p_P$ such that the worst-case sample size and running time are bounded by $p_P(s,1/\varepsilon,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ may depend on $P$ but not on the conditional label distribution, $\varepsilon$, or $\delta$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+\varepsilon$. For every marginal $P$ there is a polynomial $p_P$ such that the worst-case sample size and running time are bounded by $p_P(s,1/\varepsilon,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ may depend on $P$ but not on the conditional label distribution, $\varepsilon$, or $\delta$.

Assuming $\mathrm{NP}\nsubseteq\mathrm{RP}$, there exists a binary concept class $\mathcal C$ for which the source guarantee holds and the target guarantee fails.

## Proof Status

**Source.** For each $n$, let $X_n$ be the set of all 3-CNF clauses over variables $x_1,\ldots,x_n$. Proper hypotheses are assignments $a\in\{0,1\}^n$, represented by
$$
h_a(C)=1 \quad\Longleftrightarrow\quad a \text{ satisfies } C.
$$
An improper learner may output an arbitrary lookup table on $X_n$. Since $|X_n|=O(n^3)$, empirical majority labels over clauses give efficient distribution-free agnostic improper learning, hence the marginal-nonuniform improper source.

**Fixed marginal.** Let $P_n$ be uniform on $X_n$. Given a 3-CNF formula $\varphi$ with clause set $F\subseteq X_n$, define a joint distribution with marginal $P_n$ by labeling clauses in $F$ as $1$ and labeling clauses outside $F$ by an independent fair coin. For every assignment $a$,
$$
\operatorname{err}(h_a)
=
\frac{|\{C\in F:h_a(C)=0\}|}{|X_n|}
+\frac{|X_n|-|F|}{2|X_n|}.
$$
The non-formula region contributes the same fair-noise term for every proper hypothesis.

If $\varphi$ is satisfiable, some assignment attains the fair-noise baseline. If $\varphi$ is unsatisfiable, every assignment falsifies at least one formula clause, so the optimum proper error is larger by at least $1/|X_n|$. A marginal-nonuniform proper agnostic learner for the fixed marginal $P_n$, run with accuracy $1/(3|X_n|)$, would return a satisfying assignment in the satisfiable case. Checking the returned assignment gives a one-sided randomized polynomial-time algorithm for 3-SAT, contradicting $\mathrm{NP}\nsubseteq\mathrm{RP}$.

## References

- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
- [Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)
