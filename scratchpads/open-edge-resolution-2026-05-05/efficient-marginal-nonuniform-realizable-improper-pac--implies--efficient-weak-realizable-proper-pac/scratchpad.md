# Edge: efficient-marginal-nonuniform-realizable-improper-pac -> efficient-weak-realizable-proper-pac

- depth: 1
- edge_file: atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-weak-realizable-proper-pac.md
- verdict: resolved-false
- confidence: high

## Context

The current edge note is marked `open` under [[properization-open|Properization Open]]. It describes two possible obstructions: marginal-nonuniform-to-distribution-free uniformization and improper-to-proper weak output.

For this exact edge, the properization obstruction already gives a counterexample. The target is the distribution-free weak proper node, not the marginal-nonuniform weak proper node. Therefore a class that is even distribution-free strongly improperly learnable, but not distribution-free weakly properly learnable, separates the edge.

Files checked:

- `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-weak-realizable-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/definitions/efficient-weak-realizable-proper-pac.md`
- `atlas/definitions/efficient-realizable-improper-pac.md`
- `atlas/implications/efficient-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/implications/efficient-realizable-improper-pac--implies--efficient-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-weak-realizable-improper-pac.md`
- `atlas/implications/efficient-weak-realizable-improper-pac--implies--efficient-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-weak-realizable-proper-pac.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/marginal-uniformization-open.md`

## Resolution

**Goal.** Exhibit a concept class satisfying [[efficient-marginal-nonuniform-realizable-improper-pac|Efficient Marginal-Nonuniform Realizable Improper PAC Learning]] but failing [[efficient-weak-realizable-proper-pac|Efficient Weak Realizable Proper PAC Learning]].

Use the [[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]] from [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]].

Fix a perfect-completeness PCP for an NP-complete language with $O(\log n)$ random bits and soundness $s<1/2$. A proper concept is indexed by an instance $\varphi$ and a proof string $\pi$. On input $(\psi,r)$ it outputs the verifier decision $V(\varphi,\pi,r)$ if $\psi=\varphi$, and outputs $0$ otherwise. The active slice for $\varphi$ is

$$
S_\varphi=\{(\varphi,r): r\in\{0,1\}^{O(\log |\varphi|)}\},
$$

so $|S_\varphi|=\operatorname{poly}(|\varphi|)$.

### Why The Source Holds

The witness satisfies the stronger distribution-free node [[efficient-realizable-improper-pac|Efficient Realizable Improper PAC Learning]].

Given realizable samples from a target concept $c_{\varphi,\pi}$, every positive example lies in the polynomial-size active slice $S_\varphi$. An improper learner draws

$$
m=O\left(\frac{|S_\varphi|}{\varepsilon}\left(\log |S_\varphi|+\log\frac1\delta\right)\right)
$$

examples, stores the positive sample points, and predicts $1$ exactly on those stored points and $0$ elsewhere.

This learner makes no false-positive errors. Its only possible errors are positive points in $S_\varphi$ that were not sampled. By the usual finite-support coupon bound, with probability at least $1-\delta$ the total distribution mass of unseen positive points is at most $\varepsilon$. The sample bound, hypothesis size, and evaluation time are polynomial in the representation size, $1/\varepsilon$, and $\log(1/\delta)$.

Thus the class is distribution-free strongly learnable by an improper learner. Since distribution-free polynomial bounds are a special case of marginal-dependent polynomial bounds, the atlas implication

`efficient-realizable-improper-pac -> efficient-marginal-nonuniform-realizable-improper-pac`

also makes the assigned source hold.

### Why The Target Fails

Assume for contradiction that there is an efficient distribution-free weak realizable proper learner for this class. Given an NP instance $\varphi$, draw examples uniformly from the active slice $S_\varphi$ and label every example by $1$.

If $\varphi$ is satisfiable, perfect completeness gives a proof $\pi$ whose proper concept labels every point of $S_\varphi$ by $1$. The distribution is therefore realizable. With probability at least $1-\delta$, the weak proper learner returns a proper concept with error at most $1/2-\gamma$, hence acceptance at least $1/2+\gamma$ on the verifier random strings for $\varphi$.

If $\varphi$ is unsatisfiable, PCP soundness says every proof is accepted on at most an $s<1/2$ fraction of verifier random strings. A proper concept for a different active instance outputs $0$ on $S_\varphi$. Hence no proper hypothesis has acceptance above $1/2$ on this active slice.

Because $S_\varphi$ has polynomial size, the reduction can enumerate the slice and compute the returned proper hypothesis's acceptance exactly. Accept iff this acceptance is greater than $1/2$. On satisfiable instances this accepts with the learner's success probability; on unsatisfiable instances it never accepts. This gives an RP algorithm for an NP-complete language. Under $\mathrm{NP}\nsubseteq\mathrm{RP}$, the target cannot exist.

Therefore the assigned implication is false under the same assumption.

## Composition Check

There is a true edge

`efficient-marginal-nonuniform-realizable-improper-pac -> efficient-weak-realizable-improper-pac`

via full-support marginal uniformization and strong-to-weak relaxation. There is also a false edge

`efficient-weak-realizable-improper-pac -> efficient-weak-realizable-proper-pac`

by the PCP active-slice witness.

The false edge does not compose formally with the true edge to prove this edge false. What resolves the assigned edge is stronger: the same PCP active-slice witness used for the weak-improper/proper separation satisfies the assigned source itself, because it is distribution-free strongly improperly learnable.

## Distribution Distinction

This resolution depends on the target being distribution-free weak proper PAC learning.

The analogous edge

`efficient-marginal-nonuniform-realizable-improper-pac -> efficient-marginal-nonuniform-weak-realizable-proper-pac`

is not refuted by the same PCP argument. That lower bound runs the learner on the marginal $U_\varphi$ uniform over the active slice of the input instance $\varphi$. For a marginal-nonuniform weak proper target, both the runtime polynomial and the weak advantage may depend on $U_\varphi$, which varies with the NP instance. This blocks the uniform polynomial-time RP reduction. Packing all active slices into one fixed marginal dilutes each hard slice by its weight, so a wrong-slice or mostly-zero proper hypothesis can be globally weak without revealing a useful proof.

For the assigned edge, the target asks for one distribution-free polynomial weak proper learner. The reduction may choose $U_\varphi$ as the test distribution for each input $\varphi$, and the learner's single polynomial/inverse-polynomial weak guarantee must work uniformly over all these marginals. That is why the active-slice PCP witness separates this edge.

## Proposed Atlas Update

Suggested frontmatter changes:

```yaml
status: "false"
evidence: conditional-counterexample
result_origin: "unclear"
assumptions:
  - "NP not subset RP"
witnesses:
  - pcp-active-slice-lookup-class
witness_note: "[[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]]"
ref_keys:
  - hastad2005query
  - karp1972
refs:
  - "[Hastad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)"
  - "[Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)"
summary: "False under NP not subset RP: the PCP active-slice lookup class is distribution-free strongly learnable improperly, hence marginal-nonuniform realizably learnable improperly, but weak proper realizable learning would decide an NP-complete language."
family: pcp-active-slice-weak-proper-hardness
argument_note: "[[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]"
```

The existing `axis_delta` can remain:

```yaml
axis_delta:
  resource: same
  distribution: marginal-nonuniform-to-distribution-free
  strength: strong-to-weak
  realizability: same
  properness: improper-to-proper
```

Suggested replacement body:

```markdown
## Verdict

`false`, under the assumption $\mathrm{NP}\nsubseteq\mathrm{RP}$.

The [[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]] is distribution-free strongly learnable by an improper memorization learner, and therefore satisfies the marginal-nonuniform realizable improper source. An efficient weak proper realizable learner would decide an NP-complete language with one-sided randomized error.

## Proof Status

**Goal.** Separate marginal-nonuniform realizable improper learning from distribution-free weak realizable proper learning.

**Witness construction.** Use the PCP active-slice class from [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]. A proper concept is indexed by an NP instance $\varphi$ and a proof $\pi$; on an example $(\psi,r)$ it runs the verifier on $(\varphi,\pi,r)$ if $\psi=\varphi$, and outputs $0$ otherwise.

**Why the source holds.** For a target concept, all positive examples lie in one active slice of polynomial size. An improper learner memorizes positive sample points and predicts $0$ elsewhere. With polynomially many samples, the unseen positive mass is at most $\varepsilon$ with probability at least $1-\delta$, giving efficient distribution-free realizable improper learning. Distribution-free polynomial bounds are valid marginal-by-marginal, so the assigned marginal-nonuniform source holds.

**Why the target fails.** Given an instance $\varphi$, sample uniformly from its active slice and label every point by $1$. If $\varphi$ is satisfiable, perfect completeness makes this distribution realizable by a proper concept, so a weak proper learner returns a proof accepted on more than half of the verifier random strings. If $\varphi$ is unsatisfiable, every proof is accepted on at most an $s<1/2$ fraction, and wrong-slice concepts output $0$. Since the active slice is polynomial size, acceptance can be checked exactly, yielding an RP algorithm for an NP-complete language. Thus the target would imply $\mathrm{NP}\subseteq\mathrm{RP}$.
```

## Next Directions

- Update the assigned atlas edge from `properization-open` to `pcp-active-slice-weak-proper-hardness`.
- Keep the marginal-nonuniform weak proper edge separate; the PCP active-slice lower bound does not resolve that weaker target.
- Optionally normalize the Karp DOI across PCP active-slice notes; some notes use `10.1007/978-1-4684-2001-2_9`, while the argument and witness notes use `10.1007/978-3-540-68279-0_8`.

verdict: resolved-false
confidence: high
