---
type: argument
id: full-support-marginal-uniformization
title: Full-Support Marginal Uniformization
domain: binary-classification
model: pac
status: "true"
evidence: theorem
ref_keys:
  - benedek1991fixed
  - bendavid1995parameterization
  - hanneke2025marginalnonuniform
refs:
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
  - "[Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)"
  - "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
tags:
  - atlas/argument
  - learning/binary-classification
---

# Full-Support Marginal Uniformization

## Verdict

`true`, under the atlas convention that efficient PAC sample use and running time are worst-case bounds on finite encoded sample transcripts.

For a single marginal-nonuniform learner, a full-support reference marginal turns a marginal-dependent worst-case resource polynomial into one distribution-free resource polynomial. Accuracy is not transferred from the reference marginal; it comes directly from the source guarantee for the target marginal.

## Theorem Statement

Let $\mathcal C$ be a binary concept class and let $A$ be a single PAC learner. Suppose that for every marginal distribution $P$ over instances there is a polynomial $p_P$ such that, for every realizable or agnostic labeling distribution with instance marginal $P$, $A$ satisfies the relevant PAC error guarantee and has worst-case, pathwise sample and running-time bounded by $p_P$ on every finite encoded sample transcript. If there is a reference marginal $P^\star$ with full support on every finite encoded instance in each size slice, then $p_{P^\star}$ is a single distribution-free polynomial resource bound for $A$. The accuracy guarantee under any actual marginal $P$ is still obtained by applying the original fixed-$P$ guarantee, not by transferring accuracy from $P^\star$.

## Proof Sketch

Let $A$ be the single learner promised by the marginal-nonuniform source. Choose a reference marginal $P^\star$ with full support on every finitely encoded instance in each representation-size slice. Applying the source to $P^\star$ gives a polynomial $p_{P^\star}$ bounding $A$'s sample use and running time.

Every finite labeled transcript that can occur under any marginal has positive probability under $P^\star$ for a suitable target or conditional label rule. If $A$ exceeded $p_{P^\star}$ on that transcript, it would violate the source's worst-case resource bound for $P^\star$. Thus $p_{P^\star}$ is one distribution-free sample/time bound for $A$.

For accuracy, fix the actual marginal $P$ and apply the source guarantee directly to $P$. Combining that accuracy statement with the uniform resource bound proves the corresponding distribution-free efficient target whenever the remaining target requirements are already met by the source.

## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
