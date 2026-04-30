---
type: implication
id: efficient-weak-realizable-improper-pac__implies__efficient-agnostic-proper-pac
source: efficient-weak-realizable-improper-pac
target: efficient-agnostic-proper-pac
source_note: "[[efficient-weak-realizable-improper-pac|Efficient Weak Realizable Improper PAC Learning]]"
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
summary: "Fixed-k-term DNF is weakly realizably improperly learnable, but strong proper agnostic learning would imply the forbidden proper realizable learner."
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Realizable Improper PAC Learning $\Rightarrow$ Efficient Agnostic Proper PAC Learning

## Verdict

`false`, under RP != NP.

Fixed-k-term DNF is weakly realizably improperly learnable, but strong proper agnostic learning would imply the forbidden proper realizable learner.

## Proof Sketch

**Goal.** Refute the implication under $\mathrm{RP}\ne\mathrm{NP}$.

**Construction.** Use fixed-$k$ term DNF. It has an efficient improper realizable learner via $k$-CNF, hence satisfies the weak source node.

**Why the target fails.** A strong proper agnostic learner restricted to realizable distributions would be a strong proper realizable learner. Pitt and Valiant rule this out for fixed-$k$ term DNF unless $\mathrm{RP}=\mathrm{NP}$.

**Conclusion.** The mixed weak-realizable-improper to strong-agnostic-proper implication fails under the stated assumption.

## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)
- [Haussler et al. 1990](https://www.cis.upenn.edu/~mkearns/papers/models.pdf)
