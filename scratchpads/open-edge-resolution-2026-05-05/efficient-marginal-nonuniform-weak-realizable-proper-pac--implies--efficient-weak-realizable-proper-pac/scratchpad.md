# Edge Resolution Scratchpad

Edge:

```text
efficient-marginal-nonuniform-weak-realizable-proper-pac
->
efficient-weak-realizable-proper-pac
```

- date: 2026-05-05
- depth: 1
- edge_file: `atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-weak-realizable-proper-pac.md`
- source: `efficient-marginal-nonuniform-weak-realizable-proper-pac`
- target: `efficient-weak-realizable-proper-pac`
- family: `marginal-uniformization-open`
- atlas files edited: no
- scratchpad-only path: `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-weak-realizable-proper-pac/scratchpad.md`

## Bottom Line

I did not find an atlas-ready proof or separation. I would keep the edge `open`.

The current atlas summary is directionally right but should be sharpened. Under the atlas convention that efficient sample use and running time are worst-case/pathwise bounds on finite encoded transcripts, `full-support-marginal-uniformization` removes the one-call resource obstruction for the single source learner. What remains is the weak-advantage quantifier:

$$
\forall P\ \exists k(P)\ \forall c\in\mathcal C:
\operatorname{err}_P(A,c)\le \frac12-s^{-k(P)}.
$$

The distribution-free target needs one exponent $k_0$ independent of $P$:

$$
\exists k_0\ \forall P\ \forall c\in\mathcal C:
\operatorname{err}_P(B,c)\le \frac12-s^{-k_0}.
$$

I found no theorem that swaps these quantifiers in the computational proper weak setting, and the best counterexample templates still fail at a specific technical point: they can make the proper weak handle arbitrarily small, but a uniform high-confidence source learner must choose the correct orientation without spending samples at the hidden gap scale.

## Sources Read

Local atlas notes:

- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/definitions/efficient-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--sample-efficient-weak-realizable-proper-pac.md`
- `atlas/implications/sample-efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--sample-efficient-weak-realizable-proper-pac.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/sample-complexity-equivalence.md`
- `atlas/arguments/realizable-boosting.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- `atlas/witnesses/pseudorandom-function-classes.md`
- `atlas/arguments/sample-to-computational-hardness.md`

Neighboring scratchpads:

- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-weak-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-realizable-improper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-weak-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`

Primary sources checked:

- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability", OpenReview/PDF. Used for the quantifier pattern that rates may depend on $P$ but must hold uniformly over targets once $P$ is fixed, and for the sample-rate trichotomy.
- Benedek and Itai, "Learnability with respect to fixed distributions", TCS 1991, via the author's publication page/PDF. Used as fixed-distribution background.
- Schapire, "The Strength of Weak Learnability", Machine Learning 1990. Used to verify that standard boosting assumes a distribution-free inverse-polynomial weak edge and naturally outputs an unrestricted/improper aggregate.
- Kearns and Valiant 1994 and Håstad, Impagliazzo, Levin, and Luby 1999, via atlas refs/DOIs. Used as cryptographic-hardness background for PRF/one-way false-witness attempts.

## Exact Goal

Show or refute:

> If one uniform polynomial-time proper learner weakly learns $\mathcal C$ under every marginal $P$, with the inverse-polynomial advantage allowed to depend on $P$, then there is a distribution-free polynomial-time proper weak learner with one inverse-polynomial advantage.

The source is already proper and weak, so neither boosting nor properization is obviously required. The only changed axis is marginal-nonuniform to distribution-free.

## Positive Route Checked

Let $A$ be the source learner. By `full-support-marginal-uniformization`, choose a full-support reference marginal $P^\star$. Since every finite realizable transcript possible under any marginal has positive probability under $P^\star$, the source's pathwise resource bound for $P^\star$ gives one polynomial resource bound for $A$ on all transcripts.

Thus $A$ can be viewed as one distribution-free polynomial-time procedure. Its accuracy guarantee remains:

$$
\forall P\ \exists \gamma_P(s)\ge s^{-k(P)}
\quad
\operatorname{err}_P(A,c)\le \frac12-\gamma_P(s).
$$

If the exponents $k(P)$ had a finite supremum, the edge would be true. The source gives no such envelope.

Classical Schapire/Freund boosting does not fix this edge. Boosting would amplify a known or at least uniformly lower-bounded weak advantage. Its running time and number of weak calls depend polynomially on $1/\gamma$. If $\gamma_P$ can be $s^{-k(P)}$ with unbounded $k(P)$, then no fixed polynomial budget suffices for all marginals. Also, boosting would normally produce a vote of proper hypotheses, not necessarily a proper final hypothesis, though that is secondary here because the target is only weak.

The sample-only sibling is true, but that proof drops computation. Hanneke--Moran--Thiessen's trichotomy implies that polynomial marginal-nonuniform sample rates force finite VC dimension, and then unbounded proper ERM gives distribution-free sample-efficient weak learning. This does not give a polynomial-time proper learner.

### Diagonal Uniformization Attempt

A tempting proof by contradiction is:

1. suppose no uniform weak exponent exists;
2. choose bad marginals $P_d$ and target sizes $s_d$ where the best available gap is below $s_d^{-d}$;
3. mix the $P_d$ into one marginal $P^\oplus$;
4. use the source guarantee for $P^\oplus$ to contradict the bad components.

I do not see how to make this work in the atlas model.

First, the target concept can vary with $d$. The source guarantee for a mixture is uniform over concepts, but one target concept under $P^\oplus$ need not realize the separate hard labelings on all components unless the class has a product/disjoint-union closure property.

Second, a global mixture can assign the bad components tiny mass. Weak learning may ignore a low-mass component and still obtain an inverse-polynomial advantage on the mixture. This is exactly different from strong learning, where arbitrary $\varepsilon$ would eventually force attention to every component.

So this route might prove a theorem under stronger size-indexed or closure assumptions, but not the current abstract edge.

## False Route Checked: PCP Active Slices

The PCP active-slice class separates distribution-free weak improper learning from distribution-free weak proper learning under $\mathrm{NP}\nsubseteq \mathrm{RP}$. It is tempting to use it here because the target is distribution-free weak proper.

This does not establish the assigned source. On the active-slice marginal $U_\varphi$, a source weak proper learner would have to output a proper proof accepted on more than half of the verifier random strings whenever $\varphi$ is satisfiable. Because the source learner is one uniform algorithm, the full-support transcript argument would give a uniform polynomial runtime bound for it. Then the usual active-slice reduction would put $\mathrm{NP}$ in $\mathrm{RP}$.

One cannot hide exhaustive proof search in the marginal-dependent polynomial: the full-support marginal would include the same finite transcripts with positive probability, so any exponential branch on those transcripts would violate the source's pathwise polynomial bound for that full-support marginal.

Adding constants or other cheap proper handles would make the source easier, but it also gives the distribution-free target the same handles. In particular, an all-one handle destroys the all-positive active-slice hardness test for unsatisfiable formulas.

Conclusion: PCP active slices are a good sanity check for the pathwise resource convention, but not a witness for this edge.

## False Route Checked: One-Way Coordinate Weak Handles

The one-way image-coordinate weak-handle class already satisfies distribution-free weak proper learning. Constants and singleton positive atoms give an $\Omega(1/n)$ weak advantage, uniformly over marginals, for the usual length-$n$ coordinate block. Therefore it cannot separate marginal-nonuniform weak proper learning from the distribution-free weak proper target.

The natural repair is to replace the length-$n$ block by a much wider block of size $N=n^K$, where $K$ is fixed by the hard marginal. A singleton handle then gives only $\Theta(1/N)=n^{-K}$ advantage. For each fixed $K$ this is still inverse-polynomial, so it looks marginal-nonuniform; no single exponent works over all $K$, so it looks distribution-free false.

This is the right hidden-gap shape, but the current version is not a proof.

### Orientation Problem

For a balanced hard target under the uniform block, a sampled positive singleton has advantage $\Theta(1/N)$. But under an arbitrary marginal on the same finite block, the positive mass

$$
\alpha=P(c=1)
$$

can be $1/2+\eta$ or $1/2-\eta$ for any small $\eta$.

If $\alpha<1/2$, a default-zero singleton handle is good. If $\alpha>1/2$, a default-one co-singleton handle is good. When $|\eta|$ is much larger than the tiny handle mass, choosing the wrong default gives error above $1/2$.

Choosing the correct default with high confidence requires distinguishing $\alpha$ from $1/2$ at scale roughly $|\eta|$. For the hard interval

$$
\frac1N \ll |\eta| \ll \frac1{\sqrt m},
$$

an $m$-sample uniform polynomial-time learner cannot reliably determine the sign, while the wrong tiny-handle orientation is not weakly valid. Letting $m$ grow like $N^2$ would solve the statistical test for a fixed $K$, but it violates the full-support pathwise resource convention when $K$ is unbounded.

This is the same obstruction recorded in `marginal-uniformization-open`: current hidden-gap counterexamples either use prediction-time randomized hypotheses, or they run into gap-scale validation/orientation tests.

### Lookup-Table Handle Variant

I also checked a stronger handle family: allow proper finite lookup-table handles containing all sampled labeled atoms with a default value. Under a uniform balanced block of size $N=n^K$, a table of $m$ samples has advantage about $m/N$. This would still be marginal-nonuniform for each fixed $K$ and too small for any fixed distribution-free exponent after choosing $K$ large.

However, the orientation issue persists. A default-zero table works below the $1/2$ label-bias threshold, and a default-one table works above it. Empirical majority chooses correctly only when $|\alpha-1/2|\gtrsim 1/\sqrt m$. In the intermediate interval $m/N \ll |\alpha-1/2|\ll 1/\sqrt m$, the correction mass of the table is too small to rescue the wrong default, but the sample is too small to choose the right default with high confidence.

This variant is worth handing to a depth-2 agent because it makes the desired separation quantitative, but as written it is not an atlas-ready counterexample.

## False Route Checked: PRF Hard Blocks

A cryptographic version would use pseudorandom labels on the wide block. The proposed class would contain:

- hard PRF block concepts on blocks of size $N=n^K$;
- constants;
- singleton or finite-lookup proper handles.

For the target lower bound, a distribution-free weak learner with fixed runtime/sample exponent $a$ and weak exponent $b$ could be challenged on a block with $K>a+b+O(1)$. Lookup handles from polynomially many samples would have advantage below $n^{-b}$, and any better proper hypothesis should yield a PRF distinguisher.

This almost gives a conditional separation, but the source proof is missing for the same orientation reason. A source learner that is guaranteed high-confidence weak proper learning for every marginal must handle arbitrary slight label bias on the hard block without spending samples at scale $N^2$.

To make this route work, one needs an orientation-free proper handle: a deterministic proper concept that, after seeing a small sample, is guaranteed to beat $1/2$ by about sample-mass-over-$N$ regardless of which side of the global label bias is larger. I did not find such a handle in the local atlas witnesses or in the checked primary-source background.

## Why The Edge Is Still Not Resolved True

The absence of a counterexample is not evidence for a generic theorem. The source provides no effective lower bound on $\gamma_P$, and no compactness condition over marginals. Even after resource uniformization, the learner may have a valid but arbitrarily tiny inverse-polynomial edge on different marginals.

A proof would need one of the following extra ingredients:

- a diagonal theorem turning $\forall P\exists k(P)$ into $\exists k_0\forall P$ for one polynomial-time learner;
- a structural theorem from the computational source to an efficiently computable finite proper cover;
- a stable-family theorem showing that all relevant marginals have a uniform weak-gap envelope;
- or a model-level convention that weak advantages are part of the learner specification, not merely existence statements in the analysis.

None of these is present in the current atlas definitions.

## Proposed Atlas Refinement

No atlas edit is justified from this pass. If later edits are allowed, I would keep the status open but update the explanation away from generic runtime nonuniformity and toward weak-gap nonuniformity.

Suggested frontmatter direction:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - schapire1990
  - freund1995boosting
  - benedek1991fixed
  - bendavid1995parameterization
  - hanneke2025marginalnonuniform
summary: "Open: full-support transcript uniformization controls the resource cost of the single source learner, but the source still gives only marginal-dependent weak advantages; no known theorem yields one distribution-free inverse-polynomial weak edge."
family: marginal-uniformization-open
argument_note: "[[marginal-uniformization-open|Marginal Uniformization Open]]"
```

Suggested body replacement:

```markdown
## Verdict

`open`.

The source supplies one proper weak learner whose runtime can be made distribution-free by the full-support finite-transcript argument, but whose weak advantage may still depend on the marginal.

## Proof Status

**Goal.** Decide whether marginal-dependent inverse-polynomial weak advantages can be uniformized.

**Resource bookkeeping.** Under the atlas worst-case/pathwise efficiency convention, a full-support reference marginal gives one polynomial bound on the source learner's sample use and running time. Thus the remaining issue is not one-call runtime.

**Weak-gap obstruction.** The source has quantifier form $\forall P\exists \gamma_P$, with $1/\gamma_P$ bounded by a $P$-dependent polynomial. The target requires one inverse-polynomial advantage working for all $P$. Standard boosting needs a quantitative lower bound on the weak advantage and does not by itself preserve proper final output.

**Known near misses.** PCP active-slice hardness refutes distribution-free weak proper learning, but it also refutes the marginal-nonuniform weak proper source once full-support pathwise runtime is enforced. One-way weak-handle classes satisfy the target with an $\Omega(1/n)$ edge. Wide-block PRF or lookup-handle variants expose the desired hidden-gap phenomenon, but current versions run into gap-scale orientation and validation barriers for the marginal-nonuniform source.

**Conclusion.** The edge remains open pending either a weak-gap uniformization theorem or an orientation-free hidden-gap counterexample.
```

## Concrete Obstacles For Depth-2 Agents

1. **Weak-gap quantifier swap.** Need prove or refute
   $\forall P\exists k(P)$ implies $\exists k_0\forall P$ for an efficient proper weak learner after resource uniformization.

2. **Mixture diagonalization.** A mixture of bad marginals dilutes weak gaps, and one concept may not realize all component labelings. A depth-2 positive attempt should specify the exact closure/size-indexed assumptions under which this diagonal can work.

3. **PCP source failure.** Active-slice PCPs cannot be source-positive unless cheap proper handles are added. But handles strong enough for the source tend to destroy the distribution-free target lower bound.

4. **Orientation barrier.** Wide-block singleton/lookup handles give the right marginal-dependent scale, but high-confidence selection between default zero and default one appears to need samples at the hidden gap scale.

5. **Prediction-time randomness.** A randomized predictor that is unbiased off the sampled point would be an elegant orientation-free handle, but the target/source are proper deterministic concept-output nodes. A useful branch would derandomize this without leaking a uniform weak handle to the target.

## Promising Depth-2 Branches

1. **Formalize wide-block lookup lower bounds.** Build a clean theorem for blocks of size $n^K$: any polynomial-sample proper lookup-handle learner has advantage at most $\operatorname{poly}(n)/n^K$ unless it outputs a hard PRF concept. Then isolate exactly where source orientation fails.

2. **Search for orientation-free deterministic handles.** Look for a proper concept family whose small-sample handle has guaranteed positive correlation independent of the global label bias, perhaps using balanced hash families, pair designs, or deterministic signed codewords.

3. **Relativized oracle model.** Before proving a cryptographic separation, try an oracle concept class where hard block labels are random and proper hypotheses are restricted to hard labels plus handles. This may clarify whether the orientation barrier is inherent.

4. **Size-indexed marginal semantics.** Prove the edge true under a modified convention where a marginal is a size-indexed family and bad gaps cannot be hidden by global mixture weights. Compare that theorem with the current global-marginal atlas semantics.

5. **Known distribution-specific weak learning.** Search for fixed-distribution weak learning lower bounds where every marginal has some efficiently findable weak proper handle, but no uniform edge. Feldman-style distribution-specific SQ separations may be relevant if made proper and realizable.

## Final State

I did not resolve the edge. The mature state after this pass is:

- Resource nonuniformity alone is not the issue because of full-support transcript uniformization.
- Sample-only marginal nonuniformity does collapse to distribution-free sample efficiency.
- The computational proper weak edge remains blocked by the hidden weak advantage.
- The best false templates need a new orientation-free hidden-gap handle.

verdict: unresolved
confidence: 0.78

## Depth 3 Branch: distribution-free weak proper target

- date: 2026-05-05
- depth: 3
- branch focus: does the proper distribution-free weak target make a false witness easier, or does it only inherit the hidden weak-gap obstruction?
- atlas files edited: no

### Local Question

The target is not an improper learner. This initially looks helpful for a false witness: an improper weak learner could use randomized predictions, voting, or sample memorization outside the class, while the target here must output one proper hypothesis $h\in\mathcal C$.

The catch is that the source is also proper. Any cheap proper handle added to make the marginal-nonuniform weak source true is automatically an allowed output for the distribution-free weak proper target. Therefore properness helps the target lower-bound side only if the handles can be made marginally useful but distribution-free too small.

In quantifiers, the desired false witness would need:

$$
\forall P\ \exists k(P):\text{ some efficient proper handle gives edge }s^{-k(P)}
$$

but also, for every fixed $k_0$,

$$
\exists P,c:\text{ no efficient proper output gives edge }s^{-k_0}.
$$

So the branch reduces again to hidden weak-gap engineering. Properness removes some improper escape routes, but it does not by itself create the gap.

### Ordinary One-Way Weak Handles Are Target-Positive

The existing one-way image-coordinate weak-handle witness is not a counterexample to this edge. It adds constants and positive-atom handles. For a length-$n$ coordinate target with positive mass $M$:

- if $M$ is noticeably below $1/2$, all-zero is weakly good;
- if $M$ is noticeably above $1/2$, all-one is weakly good;
- if $M$ is near $1/2$, a heaviest positive singleton improves the all-zero hypothesis by $\Omega(M/n)$.

Thus the best of constants and singleton handles gives an $\Omega(1/n)$ proper weak edge. This is already distribution-free. The target being proper does not hurt the learner, because the weak handles are themselves proper concepts.

Bounded positive-atom handles make the same point more strongly. If the class contains handles for a constant fraction of the positive coordinate atoms, then near balance the learner can obtain a constant or fixed inverse-polynomial edge. These handles were designed to make weak proper learning easy; once they are in the class, the distribution-free proper target can use them too.

Conclusion: the existing one-way weak-handle and bounded-handle witnesses separate stronger proper tasks from weak proper learning, but they do not separate marginal-nonuniform weak proper learning from distribution-free weak proper learning.

### Wide Handles Give The Right Scale But Not A Source

The tempting repair is to replace the length-$n$ block by a much wider block of effective size

$$
N=n^K
$$

where $K$ is fixed by the hard marginal. Singleton or small lookup handles then give edge about $1/N=n^{-K}$. For each fixed marginal this is still inverse-polynomial, but no single exponent works over all $K$.

This is exactly the desired target-failure scale. If a distribution-free learner has sample/runtime exponent $r$ and claims edge $n^{-b}$, choose $K\gg r+b$. On the uniform near-balanced block, sampled singleton or bounded-size handles have total correction mass at most about $m/N$, too small to certify edge $n^{-b}$. A proper learner that outputs a genuinely hard one-way/PRF concept would contradict the intended cryptographic hardness.

But the source proof breaks before cryptography is used. The marginal-nonuniform source must succeed for every marginal on the same wide block, not just the uniform balanced marginal.

Let $S$ be the positive set of the realizable target and consider two marginals:

$$
P_+(S)=\frac12+\eta,\qquad
P_-(S)=\frac12-\eta.
$$

A default-zero positive handle of correction mass $q$ has error

$$
P(S)-q.
$$

So under $P_+$ it is weakly useful only if $q>\eta$, while under $P_-$ the same orientation is helped by both the negative bias and the correction mass. The default-one/co-negative orientation has the opposite behavior.

For an $m$-sample learner using singleton or bounded sample handles, the visible correction mass is at most about

$$
q\lesssim \frac{m}{N}
$$

under the uniform wide block. Choose

$$
\frac{m}{N}\ll \eta\ll \frac1{\sqrt m}.
$$

Then the two marginals $P_+$ and $P_-$ cannot be distinguished reliably from $m$ samples, but choosing the wrong default orientation gives error at least $1/2$. This is not merely a failure to get the requested edge; it is a failure to be a weak learner at all on one of the two marginals.

A marginal-dependent polynomial sample bound could distinguish the sign for a fixed $K$ by taking enough samples, but the earlier resource-uniformization observation blocks that as an atlas-ready source proof. Since the source learner is one uniform algorithm and full-support finite transcripts have positive probability under a reference marginal, arbitrarily large hidden $K$ cannot be handled by spending $N^2$ samples on those transcripts while retaining one pathwise polynomial bound.

### Bounded-Handle Variants

Bounded handles split into two regimes.

If "bounded" means a fixed fraction of the active positive atoms, then the handles are too powerful for a false witness. Near balance they give a visible correction mass $q=\Omega(1)$, so the distribution-free proper target again has a uniform weak edge.

If "bounded" means polynomially many listed atoms, with the exponent independent of the hidden block scale, then the false target side becomes plausible: for $N=n^K$ with $K$ larger than the learner's fixed exponent, the total mass of any observed/listed correction is too small. But the source side inherits the same orientation problem. The learner must still decide between the default-zero and default-one orientations in the interval

$$
\frac{\operatorname{poly}(n)}{N}\ll |\eta|\ll \frac1{\sqrt m}.
$$

Adding both orientations to the proper class does not solve this. The learner must output one proper hypothesis with high probability. A randomized choice of orientation succeeds only with constant probability on one of $P_+$ or $P_-$, and a validation step accurate enough to choose the orientation costs samples at the hidden-gap scale.

### Does Properness Help The False Witness?

Only partially.

Properness helps rule out some improper repairs to the target, such as randomized unbiased predictors or votes of many tiny handles. Those would be natural ways to defeat a sparse-handle lower bound.

However, the same properness requirement also makes the source harder. The source cannot output a mixed predictor, a pair of opposite orientations, or an improper fallback that is unbiased away from sampled points. It must choose one concept in $\mathcal C$, and near balance that choice requires information at the hidden scale unless the class contains an orientation-free proper handle.

Thus the proper target does not make the false witness substantially easier. It mostly removes irrelevant improper escape routes, while the decisive problem remains: find a deterministic, efficiently findable, orientation-free proper handle whose advantage can be marginal-dependent and arbitrarily small without becoming a distribution-free weak handle.

### Branch Verdict

No atlas-ready proof or separation emerges from this branch.

The edge still appears to inherit the hidden-gap open status. Ordinary one-way weak-handle and bounded-handle witnesses are target-positive. Wide-block variants create the desired nonuniform weak-gap scale, but singleton, co-singleton, lookup, and polynomially bounded handles fail to prove the marginal-nonuniform weak proper source because of the near-balanced orientation barrier.

verdict: unresolved; keep edge `open`

confidence: 0.82

next branches:

1. Formalize the two-marginal orientation obstruction as a reusable lemma for any handle family whose sampled correction mass is $o(|P(c=1)-1/2|)$.
2. Search specifically for deterministic orientation-free proper handles; rule out pair-handle, signed-code, or balanced-hash variants before trying another cryptographic block witness.
3. Separate fixed-gap weak proper variants from the current hidden-gap node. Proper target lower bounds may be much easier when the required weak advantage exponent is fixed in advance.

## Depth 4 Branch: properness, finite traces, and hidden-gap handles

- date: 2026-05-05
- depth: 4
- branch focus: whether properness in the target uniformizes marginal-nonuniform weak proper learning, or whether a source-positive/target-negative proper witness survives the earlier orientation obstruction
- atlas files edited: no
- verdict: unresolved-open

### Bottom Line

I still would not change the atlas edge. Properness does not seem to give a black-box positive theorem: it only says the marginal-nonuniform learner already outputs a concept in $\mathcal C$, not that the concept has a marginal-independent correlation gap. But properness also blocks the cleanest false witnesses, because any deterministic proper handle that makes the source true for every marginal tends either to become a uniform distribution-free weak handle, or to require choosing an orientation at a scale no uniform polynomial sample bound can validate.

The most promising source-positive/target-negative idea remains a hidden-gap block family:

$$
N_s=s^{K}
$$

with proper lookup or singleton handles whose visible advantage is about $\operatorname{poly}(s)/N_s=s^{-K+O(1)}$. For each fixed hard marginal this is inverse-polynomial with a marginal-dependent exponent, while no single exponent works over all $K$. The depth-4 conclusion is that this shape is necessary but not sufficient: the source proof still fails for arbitrary same-block marginals unless the class supplies an orientation-free deterministic proper handle.

### Why Properness Does Not Give A Positive Uniformization

The source and target are both proper, so there is no properization step to perform. After applying the full-support finite-transcript argument, the source learner can be treated as having one distribution-free pathwise polynomial resource bound. The remaining guarantee is still only

$$
\forall P\ \exists k(P)\ \forall c\in\mathcal C:
\Pr\left[\operatorname{err}_P(A(S),c)\le \frac12-s^{-k(P)}\right]\ge 1-\delta.
$$

The target needs

$$
\exists k_0\ \forall P\ \forall c\in\mathcal C:
\Pr\left[\operatorname{err}_P(B(S),c)\le \frac12-s^{-k_0}\right]\ge 1-\delta.
$$

Properness only constrains the range of $A(S)$; it does not give a lower bound on the correlation of that output. A validation wrapper cannot manufacture the missing exponent, because estimating whether a candidate has advantage $s^{-K}$ needs about $s^{2K}$ labeled examples. Running the source learner on reweighted or filtered marginals reintroduces the same marginal-boosting envelope problem recorded in `marginal-boosting-open`: the induced marginals have their own unknown exponents.

A compactness-style diagonal also still needs more structure. If there are bad marginals $P_i$ with gaps tending below every inverse polynomial, mixing them into $P^\oplus=\sum_i w_iP_i$ does not force a contradiction. Weak learning can ignore sufficiently low-weight components, and a single target concept under $P^\oplus$ need not realize all separately chosen hard labelings unless the class has a disjoint-union closure property. Properness of the output does not supply that closure.

### Finite-Trace Proper Memorization Is A Near Miss

There is a tempting positive theorem for countable recursive representations. For a fixed countably supported marginal $P$, choose a finite trace $F$ carrying mass at least $3/4$. If $\mathcal C$ is recursively enumerable and every realizable trace on $F$ has an effectively findable proper representative, then a learner can identify the target labels on $F$ and output a proper concept matching that trace. This gives fixed-marginal weak proper learning without using the source learner.

This does not resolve the assigned edge for two reasons.

First, it is a model-level extra assumption. The atlas definitions do not currently promise an effective proper enumeration, a total evaluator, or a stopping certificate saying that the first trace-consistent concept has been found. The neighboring properization note treats exactly this as a conditional finite-trace near theorem, not an atlas theorem.

Second, even if accepted, it would only show marginal-nonuniform weak proper learnability for many countable classes. It would not give the distribution-free target. A distribution-free learner cannot choose the $P$-heavy trace in advance, and for broad lookup classes the uniform finite-domain marginal on a large block recreates the usual no-free-lunch lower bound: with polynomially many samples, an unseen near-balanced labeling can keep every deterministic proper lookup output at correlation about sample-mass over block-size.

So finite-trace properness explains why the source side may be broad, but it does not uniformize the weak advantage.

### Attempted False Witness: Sparse Proper Lookup Blocks

The cleanest candidate witness would use disjoint blocks $B_{s,K}$ of size $N=s^K$ and a class containing:

- hard balanced target concepts on each block, possibly PRF- or one-way-indexed;
- the constants;
- proper lookup handles that memorize polynomially many labeled atoms with a default value;
- no richer handles whose correction mass is uniformly inverse-polynomial in $s$.

For a target-failure argument, fix any proposed distribution-free weak learner using at most $m=s^a$ samples and claiming advantage $s^{-b}$. Choose $K>a+b+2$ and use the uniform marginal on a balanced hard block. A sampled lookup handle then corrects at most $m/N\le s^{-b-2}$ mass. If every non-handle proper concept with correlation $s^{-b}$ decodes the hard witness, a PRF or one-way reduction would rule out the target.

This is the right lower-bound geometry. The source-positive side is where the construction breaks.

Let $S$ be the positive region of the target under some marginal on the same block, and write

$$
P(S)=\frac12+\eta.
$$

A default-zero positive lookup handle with correction mass $q$ has error

$$
\frac12+\eta-q.
$$

It is weak only when $q>\eta$. The default-one negative handle has the symmetric condition when $\eta<0$. A polynomial-sample learner can estimate the sign of $\eta$ only down to scale about $1/\sqrt m$, while sparse handles on the wide block have $q\lesssim m/N$. For

$$
\frac{m}{N}\ll |\eta|\ll \frac1{\sqrt m},
$$

the wrong orientation is not weak, and the right orientation cannot be chosen with high confidence from $m$ samples. This creates a marginal on which the proposed source learner fails. Taking more samples depending on $K$ would repair this one marginal, but the full-support pathwise resource argument forbids a single source learner from spending $N^2$ samples on those finite transcripts while still having one polynomial bound under a full-support reference marginal.

### Ruling Out The Obvious Orientation-Free Repairs

I checked three deterministic repairs; none gives an atlas-ready witness.

**Both defaults in the class.** Including both default-zero and default-one lookup concepts is necessary, but the learner must output one of them with probability at least $1-\delta$. A random choice succeeds on only one side of the two nearby marginals, and validation at the needed scale costs $1/\eta^2$ samples.

**Pair or signed-code handles.** One might pair atoms and output a concept that agrees with the sample on one atom and flips the paired atom, hoping to get correlation independent of global label bias. This only works under symmetric pair marginals. The source quantifies over arbitrary marginals, including ones concentrating most pair mass on the side where the default behavior is wrong. Constants or heavy-atom memorization handle large imbalances, but the same intermediate interval $q\ll |\eta|\ll 1/\sqrt m$ remains unless the pair handle has correction mass comparable to $|\eta|$.

**Balanced hash handles.** A family of balanced hash-like proper concepts can make every target have some mildly correlated codeword under a uniform block. But if the family is explicit and searchable enough for the source, then the distribution-free target can search or sample the same family and obtains a uniform weak handle. If the family is cryptographically hidden, the source no longer has an efficient way to find the correlated handle for every fixed marginal. This is the same tension as the coding/list-decoding discussion in `properization-open`: residual inverse-polynomial correlations are either findable handles for the target or too hidden for the source.

### What Would Resolve The Edge False

A conditional counterexample would need all of the following in one class:

1. A uniform polynomial-time proper source learner whose pathwise sample bound is independent of the marginal.
2. For each marginal $P$, an inverse-polynomial weak edge whose exponent may depend on $P$.
3. For every fixed distribution-free exponent $b$, a marginal and realizable target under which all efficiently findable proper handles have correlation $o(s^{-b})$.
4. A hardness argument that any proper hypothesis with correlation at least $s^{-b}$ decodes a hard witness.
5. An orientation-free deterministic proper handle mechanism, so the source learner does not need to decide between default-zero and default-one at hidden scale.

The fifth item is the missing piece. Current singleton, lookup, bounded-subset, pair, signed-code, and hash-handle variants fail there.

### What Would Resolve The Edge True

A positive theorem would need a real weak-gap uniformization principle, not just resource uniformization. Plausible sufficient hypotheses would be:

- a size-conditional marginal semantics preventing bad gaps from being hidden in low-mass global mixture slices;
- a compact, effectively searchable family of proper hypotheses whose correlation function has a uniform inverse-polynomial minimum once it is positive for every marginal;
- a stability assumption saying the source learner's marginal-dependent exponents are locally bounded over all marginals reached by validation, filtering, or reweighting;
- or a convention that the weak advantage exponent is part of the learner specification and therefore cannot vary with $P$.

None of these hypotheses is present in the current definition of `efficient-marginal-nonuniform-weak-realizable-proper-pac`.

### Verdict

`unresolved-open`.

Properness in the target does not appear to uniformize the marginal-dependent weak advantage. But properness also makes the best false witnesses much harder: the source itself must output one deterministic concept, and all known sparse proper handles run into the near-balanced orientation barrier. The next genuinely promising move is either to prove an impossibility lemma for orientation-free deterministic hidden-gap handles under arbitrary marginals, or to construct a cryptographic block class where finding the correct orientation and a weak handle are the same easy fixed-marginal task but still too weak to give any distribution-free inverse-polynomial edge.

References used in this depth-4 pass: `benedek1991fixed`, `bendavid1995parameterization`, `hanneke2025marginalnonuniform`, `schapire1990`, `freund1995boosting`, `kearns1994cryptographic`, `hastad1999prg`, `plotkin1960`, `mceliece1977`, `guruswami2010list`.

## Depth 5 Branch: finite traces, sparse blocks, and orientation-free handles

- date: 2026-05-05
- depth: 5
- branch focus: push the three strongest remaining directions: finite-trace near theorem, sparse lookup block false witness, and deterministic orientation-free hidden-gap handles
- atlas files edited: no
- verdict: unresolved-open

### Bottom Line

I still cannot resolve the edge. The best depth-5 update is a sharper diagnosis:

1. The finite-trace route gives a real conditional theorem for fixed marginals, but it is too conditional and too distribution-specific to imply the target.
2. The sparse lookup block route has the right target-negative geometry, but it is not source-positive unless one can build deterministic proper handles with positive correlation that is independent of the global positive/negative orientation.
3. The orientation-free handle requirement can be stated as a concrete local correlation condition. The obvious deterministic candidates either fail this condition under arbitrary marginals, or satisfy it only by becoming a uniform distribution-free weak handle.

So the edge remains `open`; no atlas status change is justified.

### Finite-Trace Near Theorem

Here is the cleanest theorem-shaped statement I can extract.

**Conditional finite-trace theorem.** Fix a marginal $P$. Suppose that for every representation size $s$ and every mass threshold $\rho>0$ there is an effectively findable finite set $F_{P,s,\rho}$ carrying $P$-mass at least $1-\rho$ on all examples relevant to size $s$. Suppose also that the class has effective proper trace extension: given any realizable labeled trace on $F_{P,s,\rho}$, the learner can find some $h\in\mathcal C$ matching that trace in time polynomial in the trace size and the target representation size, with the polynomial allowed to depend on $P$. Then $\mathcal C$ is marginal-nonuniform weak realizable proper learnable under $P$.

The proof is straightforward. Choose $\rho<1/4$, sample enough to identify the labels on the heavy trace with high confidence, and output a proper trace extension. The resulting error is below $1/4$ on $P$, hence weak with constant advantage. If the trace size bound is only $s^{k(P)}$, the resulting advantage and runtime are still marginal-dependent polynomial.

This theorem is useful because it explains why a source-positive construction can be quite broad for fixed marginals. It also explains why finite-support or effectively finite-trace marginals are not a good place to search for hardness of the source.

But it does not prove the assigned edge. The atlas source does not assume that heavy traces are effectively findable from $P$, that proper trace extension is decidable, or that the learner has any certificate that it has found a valid extension. More importantly, even if the conditional theorem is accepted as a source proof for a proposed witness, it says nothing distribution-free. A target learner facing the uniform marginal on a large block cannot know a small heavy trace in advance; if the block has size $N=s^K$, a polynomial number of samples sees only $\operatorname{poly}(s)/N$ of the mass.

Thus finite traces are source-positive but not target-positive only when the trace size exponent is allowed to depend on $P$. That is exactly the hidden-gap shape, not a resolution of it.

### Sparse Lookup Block False Witness Revisited

The strongest false template is still:

- blocks $B_{s,K}$ of size $N=s^K$;
- hard balanced targets on the block, e.g. PRF-like or one-way-image-coordinate-like concepts;
- constants and sparse proper lookup handles;
- no dense handles that give a fixed inverse-polynomial edge independent of $K$.

For the target lower bound, this geometry is excellent. If a distribution-free weak proper learner uses $m=s^a$ samples and claims advantage $s^{-b}$, choose $K>a+b+3$. Under the uniform balanced marginal on $B_{s,K}$, any lookup handle supported only on observed atoms has correction mass at most

$$
q \le \frac{m}{N} \le s^{-b-3}.
$$

So sparse handles cannot supply the claimed edge. A non-handle proper output with correlation $\Omega(s^{-b})$ can then be designed to decode the hard witness, giving the usual cryptographic contradiction if the block labels come from a suitable one-way or PRF construction.

The source side is the fatal part. For each fixed $K$, the source is allowed an edge as small as $s^{-K+O(1)}$, so a sparse lookup handle would be numerically acceptable. The problem is not the magnitude of the edge. It is choosing a deterministic proper hypothesis whose edge has the right sign for every marginal on the same block.

### A Local Orientation Lemma

The orientation obstruction can be put in a reusable form.

Let a target concept have positive region $S$. Consider two marginals with the same conditional distributions on $S$ and $S^c$, but with

$$
P_\eta(S)=\frac12+\eta,\qquad P_{-\eta}(S)=\frac12-\eta.
$$

For a deterministic hypothesis $h$, write its conditional signed correlations as

$$
r_+(h)=\mathbb E[2h(X)-1\mid X\in S],
$$

and

$$
r_-(h)=\mathbb E[1-2h(X)\mid X\in S^c].
$$

The correlation with the target under $P_\eta$ is

$$
\left(\frac12+\eta\right)r_+(h)+\left(\frac12-\eta\right)r_-(h)
= \frac{r_+(h)+r_-(h)}2+\eta\bigl(r_+(h)-r_-(h)\bigr).
$$

Thus a hypothesis is orientation-free on this pair only if its balanced correlation

$$
q_0(h)=\frac{r_+(h)+r_-(h)}2
$$

dominates the possible adverse orientation term $\eta(r_+(h)-r_-(h))$. Since $r_+(h)-r_-(h)$ can be as large as $2$ in magnitude for default-oriented lookup handles, those handles need $q_0(h)\gtrsim |\eta|$ to be weak on both $P_\eta$ and $P_{-\eta}$.

Now take an $m$-sample learner and choose

$$
\frac{m}{N}\ll |\eta|\ll \frac1{\sqrt m}.
$$

The two sample distributions are statistically close enough that no learner can choose opposite orientations with high confidence. But sparse lookup concepts have balanced correlation only $q_0\lesssim m/N$, too small to be orientation-free. Therefore one of the two marginals defeats the source learner.

This lemma is not a full lower bound for every possible proper handle. It only rules out handles whose positive balanced correlation comes from observed sparse correction mass while the unseen region behaves like a default orientation. But that covers singleton handles, finite lookup tables with a default, co-singletons, bounded observed subsets, and the pair/signed-code variants tried so far.

### Why The Obvious Orientation-Free Handles Do Not Work

An orientation-free deterministic handle would need to have $r_+(h)$ and $r_-(h)$ both mildly positive, so that $q_0(h)>0$ and $r_+(h)-r_-(h)$ is small. In words, it must agree with the target slightly more than half the time inside the positive region and slightly more than half the time inside the negative region, without knowing the global sign of the imbalance.

The natural candidates all lose one side of this tradeoff.

**Sample lookup with both labels.** A table that memorizes sampled positive and negative points and uses a fixed default off-sample does not have positive conditional correlation on both $S$ and $S^c$. One side is helped by the exceptions; the other side inherits the wrong default. This is just the orientation lemma.

**Pair handles.** Pairing atoms and flipping the partner of each sampled atom can make a symmetric calculation look orientation-free under a specially paired marginal. But the source quantifies over arbitrary marginals. A marginal can put most of the conditional mass on the unfavorable side of the pairs, making either $r_+$ or $r_-$ negative.

**Balanced hash or code handles.** If an explicit family of balanced concepts guarantees that every target has a searchable codeword with $r_+,r_->0$, then the distribution-free target can search or validate the same family and obtains a uniform weak handle. If the family is hidden cryptographically, the source learner also cannot find the right codeword for an arbitrary fixed marginal. This is the recurring "findable means target-positive; hidden means source-negative" tension.

**Randomized unbiased off-sample prediction.** This would be the clean conceptual fix: memorize the sample and predict by an unbiased random coin elsewhere. Its expected correlation is about sample mass and independent of orientation. But the atlas node is deterministic proper concept output. A randomized predictor or a vote is improper for this edge unless the class contains deterministic derandomizations, and deterministic derandomizations are exactly balanced code handles above.

### A Sharper View Of The Remaining Open Problem

The unresolved core is now quite narrow. To prove the edge false, one needs a class where the source learner can always find a deterministic proper handle satisfying

$$
r_+(h)>0,\qquad r_-(h)>0,
$$

with balanced correlation as small as $s^{-K(P)}$, while every distribution-free polynomial-time learner has no handle of correlation $s^{-b}$ on some wider block.

This is stronger than merely adding sparse lookup tables. It asks for a deterministic proper analogue of an unbiased randomized memorizer, but with a correlation scale that can be made arbitrarily small across marginals.

To prove the edge true, one would need to show that this requirement is impossible in general: any uniform algorithm that, for every marginal, finds such deterministic proper handles with some inverse-polynomial edge must in fact have a uniform inverse-polynomial edge. I do not see a proof of that. The local orientation lemma only rules out sample-local sparse handles, not arbitrary proper concepts with balanced residual correlation.

### Verdict

`unresolved-open`.

The finite-trace route is a useful conditional source theorem, and the sparse lookup block route is a good target lower-bound template. The missing object remains an orientation-free deterministic proper hidden-gap handle. I did not find one, and I also did not prove that none can exist under the current atlas definitions.

Depth 6 should focus on one of two concrete tasks:

1. Prove a general impossibility theorem for sample-local deterministic proper handles: if a handle's balanced correlation is generated only by the observed labeled mass, then arbitrary near-balanced marginals force the orientation lower bound above.
2. Try a real construction of deterministic orientation-free handles using pairwise-independent code families, but require an explicit source algorithm and check whether the same search immediately gives the distribution-free target a uniform edge.

## Depth 6 Final Synthesis: no resolution after the finite-trace and sparse-handle audit

- date: 2026-05-05
- depth: 6
- branch focus: last hard attempt on the finite-trace near theorem, sparse lookup block false witness, and the local orientation lemma for sparse deterministic handles
- atlas files edited: no
- verdict: final-unresolved-open

### Bottom Line

I still do not have an atlas-ready proof or counterexample. The final recommendation is to keep this edge `open` in the `marginal-uniformization-open` family, but to rewrite the atlas explanation so the obstruction is stated precisely:

> Full-support finite-transcript uniformization removes the one-call resource nonuniformity. The remaining obstruction is weak-gap uniformization: the source gives $\forall P\exists k(P)$, while the target needs $\exists k_0\forall P$. The best false-witness template needs deterministic orientation-free proper hidden-gap handles; sparse lookup, singleton, co-singleton, pair, signed-code, and public hash handles do not supply them.

The edge is therefore not merely "runtime nonuniformity" anymore. It is a hidden weak-advantage problem under deterministic proper output.

### What The Finite-Trace Near Theorem Really Gives

The finite-trace route gives a useful conditional theorem, but it does not cross the distribution-free gap.

**Near theorem.** Fix a marginal $P$. Suppose that for each representation size $s$ there is a $P$-dependent finite trace $F_{P,s}$ with $P(F_{P,s})\ge 3/4$, and suppose there is an effective proper trace selector: from any realizable labeling of $F_{P,s}$ it finds some $h\in\mathcal C$ matching that trace. If the selector's stopping time and trace size are bounded by a $P$-dependent polynomial, then fixed-marginal weak proper learning follows, with constant advantage.

This is a genuine source-side near theorem. It explains why many fixed-marginal proper weak learners are plausible: learn the labels on a heavy finite trace and output a proper extension.

But it cannot prove the assigned implication. A distribution-free target learner cannot choose $F_{P,s}$ in advance, and on the uniform marginal over a block of size $N=s^K$ the heavy trace is essentially the whole block. A fixed polynomial-sample learner sees only $m/N$ mass. Also, under the atlas pathwise resource convention, a proposed source algorithm cannot spend $s^K$ samples on high-$K$ finite transcripts if a full-support reference marginal makes those transcripts possible; the single source learner already has one transcript-wise polynomial resource bound. Thus finite traces are a source-positive explanation, not a target-positive theorem.

### Sparse Lookup Blocks Still Give The Right Lower-Bound Geometry

The target-negative half of the sparse-block witness remains compelling.

Take blocks $B_{s,K}$ of size $N=s^K$. Let a distribution-free weak learner use $m=s^a$ samples and claim advantage $s^{-b}$. Choosing $K>a+b+3$ makes every sample-local lookup correction have mass at most

$$
q\le \frac{m}{N}\le s^{-b-3}.
$$

So lookup handles cannot achieve the claimed edge under the uniform balanced block marginal. If the non-handle proper hypotheses are cryptographically hard, any proper hypothesis with correlation $\Omega(s^{-b})$ could be made to decode a PRF seed, one-way preimage, or PCP witness. This is the right false-witness skeleton.

The source-positive half is what fails. For each fixed $K$, the marginal-nonuniform source would be allowed the tiny edge $s^{-K+O(1)}$, but the learner must output one deterministic proper concept with the correct sign under every marginal on the same block. Sparse lookup handles do not know that sign.

### Final Local Orientation Lemma

Here is the cleanest reusable obstruction.

Let $c$ be a target and let $S=\{x:c(x)=1\}$. Consider two marginals with identical conditional distributions inside $S$ and $S^c$, but with

$$
P_+(S)=\frac12+\eta,\qquad P_-(S)=\frac12-\eta.
$$

An $m$-sample learner cannot distinguish $P_+$ from $P_-$ with high confidence when $|\eta|\ll 1/\sqrt m$; the total variation distance between the two $m$-sample label-count distributions is $O(|\eta|\sqrt m)$.

Now consider deterministic sparse lookup handles whose only target-dependent correction off a default orientation has mass $q$. If the handle uses the default-one orientation, it is correct on the unseen majority side for $P_+$ but wrong for $P_-$. If it uses the default-zero orientation, the reverse holds. On the wrong side its error is at least

$$
\frac12+|\eta|-q.
$$

Thus when

$$
q\ll |\eta|\ll \frac1{\sqrt m},
$$

the learner cannot reliably choose the right orientation, and the wrong orientation is not even weakly better than random guessing. For sparse lookup blocks, $q\le m/N$, so choosing $N$ large creates exactly this interval.

This lemma rules out the current deterministic sparse-handle templates: singletons, co-singletons, finite lookup tables with defaults, bounded observed subsets, paired corrections under arbitrary marginals, and signed-code variants whose positive balanced correlation is generated only by observed mass.

### Last Attempted Escape: Deterministic Unbiased Handles

The only way around the lemma is an orientation-free deterministic proper handle: a hypothesis whose conditional correlations are both positive,

$$
r_+(h)>0,\qquad r_-(h)>0,
$$

so the balanced correlation survives both $P_+$ and $P_-$ without estimating the sign of $\eta$.

The tempting construction is a deterministic derandomization of the improper randomized memorizer: memorize the sample and behave like an unbiased coin off-sample. But every deterministic version I can see falls into one of two cases.

1. **Public/searchable derandomization.** If balanced hash, code, or pairwise-independent handles are explicit enough that the source learner can find a correlated one, then a distribution-free target learner can search or validate the same public family and gets a uniform weak handle. This kills target hardness.
2. **Hidden/cryptographic derandomization.** If the correlated handle is hidden enough to block the distribution-free target, the source learner also cannot find it for arbitrary fixed marginals. Empirical validation at correlation $s^{-K}$ costs about $s^{2K}$ samples, which contradicts the full-support pathwise resource bound.

Randomized prediction-time hypotheses would bypass much of this, but they are not proper deterministic concept outputs in the current atlas node.

### Final Obstruction

The precise missing object for a false edge is:

> A deterministic, efficiently findable, proper hidden-gap handle family such that for every marginal $P$ and realizable target $c$, a single uniform polynomial-time learner finds $h\in\mathcal C$ with positive correlation at some $P$-dependent inverse-polynomial scale, while for every fixed distribution-free exponent $b$ there is a wider block on which no polynomial-time learner can find correlation $s^{-b}$.

The depth-5 orientation lemma shows that this object cannot be sample-local sparse lookup with a default. The finite-trace theorem shows why fixed-marginal learning alone is too weak to refute the source. What is still missing is either:

- an impossibility theorem saying every such deterministic orientation-free hidden-gap handle yields a uniform inverse-polynomial edge; or
- a concrete construction of such handles with a source algorithm that does not immediately give the distribution-free target the same handle.

I do not see either theorem in the current atlas material.

### Recommended Atlas Incorporation

Recommended status: keep `status: "open"` and `evidence: unknown`.

Recommended family: keep `family: marginal-uniformization-open`, with a sharper summary:

```yaml
summary: "Open: full-support finite-transcript uniformization gives one resource polynomial for the source learner, but the weak advantage may remain marginal-dependent; known sparse hidden-gap handle templates fail because deterministic proper outputs must solve a near-balanced orientation problem."
```

Recommended body language:

```markdown
## Proof Status

**Goal.** Decide whether the marginal-dependent weak edge $\forall P\exists k(P)$ can be replaced by one distribution-free exponent $\exists k_0\forall P$ for a proper efficient learner.

**Resource uniformization.** Under the atlas pathwise efficiency convention, the single source learner's sample use and runtime can be bounded uniformly by applying the source guarantee to a full-support reference marginal. Accuracy under the actual marginal still gives only a $P$-dependent inverse-polynomial advantage.

**Main obstruction.** Sparse hidden-gap block witnesses can make the available proper handle have mass $s^{-K}$ on a block of size $s^K$, which is too small for any fixed distribution-free weak exponent. But to satisfy the source under arbitrary marginals, the learner must choose a deterministic orientation. For two near-balanced marginals with $P(c=1)=1/2\pm\eta$, where sampled correction mass $q\ll |\eta|\ll 1/\sqrt m$, no $m$-sample learner can reliably choose between the default-zero and default-one handles, and the wrong orientation has error above $1/2$.

**Near misses.** Fixed-marginal finite-trace search gives a conditional weak proper learner when heavy traces and proper trace extensions are effectively findable, but this is distribution-specific and does not give the target. PCP active-slice hardness refutes weak proper targets only when the source is improper; with a proper source it fails unless cheap handles are added, and sparse handles run into the orientation obstruction. Public balanced-code or hash handles are either reusable by the distribution-free target or hidden from the source as well.

**Conclusion.** The edge remains open pending either a weak-gap uniformization theorem or an orientation-free deterministic proper hidden-gap counterexample.
```

Final verdict: `unresolved-open`.

Confidence: high that the current atlas should not mark the edge true or false; medium-high that the sparse deterministic handle family is exhausted by the orientation lemma; medium that a future resolution will require either changing deterministic/proper output semantics or proving a real weak-gap compactness theorem.
