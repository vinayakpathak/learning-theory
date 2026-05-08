# Edge: efficient-marginal-nonuniform-agnostic-improper-pac -> efficient-marginal-nonuniform-weak-realizable-proper-pac

- depth: 1
- edge_file: atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md
- verdict: unresolved
- confidence: medium

## Context

The source is efficient marginal-nonuniform strong agnostic improper PAC learning. One uniform learner must work for every joint distribution, but the sample and runtime polynomial may depend on the instance marginal $P$. The learner may output hypotheses outside $\mathcal C$.

The target is efficient marginal-nonuniform weak realizable proper PAC learning. For every marginal $P$, one must output a member of $\mathcal C$ with error at most $1/2-\gamma_P(s)$ on realizable examples, where $1/\gamma_P(s)$ is bounded by a $P$-dependent polynomial.

Thus the only hard step is properization: the source gives strong prediction by an improper hypothesis, while the target asks for even a weakly correlated proper representation.

## Attempted Resolution

I checked whether the existing improper-to-proper hardness witnesses resolve this exact marginal weak edge.

The PCP active-slice lookup class separates distribution-free weak improper learning from weak proper learning under $\mathrm{NP}\nsubseteq\mathrm{RP}$, and its argument note says it is even agnostically improperly learnable by one-slice lookup-table ERM. This gives the distribution-free false edges such as `efficient-agnostic-improper-pac -> efficient-weak-agnostic-proper-pac`.

However, the same proof does not refute the marginal-nonuniform target. The weak proper lower bound runs the learner on the uniform marginal over the active slice of the input formula $\varphi$. If the marginal is allowed to depend on $\varphi$, the target's runtime polynomial and weak advantage may also depend on that marginal, so the reduction no longer yields a single polynomial-time decision procedure for the NP-complete language. Packing all formula slices into one fixed marginal makes each individual slice have tiny mass, which dilutes the global weak advantage below the learner's unknown inverse-polynomial gap.

The one-way image-coordinate class is a stronger fixed-marginal properization witness for strong proper learning under length-preserving one-way functions. It also satisfies an agnostic improper source by sparse lookup-table ERM. But it does not seem to rule out weak proper learning. Under the fixed all-length marginal with block mass $\mu_n=6/(\pi^2n^2)$, any same-length seed concept has total error at most $\mu_n$ against a length-$n$ target, even if it encodes the wrong image. This already beats random guessing by nearly $1/2$, so a weak proper learner can succeed without inverting the one-way function.

I also considered a dense-code repair: replace coordinates of $f(s)$ by an error-correcting or small-bias code so that any wrong image has distance close to $1/2$ within a length block, while an improper lookup learner can still learn the codeword. This helps at a single fixed length, but the marginal-nonuniform target needs one fixed marginal across all input lengths to obtain a uniform cryptographic inverter. Once the fixed marginal spreads mass over infinitely many lengths, a length-$n$ block again has vanishing mass, and weak global error no longer forces decoding the length-$n$ image. Concentrating the marginal on one length would let the marginal-dependent polynomial vary with the input length, which is not enough for a standard polynomial-time contradiction.

The theorem direction also remains blocked. The source implies strong improper realizable learning under the same marginal by restriction to realizable distributions, and sample-only consequences give existence of proper hypotheses through VC-style finite-sample arguments. None of these provide an efficient projection or ERM over $\mathcal C$. Standard boosting does not solve this either: boosting improves weak predictors but typically outputs votes or aggregates, not a single proper concept, and here the source is already strong but improper.

## Proposed Atlas Update

Keep the edge open.

Suggested metadata if the note is refreshed:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - schapire1990
  - pitt1988
  - khot2008dnf
  - hastad2005query
  - kearns1994cryptographic
  - hastad1999prg
refs:
  - "[Schapire 1990](https://doi.org/10.1023/A:1022648800760)"
  - "[Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)"
  - "[Khot and Saket 2008](https://doi.org/10.1109/FOCS.2008.37)"
  - "[Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)"
  - "[Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)"
  - "[Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)"
summary: "Open: agnostic improper learning gives strong prediction, but no efficient marginal-nonuniform weak properization theorem or fixed-marginal weak separation is currently recorded."
family: properization-open
argument_note: "[[properization-open|Properization Open]]"
```

Replacement body sketch:

> **Verdict.** `open`.
>
> **Goal.** Decide whether a strong marginal-nonuniform agnostic improper learner can always be converted, on realizable data, into a proper hypothesis with inverse-polynomial advantage under the same marginal.
>
> **Theorem route.** Restricting the agnostic learner to realizable distributions gives strong improper prediction, but the target requires output in $\mathcal C$. VC/sample arguments give existence of good proper hypotheses once runtime is ignored, not an efficient projection back into the representation class.
>
> **Counterexample route.** PCP active-slice hardness separates distribution-free weak improper from weak proper learning, but its hard marginal varies with the input instance. Marginal-nonuniformity lets the target's polynomial and weak gap depend on that marginal. Packing all hard slices into one fixed marginal dilutes the weak global gap. One-way image-coordinate witnesses give fixed-marginal strong proper hardness, but same-length wrong-image concepts already have tiny global error under the all-length marginal, so they do not force inversion at the weak threshold.
>
> **Conclusion.** The implication remains open as a marginal-nonuniform weak properization question.

## Obstacles

- The source's improper output may approximate the target concept very well while carrying no efficiently recoverable proper representation.
- Distribution-free PCP-style weak proper lower bounds use an input-specific active-slice marginal; marginal-nonuniform target guarantees are too nonuniform over such marginals to produce a uniform polynomial-time NP decision procedure.
- Fixed-marginal cryptographic witnesses that spread mass across all lengths lose the weak signal on each individual hard length.
- Dense code repairs need both efficient agnostic improper learnability and a fixed marginal where every wrong proper concept has global error at least $1/2-\gamma_P(s)$ for the target learner's unknown inverse-polynomial $\gamma_P$.

## Next Directions

1. Try to build a fixed-marginal dense-code cryptographic witness whose pairwise proper distances are near $1/2$ globally across all lengths, not only inside a low-mass length block, while preserving efficient agnostic improper lookup-table ERM.
2. Look for a representation-sensitive theorem converting efficient improper agnostic learning plus finite VC dimension into weak proper learning under fixed marginals; this would need an efficient approximate proper ERM or projection principle.
3. Revisit Khot-Saket-style DNF hardness to see whether any inverse-polynomial proper weak lower bound is known for a class that remains efficiently agnostically improperly learnable.
4. Check whether stronger nonuniformity conventions, such as advice algorithms per marginal, would make the edge true or false; this may isolate exactly where the current atlas convention blocks the usual reductions.

## References Checked

- `atlas/definitions/efficient-marginal-nonuniform-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-agnostic-improper-pac--implies--efficient-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-agnostic-improper-pac--implies--efficient-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`

---

# Depth-2 Follow-Up

- depth: 2
- edge_file: atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md
- verdict: unresolved
- confidence: medium-high

## Context

I focused on the requested counterexample direction: fixed-marginal weak realizable proper separations. The target guarantee is very weak but also very nonuniform: for one fixed marginal $P$, a hypothetical proper learner may have an unknown inverse-polynomial advantage $\gamma_P(s)$, and the polynomial behind $\gamma_P$ is not exposed to the reduction. A false witness therefore has to make every non-inverting or non-witnessing proper concept have error at least $1/2-\gamma_P(s)$ under one fixed marginal, while keeping the source strongly agnostically learnable by an improper algorithm.

## Attempted Resolution

### PCP Active Slices

The active-slice PCP witness still seems unable to survive marginal-nonuniformity.

For an input formula $\varphi$, the distribution-free reduction uses the marginal concentrated on the active slice $\{(\varphi,r): r\in\{0,1\}^{O(\log |\varphi|)}\}$. A satisfiable $\varphi$ gives an all-positive realizable labeling on that slice; an unsatisfiable $\varphi$ makes every proper proof accept on at most a soundness-$s<1/2$ fraction. Thus weak proper learning extracts a proof with acceptance above $1/2$.

To make this one fixed marginal, one can pack formula slices with masses $w_\varphi$. The global acceptance gap contributed by $\varphi$ is only $(1/2-s)w_\varphi$. For length $n$ there are exponentially many possible formulas, so a single fixed marginal cannot give inverse-polynomial mass to all length-$n$ slices. Using a length block of mass $\mu_n=1/\operatorname{poly}(n)$ and distributing it over all formulas gives typical slice mass $\mu_n 2^{-\Omega(n)}$, far below the hidden inverse-polynomial weak advantage.

This is not just a cosmetic issue. If the reduction instead chooses a separate marginal for each length or each formula, the marginal-dependent runtime and weak-gap polynomial may vary with the input. That does not yield a single randomized polynomial-time algorithm for the NP language.

I also tried the usual "put the instance in the labels, not the marginal" repair. The clause-satisfaction fixed-marginal trick works for strong proper agnostic targets because formula clauses carry an inverse-polynomial optimum gap inside the uniform clause marginal. For a weak realizable target, however, the learner is allowed any proper concept beating $1/2$ by its hidden inverse polynomial. A random or simple assignment can already weakly satisfy many ordinary clause distributions, and making the PCP gap constant seems to require concentrating the marginal on the input's active constraints, reintroducing the varying-marginal problem.

### One-Way Coordinate Blocks

The original image-coordinate witness fails for weak learning because wrong proper concepts are too good globally: if a length-$n$ target differs from another seed only on the length-$n$ block of mass $\mu_n$, then even a non-inverting seed has error $O(\mu_n)$ or at most $\mu_n$, which is far below $1/2-\gamma_P(s)$.

I pushed on the natural repair: replace the sparse image coordinates by balanced codewords. Suppose a seed $u$ defines labels $E(f(u))$ over a shared coordinate set, and $E$ has pairwise relative distances very close to $1/2$. Then a weak proper learner for labels $E(y)$ would have to output a seed $t$ with $f(t)=y$, provided every wrong image codeword has error at least $1/2-\gamma_P(s)$.

This splits into two incompatible regimes.

1. Exact orthogonal codes, such as Hadamard/parity codes, have the perfect geometry: every wrong image is exactly distance $1/2$. But their coordinate set has size $2^n$. If concepts of seed length $n$ are represented with size $n$, then the improper lookup/ERM source is no longer polynomial time. If the representation is padded so the size is $S=2^n$, then a target learner running in $\operatorname{poly}(S)$ only gives a subexponential-time inverter in the original seed length, which does not contradict ordinary one-wayness.

2. Polynomial-length error-correcting or small-bias codes keep the lookup-style improper source plausible: a concept has only $L=\operatorname{poly}(n)$ relevant coordinates, and sparse/table ERM can compete with the proper class. But a family of $2^n$ binary codewords of length $L$ cannot have all pairwise distances $1/2-o(1/\operatorname{poly}(L))$ for every polynomial exponent. Standard packing intuition gives unavoidable bias on the order of at least $\sqrt{n/L}$ for random-like polynomial codes, and exact orthogonality would require length at least the number of mutually orthogonal sign vectors. Since the target's $\gamma_P(s)$ may be a much smaller inverse polynomial than the code bias, a wrong seed could still satisfy the weak guarantee.

Overlapping all lengths on one high-mass prefix does not remove this tension. It can fix the "low-mass length block" problem, but then the construction needs cross-length codewords for all images at all lengths to be closer than the unknown weak gap to distance $1/2$ on the same fixed marginal. With polynomially many high-mass coordinates at size $s$, this runs into the same packing barrier. With exponentially many coordinates, the improper source or the cryptographic contradiction no longer has the right polynomial scale.

### Known Weak Improper/Proper Separations

I checked the known weak proper hardness families for a direct transplant.

Khot-Saket-style DNF hardness is a near miss. It gives constant-advantage hardness for learning small DNF by restricted proper hypothesis classes under $\mathrm{NP}\nsubseteq\mathrm{RP}$, but the hard distribution is produced by the reduction instance. More importantly for this edge, the class is not known in the atlas to be strongly agnostically learnable by an efficient improper learner. Using the PCP active-slice lookup class recovers the easy improper source, but then the hard marginal is exactly the varying active slice discussed above.

Pitt-Valiant and clause-satisfaction lookup witnesses give strong proper hardness, and the atlas already uses clause satisfaction to refute marginal-nonuniform strong agnostic proper targets under a fixed clause marginal. They do not force weak proper failure: the gap that identifies a satisfying assignment is an accuracy/optimization gap, not a statement that all non-witness proper concepts have error close to $1/2$.

Cryptographic distribution-specific hardness, such as Kharitonov-style fixed-distribution hardness for formulas/circuits, points in the opposite direction: it gives hard fixed marginals for prediction itself. That would threaten the source node rather than provide a class that remains efficiently agnostically improperly learnable.

## Proposed Atlas Update

No resolved update. I would keep the atlas edge open.

If refreshing the note, I would add one sentence to the proof status:

> The strongest apparent counterexample route is a fixed-marginal balanced-code properization witness, but polynomial-size code supports leave an inverse-polynomial correlation slack while exact orthogonal codes destroy the ordinary polynomial-time improper source or require stronger-than-standard cryptographic hardness.

No change to `status`, `evidence`, `assumptions`, or `witnesses` is justified by this depth-2 pass.

## Obstacles

- **Mass packing obstacle:** A fixed marginal cannot give inverse-polynomial mass to every PCP active slice for exponentially many length-$n$ instances. Any packed-slice weak gap is multiplied by slice mass.
- **Hidden weak-gap obstacle:** The target only promises some $\gamma_P(s)>0$ with $1/\gamma_P$ polynomial. A candidate false witness must beat every possible polynomial exponent for the fixed marginal, not just a chosen inverse-polynomial separation scale.
- **Code-packing obstacle:** Polynomial-length shared-coordinate codes can make wrong proper concepts almost uncorrelated, but not close enough to $1/2$ to dominate an unknown inverse-polynomial weak gap. Exact $1/2$ orthogonality costs exponential coordinate length.
- **Source-side obstacle:** Dense balanced codewords make proper weak hardness plausible, but they turn the source into an agnostic decoding/correlation problem. Sparse lookup supports make agnostic improper learning easy, but they also let wrong proper concepts have tiny global error unless the support has large fixed mass.
- **Known-separation mismatch:** Existing weak proper hardness results either vary the marginal with the instance or lack an efficient strong agnostic improper learner for the same concept class.

## Next Directions

1. Formalize the code-packing barrier for this atlas setting: prove a lemma saying that any polynomial-time sparse/table improper source with $L(s)=\operatorname{poly}(s)$ effective coordinates cannot force all wrong proper concepts to have distance $1/2-1/s^k$ for all $k$ when there are exponentially many hard seeds.
2. Investigate whether a subexponentially hard or exponentially hard one-way-function assumption plus padded representations would yield a clean conditional separation. This would not be the standard atlas assumption, but it may clarify whether the only blocker is the polynomial scale.
3. Search for fixed-marginal PCP encodings with shared randomness coordinates and instance-dependent labels where satisfiable instances are realizable and unsatisfiable instances make every proper proof have error at least $1/2-o(1/\operatorname{poly})$ without giving the instance an exponentially small slice.
4. Look for structural positive theorems for classes with efficient marginal-nonuniform agnostic improper lookup learners: perhaps the same "effective finite trace" property that makes the source easy can always be exploited to output some weakly correlated proper concept under fixed $P$.

## References Checked

- `atlas/definitions/efficient-marginal-nonuniform-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- `atlas/arguments/clause-satisfaction-proper-hardness.md`
- `atlas/witnesses/clause-satisfaction-lookup-class.md`
- `atlas/arguments/sample-to-computational-hardness.md`
- [Khot and Saket 2008](https://doi.org/10.1109/FOCS.2008.37)
- [Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)
- [Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)
- [Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)
- [Kharitonov 1993](https://doi.org/10.1145/167088.167197)

---

# Depth-3 Follow-Up

- depth: 3
- edge_file: atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md
- verdict: unresolved
- confidence: medium-high

## Focus

This pass focused only on balanced one-way/code constructions under one fixed marginal. The desired counterexample template is:

1. A proper concept is a hard certificate, usually a one-way preimage or PCP proof.
2. The fixed marginal has enough balanced mass on the challenge coordinates that any proper hypothesis with error $<1/2-\gamma_P(s)$ reveals the certificate.
3. The class is still efficiently agnostically learnable by an improper lookup-style learner.

The first two requirements push toward dense, nearly orthogonal encodings. The third requirement pushes toward sparse or polynomial-support lookup tables. I did not find a construction satisfying both.

## Attempted Resolution

### Error-Correcting Output Encodings

The cleanest one-way variant would encode the one-way image $y=f(u)$ by a balanced binary codeword $E(y)$. A target seed $u$ labels a shared coordinate domain by $E(f(u))$, while a proper hypothesis must output a seed $t$. If every wrong image $f(t)\ne y$ has correlation at most $0$ with $E(y)$ under the fixed marginal, then any weak proper learner with any inverse-polynomial advantage must return a seed inverting $y$.

Ordinary error-correcting and small-bias codes miss exactly at the hidden-gap scale. A polynomial-length code can make all wrong image codewords have correlation at most some chosen inverse polynomial $\eta(s)$, but the target only promises an unknown marginal-dependent advantage $\gamma_P(s)$. If $\gamma_P(s)<\eta(s)$, a wrong seed with correlation $\eta(s)$ is a legal weak output and the reduction extracts no preimage.

Making $\eta$ negligible in the seed length by lengthening the code does not repair the scale issue once representation size is counted honestly. If the code has length $L$ and lookup ERM enumerates sampled coordinates, then the runtime is polynomial in $L$ at best, and the target's weak gap is allowed to be inverse-polynomial in the resulting size parameter. A fixed polynomial or mildly superpolynomial code length leaves a residual positive correlation at some inverse-polynomial scale in that size parameter; exact orthogonality returns to Hadamard/Plotkin territory and requires exponentially many coordinates for exponentially many images.

This also clarifies the all-length fixed-marginal problem. Assigning length block mass $\mu_n$ makes the visible global advantage from a length-$n$ code only $\mu_n$ times the within-block correlation. If $\mu_n$ is inverse-polynomial, an exactly orthogonal code would still be enough, because every wrong seed has no positive correlation. But any positive residual correlation is multiplied by $\mu_n$ and can still exceed the hidden $\gamma_P$ for some learner polynomial. Thus the construction really wants nonpositive, not merely small, wrong-code correlation on the relevant global marginal.

### Goldreich-Levin and Hard-Core Predicate Encodings

Goldreich-Levin-style predicates give the right geometry in the most direct form. If a seed $u$ is represented by the parity code $r\mapsto \langle u,r\rangle$, then under the uniform marginal on $r$ every wrong seed is exactly distance $1/2$ from the target. A weak proper learner with any positive advantage would identify the seed.

The source side is the obstruction. Agnostic improper lookup learning no longer applies under the uniform parity-coordinate marginal: the learner sees random examples from a dense codeword, not a sparse set of positive atoms. Outputting the image or seed as an improper hypothesis would require solving a noisy parity or agnostic Hadamard decoding problem from random examples. The Goldreich-Levin algorithm recovers a list from oracle/query access to a predictor correlated with the hard-core bit; it is not an agnostic PAC learner competing with the best parity/codeword under arbitrary labels and arbitrary marginals.

Trying to attach the one-way image explicitly, with examples of the form $(y,r)$ and labels $\langle u,r\rangle$ when $y=f(u)$, reintroduces the marginal issue. Concentrating on the challenge image makes the marginal depend on the instance. Spreading mass over all images makes the challenge image slice exponentially or at least too thin unless one adds a target-dependent balanced guard, which again becomes the dense-code problem above.

So the Goldreich-Levin route is a good diagnostic but not yet a witness: it supplies exact weak-safe separation, but it replaces lookup ERM by parity/list-decoding.

### Kharitonov-Style Fixed-Distribution Hardness

Kharitonov-style results are also a near miss in the opposite direction. They give cryptographic lower bounds for weak learning natural circuit/formula classes on fixed distributions such as the uniform distribution, and distribution-specific variants extend this kind of hardness to nontrivial fixed marginals. That is precisely the kind of visible fixed-marginal weak gap one would like for the target failure.

But these results are prediction hardness results, not properization-only hardness results. If a class is hard to weakly learn under the fixed marginal even with membership queries, then it does not preserve the assigned source, which requires efficient agnostic improper learning. Using such a hard class directly would refute the source as well as the target.

One could try to wrap a Kharitonov-hard core inside an improper lookup-friendly representation, but then the wrapper must expose enough labels for efficient agnostic improper learning while preventing any proper weak handle. The known lookup wrappers expose sparse or finite traces, and those are exactly what create low-error weak handles under one fixed marginal. Making the wrapper balanced and hard-core-like removes the handles but brings back fixed-distribution prediction hardness for the improper learner.

## Verdict

Keep the edge open.

The depth-3 check strengthens the current obstacle rather than resolving it. Error-correcting output encodings can make wrong seeds almost uncorrelated, but not uniformly below the target's hidden inverse-polynomial weak gap while keeping a polynomial lookup domain. Goldreich-Levin/Hadamard predicates give exact orthogonality, but the source becomes agnostic parity or hard-core decoding rather than lookup-table ERM. Kharitonov-style fixed-distribution hardness supplies fixed-marginal weak hardness for prediction itself, which threatens the improper source instead of isolating properness.

## Obstacles

1. **Hidden-gap robustness.** A false witness should make every non-certificate proper hypothesis have nonpositive or negligible-in-size correlation with the target labels. A fixed inverse-polynomial residual correlation is not enough because $\gamma_P$ is hidden.

2. **Exact orthogonality costs density.** Hadamard and hard-core encodings have the weak-safe geometry, but their natural coordinate domains are dense and high-entropy. The sparse lookup ERM proving the source no longer works.

3. **Polynomial-code packing.** Polynomial coordinate domains can support efficient lookup learning, but cannot host exponentially many one-way images or hard instances with pairwise nonpositive correlation.

4. **Fixed-distribution cryptographic hardness is too strong.** Kharitonov-style hardness rules out weak prediction under the fixed marginal; the assigned source needs efficient improper agnostic prediction under the same marginal.

5. **Instance-in-marginal repairs are invalid here.** Concentrating the balanced code or hard-core predicate on the challenge instance makes the marginal vary with the cryptographic or NP input, allowing the target's polynomial and weak gap to vary with that input.

## Next Depth-4 Directions

1. **Negligible-correlation code accounting.** Formalize the size-parameter tradeoff: if a code over $2^n$ images has wrong-code correlation below $S^{-k}$ for all $k$ measured in the learner's representation size $S$, then either the coordinate domain is effectively exponential or the code family has extra structure beyond lookup ERM.

2. **Proper-only hard-core wrapper.** Search for a wrapper where the improper learner can output a tractable non-seed description of the dense codeword, but every proper seed with weak correlation yields a one-way preimage. The key test is whether the non-seed description can be learned agnostically from random examples without solving noisy parity.

3. **List-output reduction.** Revisit whether a weak proper learner returning a wrong but correlated codeword can be used iteratively to eliminate candidates under the same fixed marginal. This would relax the need for exact pairwise nonpositive correlation.

4. **Kharitonov separation transplant.** Look for a distribution-specific hardness theorem whose lower bound is representation-sensitive, ruling out only proper learners while allowing an explicit improper hypothesis class to learn. The standard fixed-distribution hardness statements appear too prediction-hard, but a representation-sensitive variant would be directly relevant.

## References Checked

- Depth-1 and depth-2 references above.
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/sample-to-computational-hardness.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`
- Michael Kharitonov, "Cryptographic hardness of distribution-specific learning," FOCS 1993, DOI [10.1109/SFCS.1993.366850](https://doi.org/10.1109/SFCS.1993.366850).
- Michael Kharitonov, "Cryptographic Lower Bounds for Learnability of Boolean Functions on the Uniform Distribution," JCSS 50(3):600--610, 1995, DOI [10.1006/jcss.1995.1046](https://doi.org/10.1006/jcss.1995.1046).

---

# Depth-4 Follow-Up

- depth: 4
- edge_file: atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md
- verdict: unresolved
- confidence: medium-high

## Focus

This pass focused on the positive-theorem route requested in the prompt. I treated the counterexample attempts from depths 1--3 as still inconclusive and asked whether, for each fixed marginal $P$, strong agnostic improper learning could be turned into weak realizable proper learning by:

1. enumerating sample-supported traces,
2. using compactness or finite $L_1(P)$ covers, or
3. exploiting the marginal-dependent runtime polynomial to perform a $P$-specific proper search.

I did not find a generic theorem. The obstruction is now more precisely computational: fixed-marginal nonuniformity can pay for a larger polynomial once a finite proper search space is effectively available, but it does not itself provide that search space, an enumeration of representative concepts, or a projection from an improper predictor back into $\mathcal C$.

## Attempted Resolution

### What the Source Gives on Realizable Data

Fix a marginal $P$ and a target $c^\star\in\mathcal C$. Running the source agnostic improper learner on realizable examples from $(X,c^\star(X))$, with $\varepsilon$ chosen small, gives an improper hypothesis $g$ with

$$
\Pr_{X\sim P}[g(X)\ne c^\star(X)]\le \varepsilon
$$

in $P$-dependent polynomial time. Thus, statistically, there is a proper concept very close to $g$: namely $c^\star$ itself. The target only asks for much less, a proper concept with error at most $1/2-\gamma_P(s)$ against $c^\star$.

The missing step is to find any such proper concept. The learner's output $g$ may be an arbitrary external representation. The source guarantee says nothing about making $g$ a decomposable object, a convex combination of concepts, a compression scheme, or a certificate from which one can recover a nearby member of $\mathcal C$.

### Sample-Supported Trace Enumeration

A tempting construction is:

1. draw a sample $S=(x_1,\dots,x_m)$ from $P$,
2. run the improper learner to get labels $g(x_i)$ on $S$,
3. enumerate traces $(c(x_1),\dots,c(x_m))$ realized by concepts $c\in\mathcal C$,
4. output a concept whose trace agrees well with $g$ or with the true sample labels.

The problem is that step 3 is not an algorithm in the atlas model. Enumerating possible binary traces is different from outputting a representation of a concept in $\mathcal C$ realizing a chosen trace. Even if the number of distinct traces is sample-controlled by VC/Sauer bounds, realizing or optimizing over those traces is exactly a proper ERM/search problem.

There is also a quantitative issue. From the marginal-nonuniform sample side one expects a finite-dimensional consequence: polynomial marginal-nonuniform rates force finite VC dimension, and the sample-only atlas uses unrestricted ERM to move from improper to proper. But a trace bound of the form $m^{d(s)}$ is not generally polynomial time when $d(s)$ is polynomial in the representation size. For weak learning one could take a constant-accuracy sample, yet the cover or trace count remains exponential in $d(s)$ in general. Marginal dependence lets the exponent's constants depend on $P$, but it does not turn an exponential-in-$d(s)$ search into a polynomial in $s$.

Finite support is the special case where the idea can work. If $P$ has an effectively known support of size $\operatorname{poly}_P(s)$ and the representation language admits an efficient realizability/ERM procedure on that support, then sample-supported properization is plausible. The assigned edge, however, quantifies over arbitrary marginals and arbitrary represented classes satisfying the source; it does not assume effective finite support or a proper-consistency oracle.

### Compactness and Finite-Cover Arguments

For a fixed marginal $P$, finite VC dimension gives total boundedness of $\mathcal C$ in the $L_1(P)$ pseudometric at each fixed size scale. Thus, ignoring computation, one can choose a finite $\eta$-cover by concepts and validate the cover on samples. This is the compactness route.

This also stops short of a computational theorem for three reasons.

First, the cover is nonconstructive. A marginal-dependent polynomial bound may depend on $P$, but the learner remains one uniform algorithm and is not handed a $P$-specific cover as advice.

Second, even if the cover exists with size $(1/\eta)^{O(d(s))}$, that is not polynomial time for general polynomial $d(s)$. For the weak target a constant $\eta<1/4$ suffices statistically, but the cover size is still exponential in the VC dimension.

Third, a finite cover of label functions in $L_1(P)$ is not automatically a list of valid output representations. To be useful for the target, the algorithm must output an actual member of $\mathcal C$, not merely a cover cell, a trace, or an improper representative.

So compactness proves the sample-only shadow already recorded in [[sample-complexity-equivalence|Sample-Complexity Equivalence]], not an efficient properization theorem.

### Can the Improper Learner Induce a Proper Search?

Another possible positive route is to use $g$ as an oracle-like guide. Since $g$ is close to $c^\star$, perhaps a proper hypothesis with weak correlation could be found by searching for concepts agreeing with $g$ on fresh samples.

This reduces to approximate proper ERM with labels supplied by $g$. If the class has an efficient proper agnostic learner, then the edge is trivial through the proper source node. But the assigned source is improper precisely because such proper search may be unavailable. The improper learner may succeed by using a larger hypothesis class with efficient ERM, by sparse lookup, or by another external representation. Its success does not imply that the original representation class is searchable.

The computational failure can be isolated as follows. A generic conversion would need a polynomial-time procedure that, given sample access to $P$ and evaluation access or an explicit description of an arbitrary low-error external predictor $g$, returns some $c\in\mathcal C$ with nontrivial $P$-correlation with $g$. This is a representation-sensitive approximate projection problem. It is not supplied by agnostic improper learning, by marginal nonuniformity, or by finite-sample compactness.

### Why Marginal Nonuniformity Does Not Save the Search

The key convention in the atlas definitions is that there is still one learner for all marginals. For each fixed $P$ the time bound may be a different polynomial $p_P$, but the algorithm is not replaced by a $P$-specific algorithm and is not given a $P$-specific advice string.

Therefore, marginal nonuniformity can justify statements like "this uniform algorithm happens to finish within a larger polynomial under $P$." It cannot justify "choose an arbitrary finite $P$-cover and enumerate it" unless the uniform algorithm can compute that cover or can discover it from samples in polynomial time. Samples reveal high-probability regions of $P$, but they do not reveal which proper representations realize the relevant traces.

This is the exact point where the positive theorem fails: the fixed marginal makes statistical search finite, while efficient proper learning needs an effective representation-level search over $\mathcal C$.

## Proposed Atlas Update

No resolved atlas update. I would keep:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
```

If the edge note is refreshed, I would add a positive-route obstruction sentence:

> For each fixed marginal, sample-supported trace and finite-cover arguments give nonconstructive proper hypotheses, but they require either exhaustive proper ERM or an effective $P$-specific cover. Marginal nonuniformity changes the allowed polynomial bound, not the uniform learner's access to such a cover or to a projection from an improper predictor into $\mathcal C$.

## Obstacles

1. **Trace realization is a proper ERM problem.** Enumerating labels on a sample is not enough; the target requires an actual representation in $\mathcal C$.

2. **Finite covers are nonconstructive and often too large.** Fixed-marginal compactness gives existence, but generic covers have size exponential in VC dimension and are not necessarily computable from samples.

3. **Marginal nonuniformity is not advice.** The polynomial may depend on $P$, but the algorithm cannot hardwire an arbitrary $P$-dependent cover, support ordering, or representative list.

4. **The improper output need not be projectable.** A low-error external predictor $g$ gives a statistical witness that some proper concept is nearby, but no generic efficient projection or correlation search over $\mathcal C$ follows.

5. **Known sample-only equivalences do not lift computationally.** The atlas already separates finite-sample existence from polynomial-time search through the resource axis and cryptographic sample-to-computational hardness notes.

## Depth-5 Directions

1. **Effective-cover sufficient condition.** Formulate and prove a restricted positive theorem: if for every fixed $P$ there is a uniform procedure that builds a polynomial-size $L_1(P)$ cover by valid concepts, or a polynomial-time approximate proper ERM oracle under $P$, then the edge becomes true for that class.

2. **Projection-oracle characterization.** Isolate the exact oracle needed: given an improper predictor $g$ with $\inf_{c\in\mathcal C}\Pr_P[c\ne g]\le\varepsilon$, return a proper $c$ with error at most $1/2-\gamma_P(s)$. Check whether any known representation classes satisfy this under fixed marginals without already being properly learnable.

3. **Hardness of fixed-marginal projection.** Search for a class that is efficiently agnostically learnable by a larger improper class, while the approximate projection problem above is cryptographically or NP-hard even for one fixed marginal and realizable labels. This would be a cleaner false witness than the balanced-code attempts if it also preserves the weak-gap scale.

4. **Learnable-cover from samples.** Investigate whether marginal-nonuniform learnability plus the single-learner worst-case transcript convention implies any computable distribution-specific compression or cover. The current pass sees no such implication, but a positive theorem would likely have to arise here.

## References Checked

- `atlas/definitions/efficient-marginal-nonuniform-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-proper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/sample-complexity-equivalence.md`
- `atlas/arguments/sample-to-computational-hardness.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`

---

# Depth-5 Follow-Up

- depth: 5
- edge_file: atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md
- verdict: unresolved
- confidence: high that current atlas evidence supports `open`; medium that the projection formulation captures the right missing ingredient

## Focus

This pass followed the four depth-5 directions from depth 4:

1. effective covers,
2. projection-oracle characterization,
3. fixed-marginal projection hardness, and
4. learnable covers from samples.

The result is not a resolution of the edge. It is a cleaner conditional theorem plus a cleaner failure mode. Effective covers or projection oracles make the implication true for a restricted class, but the source node does not imply either object. Conversely, fixed-marginal projection hardness would be the right kind of false witness only if it is coupled to realizable-label access under the same fixed marginal; a standalone hard projection problem with an externally supplied improper predictor is not yet enough to refute the target.

## Effective Covers

**Restricted positive theorem.** Fix a represented class $\mathcal C$ satisfying the source. Suppose that for every marginal $P$ there is one uniform procedure whose runtime is bounded by a $P$-dependent polynomial and which, from sample access to $P$ and parameters $(s,\eta,\delta)$, outputs a list

$$
L_{P,s,\eta}\subseteq \mathcal C_s
$$

of valid proper representations such that, with probability at least $1-\delta$, every $c\in\mathcal C_s$ has some $\ell\in L_{P,s,\eta}$ with

$$
\Pr_{X\sim P}[\ell(X)\ne c(X)]\le \eta .
$$

Then $\mathcal C$ satisfies the target. On realizable labeled samples from $c^\star$, build a cover with any constant $\eta<1/8$, draw a fresh validation sample, and output the list element with least empirical error. Standard validation bounds give true error at most, say, $1/4$ for sufficiently many samples, hence weak advantage at least $1/4$. The runtime and sample bound are marginal-dependent polynomial by assumption.

This theorem is useful mostly as a diagnostic. It does not use the source's improper agnostic learner; the effective cover already gives weak proper learning directly. That is the first warning sign: an effective-cover assumption strong enough to prove the edge is not a consequence of the source node, but an additional representation-level search assumption.

The same point holds for an approximate proper ERM oracle under fixed $P$. If a uniform procedure can, for every sample or every bounded-loss labeling oracle, return a proper concept with empirical or true error within a constant of the best proper concept in $\mathcal C_s$, then the target follows immediately on realizable data. Again, this is essentially proper learnability, not a black-box consequence of improper learnability.

## Projection-Oracle Characterization

The weakest-looking useful oracle is not a full cover. It is a distribution-specific weak projection oracle:

> Given sample access to $P$, evaluation access or an explicit description of an external predictor $g$, and a promise that
> $$
> \inf_{c\in\mathcal C_s}\Pr_P[c(X)\ne g(X)]\le \rho ,
> $$
> return a proper $h\in\mathcal C_s$ with
> $$
> \Pr_P[h(X)\ne g(X)]\le 1/2-\alpha_P(s)
> $$
> for some inverse-polynomial $\alpha_P$ whenever $\rho$ is a sufficiently small constant.

With this oracle, the assigned edge becomes true for the class. On realizable examples from $c^\star$, run the source agnostic improper learner with small constant accuracy to obtain $g$ with $\Pr_P[g\ne c^\star]\le \rho$. Project $g$ to $h\in\mathcal C_s$. Then

$$
\Pr_P[h\ne c^\star]
\le
\Pr_P[h\ne g]+\Pr_P[g\ne c^\star]
\le
1/2-\alpha_P(s)+\rho .
$$

Choosing the projection margin with slack, or running the source to $\rho\le \alpha_P(s)/2$ if the oracle exposes its margin, gives the weak target. Since the ordinary target definition does not expose $\alpha_P$, the cleaner sufficient condition is a projection oracle with constant slack, e.g. return $h$ with $\Pr_P[h\ne g]\le 1/3$ whenever some proper concept is within $1/12$ of $g$. Then the final realizable error is below $1/2$ by a fixed constant.

This isolates the missing operation precisely: approximate projection from an improper predictor back into the represented class. The operation is weaker than strong proper agnostic learning, but it is still a proper search problem. None of the source guarantee, finite VC/sample compactness, or marginal nonuniformity supplies it.

Known local examples fit this characterization:

- If the class has efficient marginal-nonuniform agnostic proper learning, the projection oracle is just the proper agnostic learner run on labels generated by $g$; the neighboring proper-source edge is already marked true.
- If $P$ has effectively finite support and the representation admits efficient consistency or approximate ERM on that support, the oracle can be implemented by exhaustive or optimized search over realized traces.
- Sparse lookup witnesses implement projection into the larger sparse improper class, not into the original proper seed/proof class. That is why they prove the source but do not settle this edge.

## Fixed-Marginal Projection Hardness

A tempting false route is now very crisp:

1. choose one fixed marginal $P$;
2. make $\mathcal C$ efficiently agnostically learnable by an improper class $\mathcal H$ under all marginals, or at least under $P$ in a way that extends to the source node;
3. prove that the projection problem "given $g$ close to some $c\in\mathcal C_s$, find any weakly correlated proper $h\in\mathcal C_s$" is NP-hard or cryptographically hard under $P$.

This would refute a black-box properization theorem. It does not, by itself, refute the atlas edge. The target learner is not given $g$; it receives realizable labels from an unknown proper target $c^\star$. A hard projection instance with an externally supplied $g$ becomes an edge separation only if the reduction can turn it into realizable labeled examples under the same fixed marginal such that any weak proper learner solves the hard projection problem.

This distinction explains why the earlier witnesses split the way they do.

- The one-way image-coordinate class gives a fixed-marginal projection/recovery hardness statement for sufficiently accurate proper learning. It fails at the weak threshold because wrong seed concepts, or simple weak handles after repair, can have global error below $1/2$ without inverting.
- The PCP active-slice class gives weak proper hardness on the active marginal. It fails to become a fixed-marginal hardness statement because packing many active slices into one $P$ dilutes the weak gap below the hidden inverse-polynomial advantage.
- Balanced-code repairs try to make fixed-marginal weak projection hard, but exact weak-safe geometry requires Hadamard/Plotkin-scale coordinate domains, while polynomial lookup domains leave inverse-polynomial wrong-code correlations.

So the right counterexample target is more demanding than "projection is hard." It needs **realizable fixed-marginal weak projection hardness**: for one fixed $P$, a family of realizable label distributions generated by proper concepts should be easy for an improper learner but should force every weakly good proper output to reveal the hard certificate. I do not currently know such a construction in the notes.

## Learnable Covers From Samples

The remaining positive possibility is that the source learner itself might secretly create an effective cover.

For a fixed $P$, one can imagine enumerating all finite sample transcripts of the source learner up to its $P$-dependent runtime bound and collecting the hypotheses it may output. This does give an improper transcript family, at least morally. It does not give a proper cover:

1. the collected outputs may be outside $\mathcal C$;
2. the runtime polynomial $p_P$ exists but is not supplied to the uniform learner as a usable cutoff;
3. randomized learners and real-valued internal computations make transcript enumeration representation-dependent;
4. even a good improper cover still needs the projection oracle above to output a valid concept.

Sample access to $P$ also cannot identify a nonconstructive $L_1(P)$ cover by proper representations. Samples reveal high-probability regions, but they do not reveal which strings encode concepts realizing the relevant traces. In the sample-only atlas layer, unbounded ERM can bridge that gap. In the computational layer, the bridge is exactly the missing proper search.

The full-support marginal-uniformization note does not change this conclusion. It can turn a marginal-dependent worst-case transcript bound for one uniform algorithm into a distribution-free resource bound under a full-support reference marginal, but it does not turn improper outputs into proper representatives or compute a $P$-specific cover.

## Depth-5 Verdict

Keep the edge open.

The depth-5 investigation gives a candidate atlas note rather than a status change:

> **Verdict.** `open`.
>
> **Reason.** A strong marginal-nonuniform agnostic improper learner gives, on realizable data, an external predictor close to the target concept. To reach the weak proper target, one still needs an effective fixed-marginal projection step: from a predictor close to $\mathcal C$, find a member of $\mathcal C$ with nontrivial correlation. Effective $L_1(P)$ covers, proper ERM, or a weak projection oracle would make the implication true for restricted classes, but these are additional representation-level assumptions. Known false-witness routes do not yet supply a fixed marginal where realizable labels are improperly easy while every weakly good proper output reveals a hard certificate; active-slice PCPs vary the marginal, sparse one-way coordinates lose at the weak threshold, and balanced-code repairs run into Plotkin/list-decoding scale barriers.
>
> **Suggested metadata.**
>
> ```yaml
> status: "open"
> evidence: unknown
> assumptions: []
> witnesses: []
> family: properization-open
> summary: "Open: effective fixed-marginal covers or projection oracles would yield weak proper learning, but the source supplies no generic projection from improper predictors into the concept class; known fixed-marginal hardness templates still fail at the weak-gap scale."
> ```

No atlas implication note should be changed to `true` or `false` from this pass alone.

## Depth-6 Directions

1. **Realizable projection-hardness witness.** Search specifically for a class and fixed marginal where labels are generated by proper concepts, an improper learner can agnostically learn by a transparent larger class, and any weakly correlated proper output reveals a hard certificate. This is narrower and sharper than external projection hardness.

2. **Projection oracle versus proper weak learning.** Formalize whether the weak projection oracle above is equivalent, up to constants, to marginal-nonuniform weak realizable proper learning plus the source learner. If it is equivalent, the edge can be restated cleanly as "does improper agnostic learnability imply weak projectability?"

3. **Effective-cover taxonomy.** Add a small auxiliary note classifying conditions that do imply the edge: finite effective support, polynomial-size computable $L_1(P)$ covers by valid concepts, and polynomial-time fixed-marginal approximate proper ERM. This would prevent future passes from rediscovering only restricted positive theorems.

4. **Non-black-box cover extraction.** Test whether special source learners with stable compression, bounded description length, or sample-compression structure yield computable proper covers. A positive result here would have to use more than the abstract source node.

5. **Agreement-theorem PCP route.** Continue the depth-3 idea: look for a shared-coordinate PCP/agreement theorem where any object weakly correlated with the target transcript identifies the target instance or witness, avoiding the unrelated-formula weak-handle problem without putting the instance into the marginal.

## Additional References Checked

- `atlas/implications/efficient-marginal-nonuniform-agnostic-proper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/sample-complexity-equivalence.md`
- `atlas/arguments/sample-to-computational-hardness.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`
- [Hanneke, Moran, and Thiessen 2025](https://openreview.net/forum?id=aoVCFtox89)
- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)

---

# Depth-6 Final Follow-Up

- depth: 6
- edge_file: atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md
- verdict: unresolved
- confidence: high that the current atlas status should remain `open`; medium-high that the remaining obstruction is exactly fixed-marginal weak proper projection

## Final Focus

This last pass followed the depth-6 directions from depth 5:

1. search for a realizable fixed-marginal projection-hardness witness,
2. compare weak projection oracles with the target learner,
3. classify sufficient effective-cover conditions,
4. test whether source learners with extra structure could yield covers, and
5. revisit agreement-style PCP routes.

I did not find a valid theorem or counterexample. The best final resolution is a sharpened open summary: the edge asks whether strong improper marginal-nonuniform agnostic prediction forces an efficient weak proper representative under the same marginal. The source gives statistical closeness to some proper concept on realizable data, but no known mechanism finds any proper concept with nontrivial correlation. Known lower-bound templates either make the hard marginal depend on the input, require strong accuracy rather than weak advantage, or lose the easy improper learner once the encoding is made weak-safe.

## Realizable Projection-Hardness Witness

The desired false witness would have to satisfy a very specific three-part condition.

1. Labels are realizable by proper concepts under one fixed marginal $P$.
2. A uniform improper learner can agnostically learn the class in marginal-dependent polynomial time, ideally by an explicit relaxation such as sparse lookup ERM.
3. Every proper hypothesis with error $<1/2-\gamma_P(s)$ against the realizable target reveals a hard certificate, even though $\gamma_P$ is hidden and may be any inverse polynomial depending on $P$.

The checked witnesses each miss one part.

The PCP active-slice class satisfies the improper source and gives weak proper hardness, but its hard distribution is the active slice of the input formula. If the slice is packed into one fixed marginal, the slice mass multiplies the weak gap. With exponentially many formulas at size $n$, some slices have mass far below any uniform inverse-polynomial scale available to a reduction. If the marginal is instead chosen per formula, the marginal-dependent runtime and weak advantage may also vary per formula, so the reduction no longer yields one randomized polynomial-time NP decision procedure.

The one-way image-coordinate class satisfies the improper agnostic source and gives fixed-marginal strong proper hardness. It does not give weak proper hardness. Under the all-length marginal, wrong same-length seed concepts differ from the target only on the length-$n$ block, and the block has mass $\mu_n=O(1/n^2)$. Such wrong seeds can already have global error far below $1/2-\gamma_P(n)$ without inverting the one-way image.

Balanced-code repairs identify the right target geometry but not a construction. Exact orthogonality, as in Hadamard or parity encodings, makes any positive weak advantage identify the image; however, the coordinate domain is exponential if represented explicitly, or the source learner becomes an agnostic parity/correlation-search learner if represented implicitly. Polynomial coordinate domains keep lookup ERM polynomial but leave inverse-polynomial residual correlations or list-decoding radii. Because the weak advantage is hidden, any fixed inverse-polynomial residual correlation can be a legal wrong proper output for a learner with a smaller promised advantage.

Thus no realizable fixed-marginal projection-hardness witness is presently recorded.

## Projection Oracle Versus Weak Proper Learning

The most useful reformulation is a weak projection problem, but it is not equivalent to the target by itself.

A sufficient oracle is:

> For each fixed marginal $P$, given sample access to $P$ and an explicit or evaluable predictor $g$ with some $c\in\mathcal C_s$ satisfying $\Pr_P[g\ne c]\le\rho$, output $h\in\mathcal C_s$ with $\Pr_P[h\ne g]\le 1/2-\alpha_P(s)$, preferably with constant slack.

Together with the source learner, such an oracle proves the edge. On realizable labels from $c^\star$, run the agnostic improper learner to get $g$ close to $c^\star$, then project $g$ into $\mathcal C_s$. If the projection has constant slack, the triangle inequality immediately gives a weak proper hypothesis for $c^\star$. If the projection only has inverse-polynomial slack, one needs quantitative access to that slack to set the source accuracy; the atlas target does not expose the weak advantage polynomial, so the clean sufficient condition is constant-slack or otherwise parameterized projection.

The converse fails as a black-box equivalence. A weak realizable proper learner receives labels generated by an unknown proper target $c^\star$; it is not given an arbitrary external predictor $g$ close to the class. Projection hardness for externally supplied $g$ refutes generic black-box properization, but it does not refute the atlas target unless the hard projection instance can be encoded as realizable labels under the same fixed marginal. This is exactly where the current counterexample attempts fail.

So the edge can be restated informally as:

> Does efficient marginal-nonuniform agnostic improper learnability force realizable fixed-marginal weak projectability into the original representation class?

No existing atlas theorem answers that restatement.

## Effective-Cover Taxonomy

The following additional assumptions would make the edge true for a restricted class. They should be treated as sufficient conditions, not consequences of the source node.

1. **Polynomial computable $L_1(P)$ covers by valid concepts.** If a uniform procedure, with $P$-dependent polynomial bounds, can build a list of proper concepts covering $\mathcal C_s$ at constant $P$-error, validation on realizable samples gives a constant-advantage weak proper learner.

2. **Fixed-marginal approximate proper ERM.** If the class admits polynomial-time proper ERM or constant-factor approximate proper ERM under each fixed marginal, realizable weak proper learning follows directly.

3. **Effective finite support plus proper consistency/search.** If $P$ has effectively discoverable support of size $\operatorname{poly}_P(s)$ and the representation admits efficient consistency or weak optimization over traces on that support, the learner can search for a proper concept agreeing with the labels on enough observed mass.

4. **Constant-slack projection from external predictors.** If a low-error improper predictor can be converted into a proper concept agreeing with it on more than half the $P$-mass by a fixed constant, the source learner plus projection gives the target.

All four are representation-level search assumptions. The source guarantee alone supplies an external predictor; it does not supply a cover, an ERM oracle, an effective trace realization procedure, or a projection map.

## Non-Black-Box Cover Extraction

I also checked whether the source learner's own transcripts might yield a cover. For a fixed marginal $P$, one can imagine enumerating all transcripts of the improper learner up to the marginal-dependent runtime bound and validating the resulting hypotheses. This does not solve the edge:

- the transcript hypotheses may all be improper;
- the polynomial bound $p_P$ exists but is not given to the learner as a usable cutoff;
- enumerating randomized or real-valued transcripts is representation-dependent;
- an improper transcript cover still needs projection into $\mathcal C$;
- samples from $P$ reveal likely instance regions, not which strings encode proper concepts realizing useful traces.

Stable compression, bounded description length, or a specially structured improper learner could change this conclusion for a particular class. No such structure is part of the abstract source node, and none is recorded in the checked atlas witnesses.

## Agreement-Theorem PCP Route

The remaining plausible false direction is not an ordinary PCP or list-decoding argument. It would need an agreement theorem with the following flavor:

> Under one fixed coordinate/test marginal, any proper object with even inverse-polynomial correlation with the target transcript identifies the target formula or witness.

Ordinary PCP soundness controls proofs for a fixed formula on that formula's active slice. Once the formula is removed from the marginal, unrelated satisfiable formulas or proofs become weak handles unless formula identity is protected by a shared code. Protecting exponentially many formula identities on a polynomial coordinate set returns to the Plotkin/Hadamard and list-decoding barriers already found in depths 2--4.

Direct-product or low-degree agreement theorems may be the right literature to inspect next, but a mere small list of correlated objects is insufficient: the learner returns one proper hypothesis, and a wrong list element must itself reveal the hard certificate or be eliminable without changing the fixed marginal and without raising the optimum toward $1/2$.

## Final Proposed Atlas Update

Keep the edge open.

Suggested metadata if the atlas edge is refreshed:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - schapire1990
  - pitt1988
  - khot2008dnf
  - hastad2005query
  - kearns1994cryptographic
  - hastad1999prg
  - benedek1991fixed
  - bendavid1995parameterization
  - hanneke2025marginalnonuniform
refs:
  - "[Schapire 1990](https://doi.org/10.1023/A:1022648800760)"
  - "[Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)"
  - "[Khot and Saket 2008](https://doi.org/10.1109/FOCS.2008.37)"
  - "[Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)"
  - "[Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)"
  - "[Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)"
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
  - "[Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)"
  - "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
summary: "Open: strong marginal-nonuniform agnostic improper learning gives accurate external prediction on realizable data, but no generic efficient fixed-marginal projection into the original proper class is known; current PCP, one-way, and shared-code lower-bound routes fail at the hidden weak-gap or source-learnability scale."
family: properization-open
argument_note: "[[properization-open|Properization Open]]"
```

Suggested replacement or expansion for the proof-status body:

> **Goal.** Decide whether a strong marginal-nonuniform agnostic improper learner can always be converted, on realizable data, into a proper hypothesis with inverse-polynomial advantage under the same marginal.
>
> **Positive route obstruction.** On realizable labels from $c^\star\in\mathcal C$, the source learner can output an external predictor $g$ close to $c^\star$. The missing step is an efficient fixed-marginal weak projection: from a predictor close to $\mathcal C_s$, find some member of $\mathcal C_s$ with nontrivial $P$-correlation. Effective $L_1(P)$ covers, proper ERM, finite effective support with proper search, or constant-slack projection oracles would each imply the target for restricted classes, but none follows from the source definition.
>
> **Counterexample route obstruction.** PCP active-slice witnesses separate distribution-free weak proper learning, but their hard marginal varies with the input formula; packing all slices into one fixed marginal dilutes the weak gap. One-way image-coordinate witnesses give fixed-marginal strong proper hardness with an agnostic improper source, but weak proper learners can use wrong-image or low-mass handles without inverting. Shared balanced-code repairs need every wrong proper certificate below the hidden inverse-polynomial weak advantage; polynomial coordinate domains leave inverse-polynomial residual correlations, while Hadamard-style exact orthogonality makes the improper source look like agnostic parity or makes the representation exponentially large.
>
> **Conclusion.** The implication remains open as a fixed-marginal weak properization problem.

## Crisp Obstacles

1. **Projection is the missing operation.** The source supplies prediction, not a searchable proper representation.

2. **Marginal nonuniformity is not advice.** The runtime polynomial may depend on $P$, but the learner is still one algorithm and is not handed a $P$-specific cover, support ordering, or projection map.

3. **External projection hardness is not enough.** To refute the edge, the hard projection instance must be encoded as realizable labeled examples under the same fixed marginal.

4. **Weak-gap quantification is unforgiving.** A wrong proper concept with any fixed inverse-polynomial positive correlation may be a legal output for a learner whose hidden advantage is smaller.

5. **PCP active slices vary the marginal.** Fixed-marginal packing multiplies each hard slice gap by its mass, which is too small for exponentially many inputs.

6. **One-way coordinate blocks are too sparse for weak hardness.** Strong accuracy forces recovery; weak accuracy can be achieved by wrong-image or low-mass handles.

7. **Balanced codes trade off the two sides.** Exact orthogonality protects weak hardness but breaks lookup-style agnostic improper learning; polynomial explicit codes preserve the source but leave residual correlations.

8. **Agreement, not list size, is needed.** A list of correlated wrong certificates is not useful unless every returned item reveals the target witness or can be eliminated under the same fixed marginal.

## Best Next Directions

1. Search for direct-product, low-degree, or agreement-test PCPs where weak correlation with a shared target transcript forces recovery of the target instance or witness, not merely membership in a short list.

2. Formalize the "realizable projection-hardness" requirement as its own lemma or argument note: external projection hardness becomes an atlas separation only when encoded as realizable labels under one fixed marginal.

3. Prove a template no-go for explicit lookup-ERM shared-coordinate witnesses using Plotkin/rate-versus-distance/list-decoding bounds and the hidden weak-gap quantifier.

4. Develop an auxiliary positive note for restricted sufficient conditions: effective finite support, computable polynomial $L_1(P)$ covers by valid concepts, fixed-marginal approximate proper ERM, and constant-slack projection.

5. Investigate whether any non-lookup improper relaxation of Hadamard/image-code concepts is known to be efficiently agnostically learnable from random examples without implying a breakthrough for agnostic parity or LPN-style decoding.

## References Checked In This Final Pass

- `atlas/definitions/efficient-marginal-nonuniform-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-proper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- `atlas/arguments/clause-satisfaction-proper-hardness.md`
- `atlas/witnesses/clause-satisfaction-lookup-class.md`
- `atlas/arguments/sample-complexity-equivalence.md`
- `atlas/arguments/sample-to-computational-hardness.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/arguments/marginal-boosting-open.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`
- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
- [Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)
- [Khot and Saket 2008](https://doi.org/10.1109/FOCS.2008.37)
- [Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)
- [Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)
- [Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)
- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)
- [Hanneke, Moran, and Thiessen 2025](https://openreview.net/forum?id=aoVCFtox89)
- Plotkin, "Binary codes with specified minimum distance," IRE Transactions on Information Theory 6(4):445--450, 1960, DOI [10.1109/TIT.1960.1057584](https://doi.org/10.1109/TIT.1960.1057584).
- Guruswami and Vadhan, "A Lower Bound on List Size for List Decoding," IEEE Transactions on Information Theory 56(11):5681--5688, 2010, DOI [10.1109/TIT.2010.2070170](https://doi.org/10.1109/TIT.2010.2070170).
