---
type: implication
id: efficient-weak-realizable-proper-pac__implies__efficient-weak-agnostic-proper-pac
source: efficient-weak-realizable-proper-pac
target: efficient-weak-agnostic-proper-pac
source_note: "[[efficient-weak-realizable-proper-pac|Efficient Weak Realizable Proper PAC Learning]]"
target_note: "[[efficient-weak-agnostic-proper-pac|Efficient Weak Agnostic Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "false"
evidence: conditional-counterexample
assumptions:
  - "worst-case lattice hardness"
witnesses:
  - "halfspaces"
ref_keys:
  - tiegel2023
refs:
  - "[Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)"
summary: "Halfspaces are efficiently realizably properly learnable, but Tiegel rules out weak agnostic learning even with arbitrary binary hypotheses under worst-case lattice hardness."
family: halfspace-agnostic-hardness
axis_delta:
  distribution: same
  strength: same
  realizability: realizable-to-agnostic
  properness: same
argument_note: "[[halfspace-agnostic-hardness|Halfspace Agnostic Hardness]]"
witness_note: "[[halfspaces|Halfspaces]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Realizable Proper PAC Learning $\Rightarrow$ Efficient Weak Agnostic Proper PAC Learning

## Verdict

`false`, under the worst-case lattice hardness assumption used by Tiegel.

Halfspaces satisfy the realizable source node, but Tiegel rules out even weak agnostic improper learning of halfspaces under the cited lattice assumption.

## Counterexample

**Goal.** Refute the implication by finding a class that is efficiently weakly realizably properly learnable but not weakly agnostically learnable, even improperly.

**Witness class.** Let $\mathcal C$ be the class of Boolean halfspaces over $\mathbb R^d$.

**Why the source property holds.** Halfspaces are efficiently realizably properly PAC learnable. Draw a polynomial-size sample, find a separating halfspace consistent with the sample by linear feasibility, and use the VC dimension of halfspaces to generalize from consistency on the sample to small true error. This proves the strong realizable proper node, and hence also every weaker realizable source node: improper output is allowed to be proper, and strong learning implies weak learning.

**Why the target property fails.** Tiegel proves, assuming worst-case lattice hardness, that there is no efficient algorithm that outputs any binary hypothesis with error better than $1/2-\gamma$ even when the best halfspace has error as small as $\delta$, for parameters where $\gamma$ is inverse-polynomially small and $\delta$ is negligible enough for the argument.

Fix the atlas weak agnostic tolerance $\beta<1/2$, and let $a=1/2-\beta>0$. Choose the hard Tiegel parameters so that $\delta+\gamma<a$. If a weak agnostic learner for halfspaces existed, then on the hard distribution it would output $h$ with

$$
\operatorname{err}(h)
\le
\operatorname{opt}_{\mathcal C}+\beta
\le
\delta+\beta
<
1/2-\gamma,
$$

contradicting the lower bound. A weak agnostic proper learner is a special case of a weak agnostic improper learner, so the same lower bound rules it out.

**Conclusion.** Halfspaces satisfy the source but fail the target under Tiegel's lattice-hardness assumption, so this implication is false under that assumption.

## References

- [Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)
