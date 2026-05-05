---
type: implication
id: efficient-weak-realizable-improper-pac__implies__efficient-marginal-nonuniform-realizable-improper-pac
source: efficient-weak-realizable-improper-pac
target: efficient-marginal-nonuniform-realizable-improper-pac
source_note: "[[efficient-weak-realizable-improper-pac|Efficient Weak Realizable Improper PAC Learning]]"
target_note: "[[efficient-marginal-nonuniform-realizable-improper-pac|Efficient Marginal-Nonuniform Realizable Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: theorem
result_origin: "known"
assumptions: []
witnesses: []
ref_keys:
  - schapire1990
refs:
  - "[Schapire 1990](https://doi.org/10.1023/A:1022648800760)"
summary: "Schapire boosting converts weak realizable improper learning into strong realizable improper learning, which is stronger than the marginal-nonuniform target."
family: realizable-boosting
axis_delta:
  resource: same
  distribution: distribution-free-to-marginal-nonuniform
  strength: weak-to-strong
  realizability: same
  properness: same
argument_note: "[[realizable-boosting|Realizable Boosting]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Realizable Improper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Realizable Improper PAC Learning

## Verdict

`true`.

Schapire boosting converts weak realizable improper learning into strong realizable improper learning, which is stronger than the marginal-nonuniform target.

## Proof Sketch

**Goal.** Derive arbitrary realizable accuracy from the weak source.

**Boosting step.** Schapire's weak-to-strong theorem repeatedly calls the weak learner under reweighted realizable distributions and returns an improper vote with error at most $\varepsilon$.

**Why the target follows.** The boosted learner has a distribution-free polynomial bound in the usual PAC parameters. A distribution-free polynomial is also a valid marginal-dependent polynomial.

**Conclusion.** The source implies the target.

## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
