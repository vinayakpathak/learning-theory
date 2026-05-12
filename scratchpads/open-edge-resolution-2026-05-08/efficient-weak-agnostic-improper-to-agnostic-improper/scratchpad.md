# Scratchpad: Efficient Weak Agnostic Improper PAC -> Efficient Agnostic Improper PAC

Edge file: `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-agnostic-improper-pac.md`

Depth log starts at depth 1 from the main agent's depth 0.

## Current Verdict

Unresolved at launch.

## Depth 1 Attempt

### Candidate Resolution: Conditional False via Affine Parities, If The Edge's Inverse-Polynomial Gap Statement Is Authoritative

I found a plausible resolution of the edge as **conditionally false**, but it depends on a definitional point that should be checked before editing the atlas.

The edge file's theorem statement formulates the source as

$$
\operatorname{err}(h) \le \operatorname{OPT}_{\mathcal C} + \frac12-\gamma(s)
$$

for an inverse-polynomial weak gap $\gamma(s)>0$. Under that formulation, affine parities over $\{0,1\}^n$ give a clean counterexample under the standard decision-LPN hardness assumption. If instead the atlas intends the source definition's phrase "fixed additive weak-agnostic tolerance" to mean a representation-independent constant gap $1/2-\beta=\Omega(1)$, then this parity witness does **not** resolve the edge; it only resolves the inverse-polynomial-gap variant.

#### Sources Checked

- The endpoint definition note `efficient-weak-agnostic-improper-pac.md` says the weak agnostic guarantee is $\operatorname{OPT}+\beta$ for fixed $\beta<1/2$, with polynomial dependence on $1/(1/2-\beta)$ if the weak advantage is parameterized.
- The edge note itself states the source using an inverse-polynomial $\gamma(s)$.
- Kalai, Mansour, and Verbin describe agnostic learning of parities and recall the Ben-David--Long--Mansour additive weak agnostic definition. In their STOC 2008 paper, they explicitly state that Ben-David et al. define a weak agnostic learner by error at most $\operatorname{opt}_D(C)+\beta$ for $\beta<1/2$, and that Gavinsky's boosting of this notion only reaches roughly $\operatorname{opt}/(1/2-\beta)+\varepsilon$, not $\operatorname{opt}+\varepsilon$. They also state that learning parity with random classification noise under the uniform distribution is commonly believed hard and is the benchmark LPN problem. Primary source: [Kalai--Mansour--Verbin 2008](https://doi.org/10.1145/1374376.1374466), accessible copy at Microsoft Research.
- Blum, Kalai, and Wasserman study learning parity with random classification noise and give the classic subexponential BKW algorithm; this is the standard reference for the LPN problem. Primary source: [Blum--Kalai--Wasserman 2003](https://doi.org/10.1145/792538.792543).
- The newer agnostic boosting papers clarify the quantitative mismatch. Ghai--Singh 2025 gives efficient boosting with a residual proportional to the weak oracle tolerance, while da Cunha--Moller Hogsgaard--Paudice 2026 gives a residual-free fixed-parameter algorithm whose runtime is polynomial in the sample size only when weak-learner parameters are fixed. The da Cunha et al. theorem has runtime of the form roughly $n^{O(m_0\min\{d^*,\log n\}/\theta^2)}$, which is not representation-uniform polynomial when $m_0$ and $1/\theta$ are polynomial in $n$. Primary sources: [Ghai--Singh 2025](https://proceedings.mlr.press/v267/ghai25a.html), [da Cunha et al. 2026](https://arxiv.org/abs/2601.11265).

#### Witness Class

Let $\mathcal C_n$ be the class of affine parities

$$
c_{a,b}(x) = a\cdot x \oplus b,\qquad a\in\{0,1\}^n,\ b\in\{0,1\}.
$$

This class includes both constant classifiers. The representation size is $s=\Theta(n)$.

#### Why The Weak Agnostic Source Holds With An Inverse-Polynomial Gap

Goal: build an efficient improper, in fact proper, weak agnostic learner with

$$
\operatorname{err}(h)\le \operatorname{OPT}_{\mathcal C}+\frac12-\gamma(n)
$$

for $\gamma(n)=1/\operatorname{poly}(n)$.

Construction:

1. Fix a realizable PAC subroutine for affine parities: on a realizable sample, solve the linear system over $\mathbb F_2$ and output any consistent affine parity. By the VC/generalization bound for a class of VC dimension $n+1$, a sample of
   $$
   m_0=O(n+\log(1/\delta_0))
   $$
   suffices for any fixed clean accuracy, say $1/16$, and constant confidence.

2. Set $\gamma(n)=1/(16m_0)$, up to harmless constant-factor slack.

3. On agnostic examples from $\mathcal D$, generate polynomially many candidate hypotheses:
   - the two constants;
   - affine parities obtained by running Gaussian elimination on many fresh batches of size $m_0$, pretending the batch is realizable whenever the sampled equations are consistent.

4. Use a fresh validation sample to output the candidate with smallest empirical error.

Analysis:

Let $\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D)$ and let $c^\star$ be a best affine parity.

If $\eta\ge \gamma(n)$, one of the constants has error at most $1/2$, hence

$$
\operatorname{err}(\text{best constant})\le \frac12\le \eta+\frac12-\gamma(n).
$$

If $\eta<\gamma(n)$, then a fresh batch of size $m_0$ is entirely clean relative to $c^\star$ with probability at least

$$
1-m_0\eta > 1-m_0\gamma(n),
$$

which is bounded below by a positive constant for the chosen $\gamma(n)$. Conditioned on this clean-batch event, the examples are i.i.d. from a conditional marginal $Q$ and are realizable by $c^\star$. The Gaussian-elimination learner therefore returns, with constant probability, an affine parity $h$ whose clean error under $Q$ is at most $1/16$.

The clean conditional marginal $Q$ is close to the original marginal $P=\mathcal D_X$:

$$
\operatorname{TV}(P,Q)\le \frac{\eta}{1-\eta}=O(\gamma(n)).
$$

Thus $h$ has clean error at most $1/16+O(\gamma(n))$ under $P$, and hence label error at most

$$
\eta + \frac1{16}+O(\gamma(n))
\le \eta+\frac12-\gamma(n)
$$

for all sufficiently large $n$ after adjusting constants. Repetition and validation make the success probability $1-\delta$ with polynomial samples and time.

This is just the low-noise clean-batch robustification specialized to affine parities. It does not give a constant weak gap.

#### Why The Strong Agnostic Improper Target Fails Under Decision-LPN

Assume the standard decision-LPN hardness assumption for constant classification noise: no randomized polynomial-time algorithm distinguishes samples

$$
(X, a\cdot X\oplus b\oplus N)
$$

with $X$ uniform on $\{0,1\}^n$, a uniformly hidden affine parity $(a,b)$, and $N\sim\operatorname{Bernoulli}(\eta_0)$ for some fixed $\eta_0<1/2$, from uniformly random labels.

Suppose an efficient agnostic improper PAC learner for affine parities existed. Run it with accuracy

$$
\varepsilon < \frac{1/2-\eta_0}{4}.
$$

On LPN samples, $\operatorname{OPT}_{\mathcal C}=\eta_0$, so with high probability the learner outputs a binary hypothesis $h$ with

$$
\operatorname{err}(h)\le \eta_0+\varepsilon < \frac12-\Omega(1).
$$

Use a fresh validation set from the same source to estimate the error of $h$. On true LPN samples, the validation error is below $1/2-\Omega(1)$. On random-label samples, every fixed output hypothesis has validation error concentrated around $1/2$. Therefore the strong agnostic learner would distinguish LPN from random labels in randomized polynomial time, contradicting decision-LPN hardness.

This reduction uses only the uniform marginal, so it refutes the distribution-free strong target.

#### Exact Atlas Update If This Resolution Is Accepted

For `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-agnostic-improper-pac.md`:

```yaml
status: "false"
evidence: conditional-counterexample
assumptions:
  - "decision-LPN hardness for affine parities with constant classification noise"
witnesses:
  - "affine parities"
ref_keys:
  - blum2003
  - kalai2008agnosticboosting
summary: "False under decision-LPN hardness, if the weak agnostic source allows an inverse-polynomial gap: affine parities have an efficient inverse-polynomial-gap weak agnostic learner by clean-batch Gaussian elimination and validation, but a strong agnostic improper learner would distinguish constant-noise LPN from random labels."
family: lpn-parity-hardness
```

The repo does not currently appear to have a `blum2003` BibTeX key. Suggested addition to `references.bib` if the main agent accepts this update:

```bibtex
@article{blum2003,
  author = {Blum, Avrim and Kalai, Adam and Wasserman, Hal},
  title = {Noise-Tolerant Learning, the Parity Problem, and the Statistical Query Model},
  journal = {Journal of the ACM},
  volume = {50},
  number = {4},
  pages = {506--519},
  year = {2003},
  doi = {10.1145/792538.792543}
}
```

#### Caveat / If Not Accepted

If the atlas source node is interpreted as requiring a representation-independent constant weak agnostic gap, then this is **not** a resolution. The parity clean-batch learner only gives $\gamma(n)=1/\operatorname{poly}(n)$, and for a constant gap it runs into exactly the standard noisy-parity obstacle: for constant LPN noise $\eta_0<1/2$, an $\operatorname{OPT}+1/2-\Omega(1)$ weak learner would itself need nontrivial correlation with the hidden parity and would already break LPN.

In that constant-gap interpretation, the edge remains open for the reasons already recorded in the atlas: efficient observable boosters leave a residual proportional to the fixed slack, while residual-free fixed-slack boosters are not known to be polynomial uniformly in the representation parameters.

## Depth 2 Attempt: Fixed-Slack Booster/Barrier

### Question Pursued

Under the current atlas convention, the source is a fixed-additive weak agnostic learner: for some constant $\beta<1/2$, it returns an improper binary hypothesis with

$$
\operatorname{err}_D(h)\le \operatorname{OPT}_{\mathcal C}(D)+\beta .
$$

The depth-2 question was whether this Ben-David--Long--Mansour style oracle has a fully polynomial fixed-slack agnostic booster to $\operatorname{OPT}+\varepsilon$, or whether known black-box/oracle barriers can be promoted to an atlas separation.

I did not resolve the edge. The best current summary is:

- Old-model agnostic boosting does not give $\operatorname{OPT}+\varepsilon$ from a fixed $\beta$.
- Modern correlation-style agnostic boosting shows the obstruction is not information-theoretic.
- The known residual-free fixed-slack route is statistical, not computational.
- Known black-box lower bounds do not by themselves give an atlas-relevant false edge.

### Primary-Source Check

Ben-David, Long, and Mansour define a $\beta$-weak agnostic learner as one that, on any distribution $P$, outputs a hypothesis whose error is at most $\operatorname{er}_P(F)+\beta$, where the bound may exceed $1/2$. Their COLT 2001 guarantee boosts this only to a non-optimal expression of the form $\max\{c_1(\beta)\operatorname{er}(F)^{c_2(\beta)},\varepsilon\}$, not to $\operatorname{er}(F)+\varepsilon$. Source checked: [Ben-David--Long--Mansour 2001](https://doi.org/10.1007/3-540-44581-1_33), with the accessible Tel Aviv abstract at <https://cris.tau.ac.il/en/publications/agnostic-boosting>.

Gavinsky improves the old-model result but still leaves a multiplicative dependence on the optimum. His upper bound is

$$
\frac{1}{1/2-\beta}\operatorname{err}_D(F)+\zeta,
$$

and the paper explicitly frames this as the final error achievable by that agnostic boosting approach, with a lower bound matching up to a constant factor. This confirms that the smooth/reweighting route from the original $\beta$-optimal oracle cannot settle the atlas edge. Source checked: [Gavinsky 2003](https://www.jmlr.org/papers/v4/gavinsky03a.html).

Kalai, Mansour, and Verbin explain the quantitative mismatch very clearly. They recall the old definition

$$
\operatorname{err}(h)\le \operatorname{OPT}+\beta,
$$

then replace it with an $(\alpha,\gamma)$ weak agnostic learner: if $\operatorname{OPT}\le 1/2-\alpha$, the learner returns error at most $1/2-\gamma$. Their theorem boosts this to

$$
\operatorname{OPT}+\alpha+\varepsilon .
$$

A fixed $\beta$ source implies an $(\alpha,\gamma)$ oracle only when $\alpha>\beta$, with $\gamma\le \alpha-\beta$; otherwise the old guarantee can be above $1/2$. Therefore Kalai--Mansour--Verbin gives a fully polynomial booster only to $\operatorname{OPT}+\alpha+\varepsilon$ for some constant $\alpha>\beta$, not to arbitrary excess error. Source checked: [Kalai--Mansour--Verbin 2008](https://doi.org/10.1145/1374376.1374466), accessible PDF at <https://www.microsoft.com/en-us/research/wp-content/uploads/2016/11/2008-On_Agnostic_Boosting-and_Parity_Learning.pdf>.

The most interesting update comes from da Cunha, Moller Hogsgaard, and Paudice's "Revisiting Agnostic Boosting" formulation. They use a correlation weak learner:

$$
\operatorname{corr}_D(w)\ge \gamma\sup_{f\in F}\operatorname{corr}_D(f)-\varepsilon_0,
$$

and show statistically that any nontrivial gap $\gamma>\varepsilon_0$ can be boosted to strong agnostic learning with nearly optimal sample complexity. This does not immediately solve the atlas edge because the paper explicitly says it only considers the statistical problem and that its relabeling framework requires exponential time.

The fixed-$\beta$ atlas source can be converted into such a constant-gap correlation oracle. Write

$$
\rho=\sup_{c\in\mathcal C}\operatorname{corr}_D(c,Y)=1-2\operatorname{OPT}_{\mathcal C}(D).
$$

The weak source gives, with high probability,

$$
\operatorname{corr}_D(h,Y)\ge \rho-2\beta .
$$

By validating $h$ against a neutral fallback, such as the real-valued zero predictor or the better constant label, one can force a nonnegative output correlation up to validation slack:

$$
\operatorname{corr}_D(w,Y)\gtrsim \max\{0,\rho-2\beta\}.
$$

For every $\rho\in[0,1]$,

$$
\max\{0,\rho-2\beta\}\ge \frac12\rho-\beta.
$$

Thus the atlas source yields a da-Cunha-style oracle with, say, $\gamma=1/2$ and $\varepsilon_0=\beta+o(1)$, leaving constant advantage $\gamma-\varepsilon_0\approx 1/2-\beta>0$. This is a strong indication that the fixed-slack problem is statistically true. It does not supply the required polynomial-time atlas learner, because the available residual-free construction is not computationally efficient. Source checked: [da Cunha et al. 2026 / Revisiting Agnostic Boosting](https://openreview.net/pdf?id=aFf30XJpl4), also listed in the atlas as <https://arxiv.org/abs/2601.11265>.

### Why Existing Efficient Boosters Still Do Not Settle The Edge

The efficient Kalai--Mansour--Verbin style theorem has a residual $\alpha$, and the fixed $\beta$ source only gives usable calls for $\alpha>\beta$. So it cannot push the final error below $\operatorname{OPT}+\beta+o(1)$ by parameter tuning.

The efficient correlation-style boosters surveyed by da Cunha et al., including Ghai--Singh style guarantees, leave a residual proportional to $\varepsilon_0/\gamma$ or otherwise require the weak slack to be at the final accuracy scale. The transformed fixed-$\beta$ oracle has $\varepsilon_0=\Theta(\beta)$, so these algorithms also leave a constant residual.

The residual-free da Cunha et al. route accepts constant $\gamma-\varepsilon_0$, but it relies on enumerating relabelings/hypotheses in a way that is explicitly exponential. Since the atlas edge asks for runtime polynomial in the representation size and $1/\varepsilon$, this is only a sample-complexity resolution, not a computational one.

### Why Existing Barriers Do Not Give A False Atlas Edge

Gavinsky's lower bound is a lower bound for the old agnostic boosting approach based on smooth reweightings of the original labeled distribution. It is not a general oracle separation against all black-box reductions, because Kalai--Mansour--Verbin and the later correlation-oracle framework evade it by changing what weak calls must certify.

A bad-oracle separation also would not be enough for the atlas. The atlas source says the class has some efficient fixed-$\beta$ weak agnostic learner. A black-box construction where an adversarial weak oracle withholds information on medium-noise distributions would only refute universal black-box boosting from every possible weak learner. It would not produce a concept class that is weakly agnostically learnable but not strongly agnostically learnable.

The da Cunha lower bound is statistical and polynomial-scale. It gives near-optimal sample lower bounds for their general weak-oracle framework, but not a superpolynomial computational lower bound and not an explicit representation-based class satisfying the atlas source while violating the atlas target.

### Obstacles

The positive obstacle is computationalizing the statistical fixed-slack theorem. The known path runs a realizable-style learner over many candidate relabelings or clean traces, then validates. For a weak learner with sample complexity $m_0=\operatorname{poly}(s)$, enumerating all size-$m_0$ relabeling traces is not polynomial in $s$.

The negative obstacle is existentiality. To mark the atlas edge false, one needs an explicit class with an efficient distribution-free $\operatorname{OPT}+\beta$ improper learner for every labeled distribution, while every efficient strong agnostic improper learner would break a standard hardness assumption. The usual parity/LPN witness fails exactly here for constant $\beta$: a fixed-gap weak learner on constant-noise LPN distributions would already give nontrivial correlation with the hidden parity.

### Next Directions

1. Try to computationalize the da Cunha/Hopkins relabeling step for weak learners produced by actual algorithms rather than arbitrary sample maps. A useful lemma would replace all relabelings by a polynomial-size validation-searchable menu while preserving one good hypothesis.

2. Look for a cryptographic "neutral fallback plus hidden comparator" class where the fallback gives $\operatorname{OPT}+\beta$ on every distribution, but any $\operatorname{OPT}+\varepsilon$ learner must decode the hidden comparator. Previous public-handle ideas tend to make the improper strong learner easy by sparse ERM, so the class would need a genuinely hard improper benchmark.

3. Formalize a black-box limitation carefully, but keep it separate from atlas status unless it produces an actual class separation. The most plausible barrier statement is: no polynomial-query booster can force fixed-$\beta$ oracles to reveal information on distributions with $\operatorname{OPT}\in(1/2-\alpha,1/2)$ unless it already has a way to generate low-noise relabelings.

### Depth 2 Verdict

RESOLVED: no.

The edge should remain open. The fixed-slack source appears statistically boostable via modern correlation weak learning, but I found no fully polynomial fixed-slack booster and no known black-box/oracle lower bound that can be converted into an atlas-relevant separation.

## Depth 3 Attempt: Black-Box Clean-Tuple Barrier

RESOLVED: no.

### Question Pursued

I tried to make the clean-tuple obstruction into a formal black-box lower bound for the edge

$$
\text{efficient weak agnostic improper PAC}
\Longrightarrow
\text{efficient agnostic improper PAC}.
$$

I interpret the source in the fixed-additive sense from the endpoint definition: there is a constant $\beta<1/2$, equivalently $\gamma_0=1/2-\beta>0$, such that the weak learner only has to beat random prediction when the queried distribution has

$$
\operatorname{OPT}_{\mathcal C}<\gamma_0.
$$

The model I pursued is: on a hard noisy-comparator distribution

$$
X\sim P,\qquad Y=f(X)\oplus N,\qquad N\sim \operatorname{Bernoulli}(\eta),
$$

where $f\in\mathcal C$ and $\gamma_0<\eta<1/2$, the weak learner may legally be neutral on the original distribution. A booster must therefore manufacture a new query distribution whose labels have error below $\gamma_0$ relative to some comparator in $\mathcal C$. If the booster does not already predict $f$, the only visible way to do this is to find clean witness transcripts whose observed noisy labels accidentally agree with $f$.

### A Restricted Oracle Lower Bound Does Formalize

There is a clean restricted oracle lower bound in the following transcript-query model.

Fix a sample size parameter $m_0$. The reduction can draw examples from the hard distribution and make adaptive calls to a weak oracle. Each call is represented, from the weak oracle's point of view, by an $m_0$-example transcript or by a sampler whose decisive branch is an $m_0$-transcript. The adversarial weak oracle has a hidden set $G_f$ of useful transcripts: if the transcript is clean relative to the hidden comparator $f$, the oracle returns a hypothesis with nontrivial correlation with $f$; otherwise it returns a neutral hypothesis, such as the better constant or a zero-correlation decoy.

For any adaptively chosen polynomial set of transcript probes $T_1,\ldots,T_q$, with $q=\operatorname{poly}(s,1/\varepsilon)$, the probability of finding a clean transcript is at most

$$
q(1-\eta)^{m_0}
$$

under independent classification noise. If $m_0=s^{\Omega(1)}$ and $\eta$ is a fixed constant, this is superpolynomially small. Equivalently, if the hidden clean transcript is modeled as a password among roughly $\exp(\Omega(m_0))$ plausible relabeling traces, polynomially many black-box probes do not find it. Exhaustive enumeration over $n^{m_0}$ traces can find such witnesses, which matches the fixed-parameter flavor of the known residual-free constructions, but a polynomial-query booster cannot.

This can be sharpened into a dichotomy statement:

1. If a black-box booster ever constructs a query distribution with $\operatorname{OPT}_{\mathcal C}<\gamma_0$ and noticeable mass, then the construction of that query distribution already encodes noticeable information about $f$.
2. If it does not, a valid fixed-additive weak oracle may answer all its calls with neutral hypotheses.

So, as a barrier against a particular style of black-box boosting, the clean-tuple picture is real. It says that a polynomial-query reduction cannot demand useful information from an adversarial fixed-slack oracle on medium-noise residual tasks unless the reduction has already solved the main denoising problem or can hit exponentially rare clean traces.

### Why This Is Not Yet A General Oracle Lower Bound

The formal statement above is not fully model-independent. It restricts weak-oracle access to transcript-style calls or observable samplers generated from the noisy data. A completely general reduction might specify an arbitrary efficiently samplable distribution for the weak learner. If that distribution has $\operatorname{OPT}_{\mathcal C}<\gamma_0$, then a valid weak oracle must answer usefully, certificate or no certificate.

Thus the lower bound is best read as: observable clean-witness search has query complexity $\exp(\Omega(m_0))$. It is not yet a theorem saying that every possible black-box reduction from fixed-additive weak agnostic learning to strong agnostic learning needs exponentially many calls. A fully general oracle theorem would need to formalize the idea that every low-$\operatorname{OPT}$ query sampler either already contains a predictor correlated with $f$ or must pass through a clean transcript. I do not currently see how to prove that without imposing a query model.

### The Realization Problem

More importantly, I do not see how to realize the bad oracle as an atlas-valid concept class satisfying the source.

The first obstruction is the source guarantee itself. A genuine weak agnostic learner must work on every distribution with $\operatorname{OPT}_{\mathcal C}<\gamma_0$. Suppose its only informative mode requires an all-clean $m_0$-tuple. Then on a genuinely low-noise distribution with noise rate $\eta_0<\gamma_0$, the probability that an $m_0$-sample is all clean is

$$
(1-\eta_0)^{m_0}=\exp(-\Omega(\eta_0 m_0)).
$$

For fixed $\eta_0$ and growing $m_0$, polynomially many repetitions do not find such a tuple. Therefore a clean-tuple-only algorithm is not an efficient fixed-additive weak agnostic learner. It becomes viable only when $\eta_0 m_0=O(1)$, which is exactly the inverse-polynomial-gap regime already isolated by the parity/LPN attempt at depth 1.

The second obstruction is publicness. To make the source true at fixed constant $\gamma_0$, the concept class must come with a public polynomial-time low-noise decoder: whenever labels are within $\gamma_0$ of some concept under an arbitrary marginal, the learner must output a hypothesis beating random prediction by a constant amount. Once such a decoder exists, the adversarial-oracle picture no longer controls all useful behavior. A strong learner or booster can use the same public algorithm as a subroutine, and the clean-tuple lower bound no longer by itself proves hardness.

The third obstruction is improper output. Many coding or PCP analogies can make proper recovery hard at medium noise, but the target is improper. If the hard region is small, lookup or memorization can solve it. If the hard region is large, the low-noise source learner must already decode it under arbitrary marginals. If public handles reveal the hidden comparator, the strong target also becomes easy. If handles are hidden, the weak source fails on distributions concentrated away from the handles.

### Candidate Realizations Checked Conceptually

Parities/LPN realize the clean-batch story for an inverse-polynomial gap: Gaussian elimination on clean batches gives weak learning at gap $\Theta(1/m_0)$, while constant-noise LPN blocks strong agnostic learning. They do not realize the fixed-additive source, because even weak prediction below a fixed constant noise rate would already break LPN.

Random-label or PRF-style classes give a strong password intuition, but they fail the source even on realizable or low-noise distributions. The source restricted to realizable labels is already an efficient weak realizable learner, and ordinary realizable boosting then gives efficient strong realizable improper learning. So the class cannot hide all clean information behind an exponential password.

Error-correcting-code templates are the closest conceptual route. One would want a public polynomial-time decoder that gives a weak predictor for every arbitrary weighted corruption pattern below a fixed radius $\gamma_0$, but an average-case hardness result for improper prediction at some larger constant noise rate $\eta>\gamma_0$. I do not know a standard binary PAC concept class with both properties. Usual nearest-codeword hardness is about proper or explicit codeword recovery, while an improper learner under a polynomial-size domain may use lookup; exponential domains restore hardness but make the distribution-free low-noise source much stronger than standard bounded-distance decoding.

### Bottom Line

The depth-3 attempt gives a useful barrier but not a resolution.

The barrier: in a transcript-query or clean-witness-search model, a fixed-additive weak oracle can hide all useful medium-noise information behind all-clean $m_0$-tuples, and polynomially many probes miss those tuples with probability $1-\exp(-\Omega(m_0))$.

The obstacle to an atlas separation: a real source learner cannot be merely clean-tuple based at fixed constant weak slack. To satisfy the atlas source, it must also be a polynomial-time low-noise weak decoder for every marginal and every conditional label rule with $\operatorname{OPT}<\gamma_0$. That extra decoder is exactly the structure absent from the bad-oracle construction.

Promising next directions:

1. Formalize the restricted transcript-query lower bound cleanly, with an adversary argument showing $q(1-\eta)^{m_0}$ success probability and a dichotomy between "already has correlation with $f$" and "must hit a clean transcript."
2. Search specifically for threshold-noise classes: efficient weak decoding for arbitrary distributions below fixed noise radius $\gamma_0$, but improper agnostic hardness above $\gamma_0$ under a fixed natural marginal.
3. Check whether the da Cunha et al. statistical lower bound can be recast as a computational query lower bound whose hard instance still permits a public low-noise weak learner.

Current verdict remains unresolved: RESOLVED: no.

## Depth 4 Attempt: Computationalizing Residual-Free Relabeling

RESOLVED: no.

### Question Pursued

I pursued whether the residual-free statistical reduction of Hopkins et al. / da Cunha et al. can be made polynomial for the atlas edge

$$
\text{efficient weak agnostic improper PAC}
\Longrightarrow
\text{efficient agnostic improper PAC}
$$

by exploiting extra structure in the weak learner's outputs: compression of weak-learner calls, finite enumeration of generated hypotheses, or online learning over the generated hypotheses.

I interpret the source in the fixed-additive sense of the endpoint definition. In correlation notation, an atlas weak learner with

$$
\operatorname{err}(h) \le \operatorname{OPT}_{\mathcal C}+\beta,\qquad \beta<1/2,
$$

is a da-Cunha-style agnostic weak learner with parameters $\gamma_0=1$ and $\epsilon_0=2\beta$, so the residual-free advantage parameter is

$$
\theta=(\gamma_0-\epsilon_0)/2=1/2-\beta>0.
$$

Thus the statistical theorem is relevant: the issue is only computational uniformity in the representation size.

### Source Check

The older residual-free framework can be summarized as: run a realizable learner on every relabeling of a training set, then use validation or margin filtering to find a good output. The 2025 da Cunha et al. paper explicitly says this first step is exponential and that the work is statistical rather than computational. Source checked: [Revisiting Agnostic Boosting](https://openreview.net/pdf?id=aFf30XJpl4), especially Algorithm 2 and the discussion around the relabeling loop.

The 2026 da Cunha--Hogsgaard--Paudice paper is the relevant sharper source. It gives a polynomial-in-sample-size algorithm when the weak-learner parameters are fixed. Its Algorithm 1 avoids enumerating all labelings. Instead, it:

1. builds a bag $B$ by running the weak learner on every length-$m_0$ subsequence of the first half of the sample, with several random seeds;
2. returns an empirical-risk minimizer over $\operatorname{sign}(B^{(T)})$, the signs of averages of $T$ generated hypotheses;
3. uses the proof idea that among all enumerated subsequences are the clean subsequences from
   $$
   S_{f^\star}=\{(x,y)\in S_1:f^\star(x)=y\},
   $$
   so the generated bag can simulate realizable boosting on the clean slice.

The theorem's runtime is still of the form

$$
\operatorname{Eval}_H(1)\cdot n^{\,m_0\cdot O(\min\{d^\star,\log n\}/\theta^2)}
$$

with $d^\star$ the dual VC dimension of the weak learner's base class. Source checked: [Sample-Near-Optimal Agnostic Boosting with Improved Running Time](https://arxiv.org/pdf/2601.11265), Theorem 2 and the computational-complexity analysis.

This is an important partial positive, but it is not an atlas resolution. In the atlas, $m_0$ is the sample complexity of the given efficient weak learner and may be $\operatorname{poly}(s)$; $d^\star$ may also grow with the representation size or even be large for an arbitrary improper output class. Therefore $n^{m_0}$ and $n^{m_0 O(d^\star)}$ are not polynomial-time bounds in the representation size.

The same issue remains in a marginal-nonuniform variant. Even if a polynomial is allowed to depend on the marginal $P$, the clean slice $S_{f^\star}$ depends on the unknown conditional labels and best comparator, not just on $P$. Marginal-dependent advice does not identify which sample points are clean.

### Attempt 1: Weak-Learner Output Compression

The most direct way to make the 2026 algorithm atlas-polynomial would be to replace the enumeration of all $m_0$-tuples by enumeration of a much shorter certificate for each useful weak output.

A sufficient condition would be something like:

> For every query distribution $D'$ supported on a clean slice $S_{f^\star}$, whenever the weak learner succeeds using an $m_0$-sample, there is a successful call whose output is determined by at most $k$ labeled examples from the sample, where $k$ is bounded independently of the representation size.

Then the $n^{m_0}$ enumeration could be replaced by $n^k$, and the residual-free route would become polynomial if the later $T$-wise search were also controlled.

I do not see a way to derive this from the atlas source. The weak learner is an arbitrary efficient improper algorithm. Its useful output may depend on all $m_0=\operatorname{poly}(s)$ examples; its output representation may have $\operatorname{poly}(s)$ bits; and enumerating either all possible compressed samples or all possible output descriptions is still superpolynomial unless the compression size is constant. Even a VC-style compression size $O(d)$ would not be enough for the computational atlas when $d$ grows with $s$, because $n^{O(d)}$ is not polynomial in $s$.

Randomly sampling candidate weak calls also does not repair this. Under a noisy comparator distribution with constant $\operatorname{OPT}<1/2$, the probability that an $m_0$-tuple is entirely in the clean slice is roughly $(1-\operatorname{OPT})^{m_0}=\exp(-\Omega(m_0))$ in the worst constant-noise case. The da Cunha algorithm wins by exhaustive enumeration of these clean tuples; sampling only gives a polynomial algorithm when $m_0=O(\log s)$ at best, and the atlas source permits larger $m_0$.

### Attempt 2: Finite Hypothesis Enumeration

The 2026 algorithm already converts the problem into a finite generated bag $B$. This suggests trying to enumerate hypotheses rather than relabelings or clean tuples.

There is a conditional positive statement:

> If, for every sample, the set of hypotheses reachable from the weak learner on all relevant clean-slice calls has polynomial cardinality, and if empirical risk minimization over the corresponding short majorities can be done in polynomial time, then the residual-free statistical argument becomes a polynomial-time learner.

This condition is much stronger than the source node. The source gives an efficient map from samples to hypotheses, not a polynomial-size range bound. An efficient weak learner can have exponentially many possible outputs as the input sample and random seed vary.

Even if $B$ is explicitly generated, the final search over $\operatorname{sign}(B^{(T)})$ costs $|B|^T$. Da Cunha et al. control $T$ by a pruning lemma using the dual VC dimension:

$$
T=O(\min\{d^\star,\log n\}/\theta^2).
$$

This is polynomial only when $d^\star$ is treated as a fixed parameter. The atlas source does not bound the dual VC dimension of the improper base hypotheses output by the weak learner. In fact, because improper outputs are arbitrary binary hypotheses, the natural base class may have very large or untracked dual VC dimension even when each individual hypothesis is efficiently evaluable.

Known finite-base efficient agnostic boosters do not solve the fixed-slack problem either. Ghai--Singh style guarantees are computationally efficient for finite base classes, but they leave a residual proportional to the weak learner's additive slack, e.g. a correlation loss on the order of $\epsilon_0/\gamma_0$. For the atlas source $\epsilon_0=2\beta$ is fixed, so that residual is constant rather than $O(\varepsilon)$.

### Attempt 3: Online Learning Over Generated Hypotheses

I also tried to replace the exhaustive ERM over $\operatorname{sign}(B^{(T)})$ with no-regret or online convex optimization over generated hypotheses.

The obstacle is that the residual-free proof is not optimizing against the observed noisy labels alone. It needs the ensemble that would be produced by realizable boosting on the clean slice $S_{f^\star}$, or equivalently on labels supplied by the unknown near-optimal comparator. Online learning against the observed labels reverts to the usual agnostic boosting setting. There the weak learner only promises

$$
\operatorname{corr}(h,Y)\ge \sup_{c\in\mathcal C}\operatorname{corr}(c,Y)-2\beta,
$$

which is progress-neutral whenever the best correlation is below $2\beta$. This is exactly the residual term that the relabeling/clean-slice argument was designed to avoid.

One could ask an online algorithm to search over generated ensembles using validation loss on fresh noisy labels. But then it is solving empirical risk minimization over the same implicit class $\operatorname{sign}(B^{(T)})$. Without a special optimization oracle or structural assumptions on $B$, this does not avoid either bottleneck: generating $B$ already costs $n^{m_0}$, and optimizing over $T$-wise majorities costs $|B|^T$ in the generic case.

The online agnostic boosting literature is still relevant but does not bridge this specific gap. Brukhim--Chen--Hazan--Moran give online agnostic boosting from a stronger online weak learner with regret guarantees, and finite-base statistical boosters can be viewed through no-regret dynamics. Those assumptions are not consequences of a batch fixed-additive weak agnostic PAC learner.

### Best Conditional Lemma Found

A true positive resolution would follow from the following extra-structure lemma, but I could not prove it from the atlas source:

**Lemma template.** Suppose every efficient fixed-additive weak agnostic improper learner can be converted, with polynomial overhead, into one whose clean-slice behavior has all three properties:

1. constant-size or otherwise atlas-polynomial call compression replacing $m_0$;
2. generated base hypotheses with atlas-polynomial dual dimension or a polynomial ERM oracle over the needed short majorities;
3. stability under clean-slice simulation, so that the hypotheses needed for realizable boosting on $S_{f^\star}$ are generated from observable samples with polynomial probability or polynomial enumeration.

Then da Cunha--Hogsgaard--Paudice gives an efficient strong agnostic improper learner.

The problem is that each bullet is an additional algorithmic regularity assumption. None follows from the bare existence of a polynomial-time weak agnostic improper learner.

### Bottom Line

The 2026 improved-time booster is the best current positive route and should be cited in future atlas notes as a serious near miss: it eliminates full relabeling enumeration and gives polynomial time for fixed $m_0$, fixed $\theta$, and controlled dual VC dimension.

It still does not resolve the atlas edge. The remaining exponents contain weak-learner sample complexity and generated-class dual VC dimension, both of which may grow with the representation size. I found no generic way to remove those exponents using output compression, finite hypothesis enumeration, or online learning without assuming extra structure not present in the source node.

Promising next directions:

1. Look for natural subclasses of weak learners where the 2026 algorithm is genuinely atlas-polynomial, e.g. constant $m_0$ and constant dual VC base hypotheses. These would give useful restricted positive theorems, not the full edge.
2. Try to prove a normalization theorem for weak learners: efficient fixed-slack weak agnostic learning implies an equivalent weak learner with small clean-slice compression. This currently looks much stronger than known sample-compression phenomena.
3. Try the negative direction with the 2026 algorithm in mind: construct a concept class where any residual-free booster must either enumerate $m_0$-clean tuples or solve a hard implicit ERM over generated majorities, while the weak source remains genuinely efficient. This would need to avoid the realization problem from depth 3.

## Depth 5 Attempt: Clean-Witness Generator Yes/No

RESOLVED: no.

### Primitive Isolated

I focused only on the missing primitive:

> Given samples from an agnostic distribution $D$ and an efficient fixed-slack weak agnostic improper learner $A$, generate in polynomial time a polynomial menu of weak-learner calls such that, whenever the current residual still has excess error, at least one call has $\operatorname{OPT}_{\mathcal C}$ below the fixed weak threshold and its returned hypothesis gives useful progress on the original distribution.

In the residual-free statistical construction, the menu is obtained by enumerating clean witnesses: small transcripts that accidentally contain only labels agreeing with a near-optimal comparator $f^\star$. The question here is whether the atlas source assumption alone forces a polynomial way to find such witnesses.

I do not see a proof. More sharply, the primitive looks equivalent to already having a weak predictor for the hidden comparator in the medium-noise regime where the source learner is allowed to be silent.

### A Useful No-Free-Cleaning Calculation

Work in $\{-1,1\}$ notation. Let

$$
X\sim P,\qquad Y=f(X)Z,\qquad \Pr[Z=-1]=\eta,
$$

where $f\in\mathcal C$ and the noise rate satisfies

$$
\gamma < \eta < 1/2,
$$

with $\gamma=1/2-\beta$ the fixed weak edge. On this distribution the source guarantee need not return anything correlated with $f$, since

$$
\operatorname{OPT}_{\mathcal C}(D)\le \eta > \gamma .
$$

Suppose an observable generator tries to create a lower-noise weak call by filtering examples using some candidate predictor $g$. The most favorable simple filter keeps examples for which the observed label agrees with $g$, i.e. $Y=g(X)$. If

$$
r=\mathbb E_P[f(X)g(X)],
$$

then the conditional corruption rate after this filter is

$$
\Pr[Z=-1\mid Y=g(X)]
=
\frac{\eta(1-r)}{1+(1-2\eta)r}.
$$

For this to fall below the weak threshold $\gamma$, one must have

$$
r>
\frac{\eta-\gamma}{\eta+\gamma-2\eta\gamma}.
$$

So a filter that genuinely cleans medium-noise labels must already contain noticeable correlation with $f$. When $\eta$ is close to $1/2$, the required $r$ is not tiny; the filter is not discovering a clean slice for free, it is using a partial solution.

This is not limited to the literal event $Y=g(X)$. Any useful sampled query distribution has to either:

1. concentrate on a region too small to give progress on the original task;
2. relabel/filter in a way whose signed acceptance function is already correlated with $f$; or
3. enumerate many possible signed acceptance functions until one happens to match $f$.

The clean-witness enumeration route is case 3. A polynomial clean-witness generator would need a reason, not present in the source definition, that the relevant signed acceptance function lies in a polynomially searchable menu.

### Why The Source Assumption Does Not Seem To Force The Menu

The fixed-slack source gives an algorithm for distributions whose benchmark error is already below $\gamma$. It says nothing operational about medium-noise comparator distributions with $\operatorname{OPT}$ in $(\gamma,1/2)$. In that band, constants can be consistent with the source guarantee, and the learner's behavior may be completely progress-neutral.

Trying to derive the generator from the source therefore seems to require a hidden normalization theorem:

> Every class with an efficient fixed-slack weak agnostic learner has an efficient weak learner whose successful low-noise calls are exposed by a polynomial-size, sample-observable menu.

I found no route to such a theorem. The source learner may use all $m_0=\operatorname{poly}(s)$ examples in an essentially global way. Statistical sample compression does not give a polynomial menu unless the compression size is constant or logarithmic. VC-style compression of size $\operatorname{poly}(s)$ is still too large, because the clean-witness enumeration becomes $n^{\operatorname{poly}(s)}$.

The calculation above also explains why random subsampling is the wrong replacement. For independent noise $\eta>\gamma$, a random $m_0$-tuple has empirical noise at most $\gamma$ with probability roughly

$$
\exp(-m_0\,D_{\mathrm{KL}}(\gamma\Vert\eta)).
$$

If $m_0$ grows polynomially with the representation size, this is superpolynomially small. A polynomial generator must use information about $f^\star$, not just luck.

### Plausible Obstruction Template

The cleanest obstruction would be a threshold-decodable pseudorandom code class. I did not construct one from standard assumptions, but the template is now quite precise.

Let $\mathcal C_s=\{c_u:u\in\{0,1\}^s\}$ be a family of efficiently evaluable codeword-like concepts over a large domain $\mathcal X_s$. We would want two properties.

**Low-noise weak decoding.** There is a public polynomial-time learner $L$ such that for every marginal $P$ and every labeled distribution with $\operatorname{OPT}_{\mathcal C}<\gamma$, $L$ outputs some hypothesis with error at most $1/2-\gamma$ after validation. Together with the better constant classifier for the case $\operatorname{OPT}_{\mathcal C}\ge\gamma$, this gives the atlas fixed-slack weak source:

$$
\operatorname{err}(h)\le \operatorname{OPT}_{\mathcal C}+1/2-\gamma .
$$

**Medium-noise pseudorandomness.** For some fixed marginal $P_0$ and some $\eta\in(\gamma,1/2)$, no polynomial-time improper learner given samples from

$$
(X,c_u(X)Z),\qquad X\sim P_0,\quad \Pr[Z=-1]=\eta,
$$

can output a hypothesis with error below $1/2-\Omega(1)$, or even distinguish these samples from random labels, for random $u$.

If such a class exists, it would be a genuine obstruction to the generator. A polynomial clean-witness generator applied to the medium-noise distribution would have to manufacture a low-$\operatorname{OPT}$ weak call. Feeding that call to the low-noise weak decoder and validating the result would produce a hypothesis correlated with $c_u$ under $P_0$, contradicting medium-noise pseudorandomness. The no-free-cleaning calculation says exactly where the contradiction enters: the generator's filter/relabeling rule must already encode a correlated predictor.

This template also explains why the familiar candidates keep missing. Parities supply medium-noise pseudorandomness under LPN but not public fixed-slack low-noise weak decoding. Ordinary efficient error-correcting codes supply low-noise decoding in some models but not the required distribution-free weighted weak decoding plus improper medium-noise hardness. Lookup-style finite-support classes make the low-noise side easy but also make the improper strong target easy by memorization.

### Current Bottom Line

I cannot prove a polynomial clean-witness generator from the atlas source assumptions. The strongest statement I can justify is a barrier:

> Any polynomial clean-witness generator that helps on medium-noise comparator distributions must either enumerate an exponentially large clean-transcript space or already compute a predictor noticeably correlated with the hidden comparator.

This is not an atlas resolution because I do not have an explicit class satisfying both low-noise fixed-slack weak learnability and medium-noise improper hardness. The most promising next subproblem is therefore not another generic boosting attempt, but the construction or refutation of the threshold-decodable pseudorandom code template above.

## Depth 6 Attempt: Adaptive Random Clean Traces

RESOLVED: no.

### Claim Tested

I tried to break the current negative conclusion against the following positive proposal:

> Fixed-slack weak agnostic improper learning should imply strong agnostic improper learning by simulating the residual-free da Cunha-style boosting argument, replacing exhaustive clean-trace enumeration with adaptive random clean traces.

The proposal is attractive because the 2026 da Cunha--Hogsgaard--Paudice algorithm already improves the older all-relabelings construction. It calls the weak learner on many observed subsequences rather than on all possible relabelings, and it achieves the residual-free statistical error rate with running time polynomial in the sample size when the weak-learner parameters are fixed. Source checked: [Sample-Near-Optimal Agnostic Boosting with Improved Running Time](https://arxiv.org/abs/2601.11265). The relevant theorem still gives running time

$$
\operatorname{Eval}_H(1)\cdot n^{O(m_0\min\{d^\star,\log n\}/\theta^2)}.
$$

So the adversarial question is whether adaptively sampling only promising traces can remove the exponent in $m_0$.

### What The 2026 Proof Actually Uses

The 2026 algorithm does not merely need a diverse bag of weak hypotheses. Its proof uses the following hidden object. Let $f^\star\in\mathcal C$ be a near-optimal comparator and let

$$
S_{f^\star}:=\{(x,y)\in S_1:f^\star(x)=y\}
$$

be the part of the sample whose labels agree with $f^\star$. The analysis simulates realizable boosting on this clean slice. For every reweighted distribution $D_r$ over $S_{f^\star}$ arising in the simulated AdaBoost run, the weak-learning guarantee implies that there exists an $m_0$-tuple

$$
S'\in S_{f^\star}^{m_0}
$$

and a random seed such that $W(S')$ has the required weak advantage on $D_r$. The algorithm contains this hypothesis because it loops over all index vectors $I\in[n/2]^{m_0}$ and repeats enough seeds. This is an existential coverage argument, not an observable sampling argument.

That distinction is fatal for the adaptive-random-trace proposal. The booster does not know $f^\star$, hence it does not know membership in $S_{f^\star}$ or the correct reweighted clean distribution $D_r$.

### Random Clean Traces Are Exponentially Rare

Consider the cleanest obstruction distribution:

$$
X\sim P,\qquad Y=f^\star(X)Z,\qquad \Pr[Z=-1]=\eta,
$$

where $\eta$ is a fixed constant in the medium-noise band above the source's weak threshold but below $1/2$. A trace drawn blindly from the observed data is entirely in the clean slice with probability

$$
(1-\eta)^{m_0}=\exp(-\Omega(m_0)).
$$

More generally, if the attempted simulation only needs a trace whose empirical corruption rate is at most the weak threshold $\gamma<\eta$, the probability is still

$$
\Pr[\operatorname{Bin}(m_0,\eta)\le \gamma m_0]
\approx
\exp(-m_0D_{\mathrm{KL}}(\gamma\Vert\eta)).
$$

Thus a polynomial number of random traces misses the low-noise or clean event with high probability whenever $m_0=\operatorname{poly}(s)$. This is exactly the regime allowed by the atlas source node.

### Why Adaptivity Does Not Magically Help

The adaptive variant would have to use previous weak-learner outputs and validation losses to bias future traces toward $S_{f^\star}$. But before a useful trace has been hit, the fixed-slack source gives no progress guarantee on the original medium-noise distribution. The weak learner may legally return hypotheses with no useful correlation whenever the queried distribution has $\operatorname{OPT}$ above the fixed weak threshold.

Validation only identifies a good trace after the trace has already produced a hypothesis correlated with $f^\star$. It does not reveal clean membership in advance. Put differently, the stopping rule can recognize success, but it does not increase the base success probability unless it already has a filter correlated with the hidden comparator.

The no-free-cleaning calculation from Depth 5 makes this precise. If a filter keeps examples according to agreement with a candidate $g$, and

$$
r=\mathbb E_P[f^\star(X)g(X)],
$$

then the conditional corruption rate after keeping $Y=g(X)$ is

$$
\Pr[Z=-1\mid Y=g(X)]
=
\frac{\eta(1-r)}{1+(1-2\eta)r}.
$$

To push this below $\gamma$, one needs

$$
r>\frac{\eta-\gamma}{\eta+\gamma-2\eta\gamma}.
$$

So a polynomial-time adaptive sampler that noticeably enriches clean traces is already carrying a predictor correlated with $f^\star$. In the medium-noise band, obtaining such a predictor is the strong-learning problem, not a free preprocessing step.

### Second Bottleneck: The Final Search

Even if random traces generated a polynomial bag $B$ of candidate weak hypotheses, the da Cunha--Hogsgaard--Paudice algorithm still returns an empirical-risk minimizer over

$$
\operatorname{sign}(B^{(T)}),
\qquad
T=O(\min\{d^\star,\log n\}/\theta^2).
$$

Without bounded dual VC dimension, small $T$, or a special optimization oracle, this search is not automatically atlas-polynomial. Adaptive trace generation addresses only the first bottleneck; it does not by itself solve ERM over the generated short majorities.

### Limited Cases Where The Idea Would Work

The adaptive-random-trace idea does become plausible under extra structure not present in the source node:

1. $m_0=O(\log s)$, so random clean or low-noise traces appear with polynomial probability.
2. The weak learner has a polynomial clean-witness generator or a logarithmic compression scheme exposing all relevant clean-slice calls.
3. The generated base class has bounded dual VC dimension and admits polynomial ERM over $\operatorname{sign}(B^{(T)})$.
4. The sampler already has a weak predictor correlated with $f^\star$, in which case it can bias toward the clean slice, but that is already the missing progress.

These are useful restricted positive directions. They do not follow from fixed-slack weak agnostic improper learnability alone.

### Bottom Line

The fatal flaw is a conditioning fallacy: simulating residual-free boosting requires samples from the unknown clean conditional distribution determined by $f^\star$, while adaptive random traces draw from the observed noisy distribution unless they already know how to bias toward that clean conditional distribution. In the medium-noise regime, clean or low-noise traces occur with probability $\exp(-\Omega(m_0))$, and validation cannot increase that probability before a correlated hypothesis has already been found.

So the proposed adaptive-random-trace simulation does not turn the da Cunha residual-free theorem into a fully polynomial atlas implication. The edge remains open; this attempt only strengthens the barrier around the clean-witness generator.

## Depth 7 Attempt: Final Fixed-Slack Boosting Theorem Check

RESOLVED: no.

### Scope Of The Check

I made a final pass for any theorem newer than the cited 2026 agnostic boosters that would give a representation-uniform polynomial-time conversion

$$
\text{efficient fixed-slack Ben-David weak agnostic improper PAC}
\Longrightarrow
\text{efficient strong agnostic improper PAC}.
$$

The source is interpreted in the Ben-David--Long--Mansour fixed-additive form: for some fixed $\beta<1/2$, the weak learner returns an improper hypothesis with

$$
\operatorname{err}(h)\le \operatorname{OPT}_{\mathcal C}+\beta.
$$

Equivalently, for binary hypotheses this gives a da-Cunha-style correlation weak learner with $\gamma_0=1$ and $\varepsilon_0=2\beta$, hence positive fixed gap $\theta=(\gamma_0-\varepsilon_0)/2=(1-2\beta)/2$.

### Search Result

I found no post-2026 theorem that closes this exact gap. Local scratchpads and atlas notes all point to the same boundary: efficient observable agnostic boosters need accuracy-sensitive weak slack, while residual-free fixed-slack boosters use a clean-slice or relabeling search that is not representation-uniform polynomial for an arbitrary Ben-David weak learner.

I also checked live primary-source listings. An arXiv date-sorted query for "agnostic boosting" has `Sample-Near-Optimal Agnostic Boosting with Improved Running Time` as the latest matching paper, submitted January 16, 2026 and revised February 3, 2026: <https://arxiv.org/abs/2601.11265>. Date-sorted arXiv queries for "weak agnostic learner" and "weak-to-strong learning" did not reveal a later classical theorem of the required kind. A nearby February 17, 2026 revision, `How Global Calibration Strengthens Multiaccuracy`, proves strong learning consequences from calibrated multiaccuracy and discusses weak agnostic learning, but it is not a booster from the Ben-David fixed-additive source alone: <https://arxiv.org/abs/2504.15206>.

The key remaining primary theorem is therefore still da Cunha--Moller Hogsgaard--Paudice 2026. Its abstract explicitly says the algorithm is polynomial in sample size "when considering the other parameters of the problem fixed." The theorem statement makes the obstruction concrete: the running time is

$$
\operatorname{Eval}_H(1)\cdot
n^{O(m_0\min\{d^\star,\log n\}/\theta^2)},
$$

with $m_0$ the weak learner's sample complexity and $d^\star$ the dual VC dimension of the base class. This is a large improvement over the earlier exponential-in-$n$ residual-free search, but it is not an atlas-polynomial implication when $m_0$ or $d^\star$ may grow with the representation size. In the atlas model, $m_0=\operatorname{poly}(s,1/\delta_0)$ is allowed; then $n^{\operatorname{poly}(s)}$ is not polynomial in the representation size $s$ and target accuracy $1/\varepsilon$.

### Atlas-Ready Status Summary

The edge should remain `status: "open"` with `evidence: "unknown"`.

The reason is not statistical. In correlation form, the fixed-additive Ben-David source gives a nontrivial constant-gap weak oracle, so the modern residual-free agnostic boosting framework strongly suggests that the sample-complexity implication is true. The unresolved point is computational uniformity. Known efficient Feldman/Kalai--Kanade/Ghai--Singh style boosters are observable and polynomial, but their final error contains a residual proportional to the weak oracle tolerance; with fixed $\beta$, that residual is constant and cannot be tuned down to $\varepsilon$. Known residual-free da-Cunha-style boosters tolerate fixed slack, but their generic implementation searches over clean traces/relabelings, with exponents depending on $m_0$ and dual VC dimension.

The barrier to record is the clean-witness barrier:

> A fully polynomial fixed-slack booster would need a polynomial-time way to generate, from a medium-noise agnostic sample, a polynomial menu of weak-learner calls containing one call that behaves like a low-noise or clean conditional call for a near-optimal comparator. Random traces hit that clean slice with probability $\exp(-\Omega(m_0))$, and any efficient filter that boosts the clean probability appears to require a hypothesis already correlated with the hidden comparator.

### Conditional Theorem Worth Recording

A useful conditional theorem is:

> If every efficient fixed-slack Ben-David weak agnostic improper learner can be converted into a representation-uniform polynomial clean-witness generator, or more concretely into a polynomial-size residual-exposure menu sufficient to simulate the da-Cunha clean-slice boosting argument and optimize over the resulting short votes, then the edge becomes true.

Equivalently, the missing primitive is a polynomial replacement for the $n^{O(m_0\min\{d^\star,\log n\}/\theta^2)}$ clean-slice search. Without that primitive, and without an explicit threshold-decodable pseudorandom code separation, the present evidence supports neither `true` nor `false`.

## Depth 8 Final Incorporation Recommendation

RESOLVED: no.

### Status And Evidence Summary

Suggested atlas status for `efficient-weak-agnostic-improper-pac__implies__efficient-agnostic-improper-pac`:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
summary: "Still open. The source gives a distribution-free improper weak agnostic learner with only one fixed additive slack. Known observable polynomial agnostic boosters need tunable weak slack at the final accuracy scale, while known residual-free fixed-slack boosters use clean-slice or relabeling searches with exponents depending on weak-sample or capacity parameters. No explicit class is known that separates the two nodes."
```

The edge should not be marked `true`: the known positive route still requires either tunable accuracy-sensitive weak slack, a fixed-parameter regime, or a polynomial clean-witness/residual-exposure menu not supplied by the source node.

The edge should not be marked `false`: the obstruction is still black-box and algorithmic, not an atlas separation. No standard halfspace, parity/LPN, code, CSP, PRF, or public-handle construction simultaneously satisfies the distribution-free fixed-slack weak improper source and refutes strong improper agnostic learning.

### Body Text To Replace

Recommended replacement for the current `## Verdict` and `## Proof Status` body, leaving the `## Theorem Statement` section in place after harmonizing the schema caveat below:

```markdown
## Verdict

`open`.

Still open under the atlas fixed-additive weak agnostic convention. The source gives an improper learner with
$$
\operatorname{err}(h)\le \operatorname{OPT}_{\mathcal C}+\beta
$$
for one additive tolerance $\beta<1/2$. This is enough to supply a nontrivial weak oracle on sufficiently low-noise query distributions, but it does not give an accuracy-tunable oracle at the final $\varepsilon$ scale.

## Proof Status

**Goal.** Decide whether a distribution-free efficient improper learner with fixed weak agnostic excess $\beta<1/2$ can always be converted into a distribution-free efficient improper learner with arbitrary excess error $\varepsilon$.

**Known positive evidence.** In $\{-1,1\}$ notation, the source guarantee is a fixed-additive approximation to the best correlation in $\mathcal C$:
$$
\operatorname{corr}(h,Y)\ge \max_{c\in\mathcal C}\operatorname{corr}(c,Y)-2\beta .
$$
This puts the edge near the agnostic boosting literature of Ben-David--Long--Mansour, Gavinsky, Kalai--Mansour--Verbin, Ghai--Singh, and da Cunha--Moller Hogsgaard--Paudice. The sample-complexity analogue is not the issue; the hard point is a representation-uniform polynomial-time conversion.

**Why current boosters do not settle the edge.** Observable polynomial boosters such as the Feldman/Kalai--Kanade/Ghai--Singh line require a weak oracle whose additive slack can be tuned with the target accuracy. With only one fixed $\beta$, their residual term remains fixed and cannot be driven to $O(\varepsilon)$. Residual-free fixed-slack boosters avoid this residual, but their known generic implementations search over clean traces, relabelings, or short-vote menus. The da Cunha--Moller Hogsgaard--Paudice running time has exponents depending on the weak learner's sample parameter and the dual VC/capacity term, so it is not polynomial uniformly in the atlas representation parameters when those quantities grow with the representation size.

**Clean-witness barrier.** A generic fixed-slack booster would need a polynomial-time way to generate, from a medium-noise agnostic sample, a polynomial menu of weak-learner calls containing one call that behaves like a low-noise or clean conditional call for a near-optimal comparator. If the weak learner needs $m_0$ examples, a blindly sampled trace whose empirical corruption is below the weak threshold appears with probability roughly
$$
\exp(-m_0 D_{\mathrm{KL}}(\gamma\Vert\eta))
$$
when the comparator noise rate is $\eta>\gamma$. Thus random trace generation is not polynomial when $m_0$ may be polynomial in the representation size. Any efficient filter that raises the clean probability seems to require a hypothesis already correlated with the hidden comparator, which is essentially the strong-learning task.

**Why this is not a separation.** The clean-witness and posterior-filtering arguments are barriers to known proof strategies. They do not produce a concept class satisfying the source while failing the target. Parity/LPN gives medium-noise hardness but not the required distribution-free low-noise weak source. Code and nearest-codeword templates either fail improper prediction hardness or become learnable by lookup on polynomial supports. Public-handle and PRF-style witnesses either let adversarial source distributions avoid the handles or leak enough structure to make the target plausible.

**Conditional positive principle.** The edge would become `true` if every fixed-slack weak agnostic improper learner admitted a representation-uniform polynomial clean-witness generator, or more concretely a polynomial-size residual-exposure menu sufficient to simulate the residual-free clean-slice boosting proof and optimize over the resulting short votes.

**Current bottom line.** Known theorems support neither `true` nor `false` for the atlas computational node. The most accurate status is `open`: the missing lemma is a polynomial replacement for the clean-slice/relabeling enumeration, and the missing counterexample is a threshold-decodable pseudorandom-code-style class that still satisfies the distribution-free fixed-slack weak source.
```

### References To Keep Or Add

Keep these existing frontmatter keys and reference bullets:

```yaml
ref_keys:
  - bendavid2001
  - kalai2008agnosticboosting
  - gavinsky2003
  - ghai2025agnosticboosting
  - dacunha2026agnosticboosting
```

Add `feldman2010distributionspecific` if the replacement body keeps the sentence about the Feldman/Kalai--Kanade/Ghai--Singh observable-booster line:

```yaml
  - feldman2010distributionspecific
```

with the matching bullet:

```markdown
- [Feldman 2010](https://arxiv.org/abs/0909.2927)
```

Do not add the 2026 calibration/multiaccuracy paper to this edge unless a separate bibliography entry is introduced and the body explicitly discusses calibrated multiaccuracy. It is a nearby weak-to-strong result, but it is not a booster from the Ben-David fixed-additive source alone, so it is optional context rather than core evidence for this edge.

### Schema Caveat

The atlas should harmonize this edge's theorem statement with the definition note. The definition currently says the source uses a fixed additive tolerance $\beta<1/2$, possibly parameterized by $1/(1/2-\beta)$. The edge theorem statement currently phrases the source as an inverse-polynomial weak gap $\gamma(s)>0$.

These are compatible only if the intended convention is: for each representation size the learner has one non-tunable gap $\gamma=1/2-\beta$ bounded below by an inverse polynomial, and the target still asks for arbitrary $\varepsilon$. If that is the intended schema, replace phrases like "fixed constant slack" with "single fixed additive slack" or "one non-tunable inverse-polynomial weak gap" in the edge text.

If instead the atlas intends a tunable weak oracle whose slack can be requested at scale $\operatorname{poly}(\varepsilon)$, this edge should be split or renamed, because the known observable agnostic boosting theorems are much closer to proving the tunable variant. Under the current fixed/non-tunable source, however, the recommended status remains `open`.

## Depth 9 Attempt: Final Fixed-Slack Boosting Search

RESOLVED: no.

### What I Checked

I treated the prior scratchpad as depths 1--8 and reread the edge, endpoint definitions, and the atlas argument notes. The operative source is the Ben-David--Long--Mansour fixed-additive weak agnostic guarantee

$$
\operatorname{err}(h)\le \operatorname{OPT}_{\mathcal C}+\beta
$$

for one non-tunable $\beta<1/2$, with improper output allowed. The target is ordinary efficient improper agnostic PAC learning to arbitrary $\varepsilon$.

I also reran a primary-source search as of 2026-05-09. Date-sorted arXiv queries for `"agnostic boosting"`, `"weak agnostic learner"`, and `"weak-to-strong learning"` still put [da Cunha--Hogsgaard--Paudice 2026](https://arxiv.org/abs/2601.11265) as the latest relevant classical agnostic-boosting theorem after [Ghai--Singh 2025](https://arxiv.org/abs/2503.04706), [da Cunha--Hogsgaard--Paudice--Sun 2025](https://arxiv.org/abs/2503.09384), and [Ghai--Singh 2024](https://arxiv.org/abs/2410.23632). The one newer-looking nearby hit, [Arunachalam--Dutt--Gheorghiu--de Oliveira 2025/2026](https://arxiv.org/abs/2509.14461), is a quantum phase-state boosting result with quantum examples and fidelity loss, not a classical distribution-free binary PAC theorem for this atlas edge.

### Final Positive Route Test

In $\{\pm 1\}$ notation, the source gives

$$
\operatorname{corr}(h,Y)
\ge
\max_{c\in\mathcal C}\operatorname{corr}(c,Y)-2\beta .
$$

So it can be viewed as a da-Cunha-style agnostic weak learner with $\gamma_0=1$, $\varepsilon_0=2\beta$, and fixed positive gap

$$
\theta=\frac{\gamma_0-\varepsilon_0}{2}=\frac{1-2\beta}{2}>0.
$$

This is the strongest reason the edge might be true statistically. The residual-free sample-complexity theorem of [Revisiting Agnostic Boosting](https://arxiv.org/abs/2503.09384) applies to any nontrivial gap $\gamma_0>\varepsilon_0$, and the 2026 improved-time paper makes the same route much more algorithmic.

The obstruction remains exactly computational. In the 2026 theorem, the running time is bounded by

$$
\operatorname{Eval}_{\mathcal H}(1)\cdot
n^{O(m_0\min\{d^\star,\log n\}/\theta^2)},
$$

where $m_0$ is the weak learner's sample parameter and $d^\star$ is the dual VC dimension of the generated base class. The proof also explicitly enumerates all $m_0$-subsequences of the first sample block so that one of them lies in the hidden clean slice for a near-optimal comparator. This is polynomial in the sample size only when $m_0$, $d^\star$, and $\theta^{-1}$ are treated as fixed or otherwise very small. In the atlas node, $m_0$ may be $\operatorname{poly}(s)$ and the improper base outputs of the weak learner have no bounded dual-VC promise. Therefore this theorem is not representation-uniform polynomial in $s$ and $1/\varepsilon$.

The older observable boosters do not close the gap either. Feldman-style and Kalai--Kanade/Ghai--Singh-style algorithms need an accuracy-sensitive weak condition; their residual terms force constraints such as an additive weak parameter at the $O(\varepsilon)$ scale. A single fixed $\beta$ leaves a constant residual. The classical optimal weak-to-strong learning papers for realizable boosting improve sample complexity, but they do not address agnostic fixed-additive residual removal.

### Final Negative Route Test

I also do not see a source-grounded separation.

A false edge would require an explicit concept class with an efficient distribution-free fixed-slack weak agnostic improper learner for every labeled distribution, while strong improper agnostic learning remains hard under a standard assumption. The usual candidates still miss one side:

1. Parities/LPN give medium-noise hardness, but a fixed-constant weak agnostic learner below constant LPN noise would already produce nontrivial correlation and break the same assumption. The clean-batch parity argument only gives an inverse-polynomial weak gap.
2. PRF classes fail even weak agnostic learning on the hard marginal, and in fact fail weak realizable learning under the cryptographic assumption.
3. Halfspaces provide agnostic hardness, but Tiegel's result rules out weak agnostic improper learning as well, so they fail the source.
4. Finite lookup/PCP-style classes and clause-satisfaction lookup classes are too easy for the improper strong target once the domain slice is polynomially enumerable.
5. One-way weak-handle constructions separate proper targets, but the added public handles either do not block improper voting/lookup or solve only a proper-output obstruction.
6. Error-correcting-code analogies still lack the needed pair: public distribution-free low-noise weak decoding below a fixed threshold $\gamma$, plus medium-noise pseudorandomness against every improper predictor.

Thus the clean-witness and posterior-filtering calculations remain barriers, not separations. They show why known black-box residual-free proofs need hidden clean traces, but they do not instantiate a real atlas-valid class satisfying the source.

### Final Atlas Directions

The edge should remain `status: "open"` with `evidence: unknown`.

The most useful positive direction is now very specific: prove a representation-uniform polynomial clean-witness or residual-exposure generator. Such a lemma would take an arbitrary efficient fixed-slack weak agnostic improper learner and produce a polynomial menu of weak calls that contains, whenever the current excess is larger than $\varepsilon$, a low-noise call sufficient to simulate the residual-free clean-slice boosting proof.

The most useful negative direction is equally specific: construct a threshold-decodable pseudorandom code class. It would need a public learner that weakly decodes every distribution with $\operatorname{OPT}_{\mathcal C}<\gamma$ for fixed $\gamma>0$, but a hard marginal and noise rate $\eta\in(\gamma,1/2)$ on which producing any improper predictor with nontrivial correlation contradicts a standard assumption.

The schema caveat from depth 8 is still important. If the source node means a tunable family that can request $\operatorname{OPT}+\varepsilon$-scale slack, the edge is either trivial or belongs with the known tunable-oracle boosting results. Under the current fixed/non-tunable interpretation, the best source-grounded atlas update is still to keep the edge open and record the clean-witness generator as the missing lemma.
