# Edge: efficient-marginal-nonuniform-weak-agnostic-improper-pac -> efficient-weak-agnostic-proper-pac

- depth: 1
- edge_file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-weak-agnostic-proper-pac.md`
- verdict: resolved-false
- confidence: high

## Context

The current edge note marks this as open under [[properization-open|Properization Open]], with both a marginal-nonuniform-to-distribution-free resource issue and an improper-to-proper issue.

For this exact target, the marginal-uniformization issue is not binding. The target is distribution-free weak agnostic proper learning, and the atlas already has a distribution-free improper witness that fails this same target. Since distribution-free efficient agnostic improper learning implies the assigned source,

$$
\text{efficient agnostic improper PAC}
\Rightarrow
\text{efficient marginal-nonuniform weak agnostic improper PAC},
$$

the same witness separates the assigned source from the target.

Relevant existing notes checked:

- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-weak-agnostic-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/arguments/marginal-agnostic-hardness-open.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- sibling resolved edge `atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-weak-agnostic-proper-pac.md`
- sibling resolved edge `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-weak-agnostic-proper-pac.md`

## Resolution

**Goal.** Exhibit a class satisfying `efficient-marginal-nonuniform-weak-agnostic-improper-pac` but not `efficient-weak-agnostic-proper-pac`.

Use the [[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]] from [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]. Start from a perfect-completeness PCP for an NP-complete language with $O(\log n)$ verifier randomness and soundness $s<1/2$.

A proper concept is indexed by an instance $\varphi$ and proof string $\pi$. On an example $(\psi,r)$ it outputs $V(\varphi,\pi,r)$ if $\psi=\varphi$, and outputs $0$ otherwise. Thus each proper concept is active on one instance slice and zero elsewhere.

## Why The Source Holds

The class satisfies a stronger source: efficient distribution-free agnostic improper PAC learning.

The improper learner competes with the proper class by running ERM over the finite improper class of all one-slice lookup tables, plus the all-zero hypothesis. A one-slice table chooses a slice $\psi$ and assigns arbitrary labels to the verifier-randomness strings on that slice. Since the verifier uses $O(\log n)$ random bits, each slice has polynomial size, and the logarithm of the one-slice table class size is polynomial in the representation length.

ERM over this improper class is polynomial time on a sample. Only sampled slices can improve over the all-zero hypothesis, and for each sampled slice the best table is obtained by empirical majority vote on the sampled random strings. Every proper PCP hypothesis is one of these one-slice tables, so finite-class uniform convergence gives agnostic improper learning against the proper benchmark class.

Therefore the witness satisfies `efficient-agnostic-improper-pac`, and hence the assigned source. To see the final implication explicitly, run the distribution-free agnostic improper learner with a fixed weak tolerance, for example $\varepsilon=1/4$. For every marginal $P$, take the same distribution-free sample and runtime polynomial as $p_P$ and take $\beta_P=1/4$.

## Why The Target Fails

Assume an efficient weak agnostic proper learner for this class. I will use it to decide the NP-complete language in randomized polynomial time.

Given an instance $\varphi$, sample uniformly from its active slice $\{(\varphi,r)\}$ and label every example by $1$.

If $\varphi$ is satisfiable, perfect completeness gives a proof $\pi$ accepted on every verifier random string. Thus the labeled distribution has proper optimum $0$. A weak agnostic proper learner must return a proper hypothesis with error at most some $\beta<1/2$, equivalently a proof accepted on more than half of the verifier random strings.

If $\varphi$ is unsatisfiable, PCP soundness says every proof is accepted on at most an $s<1/2$ fraction of verifier random strings on the $\varphi$ slice. Proper hypotheses for other active instances output $0$ on this slice, so they also cannot have acceptance above $1/2$.

The active slice has polynomial size, so after the learner returns its proper hypothesis, the reduction can enumerate all verifier random strings and compute its exact acceptance rate in polynomial time. Acceptance greater than $1/2$ distinguishes satisfiable instances from unsatisfiable instances with the learner's success probability. Thus an efficient weak agnostic proper learner would imply $\mathrm{NP}\subseteq\mathrm{RP}$.

Under the standard assumption $\mathrm{NP}\nsubseteq\mathrm{RP}$, the target fails.

## Why This Bypasses The Open Obstacles

The open marginal-uniformization notes matter when the target demands marginal-nonuniform learning under one fixed marginal, because a PCP active slice can vary with the input instance. Here the target is distribution-free. A refutation is allowed to choose, for each input $\varphi$, the distribution uniform on that active slice, because the alleged target learner must work uniformly over all distributions with one polynomial bound.

The open weak properization notes also do not block this separation, because the PCP active-slice construction is already designed to make even weak proper output computationally hard. The improper learner can use arbitrary one-slice lookup tables; a proper learner must output a PCP proof.

## Proposed Atlas Update

Change the assigned edge from open to the PCP active-slice counterexample family:

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
summary: "False under NP not subset RP: the PCP active-slice lookup class is distribution-free agnostically learnable improperly, hence satisfies the marginal-nonuniform weak agnostic improper source, but weak agnostic proper learning would decide an NP-complete language."
family: pcp-active-slice-weak-proper-hardness
argument_note: "[[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]"
witness_note: "[[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]]"
```

Suggested replacement body:

```markdown
## Verdict

`false`, under the assumption $\mathrm{NP}\nsubseteq\mathrm{RP}$.

The [[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]] is efficiently agnostically learnable by an improper one-slice lookup-table ERM, hence satisfies the marginal-nonuniform weak agnostic improper source. However, an efficient weak agnostic proper learner for the same class would decide an NP-complete language with one-sided randomized error.

## Proof Status

**Goal.** Separate marginal-nonuniform weak agnostic improper learning from distribution-free weak agnostic proper learning.

**Witness construction.** Use the PCP active-slice class from [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]. Proper hypotheses encode an NP instance $\varphi$ and a proof $\pi$; on examples $(\psi,r)$ they run the verifier on $(\varphi,\pi,r)$ if $\psi=\varphi$, and output $0$ otherwise.

**Why the source holds.** The class satisfies the stronger distribution-free [[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]] node. The improper learner runs ERM over one-slice lookup tables and the all-zero hypothesis. The verifier has logarithmic randomness, so each active slice is polynomial size; only sampled slices need be considered, and the best table on a sampled slice is obtained by empirical majority vote. Since every proper hypothesis is one such table, finite-class uniform convergence gives efficient agnostic improper learning. Running this learner at any fixed weak tolerance gives the assigned marginal-nonuniform weak source.

**Why the target fails.** Given an NP instance $\varphi$, sample uniformly from its active slice and label every example by $1$. If $\varphi$ is satisfiable, perfect completeness makes the distribution realizable by a proper hypothesis, so a weak agnostic proper learner returns a proof accepted on more than half of verifier random strings. If $\varphi$ is unsatisfiable, soundness keeps every proof below one-half acceptance. The active slice is polynomial size, so the returned hypothesis's acceptance can be checked in polynomial time, yielding an $\mathrm{RP}$ algorithm for an NP-complete language.
```

## Depth-2 Directions

No depth-2 work is needed for this conditional resolution. Useful follow-up audit: any remaining open edge with target `efficient-weak-agnostic-proper-pac` and a source implied by distribution-free efficient agnostic improper learning should be checked against the same PCP active-slice witness.

## Final Verdict

verdict: resolved-false

confidence: high
