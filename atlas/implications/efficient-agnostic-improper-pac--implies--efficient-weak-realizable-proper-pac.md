---
type: implication
id: efficient-agnostic-improper-pac__implies__efficient-weak-realizable-proper-pac
source: efficient-agnostic-improper-pac
target: efficient-weak-realizable-proper-pac
source_note: "[[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]]"
target_note: "[[efficient-weak-realizable-proper-pac|Efficient Weak Realizable Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - schapire1990
  - pitt1988
  - khot2008dnf
refs:
  - "[Schapire 1990](https://doi.org/10.1023/A:1022648800760)"
  - "[Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)"
  - "[Khot and Saket 2008](https://doi.org/10.1109/FOCS.2008.37)"
summary: "Still open: after restricting to realizable data, the unresolved step is weak properization from an improper learner."
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Agnostic Improper PAC Learning $\Rightarrow$ Efficient Weak Realizable Proper PAC Learning

## Verdict

`open`.

Still open: after restricting to realizable data, the unresolved step is weak properization from an improper learner.

## Proof Status

**Goal.** Decide whether strong agnostic improper learning forces weak realizable proper learning.

**Reduction of the question.** Restrict the source learner to realizable distributions. This gives a strong realizable improper learner, hence a weak realizable improper learner. The target asks for a weak hypothesis inside $\mathcal C$.

**What the known examples say.** Fixed-$k$ term DNF is not a counterexample: it is weakly properly learnable by Schapire's candidate-clause argument, even though it is not strongly properly learnable unless $\mathrm{RP}=\mathrm{NP}$. Thus the standard DNF separation only rules out strong properization, not weak properization.

**Second-pass check: constant-advantage DNF hardness.** Khot and Saket show that two-term DNF is hard to learn by any fixed number of DNF terms to constant advantage, assuming $\mathrm{NP}\not\subseteq\mathrm{RP}$. That would refute a constant-advantage version of this weak proper target.

**Why it is only a near miss.** The weak-realizable target in this atlas asks only for inverse-polynomial advantage. Khot and Saket do not rule out that weaker advantage, and the fixed-$k$ DNF example already has such a proper weak learner. Therefore the standard DNF family still does not separate the source from this weak target.

**Conclusion.** This edge remains open. It is essentially asking whether improper realizable learning always contains enough information to recover a proper hypothesis with nontrivial advantage.

## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
- [Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)
- [Khot and Saket 2008](https://doi.org/10.1109/FOCS.2008.37)
