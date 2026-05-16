---
type: argument
id: multiclass-marginal-weak-sample-collapse-counterexample
title: Marginal Weak Sample Collapse Counterexample
domain: multiclass-classification
model: pac
status: 'false'
evidence: counterexample
witnesses:
- multiclass-unrestricted-labelings
witness_note: "[[multiclass-unrestricted-labelings|Unrestricted Labelings]]"
assumptions: []
ref_keys:
- valiant1984
- blumer1989
- benedek1991fixed
- hanneke2025marginalnonuniform
refs:
- "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
- "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
- "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
- "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
tags:
- atlas/argument
- learning/multiclass-classification
---

# Marginal Weak Sample Collapse Counterexample

## Verdict

`false`, with evidence `counterexample`.

The goal is to separate fixed-marginal weak sample learnability from both distribution-free sample learnability and fixed-marginal strong sample learnability.

Use a countably infinite instance space and fix two active labels inside a finite multiclass label set. The class contains all functions from the instance space to those two active labels. This is the finite-multiclass embedding of unrestricted binary labelings, and it is proper-friendly for active-label prediction rules.

For any fixed marginal, weak learning is easy. Choose a finite set carrying enough probability mass to make the remaining tail below the fixed weak tolerance, estimate the best label on that finite set, and output arbitrary labels elsewhere. In the realizable case this memorizes the target on the high-mass set; in the agnostic case empirical majority labels approximate the Bayes rule on that set. Because the weak tolerance is fixed, the finite set and the required sample bound may depend on the marginal.

Strong marginal-nonuniform sample efficiency does not follow. Some fixed countable marginals have tails whose high-mass truncation size grows faster than any polynomial in $1/\varepsilon$. On such marginals, unrestricted labelings force a learner to see essentially all high-mass points needed for the desired accuracy, so no marginal-dependent polynomial strong rate exists.

Distribution-free weak learning also fails by the standard no-free-lunch argument for unrestricted labelings. For every proposed sample bound, choose a marginal spread over many more atoms than the sample can cover and choose labels adversarially on the unseen mass. The learner has no information about enough of the domain to guarantee error below the majority threshold.

## Scope

This is the main place where the binary sample-only conclusion does not transfer to the multiclass atlas as originally recorded. Multiclass sample-complexity theory still gives the usual positive characterizations for finite-dimensional classes, but unrestricted countable labelings show that marginal-nonuniform weak sample learnability is strictly weaker than the strong or distribution-free sample nodes tracked here.


## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
