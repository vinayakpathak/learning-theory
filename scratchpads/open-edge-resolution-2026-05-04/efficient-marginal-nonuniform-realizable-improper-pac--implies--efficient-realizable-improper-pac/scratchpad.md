# Open Edge Resolution Scratchpad

Edge: `efficient-marginal-nonuniform-realizable-improper-pac -> efficient-realizable-improper-pac`

## Research Log

## Sources Checked

## Proof Or Counterexample Attempts

## Verdict

## Follow-Up Directions

## Depth-1 Entry - 2026-05-05

### Verdict

Still `open` at Depth 1. I did not find a primary-source theorem or a clean atlas-ready construction resolving

`efficient-marginal-nonuniform-realizable-improper-pac -> efficient-realizable-improper-pac`.

The edge is true after dropping the runtime requirement, but I do not see a justified upgrade from marginal-dependent polynomial time to one distribution-free polynomial-time learner.

### Definitions Used

- Source: `efficient-marginal-nonuniform-realizable-improper-pac`.
  A single learner works for every marginal $P$, but for each fixed $P$ the sample and running-time bound may be a different polynomial $p_P(s,1/\varepsilon,\log(1/\delta))$, uniform over targets $c \in \mathcal C$.
- Target: `efficient-realizable-improper-pac`.
  A learner must have one polynomial sample and running-time bound, independent of the marginal distribution, for all realizable target concepts.
- Relevant local implication note:
  `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-realizable-improper-pac.md` currently marks the edge `open` with evidence `unknown`.
- Relevant local argument note:
  `atlas/arguments/marginal-uniformization-open.md` records exactly this obstruction: marginal-dependent runtime/sample polynomials do not automatically become one distribution-free runtime/sample polynomial. It also notes that the sample-only polynomial-rate analogue is no longer open.
- Witnesses:
  The edge note lists no witnesses. I did not find a local witness note that settles this exact computational marginal-uniformization edge.

### Sources Checked

- Benedek and Itai, "Learnability with respect to fixed distributions", Theoretical Computer Science 86(2), 1991.
  URL: https://www.sciencedirect.com/science/article/pii/030439759190026X
  The abstract says the fixed-distribution model is characterized by finite covers and explicitly says the main concern is sample complexity, not time; the learning map may even be undecidable or infeasible in some cases. This supports using it for the statistical fixed-marginal background, but not for a computational uniformization theorem.
- Ben-David, Benedek, and Mansour, "A parameterization scheme for classifying models of PAC learnability", Information and Computation 120(1), 1995.
  URL: https://cris.tau.ac.il/en/publications/a-parameterization-scheme-for-classifying-models-of-pac-learnabil/
  The abstract says the paper classifies PAC models by uniformity parameters and explicitly concentrates on information-theoretic learnability rather than computational complexity. This supports the quantifier taxonomy but not the desired efficient implication.
- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability", NeurIPS 2025.
  URL: https://openreview.net/forum?id=aoVCFtox89
  PDF: https://openreview.net/pdf?id=aoVCFtox89
  The paper defines marginal-nonuniform learning with quantifier order
  $\exists \hat h_n \ \forall P \ \exists C,c>0 \ \forall f^\ast$ and proves a trichotomy of sample rates. The abstract and Theorem 3 state that finite VC dimension is exactly the linear-rate marginal-nonuniform regime, while infinite VC dimension gives arbitrarily slow rates. The paper contains no computational or polynomial-time claim.
- Local sample-only comparison:
  `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--sample-efficient-realizable-improper-pac.md` records the corresponding sample-efficient distribution-free implication as `true`, using the Hanneke-Moran-Thiessen trichotomy plus standard VC theory.

### Theorem Route

The plausible theorem route is:

1. Ignore runtime. The source gives a polynomial marginal-nonuniform sample guarantee.
2. Hanneke-Moran-Thiessen imply that polynomial marginal-nonuniform sample rates force finite VC dimension in the binary realizable setting.
3. Standard VC theory then gives distribution-free polynomial sample complexity.
4. To finish the target, one would need to turn this into a polynomial-time learner.

Step 4 is where the route fails. VC theory supplies an information-theoretic learner, usually via ERM or compression-style existence, but the atlas target requires polynomial running time in the representation-size parameter and accuracy/confidence parameters. The cited fixed-distribution and parameterization papers explicitly do not provide such a computational result.

I also tried the black-box uniformization idea: take the marginal-specific learner $A$ and combine bad marginals into a mixture $P^\star$. Statistically, if $P^\star=\sum_i w_iP_i$ and a hypothesis has error at most $w_i\varepsilon$ under $P^\star$, then it has error at most $\varepsilon$ under $P_i$. But this does not give a learner for $P_i$: PAC samples from $P_i$ do not let us run $A$ as if samples came from $P^\star$, and the polynomial bound obtained for $P^\star$ is not a bound on executions under $P_i$. The route also has a target-label compatibility problem if the bad cases use different concepts.

### Counterexample Route

The plausible counterexample route would be a class with:

1. one learner that succeeds for every marginal with a marginal-dependent polynomial runtime bound; but
2. no learner with one polynomial runtime bound working for all marginals.

Standard computational hardness witnesses do not immediately work. A pseudorandom-function-style class fails the target because of a hard fixed marginal, but that same hard marginal would also violate the source. Conversely, classes such as halfspaces satisfy the target already. Pure sample-rate examples such as $2^{\mathbb N}$ or finite subsets of $\mathbb N$ separate weaker information-theoretic notions, but they only give arbitrarily slow marginal rates for some marginals and therefore do not satisfy the polynomial marginal-nonuniform source.

A successful counterexample seems to need a more delicate "pointwise polynomial but not uniformly polynomial" learning phenomenon, not just hardness under one fixed distribution.

### Concrete Obstruction

The exact obstruction is computational uniformization. The source has the quantifier pattern

$$
\exists A \ \forall P \ \exists \text{polynomial } p_P \ \forall c\in\mathcal C,
$$

while the target needs

$$
\exists A \ \exists \text{polynomial } p \ \forall P \ \forall c\in\mathcal C.
$$

The known statistical theory collapses the analogous sample-rate gap at polynomial rates, but it says nothing about whether the marginal-specific running-time polynomials can be bounded by one polynomial, or whether finite-VC sample control can be implemented by polynomial-time improper hypotheses for the representation of the class.

### Promising Next Directions

- Search specifically for average-case or distribution-dependent polynomial-time learning notions with quantifier pattern $\forall P \exists p_P$, especially any uniform boundedness theorem for all marginals.
- Try to build an artificial diagonal class whose learner is polynomial under each marginal but whose required exponent is unbounded across marginals. The main difficulty is preserving the source for arbitrary heavy-tailed mixtures.
- Look for finite-VC classes with no distribution-free polynomial-time improper learner but with distribution-dependent polynomial-time algorithms for every marginal. A cryptographic witness alone is not enough, because source learnability must hold even on the cryptographic hard marginal.
- Clarify the atlas runtime convention: whether the time bound is worst-case over sample sequences, high-probability over samples, or expected under $P$. A worst-case convention may make some diagonal mixture arguments stronger; an expected or high-probability convention may admit different counterexample attempts.

### Atlas-Ready Changes If Resolved

Not resolved. I would leave the atlas edge unchanged:

- `status: "open"`
- `evidence: unknown`
- `assumptions: []`
- `witnesses: []`
- `ref_keys`: keep `benedek1991fixed` and `hanneke2025marginalnonuniform`; optionally add `bendavid1995parameterization` if the edge note wants to cite the quantifier taxonomy directly.

## Depth-2 Entry - 2026-05-05

### Verdict

`resolved true`, under the atlas's written efficient-PAC convention.

The Depth-1 obstruction was too pessimistic about runtime. The source is not a family of distribution-indexed learners; it is one learner $A$. For every marginal $P$, some polynomial $p_P$ bounds the samples and running time of this same learner. Under the standard computational-learning reading that "uses at most ... samples and time" is a worst-case/pathwise resource bound for finite encoded example transcripts, a single full-support reference marginal forces one polynomial bound on all transcripts. The source already gives accuracy for every marginal, so the same learner is an efficient distribution-free realizable improper PAC learner.

This is a convention-sensitive theorem. If the atlas intended marginal-nonuniform runtime to mean expected, high-probability, or almost-sure runtime under each marginal, then the proof below would not settle the edge.

### Sources Checked

- Local source definition: `atlas/definitions/efficient-marginal-nonuniform-realizable-improper-pac.md`.
- Local target definition: `atlas/definitions/efficient-realizable-improper-pac.md`.
- Local edge note: `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-realizable-improper-pac.md`.
- Local argument notes: `atlas/arguments/marginal-uniformization-open.md` and `atlas/arguments/sample-complexity-equivalence.md`.
- Neighboring scratchpads for the proper and agnostic proper marginal-uniformization edges, especially the full-support transcript analysis.
- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability", OpenReview page and PDF, https://openreview.net/forum?id=aoVCFtox89 and https://openreview.net/pdf?id=aoVCFtox89. The page checked on 2026-05-05 says the paper studies rates whose constants may depend on the marginal distribution, and the page records the trichotomy of marginal-nonuniform sample rates. This remains statistical rather than computational.
- Benedek and Itai, "Learnability with respect to fixed distributions", Theoretical Computer Science 86(2), 1991, https://doi.org/10.1016/0304-3975(91)90026-X and https://www.sciencedirect.com/science/article/pii/030439759190026X. The abstract gives the finite-cover characterization and explicitly says the main concern is sample count, not computation.
- Benedek and Itai, "Dominating distributions and learnability", COLT 1992, DOI https://doi.org/10.1145/130385.130413 and Technion record https://cris.technion.ac.il/en/publications/dominating-distributions-and-learnability/. Its abstract says polynomial sample transfer between two fixed distributions needs a multiplicative domination condition; this supports the earlier warning that accuracy/sample-rate transfer is not obtained merely from full support.
- Kearns, Schapire, and Sellie, "Toward Efficient Agnostic Learning", Machine Learning 17, 1994, https://www.schapire.net/papers/agnostic.pdf. Checked as background for the ordinary efficient-learning convention: efficient learning uses a fixed polynomial resource bound, and polynomial time is polynomial in the sample size/input representation.

### Theorem Route

Goal: starting from the source learner $A$, produce one polynomial $q$ that works for every marginal $P$.

Use the computational representation-size convention implicit in the efficient atlas nodes: examples of size $s$ have finite encodings, so the possible encoded examples can be enumerated, either globally or size-slice by size-slice. Choose a reference marginal $P^\star$ with full support on every encoded instance in every relevant size slice. For example, assign positive mass to each encoded instance with summable weights. If marginals are formalized as size-indexed families, choose a full-support family $P^\star_s$.

Apply the source guarantee to this one marginal $P^\star$. There is a polynomial

$$
q(s,1/\varepsilon,\log(1/\delta))
:=
p_{P^\star}(s,1/\varepsilon,\log(1/\delta))
$$

bounding the sample use and running time of $A$ under $P^\star$, uniformly over all target concepts $c\in\mathcal C$.

Now consider any finite labeled transcript that $A$ could see on examples of size $s$ under any marginal and any target concept. Since $P^\star$ gives positive mass to every encoded instance, the same finite instance transcript has positive probability under $P^\star$; since the source guarantee for $P^\star$ is uniform over targets, the corresponding labeled transcript is covered by applying the source to the relevant target concept. If $A$ could request more than $q$ samples or spend more than $q$ time on that transcript, it would contradict the "at most" resource promise for $P^\star$.

Thus $q$ is a worst-case sample-use and runtime bound for $A$ on every finite transcript, independent of the actual marginal. This is where the full-support transcript argument is legitimate: it controls resources, not error probabilities.

Accuracy should not be transferred from $P^\star$ to another marginal. That would be invalid: full support does not preserve the probability of failure events, and Benedek--Itai's domination results warn that polynomial transfer between distributions needs stronger domination than mere support inclusion. Instead, accuracy comes directly from the source quantifier. For an arbitrary marginal $P$ and target $c\in\mathcal C$, the source guarantee applied to $P$ says the same learner $A$ outputs $h$ with

$$
\operatorname{err}_P(h,c)\le \varepsilon
$$

with probability at least $1-\delta$. Combining this already-distribution-free accuracy statement with the uniform resource bound $q$ proves efficient realizable improper PAC learning.

### Counterexample Route

The diagonal runtime witness route does not work under this convention.

A tempting construction would arrange blocks or slices whose learning times require exponents $1,2,3,\ldots$, so each fixed marginal has a marginal-dependent polynomial but no uniform polynomial exists. The full-support argument kills this if resource bounds are pathwise. Any finite transcript on a high-exponent block has positive probability under $P^\star$ with a suitable target concept, so the source polynomial for $P^\star$ must already bound that transcript. A learner with truly unbounded polynomial exponents across finite transcripts would fail the source on $P^\star$.

The other standard witnesses are also near misses. A PRF-style hard fixed marginal refutes the source itself, because the source must work for every marginal. A class whose hard instances are hidden in the marginal does not refute the target unless the source still survives arbitrary mixtures over those hard instances. Properness-hard witnesses are irrelevant here because the target remains improper.

So a diagonal runtime witness can only become an atlas counterexample if the atlas weakens "running time" to an expected, high-probability, or almost-sure-under-$P$ notion. Then slow transcripts of tiny $P^\star$-probability might escape the full-support resource bound. That is not the convention currently written in the efficient nodes.

### Concrete Obstruction

The concrete obstruction is definitional precision, not a remaining mathematical separation.

The proof needs:

1. one uniform learner, not marginal-indexed advice;
2. finite encoded examples organized by the representation-size parameter;
3. sample use and running time bounded "at most" on every finite transcript compatible with the marginal support, as in the usual worst-case efficient PAC model.

Under those assumptions, the full-support transcript argument is legitimate for sample use and runtime. It is not legitimate for accuracy, but it does not need to be: source accuracy already quantifies over every marginal.

### Next Directions

- Update this edge to `true` if the atlas accepts the standard countable encoded/worst-case-resource reading.
- Add a short convention note, either in `atlas/README.md` or the efficient node definitions, saying that computationally efficient sample use and running time are worst-case/pathwise bounds for the learner on finite encoded sample transcripts, not expected or high-probability runtime under the marginal.
- Revisit the neighboring marginal-uniformization edges for the same full-support resource argument. The agnostic proper scratchpad already records the analogous resolved proof; the realizable proper edge may need the same convention decision.
- If the intended model is instead expected or high-probability marginal-dependent runtime, keep the edge open and explicitly rename the obstruction as "probabilistic runtime uniformization"; then a diagonal rare-transcript construction becomes a meaningful next target.

### Exact Atlas Changes If Accepted

For `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-realizable-improper-pac.md`:

```yaml
status: "true"
evidence: theorem
assumptions: []
witnesses: []
ref_keys:
  - benedek1991fixed
  - bendavid1995parameterization
  - hanneke2025marginalnonuniform
refs:
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
  - "[Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)"
  - "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
summary: "True under the atlas's one-learner worst-case efficiency convention: a full-support reference marginal forces the marginal-nonuniform learner's sample and runtime bound to hold on every finite transcript, while the source already gives realizable accuracy for every marginal."
```

Suggested body replacement:

> `true`, by a full-support marginal uniformization argument.
>
> Let $A$ be the single learner promised by the marginal-nonuniform source. Choose a reference marginal $P^\star$ with full support on every finitely encoded instance in each representation-size slice. By the source guarantee, there is a polynomial $p_{P^\star}$ bounding the sample use and running time of $A$ under $P^\star$, uniformly over all target concepts.
>
> Since $P^\star$ has full support, every finite labeled transcript that can occur for examples of size $s$ under any marginal and target concept has positive probability under $P^\star$ for that same target concept. Therefore, if $A$ exceeded $p_{P^\star}(s,1/\varepsilon,\log(1/\delta))$ samples or time on any such transcript, it would violate the source resource bound for $P^\star$. Thus $p_{P^\star}$ is a single distribution-free sample and runtime bound for $A$.
>
> For accuracy, no transfer from $P^\star$ is needed. Given any marginal $P$ and target $c\in\mathcal C$, the source guarantee applied directly to $P$ says that $A$ outputs an improper hypothesis $h$ with $\operatorname{err}_P(h,c)\le\varepsilon$ with probability at least $1-\delta$. Combining this accuracy guarantee with the uniform resource bound proves efficient distribution-free realizable improper PAC learning.

No atlas files were edited in this Depth-2 pass.
