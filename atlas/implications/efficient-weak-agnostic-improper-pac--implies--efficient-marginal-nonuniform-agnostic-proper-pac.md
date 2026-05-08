---
type: implication
id: efficient-weak-agnostic-improper-pac__implies__efficient-marginal-nonuniform-agnostic-proper-pac
source: efficient-weak-agnostic-improper-pac
target: efficient-marginal-nonuniform-agnostic-proper-pac
source_note: "[[efficient-weak-agnostic-improper-pac|Efficient Weak Agnostic Improper PAC Learning]]"
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
witness_note: "[[clause-satisfaction-lookup-class|Clause-Satisfaction Lookup Class]]"
ref_keys:
  - blumer1989
  - karp1972
refs:
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
  - "[Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)"
summary: "False under NP not subset RP: the clause-satisfaction lookup class is efficiently agnostically learnable improperly, hence satisfies the weak improper source, but fixed-marginal proper agnostic learning would decide 3-SAT."
family: clause-satisfaction-proper-hardness
axis_delta:
  resource: same
  distribution: distribution-free-to-marginal-nonuniform
  strength: weak-to-strong
  realizability: same
  properness: improper-to-proper
argument_note: "[[clause-satisfaction-proper-hardness|Clause-Satisfaction Proper Hardness]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Agnostic Improper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Agnostic Proper PAC Learning

## Verdict

`false`, under the assumption $\mathrm{NP}\nsubseteq\mathrm{RP}$.

Use the [[clause-satisfaction-lookup-class|Clause-Satisfaction Lookup Class]]. It is efficiently strong agnostic learnable by an improper lookup-table learner, so it satisfies the weaker distribution-free weak agnostic improper source.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+1/2-\gamma(s)$. There is one polynomial $p$ and an inverse-polynomial weak gap $\gamma(s)>0$, independent of $P$ and $\mathcal D$, such that the worst-case sample size and running time are bounded by $p(s,\log(1/\delta))$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+\varepsilon$. For every marginal $P$ there is a polynomial $p_P$ such that the worst-case sample size and running time are bounded by $p_P(s,1/\varepsilon,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ may depend on $P$ but not on the conditional label distribution, $\varepsilon$, or $\delta$.

Assuming $\mathrm{NP}\nsubseteq\mathrm{RP}$, there exists a binary concept class $\mathcal C$ for which the source guarantee holds and the target guarantee fails.

## Proof Status

**Goal.** Separate the weak agnostic improper source from the strong marginal-nonuniform agnostic proper target.

**Why the source holds.** For size $n$, let $X_n$ be the polynomial-size set of 3-CNF clauses over variables $x_1,\ldots,x_n$. Improper ERM over all Boolean lookup tables on $X_n$ is polynomial-time by per-clause empirical majority vote. Finite-class uniform convergence gives efficient distribution-free agnostic improper learning, since the lookup class contains every assignment hypothesis. Running this stronger learner to any fixed constant accuracy gives the assigned weak agnostic improper source.

**Why the target fails.** Fix the uniform marginal over clauses on $n$ variables. Given a 3-CNF formula $\varphi$ with clause set $F$, label clauses in $F$ by $1$ and label clauses outside $F$ by fair coins. For an assignment hypothesis $h_a$,

$$
\operatorname{err}(h_a)
=
\frac{|\{C\in F:h_a(C)=0\}|}{|X_n|}
+
\frac{|X_n|-|F|}{2|X_n|}.
$$

The fair-noise term is the same for every assignment, and each unsatisfied formula clause adds exactly $1/|X_n|$ error. If a marginal-nonuniform agnostic proper learner existed, then for this one fixed marginal we could run it with accuracy $1/(3|X_n|)$ and constant confidence. On satisfiable formulas it would return a satisfying assignment with probability at least $2/3$; on unsatisfiable formulas no returned assignment can satisfy all clauses. Checking the returned assignment would decide 3-SAT with one-sided randomized polynomial time.

Thus the target would imply $\mathrm{NP}\subseteq\mathrm{RP}$.

## References

- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
- [Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)
