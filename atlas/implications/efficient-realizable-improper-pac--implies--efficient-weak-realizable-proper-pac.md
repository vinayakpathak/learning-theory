---
type: implication
id: efficient-realizable-improper-pac__implies__efficient-weak-realizable-proper-pac
source: efficient-realizable-improper-pac
target: efficient-weak-realizable-proper-pac
source_note: "[[efficient-realizable-improper-pac|Efficient Realizable Improper PAC Learning]]"
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
summary: "Still open: Schapire boosting gives improper strong learning from weak learning, but does not give a general weak proper learner from a strong improper learner."
family: properization-open
axis_delta:
  distribution: same
  strength: strong-to-weak
  realizability: same
  properness: improper-to-proper
argument_note: "[[properization-open|Properization Open]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Realizable Improper PAC Learning $\Rightarrow$ Efficient Weak Realizable Proper PAC Learning

## Verdict

`open`.

Still open: Schapire boosting gives improper strong learning from weak learning, but does not give a general weak proper learner from a strong improper learner.

## Proof Status

**Goal.** Decide whether every efficiently realizably improperly learnable class is at least weakly realizably properly learnable.

**What is known.** Schapire's theorem goes in the other direction once a weak learner exists: weak realizable learning can be boosted to strong realizable learning, with an improper vote as the final hypothesis. It does not extract a proper weak hypothesis from an arbitrary strong improper learner.

**Why fixed-$k$ term DNF is not enough.** Fixed-$k$ term DNF separates strong improper from strong proper learning, but Schapire gives a weak proper learner for exactly this class. So it does not refute the weak proper target.

**Second-pass check: constant-advantage DNF hardness.** Khot and Saket prove that, under the standard assumption $\mathrm{NP}\not\subseteq\mathrm{RP}$, two-term DNF cannot be PAC learned by any fixed number of DNF terms to accuracy $1/2+\epsilon$ for constant $\epsilon>0$. This is close to a counterexample to weak properization.

**Why it is only a near miss.** The target node uses Schapire's inverse-polynomial weak advantage convention, not a constant-advantage convention. Khot and Saket's lower bound does not rule out an advantage such as $1/\operatorname{poly}(n)$, and the fixed-$k$ DNF argument recorded in the atlas gives exactly that kind of weak proper learner. So their theorem warns that a stronger weak node could behave differently, but it does not settle this edge as written.

**Conclusion.** The edge remains open. A counterexample would need a class with an efficient improper realizable learner but no efficient way to find even a slightly-better-than-random member of $\mathcal C$ on realizable distributions.

## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
- [Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)
- [Khot and Saket 2008](https://doi.org/10.1109/FOCS.2008.37)
