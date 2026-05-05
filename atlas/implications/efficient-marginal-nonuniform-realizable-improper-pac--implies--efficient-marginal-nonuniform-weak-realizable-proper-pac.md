---
type: implication
id: efficient-marginal-nonuniform-realizable-improper-pac__implies__efficient-marginal-nonuniform-weak-realizable-proper-pac
source: efficient-marginal-nonuniform-realizable-improper-pac
target: efficient-marginal-nonuniform-weak-realizable-proper-pac
source_note: "[[efficient-marginal-nonuniform-realizable-improper-pac|Efficient Marginal-Nonuniform Realizable Improper PAC Learning]]"
target_note: "[[efficient-marginal-nonuniform-weak-realizable-proper-pac|Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]]"
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
  - hastad2005query
  - kearns1994cryptographic
  - hastad1999prg
refs:
  - "[Schapire 1990](https://doi.org/10.1023/A:1022648800760)"
  - "[Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)"
  - "[Khot and Saket 2008](https://doi.org/10.1109/FOCS.2008.37)"
  - "[Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)"
  - "[Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)"
  - "[Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)"
summary: "Open: strong improper prediction does not give an efficient weak proper projection, while PCP and cryptographic fixed-marginal separations remain near misses."
family: properization-open
axis_delta:
  resource: same
  distribution: same
  strength: strong-to-weak
  realizability: same
  properness: improper-to-proper
argument_note: "[[properization-open|Properization Open]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Realizable Improper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning

## Verdict

`open`.

This edge asks whether strong marginal-nonuniform realizable improper learning can always be properized to weak marginal-nonuniform realizable learning.

## Proof Status

**Theorem route.** The source supplies arbitrary-accuracy polynomial-time prediction by hypotheses outside $\mathcal C$, while the target requires a polynomial-time output in $\mathcal C$ with inverse-polynomial advantage. No checked boosting or marginal-nonuniform sample-complexity theorem provides this representation-sensitive projection step.

**Counterexample route.** PCP active-slice and proper-DNF hardness arguments use hard distributions that vary with the input instance; marginal-nonuniformity permits the runtime polynomial and weak advantage to depend on such a marginal. Packing all slices into one fixed marginal dilutes the hard slice below the inverse-polynomial global advantage promised by the target.

Cryptographic image-coordinate witnesses separate improper learning from strong proper learning, but at the weak threshold sparse blocks, wrong-length concepts, constants, singletons, or residual code correlations can provide proper hypotheses that beat random guessing without inverting the one-way function. A promising dense parity-of-image construction would let improper learning recover an external image vector while proper weak learning would require a preimage, but no finitely encoded fixed marginal is known that supplies balanced high-mass parity queries for every representation size without tail dilution or hidden weak handles.

**Conclusion.** The edge remains open as a computational marginal-nonuniform properization problem.

## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
- [Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)
- [Khot and Saket 2008](https://doi.org/10.1109/FOCS.2008.37)
- [Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)
- [Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)
- [Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)
