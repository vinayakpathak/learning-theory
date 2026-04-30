---
type: implication
id: efficient-agnostic-improper-pac__implies__efficient-realizable-proper-pac
source: efficient-agnostic-improper-pac
target: efficient-realizable-proper-pac
source_note: "[[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]]"
target_note: "[[efficient-realizable-proper-pac|Efficient Realizable Proper PAC Learning]]"
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
summary: "Still open: restricting an agnostic improper learner to realizable data gives strong improper learning, but no general conversion to proper realizable learning is known here."
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Agnostic Improper PAC Learning $\Rightarrow$ Efficient Realizable Proper PAC Learning

## Verdict

`open`.

Still open: restricting an agnostic improper learner to realizable data gives strong improper learning, but no general conversion to proper realizable learning is known here.

## Proof Status

**Goal.** Decide whether strong agnostic improper learning forces strong realizable proper learning.

**Reduction of the question.** On realizable distributions, an agnostic improper learner becomes a strong realizable improper learner. The missing step is therefore not boosting or agnostic-to-realizable restriction; it is properization in the realizable model.

**Why the available counterexamples do not settle it.** Fixed-$k$ term DNF shows that strong realizable improper learning need not imply strong realizable proper learning. However, to refute this stronger source edge with the same class, one would also need efficient strong agnostic improper learning for fixed-$k$ term DNF. That is not supplied by the Pitt-Valiant/Schapire argument recorded here.

**Second-pass check: DNF weak-hardness results.** Khot and Saket strengthen the warning from DNF by showing hardness of constant-advantage proper weak learning for two-term DNF using any fixed number of DNF terms. This still does not settle the present edge. The target here is strong realizable proper learning, and the source is strong agnostic improper learning; the Khot-Saket theorem does not supply a class satisfying that source while failing this target.

**Conclusion.** This edge remains open. A counterexample would be a class that is strongly agnostically learnable with arbitrary hypotheses but whose realizable proper learning problem is computationally hard.

## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
- [Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)
- [Khot and Saket 2008](https://doi.org/10.1109/FOCS.2008.37)
