---
type: implication
id: efficient-realizable-improper-pac__implies__efficient-agnostic-proper-pac
source: efficient-realizable-improper-pac
target: efficient-agnostic-proper-pac
source_note: "[[efficient-realizable-improper-pac|Efficient Realizable Improper PAC Learning]]"
target_note: "[[efficient-agnostic-proper-pac|Efficient Agnostic Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "false"
evidence: conditional-counterexample
assumptions:
  - RP != NP
witnesses:
  - fixed-k-term-DNF
ref_keys:
  - valiant1984
  - pitt1988
  - haussler1990
refs:
  - "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
  - "[Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)"
  - "[Haussler et al. 1990](https://www.cis.upenn.edu/~mkearns/papers/models.pdf)"
summary: "If fixed-k-term DNF had efficient proper agnostic learners, restricting to realizable distributions would give efficient proper realizable learners, contradicting the known hardness unless RP = NP."
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Realizable Improper PAC Learning $\Rightarrow$ Efficient Agnostic Proper PAC Learning

## Verdict

`false`, under the assumption $\mathrm{RP} \ne \mathrm{NP}$.

The fixed-$k$ term DNF separation blocks this mixed implication. A proper agnostic learner would specialize to a proper realizable learner on realizable distributions, contradicting the proper-learning hardness.

## Proof Sketch

**Goal.** Refute the universal implication, assuming $\mathrm{RP}\ne\mathrm{NP}$. It is enough to use a class that is efficiently realizably improperly learnable but cannot be efficiently properly learned even in the easier realizable setting.

**Construction.** Fix a constant $k\ge 2$ and let $\mathcal C_k$ be the class of DNF formulas with at most $k$ terms.

**Why the source property holds.** As in the realizable improper versus realizable proper separation, every fixed-$k$ term DNF has an equivalent polynomial-size $k$-CNF. The learner may output this CNF representation, so Valiant's fixed-width CNF learner, as used by Pitt and Valiant, gives an efficient realizable improper PAC learner for $\mathcal C_k$.

**Why the target property fails.** Suppose, for contradiction, that $\mathcal C_k$ had an efficient proper agnostic PAC learner. On a realizable distribution, the optimum benchmark error is $0$, so the same learner would output a hypothesis in $\mathcal C_k$ with error at most $\varepsilon$. Thus it would be an efficient proper realizable PAC learner for fixed-$k$ term DNF. Pitt and Valiant's hardness theorem rules this out unless $\mathrm{RP}=\mathrm{NP}$, with the examples-model formulation transferred to standard polynomial PAC learnability by Haussler, Kearns, Littlestone, and Warmuth.

**Conclusion.** The assumed proper agnostic learner would imply the forbidden proper realizable learner. Therefore, under $\mathrm{RP}\ne\mathrm{NP}$, efficient realizable improper PAC learning does not imply efficient agnostic proper PAC learning.

## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)
- [Haussler et al. 1990](https://www.cis.upenn.edu/~mkearns/papers/models.pdf)
