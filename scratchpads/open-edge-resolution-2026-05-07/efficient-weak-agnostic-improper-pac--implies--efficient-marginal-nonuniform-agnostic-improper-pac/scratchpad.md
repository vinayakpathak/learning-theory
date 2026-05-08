## Depth 1 Branch A: Marginal Bookkeeping Does Not Remove Fixed Slack

### Setup Read First

I first read the edge note
`atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac.md`,
the two endpoint definitions, the sibling edge
`efficient-weak-agnostic-improper-pac--implies--efficient-agnostic-improper-pac`,
and the realizable siblings. I also checked the local
`agnostic-boosting-open` and `marginal-boosting-open` argument notes.

The source is stronger than a marginal-nonuniform weak source: it gives one
distribution-free efficient improper weak agnostic learner with fixed additive
tolerance
$$
\operatorname{err}_D(h)\le \operatorname{OPT}_C(D)+\beta,
\qquad \beta<1/2.
$$
The target is weaker than distribution-free strong agnostic learning only in
the resource bound: for each fixed instance marginal $P$, the final strong
learner may have a polynomial $p_P(s,1/\varepsilon,\log(1/\delta))$ depending
on $P$.

I also refreshed the closest primary sources on 2026-05-07. Feldman's
distribution-specific booster explicitly preserves the instance marginal by
modifying labels, which is attractive for this target. Ghai--Singh 2025 gives
a modern efficient version in that accuracy-sensitive correlation-oracle
regime. Da Cunha--Hogsgaard--Paudice 2026 is the closest fixed-slack theorem:
the arXiv page for `2601.11265` says v3 was last revised on 2026-02-03 and
that the runtime is polynomial in the sample size when the other parameters
are fixed. Inspecting the TeX source confirms the theorem still has weak
sample/capacity parameters in the exponent.

### Correlation Translation

Use labels in $\{-1,1\}$. The source guarantee is equivalent to
$$
\operatorname{corr}_D(h,Y)
\ge
\sup_{c\in C}\operatorname{corr}_D(c,Y)-2\beta.
$$
Thus the source is a fixed-additive approximation to the best correlation.
Since $\beta<1/2$, this is a nontrivial fixed-slack oracle in the sense of the
recent da Cunha-style boosting framework. In particular, the obstacle is not
that the weak learner fails on reweighted or relabeled distributions: it is
distribution-free, so every distribution queried by either a Schapire-style
reweighting booster or a Feldman-style same-marginal relabeling booster is
within the source promise.

The obstruction is that the slack is fixed. On a query distribution $Q$, the
source is forced to give positive correlation only when
$$
\operatorname{OPT}_C(Q)<1/2-\beta.
$$
When the residual or relabeled task has best correlation below $2\beta$, a
progress-neutral response is legal even if a strong agnostic learner still
needs that small correlation to reach excess error $\varepsilon\ll 1$.

### Why Same-Marginal Boosting Does Not Settle It

The most tempting positive route is:

1. Fix the original marginal $P$.
2. Use a Feldman/Ghai-style booster that only relabels points, so every weak
   call has instance marginal $P$.
3. Let the final runtime polynomial depend on $P$.

This removes the usual marginal-nonuniform boosting problem, where ordinary
boosting induces many new instance marginals whose weak-learner polynomials
need one original-marginal envelope. Here the source is distribution-free
anyway, so even that issue is absent.

However, Feldman/Ghai-style theorems use a threshold or correlation weak
oracle with accuracy at the final scale. In the Ghai--Singh notation, the
weak learner satisfies something like
$$
\operatorname{corr}(W,Y)\ge
\gamma\max_{c\in C}\operatorname{corr}(c,Y)-\varepsilon_0,
$$
and the final excess includes a residual of order $\varepsilon_0/\gamma$ plus
the booster accuracy. Their own formulation treats $\varepsilon_0$ as a
separate weak-oracle accuracy parameter, and the 2025 paper states final
residual terms such as $2\varepsilon_0/\gamma+\varepsilon$ or
$(1+\mathcal C_X)\varepsilon_0/\gamma+\varepsilon$ in variants.

The atlas source cannot make $\varepsilon_0$ small. If we validate and flip
weak outputs, the best generic lower envelope from
$\operatorname{corr}\ge \rho-2\beta$ is
$$
\operatorname{corr}\ge \max\{0,\rho-2\beta\}.
$$
Trying to dominate this by $\gamma\rho-\varepsilon_0$ for all
$\rho\in[0,1]$ forces $\varepsilon_0/\gamma\ge 2\beta$ at
$\rho=2\beta$. So accuracy-sensitive same-marginal agnostic boosting gives at
best a constant residual from this source, not arbitrary excess error.

### Why Fixed-Slack Boosting Does Not Fit The Target Runtime

The da Cunha--Hogsgaard--Paudice fixed-slack theorem is semantically much
closer. Their weak condition permits fixed constants
$(\gamma_0,\varepsilon_0)$ with only $\gamma_0>\varepsilon_0$. The atlas source
instantiates this, for example, with
$$
\gamma_0=1,\qquad \varepsilon_0=2\beta,
\qquad \theta=(\gamma_0-\varepsilon_0)/2=1/2-\beta.
$$
So the fixed-additive source is not too weak for that theorem's weak-oracle
definition.

The problem is computational bookkeeping. The theorem statement and proof give
weak-learner calls and runtime of the form
$$
O(n^{m_0+3})
$$
and
$$
\operatorname{Eval}_H(1)\cdot
n^{O(m_0\min\{d^*,\log n\}/\theta^2)}.
$$
Here $m_0$ is the weak learner's sample requirement, $d^*$ is a dual-VC/base
capacity parameter, and $\theta$ is the fixed nontriviality gap. In the atlas
edge, $m_0$ may be polynomial in the representation size $s$; $d^*$ may also
grow with $s$. Substituting this gives $n^{\operatorname{poly}(s)}$, not a
polynomial in $s,1/\varepsilon,\log(1/\delta)$.

The marginal-nonuniform target does not absorb this. For each marginal $P$,
$p_P$ may have $P$-dependent constants and degree, but it is still one
polynomial in the representation size. It cannot have degree $m_0(s)$ growing
with $s$, and it cannot depend on the conditional label rule or hidden
comparator. Thus da Cunha 2026 gives a fixed-parameter or statistical near
positive result, not an atlas-polynomial proof of this edge.

### Comparison With Siblings

The distribution-free strong agnostic sibling has the same fixed-slack
obstruction. The present target is weaker only by allowing $P$-dependent
polynomial resource bounds, but the checked positive routes do not fail
because of an original-marginal envelope. They fail because the weak slack is
fixed, or because the fixed-slack runtime exponent grows with representation
parameters. Those are not repaired by making the final polynomial depend on
$P$.

The realizable siblings are different. On realizable distributions,
$\operatorname{OPT}_C=0$, so the weak agnostic source becomes an ordinary weak
realizable learner with error $<1/2$. Schapire/Freund boosting then gives a
strong improper learner. That proof does not extend to agnostic labels because
when $\operatorname{OPT}_C>\!1/2-\beta$, the fixed-additive weak guarantee may
legally return no useful signal, while the strong agnostic target still asks
for $\operatorname{OPT}_C+\varepsilon$.

### Counterexample Search

I do not have a false witness.

Halfspaces do not work: the atlas already records that the relevant lattice
hardness rules out even distribution-free weak agnostic improper learning, so
halfspaces fail the source rather than separating source from target.

Cryptographic hidden-function templates also fail at the source. Because the
source is distribution-free, the adversary can put all mass on the hidden hard
region with realizable or low-noise labels. Any class hard enough to block
strong improper agnostic learning under such a marginal tends to be hard even
for weak prediction there.

Lookup and PCP-style classes go the other way. When the weak source is made
true by visible handles or sampled-slice lookup tables, the target is often
also true for improper learners, because a strong learner may vote, validate,
or memorize the visible handles. Proper-output hardness does not survive the
improper target.

The remaining plausible false route would be a code/noisy-decoding class:
efficient weak recovery from every low-OPT weighted distribution, but hard
near-optimal recovery at constant noise. I do not know a construction with the
required distribution-free weak agnostic improper source. Parity/LPN-like
templates capture the high-noise hardness flavor, but their low-OPT
distribution-free weak agnostic requirement becomes a weighted adversarial
noise decoding problem, which is already the hard part.

### Current Obstacles

1. Same-marginal agnostic boosting is attractive and would fit the
   marginal-nonuniform target, but the efficient Feldman/Ghai interface needs
   tunable weak slack. The atlas source has a fixed floor, so its residual
   cannot be driven below a constant.

2. The known fixed-slack theorem accepts the atlas source semantically but has
   $m_0$ and capacity parameters in the exponent. A $P$-dependent target
   polynomial cannot absorb an exponent that grows with representation size.

3. No source-positive, target-negative class is known. Standard hardness
   templates either violate the distribution-free weak source or become easy
   once the final learner may be improper.

### Depth 2 Directions

1. Look for a fully polynomial fixed-slack agnostic booster: runtime polynomial
   in $m_0$, $d^*$, $1/\theta$, $1/\varepsilon$, and representation size, with
   no weak-sample or capacity parameter in an exponent. This would resolve the
   edge true, and in fact also resolve the distribution-free strong agnostic
   sibling.

2. Formalize a black-box lower bound for fixed-additive weak oracles under
   same-marginal relabeling. The target statement should show that any
   polynomial-query booster using only an
   $\operatorname{OPT}+1/2-\gamma$ oracle can be forced to miss hidden
   low-noise witnesses when the ambient optimum is above $\gamma$.

3. Search for a concrete noisy-decoding or planted-code witness satisfying the
   distribution-free weak source on every low-OPT distribution while preserving
   hardness of $\operatorname{OPT}+\varepsilon$ improper learning under one
   fixed marginal. This needs a genuine source proof, not just high-noise
   hardness.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac/scratchpad.md

## Depth 2 Branch A: Tuple Barrier Survives Fixed Marginals

### What I Rechecked

This pass compared the target edge directly against the distribution-free
strong agnostic sibling
`efficient-weak-agnostic-improper-pac--implies--efficient-agnostic-improper-pac`.
I also rechecked the current primary-source statements for the three closest
positive routes:

- Feldman 2010 distribution-specific agnostic boosting:
  https://arxiv.org/abs/0909.2927.
- Ghai--Singh 2025 sample-optimal agnostic boosting with unlabeled data:
  https://proceedings.mlr.press/v267/ghai25a.html.
- da Cunha--Hogsgaard--Paudice 2026 fixed-slack agnostic boosting,
  `arXiv:2601.11265`, v3 last revised 2026-02-03:
  https://arxiv.org/abs/2601.11265.

The relevant facts are the same as in Depth 1, but the marginal-nonuniform
quantifier deserves a sharper separation from the fixed-distribution intuition.
The target allows, for each fixed instance marginal $P$, a polynomial
$$
p_P(s,1/\varepsilon,\log(1/\delta)).
$$
The polynomial may have $P$-dependent constants and degree, but once $P$ is
fixed it must still be one polynomial in the representation size $s$ and
accuracy parameters. It may not have degree $m_0(s)$, $d^*(s)$, or any other
quantity that grows with the represented concept size.

### Same-Marginal Boosting Still Has A Slack Floor

Feldman-style relabeling is the best reason to hope that the marginal target
could be easier than the distribution-free strong target. Its weak calls keep
the feature marginal fixed and only change the label rule, which is exactly the
kind of bookkeeping the target permits.

However, the atlas source gives only a fixed-additive oracle. In correlation
form,
$$
\operatorname{corr}(W,Y)\ge \rho-2\beta,
\qquad
\rho=\sup_{c\in C}\operatorname{corr}(c,Y).
$$
After validation and possible sign flipping, the generic lower envelope is
only
$$
\operatorname{corr}(W,Y)\ge \max\{0,\rho-2\beta\}.
$$

Trying to view this as a Ghai/Kalai--Kanade style oracle
$$
\operatorname{corr}(W,Y)\ge a\rho-\tau
$$
does not make the final residual small. For every $a>0$, validity at
$\rho=2\beta$ forces $\tau\ge 2a\beta$, hence $\tau/a\ge 2\beta$. Equivalently,
in Feldman's threshold notation, the source becomes useful on an
$(\alpha,\gamma)$ query only when $\alpha>\beta$, with a weak edge roughly
$\alpha-\beta$. Feldman's strong-accuracy use needs the threshold $\alpha$ at
the final error scale, so for $\varepsilon<\beta$ the fixed source cannot
instantiate the needed oracle.

Thus marginal preservation solves only the wrong problem. It avoids induced
feature marginals, but it does not turn a fixed weak slack into a tunable
accuracy-scale weak slack.

### da Cunha Accepts The Source But Not The Target Resource Bound

The da Cunha--Hogsgaard--Paudice theorem accepts the atlas source semantically.
Set
$$
\gamma_0=1,\qquad \varepsilon_0=2\beta,\qquad
\theta=(\gamma_0-\varepsilon_0)/2=1/2-\beta.
$$
Since $\beta<1/2$, this is a nontrivial fixed-slack weak learner in their
sense.

The formal runtime is the obstruction. Their v3 theorem invokes the weak
learner at most
$$
O(n^{m_0+3})
$$
times and has a search term of the form
$$
\operatorname{Eval}_H(1)\cdot
n^{O(m_0\min\{d^*,\log n\}/\theta^2)}.
$$
Here $m_0$ is the weak learner's sample parameter and $d^*$ is a dual-VC/base
capacity parameter. In the atlas source, $m_0$ may be polynomial in $s$; the
base/output capacity may also grow with $s$. Substituting these into the
displayed bound gives $n^{\operatorname{poly}(s)}$ or worse. With
$n=\operatorname{poly}(s,1/\varepsilon,\log(1/\delta))$, this is not a
polynomial in the target variables.

The marginal-nonuniform target cannot absorb this in the current atlas
semantics. For a fixed $P$, the polynomial $p_P$ may be large, but its degree is
fixed as $s$ varies. A pathwise algorithm whose runtime contains
$n^{m_0(s)}$ has degree growing with $s$ independently of $P$. That is not a
valid marginal-dependent polynomial bound.

This is the key difference between a fixed-parameter positive theorem and an
atlas update. If $m_0$, $d^*$, and $1/\theta$ were treated as constants, or if a
separate strengthened node bounded them independently of representation size,
then the theorem would support a conditional true statement. It does not prove
the present implication.

### Why The Tuple Enumeration Looks Intrinsic To This Route

The da Cunha proof uses the weak learner on hidden low-noise or realizable
subproblems associated with a near-best comparator $f$. If the observed data
come from a distribution with constant agnostic noise $\eta>1/2-\beta$, the
original distribution may have $\operatorname{OPT}_C(D)=\eta$, so the atlas weak
learner can legally return no useful signal. The forced signal appears only on
comparator-dependent clean subsets, such as examples where $f(x)=y$.

Let $S$ be a final sample of size $n$, and let $G\subseteq S$ be such a hidden
clean set with density $p=|G|/n$ bounded away from $0$. If the weak learner
needs an $m_0$-tuple from the low-noise set, then a generic observable booster
would like to replace all $n^{m_0}$ tuples by a polynomial-size menu $L$.
But for a random hidden clean set $G$ of density $p$ and any fixed ordered tuple
$T$,
$$
\Pr[T\subseteq G]\approx p^{m_0}.
$$
Therefore a menu of $q$ tuples hits $G$ with probability at most about
$q p^{m_0}$. When $m_0$ grows with $s$, every
$q=\operatorname{poly}(n,m_0,1/\theta)$ misses some hidden clean set. This is
not a formal lower bound for all possible boosters, but it explains why the
known fixed-slack proof pays the $n^{m_0}$ price: it has to cover comparator
choices that are invisible from the observed marginal and labels.

The marginal-nonuniform target does not remove this combinatorial issue. The
hidden set $G$ lives inside one fixed marginal $P$ and varies with the
conditional label rule or comparator. The polynomial $p_P$ is not allowed to
depend on that label rule, and it cannot give a different exponent for every
possible hidden clean subset.

### Comparison With The Distribution-Free Sibling

This edge is not easier for the reasons one might first expect. The source is
already distribution-free, so ordinary reweighting boosters are allowed to call
the weak learner on any induced marginal. Passing to a marginal-nonuniform
target only relaxes the final resource accounting. The checked positive routes
fail before that relaxation matters:

1. Feldman/Ghai-style fixed-marginal methods are polynomial but need tunable
   weak slack.
2. da Cunha-style fixed-slack methods remove the residual but enumerate
   weak-learner inputs with representation-dependent exponents.

Consequently, a fully polynomial fixed-slack agnostic booster would resolve
both this edge and the distribution-free strong agnostic sibling. Conversely,
the clean-tuple black-box obstruction applies to both edges, because it is
about hidden conditional structure inside a single marginal, not about
generating new feature marginals.

### Why I Still Do Not Have A False Witness

A separation would need a class with a distribution-free
$\operatorname{OPT}+\beta$ improper learner for every labeled distribution, but
no strong improper agnostic learner under some fixed marginal. The standard
hard families still fail this exact source/target combination.

Parity/LPN and code-decoding templates have the right high-noise hardness
flavor, but the source would require efficient weak recovery from every
weighted low-OPT distribution. That is already a weighted adversarial decoding
problem, not the easy realizable case.

Cryptographic hidden-function templates fail because the distribution-free
source must work when the adversary places all mass on the hidden hard region
with realizable or low-noise labels. If weak prediction is possible there, the
usual pseudorandomness-based strong hardness is usually gone; if it is not
possible, the source fails.

Lookup and visible-handle constructions tend to make the target true once
improper hypotheses are allowed: the strong learner can validate, vote, or
memorize the visible handles. Proper-learning hardness is not enough for this
improper target.

### Current Obstacles

1. Fixed-marginal relabeling preserves $P$ but cannot shrink the atlas
   additive weak slack. The residual inherited by accuracy-sensitive boosters
   remains constant.

2. The only checked residual-free fixed-slack theorem is not
   atlas-polynomial. Its weak-sample and capacity parameters appear in runtime
   exponents, and a marginal-dependent polynomial cannot have degree growing
   with representation size.

3. The obvious attempt to replace tuple enumeration by a polynomial menu fails
   for hidden clean sets of constant density. Any positive proof must avoid the
   need to hit an all-clean $m_0$-tuple, or exploit structure not present in the
   atlas source.

### Depth 3 Directions

1. Prove a black-box lower bound for same-marginal fixed-slack boosting. The
   oracle should be progress-neutral on all observable high-OPT relabelings and
   useful only on hidden low-OPT $m_0$-tuples, showing that polynomially many
   weak calls cannot generically recover $\operatorname{OPT}+\varepsilon$.

2. Search for a code/noisy-decoding witness with a real source proof: efficient
   distribution-free weak agnostic recovery from every weighted distribution
   with $\operatorname{OPT}<1/2-\beta$, plus hardness of
   $\operatorname{OPT}+\varepsilon$ under one fixed marginal at constant noise.

3. Look for a non-enumerative fixed-slack booster that works directly on noisy
   observable relabelings. The target theorem must have runtime polynomial in
   $m_0$, $d^*$ or a replacement capacity measure, $1/\theta$, and
   $1/\varepsilon$, with none of these parameters in an exponent.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac/scratchpad.md

## Depth 3 Branch A: Black-Box Barrier, No Atlas Witness

### Fresh Angle

This branch tried to turn the Depth 2 tuple barrier into a separation. I also
rechecked the current primary pages for the relevant positive routes on
2026-05-07:

- Ben-David--Long--Mansour's original fixed-additive weak agnostic theorem
  gives the weaker guarantee
  $\max\{c_1(\beta)\operatorname{OPT}^{c_2(\beta)},\varepsilon\}$, not
  $\operatorname{OPT}+\varepsilon$:
  https://cris.tau.ac.il/en/publications/agnostic-boosting.
- Feldman's distribution-specific theorem keeps the instance marginal fixed by
  relabeling, but assumes an $(\alpha,\gamma)$ weak agnostic learner and only
  gives $\alpha$-optimal learning for that threshold:
  https://www.cs.cmu.edu/~odonnell/hits09/feldman-agnostic-boosting.pdf.
- Ghai--Singh 2025 is polynomial and well matched to fixed marginals with
  unlabeled samples, but still lives in the accuracy-sensitive correlation
  oracle regime:
  https://proceedings.mlr.press/v267/ghai25a.html.
- da Cunha--Hogsgaard--Paudice 2026 remains the closest fixed-slack theorem;
  the arXiv abstract still says polynomial in the sample size with other
  parameters fixed, and v3 is dated 2026-02-03:
  https://arxiv.org/abs/2601.11265.

So the literature check did not reveal a new fully polynomial
fixed-additive-to-strong agnostic booster. The useful new work is to sharpen
what the tuple barrier does and does not prove.

### The Same-Marginal Tuple Barrier Is A Black-Box Separation

Fix a marginal $P$ and a final labeled distribution generated by a hidden
near-best comparator $f$ with constant noise rate
$$
\eta\in(1/2-\beta,1/2).
$$
The original task has $\operatorname{OPT}_C(D)=\eta$, so the source weak
learner may legally return a progress-neutral classifier on $D$. A strong
agnostic learner must still approach error $\eta$.

The weak signal is forced only on subproblems where the conditional noise drops
below the weak threshold $1/2-\beta$. In the da Cunha-style proof this is
achieved by feeding the weak learner an $m_0$-sample drawn from a hidden clean
or low-noise set $G$ depending on $f$. Marginal preservation does not expose
$G$: it is not a property of $P$, but of the unknown conditional label rule.

This gives a clean black-box oracle lower bound for polynomial-query boosters
of this kind. Let the weak oracle answer neutrally on every query transcript
unless the booster supplies an all-clean $m_0$-tuple from $G$; on such tuples
it returns a valid weak edge. For any adaptive booster making $q$ weak calls,
as long as prior answers are neutral its queried tuples are independent of
$G$. If $G$ is a random density-$p$ subset of the sample,
$$
\Pr[T\subseteq G]\le p^{m_0}
$$
for each queried tuple $T$, so
$$
\Pr[\text{any hit in }q\text{ calls}]\le q p^{m_0}.
$$
For $m_0=\operatorname{poly}(s)$ and $q=\operatorname{poly}(s,1/\varepsilon)$,
this is negligible. Thus the fixed-marginal tuple barrier is not just a
bookkeeping artifact: it rules out a broad class of black-box boosters whose
only way to beat the fixed slack is to discover hidden low-noise weak-learner
inputs.

The argument survives the marginal-nonuniform relaxation. A $P$-dependent
polynomial can prepay for the geometry of $P$, but it cannot depend on the
hidden comparator or on the conditional noise realization. The hidden set $G$
varies over conditionals with the same $P$, and the target polynomial must work
uniformly over all of them.

### Why This Still Is Not A False Atlas Edge

The black-box oracle above is not yet a concept class. To mark the implication
false, one needs a represented class with a genuine distribution-free
$\operatorname{OPT}+\beta$ improper weak learner and a fixed marginal under
which every uniform polynomial-time strong improper learner fails.

The most plausible conversion is a code/noisy-decoding class. View codewords as
concepts on their coordinate set. The source would follow from an efficient
weighted decoder that, for every marginal over coordinates and every labeling
whose weighted distance to some codeword is below
$\gamma=1/2-\beta$, outputs a hypothesis of error below $1/2$. The target would
fail under a fixed coordinate marginal if high-noise prediction at rate
$\eta\in(\gamma,1/2)$ were hard even for improper outputs.

This blueprint isolates exactly what is missing. Parity/Hadamard-style classes
have the desired high-noise hardness flavor under uniform marginals, but the
distribution-free low-OPT source becomes weighted nearest-codeword or
adversarial-noise decoding, which is already hard. Classical error-correcting
codes with efficient adversarial decoders give the source-looking half only up
to their decoding radius, but I do not know a matching hardness theorem saying
that improper high-noise prediction under one fixed marginal remains hard
above that radius. PCP and Max-CSP encodings give constant-approximation
intuition, but signed labels and improper final hypotheses again make the weak
source the hard part or let the learner memorize/validate visible handles.

So the tuple barrier can be converted into a black-box same-marginal separation
for a family of booster reductions, but not into an atlas separation without a
real class satisfying the all-distributions weak source.

### Why I Do Not See A Different Polynomial Positive Route

The other possible resolution is to avoid clean tuples altogether and obtain
marginal-nonuniform strong agnostic learning by a polynomial same-marginal
boosting route.

Feldman/Ghai-style potential descent is the natural candidate because the
feature marginal stays fixed. But the descent certificate needs weak
correlation at the current residual scale. From the atlas source the best
validated black-box envelope is
$$
\operatorname{corr}(W,Y)\ge \max\{0,\rho-2\beta\},
$$
where $\rho$ is the best residual correlation in $C$. Any inequality of the
form
$$
\operatorname{corr}(W,Y)\ge a\rho-\tau
$$
that holds for all $\rho$ has $\tau/a\ge 2\beta$. Thus these boosters inherit a
constant residual. The obstruction appears exactly when the current predictor
has only small excess error left; the remaining useful correlations are
$O(\varepsilon)$, below the fixed slack floor.

A distribution-specific cover or ERM route also does not give the target.
Fixed $P$ may permit finite $P$-covers statistically, but a generic cover over
a class of VC or representation dimension $\operatorname{poly}(s)$ has size
like $(1/\varepsilon)^{\operatorname{poly}(s)}$, and computational ERM over it
need not be polynomial. The target allows the polynomial to depend on $P$, not
to have degree growing with the representation size. This is the same resource
failure seen in da Cunha's $n^{m_0}$ enumeration.

Finally, using the source learner non-black-box would require extra structure
not present in the node. The source gives one algorithm that achieves a fixed
additive approximation on every labeled distribution; it does not promise
stable confidence scores, a list of near-optimal weak hypotheses, a local
decoder, a correlation oracle with tunable slack, or a way to expose
comparator-dependent clean sets.

### Comparison With The Distribution-Free Sibling

The marginal-nonuniform edge and the distribution-free strong agnostic sibling
now seem to have the same core status. The marginal version avoids no real
obstacle in the positive proofs, because the source learner is already
distribution-free and may be called on any induced marginal. Conversely, the
same-marginal black-box barrier already lives inside one fixed $P$, so it
applies just as strongly to the marginal target.

Therefore:

1. A fully polynomial fixed-slack agnostic booster would resolve both edges
   true.
2. A code/noisy-decoding construction with weighted low-OPT weak decoding and
   high-noise fixed-marginal improper hardness would resolve at least this edge
   false, and likely illuminate the distribution-free sibling.
3. The current tuple argument only separates black-box booster strategies; it
   is not a theorem about all possible learners for a represented class.

### Depth 4 Directions

1. Formalize the black-box oracle model carefully. The oracle must satisfy the
   fixed-additive weak guarantee on every low-OPT query distribution, answer
   neutrally on high-OPT queries, and hide the useful $m_0$-tuples inside one
   fixed marginal. The output should be a theorem that rules out polynomial
   same-marginal fixed-slack boosters, while explicitly saying it is not an
   atlas false witness.

2. Pursue the code blueprint with weighted decoding as the source condition:
   find a code/concept family with efficient distribution-free weighted
   decoding up to some constant radius $\gamma$, but hardness of improper
   prediction under random classification noise $\eta>\gamma$ for the uniform
   coordinate marginal. If such a family exists under LPN, LWE, or nearest-code
   assumptions, it is the cleanest route to `resolved-false`.

3. Search for a non-clean-tuple fixed-slack booster. The exact missing lemma is
   an observable procedure which, whenever the current predictor has excess
   more than $\varepsilon$, produces in time
   $\operatorname{poly}(s,m_0,1/\theta,1/\varepsilon,\log(1/\delta))$ a
   weak-learner query with $\operatorname{OPT}<1/2-\beta$ or an equivalent
   certificate of progress, without enumerating $m_0$-tuples or assuming
   tunable slack.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac/scratchpad.md

## Depth 4 Branch A: Weighted Decoding Door Still Locked

### Goal Of This Branch

This pass focused on the two non-black-box directions left by Depth 3.

First, can the marginal-nonuniform target allowance buy a fully polynomial
fixed-slack agnostic booster even though the distribution-free sibling remains
open? Second, can a code/noisy-decoding class satisfy the full
distribution-free weak source while failing strong marginal-nonuniform
agnostic improper learning under one fixed marginal?

I rechecked the local endpoint definitions and argument notes. The key
semantic point is that the source is the distribution-free fixed-additive weak
node, not the weaker marginal-nonuniform weak node. Thus the halfspace
counterexample for marginal weak sources does not transfer: the halfspace note
itself records that Tiegel-style hardness rules out even weak agnostic
improper learning for halfspaces under the same lattice assumptions.

I also rechecked the current primary pages for the positive boosting route:

- da Cunha--Hogsgaard--Paudice, `arXiv:2601.11265`, still states the improved
  algorithm as polynomial in the sample size with the other parameters fixed:
  https://arxiv.org/abs/2601.11265.
- The older Kalai--Mansour--Verbin and Feldman-style polynomial boosters still
  give an $\alpha$-optimal or threshold/correlation result, not an
  $\operatorname{OPT}+\varepsilon$ result from a fixed
  $\operatorname{OPT}+\beta$ oracle:
  https://www.cs.cmu.edu/~odonnell/hits09/feldman-agnostic-boosting.pdf.

No checked source removed the representation-dependent exponent from the
fixed-slack construction.

### Marginal Nonuniformity Does Not Expose The Clean Structure

Let the source tolerance be
$$
\beta=1/2-\gamma
$$
with $\gamma>0$. On any weak-learner query distribution $Q$, the source is
forced to return a classifier with nontrivial error below $1/2$ only when
$$
\operatorname{OPT}_{\mathcal C}(Q)<\gamma.
$$
When $\operatorname{OPT}_{\mathcal C}(Q)\ge\gamma$, a progress-neutral answer
is legal even if $Q$ still contains information needed for
$\operatorname{OPT}+\varepsilon$ strong learning.

The marginal-nonuniform target fixes only the instance marginal $P$. It allows
one polynomial $p_P(s,1/\varepsilon,\log(1/\delta))$ for all conditional label
rules over that same $P$. The hidden low-noise structure that makes a
fixed-slack query useful is not a property of $P$ alone. It depends on a
near-best comparator and on the conditional noise pattern.

This blocks the most optimistic same-marginal plan. Suppose a booster uses
unlabeled samples from $P$ to build a $P$-specific menu of weak calls, then uses
the distribution-free weak learner on relabeled examples. If the observed
distribution has constant noise $\eta>\gamma$ around a hidden comparator
$c^\star$, every visible same-marginal residual can have
$\operatorname{OPT}\ge\gamma$. The booster must somehow create a query where
the conditional noise drops below $\gamma$. In the known fixed-slack proof this
happens by enumerating weak-learner samples or witness tuples until one lands
inside a comparator-dependent clean set.

For a weak learner with sample parameter $m_0$, a generic menu compression has
the same barrier as in Depth 3. Let $G$ be a random clean set of density
$p>0$ inside a fixed marginal $P$. A menu $L$ of candidate $m_0$-tuples that is
chosen from $P$ and previous neutral answers hits $G$ with probability at most
$$
|L|p^{m_0}.
$$
If $m_0$ grows polynomially with the representation size, then every menu of
size $\operatorname{poly}(s,1/\varepsilon)$ misses some conditional clean set.
The target polynomial may depend on $P$, but it may not depend on the hidden
conditional rule. Thus $p_P$ cannot pay for a different exponent for every
possible $G$.

This does not prove that no fully polynomial booster exists. It does show that
the marginal allowance by itself does not repair the da Cunha enumeration:
the missing object is an observable way to force a low-OPT weak query without
guessing an all-clean $m_0$-tuple.

### Why Distribution-Specific Covers Still Do Not Give A Positive Proof

A second possible use of the fixed marginal is to ignore boosting and learn a
$P$-cover of $\mathcal C$. Statistically this is plausible: weak agnostic
learnability implies finite-dimensional sample control in the sample-only
atlas, and for a fixed $P$ one can imagine $L_1(P)$ covers.

Computationally this does not match the target. If the effective dimension or
weak sample parameter is $d(s)=\operatorname{poly}(s)$, a generic cover has
size like
$$
(1/\varepsilon)^{d(s)}
$$
or worse. A marginal-dependent polynomial may have a large $P$-dependent
degree, but that degree must be fixed as $s$ varies. It cannot be $d(s)$.
Moreover, the atlas source gives an algorithm for fixed-additive weak
approximation, not a tractable ERM oracle over the cover.

So the $P$-specific cover route has the same resource failure as
$n^{m_0}$ tuple enumeration: it is a fixed-distribution statistical route, not
an efficient marginal-nonuniform PAC proof.

### Code/Noisy-Decoding Witness Template

A code witness would be the cleanest false route. Let concepts be codewords
$c_m:X_s\to\{\pm1\}$, and let the hard marginal be the uniform coordinate
distribution $U_s$.

For this class, the source with $\beta=1/2-\gamma$ would follow from a
weighted low-noise decoder:

**Weighted low-noise source condition.** For every distribution $P$ over
coordinates and every labeling rule whose weighted distance to some codeword is
$\eta<\gamma$, there is a polynomial-time learner which outputs a hypothesis
with error at most $\eta+\beta<1/2$ under $P$.

When $\operatorname{OPT}\ge\gamma$, a constant classifier already has error at
most $1/2\le\operatorname{OPT}+\beta$, so the hard part of the source is
exactly arbitrary-weight decoding below the fixed radius $\gamma$.

The target failure would require a fixed-marginal high-noise hardness theorem:
for some $\eta\in(\gamma,1/2)$, given examples from $U_s$ labeled by
$c_m$ with random classification noise $\eta$, no polynomial-time improper
learner can achieve error $\eta+\varepsilon$. For a large-distance code, such
a learner would give nontrivial prediction of the hidden codeword and usually
recover or list the message.

This template is sharp, but I do not know an instantiated code family that has
both sides.

### Candidate Code Families And Where They Fail

**Parity/Hadamard codes.** These have exactly the right high-noise hardness
flavor under LPN-style assumptions: agnostic learning under the uniform
coordinate marginal with constant random noise is hard. But the source would
already require efficient weak recovery at every lower constant noise
$\eta<\gamma$, including the same uniform marginal. Standard LPN hardness is
not known to switch on only above $\gamma$; under the usual assumptions this
violates the source rather than separating source from target. Arbitrary
weighted marginals make the source even stronger.

**Algebraic or locally decodable/list-decodable codes.** These are more
source-friendly because some have efficient decoders or local list decoders.
But that same structure tends to weaken the target hardness. If the code is
efficiently list-decodable or locally recoverable from noise near
$1/2-\varepsilon$ under the uniform coordinate marginal, then an improper
agnostic learner can validate the short list or use the local decoder. If the
available decoder only works in the usual Hamming metric, it still does not
prove the source, which asks for arbitrary coordinate weights induced by an
adversarial marginal.

**Random or cryptographic linear codes.** These are target-hard candidates,
and hardness of decoding with preprocessing is philosophically aligned with a
fixed-marginal obstruction. But arbitrary-weight bounded-distance decoding is
already hard for generic linear codes. Adding a public trapdoor or special
decoder strong enough to satisfy the source below $\gamma$ either is not a
standard concept-class learner, because the learner does not know a
per-target secret, or risks giving an algorithmic foothold for the
fixed-marginal high-noise task. I do not see a standard McEliece/LPN/LWE-style
assumption that gives exactly "easy weighted decoding below $\gamma$, hard
improper prediction above $\gamma$" for one uniform public class.

**PCP and visible-handle encodings.** The existing atlas handle constructions
can give weak proper or weak marginal-nonuniform sources, but they do not
survive this improper target. If handles are visible enough to guarantee the
full distribution-free weak source on every low-OPT marginal, an improper
learner can usually sample, validate, vote, or memorize those same handles
under the fixed marginal. If the hard region is hidden enough to stop the
improper learner, an adversarial distribution supported on that region defeats
the distribution-free weak source.

### Provisional Conclusion

This branch did not resolve the edge.

The positive route still needs a fully polynomial fixed-slack forcing lemma:
from samples, a fixed-additive weak learner with sample bound $m_0$, and a
current predictor with excess more than $\varepsilon$, produce in time
$$
\operatorname{poly}(s,m_0,1/\gamma,1/\varepsilon,\log(1/\delta))
$$
a polynomial list of weak queries, one of which has
$\operatorname{OPT}<\gamma$ and yields progress. The procedure must avoid
$n^{m_0}$ clean-tuple enumeration and must work uniformly over all conditional
label rules with the same $P$.

The false route still needs a threshold-decodable code family:

1. efficient arbitrary-weight low-noise decoding below some fixed
   $\gamma>0$, enough to prove the distribution-free
   $\operatorname{OPT}+1/2-\gamma$ weak source;
2. fixed-marginal high-noise hardness above $\gamma$ against improper
   predictors, not merely against proper message recovery;
3. a public representation in which the low-noise decoder is available to the
   learner without also collapsing the high-noise hardness.

### Depth 5 Directions

1. Formalize the threshold-decodable-code assumption as a standalone lemma and
   test it against specific public code families: Hadamard/parity, Reed-Muller,
   Reed-Solomon variants, Goppa/McEliece-style codes, and LWE/LPN-derived
   codeword classes. The key yes/no question is arbitrary-weight decoding
   below a fixed radius.

2. Prove a black-box lower bound that explicitly allows $P$-dependent
   preprocessing and unlimited unlabeled samples from $P$, but requires one
   polynomial to work for all conditionals over that $P$. This would isolate
   the exact part of the obstruction not removed by marginal-nonuniformity.

3. Audit the da Cunha fixed-slack proof for a structural replacement of
   all-clean tuple enumeration: sample compression, stability of the weak
   learner, hard-core set generation, or online regret over weak-learner input
   distributions. Any replacement must have polynomial dependence on $m_0$,
   not exponent $m_0$.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac/scratchpad.md

## Depth 5 Branch A: Threshold Weighted Decoding Bottleneck

### Fresh Check

I re-read Depths 3--4 and the endpoint definitions. I also rechecked the
current public pages for the closest positive and coding routes on
2026-05-07. The boosting landscape still looks unchanged: Feldman/Ghai-style
same-marginal boosters preserve the feature marginal but keep a residual
proportional to the weak oracle's additive slack; da
Cunha--Hogsgaard--Paudice 2026 accepts fixed nontrivial slack, but the current
arXiv page still describes an algorithm polynomial in the sample size with the
other parameters fixed, and the theorem interface still has the weak sample
size/capacity parameters outside the atlas-polynomial regime:
https://arxiv.org/abs/2601.11265.

On the coding side I checked the usual suspects again. Feldman--Gopalan--Khot--
Ponnuswami frame uniform agnostic parity as Hadamard/noisy-parity decoding,
which is exactly the high-noise hardness flavor but also exactly the
low-noise weighted-decoding problem that would be needed for the source:
https://paperzz.com/doc/8297427/on-agnostic-learning-of-parities--monomials-and.
Berlekamp--McEliece--van Tilborg-style hardness with preprocessing supports
fixed-code hardness candidates, but those are source-negative unless a public
low-noise decoder is also available:
https://authors.library.caltech.edu/records/fgb06-gdy28. Reed--Solomon
soft-decision/list-decoding work, including Koetter--Vardy-style algorithms
and newer weighted-metric variants, gives positive decoding structure rather
than a hard-threshold public family:
https://www.itsoc.org/publications/papers/algebraic-soft-decision-decoding-of-reed-solomon-codes
and
https://drops.dagstuhl.de/storage/00lipics/lipics-vol362-itcs2026/html/LIPIcs.ITCS.2026.106/LIPIcs.ITCS.2026.106.html.

I did not find a current theorem that resolves the edge true, nor a standard
public-code assumption that resolves it false.

### Why The Marginal Allowance Still Does Not Start Fixed-Slack Boosting

Write the weak tolerance as
$$
\beta=1/2-\gamma,\qquad \gamma>0.
$$
The source weak learner is forced to be useful only on query distributions
whose best concept error is below $\gamma$. The target fixes an instance
marginal $P$ and permits one polynomial $p_P$, but this polynomial must work
for every conditional label rule over $P$.

The optimistic marginal-nonuniform idea is that $P$-dependent preprocessing,
perhaps using unlimited unlabeled samples, could build a polynomial menu of
same-marginal relabelings/reweightings that makes a low-$\operatorname{OPT}$
weak call appear. The problem is that the event making a query low-noise is
conditional-label information, not marginal information.

A useful diagnostic is the high-noise comparator channel
$$
Y=f(X)N,\qquad \Pr[N=-1]=\eta,\qquad \gamma<\eta<1/2,
$$
with $f\in C$ and $X\sim P$. The original distribution has
$\operatorname{OPT}_C\le \eta$, so a fixed-additive weak learner can legally be
neutral on the original data. To create a low-noise weak call by filtering on
agreement with a current predictor $h$, let
$$
r=\mathbb E_P[h(X)f(X)].
$$
On the selected event $A=\{Y=h(X)\}$, the remaining noise relative to $f$ is
$$
\Pr[Y\ne f(X)\mid A]
=
\frac{\eta(1-r)}
{(1-\eta)(1+r)+\eta(1-r)}.
$$
This falls below $\gamma$ only if
$$
r>
\frac{\eta-\gamma}{\eta+\gamma-2\eta\gamma}.
$$
Thus even this best-case observable filter needs a predictor already
correlated with the hidden comparator. If $r=0$, the selected labels still have
noise $\eta$; no fixed-slack weak call is forced.

This calculation does not prove a lower bound for every possible booster. It
does sharpen the marginal point: $P$-dependent preprocessing can learn the
geometry of $P$, but it cannot know which examples are clean for the hidden
conditional rule. Any polynomial same-marginal booster still needs either a
way to obtain initial correlation with $f$, or a way to hit hidden clean
$m_0$-tuples without enumerating $n^{m_0}$ possibilities.

### The Exact Code Witness One Would Need

The weighted decoding door can be stated cleanly. Let concepts be codewords
$c_m:X_s\to\{\pm1\}$, and let $U_s$ be the fixed hard coordinate marginal. To
prove the source from a code family, constants handle the high-$\operatorname
{OPT}$ regime: if $\operatorname{OPT}_C(D)\ge \gamma$, a constant classifier
has error at most $1/2\le \operatorname{OPT}_C(D)+1/2-\gamma$.

So the real source obligation is the following low-noise decoder.

**Arbitrary-weight fixed-radius weak decoder.** For every coordinate
distribution $P$, every label rule $Y$, and every representation size $s$, if
there is a codeword $c_m$ with weighted error
$$
\eta=\Pr_{X\sim P}[c_m(X)\ne Y]<\gamma,
$$
then a polynomial-time learner from $P$-labeled samples outputs an improper
hypothesis $h$ satisfying
$$
\operatorname{err}_P(h,Y)\le \eta+1/2-\gamma<1/2.
$$

This is stronger than ordinary unique decoding in Hamming distance. It is a
PAC/soft-decision requirement under arbitrary coordinate weights, arbitrary
puncturings, and adversarial low-noise label patterns. If the target is to fail,
the same public family must also satisfy a high-noise fixed-marginal hardness
statement: for some $\eta\in(\gamma,1/2)$ and $\varepsilon\ll1/2-\eta$, no
uniform polynomial-time improper learner from examples
$X\sim U_s$, $Y=c_m(X)N$ or from some adversarial high-noise conditional over
$U_s$, achieves error $\eta+\varepsilon$.

This pair of requirements is a sharp formulation, but it is not a standard
assumption. It asks for a public decoder that is robust to every low-noise
weighted marginal, while the same public structure remains useless for
high-noise prediction under one fixed marginal.

### Candidate Families

**Parity/Hadamard and LPN-style codes.** These are the best high-noise
candidates. Under the uniform marginal, strong agnostic prediction is the noisy
parity/Hadamard decoding problem. But the source would already require
efficient weak recovery for every weighted distribution with adversarial noise
below $\gamma$. For parities, arbitrary example weights can encode worst-case
linear-code decoding on the sampled equations. The usual clean Gaussian
elimination does not survive adversarial low noise, and LPN hardness is not
known to switch on only above $\gamma$. These families still fail the source.

**Algebraic/list-decodable codes.** Reed--Solomon, Reed--Muller, and related
codes have real public decoding structure, including soft-decision and
weighted-metric list-decoding in some regimes. That helps the source side only
if it works for the PAC arbitrary-weight condition above. When the list remains
short at the high-noise level, however, an improper learner can validate the
list or aggregate candidates under the fixed marginal, so target hardness
collapses. When parameters are chosen so the high-noise list is large or
decoding is believed hard, I do not see a proof of the arbitrary-weight
low-noise source condition.

**Random, Goppa/McEliece-style, LWE/LPN-derived codes.** These align with
fixed-code or preprocessing hardness. But a random-looking public code has no
known efficient arbitrary-weight low-noise weak decoder, so it is
source-negative. A trapdoor decoder also does not immediately fit the learning
model: if the decoder uses a secret unavailable to the learner, the source is
not proved; if the public class exposes enough trapdoor structure for every
target low-noise decode, there is no standard theorem saying high-noise
improper prediction under the fixed marginal remains hard.

**PCP and visible-handle encodings.** These can separate proper weak from
proper strong learning, but the present target is improper. Handles visible
enough to guarantee the distribution-free fixed-additive weak source are also
available for validation, voting, or memorization by an improper strong
learner. Hiding them enough to block the target tends to defeat the source on
marginals concentrated on the hidden region.

### Conditional Skeleton, Not An Atlas Resolution

There is a clean conditional false statement:

If there exists a public binary code/concept family satisfying the
arbitrary-weight fixed-radius weak decoder above for some constant
$\gamma>0$, and also satisfying high-noise fixed-marginal hardness against
improper $\eta+\varepsilon$ prediction for some $\eta>\gamma$, then this edge
is false. The source learner runs the decoder in the low-$\operatorname{OPT}$
case and a validated constant in the high-$\operatorname{OPT}$ case; the target
fails under the hard marginal $U_s$.

But this is only a restatement of the missing object. I do not know a standard
instantiation under LPN, LWE, McEliece-style assumptions, Reed--Solomon
decoding hardness, or PCP assumptions. Calling this `conditional-only` would
overstate the result, because the condition is exactly the new unproved
threshold-decodable-code primitive.

### Current Blockers

1. Marginal-nonuniformity cannot absorb the known fixed-slack booster runtime:
   $P$ may determine constants and a fixed degree, but not an exponent growing
   like $m_0(s)$ or a budgeted weak-output capacity.

2. Same-marginal observable relabeling still has a certification gap. In
   high-noise comparator distributions, producing a low-$\operatorname{OPT}$
   query seems to require prior correlation with the hidden comparator, or the
   forbidden $n^{m_0}$ search for clean weak-learner samples.

3. The false witness needs a threshold-decodable public family. Existing hard
   code families fail the arbitrary-weight low-noise source, while existing
   public decodable/list-decodable families tend to make high-noise improper
   prediction too easy or lack a fixed-marginal hardness theorem.

### Depth 6 Directions

1. Formalize the $P$-dependent preprocessing lower bound: allow unlimited
   unlabeled access to one fixed $P$ and arbitrary polynomial preprocessing,
   then prove that transcript-measurable relabeling/reweighting cannot certify
   $\operatorname{OPT}<\gamma$ in the noisy-comparator channel without an
   already correlated predictor.

2. Audit one concrete code family at a time against the arbitrary-weight
   decoder condition. For parities, reduce arbitrary-weight low-noise weak
   decoding to worst-case nearest-codeword or agnostic parity. For
   Reed--Solomon/Reed--Muller variants, determine whether available
   soft-decision list decoders either satisfy enough source and then give a
   validated high-noise learner, or fail the arbitrary-weight PAC condition.

3. Look for a semi-agnostic separation instead of a pure code threshold: a
   class with efficient distribution-free improper
   $A\operatorname{OPT}+\varepsilon$ learning for a fixed constant $A$, but
   fixed-marginal hardness for $\operatorname{OPT}+\varepsilon$ improper
   learning. Such a class would satisfy the fixed-additive source without
   needing a direct fully polynomial fixed-slack booster.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac/scratchpad.md

## Depth 6 Branch A: Reed-Solomon Near Miss

### What This Branch Tried

I pushed on the two remaining live routes from Depth 5.

The positive route would be a fully polynomial fixed-slack agnostic booster
specialized to the marginal-nonuniform target. I rechecked the current
boosting pages again. The da Cunha--Hogsgaard--Paudice ALT 2026 paper still
advertises runtime polynomial in the sample size with the other parameters
fixed, not polynomial in the weak sample/capacity parameters needed by the
atlas edge: https://arxiv.org/abs/2601.11265. The Ghai--Singh/Feldman-style
same-marginal route still needs an accuracy-sensitive correlation oracle rather
than a fixed additive oracle. I did not find a new polynomial fixed-slack
forcing lemma.

The false route would be a public threshold-decodable code family. I checked
the code side with Reed--Solomon and soft-decision decoding as the main near
miss. Guruswami--Vardy gives worst-case maximum-likelihood hardness for
Reed--Solomon codes, even with preprocessing:
https://arxiv.org/abs/cs/0405005. Koetter--Vardy and related soft-decision
work give public weighted/list-decoding structure for Reed--Solomon codes:
https://www.site.uottawa.ca/~zhcheng/RS_soft_decision.pdf. Recent
metric/list-decoding work also explicitly routes through weighted
soft-decision Reed--Solomon decoders:
https://drops.dagstuhl.de/storage/00lipics/lipics-vol362-itcs2026/html/LIPIcs.ITCS.2026.106/LIPIcs.ITCS.2026.106.html.

This is the closest I have seen to the desired shape, but it still does not
resolve the binary PAC edge.

### Fixed-Slack Boosting Still Needs A Low-OPT Forcing Lemma

Keep the notation
$$
\beta=1/2-\gamma,\qquad \gamma>0.
$$
The source weak learner is forced to return useful signal only on weak-call
distributions $Q$ with
$$
\operatorname{OPT}_{\mathcal C}(Q)<\gamma.
$$
For $\operatorname{OPT}_{\mathcal C}(Q)\ge\gamma$, a neutral answer is
consistent with the source.

The marginal-nonuniform allowance lets the final runtime depend on the feature
marginal $P$, but the learner and its polynomial must work for every
conditional label rule over that $P$. Thus any same-marginal positive proof
needs an observable procedure which, from the sample transcript and previous
weak answers, manufactures a weak-call distribution with
$\operatorname{OPT}<\gamma$ whenever the current predictor has excess
$>\varepsilon$.

I do not see such a procedure. Relabeling by residuals gives correlations at
the current excess scale, and the fixed additive oracle can hide all
correlations below $2\beta$. Filtering on agreement with a current predictor
helps only after the predictor already correlates with the hidden comparator,
as in the Depth 5 calculation. Distribution-specific covers or ERM menus have
degree growing with the effective dimension or weak sample bound, which a
single $p_P(s,1/\varepsilon,\log(1/\delta))$ cannot absorb.

So the positive route is reduced to a precise missing lemma: a polynomial-time
same-marginal low-$\operatorname{OPT}$ forcing step with polynomial dependence
on $m_0$, not $n^{m_0}$. I found no current theorem giving it.

### Exact Threshold-Code Primitive

The code witness can now be stated without slack in the formulation. Let
$\mathcal C_s=\{c_m:X_s\to\{\pm1\}\}$ be a public binary code/concept family
and let $U_s$ be the fixed hard coordinate marginal. A false witness would need
a constant $\gamma>0$ and a polynomial-time learner with the following
property.

**Arbitrary-weight threshold decoder.** For every distribution $P$ over $X_s$
and every binary label rule $Y$, if
$$
\eta=\inf_m \Pr_{X\sim P}[c_m(X)\ne Y]<\gamma,
$$
then the learner outputs an improper hypothesis $h$ with
$$
\Pr[h(X)\ne Y]\le \eta+1/2-\gamma<1/2.
$$

Given this decoder, the weak source follows by validation: run the decoder and
also test the two constants. If $\operatorname{OPT}<\gamma$, the decoder gives
the required $\operatorname{OPT}+1/2-\gamma$ guarantee; if
$\operatorname{OPT}\ge\gamma$, the better constant has error at most
$1/2\le\operatorname{OPT}+1/2-\gamma$.

The target failure would then need a fixed-marginal hardness statement: for
some $\eta\in(\gamma,1/2)$ and some fixed $\varepsilon>0$, no uniform
polynomial-time improper learner given samples from $U_s$ with labels generated
by a high-noise channel around $c_m$, or by a hard adversarial conditional at
distance $\eta$ from $\mathcal C_s$, achieves error $\eta+\varepsilon$.

This primitive is not ruled out by the black-box boosting barrier. The
low-noise decoder says nothing directly about the high-noise distribution, and
without a correlated predictor or clean tuple search there is no generic way
to turn high-noise samples into a low-noise weak call.

### Why Reed--Solomon Does Not Yet Instantiate It

Reed--Solomon codes are the best near miss because the two halves exist in
nearby but incompatible forms.

On the source side, public bounded-distance and soft-decision decoders provide
real weighted decoding structure. For $q$-ary symbols, Berlekamp--Welch,
Guruswami--Sudan, Koetter--Vardy, and GMD-style methods are the right tools to
audit.

On the target-hard side, Guruswami--Vardy shows worst-case
maximum-likelihood decoding hardness for Reed--Solomon codes, even allowing
preprocessing. That is philosophically close to "fixed marginal with hard
decoding above the public radius."

The mismatches are still substantial.

First, the atlas class is binary. Passing from $q$-ary symbols to binary
classification by concatenating with an inner code changes the source
condition. The PAC marginal can put arbitrary weights on individual bit
coordinates, not just on whole symbols with a clean reliability vector. Existing
soft-decision guarantees are score/cost or channel-model guarantees; they do
not immediately imply that every binary bit-weighted labeling within weighted
error $<\gamma$ is weakly decodable.

Second, the known hardness is worst-case decoding, not fixed-marginal PAC
hardness against improper predictors from random coordinate samples. A PAC
learner is allowed to output any predictor, not a codeword or message. If a
public list decoder at the high-noise radius returns a polynomial list of
global candidates, validation against fresh noisy samples collapses the target
hardness. Therefore a Reed--Solomon witness would need the hard radius to sit
beyond every available polynomial-list/soft-decision regime, while the same
binary family remains arbitrary-weight weak-decodable below $\gamma$.

Third, average-case hardness is missing. A deterministic hard received word is
not automatically a PAC lower bound under sample access, and random-noise
hardness above the public threshold is not known for the Reed--Solomon variants
in the binary improper-learning form needed here.

Thus Reed--Solomon gives a concrete depth-7 audit target, not a resolution.
Parities/Hadamard remain source-negative under low-noise LPN-style hardness;
random or McEliece/Goppa-style public codes remain source-negative without a
public arbitrary-weight decoder; visible-handle/PCP encodings remain
target-positive once the final learner is improper.

### Semi-Agnostic Detour

Depth 5 suggested a semi-agnostic separation. The exact inequality is useful.
If a class has an efficient distribution-free improper learner with
$$
\operatorname{err}(h)\le A\operatorname{OPT}_{\mathcal C}+\varepsilon
$$
for a fixed $A$, then constants plus validation imply the source whenever
$$
(A-1)\gamma\le 1/2-\gamma,
\qquad\text{equivalently}\qquad
A\le \frac{1}{2\gamma}.
$$
So a class with efficient constant-factor agnostic learning but fixed-marginal
hardness for exact $\operatorname{OPT}+\varepsilon$ learning would also
separate this edge.

I do not know such a class. Recent small-error agnostic results with constants
above 1 are statistical or ERM-based routes, not evidence that a source-positive
computational class can fail the marginal-nonuniform exact target. This detour
is worth keeping because it avoids the sharp public-code threshold, but it is
not presently an atlas witness.

### Depth 7 Directions

1. Do a binary concatenated Reed--Solomon audit. Define
   $X_s=[n]\times[L]$ with an explicit inner binary code for each
   Reed--Solomon symbol. Prove or refute the arbitrary bit-weighted threshold
   decoder: for every distribution over bit coordinates and every labeling at
   weighted distance $<\gamma$, can known soft-decision machinery output an
   improper weak predictor? Then check whether the same machinery gives a
   polynomial-list validated learner at the proposed high-noise radius.

2. Prove the black-box marginal lower bound cleanly. The model should allow
   unlimited unlabeled access to one fixed $P$, arbitrary $P$-dependent
   preprocessing, and adaptive same-marginal weak calls. Show that, for the
   noisy comparator channel $Y=f(X)N$ with $\eta>\gamma$, transcript-measurable
   calls cannot force $\operatorname{OPT}<\gamma$ with polynomially many
   queries unless they first acquire correlation with $f$ or hit an
   $m_0$-tuple clean event.

3. Search specifically for a semi-agnostic witness. The target statement is:
   efficient distribution-free improper $A\operatorname{OPT}+\varepsilon$
   learning for some $A\le 1/(2\gamma)$, but hardness of
   $\operatorname{OPT}+\varepsilon$ improper learning under one fixed marginal.
   This may be easier to instantiate than the full threshold-decodable-code
   primitive.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac/scratchpad.md

## Depth 7 Branch A: Final Consolidation

### Final Attempt

I do not see an atlas-valid resolution of the edge.

The source is a distribution-free improper weak agnostic learner with fixed
additive tolerance
$$
\operatorname{err}(h)\le \operatorname{OPT}_{\mathcal C}+\beta,
\qquad \beta<1/2.
$$
Writing $\gamma=1/2-\beta$, the guarantee is forced to give a nontrivial
predictor only on weak-call distributions with
$$
\operatorname{OPT}_{\mathcal C}<\gamma.
$$
In correlation notation this is the fixed-slack oracle
$$
\operatorname{corr}(h,Y)\ge
\sup_{c\in\mathcal C}\operatorname{corr}(c,Y)-2\beta.
$$
This is strong enough to be a real weak oracle, but it is not an
accuracy-scale correlation oracle. Any generic lower envelope after validation
and sign flipping is only
$$
\operatorname{corr}(h,Y)\ge \max\{0,\rho-2\beta\},
$$
where $\rho$ is the best concept correlation on the query distribution. Thus
Feldman/Ghai-style same-marginal boosting inherits a residual of order
$\beta$, because any inequality of the form
$\operatorname{corr}(h,Y)\ge a\rho-\tau$ has $\tau/a\ge 2\beta$.

The marginal-nonuniform target fixes an instance marginal $P$ and allows a
polynomial $p_P(s,1/\varepsilon,\log(1/\delta))$. This helps only with
bookkeeping over the visible marginal. The polynomial may depend on $P$, but
it must work for every conditional label rule over $P$ and its degree cannot
grow with the represented concept size, the weak learner's sample bound
$m_0(s)$, or a hidden comparator. Therefore it cannot absorb the known
fixed-slack runtime terms such as
$$
O(n^{m_0+3})
\qquad\text{or}\qquad
\operatorname{Eval}_H(1)\,
n^{O(m_0\min\{d^*,\log n\}/\theta^2)}
$$
from the da Cunha--Hogsgaard--Paudice route when $m_0$ or $d^*$ grows with
$s$.

The clean-tuple obstruction also survives the marginal relaxation. In a
high-noise comparator channel $Y=f(X)N$ with
$\gamma<\eta=\Pr[N=-1]<1/2$, the original distribution can have
$\operatorname{OPT}_{\mathcal C}=\eta$, so the source may answer neutrally.
Useful weak calls arise only after exposing low-noise structure depending on
the hidden comparator and noise realization. If a weak learner needs an
$m_0$-sample from a hidden clean set $G$ of density $p$, a polynomial
same-marginal menu of $q$ candidate tuples hits a random $G$ with probability
at most about $q p^{m_0}$. Since $G$ is conditional-label information, not
marginal information, $P$-dependent preprocessing cannot choose a different
exponent or menu for each $G$. This is a black-box barrier for known
fixed-slack strategies, not a separation theorem for represented classes.

### Last False-Witness Audit

The cleanest false witness would be a public binary code/concept family
$\mathcal C_s=\{c_m:X_s\to\{\pm1\}\}$ with two properties.

First, for some constant $\gamma>0$, it would have an arbitrary-weight
threshold decoder: for every distribution $P$ over coordinates and every label
rule $Y$, if
$$
\eta=\inf_m \Pr_{X\sim P}[c_m(X)\ne Y]<\gamma,
$$
then a polynomial-time learner outputs a deterministic improper hypothesis
$h$ with
$$
\Pr[h(X)\ne Y]\le \eta+1/2-\gamma<1/2.
$$
Together with empirical validation against the two constants, this proves the
source: when $\operatorname{OPT}<\gamma$ use the decoder, and when
$\operatorname{OPT}\ge\gamma$ a better constant has error at most
$1/2\le \operatorname{OPT}+1/2-\gamma$.

Second, for the fixed hard marginal $U_s$, the same family would need
high-noise hardness against deterministic improper prediction: for some
$\eta\in(\gamma,1/2)$ and fixed $\varepsilon>0$, no uniform polynomial-time
learner given samples from $X\sim U_s$ and labels at distance $\eta$ from a
codeword achieves error $\eta+\varepsilon$.

This primitive would resolve the edge false, but it is exactly the missing
object rather than an available atlas witness. Reed--Solomon remains the best
near miss. It has public bounded-distance, soft-decision, and list-decoding
machinery, while Guruswami--Vardy-style results give worst-case
maximum-likelihood hardness with preprocessing. The pieces still do not line
up for this binary PAC implication:

1. The atlas class is binary; concatenating $q$-ary Reed--Solomon symbols with
   an inner binary code lets the PAC marginal put arbitrary weights on
   individual bits, not just clean symbol reliabilities.
2. The known hard side is worst-case decoding, not average-case sample-access
   hardness under one fixed marginal against improper predictors.
3. If a polynomial list or soft-decision decoder works at the proposed
   high-noise radius, an improper learner can validate the list on fresh
   samples and the target becomes true rather than hard.

Parity/Hadamard and LPN-style families have the high-noise flavor but are
source-negative because low-noise arbitrary-weight agnostic parity is already
hard. Random, Goppa/McEliece-style, LWE-derived, or generic linear codes are
also source-negative without a public arbitrary-weight low-noise decoder.
Visible-handle and PCP-style constructions tend to become target-positive for
improper learners, since the same handles that certify weak learning can be
validated, voted, or memorized by a strong deterministic improper hypothesis.

The semi-agnostic detour also remains a template, not a witness. If a class had
an efficient distribution-free improper learner with
$$
\operatorname{err}(h)\le A\operatorname{OPT}_{\mathcal C}+\varepsilon
$$
and $A\le 1/(2\gamma)$, then constants plus validation would imply the
fixed-additive weak source with tolerance $1/2-\gamma$. A fixed-marginal
hardness result for exact $\operatorname{OPT}+\varepsilon$ learning of the same
class would separate the edge. I do not know such a computational class.

### Conditional True Principles

The edge would be true under any one of the following strengthened principles.
None is currently supplied by the atlas source alone.

1. **Fully polynomial fixed-slack agnostic boosting.** Given a distribution-free
   $\operatorname{OPT}+1/2-\gamma$ improper weak learner with sample bound
   $m_0$, there is a strong agnostic improper learner with runtime polynomial
   in $s,m_0,1/\gamma,1/\varepsilon,\log(1/\delta)$ and any relevant capacity
   parameters, with no $m_0$ or capacity term in an exponent. This would
   actually resolve the distribution-free strong agnostic sibling as well.

2. **Same-marginal low-OPT forcing.** For every fixed marginal $P$, whenever a
   current predictor has excess more than $\varepsilon$, there is an observable
   polynomial-time procedure using samples, previous weak answers, and
   $P$-dependent preprocessing that produces a polynomial list of same-marginal
   weak-call distributions, one of which has
   $\operatorname{OPT}_{\mathcal C}<\gamma$ and yields progress. The procedure
   must work uniformly over all conditional label rules over $P$ and avoid the
   $n^{m_0}$ clean-tuple search.

3. **Bounded-parameter fixed-slack regime.** For subclasses where the da Cunha
   weak-sample, dual-VC/base-capacity, and fixed-gap parameters are bounded
   independently of representation size, the existing fixed-slack theorem
   gives the right qualitative conclusion. That is a conditional subclass
   statement, not the present atlas implication.

All positive principles here output deterministic improper hypotheses. The
learning algorithm may use random samples and validation internally, but the
delivered PAC hypothesis is a single deterministic function not required to
belong to $\mathcal C$.

### Proposed Atlas Summary

`Open: a distribution-free fixed-additive weak agnostic improper learner gives a fixed-slack oracle, but known same-marginal boosters need accuracy-scale slack and known fixed-slack boosters put weak-sample or capacity parameters in representation-dependent exponents; no source-positive deterministic-improper separation is known.`

### Proposed Proof-Status Body

**Goal.** Decide whether a distribution-free fixed-additive weak agnostic
improper learner implies strong agnostic improper learning with
marginal-dependent polynomial resources.

**Fixed-additive slack barrier.** Let the source tolerance be
$\beta=1/2-\gamma$. The weak learner is forced to provide signal only on query
distributions with $\operatorname{OPT}_{\mathcal C}<\gamma$. In correlation
form it gives $\rho-2\beta$, not a tunable residual-scale oracle. Consequently
Feldman/Ghai-style same-marginal agnostic boosters preserve the right marginal
but do not drive excess error below the fixed slack floor.

**Marginal-nonuniform bookkeeping.** The target allows a polynomial $p_P$ for
each marginal $P$, but this one polynomial must work for all conditional label
rules over $P$. It cannot depend on the hidden comparator or have degree
growing with the weak sample bound, representation-dependent capacity, or
other parameters that vary with $s$.

**Known fixed-slack near positive.** Da Cunha--Hogsgaard--Paudice accepts the
source as a fixed-slack weak oracle, but the available construction pays
$n^{m_0}$-type or capacity-in-the-exponent costs. The apparent reason is a
clean-tuple search for comparator-dependent low-noise structure. Since that
structure is conditional-label information inside a fixed marginal, the
marginal-nonuniform allowance does not remove the search.

**No atlas-valid separation.** A false witness would need a class that is
distribution-free $\operatorname{OPT}+\beta$ weakly learnable by deterministic
improper hypotheses on every marginal, while exact
$\operatorname{OPT}+\varepsilon$ deterministic improper learning is hard under
one fixed marginal. The sharp code template requires arbitrary-weight
low-noise threshold decoding below $\gamma$ and high-noise fixed-marginal
improper hardness above $\gamma$. Reed--Solomon soft-decision decoding is a
near miss, but the binary arbitrary-bit-weight source condition, average-case
PAC hardness, and improper-list-validation issues are not resolved by known
theorems.

**Conclusion.** Keep the edge open. A fully polynomial fixed-slack agnostic
booster or same-marginal low-OPT forcing lemma would resolve it true. A public
threshold-decodable code family, or a semi-agnostic class with exact
fixed-marginal hardness, would resolve it false. Neither is currently known.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac/scratchpad.md

