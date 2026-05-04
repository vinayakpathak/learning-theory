---
type: argument
id: sample-complexity-equivalence
title: Sample-Complexity Equivalence
domain: binary-classification
model: pac
status: "true"
evidence: theorem
ref_keys:
  - valiant1984
  - blumer1989
  - schapire1990
  - freund1995boosting
  - bendavid2001
  - kalai2008agnosticboosting
  - benedek1991fixed
  - hanneke2025marginalnonuniform
refs:
  - "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
  - "[Schapire 1990](https://doi.org/10.1023/A:1022648800760)"
  - "[Freund 1995](https://doi.org/10.1006/inco.1995.1136)"
  - "[Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)"
  - "[Kalai et al. 2008](https://doi.org/10.1145/1374376.1374466)"
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
  - "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
tags:
  - atlas/argument
  - learning/binary-classification
---

# Sample-Complexity Equivalence

## Verdict

`true`, for the sample-only binary PAC notions tracked here.

Once running time is ignored, empirical risk minimization over the benchmark class is an admissible learner. In the distribution-free binary setting, finite VC dimension characterizes realizable and agnostic PAC learnability, and the same uniform-convergence bounds support proper learning whenever the benchmark class itself is the output class.

For weak-to-strong directions, classical boosting is the algorithmic reference point: Schapire's weak-to-strong theorem and Freund's boost-by-majority show how a weak realizable advantage can be amplified. The sample-only edges do not need to implement that booster efficiently. They use the same finite-sample consequence instead: a binary class that is weakly learnable with polynomial samples is on the finite-dimensional side of the VC sample-complexity characterization, so standard uniform convergence supplies arbitrary accuracy once unbounded ERM is allowed.

For the agnostic weak-to-strong directions, the route is two-step. First, a weak agnostic learner with fixed tolerance $\beta<1/2$ is a weak realizable learner when restricted to realizable labeled distributions, because then $\inf_{c\in\mathcal C}\operatorname{err}(c)=0$. Second, the resulting finite-dimensional sample control gives agnostic learning by ERM: with a sufficiently large sample, every $c\in\mathcal C$ has empirical error close to true error, so an empirical minimizer satisfies $\operatorname{err}(h)\le \inf_{c\in\mathcal C}\operatorname{err}(c)+\varepsilon$. This is the sample-complexity counterpart of agnostic boosting, as studied by Ben-David--Long--Mansour and Kalai--Mansour--Verbin, but it does not assert a polynomial-time black-box conversion for the atlas's fixed-additive weak agnostic node.

In the marginal-nonuniform setting, the same reasoning is applied at a fixed marginal when the target remains marginal-nonuniform, with the polynomial allowed to depend on that marginal. When a marginal-nonuniform sample source is used to prove a distribution-free target, Hanneke, Moran, and Thiessen's trichotomy supplies the additional uniformization step.

The marginal-to-distribution-free step is also settled at the sample-only polynomial-rate level. Hanneke, Moran, and Thiessen's trichotomy says that binary classes with finite VC dimension have linear marginal-nonuniform rates, while classes with infinite VC dimension require arbitrarily slow marginal-nonuniform rates. Thus a polynomial marginal-nonuniform sample guarantee forces finite VC dimension, and standard VC theory gives the distribution-free sample-efficient target.

This argument does not settle computational marginal-to-distribution-free uniformization. A learner whose running-time polynomial may depend on the marginal distribution need not come with one polynomial-time bound that works uniformly over all marginals. Those computational edges remain in [[marginal-uniformization-open|Marginal Uniformization Open]].

## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
- [Freund 1995](https://doi.org/10.1006/inco.1995.1136)
- [Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)
- [Kalai et al. 2008](https://doi.org/10.1145/1374376.1374466)
- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
