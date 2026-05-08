# Edge: efficient-weak-agnostic-improper-pac -> efficient-marginal-nonuniform-weak-realizable-proper-pac

- date: 2026-05-05
- depth: 1
- edge_file: `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- source: `efficient-weak-agnostic-improper-pac`
- target: `efficient-marginal-nonuniform-weak-realizable-proper-pac`
- family: `properization-open`
- atlas files edited: none

## Bottom Line

I do not have an atlas-ready proof or separation. Keep the assigned edge open.

The source is strong enough to give a distribution-free constant-advantage
improper predictor on realizable data: if the labels are $Y=c(X)$, then
$\operatorname{OPT}_{\mathcal C}=0$, so the weak agnostic learner returns an
external hypothesis with error at most a fixed $\beta<1/2$ under every marginal.
The target asks for much less accuracy, but it asks for a representation in
$\mathcal C$.

Thus the remaining problem is a fixed-marginal weak properization problem:

$$
\text{efficient external prediction near } c
\quad\Longrightarrow ?\quad
\text{efficiently find } h\in\mathcal C
\text{ with } \operatorname{err}_P(h,c)<1/2.
$$

I found no generic theorem giving this implication. The standard false-witness
templates are close, but each leaks weak proper handles or relies on
input-dependent marginals that are absorbed by marginal nonuniformity.

## Files And Sources Checked

Local atlas notes:

- `atlas/definitions/efficient-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/clause-satisfaction-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/witnesses/clause-satisfaction-lookup-class.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- `atlas/witnesses/fixed-k-term-DNF.md`

Sibling scratchpads:

- `scratchpads/open-edge-resolution-2026-05-05/efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-weak-agnostic-improper-pac--implies--efficient-agnostic-improper-pac/scratchpad.md`

Primary-source checks and reference anchors:

- Hanneke, Moran, and Thiessen, *Marginal-Nonuniform PAC Learnability*, OpenReview 2025: `https://openreview.net/forum?id=aoVCFtox89`. Used for the quantifier pattern: rates may depend on the marginal, but must hold uniformly over target concepts once the marginal is fixed.
- Håstad and Khot, *Query Efficient PCPs with Perfect Completeness*, Theory of Computing 2005: `https://theoryofcomputing.org/articles/v001a007/`. Used for perfect completeness, logarithmic randomness, and soundness below $1/2$.
- Khot and Saket, *Hardness of Minimizing and Learning DNF Expressions*, FOCS 2008 / author PDF: `https://cs.nyu.edu/~khot/papers/minDNF.pdf`. Used for the near-miss constant-advantage proper-DNF hardness.
- Kearns and Valiant, *Cryptographic Limitations on Learning Boolean Formulae and Finite Automata*, JACM 1994, DOI `10.1145/174644.174647`. Used as the cryptographic learning-hardness anchor.
- Håstad, Impagliazzo, Levin, and Luby, *A Pseudorandom Generator from any One-way Function*, SICOMP 1999, DOI `10.1137/S0097539793244708`. Used as the standard one-way-function/PRG background for image-coordinate witnesses.
- Schapire, *The Strength of Weak Learnability*, Machine Learning 1990, DOI `10.1023/A:1022648800760`. Used to keep the boosting/proper-output distinction straight.

## Positive Route: Constant Improper Advantage Does Not Properize

On realizable labels, the source learner gives an improper $g$ satisfying

$$
\operatorname{err}_P(g,c)\le \beta<1/2
$$

for every marginal $P$ and every target $c\in\mathcal C$. This is stronger
than the target's required inverse-polynomial weak advantage, but it is still
external prediction.

A proof of the edge would need a uniform algorithm that, for every fixed
marginal $P$, turns samples and perhaps $g$ into some $h\in\mathcal C$ with
positive $P$-correlation against $c$. I could prove this only under an extra
selector assumption:

> For every fixed marginal $P$, there is a target-uniform polynomial-time
> weak proper trace selector which, from realizable labeled samples and an
> optional external predictor, outputs a proper concept weakly correlated with
> the labels.

With such a selector, the target is immediate. But the selector is not implied
by the source. The source learner may output a table, sparse support, linear
relaxation, aggregate vote, or other object outside $\mathcal C$. Validation can
check a proposed proper hypothesis, and unbounded ERM can find one in the
sample-only layer, but neither generates a valid representation efficiently.

Standard boosting also misses the point. It can improve weak prediction, but
the boosted hypothesis is normally an aggregate outside $\mathcal C$. The
assigned edge does not need stronger prediction; it needs a single proper
member of $\mathcal C$.

## False Route 1: PCP Active Slices

The PCP active-slice lookup class satisfies the assigned source, apparently by
a stronger property. The improper one-slice lookup class has polynomial
log-size/VC control and admits efficient ERM on a sample, so it gives
distribution-free agnostic improper learning against the proper PCP-proof
class. Running it at fixed constant excess error gives the weak agnostic
improper source.

For distribution-free weak proper learning, this witness is compelling. Given
an NP instance $\varphi$, sample uniformly from its active verifier-randomness
slice and label every point by $1$. Perfect completeness makes satisfiable
instances realizable, while soundness below $1/2$ means no proof concept has
weak advantage on unsatisfiable instances.

The same argument does not refute the assigned marginal-nonuniform target.
The hard marginal $P_\varphi$ depends on the input instance $\varphi$. Since
the target permits the runtime polynomial and weak advantage to depend on the
fixed marginal, a reduction from SAT would not obtain one polynomial bound
uniform in $\varphi$.

Packing all slices into one fixed marginal also fails at the weak threshold.
If

$$
P^\star=\sum_\psi w_\psi U_\psi,
$$

then the local PCP gap on the $\varphi$ slice is multiplied by $w_\varphi$.
At each formula length there are exponentially many possible $\varphi$, so
most slices have tiny mass. For a low-mass target slice, a wrong-slice proper
hypothesis that is active on another low-mass slice has global error at most
roughly $w_\varphi+w_\psi$, far below $1/2$, without revealing any accepting
proof for $\varphi$.

Thus the source strength is not the problem; the weak fixed-marginal target is.
The packed PCP construction creates legal weak proper handles.

## False Route 2: Clause-Satisfaction Lookup

The clause-satisfaction lookup class separates nearby agnostic proper targets:
under the fixed uniform-clause marginal, formula clauses can be encoded in the
conditional labels, and a sufficiently accurate proper agnostic learner would
return a satisfying assignment.

This does not separate the assigned realizable weak target. If labels are
realizable by an assignment $a$, the target distribution is just uniform over
clauses labeled by whether $a$ satisfies them. Another assignment $b$ is already
fairly close under this marginal. For random 3-clauses, $h_a$ and $h_b$
disagree only when the clause is falsified by exactly one of the two assignments;
this probability is at most $1/4$. So outputting a fixed assignment gives error
at most $1/4$ against every realizable assignment-labeling, a constant weak
advantage with no SAT solving.

The clause witness uses agnostic labels to create an inverse-polynomial proper
search gap. Once the target is realizable and only weak, that gap disappears.

## False Route 3: One-Way Image Coordinates

The one-way image-coordinate class also satisfies a stronger source. For a
length-$n$ seed $s$, the concept marks the $n$ positive atoms
$(1^n,i,f(s)_i)$. Sparse improper ERM over all at-most-$n$ positive lookup
tables gives distribution-free agnostic improper learning.

This witness refutes the strong marginal-nonuniform realizable proper target:
under the fixed all-length coordinate marginal with block mass
$\mu_n=\Theta(1/n^2)$, accuracy $\mu_n/(3n)$ forces a proper output to have
the same length and the same image as the target, hence to invert the one-way
function.

It does not refute the weak target. Under the same fixed marginal, the entire
length-$n$ challenge block has mass only $\mu_n$. A wrong-length seed, a
low-mass wrong block, or an added constant/singleton handle can have error far
below $1/2$ without recovering $f^{-1}(y)$. Concentrating the marginal on the
length-$n$ block would remove that dilution, but then the marginal varies with
$n$ and the marginal-dependent polynomial can vary with it.

The `one-way-image-coordinate-weak-handle-class` makes this diagnosis explicit:
weak proper learning can be easy through constants and singleton atoms while
strong fixed-marginal proper learning still forces inversion.

## False Route 4: Dense Code Or PRG Repairs

The most promising repair is to replace sparse image coordinates by a balanced
code. At one fixed length, define a target by a codeword $E(f(s))$ under a
uniform coordinate marginal. If every nonpreimage codeword has error at least
$1/2$, then any weakly correlated proper output yields a preimage.

This works geometrically for Hadamard/parity codewords at one length, but I did
not find a version satisfying the assigned source and the all-length
fixed-marginal target.

There are two quantitative barriers.

First, if the code domain has polynomial size $N=\operatorname{poly}(n)$, then
improper lookup ERM remains efficient and source-positive. But exponentially
many binary codewords on $N$ coordinates cannot all have one-sided nonpositive
correlation with each other. Plotkin/Hadamard-style bounds force
inverse-polynomial residual correlations for polynomial $N$. Since the target's
advantage $\gamma_P(s)$ is hidden and may be any marginal-dependent inverse
polynomial, such residual correlations can become legal weak proper handles.
A random or validated wrong seed can exploit them once the target learner is
allowed a large enough polynomial sample bound.

Second, using superpolynomial or exponential coordinate domains can make
wrong-code correlations negligible, but then lookup-style agnostic improper
learning is no longer distribution-free polynomial. Under a uniform dense
coordinate marginal, learning the external codeword becomes parity/PRG-style
agnostic learning rather than sparse memorization. That is exactly the kind of
hard problem the source is supposed to avoid.

An all-length Hadamard construction has the same tail issue as image
coordinates: if each length has its own block under one fixed finite-encoded
marginal, the length-$n$ block mass tends to zero and wrong-length/default
hypotheses become weak handles. If the marginal is changed to focus on one
length, marginal nonuniformity absorbs the change.

## False Route 5: Constant-Advantage Proper-DNF Hardness

Khot and Saket's DNF hardness is a near miss for proper weak learning: it rules
out learning two-term DNF by a fixed number of DNF terms to any fixed constant
advantage over random guessing, under $\mathrm{NP}\nsubseteq\mathrm{RP}$.

The atlas target uses the weaker inverse-polynomial convention. Fixed-$k$ term
DNF remains a weak proper learner at inverse-polynomial advantage, so this does
not give a counterexample to the assigned edge.

## Proposed Atlas Update

No status change is justified. Keep:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
argument_note: "[[properization-open|Properization Open]]"
```

Optional replacement summary if atlas edits are later allowed:

```yaml
summary: "Open: the source gives a distribution-free constant-advantage improper predictor on realizable data, but no generic efficient fixed-marginal selector for even a weakly correlated proper hypothesis is known; PCP, clause, one-way, and dense-code witnesses all leak weak proper handles or use input-dependent marginals."
```

Optional body sketch:

```markdown
`open`.

On realizable labels the weak agnostic improper source gives an external
hypothesis of error at most a fixed beta < 1/2 under every marginal. The target
requires only a marginal-dependent inverse-polynomial weak advantage, but the
output must lie in C. A positive proof would need an efficient fixed-marginal
weak proper selector, or projection theorem, turning external prediction into a
valid concept representation. No such selector follows from the abstract
source.

Known witnesses remain near misses. PCP active-slice hardness gives
distribution-free weak proper lower bounds, but the hard marginal varies with
the NP instance, and packing slices into one fixed marginal dilutes the weak
gap. Clause-satisfaction lookup separates agnostic proper learning but becomes
weakly easy on realizable assignment labels. One-way image-coordinate classes
force strong fixed-marginal recovery, but wrong-length, low-mass, constant, or
singleton handles already beat random guessing. Dense code repairs would need
polynomial-domain lookup learnability together with negligible positive
correlation between all wrong proper codewords, which conflicts with standard
coding bounds at the hidden inverse-polynomial weak scale.
```

## Obstacles

1. **Proper trace selection.** The target concept exists and the source can
   predict it externally, but no efficient map from external prediction or a
   labeled trace to a proper representation is supplied.

2. **Marginal-dependent hard instances.** PCP lower bounds put the hard
   instance into the marginal. Marginal nonuniformity lets the target's
   resource polynomial and weak advantage depend on that marginal.

3. **Weak-handle leakage.** Sparse proper-hardness witnesses usually contain
   wrong-slice, wrong-length, constant, singleton, or low-support concepts that
   are already good enough for a weak global threshold.

4. **Hidden weak exponent.** To refute the target, a fixed-marginal code
   witness must block every inverse-polynomial proper correlation, not just a
   chosen constant or chosen polynomial scale.

5. **Source versus balance tension.** Polynomial-size domains make improper
   lookup ERM easy but leave residual correlations; balanced superpolynomial
   domains remove residual correlations but tend to make the improper agnostic
   source hard.

## Depth-2 Directions

1. Formalize a fixed-marginal weak proper selector condition and prove the
   conditional theorem: assigned source plus selector implies the target. Then
   classify standard concept classes by whether they have such selectors.

2. Prove a reusable packed-PCP barrier lemma: in any fixed mixture of active
   slices, low-mass target slices admit wrong-slice proper weak handles unless
   a large target-dependent balancing region is added.

3. Try a PRG-code witness under a stronger assumption than one-wayness: given
   $y=G(s)$, finding any seed $t$ whose $G(t)$ has inverse-polynomial positive
   correlation with $y$ is hard. The construction must still keep the improper
   agnostic learner polynomial under arbitrary marginals.

4. Revisit finite-code bounds quantitatively. An atlas-useful lemma would say
   that polynomial-domain lookup-learnable dense-code witnesses cannot rule out
   a marginal-nonuniform weak target because some wrong proper handles remain at
   an inverse-polynomial scale.

5. Check whether a schema variant with a fixed constant weak advantage in the
   target is intended anywhere. Under that stronger target convention, PCP and
   polynomial-code witnesses would become much closer to decisive; under the
   current inverse-polynomial convention they remain near misses.

verdict: unresolved-open
confidence: medium-high

## Depth 3 Branch: agnostic improper source to weak realizable proper

- depth: 3
- date: 2026-05-05
- edge: `efficient-weak-agnostic-improper-pac -> efficient-marginal-nonuniform-weak-realizable-proper-pac`
- prior: unresolved fixed-marginal weak proper selection
- atlas files edited: none

### Branch Question

Can the agnostic improper source be used as more than a predictor? In the
realizable target setting, running the source learner on labels
$Y=c(X)$ gives an external hypothesis $g$ with

$$
\operatorname{err}_P(g,c)\le \beta<1/2.
$$

This is already a clean constant-advantage signal under the same marginal. The
question is whether that signal can be converted into a proper handle
$h\in\mathcal C$ with

$$
\operatorname{err}_P(h,c)\le \frac12-\frac1{\operatorname{poly}_P(s)}.
$$

The depth-3 conclusion is that the agnostic nature of the source does not
appear to add the missing representation-level step. It gives useful labels,
and even a useful external predictor, but it does not identify a legal proper
description or a finite list of legal descriptions to validate.

### What The Source Actually Adds

In the realizable reduction, the source has three possible uses:

1. Run it directly on the clean labeled sample and obtain $g$.
2. Run it repeatedly on reweighted samples, as in weak-to-strong boosting.
3. Use $g$ to pseudo-label fresh points or to define a high-agreement region.

All three stay external. A boosted aggregate is still normally outside
$\mathcal C$. Pseudo-labeling by $g$ produces a noisy agnostic instance whose
best proper concept is still $c$, but finding even a weakly correlated proper
concept for that pseudo-labeled instance is exactly a proper agnostic
projection/selection problem. A high-agreement region is also not certified:
the learner can estimate where $g$ agrees with observed labels, but this does
not produce an efficiently searchable proper trace off-sample.

The original clean samples already contain realizable information. The hard
part is not obtaining clean labels; the learner has them. The hard part is
finding a valid representation in $\mathcal C$ that explains enough of the
fixed marginal. The source learner is allowed to solve prediction by leaving
the representation class, so its output may be a table, relaxation, ensemble,
linear separator in a lifted space, or other object with no efficiently
recoverable concept inside $\mathcal C$.

Thus a black-box positive proof would need an extra projection principle:

> If an efficient algorithm can produce an external $g$ with constant positive
> $P$-correlation with every target $c\in\mathcal C$, then another efficient
> algorithm can output some $h\in\mathcal C$ with inverse-polynomial positive
> $P$-correlation with $c$.

This principle is not implied by the source definition. It is essentially the
unresolved fixed-marginal weak proper selector.

### PCP Template Check

The PCP active-slice template shows why the source can contain plenty of clean
information without yielding a proper handle. On the active slice for an
instance $\varphi$, realizable labels may be the all-accepting pattern supplied
by a satisfying proof. An improper learner can predict the slice labels by a
lookup or external table. A proper weak learner, however, must output a proof
accepted on more than half the verifier random strings; under perfect
completeness and soundness below $1/2$, that would distinguish satisfiable
from unsatisfiable instances.

This is a genuine obstruction for distribution-free weak proper learning or
for a marginal chosen from the instance. It still does not settle the assigned
marginal-nonuniform target. The target permits the runtime polynomial and weak
advantage to depend on the fixed marginal $P$. If each hard instance
$\varphi$ uses its own active-slice marginal $P_\varphi$, a reduction does not
get one uniform polynomial bound over $\varphi$.

Packing all active slices into one fixed marginal $P^\star$ again loses the
weak gap. The local PCP advantage on slice $\varphi$ is multiplied by the
global slice mass $w_\varphi$. Low-mass slices can be ignored, and
wrong-slice or prefix concepts become legal weak proper handles. The agnostic
improper source does not repair this: it can learn the slice labels, but the
target learner is not forced to solve the low-mass slice when an easier weak
proper correlation is available elsewhere.

### One-Way Template Check

The one-way template is the cleanest illustration that external information
can be very informative and still not proper. A source learner may recover an
image string $y=f(s)$ or a lookup table derived from it. That is enough to
predict labels, but it need not reveal a seed $s$ whose proper concept is the
target. At a single fixed length, a dense Hadamard-style image code makes this
sharp: under the uniform coordinate marginal, any proper seed with positive
correlation with the target codeword must have the same image, so a weak
proper learner would invert or find a preimage.

This is the closest false branch, but it still fails the atlas edge for the
same fixed-marginal reasons. If the marginal is the uniform length-$n$
marginal, it varies with $n$ and marginal nonuniformity absorbs the variation.
If all lengths are packed into one finite-string marginal, the length-$n$
block has tail mass $\mu_n$, so weak learning can ignore it or use
wrong-length/default handles. Sparse coordinate versions keep the improper
source easy but leak weak handles; dense code versions remove handles locally
but make distribution-free agnostic improper learning look like parity or
noisy-codeword learning.

So the one-way branch suggests the right kind of counterexample but not an
atlas-ready one: every inverse-polynomially correlated proper output would
need to decode a hard witness under one fixed finite-encoded marginal, while
an improper agnostic learner remains efficient under arbitrary marginals.

### Interim Synthesis

The agnostic improper source gives enough clean realizable information for
prediction, and in some templates it can even reveal the complete external
object underlying the labels. But weak realizable proper learning is a
selection problem, not a prediction problem. The missing operation is to turn
external information into one legal concept with positive correlation under a
fixed marginal.

The checked false templates show two incompatible pressures:

- PCP and one-length one-way constructions can make weak proper selection
  computationally meaningful, but their hard marginals vary with the instance
  or length.
- Fixed-marginal packings respect the target quantifiers, but they dilute the
  hard region and create weak proper handles.

The checked positive routes also stop at the same point:

- validation can certify a candidate proper handle but cannot generate one;
- boosting improves external prediction but does not make the final output
  proper;
- pseudo-labeling reduces to proper agnostic projection;
- finite-trace enumeration would nearly solve the target only after adding
  stronger representation and stopping semantics, and then the improper source
  is not doing the main work.

### Verdict

`unresolved-open`.

The depth-3 branch does not justify an atlas status change. The source's
agnostic improper guarantee supplies constant-advantage external prediction on
realizable data, but it does not by itself provide an efficient fixed-marginal
weak proper selector. PCP and one-way templates remain strong evidence for the
shape of a separation, yet the versions checked either use input-dependent
marginals or leak weak proper handles when packed into one fixed marginal.

### Confidence

medium-high that the edge should remain open under the current atlas
semantics; high that the agnostic improper source does not, by itself, solve
the proper selection step; medium that a refined one-way dense-code template is
the closest plausible false route but still lacks a fixed finite-string
marginal construction satisfying the source.

### Next Branches

1. Formalize the required projection principle as a standalone
   fixed-marginal weak proper selector condition, then prove the conditional
   implication from the source plus this selector.

2. Try to build a fixed-marginal one-way code where every
   inverse-polynomially correlated proper hypothesis decodes a preimage, while
   an external agnostic learner remains polynomial under arbitrary marginals.

3. Prove a packed-PCP weak-handle barrier lemma: any fixed mixture of
   instance slices with sufficiently small slice masses admits a target-
   independent weak proper handle unless an additional balancing gadget is
   introduced.

4. Audit the representation semantics needed for finite-trace enumeration. If
   legal proper concepts are recursively enumerable with effective evaluation
   and a usable stopping certificate, the weak marginal-nonuniform proper
   target may become broadly positive independently of the source.

---

## Depth 4 Follow-Up - Selector Lemma And Witness Audit, 2026-05-05

- depth: 4
- date: 2026-05-05
- edge: `efficient-weak-agnostic-improper-pac -> efficient-marginal-nonuniform-weak-realizable-proper-pac`
- verdict: unresolved-open
- confidence: high that the source gives only external prediction; medium-high that known properization witnesses still miss the fixed-marginal weak target
- atlas files edited: none

### Goal

Try one level harder on both directions.

For a positive proof, use the full strength of the source: it is
distribution-free weak agnostic improper with a fixed additive tolerance
$\beta<1/2$, not merely marginal-nonuniform. On realizable data this gives,
under every fixed marginal $P$ and every target $c\in\mathcal C$, an external
predictor $g$ such that

$$
\operatorname{err}_P(g,c)\le \beta
$$

or, in $\{\pm1\}$ notation,

$$
\mathbb E_P[g(X)c(X)]\ge 1-2\beta =: \alpha>0.
$$

The target asks for less accuracy but insists on a legal proper output
$h\in\mathcal C$ with inverse-polynomial positive correlation. The question is
whether the clean labels plus this constant-correlation external predictor can
force a proper weak hypothesis under each fixed marginal.

For a negative proof, look specifically for a class that is source-positive
because improper prediction is easy, but target-negative because every proper
weak output under one fixed marginal would solve a hard search problem.

### Conditional Positive Result: Validation Is Easy Once Candidates Exist

The useful positive statement is a validation-selector lemma.

Assume there is a uniform procedure $S$ with the following property. For every
fixed marginal $P$, there are a $P$-dependent polynomial $q_P$ and an
inverse-polynomial $\eta_P(s)$ such that, given realizable samples from
$(P,c)$ and optional evaluation access to the source output $g$, $S$ runs in
time $q_P(s,\log(1/\delta))$ and outputs a list

$$
L\subseteq\mathcal C,\qquad |L|\le q_P(s,\log(1/\delta)),
$$

with probability at least $1-\delta$, such that some $h\in L$ satisfies

$$
\mathbb E_P[h(X)c(X)]\ge 4\eta_P(s).
$$

Then the target follows. Run the source learner to get $g$, run $S$ to get
$L$, and validate the candidates on fresh realizable samples. Since the weak
advantage exponent hidden in $\eta_P$ is not known, use phases
$k=1,2,\ldots$ and in phase $k$ accept a candidate whose empirical correlation
is at least $2s^{-k}$. A Hoeffding bound over the polynomial list and over
phases guarantees that an accepted candidate has true correlation at least
$s^{-k}$, while once $s^{-k}$ is below the promised $\eta_P(s)$ a good
candidate is accepted. The total time through that phase is bounded by a
$P$-dependent polynomial.

Thus the source plus a fixed-marginal polynomial proper candidate generator
would prove the edge.

### Why The Source Does Not Supply The Selector

The source learner is a predictor oracle, not a representation oracle. It may
return a table, a sparse set, a lifted separator, a parity coefficient, an
ensemble, or any other external object. The guarantee constrains only its
error against the best proper concept.

Several attempts to mine a proper candidate list from the source collapse back
to the same missing operation.

1. **Validate all sample-consistent proper concepts.** This would work after a
   polynomial candidate generator exists. But generating legal proper
   representations consistent with a sample is proper consistency or proper
   ERM, exactly the problem the edge asks about.

2. **Use $g$ as a surrogate labeler.** A proper hypothesis that weakly agrees
   with $g$ need not weakly agree with $c$. If $g$ is only weakly correlated
   with $c$, two functions can each have small positive correlation with $g$
   while having zero or negative mutual correlation. Optimizing agreement with
   $g$ is also itself a proper optimization problem.

3. **Rerun the agnostic source on derived labels.** Relabeling by $g$,
   disagreement bits, or residuals only produces more improper predictors.
   Boosting these predictors improves external prediction but normally leaves
   the final aggregate outside $\mathcal C$.

4. **Enumerate source transcripts.** The transcript tree of a polynomial-time
   improper learner contains polynomially many external objects at any fixed
   phase. Nothing in the source definition maps those objects to legal concepts.

The clean labels are also not enough by themselves. They let validation certify
a proposed proper hypothesis, but they do not reveal a valid representation.
The target concept $c$ exists, yet finding any weakly correlated representation
of a concept in $\mathcal C$ can still be the computational bottleneck.

### Near-Positive Finite-Trace Observation

There is one important boundary case. If a fixed marginal $P$ is effectively
covered by a constant-size high-mass finite trace, and legal proper
representations can be recursively enumerated and evaluated, then weak proper
learning is plausible without using the source.

Choose a finite set $F$ with $P(F)>3/4$. For every realizable trace
$\tau:F\to\{\pm1\}$, pick the first proper concept in an enumeration realizing
that trace. There are at most $2^{|F|}$ representatives, a $P$-dependent
constant. A uniform dovetailing learner can eventually enumerate those
representatives and validation will select one agreeing with the target on
$F$, hence with error below $1/4$.

This is not an atlas-ready proof of the assigned edge. It depends on
representation semantics not stated in the node, and it uses a constant-size
high-mass trace. For arbitrary marginals, especially nonatomic or
large-effective-support marginals, a constant-error cover by proper concepts
may have size exponential in the target size. Marginal nonuniformity permits
the polynomial's constants and exponent to depend on $P$, but the running time
must still be polynomial in the representation size, not exponential in it.

So the finite-trace route clarifies the boundary: the edge would be broadly
true for classes with efficient fixed-$P$ proper trace representatives, weak
covers, or approximate proper ERM. The source assumption alone does not provide
any of these structures.

### Source-Positive, Target-Negative Witness Search

A false witness must satisfy a demanding combination:

- distribution-free weak agnostic improper learning is efficient;
- there is one fixed marginal $P^\star$ and realizable targets under
  $P^\star$;
- every polynomial-time proper learner fails to find even an
  inverse-polynomially correlated proper hypothesis for some target.

The standard templates remain near misses.

**PCP active slices.** This class is source-positive in a strong sense:
one-slice lookup-table ERM gives agnostic improper learning against the proper
PCP-proof class. It also refutes distribution-free weak proper learning when
the marginal is the active verifier-randomness slice of the input formula.
But that hard marginal depends on the formula. Marginal nonuniformity lets the
target's polynomial and weak advantage depend on that formula-specific
marginal. Packing all formula slices into one fixed marginal multiplies the
local PCP gap by the slice weight, and low-mass slices admit wrong-slice or
mostly-zero proper weak handles.

**Clause-satisfaction lookup.** The improper lookup side is easy on the
polynomial clause universe, and fixed-marginal agnostic proper hardness works
when the input formula is encoded in noisy conditional labels. The assigned
target is realizable and weak. Under realizable assignment labels, unrelated
assignments still agree on most clauses, so weak proper handles are plentiful.
Concentrating only on the formula's clauses makes the marginal input-dependent
again.

**One-way image coordinates.** Sparse image-coordinate classes are source
positive by sparse improper ERM and give strong fixed-marginal proper recovery
hardness. They do not give weak hardness. Under the all-length fixed marginal,
wrong lengths, low-mass blocks, constants, singleton handles, or other sparse
proper concepts can beat random guessing without inverting the one-way
function.

**Dense one-way/Hadamard repairs.** At one fixed length, the construction

$$
c_s(r)=\langle f(s),r\rangle \pmod 2
$$

has exactly the desired flavor: an improper learner can output the image
coefficient $f(s)$, while any positive-correlation proper seed recovers a
preimage. The all-length fixed-marginal version still leaks weak handles.
Disjoint length blocks give inactive-complement agreement. Shared finite
coordinate systems run into coding bounds: exponentially many proper
certificates on polynomially many coordinates cannot all have correlation
below every inverse-polynomial threshold. Exact orthogonality uses
superpolynomial or atomless structure, which either breaks the source's
polynomial improper learner or leaves the atlas's finite-transcript setting.

The remaining false route would need computational weak-handle hardness rather
than geometric absence of handles: weakly correlated proper concepts may
exist, but finding any of them from samples would have to decode a proof,
satisfying assignment, preimage, or other hard certificate. I do not know a
standard PCP, DNF, one-way, PRF, or coding witness that achieves this while
preserving the distribution-free weak agnostic improper source.

### Verdict

`unresolved-open`.

The depth-4 pass does not justify `resolved-true` or `resolved-false`.

The positive route reduces the edge to a fixed-marginal weak proper selector:
source learner plus polynomial proper candidate generation plus validation
would prove the target. The source gives a constant-advantage external
predictor on realizable data, but it does not generate legal concepts.

The negative route still lacks a source-positive/target-negative witness.
Known properization witnesses either use input-dependent hard marginals, prove
only strong proper recovery hardness, or leak weak proper handles under one
fixed marginal. A future separation needs computational weak-handle hardness
under a fixed marginal, not merely a sparse or dense code with no wrong
correlates.

### Obstacles

1. **Selector gap.** Validation can certify proper candidates, but the source
   does not produce a polynomial list of legal concepts.

2. **Fixed-marginal quantifiers.** Slice-local PCP and DNF hardness loses force
   because the target's resource polynomial may depend on the slice marginal.

3. **Weak-handle leakage.** Sparse, packed, or all-length witnesses expose
   wrong-slice, wrong-length, constant, singleton, short-sketch, or residual
   codeword handles that already satisfy the weak target.

4. **Hidden inverse-polynomial scale.** A counterexample must defeat every
   marginal-dependent inverse-polynomial advantage, not just a chosen constant
   or chosen exponent.

5. **Representation semantics.** Finite-trace dovetailing suggests broad
   positive results under enumerable/evaluable proper representations and
   small high-mass traces, but the atlas node does not state enough structure
   to turn that into an unconditional theorem.

### Next Directions

1. Formalize the validation-selector lemma as a reusable conditional theorem
   for edges from improper sources to weak proper marginal targets.

2. Decide whether computational atlas nodes implicitly assume recursively
   enumerable proper representations with polynomial-time evaluation. If so,
   revisit finite-trace and fixed-$P$ cover dovetailing carefully.

3. Search for fixed-marginal computational weak-handle hardness: every
   validation-findable weak proper output should decode a hard certificate,
   while the improper learner remains distribution-free weak agnostic.

4. Try a model-boundary Hadamard/image construction only if the atlas permits
   atomless or succinct infinite-coordinate samples; under the current
   finite-transcript convention it remains diagnostic, not a witness.

5. Recheck DNF/PCP literature only for inverse-polynomial weak proper hardness
   under one universal marginal with labels encoding the instance. Constant
   advantage or instance-dependent distributions are not enough for this edge.

---

## Depth 5 Follow-Up - Fixed-Marginal Weak Selector Hardness, 2026-05-05

- depth: 5
- date: 2026-05-05
- edge: `efficient-weak-agnostic-improper-pac -> efficient-marginal-nonuniform-weak-realizable-proper-pac`
- verdict: unresolved-open
- confidence: high that any false witness must prove fixed-marginal weak selector hardness; medium-high that current source-positive templates do not
- atlas files edited: none

### Refined Goal

At this depth I focused on the exact extra power supplied by the source in the
target's realizable setting.

Fix a marginal $P$ and a target $c\in\mathcal C$. Because the data are
realizable, the weak agnostic improper source can be run by the target learner
itself. With high probability it returns an external hypothesis $g$ satisfying

$$
\operatorname{err}_P(g,c)\le \beta<1/2,
\qquad
\text{equivalently}\qquad
\langle g,c\rangle_P\ge \alpha:=1-2\beta>0
$$

in $\{\pm1\}$ notation.

So a counterexample to the edge cannot merely say that the labels are hard to
predict. They are not hard to predict: the source provides a constant-advantage
predictor under the same fixed marginal. A counterexample must say something
stronger:

> Even given realizable samples and the external predictor that the source
> computes, no polynomial-time algorithm can find any legal
> $h\in\mathcal C$ with inverse-polynomial positive correlation with $c$ under
> the fixed marginal.

This is the fixed-marginal weak selector hardness problem. It is strictly more
specific than ordinary proper learning hardness, because the learner may first
compute a useful improper description of the target behavior.

### Why Realizable Weak Agnostic Improper Learning Is Not Enough

The tempting positive proof is:

1. learn $g$ improperly from realizable samples;
2. use $g$ to identify a region where $c$ has bias;
3. output a proper concept that captures that bias.

The second step is real, but the third step is not supplied by the source. From
samples one can estimate that $g$ has positive correlation with $c$, and one can
validate any proposed proper $h$. But there is no generic way to generate the
proper candidates to validate.

More concretely, the source output can be a lookup table, a lifted linear
separator, a low-degree surrogate, an ensemble, a decoded image string, or a
sample-dependent object. None of these need contain a short legal description
of a concept in $\mathcal C$. Agreement with $g$ is also not enough: two
functions can each be positively correlated with $g$ while being uncorrelated,
or negatively correlated, with each other. Thus optimizing proper agreement
with $g$ is just another proper search problem.

The source helps only after a selector exists. If a fixed-$P$ procedure outputs
a polynomial list of proper candidates containing one with correlation
$\Omega(1/\operatorname{poly}_P(s))$, validation turns it into the target
learner. Without such a procedure, the source's contribution stops at external
prediction.

### Required Shape Of A False Witness

A source-positive, target-negative witness for this edge has to satisfy all of
the following at once.

1. **Source positivity.** There is a distribution-free polynomial-time weak
   agnostic improper learner for $\mathcal C$. In particular, on realizable
   data it can output a useful external predictor for every marginal.

2. **One fixed hard marginal.** There is a single marginal $P^\star$ used for
   infinitely many target representations. The target's polynomial and weak
   advantage may depend on $P^\star$, so the hardness cannot come from changing
   the marginal with the instance.

3. **Weak selector hardness.** For some family of targets
   $c_z\in\mathcal C$, finding any $h\in\mathcal C$ with
   $\langle h,c_z\rangle_{P^\star}\ge 1/\operatorname{poly}(|z|)$ is hard,
   even when the learner can compute or receive the source's external
   predictor for $c_z$.

4. **No easy handles.** Constants, wrong-length concepts, wrong-slice
   concepts, singleton concepts, low-mass concepts, residual code correlations,
   and default behavior outside the active region must not already provide the
   inverse-polynomial weak advantage.

The fourth item is the sticking point. Known witnesses usually make strong
proper recovery hard, but weak learning can use a handle that is much less
informative than a full certificate.

### Witness Audit At The Selector Level

**PCP active slices.** The selector hardness is excellent on a single active
slice: a proper weak hypothesis is a PCP proof accepted on more than half of
the verifier coins. But the slice marginal depends on the formula. Packing
slices into one $P^\star$ multiplies the local gap by the slice weight. Unless
the construction prevents all wrong-slice and default concepts from gaining
weak global correlation, low-mass slices become harmless to the target learner.
The source learner can still memorize the slice labels, but that only
emphasizes the issue: prediction is easy while fixed-marginal weak selection
has not been made hard.

**Clause-satisfaction lookup.** A fixed clause marginal can encode an agnostic
proper hardness instance through the conditional labels, but the assigned
target is realizable. Under realizable assignment labels, many unrelated
assignments agree with the target on a constant majority of random clauses.
Those assignments are proper weak handles. The hardness is therefore about
finding an optimum or satisfying assignment, not about finding any
weakly-correlated proper hypothesis.

**One-way image coordinates.** Sparse image-coordinate classes have the right
representation-recovery hardness for strong accuracy: a sufficiently accurate
proper output must give a preimage. But for weak accuracy under an all-length
fixed marginal, a learner can use constants, low-mass blocks, singleton
positive atoms, or wrong-length behavior. Adding explicit weak handles makes
this diagnosis formal in the atlas: weak proper learning can be easy while
strong proper recovery still inverts the one-way function.

**Dense image codes.** A one-length Hadamard-style code has the cleanest local
selector statement: positive correlation with the target codeword can force a
preimage. The trouble is globalizing it to one fixed finite-string marginal
while keeping the source distribution-free weak agnostic improper. If lengths
are separated into blocks, active mass tends to zero and weak handles reappear.
If all targets share a polynomial coordinate set, coding bounds leave residual
inverse-polynomial correlations among wrong proper codewords. If the coordinate
set is superpolynomial or atomless, the improper source is no longer an easy
lookup-style learner in the atlas's finite-transcript setting.

### What A Real Separation Would Need To Prove

The missing theorem is a computational weak-handle lower bound, not a geometric
absence-of-handles statement. It would be enough to construct a class where
weakly correlated proper hypotheses may exist, but finding any of them under
the fixed marginal is computationally equivalent to finding a proof, a
satisfying assignment, a preimage, or another hard witness.

The source-positive side then has to explain why the same hard witness is not
needed for improper prediction. The external learner must be able to predict
using a relaxation, table, decoded public image, or other object that preserves
label behavior without yielding a proper representation. This is a narrow
requirement. Many cryptographic candidates make prediction itself hard; many
PCP candidates make prediction easy only on instance-dependent marginals; many
lookup candidates make prediction easy but also expose weak proper handles.

### Verdict

`unresolved-open`.

The depth-5 analysis does not resolve the edge. It sharpens the open problem:
the source already gives constant-advantage improper prediction on realizable
data, so a false proof must establish fixed-marginal weak selector hardness
even in the presence of that external predictor. I do not see such a witness in
the current PCP, clause, one-way-coordinate, weak-handle, or dense-code
templates. Conversely, the positive proof still requires an additional
selector or candidate-generation principle not implied by the source.

### Obstacles

1. **External prediction is available.** Any target learner can run the source
   first, so target-negative hardness must survive the presence of $g$.

2. **Candidate generation remains missing.** Validation turns a proposed
   proper weak handle into a learner, but the source does not generate a
   polynomial candidate list in $\mathcal C$.

3. **Fixed-marginal dilution.** Packing hard instances into one marginal
   shrinks local gaps and allows the hidden target advantage to be chosen at a
   marginal-dependent inverse-polynomial scale.

4. **Weak handles are too cheap.** Strong recovery witnesses fail because the
   weak target accepts any positive-correlation proper concept, not necessarily
   the true certificate.

5. **Source positivity conflicts with hard balanced codes.** Making every weak
   proper correlate decode a hard witness tends to make improper agnostic
   prediction hard as well, unless a special external relaxation is available.

### Concrete Depth-6 Directions

1. Formalize a "fixed-marginal weak selector" search problem with oracle or
   description access to the source output $g$, and record the conditional
   theorem: source plus selector implies the target.

2. Search specifically for cryptographic correlation-search assumptions: given
   a public external predictor for $c_z$, finding any proper
   inverse-polynomial correlate under one fixed marginal is hard, while
   prediction remains easy.

3. Prove a packed-slice barrier lemma for PCP-style witnesses: under any fixed
   summable mixture of active slices, either the hard slice has enough mass to
   be one of only polynomially many relevant slices, or wrong-slice/default
   proper concepts give weak handles.

4. Quantify the dense-code obstruction: for polynomial coordinate domains,
   show that a large proper family must contain wrong codewords with
   inverse-polynomial positive correlation at some target sizes, matching the
   hidden weak advantage scale.

5. Revisit finite-trace dovetailing under explicit representation assumptions.
   If proper concepts are effectively enumerable and fixed marginals admit
   polynomial-size high-mass trace covers, the edge may become conditionally
   true for a broad subclass independent of the improper source.

---

## Depth 6 Final Attempt - Fixed-Marginal Weak Selector Hardness With External Prediction, 2026-05-05

- depth: 6
- date: 2026-05-05
- edge: `efficient-weak-agnostic-improper-pac -> efficient-marginal-nonuniform-weak-realizable-proper-pac`
- verdict: unresolved-open
- confidence: high that the edge should remain in `properization-open`; high that current PCP/one-way/dense-code templates do not prove a separation; medium that a conditional selector lemma is the right atlas-facing abstraction
- atlas files edited: none

### Final Reduction Of The Question

Use $\{\pm 1\}$ notation. On a realizable distribution
$(X,c(X))$ with $X\sim P$, the source learner gives, in polynomial time and
with high probability, an external hypothesis $g$ with

$$
\mathbf E_P[g(X)c(X)] \ge \alpha
$$

for a fixed constant $\alpha>0$. Therefore the edge is not asking whether the
labels can be predicted. They can. It is asking whether external prediction
can be converted into a legal representation from $\mathcal C$ under a fixed
marginal.

The exact missing primitive is:

> **Fixed-marginal weak selector with external predictor.** For every fixed
> marginal $P$, there is one polynomial $q_P$ such that, given labeled samples
> from any realizable target $c\in\mathcal C$ of size $s$ and optional oracle
> or circuit access to any $g$ with $\mathbf E_P[gc]\ge\alpha$, the selector
> outputs some $h\in\mathcal C$ with
> $\mathbf E_P[hc]\ge 1/q_P(s)$ in time $q_P(s,\log(1/\delta))$.

If this selector exists, the target follows: run the weak agnostic improper
source to obtain $g$, run the selector, and validate the selected proper
candidate on fresh realizable samples. Conversely, any counterexample to the
assigned edge must refute this selector even though $g$ is available. This is
stronger than ordinary proper-learning hardness and stronger than
representation-recovery hardness.

### Cryptographic Correlation-Search Route

The most direct false route would be a cryptographic correlation-search
assumption:

Given a public object $u_z$ from which an improper circuit $g_z$ predicts
$c_z$ with constant correlation under one fixed marginal $P^\star$, it is hard
to find any legal key $h\in\mathcal C$ with
$\mathbf E_{P^\star}[h c_z]\ge 1/\operatorname{poly}(|z|)$.

This would match the edge perfectly. The source learner would recover or use
the public predictor $g_z$, while proper weak learning would solve the
correlation-search problem.

I do not see an atlas-ready instantiation. Standard PRF-style assumptions make
prediction itself hard, so they violate the source. One-way image-coordinate
classes make prediction easy from the image bits and make exact proper
recovery hard, but weak proper correlation is too cheap: constants,
singletons, wrong lengths, or low-mass active blocks can already be legal weak
outputs. Hadamardizing the image makes local positive correlation decode the
image at one length, but the all-length fixed-marginal version again leaks
wrong-length/default handles unless the active length has nonvanishing mass.

Thus the needed assumption is not just "proper recovery is hard." It must say
that *every efficiently findable weak proper correlate*, not merely every
accurate proper hypothesis, yields the cryptographic witness. That is a much
sharper and currently unrecorded hardness primitive.

### Packed-Slice Barrier

PCP active slices have the right local behavior. On the active marginal
$U_\varphi$, weak proper learning distinguishes satisfiable instances from
soundness-below-$1/2$ instances. The source remains positive because an
improper one-slice table ERM can memorize or majority-label the polynomial-size
active slice.

The barrier is the fixed marginal. Suppose one packs instances into

$$
P^\star=\sum_z w_z U_z .
$$

For any localized satisfiable target whose nondefault behavior lives on slice
$z$, the global advantage of a proof over the local default is multiplied by
$w_z$. Worse, if the target has common default behavior off the active slice,
then the default concept has error at most about $w_z$ against that target.
For all but finitely many slices, $w_z<1/2-1/\operatorname{poly}(|z|)$ for
many polynomial scales, so the default output is already a valid weak proper
handle if it is legal.

Trying to remove the default handle by forcing every target to be balanced
under $P^\star$ creates a packing problem: infinitely many hard slices cannot
all carry constant mass, and sharing mass across slices creates cross-instance
proper hypotheses that need not decode the intended proof. At length $n$ there
are exponentially many possible instances; under any summable fixed mixture,
only polynomially many can have inverse-polynomial mass above a given threshold.
A SAT reduction would need hardness on the low-mass majority, but weak learning
is allowed to ignore such slices through default or wrong-slice behavior.

This is the packed-slice obstruction in atlas terms: local PCP hardness is
lost either by marginal dependence or by weak handles introduced by the
mixture.

### Dense-Code Bounds

The dense-code repair tries to remove weak handles geometrically. Encode each
proper certificate as a balanced codeword over a shared coordinate space, and
ask that every wrong proper certificate have nonpositive, or at least
negligible, correlation with the target codeword. Then any weak proper output
would decode the hidden certificate.

There are two barriers.

First, exact nonpositive correlation is too expensive on a finite explicit
coordinate set. In a domain of size $N$, one cannot have an unbounded
exponential family of balanced $\{\pm1\}$ vectors with all pairwise weighted
inner products nonpositive; the Gram-rank/simplex obstruction behind
Plotkin-style bounds gives only linear-scale exact packing.

Second, approximate safety at polynomial coordinate size leaves precisely the
wrong scale. If $N=\operatorname{poly}(s)$ so that lookup-style improper ERM
can remain efficient, then large families of binary codewords near distance
$1/2$ inevitably leave residual inverse-polynomial correlations somewhere
unless the family size is drastically limited. Those residual correlations
are already large enough for the marginal-nonuniform weak target, whose
advantage exponent is hidden inside $P^\star$.

This does not prove a positive theorem, because existence of correlated wrong
codewords is not an efficient selector. But it rules out the clean geometric
separation strategy. A successful dense-code counterexample would have to
prove computational hardness of finding any residual correlate, while still
allowing the source to find an external constant-correlate predictor. I do not
know such a construction.

### Finite-Trace Positive Near Miss

There is also a positive near miss under stronger representation assumptions.
Fix $P$. Suppose that for every size $s$ there is a computable trace set
$T_{P,s}$ with $P(T_{P,s})\ge 1-1/\operatorname{poly}_P(s)$ and
`poly_P(s)` many atoms, and suppose the representation admits a polynomial-time
proper selector over traces:

Given a labeled trace, or given a predictor $g$ on the trace, find a valid
$h\in\mathcal C$ whose trace correlation is within inverse-polynomial slack of
the best valid trace correlation.

Then the edge follows for that class. The true target $c$ is itself a valid
proper trace with perfect correlation, the high-mass trace transfers
correlation back to $P$, and validation on fresh samples orients the output.

This is not an atlas theorem. The current nodes do not assume computable
high-mass traces, polynomially many distinct legal traces, polynomial-time
proper consistency, or a trace-level optimization oracle. Effective
enumerability alone is insufficient: enumerating all size-$s$ proper
representations can be exponential, and the source hypothesis $g$ does not
identify which legal trace should be selected.

The finite-trace analysis therefore supports a conditional positive lemma,
not a resolution of the abstract edge.

### Atlas-Facing Synthesis

No status change is justified. Keep the edge:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
argument_note: "[[properization-open|Properization Open]]"
```

Recommended replacement summary, if the implication note is later edited:

```yaml
summary: "Open: on realizable data the source supplies a constant-advantage external predictor, but no generic fixed-marginal weak selector is known for producing an inverse-polynomially correlated proper hypothesis; PCP slices, cryptographic image classes, and dense-code repairs either use input-dependent marginals, leak weak handles, or require extra representation-level selector assumptions."
```

Recommended family placement: keep `properization-open`. This edge is not
primarily a boosting problem, because prediction is already weakly solved by
the source. It is not primarily marginal uniformization either, because the
target is already marginal-nonuniform. The live obstruction is efficient
proper candidate generation under a fixed marginal.

### Missing Lemma To Record Elsewhere

The reusable conditional theorem should be:

> **Source plus fixed-marginal weak selector implies weak proper target.**
> If $\mathcal C$ has efficient weak agnostic improper learning and admits a
> fixed-marginal weak selector with access to the source's external predictor,
> then $\mathcal C$ satisfies efficient marginal-nonuniform weak realizable
> proper PAC learning.

The reusable lower-bound target should be:

> **Fixed-marginal weak selector hardness.** Construct a class satisfying
> efficient weak agnostic improper learning and a fixed marginal $P^\star$
> such that, even given the source's external predictor, finding any
> $h\in\mathcal C$ with
> $\mathbf E_{P^\star}[h c_z]\ge 1/\operatorname{poly}(|z|)$ is hard for
> infinitely many realizable targets $c_z$.

The second lemma is exactly what current witnesses fail to prove. Until a
cryptographic correlation-search construction or an explicit trace-selector
theorem is available, the atlas should leave this edge open.
