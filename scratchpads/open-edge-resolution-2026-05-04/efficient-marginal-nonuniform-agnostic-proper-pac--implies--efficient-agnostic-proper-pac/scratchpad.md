# Open Edge Resolution Scratchpad

Edge: `efficient-marginal-nonuniform-agnostic-proper-pac -> efficient-agnostic-proper-pac`
Depth: 0 root pending
Current atlas status: `open`, evidence `unknown`
Family: `marginal-uniformization-open`

## Research Log

## Sources Checked

## Proof Or Counterexample Attempts

## Verdict

Unresolved pending depth-0 investigation.

## Follow-Up Directions

## Depth-0 Entry - 2026-05-04

### Relevant Definitions

Target edge:
`efficient-marginal-nonuniform-agnostic-proper-pac -> efficient-agnostic-proper-pac`.

Source node: one uniform learner $A$ receives examples from any joint distribution $\mathcal D$ over $\mathcal X\times\{0,1\}$, with marginal $P=\mathcal D_X$, and outputs $h\in\mathcal C$. For every marginal $P$, there is a polynomial $p_P$ such that for every joint distribution with marginal $P$ and every $\varepsilon,\delta\in(0,1)$,

$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\varepsilon
$$

with probability at least $1-\delta$, using sample size and running time bounded by

$$
p_P(s,1/\varepsilon,\log(1/\delta)).
$$

The polynomial may depend on the marginal $P$, but not on the conditional label rule, target/benchmark concept, $\varepsilon$, or $\delta$. The learner itself is still a single algorithm; it is not a separate advice-taking algorithm for each marginal.

Target node: one proper agnostic PAC learner has sample complexity and running time bounded by a single polynomial in the representation-size parameter $s$, $1/\varepsilon$, and $\log(1/\delta)$, uniformly over all joint distributions and all marginals.

The only axis change is `distribution: marginal-nonuniform-to-distribution-free`; realizability, strength, properness, and computational efficiency are otherwise the same. The target is stronger exactly because it swaps

$$
\forall P\ \exists p_P
$$

for

$$
\exists q\ \forall P.
$$

### Sources Checked

- `atlas/definitions/efficient-marginal-nonuniform-agnostic-proper-pac.md`.
- `atlas/definitions/efficient-agnostic-proper-pac.md`.
- `atlas/implications/efficient-marginal-nonuniform-agnostic-proper-pac--implies--efficient-agnostic-proper-pac.md`.
- `atlas/arguments/marginal-uniformization-open.md`.
- `atlas/arguments/sample-complexity-equivalence.md`, for the resolved sample-only marginal-to-distribution-free route.
- `atlas/registry/edge_families.yml`, especially the `marginal-uniformization-open` registry entry.
- Neighboring implication notes:
  - `atlas/implications/sample-efficient-marginal-nonuniform-agnostic-proper-pac--implies--efficient-agnostic-proper-pac.md`.
  - `atlas/implications/efficient-marginal-nonuniform-agnostic-proper-pac--implies--efficient-agnostic-improper-pac.md`.
  - `atlas/implications/efficient-marginal-nonuniform-agnostic-proper-pac--implies--efficient-realizable-improper-pac.md`.
- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability", OpenReview page and PDF, https://openreview.net/forum?id=aoVCFtox89 and https://openreview.net/pdf?id=aoVCFtox89. The OpenReview page I checked reports "Published: 18 Sept 2025" and "Last Modified: 21 Apr 2026". The paper defines marginal-nonuniform learning as allowing constants/rates to depend on the marginal distribution while holding uniformly over concepts, and proves the rate trichotomy: finite classes have exponential rates, finite VC-eluder dimension / finite VC dimension gives linear rates, and infinite VC dimension forces arbitrarily slow rates.
- Benedek and Itai, "Learnability with respect to fixed distributions", ScienceDirect/DOI page, https://www.sciencedirect.com/science/article/pii/030439759190026X. The abstract characterizes fixed-distribution learnability via finite covers and explicitly says the main concern is sample count rather than computation; computational complexity is considered only for discrete distributions.
- Ben-David, Benedek, and Mansour, "A parameterization scheme for classifying models of PAC learnability", TAU/DOI record, https://cris.tau.ac.il/en/publications/a-parameterization-scheme-for-classifying-models-of-pac-learnabil/. The record says the paper classifies PAC models by uniformity parameters and concentrates on information-theoretic learnability rather than computational complexity.
- `atlas/witnesses/pseudorandom-function-classes.md` and `atlas/arguments/sample-to-computational-hardness.md`, to test the standard cryptographic counterexample route.
- `atlas/witnesses/clause-satisfaction-lookup-class.md` and `atlas/arguments/clause-satisfaction-proper-hardness.md`, to test whether properness hardness can separate this exact edge.
- `atlas/witnesses/halfspaces.md` and `atlas/arguments/halfspace-agnostic-hardness.md`, to check whether known marginal agnostic hardness creates a counterexample.

### Theorem Attempt

Goal: derive an efficient distribution-free proper agnostic learner from the marginal-nonuniform efficient proper agnostic learner.

The sample-complexity part can be uniformized. Since the source includes a polynomial marginal-dependent sample guarantee, Hanneke--Moran--Thiessen's marginal-nonuniform trichotomy rules out the infinite-VC / arbitrarily-slow regime in the binary sample-only setting. Thus the class has finite VC dimension, and standard VC uniform convergence plus unbounded ERM gives a distribution-free proper agnostic sample-efficient learner. This recovers the atlas's `sample-complexity-equivalence` story.

The computational step is the blocker. A tempting construction is:

1. Run the source learner $A$ with increasing timeouts and sample budgets.
2. Validate candidate proper hypotheses on a holdout sample.
3. Stop when validation certifies near-optimal empirical performance.

For each fixed marginal $P$, some polynomial timeout scale $p_P$ is enough. But the target needs a single polynomial timeout $q$ independent of $P$. The source gives no upper bound on the degree or coefficients of $p_P$ as $P$ varies, and the Hanneke--Moran--Thiessen theorem only uniformizes sample rates, not representation-sensitive optimization time.

Point masses do not close the gap. For a degenerate marginal $P=\delta_x$, the source only says that samples supported on $x$ are handled within some polynomial whose constants and degree may depend on $\delta_x$. Taking a supremum over degenerate marginals can still be superpolynomial in $s$ unless the model supplies extra control on $P\mapsto p_P$.

Dovetailing also fails to give the target. A universal search over timeouts may eventually find a successful scale for each fixed $P$, but its discovery time remains $P$-dependent. That is another marginal-nonuniform or universal-style guarantee, not a distribution-free polynomial runtime bound.

### Counterexample Attempts

1. Pseudorandom function classes.

This does not separate the edge. The standard atlas cryptographic witness shows that, under standard cryptographic assumptions, there is a fixed hard marginal under which no randomized polynomial-time learner can even weakly learn the PRF class. Since the source requires polynomial-time learning for every marginal, allowing only that the polynomial may depend on the marginal, the PRF class fails the source rather than witnessing `source true, target false`.

2. Halfspaces.

The atlas records halfspace agnostic hardness, including marginal-nonuniform agnostic hardness under Tiegel's standard-Gaussian result and worst-case lattice assumptions. That again threatens the source itself: the hard Gaussian marginal is one marginal for which the source would need an efficient agnostic proper learner. Therefore halfspaces are not a witness for this uniformization edge.

3. Clause-satisfaction lookup / properness hardness.

The clause-satisfaction lookup class is useful for separating improper learning from proper learning, but this edge's source is already proper. To use it here, one would need to prove a positive marginal-nonuniform proper agnostic learner for every fixed marginal while maintaining conditional hardness for distribution-free proper agnostic learning. The existing atlas argument does not supply that positive source statement.

4. Artificial diagonalization.

A plausible abstract route is to build a class whose learning problem decomposes into subfamilies indexed by $k$, where marginal $P_k$ admits a proper agnostic learner in time $s^k$, while no uniform exponent works over all $k$. This would match the quantifier gap. I did not turn this into an atlas-grade counterexample: it would need a precise representation, a proof that every uniform polynomial learner fails on some induced marginal, and either a primary time-hierarchy/complexity source or a fully formal construction. It also must survive arbitrary mixtures of the $P_k$'s, since the source quantifies over all marginals, not just a chosen sequence.

### Precise Obstruction

The source supplies:

$$
\exists A\ \forall P\ \exists \text{ polynomial }p_P\ \forall\mathcal D\text{ with }\mathcal D_X=P\ \forall\varepsilon,\delta:
A \text{ is proper agnostic and runs in }p_P(s,1/\varepsilon,\log(1/\delta)).
$$

The target needs:

$$
\exists B\ \exists \text{ polynomial }q\ \forall P\ \forall\mathcal D\text{ with }\mathcal D_X=P\ \forall\varepsilon,\delta:
B \text{ is proper agnostic and runs in }q(s,1/\varepsilon,\log(1/\delta)).
$$

The known marginal-nonuniform sample results justify the analogous sample-bound quantifier swap at polynomial rates, because polynomial marginal-nonuniform sample rates imply finite VC dimension. I found no primary source that performs the same quantifier swap for computational running time, and the classic fixed-distribution / parameterization sources explicitly focus on information-theoretic learnability rather than computational complexity.

### Final Verdict

`unresolved`.

I do not have an atlas-valid resolution to `resolved true` or `resolved false`. The sample-only shadow is true, but the efficient edge remains blocked by computational uniformization. The obvious conditional-false witnesses either fail the source on a fixed hard marginal or separate a different axis.

### Concrete Follow-Up Directions

- Formalize the runtime convention for marginal-nonuniform learners: is runtime required worst-case over samples once $P$ is fixed, high-probability over samples, or only bounded for a prescribed sample size? A worst-case convention may make point-mass diagonalization more powerful.
- Search specifically for computational fixed-distribution PAC uniformization results, not just sample-rate results: queries like "distribution-dependent polynomial-time PAC", "fixed-distribution computational PAC", "nonuniform computational PAC", and "uniformization distribution-dependent learning".
- Try to build the artificial diagonalization witness using a time hierarchy theorem, with careful handling of mixtures of marginals. The witness must satisfy all fixed marginals but defeat every distribution-free polynomial learner.
- Revisit properness-hard candidates under fixed marginals. A useful false witness would need marginal-nonuniform proper agnostic learning for every fixed marginal, plus distribution-free proper agnostic hardness.
- Recheck the Hanneke--Moran--Thiessen OpenReview page before any atlas update; the current page was last modified on 21 Apr 2026, and the paper is recent enough that revisions may affect the surrounding marginal-nonuniform conventions.

## Depth-1 Entry - 2026-05-04

### Search Targets

I pursued the three depth-0 leads:

1. computational fixed-distribution PAC uniformization / nonuniform computational PAC results relevant to agnostic proper learning;
2. an artificial time-hierarchy or diagonalization witness separating marginal-dependent polynomial time from distribution-free polynomial time;
3. properness-hard candidates that might become easy under every fixed marginal but remain hard distribution-free.

### Sources Checked

- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability", OpenReview page and PDF, https://openreview.net/forum?id=aoVCFtox89. The page now reports "Published: 18 Sept 2025" and "Last Modified: 21 Apr 2026". The paper remains a sample-rate result: marginal-dependent rates are characterized by a trichotomy, but the statement does not give a representation-sensitive runtime uniformization theorem.
- Benedek and Itai, "Learnability with respect to fixed distributions", Theoretical Computer Science 86(2), 1991, https://doi.org/10.1016/0304-3975(91)90026-X. Still relevant mainly as the fixed-distribution / cover characterization source, not as a computational uniformization result.
- Ben-David, Benedek, and Mansour, "A parameterization scheme for classifying models of PAC learnability", Information and Computation 120(1), 1995, https://doi.org/10.1006/inco.1995.1094. The atlas already records this as an information-theoretic uniformity-parameter framework.
- Vidyasagar and Kulkarni, "Some contributions to fixed-distribution learning theory", IEEE Transactions on Automatic Control 45(2), 2000, https://doi.org/10.1109/9.839945. Its abstract treats fixed-distribution learnability, agnostic/model-free learning, uniform convergence, and equivalence-class representations, but again at the statistical/representation level rather than a PAC runtime-uniformization theorem.
- Blanc, Lange, Strassle, and Tan, "A Distributional-Lifting Theorem for PAC Learning", COLT 2025 / arXiv:2506.16651, https://arxiv.org/abs/2506.16651. This is the closest computationally flavored lead: it upgrades learners for a restricted distribution family to arbitrary distributions with overhead depending on the complexity of writing the target distribution as a mixture of base-family distributions. It does not apply directly to the present edge because our source is not a finite or structured base-family learner with a uniform runtime; it allows a separate polynomial bound for every marginal, with no mixture-complexity bound for arbitrary marginals.
- Blanc, Koch, Lange, Strassle, and Tan, "Samplability Makes Learning Easier", ITCS 2026, https://doi.org/10.4230/LIPIcs.ITCS.2026.20 and arXiv:2512.01276. This gives separations between standard PAC and samplable PAC, including computational separations relative to a random oracle, via explicit evasive sets. It suggests useful diagonalization technology, but it changes the distribution universe to efficiently samplable distributions; the present source must handle all marginals, including non-samplable and adversarially heavy-tailed ones.
- Tiegel, "Hardness of Agnostically Learning Halfspaces from Worst-Case Lattice Problems", COLT 2023, https://proceedings.mlr.press/v195/tiegel23a.html. This rules out efficient agnostic learning even in the distribution-specific standard-Gaussian setting under worst-case lattice assumptions, so halfspaces fail the source rather than separating this edge.
- Diakonikolas, Kane, Kontonis, Tzamos, and Zarifis, "Agnostic Proper Learning of Halfspaces under Gaussian Marginals", arXiv:2102.05629, https://arxiv.org/abs/2102.05629. This is a positive proper agnostic fixed-Gaussian result, but Tiegel's later hardness indicates the quantitative polynomial-in-$1/\varepsilon$ target is not available in the strong form needed here under the cited lattice assumptions.
- The local atlas notes for `clause-satisfaction-lookup-class`, `clause-satisfaction-proper-hardness`, `halfspaces`, and `pseudorandom-function-classes`.

### Lead 1: Computational Fixed-Distribution Uniformization

The search did not turn up a theorem of the needed form:

$$
\exists A\ \forall P\ \exists p_P\ \Longrightarrow\ \exists B\ \exists q\ \forall P
$$

for polynomial runtime in proper agnostic PAC learning.

The distributional-lifting theorem is the most relevant nearby result. Its shape is different: it starts from learners for a limited distribution family and pays an overhead governed by the complexity of decomposing an arbitrary target distribution into that family. For this edge, the "family" would be all marginals, and the missing quantity is exactly a uniform complexity/rate bound on the marginal-dependent polynomials. Treating every marginal as a base distribution would make the mixture decomposition trivial but leaves the runtime bound nonuniform, so the theorem does not collapse the edge to `resolved true`.

The fixed-distribution papers I found or rechecked continue to support the depth-0 reading: the classical characterizations explain when fixed-marginal or marginal-nonuniform sample learning is possible, but they do not supply a computational uniformization principle for proper agnostic ERM or proper optimization.

### Lead 2: Artificial Diagonalization Witness

The intended witness template is:

- create subproblems indexed by $k$;
- make the $k$th subproblem properly agnostically learnable in time $s^k$;
- arrange that no single exponent works across all $k$;
- define marginals $P_k$ concentrated on the $k$th subproblem, so each fixed $P_k$ has a polynomial bound, while any distribution-free learner would need one exponent for all $k$.

This template still fails as an atlas-grade counterexample because the source quantifies over every marginal, not just the sequence $(P_k)_k$.

The obstruction is arbitrary mixtures. If the domain is the disjoint union of blocks $X_k$, there are marginals with support on infinitely many blocks and tails decaying slower than any polynomial quantile. For such a marginal, an algorithm that must solve block $k$ in time $s^k$ cannot be bounded by any fixed polynomial in $s$ and $1/\varepsilon$ merely because the marginal is fixed. For example, if learning the tail up to error $\varepsilon$ requires processing all blocks up to a quantile $K_P(\varepsilon)$, then a distribution with $K_P(\varepsilon)$ growing faster than every polynomial in $1/\varepsilon$ breaks the source property itself.

One can try to evade this by allowing the learner to ignore low-mass hard blocks. That helps for fast tails, but the source must handle every fixed marginal, including deliberately slow tails. One can also try to encode the hard index $k$ in the marginal rather than in sample-visible points, but then mixtures of the corresponding marginals reintroduce the same problem unless the construction is closed under mixtures with a controlled polynomial exponent. I do not see such a closure mechanism.

A second issue is proper agnostic output. A hierarchy witness is easiest for a decision problem embedded into labels, but the learner here must output a member of the same concept class competing with the best concept. If the class contains enough lookup hypotheses to make every fixed marginal easy, it often also makes the distribution-free proper learner easy by empirical majority/ERM on the observed finite support. If the class does not contain those lookup hypotheses, the positive marginal-nonuniform proper side is hard to prove.

This does not prove the edge true. It does refute the naive "one hard block per exponent" diagonalization route unless it is strengthened to handle all infinite-support marginals and all agnostic conditionals.

### Lead 3: Properness-Hard Fixed-Marginal Candidates

The clause-satisfaction lookup class still does not separate this edge. Its known positive side is improper: enumerate the polynomial-size clause domain and output a lookup table. The target failure uses proper hypotheses encoding assignments. For this edge the source is already proper, so the same witness would need a proper agnostic learner for every fixed marginal over clauses. That would already solve the hard satisfiability-encoded realizable marginals used in the lower-bound argument.

Halfspaces also do not separate this edge. Positive fixed-Gaussian proper agnostic algorithms exist, but the source asks for every marginal. Tiegel's standard-Gaussian distribution-specific hardness, under worst-case lattice assumptions, is stronger in the wrong direction: it blocks the source for halfspaces rather than showing only distribution-free failure.

Fixed-$k$ DNF / proper DNF-style candidates have the same problem. Distribution-specific positive results for restricted or bounded distribution families do not imply positive marginal-nonuniform learning for every marginal. The known proper hardness reductions choose a marginal tailored to the hard instance; since the source must handle that marginal too, these candidates fail at the source unless a new argument shows fixed-marginal proper learning even on the reduction marginals.

### Conditional True Heuristic

There is a weak heuristic in favor of truth under a strong runtime convention. If the source learner is a single Turing machine whose runtime is bounded worst-case over all samples in the support of a fixed marginal, then point-mass and mixture marginals exert pressure against unbounded runtime exponents:

1. point masses test the learner's behavior on individual domain points;
2. countable mixtures can place positive mass on infinitely many bad regions;
3. a fixed marginal with a sufficiently slow tail can force the learner to cope with larger and larger bad regions as $\varepsilon$ decreases.

Together with the sample-only Hanneke--Moran--Thiessen uniformization, this suggests that some formal compactness/diagonal-mixture argument might rule out arbitrary marginal-dependent computational exponents. However, I do not have a proof. The difficult step is converting "the source learner succeeds with a $P$-dependent polynomial" into one explicit distribution-free polynomial runtime while preserving proper agnostic correctness. The source learner may use its samples adaptively, and correctness under a mixture marginal does not immediately imply correctness under each component marginal.

### Final Verdict

`unresolved`.

Depth 1 did not produce either an atlas-valid proof or a valid counterexample. The strongest update is negative: the most tempting false-witness route, a time-hierarchy family with one block per exponent, appears to fail the source once arbitrary infinite-support mixture marginals are included. The strongest positive lead is a possible diagonal-mixture uniformization theorem under a worst-case runtime convention, but I did not find it in the literature and did not complete a proof.

### Concrete Next Directions

- Pin down the atlas runtime convention for marginal-nonuniform efficient learning. If runtime is worst-case over all sample sequences in the marginal support, attempt a formal diagonal-mixture proof that unbounded exponents contradict the source.
- Try a component-to-mixture lemma: if $P^\star=\sum_i w_iP_i$, determine which guarantees for proper agnostic learning under $P^\star$ can be transferred to each $P_i$ by choosing $\varepsilon\ll w_i$. This is the missing technical bridge for a true proof.
- Search for "distributional lifting" variants that preserve properness and agnostic excess error while allowing infinitely many base distributions with nonuniform base runtimes. The current COLT 2025 theorem has the right flavor but not the needed quantifiers.
- If pursuing a false witness, require the construction to pass the slow-tail test: for every marginal over the union of hard blocks, there must be a fixed polynomial in $1/\varepsilon$ despite arbitrarily slow mass tails.
- Revisit properness-hard witnesses only if there is a candidate whose hard distribution-free reduction uses a family of marginals that become easy one-by-one for a single proper learner. The current lookup, DNF, and halfspace candidates do not meet that bar.

## Depth-2 Entry - 2026-05-04

### Target Question

Depth 1 isolated the following possible bridge. Let

$$
P^\star=\sum_i w_iP_i,\qquad w_i>0,\qquad \sum_iw_i=1.
$$

Suppose the marginal-nonuniform agnostic proper learner $A$ has a polynomial guarantee for the mixture marginal $P^\star$. Can an accuracy guarantee under a joint distribution $\mathcal D^\star$ with marginal $P^\star$ be transferred to a component joint distribution $\mathcal D_i$ with marginal $P_i$, with only polynomial overhead in $1/w_i$ and $1/\varepsilon$? If yes, a diagonal mixture might convert the family of component-wise marginal-dependent runtime bounds into one bound for the mixture.

### Sources Checked

- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability" (NeurIPS 2025), https://openreview.net/forum?id=aoVCFtox89 and https://openreview.net/pdf?id=aoVCFtox89. The paper defines marginal-nonuniform rates as marginal-dependent but concept-uniform, and proves the sample-rate trichotomy. This remains the main source for the sample-only collapse but not for computational runtime uniformization.
- Benedek and Itai, "Learnability with respect to fixed distributions", Theoretical Computer Science 86(2), 1991, https://doi.org/10.1016/0304-3975(91)90026-X. Relevant because it separates fixed-distribution sample learnability from computation; its abstract explicitly notes that the main concern is sample count, not feasible computation.
- Benedek and Itai, "Dominating distributions and learnability", COLT 1992, https://doi.org/10.1145/130385.130413. Relevant for distribution transfer: for polynomial sample bounds, one needs a multiplicative domination condition. A mixture gives $P_i\le (1/w_i)P^\star$, but this is only a starting point and does not by itself control agnostic excess error against the component optimum.
- Ben-David, Benedek, and Mansour, "A Parameterization Scheme for Classifying Models of PAC Learnability", Information and Computation 120(1), 1995, https://doi.org/10.1006/inco.1995.1094. This is the classic uniformity-parameter framework; it is explicitly information-theoretic rather than a computational uniformization theorem.
- Kearns, Schapire, and Sellie, "Toward Efficient Agnostic Learning", Machine Learning 17, 1994, https://doi.org/10.1023/A:1022615600103. Used for the standard agnostic excess-error benchmark $\operatorname{err}(h)\le \operatorname{OPT}_{\mathcal C}+\varepsilon$.
- Blanc, Lange, Strassle, and Tan, "A Distributional-Lifting Theorem for PAC Learning", COLT 2025 / arXiv:2506.16651, https://arxiv.org/abs/2506.16651. This is the closest positive mixture theorem: it lifts learners for a structured base family to mixtures with overhead depending on mixture complexity and preserves noise tolerance, but it assumes a uniform efficient base-family setup rather than an arbitrary marginal-indexed family of polynomial runtimes.

### Raw Component-To-Mixture Transfer Is False

The naive lemma is false in the proper agnostic setting.

For a mixture joint distribution

$$
\mathcal D^\star=\sum_i w_i\mathcal D_i,
$$

the source learner gives, with high probability,

$$
\operatorname{err}_{\mathcal D^\star}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D^\star)+\eta.
$$

But

$$
\operatorname{OPT}_{\mathcal C}(\mathcal D^\star)
=
\inf_{c\in\mathcal C}\sum_iw_i\operatorname{err}_{\mathcal D_i}(c)
\ge
\sum_iw_i\operatorname{OPT}_{\mathcal C}(\mathcal D_i),
$$

and the inequality can be strict. The gap is exactly the incompatibility cost of requiring one proper hypothesis $c\in\mathcal C$ to serve all mixture components at once. Consequently, small excess error on the mixture only gives

$$
w_i\bigl(\operatorname{err}_{\mathcal D_i}(h)-\operatorname{OPT}_{\mathcal C}(\mathcal D_i)\bigr)
\le
\eta+
\left(
\operatorname{OPT}_{\mathcal C}(\mathcal D^\star)
-
\sum_jw_j\operatorname{OPT}_{\mathcal C}(\mathcal D_j)
\right),
$$

which is useful only if the incompatibility gap is already small.

A two-point example shows the obstruction. Let $X=\{a,b\}$ and let $\mathcal C$ contain only the two constant classifiers. Let $P_1$ be supported on $a$ with label $0$, and let $P_2$ be supported on $b$ with label $1$. Each component has $\operatorname{OPT}_{\mathcal C}=0$: the constant-$0$ classifier is optimal on $\mathcal D_1$, and the constant-$1$ classifier is optimal on $\mathcal D_2$. On the balanced mixture, every proper classifier has error $1/2$. Thus a perfect mixture-agnostic learner may output either constant classifier, but that hypothesis has component excess error $1$ on one component. Taking $\eta\ll w_i\varepsilon$ does not fix this, because the problem is not estimation error; it is the proper agnostic benchmark changing from per-component optima to a single mixture optimum.

This is not merely a properness issue, but properness makes it unavoidable for the atlas edge. An improper learner allowed to paste together component-wise hypotheses on disjoint supports might remove the incompatibility gap. A proper learner cannot assume that the pasted classifier is in $\mathcal C$.

### A Neutral-Noise Variant Does Transfer

There is a narrower true lemma. Fix one component $i$ and define a joint distribution

$$
\mathcal D^{\star,i}
=
w_i\mathcal D_i
+
\sum_{j\ne i}w_j(P_j\times \operatorname{Bernoulli}(1/2)).
$$

On every off-component point, labels are independent fair noise. Therefore every deterministic $c\in\mathcal C$ has off-component error exactly $1/2$, and for every $h\in\mathcal C$,

$$
\operatorname{err}_{\mathcal D^{\star,i}}(h)
=
w_i\operatorname{err}_{\mathcal D_i}(h)
+
\frac{1-w_i}{2}.
$$

It follows that

$$
\operatorname{OPT}_{\mathcal C}(\mathcal D^{\star,i})
=
w_i\operatorname{OPT}_{\mathcal C}(\mathcal D_i)
+
\frac{1-w_i}{2}.
$$

Thus any proper hypothesis satisfying

$$
\operatorname{err}_{\mathcal D^{\star,i}}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D^{\star,i})+\eta
$$

also satisfies

$$
\operatorname{err}_{\mathcal D_i}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D_i)+\eta/w_i.
$$

So with $\eta=w_i\varepsilon$, mixture accuracy transfers to component accuracy with the expected polynomial overhead in $1/w_i$ and $1/\varepsilon$. This works precisely because the fair-noise complement cancels out of the agnostic objective for every proper hypothesis.

### Why The Transfer Lemma Still Does Not Prove The Edge

The neutral-noise lemma is useful but not enough to resolve

$$
\texttt{efficient-marginal-nonuniform-agnostic-proper-pac}
\Rightarrow
\texttt{efficient-agnostic-proper-pac}.
$$

First, it requires control of $A$ on the mixture marginal

$$
P^\star=\sum_iw_iP_i.
$$

The source gives a polynomial $p_{P^\star}$ for this fixed mixture, but says nothing quantitative about the degree or coefficients of $p_{P^\star}$. To obtain a distribution-free efficient learner, one still needs one polynomial $q$ independent of the unknown target marginal. The lemma can move accuracy from $P^\star$ to $P_i$, but it does not turn the unknown polynomial $p_{P^\star}$ into a uniform polynomial.

Second, a distribution-free learner for a fresh marginal $P$ cannot generally simulate samples from a fixed diagonal mixture containing $P$ as a known component. It only receives labeled samples from the target joint distribution. It can add artificial fair-noise examples from a chosen reference marginal $R$, but then the relevant marginal is

$$
wP+(1-w)R,
$$

which still varies with $P$. The source's runtime polynomial may therefore vary with $P$ through the mixture.

Third, there is no universal reference marginal $R$ that multiplicatively dominates all possible $P$ with a polynomially bounded density ratio in the general PAC domain. Benedek--Itai's domination result explains why multiplicative domination is the right kind of condition for polynomial transfer between fixed distributions, but arbitrary distribution-free PAC learning has no such dominating distribution built in.

Fourth, the distributional-lifting theorem of Blanc--Lange--Strassle--Tan is a near miss rather than a resolution. It starts with a uniformly efficient learner for every distribution in a base family and pays an overhead for expressing the target distribution as a structured mixture of base distributions. Here the base family would effectively be "all marginals", but the available runtime is not uniform across that family. Treating every target marginal as its own base distribution makes the mixture description trivial while leaving the runtime nonuniform.

### Effect On False-Witness Attempts

The raw-transfer failure revives one obstruction to a positive proof: proper agnostic mixture learning can hide bad component performance behind incompatible component optima. Therefore a proof of the atlas edge cannot simply say "put all hard marginals into one mixture and run the source learner with $\eta\ll w_i\varepsilon$."

However, this does not give a false witness either. The neutral-noise trick shows that, in an agnostic setting, one can sometimes isolate a component inside a mixture by making the rest of the mixture label-informationally irrelevant. That weakens the naive diagonal counterexample strategy: if the construction tries to hide many hard marginals in a slow-tail mixture, an adversary can ask about label conditionals that neutralize the other components.

The remaining difficulty is computational, not statistical. The source learner may have a valid polynomial for each mixture marginal, including every neutralized mixture marginal, while those polynomials might still have no uniform envelope.

### Depth-2 Verdict

`unresolved` for the atlas edge.

More precisely:

- The raw component-to-mixture lemma is `resolved false` in the agnostic proper setting because mixture excess error need not control component excess error; incompatible component optima create an additive gap that can be constant.
- A neutral-fair-noise component isolation lemma is `resolved true`: if all non-target components have independent fair labels, then $\eta$ excess error on the mixture gives $\eta/w_i$ excess error on component $i$, with no properness loss.
- The neutral lemma does not currently prove a distribution-free efficient proper agnostic learner, because it does not supply a uniform polynomial runtime bound independent of the target marginal.

### Next Directions

1. Try to strengthen the neutral-noise lemma into a diagonal runtime argument. The missing statement would be: if one Turing machine has a polynomial runtime bound for every neutralized mixture marginal, then the exponents and coefficients have a uniform envelope. I do not see a proof.
2. Search specifically for computational versions of Benedek--Itai domination: transfer results where $P_i\le \kappa P^\star$ controls both sample complexity and running time for a single algorithm.
3. Check whether the atlas runtime convention is worst-case over sample sequences from the marginal support. If so, point-mass plus neutral-mixture arguments may put stronger pressure on unbounded runtime exponents.
4. For a false witness, build a class whose component optima can be neutralized by fair-noise complements but whose source still holds for every mixture marginal. The current block-diagonal hierarchy template has not passed this test.
5. Revisit distributional lifting only if a version appears that allows nonuniform base runtimes and returns a hypothesis proper for the original class $\mathcal C$.

## Depth-3 Entry - 2026-05-04

### Target Question

Depth 2 found a fair-noise neutralized component-to-mixture lemma:

$$
\mathcal D^{\star,i}
=
w_i\mathcal D_i
+
\sum_{j\ne i}w_j(P_j\times \operatorname{Bernoulli}(1/2)).
$$

For this special joint distribution, the off-component loss is exactly $(1-w_i)/2$ for every deterministic proper hypothesis $h\in\mathcal C$, so mixture excess error $\eta$ implies component excess error $\eta/w_i$. The follow-up question is whether this can be strengthened enough to prove the full uniformization edge, or whether the remaining mixture-specific runtime polynomial is a genuine blocker. I also checked whether properness introduces a separate obstruction after fair-noise neutralization.

### Strengthened Statistical Lemma

The neutralized lemma can be stated in its strongest useful statistical form.

Fix any target joint distribution $\mathcal D$ with marginal $P$, any auxiliary marginal $R$, and any weight $\alpha\in(0,1]$. Define

$$
\mathcal D_{\alpha,R}
=
\alpha\mathcal D
+
(1-\alpha)(R\times\operatorname{Bernoulli}(1/2)).
$$

Then for every $h\in\mathcal C$,

$$
\operatorname{err}_{\mathcal D_{\alpha,R}}(h)
=
\alpha\operatorname{err}_{\mathcal D}(h)+\frac{1-\alpha}{2},
$$

and hence

$$
\operatorname{OPT}_{\mathcal C}(\mathcal D_{\alpha,R})
=
\alpha\operatorname{OPT}_{\mathcal C}(\mathcal D)+\frac{1-\alpha}{2}.
$$

Therefore any proper hypothesis with

$$
\operatorname{err}_{\mathcal D_{\alpha,R}}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D_{\alpha,R})+\alpha\varepsilon
$$

also satisfies

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\varepsilon.
$$

This is already as strong as the accuracy-transfer step needs to be. It works for arbitrary $\mathcal C$ and does not require closure under pasting, disjoint unions, convexification, or improper hypotheses. The fair-noise complement is label-neutral for every classifier, so the agnostic benchmark on the mixture is exactly an affine rescaling of the benchmark on the target component.

### Why This Still Does Not Uniformize Runtime

To use the source learner $A$, one would simulate examples from $\mathcal D_{\alpha,R}$ by drawing from $\mathcal D$ with probability $\alpha$ and from $R$ with fair labels otherwise. If $A$ is run with target accuracy $\eta=\alpha\varepsilon$, then the source guarantee gives the desired proper hypothesis for $\mathcal D$.

The runtime bound obtained this way is

$$
p_{\alpha P+(1-\alpha)R}\bigl(s,1/(\alpha\varepsilon),\log(1/\delta)\bigr).
$$

This is the decisive obstruction for the proof route. The polynomial is attached to the mixed marginal $\alpha P+(1-\alpha)R$, and this marginal still depends on the unknown target marginal $P$. The source definition gives no uniform bound on the degree or coefficients of

$$
P\mapsto p_{\alpha P+(1-\alpha)R}.
$$

Choosing a very small fixed $\alpha$ does not remove the problem. It makes every target marginal a small perturbation of $R$, but the definition contains no continuity, domination-stability, or local boundedness assumption saying that nearby marginals have comparable runtime polynomials. Even if $\alpha$ is polynomially small in $\varepsilon$, the target still needs one global polynomial in $s,1/\varepsilon,\log(1/\delta)$, while the source only gives a separate polynomial for each perturbed marginal.

Letting $\alpha$ depend on $P$ would be worse: the distribution-free learner is not allowed marginal-specific advice, and the final polynomial cannot hide $P$-dependent parameters. Dovetailing over $\alpha$, timeouts, or candidate reference distributions only recovers eventual or marginal-dependent behavior unless one already has a uniform envelope on the corresponding $p_{\alpha P+(1-\alpha)R}$.

Thus the fair-noise lemma solves the agnostic excess-error transfer problem, but it does not solve the computational quantifier swap:

$$
\forall P\ \exists p_P
\qquad\not\Rightarrow\qquad
\exists q\ \forall P
$$

for runtime. The blocker is not that the component accuracy loss is too large; the blocker is that every application of the lemma still calls $A$ under a marginal whose promised polynomial may be mixture-specific.

### Can A Diagonal Mixture Force A Uniform Envelope?

The most optimistic true-proof attempt would argue by contradiction. If no uniform runtime polynomial exists, choose a sequence of troublesome marginals $P_k$, put them into a single mixture

$$
P^\star=\sum_kw_kP_k,
$$

and use the source polynomial $p_{P^\star}$ plus fair-noise neutralization to derive a uniform enough bound for the components.

The neutralized lemma is not sufficient for this argument. The source gives $p_{P^\star}$ only for joint distributions whose marginal is exactly $P^\star$. To isolate a component $P_k$, the neutralized joint distribution may have marginal $P^\star$, but running $A$ on it gives a runtime bounded by $p_{P^\star}$ at accuracy $\eta=w_k\varepsilon$. This yields a component learner with runtime polynomial in $1/w_k$ and $1/\varepsilon$, but the constants and exponent are those of the one selected mixture $P^\star$.

That is useful only for the particular countable family embedded in $P^\star$. It does not produce a distribution-free learner for an arbitrary fresh marginal $P$. To prove the atlas edge true, one would need a canonical way to embed every possible $P$ into one fixed mixture with polynomially controlled weight, or a universal reference marginal dominating all $P$ with polynomial density ratio. The general PAC domain supplies neither. This is exactly where the Benedek-Itai domination intuition points in the negative direction: distribution transfer with polynomial rates needs quantitative domination, and the distribution-free setting has no universal dominating marginal.

There is also a quantifier issue about algorithms. Even if a diagonal argument showed that a particular source learner $A$ cannot have wildly unbounded runtimes on some selected family without contradicting its promise on a mixture, the target asks whether there exists some distribution-free polynomial learner $B$. Conversely, unbounded marginal-specific polynomials for one witnessing $A$ do not by themselves prove that no different $B$ exists. This is why the runtime obstruction blocks the positive proof route but does not by itself certify a false edge.

### Properness Check

Properness caused the raw component-to-mixture lemma to fail: different components can have incompatible optimal concepts, so a proper mixture optimum need not be assembled from component optima.

After fair-noise neutralization, that additional obstruction disappears. Since the off-component labels are independent fair noise, every proper $h\in\mathcal C$ pays the same off-component loss. The optimal proper hypothesis for the neutralized mixture is exactly a proper optimizer for the target component, up to the affine scaling above. No improper pasting is needed, and no closure property of $\mathcal C$ is being smuggled in.

So properness is not an extra blocker for the strengthened neutralized lemma itself. The remaining properness-related limitation is only methodological: the lemma returns a single $h\in\mathcal C$, and it cannot support a proof strategy that would combine different component-wise proper hypotheses into one hypothesis unless $\mathcal C$ has an explicit closure property. For this edge, however, the decisive unsolved issue remains runtime uniformization, not properness.

### Depth-3 Verdict

`unresolved` for the atlas edge.

The fair-noise neutralized component-to-mixture lemma can be strengthened to give the desired agnostic excess-error transfer with a clean $\alpha^{-1}$ accuracy overhead and no additional properness loss. That is not enough to prove

$$
\texttt{efficient-marginal-nonuniform-agnostic-proper-pac}
\Rightarrow
\texttt{efficient-agnostic-proper-pac}.
$$

The mixture-specific runtime polynomial remains a definitive blocker for this proof strategy: every neutralized simulation invokes the source learner under a marginal-dependent mixture, and the source definition gives no uniform polynomial envelope over those mixtures. This does not resolve the edge false, because the absence of a uniform envelope in the promise is not itself a counterexample. It leaves the correct atlas verdict at `open` / unresolved.

### Follow-Up Directions

1. A true proof would need an additional theorem deriving uniform runtime envelopes from marginal-nonuniform runtime promises, perhaps under a worst-case-over-samples convention plus a strong diagonal-mixture argument. The fair-noise lemma supplies only the statistical transfer part of such a theorem.
2. A false proof still needs an actual class satisfying the source for every marginal while defeating every distribution-free polynomial proper agnostic learner. Merely pointing to marginals with large $p_P$ for one learner is not enough.
3. Any future strengthening should separate two hypotheses explicitly: domination or local-stability assumptions on $P\mapsto p_P$ would make neutralized transfer powerful, but those assumptions are not present in the current atlas node.

## Depth-4 Entry - 2026-05-04

### Final Target

Decide whether the edge

$$
\texttt{efficient-marginal-nonuniform-agnostic-proper-pac}
\Rightarrow
\texttt{efficient-agnostic-proper-pac}
$$

can be resolved after the depth-2 and depth-3 fair-noise analysis.

The final answer is: **unresolved**. The edge should remain `status: "open"` with `evidence: unknown`.

### What Is Resolved Inside The Edge

The statistical component-transfer problem is resolved positively once the non-target part of the mixture is replaced by fair noise.

For any target joint distribution $\mathcal D$ with marginal $P$, any auxiliary marginal $R$, and any $\alpha\in(0,1]$, define

$$
\mathcal D_{\alpha,R}
=
\alpha\mathcal D
+
(1-\alpha)(R\times\operatorname{Bernoulli}(1/2)).
$$

For every deterministic classifier $h$, and therefore for every proper hypothesis $h\in\mathcal C$,

$$
\operatorname{err}_{\mathcal D_{\alpha,R}}(h)
=
\alpha\operatorname{err}_{\mathcal D}(h)
+
\frac{1-\alpha}{2}.
$$

Taking the infimum over $h\in\mathcal C$ preserves the same affine relation:

$$
\operatorname{OPT}_{\mathcal C}(\mathcal D_{\alpha,R})
=
\alpha\operatorname{OPT}_{\mathcal C}(\mathcal D)
+
\frac{1-\alpha}{2}.
$$

Hence a proper hypothesis satisfying

$$
\operatorname{err}_{\mathcal D_{\alpha,R}}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D_{\alpha,R})
+
\alpha\varepsilon
$$

also satisfies

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)
+
\varepsilon.
$$

This is the exact transfer one would want from the mixture problem back to the target component. It does not require improper pasting, closure of $\mathcal C$ under disjoint unions, convexity, or any special representation property. The fair-noise complement contributes the same loss to every hypothesis, so the agnostic proper benchmark is simply rescaled.

### Properness Diagnosis

Properness is a real obstruction for the raw component-to-mixture argument, because different components can have incompatible optimal proper hypotheses. A learner that is nearly optimal for the ordinary mixture need not be nearly optimal on each component.

Fair-noise neutralization removes that particular obstruction. Once the complement is labeled by independent fair coins, all proper hypotheses incur the same complement loss. The mixture optimum is therefore an affine copy of the component optimum inside the same class $\mathcal C$. No improper hypothesis is introduced, and no component-wise hypotheses are combined.

So the final diagnosis is not "properness blocks transfer." The more precise statement is:

- raw mixture transfer fails in the proper agnostic setting because proper optima can be incompatible across components;
- fair-noise mixture transfer succeeds and preserves properness exactly;
- after this repair, the remaining open issue is purely the computational uniformization of runtime polynomials.

### Why Runtime Still Blocks Uniformization

Using the source learner $A$ on $\mathcal D_{\alpha,R}$ gives a proper hypothesis with the desired accuracy on $\mathcal D$ if $A$ is run to accuracy $\eta=\alpha\varepsilon$. But the marginal of $\mathcal D_{\alpha,R}$ is

$$
P_{\alpha,R}=\alpha P+(1-\alpha)R.
$$

The source node only gives a polynomial bound

$$
p_{P_{\alpha,R}}
\left(s,1/(\alpha\varepsilon),\log(1/\delta)\right)
$$

for this particular mixed marginal. Since $P_{\alpha,R}$ still depends on the target marginal $P$, this is not a distribution-free polynomial runtime bound.

The target node requires one polynomial $q$ such that the running time is bounded by

$$
q(s,1/\varepsilon,\log(1/\delta))
$$

for all marginals $P$. The source promise has only

$$
\forall P\ \exists p_P,
$$

not

$$
\exists q\ \forall P.
$$

The fair-noise construction does not change this quantifier order. It transfers agnostic excess error from a mixed marginal to a component, but every such use still inherits the mixed marginal's own polynomial $p_{\alpha P+(1-\alpha)R}$.

Choosing $R$ canonically does not fix the problem. There is no general universal marginal $R$ that dominates all possible PAC marginals with a polynomially bounded density ratio, and the source definition gives no continuity or local boundedness of $P\mapsto p_P$. Choosing $\alpha$ very small also does not fix it: even an arbitrarily small perturbation of $R$ may have an unrelated runtime polynomial under the current definition.

### Why This Is Not A False Resolution

The runtime obstruction is not itself a counterexample. To mark the edge `false`, one would need a concept class $\mathcal C$ such that:

1. one uniform learner properly agnostically learns $\mathcal C$ for every marginal, with a marginal-dependent polynomial runtime bound;
2. no distribution-free proper agnostic learner has a single polynomial runtime bound.

The scratchpad attempts did not produce such a class. Standard cryptographic and halfspace hardness examples fail in the wrong way: they usually give a fixed hard marginal, so they refute the source node rather than separate it from the target. Properness-hard lookup examples separate proper from improper learning, but this edge already assumes proper learning on the source side. Block-diagonal diagonalization templates still have to handle arbitrary slow-tail mixtures of their blocks, and no atlas-ready construction here satisfies the source for every marginal.

Thus the failure of the proof route should not be upgraded to `status: "false"`.

### Atlas-Ready Unresolved Summary

Proposed atlas verdict:

```yaml
status: "open"
evidence: unknown
summary: "Open: fair-noise mixtures transfer agnostic proper excess error from a mixture to a component, but the source still supplies only a polynomial runtime bound depending on the mixed marginal. No theorem currently uniformizes these marginal-specific runtime polynomials, and no counterexample class is recorded."
```

Suggested body text:

> The statistical transfer obstruction can be bypassed by fair-noise neutralization. Given a target distribution $\mathcal D$ with marginal $P$, form $\alpha\mathcal D+(1-\alpha)(R\times\operatorname{Bernoulli}(1/2))$. The fair-noise part contributes $(1-\alpha)/2$ error to every proper hypothesis, so excess error $\alpha\varepsilon$ on the mixture implies excess error $\varepsilon$ on $\mathcal D$ with no loss of properness.
>
> This does not resolve the computational edge. Applying the marginal-nonuniform learner to the neutralized mixture gives a runtime bounded by the polynomial attached to the mixed marginal $\alpha P+(1-\alpha)R$. That polynomial may still depend arbitrarily on $P$. The source gives no uniform envelope, continuity, domination stability, or local boundedness for the map $P\mapsto p_P$. Therefore the fair-noise argument proves only the accuracy-transfer step, not the distribution-free polynomial runtime required by the target.
>
> Known hardness witnesses do not currently separate the edge: fixed hard marginals refute the source itself, and properness-hard examples do not provide the required positive marginal-nonuniform proper agnostic learner. The edge remains open pending either a computational uniformization theorem or a formal class separating marginal-dependent polynomial runtime from distribution-free polynomial runtime.

### Final Verdict

`unresolved`.

The correct final state for this scratchpad is not `resolved true` and not `resolved false`. The fair-noise component-transfer lemma is resolved true and properness-preserving, but the mixture-specific runtime polynomial remains the fundamental blocker. The atlas edge should remain open unless future work supplies either:

1. a theorem converting marginal-dependent polynomial runtime bounds into one distribution-free polynomial runtime bound, or
2. a formal counterexample class satisfying the marginal-nonuniform proper agnostic source while failing the distribution-free proper agnostic target.

## Depth-5 Entry - 2026-05-05

### Verdict

`resolved true`, under the atlas definition as written.

The previous entries treated the marginal-dependent runtime polynomial as if it could remain hidden from every distribution-free run. That is too pessimistic once the source node is read literally: there is one uniform learner, the learner is not given marginal-specific advice, and its sample complexity and running time are "at most" a marginal-dependent polynomial. Under the standard worst-case resource convention for efficient PAC algorithms over finite example representations, a single full-support reference marginal forces a uniform polynomial bound on all finite labeled transcripts. The source learner itself is then already a distribution-free efficient proper agnostic learner.

This is a definition-level theorem, not a new hardness assumption. If the atlas later changes marginal-nonuniform efficiency to mean only high-probability, expected, or almost-sure runtime under each marginal, then this proof no longer applies and the old runtime-uniformization obstruction should be restored.

### Definitions Used

Source: `efficient-marginal-nonuniform-agnostic-proper-pac` means there is a single learner $A$ such that, for every instance marginal $P$, some polynomial $p_P$ bounds both sample complexity and running time as a function of the representation-size parameter $s$, $1/\varepsilon$, and $\log(1/\delta)$. For every joint distribution $\mathcal D$ with marginal $P$, $A$ outputs $h\in\mathcal C$ satisfying

$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\varepsilon
$$

with probability at least $1-\delta$. The polynomial may depend on $P$, but not on the conditional label rule, $\varepsilon$, $\delta$, or the target/benchmark concept. The learner is one algorithm, not a family of algorithms indexed by $P$.

Target: `efficient-agnostic-proper-pac` asks for one proper agnostic PAC learner with one polynomial sample and runtime bound uniform over all joint distributions and all marginals.

The proof also uses the usual representation-size reading of the efficient nodes: for each size $s$, examples have finite encodings. Thus there is a countable set of possible encoded examples, or a countable set inside each size slice, and one can choose a reference marginal with full support on every encoded instance in every size slice. This is the same computational-learning convention implicit in measuring running time by a representation-size parameter.

### Sources Checked

- Local source definition: `atlas/definitions/efficient-marginal-nonuniform-agnostic-proper-pac.md`.
- Local target definition: `atlas/definitions/efficient-agnostic-proper-pac.md`.
- Local edge note: `atlas/implications/efficient-marginal-nonuniform-agnostic-proper-pac--implies--efficient-agnostic-proper-pac.md`.
- Local argument notes: `atlas/arguments/marginal-uniformization-open.md` and `atlas/arguments/marginal-agnostic-hardness-open.md`.
- Local atlas conventions: `atlas/README.md`, especially the statement that computationally efficient nodes require polynomial sample complexity and polynomial running time, and marginal-nonuniform nodes allow the polynomial PAC bounds to depend on the instance marginal distribution.
- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability", OpenReview page and PDF, https://openreview.net/forum?id=aoVCFtox89 and https://openreview.net/pdf?id=aoVCFtox89. Checked on 2026-05-05. The OpenReview page reports "Published: 18 Sept 2025, Last Modified: 21 Apr 2026"; the paper states the marginal-nonuniform quantifier order as one algorithm with constants depending on the marginal distribution and uniformly over target concepts.
- Kearns, Schapire, and Sellie, "Toward Efficient Agnostic Learning", Machine Learning 17, 1994, https://www.cis.upenn.edu/~mkearns/papers/agnostic-journal.pdf. The paper's general learning definition uses a fixed polynomial sample bound and says efficient learnability means the running time is bounded by a fixed polynomial.
- Ben-David, Benedek, and Mansour, "A parameterization scheme for classifying models of PAC learnability", Information and Computation 120(1), 1995, https://doi.org/10.1006/inco.1995.1094 and https://cris.tau.ac.il/en/publications/a-parameterization-scheme-for-classifying-models-of-pac-learnabil/. The record confirms the uniformity-parameter taxonomy and notes that the paper focuses on information-theoretic learnability rather than computational complexity.
- Benedek and Itai, "Learnability with respect to fixed distributions", Theoretical Computer Science 86(2), 1991, https://doi.org/10.1016/0304-3975(91)90026-X and https://www.sciencedirect.com/science/article/pii/030439759190026X.

### Theorem Route

Goal: prove that the source learner $A$ itself has one distribution-free polynomial sample and runtime bound.

Fix the encoded instance space used by the representation-size parameter. For each size slice, enumerate the possible encoded instances as $x_{s,1},x_{s,2},\ldots$ and choose a reference marginal $P^\star$ with full support on every encoded instance in every slice, for example by assigning positive mass proportional to $2^{-i}$ inside each slice. If the formalism treats marginals as size-indexed families, take the family $P^\star=(P^\star_s)_s$.

Apply the source definition to this one marginal $P^\star$. There is a polynomial

$$
q(s,1/\varepsilon,\log(1/\delta)) := p_{P^\star}(s,1/\varepsilon,\log(1/\delta))
$$

bounding the sample complexity and running time of $A$ for every joint distribution whose instance marginal is $P^\star$.

Now consider any finite labeled transcript that $A$ could see on examples of representation size $s$. Since $P^\star$ gives positive mass to every encoded instance, and since the source guarantee for $P^\star$ is uniform over all conditional label rules, there is a joint distribution with marginal $P^\star$ assigning positive probability to that transcript. If $A$ could use more than $q(s,1/\varepsilon,\log(1/\delta))$ samples or time on that transcript, this would contradict the "at most" resource bound promised for $P^\star$. The same reasoning covers adaptive sampling: every finite adaptive transcript that can occur under any marginal also has positive probability under some joint distribution with marginal $P^\star$.

Therefore $A$ has a worst-case sample and runtime bound $q$ on every possible finite transcript, independent of the target marginal. Since $A$ is one algorithm, this same bound applies when the examples are drawn from an arbitrary joint distribution $\mathcal D$.

Accuracy is even simpler. For an arbitrary joint distribution $\mathcal D$ with marginal $P$, the source guarantee applied to $P$ already says that $A$ outputs a proper $h\in\mathcal C$ with

$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\varepsilon
$$

with probability at least $1-\delta$. Combining this distribution-free accuracy guarantee with the full-support resource bound $q$ proves the target node.

The fair-noise mixture lemma from depths 2--4 is still correct, but it is unnecessary for this final proof. The missing observation was that the resource polynomial for one full-support marginal controls the actual uniform algorithm on all finite transcripts.

### Counterexample Route

The standard false-witness routes still fail, and now for a sharper reason.

Fixed hard marginals, such as PRF or halfspace hardness marginals, refute the source itself: the source learner must be efficient for every marginal, including the fixed hard one.

Block-diagonal diagonalization no longer separates the edge under the atlas resource convention. If a proposed source learner takes superpolynomial time on some finite block transcript, then the full-support reference marginal $P^\star$ sees that transcript with positive probability under a suitable conditional label rule. The source promise for $P^\star$ forbids such behavior. Thus a diagonal construction would have to exploit a weaker runtime convention, such as expected or high-probability runtime, rather than the "at most" convention currently written in the node.

Properness-hard lookup witnesses also do not apply. The source is already proper, and the full-support argument is indifferent to properness: once the source learner's accuracy guarantee is assumed, only its transcript-wise resource use has to be uniformized.

### Concrete Obstruction

The only remaining obstruction is definitional, not mathematical.

The proof requires the atlas's current "sample complexity and running time are at most" wording to mean a worst-case polynomial bound for the single learner on every finite transcript compatible with the marginal support, as in standard efficient PAC learning. It also requires the computational representation model to admit a full-support reference marginal on encoded examples, which is natural for finite strings and size-indexed computational learning problems.

If instead marginal-nonuniform runtime is intended to mean expected runtime, high-probability runtime, or almost-sure runtime under each marginal, then a full-support marginal would not necessarily control measure-zero or tiny-probability slow transcripts. In that alternative model the depth-4 open obstruction would return: the source would provide only $\forall P\,\exists p_P$, and fair-noise mixtures would not by themselves yield $\exists q\,\forall P$.

### Atlas-Ready Proof And Changes

Proposed status changes:

```yaml
status: "true"
evidence: theorem
assumptions: []
witnesses: []
ref_keys:
  - benedek1991fixed
  - bendavid1995parameterization
  - hanneke2025marginalnonuniform
  - kearns1994
summary: "True under the atlas's one-learner worst-case efficiency convention: a full-support reference marginal forces the marginal-nonuniform learner's sample and runtime bound to hold on every finite transcript, while the source already gives proper agnostic accuracy for every marginal."
```

Suggested atlas body text:

> `true`, by a full-support marginal uniformization argument.
>
> Let $A$ be the single learner promised by the marginal-nonuniform source. Choose a reference marginal $P^\star$ with full support on every finitely encoded instance in each representation-size slice. By the source guarantee, there is a polynomial $p_{P^\star}$ bounding the sample use and running time of $A$ for every joint distribution with marginal $P^\star$.
>
> Since $P^\star$ has full support, every finite labeled transcript that can occur for examples of size $s$ has positive probability under some joint distribution with marginal $P^\star$; the source guarantee is uniform over conditional label rules. Therefore, if $A$ exceeded $p_{P^\star}(s,1/\varepsilon,\log(1/\delta))$ samples or time on any such transcript, it would violate the promised bound for $P^\star$. Thus $p_{P^\star}$ is a single distribution-free sample and runtime bound for $A$.
>
> For accuracy, fix any joint distribution $\mathcal D$ with marginal $P$. Applying the source guarantee to this $P$ already gives, with probability at least $1-\delta$, a proper hypothesis $h\in\mathcal C$ satisfying
> $$
> \operatorname{err}_{\mathcal D}(h)\le \inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\varepsilon .
> $$
> Combining this accuracy guarantee with the uniform resource bound from $P^\star$ proves efficient distribution-free agnostic proper PAC learning.
