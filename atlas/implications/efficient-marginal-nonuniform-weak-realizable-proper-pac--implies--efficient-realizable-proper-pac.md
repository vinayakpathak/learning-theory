---
type: implication
id: efficient-marginal-nonuniform-weak-realizable-proper-pac__implies__efficient-realizable-proper-pac
source: efficient-marginal-nonuniform-weak-realizable-proper-pac
target: efficient-realizable-proper-pac
source_note: "[[efficient-marginal-nonuniform-weak-realizable-proper-pac|Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]]"
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
  - schapire1990
  - pitt1988
  - haussler1990
refs:
  - "[Schapire 1990](https://doi.org/10.1023/A:1022648800760)"
  - "[Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)"
  - "[Haussler et al. 1990](https://www.cis.upenn.edu/~mkearns/papers/models.pdf)"
summary: "Fixed-k-term DNF satisfies the source, but fails the distribution-free strong proper target unless RP = NP."
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning $\Rightarrow$ Efficient Realizable Proper PAC Learning

## Verdict

`false`, under RP != NP.

Fixed-k-term DNF satisfies the source, but fails the distribution-free strong proper target unless RP = NP.

## Counterexample

**Goal.** Refute the implication using a class that is easy enough for the source but hard for the distribution-free strong proper target.

**Construction.** Use fixed-$k$ term DNF for a fixed $k\ge2$. Pitt and Valiant give an efficient improper realizable learner via equivalent polynomial-size $k$-CNF hypotheses, and Schapire's argument gives weak proper learning for this class. Hence fixed-$k$ term DNF satisfies the source node in this edge.

**Why the target fails.** Pitt and Valiant show that proper realizable learning of fixed-$k$ term DNF is hard unless $\mathrm{RP}=\mathrm{NP}$. A strong distribution-free proper target, realizable or agnostic, would imply such a proper realizable learner by restriction. Haussler, Kearns, Littlestone, and Warmuth justify transferring the learning-from-examples formulation to the PAC variants used here.

**Conclusion.** Fixed-$k$ term DNF satisfies the source but not the target under $\mathrm{RP}\ne\mathrm{NP}$.

## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
- [Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)
- [Haussler et al. 1990](https://www.cis.upenn.edu/~mkearns/papers/models.pdf)
