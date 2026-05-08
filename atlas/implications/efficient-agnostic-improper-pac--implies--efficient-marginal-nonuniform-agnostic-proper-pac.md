---
type: implication
id: efficient-agnostic-improper-pac__implies__efficient-marginal-nonuniform-agnostic-proper-pac
source: efficient-agnostic-improper-pac
target: efficient-marginal-nonuniform-agnostic-proper-pac
source_note: "[[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]]"
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
summary: "False under NP not subset RP: the clause-satisfaction lookup class is agnostically learnable improperly, but fixed-marginal proper agnostic learning would decide 3-SAT."
family: clause-satisfaction-proper-hardness
axis_delta:
  resource: same
  distribution: distribution-free-to-marginal-nonuniform
  strength: same
  realizability: same
  properness: improper-to-proper
argument_note: "[[clause-satisfaction-proper-hardness|Clause-Satisfaction Proper Hardness]]"
witness_note: "[[clause-satisfaction-lookup-class|Clause-Satisfaction Lookup Class]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Agnostic Improper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Agnostic Proper PAC Learning

## Verdict

`false`, under the assumption $\mathrm{NP}\nsubseteq\mathrm{RP}$.

The clause-satisfaction lookup class is efficiently agnostically improperly learnable, but a marginal-nonuniform agnostic proper learner under the fixed uniform-clause marginal would decide 3-SAT.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+\varepsilon$. There is one polynomial $p$, independent of $P$ and $\mathcal D$, such that the worst-case sample size and running time are bounded by $p(s,1/\varepsilon,\log(1/\delta))$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+\varepsilon$. For every marginal $P$ there is a polynomial $p_P$ such that the worst-case sample size and running time are bounded by $p_P(s,1/\varepsilon,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ may depend on $P$ but not on the conditional label distribution, $\varepsilon$, or $\delta$.

Assuming $\mathrm{NP}\nsubseteq\mathrm{RP}$, there exists a binary concept class $\mathcal C$ for which the source guarantee holds and the target guarantee fails.

## Proof Status

Use the clause-satisfaction lookup class from [[clause-satisfaction-proper-hardness|Clause-Satisfaction Proper Hardness]]. On the source side, arbitrary lookup tables over the polynomial-size clause universe give efficient distribution-free agnostic improper learning.

For the target lower bound, fix the marginal $P_n$ uniform over all 3-CNF clauses on $n$ variables. Given a formula $\varphi$ with clause set $F$, label clauses in $F$ by $1$ and label clauses outside $F$ by independent fair coins. For every assignment hypothesis $h_a$,
$$
\operatorname{err}(h_a)
=
\frac{|\{C\in F:h_a(C)=0\}|}{|X_n|}
+\frac{|X_n|-|F|}{2|X_n|}.
$$
The fair-noise term is the same for every assignment. Thus satisfiable and unsatisfiable formulas differ by at least $1/|X_n|$ in the optimum proper error. Running a marginal-nonuniform agnostic proper learner for this one fixed marginal to accuracy $1/(3|X_n|)$ and checking the returned assignment would decide 3-SAT with one-sided randomized error.

## References

- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
- [Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)
