# Edge Resolution Scratchpad

Edge:

```text
efficient-marginal-nonuniform-weak-realizable-improper-pac
->
efficient-weak-realizable-proper-pac
```

- date: 2026-05-05
- pass: first-pass open-edge resolution
- verdict: resolved-false
- confidence: high, conditional on the existing PCP active-slice construction and the standard assumption $\mathrm{NP}\nsubseteq\mathrm{RP}$
- atlas files edited: no

## Bottom Line

The edge should be marked `false` with `evidence: conditional-counterexample`, under the assumption $\mathrm{NP}\nsubseteq\mathrm{RP}$.

Use the [[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]]. It satisfies a stronger source than the assigned one: it is distribution-free strongly learnable by an improper memorization learner. Therefore it also satisfies efficient marginal-nonuniform weak realizable improper PAC learning. But a distribution-free weak proper learner for the same class would decide an NP-complete language with one-sided randomized error.

The key distinction from the nearby marginal-nonuniform-proper target is that the target here is distribution-free. The lower-bound reduction is allowed to choose, for each NP instance $\varphi$, the uniform marginal on the active slice for $\varphi$, and the learner's single polynomial weak-proper guarantee must work uniformly over all of these marginals.

## Sources Checked

Local atlas notes:

- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-weak-realizable-proper-pac.md`
- `atlas/definitions/efficient-realizable-improper-pac.md`
- `atlas/definitions/efficient-weak-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-realizable-improper-pac--implies--efficient-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-weak-realizable-improper-pac--implies--efficient-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-weak-realizable-proper-pac.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/arguments/clause-satisfaction-proper-hardness.md`

Related scratchpads:

- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-weak-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-weak-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-04/efficient-weak-realizable-improper-pac--implies--efficient-weak-realizable-proper-pac/scratchpad.md`

External checks:

- Håstad and Khot, *Query Efficient PCPs with Perfect Completeness*, Theory of Computing 2005, https://theoryofcomputing.org/articles/v001a007/. The article page states logarithmic randomness, perfect completeness, and false-statement acceptance probability $2^{-k^2}+\epsilon$; choosing fixed $k$ and small $\epsilon$ gives soundness below $1/2$.
- Karp, *Reducibility among Combinatorial Problems*, 1972, DOI metadata at https://doi.org/10.1007/978-1-4684-2001-2_9. Used only as the standard NP-completeness anchor.
- Hanneke, Moran, and Thiessen, *Marginal-Nonuniform PAC Learnability*, OpenReview, https://openreview.net/forum?id=aoVCFtox89. Used for the marginal-nonuniform quantifier pattern: rates may depend on the marginal distribution but must hold uniformly over concepts for that marginal.

## Resolution

### Goal

Find a concept class satisfying

```text
efficient-marginal-nonuniform-weak-realizable-improper-pac
```

but not satisfying

```text
efficient-weak-realizable-proper-pac.
```

The PCP active-slice lookup class does this under $\mathrm{NP}\nsubseteq\mathrm{RP}$.

### Witness Construction

Fix a perfect-completeness PCP verifier for an NP-complete language. The verifier uses $O(\log n)$ random bits and has soundness $s<1/2$.

A proper concept is indexed by an instance $\varphi$ and a proof string $\pi$. On an example $(\psi,r)$, define

$$
h_{\varphi,\pi}(\psi,r)=
\begin{cases}
V(\varphi,\pi,r) & \text{if } \psi=\varphi,\\
0 & \text{otherwise.}
\end{cases}
$$

The active slice for $\varphi$ is

$$
S_\varphi=\{(\varphi,r):r\in\{0,1\}^{O(\log |\varphi|)}\},
$$

so $|S_\varphi|=\operatorname{poly}(|\varphi|)$.

## Why The Source Holds

The witness is stronger than needed: it is distribution-free strongly realizably learnable by an improper learner.

For a target concept $h_{\varphi,\pi}$, every positive example lies in the polynomial-size slice $S_\varphi$. An improper learner draws a polynomial number of examples, stores the positive sample points, and predicts $1$ exactly on those stored points and $0$ everywhere else.

There are no false positives. The only possible errors are positive points in $S_\varphi$ that were not sampled. Since the positive support has size $M=|S_\varphi|=\operatorname{poly}(s)$ in the target representation size, the standard finite-support coupon/epsilon-net bound gives, with probability at least $1-\delta$, unseen positive mass at most $\varepsilon$ after

$$
m=O\left(\frac{M}{\varepsilon}\left(\log M+\log\frac1\delta\right)\right)
$$

samples. The resulting table hypothesis is improper, polynomial-size, and evaluable in polynomial time.

Thus the class satisfies `efficient-realizable-improper-pac`. Running this strong learner with $\varepsilon=1/4$ gives a distribution-free weak improper learner with constant advantage $1/4$. A distribution-free polynomial guarantee is a special case of a marginal-dependent polynomial guarantee, so the assigned marginal-nonuniform weak improper source holds.

This avoids the weak-gap uniformization obstruction entirely. We do not need to convert an unknown marginal-dependent advantage $\gamma_P$ into one uniform advantage; the witness has a single strong improper learner with an explicit constant weak advantage when run at constant accuracy.

## Why The Target Fails

Assume for contradiction that an efficient distribution-free weak realizable proper learner $B$ exists for the PCP active-slice class.

Given an NP instance $\varphi$, sample uniformly from $S_\varphi$ and label every example by $1$.

If $\varphi$ is satisfiable, perfect completeness gives a proof $\pi^\star$ accepted for every random string. Therefore the all-positive distribution on $S_\varphi$ is realizable by the proper concept $h_{\varphi,\pi^\star}$. With probability at least $1-\delta$, the weak proper learner returns a proper concept with error at most $1/2-\gamma$, hence with acceptance greater than $1/2$ on $S_\varphi$.

If $\varphi$ is unsatisfiable, PCP soundness says every proof $\pi$ is accepted on at most an $s<1/2$ fraction of random strings. A proper concept with active instance $\psi\ne\varphi$ outputs $0$ on all of $S_\varphi$. Hence no proper hypothesis has acceptance greater than $1/2$ on the all-positive active-slice distribution.

The active slice has polynomial size, so after receiving $B$'s proper output, the reduction can enumerate every $r$, compute its exact acceptance fraction on $S_\varphi$, and accept iff that fraction exceeds $1/2$.

This is an RP algorithm for the NP-complete language: satisfiable instances are accepted with the learner's success probability, and unsatisfiable instances are never accepted. Therefore the target would imply $\mathrm{NP}\subseteq\mathrm{RP}$. Under $\mathrm{NP}\nsubseteq\mathrm{RP}$, the target fails.

## Checks Requested In Prompt

### Properization

No generic properization theorem is needed, and the witness shows such a theorem cannot hold at this level under $\mathrm{NP}\nsubseteq\mathrm{RP}$. The improper learner finds a lookup-table predictor; projecting that predictor back to a proper proof would solve the PCP search/distinguishing problem.

### Weak-Gap Uniformization

This edge has two apparent obstacles: marginal-to-distribution-free uniformity and improper-to-proper output. The counterexample bypasses the first by satisfying a stronger, distribution-free, strong improper source. Therefore any unresolved question about uniformizing a hidden $\gamma_P$ is irrelevant for this witness.

The target's weak gap is distribution-free and uniform. On a satisfiable active slice, any legal weak proper learner must cross the threshold $1/2$ by some inverse-polynomial amount. On an unsatisfiable slice, soundness keeps every proper hypothesis strictly below $1/2$. Since the reduction can check exact acceptance over the polynomial-size slice, it does not need to know the learner's numerical $\gamma$.

### PCP Active Slice

This is the resolving witness. The hard marginal varies with the NP input, but that is allowed when refuting a distribution-free target. It would not refute the analogous target

```text
efficient-marginal-nonuniform-weak-realizable-proper-pac
```

because there the target's runtime polynomial and weak advantage may depend on the active-slice marginal $U_\varphi$ itself. That is why the neighboring marginal-proper edge remains a different problem.

### One-Way And Code Witnesses

One-way image-coordinate and dense-code witnesses are not needed for this edge. They are useful for fixed-marginal or strong proper-recovery questions, but weak proper learning can often exploit wrong-length, low-mass, constant, singleton, or residual-code handles. The PCP active-slice construction directly attacks distribution-free weak proper learning and gives a cleaner conditional separation.

## Proposed Atlas Update

No atlas files were edited. If atlas updates are later allowed, the edge file

```text
atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-weak-realizable-proper-pac.md
```

should be changed from `open`/`unknown` to the PCP active-slice counterexample family.

Suggested frontmatter changes:

```yaml
status: "false"
evidence: conditional-counterexample
result_origin: "open-edge-resolution-2026-05-05"
assumptions:
  - "NP not subset RP"
witnesses:
  - pcp-active-slice-lookup-class
witness_note: "[[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]]"
ref_keys:
  - hastad2005query
  - karp1972
refs:
  - "[Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)"
  - "[Karp 1972](https://doi.org/10.1007/978-1-4684-2001-2_9)"
summary: "False under NP not subset RP: the PCP active-slice lookup class is distribution-free strongly learnable improperly, hence marginal-nonuniform weakly realizably learnable improperly, but weak proper realizable learning would decide an NP-complete language."
family: pcp-active-slice-weak-proper-hardness
argument_note: "[[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]"
```

Suggested `axis_delta`:

```yaml
axis_delta:
  resource: same
  distribution: marginal-nonuniform-to-distribution-free
  strength: same
  realizability: same
  properness: improper-to-proper
```

Suggested body:

```markdown
## Verdict

`false`, under the assumption $\mathrm{NP}\nsubseteq\mathrm{RP}$.

The [[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]] is distribution-free strongly learnable by an improper memorization learner, and therefore satisfies the marginal-nonuniform weak realizable improper source. An efficient weak proper realizable learner would decide an NP-complete language with one-sided randomized error.

## Proof Status

**Goal.** Separate marginal-nonuniform weak realizable improper learning from distribution-free weak realizable proper learning.

**Witness construction.** Use a perfect-completeness PCP with logarithmic randomness and soundness $s<1/2$. A proper concept is indexed by an NP instance $\varphi$ and a proof $\pi$; on an example $(\psi,r)$ it runs the verifier on $(\varphi,\pi,r)$ if $\psi=\varphi$, and outputs $0$ otherwise.

**Why the source holds.** For a target concept, all positive examples lie in one active slice of polynomial size. An improper learner memorizes positive sample points and predicts $0$ elsewhere. With polynomially many samples, the unseen positive mass is at most $\varepsilon$ with probability at least $1-\delta$, giving efficient distribution-free realizable improper learning. Running at $\varepsilon=1/4$ gives weak improper learning with constant advantage, so the assigned marginal-nonuniform weak source holds.

**Why the target fails.** Given an instance $\varphi$, sample uniformly from its active slice and label every point by $1$. If $\varphi$ is satisfiable, perfect completeness makes this distribution realizable by a proper concept, so a weak proper learner returns a proof accepted on more than half of the verifier random strings. If $\varphi$ is unsatisfiable, every proof is accepted on at most an $s<1/2$ fraction, and wrong-slice concepts output $0$. Since the active slice is polynomial size, acceptance can be checked exactly, yielding an RP algorithm for an NP-complete language. Thus the target would imply $\mathrm{NP}\subseteq\mathrm{RP}$.

The analogous marginal-nonuniform weak proper target is not refuted by this active-slice reduction, because there the runtime polynomial and weak advantage may depend on the active-slice marginal chosen from the input instance.
```

## Residual Risk

The conclusion is conditional, not unconditional. It depends on the existing atlas convention that the PCP active-slice class is an admissible computational PAC concept class with efficient concept evaluation and polynomial-size active slices.

The proof also relies on the target learner returning a usable proper representation whose acceptance on a polynomial-size slice can be evaluated in polynomial time. This is standard for the atlas's computational proper-learning nodes and is already assumed by the neighboring PCP active-slice notes.

## Final Verdict

`resolved-false`.

Confidence: high.
