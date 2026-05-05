---
type: implication
id: efficient-agnostic-improper-pac__implies__efficient-weak-agnostic-proper-pac
source: efficient-agnostic-improper-pac
target: efficient-weak-agnostic-proper-pac
source_note: "[[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]]"
target_note: "[[efficient-weak-agnostic-proper-pac|Efficient Weak Agnostic Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "false"
evidence: conditional-counterexample
result_origin: "unclear"
assumptions:
  - "NP not subset RP"
witnesses:
  - pcp-active-slice-lookup-class
ref_keys:
  - bendavid2001
  - blumer1989
  - hastad2005query
  - karp1972
refs:
  - "[Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)"
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
  - "[Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)"
  - "[Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)"
summary: "False under NP not subset RP: the PCP active-slice lookup class is agnostically learnable improperly, but weak agnostic proper learning would decide an NP-complete language."
family: pcp-active-slice-weak-proper-hardness
axis_delta:
  resource: same
  distribution: same
  strength: strong-to-weak
  realizability: same
  properness: improper-to-proper
argument_note: "[[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]"
witness_note: "[[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Agnostic Improper PAC Learning $\Rightarrow$ Efficient Weak Agnostic Proper PAC Learning

## Verdict

`false`, under the assumption $\mathrm{NP}\nsubseteq\mathrm{RP}$.

The PCP active-slice lookup class is efficiently agnostically learnable improperly, but weak agnostic proper learning would decide an NP-complete language.

## Proof Status

Use the PCP active-slice lookup class from [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]. The class is efficiently agnostically learnable improperly by ERM over one-slice lookup tables. The logarithmic-randomness PCP makes each active slice polynomial size, and only sampled slices need be considered during ERM.

If a weak agnostic proper learner existed, run it on the all-positive uniform distribution over the active verifier-randomness slice of an input instance $\varphi$. Perfect completeness gives zero proper error on satisfiable instances, so the weak learner returns a proof accepted on more than half the random strings. Soundness keeps every proper hypothesis below one-half acceptance on unsatisfiable instances. Since the active slice is polynomial size, the returned proper hypothesis's acceptance can be checked exactly, giving a one-sided randomized polynomial-time algorithm for an NP-complete language.

## References

- [Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)
- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
- [Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)
- [Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)
