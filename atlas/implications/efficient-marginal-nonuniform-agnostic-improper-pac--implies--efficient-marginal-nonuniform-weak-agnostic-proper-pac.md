---
type: implication
id: efficient-marginal-nonuniform-agnostic-improper-pac__implies__efficient-marginal-nonuniform-weak-agnostic-proper-pac
source: efficient-marginal-nonuniform-agnostic-improper-pac
target: efficient-marginal-nonuniform-weak-agnostic-proper-pac
source_note: "[[efficient-marginal-nonuniform-agnostic-improper-pac|Efficient Marginal-Nonuniform Agnostic Improper PAC Learning]]"
target_note: "[[efficient-marginal-nonuniform-weak-agnostic-proper-pac|Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - bendavid2001
  - feldman2010distributionspecific
  - schapire1990
  - pitt1988
  - khot2008dnf
  - hastad2005query
  - kearns1994cryptographic
  - hastad1999prg
refs:
  - "[Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)"
  - "[Feldman 2010](https://arxiv.org/abs/0909.2927)"
  - "[Schapire 1990](https://doi.org/10.1023/A:1022648800760)"
  - "[Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)"
  - "[Khot and Saket 2008](https://doi.org/10.1109/FOCS.2008.37)"
  - "[Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)"
  - "[Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)"
  - "[Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)"
summary: "Open: no efficient marginal fixed properization is known, and standard separation routes lose either the weak gap or efficient agnostic improper learnability."
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

# Efficient Marginal-Nonuniform Agnostic Improper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning

## Verdict

`open`.

This edge asks whether strong marginal-nonuniform agnostic improper learning always gives weak marginal-nonuniform agnostic proper learning.

## Proof Status

**Goal.** Convert an efficient strong agnostic improper learner into a proper learner with inverse-polynomial excess-error advantage under the same fixed marginal. The source can output any hypothesis $g$ satisfying

$$
\operatorname{err}_{\mathcal D}(g)
\le
\operatorname{OPT}_{\mathcal C}+\varepsilon,
$$

but the target must output $h\in\mathcal C$ with error at most $\operatorname{OPT}_{\mathcal C}+\beta_P(s)$ for a marginal-dependent weak tolerance $\beta_P(s)<1/2$.

**Theorem route.** Uniform convergence and finite-class ERM show that good proper hypotheses exist on sufficiently large samples. They do not give an efficient approximate proper ERM or projection from the improper output back into $\mathcal C$. Boosting is also a near miss: the source is already strong, and agnostic boosting constructions typically output votes or aggregates outside the base class rather than a single proper concept.

**Counterexample route.** Known hardness templates do not yet give a fixed-marginal weak agnostic proper separation with an easy strong agnostic improper learner.

Clause-satisfaction and PCP active-slice constructions either give only strong-accuracy gaps or place the hard instance in the marginal. Marginal-nonuniform learning allows the runtime polynomial and weak advantage to depend on that marginal, so an input-specific marginal does not yield a uniform polynomial-time contradiction. Packing all hard slices into one fixed marginal multiplies the gap by the slice mass, and some length-$n$ slices must then fall below the hidden inverse-polynomial advantage of the target learner.

One-way image-coordinate witnesses give strong proper hardness with an agnostic improper source, but their fixed all-length marginal leaves weak learners with low-mass or wrong-length handles. Dense shared-code repairs would need distance from every wrong image at the unknown weak-gap scale, while still preserving efficient agnostic improper learning. Balanced Hadamard or parity encodings have the right weak geometry at a fixed length, but competing agnostically with the best image parity becomes a noisy-parity-type task rather than an evident efficient improper learner.

**Conclusion.** The edge remains open as a marginal-nonuniform properization question.

## References

- [Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)
- [Feldman 2010](https://arxiv.org/abs/0909.2927)
- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
- [Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)
- [Khot and Saket 2008](https://doi.org/10.1109/FOCS.2008.37)
- [Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)
- [Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)
- [Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)
