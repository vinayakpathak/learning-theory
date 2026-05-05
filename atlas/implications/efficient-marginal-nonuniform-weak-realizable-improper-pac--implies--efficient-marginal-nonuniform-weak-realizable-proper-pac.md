---
type: implication
id: efficient-marginal-nonuniform-weak-realizable-improper-pac__implies__efficient-marginal-nonuniform-weak-realizable-proper-pac
source: efficient-marginal-nonuniform-weak-realizable-improper-pac
target: efficient-marginal-nonuniform-weak-realizable-proper-pac
source_note: "[[efficient-marginal-nonuniform-weak-realizable-improper-pac|Efficient Marginal-Nonuniform Weak Realizable Improper PAC Learning]]"
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
summary: "Open: weak improper learning may use external handles, but known fixed-marginal weak proper hardness constructions either vary the marginal or leak weak proper predictors."
family: properization-open
axis_delta:
  resource: same
  distribution: same
  strength: same
  realizability: same
  properness: improper-to-proper
argument_note: "[[properization-open|Properization Open]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Weak Realizable Improper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning

## Verdict

`open`.

This is the weak marginal-nonuniform properization edge. The source gives weak prediction by hypotheses outside $\mathcal C$; the target asks for a weak predictor represented inside $\mathcal C$.

## Proof Status

**Theorem route.** For a fixed marginal, the realizing concept itself is a zero-error proper hypothesis, so the obstacle is not statistical existence. The obstacle is efficient search: an improper weak learner may output a lookup table, codeword, vote, or other external handle, and standard boosting does not project such a hypothesis back into the representation class.

**Counterexample route.** PCP active-slice witnesses separate distribution-free weak improper from weak proper learning, but their hard marginal varies with the input instance. Marginal-nonuniformity permits the runtime polynomial to depend on that marginal, so this does not give a uniform polynomial-time decision procedure. Packing all PCP slices into one fixed marginal dilutes each local gap by the slice mass.

One-way image-coordinate and balanced image-code ideas show how proper accuracy can force inversion under a fixed length-specific marginal, but the weak all-length version suffers from dilution or from labels that cannot be simulated from the cryptographic challenge. Adding easy proper handles makes weak learning true rather than false; keeping handles improper tends to leak approximations through existing proper concepts.

**Conclusion.** Keep this edge open. A resolution would need either a uniform efficient projection theorem from marginal-nonuniform weak improper learners to proper learners, or a fixed-marginal weak proper hardness construction that avoids both input-dependent-marginal nonuniformity and weak-advantage dilution.

## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
- [Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)
- [Khot and Saket 2008](https://doi.org/10.1109/FOCS.2008.37)
- [Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)
- [Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)
- [Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)
