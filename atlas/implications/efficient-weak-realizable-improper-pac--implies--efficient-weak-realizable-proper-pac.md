---
type: implication
id: efficient-weak-realizable-improper-pac__implies__efficient-weak-realizable-proper-pac
source: efficient-weak-realizable-improper-pac
target: efficient-weak-realizable-proper-pac
source_note: "[[efficient-weak-realizable-improper-pac|Efficient Weak Realizable Improper PAC Learning]]"
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
summary: "Still open: this is the pure weak realizable properization problem."
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Realizable Improper PAC Learning $\Rightarrow$ Efficient Weak Realizable Proper PAC Learning

## Verdict

`open`.

Still open: this is the pure weak realizable properization problem.

## Proof Status

**Goal.** Decide whether weak realizable improper learning implies weak realizable proper learning.

**Why this is not settled by boosting.** Schapire boosting converts weak hypotheses into a strong improper vote. The construction is deliberately representation-independent, so it does not preserve the final-output class $\mathcal C$.

**Why the standard DNF separation does not settle it.** Fixed-$k$ term DNF is weakly properly learnable: the learner searches over constants and disjunctions of at most $k$ literals. Therefore that class separates weak proper learning from strong proper learning, but not weak improper from weak proper learning.

**Second-pass check: constant-advantage DNF hardness.** Khot and Saket show that, assuming $\mathrm{NP}\not\subseteq\mathrm{RP}$, two-term DNF cannot be learned by any fixed number of DNF terms with constant advantage over random guessing. This is the closest known obstruction to weak properization for the DNF example.

**Why it is only a near miss.** The atlas weak-realizable node allows inverse-polynomial advantage. Khot and Saket rule out $1/2+\epsilon$ accuracy for a constant $\epsilon$, but they do not rule out $1/2+1/\operatorname{poly}(n)$ accuracy. Since the DNF weak learner used here only needs inverse-polynomial advantage, their result does not produce a counterexample to this edge.

**Conclusion.** This remains the cleanest open properization edge in the realizable weak setting.

## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
- [Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)
- [Khot and Saket 2008](https://doi.org/10.1109/FOCS.2008.37)
