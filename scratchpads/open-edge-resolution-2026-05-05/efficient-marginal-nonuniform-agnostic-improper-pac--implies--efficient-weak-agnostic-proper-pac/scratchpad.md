# Edge: efficient-marginal-nonuniform-agnostic-improper-pac -> efficient-weak-agnostic-proper-pac

- depth: 1
- edge_file: atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-weak-agnostic-proper-pac.md
- verdict: resolved-false
- confidence: high, conditional on the existing PCP active-slice witness and the assumption $\mathrm{NP}\nsubseteq\mathrm{RP}$

## Context

The edge asks whether [[efficient-marginal-nonuniform-agnostic-improper-pac|Efficient Marginal-Nonuniform Agnostic Improper PAC Learning]] implies [[efficient-weak-agnostic-proper-pac|Efficient Weak Agnostic Proper PAC Learning]].

The current edge note marks the edge open because it combines two apparent obstacles:

- marginal-nonuniform-to-distribution-free resource uniformization;
- improper-to-proper output conversion, even after weakening strong agnostic accuracy to a fixed additive weak agnostic tolerance.

The first obstacle is not needed for a counterexample. The existing atlas edge
`efficient-agnostic-improper-pac -> efficient-weak-agnostic-proper-pac`
is already false under $\mathrm{NP}\nsubseteq\mathrm{RP}$ via [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]. Since distribution-free efficient agnostic improper learning implies the marginal-nonuniform agnostic improper source, the same witness refutes this assigned edge.

## Attempted Resolution

**Goal.** Find a class satisfying the assigned source but not the distribution-free weak agnostic proper target.

Use the [[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]]. Proper hypotheses encode an NP instance $\varphi$ and a proof $\pi$. On an example $(\psi,r)$, the hypothesis runs the PCP verifier on $(\varphi,\pi,r)$ when $\psi=\varphi$, and otherwise outputs $0$.

**Why the source holds.** The stronger node [[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]] holds for this class. The improper learner uses the finite class of all one-slice lookup tables, together with the all-zero hypothesis. Each active slice has polynomial size because the PCP has logarithmic randomness. On a sample, only slices that actually occur in the sample can improve over the all-zero hypothesis, and the best table on any sampled slice is computed by majority vote on the sampled verifier-randomness points.

This is polynomial-time ERM over an improper class whose logarithmic size is polynomial and which contains every proper hypothesis. Standard finite-class uniform convergence therefore gives distribution-free efficient agnostic improper PAC learning against the proper benchmark class. Distribution-free source learning is stronger than marginal-nonuniform source learning, so the assigned source is satisfied.

**Why the target fails.** Suppose an efficient weak agnostic proper learner existed for this class. On input an NP instance $\varphi$, sample uniformly from the active slice $\{(\varphi,r)\}$ and label every point by $1$.

If $\varphi$ is satisfiable, perfect completeness gives a proof $\pi$ whose proper hypothesis has error $0$ on this distribution. The weak agnostic guarantee with fixed $\beta<1/2$ forces the learner, with high probability, to output a proper hypothesis with error at most $\beta$, equivalently acceptance probability at least $1-\beta>1/2$ on the active slice.

If $\varphi$ is unsatisfiable, PCP soundness gives that every proper hypothesis is accepted on at most an $s<1/2$ fraction of verifier random strings. Since the active slice has polynomial size, the reduction can evaluate or estimate the returned proper hypothesis's acceptance probability in polynomial time and accept exactly when it is above $1/2$.

Thus an efficient weak agnostic proper learner would put an NP-complete language in $\mathrm{RP}$, contradicting $\mathrm{NP}\nsubseteq\mathrm{RP}$.

**Conclusion.** The implication is false under $\mathrm{NP}\nsubseteq\mathrm{RP}$. The existing open note is too conservative for the distribution-free target: the properization obstruction is already witnessed by the PCP active-slice construction, and the marginal-nonuniform source is satisfied because the witness has the stronger distribution-free agnostic improper learner.

## Proposed Atlas Update

Frontmatter changes:

```yaml
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
summary: "False under NP not subset RP: the PCP active-slice lookup class is distribution-free agnostically learnable improperly, hence marginal-nonuniform agnostically learnable improperly, but weak agnostic proper learning would decide an NP-complete language."
family: pcp-active-slice-weak-proper-hardness
argument_note: "[[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]"
witness_note: "[[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]]"
```

Suggested replacement body:

```markdown
## Verdict

`false`, under the assumption $\mathrm{NP}\nsubseteq\mathrm{RP}$.

The [[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]] is efficiently agnostically learnable by an improper one-slice lookup-table ERM, and therefore satisfies the marginal-nonuniform agnostic improper source. However, an efficient weak agnostic proper learner for the same class would decide an NP-complete language with one-sided randomized error.

## Proof Status

Use the PCP active-slice class from [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]. Proper hypotheses encode an NP instance $\varphi$ and a proof $\pi$; on an example $(\psi,r)$ they run the verifier on $(\varphi,\pi,r)$ if $\psi=\varphi$, and output $0$ otherwise.

**Why the source holds.** The class satisfies the stronger distribution-free [[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]] node. An improper learner performs ERM over one-slice lookup tables and the all-zero hypothesis. The verifier uses logarithmic randomness, so each active slice is polynomial size; only sampled slices need be considered, and the best table on a sampled slice is obtained by majority vote. Since every proper hypothesis is one such lookup table, finite-class uniform convergence gives efficient agnostic improper learning. This immediately implies the marginal-nonuniform source.

**Why the target fails.** Given an NP instance $\varphi$, sample uniformly from the active slice $\{(\varphi,r)\}$ and label every example by $1$. If $\varphi$ is satisfiable, perfect completeness gives proper error $0$, so a weak agnostic proper learner must output a proof accepted on more than half of verifier random strings. If $\varphi$ is unsatisfiable, PCP soundness keeps every proof below one-half acceptance. The active slice is polynomial size, so the returned hypothesis's acceptance can be checked in polynomial time, yielding an $\mathrm{RP}$ algorithm for an NP-complete language.

## References

- [Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)
- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
- [Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)
- [Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)
```

## Obstacles

No obstacle remains for this distribution-free target. The obstacle found in the sibling edge
`efficient-marginal-nonuniform-agnostic-improper-pac -> efficient-marginal-nonuniform-weak-agnostic-proper-pac`
does not apply here, because the target learner is distribution-free. The reduction may choose the hard active-slice marginal from the input instance $\varphi$.

The only caveat is that the result is conditional on $\mathrm{NP}\nsubseteq\mathrm{RP}$ and on the PCP active-slice witness as already recorded in the atlas.

## Next Directions

1. Update the assigned atlas edge to use `status: "false"` with the PCP active-slice witness.
2. Keep the marginal-nonuniform weak proper target edge separate; there the hard active slice would have to be encoded without varying the marginal, which is the obstruction noted by the neighboring scratchpad.

## References Checked

- `scratchpads/open-edge-resolution-2026-05-05/README.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-agnostic-improper-pac.md`
- `atlas/definitions/efficient-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-agnostic-improper-pac.md`
- `atlas/implications/efficient-agnostic-improper-pac--implies--efficient-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-weak-agnostic-proper-pac.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `references.bib` entries for `bendavid2001`, `blumer1989`, `hastad2005query`, and `karp1972`
