---
type: implication
id: efficient-agnostic-improper-pac__implies__efficient-agnostic-proper-pac
source: efficient-agnostic-improper-pac
target: efficient-agnostic-proper-pac
source_note: "[[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]]"
target_note: "[[efficient-agnostic-proper-pac|Efficient Agnostic Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - kearns1994
  - pitt1988
  - khot2008dnf
refs:
  - "[Kearns et al. 1994](https://doi.org/10.1023/A:1022615600103)"
  - "[Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)"
  - "[Khot and Saket 2008](https://doi.org/10.1109/FOCS.2008.37)"
summary: "Still open: this is the strong agnostic properization problem, and the known DNF and halfspace separations do not satisfy the source in the needed way."
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Agnostic Improper PAC Learning $\Rightarrow$ Efficient Agnostic Proper PAC Learning

## Verdict

`open`.

Still open: this is the strong agnostic properization problem, and the known DNF and halfspace separations do not satisfy the source in the needed way.

## Proof Status

**Goal.** Decide whether every efficiently agnostically improperly learnable class is also efficiently agnostically properly learnable.

**What would prove it.** A proof would need a general properization procedure: from an arbitrary hypothesis whose error is within $\beta$ of $\operatorname{opt}_{\mathcal C}$, efficiently find a concept $c \in \mathcal C$ with comparable error. This is much stronger than standard uniform convergence, because empirical risk minimization over $\mathcal C$ may be computationally intractable.

**Why the known separations do not settle it.** Fixed-$k$ term DNF separates improper from proper learning in the realizable setting, but the atlas does not record an efficient strong agnostic improper learner for fixed-$k$ term DNF. Tiegel's halfspace lower bound separates realizable learning from weak agnostic learning, but halfspaces fail the source here because they are not efficiently agnostically improperly learnable under arbitrary distributions under the cited hardness assumption.

**Second-pass check: DNF weak-hardness results.** Khot and Saket show constant-advantage hardness for proper weak learning of two-term DNF by fixed-size DNF. This strengthens the evidence that properization can be computationally delicate, but it does not give the needed source-side learner: it does not exhibit a class that is strongly agnostically improperly learnable while strongly agnostically properly hard.

**Conclusion.** The edge remains open in this atlas. It should be settled either by a black-box agnostic properization theorem or by a class with efficient strong agnostic improper learning and hard strong agnostic proper learning.

## References

- [Kearns et al. 1994](https://doi.org/10.1023/A:1022615600103)
- [Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)
- [Khot and Saket 2008](https://doi.org/10.1109/FOCS.2008.37)
