## Depth 1 Branch A: Fixed-Slack Boosting Near Miss

Scratchpad path:
`scratchpads/open-edge-resolution-2026-05-07/efficient-weak-agnostic-improper-pac--implies--efficient-agnostic-improper-pac/scratchpad.md`

### Setup Read First

I first read the current edge note
`atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-agnostic-improper-pac.md`.
It records the edge as `status: "open"` with the family
`agnostic-boosting-open`. I also read the two endpoint definitions,
`atlas/arguments/agnostic-boosting-open.md`, the relevant entries in
`references.bib`, the same-edge May 4 and May 5 scratchpads, and nearby
weak-to-strong notes. I did not edit any atlas file or `references.bib`.

The source is a distribution-free efficient weak agnostic improper learner:
for one fixed additive tolerance
$$
\beta = 1/2-\gamma < 1/2,
$$
or with $\gamma$ treated as an inverse-polynomial weak advantage parameter, the
learner returns an efficiently evaluable improper hypothesis $h$ satisfying
$$
\operatorname{err}_D(h)
\le
\operatorname{OPT}_C(D)+\beta
$$
for every labeled distribution $D$. The target asks for an efficient improper
agnostic learner with excess $\varepsilon$ for every requested $\varepsilon>0$.

I also checked current primary pages for the recent boosting references. The
arXiv page for da Cunha--Hogsgaard--Paudice 2026 says the paper was last revised
on 2026-02-03 and that the algorithm is polynomial in the sample size with the
other parameters fixed. A fresh search did not turn up a newer primary-source
theorem removing that qualifier.

### What The Source Gives In Correlation Form

Use labels in $\{-1,1\}$. For a labeled distribution $D$, write
$$
\rho_C(D)=\sup_{c\in C}\mathbb E_D[Yc(X)].
$$
Since $\operatorname{err}(h)=(1-\operatorname{corr}(h,Y))/2$, the source gives
$$
\operatorname{corr}_D(h,Y)
\ge
\rho_C(D)-2\beta.
$$
Together with the trivial lower bound $\operatorname{corr}\ge -1$, this implies
$$
\operatorname{corr}_D(h,Y)
\ge
\max\{-1,\rho_C(D)-2\beta\}.
$$

Thus the source is not vacuous. It gives a fixed nontrivial correlation oracle
of the kind used in the recent fixed-slack agnostic boosting literature. For
example, for any
$$
\gamma_0\in\left(\frac{1}{2(1-\beta)},1\right),
$$
the choice
$$
\varepsilon_0=1-\gamma_0(1-2\beta)
$$
satisfies $\gamma_0>\varepsilon_0$, and
$$
\max\{-1,\rho-2\beta\}\ge \gamma_0\rho-\varepsilon_0
$$
for every $\rho\in[-1,1]$.

This is the strongest positive evidence. Any theorem that accepts only fixed
constants $\gamma_0>\varepsilon_0$ and has fully polynomial overhead in the
weak learner's sample/runtime parameters would resolve the edge as true.

### Why Known Boosters Still Do Not Prove The Edge

The older fixed-additive agnostic boosters of Ben-David--Long--Mansour and
Gavinsky are well matched to the atlas source, but their final guarantee is not
$\operatorname{OPT}_C+\varepsilon$. Gavinsky's result improves the smooth
boosting behavior and is essentially optimal for that older model, but it still
leaves an $\operatorname{OPT}$-dependent multiplicative loss rather than
arbitrary excess error.

The Feldman / Kalai--Kanade / Ghai--Singh route has the right computational
shape. These boosters use observable reweighting or relabeling, and Feldman's
distribution-specific version is especially clean because it can preserve the
feature marginal. The catch is the weak-interface scale. These theorems need a
threshold or correlation oracle whose slack can be made small at the final
accuracy scale, such as $\varepsilon_0=O(\gamma\varepsilon)$ or a weak learner
available for every small threshold $\alpha$. The atlas source supplies only
one fixed additive floor. On query distributions with
$$
\operatorname{OPT}_C(Q)\ge \gamma=1/2-\beta,
$$
an error-$1/2$ response is legal, so the weak learner may be completely
progress-neutral. Near the strong optimum, observable residual correlations can
be only $O(\varepsilon)$, exactly where a fixed-slack oracle need not reveal
anything.

The da Cunha--Hogsgaard--Paudice line is the closest positive route. The 2025
and 2026 papers accept nontrivial fixed correlation parameters and remove the
residual weak-slack term statistically. However, the 2026 running time still
contains weak-learner/sample and capacity parameters in the exponent. The
earlier scratchpads record the relevant displayed bounds: the algorithm makes
about
$$
O(n^{m_0+3})
$$
weak-learner calls and has a total running-time term of the form
$$
\operatorname{Eval}_H(1)\cdot
n^{O(m_0\min\{d^*,\ln n\}/\theta^2)}.
$$
Here $m_0$ is the sample requirement of the weak learner and
$\theta=(\gamma_0-\varepsilon_0)/2$. In the atlas edge, $m_0$ can be polynomial
in the concept representation size and in the inverse weak advantage. Then
$n^{m_0}$ is not polynomial in the representation size or in $1/\varepsilon$.
So da Cunha 2026 gives a statistical or fixed-parameter positive theorem, but
not the representation-uniform efficient PAC implication.

### Low-Noise Password Obstruction

The clean reason the fixed-slack problem is hard is the weak threshold
$\gamma=1/2-\beta$. Suppose labels come from a hidden near-optimal comparator
$f\in C$ with independent corruption rate
$$
\eta\in(\gamma,1/2).
$$
The original distribution has $\operatorname{OPT}_C(D)=\eta$, so the source
learner is allowed to return a useless error-$1/2$ classifier on $D$. A strong
agnostic learner with $\varepsilon\ll 1/2-\eta$ still has to recover information
about $f$ well enough to approach error $\eta$.

Where is the weak signal? It appears on comparator-dependent low-noise or clean
subproblems, for example the set of examples on which $f(x)=y$. On such a
distribution the optimum drops below $\gamma$, so every valid fixed-additive
weak response has a real edge. But this set is hidden because it depends on the
unknown comparator.

If the weak learner needs $m_0$ examples, a random observable attempt to feed it
a low-noise $m_0$-sample from the noisy distribution succeeds only with a
large-deviation probability such as
$$
\Pr[\operatorname{Bin}(m_0,\eta)\le \gamma m_0]
\le
\exp(-m_0 D_{\mathrm{KL}}(\gamma\|\eta)).
$$
For $m_0=\operatorname{poly}(s)$, polynomially many random attempts need not
hit such a password. The da Cunha enumeration over all $m_0$-tuples is precisely
the brute-force way to ensure that the hidden low-noise witnesses are in the
menu. I do not see a known polynomial replacement for this enumeration.

This is an obstruction, not a separation. The atlas target learner is not
required to use the weak learner as a black box; it can exploit the
representation of $C$ directly. A false edge would require an actual class that
is efficiently $\operatorname{OPT}+\beta$ agnostically learnable for every
labeled distribution, while $\operatorname{OPT}+\varepsilon$ improper learning
is computationally hard.

### Separation Search

I do not have such a witness.

Halfspaces are not a witness: the atlas already records that lattice-based
hardness rules out even weak agnostic improper learning in the relevant
distribution-free sense, so they fail the source rather than separating source
from target.

Cryptographic hidden-function templates also miss the source. If the hidden
region is hard enough to block strong improper agnostic learning, then on
realizable or low-noise labels over that region, even weak prediction would
usually distinguish the hidden function. Distribution-free quantification lets
the adversary put all mass on the hard region, so public handles do not rescue
the weak source.

CSP/PTAS-hardness templates remain tempting but do not immediately survive the
learning translation. Constant-additive approximation can be easy for positive
Max-CSP instances, but agnostic learning sees signed labels. Negative labels
turn predicates into complements, constant predictors can solve degenerate
signed distributions, and an improper learner may memorize small visible
supports. I did not find a signed-CSP construction that gives a uniform
$\operatorname{OPT}+\beta$ learner for all labeled distributions while keeping
arbitrary excess-error improper learning hard.

### Conclusion For Atlas Purposes

This branch does not resolve the edge. The current atlas classification should
stay open.

The best positive statement I can justify is conditional/fixed-parameter: if the
weak learner's sample parameter $m_0$, the relevant base-hypothesis capacity
parameter $d^*$, and the weak nontriviality gap $\theta$ are treated as fixed or
otherwise enter only polynomially, then da Cunha--Hogsgaard--Paudice gives the
right residual-free boosting behavior. That is not the atlas computational
claim, where these parameters may scale with the representation.

The best negative evidence is a black-box low-noise-password barrier: fixed
additive weak learning only forces signal on low-OPT queries, while strong
agnostic learning must handle noisy distributions whose optimum can be above
that fixed threshold. Known observable polynomial boosters solve this by
assuming tunable slack; known fixed-slack boosters solve it by enumerating
hidden low-noise weak inputs.

### Depth 2 Directions

1. Prove or refute a fully polynomial clean-subset hitting lemma. The direct
   target is to replace da Cunha's $n^{m_0}$ tuple enumeration by a list of size
   $\operatorname{poly}(n,m_0,d^*,1/\theta)$ that still hits every hidden
   comparator-dependent low-OPT query needed by the proof.

2. Formalize the low-noise-password barrier as a black-box oracle lower bound.
   The oracle should be a valid fixed-additive weak agnostic learner that
   returns progress-neutral hypotheses on all high-OPT observable queries, and
   the lower bound should show that polynomially many queries miss the hidden
   low-OPT witnesses.

3. Split the positive theory into a strengthened atlas node with tunable
   threshold/correlation slack. Feldman, Kalai--Kanade, and Ghai--Singh appear
   to give polynomial implications for that stronger interface; this would
   separate the known positive theorem from the unresolved fixed-additive edge.

VERDICT: unresolved

## Depth 2 Branch A: No Polynomial Clean-Tuple Hitter

### Primary-Source Refresh

I rechecked the current primary pages and source text for the closest boosting
results. The relevant facts have not changed since Depth 1.

- da Cunha--Hogsgaard--Paudice, `arXiv:2601.11265`, v3 last revised
  2026-02-03, is still the closest fixed-additive theorem:
  https://arxiv.org/abs/2601.11265.
- Ghai--Singh 2025, PMLR 267, remains the clean efficient/unlabeled-data
  theorem, but its weak-oracle slack contributes a residual term:
  https://proceedings.mlr.press/v267/ghai25a.html.
- Feldman 2010 remains the clean distribution-specific label-relabeling
  route, but in the same accuracy-sensitive weak-oracle family:
  https://arxiv.org/abs/0909.2927.
- A targeted search on 2026-05-07 did not find a newer primary source proving
  fully polynomial agnostic boosting from a fixed-additive
  $\operatorname{OPT}+\beta$ weak learner.

### Feldman/Ghai Slack Cannot Be Tuned Away

The source weak learner gives, in $\{\pm 1\}$ notation,
$$
\operatorname{corr}(W,Y)\ge \rho-2\beta,
\qquad
\rho=\sup_{c\in C}\operatorname{corr}(c,Y).
$$
Since the final learner is improper, we can wrap any weak output by validation
and flipping its sign, so the best black-box guarantee one should credit the
source with is at most
$$
\operatorname{corr}\ge \max\{0,\rho-2\beta\}.
$$

Now ask whether this can instantiate a Kalai--Kanade/Feldman/Ghai-style
correlation oracle
$$
\operatorname{corr}\ge a\rho-\tau
$$
with a final residual $\tau/a$ that can be made $O(\varepsilon)$. It cannot.
For every $a\in(0,1]$, validity for all $\rho\in[0,1]$ forces
$$
\tau\ge a\rho \quad\text{at}\quad \rho=2\beta,
$$
using the flat part of $\max\{0,\rho-2\beta\}$. Hence
$$
\frac{\tau}{a}\ge 2\beta.
$$
Choosing a smaller multiplicative advantage $a$ only shrinks $\tau$ and $a$
together; the residual ratio stays constant. Thus the efficient
Feldman/Ghai-style theorems cannot be rescued by a clever parameter choice
from the atlas fixed-additive source. They prove a strengthened edge with
tunable correlation slack, not this edge.

This is a real semantic mismatch, not merely a proof-style mismatch. When the
booster's residual task has best concept correlation $\rho<2\beta$, the source
learner may legally provide no progress even though a strong agnostic learner
with target excess $\varepsilon\ll\rho$ still needs to recover that small
positive correlation.

### da Cunha Fits Semantically But Not Polynomially

The da Cunha--Hogsgaard--Paudice definition is the right one for this source.
Their weak learner condition is
$$
\operatorname{corr}(W,Y)
\ge
\gamma_0\sup_{f\in F}\operatorname{corr}(f,Y)-\varepsilon_0,
$$
with only $\gamma_0>\varepsilon_0$. The atlas source instantiates it with
$$
\gamma_0=1,\qquad \varepsilon_0=2\beta,\qquad
\theta=(\gamma_0-\varepsilon_0)/2=1/2-\beta.
$$
So the fixed-additive weak learner is not too weak for their theorem.

The obstruction is exactly the running time. The theorem's formal statement
uses a weak sample parameter $m_0$, VC dimension $d$ of the base class, dual VC
dimension $d^*$, and
$$
T=\left\lceil
\min\left\{\frac{\log n}{\theta^2},
260^2\frac{4d^*+2}{\theta^2}
\right\}
\right\rceil .
$$
It invokes the weak learner at most
$$
O(n^{m_0+3})
$$
times and has running time
$$
\operatorname{Eval}_H(1)\cdot
n^{O(m_0\min\{d^*,\log n\}/\theta^2)}.
$$
For this atlas edge, $m_0$ and $1/\theta$ may be polynomial in the
representation size. Substitution gives $n^{\operatorname{poly}(s)}$, not
$\operatorname{poly}(s,1/\varepsilon,\log(1/\delta))$.

### Why A Generic Polynomial Tuple Menu Cannot Work

The most tempting Depth 2 positive move was to replace the $n^{m_0}$
enumeration by a polynomial-size menu of candidate weak-learner training
tuples. A simple hitting argument rules out that replacement in the generic
hidden-clean-set form used by the da Cunha proof.

Fix a final sample $S$ of size $n$. Let $G\subseteq S$ be the hidden set of
examples on which an unknown comparator $f$ agrees with the observed labels.
In the low-noise-password regime, $|G|\approx pn$ for some constant
$p=1-\eta<1$, while the weak learner needs an $m_0$-tuple drawn entirely from
$G$ to be forced into a realizable/low-OPT response. Suppose an observable
replacement prepares a list $L$ of $q$ ordered $m_0$-tuples before knowing
$G$.

For a uniformly random $G$ of density $p$,
$$
\Pr[T\subseteq G]\approx p^{m_0}
$$
for each fixed tuple $T$. By a union bound,
$$
\Pr[\exists T\in L:T\subseteq G]\le q p^{m_0}.
$$
Therefore, if $q\ll p^{-m_0}$, some clean set $G$ of density $p$ is missed by
the whole list. In particular, no universal comparator-independent menu of
size $\operatorname{poly}(n,m_0,1/\theta)$ can hit every hidden clean set when
$m_0$ grows polynomially with the representation size.

This does not prove the edge false. It only rules out the most literal
polynomial replacement for da Cunha's enumeration. A successful positive proof
would need to avoid the hidden-clean-tuple requirement, exploit additional
structure of the weak learner or class, or obtain progress from noisy
observable distributions directly.

### Counterexample Search Still Fails At The Source

The natural false route is a class that is easy below the weak threshold but
hard at high agnostic noise. Code and parity examples are the cleanest mental
model: unique decoding at very small error might give the source, while
high-noise decoding would be target-hard.

I do not have a concrete class with the required distribution-free source.
Parities/LPN give the desired high-noise hardness flavor, but the source would
also need a polynomial weak agnostic learner for every arbitrary distribution
with $\operatorname{OPT}<\gamma$. That is a weighted adversarial-noise
Max-Lin/nearest-codeword problem, not the easy realizable Gaussian-elimination
case. Standard CSP approximation examples also do not survive the improper
target: if examples are constraints with all-positive labels, the constant
positive hypothesis is already a perfect improper learner; if labels are
signed to prevent this, the weak source becomes the hard part.

Cryptographic hidden-function templates still have the same defect as in
Depth 1. Any distribution-free weak source must handle realizable or very
low-noise distributions supported entirely on the hidden hard region. If that
is possible, the usual pseudorandomness-based strong hardness tends to break;
if it is not possible, the class fails the source.

### Current Obstacles

1. Accuracy-sensitive correlation boosters cannot use the atlas source with
   arbitrary final accuracy. The residual ratio inherited from
   $\operatorname{OPT}+\beta$ is bounded below by a constant.

2. The only checked residual-free fixed-additive booster is fixed-parameter,
   not atlas-polynomial, because it enumerates $m_0$-tuples and searches over
   bounded votes.

3. A polynomial-size generic clean-tuple hitting menu is combinatorially
   impossible for hidden clean sets of constant density when $m_0$ grows.

4. No concrete source-true/target-false class is known. The plausible high-noise
   hard families fail to establish the distribution-free low-OPT weak source.

### Depth 3 Directions

1. Formalize the tuple-menu counting argument as a black-box lower bound. The
   oracle should answer neutrally unless queried on an all-clean $m_0$-tuple,
   while still satisfying the fixed-additive weak guarantee on the intended
   low-OPT query distributions. This would not refute the atlas edge, but it
   would isolate exactly what any positive proof must avoid.

2. Search for a code-based witness with two algorithms/properties: efficient
   distribution-free weak recovery from every weighted corruption pattern of
   rate $<\gamma$, and cryptographic or complexity-theoretic hardness of
   achieving $\operatorname{OPT}+\varepsilon$ at constant noise. Parity/LPN is
   the template, but the low-OPT distribution-free weak source is currently
   the missing piece.

3. Look for a genuinely noisy fixed-slack booster that never tries to hit the
   unknown clean set. The target theorem would call the weak learner only on
   observable reweighted/relabelled distributions and have runtime polynomial
   in $m_0$, $1/\theta$, VC parameters, and $1/\varepsilon$, with no such
   parameter in an exponent.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-weak-agnostic-improper-pac--implies--efficient-agnostic-improper-pac/scratchpad.md


## Depth 3 Branch A: Black-Box Barrier, No Separation

### Recheck Scope

I read the Depth 1 and Depth 2 entries above, the May 4 and May 5 same-edge
scratchpads, the sibling marginal-nonuniform scratchpads, the local
`agnostic-boosting-open` note, and the endpoint definitions. I also refreshed
the primary pages for the closest positive routes:

- Kalai--Mansour--Verbin 2008 and Feldman 2010 for threshold
  $(\alpha,\gamma)$ agnostic boosting.
- Ghai--Singh 2024/2025 for efficient correlation-oracle boosting with
  residual weak-slack terms.
- da Cunha--Hogsgaard--Paudice 2026, `arXiv:2601.11265`, whose current v3
  page still describes runtime as polynomial in the sample size when the other
  parameters are fixed.

I did not find a newer primary-source theorem giving a representation-uniform
polynomial fixed-additive agnostic booster.

### The Clean-Tuple Barrier Can Be Made Black-Box

Depth 2's counting argument is sound as a barrier to the most literal repair of
da Cunha's enumeration. Let $S$ be an observed sample of size $n$, and let
$G\subseteq S$ be the hidden clean set for a near-best comparator $f$, with
density $p=|G|/n$ bounded away from zero. If the fixed-slack proof needs one
weak-learner training tuple $T\in G^{m_0}$, then any comparator-independent
menu $L$ of $q$ ordered $m_0$-tuples hits a uniformly random $G$ with
probability at most about
$$
q p^{m_0}.
$$
For $m_0=\operatorname{poly}(s)$, a polynomial-size menu misses some possible
clean set. This explains the $n^{m_0}$ term in the known residual-free
fixed-slack booster.

This can be formalized as a black-box weak-oracle lower bound. Define an
oracle that returns a progress-neutral hypothesis on every high-OPT observable
query and returns a useful hypothesis only when its training transcript
contains an all-clean $m_0$-tuple for the hidden $G$. Any booster making
$\operatorname{poly}(n,m_0)$ such calls misses the useful event for some $G$,
so its transcript is compatible with many different hidden comparators and
cannot be forced to output $\operatorname{OPT}+\varepsilon$ for all of them.

That would be a real lower bound for this black-box route, but it is not an
atlas separation.

### Why The Barrier Does Not Yet Give A False Edge

The atlas source is not an arbitrary weak oracle supplied by an adversary. It
asserts the existence of one public polynomial-time learner that satisfies
$$
\operatorname{err}(h)\le \operatorname{OPT}_C+\beta
$$
on every labeled distribution. A false edge needs a public class $C$ with such
a learner, while strong improper agnostic learning remains hard. The
clean-tuple oracle lower bound hides exactly the information that a legitimate
source learner is required to find on every low-OPT distribution.

This is the key nonconversion: if we build the hard instance so that the only
useful signal lives on a hidden clean subset, then the source learner must
still weakly learn distributions supported on that subset, and must do so
uniformly for every possible subset/comparator. If it can do that by exploiting
the representation of $C$, a generic black-box menu lower bound no longer
applies. If it cannot, the class fails the source.

The standard witness families continue to hit this fork.

- Halfspaces are not a fixed-constant source witness. Tiegel's lattice-based
  hardness rules out even improper prediction with nontrivial advantage on
  halfspace distributions whose optimum is below any fixed weak threshold. The
  low-noise robustification from realizable learning only gives an
  inverse-polynomial weak gap, not the fixed-additive source needed here.
- Parity/LPN and linear-code templates have the right high-noise hardness
  shape, but the source would require efficient weak recovery from every
  weighted low-noise corruption pattern. For parities this is essentially
  weighted adversarial Max-Lin/nearest-codeword, already the hard part.
- CSP/PTAS templates still do not survive signed labels and improper outputs.
  Positive-label instances are killed by constant predictors; signed instances
  make the weak source as hard as the target-level optimization.
- Cryptographic hidden-region templates fail because distribution-free
  low-OPT queries can concentrate entirely on the hidden region. If weak
  prediction is possible there, the usual strong hardness tends to disappear;
  if not, the source fails.
- Public handle or lookup repairs make weak learning easy, but an improper
  strong learner can usually validate, aggregate, or memorize the same visible
  handles.

So the no-polynomial-clean-tuple-hitter obstruction currently supports only a
black-box lower bound, not an actual `status: false` atlas update.

### No Polynomial Booster Route Found

The other direction also remains blocked. Accuracy-sensitive boosters can be
summarized by a correlation interface
$$
\operatorname{corr}(W,Y)\ge a\rho-\tau,
\qquad
\rho=\sup_{c\in C}\operatorname{corr}(c,Y).
$$
The atlas source, after validation and optional sign flipping, gives only
$$
\operatorname{corr}(W,Y)\ge \max\{0,\rho-2\beta\}.
$$
For any $a>0$, validity at $\rho=2\beta$ forces
$\tau\ge 2a\beta$, hence $\tau/a\ge 2\beta$. Thus the residual in
Feldman/Kalai--Kanade/Ghai-style analyses cannot be tuned below a constant by
choosing parameters differently.

The da Cunha--Hogsgaard--Paudice route avoids that residual and accepts the
fixed source semantically, for example with
$$
\gamma_0=1,\qquad \varepsilon_0=2\beta,\qquad
\theta=(1-2\beta)/2.
$$
But the current algorithm still calls the weak learner about $n^{m_0+3}$ times
and has $m_0$, dual-VC/base-capacity parameters, and $1/\theta$ in runtime
exponents. Since an atlas weak learner can have $m_0=\operatorname{poly}(s)$
and arbitrary efficient improper outputs, this is fixed-parameter polynomial,
not polynomial in the representation size and $1/\varepsilon$.

I also do not see an observable denoising trick that bypasses both problems.
Relabeling, reweighting, and convex-potential boosters only expose small
residual correlations near the optimum, exactly where fixed additive slack may
legally return no progress. Pairing or majority-style denoising would require
extra structure such as repeated points, a product/noise model, or algebraic
closure; none is part of the atlas node.

### Current Conclusion

This branch does not resolve the edge. The best negative statement is a
black-box lower bound target: fixed-slack residual-free boosting appears to
need either clean-tuple enumeration or some non-black-box structure. The best
positive statement is still conditional: if a residual-free fixed-slack booster
were polynomial in $m_0$, weak runtime, a controlled capacity measure,
$1/\theta$, and $1/\varepsilon$, the atlas implication would be true.

### Depth 4 Directions

1. Prove the black-box lower bound cleanly. Model a fixed-additive weak oracle
   that is useful only on hidden low-OPT $m_0$-tuples and neutral elsewhere,
   then show any polynomial-query booster fails. State explicitly that this is
   an oracle barrier, not an atlas separation.

2. Search for a code/noisy-decoding class with both sides proved: an efficient
   distribution-free weak decoder for every weighted distribution with
   $\operatorname{OPT}<1/2-\beta$, and hardness of
   $\operatorname{OPT}+\varepsilon$ improper learning at constant noise under
   one fixed marginal.

3. Try to prove or refute an observable forcing lemma: whenever a current
   predictor has excess more than $\varepsilon$, a polynomial procedure
   generates reweighted or relabeled weak calls, none depending on the hidden
   comparator, such that one call has $\operatorname{OPT}<1/2-\beta$ and its
   valid weak response gives measurable progress.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-weak-agnostic-improper-pac--implies--efficient-agnostic-improper-pac/scratchpad.md

## Depth 4 Branch A: Non-Black-Box Fixed-Slack Audit

### Fresh Check And Branch Goal

I refreshed the live primary pages on 2026-05-07 before this pass. The current
closest fixed-slack result is still da Cunha--Hogsgaard--Paudice 2026,
`arXiv:2601.11265`, v3 dated 2026-02-03:
https://arxiv.org/abs/2601.11265. Its theorem uses the right semantic weak
learner,
$$
\operatorname{cor}_D(W)\ge \gamma_0\sup_{f\in F}\operatorname{cor}_D(f)-\varepsilon_0
$$
with only $\gamma_0>\varepsilon_0$, but the paper explicitly states weak-call
count $O(n^{m_0+3})$ and running time
$$
\operatorname{Eval}_H(1)\cdot
n^{O(m_0\min\{d^*,\ln n\}/\theta^2)}.
$$
It also emphasizes that the running time is polynomial in the sample size when
the other problem parameters are fixed. That is still not an atlas-polynomial
implication when $m_0$, $d^*$, or $1/\theta$ can grow with the representation.

I also rechecked the Ghai--Singh / Feldman line. The relevant comparison in
the 2025/2026 boosting papers remains that Feldman-style threshold boosting
must take $\alpha=O(\varepsilon)$, and Ghai--Singh-style correlation boosting
retains a residual term proportional to the weak oracle's additive slack. Thus
the public theorem landscape still matches Depths 1--3.

This branch therefore asks a narrower question: can a non-black-box route use
the actual hypotheses returned by the weak learner, validation, surrogate
losses, or sample-compression structure to avoid the clean-tuple enumeration?

### Validation Only Selects, It Does Not Create Signal

Validation is powerful after a useful candidate has been generated. It cannot,
by itself, force the weak learner to generate such a candidate.

Let $\beta=1/2-\gamma$. On a weak-call distribution $Q$, the source guarantee
forces a below-random response only when
$$
\operatorname{OPT}_C(Q)<\gamma.
$$
Equivalently, in correlation notation it gives progress only when the best
concept correlation is above $2\beta=1-2\gamma$.

Suppose a proposed booster makes only observable weak calls $Q_1,\ldots,Q_N$
with $\operatorname{OPT}_C(Q_i)\ge \gamma$. Then a valid source learner may
return a progress-neutral hypothesis on every one of those calls. A holdout
sample can reject bad hypotheses or choose the best among the neutral ones, but
it cannot certify the missing comparator-dependent low-OPT query. The transcript
is compatible with many hidden comparators whose clean sets differ.

This is still a black-box sentence if stated for an adversarial oracle, but it
also identifies what non-black-box validation would need: a structural promise
that the particular source learner is stable or generous on high-OPT noisy
queries. The atlas source does not require that. It only requires correctness
on every distribution up to the fixed additive slack.

### Surrogate Relabeling Has A Fixed Noise Ceiling

The most tempting non-black-box positive route is to avoid hidden clean sets
entirely and call the weak learner on observable surrogate labels: gradients of
a convex potential, residual labels, randomized relabelings, or calibration
losses.

The noisy-comparator diagnostic shows why this still hits the fixed-slack
ceiling. Let labels be generated by
$$
Y=f(X)N,\qquad \Pr[N=-1]=\eta,
$$
with $f\in C$ and
$$
\eta\in(\gamma,1/2).
$$
The original distribution has $\operatorname{OPT}_C(D)\le \eta$, so a strong
learner with $\varepsilon\ll 1/2-\eta$ must recover information about $f$.
But the best raw correlation is only $1-2\eta<1-2\gamma=2\beta$, so the source
weak learner need not reveal anything on $D$.

Now take any observable binary relabeling channel that forms a new label $Y'$
from $(X,Y)$, the current predictor's value, and fresh randomness, but not from
the unknown $f$ or the clean indicator. Conditional on $X=x$, its $f$-dependent
part is still multiplied by the original bias $1-2\eta$. In the simplest
label-channel form,
$$
\mathbb E[Y'\mid X=x]
=a(x)+b(x)(1-2\eta)f(x),
\qquad |b(x)|\le 1,
$$
where $a,b$ are observable from the booster state. Reweighting can change the
average over $x$, and centering can remove observable offsets, but without a
weight correlated with the hidden clean event it cannot turn the factor
$1-2\eta$ into a constant larger than the fixed threshold $2\beta$.

This is exactly where surrogate and OCO boosters use a stronger oracle: they
ask for correlation at the current residual scale. If that scale is
$O(\varepsilon)$, the atlas fixed-additive source is allowed to be silent.
Repeated-label denoising, product tests, or majority votes over identical
points could amplify the bias, but none of those structures is available in the
distribution-free PAC model. On a continuous or high-entropy marginal, repeated
points need not occur.

### Compression Does Not Remove The Password

A source learner run on $m_0$ examples is a compression mechanism in the weak
sense that each returned hypothesis is determined by a short training
transcript and randomness. da Cunha--Hogsgaard--Paudice exploit this by
enumerating enough $m_0$-tuples to ensure that some tuple lies in the hidden
low-noise set for the near-optimal comparator.

A generic polynomial compression menu cannot replace that enumeration. If
$G\subseteq S$ is a hidden clean set of density $p<1$ and a useful call requires
an $m_0$-tuple in $G^{m_0}$, then a precomputed menu of $q$ tuples hits a random
$G$ with probability at most about $q p^{m_0}$. For $m_0=\operatorname{poly}(s)$,
every menu of size $\operatorname{poly}(s,n,1/\varepsilon)$ misses some possible
clean set.

Sample-compression generalization bounds still help after a candidate has been
generated. They do not explain how to generate, in polynomially many tries, the
candidate whose compression set is comparator-clean. A positive theorem would
need additional structure: for example, a stable weak learner whose output on
moderately noisy tuples agrees with its output on clean tuples, or a public
compression map that can be optimized without guessing the hidden clean subset.
Neither property is part of the source node.

### Separation Search After The Non-Black-Box Audit

The false direction still lacks an atlas-valid class. The required witness is
quite demanding:

1. for every labeled distribution, there is a polynomial-time improper learner
   with error at most $\operatorname{OPT}_C+\beta$ for some fixed
   $\beta<1/2$; but
2. for some distribution family, no polynomial-time improper learner achieves
   $\operatorname{OPT}_C+\varepsilon$.

The usual candidates fail for more specific reasons now.

Halfspaces have the desired strong agnostic hardness flavor, but they do not
satisfy the distribution-free fixed-additive source. Tiegel's COLT 2023
halfspace hardness says that, under worst-case lattice assumptions, even
outputting an arbitrary binary hypothesis with error better than
$1/2-\gamma$ is hard when the optimal halfspace error is tiny:
https://proceedings.mlr.press/v195/tiegel23a.html. So halfspaces fail the
source rather than separating it from the target.

Parities, LPN, and linear-code templates have the right high-noise hardness
intuition. The source, however, would require efficient weak recovery under
every arbitrary weighted low-OPT corruption pattern. For parities this is a
weighted adversarial Max-Lin / nearest-codeword problem, not merely noiseless
Gaussian elimination. For codes, ordinary unique decoding under uniform Hamming
noise is not enough; the PAC distribution may put arbitrary weights on
coordinates.

CSP and PTAS-hardness templates are still near-misses. A constant-additive
approximation algorithm for positive constraints does not become an agnostic
learner for signed labels. If negative labels are included to block constant
predictors, then the same signed optimization problem becomes the weak-source
obligation. If the domain is made polynomial-size so that low-noise decoding is
easy, an improper learner can often estimate the labels pointwise and the
strong target becomes easy too.

The one false route that still seems worth isolating is a semi-agnostic
approximation witness. If one could find a class with an efficient
distribution-free improper learner satisfying
$$
\operatorname{err}(h)\le A\operatorname{OPT}_C+\varepsilon_0
$$
for a fixed constant $A$, while $\operatorname{OPT}_C+\varepsilon$ improper
learning is hard, then choosing the weak threshold small enough might imply the
source but refute the target. I do not know such a class. Known high-noise hard
families tend to rule out even weak prediction in the low-OPT regime, and known
semi-agnostic positive algorithms usually rely on marginal assumptions or do
not come with improper strong lower bounds for the same class.

### Current Resolution State

I do not see a polynomial fixed-slack boosting route beyond the black-box
barrier. The obstruction is not just that a black-box oracle hides a clean
tuple. The deeper issue is that the source definition provides no efficiently
checkable certificate of where fixed slack becomes useful. Validation,
surrogate losses, and compression all work once a useful low-OPT weak call or
candidate is present; none generically manufactures that call from observable
high-OPT noisy data.

I also do not see a source-positive hardness witness. Every plausible
separation has to solve a hard pair of requirements: weakly decode every
low-OPT distribution in polynomial time, but keep fine agnostic improper
decoding hard at higher noise. The standard halfspace, parity/LPN,
nearest-codeword, CSP, and cryptographic hidden-region templates each fail one
side of that pair.

Thus the atlas edge should remain open.

### Depth 5 Directions

1. Prove a formal label-channel obstruction for surrogate boosters. Start with
   $Y=f(X)N$ at noise $\eta>\gamma$ and show that any polynomial sequence of
   relabelings/reweightings whose weights are measurable with respect to the
   observed transcript cannot create a query with
   $\operatorname{OPT}<\gamma$ unless it has already learned a predictor
   correlated with $f$.

2. Search specifically for a semi-agnostic separation: a class with an
   efficient distribution-free improper $A\operatorname{OPT}+\varepsilon$
   learner for fixed $A$, but cryptographic or NP-hardness of
   $\operatorname{OPT}+\varepsilon$ improper learning. This would bypass the
   need for a direct fixed-slack booster while satisfying the source via the
   constant-factor guarantee.

3. Identify a structural positive subnode: fixed-additive weak learners with a
   stable compression map, tolerant low-noise behavior, or polynomial-size
   clean-set hitting family. da Cunha--Hogsgaard--Paudice would then supply the
   statistical skeleton, and the extra structure would be exactly what removes
   the $n^{m_0}$ enumeration.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-weak-agnostic-improper-pac--implies--efficient-agnostic-improper-pac/scratchpad.md

## Depth 5 Branch A: Certification Gap

### Fresh Check And Target

I rechecked the local endpoint definitions and edge note, plus the current
primary pages for the closest boosting results. The atlas source is still the
fixed-additive weak agnostic guarantee
$$
\operatorname{err}(h)\le \operatorname{OPT}_C+\beta,\qquad
\beta=1/2-\gamma<1/2,
$$
with improper but deterministic binary hypotheses. The target is still
arbitrary excess agnostic improper learning. The current public theorem
landscape has not changed: Feldman/Ghai-style observable boosters need
accuracy-scale weak slack, while da Cunha--Hogsgaard--Paudice 2026 accepts the
right fixed-slack semantic condition but keeps weak sample/capacity parameters
in exponents. I did not find a representation-uniform polynomial theorem that
settles this edge.

This pass focuses only on the high-noise certification problem: can an
algorithm, from observable high-noise agnostic data, manufacture or certify a
low-$\operatorname{OPT}$ weak call without already having learned the hidden
near-optimal comparator?

### A Quantitative Certification Obstruction

Consider the diagnostic distribution
$$
Y=f(X)N,\qquad \Pr[N=-1]=\eta,
$$
where $f\in C$ and
$$
\gamma<\eta<1/2.
$$
The original task has $\operatorname{OPT}_C(D)\le \eta$, so the fixed-additive
weak learner may legally return a random-looking deterministic hypothesis on
$D$. A strong agnostic learner must still recover correlation with $f$ when
$\varepsilon\ll 1/2-\eta$.

The simplest observable way to create a lower-noise subproblem is to keep
examples on which the noisy label agrees with some current deterministic
predictor $h$. Let
$$
r=\mathbb E[h(X)f(X)]
$$
be the predictor's true correlation with the hidden comparator. On the selected
event $A=\{Y=h(X)\}$, the remaining label noise relative to $f$ is
$$
\Pr[Y\ne f(X)\mid A]
=
\frac{\eta(1-r)}
{(1-\eta)(1+r)+\eta(1-r)}.
$$
This selected distribution has $\operatorname{OPT}_C<\gamma$ by this route
only if
$$
r>
\frac{\eta-\gamma}{\eta+\gamma-2\eta\gamma}.
$$
Thus agreement filtering can certify a useful low-$\operatorname{OPT}$ call
only after the learner already has nontrivial, often large, correlation with
$f$. If $r=0$, the selected noise remains exactly $\eta$; no fixed-slack weak
call is forced. If $\gamma$ is much smaller than the high-noise level $\eta$,
the required $r$ is close to one.

This calculation is more than a criticism of that one filter. Any binary
relabeling or reweighting channel whose only $f$-dependent inputs are
$(Y,h_1(X),\ldots,h_k(X))$ can amplify clean examples only through whatever
posterior information the current deterministic predictors already carry about
$f$. With no repeated labels at the same $X$, no membership queries, and no
observable clean indicator, label processing cannot manufacture a fresh
low-noise certificate. Validation estimates error against the observed noisy
labels; it can recognize a good candidate once produced, but it cannot certify
that an unobserved comparator-dependent weak-call distribution has
$\operatorname{OPT}<\gamma$.

So the obstruction is circular:

1. To force the fixed-additive weak learner to reveal signal, the booster needs
   an observable query with $\operatorname{OPT}<\gamma$.
2. To certify such a query from high-noise data, the booster needs a predictor
   already correlated with the hidden comparator strongly enough to enrich the
   clean examples.
3. Obtaining that predictor is essentially the strong agnostic task in the
   first place.

This strengthens the black-box password picture from Depths 3--4. It explains
why validation, surrogate relabeling, and compression do not start the process:
they select among or reuse candidates, but they do not create the initial
comparator correlation needed to make high-noise data look low-noise.

### Why This Still Is Not An Atlas Separation

The calculation above is a barrier for generic observable boosting. It does
not refute the atlas implication. A legitimate source learner is a public
polynomial-time algorithm for the whole class, not an adversarial oracle. It
might exploit representation-specific structure and return useful deterministic
hypotheses even on high-$\operatorname{OPT}$ queries where the fixed-additive
guarantee does not force progress.

A false edge therefore still needs an actual class with both properties:

1. every distribution with arbitrary labels admits an efficient deterministic
   improper learner with error at most $\operatorname{OPT}_C+\beta$ for one
   fixed $\beta<1/2$; and
2. some high-noise agnostic family remains hard for deterministic improper
   $\operatorname{OPT}_C+\varepsilon$ learning.

The obvious templates still fail one side. Parity/LPN and code families have
the right high-noise hardness shape, but the source would require a constant
low-noise distribution-free weak decoder for arbitrary weighted corruption
patterns, not only random noise under a fixed marginal. Clean-batch
robustification from realizable learning gives only an inverse-polynomial
low-noise threshold when the clean sample size grows. Halfspaces fail the
source under known lattice-based weak agnostic hardness. CSP/PCP templates
either become easy for improper learners on polynomial-size domains, or signed
labels make the same hard optimization problem appear already in the weak
source obligation.

The most plausible separation skeleton remains a coding-style bounded-distance
decoder: efficient weighted low-noise decoding for every PAC marginal, but
hard high-noise improper prediction under one marginal. I do not know a
standard class satisfying both. Ordinary unique decoding is not enough because
the PAC source quantifies over arbitrary example weights, and ordinary
maximum-likelihood hardness is not enough because the target permits arbitrary
efficient deterministic hypotheses, not just proper codewords.

### Conditional Positive Shape

The certification calculation also identifies a genuine positive subnode. If
the weak source came with an extra stability or generosity promise saying that,
on high-noise comparator-corrupted data, it returns a deterministic hypothesis
with correlation exceeding
$$
\frac{\eta-\gamma}{\eta+\gamma-2\eta\gamma}
$$
whenever the best comparator has noise $\eta$, then agreement filtering would
produce a low-$\operatorname{OPT}$ weak call and the fixed-slack machinery
could start. More abstractly, a stable compression map or tolerant decoder that
turns moderately noisy samples into a slightly correlated comparator estimate
would remove the first-step certification gap.

But that is a strictly stronger interface than
$\operatorname{OPT}_C+\beta$. The atlas source permits a valid learner to be
neutral on every high-$\operatorname{OPT}$ query. Hence this is only a
conditional structural route, not a proof of the present edge.

### Depth 6 Directions

1. Formalize the label-channel obstruction. Prove a lemma for deterministic
   transcript-measurable reweighting/relabeling channels: unless the transcript
   already contains a predictor with correlation at least
   $(\eta-\gamma)/(\eta+\gamma-2\eta\gamma)$ with the hidden comparator, no
   generated weak-call distribution can be certified to have
   $\operatorname{OPT}<\gamma$ in the noisy-comparator model.

2. Search for a weighted bounded-distance decoding witness. The needed class
   must have efficient distribution-free weak decoding for all weighted
   corruption patterns below a fixed constant radius, while high-noise
   deterministic improper prediction remains hard under a standard assumption.

3. Define a strengthened positive node for stable fixed-additive weak learners:
   the weak learner should either expose a useful high-noise correlation
   certificate or have a polynomial-size stable compression/hitting family.
   Check whether da Cunha--Hogsgaard--Paudice plus this extra property gives a
   fully polynomial reduction.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-weak-agnostic-improper-pac--implies--efficient-agnostic-improper-pac/scratchpad.md

## Depth 6 Branch A: Posterior Certification Barrier

### Fresh Check And Branch Goal

I rechecked the local endpoint definitions, the edge note, the
`agnostic-boosting-open` note, and the low-noise robustification note. I also
refreshed the current primary boosting pages. Two public facts are relevant for
this pass.

- `Revisiting Agnostic Boosting`, the NeurIPS 2025 OpenReview version by
  da Cunha, Hogsgaard, Paudice, and Sun, gives the right statistical
  fixed-slack flavor but explicitly forgoes computational considerations: the
  candidate generation step is exponential.
  https://openreview.net/attachment?id=aFf30XJpl4&name=pdf
- `Sample-Near-Optimal Agnostic Boosting with Improved Running Time`,
  `arXiv:2601.11265`, remains the closest efficient fixed-slack result. The
  current arXiv page still says v3 was last revised on 2026-02-03 and that the
  algorithm runs in time polynomial in the sample size when the other problem
  parameters are fixed.
  https://arxiv.org/abs/2601.11265

So the theorem landscape still does not give a representation-uniform
polynomial implication. This branch instead tries to make the Depth 5
certification gap as sharp as possible.

### Posterior Form Of The Certification Gap

Work in the noisy-comparator diagnostic:
$$
Y=F(X)N,\qquad \Pr[N=-1]=\eta,\qquad \gamma<\eta<1/2,
$$
where $F$ is the hidden near-optimal comparator and
$\beta=1/2-\gamma$. Let
$$
p=1-2\eta,\qquad q=1-2\gamma .
$$
The original distribution has best comparator correlation $p<q$, so the
fixed-additive weak learner need not reveal anything on the original data.

The clean way to phrase the obstruction is Bayesian. Let $T$ denote the whole
observable transcript before a proposed weak call: previous samples, previous
hypotheses, validation outcomes, random coins, and the fresh instance $X$ as
seen through the algorithm's computable features. The hidden comparator $F$ is
drawn from some hard prior over the class, and the transcript induces the
posterior mean
$$
\mu_T(X)=\mathbb E[F(X)\mid T,X].
$$
If $|\mu_T(X)|$ is small, then the transcript has not yet learned the
comparator at $X$. Observing the noisy label $Y$ can update this posterior, but
only by the standard binary-noise Bayes factor:
$$
\mathbb E[F(X)\mid T,X,Y=y]
=
\frac{\mu_T(X)+yp}{1+yp\,\mu_T(X)}.
$$
Therefore the largest possible posterior confidence after seeing the noisy
label is
$$
\max_{y\in\{\pm1\}}
\left|
\frac{\mu_T(X)+yp}{1+yp\,\mu_T(X)}
\right|.
$$
To make any observable relabeling or selection produce a weak-call
distribution with $\operatorname{OPT}<\gamma$, the selected examples must have
comparator correlation above $q=1-2\gamma$. Solving
$$
\frac{r+p}{1+pr}>q
$$
gives exactly
$$
r>
\frac{q-p}{1-pq}
=
\frac{\eta-\gamma}{\eta+\gamma-2\eta\gamma}.
$$
This is the same threshold that appeared in Depth 5 for agreement filtering,
but now it is not tied to that particular filter. It says:

**Posterior certification lemma target.** In the noisy-comparator model, any
weak-call distribution produced by transcript-measurable reweighting,
selection, relabeling, or validation can have $\operatorname{OPT}<\gamma$ only
on mass where the transcript already gives posterior comparator correlation at
least
$$
r_\star(\eta,\gamma)
=
\frac{\eta-\gamma}{\eta+\gamma-2\eta\gamma}.
$$
Otherwise the best possible label processing of one noisy label per point
leaves the comparator noise at least $\gamma$.

This is the certification obstruction in its cleanest form. The fixed-slack
weak call becomes forced only after the booster has already localized a region
where it can predict the hidden comparator substantially better than the raw
noisy label permits. In the high-noise regime $\eta>\gamma$, that posterior
correlation is exactly the thing a strong agnostic learner is trying to build.

### Why This Does Not Yet Prove False

The posterior lemma is a strong black-box or average-case barrier, not an
atlas-valid separation by itself.

First, the atlas source is an existential statement about a public
polynomial-time learner for a concrete class. It is not an adversarial weak
oracle. A legitimate source learner may be generous on high-OPT distributions,
or may exploit representation-specific structure that is not visible to the
generic label channel. The source guarantee does not force such generosity, but
a false edge must rule out every possible strong learner for a class that still
has some fixed-additive weak learner.

Second, the posterior statement must be embedded in a class where the
posterior really stays small after polynomially many observable calls. That is
a cryptographic or average-case hardness requirement. But the same class must
also satisfy the distribution-free fixed-additive weak source on every
low-OPT distribution. Those requirements pull in opposite directions: hiding
the comparator well enough to keep high-noise posteriors small usually also
makes low-noise weak recovery hard when the distribution concentrates on the
hidden region.

Third, this cannot be repaired by the cheap low-noise robustification route.
The local `low-noise-weak-agnostic-robustification` note gives only an
inverse-polynomial weak-agnostic gap from clean realizable learning. That is
useful for the marginal/inverse-polynomial weak nodes, but the present source
is the fixed-additive distribution-free weak agnostic node. For example,
parities plus clean-batch robustification would give only a tiny
$\gamma=\Theta(1/n)$ style source; with a fixed constant $\gamma$, parities
would need efficient weak recovery from every weighted corruption pattern of
rate below $\gamma$, which is the adversarial Max-Lin/nearest-codeword problem
rather than ordinary Gaussian elimination.

### Separation Audit

I do not see an atlas-valid false witness.

The parity/LPN template is still the cleanest high-noise hardness story. Under
uniform random classification noise, an $\operatorname{OPT}+\varepsilon$
improper learner for parities would give a predictor highly correlated with
the secret parity and would contradict standard noisy-parity assumptions. The
source side is the blocker: a fixed-additive weak agnostic parity learner
would have to handle arbitrary PAC marginals and arbitrary weighted error
patterns with $\operatorname{OPT}<\gamma$ for a constant $\gamma$. That is not
known and appears to be the same robust decoding difficulty, just below the
weak threshold.

The one-way weak-handle constructions in the atlas also do not transfer. They
make weak proper selection easy by adding public handles, but the present
target is improper. Once the handles or a polynomial-size active coordinate set
are visible, an improper learner can usually validate, aggregate, or memorize
enough labels to achieve strong agnostic error. The properness restriction was
doing essential work in those witnesses.

The remaining plausible false route is semi-agnostic. If a class had an
efficient distribution-free improper learner with
$$
\operatorname{err}(h)\le A\,\operatorname{OPT}_C+\varepsilon
$$
for a fixed constant $A$, then combining that learner with constants would
give the atlas fixed-additive weak source for a sufficiently small constant
weak threshold $\gamma$. If the same class were hard for
$\operatorname{OPT}_C+\varepsilon$ improper learning, the edge would be false.
I did not find such a class. Known disjunction/CSP-style approximation
algorithms either have approximation factors growing with dimension or rely on
restricted marginals, and signed-label hardness tends to make the weak source
hard as well.

### Positive Audit

The posterior calculation also explains why the standard positive moves keep
stalling.

Observable relabeling and reweighting boosters can reduce agnostic learning to
finding residual correlations, but near the optimum those correlations may be
arbitrarily small. A fixed-additive weak learner is allowed to ignore them.
Conditioning on apparent clean examples would amplify the signal, but the
posterior lemma says such conditioning is only certifiable after the transcript
already contains a comparator-correlated predictor.

The residual-free fixed-slack statistical boosters avoid this by generating a
large enough hypothesis menu that some candidate effectively comes from a
hidden low-noise sample. The known efficient version still pays for this with
weak-sample or capacity parameters in exponents. A fully polynomial positive
proof would need a new mechanism that creates the first posterior correlation
without an all-clean tuple search, or a structural promise on the weak learner
that is stronger than $\operatorname{OPT}+\beta$.

### Current Resolution State

This depth does not resolve the edge. It upgrades the certification gap from
an agreement-filter calculation to a general posterior obstruction for
observable label processing in the noisy-comparator model. That is useful
evidence against a generic polynomial fixed-slack booster, but it is still not
a concrete source-true/target-false class.

The atlas edge should remain open unless one of two missing ingredients is
found: a fully polynomial fixed-slack booster that avoids posterior
certification, or a class with constant-radius distribution-free weak decoding
but hard high-noise improper agnostic learning.

### Depth 7 Directions

1. Prove the posterior certification lemma as a formal black-box lower bound.
   Use a random hidden comparator prior, independent classification noise
   $\eta>\gamma$, and adaptive transcript-measurable weak-call channels. Show
   that any successful call with $\operatorname{OPT}<\gamma$ implies a
   transcript predictor with correlation at least
   $r_\star(\eta,\gamma)$ on the selected mass.

2. Search only for constant-radius weighted decoding witnesses. The required
   object is a concept/code class with a polynomial algorithm that, for every
   PAC marginal and every weighted corruption pattern of rate below a fixed
   constant $\gamma$, outputs some hypothesis with error below $1/2-\Omega(1)$,
   while high-noise $\operatorname{OPT}+\varepsilon$ improper prediction is
   hard under one standard marginal.

3. Test the semi-agnostic route with fixed-factor approximation. A class with
   efficient improper $A\operatorname{OPT}+\varepsilon$ learning for constant
   $A$, but hard $\operatorname{OPT}+\varepsilon$ improper learning, would
   immediately give a fixed-additive weak source by mixing the semi-agnostic
   learner with constants. The search should focus on signed CSP or
   disjunction-like classes where the factor is truly constant and the output
   is allowed to be improper.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-weak-agnostic-improper-pac--implies--efficient-agnostic-improper-pac/scratchpad.md
## Depth 7 Branch A: Final Consolidation

### Final Refresh And Scope

This is the final allowed depth for the edge
`efficient-weak-agnostic-improper-pac -> efficient-agnostic-improper-pac`.
I re-read the whole scratchpad, with special attention to Depths 5--6, and
checked the current primary pages for the closest boosting route. The relevant
state is unchanged on 2026-05-07:

- `Revisiting Agnostic Boosting`, arXiv:2503.09384, is the residual-free
  fixed-slack statistical breakthrough but the known algorithmic candidate
  generation is exponential.
  https://arxiv.org/abs/2503.09384
- `Sample-Near-Optimal Agnostic Boosting with Improved Running Time`,
  arXiv:2601.11265, v3 last revised 2026-02-03 and accepted to ALT 2026, is
  the closest computational result. Its abstract still states runtime
  polynomial in the sample size when the other problem parameters are fixed.
  https://arxiv.org/abs/2601.11265

I did not find a primary-source theorem giving a representation-uniform
polynomial fixed-additive agnostic booster. I also did not find an atlas-valid
source-true/target-false class. The edge therefore remains unresolved, but the
best current state can now be made fairly crisp.

All statements below are for deterministic improper binary output hypotheses.
Randomized subroutines can be handled in the usual PAC way by confidence
amplification and validation; the final learner required by the target node may
be taken to output a deterministic hypothesis.

### Fixed-Additive Slack Barrier

Let the source weak tolerance be
$$
\beta=1/2-\gamma<1/2 .
$$
For a labeled distribution $Q$ and labels in $\{-1,1\}$, write
$$
\rho(Q)=\sup_{c\in C}\mathbb E_Q[Yc(X)] .
$$
The source guarantee
$$
\operatorname{err}_Q(h)\le \operatorname{OPT}_C(Q)+\beta
$$
is equivalently
$$
\operatorname{corr}_Q(h,Y)\ge \rho(Q)-2\beta .
$$
After validation and optional sign flipping, the strongest black-box guarantee
one should safely credit to the source is
$$
\operatorname{corr}_Q(h,Y)\ge \max\{0,\rho(Q)-2\beta\}.
$$

This cannot instantiate an accuracy-scale correlation oracle
$$
\operatorname{corr}(h,Y)\ge a\rho-\tau
$$
with residual ratio $\tau/a=O(\varepsilon)$ for arbitrary final
$\varepsilon$. Indeed, validity at $\rho=2\beta$ forces
$$
\tau\ge 2a\beta,
$$
hence
$$
\tau/a\ge 2\beta .
$$
Thus Feldman/Kalai--Kanade/Ghai--Singh style observable boosters cannot be
rescued by parameter tuning. They prove the right theorem for a stronger weak
interface whose slack is tunable at the target accuracy scale, but the atlas
source only provides one fixed additive floor.

The semantic consequence is the real barrier: whenever a booster reaches a
residual task whose best concept correlation lies below $2\beta$, the source
learner may return a progress-neutral deterministic hypothesis, even if a
strong agnostic learner must still extract an $O(\varepsilon)$ improvement.

### Posterior And Noise-Channel Certification Barrier

Depths 5--6 identify the cleanest obstruction to creating a useful low-OPT
weak call from high-noise data. Consider the noisy-comparator diagnostic
distribution
$$
Y=F(X)N,\qquad \Pr[N=-1]=\eta,\qquad \gamma<\eta<1/2,
$$
where $F\in C$ is hidden. Let
$$
p=1-2\eta,\qquad q=1-2\gamma .
$$
The original distribution has best comparator correlation $p<q$, so the
fixed-additive source need not give any useful response on it.

Let $T$ be the whole observable transcript before a proposed weak call. If a
hard prior on $F$ induces posterior mean
$$
\mu_T(x)=\mathbb E[F(x)\mid T,X=x],
$$
then observing one noisy label $Y=y$ updates this posterior by
$$
\mathbb E[F(X)\mid T,X,Y=y]
=
\frac{\mu_T(X)+yp}{1+yp\,\mu_T(X)} .
$$
To certify a weak-call distribution with $\operatorname{OPT}_C<\gamma$, the
selected or relabeled examples must expose comparator correlation above
$q=1-2\gamma$. Even under the most favorable sign of $y$, solving
$$
\frac{r+p}{1+pr}>q
$$
gives the required prior transcript correlation
$$
r>r_\star(\eta,\gamma)
=
\frac{q-p}{1-pq}
=
\frac{\eta-\gamma}{\eta+\gamma-2\eta\gamma}.
$$

This is the posterior certification barrier. Any transcript-measurable
selection, reweighting, relabeling, or validation channel that sees only one
noisy label per example can make the fixed-slack weak guarantee forced only on
mass where the transcript already predicts the hidden comparator with
correlation at least $r_\star(\eta,\gamma)$. Agreement filtering is just the
simplest example; the posterior formula shows the same obstruction for general
observable label processing.

This does not prove the edge false. It proves only that a generic observable
booster cannot certify the needed low-OPT call unless it has already acquired
substantial comparator information. A legitimate source learner may exploit
class-specific structure and may be generous on high-OPT queries; the atlas
source does not forbid that. But the source also does not require such
generosity, so this remains a serious barrier to a theorem that uses only the
fixed-additive guarantee.

### Clean-Tuple And da Cunha Barrier

The residual-free fixed-slack boosters avoid the posterior-starting problem by
generating a sufficiently rich candidate menu. In the noisy-comparator picture,
let $G\subseteq S$ be the hidden clean set where $Y=F(X)$, with density
$p_c=|G|/|S|$ bounded away from zero. If the weak learner needs $m_0$ training
examples, a call trained on a tuple from $G^{m_0}$ is forced into the low-OPT
regime, while a generic noisy tuple may not be.

For any comparator-independent menu $L$ of $q$ ordered $m_0$-tuples,
a uniformly random clean set of density $p_c$ is hit with probability at most
about
$$
q\,p_c^{m_0}.
$$
Therefore a universal polynomial-size menu cannot hit every hidden clean set
when $m_0$ grows with the representation size. This explains why the
da Cunha--Hogsgaard--Paudice fixed-slack construction pays for tuple/candidate
enumeration.

The 2026 improved-running-time result is semantically the closest positive
theorem. The atlas source can be converted to their fixed-slack correlation
condition, for example with parameters satisfying $\gamma_0>\varepsilon_0$.
But their generic runtime still has weak-sample and capacity parameters in
exponents, such as the already-recorded $O(n^{m_0+3})$ weak-call count and
terms of the form
$$
\operatorname{Eval}_H(1)\cdot
n^{O(m_0\min\{d^*,\ln n\}/\theta^2)} .
$$
That is a fixed-parameter positive theorem, not an atlas-polynomial
implication when $m_0$, $d^*$, or $1/\theta$ may scale with the concept
representation.

### Why No Atlas-Valid Separation Is Known

The negative direction still lacks a concrete witness class. The source is
stronger than it first appears: it must provide one public polynomial-time
improper learner satisfying
$$
\operatorname{err}(h)\le \operatorname{OPT}_C+\beta
$$
for every labeled distribution. Any proposed separation must make this true
while keeping $\operatorname{OPT}_C+\varepsilon$ improper learning hard on some
family.

The standard candidates keep failing one side of that pair.

- Halfspaces have strong agnostic hardness evidence, but known lattice-based
  hardness rules out even weak improper agnostic prediction in relevant
  distribution-free settings. They fail the source.
- Parities, LPN, and code templates have the right high-noise hardness shape,
  but the source would require constant-radius weak recovery for every
  arbitrary PAC marginal and every weighted low-noise corruption pattern. That
  is adversarial Max-Lin or nearest-codeword style decoding, not the easy
  realizable parity learner.
- CSP/PTAS templates do not transfer cleanly to signed agnostic labels and
  improper output. Positive-label instances are often solved by constants;
  signed instances make the weak-source obligation inherit the hard
  optimization problem.
- Cryptographic hidden-region templates fail because distribution-free low-OPT
  queries may concentrate entirely on the hidden region. If the weak source can
  learn there, the usual high-noise hiding argument tends to break; if it
  cannot, the class fails the source.
- Public-handle constructions separate proper notions more naturally than this
  improper edge. Once the handle or active coordinate set is visible, an
  improper learner can often validate, aggregate, or memorize enough to become
  strong.
- The semi-agnostic route remains plausible in form but has no known witness:
  an efficient distribution-free improper $A\operatorname{OPT}+\varepsilon$
  learner for constant $A$, combined with strong improper hardness, would give
  a false edge after choosing the weak threshold appropriately. I do not know a
  class satisfying both requirements.

Thus the clean-tuple and posterior barriers are best understood as black-box or
generic-boosting barriers, not as atlas-valid separations.

### Conditional True Principles

Several strengthened principles would make the implication true, but each adds
structure beyond the current source node.

1. Tunable weak slack. If the weak learner supplied
   $\operatorname{corr}\ge a\rho-\tau$ with $\tau/a=O(\varepsilon)$, or an
   equivalent threshold/correlation oracle at the requested accuracy scale,
   then the known observable agnostic boosting machinery gives an efficient
   improper strong learner.

2. Fully polynomial fixed-slack booster. If the da Cunha--Hogsgaard--Paudice
   residual-free fixed-slack theorem were made polynomial in $m_0$, weak
   runtime, $d^*$, $1/\theta$, $1/\varepsilon$, and $\log(1/\delta)$, with no
   representation parameter in an exponent, then the atlas edge would be true.

3. Fixed-parameter regime. If $m_0$, the relevant base/dual capacity
   parameters, and $1/\theta$ are treated as constants, or are otherwise
   bounded so that the displayed exponents remain polynomial in the
   representation size, the current fixed-slack theory gives the desired
   residual-free behavior.

4. Stable or generous weak learner. If the source were strengthened so that on
   noisy comparator distributions it returns a deterministic hypothesis with
   enough correlation to cross the threshold
   $r_\star(\eta,\gamma)$, or if it supplied a stable compression map or
   polynomial clean-set hitting family, then the posterior/candidate-generation
   barrier would disappear.

These are useful atlas-adjacent subnodes, but they are conditional-only for the
present edge.

### Proposed Atlas Summary

Still open. A fixed-additive weak agnostic improper learner gives useful
guarantees only on query distributions with $\operatorname{OPT}_C<\gamma$,
where $\beta=1/2-\gamma$. Known observable polynomial agnostic boosters require
weak slack at the final accuracy scale, while known residual-free fixed-slack
boosters use candidate enumeration whose runtime is not polynomial uniformly
in the atlas representation parameters.

### Proposed Atlas Proof-Status Body

**Goal.** Decide whether an efficient distribution-free deterministic improper
weak agnostic learner satisfying
$$
\operatorname{err}(h)\le \operatorname{OPT}_C+\beta
$$
for one fixed $\beta<1/2$ implies an efficient deterministic improper agnostic
learner achieving
$$
\operatorname{err}(h)\le \operatorname{OPT}_C+\varepsilon
$$
for every requested $\varepsilon>0$.

**Positive evidence.** In correlation notation, the weak source supplies a
fixed-slack approximation to the best concept correlation:
$$
\operatorname{corr}(h,Y)\ge \rho_C-2\beta .
$$
This is exactly the kind of nontrivial fixed-slack signal used by the recent
residual-free agnostic boosting literature. In fixed-parameter regimes, or if
a fully polynomial fixed-slack booster were available, the implication would
be true.

**Why known boosters do not settle the edge.** Efficient observable boosters
with tunable weak oracles inherit a residual term proportional to the weak
oracle's additive slack. The atlas source has a flat region:
$$
\max\{0,\rho-2\beta\}.
$$
Any bound of the form $\operatorname{corr}\ge a\rho-\tau$ valid for this flat
region has $\tau/a\ge 2\beta$, so the residual cannot be driven to
$O(\varepsilon)$. The fixed-slack residual-free boosters avoid this residual,
but their known candidate-generation step has weak-sample or capacity
parameters in exponents; this is not a representation-uniform polynomial-time
reduction.

**Main obstruction.** In a noisy-comparator distribution
$Y=F(X)N$ with noise rate $\eta\in(\gamma,1/2)$, the original distribution has
$\operatorname{OPT}_C\le\eta$, so the weak learner may be progress-neutral.
To force a useful weak call, an observable booster must create or certify a
lower-noise subproblem. But posterior updating through one noisy label can
cross the weak threshold only on mass where the transcript already predicts
the hidden comparator with correlation at least
$$
r_\star(\eta,\gamma)
=
\frac{\eta-\gamma}{\eta+\gamma-2\eta\gamma}.
$$
Thus generic reweighting, relabeling, filtering, validation, and compression
do not start the process unless substantial comparator information is already
present.

**Why this is not a separation.** The posterior and clean-tuple arguments are
black-box barriers. A false atlas edge would need an explicit concept class
that has a public polynomial-time $\operatorname{OPT}+\beta$ improper learner
on every distribution, while $\operatorname{OPT}+\varepsilon$ improper
learning remains hard. Halfspaces, parities/LPN, code families, CSP templates,
cryptographic hidden regions, public-handle constructions, and known
semi-agnostic examples do not currently provide such a witness.

**Current status.** Leave the edge open with evidence `unknown` and family
`agnostic-boosting-open`. The best positive statements are conditional on
tunable slack, fixed-parameter runtime, a fully polynomial fixed-slack booster,
or extra stability/generosity structure in the weak learner. The best negative
statements are black-box/posterior/candidate-enumeration barriers, not
atlas-valid separations.

VERDICT: unresolved scratchpads/open-edge-resolution-2026-05-07/efficient-weak-agnostic-improper-pac--implies--efficient-agnostic-improper-pac/scratchpad.md
