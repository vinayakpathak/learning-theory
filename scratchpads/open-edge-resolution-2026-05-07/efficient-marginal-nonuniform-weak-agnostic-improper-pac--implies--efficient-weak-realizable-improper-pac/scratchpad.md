# Edge Scratchpad: efficient-marginal-nonuniform-weak-agnostic-improper-pac -> efficient-weak-realizable-improper-pac

- date: 2026-05-07
- depth: 1
- edge file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-weak-realizable-improper-pac.md`
- source: `efficient-marginal-nonuniform-weak-agnostic-improper-pac`
- target: `efficient-weak-realizable-improper-pac`
- write scope: scratchpad only; no atlas or bibliography files edited

## Files Read

- `atlas/README.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-weak-agnostic-improper-pac.md`
- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/arguments/realizable-boosting.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- Related implication notes:
  - `efficient-marginal-nonuniform-weak-agnostic-improper-pac -> efficient-marginal-nonuniform-weak-realizable-improper-pac`
  - `efficient-marginal-nonuniform-weak-realizable-improper-pac -> efficient-weak-realizable-improper-pac`
  - `efficient-marginal-nonuniform-weak-agnostic-improper-pac -> efficient-weak-agnostic-improper-pac`
  - `efficient-marginal-nonuniform-weak-agnostic-improper-pac -> efficient-realizable-improper-pac`
  - `efficient-marginal-nonuniform-weak-realizable-improper-pac -> efficient-marginal-nonuniform-weak-agnostic-improper-pac`
  - `efficient-weak-realizable-improper-pac -> efficient-marginal-nonuniform-weak-agnostic-improper-pac`
  - `efficient-marginal-nonuniform-weak-realizable-improper-pac -> efficient-weak-agnostic-improper-pac`
- Prior exact scratchpad:
  - `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-weak-realizable-improper-pac/scratchpad.md`
- Closely related prior scratchpads:
  - `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-weak-realizable-improper-pac/scratchpad.md`
  - `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-weak-realizable-improper-pac/scratchpad.md`
  - `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac/scratchpad.md`
- Primary-source anchors checked by web:
  - Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability", OpenReview/PDF.
  - Kearns and Valiant, "Cryptographic Limitations on Learning Boolean Formulae and Finite Automata".
  - Goldreich, Goldwasser, and Micali, "How to Construct Random Functions".

## Current Atlas State

The assigned edge is currently `open` with the sharpened diagnosis:

> full-support uniformization can control the source learner's resources, but the source weak advantage may still have a marginal-dependent inverse-polynomial exponent that is not known to imply one distribution-free weak gap.

This is consistent with the endpoint definitions. The source explicitly allows, for each marginal $P$, a weak agnostic tolerance

$$
\beta_P(s)=1/2-\gamma_P(s),
$$

where the inverse-polynomial lower bound on $\gamma_P$ may depend on $P$. On realizable labels, $\operatorname{OPT}_{\mathcal C}=0$, so the source gives

$$
\operatorname{err}_P(h,c)\le 1/2-\gamma_P(s).
$$

The target needs one distribution-free inverse-polynomial weak advantage, independent of $P$.

## What Is Already Settled

The implication is not blocked by one-call runtime. `atlas/README.md` states that computationally efficient PAC sample use and running time are worst-case/pathwise bounds on finite encoded sample transcripts. Therefore `full-support-marginal-uniformization` applies to the single source learner: choose a full-support reference marginal $P^\star$; the source guarantee at $P^\star$ bounds every finite transcript that could arise under any marginal.

Accuracy is different. It is evaluated under the actual marginal $P$, so the source gives only the actual-marginal gap $\gamma_P(s)$. Full support does not transfer a reference-marginal gap to $P$.

Thus the exact missing theorem is still

$$
\forall P\ \exists k(P):\ \gamma_P(s)\ge s^{-k(P)}
\quad\Longrightarrow\quad
\exists k\ \forall P:\ \gamma_P(s)\ge s^{-k}.
$$

No checked atlas note or primary source supplies this theorem for the current computational setting.

## Why A Direct Positive Proof Still Fails

### Fixed-Size Compactness

For each fixed representation size, a transcript-bounded learner may induce a positive minimum gap over a finite simplex of marginals. Even if that pointwise minimum exists, compactness gives no inverse-polynomial lower envelope in the representation size. The minimum can shrink like $s^{-s}$ or worse while every fixed marginal still has its own inverse-polynomial exponent.

### Diagonal Stitching

If marginal-nonuniform semantics were size-indexed and slice-conditional, a diagonal proof would be plausible: choose bad marginals at increasing sizes and stitch them into one bad marginal family. The current atlas uses a global marginal over encoded instances. A weighted global mixture can place tiny mass on each bad high-size slice, and an additive weak guarantee can ignore those tiny slices while retaining a positive global advantage. This is exactly why the current `marginal-uniformization-open` note separates pathwise resource control from accuracy control.

### Boosting And Validation

Boosting is not needed for the weak target, and it would not solve the quantifier issue anyway: standard overhead depends polynomially on $1/\gamma_P(s)$, preserving the marginal-dependent exponent. Validation also cannot manufacture a uniform weak gap; estimating whether an error is below $1/2-\gamma_P$ costs roughly $1/\gamma_P^2$ samples.

### Sample-Only Trichotomy

The Hanneke-Moran-Thiessen trichotomy is powerful for sample-only nodes: their OpenReview abstract and PDF formulate marginal-nonuniform learning as allowing rates to depend on the marginal while remaining uniform over concepts, and their main result classifies possible information-theoretic rates. The atlas uses that to collapse relevant sample-efficient marginal-nonuniform edges to distribution-free sample-efficient nodes. But that route uses unbounded computation/ERM and does not give a polynomial-time learner for the present computational edge.

## Strongest False Route Found

The prior 2026-05-05 sibling scratchpad for

`efficient-marginal-nonuniform-weak-realizable-improper-pac -> efficient-weak-realizable-improper-pac`

developed a paired rare-block PRF singleton-handle construction. That construction is highly relevant here because the atlas now records

$$
\text{efficient marginal-nonuniform weak realizable improper}
\Rightarrow
\text{efficient marginal-nonuniform weak agnostic improper}
$$

by `low-noise-weak-agnostic-robustification`. Therefore any class satisfying the sibling weak-realizable source while failing the distribution-free weak-realizable target also satisfies this edge's weak-agnostic marginal-nonuniform source.

### Candidate Construction

Use paired blocks

$$
B_{n,j}=\{(n,j,u,b):u\in U_{n,j},\ b\in\{0,1\}\},
\qquad |U_{n,j}|=n^j,
$$

with $j\le \lfloor n/(4\log n)\rfloor$ so arbitrarily large constant levels are available while the representation size remains $s=\Theta(n)$.

A keyed target labels exactly one point in each pair:

$$
c_{n,j,k}(n',j',u,b)=1
\Longleftrightarrow
(n',j')=(n,j)\ \text{and}\ b=F_k(u),
$$

and labels all other blocks by $0$. Add the constants and positive singleton hypotheses used by the source learner.

### Source Positivity

For a fixed marginal $R$ and an active block with $N=n^j$ pairs, let $M$ be the mass of the positive set. One of the following has error at most $1/2-\Omega(1/N)$:

- the all-zero classifier, if $M\le 1/2-\Theta(1/N)$;
- the all-one classifier, if $M\ge 1/2+\Theta(1/N)$;
- a singleton on a heaviest positive atom, if $M$ lies in the narrow window around $1/2$.

Sampling and validation find a good observed positive singleton using $O(N^2)$ samples up to logarithms. For any fixed global marginal $R$, only finitely many blocks can have substantial mass; all other active blocks are handled by a constant classifier. Hence one uniform staged learner has an $R$-dependent polynomial bound and $R$-dependent inverse-polynomial weak advantage. By the existing low-noise robustification edge, this yields the assigned source node.

### Target Obstruction

Suppose a distribution-free weak realizable improper learner had sample/runtime degree $D$ and weak exponent $a$. Choose a constant level $j>D+a+3$ and use the uniform marginal on $B_{n,j}$. With at most $s^D$ labeled samples, the learner sees labels for at most $s^D$ of the $N=n^j$ pair indices. On fresh unseen indices, a truly random paired labeling is independent of the transcript, so the possible advantage is at most $O(s^D/N)=o(s^{-a})$.

For PRF labels, any learner achieving error $1/2-s^{-a}$ would allow a distinguisher: evaluate the learned hypothesis on the fresh pair $(n,j,u,0),(n,j,u,1)$ and predict which point is positive. Kearns-Valiant-style cryptographic lower bounds and the GGM PRF framework are the primary-source background for this move.

## Why This Is Not Yet A Resolved False Edge

The target lower bound needs to evaluate the learner's improper output on fresh paired points. The written atlas conventions say that the learner's training sample use and running time are pathwise polynomial. They do not explicitly state that an efficient improper output is a polynomial-time evaluable hypothesis representation, nor that prediction time is part of the resource model.

Existing atlas PRF witnesses strongly suggest that this is the intended computational-PAC convention: many computational separations say that an efficient weak learner for a PRF class would distinguish pseudorandom labels from random labels. That standard reduction normally evaluates the returned hypothesis on fresh examples. But the convention is not written in `atlas/README.md` or in the endpoint definitions read for this edge.

So the paired rare-block PRF route is best classified as `conditional-only` for this pass:

- conditional on PRF security and the standard efficient-output evaluator convention, the edge should become `false`;
- under the current written atlas semantics, the convention gap prevents an atlas-ready resolved-false verdict.

## Proposed Follow-Ups

1. Add a global computational-output convention to `atlas/README.md`: efficient improper learners output finite encoded hypotheses with a uniform polynomial-time prediction procedure; improperness only removes membership in $\mathcal C$, not evaluability.
2. Create a dedicated witness note for the paired rare-block PRF singleton-handle class, rather than overloading the existing one-way image-coordinate witness.
3. Create an argument note with three lemmas:
   - constants-or-positive-singleton source lemma;
   - random-label no-free-label bound on high paired blocks;
   - PRF distinguishing reduction using fresh paired evaluations.
4. Then update this edge, and the sibling weak-realizable uniformization edge, to conditional `false` under PRF security if the evaluator convention is adopted.
5. If the evaluator convention is intentionally rejected, keep this edge `open` and search for a separation that does not require fresh evaluation of an improper hypothesis. I do not currently see such a route.

## Bottom Line

The direct positive route remains blocked by weak-gap uniformization. The strongest negative route is now much sharper than the old PRF/block sketches: via the existing low-noise robustification implication, the paired rare-block PRF construction would refute this exact edge if the standard efficient-output evaluator convention is made explicit. Without that convention in the written atlas semantics, I do not think this pass can honestly call the edge resolved.

VERDICT: conditional-only

Scratchpad path: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-weak-realizable-improper-pac/scratchpad.md`

## Depth 1 Branch A: Weak-Gap Audit

- date: 2026-05-07
- branch: recheck uniformization versus rare-block false witnesses
- write scope: scratchpad only; no atlas files, bibliography, or legacy LaTeX edited

### Question

The edge asks whether

$$
\text{efficient marginal-nonuniform weak agnostic improper}
\Rightarrow
\text{efficient distribution-free weak realizable improper}.
$$

On clean labels, the source specializes to a weak realizable improper learner:

$$
\operatorname{err}_P(h,c)
\le
\frac12-\gamma_P(s),
$$

where $1/\gamma_P(s)$ is bounded by a polynomial whose degree may depend on the marginal $P$. The target needs one inverse-polynomial advantage

$$
\operatorname{err}_P(h,c)
\le
\frac12-\gamma(s)
$$

with a polynomial lower envelope for $\gamma(s)$ independent of $P$.

Full-support transcript uniformization still handles only resources. Since the learner is a single algorithm and atlas-efficient sample/time bounds are pathwise on finite transcripts, a full-support reference marginal gives one polynomial bound on the source learner's sample use and running time. The accuracy statement remains attached to the actual marginal and still has the form $\gamma_P(s)$.

Thus the positive route still needs the weak-gap quantifier swap

$$
\forall P\ \exists k(P):\ \gamma_P(s)\ge s^{-k(P)}
\quad\Longrightarrow\quad
\exists k\ \forall P:\ \gamma_P(s)\ge s^{-k}.
$$

I do not see a theorem proving this under the current weighted-global marginal semantics.

### Why The Agnostic Promise Does Not Immediately Uniformize

The source is stronger than marginal-nonuniform weak realizable learning, but on realizable labels it gives exactly the same kind of marginal-dependent weak gap. The agnostic part helps only if it can force a uniform lower envelope by considering noisy label distributions.

The natural diagonal attempt still fails. If bad marginals $P_j$ occur at increasing sizes or block levels, mixing them into one global marginal gives

$$
P^\star=\sum_j w_jP_j.
$$

A weak additive guarantee under $P^\star$ may ignore the high-level bad slice once $w_j$ is small. Making the other slices noisy raises $\operatorname{OPT}_{\mathcal C}$ and leaves the tolerance $\operatorname{OPT}+1/2-\gamma_{P^\star}$ too slack to force learning on the low-mass component. Without a size-conditional full-mass semantics or a closure theorem that stitches bad target concepts without dilution, the agnostic quantifier does not by itself produce a distribution-free exponent.

Fixed-size compactness is also insufficient. Even if a bounded-transcript learner has a positive worst-case gap at each fixed representation size, those minima can shrink faster than any inverse polynomial as the size grows.

### False-Witness Recheck

Plain PRF classes fail the source: under the hard uniform marginal, even a tiny inverse-polynomial weak predictor would distinguish pseudorandom labels.

The plausible false route is instead a rare-block or high-level PRF hierarchy. A level-$j$ block has $N=n^j$ hidden coordinates or pairs. A fixed-polynomial learner can memorize only $m=n^a$ sampled local labels, giving a weak gain on the order of $m/N$. For each fixed level $j$ this is inverse-polynomial, but the exponent is unbounded over levels. A distribution-free weak target with exponent $K$ can be attacked by choosing $j>a+K$.

The target-negative side of this story is credible under the usual efficient-output evaluator convention: on fresh unseen coordinates, any extra advantage over sampled coverage would predict PRF orientations and give a Kearns-Valiant/GGM-style distinguisher.

The source-positive side is not closed. The earlier singleton/handle sketch relied on finding or validating a good constant-or-handle choice at the hidden scale, e.g. sampling on the order of the active block size. Under the atlas pathwise resource convention this is not allowed: full-support marginal uniformization would expose those same finite transcripts under the reference marginal and force one global polynomial bound.

If the source learner uses only one fixed pathwise polynomial number of samples, deterministic selection becomes the obstacle. On a nearly balanced active block, the all-zero default, all-one default, and finite sampled-handle hypotheses can require different choices depending on a label-mass or coordinate-bias sign of size comparable to the hidden gain $m/N$. Distinguishing

$$
M=\frac12+\Theta(m/N)
\quad\text{from}\quad
M=\frac12-\Theta(m/N)
$$

or the analogous paired-coordinate tilt takes about $(N/m)^2$ samples by ordinary validation. With only $m$ samples, the two transcript laws can be too close, while choosing the wrong deterministic unseen behavior cancels the sampled-handle gain and can leave error at least $1/2$.

Improperness does not remove this by itself. The source already permits arbitrary deterministic binary outputs, so adding public local handles only helps if the learner can select or orient them without hidden-scale information. If the handle is public and strong enough to give a level-independent inverse-polynomial advantage, the improper distribution-free target can reuse it; if it is only local to sampled coordinates, the deterministic unseen behavior problem returns.

Training-time random defaults or prediction-time stochastic neutralizers are a possible model fork, but they are not an atlas-ready resolution here. A randomized learner may output a randomly chosen deterministic hypothesis, yet a source proof would still need high-probability control under every fixed marginal, including heavy or biased unsampled regions. A prediction-time stochastic hypothesis that flips a fair coin on unseen coordinates would neutralize the issue in expected loss, but that is a different output convention from the current ordinary binary-hypothesis node.

Low-noise weak agnostic robustification also does not rescue the false route unless the weak realizable source is already valid with a fixed pathwise polynomial learner. The rare-block construction is currently missing exactly that deterministic, validation-free weak realizable source lemma.

### Current Posture

I would keep the atlas edge open. The right open summary is not merely "resource polynomial may depend on $P$"; resources can be uniformized for the single learner. The remaining issue is that the weak advantage may have a marginal-dependent exponent, and neither the agnostic promise nor the known rare-block PRF templates currently settle whether that exponent can be uniformized.

An atlas update, if made now, should say:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
summary: "Open: full-support transcript uniformization gives one pathwise sample/time polynomial for the single source learner, but the realizable weak gap inherited from the marginal-nonuniform weak agnostic guarantee may have a marginal-dependent exponent. Rare-block PRF false routes have plausible target hardness but still lack a deterministic validation-free source learner under arbitrary marginals."
```

### Depth 2 Directions

1. Prove or refute a weak-gap uniformization theorem for one pathwise-polynomial learner under weighted-global marginals:

   $$
   \forall P\ \exists k(P)
   \quad\text{versus}\quad
   \exists k\ \forall P.
   $$

   A bounded-exponent version would already be useful: if $\sup_P k(P)\le K$, the target follows with an exponent depending on $K$.

2. Formalize the deterministic selection barrier for rare-block local handles, including arbitrary improper outputs and training-time random hash defaults. The useful lemma would show that sampled local corrections cannot beat the hidden $m/N$ scale under all nearly balanced or coordinate-biased marginals without either hidden-scale validation or prediction of unseen hard labels.

3. If the barrier fails, build the paired rare-block PRF witness completely: specify the class, prove the fixed-polynomial marginal-nonuniform weak realizable source, apply low-noise robustification for the weak agnostic source, and state the target lower bound under PRF security plus an explicit efficient-output evaluator convention.

4. Separately decide whether the atlas should add stochastic-final-hypothesis nodes. Under that different semantics, the rare-block construction with fair-coin behavior on unseen coordinates looks much closer to a conditional false witness, but it should not be silently folded into the present deterministic binary-hypothesis edge.

VERDICT: unresolved

## Depth 2 Branch A: Deterministic Weak-Gap Barrier

- date: 2026-05-07
- branch: audit agnostic uniformization and fixed-polynomial hidden-gap witnesses
- write scope: scratchpad only; no atlas files, bibliography, or legacy LaTeX edited

### Goal

Resolve whether

$$
\text{efficient marginal-nonuniform weak agnostic improper}
\Rightarrow
\text{efficient weak realizable improper}.
$$

After restricting the source to clean labels and applying full-support transcript uniformization, the only remaining positive step would be a weak-gap uniformization theorem:

$$
\forall P\ \exists k(P):\gamma_P(s)\ge s^{-k(P)}
\quad\Longrightarrow\quad
\exists k\ \forall P:\gamma_P(s)\ge s^{-k}.
$$

This pass tried two routes that were not fully separated in Depth 1:

1. use the agnostic quantifier to force the gap through mixtures or noisy labels;
2. build a concrete hidden-level witness whose source learner runs in one fixed pathwise polynomial time and whose gap, but not runtime, deteriorates with the marginal.

Neither route closes the edge.

### Agnostic Uniformization Still Does Not Transfer Accuracy

The most tempting positive move is to mix the target marginal $P$ with a full-support reference marginal $R$:

$$
Q_\varepsilon=(1-\varepsilon)P+\varepsilon R.
$$

A target learner can generate samples from $Q_\varepsilon$ by drawing true labeled examples from $P$ with probability $1-\varepsilon$ and synthetic examples from $R$ with arbitrary labels with probability $\varepsilon$. If $c\in\mathcal C$ realizes the true $P$-part, then

$$
\operatorname{OPT}_{\mathcal C}(Q_\varepsilon)\le \varepsilon.
$$

The source guarantee at $Q_\varepsilon$ gives

$$
\operatorname{err}_{Q_\varepsilon}(h)
\le
\varepsilon+\frac12-\gamma_{Q_\varepsilon}(s).
$$

Transferring this back to $P$ yields only

$$
\operatorname{err}_P(h,c)
\le
\frac{1/2+\varepsilon-\gamma_{Q_\varepsilon}(s)}{1-\varepsilon}.
$$

So this produces a $P$-gap only when $\varepsilon$ is smaller than the unknown $\gamma_{Q_\varepsilon}(s)$. Since the marginal $Q_\varepsilon$ still depends on $P$ and on the chosen $\varepsilon$, this does not give a distribution-free exponent. Dovetailing over $\varepsilon$ merely moves the hidden exponent into the validation cost: certifying a gap of size $\gamma$ needs about $1/\gamma^2$ holdout samples.

Adding random label noise to the clean $P$-samples has the same problem. Under $\eta$-classification noise,

$$
\operatorname{err}_{\mathcal D_\eta}(h)
=
\eta+(1-2\eta)\operatorname{err}_P(h,c),
\qquad
\operatorname{OPT}_{\mathcal C}(\mathcal D_\eta)\le\eta.
$$

The source gives

$$
\operatorname{err}_P(h,c)
\le
\frac{1/2-\gamma_P(s)}{1-2\eta},
$$

which weakens the clean gap rather than making its exponent uniform. The agnostic promise is useful for low-noise robustification once a weak gap is already available; I do not see a way for it to manufacture a uniform weak gap.

### Why The Diagonal Still Dilutes

A size-indexed diagonal proof would be straightforward in a different semantics. If risk were evaluated conditionally on size-$s$ slices, one could choose increasingly bad marginals $P_s$ and combine them into one marginal family that contradicts the source's single inverse-polynomial guarantee for that family.

Under the atlas's current global-marginal semantics, a weighted mixture

$$
P^\star=\sum_t w_tP_t
$$

does not force learning on low-mass bad slices. For realizable labels, easy off-slice mass can give the learner enough global advantage even if it has almost no conditional advantage on the bad slice. For agnostic labels, making other slices random raises $\operatorname{OPT}_{\mathcal C}$ and the weak additive tolerance remains so large that a component of mass $w_t$ can still be ignored unless $w_t$ is itself comparable to the desired weak gap.

This is the key difference between pathwise resource uniformization and accuracy uniformization. Rare transcripts under a full-support marginal control runtime because runtime is a worst-case property of finite transcripts. Accuracy is averaged under the actual marginal, so small mixture components can disappear inside the additive $1/2-\gamma$ slack.

### Fixed-Polynomial False Witness Attempt

Depth 1 correctly rejects the older paired rare-block source proof if the source learner spends $N^2$ samples or validation time on a level-$j$ block of size $N=n^j$. A full-support reference marginal would assign positive probability to those same high-level transcripts, so one pathwise polynomial bound would have to dominate $n^{2j}$ for all allowed $j$. That is not polynomial in the representation size when $j$ is unbounded.

The only viable false witness must therefore use one fixed pathwise polynomial budget, say $m=s^D$, and obtain a level-dependent accuracy gap from the small amount of mass it memorizes. On a paired block

$$
B_{n,j}=\{(n,j,u,b):u\in U_{n,j}, b\in\{0,1\}\},
\qquad |U_{n,j}|=n^j,
$$

a memorization learner with $m=n^D$ samples has conditional advantage about $m/n^j$ on the uniform paired marginal. For each fixed $j$ this is inverse-polynomial, while no fixed target exponent can survive all larger $j$. This is the right weak-gap geometry.

The obstruction is selecting deterministic behavior on unseen points for arbitrary marginals. If the hypothesis memorizes sampled labels and defaults to $0$, then its clean error is

$$
\operatorname{err}(h)=M-S_+,
$$

where $M$ is the marginal mass of the positive region and $S_+$ is the mass of sampled positive atoms. Its advantage is

$$
\frac12-M+S_+.
$$

Defaulting to $1$ gives the symmetric advantage

$$
M-\frac12+S_-.
$$

On balanced uniform paired marginals, either fixed default gains on the sampled half and has the desired $m/n^j$ advantage. But for an arbitrary marginal with

$$
|M-1/2|
\gg
m/n^j
\quad\text{and}\quad
|M-1/2|\ll m^{-1/2},
$$

the wrong default loses more from global orientation than memorization gains, while ordinary validation or empirical majority cannot reliably determine the sign of $M-1/2$ using only $m$ samples. This is the deterministic weak-gap barrier in its sharpest form.

Prediction-time randomization would neutralize unseen points: memorize sampled labels and flip an independent fair coin elsewhere. Then the only systematic gain is the memorized mass, giving exactly the hidden level-dependent gap. But the current node is ordinary deterministic binary PAC with zero-one error; a stochastic final predictor would be a different model.

Training-time random defaults or pseudorandom unseen orientations do not obviously fix the problem. A random default function has mean-zero correlation with the unseen target, but for spread-out high-level marginals its negative fluctuation is typically on the order of an $\ell_2$ mass scale, while the memorization gain is only about $m$ times the squared-mass scale. When the effective support size is much larger than $m^2$, the random negative fluctuation can dominate the desired $m/n^j$ gain with constant probability. A high-probability PAC source proof would need a new neutralizer that is deterministic after training and nonnegative for every marginal/target, not just neutral in expectation.

### Current Best Candidate And Why It Is Not A Resolution

The best conditional false template remains a paired rare-block PRF class with deterministic binary outputs, but it needs an additional source-side idea:

- fixed polynomial sample/time budget after full-support resource uniformization;
- per-marginal inverse-polynomial weak gaps coming only from accuracy, not from level-dependent validation;
- deterministic unseen behavior that cannot be adversarially oriented by an arbitrary marginal;
- PRF target hardness on a high uniform paired block.

The target hardness side is still plausible under the usual efficient-output evaluator convention: a distribution-free weak learner with fixed exponent would have to predict unseen PRF pair orientations on a level $j$ above its sample/time degree. The source side is the missing lemma. The known constants-or-singleton proof uses level-dependent validation and is therefore not compatible with the pathwise resource convention.

### Depth 3 Directions

1. Prove a deterministic neutralization lemma or rule it out. Formalize the two-default calculation above for any fixed-polynomial memorization learner on paired blocks. Either find a deterministic output rule whose error is always at most $1/2-\operatorname{poly}_P^{-1}(s)$, or prove that some near-balanced marginal with hidden sign defeats every such rule.

2. Explore a model-split witness for stochastic final predictors. If prediction-time randomized hypotheses are allowed, the paired rare-block PRF construction looks much closer to a clean conditional false edge. This should be recorded only as a separate stochastic-output node, not silently imported into deterministic binary PAC.

3. Search for a positive theorem with an extra anti-dilution hypothesis. The exact theorem to try is: one pathwise-polynomial weak agnostic learner plus a lower bound preventing bad size slices from having sub-polynomial mixture mass implies weak-gap uniformization. If such a theorem needs size-conditional marginals or density lower bounds, that pinpoints the missing assumption in the current atlas edge.

### Bottom Line

I cannot resolve the edge. Full-support reference marginals uniformize the source learner's resources but not its weak advantage. The agnostic promise does not repair the quantifier swap through mixtures or label noise. Conversely, the most concrete false geometry, paired rare blocks with memorized labels, still lacks a deterministic validation-free source learner under arbitrary marginals.

VERDICT: unresolved
Scratchpad path: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-weak-realizable-improper-pac/scratchpad.md`

## Depth 3 Branch A: Active-Slice Neutralizers

- date: 2026-05-07
- branch: try to make a concrete hidden-gap witness or prove why it fails
- write scope: scratchpad only; no atlas files, bibliography, or legacy LaTeX edited

### Targeted Question

The remaining obstruction is not sample or runtime uniformization. After full-support transcript uniformization, a source learner has one fixed pathwise polynomial budget, say

$$
m(s)=s^D.
$$

The question is whether its per-marginal weak gaps must have a distribution-free inverse-polynomial lower envelope, or whether a class can force gaps like $s^{-j}$ on level-$j$ marginals while keeping every fixed marginal weakly learnable.

This pass focused on the strongest false direction: an active-slice hard block that is computationally pseudorandom under the target distribution, but has only a marginal-specific weak handle under the source.

### The Finite-Exception Trick Helps But Does Not Resolve

One subtle point from the previous branches is worth making explicit. A marginal concentrated on a single hard size $n_0$ is not dangerous for the source's inverse-polynomial definition, even if the learner's advantage at that one size is extremely small. A polynomial lower bound for a fixed marginal can absorb finitely many bad sizes into its constant.

So an active-slice witness is allowed to attack the target as follows:

1. For each target size $n$, choose a hard marginal $P_n$ concentrated on one high level $j(n)$.
2. Make the available weak advantage under $P_n$ about $n^{-j(n)}$, smaller than any proposed distribution-free target gap.
3. Avoid contradicting the source by noting that each individual $P_n$ has only one bad size, while a global mixture over many sizes gives all-zero or off-slice behavior enough mass to dilute the hard component.

This is a real way around the naive diagonal proof. It explains why the source condition

$$
\forall P\ \exists k(P)
$$

does not obviously imply

$$
\exists k\ \forall P.
$$

But it only solves the exponent bookkeeping. It does not give the deterministic weak learner needed for the source.

### Why Public Weak Signals Still Fail

I tried to replace the sampled-handle learner by a public level-dependent weak signal. The dream would be a known hypothesis $g_j$ that has advantage $n^{-j}$ against every level-$j$ target and every marginal. Then the source could output $g_j$, while the target could defeat every fixed exponent by choosing $j$ large and relying on PRF hardness for any larger advantage.

That cannot work under arbitrary marginals. If a fixed public hypothesis $g$ disagrees with some concept $c$ at an instance $x$, the marginal $\delta_x$ makes $g$ perfectly wrong. Point-mass marginals are easy because one sample reveals the label, but diffuse marginals supported on many disagreement points recreate the original problem. Thus a public weak signal cannot be globally safe unless it is essentially pointwise correct, in which case the distribution-free target can use it too.

The same issue appears for common-marker variants. If the marker has positive mass under the hard marginal, the target can use it as well. If the marker can be avoided by an arbitrary marginal, the source must still weakly learn the hard core without it.

### The Near-Balanced Tilt Barrier Is The Concrete Blocker

Return to a paired hard block

$$
B_{n,j}=\{(u,b):u\in[N],\ b\in\{0,1\}\},
\qquad N=n^j,
$$

where each target puts exactly one positive point in each pair. With a fixed budget $m=n^D$, memorizing observed pairs gives the desired hidden-scale gain $m/N$ on the perfectly pair-balanced marginal. All-zero behavior on unseen points is then neutral, and sampled corrections give a positive advantage.

The source must also handle arbitrary nearby marginals. Let $M$ be the total mass of the positive region for the current target. A default-zero memorization hypothesis has advantage roughly

$$
A_0 = \frac12-M+S_+,
$$

and default one has

$$
A_1 = M-\frac12+S_-,
$$

where $S_+$ and $S_-$ are the masses of sampled positive and negative atoms corrected by memorization.

For a spread-out level-$j$ marginal, $S_+$ and $S_-$ are on the order of $m/N$. Now choose a near-balanced tilt

$$
\frac{m}{N} \ll |M-1/2| \ll \frac{1}{\sqrt m}.
$$

The wrong default has negative advantage, while the sign of $M-1/2$ cannot be estimated with high probability from $m$ labels. Validation has the same cost: distinguishing the two defaults at this scale needs about $1/|M-1/2|^2$ samples, which is larger than the fixed budget in the displayed window.

This is more than a proof-technique annoyance. If the concept family contains complementary or sufficiently opposite pair orientations, the same marginal can require opposite defaults for two realizable targets whose sample transcripts are statistically close at budget $m$. That gives a real source-side lower-bound template against deterministic binary hypotheses.

If the family omits all such opposite targets, the source obstruction is less formal, but then the target PRF hardness proof also has less room: the witness must still be rich enough that no polynomial-time improper learner can get a distribution-free weak edge under the uniform hard block. I do not currently see a construction that satisfies both requirements.

### Randomization Does Not Fit The Present Node

Prediction-time randomization would make the paired-block idea work much more cleanly. The hypothesis could memorize seen pair labels and flip a fresh fair coin on unseen pairs; the unseen part has exactly zero expected correlation and the seen part gives the hidden $m/N$ gain.

Training-time random hashes are not enough for the deterministic node. For a fixed returned hash, the unseen correlation has standard deviation on the order of the $\ell_2$ mass of the unseen distribution. On the uniform block this is about $N^{-1/2}$, while the memorization gain is only $m/N$. When $N\gg m^2$, the random negative fluctuation overwhelms the desired gain with constant probability. This prevents a high-probability PAC source proof for ordinary deterministic binary outputs.

### Positive Route Rechecked

The agnostic promise still does not force a uniform exponent. Mixtures with a full-support reference marginal transfer runtime but dilute accuracy. Label-noise or low-noise reductions preserve whatever weak gap is already present; they do not create a distribution-free lower envelope.

A more ambitious positive proof would use tilted marginals: if a learner has only a tiny advantage on a balanced hard marginal, then small positive and negative tilts should force it to choose opposite defaults from statistically close samples. This intuition explains why many false witnesses fail, but I do not have a theorem that turns it into a uniform weak-gap bound for arbitrary represented classes. The missing step is global: the proof would need to rule out classes whose active slices make every bad tilt either a finite-size exception for its marginal or diluted by off-slice mass.

### Current Status

I do not think this edge is atlas-ready as true or false.

The best false witness geometry is still paired rare blocks with PRF orientations, but a deterministic, validation-free source learner is missing. Public weak signals and active-slice finite exceptions fix only the exponent bookkeeping, not the arbitrary-marginal tilt problem. Conversely, the tilt problem suggests a possible positive theorem, but no checked argument currently converts it into the needed quantifier swap.

### Depth 4 Directions

1. Formalize the two-target tilt lower bound: for a fixed $m=s^D$, construct one marginal and two opposite concepts on a paired block such that any deterministic learner has error at least $1/2$ for one target with constant probability. Then identify exactly which richness condition on the class is required.

2. Try to prove a positive theorem from that lower bound: if a class satisfies the source for one pathwise-polynomial deterministic learner, then the absence of such opposite tilted blocks forces a uniform weak advantage. This would be a genuine weak-gap uniformization theorem rather than another resource argument.

3. If stochastic final hypotheses are acceptable as a separate model, build the paired rare-block PRF witness there. It should give a clean conditional false result for stochastic-output marginal weak agnostic learning, while clarifying why it should not be imported into the current deterministic binary node.

VERDICT: unresolved
Scratchpad path: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-weak-realizable-improper-pac/scratchpad.md`

## Depth 4 Branch A: Tilt Window

- date: 2026-05-07
- branch: test whether near-balanced tilted marginals force a uniform weak edge
- write scope: scratchpad only; no atlas files, bibliography, or legacy LaTeX edited

### Question

The active false template wants a fixed pathwise-polynomial learner with sample budget

$$
m(s)=s^D
$$

whose advantage on a level-$j$ hard slice is only about $m/N$, where $N=n^j$. For each fixed level this is inverse-polynomial, but choosing $j$ above any proposed target exponent would defeat distribution-free weak learning.

The remaining question is whether this can coexist with the source's arbitrary-marginal quantifier when the source outputs deterministic binary hypotheses, not proper concepts. I focused on two nearby marginals for the same target concept rather than on a properness obstruction.

### A Local Tilt Lemma For Active Slices

Consider a hard slice split by a target $c$ into positive and negative sides. Start from a balanced spread-out base marginal $U$ with $U(c=1)=U(c=0)=1/2$. For a small tilt $\Delta>0$, define two instance marginals

$$
Q_+(c=1)=1/2+\Delta,\qquad Q_-(c=1)=1/2-\Delta,
$$

keeping the conditional distribution inside each side spread out. The labeled sample laws under $(Q_+,c)$ and $(Q_-,c)$ have total variation on $m$ samples of order $\Delta\sqrt m$ as long as collisions inside the large slice are negligible. Thus, when

$$
\frac{m}{N}\ll \Delta \ll \frac1{\sqrt m},
$$

the learner cannot reliably infer the sign of the tilt from its sample, but the wrong global orientation loses more than the memorized-sample gain.

This comparison uses two marginals for one target, so it does not require the class to contain literal complements. If a deterministic learner's only certified advantage on unseen points is the sampled correction scale $m/N$, then it must behave like default one on $Q_+$ and default zero on $Q_-$. Since these two experiments are statistically close below the $1/\sqrt m$ scale, one of the two source guarantees fails with constant probability.

Improperness does not remove this local barrier. The argument ranges over arbitrary binary hypotheses: after the sample is fixed, any deterministic unseen behavior has a signed correlation with the hidden labeling. A biased default is killed by one of $Q_+$ or $Q_-$; a training-time random default only makes that signed correlation random, and on effective support much larger than $m^2$ its typical negative fluctuation is larger than the desired $m/N$ gain. Prediction-time randomization would be different because it makes the unseen correlation exactly zero in expectation, but that is not the current deterministic binary-output node.

### Consequence For The Rare-Block PRF Route

The tilt window gives a clean dichotomy for the paired rare-block PRF witness:

- If $N\gg m^2$, there is room to choose $\Delta$ with $m/N\ll\Delta\ll1/\sqrt m$. The high slice may hide a distribution-free weak gap, but the same slice breaks the marginal-nonuniform source on the tilted marginals unless the learner has a new deterministic neutralizer for unseen points.
- If $N\lesssim m^2$, memorization already gives a gap at least on the order of $1/m$, which is a distribution-free inverse-polynomial scale for this learner. That regime cannot refute the target by making the hidden level arbitrarily worse than every fixed exponent.

So the active-slice obstruction is not just a defect in the old constants-or-singletons proof. It seems to rule out the whole family of deterministic "learn only sampled hard coordinates" counterexamples, including improper versions, unless one supplies a deterministic neutralizer with nonnegative unseen correlation under every marginal and every target.

### Why This Still Does Not Prove The Edge True

The local tilt lemma is conditional on a particular geometry: a balanced hard core, spread-out mass, and the premise that efficient hypotheses have no useful deterministic correlation on unseen hard points except the memorized mass. That is exactly the geometry of the rare-block PRF attempt, but it is not yet a theorem about every represented concept class satisfying the source node.

To prove the atlas edge true, one would need a black-box conversion:

$$
\text{failure of a distribution-free inverse-polynomial weak gap}
\Longrightarrow
\text{existence of a tilted pair of marginals that violates the source}.
$$

I do not have that conversion. A class might in principle have asymmetric active slices or a deterministic, marginal-sensitive neutral predictor that gives a tiny positive correlation under each fixed marginal, with exponents deteriorating across slices. Such a predictor would not be proper and need not look like constants, singletons, or sampled-coordinate memorization. The tilt argument says that any such neutralizer has to be genuinely neutral, not merely a hidden default whose sign is chosen from samples.

The agnostic part also still does not close the gap. Low-noise robustification preserves whatever realizable weak edge is available for the marginal; it does not create a uniform lower envelope. Conversely, tilted noisy distributions only reintroduce the same unknown marginal-dependent tolerance.

### Depth 5 Directions

1. Formalize the local tilt lemma as a reusable no-neutralizer statement for active slices: specify an effective support lower bound, a collision bound, and an "unseen correlation at most $\rho$" hypothesis; prove that any deterministic $m$-sample learner fails one of $Q_+$ or $Q_-$ when $\rho\ll\Delta\ll1/\sqrt m$.

2. Try to lift the lemma to a positive theorem. The missing step is to show that if a deterministic source learner has only sub-polynomial distribution-free gaps, then some hard marginal can be balanced and tilted so that the learner's unseen correlation is below the tilt window. This would turn the current obstruction into weak-gap uniformization.

3. Search specifically for asymmetric deterministic neutralizers. A viable false witness now has to beat the tilt lemma: it must give every fixed marginal a positive inverse-polynomial weak edge without validation at the hidden scale and without producing any distribution-free inverse-polynomial edge. Constants, singleton handles, public weak signals, and training-time random hashes all fail this test for the reasons above.

### Bottom Line

This branch strengthens the case against the active-slice PRF counterexample in the present deterministic improper model. Arbitrary tilted marginals force a source learner either to detect a sub-sampling-scale sign or to provide a true deterministic neutralizer on unseen points. I do not know how to prove that every possible target failure has such an active-slice form, so the edge remains unresolved rather than atlas-ready true.

VERDICT: unresolved
Scratchpad path: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-weak-realizable-improper-pac/scratchpad.md`

## Depth 5 Branch A: Balanced Neutralizer Gap

- date: 2026-05-07
- branch: test whether the tilt window becomes a weak-gap uniformization theorem, or whether a different deterministic improper witness can evade it
- write scope: scratchpad only; no atlas files, bibliography, or legacy LaTeX edited

### Aim

Depth 4 isolated the main obstruction to the paired rare-block false witness: if the only source-side gain on a level-$j$ hard slice is sampled mass $m/N$, then a near-balanced tilt with

$$
\frac{m}{N}\ll \Delta \ll \frac1{\sqrt m}
$$

forces the learner either to detect a sub-sampling-scale sign or to output deterministic unseen behavior that is genuinely neutral. This branch asks whether that obstruction can be promoted into a proof of the edge, or whether an improper deterministic source learner can supply such a neutralizer while the class still blocks distribution-free weak realizable learning.

### What The Tilt Window Actually Proves

Use labels and hypotheses in $\{\pm1\}$. The weak advantage of an output $h$ under a marginal $P$ and target $c$ is

$$
\frac12 E_P[c(x)h(x)].
$$

Let $U$ be a balanced base marginal on a hard slice, and tilt only by the target label:

$$
dQ_\pm(x)=(1\pm 2\Delta c(x))\,dU(x).
$$

For any fixed deterministic output $h$,

$$
E_{Q_\pm}[ch]=E_U[ch]\pm 2\Delta E_U[h]+O(\Delta^2).
$$

Thus the two label-mass tilts kill default-like hypotheses because a default has $|E_U[h]|$ of constant order while its useful sampled correlation is only $E_U[ch]\asymp m/N$. One of $Q_+$ or $Q_-$ then has negative correlation once $\Delta\gg m/N$, and the two sample laws are still close when $\Delta\ll1/\sqrt m$.

This is not yet a black-box weak-gap uniformization theorem. The displayed calculation leaves an escape hatch: an improper output could arrange $E_U[h]\approx0$. A perfectly balanced unseen rule is not hurt by label-mass tilts; both tilted correlations remain essentially $E_U[ch]$. More generally, for a density tilt $dQ_\theta=(1+\theta\phi)dU$, the first-order change is

$$
E_{Q_\theta}[ch]-E_U[ch]
=
\theta\big(E_U[\phi ch]-E_U[\phi]E_U[ch]\big)+O(\theta^2).
$$

To turn Depth 4 into a theorem, one must show that every super-polynomially small distribution-free gap exposes some fixed tilt direction $\phi$ whose covariance with the learner's unseen correlation is large and whose sign the learner cannot infer from $m$ samples. I do not see how to prove that for arbitrary improper outputs. The source learner might, in principle, produce low-discrepancy deterministic predictions whose correlations are tiny but not exposed by the simple positive/negative label-mass tilts.

So the local tilt lemma should be recorded as a no-default or no-exposed-bias lemma, not yet as a full uniformization theorem.

### Why Balanced Neutralizers Are Not Yet A False Witness

The balanced-output escape hatch is also not enough to build a counterexample.

Suppose a candidate witness supplies a public balanced rule $r$ on an unseen paired block. Under the uniform block, $r$ may have zero mean and perhaps zero average correlation with each pseudorandom target, so it avoids the label-mass tilt above. But the source quantifier ranges over arbitrary marginals, not just the uniform one. For a fixed target $c$, partition the block into

$$
A=\{x:r(x)=c(x)\},\qquad B=\{x:r(x)\neq c(x)\}.
$$

If both $A$ and $B$ are large, choose a spread-out marginal with

$$
P(A)=\frac12+\Delta,\qquad P(B)=\frac12-\Delta
$$

or the opposite tilt. Now the learner must decide whether to trust $r$ or $-r$. When

$$
\frac{m}{N}\ll \Delta\ll\frac1{\sqrt m},
$$

the sign of this alignment bias is again below the reliable validation scale, while the wrong deterministic choice has negative advantage larger than the memorized-sample gain. This is the same tilt window, but applied to agreement with the proposed neutralizer rather than to the raw positive-label mass.

If $r$ is pointwise safe enough to avoid this attack for every marginal and every target, then $r$ must essentially agree with each target on every point not already learnable from a point-mass sample. Such a rule would be a distribution-free weak predictor, so it cannot serve a separation. If the witness uses many public balanced rules, the source still has to select a sign or a rule from samples. A rule whose advantage is below $1/\sqrt m$ cannot be validated with high probability using only $m$ examples; a rule whose advantage is above that scale already gives a distribution-free inverse-polynomial gap once the hidden level is fixed below the sample exponent.

Training-time random hashes do not solve this for the deterministic node. After the hash is fixed, the arbitrary marginal may put a slight spread-out bias on the hash's agreement or disagreement cells. On a uniform block the typical accidental correlation is about $N^{-1/2}$, while the sampled memorization gain is $m/N$. In the target-hard regime $N\gg m^2$, a negative fluctuation of the hash is larger than the desired gain with constant probability, so the PAC high-probability source guarantee is not obtained.

### Asymmetric Witness Attempts

I also tried to avoid near-balanced tilted marginals by making the hard distribution intrinsically one-sided.

One-sided hard slices do not separate this edge. If every hard marginal has a known bias toward label $0$ of size $n^{-j}$, the all-zero hypothesis already gives the same hidden gap to the distribution-free target. Choosing $j$ large can make that gap too small for a proposed target exponent, but it does not block the target from using the same public bias whenever the marginal has it. If arbitrary marginals can reverse or nearly erase the bias, the source learner is back in the tilt window and must detect the sign.

Sparse-positive variants have the same problem. If positives are uniformly rare, all-zero is distribution-free weak. If a marginal concentrates enough mass on positives to defeat all-zero, then either empirical label frequency detects a large imbalance, or a near-balanced diffuse concentration recreates the sub-sampling-scale sign problem. Singleton or small-handle corrections work for point masses and heavy atoms, but not for diffuse near-balanced mass unless the learner validates at the hidden support scale.

Marker and hint constructions also seem unable to evade the dichotomy. If the marker has enough mass on the hard target distribution to give a weak edge, the distribution-free learner can use it. If an arbitrary marginal may avoid the marker, the source must learn the hard core without it. A level-dependent marker of mass $n^{-j}$ only hides the exponent; it does not protect the source from tilted marginals that put their mass on the unmarked hard core.

### Why I Cannot Promote This To Resolved True

The strongest possible positive theorem would look like:

$$
\text{failure of every distribution-free inverse-polynomial weak gap}
\Rightarrow
\text{existence of an exposed tilt window violating the source}.
$$

Depth 5 does not prove this. The missing step is an extraction lemma. Starting only from a tiny worst-case gap at size $s$, we would need to find a hard marginal $U$, a target $c$, and a tilt direction $\phi$ such that:

1. the $m(s)$-sample transcript laws under $U$ and the two tilts are close;
2. the learner's useful correlation under $U$ is smaller than the tilt loss;
3. the output has a tilt-exposed deterministic bias in direction $\phi$ with high probability.

The paired rare-block PRF template has exactly these properties for constants, singleton handles, public weak signals, and sampled-coordinate memorization. But an arbitrary improper learner might attempt to make condition 3 false by returning a balanced, low-discrepancy deterministic hypothesis whose small positive correlation is not aligned with a simple tilt. I have no construction of such a learner that survives arbitrary marginals and still blocks the target, but I also do not have a proof that it cannot exist.

The agnostic part still does not close the gap. It lets the same source learner tolerate label noise once a marginal-specific weak edge exists, but it does not force a uniform lower envelope for the realizable weak advantage. Noisy tilted distributions merely replace the unknown realizable gap by an unknown agnostic tolerance for the tilted marginal.

### Depth 6 Directions

1. Prove or refute the exposed-tilt extraction lemma. Formal target: from a fixed polynomial budget $m(s)$ and a sequence of marginals where the learner's best guaranteed correlation is below $s^{-K}$ for all $K$, extract $U,c,\phi,\Delta$ with $m/N\ll\Delta\ll1/\sqrt m$ and with a high-probability tilt-exposed bias. A counterexample to this lemma would be the first credible shape of a deterministic improper neutralizer.

2. Formalize the neutralizer attack for paired PRF blocks. Given any deterministic polynomial-time source learner whose unseen rule is independent of most pair orientations, define agreement-bias tilts on the cells $\{r=c\}$ and $\{r\neq c\}$ and prove by Le Cam or total variation that one tilt forces error at least $1/2$ with constant probability. This would not prove the edge true, but it would definitively rule out the current PRF rare-block witness family.

3. Search for a genuinely asymmetric deterministic witness and test it against three filters: point-mass marginals must be learnable from samples, diffuse near-balanced alignment tilts must not require sub-scale validation, and the hard distribution must not contain a public inverse-polynomial signal reusable by the distribution-free target. Every candidate I tried fails one of these filters.

### Bottom Line

The tilt-window obstruction cannot yet be promoted to an atlas-ready weak-gap uniformization theorem, because the necessary exposed-tilt extraction is missing for arbitrary improper deterministic outputs. It also sharply constrains false witnesses: any viable counterexample now needs a real marginal-sensitive deterministic neutralizer, not constants, singleton handles, public markers, public weak signals, sampled-coordinate memorization, or training-time random hashes. I therefore still cannot honestly resolve the edge.

VERDICT: unresolved
Scratchpad path: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-weak-realizable-improper-pac/scratchpad.md`

## Depth 6 Branch A: Exposed-Tilt Stress Test

- date: 2026-05-07
- branch: test the exposed-tilt extraction route, paired-PRF neutralizer attacks, and asymmetric deterministic witnesses
- write scope: scratchpad only; no atlas files, bibliography, or legacy LaTeX edited

### Setup

After full-support resource uniformization, the source learner can be treated as one fixed pathwise-polynomial learner. Write its sample budget at representation size $s$ as

$$
m(s)=s^D.
$$

On realizable labels, the source guarantee says that for every marginal $P$ there is some marginal-dependent inverse-polynomial gap $\gamma_P(s)>0$. The target would need one inverse-polynomial lower bound independent of $P$.

The useful notation for this branch is $\{\pm1\}$-valued. The weak advantage of an output $h$ against a target $c$ under a marginal $P$ is

$$
\frac12 E_P[c(x)h(x)].
$$

Thus a false witness must make $E_P[ch]$ positive for every fixed marginal, but allow the best guaranteed positive correlation to have no distribution-free inverse-polynomial envelope.

### Exposed-Tilt Extraction Attempt

The hoped-for positive theorem is:

$$
\text{no distribution-free inverse-polynomial weak gap}
\Longrightarrow
\text{some near-balanced tilt violates the source}.
$$

The local calculation from Depth 5 is sound. If $U$ is a base marginal and

$$
dQ_\theta=(1+\theta\phi)dU,
$$

then for a fixed deterministic output $h$,

$$
E_{Q_\theta}[ch]
=
E_U[ch]
+\theta\left(E_U[\phi ch]-E_U[\phi]E_U[ch]\right)
+O(\theta^2).
$$

So if a high-probability output has a small useful correlation $E_U[ch]=\eta$ but a larger exposed covariance in some direction $\phi$, one can choose

$$
\eta \ll |\theta|\cdot |\operatorname{Cov}_U(\phi,ch)|,
\qquad
|\theta|\sqrt m \ll 1,
$$

and the $m$-sample transcript laws under the two tilts remain close while one tilt makes the correlation nonpositive. This would contradict the source.

The extraction step is where the proof still breaks. From target failure alone we know only that some marginal-target pair has very small correlation for the learner. We do not know that the learner's deterministic output has a large exposed covariance in any fixed tilt direction chosen before the sample is drawn.

A tempting choice is to tilt against the learner's averaged prediction

$$
f(x)=E[h_T(x)]
$$

under the base experiment. If $f$ has substantial $L_1(U)$ mass away from zero, tilting in a direction like $\phi=-\operatorname{sign}(c f)$ should reduce the expected correlation. But this is only an expectation-level attack. The source guarantee is high probability over transcripts, and the actual output may vary with the sample. More importantly, an improper learner might try to keep $f$ and many simple covariances close to zero while still obtaining a tiny positive correlation transcript-by-transcript. I do not have a theorem ruling out that low-discrepancy possibility.

Thus Depth 6 does not prove the edge true. The exposed-tilt lemma is a strong no-default principle, but not yet a black-box weak-gap uniformization theorem.

### Paired-PRF Neutralizer Attack

The paired rare-block PRF witness now looks worse as a false route, not better. On a block with $N$ pairs and one positive point per pair, sampled memorization gives the hidden scale $m/N$ under the perfectly pair-balanced uniform marginal. To refute a target weak exponent, one wants

$$
N\gg m^2,
$$

so that $m/N$ is far below the reliable validation scale $1/\sqrt m$.

For a deterministic source learner on this block, there are two cases.

**Case 1: the unseen output is mean-biased.** In $\{\pm1\}$ notation, let $U$ be the pair-balanced marginal. If a typical returned hypothesis has $|E_U[h]|$ larger than the memorized correlation scale, then the label-mass tilts

$$
dQ_\pm=(1\pm 2\Delta c)dU
$$

with

$$
\frac{m}{N}\ll \Delta \ll \frac1{\sqrt m}
$$

break the source. The two transcript laws are close, but the same deterministic output cannot have positive correlation under both tilts, because

$$
E_{Q_\pm}[ch]=E_U[ch]\pm 2\Delta E_U[h]+O(\Delta^2).
$$

This covers constants, all-zero/all-one defaults, marker defaults, and any rule whose safety comes from a hidden global orientation.

**Case 2: the unseen output is balanced.** A balanced output can avoid the label-mass tilt only by having $E_U[h]\approx0$. On paired blocks this means it must orient many unseen pairs. If the orientation is public or sample-independent, then for a PRF target it has essentially random agreement with the unseen PRF orientations. A negative fluctuation of size about $N^{-1/2}$ is larger than the memorized gain $m/N$ in the target-hard regime $N\gg m^2$.

If the learner tries to choose the balanced orientation from the sample, then on most unseen pairs that choice is still independent of the PRF orientation. Any systematic positive unseen correlation beyond the memorized pairs would be exactly the kind of fresh-pair prediction that gives the usual PRF distinguisher, assuming the standard efficient-output evaluator convention.

This gives a useful conditional no-go for the current PRF rare-block family:

1. mean-biased deterministic outputs are killed by sub-sampling-scale label-mass tilts;
2. balanced deterministic outputs either suffer random PRF agreement fluctuations larger than $m/N$, or else predict unseen PRF orientations and violate the cryptographic hardness premise.

That does not prove the atlas edge true, because it is still a no-go for one witness family. It does mean the paired-PRF construction should not be promoted to a resolved-false edge merely by adding evaluator conventions. Its missing source lemma appears genuinely false for deterministic binary outputs.

### Asymmetric Deterministic Witness Attempts

I tried three variants meant to avoid the balanced-neutralizer failure.

**One-sided bias.** Give every hard slice a known label bias of size $n^{-j}$. This supplies a marginal-specific weak edge, but it is public. The distribution-free target can use the same biased constant predictor and gets exactly that edge. Choosing $j$ large hides the exponent, but arbitrary marginals can reverse or erase the bias on a diffuse subset, returning to the tilt window.

**Core-halo constructions.** Put an easy halo around a hard balanced core, hoping the source wins from the halo while the target can choose the hard core. This fails under the source quantifier: a marginal may avoid the halo and place all mass on the hard core. If the core is balanced, the deterministic neutralizer problem returns; if it is not balanced, the target can use the public bias.

**Public low-discrepancy rules.** Supply a family of balanced public rules and let the learner select one. For a fixed rule $r$ and target $c$, the marginal can tilt between the agreement and disagreement cells

$$
\{x:r(x)=c(x)\},\qquad \{x:r(x)\ne c(x)\}.
$$

If the agreement advantage is below the validation scale, the learner cannot reliably choose the sign or rule from $m$ samples. If it is above that scale uniformly, the distribution-free target already has an inverse-polynomial weak signal. A rule that avoids every such tilt would have to be almost pointwise safe for every concept, which again gives the target a weak predictor rather than a separation.

The finite-active-slice trick does not fix these asymmetric attempts. Constants in the marginal-dependent polynomial can absorb a tiny positive edge at one finite size, but they cannot absorb a high-probability failure where the learner has nonpositive advantage on a tilted marginal at that size.

### Current Obstacles

I still cannot resolve the edge.

The positive route lacks an extraction lemma. We need to pass from "the learner's worst-case weak gap is super-polynomially small" to "there is a fixed, sample-oblivious tilt direction that exposes a deterministic bias before validation can detect the sign." The local tilt formulas prove the second half once the direction is found, but do not find it for arbitrary improper outputs.

The negative route lacks a source-positive deterministic neutralizer. Paired PRF blocks are target-hard-looking, but deterministic outputs must either reveal a tilt-exposed mean bias or orient unseen pairs. The former breaks the source under arbitrary tilted marginals; the latter conflicts with PRF unpredictability or suffers fluctuations larger than the hidden memorization gain.

The asymmetric route has not produced a credible witness. Every construction tried either exposes a public weak signal reusable by the distribution-free target, or lets an arbitrary marginal concentrate on a diffuse near-balanced hard region where sub-scale validation is necessary.

### Depth 7 Directions

1. Prove the paired-block no-neutralizer lemma cleanly. Formalize the two cases above for any deterministic $m$-sample learner: mean-biased outputs are defeated by label-mass tilts, while mean-balanced outputs on unseen pairs imply either PRF fresh-pair prediction or a bad key/marginal with negative fluctuation larger than $m/N$.

2. Search for a finite-slice class with a structurally selected super-polynomial weak edge. This would be the most plausible false direction outside PRFs: each finite slice would have a deterministic distribution-free edge $\epsilon_s>0$ too small for the target, selected without validation. The test is whether arbitrary tilted marginals force the edge to become either pointwise safe or sample-detectable.

3. Try the exposed-tilt extraction under additional closure hypotheses first. Complements, restrictions to active slices, or a finite low-complexity output family may be enough to prove weak-gap uniformization. If so, the exact missing hypothesis for the atlas edge would become visible.

### Bottom Line

Depth 6 strengthens the obstruction to false witnesses more than it proves a positive theorem. The paired-PRF route appears source-negative for deterministic improper outputs, and the asymmetric alternatives still collapse under arbitrary marginals. But the exposed-tilt extraction lemma remains unproved for arbitrary improper learners, so the edge is still not atlas-ready as true.

VERDICT: unresolved
Scratchpad path: `scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-weak-realizable-improper-pac/scratchpad.md`

## Depth 7 Branch A: Final Consolidation

- date: 2026-05-07
- branch: final allowed depth; consolidate unresolved edge state
- write scope: scratchpad only; no atlas files, bibliography, or legacy LaTeX edited

### Final Target

Decide whether

$$
\text{efficient marginal-nonuniform weak agnostic improper PAC}
\Rightarrow
\text{efficient weak realizable improper PAC}.
$$

Both endpoint nodes use ordinary deterministic binary hypotheses as outputs. "Improper" means the returned hypothesis need not lie in $\mathcal C$; it does not mean abstention, prediction-time randomization, or an unevaluable advice object. This matters because all active-slice false witnesses become much easier if the final predictor may flip coins on unseen points, but that is not the present edge.

On realizable labels, the source gives one learner $A$ such that for every marginal $P$,

$$
\operatorname{err}_P(A,c)\le \frac12-\gamma_P(s),
$$

where $\gamma_P(s)$ is inverse-polynomial with an exponent allowed to depend on $P$. Full-support transcript uniformization makes the sample and running-time bounds of this single learner pathwise distribution-free. The only missing target requirement is therefore a uniform weak gap

$$
\exists K\ \forall P:\quad \gamma_P(s)\ge s^{-K}
$$

up to constants and the usual confidence bookkeeping.

### Last Positive Attempt

The agnostic promise was the last plausible source of extra leverage. The cleanest attempt is to run the source on a mixture

$$
Q_\varepsilon=(1-\varepsilon)P+\varepsilon R
$$

where $R$ is a fixed full-support reference marginal and the synthetic $R$-part is given arbitrary labels. For realizable data on $P$,

$$
\operatorname{OPT}_{\mathcal C}(Q_\varepsilon)\le \varepsilon,
$$

so the source gives

$$
\operatorname{err}_{Q_\varepsilon}(h)
\le
\varepsilon+\frac12-\gamma_{Q_\varepsilon}(s).
$$

Transferring back to $P$ gives a useful weak gap only when $\varepsilon$ is below the unknown gap $\gamma_{Q_\varepsilon}(s)$. Dovetailing over $\varepsilon$ moves the same unknown exponent into validation: certifying a gap of order $\gamma$ costs about $1/\gamma^2$ examples. Label-noise reductions have the same problem; they preserve a supplied weak gap but do not make its exponent uniform.

The exposed-tilt route is the most promising route to a positive theorem. In $\{\pm1\}$ notation, for a deterministic output $h$ and a tilt

$$
dQ_\theta=(1+\theta\phi)dU,
$$

one has

$$
E_{Q_\theta}[ch]
=
E_U[ch]
+\theta\left(E_U[\phi ch]-E_U[\phi]E_U[ch]\right)
+O(\theta^2).
$$

If target failure forced a base marginal $U$, target $c$, and sample-oblivious tilt direction $\phi$ for which the covariance term dominates the tiny useful correlation before $m(s)$ samples can detect the sign of $\theta$, the source would fail on one of the two tilts. This would prove the edge true.

The missing step is exactly that extraction lemma. From "no distribution-free inverse-polynomial weak gap" we do not know how to obtain a tilt direction that exposes the learner's deterministic bias with high probability over transcripts. An improper learner might try to return low-discrepancy deterministic hypotheses whose average prediction and simple covariances are near zero while retaining a tiny positive marginal-specific correlation. I have no construction of such a learner, but I also do not have a theorem excluding it for arbitrary represented classes.

### Last False Attempt

The strongest false geometry is still a high-level active slice. Let a block have $N=n^j$ paired coordinates and let the uniform hard marginal be balanced, with one positive point per pair. A learner using $m=s^D$ examples can memorize about $m/N$ of the fresh-pair orientation mass. For each fixed level $j$, this is inverse-polynomial; for the distribution-free target, choosing $j$ above the proposed weak exponent should defeat any fixed gap.

Depths 4-6 show why this does not yield a deterministic source learner. If $N\gg m^2$, there is a tilt window

$$
\frac{m}{N}\ll \Delta \ll \frac1{\sqrt m}.
$$

Mean-biased unseen behavior is killed by label-mass tilts:

$$
dQ_\pm=(1\pm 2\Delta c)dU,
\qquad
E_{Q_\pm}[ch]=E_U[ch]\pm 2\Delta E_U[h]+O(\Delta^2).
$$

The two $m$-sample transcript laws are close, but one tilt makes the deterministic bias point the wrong way by more than the memorized gain.

Balanced unseen behavior avoids that particular tilt only by orienting many unseen points. For a paired PRF block, a public or sample-independent orientation has random agreement with the hidden target and suffers fluctuations on the order of $N^{-1/2}$, larger than $m/N$ in the target-hard regime. If the learner obtains systematic positive correlation on fresh unseen pairs, that is precisely the usual PRF-prediction handle that would give a cryptographic distinguisher, assuming the standard efficient-output evaluator convention.

This reverses the earlier conditional-false posture. Adding an explicit evaluator convention would strengthen the target-hardness reduction, but it would not repair the source-positive lemma. The active-slice PRF construction appears source-negative for deterministic improper outputs.

Other false-witness variants fail the same filters.

- Public weak signals, markers, or one-sided biases are either reusable by the distribution-free target or avoidable by an arbitrary marginal.
- Sparse-positive and singleton-handle variants handle point masses and heavy atoms, but diffuse near-balanced marginals require validation at the hidden scale.
- Core-halo constructions fail because the source marginal may put all mass on the hard core.
- Training-time random hashes become fixed deterministic outputs after training; arbitrary marginals can tilt toward their bad agreement cells.
- Prediction-time stochastic neutralization would work in expectation on unseen points, but it is a different output model.

### Deterministic Improper Output Issues

The word "improper" should be kept separate from three stronger conventions.

First, deterministic improper output does not provide a neutral prediction value. A binary hypothesis must choose $0$ or $1$ on unseen mass, so a marginal can tilt toward the cells where that choice is wrong.

Second, training randomness does not give prediction-time neutrality. Once the training transcript and random seed fix $h$, the guarantee is over a deterministic binary function. High-probability PAC success must hold for the realized $h$, not merely in expectation over fresh prediction coins.

Third, the atlas should eventually say explicitly whether efficient improper hypotheses include a uniform polynomial-time evaluator. That convention is standard in computational PAC reductions and is needed for PRF lower bounds against the target. For this edge, however, the evaluator issue is no longer the decisive blocker: the current PRF route already lacks a deterministic source learner under arbitrary tilted marginals.

### Conditional True Principles

The edge would be true under any of the following additional principles.

1. Uniform weak-gap principle. If the source guarantee can be strengthened from $\forall P\ \exists k(P)$ to $\exists K\ \forall P$, full-support resource uniformization plus the same learner proves the target directly.

2. Exposed-tilt extraction. If every failure of a distribution-free inverse-polynomial weak gap yields a base marginal, target, and pre-sample tilt direction whose sign is statistically hidden at the source sample scale but whose covariance dominates the learner's useful correlation, the source is contradicted on one of the tilted marginals.

3. No hidden deterministic neutralizers. If every deterministic improper output rule that is safe under all small tilts must either be pointwise safe on the hard slice or provide a public inverse-polynomial weak signal, then the target follows. Pointwise safety or a public signal can be reused by a distribution-free learner.

4. Sample-only/unbounded-computation route. The marginal-nonuniform sample-rate trichotomy can support distribution-free sample-efficient conclusions in the information-theoretic atlas nodes, but it does not by itself give the computational target here because the ERM or rate-optimal learner may be inefficient.

These are not current atlas theorems for the computational deterministic-improper node. They are the cleanest formulations of what a true proof would have to add.

### Proposed Atlas Summary

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
summary: "Open: full-support transcript uniformization gives one pathwise sample/time polynomial for the single source learner, but the realizable weak gap inherited from the marginal-nonuniform weak agnostic guarantee may have a marginal-dependent exponent. Active-slice and PRF-style false witnesses are blocked in the deterministic improper model by near-balanced tilted marginals unless a genuine deterministic neutralizer exists."
```

### Proposed Proof-Status Body

**Goal.** Decide whether efficient marginal-nonuniform weak agnostic improper learning yields efficient distribution-free weak realizable improper learning.

**Reduction to weak-gap uniformization.** On realizable labels, the source learner gives for each marginal $P$ an advantage $\gamma_P(s)$ that is inverse-polynomial with a marginal-dependent exponent. Since the learner is a single uniform algorithm and atlas-efficient sample/time bounds are pathwise on finite transcripts, a full-support reference marginal uniformizes the resource polynomial. The target still needs one inverse-polynomial weak advantage independent of $P$.

**Why agnostic structure has not closed the gap.** Mixtures with a full-support marginal and low-noise or noisy-label reductions preserve only the unknown marginal-specific gap. To transfer accuracy from a mixture back to the target marginal, the mixture weight must be smaller than the unknown gap; finding such a scale by validation has polynomial cost only after a uniform exponent is already known.

**Failed false witnesses.** Rare active-slice and paired-PRF constructions can make the distribution-free target look hard by hiding the available advantage at a level $N=n^j$. In the deterministic improper model, their source side fails on arbitrary marginals. If the unseen output is mean-biased, near-balanced label-mass tilts with $m/N\ll\Delta\ll1/\sqrt m$ force one of two statistically close marginals to have nonpositive advantage. If the unseen output is balanced, it must orient unseen hard points; for PRF blocks this either has random negative fluctuations larger than the memorized gain or predicts fresh PRF orientations. Public markers, one-sided biases, singleton handles, and core-halo variants are either reusable by the target or avoidable by the source marginal.

**Output-model caveat.** Prediction-time randomized hypotheses would neutralize unseen mass in expectation and should be treated as a separate stochastic-output node. Under the current deterministic binary-output convention, improperness alone does not supply that neutralizer.

**Conclusion.** The edge remains open. A proof needs a weak-gap uniformization theorem, most plausibly through an exposed-tilt extraction lemma for deterministic improper learners. A counterexample needs a deterministic marginal-sensitive neutralizer that survives arbitrary tilted marginals while not becoming a public weak signal for the distribution-free target.

VERDICT: unresolved | scratchpads/open-edge-resolution-2026-05-07/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-weak-realizable-improper-pac/scratchpad.md
