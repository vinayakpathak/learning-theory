# Open Edge Resolution Scratchpad

Edge: `efficient-marginal-nonuniform-weak-realizable-improper-pac -> efficient-marginal-nonuniform-realizable-improper-pac`
Depth: 0 root pending
Current atlas status: `open`, evidence `unknown`
Family: `marginal-boosting-open`

## Research Log

## Sources Checked

## Proof Or Counterexample Attempts

## Verdict

Unresolved pending depth-0 investigation.

## Follow-Up Directions

---

## Depth-0 Entry - 2026-05-04

### Relevant Definitions

Target edge:
`efficient-marginal-nonuniform-weak-realizable-improper-pac -> efficient-marginal-nonuniform-realizable-improper-pac`.

The source node requires one uniform learner $A$ such that for every instance marginal $P$ there are a marginal-dependent polynomial $p_P$ and inverse-polynomial advantage $\gamma_P(s)>0$ with

$$
\operatorname{err}_P(h,c)\le 1/2-\gamma_P(s)
$$

for every target $c\in\mathcal C$ and confidence parameter $\delta$, using sample size and runtime bounded by $p_P(s,\log(1/\delta))$. The polynomial and advantage may depend on $P$, but not on the target concept.

The target node requires one uniform learner $B$ such that for every marginal $P$ there is a marginal-dependent polynomial $q_P$ with

$$
\operatorname{err}_P(h,c)\le \varepsilon
$$

for every $c\in\mathcal C$ and $\varepsilon,\delta\in(0,1)$, using sample size and runtime bounded by $q_P(s,1/\varepsilon,\log(1/\delta))$. Again, $q_P$ may depend on $P$ but not on $c,\varepsilon,\delta$.

Registry context: this edge is in the `marginal-boosting-open` family. The registry permits `status: "true"` only with `evidence: theorem`, `status: "false"` only with `evidence: counterexample` or `conditional-counterexample`, and `status: "open"` with `evidence: unknown`.

### Sources Checked

- Local source definition: `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-improper-pac.md`.
- Local target definition: `atlas/definitions/efficient-marginal-nonuniform-realizable-improper-pac.md`.
- Local edge note: `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac.md`.
- Local argument note: `atlas/arguments/marginal-boosting-open.md`.
- Registry context: `atlas/registry/edge_families.yml`, especially `marginal-boosting-open`; `atlas/registry/axes.yml`.
- Local comparison notes: `atlas/arguments/realizable-boosting.md` and `atlas/arguments/sample-complexity-equivalence.md`.
- Schapire, "The Strength of Weak Learnability" (1990), DOI: https://doi.org/10.1023/A:1022648800760; author PDF checked at https://www.schapire.net/papers/strengthofweak.pdf. The paper proves weak/strong equivalence in the distribution-free PAC model and explicitly uses filtering to simulate new example distributions.
- Freund, "Boosting a Weak Learning Algorithm by Majority" (1995), DOI: https://doi.org/10.1006/inco.1995.1136; author PDF checked at https://cseweb.ucsd.edu/~yfreund/papers/BoostByMajority.pdf; ScienceDirect abstract checked at https://www.sciencedirect.com/science/article/pii/S0890540185711364. The abstract says the algorithm trains on different example sets and includes an extension where weak accuracy depends on the instance distribution.
- Benedek and Itai, "Learnability with Respect to Fixed Distributions" (1991), DOI: https://doi.org/10.1016/0304-3975(91)90026-X; ScienceDirect page checked at https://www.sciencedirect.com/science/article/pii/030439759190026X and Technion PDF located at https://csaws.cs.technion.ac.il/~itai/publications/Learning/fixed.pdf. This source supports the fixed-distribution background but is mainly sample-complexity oriented and does not give the needed computational boosting envelope.
- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability" (NeurIPS 2025), OpenReview: https://openreview.net/forum?id=aoVCFtox89; PDF: https://openreview.net/pdf?id=aoVCFtox89. The paper defines marginal-nonuniform rates as depending on the marginal but holding uniformly over concepts, and gives the sample-rate trichotomy.

### Theorem Attempt: Classical Boosting

Goal: use Schapire/Freund boosting as a black-box conversion from the weak source learner $A$ to a strong improper learner $B$.

Construction attempt:

1. Fix an original marginal $P$, target concept $c$, and requested $\varepsilon,\delta$.
2. Run a realizable booster with oracle access to examples from $P$ labeled by $c$.
3. Whenever the booster needs a weak hypothesis for a reweighted or filtered distribution $Q_t$, simulate samples from $Q_t$ using examples from $P$ and previous hypotheses, then call $A$ on those samples.
4. Combine the weak hypotheses by the booster vote.

Why this would work in the distribution-free setting: Schapire's theorem assumes the weak learner succeeds for every distribution with one distribution-independent polynomial and edge, so every filtered distribution $Q_t$ is covered with the same quantitative resources. The final vote is improper, which is allowed by the target node.

Obstruction under the atlas source: for each induced $Q_t$, the weak source gives some polynomial $p_{Q_t}$ and edge $\gamma_{Q_t}$, but these may depend on the induced marginal. The induced $Q_t$ is not fixed by $P$ alone; it can depend on $c$, previous weak hypotheses, the booster's internal randomness, and empirical estimates. The target needs one polynomial $q_P$ depending only on the original $P$, not on $c$ or on the particular sequence of reweightings. The source definition contains no statement such as

$$
\sup_{Q\in\mathcal Q(P,\varepsilon,\delta,A,\mathrm{Boost})} p_Q,\ 1/\gamma_Q
$$

being bounded by a polynomial depending only on $P$. Without such an envelope, the usual boosting proof does not instantiate the target's quantifiers.

### Theorem Attempt: Adaptive Verification And Timeouts

Attempt: call $A$ on a candidate reweighted marginal $Q_t$ with increasing time/sample budgets and empirically test whether the returned hypothesis has error below $1/2-\widehat\gamma$ on fresh $Q_t$ samples. This avoids knowing $p_{Q_t}$ or $\gamma_{Q_t}$ in advance.

This can plausibly make each individual boosting call eventually succeed for a fixed realized $Q_t$. However, the target is a polynomial-time statement. The running time would be controlled by the actual $p_{Q_t}$ and $1/\gamma_{Q_t}$ values encountered. Since these quantities may vary with target-dependent reweightings, the argument still does not produce a single polynomial $q_P(s,1/\varepsilon,\log(1/\delta))$ independent of $c$. The adaptive scheme is therefore a Las Vegas-style search idea, not a proof of the atlas target.

### Theorem Attempt: Sample-Only Detour

The sample-only marginal-nonuniform weak-to-strong edge is true in the atlas via finite-sample characterizations and ERM. Hanneke--Moran--Thiessen's marginal-nonuniform trichotomy also explains why polynomial marginal-dependent sample rates collapse to the finite-VC side.

This does not resolve the present computational edge. Unbounded ERM can ignore runtime; here the target requires a polynomial running-time bound depending only on $P$. The weak algorithm is computationally efficient only with marginal-dependent runtime bounds, and the sample-only route gives no efficient implementation of the strong learner.

### Counterexample Attempt: Fixed-Distribution Weak/Strong Separation

Schapire's introduction notes that, under restrictions on the instance distribution, weak and strong learning can separate; this motivates why the distribution-free theorem is nontrivial. A tempting false-edge strategy is to use a class that is weakly but not strongly learnable under a fixed marginal such as the uniform distribution.

This does not fit the atlas source. The source is not "weakly learnable under one fixed marginal"; it requires one learner that weakly succeeds for every marginal, with a polynomial allowed to depend on that marginal. A fixed-marginal separation does not certify the source node across all marginals. I did not find a primary-source counterexample satisfying the full marginal-nonuniform weak source while violating the strong marginal-nonuniform improper target.

### Precise Obstruction

The problem is a quantifier mismatch:

$$
\forall P\ \exists p_P,\gamma_P\ \forall c
$$

is available for the weak learner only when the learner is run on marginal $P$. In a boosting proof from original marginal $P_0$, the weak learner is run on a family of marginals

$$
Q_t = Q_t(P_0,c,h_1,\ldots,h_{t-1},\text{randomness}).
$$

For each such $Q_t$, the source gives

$$
\exists p_{Q_t},\gamma_{Q_t},
$$

but the target requires the whole boosted procedure to be bounded by one

$$
q_{P_0}
$$

that is independent of $c$. The definitions do not imply any regularity of $Q\mapsto p_Q$ or $Q\mapsto \gamma_Q$ under bounded-density reweightings, filtering, absolute continuity with respect to $P_0$, or booster-generated transformations. Freund's distribution-dependent extension is a near miss, but the source material I checked did not yield an atlas-ready theorem saying that the required envelope follows from the bare marginal-nonuniform weak promise.

### Final Verdict

`unresolved`.

I do not have a theorem strong enough for `resolved true`, and I do not have a valid class/assumption pair for `resolved false`. The current atlas status `open` with `evidence: unknown` remains appropriate for this edge.

### Concrete Follow-Up Directions

1. Inspect Freund 1995 Section(s) on distribution-dependent weak accuracy in full detail, preferably from a searchable/OCR source, and formalize its assumptions. Check whether it assumes an explicit lower bound on all filtered-distribution edges or a functional relationship that can be bounded from the original marginal.
2. Search for later "distribution-dependent boosting", "boosting under fixed distributions", "boosting with variable edge", or "boosting with nonuniform weak advantage" theorems. A positive resolution would need a statement producing one polynomial envelope for all booster-generated reweightings from a fixed original marginal.
3. Try to construct an oracle/diagonal class where a uniform algorithm weakly learns every marginal but the runtime/edge constants on reweighted marginals generated from some fixed $P$ have target-dependent, super-polynomial blow-up. Such a construction would need to respect the source's uniform-over-target requirement for every marginal.
4. Clarify whether the atlas computational definitions require worst-case runtime over samples or high-probability/expected runtime under the marginal. A stricter distribution-independent syntactic runtime bound for the weak learner would likely make classical boosting go through; the current notes appear to allow genuinely marginal-dependent runtime.

---

## Depth-1 Entry - 2026-05-04

### Lead 1: Freund 1995 In Detail

Verdict from this lead: Freund's distribution-specific extension is a sharper near miss, not a positive resolution.

I inspected the author PDF of Yoav Freund, "Boosting a Weak Learning Algorithm by Majority" (Information and Computation 121(2), 1995), DOI: https://doi.org/10.1006/inco.1995.1136, especially Section 4.1, "Using boosting for distribution-specific learning." The introduction already flags the intended extension: if a learner has accuracy $1-\epsilon$ over every distribution, classical boosting gives arbitrary accuracy over the target distribution $\mathcal D$; Section 4.1 then asks what happens when the learner's accuracy degrades as the filtered distribution moves away from $\mathcal D$.

The setup in Section 4.1 is important. Freund explicitly says that the previous sections assumed complexity bounds uniform over all input distributions, and then relaxes the **accuracy** requirement, not the runtime/sample-complexity requirement. The atlas source is weaker in a second way: both the advantage and the polynomial resource bound may depend on the marginal.

Freund's Theorem 4.4 fixes a target distribution $\mathcal D$ and parameters $\gamma,\epsilon,\delta>0$. In paraphrase, if `WeakLearn`, for every distribution $\mathcal P$ over the sample space and every $c\in\mathcal C$, returns a hypothesis whose error under $\mathcal P$ is below

$$
\frac12-\gamma\left(1-\frac{\epsilon(1-\epsilon)\gamma}{4\ln(1/\epsilon)}
e^{D_{KL}(\mathcal P\|\mathcal D)}\right),
$$

then the filtering booster $B_{\mathrm{Filt}}$ returns, with probability at least $1-\delta$, a hypothesis with error below $\epsilon$ under $\mathcal D$. The formula is permissive for distributions far from $\mathcal D$ because the required edge can become nonpositive, but it still imposes a **single KL-sensitive lower envelope** for all distributions sufficiently close to $\mathcal D$.

This does not follow from the atlas source. The source gives, for each marginal $\mathcal P$, some edge $\gamma_{\mathcal P}$ and polynomial $p_{\mathcal P}$, with no lower semicontinuity, KL control, bounded-density control, or local positive infimum around the original marginal $\mathcal D$. Even if each individual filtered marginal has a positive inverse-polynomial edge, the infimum over the KL-near marginals that a booster might generate may be zero, and the polynomials $p_{\mathcal P}$ may have no envelope depending only on $\mathcal D$.

### Lead 2: Primary-Source Search

Sources checked:

- Robert Schapire, "The Strength of Weak Learnability" (Machine Learning 5, 1990), DOI: https://doi.org/10.1023/A:1022648800760; author PDF: https://www.schapire.net/papers/strengthofweak.pdf.
- Yoav Freund, "Boosting a Weak Learning Algorithm by Majority" (Information and Computation 121(2), 1995), DOI: https://doi.org/10.1006/inco.1995.1136; author PDF: https://cseweb.ucsd.edu/~yfreund/papers/BoostByMajority.pdf.
- Yoav Freund and Robert Schapire, "A Decision-Theoretic Generalization of On-Line Learning and an Application to Boosting" (JCSS 55(1), 1997), DOI: https://doi.org/10.1006/jcss.1997.1504.
- Adam Kalai and Varun Kanade, "Potential-Based Agnostic Boosting" (NeurIPS 2009), proceedings page: https://papers.nips.cc/paper/3676-potential-based-agnostic-boosting; author/Microsoft PDF: https://www.microsoft.com/en-us/research/wp-content/uploads/2016/11/2009-Potential-Based_Agnostic_Boosting.pdf.
- Vitaly Feldman, "Distribution-Specific Agnostic Boosting" (ICS 2010 / arXiv:0909.2927), arXiv: https://arxiv.org/abs/0909.2927; PDF checked at https://www.cs.cmu.edu/~odonnell/hits09/feldman-agnostic-boosting.pdf.
- Benedek and Itai, "Learnability with Respect to Fixed Distributions" (Theoretical Computer Science 86(2), 1991), DOI: https://doi.org/10.1016/0304-3975(91)90026-X.
- Kearns and Valiant, "Cryptographic Limitations on Learning Boolean Formulae and Finite Automata" (JACM 41(1), 1994), DOI: https://doi.org/10.1145/174644.174647, for the background that weak/strong equivalence can fail under restricted fixed-distribution formulations.

Search terms included "distribution-dependent boosting," "distribution-specific boosting," "fixed-distribution boosting," "boosting with variable edge," "nonuniform weak advantage," and combinations with "PAC" and "weak learner."

The variable-edge/adaptive-boosting line also does not resolve the atlas edge. AdaBoost-style results remove the need to know the edge in advance and exploit the actual edge obtained in each round, but their convergence bounds still depend on a cumulative quantity such as $\sum_t \gamma_t^2$ or on some lower edge bound along the run. Without a marginal-dependent lower envelope over the booster-generated marginals, this gives no polynomial $q_{\mathcal D}$ independent of the target concept.

The distribution-specific agnostic boosting line is the most interesting alternative because it avoids changing the marginal over $X$. Kalai--Kanade and Feldman explicitly modify labels or target functions while keeping the unlabeled marginal fixed, and Feldman's Theorem 1.1 gives a polynomial-time distribution-specific agnostic boosting theorem from an $(\alpha,\gamma)$-weak agnostic learner over the same distribution. But the atlas source is only **realizable** weak learning. The relabeling steps create agnostic/noisy labeled distributions that need not be realizable by any concept in $\mathcal C$, so a realizable weak learner has no promised behavior on those calls. Thus these theorems suggest a route for the corresponding marginal-nonuniform weak-agnostic edge, not for this realizable-only edge.

### Lead 3: Polynomial Envelope For Reweighted Marginals

I found no primary theorem yielding the needed envelope:

$$
\forall \mathcal D\ \exists q_{\mathcal D}\ \forall c,\epsilon,\delta
$$

for the boosted learner from only the source promise

$$
\forall \mathcal P\ \exists p_{\mathcal P},\gamma_{\mathcal P}\ \forall c.
$$

Freund 1995 gives a sufficient KL-sensitive edge condition, but that condition is additional structure:

$$
\gamma_{\mathcal P}
\gtrsim
\gamma_{\mathcal D}\left(1-\mathrm{const}(\epsilon,\gamma_{\mathcal D})
e^{D_{KL}(\mathcal P\|\mathcal D)}\right)
$$

on the relevant neighborhood of $\mathcal D$, plus uniform resource control. Distribution-specific agnostic boosting avoids reweighted marginals but requires a weak agnostic learner. Adaptive/variable-edge boosting tolerates unknown or varying edges but its runtime bound still depends on the actual edge sequence.

So the concrete obstruction after depth 1 is stronger than at depth 0: the known positive theorems each add exactly one missing hypothesis. Freund adds a quantitative envelope for distribution-dependent accuracy; distribution-specific agnostic boosting adds tolerance to relabeled/noisy distributions while preserving the marginal; AdaBoost-style adaptivity removes prior knowledge of the edge but not the need for a lower cumulative edge bound. The atlas source has none of these.

### Counterexample Search Status

I still do not have a valid `resolved false` counterexample. Fixed-distribution weak/strong separations, including the Kearns--Valiant monotone-Boolean background cited by Schapire, show that a single fixed-distribution weak guarantee need not imply a single fixed-distribution strong guarantee. But this atlas source is not a one-distribution source: one uniform learner must weakly learn every marginal, with the polynomial and edge allowed to depend on that marginal but not on the target concept. Those separations therefore do not directly instantiate the source node.

The most plausible false-edge route remains a diagonal/oracle construction where the weak learner succeeds on every marginal individually, but a fixed original marginal $\mathcal D$ has target-dependent filtered marginals on which the weak edge or runtime deteriorates faster than any $\mathcal D$-dependent polynomial envelope. I found no primary source carrying out such a construction for this exact quantifier pattern.

### Final Verdict

`unresolved`.

Depth 1 did not find a theorem strong enough for `resolved true` and did not find a counterexample strong enough for `resolved false`. The atlas edge should remain open unless the schema is strengthened with an envelope condition or a new diagonal counterexample is found.

### Concrete Next Directions

1. Formalize a conditional positive lemma: if the source learner's edge and runtime have a $\mathcal D$-dependent polynomial envelope over all KL-near or booster-generated filtered marginals, then Freund 1995 Section 4.1 gives the strong marginal-nonuniform target.
2. Investigate whether the corresponding weak-agnostic marginal-nonuniform edge can be resolved true via Feldman 2010 or Kalai--Kanade 2009, since those algorithms preserve the unlabeled marginal and therefore seem better matched to marginal-nonuniform quantifiers.
3. Try an oracle/diagonal separation against all candidate boosters: encode target-dependent hard regions that are invisible under $\mathcal D$ until filtering concentrates on them, while preserving a weak learner for every marginal separately.
4. Search specifically for realizable boosting-by-relabeling theorems under closure assumptions on $\mathcal C$ or its improper hypothesis class. Such a theorem would only help this atlas edge if it can call the weak learner on realizable labels from $\mathcal C$ or otherwise reduce realizable weak learning to the needed agnostic weak calls.

---

## Depth-2 Entry - 2026-05-04

### Conditional Positive Lemma: Boosting With An Original-Marginal Envelope

Verdict for the conditional statement: `true`, provided the envelope controls both weak edge/resource bounds on the filtered marginals and the cost of sampling those marginals from the original example stream.

Fix a realizable weak learner $A$ for $\mathcal C$. For an original marginal $P$, let $\mathsf{Filt}(P,c,\varepsilon)$ denote the set of unlabeled marginals $Q$ that can be passed to $A$ by a Schapire/Freund-style realizable filtering booster when the original labeled examples are $(X,c(X))$ with $X\sim P$, the target error is $\varepsilon$, and the run ranges over all target concepts $c\in\mathcal C$, all previous weak hypotheses, and all internal randomness. Equivalently, these are the booster-generated distributions obtained by reweighting or filtering the original marginal; in Freund's distribution-specific version one can replace this by a prescribed KL-neighborhood of $P$ large enough to contain the filtered distributions used by $B_{\mathrm{Filt}}$.

**Lemma.** Suppose that for every original marginal $P$ there are polynomials

$$
R_P(s,1/\varepsilon,\log(1/\eta))
\quad\text{and}\quad
G_P(s,1/\varepsilon)
$$

such that, for every $Q\in\mathsf{Filt}(P,c,\varepsilon)$ and every $c\in\mathcal C$, a call to $A$ on examples from $Q$ labeled by $c$ returns, with probability at least $1-\eta$, a hypothesis $h$ satisfying

$$
\operatorname{err}_Q(h,c)\le \frac12-\frac{1}{G_P(s,1/\varepsilon)}
$$

using at most $R_P(s,1/\varepsilon,\log(1/\eta))$ samples and time. Assume also that the filter/rejection sampler used to simulate examples from each such $Q$ from examples drawn from $P$ has overhead bounded by a polynomial $S_P(s,1/\varepsilon,\log(1/\eta))$, uniformly over $c$ and the booster's history.

Then $\mathcal C$ satisfies `efficient-marginal-nonuniform-realizable-improper-pac`. More concretely, there is one uniform strong learner $B$ such that, for every original marginal $P$, the sample complexity and running time of $B$ are bounded by a polynomial $q_P(s,1/\varepsilon,\log(1/\delta))$ depending on $P$ but not on $c,\varepsilon,\delta$, and

$$
\operatorname{err}_P(B,c)\le \varepsilon
$$

with probability at least $1-\delta$.

### Proof Sketch

Run a standard realizable boosting procedure, using $A$ as the weak oracle. Let

$$
\Gamma_P(s,\varepsilon)=1/G_P(s,1/\varepsilon).
$$

The classical Schapire weak-to-strong theorem and Freund's boost-by-majority analysis say that if every weak call made by the booster has advantage at least $\Gamma$ over the distribution on which it is trained, then after

$$
T=\operatorname{poly}(1/\Gamma,\log(1/\varepsilon))
$$

rounds the weighted vote has error at most $\varepsilon$ under the original marginal. For example, AdaBoost-style analyses give the familiar dependence through a cumulative edge quantity such as $\sum_t \gamma_t^2$, so a uniform lower bound $\gamma_t\ge \Gamma$ yields $T=O(\Gamma^{-2}\log(1/\varepsilon))$ up to constants. Schapire 1990 and Freund 1995 provide the realizable boosting reference point; Freund 1995 Section 4.1 is especially relevant because it explicitly analyzes distribution-specific filtering when weak accuracy depends on the filtered distribution.

Apply this theorem with $\Gamma=\Gamma_P(s,\varepsilon)$. Each distribution sent to $A$ lies in $\mathsf{Filt}(P,c,\varepsilon)$ by construction, so the envelope gives the required weak edge and bounds the cost of each oracle call by $R_P$. The sampler-overhead assumption bounds the number of original $P$-examples needed to realize the filtered examples by $S_P$. Allocating failure probability $\eta=\delta/(2T)$ to each weak call and reserving the remaining failure probability for the booster/filtering estimates gives total failure probability at most $\delta$ by a union bound. The final hypothesis is a vote or weighted vote of weak hypotheses, hence improper in general, which is allowed by the target node.

If the booster requires the lower edge as an input, wrap it in the usual doubling/validation scheme: run stages with guessed values $\Gamma_j=2^{-j}$ and round counts polynomial in $1/\Gamma_j$, then test the resulting vote on fresh examples from $P$. Once $\Gamma_j\le \Gamma_P(s,\varepsilon)$, the stage succeeds with high probability; the geometric sum of earlier stages is still polynomial in $G_P(s,1/\varepsilon)$ and $\log(1/\delta)$. Thus the learner need not know the marginal-dependent envelope in advance. The existence of the polynomial

$$
q_P=\operatorname{poly}(R_P,S_P,G_P,1/\varepsilon,\log(1/\delta))
$$

is enough for the marginal-nonuniform target.

### KL-Near Version

A KL-neighborhood formulation is also sufficient, but only if it is genuinely uniform. Namely, fix a booster and suppose that for every original $P$ there is a polynomial envelope over all marginals $Q$ satisfying the KL condition required by that booster, for example all $Q$ with

$$
D_{KL}(Q\|P)\le K_P(s,1/\varepsilon)
$$

where $K_P$ is large enough to contain every filtered distribution the booster may query before reaching error $\varepsilon$. If $A$ has edge at least $1/G_P(s,1/\varepsilon)$ and resources at most $R_P$ on every such $Q$, and if these $Q$ are sampleable from the original stream with polynomial overhead in the same parameters, the same proof gives the target.

This matches the spirit of Freund's distribution-specific theorem: it does not derive a good edge on filtered distributions from pointwise fixed-distribution weak learnability; it assumes a quantitative relationship between weak accuracy and distance from the target distribution. In the atlas language, that relationship is exactly an envelope over a neighborhood of the original marginal.

### Is This Assumption Already In The Atlas Source?

No. The source node says

$$
\forall P\ \exists p_P,\gamma_P\ \forall c
$$

for calls made on the same marginal $P$. It does not say that, after fixing an original marginal $P_0$, the quantities $p_Q$ and $1/\gamma_Q$ are bounded by one polynomial depending only on $P_0$ for all filtered or KL-near $Q$ generated during boosting. The source definition also does not impose continuity, monotonicity under absolute continuity, bounded-density stability, KL stability, or any uniform sampling-overhead guarantee.

Therefore the conditional lemma is not an interpretation of the existing node. It would require a strengthened source notion, for example:

`efficient-marginal-nonuniform-filter-stable-weak-realizable-improper-pac`

or

`efficient-marginal-nonuniform-KL-stable-weak-realizable-improper-pac`.

Such a node would record, in addition to marginal-nonuniform weak learnability, an original-marginal polynomial envelope for every booster-generated filtered marginal, or for every marginal in a specified KL neighborhood. Under that strengthened node, the implication to `efficient-marginal-nonuniform-realizable-improper-pac` should be recorded as true by Schapire/Freund boosting.

### Final Verdict For The Original Edge

`unresolved`.

Depth 2 gives a clean conditional positive result, but it does not resolve the atlas edge as currently stated. The extra envelope is a real strengthening, not an implicit consequence of the existing marginal-nonuniform weak source. The current atlas status should remain `open` with `evidence: unknown` unless either a theorem derives such an envelope from the bare source definition or a counterexample separates the two notions.

### Citations

- Robert E. Schapire, "The Strength of Weak Learnability" (Machine Learning 5, 1990), DOI: https://doi.org/10.1023/A:1022648800760. Used for the classical weak-to-strong realizable boosting theorem and the filtering viewpoint.
- Yoav Freund, "Boosting a Weak Learning Algorithm by Majority" (Information and Computation 121(2), 1995), DOI: https://doi.org/10.1006/inco.1995.1136. Used for boost-by-majority and the distribution-specific/KL-sensitive near miss in Section 4.1.
- Yoav Freund and Robert E. Schapire, "A Decision-Theoretic Generalization of On-Line Learning and an Application to Boosting" (JCSS 55(1), 1997), DOI: https://doi.org/10.1006/jcss.1997.1504. Used for the adaptive weighted-vote viewpoint where performance is controlled by the accumulated weak edges.
- Shai Ben-David, Gyora M. Benedek, and Yishay Mansour, "A Parameterization Scheme for Classifying Models of Learnability" (Information and Computation 118(2), 1995), DOI: https://doi.org/10.1006/inco.1995.1094. Relevant for the atlas distinction between distribution-uniform and distribution-dependent parameters.
- David Hanneke, Shay Moran, and Tosca Thiessen, "Marginal-Nonuniform PAC Learnability" (NeurIPS 2025), OpenReview: https://openreview.net/forum?id=aoVCFtox89. Relevant for the marginal-nonuniform terminology and quantifier discipline.

### Next Directions

1. Define the strengthened node precisely if the atlas wants to record this positive theorem. The key design choice is whether the envelope is over the actual booster-generated filtered family or over a clean KL/absolute-continuity neighborhood.
2. For a possible `resolved false` result on the original edge, try to diagonalize against exactly this missing envelope: construct a class where every marginal has some weak polynomial and edge, but for one original $P_0$ the target-dependent filtered marginals force $p_Q$ or $1/\gamma_Q$ to exceed every $P_0$-dependent polynomial.
3. Check whether any existing distribution-specific boosting theorem supplies the sampling-overhead part automatically for the chosen filter family. If so, the strengthened node can cite Freund 1995 more directly rather than bundling sampleability into the hypothesis.

---

## Depth-3 Entry - 2026-05-04

### Question For This Pass

Can the edge be separated by an oracle/diagonal construction in which one uniform weak learner works for every marginal individually, but for some original marginal $P_0$ the filtered marginals generated by boosting have target-dependent weak edges or runtimes so small that no $P_0$-dependent polynomial strong bound can follow?

Short answer: this is a plausible obstruction to **black-box boosting from the given weak learner**, but it is not yet an atlas-valid `false` edge. To be atlas-valid, the construction must rule out every uniform strong learner for the class under $P_0$, not only rule out the Schapire/Freund-style strategy that repeatedly calls the weak learner on reweighted marginals.

### Booster-Specific Diagonal Sketch

A natural relativized construction would have the following ingredients.

1. Choose an original marginal $P_0$ with mass spread across infinitely many blocks

$$
X=\bigsqcup_{n\ge 1} B_n,
\qquad
P_0(B_n)=w_n,
$$

where the tail weights decay, say $w_n\approx 2^{-n}$ or another computable summable schedule.

2. Define concepts by independent target choices on the blocks. The early blocks carry enough mass that a strong learner for error $\varepsilon$ must correctly solve all blocks up to roughly the cutoff where the remaining tail has mass below $\varepsilon$.

3. Give the world an oracle that makes **weak** prediction on any fixed marginal $Q$ possible after a marginal-dependent amount of work. For example, for each $Q$ the oracle exposes one feature or one partial decoding procedure with correlation

$$
\gamma_Q(s)>0
$$

uniformly over targets, but with $1/\gamma_Q$ or the decoding time allowed to depend very badly on $Q$.

4. Diagonalize against a chosen boosting procedure. For a target concept $c_n$, arrange that the booster, after doing well on earlier mass, must filter toward a marginal $Q_n$ concentrating on a block or slice where the weak oracle's promised edge is

$$
\gamma_{Q_n}(s)\le 2^{-n}
$$

or where the runtime polynomial for $Q_n$ has degree or coefficient larger than the $n$th candidate $P_0$-polynomial. Since $Q_n$ is target- and history-dependent, the sequence $\{Q_n\}$ need not have a polynomial envelope depending only on $P_0$.

This would cleanly reproduce the obstruction identified at depths 0 through 2: the source allows

$$
\forall Q\ \exists p_Q,\gamma_Q,
$$

but boosting from $P_0$ needs a bound like

$$
\exists q_{P_0}\ \forall Q\in \mathsf{Filt}(P_0,c,\varepsilon).
$$

The diagonal can make the pointwise promises true while making the latter envelope false.

### Why This Does Not Yet Refute The Atlas Edge

The atlas target is not "boostable by this weak learner." It asks whether there exists one uniform strong learner $B$ such that for every original marginal $P$ there is a polynomial $q_P$ controlling $B$ directly on examples from $P$.

Therefore, a construction in which a particular booster sees increasingly hostile filtered marginals only proves a lower bound for that booster or for that black-box access pattern. It leaves open the possibility that a different learner avoids the hostile $Q_n$'s entirely. For example, a direct learner might:

- learn the relevant blocks under $P_0$ in decreasing mass order;
- exploit the structure of the oracle in a way that boosting does not;
- use the original samples to estimate the target on high-mass regions without ever producing the bad filtered marginal;
- run a distribution-specific agnostic-style procedure that preserves the original marginal, if the class has enough extra closure.

To prove `resolved false`, the diagonal must instead enumerate **all** candidate strong learners $B_1,B_2,\ldots$ and assign, for each $B_i$, a target concept $c_i$ and accuracy parameter $\varepsilon_i$ on the same original marginal $P_0$ such that $B_i$ fails within every claimed $P_0$-dependent polynomial bound. This is stronger than diagonalizing against all boosters, because the target learner is not required to call the weak learner as a subroutine.

### Main Technical Tension

The source requirement is surprisingly restrictive. It does not merely ask for weak learnability under $P_0$. It asks for one uniform weak learner that works for **every** marginal $P$ and every target $c\in\mathcal C$, with only the polynomial and edge allowed to depend on $P$.

This blocks several easy diagonal ideas.

First, one cannot simply make the class contain arbitrary hard labels on the blocks. If a marginal $P$ concentrates on a hard block or on a hard slice inside a block, the same weak learner must still have nontrivial advantage uniformly over all target concepts. Thus each possible marginal support must contain some weakly learnable structure, not just the original $P_0$ support.

Second, adding a fixed easy region shared by all concepts is not enough. If every concept agrees on an anchor set of $P_0$-mass $\alpha>0$, then constant prediction on that anchor gives weak edge under marginals that charge the anchor. But an adversarial marginal can put zero mass on the anchor, so the source still demands a weak learner on the remaining hard part.

Third, purely information-theoretic hardness is not available in the obvious way. The existing atlas notes already record that in the sample-only marginal-nonuniform setting, weak polynomial rates collapse to strong sample-efficient learnability through the marginal-nonuniform/VC theory. Any separation here must therefore be computational: samples sufficient for strong learning may exist, but no uniform polynomial-time strong learner may compute the needed hypotheses under $P_0$.

These constraints suggest that a genuine counterexample would need either a cryptographic assumption or a fully specified oracle model. The weak learner would have to receive just enough oracle help to get a target-uniform weak edge under every marginal, while every strong learner under $P_0$ is still forced to solve an infinite sequence of increasingly hard computational tasks.

### More Promising Oracle Shape

A more atlas-relevant oracle separation would diagonalize against strong learners first and then verify the weak source.

One possible shape is:

1. Build a finite-VC or otherwise sample-tame class so that the only obstruction is computation.
2. For each strong learner $B_i$, reserve a block $B_{n_i}$ of $P_0$-mass comparable to some $\varepsilon_i$ and choose the target labels on that block using an oracle diagonal so that $B_i$ cannot compute them within its first candidate polynomial budgets.
3. Provide a separate weak oracle procedure $W$ which, on samples from any marginal $Q$, finds some $Q$-heavy block or scale and returns a hypothesis with advantage at least $1/\operatorname{poly}_Q(s)$.
4. Make the cost of finding a useful weak feature depend on $Q$ so wildly that the weak source remains true pointwise but no $P_0$-polynomial envelope controls the bad blocks required for strong learning.

The hard part is step 3. It must hold for all marginals, including marginals concentrated exactly on blocks reserved for diagonalizing against strong learners. If $W$ can weakly learn those blocks quickly enough under the concentrated marginal, then a clever strong learner under $P_0$ might simulate this block-by-block and learn all $P_0$-significant blocks. The intended separation therefore needs a quantitative gap:

$$
\text{for each fixed } Q,\quad W \text{ is polynomial with } Q\text{-dependent constants,}
$$

but

$$
\text{for } P_0,\quad \text{the constants for the sequence of significant conditional marginals are unbounded by any } P_0\text{-polynomial.}
$$

This is coherent as a relativized phenomenon. It is exactly the missing envelope. But coherence is not the same as a counterexample: the construction must also prevent a direct strong learner from bypassing those conditional marginals.

### Atlas-Validity Assessment

As currently stated, the oracle/diagonal idea is **not atlas-valid** as a `status: "false"` witness.

Reasons:

- It separates the source from a particular boosting proof strategy, not from the existence of an efficient marginal-nonuniform strong learner.
- It has not specified a concrete concept class, representation scheme, oracle access model, and learner model.
- It has not proved the source node for every marginal, especially marginals concentrated on the allegedly hard filtered regions.
- It has not diagonalized against all candidate strong learners under the fixed original marginal $P_0$.
- It has no primary-source theorem or fully formal counterexample that the atlas can cite.

What it does justify is the current `open` status: the obstruction is real enough that classical boosting cannot be cited as a theorem for the bare node, but not strong enough to record a separation.

### Verdict

`unresolved`.

Depth 3 does not resolve the edge true or false. The possible oracle/diagonal separation remains a promising research direction, but only after upgrading it from "bad filtered marginals defeat boosters" to "one formal class satisfies the marginal-nonuniform weak source and no uniform strong learner has a $P_0$-dependent polynomial bound." Until then, the atlas-valid verdict remains `open` with `evidence: unknown`.

### Next Concrete Test

Try to formalize a relativized theorem with this exact target:

There exists an oracle $\mathcal O$, a represented binary class $\mathcal C^\mathcal O$, and an original marginal $P_0$ such that:

1. $\mathcal C^\mathcal O$ has one oracle weak learner satisfying `efficient-marginal-nonuniform-weak-realizable-improper-pac` relative to $\mathcal O$.
2. For every oracle strong learner $B_i$, there is a concept $c_i\in\mathcal C^\mathcal O$ and an accuracy $\varepsilon_i$ such that $B_i$ fails to learn $c_i$ under $P_0$ within its claimed marginal-dependent polynomial.
3. The failure is computational rather than sample-theoretic, so it does not contradict the known sample-only marginal-nonuniform weak-to-strong collapse.

If such a theorem can be written cleanly, it would be a candidate `conditional-counterexample` or `counterexample` depending on whether the atlas accepts relativized/oracle witnesses for computational edges. Without that formal theorem, the present edge should not be changed.

---

## Depth-4 Entry - 2026-05-04

### Final Question

Can the edge

`efficient-marginal-nonuniform-weak-realizable-improper-pac -> efficient-marginal-nonuniform-realizable-improper-pac`

be resolved using existing boosting theorems or by the oracle/diagonal obstruction explored above?

Final answer: `unresolved`.

The atlas should not record this edge as `true`, because the standard boosting proofs need a uniform envelope over filtered or KL-near marginals that is absent from the source definition. The atlas should also not record this edge as `false`, because the oracle/diagonal ideas currently defeat particular boosting strategies, not every possible marginal-nonuniform strong learner.

### Why Classical Boosting Does Not Prove The Edge

Classical realizable boosting proves a statement of the following form. If every weak call made by the booster has an edge bounded below by some common positive quantity, and if the cost of obtaining those weak hypotheses is uniformly controlled, then the final majority or weighted vote has small error under the original marginal.

In the distribution-free PAC setting, this is exactly what the weak-learning assumption supplies: the same learner has a distribution-independent polynomial resource bound and a distribution-independent inverse-polynomial edge. Schapire-style filtering and Freund-style boost-by-majority may train weak hypotheses on reweighted distributions, but those distributions remain inside the uniform promise.

The source node here has a different quantifier pattern:

$$
\forall P\ \exists p_P,\gamma_P\ \forall c.
$$

This promise applies pointwise to each marginal on which the weak learner is run. A booster starting from an original marginal $P_0$ does not only run the weak learner on $P_0$. It generates filtered or reweighted marginals

$$
Q_t = Q_t(P_0,c,h_1,\ldots,h_{t-1},\text{randomness}),
$$

and asks for weak hypotheses under those $Q_t$'s. The source gives, for each realized $Q_t$,

$$
\exists p_{Q_t},\gamma_{Q_t},
$$

but the target requires one original-marginal polynomial

$$
q_{P_0}(s,1/\varepsilon,\log(1/\delta))
$$

that works uniformly over all target concepts $c$ and all requested accuracies.

The missing step is therefore an envelope such as

$$
\sup_{Q\in\mathsf{Filt}(P_0,c,\varepsilon)}
\left(p_Q,\ 1/\gamma_Q,\ \text{sampling overhead from }P_0\text{ to }Q\right)
\le \operatorname{poly}_{P_0}(s,1/\varepsilon,\log(1/\delta)),
$$

with the right-hand side independent of $c$. The source definition contains no such filter-stability, KL-stability, bounded-density stability, continuity, monotonicity, or local lower-bound condition on $Q\mapsto\gamma_Q$ or $Q\mapsto p_Q$.

Freund's distribution-specific analysis is best viewed as a near miss that confirms this diagnosis. It allows the weak accuracy to depend on the distance between the filtered distribution and the original distribution, but it assumes a quantitative KL-sensitive lower envelope. It does not derive that envelope from bare pointwise marginal-nonuniform weak learnability. Similarly, adaptive boosting can avoid knowing the edge in advance, but its convergence still depends on the actual accumulated edges encountered during the run; without a $P_0$-dependent lower envelope, this gives no polynomial $q_{P_0}$.

### Conditional Positive Result

The following strengthened implication is atlas-ready as a conditional statement, though it is not the original edge.

If the weak source is strengthened so that, for every original marginal $P_0$, there is a $P_0$-dependent polynomial envelope controlling the weak learner's edge, runtime, sample complexity, and filtering overhead on every booster-generated marginal from $P_0$, uniformly over target concepts, then Schapire/Freund boosting gives `efficient-marginal-nonuniform-realizable-improper-pac`.

Equivalently, a node such as

`efficient-marginal-nonuniform-filter-stable-weak-realizable-improper-pac`

or

`efficient-marginal-nonuniform-KL-stable-weak-realizable-improper-pac`

should imply the target. The proof is the standard realizable boosting proof with the strengthened envelope supplying the common edge and resource bound that the original source lacks.

This does not resolve the present edge because the strengthened envelope is extra structure, not a consequence of the current node.

### Why Oracle Diagonal Ideas Are Not Atlas-Valid Counterexamples

The diagonal idea correctly targets the same missing envelope. One can imagine a relativized construction where every marginal $Q$ has some pointwise weak edge and polynomial bound, but the sequence of filtered marginals arising from a fixed $P_0$ has edges or constants growing beyond every $P_0$-dependent polynomial envelope.

That would refute a black-box boosting proof. It would not yet refute the atlas target.

The target node asks for existence of some uniform strong learner under $P_0$, not for success of a learner that calls the weak learner on filtered marginals. A direct strong learner might avoid the bad $Q_t$'s, learn high-mass regions under $P_0$ directly, exploit structure ignored by the booster, or use a different algorithmic route. Therefore, a valid false edge must diagonalize against all candidate strong learners, not merely against all boosting procedures using the supplied weak learner.

Moreover, the source node itself is strong enough to block easy separations. The weak learner must work for every marginal, including marginals concentrated on regions that a proposed counterexample wants to make computationally hard. A construction cannot simply hide hard labels in rare blocks: once a marginal concentrates on such a block, the source still requires target-uniform weak advantage there, with only marginal-dependent resources allowed.

Thus the current oracle sketch is not atlas-valid because it lacks:

- a fully specified concept class, representation scheme, oracle model, and learner model;
- a proof of the weak source for every marginal;
- a proof that every candidate strong learner fails under the same original marginal $P_0$;
- a primary-source or complete formal theorem that the atlas can cite.

At most, the oracle idea explains why the positive theorem is nontrivial and why classical boosting cannot be cited for the bare node.

### Atlas-Ready Unresolved Summary

Verdict: `unresolved`.

Recommended atlas status: keep `status: "open"` and `evidence: "unknown"`.

Summary:

Classical weak-to-strong boosting does not currently resolve this edge. The obstacle is that Schapire/Freund filtering calls the weak learner on reweighted marginals generated from the original marginal, while the source only gives pointwise marginal-dependent weak guarantees. For an original marginal $P_0$, the target requires one polynomial bound depending only on $P_0$ and uniform over concepts. The source gives separate bounds and edges for each filtered marginal $Q$, with no filter-stable or KL-stable envelope relating those quantities back to $P_0$. Known distribution-specific boosting results assume such an envelope rather than deriving it from the bare source. Conversely, oracle/diagonal sketches that make filtered marginals hostile only separate the source from particular black-box boosting strategies; they do not rule out arbitrary strong learners and therefore are not valid counterexamples to the atlas edge.

Atlas-ready body language:

The edge remains open. A positive resolution would follow from an additional $P_0$-dependent polynomial envelope over all booster-generated filtered marginals, controlling weak advantage, weak-learner runtime/sample use, and sampling overhead. This is exactly the kind of filter-stability or KL-stability condition used implicitly or explicitly in distribution-specific boosting analyses, but it is not part of the current source node. A negative resolution would require a formal computational separation, likely relativized or cryptographic, proving that every candidate strong learner fails under some fixed original marginal despite the existence of a pointwise marginal-nonuniform weak learner for every marginal. The current diagonal ideas do not yet establish this stronger claim.

### Final Verdict

`resolved true`: no.

`resolved false`: no.

`unresolved`: yes.

---

## Depth-5 Entry - 2026-05-05

### Verdict

`unresolved`.

I tried again to turn the edge either into a theorem or into a separation. The best current conclusion is still that the atlas edge should remain `status: "open"` with `evidence: unknown`.

The positive route fails at an explicit marginal-envelope gap. The negative route has suggestive fixed-distribution and oracle/diagonal evidence, but no atlas-valid counterexample because the source requires one weak learner for every marginal, and the target can be any direct strong learner, not necessarily a booster using the weak learner.

### Definitions Used

Source:

`efficient-marginal-nonuniform-weak-realizable-improper-pac`.

There is one uniform learner $A$ such that for every marginal $P$ there are a polynomial $p_P$ and inverse-polynomial advantage $\gamma_P(s)>0$ for which, for all target concepts $c\in\mathcal C$ and all confidence parameters $\delta$,

$$
\operatorname{err}_P(A,c)\le \frac12-\gamma_P(s)
$$

with sample complexity and running time bounded by $p_P(s,\log(1/\delta))$. The polynomial and advantage may depend on $P$, but not on $c$.

Target:

`efficient-marginal-nonuniform-realizable-improper-pac`.

There is one uniform learner $B$ such that for every marginal $P$ there is a polynomial $q_P$ for which, for all target concepts $c\in\mathcal C$ and all $\varepsilon,\delta\in(0,1)$,

$$
\operatorname{err}_P(B,c)\le \varepsilon
$$

with sample complexity and running time bounded by $q_P(s,1/\varepsilon,\log(1/\delta))$. Again, $q_P$ may depend on $P$, but not on $c,\varepsilon,\delta$.

The quantifier difference that matters is:

$$
\forall Q\ \exists p_Q,\gamma_Q\ \forall c
$$

for the weak learner when it is run on marginal $Q$, versus the target's need, after fixing the original marginal $P_0$, for

$$
\exists q_{P_0}\ \forall c,\varepsilon,\delta
$$

for the whole strong learner.

### Sources Checked

Local files checked:

- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/realizable-boosting.md`
- `atlas/arguments/sample-complexity-equivalence.md`
- `references.bib`
- this scratchpad through Depth 4

Primary or near-primary web sources checked in this pass:

- Robert E. Schapire, "The Strength of Weak Learnability" (1990), author PDF: https://www.schapire.net/papers/strengthofweak.pdf. Lines checked include the introduction's fixed-distribution warning and the filtering construction: the paper notes that monotone Boolean functions under the uniform distribution were weakly but not strongly learnable under restricted-distribution formulations, then proves weak/strong equivalence for unrestricted distributions; it also says the construction uses filtering to modify the example distribution and thereby exploits distribution-freeness.
- Yoav Freund, "Boosting a Weak Learning Algorithm by Majority" (1995), author PDF: https://cseweb.ucsd.edu/~yfreund/papers/BoostByMajority.pdf; DOI page represented in local refs as https://doi.org/10.1006/inco.1995.1136. Rechecked as the main distribution-dependent boosting near miss.
- Vitaly Feldman, "Distribution-Specific Agnostic Boosting" (2010), arXiv: https://arxiv.org/abs/0909.2927. The abstract explicitly contrasts standard boosting, which runs the weak learner on different domain distributions, with distribution-specific agnostic boosting, which keeps the instance marginal fixed by modifying labels/targets. This helps the weak-agnostic route, not the realizable-only source here.
- Steve Hanneke, Shay Moran, and Maximilian Thiessen, "Marginal-Nonuniform PAC Learnability" (NeurIPS 2025), OpenReview/PDF: https://openreview.net/forum?id=aoVCFtox89 and https://openreview.net/pdf?id=aoVCFtox89. Checked the marginal-nonuniform quantifier definition and the trichotomy discussion. Their sample-rate results confirm that the obstruction here is computational rather than information-theoretic.
- Search results around fixed-distribution weak/strong separation, including Schapire's citation of Kearns--Valiant's monotone Boolean example and later monotone-function literature. This produced useful negative intuition but not a valid atlas witness for the all-marginals source.

### Theorem Route

The strongest attempted theorem route is still classical realizable boosting with marginal-dependent bookkeeping.

Fix an original marginal $P_0$ and target concept $c$. A Schapire/Freund booster calls the weak learner on filtered or reweighted marginals

$$
Q_t = Q_t(P_0,c,h_1,\ldots,h_{t-1},\text{booster randomness}).
$$

Distribution-free boosting succeeds because the weak learner has one polynomial and one inverse-polynomial edge that apply to every such $Q_t$. The atlas source does not give this. It gives only a separate polynomial $p_{Q_t}$ and edge $\gamma_{Q_t}$ for each induced marginal.

The positive theorem would become valid under the following additional hypothesis:

For every original marginal $P_0$, there is a polynomial envelope $E_{P_0}(s,1/\varepsilon,\log(1/\delta))$ such that, uniformly over all concepts $c$, all booster histories, and all induced marginals $Q_t$, the weak learner's runtime, sample complexity, $1/\gamma_{Q_t}$, and the cost of sampling $Q_t$ from the original $P_0$ stream are bounded by $E_{P_0}$.

With that strengthened assumption, Schapire/Freund boosting gives the target. Without it, the standard proof has no polynomial $q_{P_0}$ independent of the target.

I also rechecked the distribution-specific agnostic route. Feldman's route is attractive because it preserves the instance marginal, which would avoid the envelope problem. But it requires weak agnostic behavior on relabeled/noisy examples. The current source is only realizable weak learning, so it has no promised behavior on the intermediate labeled distributions produced by the agnostic booster.

The sample-only route also does not resolve the computational edge. Hanneke--Moran--Thiessen's marginal-nonuniform theory and the local sample-complexity-equivalence notes support a sample-level weak-to-strong collapse, but unbounded ERM or sample-only existence does not produce a polynomial-time strong learner with a $P_0$-dependent runtime bound.

### Counterexample Route

The fixed-distribution separation route is tempting but insufficient. Schapire records that, under restrictions on the instance distribution, weak and strong learning can separate; the monotone Boolean functions under the uniform distribution are the motivating example. This cannot be copied into the atlas edge because the source is not "weakly learnable under one fixed marginal." It requires one uniform weak learner that works for every marginal, with constants allowed to depend on the marginal but not on the target concept.

The oracle/diagonal route remains plausible but incomplete. The intended construction would make each marginal $Q$ weakly learnable with its own polynomial and advantage, while arranging that one original marginal $P_0$ has target-dependent filtered marginals $Q_t$ whose weak constants have no $P_0$-polynomial envelope. This can defeat black-box boosting.

It still does not defeat the atlas target. A target learner for `efficient-marginal-nonuniform-realizable-improper-pac` is not required to call the weak learner or to visit the hostile filtered marginals. A valid `false` edge would need a concrete represented class, an oracle or cryptographic assumption if necessary, a proof of the weak source for every marginal, and a lower bound showing that every uniform strong learner fails under one fixed original marginal $P_0$ within every $P_0$-dependent polynomial.

I do not have such a construction, and I did not find a primary source proving one for this quantifier pattern.

### Concrete Obstruction

The concrete obstruction is not just "boosting changes distributions." It is the missing **original-marginal polynomial envelope**.

The source permits the map

$$
Q\mapsto (p_Q,\gamma_Q)
$$

to be completely irregular. For a fixed original marginal $P_0$, classical boosting may need weak hypotheses on a family of marginals

$$
\mathsf{Filt}(P_0,c,\varepsilon)
$$

that varies with the target concept and the booster's history. The target requires a single polynomial $q_{P_0}$ independent of $c$. The source does not imply

$$
\sup_{Q\in \mathsf{Filt}(P_0,c,\varepsilon)}
\left(p_Q,\frac1{\gamma_Q},\text{sampling overhead}(P_0\to Q)\right)
\le \operatorname{poly}_{P_0}(s,1/\varepsilon,\log(1/\delta)).
$$

Freund's distribution-dependent analysis supplies this kind of control as an additional quantitative condition. Feldman's distribution-specific agnostic boosting avoids changing $P_0$ but buys that by asking for agnostic weak learning. Neither theorem derives the needed envelope from the bare marginal-nonuniform realizable weak source.

### Atlas-Ready Text If Still Open

Recommended atlas status: keep `status: "open"` and `evidence: unknown`.

Suggested summary:

Open. Classical realizable boosting does not by itself prove this marginal-nonuniform edge. Starting from an original marginal $P_0$, Schapire/Freund-style boosters train weak hypotheses on filtered or reweighted marginals generated from $P_0$. The source gives only pointwise marginal-dependent weak guarantees: each induced marginal $Q$ has its own polynomial resource bound and weak advantage. The target requires one polynomial bound depending only on $P_0$ and uniform over target concepts and accuracies. No current atlas assumption gives a filter-stable or KL-stable envelope controlling the weak learner's constants and sampling overhead on all booster-generated marginals. Distribution-specific agnostic boosting preserves the marginal but requires weak agnostic calls, which the realizable source does not supply. Conversely, fixed-distribution weak/strong separations and oracle sketches only show that particular restricted-distribution or black-box boosting routes can fail; they do not give a concrete class satisfying the all-marginals weak source while refuting every marginal-nonuniform strong learner.

Suggested proof-status body:

The edge would be true under a strengthened source requiring, for each original marginal $P_0$, a $P_0$-dependent polynomial envelope over all booster-generated filtered marginals, controlling weak advantage, weak-learner runtime and sample complexity, and the overhead of simulating those marginals from examples drawn from $P_0$. Under that extra envelope, standard realizable boosting gives an improper strong learner. The current source node omits exactly this envelope, so the implication remains open.

Exact atlas changes if resolved: none, because this pass did not resolve the edge.
