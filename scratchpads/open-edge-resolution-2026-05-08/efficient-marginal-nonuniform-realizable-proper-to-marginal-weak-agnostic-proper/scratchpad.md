# Scratchpad: Efficient Marginal-Nonuniform Realizable Proper PAC -> Efficient Marginal-Nonuniform Weak Agnostic Proper PAC

Edge file: `atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`

Depth log starts at depth 1 from the main agent's depth 0.

## Current Verdict

Unresolved at launch.

## Depth 1 Attempt

### Files and Sources Read

- Edge: `atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`.
- Definition notes:
  - `atlas/definitions/efficient-marginal-nonuniform-realizable-proper-pac.md`.
  - `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`.
- Nearby argument notes:
  - `atlas/arguments/marginal-agnostic-hardness-open.md`.
  - `atlas/arguments/low-noise-weak-agnostic-robustification.md`.
  - `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`.
  - `atlas/arguments/one-way-image-coordinate-proper-hardness.md`.
  - `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`.
  - `atlas/arguments/halfspace-agnostic-hardness.md`.
  - `atlas/arguments/clause-satisfaction-proper-hardness.md`.
  - `atlas/arguments/conjunction-agnostic-hardness.md`.
- Nearby implication notes:
  - The sibling improper target edge, which is marked true by marginal-preserving low-noise robustification.
  - The distribution-free weak/proper target edges, which use halfspace hardness.
  - The PCP active-slice improper-to-proper marginal edges.
- Witness notes:
  - `atlas/witnesses/pcp-active-slice-lookup-class.md`.
  - `atlas/witnesses/clause-satisfaction-lookup-class.md`.
  - `atlas/witnesses/one-way-image-coordinate-class.md`.
  - `atlas/witnesses/conjunctions.md`.
- Primary-source checks:
  - Benedek--Itai 1991 fixed-distribution learning: fixed-distribution learnability is characterized information-theoretically by finite covers, but computation may be infeasible.
  - Hanneke--Moran--Thiessen 2025: marginal-nonuniform rates may depend on the marginal distribution while remaining uniform over concepts.
  - Tiegel 2023: distribution-independent halfspace weak lower bound allows a gap smaller than every inverse polynomial; the fixed Gaussian result is strong agnostic `OPT + epsilon` hardness.
  - Feldman--Guruswami--Raghavendra--Wu 2012: weak agnostic monomial hardness is for an arbitrary labeled distribution produced by the reduction, not a fixed-marginal theorem of the form needed here.

### Formal Reduction of the Target

Use $\{\pm 1\}$ labels.  For a joint distribution with marginal $P$, write
$$
\mu(x)=\mathbf E[Y\mid X=x],
\qquad
M = \sup_{c\in\mathcal C_s}\mathbf E_P[c(X)\mu(X)].
$$
For a proper output $h\in\mathcal C_s$,
$$
\operatorname{err}(h)
= \frac{1-\mathbf E_P[h(X)\mu(X)]}{2},
\qquad
\operatorname{OPT}_{\mathcal C}
= \frac{1-M}{2}.
$$
The weak agnostic target with tolerance $1/2-\gamma_P(s)$ is therefore equivalent to
$$
\mathbf E_P[h(X)\mu(X)]\ge M+2\gamma_P(s)-1.
$$

The already-recorded low-noise branch handles $M$ very close to $1$.  If the source learner has fixed-marginal clean sample/runtime bound $m_P(s)$ at constant accuracy, then choosing $\alpha_P(s)\ll 1/m_P(s)$ gives a proper candidate whenever $\operatorname{OPT}<\alpha_P(s)$ by coupling the noisy run to a clean run under the same original marginal $P$.

After that branch, the remaining case has $M\le 1-2\alpha_P(s)$, so for $\gamma_P\le \alpha_P/4$ it would suffice to find any legal concept $h$ with
$$
\mathbf E_P[h(X)\mu(X)]\ge -\alpha_P(s).
$$
Thus the exact missing primitive is a fixed-marginal proper neutralizer/selector, not clean decoding.

### Positive-Proof Attempts

1. **Reuse the source learner directly on noisy labels.**  
   This works only when a whole inspected clean transcript occurs with inverse-polynomial probability.  In the middle regime, $\operatorname{OPT}$ can be a fixed constant, and if the clean learner needs $m_P(s)$ inspected labels, the no-corruption probability is roughly $(1-\eta)^{m_P(s)}$, which can be exponentially small.  The source guarantee gives no control over off-promise behavior on noisy transcripts.

2. **Use constants as neutralizers.**  
   This proves the improper sibling and proves proper variants for classes where both constants, or some efficiently findable balanced legal concepts, are in $\mathcal C$.  It is not a theorem of the source node: proper concepts need not contain either constant and need not contain a concept with near-zero correlation against arbitrary labels.

3. **Try a packing/Plotkin dichotomy.**  
   Promising idea: if no legal concept is even weakly neutral for a particular $\mu$, then every legal concept is substantially anti-correlated with $\mu$ except concepts close to the optimizer.  One would like to show that the dangerous part of $\mathcal C_s$ is small, and then enumerate it or identify it by a short trace.  The obstacle is computational.  Benedek--Itai style finite covers are information-theoretic; the marginal-nonuniform clean learner does not give an efficient same-$P$ list generator, and using synthetic finite-support marginals $Q$ would replace the allowed $P$-dependent runtime bound by an uncontrolled $Q$-dependent one.

4. **Enumerate short labeled traces.**  
   If one could run the clean learner on all realizable labelings of $O(\log|\mathcal C|)$ random points, validation would find a neutral/proper candidate.  But the actual source learner may need $m_P(s)=\operatorname{poly}(s)$ labels even at constant accuracy; enumerating $2^{m_P(s)}$ traces is not polynomial.  Running the learner on a custom small-support marginal also fails for the same marginal-dependence reason as above.

No positive proof emerged.  The best conditional theorem I can extract is: the edge is true for classes with an efficient fixed-marginal proper neutralizer/list-selector, legal constants, legal complements plus an arbitrary proper seed, or an efficient same-$P$ polynomial candidate list containing a concept of correlation at least $-\alpha_P(s)$ whenever $M\le 1-2\alpha_P(s)$.  These are extra assumptions, not consequences of the source definition.

### Counterexample Attempts

1. **Halfspaces/Tiegel.**  
   Halfspaces do not refute this edge.  Constants are legal halfspaces, so the low-noise robustification can be made proper.  Tiegel's distribution-independent weak lower bound has a gap that may be smaller than every inverse polynomial, while the atlas weak marginal target may choose an inverse-polynomial gap depending on $P$.  Tiegel's fixed-Gaussian theorem is strong `OPT + epsilon` hardness, not a no-advantage weak lower bound in the middle-OPT regime.

2. **FGRW monomial hardness.**  
   Feldman--Guruswami--Raghavendra--Wu give weak agnostic hardness for monomials even with halfspace outputs, but the hard labeled distribution is produced by the reduction.  I do not see a way to freeze the instance marginal while preserving the reduction and avoiding legal weak handles.  This matches the current edge note's warning that the monomial/PCP route moves the hard instance into the marginal.

3. **PCP active-slice lookup.**  
   This is the strongest nearby proper-target lower-bound template, but it fails the source here.  If the class had an efficient marginal-nonuniform realizable *proper* learner, then on the uniform active slice of a satisfiable instance labeled constantly $1$, the learner would output a proof accepted on more than half of verifier random strings.  The standard PCP soundness check would put an NP-complete language in RP.  Thus the construction separates improper sources from proper targets, but cannot witness this proper-source edge without changing the construction substantially.

4. **One-way image-coordinate and noisy-code templates.**  
   The one-way image-coordinate class makes strong proper clean learning hard under one fixed marginal, so it fails the source.  Adding weak handles makes weak proper learning easy and therefore points in the wrong direction.  Parity/LPN-style classes have the right clean-versus-noisy flavor, but wrong parities are neutral under the uniform marginal, so weak agnostic proper learning can output a wrong parity in the middle-noise regime.  Attempts to remove all neutral wrong codewords require many pairwise negatively correlated codewords; PSD/Plotkin-type bounds then leave only polynomially many codewords, making exhaustive or validation-based approaches plausible.

5. **Clause-satisfaction/conjunction hardness.**  
   These are useful for strong proper agnostic hardness, but I did not find a fixed-marginal weak no-advantage version compatible with an efficient proper clean source.  In the clause/PCP variants, the same structure that makes proper weak agnostic learning decide a hard language also tends to make clean proper realizable learning decide it.

### Current Assessment

I did **not** resolve the edge.  I recommend keeping the atlas fields unchanged:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - benedek1991fixed
  - hanneke2025marginalnonuniform
  - tiegel2023
  - feldman2012monomials
summary: "Open: marginal-preserving low-noise coupling gives proper weak agnostic candidates when OPT is below the fixed-marginal clean-transcript scale, but the middle-OPT regime needs an efficient proper residual selector or neutralizer; known halfspace, monomial, PCP, parity/code, and one-way routes either vary the marginal, prove only strong hardness, or leave legal weak proper handles."
```

### Promising Directions for Deeper Subagents

1. **Positive selector from packing.**  
   Try to prove: for every fixed $P$, either there is an efficiently generatable proper neutralizer, or the relevant same-$P$ trace family is small enough to search using the clean learner.  The hard part is turning information-theoretic cover/packing statements into a uniform polynomial-time algorithm whose bound depends only on $P$.

2. **Fixed-marginal FGRW/PCP adaptation.**  
   Try to encode the Label-Cover/PCP instance into conditional labels while holding one full-support marginal fixed, but also preserve efficient proper clean learning.  The obstacle is that realizable proper learning on satisfiable active slices tends to recover a proof and hence solve the hard language.

3. **Noisy-code construction with no weak handles.**  
   Search for a code family with efficient noiseless proper decoding from random coordinates, hard noisy weak search, and no neutral wrong codewords.  The concrete obstacle is the negative-correlation/Plotkin barrier: exponentially many legal concepts cannot all be substantially anti-correlated with one another under a fixed marginal.

4. **Oracle or black-box separation.**  
   Since source learners are unconstrained off realizable distributions, an oracle construction might separate clean proper learning from same-marginal weak agnostic proper selection without relying on standard NP/crypto templates.  The obstacle is to make the target fail against all legal weak handles, not just exact recovery.

5. **Conditional-positive atlas note.**  
   Even if the edge remains open, it may be useful to add a separate argument note for the conditional theorem: source plus efficient proper neutralizer/list-selector implies target.  This would clarify exactly what additional structure halfspaces and other constant-containing classes supply.

## Depth 2 Attempt: Packing/Neutralizer Dichotomy

### Question Pursued

I focused on the depth-1 direction: can the middle-noise obstruction be forced into a fixed-marginal set-system search problem with no weakly neutral legal output, while still preserving efficient clean proper learning?  Equivalently, does the absence of easy neutralizers imply a small/listable structure, or can one build a clean-learnable class where finding any proper hypothesis in the upper half of the signed score range is hard?

I did not edit any atlas files.

### Normalized Signed Search Form

Fix a marginal $P$ and use $\{\pm 1\}$ labels.  For a conditional label mean $\mu(x)=\mathbf E[Y\mid X=x]$, define
$$
S_\mu(c)=\mathbf E_P[c(X)\mu(X)],
\qquad
M=\sup_{c\in\mathcal C_s} S_\mu(c).
$$
The weak agnostic proper target with gap $\gamma=\gamma_P(s)$ asks for a legal concept $h\in\mathcal C_s$ with
$$
S_\mu(h)\ge M-1+2\gamma.
$$
Thus this is not hard signed optimization in the usual sense.  It is enough to find any proper concept whose score is not in the bottom half of the possible correlation range relative to the optimum.  In particular, any legal concept with $S_\mu(h)\ge 0$ succeeds whenever $M\le 1-2\gamma$.

This rephrasing makes the counterexample burden sharper: a false witness cannot merely make the maximizer hard to find.  It must make every efficiently findable proper concept substantially anti-correlated with the labels, unless the low-noise branch already recovers a near-optimal concept.

### Geometric Barrier to No-Neutral Code Witnesses

Let $c^\star$ be an optimizer.  If a concept $c$ fails the weak target, then
$$
S_\mu(c^\star)-S_\mu(c)>1-2\gamma.
$$
Since $|\mu|\le 1$,
$$
S_\mu(c^\star)-S_\mu(c)
=\mathbf E_P[(c^\star(X)-c(X))\mu(X)]
\le 2\,\Pr_P[c(X)\ne c^\star(X)].
$$
So any failing $c$ must satisfy
$$
\Pr_P[c(X)\ne c^\star(X)]>1/2-\gamma.
$$
This is only a necessary condition, but it explains why the usual noisy-code route keeps leaking handles.  If many legal concepts sit at distance about $1/2$ from $c^\star$, they are not automatically bad enough for the weak target; under standard Massart or classification-noise labels they are actually neutral and pass throughout the middle-noise regime.

For the special Massart form $\mu=\rho c^\star$, the condition is explicit:
$$
S_\mu(c)=\rho(1-2d_P(c,c^\star)),
\qquad
M=\rho,
$$
and the target accepts every $c$ with
$$
d_P(c,c^\star)\le \frac{1-2\gamma}{2\rho}.
$$
When $\rho\le 1-2\gamma$, even a concept at distance exactly $1/2$ from $c^\star$ passes.  Thus parity/Hadamard-style code families cannot yield a middle-noise separation: wrong codewords are neutral handles.  To make all wrong codewords fail one needs persistent distance above $1/2+\Omega(\gamma)$, and Plotkin-type bounds then allow only polynomially many $P$-distinct codewords for inverse-polynomial $\gamma$.

The same energy obstruction appears in signed form.  If a large subfamily is close to orthogonal under $P$, a bounded function $\mu\in[-1,1]$ cannot give inverse-polynomial negative correlation to exponentially many members at once.  For an exactly orthonormal family $\{v_i\}$ in $L_2(P)$, Bessel's inequality gives
$$
\sum_i \langle v_i,\mu\rangle_P^2 \le \|\mu\|_2^2\le 1.
$$
So at most $O(1/\alpha^2)$ orthogonal concepts can all have $|S_\mu(c)|\ge\alpha$.  A large orthogonal or near-orthogonal class therefore naturally contains neutral concepts for every fixed signed label rule.

### Why This Does Not Yet Prove a Selector

The tempting positive theorem would be:

1. If there is a balanced or low-mean distribution over proper concepts, sample it and validate until a neutralizer appears.
2. If no such neutralizer distribution exists, the exposed concepts should be packed/listable, so search the list.

I could not make either step follow from the source node.

First, clean proper learning gives a promise-extension procedure for labels generated by an actual target concept.  It does not give an efficient sampler over concepts, an efficiently computable barycenter, or a way to draw a random legal concept with small mean.  Many natural classes have such samplers, but this is extra structure.  Formally, if there is an efficient distribution $Q$ over legal concepts whose mean function
$$
b_Q(x)=\mathbf E_{c\sim Q}[c(x)]
$$
satisfies $|\langle b_Q,\mu\rangle_P|\le\alpha$, then some sampled concept has $S_\mu(c)\ge-\alpha$, and validation yields the target in the middle regime.  The source learner alone does not construct $Q$.

Second, packing is not enough at the required radius.  A maximal cover at radius $1/2-\gamma$ would indeed be a universal selector list: for an optimizer $c^\star$, any list element $r$ with $d_P(r,c^\star)\le1/2-\gamma$ satisfies
$$
S_\mu(r)\ge M-1+2\gamma.
$$
But the covering number of a binary class at radius just below $1/2$ can be exponential; Hadamard/parity classes are the basic example.  Plotkin gives polynomial bounds only for separation above $1/2+\Omega(\gamma)$, which is the wrong side for building this selector list.  The extra signed information from $\mu$ can shrink the relevant good set, but I do not see how to enumerate that set without already solving the signed search problem.

Third, the marginal-nonuniform runtime bookkeeping blocks the usual finite-cover workaround.  One could draw a small unlabeled sample from $P$, enumerate its labelings, and run the clean learner on the induced finite-support distribution.  However that invokes the source learner under a new empirical marginal $Q$, and the available polynomial may be $p_Q$, not the target's allowed $p_P$.  This is the same obstruction noted at depth 1, now in the packing/list language.

### Can a Fixed-Marginal Set-System Witness Exist?

I tried to outline what a genuine false witness would need to look like.

For a finite support with uniform $P$, concepts are $\{\pm1\}$ vectors and the hard agnostic instance is a signed weight vector $\mu$.  A witness needs:

1. **Efficient clean proper decoding.**  From random noiseless coordinates of an unknown concept, recover a proper concept close to it in time polynomial under the same $P$.
2. **Hard middle-noise signed search.**  Given samples from the signed distribution $\mu$, finding any $c$ with $S_\mu(c)\ge M-1+2\gamma$ should solve a hard problem.
3. **No easy neutral handles.**  There should be no constants, complements, random legal concepts, local moves, balanced samplers, wrong codewords, or generic above-average assignments that validation can use to get score at least $0$ or even mildly negative.

The standard templates miss at least one item.

- Error-correcting-code and parity/LPN templates satisfy clean decoding but have wrong codewords at distance about $1/2$, hence neutral handles in the middle-noise regime.
- CSP/assignment templates make optimization hard, but random assignments or conditional-expectation methods usually give an above-average legal assignment, which is already enough for the weak agnostic target unless the instance is low-noise/near-realizable.
- PCP active-slice templates remove some easy handles, but then clean proper learning on satisfiable active slices tends to recover the proof and would decide the hard language.
- Adding a common negative baseline to all concepts does not help: the weak target threshold shifts with $M$, so common score offsets cancel.

The only plausible remaining route I see is representation-sensitive or oracle-like: a class where clean examples reveal a valid/profitable proper representation, but there is no efficient way to sample or enumerate even neutral legal representations under agnostic labels.  That would be a different kind of witness from the usual code/CSP constructions, and it risks exploiting representation pathologies rather than a robust learning-theoretic separation.

### Conditional Positive Statement Extracted

The edge would be true under the following additional fixed-marginal selector condition.

For every marginal $P$, suppose there is a polynomial-time procedure, with runtime bounded by a $P$-dependent polynomial, that on unlabeled samples from $P$ and labeled samples from $\mu$ produces a polynomial list $L$ of legal concepts such that for every $\mu$ either:

- $L$ contains a concept with $S_\mu(c)\ge-\alpha_P(s)$, or
- $M>1-\alpha_P(s)$, in which case the low-noise clean-coupling branch applies.

Then validation over $L$ plus repeated low-noise runs gives the target weak agnostic proper learner with $\gamma_P(s)\ll\alpha_P(s)$.

This packages the missing ingredient but does not derive it from clean proper learning.  It is useful because it identifies exactly what natural positive examples supply: legal constants, complement pairs, balanced concept samplers, or an explicit same-$P$ cover/list.

### Current Assessment

I did **not** resolve the edge.

The packing/neutralizer dichotomy gives a real barrier to false witnesses based on noisy decoding, parities, or ordinary CSP optimization: those constructions leak neutral or above-average legal concepts before they can refute the very weak agnostic target.  However, the same analysis does not yield an algorithmic selector from the source definition alone.  Clean marginal-nonuniform proper learning is a promise guarantee, not a concept sampler, finite-cover enumerator, or signed optimizer.

Recommended next directions:

1. Try an oracle or representation-sensitive separation where valid proper concepts are clean-decodable from realizable labels but hard to sample neutrally under agnostic labels.
2. Try to prove an extra mild-effectivity lemma: clean proper marginal-nonuniform learning plus globally valid proper outputs implies an efficient balanced concept sampler or seed.  This would close the main gap in the positive direction.
3. Isolate a Massart-only positive theorem.  For $\mu=\rho c^\star$, the Plotkin/list-decoding barrier is much stronger than for arbitrary signed $\mu$, and it may be possible to prove a selector under an additional list-decoding/effective-cover assumption.
4. Search for fixed-marginal CSPs where even finding an assignment above a very low signed threshold is hard and no random/conditional-expectation baseline is available.  The obstacle is that any efficiently samplable distribution over assignments with near-zero mean becomes a neutralizer.

RESOLVED: no

## Depth 3 Attempt: Conditional Neutralizer Lemma

### Goal

I pursued the conditional-positive direction from the previous depths.  The right statement is not that the source learner itself gives a neutralizer.  Rather, the source learner plus an additional same-marginal proper residual selector gives the target.  This isolates a clean sufficient condition that could be incorporated into atlas argument notes without pretending that the edge is settled.

Throughout this attempt I use $\{\pm 1\}$ labels.  For a joint distribution $\mathcal D$ with instance marginal $P$, write
$$
\mu(x)=\mathbf E[Y\mid X=x],
\qquad
S_\mu(c)=\mathbf E_P[c(X)\mu(X)],
\qquad
M_\mu=\sup_{c\in\mathcal C_s}S_\mu(c).
$$
Then
$$
\operatorname{err}_{\mathcal D}(c)=\frac{1-S_\mu(c)}2,
\qquad
\operatorname{OPT}_{\mathcal C}(\mathcal D)=\frac{1-M_\mu}{2}.
$$
A proper weak agnostic learner with gap $\gamma_P(s)$ must output $h\in\mathcal C_s$ satisfying
$$
S_\mu(h)\ge M_\mu+2\gamma_P(s)-1.
$$

### Conditional Lemma

**Lemma.** Assume the atlas pathwise resource convention for learners.  Let $\mathcal C$ have an efficient marginal-nonuniform realizable proper learner $A$.  Fix the constant-accuracy call of $A$ with clean error at most $1/16$ and confidence at least $99/100$, and let $m_P(s)$ be its $P$-dependent pathwise sample/time bound.

Suppose, in addition, that $\mathcal C$ has an efficient same-marginal proper residual selector at the source scale: there is a single uniform procedure $R$ such that for every marginal $P$ there is a $P$-dependent polynomial resource bound and an inverse-polynomial scale
$$
\alpha_P(s)\le \min\{1/512,\;1/(512m_P(s))\}
$$
with the following guarantee.  Given samples from any joint distribution $\mathcal D$ with marginal $P$, the procedure $R$ returns a polynomial-size list $L\subseteq\mathcal C_s$ of proper hypotheses, and with high probability:

$$
M_\mu\le 1-4\alpha_P(s)
\quad\Longrightarrow\quad
\exists h\in L\ \text{such that}\ S_\mu(h)\ge -\alpha_P(s).
$$

Then $\mathcal C$ satisfies efficient marginal-nonuniform weak agnostic proper PAC learning.  One may take weak gap, up to harmless constant changes,
$$
\gamma_P(s)=\alpha_P(s)/8.
$$

This statement also covers the more concrete neutralizer cases.  For example, if there is an efficient same-$P$ sampler or deterministic procedure producing proper concepts whose validated list contains some $h$ with $S_\mu(h)\ge-\alpha_P(s)$ whenever $M_\mu\le1-4\alpha_P(s)$, then it is an instance of $R$.  Legal constants, legal complement pairs with an anchor, balanced proper concept samplers, and explicit same-$P$ weak covers are all special cases when they are effective at the needed scale.

### Proof

**Construction.**  On agnostic samples from $\mathcal D$, the learner builds a candidate pool in two ways.

First, it runs the realizable proper learner $A$ several times on fresh agnostic batches, pretending the labels are clean.  Each output is a proper concept because $A$ is proper.  Second, it runs the residual selector $R$ and adds all concepts in its list.  Finally, it validates the finite candidate pool on fresh samples and returns the empirically best candidate.  Validation only has to distinguish candidates to accuracy $O(\alpha_P(s))$, so its sample and time cost are still bounded by a $P$-dependent polynomial.  As in the existing low-noise robustification notes, this is an atlas-level hidden-scale statement: the proof charges the validation budget to the $P$-dependent inverse-polynomial scale supplied by the selector.

**Subgoal 1: the selector handles the middle-noise regime.**  Suppose
$$
M_\mu\le 1-4\alpha_P(s).
$$
By the selector guarantee, the list contains a proper $h$ with $S_\mu(h)\ge-\alpha_P(s)$.  Since $\gamma_P=\alpha_P/8$,
$$
M_\mu+2\gamma_P-1
\le
(1-4\alpha_P)+\alpha_P/4-1
=
-15\alpha_P/4.
$$
Thus
$$
S_\mu(h)\ge -\alpha_P \ge M_\mu+2\gamma_P-1.
$$
So this proper $h$ already satisfies the weak agnostic target, with large slack.  Validation over the finite list preserves the guarantee after the usual holdout slack loss.

**Subgoal 2: the realizable learner handles the low-noise regime.**  Suppose
$$
M_\mu>1-4\alpha_P(s).
$$
Choose $c^\star\in\mathcal C_s$ with
$$
S_\mu(c^\star)>M_\mu-\alpha_P(s)>1-5\alpha_P(s).
$$
Then
$$
\eta:=\operatorname{err}_{\mathcal D}(c^\star)
=\frac{1-S_\mu(c^\star)}2
<\frac{5\alpha_P(s)}2.
$$

Couple one agnostic run of $A$ on $(X,Y)\sim\mathcal D$ with a clean realizable run on $(X,c^\star(X))$, using the same $P$-distributed instance sequence and the same internal randomness.  Since the constant-accuracy invocation reads at most $m_P(s)$ labels, the chance that any inspected label is corrupted relative to $c^\star$ is at most
$$
m_P(s)\eta
<
\frac{5}{1024},
$$
using $\alpha_P(s)\le1/(512m_P(s))$.  On the no-corruption event, the agnostic transcript is exactly a realizable transcript under the original marginal $P$.  Therefore, with constant probability, $A$ outputs a proper $h$ satisfying
$$
\operatorname{err}_P(h,c^\star)\le1/16.
$$
For that $h$,
$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{err}_{\mathcal D}(c^\star)+\operatorname{err}_P(h,c^\star)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\alpha_P(s)/2+1/16.
$$
The target allowance is
$$
\operatorname{OPT}_{\mathcal C}(\mathcal D)+1/2-\gamma_P(s)
=
\operatorname{OPT}_{\mathcal C}(\mathcal D)+1/2-\alpha_P(s)/8.
$$
Since $\alpha_P(s)\le1/512$, the low-noise candidate is far better than required.  Repeating the coupled agnostic runs a logarithmic number of times and validating the resulting proper candidates amplifies the constant success probability to $1-\delta$.

**Conclusion.**  The two cases cover all $\mu$.  The construction is proper because every candidate comes either from $A$ or from $R$, both of which output concepts in $\mathcal C_s$.  Its resource bound is marginal-nonuniform because it uses only $m_P(s)$, the selector's $P$-dependent polynomial, and holdout validation at scale $\alpha_P(s)$.  Hence the source plus the residual selector implies the target with gap $\gamma_P(s)=\alpha_P(s)/8$.

### Why This Does Not Resolve the Edge

The residual selector assumption is genuinely additional.  The source learner is only a promise algorithm for labels realizable by a concept in $\mathcal C_s$.  It says nothing about how to find a proper concept with nonnegative or mildly negative signed correlation against an arbitrary conditional label mean $\mu$.

The previous failed routes are exactly attempts to derive this selector from the source:

1. Enumerating clean traces would produce a selector, but it costs $2^{m_P(s)}$ in general.
2. Packing arguments give information-theoretic neutral concepts in many code-like cases, but not an efficient same-$P$ generator.
3. Switching to a small empirical marginal would invoke the source learner under a new marginal $Q$, losing control of the original $P$-dependent polynomial.
4. Random legal concepts or constants work for many natural classes, but their existence is not implied by marginal-nonuniform clean proper learnability.

So the lemma is a useful conditional positive theorem and a good atlas note candidate: it precisely names the missing primitive.  It does not prove that every efficient marginal-nonuniform realizable proper class has such a primitive.

RESOLVED: no

## Depth 4 Attempt: Fixed-Marginal Trace Cover From Strong Clean Learning

### Question Pursued

I pursued the requested finite-cover route:

> For a fixed marginal $P$, does efficient marginal-nonuniform strong clean proper learning force an effective finite support/trace cover that is strong enough to get weak agnostic proper learning?

The comparison point is Benedek--Itai fixed-distribution learnability.  Their theorem gives the right *sample-complexity* intuition: for a fixed distribution, learnability is equivalent to finite metric coverability of the concept class under the $L_1(P)$ or symmetric-difference metric.  Later expositions, for example the distance-learning formulation of Ben-David--Itai--Kushilevitz, restate this as: $\mathcal C$ is PAC-learnable relative to $P$ iff, for every $\varepsilon>0$, there is a finite family approximating $\mathcal C$ under $d_P$.  But Benedek--Itai also explicitly separate this from computation: the learning rule induced by such covers need not be effectively computable, and even computable rules may be infeasible.  That is exactly where this atlas edge lives.

I did not edit atlas files.

### What the Benedek--Itai Cover Would Give If It Were Effective

Fix a size slice $\mathcal C_s$ and a marginal $P$.  Suppose we had an efficiently enumerable proper $\rho$-net
$$
N_{P,s,\rho}\subseteq \mathcal C_s
$$
such that for every $c\in\mathcal C_s$ there is $a\in N_{P,s,\rho}$ with $d_P(a,c)\le\rho$, and suppose moreover that $\log |N_{P,s,\rho}|$ and the enumeration time were bounded by a $P$-dependent polynomial.

Then the weak agnostic proper target would follow, and in fact something stronger would follow.  On agnostic samples, run empirical risk minimization over $N_{P,s,\rho}$ and validate.  If $c^\star$ is an optimal proper comparator, the net contains $a$ with
$$
\operatorname{err}_{\mathcal D}(a)
\le
\operatorname{err}_{\mathcal D}(c^\star)+d_P(a,c^\star)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\rho.
$$
Taking $\rho\le 1/2-\gamma_P(s)$ gives the weak agnostic guarantee.  Taking inverse-polynomial $\rho$ would even give a strong agnostic finite-cover learner at the sample-only level.

So the desired trace cover is a sufficient condition.  The problem is deriving an *effective* one from the clean learner.

### Trace Cover Induced by the Clean Learner

Let $A$ be the marginal-nonuniform clean proper learner, and fix a constant clean accuracy call with pathwise sample/time bound $m_P(s)$ under $P$.  A natural attempt is:

1. draw or otherwise choose an unlabeled trace $U=(x_1,\dots,x_m)$ from $P^m$;
2. run $A$ on every realizable labeling of $U$;
3. collect all proper outputs.

For a good trace $U$, this output range should be a fixed-marginal cover of $\mathcal C_s$ at constant radius: for each target concept $c$, the clean transcript $(U,c(U))$ has some random tape on which $A$ outputs a proper hypothesis close to $c$.

This is the computational version of the Benedek--Itai intuition, but it immediately loses polynomial time.  The number of label traces can be as large as
$$
|\mathcal C_s|_U|\le 2^{m_P(s)}.
$$
Since $m_P(s)$ is only promised to be polynomial in $s$, enumerating the trace cover is generally exponential.  Random tapes add another finite but potentially exponential factor unless the learner is made deterministic by fixing or searching over enough seeds.

This is not just a bookkeeping annoyance.  The weak agnostic target only allows a $P$-dependent polynomial runtime.  An exponential trace enumeration cannot be hidden inside the marginal-dependent polynomial unless the exponent is bounded independently of $s$, which the source node does not promise.

### Why Large-Radius or Weak Covers Do Not Drop Out

The weak target does not need a fine $\rho$-net; in the middle-OPT regime it suffices to find a proper $h$ with mildly nonnegative residual score, say
$$
S_\mu(h)=\mathbf E_P[h(X)\mu(X)]\ge -\alpha_P(s).
$$
This raises the hope that a much smaller "half-cover" or trace sketch might suffice.

I do not see a generic way to extract such a sketch from strong clean learning.  The clean learner supplies a promise extension map: if the labels on a trace come from some $c\in\mathcal C_s$, then the output is close to $c$.  It does not supply any of the following:

- a polynomial-size subset of traces whose outputs hit a residual-neutral concept for every signed label function $\mu$;
- a sampler over legal proper concepts with small barycenter under $P$;
- a projection oracle from arbitrary weighted labels on a finite support back to $\mathcal C_s$;
- a way to identify which clean trace labelings are relevant to the agnostic labels without enumerating them.

Parities under the uniform marginal are a useful sanity check.  Clean strong proper learning has a simple polynomial algorithm, but the trace space has $2^{\Theta(s)}$ possible labelings on $\Theta(s)$ random examples.  Parities themselves do not refute the edge because wrong parities provide neutral weak handles; nevertheless they show that strong clean learning alone need not compress the clean trace family to polynomial size.  The missing ingredient would have to be a weak selector that is not merely a compressed version of the clean learner's trace cover.

### Finite Support Does Not Remove Projection Hardness

Benedek--Itai also note that fixed discrete marginals are sample-learnable in very broad generality: enough samples discover the heavy atoms, and the tail has small $P$-mass.  This might look promising for a fixed-support or heavy-support route.

But for the computational proper target, after reducing to a finite support $T$, the remaining task is a weighted projection problem:
$$
\text{find } h\in\mathcal C_s \text{ with large } \sum_{x\in T} w_x h(x)\mu(x).
$$
Clean proper learning solves only the realizable consistency version under random clean labels.  It does not solve arbitrary weighted ERM or even arbitrary weak signed search over $T$.  If one replaces $P$ by the empirical distribution $Q$ on $T$ and invokes the marginal-nonuniform source learner, the allowed polynomial becomes $p_Q$, not the original target's $p_P$.  The atlas target cannot charge its runtime to every auxiliary empirical marginal generated during the algorithm.

Thus finite support gives sample-theoretic covers, but not a polynomial-time projection from noisy labels to a proper concept.

### Attempted Positive Extraction and Where It Fails

The most optimistic extraction would be:

1. Use the success of $A$ under $P$ to prove existence of a small set $U_P$ of support points.
2. Show that every concept is determined up to weak accuracy by its trace on $U_P$.
3. Enumerate only a polynomial-size family of trace representatives.
4. Validate those representatives on agnostic labels.

Step 2 is essentially Benedek--Itai metric entropy.  Step 3 is the unresolved computational projection.  The finite cover may exist with logarithmic size polynomial in the sample bound, but the source learner need not expose it in an enumerable form.  Its successful hypotheses can depend on arbitrary real-valued sample locations, target-specific labels, and internal choices.  Even if a finite subcover exists abstractly, selecting one representative concept per cover cell is a representation-level search problem over $\mathcal C_s$.

There is also a direction mismatch: a clean learner maps *realizable labeled traces* to proper concepts.  A weak agnostic learner must map an arbitrary signed empirical measure to some proper concept above a low threshold.  Turning the first map into the second is precisely an optimization/projection problem, not a metric-entropy theorem.

### Conditional Statement That Would Work

The cover route would settle the edge under the following extra effectivity assumption.

For every fixed marginal $P$, suppose there is a uniform procedure with $P$-dependent polynomial runtime that, using unlabeled samples from $P$ and oracle/sample access to the agnostic labels, constructs a polynomial-size list $L\subseteq\mathcal C_s$ such that for every conditional mean $\mu$ either:

- $L$ contains a near-optimal cover representative for an optimizer $c^\star$, or
- $L$ contains a residual-neutral proper concept with $S_\mu(h)\ge-\alpha_P(s)$.

Then validation over $L$, plus the existing low-noise coupling branch, gives the efficient marginal-nonuniform weak agnostic proper target.  This is essentially the depth-3 residual selector lemma stated in trace-cover language.

But this is an additional computational cover/projection axiom.  I found no way to derive it from the source learner alone.

### Current Assessment

I did **not** resolve the edge.

Benedek--Itai fixed-distribution theory strongly supports the sample-only side: fixed-marginal clean learnability corresponds to finite metric covers, and if those covers were efficiently proper and enumerable, agnostic proper learning would follow by ERM over the cover.  The computational atlas edge asks for more: a polynomial-time way to construct or search the relevant proper cover under the same original marginal $P$.

The clean strong learner gives at most an implicit trace cover obtained by running over realizable labelings.  That cover can be exponentially large, may depend on non-enumerable support information, and does not solve the weighted projection problem created by agnostic labels.  Switching to empirical finite-support marginals loses the original $P$-dependent runtime accounting.  So the finite-cover route clarifies the obstruction but does not close it.

Promising next directions:

1. Look for a representation-sensitive separation where a Benedek--Itai finite cover exists with small metric entropy but every effective proper projection/list selector is hard.
2. Try to prove a restricted positive theorem for classes whose fixed-$P$ metric covers are constructible from the clean learner's range with only polynomially many trace representatives.
3. Study whether additional stability of the clean learner, for example output depending on a logarithmic compression set or a canonical proper ERM oracle, converts the implicit trace cover into the residual selector needed at depth 3.

RESOLVED: no

## Depth 5 Attempt: Reduction To Proper Selector Core

### Question

This pass focused only on the structural reduction question:

> Does
> `efficient-marginal-nonuniform-realizable-proper-pac -> efficient-marginal-nonuniform-weak-agnostic-proper-pac`
> collapse to the distribution-free weak-realizable proper core, or does the stronger fixed-marginal clean source add information not present in that core?

Let

```text
S = efficient-marginal-nonuniform-realizable-proper-pac
W_mn = efficient-marginal-nonuniform-weak-realizable-proper-pac
W = efficient-weak-realizable-proper-pac
T = efficient-marginal-nonuniform-weak-agnostic-proper-pac.
```

The previous spike-tilt notes establish, under the atlas deterministic-output and pathwise finite-transcript conventions, that

```text
W_mn <=> W
```

for the relevant source notion.  Since `S` trivially implies `W_mn`, the present source implies the distribution-free weak-realizable proper source:

```text
S => W_mn => W.
```

Therefore any theorem proving the core edge

```text
W => T
```

would immediately prove the present edge.  In that positive-proof sense, this edge reduces to the proper weak-realizable core.

### Why This Is Not A Full Equivalence

The reverse direction is not available.  A class satisfying `W` need not satisfy `S`.  The gap is exactly proper high-accuracy clean learning.  Distribution-free weak realizable proper learning gives a proper hypothesis with some inverse-polynomial edge on every clean distribution.  It does not give a proper high-accuracy learner, because the usual weak-to-strong boosting output is an improper vote unless the class has additional closure or a proper projection oracle.

Marginal-nonuniformity does not remove this issue.  For a fixed marginal `P`, a weak clean proper learner can be run on reweighted or filtered distributions, but converting the resulting sequence of proper weak hypotheses back into one proper concept in the original class is again a proper selector/projection problem.  Thus `W` does not visibly imply fixed-`P` strong clean proper learnability.

Logically, the implications are only a sandwich:

```text
if W => T is true, then S => T is true;
if S => T is false, then W => T is false;
but W => T could be false while S => T is true.
```

So a counterexample to the core edge would not automatically refute this edge.  It would have to be a counterexample whose class also has efficient marginal-nonuniform strong clean proper learning.

### What The Strong Marginal Source Adds

The fixed-`P` trace-cover notes identify the extra information in `S`.  For each marginal `P`, size parameter `s`, and clean accuracy scale, a strong source learner gives an implicit fixed-marginal trace cover: on every realizable labeling induced by a concept `c in C_s`, some successful run outputs a proper hypothesis close to `c` under `P`.

This is genuinely more than the distribution-free weak source.  The weak source gives only a low-edge clean extension guarantee.  The strong marginal source gives high-accuracy clean extension under the original marginal and at arbitrary target accuracies, with resource bounds allowed to depend on `P`.

However, the trace-cover pass also explains why this extra information has not yet solved the edge.  The cover exposed by the learner is implicit:

- enumerating all clean label traces costs `2^{m_P(s)}` in general;
- the learner is only guaranteed on realizable traces, not on arbitrary signed or noisy traces;
- replacing `P` by a small empirical support `Q` loses the target's original `P`-dependent runtime accounting;
- even an abstract finite cover does not give an effective weighted projection or residual-neutral proper concept.

Thus `S` adds distinct sample-theoretic and promise-algorithmic information, but not obviously the missing agnostic middle-noise selector.

### Relation To The Proper Selector Core

For this edge, the same low-noise/middle-noise decomposition still applies.  In low noise, the strong fixed-`P` learner couples to a clean run on the same marginal and gives a proper candidate.  In middle noise, the target again reduces to finding a proper residual selector: given signed regression `mu`, output some `h in C_s` with mildly nonnegative score, for example

$$
\mathbf E_P[h(X)\mu(X)] \ge -\alpha_P(s)
$$

whenever the best proper score is bounded away from `1` at the clean-transcript scale.

The strong marginal source may help only if its implicit high-accuracy trace cover can be made into such a selector.  The earlier fixed-`P` trace-cover attempt found no generic way to do this.  Conversely, the spike-tilt reduction only uniformizes clean weak realizable learning; it does not turn strong fixed-`P` traces into a selector and does not constrain off-promise behavior on agnostic labels.

So the best current structural statement is:

```text
The present edge is implied by the distribution-free weak-realizable proper core,
but it is not known to be equivalent to that core.
The strong marginal source adds possible trace-cover information, yet the
unresolved content remains the same effective proper selector/projection
problem in the middle-noise regime.
```

### Consequences For Further Search

This suggests two separate follow-up paths.

1. To prove the edge true using the extra source strength, try to derive an effective same-`P` proper selector from the strong clean trace cover.  A stable learner, logarithmic proper compression scheme, canonical proper ERM oracle, or polynomially enumerable fixed-`P` cover would be enough, but none follows from the source definition alone.

2. To prove the edge false, a witness must satisfy the stronger source `S`, not merely the core source `W`.  In practice this means preserving efficient fixed-marginal strong clean proper learning while making even weak same-marginal agnostic proper selection hard.  The existing parity, PCP, halfspace, and code routes either fail the strong source, leak neutralizers, or prove only strong agnostic hardness.

### Verdict

I did not resolve the edge.  The depth-5 answer is: there is a one-way positive reduction to the distribution-free weak-realizable proper core, but no full equivalence.  Marginal-nonuniform strong clean learning adds distinct fixed-`P` trace-cover information, and the current obstacle is whether that implicit information can be computationalized into the residual proper selector.

RESOLVED: no

## Depth 6 Attempt: P-Dependent Exhaustive Proper ERM

### Question

Stress-test the strongest possible use of the source's fixed-marginal information:

> Suppose the fixed-$P$ strong clean learner, together with Benedek--Itai finite-cover theory, yields a $P$-dependent exhaustive proper ERM whose enumeration and validation time are polynomial under the same marginal-dependent polynomial $p_P$. Does that produce the marginal-nonuniform weak agnostic proper target?

### Conditional Positive Result

Yes, under that strengthened effectivity assumption it produces the target, and in fact it gives more than the weak target asks for.

Fix a marginal $P$, size parameter $s$, and an agnostic distribution $\mathcal D$ with marginal $P$. Let

$$
\operatorname{OPT}_{\mathcal C_s}(\mathcal D)
= \inf_{c\in\mathcal C_s} \operatorname{err}_{\mathcal D}(c).
$$

Assume there is a $P$-dependent polynomial-time procedure that enumerates a finite proper cover

$$
N_{P,s,\rho}\subseteq \mathcal C_s
$$

such that for every $c\in\mathcal C_s$ there is $a\in N_{P,s,\rho}$ with

$$
\Pr_{X\sim P}[a(X)\ne c(X)]\le \rho,
$$

and with $\log |N_{P,s,\rho}|$ and the enumeration time both bounded by $p_P(s,1/\rho)$.

Run empirical risk minimization over $N_{P,s,\rho}$ on fresh agnostic labeled samples. Uniform convergence over the finite list gives, with polynomially many samples in $\log |N_{P,s,\rho}|$, $1/\epsilon$, and $\log(1/\delta)$, an element $\hat h\in N_{P,s,\rho}$ whose true risk is within $\epsilon$ of the best risk in the list.

If $c^\star$ is an almost-optimal proper comparator and $a\in N_{P,s,\rho}$ covers $c^\star$, then

$$
\operatorname{err}_{\mathcal D}(a)
\le
\operatorname{err}_{\mathcal D}(c^\star)
+ \Pr_P[a(X)\ne c^\star(X)]
\le
\operatorname{OPT}_{\mathcal C_s}(\mathcal D)+\rho+o(1).
$$

Thus ERM over the cover gives a proper agnostic learner with excess about $\rho+\epsilon$. Taking, say, $\rho,\epsilon\le \alpha_P(s)/4$ gives the weak agnostic proper guarantee with gap $\alpha_P(s)/2$. If the cover is available down to inverse-polynomial radius, this is really a marginal-nonuniform strong agnostic proper learner, not just a weak one.

So the exhaustive proper ERM hypothesis is sufficient.

### Why This Does Not Resolve The Atlas Edge

The problem is that the source node does not appear to imply this effective exhaustive ERM. Benedek--Itai supplies a fixed-distribution finite-cover characterization at the sample-complexity level. The marginal-nonuniform strong clean source supplies a promise algorithm that succeeds on realizable samples from $P$. Neither statement, by itself, controls the computational size or enumerability of the cover in the sense needed above.

The clean learner can expose an implicit cover by running it on all clean label traces over a sufficiently large unlabeled sample. But if the clean sample bound is $m_P(s,\rho)$, this naive trace cover can contain up to

$$
2^{m_P(s,\rho)}
$$

label traces, before accounting for random tapes. Since $m_P$ is only promised to be polynomial, this is generally exponential in $s$. Calling the runtime "marginal-nonuniform" does not allow us to hide this exponential factor inside $p_P$: the target still requires one fixed polynomial bound for the marginal $P$, not an arbitrary computable bound and not a polynomial with degree growing with $s$.

There is a second, subtler gap. Even if a finite $P$-cover exists abstractly, converting it into a proper ERM requires selecting actual representatives in $\mathcal C_s$ and evaluating them efficiently. The clean source is only guaranteed on realizable labeled samples. It does not solve arbitrary signed or noisy projection problems of the form

$$
\max_{h\in\mathcal C_s} \mathbf E_P[h(X)\mu(X)],
$$

nor does it identify which clean trace labelings are relevant to the agnostic labels. Exhaustive ERM over an explicit cover would solve this projection by brute force, but obtaining that explicit cover is exactly the missing computation.

### Stress Test Of The Special Marginal Information

The special information in the source is real: for each fixed $P$, strong clean learning suggests that every concept has some successful clean transcript whose output is close under $P$. This is stronger than distribution-free weak clean learning and is precisely why the cover route is tempting.

But this information remains off-promise. The learner's guarantee says:

```text
if the labels are realizable by c, then the output is close to c under P.
```

The weak agnostic target needs:

```text
given arbitrary noisy labels with marginal P, find a proper h with risk
noticeably below the weak threshold relative to OPT_C.
```

Bridging these statements requires either enumerating enough clean transcripts or having a same-$P$ residual selector. The finite-cover theorem proves that some finite transcript/cover object exists in the sample-only sense. It does not prove that the object is polynomially enumerable under $p_P$, nor that the clean learner's range has a polynomial-size subcover at the radius needed for the weak threshold.

Parities under the uniform marginal remain a useful warning example. Strong clean proper learning is computationally easy, but the natural trace family has exponentially many realizable labelings. Parities do not separate this edge because they have many neutral weak handles, yet they show that "strong clean learner under $P$" does not by itself imply "small explicit proper cover under $P$."

### Verdict

Conditional theorem: if the Benedek--Itai/fixed-$P$ cover can be made into an explicit proper ERM with enumeration and validation time polynomial under the same $p_P$, then the marginal-nonuniform weak agnostic proper target follows immediately.

Atlas edge: not resolved. The exhaustive-cover size and representation are not controlled computationally by the current source definition. The depth-6 stress test therefore reinforces the earlier diagnosis: the missing ingredient is an effective same-$P$ proper cover/projection/selector, not the information-theoretic existence of finite covers.

RESOLVED: no

## Depth 7 Attempt: Atlas-Ready Marginal Strong Proper Summary

### Theorem-Check Pass

I checked for a theorem that would close the original edge after the depth-6 trace-cover analysis. I did not find one.

The closest positive theorem remains Hopkins--Kane--Lovett--Mahajan, "Realizable Learning is All You Need" ([TheoretiCS 2024](https://theoretics.episciences.org/13009), [PDF](https://theoretics.episciences.org/13009/pdf)). It gives a black-box realizable-to-agnostic reduction even for learning with distributional assumptions, using a non-uniform cover. However, the construction explicitly runs the realizable learner over all possible labelings of an unlabeled sample, and the paper notes that this reduction is computationally inefficient and that such inefficiency is unavoidable in general unless `P = NP`. Thus it supports the sample-level trace-cover route but does not close this efficient atlas edge.

The recent marginal-nonuniform paper of Hanneke--Moran--Thiessen ([OpenReview 2025](https://openreview.net/forum?id=aoVCFtox89), last modified 2026-04-21) characterizes achievable marginal-nonuniform rates, but it is a statistical-rate result. I did not find an effective same-$P$ proper selector/projection theorem in it.

The recent agnostic boosting papers also do not close the edge. "Revisiting Agnostic Boosting" ([arXiv:2503.09384](https://arxiv.org/abs/2503.09384)) gives strong statistical evidence for weak-to-strong agnostic boosting but uses relabeling/enumeration ideas that remain computationally expensive in the general parameters. The 2026 improved-time result ([arXiv:2601.11265](https://arxiv.org/abs/2601.11265)) gives polynomial time in the sample size with other parameters fixed, but its running-time exponent depends on weak-learner sample and dual-VC parameters, and it assumes an agnostic weak learner of correlation-oracle type. It also outputs a voting classifier rather than a proper concept. It therefore does not supply the missing proper fixed-marginal selector from a strong clean learner alone.

### Atlas-Ready Verdict

Recommended status for the original edge:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
summary: "Open: marginal-preserving low-noise coupling gives proper weak agnostic candidates when OPT is below the fixed-marginal clean-transcript scale. The remaining middle-OPT regime is equivalent to an effective same-marginal proper residual selector/list-selector problem. Fixed-P trace-cover theorems give the right sample-level object but not a polynomial-time way to enumerate or search it under the atlas efficiency requirement."
```

### Atlas-Ready Proof Status Wording

**Goal.** Decide whether efficient marginal-nonuniform realizable proper PAC learning implies efficient marginal-nonuniform weak agnostic proper PAC learning.

**Low-noise branch.** Fix a marginal $P$ and a representation size $s$. Let $A$ be the source learner run at a constant clean accuracy and confidence, with $P$-dependent sample/runtime bound $m_P(s)$. If an agnostic distribution $\mathcal D$ with marginal $P$ has a near-optimal comparator $c^\star\in\mathcal C_s$ whose error is much smaller than $1/m_P(s)$, couple a noisy run on $\mathcal D$ to the clean run on $(X,c^\star(X))$ using the same $P$-distributed instance sequence. With inverse-polynomial probability at the right $P$-dependent scale, the transcript seen by $A$ is clean enough that validation over repeated runs finds a proper hypothesis with weak agnostic excess. This proves the low-noise part without changing the instance marginal.

**Middle-OPT reduction.** In $\{\pm1\}$ notation, write
$$
\mu(x)=\mathbf E[Y\mid X=x],
\qquad
M_{\mathcal C_s}(\mu)=\sup_{c\in\mathcal C_s}\mathbf E_P[c(X)\mu(X)].
$$
The weak agnostic target with gap $\gamma_P(s)$ asks for a proper $h\in\mathcal C_s$ satisfying
$$
\mathbf E_P[h(X)\mu(X)]
\ge M_{\mathcal C_s}(\mu)+2\gamma_P(s)-1.
$$
Once the low-noise case $M_{\mathcal C_s}(\mu)\approx 1$ is removed, it is enough to find a legal proper hypothesis whose correlation with the residual labels is only mildly negative, for example at least $-\alpha_P(s)$ for an inverse-polynomial $\alpha_P$. Thus the remaining content is not clean decoding. It is an efficient same-$P$ proper neutralizer or list-selector.

**Conditional selector lemma.** The edge would be true under the following additional primitive. For every fixed marginal $P$ and size $s$, suppose there is a single algorithm, with runtime bounded by a $P$-dependent polynomial, that on labeled samples from any signed regression function $\mu$ either:

1. outputs a proper $h\in\mathcal C_s$ with $\mathbf E_P[h\mu]\ge M_{\mathcal C_s}(\mu)+2\gamma_P(s)-1$, or
2. in the middle-OPT regime, outputs a polynomial-size list of proper hypotheses containing some $h$ with $\mathbf E_P[h\mu]\ge -\alpha_P(s)$.

Then low-noise coupling handles the high-$M$ case, and validation over the selector/list handles the middle case. This gives the target learner with marginal-dependent polynomial resources. The lemma is useful atlas wording because it isolates exactly what is missing.

**Fixed-$P$ trace-cover near miss.** The source learner does imply a tempting fixed-marginal trace-cover intuition. For each $P$, $s$, and accuracy radius $\rho$, running the clean learner on realizable label traces over an unlabeled $P$-sample produces proper hypotheses close to every $c\in\mathcal C_s$ under $P$. Hopkins--Kane--Lovett--Mahajan's non-uniform-cover theorem formalizes this sample-level conversion: once such a bounded cover is available, ERM over the cover gives agnostic learning.

This does not resolve the efficient atlas edge. The natural cover is generated by running the clean learner over all realizable labelings of a sample of length $m_P(s,\rho)$, which can cost $2^{m_P(s,\rho)}$. Since $m_P$ is only promised to be polynomial, this is generally exponential in $s$. Marginal-nonuniformity permits the polynomial bound to depend on $P$, but it does not permit arbitrary superpolynomial enumeration for that fixed $P$.

There is also a representation problem. Benedek--Itai/Hopkins-style covers are finite objects in the metric/sample sense; the target here needs an effective proper search procedure. A clean learner is guaranteed only on realizable labeled samples. It gives no promise on arbitrary noisy labels, no weighted projection oracle for
$$
\max_{h\in\mathcal C_s}\mathbf E_P[h(X)\mu(X)],
$$
and no way to identify which clean traces are relevant to the agnostic conditional distribution.

**Why the strong marginal clean source still falls short.** The source is stronger than weak distribution-free clean learning: for each fixed $P$, it gives high-accuracy proper learning uniformly over concepts and at arbitrary accuracy. But that information is promise-restricted. It says:

```text
if the labels are realizable by a concept c, a proper hypothesis close to c is found under P.
```

The target needs:

```text
for arbitrary labels with the same marginal P, find a proper hypothesis weakly competitive with the best proper comparator.
```

Moving from the first statement to the second requires either enumerating enough clean traces, constructing an explicit polynomial-size proper cover, or solving a same-$P$ residual selector/projection problem. None follows from the current source definition. Known halfspace, monomial, PCP, parity/code, and one-way-function routes still do not provide a separation for this exact edge: they either prove only strong agnostic hardness, vary the hard marginal, fail the strong clean proper source, or leave legal weak proper handles.

### Final Depth-7 Verdict

The original edge is still unresolved. The best atlas-ready update is to keep it open, record the low-noise coupling as positive partial progress, and state the middle-OPT obstruction as an effective same-marginal proper neutralizer/list-selector problem. The fixed-$P$ trace-cover theorem is the main near miss: it explains why the sample-level analogue should be true, but it does not give the polynomial-time proper selector required by the efficient marginal-nonuniform target.

RESOLVED: no

## Depth 8 Final Incorporation Recommendation

### Final Verdict

RESOLVED: no.

The edge should remain `status: "open"`. The depth-8 search did not find a theorem turning efficient marginal-nonuniform realizable proper PAC learning into efficient marginal-nonuniform weak agnostic proper PAC learning, and it did not find a sound counterexample. The useful output is a sharper atlas note: low-noise coupling gives real partial progress, while the remaining middle-OPT case is exactly the missing same-marginal proper neutralizer/list-selector problem.

### Exact Suggested Frontmatter Update

Recommended update for:

```text
atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md
```

Keep the edge open and keep the empty assumptions/witnesses fields. Add `hopkins2024` to `ref_keys`, because the final analysis uses the HKLM non-uniform-cover theorem as the cleanest trace-cover near miss. The exact suggested frontmatter fields are:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - benedek1991fixed
  - hopkins2024
  - hanneke2025marginalnonuniform
  - tiegel2023
  - feldman2012monomials
refs:
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
  - "[Hopkins et al. 2024](https://theoretics.episciences.org/13009)"
  - "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
  - "[Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)"
  - "[Feldman et al. 2012](https://doi.org/10.1137/120865094)"
summary: "Open: low-noise coupling gives proper weak agnostic candidates below the fixed-marginal clean-transcript scale. The unresolved middle-OPT regime asks for an efficient same-marginal proper neutralizer/list-selector. Fixed-P trace-cover theorems give the right sample-level object, but the marginal strong clean source does not by itself give a polynomial-time proper search, projection, or cover-enumeration algorithm."
```

### Exact Suggested Body Update

Replace the current `## Proof Status` section with the following atlas-ready text.

```markdown
## Proof Status

**Goal.** Decide whether efficient marginal-nonuniform realizable proper PAC learning implies efficient marginal-nonuniform weak agnostic proper PAC learning.

**Low-noise coupling.** Fix a marginal $P$ and representation size $s$. Run the source learner at a constant clean accuracy and confidence, and let $m_P(s)$ denote the resulting fixed-marginal clean transcript scale. If an agnostic distribution $\mathcal D$ with marginal $P$ has a near-optimal comparator $c^\star\in\mathcal C_s$ whose error is well below $1/m_P(s)$, then a noisy sample from $\mathcal D$ can be coupled to the clean sample $(X,c^\star(X))$ with the same $P$-distributed instances. With inverse-polynomial probability at the $P$-dependent scale, the source learner sees an effectively clean transcript and returns a proper hypothesis close to $c^\star$ under $P$. Repeating and validating candidates gives a proper weak agnostic hypothesis in this low-noise regime.

**Middle-OPT obstruction.** In $\{\pm1\}$ notation, write
$$
\mu(x)=\mathbf E[Y\mid X=x],
\qquad
M_{\mathcal C_s}(\mu)=\sup_{c\in\mathcal C_s}\mathbf E_P[c(X)\mu(X)].
$$
The weak agnostic target with gap $\gamma_P(s)$ asks for a proper $h\in\mathcal C_s$ satisfying
$$
\mathbf E_P[h(X)\mu(X)]
\ge M_{\mathcal C_s}(\mu)+2\gamma_P(s)-1.
$$
After the low-noise case $M_{\mathcal C_s}(\mu)\approx 1$ is removed, it would suffice to find a legal proper hypothesis with only mildly negative residual correlation, for example $\mathbf E_P[h\mu]\ge -\alpha_P(s)$ for an inverse-polynomial $\alpha_P$. This is the missing same-marginal proper neutralizer or residual selector. The clean source learner is only promised on realizable labels, so it does not directly solve this signed or noisy projection problem.

**Conditional neutralizer/list-selector lemma.** The edge would be true under the following additional primitive. For every fixed marginal $P$ and size $s$, suppose there is one algorithm, with runtime bounded by a $P$-dependent polynomial, that on samples from any signed regression function $\mu$ either outputs a proper $h\in\mathcal C_s$ meeting the weak agnostic inequality above, or, in the middle-OPT regime, outputs a polynomial-size list of proper hypotheses containing some $h$ with $\mathbf E_P[h\mu]\ge -\alpha_P(s)$. Then low-noise coupling handles the high-$M_{\mathcal C_s}$ case and validation over the selector/list handles the middle case. Thus this primitive would imply the target. No argument currently derives it from marginal-nonuniform realizable proper learning alone.

**Fixed-$P$ trace-cover near miss.** The source guarantee suggests a fixed-marginal trace-cover route. For each $P$, $s$, and radius $\rho$, one can imagine running the clean proper learner over realizable label traces on an unlabeled $P$-sample to obtain proper hypotheses close under $P$ to each concept in $\mathcal C_s$. Benedek-Itai fixed-distribution covers and the Hopkins-Kane-Lovett-Mahajan realizable-to-agnostic theorem explain why such covers are enough at the sample level: ERM over an explicit cover would give agnostic learning.

This does not settle the efficient edge. The natural trace cover may require enumerating $2^{m_P(s,\rho)}$ labelings, and $m_P(s,\rho)$ is only promised to be polynomial. Marginal-nonuniformity allows the polynomial bound to depend on $P$, but it does not allow arbitrary superpolynomial enumeration for that fixed $P$. Moreover, the cover must be represented by legal proper hypotheses and searched effectively against noisy labels; the clean learner gives no weighted proper projection oracle for
$$
\max_{h\in\mathcal C_s}\mathbf E_P[h(X)\mu(X)].
$$

**Why the marginal strong source is not enough.** The source is stronger than weak distribution-free clean learning because, for each fixed $P$, it gives high-accuracy proper learning at arbitrary accuracy. That strength is still promise-restricted: it controls realizable samples $(X,c(X))$, not arbitrary labels with the same marginal. To obtain the weak agnostic target one must additionally enumerate enough clean traces, construct an explicit polynomial-size proper cover, or solve the same-$P$ proper neutralizer/list-selector problem. None of these follows from the source definition.

**Why known hardness routes are insufficient.** Halfspace hardness results are strong-accuracy lower bounds and do not eliminate easy weak proper handles. Monomial/FGRW and PCP-style constructions encode or vary the hard marginal. Parity, LPN, code, and one-way/PRF routes either fail the strong clean proper source, leak neutralizing proper hypotheses, or prove only exact/strong agnostic hardness rather than ruling out the weak marginal target.

**Conclusion.** The edge remains open. The atlas should record the low-noise coupling as positive partial progress and the middle-OPT proper neutralizer/list-selector as the remaining obstruction. The fixed-$P$ trace-cover route is the central near miss: it explains why the sample-level analogue is plausible, but it does not supply the polynomial-time proper selector required by the efficient marginal-nonuniform target.
```

### Recommended Atlas Action

Do not change `status` away from `open`. Incorporate the above frontmatter summary and proof-status replacement when editing the atlas. The update should make four points explicit:

1. Low-noise coupling is a genuine positive partial result and preserves the original marginal $P$.
2. The unresolved middle-OPT case is a conditional neutralizer/list-selector problem over proper hypotheses.
3. Fixed-$P$ trace-cover theorems are the main near miss, but their natural enumeration is generally exponential and not an efficient marginal-nonuniform learner.
4. The marginal strong clean source is not enough by itself, because it is a realizable-label promise and gives no effective proper search/projection oracle for arbitrary noisy labels.

## Depth 9 Attempt: Final Marginal Strong Proper Search

### Sources Rechecked

I rechecked the edge note, both endpoint definitions, the existing depth-1 through depth-8 tree, and the nearby atlas argument/witness notes for low-noise robustification, marginal agnostic hardness, properization, halfspace hardness, PCP active slices, one-way weak handles, fixed-$k$-term DNF, and the improper sibling edge.

I also rechecked the primary-source near misses:

- Benedek--Itai fixed-distribution learning: fixed-$D$ learnability is equivalent to finite coverability, but the paper is explicit that its main concern is sample complexity rather than computation; the sample-to-hypothesis map can be undecidable or infeasible in some cases. See [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X) and the hosted PDF.
- Hopkins--Kane--Lovett--Mahajan: their black-box realizable-to-agnostic reduction runs the realizable learner over all labelings of an unlabeled sample and then ERMs over the resulting finite cover; they also state that the generic reduction is computationally inefficient and that this is unavoidable in general unless $P=NP$. See [Hopkins et al. 2024](https://doi.org/10.46298/theoretics.24.2), especially Algorithm 1 and the discussion after it.
- Hanneke--Moran--Thiessen: the current OpenReview page lists the paper as NeurIPS 2025, last modified 2026-04-21, and its results are statistical rate/trichotomy results for marginal-nonuniform PAC learnability, not an effective proper projection theorem. See [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89).
- Tiegel and FGRW: Tiegel's fixed-Gaussian result is a strong agnostic hardness theorem, while the distribution-independent weak halfspace hardness has a gap that can be smaller than inverse-polynomial. FGRW gives NP-hardness of weak agnostic learning of monomials, even with halfspace outputs, for a reduction-generated labeled distribution rather than a fixed-marginal selector theorem. See [Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html) and [Feldman--Guruswami--Raghavendra--Wu 2012](https://doi.org/10.1137/120865094).

### Final Signed Form

For a fixed marginal $P$ and size slice $\mathcal C_s$, write labels in $\{\pm1\}$ and set
$$
\mu(x)=\mathbf E[Y\mid X=x],
\qquad
S_\mu(h)=\mathbf E_P[h(X)\mu(X)],
\qquad
M_\mu=\sup_{c\in\mathcal C_s}S_\mu(c).
$$
The weak agnostic proper target with gap $\gamma_P(s)$ is exactly
$$
S_\mu(h)\ge M_\mu+2\gamma_P(s)-1.
$$

The low-noise branch remains valid: if $M_\mu$ is close enough to $1$ at the inverse of the fixed-$P$ clean transcript scale, a noisy run of the source learner can be coupled to a clean run for a near-optimal $c^\star$ using the same $P$-distributed instances. Repetition and validation yield a proper candidate.

The only remaining regime is therefore:
$$
M_\mu\le 1-\alpha_P(s)
$$
for some inverse-polynomial scale $\alpha_P$ below the clean transcript inverse. In this regime it is enough, but not known how, to efficiently produce a legal concept with mildly nonnegative residual behavior, for example $S_\mu(h)\ge -O(\alpha_P(s))$. This is the final form of the selector obstruction.

### Last Positive Route: HKLM Cover Made Effective

If the HKLM/Benedek--Itai cover were available as an explicit polynomial-time proper list under the same marginal $P$, the edge would be true. The proof is short:

1. Construct a finite proper list $L\subseteq\mathcal C_s$ that contains, for every $c\in\mathcal C_s$, a representative within $P$-distance $\rho$.
2. Validate all $h\in L$ on agnostic labels.
3. If $c^\star$ is optimal and $a\in L$ covers it, then
$$
\operatorname{err}_{\mathcal D}(a)
\le
\operatorname{OPT}_{\mathcal C_s}(\mathcal D)+\rho.
$$
Taking $\rho$ inverse-polynomial would give even strong marginal agnostic proper learning.

The problem is still exactly effectivity. HKLM's generic construction produces the list by running the clean learner over all labelings of an unlabeled sample. For a clean sample bound $m_P(s,\rho)$ this can be $2^{m_P(s,\rho)}$ traces. Because $m_P$ is only promised polynomial in $s$ and $1/\rho$, this is generally superpolynomial in $s$. Marginal-nonuniformity allows the exponent and constants of a polynomial to depend on $P$; it does not allow an exponential-in-polynomial trace enumeration for that fixed $P$.

So the sample-level analogue is strongly supported by the sources, but the efficient edge does not follow from them.

### Last False Route: Fixed-Marginal No-Neutral Search

A counterexample would need a fixed marginal $P$ and a class satisfying the strong clean proper source, while making the half-range signed search
$$
\text{find }h\in\mathcal C_s
\text{ with }
S_\mu(h)\ge M_\mu+2\gamma_P(s)-1
$$
computationally hard for some efficiently samplable conditional label rule $\mu$.

This is weaker than ordinary agnostic optimization hardness. It is not enough to make the maximizer hard. The reduction must rule out every efficiently findable proper weak handle whose score is merely not too far below the optimum. That requirement kills the standard templates:

- Parity/LPN and Hadamard-code routes have clean proper learners and noisy-search hardness, but wrong codewords are approximately neutral under the fixed marginal and satisfy the weak threshold throughout the middle-noise regime.
- Making every wrong codeword fail would require pairwise distances above $1/2+\Omega(\gamma)$ from the hidden target; Plotkin-type bounds then prevent exponentially many such binary codewords at inverse-polynomial $\gamma$.
- CSP/PCP routes can make proper optimization hard, but random assignments, constants, local defaults, or active-slice lookup handles tend to meet the weak threshold unless the hard instance is encoded into the marginal. When the active slice is held fixed, clean proper learning on satisfiable instances tends to recover the PCP proof and violates the source.
- One-way and PRF-style routes either make strong clean proper learning hard under the fixed marginal or add handles that make weak proper learning easy.
- Halfspace and monomial hardness results are real hardness theorems, but as currently stated they either target strong agnostic accuracy, use a too-small weak gap for the atlas target, or move the hard distribution rather than proving one fixed-marginal no-neutral selector lower bound.

The false witness still seems to require a new primitive: one fixed marginal ensemble with efficient clean proper extension for every realizable target, but where every randomized polynomial-time proper output that meets the weak half-range inequality decodes a hard witness. I did not find such a primitive in the local atlas notes or the checked primary sources.

### Final Obstacles Suitable For The Atlas

1. **Effectivizing the non-uniform cover.** A proof of the edge would follow from a same-$P$ polynomial-time procedure that turns the clean learner's implicit trace cover into a validation-searchable proper list. Known cover theorems are statistical and naturally enumerate all labelings.

2. **Proper residual neutralization.** A proof would also follow from an efficiently findable proper neutralizer, balanced proper sampler, complement/anchor pair, or middle-OPT selector. These structures exist in many natural classes but are not implied by the source definition.

3. **Weak-handle hardness.** A separation must prove more than hard agnostic ERM. It must rule out all legal weak handles at the threshold $M_\mu-1+2\gamma_P(s)$ under one fixed marginal, while preserving efficient strong clean proper learning.

4. **Representation-sensitive or oracle route.** The remaining plausible false route is a carefully specified representation/oracle construction in which clean labels reveal a legal proper representation but agnostic labels do not permit even neutral legal search. Such a construction would need to respect the atlas finite-transcript and marginal-dependent-polynomial conventions.

### Proposed Atlas Handling

No atlas field should be changed to `true` or `false`. The depth-8 proposed update is still the best atlas action: keep

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
```

and keep the summary centered on low-noise coupling plus the middle-OPT same-marginal proper neutralizer/list-selector obstruction. The current edge file already contains that framing and includes the main near-miss references.

RESOLVED: no
