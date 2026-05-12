# Scratchpad: Efficient Weak Agnostic Improper PAC -> Efficient Marginal-Nonuniform Agnostic Improper PAC

Edge file: `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac.md`

Depth log starts at depth 1 from the main agent's depth 0.

## Current Verdict

Unresolved at launch.

## Depth 1 Attempt

### Verdict

Resolved: the implication should be marked `false`, conditionally on the worst-case lattice hardness assumption used by Tiegel's halfspace lower bound.

The witness is the class of Boolean halfspaces. The important point is that the source node is only an inverse-polynomial fixed-additive weak agnostic guarantee. Halfspaces satisfy that weak source by a clean-batch robustification of their standard distribution-free realizable learner, even though they do not satisfy strong agnostic learning under a fixed Gaussian marginal.

### Source Property For Halfspaces

Goal: show that halfspaces satisfy `efficient-weak-agnostic-improper-pac`.

Let `C` be affine halfspaces in dimension `d`, with representation size `s` comparable to `d`. In the realizable case, a polynomial-size sample can be fit by linear feasibility, and VC generalization for halfspaces gives a distribution-free proper PAC learner. This is the standard Valiant/VC route; the atlas witness note already records halfspaces as efficiently realizably learnable.

Now build a weak agnostic improper learner. Fix a realizable halfspace learner `L` that, on `m(d)` examples from any realizable distribution, returns a halfspace with clean error at most `1/4` with probability at least `2/3`; here `m(d)` is polynomial in `d`. Set

$$
\alpha(d) = \min\{1/16, 1/(16m(d))\}.
$$

Given agnostic labeled examples from an arbitrary distribution `D`, include the two constant classifiers as candidates. Also run `L` repeatedly on fresh batches of `m(d)` examples while pretending the labels are realizable, and validate all candidates on a fresh holdout sample. The holdout size and number of repetitions are polynomial in `d` and `log(1/delta)`.

Let `eta = OPT_C(D)`, and choose a comparator halfspace `c*` with error at most `eta + o(alpha)`.

If `eta >= alpha`, one of the two constants has error at most `1/2`, hence

$$
1/2 \le eta + 1/2 - alpha
$$

up to the harmless slack absorbed by choosing the final weak gap as, say, `alpha/4`.

If `eta < alpha`, a fresh batch is completely consistent with `c*` with probability at least

$$
(1-\eta)^{m(d)} \ge 1 - m(d)\eta \ge 15/16.
$$

Conditioned on this event, the batch is drawn from a realizable distribution labeled by `c*` under the instance marginal conditioned on agreement with `c*`. With constant probability `L` returns a halfspace whose error under that clean conditional distribution is at most `1/4`. On the original agnostic distribution this candidate has error at most

$$
eta + (1-eta)/4 < eta + 1/2 - alpha
$$

for the above choice of `alpha`. Repetition makes such a candidate appear with high probability, and validation chooses a candidate within a small additive tolerance. Thus halfspaces have a distribution-free improper weak agnostic learner with inverse-polynomial gap.

This argument is source-grounded in the standard PAC/VC learnability of halfspaces (Valiant 1984; Blumer et al. 1989 style uniform convergence) and does not require any agnostic halfspace optimization.

### Target Failure For Halfspaces

Tiegel 2023 proves hardness of improperly agnostically learning halfspaces from worst-case lattice assumptions. The paper's abstract and Theorem 2 state the distribution-specific form needed here: under the standard Gaussian instance marginal, for every constant `beta > 0`, learning halfspaces to error

$$
OPT_{LTF} + \epsilon
$$

requires time at least

$$
d^{\widetilde{\Omega}(1/\epsilon^{2-\beta})}.
$$

The target node `efficient-marginal-nonuniform-agnostic-improper-pac` permits the resource polynomial to depend on the marginal `P`, but for the fixed standard Gaussian marginal it still requires some fixed polynomial

$$
p_P(d,1/\epsilon,\log(1/\delta)).
$$

No such fixed polynomial can dominate Tiegel's lower bound as `epsilon -> 0`, assuming the stated lattice hardness. The target also allows improper binary hypotheses, exactly matching the hardness statement.

Therefore halfspaces satisfy the source and fail the target, so the implication is conditionally false.

### Exact Atlas Field Updates

Recommended frontmatter update for `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac.md`:

```yaml
status: "false"
evidence: conditional-counterexample
assumptions:
  - worst-case lattice hardness
witnesses:
  - halfspaces
witness_note: "[[halfspaces|Halfspaces]]"
ref_keys:
  - blumer1989
  - tiegel2023
refs:
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
  - "[Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)"
summary: "False under worst-case lattice hardness: halfspaces satisfy the distribution-free fixed-additive weak agnostic improper source via clean-batch robustification of their realizable learner, but Tiegel's standard-Gaussian hardness rules out marginal-nonuniform strong agnostic improper learning."
family: halfspace-agnostic-hardness
argument_note: "[[halfspace-agnostic-hardness|Halfspace Agnostic Hardness]]"
```

The body should replace the open-problem discussion with a counterexample proof organized as:

1. Verdict: `false`, under worst-case lattice hardness.
2. Construction: Boolean/affine halfspaces.
3. Why the source holds: linear feasibility plus VC generalization gives a distribution-free realizable learner; constants plus repeated clean-batch runs and validation give `OPT + 1/2 - 1/poly(d)` weak agnostic improper learning.
4. Why the target fails: Tiegel's fixed-standard-Gaussian lower bound rules out any polynomial-time improper learner achieving `OPT_LTF + epsilon`.

### Notes For The Main Agent

This resolution conflicts with some existing atlas notes that say Tiegel rules out distribution-free weak agnostic improper learning for halfspaces. The parameter issue is important: Tiegel's distribution-independent weak lower bound has `OPT_LTF` as small as `exp(-Omega(log^{1-c} d))`, which is still larger than `1/poly(d)` for every fixed polynomial. For an atlas weak source with an inverse-polynomial gap, the constant classifier already satisfies the weak additive guarantee in that parameter regime. The fixed-Gaussian strong lower bound, however, is exactly enough to refute the marginal-nonuniform strong agnostic target.

Primary sources checked:

- Tiegel 2023, PMLR page/PDF: improper agnostic halfspace hardness; fixed standard Gaussian marginal lower bound of `d^{~Omega(1/epsilon^{2-beta})}` for `OPT_LTF + epsilon`.
- Ghai and Singh 2025 and da Cunha, Hogsgaard, Paudice 2026: their positive boosting theorems use stronger correlation-style agnostic weak learners or have runtime exponents depending on weak-learner parameters, so they are not needed for the false witness.

## Main-Agent Audit

This claimed resolution is **not accepted** under the current atlas definition.

The source note `efficient-weak-agnostic-improper-pac` uses a fixed additive weak-agnostic tolerance `err <= opt_C + beta` for some fixed `beta < 1/2`. It is not merely the marginal-style inverse-polynomial weak gap used by some other nodes.

Under that fixed-gap reading, Tiegel's distribution-independent halfspace lower bound rules out halfspaces as a source witness: for any fixed gap `a = 1/2 - beta > 0`, the hard instances have `OPT` tending below `a` while no efficient improper learner achieves error better than `1/2 - gamma` for tiny `gamma`. A fixed-gap weak learner would output error at most `OPT + 1/2 - a < 1/2 - gamma`, contradicting the lower bound. This matches the existing atlas boundary notes saying halfspaces fail the weak agnostic improper source under worst-case lattice hardness.

So the halfspace/Tiegel route still refutes targets from realizable sources, but it does **not** resolve this edge whose source is already fixed-additive weak agnostic improper learning. A depth-2 follow-up should look for a class satisfying constant-slack weak agnostic improper learning while failing marginal-nonuniform strong agnostic improper learning, or for a fully polynomial fixed-slack agnostic booster.

## Depth 2 Attempt: Constant-Slack Source Separation Search

### Verdict

RESOLVED: no.

I did not find an atlas-sound separation. The best template remains a coding-theoretic low-noise/high-noise separation, but every concrete route I checked either fails the fixed constant weak source, only gives worst-case nearest-codeword hardness rather than PAC hardness against an improper learner, or loses the distribution-free arbitrary-marginal requirement.

For this attempt I use the main-agent audit's interpretation: the source learner must achieve

$$
\operatorname{err}(h)\le \operatorname{OPT}_{\mathcal C}+\beta
$$

for one fixed $\beta<1/2$. Write the fixed weak advantage as

$$
\alpha = 1/2-\beta > 0.
$$

Constants handle all distributions with $\operatorname{OPT}_{\mathcal C}\ge \alpha$, because the better constant classifier has error at most $1/2 \le \operatorname{OPT}_{\mathcal C}+1/2-\alpha$. Thus any false witness can focus on the semi-agnostic regime $\operatorname{OPT}_{\mathcal C}<\alpha$: it needs a public polynomial-time method that finds some nontrivial predictor whenever the labels are within a fixed constant $\alpha$ of a concept, but it should remain hard to get $\operatorname{OPT}+\varepsilon$ for some noisier fixed-marginal label distributions.

### LPN And Parity Variants

Affine parities still do not work under a fixed constant $\alpha$. Suppose a source learner existed for affine parities over the uniform marginal on $\{0,1\}^n$. On examples

$$
Y = a\cdot X \oplus b \oplus N,\qquad N\sim \operatorname{Bernoulli}(\eta),
$$

with any constant $\eta<\alpha$, the optimum parity error is $\eta$. The source learner would output an arbitrary binary hypothesis with error

$$
\le \eta + 1/2-\alpha
= 1/2-(\alpha-\eta),
$$

so it would have constant correlation with the noisy parity labels. A fresh holdout sample would distinguish these examples from random labels. Therefore the fixed-gap source itself breaks low-noise decision-LPN.

This rules out the clean parity witness unless one assumes a nonstandard threshold version of LPN: polynomial-time weak recovery for all noise rates below some public $\alpha$, but hardness of strong recovery at some larger constant noise rate $\eta_0>\alpha$. The usual LPN picture, as represented by Blum--Kalai--Wasserman and Kalai--Mansour--Verbin, does not give such an easy-below/hard-above threshold; the same noisy-parity problem is the obstruction already at low constant noise.

### Weighted-Decoding Template

The most promising abstract false-witness template is a binary code family viewed as a concept class. Let

$$
\mathcal C_s=\{c_m:\Omega_s\to\{\pm1\}: m\in\mathcal M_s\}.
$$

A constant-gap weak source would follow from the following distribution-free weighted bounded-distance decoder:

**Needed source lemma.** There is a fixed $\alpha>0$ and a polynomial-time algorithm which, from samples drawn from any joint distribution on $\Omega_s\times\{\pm1\}$, outputs a binary hypothesis of error $<1/2$ whenever some codeword has error $<\alpha$ under the sample marginal. More strongly, if it returned a codeword or predictor with error $\operatorname{OPT}+o(1)$ in this low-noise regime, then constants would complete the $\operatorname{OPT}+1/2-\alpha$ source guarantee.

**Needed target obstruction.** For some fixed marginal $P_0$ on $\Omega_s$, no polynomial-time learner, even with improper output, can achieve $\operatorname{OPT}_{\mathcal C}+\varepsilon$. A sufficient average-case form would be: for some $\eta_0\in(\alpha,1/2)$, noisy random codeword samples

$$
(X,c_M(X)\cdot Z),\qquad X\sim P_0,\quad \Pr[Z=-1]=\eta_0,
$$

are computationally indistinguishable from random labels, because a strong agnostic learner would output a hypothesis with error $<1/2-\Omega(1)$ on the noisy-codeword distribution and validation would distinguish.

This template would resolve the edge as conditionally false. I could not instantiate both bullets with a known public code family.

### Nearest-Codeword And Reed--Solomon Obstacles

Nearest-codeword hardness is tempting but not enough by itself.

Guruswami--Vardy prove that maximum-likelihood decoding of Reed--Solomon codes is NP-hard, even with unlimited preprocessing. That is suggestive because the target is marginal-nonuniform: preprocessing depending on the fixed code/marginal should not remove the hardness. But several gaps prevent turning this into the atlas edge:

1. The theorem is worst-case decoding hardness. The PAC target failure needs either an efficient example-oracle reduction or an average-case noisy-codeword indistinguishability statement. A strong improper learner need only output a predictor with low future error, not a nearest codeword.

2. Standard finite-block nearest-codeword instances have polynomial-size support. Under a fixed marginal with polynomial-size support, an improper PAC learner can sample enough to learn the whole conditional label table and output a lookup predictor. To get a genuine improper-learning obstruction, the hard marginal must have superpolynomial or implicit support, as in LPN-style examples.

3. Reed--Solomon and soft-decision decoders are naturally large-alphabet. The atlas edge is binary classification. Bit-level encodings introduce arbitrary bit weights under arbitrary marginals, and I did not find a theorem giving the needed binary weighted bounded-distance decoder for every marginal.

4. Ordinary bounded-distance or list decoding is usually stated for Hamming-uniform coordinates or structured reliability information. The source is distribution-free, so the low-noise decoder must tolerate arbitrary coordinate weights induced by an arbitrary instance marginal. Koetter--Vardy/Guruswami--Sudan-style soft decoding is close in spirit, but I did not verify a binary, arbitrary-weight theorem strong enough for the source lemma above.

Thus Reed--Solomon gives a useful search direction, not a settled counterexample.

### Public Handle And Weak-Summary Attempts

I also considered modifying a hard class by adding public "handles" or weak summaries so that low-noise weak learning becomes easy while high-noise strong learning remains hard.

The obstacle is that the source is distribution-free. On the fixed hard marginal, if labels are a low-noise hidden codeword/parity and $\eta<\alpha$, the source learner must output a hypothesis with constant correlation with that hidden object. If the public handles are rich enough that such a correlated handle always exists and can be found from samples, then they already provide a low-noise weak decoder. If they are not rich enough, the source fails. When handles are made dense enough to be found without identifying the hidden object, adversarial marginals can avoid them, or the same handles tend to give validation-search routes for the target.

So the handle idea does not currently beat the weighted-decoding template; it just hides the same missing low-noise decoder inside an augmented class.

### Why This Does Not Prove The Edge True

The failure of these separation templates is not evidence of a theorem. The positive direction still needs a fully polynomial fixed-slack agnostic booster. Known agnostic boosters are close but do not match this endpoint:

- Ben-David--Long--Mansour/Gavinsky-style fixed-slack results do not give a clean $\operatorname{OPT}+\varepsilon$ polynomial-time conversion in the atlas sense.
- Feldman and later Ghai--Singh use oracle conditions whose slack/advantage is tied to the final accuracy scale or leaves a residual term.
- da Cunha--Hogsgaard--Paudice is the closest fixed-slack route, but the relevant runtime has weak-sample or capacity parameters in the exponent; when those parameters grow with the representation size, this is not a uniform polynomial-time learner.

The marginal-nonuniform target does not obviously remove this barrier. The source learner is already distribution-free, so reweighted weak calls are legal. The missing step is still a polynomial observable way to manufacture low-$\operatorname{OPT}$ weak-call distributions from an arbitrary noisy residual without enumerating clean tuples.

### Promising Follow-Up Directions

1. Formalize the weighted-decoding source lemma for binary concatenated algebraic codes. The exact question is whether Forney/GMD or Koetter--Vardy-style soft information can be made to handle arbitrary PAC marginals over bit positions with a fixed constant decoding radius.

2. Search for average-case hardness of high-noise decoding for an explicitly evaluable code with sample access, not just worst-case nearest-codeword hardness. The statement must rule out arbitrary improper predictors with correlation, not merely proper codeword recovery.

3. Check whether any Reed--Muller/Reed--Solomon sample-only low-noise decoder has a provable noise threshold below a known hardness threshold. If such a threshold exists in a binary classification encoding, it is the cleanest route to a false edge.

4. Continue the positive route by looking for a marginal-nonuniform fixed-$P$ booster. The polynomial $p_P$ may depend on the marginal, but it still cannot depend on the conditional labels or comparator, so any precomputed object must be a $P$-only menu of weak-call distributions.

### Sources Checked

- [Kalai--Mansour--Verbin 2008](https://doi.org/10.1145/1374376.1374466) for the parity/LPN obstruction and fixed-additive agnostic boosting discussion.
- [Blum--Kalai--Wasserman 2003](https://doi.org/10.1145/792538.792543) for the standard noisy-parity/LPN reference point.
- [Guruswami--Vardy 2005](https://arxiv.org/abs/cs/0405005) for NP-hardness of maximum-likelihood Reed--Solomon decoding, including the unlimited-preprocessing strengthening.
- [Koetter--Vardy 2003](https://www.site.uottawa.ca/~zhcheng/RS_soft_decision.pdf) and Reed--Solomon soft/list-decoding references for the weighted-decoding near miss.
- [Ghai--Singh 2025](https://proceedings.mlr.press/v267/ghai25a.html) and [da Cunha--Hogsgaard--Paudice 2026](https://arxiv.org/abs/2601.11265) for the current positive boosting frontier.

## Depth 3 Attempt: Binary Weighted-Decoding Source Lemma

### Verdict

RESOLVED: no.

I did not find an explicit binary code/concept family satisfying both halves of the proposed separation. The weighted-decoding template is still coherent, but the needed source lemma is stronger than the soft-decision decoding theorems I could verify, and the hard fixed-marginal side needs average-case prediction hardness against improper hypotheses, not just nearest-codeword hardness.

### Target Template Rewritten

Let a concept class be a succinct binary code:

$$
\mathcal C_s=\{c_u:\Omega_s\to\{\pm1\}:u\in\mathcal U_s\}.
$$

The fixed-slack weak source with advantage $\gamma>0$ would follow from a distribution-free low-noise decoder of the following form. Given samples from any marginal $P$ on $\Omega_s$ and labels $Y$, if some codeword has weighted error

$$
\Pr_{X\sim P}[c_u(X)\ne Y] < \alpha
$$

for a fixed $\alpha<\gamma$, the learner must output some binary predictor with error at most $1/2-\Omega(1)$, or preferably recover a codeword of error $O(\alpha)$. Constants then handle the complementary regime $\operatorname{OPT}_{\mathcal C}\ge \gamma$, since a better constant has error at most $1/2\le \operatorname{OPT}+1/2-\gamma$.

The negative target would need one fixed marginal $P_0$ with superpolynomial effective support and a noise level $\eta_0\in(\alpha,1/2)$ such that examples

$$
X\sim P_0,\qquad Y=c_U(X)Z,\qquad \Pr[Z=-1]=\eta_0
$$

are hard even for improper prediction: no polynomial-time learner should output a hypothesis with correlation $\Omega(1)$ with $Y$. A strong marginal-nonuniform agnostic learner would violate this, because $\operatorname{OPT}_{\mathcal C}\le\eta_0$ and an $\operatorname{OPT}+\varepsilon$ hypothesis has error below $1/2$ by a constant when $\varepsilon<(1/2-\eta_0)/2$.

So the desired witness is a **threshold-decodable public code**: easy low-noise weighted prediction below $\alpha$ for every marginal, hard high-noise prediction above $\alpha$ for one fixed non-memorizable marginal.

### Polynomial Support Codes Do Not Work

Worst-case nearest-codeword hardness, even with preprocessing, is not enough for this edge. Bruck--Naor and Guruswami--Vardy show strong fixed-code/preprocessing hardness phenomena for maximum-likelihood decoding, and Guruswami--Vardy prove this for Reed--Solomon codes. But if the instance domain has only polynomially many coordinates, the marginal-nonuniform agnostic **improper** target can ignore the code structure: sample enough under the fixed marginal, estimate the conditional label bias on each heavy coordinate, and output the empirical Bayes lookup rule. That predictor is at least as good as the best codeword.

Thus a false witness needs $P_0$ to have superpolynomial effective support. This immediately rules out using standard finite-block decoding hardness directly. Once the block length is made superpolynomial in the representation size, ordinary decoders running in time polynomial in the block length are no longer efficient PAC learners.

### Algebraic Soft-Decision Codes Are Near Misses

Reed--Solomon soft-decision decoding is the closest positive source-side technology. Koetter--Vardy give a polynomial-time soft-decision list decoder for Reed--Solomon codes, building on Guruswami--Sudan interpolation, and weighted Reed--Solomon list-decoding formulations take a weight vector and return codewords meeting a score/tolerance condition.

I could not turn this into the needed binary PAC source lemma for three reasons.

1. The algorithms are polynomial in the full block length. If the coordinate domain is large enough to defeat lookup learning, this is not polynomial in the representation size.

2. The cleanest theorems are $q$-ary symbol-level statements. Binary classification would need a bit-level encoding that preserves arbitrary coordinate weights. Bit-level soft-decision RS work exists, but I did not find a theorem saying that arbitrary bit marginals can be decoded at a fixed constant weighted radius in time polynomial in the succinct representation.

3. The known hardness on the other side is worst-case maximum-likelihood decoding or nearest-codeword hardness. It does not rule out a PAC learner outputting an arbitrary correlated predictor under one fixed stochastic marginal.

So algebraic codes give a plausible *proper decoding* separation, but not the source-positive/improper-target-negative separation needed here.

### Hadamard And Parity Fail On The Source Side

Hadamard/parity codes have the right non-memorizable fixed marginal: $\Omega_n=\{0,1\}^n$ with $P_0$ uniform, and $c_a(x)=(-1)^{a\cdot x}$. High-noise improper prediction is exactly the LPN-style obstruction.

But this family fails the fixed-slack source. If a distribution-free low-noise weak agnostic learner existed for this class with constant $\alpha$, then on uniform examples

$$
Y=(-1)^{a\cdot X}Z,\qquad \Pr[Z=-1]=\eta<\alpha,
$$

it would output a hypothesis with constant correlation with the noisy labels. A holdout test would distinguish noisy parity from random labels, contradicting the standard decision-LPN assumption at low constant noise. Fast Walsh-Hadamard soft-decision maximum-likelihood decoding also costs $\Theta(2^n)$ time, and Goldreich--Levin-style algorithms need query access to the received word rather than only random labeled examples.

This is the central tension: the best fixed-marginal improper hardness candidates already make low-noise weighted decoding hard.

### LDPC, Polar, Concatenated, And Local-Code Routes

Modern code families with efficient decoders do not appear to satisfy the arbitrary-marginal source condition.

LDPC, polar, expander, and concatenated-code decoders are designed for specified channel models or adversarial Hamming errors over the full block. Their guarantees are not distribution-free weighted PAC statements over arbitrary coordinate marginals. They also usually run in time polynomial in block length, which is too slow for a superpolynomial support used to defeat lookup.

Sparse unbiased linear-code local list-decoding results are also instructive but do not settle this. Local algorithms can list-decode from high error with oracle access to a received word in certain regimes, and some reductions eventually touch noisy parity algorithms. A PAC learner under a fixed marginal does not have arbitrary query access to labels; it only receives random examples. Under arbitrary coordinate marginals, even choosing useful queried coordinates is not available.

### Sharper Obstacle

The binary weighted-decoding source lemma seems to require a **sample-local arbitrary-weight bounded-distance decoder**:

- input is only a polynomial sample from an unknown coordinate weighting;
- the coordinate universe may be exponentially large;
- the decoder cannot scan all positions;
- the guarantee must hold for every marginal, not just a symmetric channel;
- the output may be improper, but must have constant prediction advantage whenever a codeword has constant low weighted error.

I found no explicit family with this property and an independent high-noise fixed-marginal improper hardness theorem. Existing examples split in the wrong way:

- public codes with efficient low-noise decoders are efficient for random/channel noise or full-block inputs, not arbitrary PAC marginals over exponentially many coordinates;
- cryptographic/LPN-style fixed-marginal hard families remain hard at low constant noise, so they fail the source;
- worst-case nearest-codeword hardness survives preprocessing but does not imply average-case improper prediction hardness;
- polynomial-size coordinate domains make the target trivially learnable by empirical lookup.

### Concrete Follow-Up Directions

1. Try to prove a no-go theorem for linear codes: arbitrary-weight low-noise PAC decoding for every marginal plus enough symmetry may imply an algorithm for the high-noise fixed-marginal prediction problem, at least for transitive or self-correctable code families.

2. Search specifically for **sample-based** threshold decoding, not standard block decoding: an algorithm that sees only random noisy coordinates from $P$ and still recovers a weak predictor below one noise threshold, while a higher-noise uniform distribution is pseudorandom.

3. Revisit bit-level algebraic soft-decision decoding with the exact PAC metric: arbitrary weights on individual bits, succinctly represented evaluation domains, and runtime polynomial in $\log|\Omega_s|$ rather than $|\Omega_s|$.

4. Look for code-based cryptographic assumptions that are explicitly prediction/correlation-hard for one public, fixed, samplable marginal above a threshold, while admitting a public low-noise decoder below the threshold. I did not find a standard assumption of this form; code-based cryptography usually hides a decoding trapdoor or assumes hard decoding without a public below-threshold decoder.

### Sources Checked

- [Bruck--Naor 1990](https://authors.library.caltech.edu/records/fgb06-gdy28) for maximum-likelihood decoding hardness with preprocessing.
- [Guruswami--Vardy 2005](https://arxiv.org/abs/cs/0405005) for NP-hardness of maximum-likelihood Reed--Solomon decoding, also with unlimited preprocessing.
- [Koetter--Vardy 2003](https://www.site.uottawa.ca/~zhcheng/RS_soft_decision.pdf) and weighted/soft Reed--Solomon list-decoding references for the strongest source-side near miss.
- [Blum--Kalai--Wasserman 2003](https://doi.org/10.1145/792538.792543) and [Kalai--Mansour--Verbin 2008](https://doi.org/10.1145/1374376.1374466) for noisy parity/LPN and agnostic-boosting context.
- [Gopalan--Kalai--Klivans 2013](https://doi.org/10.1137/100811945) for local list-decoding/testing of sparse unbiased linear codes from high error.
- [Daniely--Linial--Shalev-Shwartz 2014](https://arxiv.org/abs/1311.2272) for the broader difficulty of proving improper-learning hardness from average-case assumptions.

## Depth 4 Attempt: Marginal-Dependent Booster Menus

### Verdict

RESOLVED: no.

I do not see a sound proof that marginal-nonuniformity alone computationalizes fixed-slack agnostic boosting. There is a clean conditional positive statement: if a fixed marginal $P$ admits a polynomial-size, uniformly constructible menu of weak-call transformations that always exposes a low-noise residual problem whenever the current predictor has excess error, then the source weak learner can be boosted to the target under that $P$. But this menu property is an additional structural assumption about $(\mathcal C,P)$, not a consequence of distribution-free fixed-additive weak agnostic improper learning.

The obstruction is that the missing information in the known fixed-slack boosters is label-conditional, not marginal-only. A $P$-dependent object can know the geometry of the instance distribution, but it cannot know the hidden comparator, the noise pattern, or which finite sample tuples are clean.

### What Marginal-Nonuniformity Can And Cannot Buy

The target permits a polynomial $p_P$ depending on the instance marginal $P$. It does not give the learner separate advice for each $P$: the learner is still one uniform algorithm. Operationally, the useful interpretation is that the learner may spend a $P$-dependent polynomial amount of time and unlabeled sampling to build objects from $P$, and those objects must then work for every conditional label distribution over that same $P$.

So a "booster menu" can depend on $P$, the representation size $s$, $\varepsilon$, and $\delta$. It cannot depend on:

- the hidden comparator $c\in\mathcal C$;
- the conditional label bias $\mathbb E[Y\mid X]$;
- which examples in the observed sample are corrupted;
- a weak-sample or compression parameter whose exponent grows with $s$.

That last point matters for the da Cunha--Hogsgaard--Paudice style near positive. If the known route costs $n^{m_0(s)}$, then a marginal-dependent polynomial cannot absorb it unless $m_0$ is bounded as a constant for the fixed marginal/class family. A polynomial may have $P$-dependent constants, but not degree growing with the representation size.

### Conditional Positive Menu Lemma

Here is the strongest positive formulation I could make precise.

Fix the source weak advantage $\gamma>0$, so the weak learner is only forced to provide useful signal on distributions with

$$
\operatorname{OPT}_{\mathcal C}<\gamma.
$$

Suppose that for each marginal $P$ there is a $P$-dependent polynomial-time unlabeled procedure that constructs a finite menu

$$
\mathcal M_{P,s,\varepsilon}=\{T_1,\ldots,T_N\},
$$

where $N\le p_P(s,1/\varepsilon)$, and each $T_i$ is a samplable transformation from labeled examples with marginal $P$ to a weak-call distribution over examples. Assume the menu has the following residual-exposure property:

For every joint distribution $\mathcal D$ with marginal $P$, every current predictor $f$, and every comparator $c\in\mathcal C$ witnessing excess error

$$
\operatorname{err}_{\mathcal D}(f)>\operatorname{err}_{\mathcal D}(c)+\varepsilon,
$$

some menu transformation $T_i$ produces a weak-call distribution $\mathcal D_i$ such that:

1. the comparator-induced label rule has error below $\gamma/2$ on $\mathcal D_i$; and
2. any hypothesis returned by the source weak learner on $\mathcal D_i$ can be converted, with empirically checkable sign and step size, into a descent direction reducing a convex surrogate or the zero-one empirical risk of $f$ by $\operatorname{poly}(\varepsilon,\gamma)$.

Then standard coordinate-descent or online-convex-optimization boosting bookkeeping gives an $\operatorname{OPT}+\varepsilon$ improper learner under $P$. The algorithm enumerates the menu, calls the source learner with confidence split across calls, validates all candidate updates on fresh examples from $\mathcal D$, and repeats for $\operatorname{poly}(1/\varepsilon,1/\gamma)$ rounds. All sampling still has marginal $P$ after rejection/reweighting, so the distribution-free source learner is valid on every weak call.

This lemma is useful because it states exactly what marginal-nonuniformity would need to provide: a polynomial $P$-specific residual-exposure menu.

But the lemma does not resolve the edge, because I found no argument that the source guarantee implies such a menu.

### Uniform Noise Blocks P-Only Reweighting

The basic obstruction is already visible for random classification noise above the source threshold. Fix a marginal $P$, a concept $c\in\mathcal C$, and a noise rate

$$
\eta\in(\gamma,1/2).
$$

Consider

$$
X\sim P,\qquad Y=c(X)\cdot Z,\qquad \Pr[Z=-1]=\eta,
$$

with independent noise. The target must learn to error $\eta+\varepsilon$, since $\operatorname{OPT}_{\mathcal C}\le\eta$. However, any label-independent reweighting or conditioning based only on $P$ preserves the same noise rate $\eta$. Thus every $P$-only weak-call distribution still has $\operatorname{OPT}_{\mathcal C}=\eta>\gamma$, so the fixed-slack weak learner is allowed to output a useless predictor.

This is not a separation by itself, since the source learner might exploit labels in more complex adaptive calls. But it shows that marginal-only preprocessing cannot be the missing ingredient. To reach the informative regime $\operatorname{OPT}<\gamma$, the booster must somehow construct label-dependent low-noise calls. In the independent-noise example, the identities of the clean labels are fresh randomness in the labeled sample; they are not encoded in $P$.

This is exactly where the known fixed-slack routes pay for clean-tuple enumeration. If a clean tuple has size $m_0(s)$, then the brute-force search over observed labeled samples costs roughly $n^{m_0(s)}$. A $P$-dependent menu cannot preselect the clean tuples, because which tuples are clean is conditional-label information.

### Covers And Compression Objects

A different hope is to precompute a $P$-dependent cover of the concept class or a compression object. This gives real restricted positives, but again not the general edge.

If, for a fixed $P$, there is an efficiently constructible cover $\mathcal H_{P,\varepsilon}$ such that every $c\in\mathcal C$ is $\varepsilon$-close under $P$ to some $h\in\mathcal H_{P,\varepsilon}$ and

$$
|\mathcal H_{P,\varepsilon}|\le p_P(s,1/\varepsilon),
$$

then empirical risk minimization over the cover gives the marginal-nonuniform agnostic improper target. Similarly, a $P$-dependent compression or candidate-generation scheme of size $O(\log p_P(s,1/\varepsilon))$ would suffice, because the learner could enumerate the decompressions and validate.

But distribution-free fixed-slack weak agnostic learning does not imply such a cover. Even statistically, standard VC-style $P$-covers have size roughly $(1/\varepsilon)^{O(d(s))}$ when the VC dimension grows with $s$, which is not a polynomial in $(s,1/\varepsilon)$ in the atlas sense. Computationally, the weak source can identify a comparator from labeled data in the realizable or low-noise regime without giving any label-free polynomial list of all possible comparators under $P$.

So cover/compression menus are sufficient extra structure, not a consequence of the source node.

### Connection To The Weighted-Decoding Near Miss

The code template from the previous depth is a good stress test for marginal-dependent menus. Take a fixed symmetric marginal $P_0$ over a superpolynomial coordinate set and a code-like concept class

$$
\mathcal C_s=\{c_u:\Omega_s\to\{\pm1\}\}.
$$

For high-noise examples $Y=c_U(X)Z$ with $\Pr[Z=-1]=\eta>\gamma$, every $P_0$-only reweighting again leaves the weak-call noise at $\eta$. A successful menu must therefore include label-dependent threshold-decoding operations that recover correlation despite noise above $\gamma$. But that is precisely the hard part of the desired false witness: a public low-noise decoder below $\gamma$ plus high-noise improper prediction hardness above $\gamma$.

Marginal nonuniformity does not appear to soften this tension. If the support of $P_0$ is polynomial, the improper target can learn by lookup. If the support is superpolynomial, a polynomial $P_0$-menu cannot list enough coordinates or codeword-specific handles. Any useful operation must be a genuine sample-local decoder, and that returns us to the weighted-decoding source lemma rather than solving the booster problem.

### Isolating The Obstruction

The depth-4 obstruction can be stated as follows.

To prove the implication true using marginal-dependent preprocessing, one needs to show that every distribution-free fixed-slack weak agnostic learner induces, for every fixed marginal $P$, a polynomial-size $P$-constructible residual-exposure menu. Existing boosting machinery does not provide this: its hard step is finding comparator-dependent low-noise calls from labeled data when the ambient noise may be above the source threshold.

To prove the implication false, one still needs a class where this obstruction is real. The most plausible route remains a threshold-decodable code or cryptographic class:

- below noise $\gamma$, distribution-free arbitrary-marginal weak prediction is easy;
- above noise $\gamma$, one fixed marginal $P_0$ is hard even for improper prediction;
- $P_0$ has superpolynomial effective support so lookup learning is impossible.

I did not find such a class in this attempt.

### Next Directions

1. Formalize a black-box oracle lower bound for $P$-only menus: construct an oracle weak learner that satisfies the fixed-slack source but returns no useful signal on every menu call whose induced $\operatorname{OPT}$ remains above $\gamma$. This would not be an atlas separation, but it would certify that marginal-dependent preprocessing alone cannot prove the edge.

2. Look for classes with polynomial $P$-dependent covers under every marginal satisfying the source. If such a theorem is false, find a source-positive class with superpolynomial $P$-metric entropy under some fixed marginal.

3. Refine the weighted-decoding template into a threshold assumption: easy arbitrary-marginal prediction below one noise rate, hard fixed-marginal improper prediction above it. This is still the cleanest route to a conditional false edge.

4. Check whether the $n^{m_0}$ cost in the recent fixed-slack boosters can be localized to a $P$-dependent constant for any natural subclasses. That would give useful restricted positive atlas notes even if the general edge remains open.

### Sources Rechecked

- [Feldman 2010](https://arxiv.org/abs/0909.2927) for distribution-specific agnostic boosting by reweighting same-marginal examples.
- [Ghai and Singh 2025](https://proceedings.mlr.press/v267/ghai25a.html) for the role of unlabeled samples in distribution-specific agnostic boosting.
- [da Cunha--Hogsgaard--Paudice 2026](https://arxiv.org/abs/2601.11265) and [Revisiting Agnostic Boosting](https://arxiv.org/abs/2503.09384) for the current fixed-slack/sample-complexity frontier and the computational clean-tuple bottleneck.
- [Hanneke--Moran--Thiessen 2025](https://openreview.net/forum?id=aoVCFtox89) for the marginal-nonuniform interpretation: rates may depend on the marginal, but guarantees must hold uniformly over labelings with that marginal.

## Depth 5 Attempt: Threshold Decoding Separation

### Verdict

RESOLVED: no.

I do not know a standard coding or cryptographic assumption that supports the exact threshold pattern needed for this edge. The needed assumption would say:

1. below some fixed noise level $\alpha<1/2$, there is a public polynomial-time learner/decoder that works from random examples under every coordinate marginal and outputs a weakly correlated, possibly improper, predictor whenever some codeword has weighted error below $\alpha$; but
2. above $\alpha$, for one fixed samplable marginal $P_0$ and a noise rate $\eta\in(\alpha,1/2)$, no polynomial-time algorithm, even with arbitrary improper output, can get $\operatorname{OPT}_{\mathcal C}+\varepsilon$ error.

This is a coherent conditional-false template, but it is not the shape of the usual assumptions.

### Why Standard Code Assumptions Do Not Give It

Worst-case nearest-codeword or maximum-likelihood decoding hardness, even with preprocessing, is still the wrong kind of hardness. Bruck--Naor show that maximum-likelihood decoding remains hard when the code is fixed in advance and preprocessing is allowed, and Guruswami--Vardy give strong Reed--Solomon maximum-likelihood hardness. These results are about finding a nearest codeword in worst-case received words. The atlas target would be refuted only by an average-case prediction statement under a fixed marginal: from samples $(X,Y)$, no algorithm should output any function with enough correlation with $Y$. A nearest-codeword lower bound does not rule out such an improper predictor.

Random linear code and syndrome-decoding assumptions also do not have the needed public threshold. In code-based cryptography, the public problem is supposed to be hard at the chosen error rate. If there is efficient decoding below a radius, it is typically because the legitimate party has hidden structure or a trapdoor, or because one is using a structured public code whose decoder is designed for a particular channel model. That does not give a distribution-free PAC learner for arbitrary marginals over coordinates. Debris-Alazard--Resch explicitly frame LPN as an average-case decoding problem, and their discussion reinforces the usual direction: LPN-style decoding is used as a hardness source, not as a public easy-below-threshold primitive.

Channel-decoding thresholds are a different phenomenon. LDPC, polar, expander, Reed--Solomon, concatenated, and related decoders may have efficient performance below a channel-specific threshold and poor known performance above it. But this is not a cryptographic hardness threshold. It is usually tied to an i.i.d. or symmetric channel, full-block access, and proper or message-recovery decoding. The source node here asks for arbitrary coordinate weights induced by an arbitrary instance marginal and only sample access, while the negative target must defeat arbitrary improper prediction under one fixed marginal.

### LPN Is The Wrong Threshold

Hadamard/parity remains the cleanest fixed-marginal improper prediction hardness candidate: under the uniform marginal, strong agnostic learning noisy parities would recover correlation with noisy parity labels. But standard LPN hardness applies already at low constant noise. Therefore, if a source learner existed below $\alpha$ for parities, it would itself break low-noise LPN by producing a constant-correlation predictor and validating it on fresh examples.

There are quantitative algorithmic thresholds for LPN solvers: lower noise is easier, and very small noise can reduce search complexity. But that is not the atlas pattern. The source needs polynomial-time weak prediction for every marginal below a fixed constant $\alpha$, while the target hardness needs only one higher constant noise under one marginal. Standard LPN does not assert "easy below $\alpha$, hard above $\alpha$"; it is normally a hardness assumption throughout the constant-noise regime relevant here.

### What The Nonstandard Assumption Would Need To Say

The closest formal assumption would be a **public sample-local threshold decoding assumption**:

For a succinct binary code family $\mathcal C_s=\{c_u:\Omega_s\to\{\pm1\}\}$ with efficiently samplable superpolynomial support marginal $P_0$, there are constants $0<\alpha<\eta<1/2$ such that:

- there is a public polynomial-time algorithm which, for every marginal $P$ over $\Omega_s$ and every label distribution with $\min_{c\in\mathcal C_s}\Pr[Y\ne c(X)]<\alpha$, outputs a predictor $h$ with $\Pr[h(X)\ne Y]\le 1/2-\Omega(1)$;
- but for $X\sim P_0$, random $u$, and $Y=c_u(X)Z$ with $\Pr[Z=-1]=\eta$, the joint distribution is prediction-hard: no polynomial-time algorithm given samples outputs any hypothesis with nonnegligible correlation with $Y$.

This would resolve the edge as conditionally false. It also explains why the assumption is nonstandard. The first bullet is an all-marginals, sample-only, arbitrary-weight bounded-distance decoder. The second bullet is an average-case high-noise prediction lower bound against improper hypotheses. Standard coding theory gives pieces adjacent to these bullets, but not both bullets for the same public family.

### Concrete Obstacles

Polynomial support is fatal for the negative side. A marginal-nonuniform improper learner can simply estimate the label bias at each sufficiently heavy coordinate and output a lookup rule, so the fixed hard marginal must have superpolynomial effective support.

Superpolynomial support is fatal for many positive decoders. Algebraic and message-passing decoders are usually polynomial in block length or assume full received-word access, whereas the PAC learner must run in time polynomial in the representation size and see only random examples.

Public easy decoding and cryptographic hardness pull in opposite directions. If a public decoder works below $\alpha$ for arbitrary weighted marginals, it is much stronger than ordinary unique decoding and may expose enough structure to attack nearby higher-noise prediction. If hardness is based on random linear codes, LPN, or syndrome decoding, then the low-noise source side is already hard rather than easy.

The target hardness is improper. Proper decoding hardness is too weak: the learner need not recover the hidden codeword or message. It only needs any predictor with correlation, and a successful $\operatorname{OPT}+\varepsilon$ agnostic learner under $P_0$ would give such a predictor.

### Bottom Line For This Branch

The threshold-code route remains the most legible possible conditional separation, but it would require a bespoke assumption rather than a standard one. The standard assumptions I checked fall into three incompatible families:

- public efficient decoders below channel thresholds, without average-case improper prediction hardness above the threshold;
- code-based cryptographic hardness assumptions, without public all-marginals low-noise weak decoding below the threshold;
- worst-case decoding hardness, even with preprocessing, without a fixed-marginal sample-based improper prediction lower bound.

So this depth-5 branch does not resolve the edge. The useful artifact is a sharper specification of the nonstandard assumption a future branch would need to either instantiate or rule out.

### Sources Checked

- [Bruck--Naor 1990](https://authors.library.caltech.edu/records/fgb06-gdy28) for maximum-likelihood decoding hardness with preprocessing.
- [Blum--Kalai--Wasserman 2003](https://www.microsoft.com/en-us/research/publication/noise-tolerant-learning-parity-problem-statistical-query-model/) for noisy parity/LPN as the canonical sample-based hard fixed-marginal example.
- [Debris-Alazard--Resch 2022](https://eprint.iacr.org/2022/1744) for the modern coding-cryptography view of worst-case and average-case decoding and the relationship to LPN.
- [Guruswami--Vardy 2005](https://arxiv.org/abs/cs/0405005) and [Koetter--Vardy 2003](https://www.site.uottawa.ca/~zhcheng/RS_soft_decision.pdf) remain relevant near misses: strong proper/soft decoding technology, but not the all-marginals source plus improper target hardness combination.

## Depth 6 Attempt: P-Specific Preprocessing Stress Test

### Verdict

RESOLVED: no.

I think the proposed "fix a marginal $P$ and use unbounded $P$-specific preprocessing to build all needed clean-trace menus" breaks as a proof of the atlas edge. The fatal flaw is a model mismatch plus a label-information mismatch:

1. the atlas target allows a $P$-dependent polynomial bound, not a separate unbounded advice object or separate learner for each $P$; and
2. the clean traces needed by fixed-slack agnostic boosting are not determined by $P$. They depend on the hidden comparator and on the realized label noise.

If one literally grants arbitrary unbounded $P$-specific advice, the statement may become true in a different and much stronger nonuniform-advice model, but then the computation has been moved into free advice. That would not resolve this implication.

### What Legal Marginal-Nonuniformity Gives

The target node says: for every marginal $P$ there is a polynomial

$$
p_P(s,1/\varepsilon,\log(1/\delta))
$$

bounding the runtime and sample size of one uniform learner. The polynomial may depend on $P$, but the learner is not given a separate algorithm, oracle, transcript table, or infinite preprocessing result for that $P$. The edge note says the same thing: $p_P$ cannot depend on the conditional labels, the hidden comparator, $\varepsilon$, or $\delta$.

Thus "unbounded preprocessing" is already outside the node if it is not charged to the eventual runtime. At most, one can interpret it as a thought experiment: maybe for each fixed $P$ there is some very expensive offline search which discovers a finite data structure, and once that data structure is known the online learner runs in $p_P$ time. But then the data structure must either be part of the uniform algorithm's computable behavior within $p_P$, or it is extra nonuniform advice. Those are different models.

### Why P-Only Menus Cannot Know Clean Traces

Let the source weak learner have additive tolerance

$$
\beta=1/2-\gamma.
$$

It is only forced to give signal on weak-call distributions with $\operatorname{OPT}_{\mathcal C}<\gamma$. Fixed-slack boosting tries to create such calls from a noisy agnostic distribution. The expensive part is finding a label-conditioned view in which the comparator's labels are clean enough.

Now fix a marginal $P$, a concept $c\in\mathcal C$, and independent classification noise

$$
Y=c(X)Z,\qquad \Pr[Z=-1]=\eta,
$$

where $\gamma<\eta<1/2$. The target must still get error near $\eta$, but every transformation that is determined by $P$ and the unlabeled $X$ values preserves the same noise rate $\eta$. Such a transformation never creates a query with $\operatorname{OPT}_{\mathcal C}<\gamma$. A source learner is therefore allowed to return junk on all of these calls.

To get below $\gamma$, the preprocessing must use labels. But the useful label events are comparator-relative: a tuple is "clean" when its observed labels agree with $c$ on the tuple. For fixed $P$, the identities of those clean tuples are fresh conditional-label information. They are not encoded in the marginal.

This is the core flaw in the claimed positive route. A $P$-specific menu can list geometric conditionings, reweightings, subsets, kernels, or sample transformations. It cannot preselect which observed labeled tuples are clean for an unknown $c$ under an unknown conditional distribution.

### Universal Clean-Trace Menus Are Too Strong

The natural repair is to build a universal $P$-menu covering all possible clean traces. That repair is exactly where the known fixed-slack boosters pay the exponential-looking cost.

Suppose a clean witness has size $m_0(s)$. A universal menu over labeled traces has at least the flavor of enumerating

$$
(x_1,y_1),\ldots,(x_{m_0},y_{m_0})
$$

patterns, or an equivalent family of residual tests/selectors. If $m_0(s)$ grows with representation size, the number of possible label patterns alone is $2^{m_0(s)}$, and the number of possible instance traces can be far larger. A $P$-dependent polynomial may hide constants depending on $P$, but it cannot hide a degree or exponent growing with $s$.

A compressed version of this universal menu would be a major new structure theorem. It would say that for every fixed $P$, all comparator-relative clean-trace information needed for boosting can be represented by a polynomial-size menu or by a polynomial-time selector. But such a selector is already doing the hard agnostic work: from noisy labeled data, it must find a comparator-correlated residual even when the ambient noise is above the weak threshold $\gamma$.

So there are two cases:

- The $P$-menu is polynomial-size and label-independent. Then independent noise above $\gamma$ blocks it.
- The menu somehow contains a polynomial-time label-dependent selector. Then the selector is an additional agnostic-learning primitive, not a consequence of the weak source guarantee.

### Black-Box Stress Test

This can be sharpened as a black-box obstruction. Imagine using the source learner only through its guaranteed behavior. Define an adversarial valid weak learner $A$ as follows:

- if the query distribution has $\operatorname{OPT}_{\mathcal C}<\gamma$, return a hypothesis satisfying the weak guarantee;
- otherwise return an arbitrary fixed hypothesis.

This $A$ satisfies the source node. A booster whose preprocessing is only $P$-dependent must force at least one query with $\operatorname{OPT}_{\mathcal C}<\gamma$. Under the independent-noise distribution above, no label-independent $P$ preprocessing does this. Therefore any generic proof must either:

1. construct genuinely label-dependent low-noise queries without already solving the hard residual search, or
2. use behavior of the weak learner outside its source guarantee.

Neither is supplied by marginal-nonuniformity.

This is not an atlas separation, because a real weak learner for a real class may behave better than the adversarial oracle. But it breaks the proposed proof strategy: $P$-specific preprocessing alone cannot be the missing ingredient.

### What If Unbounded Advice Is Literally Allowed?

If the claimant means literal unbounded free advice for each $P$, there are two subcases.

First, if the advice is only a polynomial-size object with polynomial-time access, then the previous obstruction still applies. The advice has to be a $P$-only residual-exposure menu, cover, compression scheme, or selector. That is a sufficient extra hypothesis, but I see no way to derive it from distribution-free fixed-slack weak agnostic learning.

Second, if the advice can be arbitrarily large or can answer arbitrary transcript queries for free, then it can encode far more than a marginal-dependent runtime constant. For a finite-sample-complexity class, such advice could encode an ERM oracle or a map from every possible labeled sample transcript to a near-optimal hypothesis under $P$. That would make the target plausible by brute nonuniformity, but it changes the node into a distribution-specific advice model closer to "sample-efficient with free computation/advice." It would prove too much and would not address the computational edge recorded in the atlas.

### Can The Claim Be Made To Work In The Atlas Model?

I do not see a path without adding a real structural assumption. A correct positive theorem would need something like:

For every fixed $P$ and every representation size $s$, there is a uniformly computable polynomial-size menu $\mathcal M_{P,s,\varepsilon}$ such that for every conditional label distribution over $P$ and every current predictor with excess error, some menu item constructs a weak-call distribution with $\operatorname{OPT}_{\mathcal C}<\gamma$ and an empirically checkable descent direction.

That statement would indeed let the distribution-free weak source boost to the marginal-nonuniform target. But it is exactly the residual-exposure menu lemma from depth 4, and it is not implied by the source definition as far as I can tell.

### Concrete Obstacle For The Next Branch

The best way to turn this stress test into a theorem would be to formalize a lower bound against polynomial $P$-only residual-exposure menus. The cleanest version would be an oracle or adversarial-label construction showing:

- every polynomial $P$-only menu leaves some high-noise comparator distribution with all menu-induced calls above the weak threshold; but
- the class still has a distribution-free fixed-slack weak learner by some separate low-noise mechanism.

The remaining hard part is the second bullet. This is the same threshold-decoding tension from depth 5: a real atlas separation needs a public all-marginals low-noise weak predictor and one fixed-marginal high-noise improper prediction hardness result for the same class.

So this follow-up does break the overstrong "unbounded $P$ preprocessing solves it" claim, but it does not resolve the original edge.

## Depth 7 Attempt: Final Marginal Boosting/Decoding Check

### Verdict

RESOLVED: no.

I did not find a theorem that converts the atlas source, namely distribution-free fixed-additive weak agnostic improper learning, into marginal-nonuniform strong agnostic improper learning. I also did not find a standard threshold-decoding separation whose positive side satisfies the distribution-free source.

The final state is that the edge should remain open, with a sharper citation trail and a sharper near-miss: the closest new separation theorem is a restricted weak-learning threshold separation from calibrated-multiaccuracy work, but its easy side is fixed-marginal rather than distribution-free.

### Positive-Theorem Check

The modern agnostic-boosting theorems still do not appear to match the atlas endpoint.

Kalai--Mansour--Verbin/Feldman-style agnostic boosting uses a correlation-threshold weak learner. In the notation of Casacuberta--Gopalan--Kanade--Reingold, an $(\alpha,\beta)$ weak agnostic learner can be boosted to a hypothesis with correlation at least

$$
\max_{c\in \mathcal C}\operatorname{corr}(c,Y)-\alpha-\varepsilon.
$$

Thus a fixed $\alpha$ leaves a fixed residual $\alpha$. Strong agnostic learning follows only when weak learning is available as $\alpha\to 0$, with $\beta=\operatorname{poly}(\alpha)$ or similar quantitative control. The atlas source is instead fixed-additive:

$$
\operatorname{err}(h)\le \operatorname{OPT}_{\mathcal C}+\beta_0
$$

for one fixed $\beta_0<1/2$. In correlation form, this only forces useful behavior above one fixed correlation threshold. It does not provide the small-$\alpha$ oracle required by the known boosters.

Feldman's distribution-specific agnostic boosting still preserves the marginal, which is useful for this edge, but it again assumes a weak learner at the relevant residual scale. Marginal-nonuniformity does not supply that scale; the polynomial $p_P$ may depend on $P$, but the learner must work uniformly over all conditional label distributions with that marginal.

The 2025/2026 da Cunha--Hogsgaard--Paudice line remains the closest algorithmic positive result. The January 2026 version advertises near-optimal sample complexity and running time polynomial in the sample size when the other parameters are fixed. That is not enough for this atlas edge if the weak-sample or capacity parameters grow with the representation size $s$. In the existing scratchpad language, the clean-tuple or residual-exposure search still has representation-dependent exponents.

The calibrated-multiaccuracy theorem is also not a direct positive theorem. It says that if one can construct a predictor that is both $\tau$-multiaccurate and $\tau$-calibrated, then thresholding it gives strong agnostic learning up to $O(\tau)$. But obtaining such predictors from weak agnostic learning again requires a $(\tau,\operatorname{poly}(\tau))$ weak learner. A fixed-additive source only gives a fixed threshold, so this route also stalls at a fixed residual.

### Threshold-Decoding Separation Check

The closest standard-looking separation I found is Theorem 6.5 of Casacuberta--Gopalan--Kanade--Reingold, "How Global Calibration Strengthens Multiaccuracy." It uses a PRF block plus a list-decodable-code block. For every fixed $\alpha\in(0,1)$, it builds a marginal $D_{\mathcal X_n}$ and class $\mathcal C_n$ such that:

- if some concept has correlation at least $\alpha+\varepsilon$, a proper random-sample learner recovers correlation at least $\alpha$ in time $\operatorname{poly}(n,1/\varepsilon)$ under that marginal;
- under a PRF assumption, no efficient learner, even improper and with membership queries, is an $(\alpha,\beta)$ weak agnostic learner for $\beta\ge 2\alpha/T(n)$ under the same fixed marginal.

This is exactly the kind of "easy above one threshold, hard below another threshold" phenomenon the previous depths were hunting for. It is built from a public list-decodable code and a pseudorandom hidden block, so it is much closer than ordinary LPN or nearest-codeword hardness.

However, it does not satisfy the atlas source. The positive theorem is only for distributions with the specially chosen marginal $D_{\mathcal X_n}$, where enough probability mass lands on the code-coordinate block $E$ to recover the PRF seed by list decoding. The atlas source is distribution-free. If an arbitrary source marginal concentrates on the PRF block $F$, then a low-noise distribution labeled by $f_r$ would require the weak learner to predict the PRF from random examples. Under the same PRF assumption, that is exactly what should be hard. So the theorem gives a fixed-marginal restricted weak separation, not a distribution-free fixed-additive source-positive class.

This also clarifies why the earlier public-handle and threshold-decoding attempts failed. If the public easy block is made visible enough to decode under the hard marginal, arbitrary source marginals can hide that block and force prediction on the cryptographic block alone. If the easy block is required to work under all marginals, it becomes a genuine arbitrary-weight, sample-local low-noise decoder, and I found no standard code-based assumption providing high-noise improper prediction hardness for the same public family.

### Standard Coding/Crypto Assumptions

The standard assumptions still split the wrong way for this edge.

Worst-case maximum-likelihood or nearest-codeword hardness, including preprocessing-resistant variants, is not an improper PAC prediction lower bound under one fixed marginal. It rules out finding a nearest codeword in worst-case received words; it does not rule out outputting an arbitrary predictor with enough future-label correlation.

LPN/parity gives the right fixed-marginal improper prediction hardness, but it is already hard at low constant noise. Therefore it cannot satisfy the atlas source: a distribution-free fixed-additive weak learner for parities below a fixed low-noise threshold would distinguish noisy parity from random labels.

Channel/list-decoding thresholds give public easy-below-threshold algorithms, but they are usually full-block or fixed-channel decoding statements. They do not provide the arbitrary-marginal, random-sample, low-noise weak learner required by the source, nor do they give a high-noise improper prediction hardness theorem under one fixed marginal.

PRF plus list-decodable-code separations give a real restricted-threshold phenomenon, but currently only with a fixed marginal. Making the positive side distribution-free appears to require solving the same arbitrary-weight low-noise decoding problem that previous branches isolated.

### Atlas-Ready Summary

Open. No known theorem turns a distribution-free fixed-additive weak agnostic improper learner into marginal-nonuniform strong agnostic improper learning. Existing agnostic boosters either require a weak learner at accuracy scale $\tau$ for every $\tau>0$, leave a fixed residual, or have running time with representation-dependent weak-sample/capacity parameters in the exponent. Marginal-nonuniformity lets the polynomial bound depend on the instance marginal $P$, but it does not provide label-conditional clean traces or a small-threshold weak oracle uniformly over all label conditionals with that marginal.

No standard separation currently settles the edge. LPN/parity gives fixed-marginal improper hardness but fails the low-noise source. Worst-case decoding hardness is not fixed-marginal improper PAC prediction hardness. Public channel/list decoding gives easy decoding below thresholds but not arbitrary-marginal sample-local weak learning plus high-noise improper hardness. The closest result is the PRF/list-decodable-code restricted weak-learning separation of Casacuberta--Gopalan--Kanade--Reingold, but its positive side is fixed-marginal; arbitrary source marginals concentrated on the PRF block would violate the distribution-free source.

Thus the edge should remain `open`. A true proof would need a fully polynomial fixed-threshold-to-small-threshold agnostic booster or a same-marginal residual-exposure lemma. A false proof would need a source-positive class with a public all-marginals low-noise weak decoder and one fixed marginal where high-noise improper prediction is hard.

### Sources Checked

- [Kalai--Mansour--Verbin 2008](https://doi.org/10.1145/1374376.1374466) and [Feldman 2010](https://arxiv.org/abs/0909.2927) for the correlation-threshold and distribution-specific agnostic boosting formulations.
- [da Cunha--Hogsgaard--Paudice 2025/2026](https://arxiv.org/abs/2503.09384) and [da Cunha--Hogsgaard--Paudice 2026](https://arxiv.org/abs/2601.11265) for the current sample-complexity and improved-runtime frontier.
- [Casacuberta--Gopalan--Kanade--Reingold 2026](https://arxiv.org/abs/2504.15206), especially Theorem 6.5, for the closest PRF/list-decodable-code restricted weak-learning threshold separation.
- [Debris-Alazard--Resch 2022](https://eprint.iacr.org/2022/1744), [Blum--Kalai--Wasserman 2003](https://doi.org/10.1145/792538.792543), and Guruswami--Sudan/list-decoding references for the decoding/LPN side of the check.

## Depth 8 Final Incorporation Recommendation

### Verdict

RESOLVED: no.

The atlas edge should remain `open` with `evidence: unknown`. The depth-1 halfspace/Tiegel false attempt is not atlas-sound under the fixed-additive source interpretation, and depths 2--7 found neither a fully polynomial fixed-slack agnostic booster nor a standard conditional separation satisfying the distribution-free source.

### Suggested Frontmatter Update

For `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac.md`, keep the stable `id`, `source`, `target`, notes, tags, and `status: "open"`. Suggested changed fields:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - bendavid2001
  - kalai2008agnosticboosting
  - feldman2010distributionspecific
  - ghai2025agnosticboosting
  - dacunha2026agnosticboosting
  - casacuberta2026globalcalibration
refs:
  - "[Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)"
  - "[Kalai, Mansour, and Verbin 2008](https://doi.org/10.1145/1374376.1374466)"
  - "[Feldman 2010](https://arxiv.org/abs/0909.2927)"
  - "[Ghai and Singh 2025](https://proceedings.mlr.press/v267/ghai25a.html)"
  - "[da Cunha, Hogsgaard, and Paudice 2026](https://arxiv.org/abs/2601.11265)"
  - "[Casacuberta, Gopalan, Kanade, and Reingold 2026](https://arxiv.org/abs/2504.15206)"
summary: "Open: no known theorem turns distribution-free fixed-additive weak agnostic improper learning into marginal-nonuniform strong agnostic improper learning. Known boosters need tunable weak accuracy or have weak-sample/capacity parameters in representation-dependent exponents, while threshold-decoding and P-specific preprocessing templates remain near misses rather than atlas-valid separations."
```

`kalai2008agnosticboosting` already exists in `references.bib` and is worth adding because the body now discusses the correlation-threshold booster explicitly. `casacuberta2026globalcalibration` should be added to `references.bib` before adding it to `ref_keys`; it is the closest restricted threshold-separation reference, but it is not itself a resolution of this edge. If avoiding a new BibTeX entry for now, leave the Casacuberta et al. item only in prose/Markdown refs and omit it from `ref_keys`.

### Suggested Body Replacement

Replace the current `## Proof Status` section with the following:

```markdown
## Proof Status

**Goal.** Decide whether a distribution-free fixed-additive weak agnostic improper learner can always be converted into a strong agnostic improper learner whose polynomial resource bound may depend on the instance marginal $P$.

**Fixed-slack source.** Let the source tolerance be $\beta=1/2-\gamma$ for a fixed constant $\gamma>0$ in the source definition. The weak learner is forced to be useful only on query distributions with $\operatorname{OPT}_{\mathcal C}<\gamma$. In correlation language, it supplies a fixed-threshold oracle, not a family of weak learners whose threshold can be driven to $0$ with the final accuracy parameter $\varepsilon$.

**Known boosters do not match this endpoint.** Ben-David--Long--Mansour and the Kalai--Mansour--Verbin/Feldman line show how to boost suitable agnostic weak learners, including in distribution-specific or same-marginal settings. But the available correlation-threshold formulations either leave a fixed residual when the threshold is fixed, or require weak learning at accuracy scale $\tau$ for arbitrarily small $\tau$. The later Ghai--Singh and da Cunha--Hogsgaard--Paudice improvements are close algorithmically, but their clean-witness, weak-sample, or capacity parameters can enter the running time in exponents that grow with the representation size. That is not an atlas-polynomial implication from the fixed-additive source alone.

**Why marginal-nonuniformity does not remove the obstacle.** The target allows a polynomial $p_P$ depending on the marginal $P$, but the same learner and the same $p_P$ must work for every conditional label distribution over that marginal. The expensive information in fixed-slack boosting is label-conditional: one must expose clean or low-noise residual views relative to an unknown comparator. A $P$-specific preprocessing menu can depend on geometry or unlabeled mass, but it cannot know which labeled traces are clean for the hidden comparator. If the menu is label-independent, uniform noise above the weak threshold blocks it; if it contains a label-dependent residual selector, that selector is an additional agnostic-learning primitive rather than a consequence of the source node.

**Threshold-decoding near miss.** A plausible false direction would be a public code-like class with an all-marginals low-noise weak decoder below some fixed threshold, but with one fixed marginal where high-noise improper prediction remains hard. Standard assumptions do not currently give this combination. LPN/parity gives fixed-marginal improper prediction hardness but is already hard in the low-noise regime, so it fails the source. Worst-case nearest-codeword or maximum-likelihood decoding hardness is not a fixed-marginal improper PAC prediction lower bound. Public channel/list-decoding gives easy decoding below thresholds, but not arbitrary-marginal sample-local weak learning plus high-noise improper hardness for the same class.

**Restricted threshold separations.** The closest known separation template is the PRF/list-decodable-code threshold phenomenon in Casacuberta--Gopalan--Kanade--Reingold's calibration/multiaccuracy work. It shows that fixed-marginal weak learning can have threshold behavior, even against improper learners. However, its positive side is tied to a special marginal with mass on a decodable public block. The atlas source is distribution-free; an arbitrary source marginal can concentrate on the cryptographic block, where the same PRF assumption should prevent even weak prediction. Thus this is an important near miss, not a counterexample.

**Conclusion.** Keep the edge open. A true proof would need a fully polynomial fixed-threshold-to-small-threshold agnostic booster, or a same-marginal residual-exposure theorem that extracts low-noise weak calls from the fixed-additive source without representation-dependent trace enumeration. A false proof would need a source-positive class with public all-marginals low-noise weak decoding and one fixed marginal where high-noise improper prediction is hard. Neither ingredient is currently known.
```

### Suggested References Section

Replace `## References` with:

```markdown
## References

- [Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)
- [Kalai, Mansour, and Verbin 2008](https://doi.org/10.1145/1374376.1374466)
- [Feldman 2010](https://arxiv.org/abs/0909.2927)
- [Ghai and Singh 2025](https://proceedings.mlr.press/v267/ghai25a.html)
- [da Cunha, Hogsgaard, and Paudice 2026](https://arxiv.org/abs/2601.11265)
- [Casacuberta, Gopalan, Kanade, and Reingold 2026](https://arxiv.org/abs/2504.15206)
```

### Incorporation Notes

The existing edge note is already broadly accurate, so this recommendation is a refinement rather than a status change. The most important additions are:

- explicitly distinguish fixed-additive weak agnostic learning from tunable correlation-threshold weak learning;
- record that `P`-specific preprocessing is not enough because clean traces are conditional-label information, not marginal information;
- record the threshold-decoding/coding-theory separation template as the best false direction, while saying why LPN, worst-case decoding, and public list decoding each miss an atlas requirement;
- cite Casacuberta--Gopalan--Kanade--Reingold as the closest restricted fixed-marginal threshold near miss, but not as evidence for `false`.

## Depth 9 Attempt: Final Marginal Fixed-Slack Boosting Search

### Verdict

RESOLVED: no.

I rechecked the edge against the newest fixed-slack boosting theorem and the closest fixed-marginal threshold separation. The edge should remain `open`. The 2026 improved-runtime agnostic booster is very close to a positive solution, but its running time is not polynomial in the atlas representation-sensitive sense when the weak learner's sample size or the dual VC dimension of its output class grows with the representation size. The closest negative construction, from the calibrated-multiaccuracy paper, gives a real fixed-marginal threshold phenomenon under PRF assumptions, but its easy side is not distribution-free.

### Final Positive Check: The 2026 Booster

Let the source tolerance be

$$
\operatorname{err}(h)\le \operatorname{OPT}_{\mathcal C}+\beta,\qquad \beta<1/2.
$$

In correlation notation this gives

$$
\operatorname{corr}(h,Y)\ge \sup_{c\in\mathcal C}\operatorname{corr}(c,Y)-2\beta.
$$

Thus, if one puts the source learner into the da Cunha--Hogsgaard--Paudice framework, it is a nontrivial agnostic weak learner with parameters $\gamma_0=1$ and $\epsilon_0=2\beta$, so $\theta=(\gamma_0-\epsilon_0)/2=(1-2\beta)/2>0$ is a fixed constant. This removes the earlier "tunable slack" objection at the level of statistical learnability: the 2025 `Revisiting Agnostic Boosting` paper proves that any nontrivial weak learner of this correlation form can be statistically boosted, and it explicitly describes the resulting method as not computationally efficient.

The January/February 2026 improved-runtime paper is the decisive test. Its Theorem 2 says that, given a $(\gamma_0,\epsilon_0,\delta_0,m_0)$ agnostic weak learner with output/base class $H$, the boosted classifier achieves an $\operatorname{OPT}$-relative agnostic bound with near-optimal sample dependence. But the same theorem gives at most $O(n^{m_0+3})$ calls to the weak learner and total running time roughly

$$
\operatorname{Eval}_H(1)\cdot n^{O(m_0\cdot \min\{d^\ast,\ln n\}/\theta^2)},
$$

where $d^\ast$ is the dual VC dimension of $H$. The paper emphasizes that the algorithm is polynomial in the sample size when these other parameters are fixed, and also notes that $d^\ast$ can be exponentially large in the primal dimension in the worst case.

For this atlas edge, those "other parameters" are not fixed constants. The source node only promises a weak learner with sample/time polynomial in the representation size $s$ and $\log(1/\delta)$. After setting $\delta_0$ to a constant, $m_0$ may still be $\operatorname{poly}(s)$. The improper output class $H$ is also not part of the source data with a controlled dual VC dimension; an efficient learner may output hypotheses from a high-capacity algorithm-dependent class while its own validation/generalization analysis remains sound. Therefore the 2026 theorem gives, in the worst case, an exponent depending on $s$ or on uncontrolled capacity parameters. That is quasi-polynomial or worse in the target variables, not a polynomial $p_P(s,1/\varepsilon,\log(1/\delta))$ with representation-independent degree.

This is not a mere bookkeeping issue. If the atlas allowed the marginal-dependent polynomial $p_P$ to hide exponents growing with $m_0(s)$ or $d^\ast(s)$, then the target model would become much closer to fixed-marginal nonuniform advice than to computationally efficient PAC learning. The target definition explicitly keeps one uniform learner and one polynomial per marginal whose degree cannot vary with the representation size. So the newest booster gives a strong restricted positive theorem, not a resolution:

> If the source weak learner can be represented with constant weak-sample parameter $m_0$ and constant, or otherwise representation-uniformly bounded, dual capacity for the output class used by the booster, then da Cunha--Hogsgaard--Paudice's 2026 algorithm boosts it to the strong agnostic improper target, indeed distribution-free. The present source node does not imply those bounded-parameter hypotheses.

### Why Marginal Nonuniformity Still Does Not Save The Runtime

The marginal-nonuniform target lets the resource polynomial depend on the instance marginal $P$, but it does not give a separate learner, advice oracle, or conditional-label transcript table for each $P$. The same learner must handle every conditional label distribution over that marginal.

The fixed-slack obstruction remains label-conditional. Suppose $X\sim P$, $Y=c(X)Z$, and $\Pr[Z=-1]=\eta$ with $\eta$ above the source threshold but below $1/2$. Any reweighting or preprocessing determined only by $P$ and unlabeled samples preserves this independent noise rate, so it does not create a weak-call distribution with $\operatorname{OPT}<1/2-\beta$. To get such a call, the algorithm needs a label-dependent selector that finds clean or low-noise traces relative to the hidden comparator $c$. Those traces are not properties of $P$.

This also explains the $n^{m_0}$ term in the 2026 theorem: the algorithm has to search over finite traces large enough to simulate a clean weak call. When $m_0$ grows with $s$, marginal-dependent runtime cannot absorb that exponent in the atlas model. A $P$-specific polynomial may have constants depending on $P$, but it cannot turn exhaustive enumeration over $\operatorname{poly}(s)$-sized clean traces into polynomial time in $s$ and $1/\varepsilon$.

### Final Negative Check: The Closest Threshold Separation

The closest false direction remains the PRF/list-decodable-code construction of Casacuberta--Gopalan--Kanade--Reingold, `How Global Calibration Strengthens Multiaccuracy`, last revised February 2026. Their overview and Theorem 6.5 give, under PRF assumptions, a concept class and a special marginal $D_X$ such that for every $\alpha\in(0,1)$:

- under marginals equal to $D_X$, the class is efficiently $(\alpha+\varepsilon,\alpha)$ weak agnostically learnable by recovering a hidden seed from an error-correcting-code block; and
- under the same fixed marginal, no efficient algorithm, even with strong query access in their formulation, can push the weak threshold below $\alpha$ without predicting a PRF block.

This is exactly the threshold behavior a separation would like to exploit. It is also exactly where the atlas source fails. Their positive learner uses the special marginal's mass on the public code block $E$ to list-decode the PRF seed. A distribution-free source learner would have to work for arbitrary marginals, including marginals concentrated on the PRF block $F$. On such a marginal, even low-noise weak prediction would amount to predicting the pseudorandom function from samples, contradicting the same PRF assumption. Thus this construction is a fixed-marginal restricted weak-learning separation, not a source-positive counterexample to this edge.

The other standard negative templates are still blocked for the same reasons recorded in depths 2--8:

- LPN/parity gives fixed-marginal improper prediction hardness, but it is already hard at low constant noise, so a distribution-free fixed-slack source learner would break the assumption.
- Worst-case nearest-codeword or maximum-likelihood decoding hardness, including preprocessing-resistant versions, does not rule out sample-based improper predictors with correlation under one fixed marginal.
- Public channel/list-decoding thresholds give easy decoding below a channel radius, but not an arbitrary-marginal, sample-local weak learner plus high-noise improper prediction hardness for the same public class.

### Atlas-Suitable Final Obstacles And Directions

The edge should stay `status: "open"` and `evidence: unknown`. I would not propose a `false` witness or a `true` theorem in the atlas.

The most precise positive direction is now:

> Prove a representation-uniform version of the 2026 fixed-slack booster, replacing the $n^{m_0}$ and $n^{O(m_0d^\ast)}$ clean-trace search by a polynomial generator whose exponent is independent of the weak learner's sample size and output-class capacity. Equivalently, prove a same-marginal residual-exposure lemma that constructs low-$\operatorname{OPT}$ weak calls from noisy data without enumerating comparator-clean traces.

The most precise negative direction is:

> Build a public threshold-decodable concept class with two simultaneous properties: below a fixed noise threshold it has a distribution-free, arbitrary-marginal, sample-local weak decoder; above that threshold, one fixed samplable marginal is hard even for improper prediction. The Casacuberta--Gopalan--Kanade--Reingold PRF/code construction shows the fixed-marginal threshold phenomenon, but not the distribution-free source-positive side.

The most useful restricted-positive atlas note would be:

> If an edge instance carries an additional bounded-parameter weak learner, for example constant $m_0$ and constant dual VC dimension for the weak output class, then the da Cunha--Hogsgaard--Paudice 2026 theorem appears to give a fully efficient strong agnostic improper learner. This is a structural add-on, not a consequence of `efficient-weak-agnostic-improper-pac`.

### Sources Rechecked

- [da Cunha, Hogsgaard, and Paudice 2026](https://arxiv.org/abs/2601.11265), especially Theorem 2 and its running-time bound $n^{O(m_0\min\{d^\ast,\ln n\}/\theta^2)}$.
- [da Cunha, Hogsgaard, Paudice, and Sun 2025](https://arxiv.org/abs/2503.09384), especially Theorem 1.3 and the statement that the statistically near-optimal method is not computationally efficient.
- [Casacuberta, Gopalan, Kanade, and Reingold 2026](https://arxiv.org/abs/2504.15206), especially the restricted weak agnostic learning discussion and Theorem 6.5/overview Theorem 2.3.
- [Feldman 2010](https://arxiv.org/abs/0909.2927), [Kalai--Mansour--Verbin 2008](https://doi.org/10.1145/1374376.1374466), and [Ghai--Singh 2025](https://proceedings.mlr.press/v267/ghai25a.html) for the tunable-threshold and distribution-specific boosting context.
