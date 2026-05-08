# Edge: efficient-weak-agnostic-improper-pac -> efficient-weak-realizable-proper-pac

- depth: 1
- edge_file: atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-weak-realizable-proper-pac.md
- verdict: resolved-false
- confidence: high

## Context

The assigned edge asks whether a distribution-free weak agnostic improper learner for a class $\mathcal C$ forces a distribution-free weak realizable proper learner for the same class.

The current edge note is still marked `open` under `properization-open`. Its reduction is correct as far as it goes: on realizable distributions the weak agnostic improper learner gives an external weak predictor, and the remaining missing step is properization. However, the atlas now contains a sharper witness family, [[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]], with argument note [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]. That argument says the class is not merely weakly improperly realizably learnable; it is efficiently agnostically learnable by an improper one-slice lookup-table ERM. Therefore it satisfies the assigned source and rules out the target under $\mathrm{NP}\nsubseteq\mathrm{RP}$.

Checked notes:

- `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-weak-realizable-proper-pac.md`: currently `open`.
- `atlas/definitions/efficient-weak-agnostic-improper-pac.md`: source is additive weak agnostic, improper, distribution-free.
- `atlas/definitions/efficient-weak-realizable-proper-pac.md`: target asks for a proper concept with inverse-polynomial advantage over $1/2$ on every realizable distribution.
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`: gives the relevant conditional counterexample.
- `atlas/witnesses/pcp-active-slice-lookup-class.md`: records the witness role.
- `atlas/implications/efficient-weak-realizable-improper-pac--implies--efficient-weak-realizable-proper-pac.md`: already uses this witness for the weaker realizable-improper source.
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-weak-realizable-proper-pac.md`: already uses this witness for a related weak agnostic improper source.

## Attempted Resolution

**Goal.** Refute

$$
\text{efficient weak agnostic improper PAC}
\Rightarrow
\text{efficient weak realizable proper PAC}.
$$

It suffices to exhibit one binary class $\mathcal C$ satisfying the source while failing the target.

**Witness construction.** Use a perfect-completeness PCP for an NP-complete language with $O(\log n)$ verifier randomness and soundness $s<1/2$, as in Hastad-Khot. A proper concept is indexed by an NP instance $\varphi$ and a proof string $\pi$. On an example $(\psi,r)$, it outputs

$$
c_{\varphi,\pi}(\psi,r)
=
\begin{cases}
V(\varphi,\pi,r), & \psi=\varphi,\\
0, & \psi\ne\varphi.
\end{cases}
$$

Thus every proper hypothesis has one active instance slice. The slice $\{(\varphi,r)\}$ has polynomial size because $r$ ranges over only $2^{O(\log n)}=\operatorname{poly}(n)$ verifier coins.

### Why The Source Holds

The source is weak agnostic and improper. In fact, this witness satisfies the stronger distribution-free agnostic improper node.

For each size $n$, let the improper comparison/output class consist of:

- the all-zero hypothesis, and
- all one-slice lookup tables: choose an active instance $\psi$ and assign arbitrary Boolean labels to the polynomially many points $(\psi,r)$, outputting $0$ off that slice.

This improper class contains every proper PCP concept. Its logarithmic size is polynomial in the representation length: specifying the active slice and a table over polynomially many random strings takes polynomially many bits. ERM over this improper class is polynomial on a sample. Only sampled slices can beat the all-zero hypothesis, and for each sampled slice the best lookup table is found by empirical majority vote independently on the observed verifier-randomness points.

By standard finite-class uniform convergence, an empirical minimizer over this improper finite class has true error within any requested $\varepsilon$ of the best hypothesis in the improper class, hence within $\varepsilon$ of $\inf_{c\in\mathcal C}\operatorname{err}(c)$. Running this agnostic improper learner with any fixed $\varepsilon=\beta<1/2$ gives the assigned weak agnostic improper guarantee.

### Why The Target Fails

Assume for contradiction that there is an efficient weak realizable proper learner for this PCP class. Given an NP instance $\varphi$, consider the distribution uniform over its active slice $\{(\varphi,r)\}$, with every example labeled $1$.

If $\varphi$ is satisfiable, perfect completeness gives a proof $\pi^\star$ such that $V(\varphi,\pi^\star,r)=1$ for every random string $r$. Hence the labeled distribution is realizable by the proper concept $c_{\varphi,\pi^\star}$. The weak proper learner must, with constant success probability, return some proper concept with error at most $1/2-\gamma(n)$ for inverse-polynomial $\gamma(n)$. On this uniform active-slice distribution, that means the returned proof is accepted on more than half of the verifier random strings.

If $\varphi$ is unsatisfiable, PCP soundness says every proof is accepted on at most an $s<1/2$ fraction of random strings. A proper hypothesis for a different active instance outputs $0$ on the $\varphi$ slice, so it also has no positive weak advantage there. Thus no proper hypothesis can cross the $1/2$ acceptance threshold in the unsatisfiable case.

The active slice is polynomial size, so after the learner returns a proper hypothesis the reduction can enumerate all random strings and compute its exact acceptance fraction in polynomial time. Accept iff this fraction is greater than $1/2$. This gives a randomized polynomial-time one-sided decision procedure for the NP-complete language. Therefore the assumed target would imply $\mathrm{NP}\subseteq\mathrm{RP}$.

Under $\mathrm{NP}\nsubseteq\mathrm{RP}$, the target fails while the source holds. The edge is false under that assumption.

## PCP Versus One-Way Witnesses

The PCP witness resolves this edge cleanly because the target is distribution-free weak proper learning. The hard marginal is allowed to depend on the NP instance: the reduction simply samples uniformly from the active slice for $\varphi$. There is no fixed-marginal mass dilution.

The one-way image-coordinate witnesses are not needed for this edge. They are useful for fixed-marginal or strong proper recovery separations, where accurate proper learning forces inversion of a one-way image. But for weak proper distribution-free learning, sparse one-way coordinate classes often leak weak handles, such as constants, singleton-heavy atoms, wrong-length/default concepts, or other hypotheses with inverse-polynomial correlation that avoid inversion. The weak-handle variant explicitly makes weak proper learning easy, so it cannot refute this edge. The PCP active-slice construction targets weak proper learning directly.

## Proposed Atlas Update

Frontmatter changes for `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-weak-realizable-proper-pac.md`:

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
  - blumer1989
  - hastad2005query
  - karp1972
refs:
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
  - "[Hastad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)"
  - "[Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)"
summary: "False under NP not subset RP: the PCP active-slice lookup class is efficiently weak agnostically learnable improperly, indeed agnostically learnable improperly, but weak proper realizable learning would decide an NP-complete language."
family: pcp-active-slice-weak-proper-hardness
argument_note: "[[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]"
```

Suggested replacement body:

```markdown
# Efficient Weak Agnostic Improper PAC Learning $\Rightarrow$ Efficient Weak Realizable Proper PAC Learning

## Verdict

`false`, under the assumption $\mathrm{NP}\nsubseteq\mathrm{RP}$.

The [[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]] is efficiently agnostically learnable by an improper one-slice lookup-table ERM, hence satisfies the weak agnostic improper source. An efficient weak realizable proper learner for the same class would decide an NP-complete language with one-sided randomized error.

## Proof Status

**Goal.** Separate weak agnostic improper learning from weak realizable proper learning.

**Witness construction.** Use the PCP active-slice class from [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]. A proper concept is indexed by an NP instance $\varphi$ and a proof $\pi$; on an example $(\psi,r)$ it runs the verifier on $(\varphi,\pi,r)$ if $\psi=\varphi$, and outputs $0$ otherwise.

**Why the source holds.** The verifier uses $O(\log n)$ random bits, so each active slice has polynomial size. The improper learner runs ERM over one-slice lookup tables and the all-zero hypothesis. Only sampled slices need be considered, and the best table on a sampled slice is obtained by empirical majority vote. Since this finite improper class contains all proper concepts and has polynomial logarithmic size, finite-class uniform convergence gives efficient agnostic improper learning. Running this learner at any fixed weak tolerance gives efficient weak agnostic improper learning.

**Why the target fails.** Given an instance $\varphi$, sample uniformly from its active slice and label every point by $1$. If $\varphi$ is satisfiable, perfect completeness makes this distribution realizable by a proper concept, so a weak proper learner returns a proof accepted on more than half the random strings. If $\varphi$ is unsatisfiable, every proof is accepted on at most an $s<1/2$ fraction. The active slice is polynomial size, so acceptance can be checked exactly in polynomial time. Thus the target would imply $\mathrm{NP}\subseteq\mathrm{RP}$.
```

## Obstacles

No remaining obstacle for a conditional resolution of this distribution-free edge. The conclusion inherits the standard complexity assumption in the existing PCP active-slice argument.

The only small atlas-cleanup issue noticed while checking nearby files is DOI consistency for Karp 1972: some notes use `10.1007/978-1-4684-2001-2_9`, while the PCP argument and related scratchpads use `10.1007/978-3-540-68279-0_8`. This does not affect the mathematical verdict.

## Next Directions

- Update the assigned edge note from `properization-open` to `pcp-active-slice-weak-proper-hardness`.
- Audit remaining `properization-open` edges whose source is at least as strong as weak distribution-free agnostic improper learning and whose target is distribution-free weak proper realizable learning; the same PCP witness may already resolve them.
- Keep one-way image-coordinate arguments for fixed-marginal and strong-proper edges, not for this distribution-free weak target.

## References Checked

- Blumer, Ehrenfeucht, Haussler, and Warmuth, "Learnability and the Vapnik-Chervonenkis dimension," 1989.
- Hastad and Khot, "Query efficient PCPs with perfect completeness," 2005.
- Karp, "Reducibility among combinatorial problems," 1972.
- `atlas/definitions/efficient-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-weak-realizable-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/implications/efficient-weak-realizable-improper-pac--implies--efficient-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-weak-realizable-proper-pac.md`

verdict: resolved-false
confidence: high
