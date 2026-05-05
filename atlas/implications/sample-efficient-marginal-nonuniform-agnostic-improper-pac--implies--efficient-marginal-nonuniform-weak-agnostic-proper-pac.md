---
type: implication
id: sample-efficient-marginal-nonuniform-agnostic-improper-pac__implies__efficient-marginal-nonuniform-weak-agnostic-proper-pac
source: sample-efficient-marginal-nonuniform-agnostic-improper-pac
target: efficient-marginal-nonuniform-weak-agnostic-proper-pac
source_note: "[[sample-efficient-marginal-nonuniform-agnostic-improper-pac|Sample-Efficient Marginal-Nonuniform Agnostic Improper PAC Learning]]"
target_note: "[[efficient-marginal-nonuniform-weak-agnostic-proper-pac|Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "false"
evidence: conditional-counterexample
result_origin: "known"
assumptions:
  - standard cryptographic assumptions
witnesses:
  - pseudorandom-function-classes
ref_keys:
  - goldreich1986
  - kearns1994cryptographic
refs:
  - "[Goldreich et al. 1986](https://doi.org/10.1145/6490.6503)"
  - "[Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)"
summary: "Pseudorandom function classes are sample-efficient but are not efficiently weakly learnable under standard cryptographic assumptions."
family: sample-to-computational-hardness
axis_delta:
  resource: sample-efficient-to-computationally-efficient
  distribution: same
  strength: strong-to-weak
  realizability: same
  properness: improper-to-proper
argument_note: "[[sample-to-computational-hardness|Sample-to-Computational Hardness]]"
witness_note: "[[pseudorandom-function-classes|Pseudorandom Function Classes]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Sample-Efficient Marginal-Nonuniform Agnostic Improper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning

## Verdict

`false`, under standard cryptographic assumptions.

## Counterexample

**Goal.** Refute the implication from sample efficiency to computational efficiency.

**Construction.** Use the pseudorandom concept families recorded in [[pseudorandom-function-classes|Pseudorandom Function Classes]]. Their finite keyed representation gives finite VC dimension, so unbounded empirical risk minimization satisfies the sample-efficient source node.

**Why the target fails.** Under standard cryptographic assumptions, an efficient weak learner for these classes under the hard marginal distribution would distinguish pseudorandom functions from random labelings. This rules out the computationally efficient target, even if the target only asks for weak realizable improper learning or permits marginal-nonuniform bounds.

**Conclusion.** Sample-efficient PAC learnability does not imply computationally efficient PAC learnability.

## References

- [Goldreich et al. 1986](https://doi.org/10.1145/6490.6503)
- [Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)
