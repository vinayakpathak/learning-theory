# Open Edge Resolution Scratchpad

Edge: `efficient-marginal-nonuniform-weak-agnostic-improper-pac -> efficient-marginal-nonuniform-agnostic-improper-pac`
Depth: 0 root pending
Current atlas status: `open`, evidence `unknown`
Family: `agnostic-boosting-open`

## Research Log

## Sources Checked

## Proof Or Counterexample Attempts

## Verdict

Unresolved pending depth-0 investigation.

## Follow-Up Directions

## Depth-0 Entry - 2026-05-04

### Relevant Definitions

- Source node: `efficient-marginal-nonuniform-weak-agnostic-improper-pac`. One uniform learner works for every joint distribution. For each fixed instance marginal $P$, the sample/runtime polynomial may depend on $P$. The guarantee is fixed-additive weak agnostic: for every joint distribution with marginal $P$, output $h \notin \mathcal C$ is allowed and
  $$
  \operatorname{err}_{\mathcal D}(h)
  \le \inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta_P(s),
  $$
  where $\beta_P(s)<1/2$ and the advantage $1/2-\beta_P(s)$ is inverse-polynomial under a marginal-dependent polynomial. There is no target excess-error input $\varepsilon$.
- Target node: `efficient-marginal-nonuniform-agnostic-improper-pac`. One uniform learner, same marginal-dependent runtime convention, but for every $\varepsilon,\delta$ it must output an improper hypothesis with
  $$
  \operatorname{err}_{\mathcal D}(h)
  \le \inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\varepsilon
  $$
  in time $p_P(s,1/\varepsilon,\log(1/\delta))$.
- Edge note currently says `open`, `evidence: unknown`, family `agnostic-boosting-open`, with a marginal bookkeeping concern: ordinary boosting may call the weak learner on reweighted instance marginals, while the source only gives separate polynomials for each induced marginal.
- Registry context allows only `true/theorem`, `false/conditional-counterexample`, or `open/unknown` for this sort of edge. A resolution needs either a generic theorem preserving the atlas marginal-dependent polynomial convention or a concrete class/assumption separating the two nodes.

### Sources Checked

- Atlas notes:
  - `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
  - `atlas/definitions/efficient-marginal-nonuniform-agnostic-improper-pac.md`
  - `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac.md`
  - `atlas/arguments/agnostic-boosting-open.md`
  - `atlas/arguments/marginal-boosting-open.md`
  - `atlas/arguments/sample-complexity-equivalence.md`
  - `atlas/registry/edge_families.yml`
  - `atlas/registry/axes.yml`
- Ben-David, Long, Mansour, "Agnostic Boosting" (COLT/EuroCOLT 2001), DOI page / ResearchGate mirror: https://doi.org/10.1007/3-540-44581-1_33 and https://www.researchgate.net/publication/2373407_Agnostic_Boosting. This is the atlas fixed-additive $\beta$-weak agnostic notion: a weak learner gives error $\operatorname{opt}+\beta$, and their boosting guarantee is non-optimal rather than $\operatorname{opt}+\varepsilon$.
- Gavinsky, "Optimally-Smooth Adaptive Boosting and Application to Agnostic Learning" (JMLR 2003): https://www.jmlr.org/papers/v4/gavinsky03a.html. The abstract says the paper gives a lower bound for final error achievable by agnostic boosting and an algorithm matching it within a constant factor.
- Kalai, Mansour, Verbin, "Agnostic Boosting and Parity Learning" (STOC 2008): https://www.microsoft.com/en-us/research/wp-content/uploads/2016/11/2008-On_Agnostic_Boosting-and_Parity_Learning.pdf. This paper explicitly distinguishes the older $\operatorname{opt}+\beta$ weak learner from its $(\alpha,\gamma)$ weak learner. Its theorem boosts an $(\alpha,\gamma)$ weak learner only to $\operatorname{opt}+\alpha+\varepsilon$, and notes one should not expect error below $\operatorname{opt}+\alpha$ from that oracle because the guarantee is vacuous when $\operatorname{opt}>1/2-\alpha$.
- Feldman, "Distribution-Specific Agnostic Boosting" (ICS 2010 / arXiv 0909.2927): https://arxiv.org/abs/0909.2927 and PDF https://www.cs.cmu.edu/~odonnell/hits09/feldman-agnostic-boosting.pdf. This is the key near miss: Feldman gives a distribution-specific booster that does not modify the marginal over instances, only the label distribution. The theorem boosts an $(\alpha,\gamma)$ distribution-specific weak agnostic learner over a fixed marginal $D$ to $\alpha$-optimal agnostic learning over the same $D$. The same paper states that a $\beta$-optimal agnostic learner is an $(\beta+\gamma_0,\gamma_0/2)$ weak learner, giving the older-style bound roughly $\Delta/(1-2\beta)+\varepsilon$ in the distribution-independent reweighting formulation, and cites Gavinsky optimality.
- Ghai and Singh, "Sample-Optimal Agnostic Boosting with Unlabeled Data" (ICML 2025): https://proceedings.mlr.press/v267/ghai25a.html. Checked for recent sample-complexity improvements and distribution-specific/unlabeled-data relevance. The abstract improves sample usage for agnostic boosting but does not appear to replace the atlas source's fixed-additive $\operatorname{opt}+\beta$ guarantee by a full $\operatorname{opt}+\varepsilon$ theorem.
- da Cunha, Hogsgaard, Paudice, "Sample-Near-Optimal Agnostic Boosting with Improved Running Time" (ALT 2026 / arXiv 2601.11265): https://arxiv.org/abs/2601.11265. Checked because the edge already cites it. The abstract gives near-optimal sample complexity and improved runtime for agnostic boosting, but this is still an agnostic boosting framework rather than a direct theorem from the atlas fixed-additive weak node with marginal-dependent runtime bookkeeping.
- Hanneke, Moran, Thiessen, "Marginal-Nonuniform PAC Learnability" (NeurIPS 2025): https://openreview.net/forum?id=aoVCFtox89. Checked for marginal-nonuniform conventions. The paper studies rates whose constants depend on the instance marginal and gives a trichotomy for sample rates; it does not by itself provide a computational boosting theorem for the atlas fixed-additive weak source.

### Theorem / Counterexample Attempts

1. **Try to prove the edge by ordinary agnostic boosting.**

   This stalls for the reason recorded in the edge note: standard boosting invokes the weak learner on reweighted distributions over instances. A marginal-nonuniform source supplies a polynomial $p_Q$ for each induced marginal $Q$, but the target needs one polynomial depending only on the original marginal $P$ and $1/\varepsilon$. Without a uniform upper bound on the finitely many $p_Q$ values generated by the booster as a function of $P$ and $\varepsilon$, this does not fit the target definition.

2. **Try to remove the marginal obstruction using Feldman distribution-specific boosting.**

   Feldman's label-only booster is a real near proof. If the source were an $(\alpha,\gamma)$ weak agnostic learner for every sufficiently small $\alpha$, with $\gamma^{-1}$ bounded by a marginal-dependent polynomial in $s$ and $1/\alpha$, then the booster would preserve the original instance marginal $P$ at every weak-learner call. In that strengthened model, the marginal-dependent runtime bookkeeping would plausibly close: all weak calls remain under $P$, and the number of calls is polynomial in $1/\gamma$ and $1/\varepsilon$.

   But the atlas source is weaker/different. A fixed-additive $\beta_P(s)$ learner implies an $(\alpha,\gamma)$ learner only when $\alpha>\beta_P(s)$: if $\operatorname{opt}\le 1/2-\alpha$, then
   $$
   \operatorname{err}(h)\le \operatorname{opt}+\beta_P(s)
   \le 1/2-(\alpha-\beta_P(s)).
   $$
   Thus one may take $\gamma=\alpha-\beta_P(s)$, but only for $\alpha$ bounded away from $\beta_P(s)$. Feldman's theorem would then give at best $\operatorname{opt}+\beta_P(s)+\varepsilon$-type accuracy from the label-only route, not arbitrary $\operatorname{opt}+\varepsilon$.

3. **Try to use Ben-David/Gavinsky/Feldman beta-optimal boosting.**

   For a $\beta$-optimal weak agnostic learner, the primary-source guarantees are non-strong. Ben-David--Long--Mansour and Gavinsky improve the weak learner but do not reach $\operatorname{opt}+\varepsilon$ for fixed $\beta$. Feldman's comparison section makes the obstruction concrete: a $\beta$-optimal learner gives a threshold weak learner with $\alpha\approx\beta$, and the distribution-independent boosted guarantee is about
   $$
   \frac{\Delta}{1-2\beta}+\varepsilon,
   $$
   with Gavinsky optimality cited. This is not the atlas target, especially when $\Delta$ is not tiny.

4. **Try to find a conditional false witness.**

   Existing atlas witnesses do not immediately fit. Halfspaces and conjunctions separate realizable or proper sources from agnostic targets, but this edge's source is already weak agnostic improper. Hardness results for weak agnostic learning of halfspaces/monomials point in the opposite direction: they threaten the source, not just the target. I did not find a primary-source class that is known to satisfy the exact atlas marginal-nonuniform fixed-additive weak agnostic improper source while failing the strong marginal-nonuniform agnostic improper target.

### Precise Obstruction

The marginal obstruction is partially defused by Feldman: there exists a distribution-specific agnostic booster that preserves the instance marginal by modifying only labels. Therefore, the broad statement "boosting necessarily changes the marginal" is too coarse for agnostic boosting.

However, Feldman solves the marginal issue for a stronger quantitative weak-agnostic oracle. The atlas source only promises one fixed additive tolerance $\beta_P(s)<1/2$ and does not allow the learner to be asked for arbitrarily small $\alpha$. The known conversion from fixed-additive $\beta$ to $(\alpha,\gamma)$ weak learning has the unavoidable relation $\alpha>\beta$. Consequently, the label-preserving booster cannot drive the final excess below roughly $\beta_P(s)$ from this source alone.

I do not see a valid atlas-status resolution:

- Not `resolved true`: the available theorems require a stronger weak learner or give a weaker final guarantee.
- Not `resolved false`: I found no concrete class/assumption proving source without target.

### Final Verdict

`unresolved`.

The best depth-0 conclusion is that Feldman's distribution-specific booster is an important near miss and may resolve the marginal bookkeeping for a strengthened edge, but it does not resolve the actual atlas edge because the atlas source is fixed-additive $\beta$-weak agnostic learning.

### Follow-Up Directions

- Check whether the atlas intends $\beta_P(s)$ to be tunable by passing an enlarged accuracy/size parameter to the weak learner. If yes, the source definition should say so explicitly; if no, the obstruction above remains.
- Consider adding a separate edge family/note for "threshold/correlation weak agnostic boosting under marginal-nonuniform distributions" where Feldman's theorem may give a true theorem edge.
- Search for representation-sensitive conditional separations: a class with efficient fixed-additive weak agnostic improper learning but computationally hard strong agnostic improper learning, preferably under a fixed marginal so that the separation survives marginal-nonuniform relaxation.
- If future work updates the atlas source to a correlation-style weak agnostic learner, revisit Ghai--Singh 2025 and da Cunha--Hogsgaard--Paudice 2026 for sample/runtime bounds, and use Feldman's label-only distribution-specific construction to handle the marginal-dependent polynomial bookkeeping.

## Depth-1 Entry - 2026-05-04

### Question

Can Feldman's distribution-specific agnostic boosting theorem resolve the atlas edge

`efficient-marginal-nonuniform-weak-agnostic-improper-pac -> efficient-marginal-nonuniform-agnostic-improper-pac`

once we notice that Feldman's booster keeps the instance marginal fixed?

### Sources Checked

- Vitaly Feldman, "Distribution-Specific Agnostic Boosting" (ICS 2010; arXiv:0909.2927): https://arxiv.org/abs/0909.2927 and author's PDF https://vtaly.net/papers/F_AgnosticBoosting_111609.pdf.
- Atlas source definition: `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`.
- Atlas target definition: `atlas/definitions/efficient-marginal-nonuniform-agnostic-improper-pac.md`.
- Atlas edge note: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac.md`.
- Related atlas argument: `atlas/arguments/agnostic-boosting-open.md`.
- Ghai and Singh, "Sample-Optimal Agnostic Boosting with Unlabeled Data" (ICML 2025): https://proceedings.mlr.press/v267/ghai25a.html, checked only to confirm that recent distribution-specific/unlabeled agnostic boosting still uses correlation-style weak learner assumptions rather than the atlas fixed-additive source.
- da Cunha, Hogsgaard, Paudice, "Sample-Near-Optimal Agnostic Boosting with Improved Running Time" (ALT 2026; arXiv:2601.11265): https://arxiv.org/abs/2601.11265, checked only as later agnostic-boosting context already cited by the edge.

### Lead 1: Feldman's Theorem And The Marginal

Feldman's Theorem 1.1 / Theorem 3.4 says that for every concept class $\mathcal C$ and fixed distribution $D$ over instances, an $(\alpha,\gamma)$-weak agnostic learner for $\mathcal C$ over $D$ can be boosted to an $\alpha$-optimal agnostic learner over the same $D$. The booster makes $O(\gamma^{-2})$ weak-learner calls and runs in time $T\cdot \operatorname{poly}(1/\gamma,1/\varepsilon)$, where $T$ is the weak learner's running time.

The theorem's weak learner is not the Ben-David--Long--Mansour fixed-additive $\operatorname{OPT}+\beta$ oracle. Feldman uses the Kalai--Mansour--Verbin threshold notion:

$$
\operatorname{err}(h)\le 1/2-\gamma
\quad\text{whenever}\quad
\operatorname{OPT}_{\mathcal C}\le 1/2-\alpha .
$$

Equivalently, in correlation notation, the weak learner must recover nontrivial correlation whenever the best concept has advantage at least $\alpha$ over random guessing. Feldman also describes a general weak agnostic learner as one that recovers at least an inverse-polynomial fraction of the best advantage over random guessing.

The marginal bookkeeping is genuinely favorable. Feldman's introduction and proof state that the booster does not modify the marginal distribution over the domain; it modifies the label distribution or target function. In the proof of Theorem 3.1, the weak learner is run on distributions

$$
A_i=(D,(\phi-h_i)/2),
$$

so the instance marginal remains exactly $D$. Theorem 3.4 uses the clipped variant $P_1(f-h_i)$, again changing labels/conditional expectations rather than reweighting examples. Thus, if the atlas source were replaced by a Feldman/KMV threshold weak learner for each fixed marginal $P$, the usual marginal-nonuniform obstruction would disappear: all oracle calls would be controlled by the single polynomial attached to $P$.

### Lead 2: Can The Atlas Source Be Upgraded To Feldman's Oracle?

Only partially. Fix a marginal $P$ and write the atlas weak tolerance as $\beta_P(s)$. The source gives, for every joint distribution with marginal $P$,

$$
\operatorname{err}(h)\le \operatorname{OPT}_{\mathcal C}+\beta_P(s).
$$

Suppose a Feldman/KMV call asks for an $(\alpha,\gamma)$ threshold guarantee. If

$$
\operatorname{OPT}_{\mathcal C}\le 1/2-\alpha,
$$

then the atlas learner returns

$$
\operatorname{err}(h)\le 1/2-\alpha+\beta_P(s).
$$

So the atlas learner is an $(\alpha,\alpha-\beta_P(s))$ weak agnostic learner only when $\alpha>\beta_P(s)$. This is enough to invoke Feldman at thresholds bounded away from $\beta_P(s)$, but Feldman's final guarantee is $\operatorname{OPT}+\alpha+\varepsilon$ in the usual PAC accuracy notation. To get the atlas strong target for an arbitrary requested $\varepsilon$, one would need to run with $\alpha\lesssim\varepsilon$. For $\varepsilon\le \beta_P(s)$, the conversion gives no positive $\gamma$.

This is not just a proof artifact. Feldman's comparison with distribution-independent boosting explicitly notes that a $\beta$-optimal agnostic learner is an $(\beta+\gamma_0,\gamma_0/2)$ weak agnostic learner, and then the boosted distribution-independent guarantee has the older fixed-additive shape

$$
\frac{\Delta}{1-2\beta}+\varepsilon
$$

with Gavinsky optimality cited. That comparison is exactly the quantitative obstruction here: a fixed $\operatorname{OPT}+\beta$ oracle converts to threshold weak learning only above the threshold $\alpha=\beta$, not all the way down to arbitrary $\alpha$.

### Lead 3: Is $\beta_P(s)$ Tunable In The Current Atlas Definition?

Under the current wording, no. The marginal weak source says: for every marginal $P$, there are a polynomial $p_P$ and an additive weak-agnostic tolerance $\beta_P(s)<1/2$ whose gap from $1/2$ is inverse-polynomial in $s$. The learner's sample complexity and running time are bounded by $p_P(s,\log(1/\delta))$; there is no accuracy input $\varepsilon$, no threshold input $\alpha$, and no statement that the learner can be asked to reduce $\beta_P(s)$.

The same definition also says the polynomial may not depend on $\varepsilon$. That sentence is slightly vestigial for a weak node, but it reinforces the intended reading: unlike the strong target, the weak source has no requested excess-error parameter. Nearby distribution-free weak agnostic definitions mention parameterized $\beta$ explicitly when allowed; this marginal-nonuniform definition does not.

Therefore $\beta_P(s)$ should be treated as fixed by the existence proof for the weak source, not tunable by the boosting reduction. The existential quantifier allows a class to have a better weak learner than the one witnessed, but the node does not assert a family of weak learners for every desired $\beta$ or every desired threshold $\alpha$.

### Provisional Positive Theorem For A Strengthened Node

A nearby true statement looks plausible and source-grounded:

If there is one uniform learner such that, for every marginal $P$, every threshold $\alpha>0$, and every joint distribution with marginal $P$, whenever $\operatorname{OPT}_{\mathcal C}\le 1/2-\alpha$ the learner returns $h$ with error at most $1/2-\gamma_P(s,\alpha)$ in time polynomial in a marginal-dependent bound for $1/\gamma_P(s,\alpha)$, then Feldman's ABoost gives efficient marginal-nonuniform agnostic improper PAC learning.

The proof would call the threshold weak learner only on relabeled distributions with the same instance marginal $P$, choose $\alpha=\Theta(\varepsilon)$, set per-call confidence by a union bound over $O(\gamma^{-2})$ calls, and output the boosted improper real-valued/sign hypothesis. This would be a theorem edge for a new "threshold/correlation weak agnostic" source, not for the current fixed-additive source.

### Final Verdict

`unresolved`.

The edge is not resolved true: Feldman preserves the marginal, but his theorem requires a threshold/correlation weak agnostic learner available at the desired final scale $\alpha\approx\varepsilon$. The atlas source only gives a fixed additive $\operatorname{OPT}+\beta_P(s)$ guarantee, which converts to Feldman's oracle only for $\alpha>\beta_P(s)$ and therefore cannot drive excess error below $\beta_P(s)$.

The edge is not resolved false: I still do not have a concrete class or conditional assumption showing efficient marginal-nonuniform fixed-additive weak agnostic improper learning while ruling out efficient marginal-nonuniform strong agnostic improper learning.

### Concrete Next Directions

1. Add a separate atlas definition for marginal-nonuniform threshold/correlation weak agnostic learning and a theorem edge to the strong marginal-nonuniform agnostic improper node, citing Feldman. This would capture the positive result without changing the meaning of the existing fixed-additive node.
2. If the intended atlas semantics were actually "for every requested weak tolerance" rather than fixed $\beta_P(s)$, revise the definition explicitly to include an input such as $\alpha$ or $\beta$ and a polynomial dependence on its inverse advantage. Under that revised definition, Feldman's theorem should be enough for a `resolved true` edge.
3. For a `resolved false` route under the current definition, search for approximation-separation examples: classes where obtaining any fixed inverse-polynomial advantage over random guessing relative to $\operatorname{OPT}$ is efficient under each marginal, but obtaining arbitrary excess $\varepsilon$ is computationally hard under some fixed marginal. This should be pursued in approximation-hardness/SQ-hardness terms, not by halfspace agnostic hardness alone, since halfspace hardness usually threatens the weak source too.
4. Check whether the atlas wants to add `feldman2010distributionspecific` to `references.bib` before any future atlas note cites this theorem directly. The scratchpad can cite the URL directly, but a schema-level edge update should use a stable BibTeX key.

## Depth-2 Entry - 2026-05-04

### Question

Can this near miss be made into a clean atlas addition by separating the Feldman/KMV threshold-or-correlation weak agnostic notion from the existing fixed-additive weak agnostic node? And, after that separation, is there any last way for the current fixed-additive node to imply the Feldman theorem when $\beta_P(s)$ is fixed?

### Proposed Atlas Addition

Add a new definition node, tentatively:

`efficient-marginal-nonuniform-threshold-weak-agnostic-improper-pac`

or, if the atlas prefers the correlation phrasing:

`efficient-marginal-nonuniform-correlation-weak-agnostic-improper-pac`.

The threshold version should be explicitly parameterized by a target threshold. A workable definition:

For one uniform learner $A$, for every instance marginal $P$ there are marginal-dependent polynomials $p_P$ and $q_P$ such that for every threshold parameter $\alpha\in(0,1/2)$, every confidence $\delta\in(0,1)$, and every joint distribution $\mathcal D$ with marginal $P$, if

$$
\operatorname{OPT}_{\mathcal C}(\mathcal D)
=\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)
\le 1/2-\alpha,
$$

then $A$, run on samples from $\mathcal D$ and parameters $\alpha,\delta$, outputs an improper hypothesis $h$ with probability at least $1-\delta$ such that

$$
\operatorname{err}_{\mathcal D}(h)
\le 1/2-\gamma_P(s,\alpha),
$$

where $\gamma_P(s,\alpha)\ge 1/q_P(s,1/\alpha)$, and the sample complexity and running time are at most

$$
p_P(s,1/\alpha,\log(1/\delta)).
$$

This is deliberately not the same as the current fixed-additive condition

$$
\operatorname{err}(h)\le \operatorname{OPT}_{\mathcal C}+\beta_P(s).
$$

The new node asks for weak recovery at every requested threshold scale $\alpha$, with inverse-polynomial advantage at that same scale. That is the shape Feldman's theorem can use.

A correlation-form version may be more faithful to Feldman's presentation. It would say, roughly, that if the best concept has advantage $\Delta$ over random guessing under marginal $P$, then the learner returns an improper hypothesis with advantage at least an inverse-polynomial function of $(s,1/\Delta)$. This avoids a separate threshold promise and packages the weak learner as "recover nontrivial correlation whenever nontrivial concept correlation exists." Either version should include the key atlas bookkeeping requirement: the polynomial may depend on the original marginal $P$, but the learner is still one uniform algorithm and the weak calls are controlled by the same $P$.

### Proposed Theorem Edge

Add a theorem edge:

`efficient-marginal-nonuniform-threshold-weak-agnostic-improper-pac -> efficient-marginal-nonuniform-agnostic-improper-pac`

Suggested metadata:

- `status: "true"`
- `evidence: theorem`
- `ref_keys: [feldman2010distributionspecific]` after adding a stable BibTeX entry.
- `summary: "Feldman's distribution-specific agnostic boosting preserves the instance marginal and boosts threshold/correlation weak agnostic learning to arbitrary excess error."`
- `family`: perhaps a new `distribution-specific-agnostic-boosting` family, rather than the current `agnostic-boosting-open` family.

Proof sketch for the edge:

Fix a marginal $P$ and a target joint distribution $\mathcal D$ with marginal $P$. Given requested excess error $\varepsilon$, run Feldman's distribution-specific booster with threshold parameter $\alpha=\Theta(\varepsilon)$. At every stage, the booster changes the conditional label distribution or target function but keeps the instance marginal equal to $P$. Therefore all weak-learner calls are governed by the same marginal-dependent polynomials $p_P,q_P$.

The threshold weak source supplies advantage

$$
\gamma_P(s,\alpha)\ge 1/q_P(s,1/\alpha).
$$

Feldman's booster uses polynomially many weak calls in $1/\gamma_P(s,\alpha)$ and $1/\varepsilon$, with per-call confidence chosen by a union bound. Since $1/\gamma_P(s,\alpha)$ is bounded by a marginal-dependent polynomial in $s$ and $1/\varepsilon$, the final sample and running-time bound is still some polynomial

$$
r_P(s,1/\varepsilon,\log(1/\delta)).
$$

The output is an improper boosted hypothesis with

$$
\operatorname{err}_{\mathcal D}(h)
\le \operatorname{OPT}_{\mathcal C}(\mathcal D)+\varepsilon.
$$

So this strengthened source should give a clean `true/theorem` atlas edge. The marginal-nonuniform feature is not an obstacle here; Feldman's label-only/distribution-specific construction is exactly the mechanism that keeps the polynomial attached to the original $P$.

### Last Test: Can The Existing Fixed-Additive Node Prove This Anyway?

No, not as currently written.

Fix $P$ and let the current node's weak tolerance be $\beta_P(s)<1/2$. If a Feldman/KMV threshold call has parameter $\alpha$, the fixed-additive learner only gives

$$
\operatorname{err}(h)
\le \operatorname{OPT}_{\mathcal C}+\beta_P(s).
$$

Under the threshold promise $\operatorname{OPT}_{\mathcal C}\le 1/2-\alpha$, this implies

$$
\operatorname{err}(h)\le 1/2-(\alpha-\beta_P(s)).
$$

Thus the existing learner acts as an $(\alpha,\gamma)$ threshold weak learner only with

$$
\gamma=\alpha-\beta_P(s)>0.
$$

For final accuracy $\varepsilon$, Feldman's route needs $\alpha=\Theta(\varepsilon)$ or at least $\alpha$ on the same scale as the desired final excess. If $\varepsilon\le \beta_P(s)$, the conversion gives no positive advantage. Choosing $\alpha>\beta_P(s)$ yields, at best, a boosted guarantee with excess on the order of $\beta_P(s)$, not arbitrary $\varepsilon$.

This remains true even though $\beta_P(s)$ may be inverse-polynomially bounded away from $1/2$. The problem is not that the weak learner lacks some advantage over random guessing; it is that the additive slack is fixed and does not shrink with the requested strong accuracy. The target node quantifies over every $\varepsilon>0$, while the source has no input that lets the booster request $\beta_P(s)\le O(\varepsilon)$.

The only ways out would change the source semantics:

- If $\beta_P$ were parameterized, e.g. the learner accepted a weak accuracy or threshold input and could make $\beta_P(s,\alpha)<\alpha$ with polynomial dependence on $1/(\alpha-\beta_P)$, then the Feldman theorem edge would apply.
- If the representation size parameter $s$ could be artificially inflated by the reduction to make $\beta_P(s)$ smaller, the node would need to state that such padding is allowed and that $\beta_P$ is monotone or controllable under padding. The current definition does not say this, and the learner's guarantee is tied to the actual class-size parameter, not a booster-chosen accuracy knob.
- If an independent theorem showed that every fixed-additive weak agnostic improper learner can be converted into a threshold/correlation weak learner at all scales under the same marginal $P$, that would settle the issue. I found no such theorem, and the quantitative conversion above is exactly where it fails.

### Verdict For The Existing Edge

`unresolved`.

The edge is still not resolved true: Feldman proves the right kind of theorem for a threshold/correlation weak agnostic marginal-nonuniform node, but the current source is a fixed-additive $\operatorname{OPT}+\beta_P(s)$ node with no tunable $\alpha$ or $\varepsilon$ parameter.

The edge is still not resolved false: this investigation did not produce a concrete class or conditional assumption satisfying the existing fixed-additive marginal-nonuniform weak agnostic improper source while failing the strong marginal-nonuniform agnostic improper target.

### Concrete Atlas-Note Update Suggestion

Do not mark the current edge true or false. Update its open note to say that the original "boosting may reweight the marginal" obstacle is incomplete: Feldman's distribution-specific agnostic booster avoids that obstacle by preserving the instance marginal. The remaining obstruction is quantitative: Feldman's theorem requires threshold/correlation weak agnostic access at the target scale, while the current atlas source provides only fixed additive excess $\beta_P(s)$.

Suggested replacement summary for the existing edge:

`Open: Feldman's distribution-specific agnostic boosting preserves the marginal for threshold/correlation weak learners, but the atlas source is only fixed-additive OPT+beta_P(s), which does not supply weak advantage at arbitrary final accuracy scales.`

Also add a forward pointer from the current edge to the proposed new theorem edge once that node exists:

`A strengthened threshold/correlation weak marginal-nonuniform source should imply this target by Feldman 2010; this edge asks whether the weaker fixed-additive source already suffices.`

## Depth-3 Entry - 2026-05-04

### Question

Can the edge be resolved `false` by an approximation, SQ, or cryptographic
example where fixed-additive weak agnostic learning is efficient under every
marginal, but strong agnostic learning is hard under one fixed marginal?

This pass deliberately looked for false witnesses and treated halfspace-style
results only as warnings, since the known halfspace hardness results usually
destroy the source by ruling out even weak prediction when the optimum is small.

### Candidate Shape Needed

A valid false witness must provide a class $\mathcal C$ and a uniform algorithm
$A$ such that:

1. For every instance marginal $P$, $A$ achieves
   $$
   \operatorname{err}(h)\le \operatorname{OPT}_{\mathcal C}+\beta_P(s)
   $$
   for some $\beta_P(s)<1/2$ in $P$-dependent polynomial time.
2. For some fixed marginal $P_0$, no efficient algorithm can achieve
   $\operatorname{OPT}_{\mathcal C}+\varepsilon$ for arbitrary
   $\varepsilon$ in time polynomial in $s,1/\varepsilon$.
3. The target is improper. The hard result must rule out every efficiently
   evaluable binary hypothesis, not just proper hypotheses from $\mathcal C$.

The third condition is the most common failure point for approximation-based
witnesses.

### Sources And Leads Checked

- Feldman, Guruswami, Raghavendra, and Wu, "Agnostic Learning of Monomials by
  Halfspaces Is Hard" / SIAM J. Comput. DOI page:
  https://doi.org/10.1137/120865094. This rules out weak agnostic learning of
  monomials even with halfspace outputs, so it is a source-killer rather than a
  source-positive witness.
- Daniely, Linial, and Shalev-Shwartz, "From average case complexity to
  improper learning complexity", arXiv:1311.2272:
  https://arxiv.org/abs/1311.2272. The abstract records hardness of improper
  learning and, in particular, constant-factor agnostic halfspace learning
  hardness under average-case assumptions. This again points toward weak-source
  failure, not a fixed-additive source-positive separation.
- Tiegel, "Hardness of Agnostically Learning Halfspaces from Worst-Case
  Lattice Problems", arXiv:2207.14030:
  https://arxiv.org/abs/2207.14030. The distribution-specific Gaussian lower
  bound is tempting because it is under a fixed marginal and has an
  $\varepsilon$-dependent runtime lower bound. But the same abstract-level
  result also states hardness of producing any binary hypothesis with error
  better than $1/2-\gamma$ even when the optimum is tiny. That kills the weak
  source at the relevant marginal, so it is not a witness for this edge.
- Diakonikolas, Kane, and Ren, "Near-Optimal Cryptographic Hardness of
  Agnostically Learning Halfspaces and ReLU Regression under Gaussian
  Marginals", arXiv:2302.06512:
  https://arxiv.org/abs/2302.06512. This is another fixed-Gaussian-marginal
  strong-hardness lead, but still for halfspaces/ReLU-style classes whose
  weak-source status is not supplied by the theorem and is contradicted by
  nearby weak-hardness results.
- Goel, Gollakota, and Klivans, "Statistical-Query Lower Bounds via Functional
  Gradients", NeurIPS 2020:
  https://papers.nips.cc/paper/2020/hash/17257e81a344982579af1ae6415a7b8c-Abstract.html.
  This gives SQ lower bounds for agnostic learning under Gaussian marginals,
  but it is SQ-only and for real-valued/non-polynomial activation settings; it
  does not by itself rule out arbitrary efficient improper binary learners or
  provide a marginal-universal fixed-additive source learner.
- Diakonikolas and Kane, "Statistical Query Lower Bounds for Smoothed Agnostic
  Learning", arXiv:2602.21191:
  https://arxiv.org/abs/2602.21191. This is a recent fixed-marginal SQ lower
  bound with explicit dependence on $\varepsilon$, but it is still SQ-only and
  halfspace-centered. It is useful evidence for strong hardness at small
  $\varepsilon$, not an atlas false witness.
- Bansal, Blum, and Chawla, "Correlation Clustering", Machine Learning 2004:
  https://link.springer.com/article/10.1023/B%3AMACH.0000033116.57574.95.
  This and follow-up correlation-clustering work supply signed-disagreement
  optimization problems with constant approximations and hardness/approximation
  structure.
- Demaine et al., "Correlation Clustering with Partial Information":
  https://erikdemaine.org/papers/Clustering_APPROX2003/paper.pdf. This is a
  useful partial-graph signed-disagreement source for no-PTAS style thinking,
  but the learning translation below runs into the improper-output issue.
- Håstad, "Some Optimal Inapproximability Results", JACM 2001:
  https://doi.org/10.1145/502090.502098, and Papadimitriou--Yannakakis
  Max-SNP/APX theory, DOI https://doi.org/10.1016/0022-0000(91)90023-X.
  These support the general constant-approximation-versus-PTAS template, but
  the template needs a signed agnostic learning realization.
- Malach and Shalev-Shwartz, "When Hardness of Approximation Meets Hardness of
  Learning", JMLR 2022: https://jmlr.org/papers/v23/20-940.html. This is
  conceptually relevant because it relates approximation and learning hardness,
  but it does not hand over the exact fixed-additive-source / improper-strong
  separation required here.

### Approximation Witness Attempt

The most promising false-witness template is:

- examples encode constraints or signed pairs;
- concepts encode structured assignments, cuts, clusterings, or codewords;
- there is a polynomial-time constant approximation to the empirical
  disagreement objective;
- a PTAS or additive-$\varepsilon$ approximation is hard.

There is a simple way a constant-factor approximation would imply the atlas
fixed-additive source. Suppose an empirical optimization problem has normalized
loss in $[0,1]$, a trivial hypothesis with loss at most $1/2$, and an
$\alpha$-approximation to the optimum loss. Returning the better of the trivial
hypothesis and the $\alpha$-approximate structured solution gives loss at most

$$
\min\{\alpha\operatorname{OPT},1/2\}.
$$

The additive excess over $\operatorname{OPT}$ is bounded by

$$
\max_{u\in[0,1/2]}\min\{(\alpha-1)u,1/2-u\}
=\frac12\left(1-\frac1\alpha\right)<\frac12.
$$

So a constant-factor approximation plus a $1/2$ baseline has exactly the right
numerical flavor for fixed-additive weak agnostic learning.

However, the natural translations do not yet work.

**Max-CSP / PCP encodings.** If examples are constraints and hypotheses are
assignments, arbitrary PAC labels become signed or complemented constraints.
For predicates such as 3-SAT clauses or 3-XOR equations, the known PCP
hardness often says that even when the instance is nearly satisfiable, finding
an assignment beating the random baseline by a fixed constant is hard. That
rules out the source: when $\operatorname{OPT}$ is tiny, the atlas weak learner
must output error below $1/2$ by an inverse-polynomial margin. This is precisely
the forbidden weak-learning task.

**Signed/disagreement problems.** Correlation clustering and related
min-disagreement objectives are better matched to arbitrary labels, because the
input is already signed. Constant-factor approximation for min-disagreement
combined with the calculation above could plausibly give an
$\operatorname{OPT}+\beta$ weak learner. The obstacle is the improper target.
If the learning domain is the set of edges or constraints on $n$ items, then
the domain usually has polynomial size, e.g. $O(n^2)$ for pairs or $n^k$ for
fixed-arity constraints. An improper agnostic learner can ignore the structured
class and estimate the conditional majority label on each domain point using
polynomially many samples. That gives $\operatorname{OPT}_{\text{all
functions}}+\varepsilon\le \operatorname{OPT}_{\mathcal C}+\varepsilon$ in
polynomial time. Thus the proper optimization problem may be APX-hard, but the
atlas improper strong learner is easy.

**Nearest-codeword / coding encodings.** A code class over an exponentially
large coordinate domain would avoid the polynomial-domain memorization problem.
This is the right kind of object in principle: fixed-additive weak learning is
approximate nearest-codeword decoding, and strong agnostic learning is
near-exact nearest-codeword decoding. I did not find a primary-source code
family satisfying the needed combination: efficient additive-$\beta<1/2$
decoding for every coordinate marginal, but computational hardness of
additive-$\varepsilon$ decoding under one fixed coordinate marginal, with
improper binary outputs ruled out. Standard parity/Hadamard-style examples lead
back to LPN or agnostic parity, where even weak agnostic learning is believed
hard.

### SQ Witness Attempt

Fixed-marginal SQ lower bounds initially look attractive: they often say that
for a known marginal such as Gaussian, achieving
$\operatorname{OPT}+\varepsilon$ needs complexity super-polynomial in
$s,1/\varepsilon$, while constant-accuracy algorithms may exist.

But an SQ lower bound is not an atlas false witness unless the atlas target is
restricted to SQ algorithms. The target permits arbitrary efficient improper
learners. Moreover, the examples I found are mostly halfspace, PTF, ReLU, or
activation-learning results. They either:

- are not binary zero-one PAC classification statements in the atlas sense;
- only rule out SQ algorithms rather than all efficient algorithms;
- or are for classes where distribution-free/marginal-universal fixed-additive
  weak agnostic learning is not known and is often contradicted by stronger
  weak-hardness results.

So the SQ route gives useful evidence for a possible small-$\varepsilon$
barrier under fixed marginals, but it does not resolve the atlas edge as false.

### Cryptographic Witness Attempt

Cryptographic hard classes have the opposite problem: they are usually too
hard. PRF classes and LPN/parity-style classes separate sample efficiency from
computational learning, but if realizable labels are pseudorandom then any
weak learner with error $<1/2-\gamma$ distinguishes the pseudorandom labels
from random labels. Thus the source fails, even before asking for agnostic
$\operatorname{OPT}+\varepsilon$ accuracy.

The fixed-Gaussian LWE/lattice halfspace results are also not usable here.
Their distribution-specific part is exactly the kind of fixed-marginal strong
hardness one would like, but the results are designed to rule out very weak
improper prediction when the optimum is small. That contradicts the source at
the hard marginal rather than separating source from target.

### Current Best Obstacle

The false-witness search keeps running into a trilemma:

1. **Hardness strong enough for improper learning usually kills the source.**
   If a result rules out every binary hypothesis beating $1/2$ when
   $\operatorname{OPT}$ is small, then fixed-additive weak agnostic learning is
   impossible at that marginal.
2. **Approximation problems with easy constant approximations are often proper
   optimization problems.** They may separate proper ERM from proper PTAS, but
   the atlas target is improper.
3. **Polynomial constraint domains make improper strong learning trivial.** In
   CSP, signed-edge, and bounded-arity disagreement encodings, the domain size
   is typically polynomial in the representation size, so an improper learner
   can estimate labels pointwise and beat the structured optimum.

The only remaining plausible false-witness direction I see is a coding-style
or exponentially-large-domain signed optimization problem with:

- an efficient uniform additive-$\beta<1/2$ agnostic decoder for every marginal;
- a fixed marginal under which additive-$\varepsilon$ decoding is hard for
  arbitrary binary outputs;
- and no polynomial-domain pointwise-estimation escape.

I did not find such a witness in this pass.

### Verdict

`unresolved`.

No resolved false witness was found. The approximation/SQ/cryptographic search
does sharpen the obstacle: a successful separation must be source-positive
under every marginal and target-hard for improper hypotheses under one marginal.
Known cryptographic and halfspace-style results are target-hard but
source-negative; standard CSP and signed-disagreement approximation examples
are source-plausible only in proper form, while the improper strong target is
easy when the constraint domain is polynomially sized.

Thus the current edge should remain open rather than be marked true or false.

## Depth-4 Entry - 2026-05-04

### Final Question

Should the atlas edge

`efficient-marginal-nonuniform-weak-agnostic-improper-pac -> efficient-marginal-nonuniform-agnostic-improper-pac`

be resolved true or false after accounting for Feldman's distribution-specific
agnostic boosting theorem, or should it remain open with a sharper explanation?

### Final Verdict

`unresolved`.

The edge should remain open. The positive theorem that is now clear is for a
stronger alternate source node, not for the current fixed-additive source. The
negative theorem needed for a false edge is also still missing.

### Atlas-Ready Summary

Open. Feldman's distribution-specific agnostic boosting theorem removes the
main marginal-bookkeeping worry for threshold/correlation weak agnostic
learners: the booster changes the conditional label distribution but preserves
the instance marginal. Therefore, a marginal-nonuniform
threshold/correlation weak agnostic improper learner available at every
threshold scale should imply efficient marginal-nonuniform agnostic improper
PAC learning.

This does not resolve the present edge because the source node is
fixed-additive weak agnostic learning. For each marginal $P$, it supplies a
single tolerance $\beta_P(s)<1/2$ and guarantees

$$
\operatorname{err}(h)\le \operatorname{OPT}_{\mathcal C}+\beta_P(s).
$$

Feldman/Kalai-Mansour-Verbin style weak agnostic boosting instead needs a
threshold or correlation oracle at the requested final scale: roughly, whenever
$\operatorname{OPT}_{\mathcal C}\le 1/2-\alpha$, the weak learner must return a
hypothesis with error at most $1/2-\gamma$ for inverse-polynomial
$\gamma=\gamma_P(s,\alpha)>0$. A fixed-additive $\beta_P(s)$ learner only gives
such an oracle when $\alpha>\beta_P(s)$, with
$\gamma\le \alpha-\beta_P(s)$. Thus it cannot be used to drive the final excess
error below the fixed tolerance $\beta_P(s)$.

The false direction is not established either. A valid witness would need a
class that is efficiently marginal-nonuniform fixed-additive weak agnostically
learnable by improper hypotheses for every marginal, while strong
marginal-nonuniform agnostic improper learning is computationally impossible
under some fixed marginal. The known hard-learning candidates do not currently
fit this shape. Halfspace, monomial, parity/LPN, PRF, and lattice/Gaussian
hardness results tend to rule out even weak improper prediction when the
optimum is small, so they kill the source rather than separate it from the
target. Approximation-style CSP, clustering, or signed-disagreement examples
can suggest fixed-additive proper approximations, but polynomial-sized domains
allow an improper learner to estimate labels pointwise, making the strong
improper target too easy. SQ lower bounds are likewise insufficient for this
atlas edge because the target is not SQ-restricted.

### Stronger Alternate Node

A separate theorem edge should be considered for a new source such as

`efficient-marginal-nonuniform-threshold-weak-agnostic-improper-pac`

or

`efficient-marginal-nonuniform-correlation-weak-agnostic-improper-pac`.

The source should include an input threshold $\alpha$ and require an
inverse-polynomial weak advantage $\gamma_P(s,\alpha)$ whenever
$\operatorname{OPT}_{\mathcal C}\le 1/2-\alpha$. Under that stronger
definition, Feldman 2010 gives the theorem route:

1. Fix a marginal $P$.
2. Run Feldman's distribution-specific booster at threshold
   $\alpha=\Theta(\varepsilon)$.
3. Each weak-learner call is on a relabeled distribution with the same instance
   marginal $P$.
4. The marginal-dependent polynomial for $P$, together with the polynomial
   dependence on $1/\gamma_P(s,\alpha)$, controls all calls.
5. The boosted improper hypothesis achieves
   $\operatorname{OPT}_{\mathcal C}+\varepsilon$.

That theorem would cite Feldman 2010 as the primary source and would clarify
that the old "boosting changes the marginal" objection is not the decisive
objection for distribution-specific agnostic boosting. The decisive objection
for the current edge is the quantitative gap between fixed-additive
$\operatorname{OPT}+\beta$ weak agnostic learning and threshold/correlation
weak agnostic learning at arbitrary accuracy scales.

### Suggested Current Edge Status

Keep:

- `status: "open"`
- `evidence: unknown`

Suggested summary:

`Open: Feldman 2010 gives marginal-preserving agnostic boosting for a stronger threshold/correlation weak agnostic source, but the current fixed-additive OPT+beta_P(s) source does not provide weak advantage at arbitrary final accuracy scales; no false witness is known.`

Suggested body sentence:

`The obstruction is quantitative rather than merely marginal: fixed-additive weak agnostic learning converts to a Feldman/KMV threshold oracle only for thresholds alpha above beta_P(s), so it cannot by itself yield OPT+epsilon for epsilon below beta_P(s).`

## Depth-5 Entry - 2026-05-05

### Verdict

`unresolved`.

The edge should still remain `open` / `evidence: unknown`. The strongest new theorem route is not Feldman's threshold version alone, but the newer correlation-weak agnostic boosting line: a fixed-additive learner

$$
\operatorname{err}(h)\le \operatorname{OPT}_{\mathcal C}+\beta_P(s)
$$

implies, in $\{\pm 1\}$ notation,

$$
\operatorname{corr}(h)\ge \sup_{c\in\mathcal C}\operatorname{corr}(c)-2\beta_P(s).
$$

Thus it is a nontrivial correlation weak learner with parameters $\gamma_0=1$ and $\varepsilon_0=2\beta_P(s)$ whenever $\beta_P(s)<1/2$. Recent statistical agnostic boosting theorems are therefore closer to the actual atlas source than the earlier Feldman-only analysis suggested.

However, I still do not see an atlas-valid computational theorem. The newest efficient-running-time route I checked enumerates weak-learner samples and has running time polynomial in the final sample size only when weak-learner parameters are treated as fixed. In the atlas edge, the weak learner's sample size and runtime may be marginal-dependent polynomials in the representation size $s$, and the target requires one marginal-dependent polynomial in $(s,1/\varepsilon,\log(1/\delta))$. An exponent depending on the weak learner sample size, e.g. $n^{m_0+O(1)}$, is not such a polynomial when $m_0$ may grow polynomially with $s$.

### Definitions Used

- Source: `efficient-marginal-nonuniform-weak-agnostic-improper-pac`. One uniform learner works for all joint distributions. For each instance marginal $P$, there are a marginal-dependent polynomial $p_P$ and a fixed additive weak tolerance $\beta_P(s)<1/2$, with inverse-polynomial gap $1/2-\beta_P(s)$, such that every joint distribution with marginal $P$ is learned to $\operatorname{OPT}_{\mathcal C}+\beta_P(s)$ in sample/time $p_P(s,\log(1/\delta))$. No accuracy parameter is available.
- Target: `efficient-marginal-nonuniform-agnostic-improper-pac`. For each marginal $P$, the same kind of uniform learner must achieve $\operatorname{OPT}_{\mathcal C}+\varepsilon$ for every $\varepsilon,\delta$, with sample/time bounded by one marginal-dependent polynomial $p_P(s,1/\varepsilon,\log(1/\delta))$.
- Conversion used in this pass: with labels in $\{\pm 1\}$, $\operatorname{corr}(h)=1-2\operatorname{err}(h)$ and $\sup_{c\in\mathcal C}\operatorname{corr}(c)=1-2\operatorname{OPT}_{\mathcal C}$. Hence fixed-additive $\operatorname{OPT}+\beta_P(s)$ implies correlation at least best-correlation minus $2\beta_P(s)$.

### Sources Checked

- Atlas files read:
  - `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
  - `atlas/definitions/efficient-marginal-nonuniform-agnostic-improper-pac.md`
  - `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac.md`
  - `atlas/arguments/agnostic-boosting-open.md`
  - `atlas/arguments/marginal-boosting-open.md`
  - `references.bib`
- Ben-David, Long, Mansour, "Agnostic Boosting" (COLT/EuroCOLT 2001), DOI / abstract page: https://doi.org/10.1007/3-540-44581-1_33 and https://cris.tau.ac.il/en/publications/agnostic-boosting/. This confirms the original $\beta$-weak agnostic definition and its weaker-than-strong boosted guarantee.
- Feldman, "Distribution-Specific Agnostic Boosting" (ICS 2010 / arXiv:0909.2927): https://arxiv.org/abs/0909.2927. This confirms that label-modifying agnostic boosting can preserve the instance marginal, but it uses a threshold/correlation-style weak oracle rather than just a fixed additive $\beta$ statement at arbitrary final scale.
- da Cunha, Hogsgaard, Paudice, "Revisiting Agnostic Boosting" (arXiv:2503.09384): https://arxiv.org/abs/2503.09384. Its theorem applies to a correlation weak learner with $\gamma>\varepsilon_0$, but the paper explicitly treats the main route as statistical/information-theoretic and notes computational limitations.
- da Cunha, Hogsgaard, Paudice, "Sample-Near-Optimal Agnostic Boosting with Improved Running Time" (ALT 2026 / arXiv:2601.11265, v3 revised 2026-02-03): https://arxiv.org/abs/2601.11265. The abstract and TeX source say the algorithm has near-optimal sample complexity and running time polynomial in sample size when other parameters are fixed. The theorem statement invokes the weak learner at most $O(n^{m_0+3})$ times and its conclusion section asks whether a fully polynomial dependence on all parameters exists.
- Gavinsky, "Optimally-Smooth Adaptive Boosting and Application to Agnostic Learning" (JMLR 2003): https://www.jmlr.org/papers/v4/gavinsky03a.html. This remains evidence that older fixed-$\beta$ boosting guarantees are not simply $\operatorname{OPT}+\varepsilon$ black-box conversions.
- Hanneke, Moran, Thiessen, "Marginal-Nonuniform PAC Learnability" (NeurIPS 2025): https://openreview.net/forum?id=aoVCFtox89. Used only for the marginal-nonuniform convention: rates may depend on the instance marginal, while the learner remains uniform.

### Theorem Route

The best positive route now has three steps.

First, convert the atlas source to a correlation weak learner. For fixed $P$, the source gives

$$
\operatorname{corr}(h)
=1-2\operatorname{err}(h)
\ge 1-2(\operatorname{OPT}_{\mathcal C}+\beta_P(s))
=\sup_{c\in\mathcal C}\operatorname{corr}(c)-2\beta_P(s).
$$

So in the da Cunha--Hogsgaard--Paudice/Ghai-style definition

$$
\operatorname{corr}(h)\ge \gamma_0\sup_{c\in\mathcal C}\operatorname{corr}(c)-\varepsilon_0,
$$

one can set $\gamma_0=1$ and $\varepsilon_0=2\beta_P(s)$. Since $\beta_P(s)<1/2$, the weak learner is nontrivial with advantage gap $\theta=\gamma_0-\varepsilon_0=1-2\beta_P(s)$, inverse-polynomially bounded under the marginal-dependent convention.

Second, apply a modern agnostic boosting theorem. In a sample-only or oracle-counting model with suitable finite-capacity assumptions on the weak hypothesis class, this plausibly yields an $\operatorname{OPT}+\varepsilon$ learner with sample complexity polynomial in $1/\theta$, $1/\varepsilon$, and the relevant dimension terms. This is a stronger theorem route than the earlier Feldman threshold-only route, because it uses the fixed-additive source more directly.

Third, try to lift the route to the atlas target. This is where the proof breaks. The ALT 2026 improved-running-time algorithm achieves polynomial time in the final sample size only with other parameters fixed, and its theorem invokes the weak learner on the order of $n^{m_0+3}$ times. In the atlas source, $m_0$ is itself bounded by a marginal-dependent polynomial in $s$ and confidence. Then $n^{m_0+3}$ is generally $(\operatorname{poly}(1/\varepsilon))^{\operatorname{poly}(s)}$, not a polynomial in the joint variables $(s,1/\varepsilon,\log(1/\delta))$.

There are also two representation mismatches. The modern theorem assumes a base weak-hypothesis class with finite VC/fat or dual VC parameters, while the atlas source allows arbitrary improper outputs and does not record any capacity bound for the range of the weak learner. And if one uses enumeration or reweighted empirical subsamples, the calls are no longer cleanly governed by the original marginal-dependent polynomial $p_P$ unless an additional local-uniformity/runtime assumption is added.

Therefore this theorem route is a near miss, not a resolution.

### Counterexample Route

The false-witness route remains unsuccessful.

A valid false witness must satisfy a demanding combination: efficient fixed-additive weak agnostic improper learning for every marginal, but no efficient strong agnostic improper learner under some fixed marginal. The recent boosting lower bounds do not give this: they are sample-complexity lower bounds compatible with polynomial sample complexity, not computational separations. They also assume the existence of correlation weak learners, so they are not target-hard witnesses against strong learning in the atlas sense.

Known computational hardness examples still fail in the ways recorded at earlier depths. Halfspace, monomial, parity/LPN, PRF, and lattice/Gaussian examples tend to rule out even weak prediction when $\operatorname{OPT}$ is small, which kills the source. CSP, clustering, signed-disagreement, and other APX-style examples can produce proper constant-approximation intuition, but bounded-arity or polynomial-sized domains let an improper learner estimate labels pointwise, making the strong improper target easy. SQ lower bounds are also not enough because the atlas target is not SQ-restricted.

### Concrete Obstruction

The precise current obstruction is computational and uniformity-sensitive:

1. Fixed-additive weak agnostic learning does convert to a nontrivial correlation weak learner with gap $\theta_P(s)=1-2\beta_P(s)$.
2. Modern agnostic boosting can use such a nontrivial correlation weak learner statistically, and the newest route improves the running time to polynomial in the final sample size when weak-learner parameters are fixed.
3. The atlas target needs a single marginal-dependent polynomial in $(s,1/\varepsilon,\log(1/\delta))$.
4. The known algorithm's weak-call count $n^{m_0+O(1)}$, with $m_0$ potentially polynomial in $s$, is not polynomial in the atlas sense.
5. The atlas source does not include finite-capacity control of the weak learner's improper output class or local-uniform runtime control over empirical/reweighted marginals.

Thus the positive theorem is tantalizingly close for a strengthened or sample-only node, but it does not justify changing this computational edge to `true`. And no concrete source-positive, target-negative class is known, so it should not be changed to `false`.

### Atlas-Ready Text If Still Open

Open. A fixed-additive weak agnostic learner is closer to modern correlation-style weak learners than the older threshold-only discussion suggests: in $\{\pm1\}$ notation, $\operatorname{err}(h)\le\operatorname{OPT}_{\mathcal C}+\beta_P(s)$ implies $\operatorname{corr}(h)\ge\sup_{c\in\mathcal C}\operatorname{corr}(c)-2\beta_P(s)$, so the weak learner has nontrivial correlation gap $1-2\beta_P(s)$. Recent agnostic boosting results can exploit such nontrivial correlation weak learners statistically.

The edge remains open in the computational marginal-nonuniform atlas because the known near-optimal/improved-time boosting routes do not give the required polynomial runtime bound. In particular, the ALT 2026 improved-time algorithm runs in time polynomial in the final sample size only when the weak-learner parameters are fixed, and its theorem invokes the weak learner about $n^{m_0+O(1)}$ times. Since the atlas weak learner's sample size $m_0$ may itself be a marginal-dependent polynomial in the representation size, this is not a polynomial in $(s,1/\varepsilon,\log(1/\delta))$. The current source also lacks capacity control on the improper weak hypotheses and local-uniform control over induced empirical or reweighted marginals. No source-positive computational separation is currently known.

Suggested status remains:

- `status: "open"`
- `evidence: unknown`
- `summary: "Open: fixed-additive weak agnostic learning converts to nontrivial correlation weak learning, but known agnostic boosting routes do not preserve the atlas polynomial-time and marginal-nonuniform uniformity requirements; no false witness is known."`
