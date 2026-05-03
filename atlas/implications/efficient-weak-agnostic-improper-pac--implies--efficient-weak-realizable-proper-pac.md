---
type: implication
id: efficient-weak-agnostic-improper-pac__implies__efficient-weak-realizable-proper-pac
source: efficient-weak-agnostic-improper-pac
target: efficient-weak-realizable-proper-pac
source_note: "[[efficient-weak-agnostic-improper-pac|Efficient Weak Agnostic Improper PAC Learning]]"
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
summary: "Still open: restricting to realizable distributions gives weak improper learning, but no general weak properization theorem is recorded."
family: properization-open
axis_delta:
  distribution: same
  strength: same
  realizability: agnostic-to-realizable
  properness: improper-to-proper
argument_note: "[[properization-open|Properization Open]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Agnostic Improper PAC Learning $\Rightarrow$ Efficient Weak Realizable Proper PAC Learning

## Verdict

`open`.

Still open: restricting to realizable distributions gives weak improper learning, but no general weak properization theorem is recorded.

## Proof Status

**Goal.** Decide whether weak agnostic improper learning forces weak realizable proper learning.

**Reduction of the question.** On realizable distributions, $\operatorname{opt}_{\mathcal C}=0$, so the source gives weak realizable improper learning. The remaining question is whether the weak hypothesis can be required to lie in $\mathcal C$.

**Known examples.** Fixed-$k$ term DNF does not refute this edge because it is weakly properly learnable. The halfspace agnostic lower bound does not refute it because halfspaces fail the weak agnostic improper source.

**Second-pass check: constant-advantage DNF hardness.** Khot and Saket prove hardness of learning two-term DNF by any fixed number of DNF terms with constant advantage over random guessing. This is close to showing that an improper weak learner cannot always be made proper.

**Why it is only a near miss.** The target here is the inverse-polynomial weak-realizable node. Khot and Saket do not rule out inverse-polynomial advantage, and fixed-$k$ DNF remains weakly properly learnable at that weaker level. Thus their theorem does not produce a counterexample to this edge.

**Conclusion.** The edge remains open and reduces to weak properization after the realizable restriction.

## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
- [Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)
- [Khot and Saket 2008](https://doi.org/10.1109/FOCS.2008.37)
