---
type: implication
id: efficient-marginal-nonuniform-realizable-improper-pac__implies__efficient-weak-realizable-proper-pac
source: efficient-marginal-nonuniform-realizable-improper-pac
target: efficient-weak-realizable-proper-pac
source_note: "[[efficient-marginal-nonuniform-realizable-improper-pac|Efficient Marginal-Nonuniform Realizable Improper PAC Learning]]"
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
summary: "Open: this asks for both a uniform weak learner and a proper hypothesis, starting from a marginal-nonuniform improper strong learner."
family: properization-open
axis_delta:
  distribution: marginal-nonuniform-to-distribution-free
  strength: strong-to-weak
  realizability: same
  properness: improper-to-proper
argument_note: "[[properization-open|Properization Open]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Realizable Improper PAC Learning $\Rightarrow$ Efficient Weak Realizable Proper PAC Learning

## Verdict

`open`.

Open: this asks for both a uniform weak learner and a proper hypothesis, starting from a marginal-nonuniform improper strong learner.

## Proof Status

**Goal.** Decide whether marginal-nonuniform improper realizable learning forces weak distribution-free proper realizable learning.

**Two obstacles.** First, the source polynomial may depend on the marginal distribution, while the target requires one distribution-free polynomial weak learner. Second, the source permits improper hypotheses, while the target requires the weak hypothesis to lie in $\mathcal C$.

**Known examples.** Fixed-$k$ term DNF does not refute this edge because it is weakly properly learnable. Khot and Saket's DNF hardness is a constant-advantage proper weak-learning lower bound, while this atlas target uses inverse-polynomial weak advantage. Schapire boosting goes from weak learning to strong improper learning, not from improper learning back to proper weak learning.

**Conclusion.** The edge remains open. It combines the uniformization issue with the weak properization issue.

## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
- [Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)
- [Khot and Saket 2008](https://doi.org/10.1109/FOCS.2008.37)
