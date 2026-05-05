---
type: implication
id: efficient-marginal-nonuniform-agnostic-proper-pac__implies__efficient-agnostic-proper-pac
source: efficient-marginal-nonuniform-agnostic-proper-pac
target: efficient-agnostic-proper-pac
source_note: "[[efficient-marginal-nonuniform-agnostic-proper-pac|Efficient Marginal-Nonuniform Agnostic Proper PAC Learning]]"
target_note: "[[efficient-agnostic-proper-pac|Efficient Agnostic Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: theorem
result_origin: "unclear"
assumptions: []
witnesses: []
ref_keys:
  - benedek1991fixed
  - bendavid1995parameterization
  - hanneke2025marginalnonuniform
refs:
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
  - "[Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)"
  - "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
summary: "True under the atlas worst-case efficiency convention: a full-support reference marginal gives one transcript-wise resource polynomial, while source agnostic accuracy already holds for every marginal."
family: full-support-marginal-uniformization
axis_delta:
  resource: same
  distribution: marginal-nonuniform-to-distribution-free
  strength: same
  realizability: same
  properness: same
argument_note: "[[full-support-marginal-uniformization|Full-Support Marginal Uniformization]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Agnostic Proper PAC Learning $\Rightarrow$ Efficient Agnostic Proper PAC Learning

## Verdict

`true`, by full-support marginal uniformization.

## Proof Status

Let $A$ be the single learner promised by the marginal-nonuniform source. Choose a reference marginal $P^\star$ with full support on every finitely encoded instance in each representation-size slice. The source gives a polynomial $p_{P^\star}$ bounding $A$'s sample use and running time under this marginal.

Because $P^\star$ has full support, every finite labeled transcript that can occur under any marginal and conditional label rule has positive probability under $P^\star$ for a suitable conditional label rule. Under the atlas worst-case/pathwise resource convention, $A$ cannot exceed $p_{P^\star}$ on any such transcript. Therefore $p_{P^\star}$ is one distribution-free resource bound for $A$.

Accuracy is not transferred from $P^\star$. For any actual joint distribution $\mathcal D$ with marginal $P$, apply the source guarantee directly to $P$. The source already gives proper agnostic excess error under $\mathcal D$, so the same learner $A$ is an efficient distribution-free agnostic proper learner.

## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
