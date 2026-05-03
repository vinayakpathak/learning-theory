---
type: implication
id: efficient-realizable-improper-pac__implies__efficient-marginal-nonuniform-weak-agnostic-proper-pac
source: efficient-realizable-improper-pac
target: efficient-marginal-nonuniform-weak-agnostic-proper-pac
source_note: "[[efficient-realizable-improper-pac|Efficient Realizable Improper PAC Learning]]"
target_note: "[[efficient-marginal-nonuniform-weak-agnostic-proper-pac|Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning]]"
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
summary: "Open: this asks for properization from an improper marginal-nonuniform learner."
family: properization-open
axis_delta:
  distribution: distribution-free-to-marginal-nonuniform
  strength: strong-to-weak
  realizability: realizable-to-agnostic
  properness: improper-to-proper
argument_note: "[[properization-open|Properization Open]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Realizable Improper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning

## Verdict

`open`.

Open: this asks for properization from an improper marginal-nonuniform learner.

## Proof Status

**Goal.** Decide whether an improper marginal-nonuniform learner can be converted into a proper learner for the target node.

**Obstacle.** The source may output hypotheses outside $\mathcal C$. The target asks for a member of $\mathcal C$, and neither distribution dependence nor standard boosting provides a general projection back into the concept class.

**Known examples.** Fixed-$k$ term DNF separates strong improper from strong proper learning in the distribution-free realizable model, but that hardness uses varying distributions and does not automatically refute a marginal-nonuniform proper target. Khot and Saket's constant-advantage DNF lower bound is also only a near miss for the inverse-polynomial weak convention used here.

**Conclusion.** The edge remains open as a marginal-nonuniform properization question.

## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
- [Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)
- [Khot and Saket 2008](https://doi.org/10.1109/FOCS.2008.37)
