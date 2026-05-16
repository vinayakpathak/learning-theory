# Promising Directions

## D001: Formal Pure Weak-Oracle Barrier

Define the weakest useful oracle model first. Specify:

- whether hypotheses may be randomized or deterministic;
- what query objects are allowed;
- whether the learner receives labeled samples or only oracle replies;
- what counts as an uninformative dummy answer.

Target theorem: in a pure weak-oracle-only model, if every adaptive query
remains in $\rho_C(Q)\le 2\beta$, then a valid dummy oracle transcript contains
no `epsilon`-scale information. Keep the conclusion explicitly black-box.

## D002: PAC-Relevant Barrier Via SQ-Style Construction

Try to strengthen D001 by adding sample access and proving computational or SQ
indistinguishability of the full sample-plus-oracle transcript. The construction
must handle arbitrary improper final predictors and adaptive reweighting.

Candidate shape: many tiny correlations in high dimension, where every
polynomially many fixed-tolerance correlation queries are uninformative, but
`OPT_C` differs by `Theta(epsilon)`.

## D003: Polynomial Clean-Witness Generator

Search for a positive primitive: given a predictor with excess more than
`epsilon`, generate a polynomial-size list of reweighted/conditioned
distributions such that one has `OPT_C < gamma` and a fixed-slack weak response
yields measurable progress.

This is the direct way around the flat-region obstruction.

## D004: Parameter-Uniform Booster Audit

Audit residual-free fixed-slack agnostic boosting results for exact dependence
on weak sample size, dual capacity, VC dimension, and representation size. Goal:
either find a natural additional hypothesis under which the atlas edge becomes
true, or isolate the precise exponential bottleneck.

## D005: Large-Easy Small-Hard Separation Search

Look for represented classes where constant advantage is efficiently detectable
for every distribution but inverse-polynomial advantage is hard. The weak
learner must satisfy `OPT + beta` distribution-free, not just on a planted
family. Avoid templates already weakened by public handles, sample-visible
blocks, or improper validation.
