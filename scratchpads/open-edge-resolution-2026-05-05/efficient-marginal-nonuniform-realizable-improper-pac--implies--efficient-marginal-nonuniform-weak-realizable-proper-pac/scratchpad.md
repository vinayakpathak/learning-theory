# Edge: efficient-marginal-nonuniform-realizable-improper-pac -> efficient-marginal-nonuniform-weak-realizable-proper-pac

- depth: 1
- edge_file: atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md
- verdict: unresolved
- confidence: medium-high

## Context

The source is [[efficient-marginal-nonuniform-realizable-improper-pac|Efficient Marginal-Nonuniform Realizable Improper PAC Learning]]. One uniform learner works for every marginal $P$, but its sample and runtime polynomial may depend on $P$. On realizable data labeled by some $c \in \mathcal C$, it outputs an arbitrary hypothesis, not necessarily in $\mathcal C$, with arbitrarily small $P$-error.

The target is [[efficient-marginal-nonuniform-weak-realizable-proper-pac|Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]]. It asks for one uniform algorithm that, for every fixed marginal $P$, has a $P$-dependent polynomial bound and a $P$-dependent inverse-polynomial advantage $\gamma_P(s)$, and outputs $h \in \mathcal C$ with error at most $1/2-\gamma_P(s)$ on realizable data.

Thus the statistical strength is much weaker in the target, but the representation constraint is stronger. The exact question is whether accurate improper prediction can always be turned into even weak proper representation recovery under the same marginal-nonuniform convention.

The current edge note places this in the [[properization-open|Properization Open]] family. Nearby scratchpads and argument notes are consistent with that placement: distribution-free weak properization has PCP counterexamples, and marginal-nonuniform strong properization has a one-way-function counterexample, but neither currently reaches this marginal-nonuniform weak proper target.

## Attempted Resolution

### Theorem Route

The source learner can be run with, say, error $1/10$ under any fixed marginal $P$ and realizable target $c$. This gives an external predictor $g$ with positive correlation against $c$. If the target allowed improper hypotheses, this would immediately give weak realizable learning. The obstruction is entirely the proper output requirement.

The obvious projection step would be:

$$
g \approx_P c \in \mathcal C
\quad\Longrightarrow\quad
\text{efficiently find } h\in\mathcal C \text{ with } \operatorname{err}_P(h,c) < 1/2.
$$

I did not find a generic way to justify this step. Information-theoretically, a perfect proper hypothesis exists, namely $c$ itself. In the sample-only layer, unbounded ERM or VC-style arguments can remove this obstruction. Computationally, however, the improper learner may output a table, sparse set, circuit, vote, or other representation outside the class that carries no efficiently recoverable proper representation.

Marginal nonuniformity helps only with the rate once $P$ is fixed. It does not give an algorithm for the representation search over $\mathcal C$, and the hidden polynomial may not depend on the target concept. Exhaustive enumeration of proper concepts is generally exponential in the representation size, and standard boosting is not a repair: boosting improves prediction but typically outputs an aggregate, not a single member of $\mathcal C$.

So the theorem route reduces to an unproved representation-sensitive weak properization theorem.

### Counterexample Route 1: PCP Active Slices

The [[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]] gives the clean distribution-free weak proper separation under $\mathrm{NP}\nsubseteq\mathrm{RP}$. Proper concepts encode a PCP proof for one active NP instance slice. The active slice has polynomial size, so an improper memorization learner gives efficient realizable improper learning, and the stronger agnostic improper version is handled by one-slice lookup-table ERM.

This witness does not appear to refute the assigned target. The weak proper lower bound runs the learner on the marginal uniform over the active slice of the input formula $\varphi$. For the marginal-nonuniform target, the polynomial runtime and weak advantage may depend on that exact marginal. Since the marginal varies with $\varphi$, the reduction does not produce one uniform polynomial-time randomized decision procedure for the NP language.

Packing all formula slices into one fixed marginal also fails at the weak threshold. If

$$
P=\sum_\psi w_\psi U_\psi,
$$

where $U_\psi$ is uniform on the active slice for $\psi$, then the global gap visible on the $\varphi$ slice is multiplied by $w_\varphi$. A fixed distribution cannot assign inverse-polynomial mass to exponentially many length-$n$ instances. If $w_\varphi$ is tiny, a wrong-slice or mostly-zero proper hypothesis can already have global error far below $1/2$, without containing a useful PCP proof for $\varphi$.

This explains why the PCP false edge to distribution-free weak proper learning does not transfer by monotonicity: the assigned target is weaker in exactly the marginal-dependent way that absorbs the hard active slice.

### Counterexample Route 2: One-Way Image Coordinates

The [[one-way-image-coordinate-class|One-Way Image Coordinate Class]] is a strong properization witness under length-preserving one-way functions. It also satisfies this source: for a length-$n$ target, there are only $n$ positive image-coordinate atoms, so an improper memorization learner strongly learns realizable distributions. The atlas note also records an agnostic improper sparse ERM, so the source side is more than adequate.

The lower bound, however, is a strong-accuracy lower bound. Under the fixed all-length marginal used in [[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]], the length-$n$ block has mass $\mu_n=6/(\pi^2 n^2)$. To force inversion, the proper learner is asked for error below roughly $\mu_n/n$, so even one wrong image bit is visible.

For weak learning this visibility disappears. A wrong-length or wrong-image proper concept differs from the target only on a low-mass block and can still have global error much less than $1/2-\gamma_P(n)$ for many possible marginal-dependent weak gaps. Thus a weak proper learner could satisfy the target without recovering a preimage of the one-way image.

Concentrating the marginal on one length would make weak correlation more meaningful, but then the marginal changes with the challenge length. The marginal-dependent polynomial could vary with that length-specific marginal, which is not enough to contradict ordinary polynomial-time one-wayness uniformly across input lengths.

### Counterexample Route 3: Dense Code Repairs

The natural repair is to encode the one-way image by a balanced codeword rather than sparse coordinates. Ideally, for a target seed $s$, every wrong proper seed $t$ would have codeword distance exactly $1/2$ from the target under one fixed marginal. Then any proper hypothesis with any positive inverse-polynomial advantage would reveal a preimage.

This runs into a source/geometry tradeoff.

Hadamard or parity-style encodings have the perfect weak geometry: distinct codewords are orthogonal under the uniform coordinate marginal. But the source learner would then need to learn dense parity-like labels from random examples, rather than memorize sparse positive atoms. That is not supplied by the existing improper learner and looks like a different hard learning problem.

Polynomial-length error-correcting or small-bias codes keep the coordinate domain closer to a polynomial lookup regime, but they only make wrong images almost uncorrelated at a chosen scale. The target's advantage $\gamma_P(s)$ is hidden and may be smaller than the residual correlation. A wrong proper seed with tiny positive correlation could already be a valid weak output. Exact orthogonality for exponentially many possible images appears to require exponential coordinate length or a padded size parameter, which breaks the ordinary polynomial-time source or the standard one-way-function contradiction.

### Monotonicity Check

Known false edges do not transfer directly.

- `efficient-agnostic-improper-pac -> efficient-weak-realizable-proper-pac` is false by the PCP active-slice witness, but its target is distribution-free weak proper learning, stronger than the assigned marginal-nonuniform weak proper target.
- `efficient-realizable-improper-pac -> efficient-marginal-nonuniform-realizable-proper-pac` is false by one-way image coordinates, but its target is strong proper learning, stronger than the assigned weak proper target.
- Sample-to-computational false edges using pseudorandom-function classes threaten weak learning itself; those witnesses do not satisfy the assigned efficient realizable improper source.

The source here is weaker than the agnostic improper sources considered in adjacent scratchpads, so unresolved adjacent agnostic-to-marginal-weak-proper edges do not imply this edge is open. But they do show that even stronger improper prediction assumptions have not yet yielded a proof or a fixed-marginal weak separation in the current atlas.

## Proposed Atlas Update

No status change is justified. I would keep:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
argument_note: "[[properization-open|Properization Open]]"
```

Suggested replacement summary:

```yaml
summary: "Open: strong marginal-nonuniform improper prediction gives no known efficient projection to even weak proper hypotheses, while PCP active-slice and one-way-coordinate separations lose force at the marginal-nonuniform weak threshold."
```

Suggested replacement body sketch:

> **Verdict.** `open`.
>
> **Goal.** Decide whether strong marginal-nonuniform realizable improper learning can always be converted into weak marginal-nonuniform realizable proper learning.
>
> **Theorem route.** The source gives accurate external prediction under every fixed marginal, but the target requires a member of $\mathcal C$. Finite-sample existence and boosting-style prediction results do not supply an efficient projection or approximate proper ERM over the representation class.
>
> **Counterexample route.** PCP active-slice witnesses refute distribution-free weak properization, but their hard marginal varies with the input instance; a marginal-nonuniform learner may have a different polynomial and weak gap for each such marginal. Packing slices into one fixed marginal dilutes each weak gap. One-way image-coordinate witnesses refute strong fixed-marginal properization, but wrong-image or wrong-length concepts can already be weak global predictors when each length block has small mass.
>
> **Conclusion.** The edge remains open as a computational marginal-nonuniform weak properization problem.

## Obstacles

1. **Representation search.** The proper target concept exists, but the improper learner need not reveal any efficiently decodable proper representation.

2. **Varying hard marginals.** PCP weak proper lower bounds use an active-slice marginal depending on the NP instance. Marginal-nonuniform guarantees allow the runtime polynomial and weak gap to depend on that marginal, blocking a standard uniform polynomial-time reduction.

3. **Packed-slice dilution.** A single fixed marginal cannot give polynomial mass to every hard slice. Once the target slice has tiny mass, weak global error no longer forces solving the hard slice.

4. **Sparse cryptographic weak handles.** One-way image-coordinate classes preserve the source, but under all-length fixed marginals, wrong proper concepts can be good weak predictors without inverting.

5. **Dense-code tension.** Balanced encodings can make weak proper hardness plausible, but the exact-orthogonal versions destroy the sparse improper learning argument, while polynomial-length approximate codes leave residual correlations at an unknown inverse-polynomial scale.

## Next Directions

1. Try to formalize a conditional positive theorem: identify representation assumptions under which an accurate improper learner plus fixed marginal $P$ yields an efficient weak proper trace selector or approximate proper ERM.

2. Search for a fixed-marginal dense-code properization witness where every non-certificate proper concept has nonpositive correlation with the target labels, while improper realizable learning remains polynomial-time.

3. Revisit PCP encodings with shared, fixed marginals and target-dependent balanced guards. The key test is whether wrong instances are kept near error $1/2$ without turning the source into a hard dense decoding problem.

4. Investigate whether a stronger cryptographic assumption, such as hardness against subexponential time or a pseudorandom-code assumption, can make the dense-code route work without changing the atlas's standard assumptions.

## References Checked

- `atlas/definitions/efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`
- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
- [Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)
- [Khot and Saket 2008](https://doi.org/10.1109/FOCS.2008.37)
- [Hastad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)
- [Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)
- [Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)

---

## Depth-2 Follow-Up - 2026-05-05

- depth: 2
- edge_file: atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md
- verdict: unresolved
- confidence: medium-high

### Focus

This pass focused on the requested narrow question: can the strong improper learner be converted to a weak proper learner by using fixed-marginal finite-support or finite-trace structure, or can a fixed-marginal weak proper selector hardness result separate the edge?

The short answer is that finite-support and trace arguments give good conditional positive theorems, but only after adding an efficient proper trace selector. The source learner does not provide such a selector. Conversely, a selector-hardness counterexample has the right conceptual shape, but the checked PCP and one-way witnesses do not yet realize it under one fixed marginal at the weak threshold.

### Finite-Support And Trace Route

Fix a marginal $P$ and a target $c\in\mathcal C_s$. The source learner can be run with small constant error, or even error $1/\operatorname{poly}(s)$, to obtain an improper predictor $g$ with

$$
\operatorname{err}_P(g,c)\ll 1/2.
$$

If the learner were allowed to output $g$, this would already be weak learning. To make the output proper, a natural plan is:

1. draw a polynomial-size sample $T=(x_1,\ldots,x_m)$ from $P$;
2. use labels from the sample, or labels predicted by $g$, to define a finite trace;
3. find a concept $h\in\mathcal C$ whose trace agrees with those labels well enough;
4. use fixed-$P$ generalization to conclude $P$-error below $1/2-\gamma_P(s)$.

The statistical part is plausible under extra finite-support assumptions. For example, if the $P$-mass relevant to concepts of size $s$ is covered by $\operatorname{poly}_P(s)$ effectively discoverable atoms, then enough samples reveal the heavy part of the support. Since the true target itself realizes the observed labeled trace, any proper concept matching that trace on most heavy atoms is a weak proper predictor. Marginal nonuniformity is friendly to this rate statement: the support-cover size, sample count, and weak advantage may all depend on $P$.

The computational problem is step 3. The algorithm must output an actual representation in $\mathcal C$, not merely a table on $T$, a trace cell, or the improper predictor $g$. A finite trace bound such as Sauer's lemma is therefore insufficient. It bounds how many traces may occur, but it does not give a polynomial-time map

$$
(T,\ell)\mapsto h\in\mathcal C
$$

where $h$ realizes or weakly fits the trace. Even when the support is finite and small, this map can be a hard proper consistency or weak-optimization problem. The source learner may have avoided exactly that problem by returning a lookup table, sparse memorizer, linearized image vector, vote, or other external representation.

So the finite-trace route proves only a restricted theorem:

> If, for every fixed $P$, there is a uniform polynomial-time procedure whose runtime is bounded by a $P$-dependent polynomial and which converts realizable sample traces into a proper concept with inverse-polynomial fixed-$P$ advantage, then the edge holds for that class.

This is not a proof of the assigned edge, because the extra procedure is precisely the missing properization oracle. Marginal nonuniformity changes the allowed polynomial bound; it does not give the learner $P$-specific advice, a list of trace representatives, or an efficient proper ERM oracle.

### Fixed-Marginal Weak Proper Selector Hardness

The complementary false route would build a class and one fixed marginal $P^\star$ such that:

- every target is strongly learnable by an efficient improper learner under every marginal, preferably by memorization or an external reconstruction;
- under $P^\star$, any proper hypothesis with error below $1/2-1/\operatorname{poly}(s)$ solves a hard selector problem, such as finding a PCP proof or inverting a one-way image.

This is the right abstraction: the target does not require exact recovery, so the hard problem must be attached to **any** proper hypothesis with positive inverse-polynomial correlation, not just to a highly accurate proper hypothesis.

The existing witnesses miss this abstraction in opposite ways.

For the PCP active-slice class, the hard selector is a proof for the input formula. If the marginal is uniform on the active slice of $\varphi$, weak proper learning gives a proof accepted above the soundness threshold. But that marginal depends on $\varphi$, and the marginal-nonuniform target allows both $p_{P_\varphi}$ and $\gamma_{P_\varphi}$ to depend on it. Packing all formula slices into a single $P^\star$ dilutes the selected slice by its weight $w_\varphi$; for exponentially many formulas, typical $w_\varphi$ is far below any uniform inverse-polynomial visibility requirement. A wrong-slice proper concept can then be weak globally without selecting a proof for $\varphi$.

For the one-way image-coordinate class, the hard selector is a seed $t$ with $f(t)=f(s)$. Strong proper learning forces this by asking for accuracy below one coordinate's mass. Weak proper learning does not. Under the fixed all-length marginal, wrong-length or wrong-image proper concepts can disagree with the target only on a low-mass block and still have global error far below $1/2$. Concentrating the marginal on one length removes the shortcut but makes the marginal length-dependent, which is too nonuniform to contradict ordinary one-wayness across all lengths.

The dense-code repair remains the most promising selector-hardness idea. If the target labels encoded $f(s)$ by a balanced code under one fixed high-mass coordinate distribution, and every wrong seed had nonpositive correlation with the target codeword, then any weak proper learner would invert $f$. But polynomial-size coordinate sets leave residual inverse-polynomial correlations, while exact orthogonality uses Hadamard/parity-scale domains and breaks the simple polynomial-time improper memorization source or changes the representation-size accounting. No checked note gives a fixed-marginal class satisfying both sides.

### Verdict

Still `unresolved`; keep the edge `open` with `evidence: unknown`.

The finite-support/trace route does not prove the implication without an additional efficient proper trace selector. The fixed-marginal selector-hardness route is the right shape for a counterexample, but the known PCP and one-way constructions either use input-dependent hard marginals, dilute the weak gap when packed into one marginal, or create weak proper handles through sparse blocks.

No atlas metadata changes are justified.

### Next Directions

1. Isolate a reusable "proper trace selector" condition: for fixed $P$, a polynomial-time algorithm that turns realizable sample traces or an accurate improper predictor into a proper concept with inverse-polynomial $P$-advantage. This would give a clean conditional positive lemma.

2. Prove a barrier lemma for finite traces: finite support or finite VC trace bounds alone do not imply computational weak properization unless trace realization/selection is efficient.

3. Search specifically for fixed-marginal weak selector hardness, not just strong proper hardness. The lower bound must show that every proper concept with inverse-polynomial positive correlation reveals the hard certificate.

4. Revisit balanced cryptographic encodings with exact or negligible wrong-seed correlation under a single finitely encoded marginal. The hard part is preserving efficient strong improper learning without relying on sparse supports that create weak handles.

5. For PCP-style routes, look for shared-coordinate encodings where the hard instance is in the target labels rather than in the marginal, and where wrong-instance proper concepts are forced to error $1/2-o(1/\operatorname{poly})$ without spending exponentially small slice mass.

### References Rechecked

- `atlas/definitions/efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/README.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `scratchpads/open-edge-resolution-2026-05-04/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`

---

## Depth-3 Follow-Up - 2026-05-05

- depth: 3
- edge_file: atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md
- verdict: unresolved
- confidence: high that the correct current atlas status is `open`

### Focus

This pass tried to sharpen the two most useful abstractions:

1. a fixed-marginal weak selector hardness template strong enough to refute the edge;
2. positive trace-selector conditions under which the edge would become true.

The result is not a resolution. It does, however, suggest a cleaner atlas-open note: the unresolved object is not "boosting" or "sample complexity", but **fixed-marginal weak proper selector** complexity.

### Fixed-Marginal Weak Selector Hardness Template

A counterexample should have the following form. There is one fixed marginal $P^\star$ and a hard relation $R(y,t)$ such that, for every challenge $y$ of representation size $s$:

1. the labels $c_y(x)$ can be simulated efficiently on examples $x\sim P^\star$;
2. the labeled distribution is realizable by some proper concept in $\mathcal C_s$ when $y$ is a valid challenge;
3. an improper learner can strongly learn every realizable target under every marginal, preferably by lookup, sparse reconstruction, or another representation-external method;
4. every proper hypothesis $h\in\mathcal C$ with

   $$
   \operatorname{err}_{P^\star}(h,c_y)\le \frac12-\frac1{\operatorname{poly}(s)}
   $$

   yields a witness $t$ with $R(y,t)$.

Condition 4 is the missing one. Strong proper hardness only needs "very accurate proper hypotheses decode $t$." Weak proper hardness needs the much more rigid statement that **any inverse-polynomial positive correlation** decodes $t$.

This template explains why the checked witnesses remain near misses.

For PCP active slices, the selector is a PCP proof accepted on more than half the verifier random strings. On the active-slice marginal $P_\varphi$, the condition is true. But $P_\varphi$ depends on the input formula. If all formulas are packed into one $P^\star$, the local correlation gap is multiplied by the slice weight $w_\varphi$. Since there are exponentially many length-$n$ formulas, many slices must have $w_\varphi\ll 1/\operatorname{poly}(n)$, so a global weak learner need not expose the selected proof.

For one-way image coordinates, the selector is a seed $t$ with $f(t)=y$. The fixed all-length marginal works for strong accuracy because one wrong coordinate has mass $\mu_n/n$. It fails at the weak threshold because wrong-image and wrong-length seed concepts can still have global error far below $1/2$ when the hard block has small mass. These are genuine weak handles, not just proof artifacts.

The dense-code repair would try to make every wrong seed almost orthogonal to the target under one shared marginal. To beat an unknown target advantage $\gamma_{P^\star}(s)$, "almost" is not enough unless the residual correlation is smaller than every inverse polynomial relevant to the learner. Polynomial-length code supports appear to leave inverse-polynomial residual correlations among exponentially many seeds, while exact orthogonality pushes toward Hadamard-size coordinate sets and breaks the polynomial-scale improper source or requires padded representation sizes. This is the cleanest current obstruction to a false witness.

### Positive Trace-Selector Conditions

The most useful positive abstraction is not finite VC dimension alone. It is a **computable proper weak cover or trace selector** for the fixed marginal.

One sufficient condition is:

For every fixed marginal $P$, there are $P$-dependent polynomials $m_P(s)$ and $q_P(s)$ and a single uniform procedure `TraceSelect` such that, on samples from $P$ and oracle/evaluation access to a predictor $g$, it runs in time $q_P(s)$ and returns a list

$$
L\subseteq \mathcal C
$$

of size at most $q_P(s)$ with the following property. For every target $c\in\mathcal C_s$ and every predictor $g$ with, say, $\operatorname{err}_P(g,c)\le 1/16$, with high probability over the selector's labeled sample, some $h\in L$ satisfies the direct target guarantee

$$
\operatorname{err}_P(h,c)\le \frac12-\frac2{q_P(s)}.
$$

Then the assigned edge follows under this extra condition. Run the source learner at a fixed constant accuracy to obtain $g$. Run `TraceSelect` to get the polynomial-size proper list. Use a fresh labeled validation sample from $P$ to choose a candidate whose empirical agreement with the true labels is best. Standard concentration for a finite list gives, for the selected $h$,

$$
\operatorname{err}_P(h,c)\le \frac12-\frac1{q'_P(s)}
$$

for another $P$-dependent polynomial $q'_P$.

This condition is stronger than sample learnability but weaker than demanding full proper ERM. It permits:

- a $P$-dependent rate and runtime;
- selectors that only output a polynomial-size list of proper candidates;
- selection using an accurate improper predictor as a guide;
- holdout validation to avoid uniform convergence over the entire concept class.

It also pinpoints why the source alone is insufficient. The source gives $g$, but it gives no way to manufacture the list $L\subseteq\mathcal C$. A finite support, finite trace count, or Sauer-style bound is only statistical unless there is an efficient map from observed traces or from $g$ to proper representatives. In hard properization examples, that map is exactly the computationally hard selector.

A second sufficient condition is a fixed-marginal proper weak cover:

For every fixed $P$ and size $s$, there is a uniformly searchable $P$-dependent polynomial-size set $K_{P,s}\subseteq\mathcal C$ such that for every $c\in\mathcal C_s$ some $h\in K_{P,s}$ has

$$
\operatorname{err}_P(h,c)\le \frac12-\frac1{\operatorname{poly}_P(s)}.
$$

Together with the source learner and finite validation, this also gives the target. The important word is "searchable": an information-theoretic cover or a finite number of traces does not help unless the learner can find or generate the cover representatives in the atlas runtime model.

### Candidate Atlas-Open Note

If the atlas is refactored, a useful argument note could be:

```yaml
type: argument
id: fixed-marginal-weak-proper-selector-open
title: Fixed-Marginal Weak Proper Selector Open
domain: binary-classification
model: pac
status: "open"
evidence: unknown
```

Suggested body:

> **Verdict.** `open`.
>
> This family records properization edges where the source gives efficient improper prediction under a fixed marginal, but the target asks for even inverse-polynomial correlation by a proper hypothesis under that same marginal.
>
> A positive theorem would follow from an efficient fixed-marginal proper trace selector: given an accurate improper predictor or a realizable finite trace, produce a polynomial-size list of proper hypotheses containing one with nontrivial $P$-correlation with the target. Finite sample or finite trace existence alone is not enough, because the selector must output actual representations in $\mathcal C$.
>
> A negative theorem would require fixed-marginal weak selector hardness: under one marginal $P^\star$, every proper hypothesis with inverse-polynomial positive correlation must reveal a hard certificate. Existing PCP active-slice witnesses use input-dependent marginals, and packing slices into one marginal dilutes the weak gap. Existing one-way coordinate witnesses force exact recovery only at strong accuracy thresholds and leak weak proper handles. Dense-code repairs are plausible but not currently atlas-ready because polynomial coordinate supports leave residual correlations, while exact orthogonality breaks the polynomial-scale improper learner or changes the cryptographic scale.

This would be a sharper home for the present edge than the broader `properization-open` bucket, but it should not replace the current edge metadata until a real atlas edit is requested.

### Depth-3 Verdict

Still `unresolved`.

Keep the assigned implication:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
```

No atlas status change is justified. The best sharpened statement is:

> Open: strong marginal-nonuniform improper prediction would imply the weak proper target under an additional efficient fixed-marginal trace-selector or searchable weak-cover condition. Conversely, a separation would need fixed-marginal weak selector hardness, where every inverse-polynomially correlated proper hypothesis reveals a hard witness. The known PCP and one-way-coordinate witnesses do not meet that weak fixed-marginal selector requirement.

### Next Directions

1. Formalize the trace-selector lemma above as a reusable conditional theorem. The proof should explicitly use the source learner for $g$, a finite proper candidate list, and labeled holdout validation.

2. Search for classes where an efficient improper learner naturally induces a searchable proper weak cover under each fixed marginal. This is the likely positive side: effective finite support plus efficient proper consistency, computable $L_1(P)$ covers by concepts, or projection from an external representation to a polynomial candidate list.

3. For a false witness, target the selector template directly. Do not settle for strong proper recovery hardness. Prove that every proper hypothesis with error $<1/2-1/\operatorname{poly}(s)$ decodes the certificate under one fixed marginal.

4. Revisit dense cryptographic code constructions only if the code geometry beats the hidden weak gap. The required property is not merely small average correlation, but no efficiently outputtable wrong proper seed with inverse-polynomial positive correlation at the representation scale.

5. Revisit PCP shared-coordinate encodings with the hard instance in the labels rather than the marginal. The acceptance gap must remain inverse-polynomial under one fixed marginal without allowing generic proper concepts to obtain weak positive correlation for irrelevant reasons.

6. If an atlas note is added, use `fixed-marginal-weak-proper-selector-open` as a focused subfamily of `properization-open`; keep this assigned edge open under that family unless one of the above directions resolves it.

### References Rechecked

- `atlas/definitions/efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/arguments/clause-satisfaction-proper-hardness.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-04/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`

---

## Depth-4 Follow-Up - 2026-05-05

- depth: 4
- edge_file: atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md
- verdict: unresolved
- confidence: medium-high that the current atlas edge should remain `open`; high that the parity construction below would be a false witness if product-Cantor or lazy random-bit examples are admitted

### Focus

This pass rechecked a route that earlier agnostic-improper scratchpads rejected too quickly for the present edge. The source here is only **realizable** improper learning, not agnostic improper learning. Dense parity encodings are hard-looking agnostically, but realizable parity learning is easy by Gaussian elimination. That changes the status of the "Hadamard/exact orthogonality" idea.

The resulting construction is a near separation:

- the improper learner can learn an arbitrary parity vector consistent with the samples;
- the proper concepts are only those parity vectors that encode one-way-function images;
- under a fixed fair-product marginal, every wrong proper parity is exactly uncorrelated with the target.

It would resolve the edge as `false` under one-way functions if the atlas model permits a fixed non-atomic product marginal with examples represented by lazy finite bit access. I do **not** mark the edge resolved because `atlas/README.md` says computational resource bounds are worst-case/pathwise bounds on finite encoded sample transcripts, and all existing witnesses use finite string/tuple examples. A finite-string implementation of the product-marginal trick is exactly where the construction currently breaks.

### Conditional False Witness: One-Way Parity-Image Class

Assume a length-preserving one-way function family $f_n:\{0,1\}^n\to\{0,1\}^n$.

For a seed $s\in\{0,1\}^n$, form a finite binary vector

$$
v_s = \operatorname{mark}(n)\,\|\, f_n(s),
$$

where $\operatorname{mark}(n)$ is a self-delimiting length marker. The marker is included only to prevent a proper hypothesis of another length from representing the same padded parity vector. Let $N(n)=|v_s|=O(n)$.

On the product instance space $X=\{0,1\}^{\mathbb N}$, define the proper concept

$$
c_s(x)=\langle v_s, x_{1:N(n)}\rangle \pmod 2.
$$

Proper hypotheses are exactly seeds $t$, interpreted as $c_t$. Improper hypotheses may be arbitrary finite parities $h_w(x)=\langle w,x_{1:|w|}\rangle\bmod 2$, with $w$ not required to be a marked one-way image.

#### Source Side

For any marginal $P$ on $X$ and any realizable target $c_s$, an improper learner can PAC-learn strongly by the standard realizable parity algorithm:

1. read the first $N(n)$ bits of each sample;
2. collect the linear equations $\langle w,x_i\rangle=y_i$ over $\mathbb F_2$;
3. output any solution $w$ consistent with the sample.

The output parity need not equal $v_s$ and need not be proper. It is enough that it is sample-consistent. Since the class of $N(n)$-bit parities has VC dimension $N(n)$, standard realizable uniform convergence gives distribution-free sample complexity $O((N(n)+\log(1/\delta))/\varepsilon)$, and Gaussian elimination is polynomial time. Thus, under the product-example model, this class satisfies a stronger source than required: efficient distribution-free realizable improper PAC learning.

This is the key distinction from the agnostic dense-code attempts. Agnostic learning of dense parities would be a hard noisy-parity-style task; realizable parity learning is easy.

#### Target Failure Under One Fixed Marginal

Fix the single marginal $U$ that draws an infinite fair-coin sequence $x\in\{0,1\}^{\mathbb N}$.

For two finite parity vectors $a\ne b$, padded by zeros to a common infinite vector, the parity functions $\langle a,x\rangle$ and $\langle b,x\rangle$ disagree with probability exactly $1/2$ under $U$. Therefore, if a proper hypothesis $c_t$ has

$$
\operatorname{err}_U(c_t,c_s)<\frac12,
$$

then $v_t=v_s$. By the marker, $|t|=|s|$, and then $f(t)=f(s)$.

Now suppose the target node held for this class. For the fixed marginal $U$, there would be one polynomial runtime bound $p_U$ and one inverse-polynomial advantage $\gamma_U(n)$, both independent of the challenge seed. Given a one-way challenge $y=f_n(s)$, simulate labeled examples from $U$ by returning

$$
(x,\langle \operatorname{mark}(n)\,\|\,y,\ x_{1:N(n)}\rangle).
$$

The weak proper learner must output a seed $t$ with error at most $1/2-\gamma_U(n)$, hence with error strictly below $1/2$. Exact parity orthogonality forces $v_t=\operatorname{mark}(n)\|y$, so $f_n(t)=y$. The runtime is polynomial in $n$ because $U$ is fixed. This contradicts one-wayness.

Thus:

> If the atlas permits this product-Cantor/lazy-bit example model, the edge should be marked `false` under length-preserving one-way functions.

The proposed atlas update in that model would be:

```yaml
status: "false"
evidence: conditional-counterexample
assumptions:
  - length-preserving one-way functions exist
witnesses:
  - one-way-parity-image-class
summary: "False under one-way functions: realizable parities over one-way images are strongly improperly learnable by Gaussian elimination, but under a fixed fair-product marginal any weak proper learner must output a seed with the same one-way image."
```

A new witness note would be needed, perhaps `one-way-parity-image-class`, and the argument family would be a sharper fixed-marginal weak-selector hardness subfamily rather than the current sparse coordinate witness.

### Why I Do Not Treat This As Atlas-Ready Yet

The construction uses a fixed non-atomic marginal over infinite bit sequences, or equivalently examples that provide lazy random access to as many fair bits as the learner needs. The current atlas conventions emphasize finite encoded sample transcripts, and all existing witnesses use ordinary finite tuples. If examples must be finite strings drawn from a countable domain, the exact orthogonality trick appears to fail.

The finite-string obstruction is the same mass-budget problem in a different costume.

If finite strings are padded with zeros, then two parities that first differ in coordinate $j$ disagree only when the sampled string reaches coordinate $j$. For any fixed length distribution, $\Pr[L\ge j]\to 0$, so a wrong proper parity can have global error far below $1/2$ by differing only in late coordinates. That recreates the weak handle that killed the sparse one-way-coordinate witness.

If one uses explicit length blocks, the block mass $\mu_n$ again multiplies the useful parity gap. A weak proper learner can ignore the hard block unless it has nearly all the fixed marginal mass, which cannot hold for all $n$.

If one tries a countable atom space with size-dependent feature maps $\phi_n:X\to\{0,1\}^n$, exact parity orthogonality would require $\phi_n(X)$ to be uniform on $\{0,1\}^n$ under one fixed atomic distribution for every $n$. Any atom of positive mass eventually exceeds the target cell mass $2^{-n}$, so exact uniformity is impossible. Approximate small-bias versions leave a positive residual correlation; because the weak advantage $\gamma_P(n)$ is hidden and may be an arbitrarily small inverse polynomial, residual inverse-polynomial correlation is not enough for a lower bound.

So the product-parity witness pinpoints a genuine fork:

- with non-atomic/lazy-bit marginals, this edge is essentially resolved `false`;
- with strictly finite encoded examples over countable supports, the same idea collapses back into tail dilution or residual weak handles.

### Consequence For The Original Question

This pass makes me less confident that the edge is "morally open" in every reasonable model. The realizable-only source can support exact dense parity geometry in a way the agnostic source cannot.

However, under the repository's current finite-transcript conventions, I do not think the edge file should be changed yet. The construction needs either:

1. an explicit atlas decision that lazy random-bit examples / non-atomic product marginals are valid computational PAC instances; or
2. a finite-encoded surrogate that preserves exact or negligible parity orthogonality for all representation sizes under one fixed marginal.

Without one of these, the safe atlas status remains `open`.

### Depth-5 Directions

1. **Model decision.** Decide whether atlas witnesses may use $X=\{0,1\}^{\mathbb N}$ or $X=[0,1]$ with algorithms reading only finitely many bits of each sample. If yes, promote the one-way parity-image construction to a formal false witness.

2. **Finite-transcript surrogate.** Try to realize the same fixed-marginal parity geometry on finite examples. The needed object is one fixed finitely encoded marginal and computable maps $\phi_n(x)\in\{0,1\}^n$ such that $\langle d,\phi_n(X)\rangle$ has bias below every inverse polynomial for every nonzero $d$ arising from two proper code vectors. Countable atoms seem to obstruct exact uniformity.

3. **Atomic lower-barrier lemma.** Prove or refute the informal atom barrier: for a fixed countable marginal and computable finite features, one cannot support exact or superpolynomially small parity bias for exponentially many size-$n$ proper codewords at every $n$ without either non-atomic samples or a tail event whose mass tends to zero.

4. **Length-tail quantification.** Formalize the finite-string padding failure: if coordinate $j$ is visible only on a tail event of mass $\tau_j\to0$, then any weak-selector lower bound based on differences in late coordinates admits wrong proper hypotheses with error at most $\tau_j/2$ on that difference, hence weak handles.

5. **Restricted positive theorem.** If the atlas rejects non-atomic/lazy examples, revisit whether the finite-transcript restriction plus the source's strong realizable improper learner implies some effective weak proper cover. The parity attempt suggests the only obvious fixed-marginal counterexample wants non-atomic entropy.

6. **Separate agnostic note.** Do not transfer this construction to agnostic-improper edges. The source-side algorithm is realizable Gaussian elimination; it does not solve agnostic parity learning.

### References Rechecked

- `atlas/README.md`
- `atlas/definitions/efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`

verdict: unresolved-open

confidence: medium-high for leaving the current atlas edge open; high for conditional `resolved-false` if product-Cantor/lazy-bit examples are admitted.

---

## Depth-5 Follow-Up - 2026-05-05

- depth: 5
- edge_file: atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md
- verdict: unresolved
- confidence: high on the model fork below; medium-high that the atlas edge should remain `open`

### Focus

This pass resolves the modeling fork in the conservative atlas reading.

The depth-4 one-way parity-image construction is a valid conditional separation if examples may be non-atomic product samples, or lazy fair-bit oracles, because then the fixed marginal has enough entropy to make all distinct finite parities exactly orthogonal. I do not think the current atlas permits that witness as written. `atlas/README.md` says computational resource bounds are worst-case/pathwise bounds on finite encoded sample transcripts, and the existing computational witnesses all use finite strings or finite tuples as examples. A lazy product sample is an oracle-valued object whose unrevealed bits remain part of the example; that is a different access model, even though any particular run reads only finitely many bits.

So the current atlas should be read as finite-encoded, hence countable-domain, for computational witnesses. Under that reading, the exact-product-marginal route is not atlas-ready.

### A Heavy-Atom Barrier For Finite Encodings

The finite surrogate obstruction is stronger than the earlier length-tail examples. It is not just that padding finite strings loses late coordinates. Any fixed marginal on finite encodings has a largest atom, and that largest atom prevents an unbounded hidden-gap-safe parity image code.

State the obstruction in $\{\pm 1\}$ notation. Let $P$ be a fixed marginal on a countable finite-encoded instance space $X$. Then there is an atom $x_0$ with mass

$$
\alpha=P(x_0)>0.
$$

Suppose a finite surrogate for the parity-image lower bound supplies, for infinitely many representation sizes, a family $\mathcal F_n$ of proper concepts representing distinct one-way images. Let $M_n=|\mathcal F_n|$. To be hidden-gap-safe for the weak target, the surrogate would need the following kind of condition: for every distinct $f,g\in\mathcal F_n$,

$$
\rho_P(f,g)=\mathbb E_{X\sim P}[f(X)g(X)]\le \eta_n,
$$

where $\eta_n$ is eventually smaller than every inverse polynomial relevant to the hidden weak advantage. In particular, exact orthogonality has $\eta_n=0$, and negligible residual correlation has $\eta_n\to 0$.

Here is the simple bound. Pick a subfamily $S\subseteq\mathcal F_n$ of concepts with the same value at $x_0$. Since labels are binary, $|S|=m\ge M_n/2$. Remove the heavy atom and form the Gram matrix

$$
H_{fg}=\sum_{x\ne x_0} P(x) f(x)g(x),\qquad f,g\in S.
$$

This matrix is positive semidefinite, because it is the Gram matrix of the restricted functions on $X\setminus\{x_0\}$. Its diagonal entries are $1-\alpha$. For $f\ne g$ in $S$, the shared value at $x_0$ gives

$$
H_{fg}=\rho_P(f,g)-\alpha\le \eta_n-\alpha.
$$

Testing positive semidefiniteness on the all-ones vector gives

$$
0\le \mathbf 1^\top H\mathbf 1
\le m(1-\alpha)+m(m-1)(\eta_n-\alpha).
$$

If $\eta_n\le \alpha/2$, then

$$
m\le 1+\frac{2(1-\alpha)}{\alpha},
$$

and therefore $M_n=O(1/\alpha)$ is bounded by a constant depending only on the fixed marginal $P$.

This rules out the needed finite-encoded geometry. A one-way-image reduction needs unbounded, in practice superpolynomially many, distinct image classes on the challenge lengths; otherwise independent random resampling would already invert on nonnegligible challenge probability. But a countable fixed marginal cannot support even an unbounded family of binary concepts whose wrong-image correlations are exact-zero or negligible below the hidden weak threshold.

### Consequences For Candidate Surrogates

1. **Finite strings with padding.** This is the visible special case of the barrier. Coordinates beyond the sampled length live in a tail event, and wrong proper parities differing only there become strong weak handles.

2. **Length-block uniform cubes.** Drawing a finite cube uniformly inside block $n$ gives exact parity orthogonality inside that block, but the fixed marginal assigns the block only mass $\mu_n$. If off-block labels agree or are easy, wrong-image hypotheses can have small global error. If one tries to make all lengths share high mass, one is implicitly asking for the non-atomic prefix-uniform product law.

3. **Feature maps from a countable marginal.** A map $\phi_n:X\to\{0,1\}^{m(n)}$ cannot push a fixed atomic $P$ to exact uniform cubes for unbounded $m(n)$, because the largest atom must land in some cell. More generally, the heavy-atom Gram bound above rules out any hidden-gap-safe family of exponentially many parity-image concepts, even if the map is not trying to be fully uniform.

4. **Polynomial-size approximate codes.** These still leave inverse-polynomial residual correlations at the representation scale. Since the weak target may have an arbitrarily small marginal-dependent inverse-polynomial advantage, such residual correlations remain legal wrong-image weak handles.

5. **Superpolynomial padding.** Making residual correlations negligible by using much larger explicit codes either destroys the polynomial-time realizable improper learner at the relevant representation size or changes the cryptographic scale. If the representation size is padded to include the explicit code length, then the hidden weak advantage is inverse-polynomial in that padded size, and standard finite-code correlation bounds again do not give a uniform separation under ordinary polynomial-time one-wayness.

### Model-Fork Conclusion

Under an expanded model that permits $X=\{0,1\}^{\mathbb N}$, $X=[0,1]$, or lazy random-bit examples with oracle-style finite access, the depth-4 parity-image construction should be promoted to a conditional counterexample:

```yaml
status: "false"
evidence: conditional-counterexample
assumptions:
  - length-preserving one-way functions exist
witnesses:
  - one-way-parity-image-class
summary: "False under one-way functions in a lazy-product example model: realizable parities over one-way images are strongly improperly learnable by Gaussian elimination, while exact orthogonality under the fixed fair-product marginal forces any weak proper learner to invert."
```

Under the current finite-encoded atlas convention, I would not make that update. The proposed finite surrogate cannot preserve the exact or hidden-gap-safe orthogonality needed for the reduction. The appropriate atlas status remains:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
```

A useful future atlas note could mention the conditional lazy-product counterexample as a model warning, not as an accepted witness.

### Remaining Depth-6 Route

The remaining finite-encoded route cannot be a purely geometric "all wrong proper concepts have negligible positive correlation" construction; the heavy-atom barrier rules that out for fixed countable marginals. A depth-6 attempt should instead look for a genuinely computational weak-handle separation:

1. allow non-inverting weakly correlated proper concepts to exist information-theoretically;
2. prove that finding any such weak handle is itself hard, or that a non-inverting weak handle can be converted into a different hard witness;
3. keep the improper realizable learner easy, likely through realizable linear algebra, sparse reconstruction, or another representation-external learner.

That is a different target from the depth-4 parity-image route. It would need to exploit computational hardness of weak proper selection, not exact fixed-marginal orthogonality.

### References Rechecked

- `atlas/README.md`
- `atlas/definitions/efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`

verdict: unresolved-open

confidence: high that the current atlas does not admit the non-atomic/lazy-bit witness without an explicit model expansion; high that exact or hidden-gap-safe finite-encoded parity-image orthogonality is blocked by the heavy atom argument; medium-high that the edge itself should remain open pending a computational weak-handle construction or a positive properization theorem.

---

## Depth-6 Final Attempt - 2026-05-05

- depth: 6
- edge_file: atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md
- verdict: unresolved
- confidence: high that no atlas-ready resolution is available under the current finite-encoded convention

### Focus

This final pass took the depth-5 conclusion seriously: under finite encoded sample transcripts, a separation cannot rest on pure fixed-marginal orthogonality. A fixed countable marginal has heavy atoms, and those atoms create potential weak handles. The only remaining plausible negative route is therefore computational:

1. allow information-theoretic weak handles to exist;
2. make finding any valid weak handle computationally hard;
3. preserve the source by giving an efficient strong improper learner that avoids the hard proper search.

I do not see an atlas-ready construction meeting all three requirements.

### Last Negative Route: Hard Weak Handles

A counterexample would need one fixed marginal $P^\star$ and a hard relation $R(y,t)$ such that, on realizable labels for challenge $y$, every efficiently findable proper hypothesis with

$$
\operatorname{err}_{P^\star}(h,c_y)\le \frac12-\frac1{\operatorname{poly}(s)}
$$

either yields $t$ with $R(y,t)$ or is itself hard to find. This is weaker than the parity-image dream, which tried to make all non-witness proper hypotheses have nonpositive correlation. The finite-encoded setting forces us to tolerate some positively correlated non-witnesses; the lower bound would have to show that they are computationally inaccessible.

The natural one-way-image attempt still breaks. Put a fixed marginal on finitely many visible code coordinates with inverse-polynomial total mass, and encode the one-way image in the target labels. If individual visible bits or small groups have inverse-polynomial mass, then a learner can often get a weak handle by matching a few bits of the image. For ordinary seed-indexed proper classes this is easy by random trial and holdout validation: a random seed matches any single balanced bit with probability about $1/2$, and among many random seeds one can find a small positive empirical correlation at the natural $1/\sqrt{k}$ code scale. If the code is lengthened to push all residual correlations below every possible hidden weak advantage, the depth-5 heavy-atom Gram obstruction reappears for a fixed countable marginal, or the representation size/code length accounting stops giving a standard polynomial-time one-way-function contradiction.

The analogous PCP attempt also fails. To avoid input-dependent active-slice marginals, the formula must be encoded in labels under one shared marginal. Then a proper weak learner must be prevented from outputting a proof for a high-mass irrelevant formula, or from matching only a few high-mass formula-code bits. Achieving that again asks for a balanced fixed-marginal code of the instance identity. With finite encodings, high-mass atoms create easy partial-match handles unless the construction makes even those partial matches hard. I do not know how to do this without smuggling in nonuniform hard instances or changing the example model.

One could try to make matching the heaviest atoms hard by defining the class so that finding any proper concept with a prescribed label pattern on those atoms is an NP or cryptographic search problem. This is the right computational weak-handle abstraction, but I do not see a uniform standard witness. If the hard pattern is input-dependent, the marginal or the labels must carry the input; then slice dilution or partial-code handles return. If the hard pattern is fixed, the construction risks relying on a nonuniform hard sequence rather than a conventional atlas assumption such as $\mathrm{NP}\nsubseteq\mathrm{RP}$ or length-preserving one-way functions.

### Why This Does Not Become A Positive Theorem

The failure of these counterexample attempts is not a proof of the implication. The source learner gives accurate improper prediction, but it still gives no generic way to synthesize even one proper concept matching the target on a heavy finite set.

For a fixed finite-encoded marginal $P$, let $H$ be a high-mass finite prefix of atoms. If we had an efficient procedure that, from labeled samples or from the improper predictor, found a proper $h\in\mathcal C$ agreeing with the target on noticeably more than half of $H$, then holdout validation would give the target. But this procedure is exactly a fixed-marginal weak proper selector. The source definition does not include it. A class can be easy to learn by improper tables on $H$ while proper consistency or weak proper optimization over $H$ is computationally difficult.

Thus the final state is asymmetric:

- pure geometry is too strong for finite encoded fixed marginals;
- known computational hardness gadgets do not yet make weak handles hard under one fixed marginal;
- the source learner is still not enough to build a proper weak selector.

### Atlas-Ready Unresolved Summary

Keep the edge open. The most accurate atlas summary I would use is:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
summary: "Open under finite-encoded computational conventions: strong marginal-nonuniform improper learning gives accurate prediction but no known efficient weak proper selector. Non-atomic parity-image witnesses would separate the edge in a lazy-product model, but finite fixed marginals have heavy-atom weak handles; known PCP and one-way constructions either dilute the hard slice or leave easy partial-match proper hypotheses."
```

Suggested body text:

> **Verdict.** `open`.
>
> The source supplies one uniform learner that predicts every realizable target accurately under each fixed marginal, with a marginal-dependent polynomial bound. The target asks for a member of the original class with inverse-polynomial advantage. No known theorem converts the improper predictor into such a proper weak selector.
>
> A non-atomic/lazy-bit parity-image construction would give a conditional one-way-function separation, because realizable parities are improperly learnable by Gaussian elimination while exact product-marginal orthogonality forces any weak proper hypothesis to invert. Under the atlas's current finite-encoded convention, this witness is not accepted: a fixed countable marginal has heavy atoms, and the heavy-atom Gram argument blocks exact or hidden-gap-safe orthogonality for unbounded proper families.
>
> The remaining negative route would need computational weak-handle hardness: positively correlated non-witness proper hypotheses may exist, but finding any of them would have to be hard. Existing PCP active-slice and one-way-image-coordinate witnesses do not establish this under one fixed marginal. PCP slices become input-dependent or diluted; one-way code variants leave partial-match or residual-correlation handles that can be found without inversion.
>
> Therefore the edge remains a finite-encoded marginal-nonuniform properization open problem.

### Best Obstacles

1. **No proper selector from the source.** Accurate improper prediction can be a table, parity vector, sparse memorizer, or external representation. The source does not provide a polynomial-time map back into $\mathcal C$.

2. **Hidden weak advantage.** A counterexample must rule out every inverse-polynomial positive correlation promised by the unknown target learner. Approximate codes with residual inverse-polynomial correlations are not enough.

3. **Heavy atoms in finite encodings.** Every fixed countable marginal has a largest atom. Any large binary proper family has many concepts agreeing there, creating weak handles and blocking all-wrong-hypotheses orthogonality.

4. **Easy partial matches.** In standard seed-indexed cryptographic code classes, matching a few high-mass bits or finding a small positive random correlation is usually easier than inversion and can satisfy a weak target.

5. **Input-dependent hardness.** PCP-style weak proper lower bounds are clean when the marginal is the active slice for the input instance. Marginal-nonuniformity absorbs that dependence, and packing all slices into one marginal dilutes the weak signal.

6. **Nonuniform hard-sequence danger.** Making the heaviest-atom label pattern hard to match looks possible only by baking in a fixed hard sequence, which is not an atlas-ready standard complexity assumption.

### Future Directions

1. Formalize a `fixed-marginal weak proper selector` argument note: the edge is true for classes where accurate improper prediction plus samples from $P$ can generate a polynomial-size proper candidate list containing an inverse-polynomially correlated concept.

2. Search for a standard, uniform computational weak-handle witness. The target lower bound should explicitly allow non-witness weak handles and prove that finding any such handle solves a hard search problem.

3. Revisit average-case or distributional assumptions stronger than ordinary one-way functions. A useful assumption would need to say that partial code agreement under the fixed marginal is hard, not merely full inversion.

4. Keep the depth-4 lazy-product parity construction as a model warning. If the atlas ever permits non-atomic examples or oracle-valued lazy samples, this edge should be reconsidered as conditionally false.

5. Avoid spending further effort on pure finite-encoded orthogonality. Depth 5's heavy-atom Gram argument is the right barrier: the next real progress must be either an efficient selector theorem or computational hardness of weak handles.

verdict: unresolved-open

confidence: high that the edge should remain open under the current finite-encoded atlas conventions; medium-high that any future false witness must use computational weak-handle hardness rather than pure orthogonality.
