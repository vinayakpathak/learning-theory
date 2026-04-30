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
summary: "Fixed-k-term DNF is weakly realizably improperly learnable via k-CNF, but strong proper realizable learning is hard unless RP = NP."
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Realizable Improper PAC Learning $\Rightarrow$ Efficient Realizable Proper PAC Learning

## Verdict

`false`, under RP != NP.

Fixed-k-term DNF is weakly realizably improperly learnable via k-CNF, but strong proper realizable learning is hard unless RP = NP.

## Proof Sketch

**Goal.** Refute the implication under $\mathrm{RP}\ne\mathrm{NP}$.

**Construction.** Use fixed-$k$ term DNF. Pitt and Valiant give an efficient improper realizable learner via equivalent polynomial-size $k$-CNF representations, so the class satisfies the weak improper source node.

**Why the target fails.** Pitt and Valiant show that proper realizable learning of fixed-$k$ term DNF is hard unless $\mathrm{RP}=\mathrm{NP}$, with the examples model transferred to standard PAC learnability by Haussler, Kearns, Littlestone, and Warmuth.

**Conclusion.** Weak realizable improper learning does not force strong realizable proper learning.

## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)
- [Haussler et al. 1990](https://www.cis.upenn.edu/~mkearns/papers/models.pdf)
