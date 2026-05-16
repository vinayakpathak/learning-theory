---
type: readme
id: multiclass-atlas-readme
title: Multiclass Classification Atlas
domain: multiclass-classification
tags:
- atlas/readme
- learning/multiclass-classification
---

# Multiclass Classification Atlas

This folder mirrors the binary PAC atlas for finite-label multiclass classification. The graph has its own definition and implication notes because a multiclass class has type $\mathcal C\subseteq\mathcal Y^{\mathcal X}$ rather than $\mathcal C\subseteq\{0,1\}^{\mathcal X}$.

The axis registry generates the same 32 combinations as the binary atlas:

- `resource`: `computationally-efficient -> sample-efficient`
- `distribution`: `distribution-free -> marginal-nonuniform`
- `strength`: `strong -> weak`
- `realizability`: `agnostic -> realizable`
- `properness`: `proper -> improper`

The weak axis uses a majority-accuracy convention: a weak realizable multiclass learner has error at most $1/2-\gamma$. This is intentionally comparable with the binary atlas and should not be read as the only possible large-label weak-learning notion.

Binary separation witnesses are embedded by using two labels in a larger finite alphabet and ignoring the rest. This transfers lower bounds into the multiclass type without adding any cross-domain implication edges.
