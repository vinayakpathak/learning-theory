---
type: implication
id: efficient-marginal-nonuniform-realizable-improper-pac__implies__efficient-realizable-proper-pac
source: efficient-marginal-nonuniform-realizable-improper-pac
target: efficient-realizable-proper-pac
source_note: "[[efficient-marginal-nonuniform-realizable-improper-pac|Efficient Marginal-Nonuniform Realizable Improper PAC Learning]]"
target_note: "[[efficient-realizable-proper-pac|Efficient Realizable Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "false"
evidence: conditional-counterexample
assumptions:
  - "RP != NP"
witnesses:
  - "fixed-k-term-DNF"
ref_keys:
  - pitt1988
  - haussler1990
refs:
  - "[Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)"
  - "[Haussler et al. 1990](https://www.cis.upenn.edu/~mkearns/papers/models.pdf)"
summary: "Fixed-k-term DNF is distribution-free realizably improperly learnable, hence satisfies the source, but strong proper realizable learning is hard unless RP = NP."
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Realizable Improper PAC Learning $\Rightarrow$ Efficient Realizable Proper PAC Learning

## Verdict

`false`, under the assumption $\mathrm{RP}\ne\mathrm{NP}$.

Fixed-$k$ term DNF is distribution-free realizably improperly learnable, hence satisfies the source, but strong proper realizable learning is hard unless $\mathrm{RP}=\mathrm{NP}$.

## Counterexample

**Goal.** Refute the implication by separating improper realizable learning from proper realizable learning.

**Construction.** Use the class $\mathcal C_k$ of DNF formulas with at most $k$ terms, for fixed $k\ge2$.

**Why the source property holds.** Pitt and Valiant give an efficient improper realizable learner for fixed-$k$ term DNF by learning an equivalent polynomial-size $k$-CNF representation. A distribution-free improper realizable learner is stronger than the marginal-nonuniform source.

**Why the target fails.** Pitt and Valiant show that proper realizable learning of fixed-$k$ term DNF is hard unless $\mathrm{RP}=\mathrm{NP}$. Haussler, Kearns, Littlestone, and Warmuth justify transferring the learning-from-examples formulation to the standard PAC variants used here.

**Conclusion.** The source can hold while the proper target fails.

## References

- [Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)
- [Haussler et al. 1990](https://www.cis.upenn.edu/~mkearns/papers/models.pdf)
