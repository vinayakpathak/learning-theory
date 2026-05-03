---
type: implication
id: efficient-weak-realizable-improper-pac__implies__efficient-realizable-proper-pac
source: efficient-weak-realizable-improper-pac
target: efficient-realizable-proper-pac
source_note: "[[efficient-weak-realizable-improper-pac|Efficient Weak Realizable Improper PAC Learning]]"
target_note: "[[efficient-realizable-proper-pac|Efficient Realizable Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "false"
evidence: conditional-counterexample
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
summary: "The clause-satisfaction lookup class is efficiently agnostically improperly learnable, but any efficient proper realizable learner would put 3-SAT in RP."
family: clause-satisfaction-proper-hardness
axis_delta:
  resource: same
  distribution: same
  strength: weak-to-strong
  realizability: same
  properness: improper-to-proper
argument_note: "[[clause-satisfaction-proper-hardness|Clause-Satisfaction Proper Hardness]]"
witness_note: "[[clause-satisfaction-lookup-class|Clause-Satisfaction Lookup Class]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Realizable Improper PAC Learning $\Rightarrow$ Efficient Realizable Proper PAC Learning

## Verdict

`false`, under the assumption $\mathrm{NP}\nsubseteq\mathrm{RP}$.

The witness satisfies the source because strong agnostic improper learning restricts to realizable distributions and gives, in particular, inverse-polynomial advantage over random guessing. The target fails for the witness: an efficient proper realizable learner would give a randomized polynomial-time one-sided algorithm for 3-SAT.

## Counterexample

**Goal.** Refute the implication by constructing one binary hypothesis class $\mathcal H$ that satisfies the source node but not the target node.

The construction is the clause-satisfaction lookup class. It is easy to learn improperly because its instance domain has only polynomially many points, but proper hypotheses encode assignments. A highly accurate proper learner on realizable clause distributions would therefore find satisfying assignments.

## Construction

For each $n$, let $X_n$ be the set of all 3-CNF clauses over variables $x_1,\ldots,x_n$, allowing repeated literals. Thus

$$
|X_n|\le (2n)^3.
$$

For every assignment $a\in\{0,1\}^n$, define $h_a:X_n\to\{0,1\}$ by

$$
h_a(C)=1
\quad\Longleftrightarrow\quad
a\text{ satisfies the clause }C.
$$

Let

$$
\mathcal H_n=\{h_a:a\in\{0,1\}^n\}.
$$

A proper hypothesis is represented by the assignment $a$, and evaluating $h_a(C)$ is polynomial time.

## Why the Source Holds

Let $\mathcal F_n=\{0,1\}^{X_n}$ be the class of all Boolean functions on the finite domain $X_n$. Since $|X_n|=O(n^3)$,

$$
\log |\mathcal F_n|=|X_n|=O(n^3).
$$

Given a labeled sample, compute an empirical risk minimizer over $\mathcal F_n$ by assigning each clause its empirical majority label, breaking ties arbitrarily. The output is a lookup table $\hat g:X_n\to\{0,1\}$, not necessarily equal to $h_a$ for any assignment $a$.

By the standard finite-class uniform convergence bound, for

$$
m=O\left(\frac{n^3+\log(1/\delta)}{\varepsilon^2}\right),
$$

with probability at least $1-\delta$, every $g\in\mathcal F_n$ has empirical and true error within $\varepsilon/2$. On this event, if $g^\star$ minimizes true error over $\mathcal F_n$, then

$$
\operatorname{err}_{\mathcal D}(\hat g)
\le
\widehat{\operatorname{err}}_S(\hat g)+\frac{\varepsilon}{2}
\le
\widehat{\operatorname{err}}_S(g^\star)+\frac{\varepsilon}{2}
\le
\operatorname{err}_{\mathcal D}(g^\star)+\varepsilon.
$$

Since $\mathcal H_n\subseteq\mathcal F_n$,

$$
\operatorname{err}_{\mathcal D}(\hat g)
\le
\inf_{h\in\mathcal H_n}\operatorname{err}_{\mathcal D}(h)+\varepsilon.
$$

The learner runs in polynomial time by enumerating the $O(n^3)$ clauses and storing their majority labels. Hence $\mathcal H$ is efficiently agnostically PAC learnable by an improper learner. The source node follows from this directly or by relaxing the distribution, realizability, strength, or accuracy requirements as described above.

## Why the Proper Target Fails

Suppose, for contradiction, that the target property held for $\mathcal H$.

If the target is strong proper agnostic learning, restrict the learner to realizable distributions. Since the optimum error is then $0$, it becomes a strong proper realizable learner. Thus in either target case we get an efficient proper realizable PAC learner for $\mathcal H$.

We use that learner to decide 3-SAT. Given a 3-CNF formula

$$
\varphi=C_1\wedge\cdots\wedge C_M
$$

over $x_1,\ldots,x_n$, define the realizable-test distribution $\mathcal D_\varphi$ by choosing $j\in[M]$ uniformly and outputting the labeled example $(C_j,1)$.

If $\varphi$ is satisfiable, some assignment $a^\star$ satisfies every clause, so $h_{a^\star}$ has zero error on $\mathcal D_\varphi$. Run the assumed proper realizable learner with

$$
\varepsilon=\frac{1}{2M},
\qquad
\delta=\frac13.
$$

With probability at least $2/3$, it returns a proper hypothesis $h\in\mathcal H_n$ with

$$
\operatorname{err}_{\mathcal D_\varphi}(h)<\frac1M.
$$

Under $\mathcal D_\varphi$,

$$
\operatorname{err}_{\mathcal D_\varphi}(h)
=
\frac{1}{M}\left|\{j:h(C_j)=0\}\right|.
$$

Therefore error below $1/M$ forces $h(C_j)=1$ for every clause occurrence $C_j$.

The randomized decision algorithm for 3-SAT is now simple: simulate samples from $\mathcal D_\varphi$, run the learner with the parameters above, and accept exactly when the returned proper hypothesis labels every $C_j$ by $1$.

If $\varphi$ is satisfiable, the algorithm accepts with probability at least $2/3$. If $\varphi$ is unsatisfiable, no assignment satisfies all clauses, hence no proper hypothesis $h_a$ labels all $C_j$ by $1$, so the algorithm never accepts. The runtime is polynomial in the formula size because $1/\varepsilon=2M$.

Thus 3-SAT would be in $\mathrm{RP}$, implying $\mathrm{NP}\subseteq\mathrm{RP}$ by NP-completeness of 3-SAT. Under the assumption $\mathrm{NP}\nsubseteq\mathrm{RP}$, the target property cannot hold.

## Conclusion

The clause-satisfaction lookup class satisfies the source node but fails the target node under $\mathrm{NP}\nsubseteq\mathrm{RP}$. Therefore this implication is false under that assumption.

## References

- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
- [Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)
