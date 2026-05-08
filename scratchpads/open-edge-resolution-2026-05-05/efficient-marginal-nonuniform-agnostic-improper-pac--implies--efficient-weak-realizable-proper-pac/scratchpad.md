# Edge: efficient-marginal-nonuniform-agnostic-improper-pac -> efficient-weak-realizable-proper-pac

- depth: 1
- edge_file: atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-weak-realizable-proper-pac.md
- verdict: resolved-false
- confidence: high

## Context

The current edge note marks this as open under [[properization-open|Properization Open]], emphasizing the marginal-nonuniform-to-distribution-free axis. That is not the binding obstruction for this edge: the source is weaker than distribution-free agnostic improper PAC learning, and the atlas already has a distribution-free agnostic-improper witness that fails the same distribution-free weak proper target.

The nearby resolved edge
`efficient-agnostic-improper-pac -> efficient-weak-realizable-proper-pac`
uses [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]. Because distribution-free efficient agnostic improper learning immediately implies efficient marginal-nonuniform agnostic improper learning, the same witness resolves the assigned edge.

## Attempted Resolution

**Goal.** Exhibit a class satisfying efficient marginal-nonuniform agnostic improper PAC learning but not efficient weak realizable proper PAC learning.

Use the [[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]]. From a perfect-completeness PCP with logarithmic randomness and soundness $s < 1/2$, define proper hypotheses indexed by an NP instance $\varphi$ and proof string $\pi$. On an example $(\psi,r)$, the hypothesis runs the verifier $V(\varphi,\pi,r)$ if $\psi=\varphi$, and otherwise outputs $0$.

### Why The Source Holds

For agnostic improper learning, use the improper class of one-slice lookup tables, together with the all-zero hypothesis. A one-slice lookup table chooses an active slice $\psi$ and an arbitrary Boolean table over the polynomially many verifier random strings for that slice.

This improper class contains all proper PCP hypotheses. Its logarithmic size is polynomial in the instance length: specifying the slice and the table over $2^{O(\log n)}=\operatorname{poly}(n)$ random strings takes polynomially many bits. ERM is polynomial-time on a sample: only sampled slices can improve over the all-zero hypothesis, and on each sampled slice the best table is obtained by empirical majority vote on the sampled random strings.

Finite-class uniform convergence, as in the standard Blumer et al. PAC bounds, gives efficient distribution-free agnostic improper learning against the proper class. Therefore the witness satisfies the assigned source, since distribution-free polynomial sample and runtime bounds are valid marginal-by-marginal.

### Why The Target Fails

Assume an efficient weak realizable proper learner for this class. Given an input NP instance $\varphi$, sample uniformly from the active slice $\{(\varphi,r)\}$ and label every sampled point by $1$.

If $\varphi$ is satisfiable, perfect completeness gives a proof $\pi$ accepted on every random string, so this labeled distribution is realizable by a proper hypothesis. The weak proper learner must then return a proper hypothesis with error at most $1/2-\gamma(n)$, hence acceptance greater than $1/2$ on the $\varphi$ slice.

If $\varphi$ is unsatisfiable, PCP soundness says every proof is accepted on at most an $s<1/2$ fraction of random strings. A proper hypothesis for a different active instance outputs $0$ on the $\varphi$ slice, so it also cannot have acceptance greater than $1/2$ there.

The active slice has polynomial size, so the reduction can estimate, or simply enumerate, the returned hypothesis's acceptance probability on the slice in polynomial time. Thus the assumed weak proper learner would decide an NP-complete language with one-sided randomized polynomial time, implying $\mathrm{NP}\subseteq\mathrm{RP}$. Under the assumption $\mathrm{NP}\nsubseteq\mathrm{RP}$, the target node fails.

Therefore the assigned implication is false under the stated complexity assumption.

## Proposed Atlas Update

Set the edge to the same counterexample family as `efficient-agnostic-improper-pac -> efficient-weak-realizable-proper-pac`:

```yaml
status: "false"
evidence: conditional-counterexample
result_origin: "unclear"
assumptions:
  - "NP not subset RP"
witnesses:
  - pcp-active-slice-lookup-class
ref_keys:
  - blumer1989
  - hastad2005query
  - karp1972
refs:
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
  - "[Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)"
  - "[Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)"
summary: "False under NP not subset RP: the PCP active-slice lookup class is efficiently agnostically learnable improperly, hence marginal-nonuniform agnostically learnable improperly, but weak proper realizable learning would decide an NP-complete language."
family: pcp-active-slice-weak-proper-hardness
argument_note: "[[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]"
witness_note: "[[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]]"
```

Suggested replacement body:

```markdown
## Verdict

`false`, under the assumption $\mathrm{NP}\nsubseteq\mathrm{RP}$.

The [[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]] is efficiently agnostically learnable by an improper one-slice lookup-table ERM, and therefore satisfies the marginal-nonuniform agnostic improper source. An efficient weak proper realizable learner would decide an NP-complete language with one-sided randomized error.

## Proof Status

**Goal.** Separate marginal-nonuniform agnostic improper learning from distribution-free weak realizable proper learning.

**Witness construction.** Use the PCP active-slice class from [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]. A proper concept is indexed by an NP instance $\varphi$ and a proof $\pi$; on an example $(\psi,r)$ it runs the verifier on $(\varphi,\pi,r)$ if $\psi=\varphi$, and outputs $0$ otherwise.

**Why the source holds.** The verifier uses $O(\log n)$ random bits, so each active slice has polynomial size. The improper learner runs ERM over one-slice lookup tables and the all-zero hypothesis. Only sampled slices need be considered, and the best table on a sampled slice is obtained by empirical majority vote. Since this finite improper class contains all proper concepts and has polynomial logarithmic size, finite-class uniform convergence gives efficient distribution-free agnostic improper learning, hence the assigned marginal-nonuniform source.

**Why the target fails.** Given an instance $\varphi$, sample uniformly from its active slice and label every point by $1$. If $\varphi$ is satisfiable, perfect completeness makes this distribution realizable by a proper concept, so a weak proper learner returns a proof accepted on more than half the random strings. If $\varphi$ is unsatisfiable, every proof is accepted on at most an $s<1/2$ fraction. The active slice is polynomial size, so acceptance can be checked to distinguish the two cases in randomized polynomial time. Thus the target would imply $\mathrm{NP}\subseteq\mathrm{RP}$.
```

## Obstacles

No remaining obstacle for a conditional resolution. The conclusion depends on $\mathrm{NP}\nsubseteq\mathrm{RP}$, matching the existing PCP active-slice argument family.

The one-way image-coordinate witness is not needed here. It is useful for strong proper hardness under fixed marginals, but it is weaker evidence for this exact edge because weak proper learning can avoid exact representation recovery in that construction. The PCP active-slice witness targets distribution-free weak proper learning directly.

## Next Directions

- Update the assigned atlas edge to `pcp-active-slice-weak-proper-hardness`.
- Replace the current `marginal-uniformization`-style summary with the properization counterexample summary above.
- Optionally audit any remaining open edges from sources at least as strong as `efficient-marginal-nonuniform-agnostic-improper-pac` to the distribution-free weak proper target; the same witness may apply.

## References Checked

- [[efficient-marginal-nonuniform-agnostic-improper-pac|Efficient Marginal-Nonuniform Agnostic Improper PAC Learning]]
- [[efficient-weak-realizable-proper-pac|Efficient Weak Realizable Proper PAC Learning]]
- [[properization-open|Properization Open]]
- [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]
- [[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]]
- `atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-agnostic-improper-pac--implies--efficient-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- Blumer et al. 1989 (`blumer1989`)
- Håstad and Khot 2005 (`hastad2005query`)
- Karp 1972 (`karp1972`)
