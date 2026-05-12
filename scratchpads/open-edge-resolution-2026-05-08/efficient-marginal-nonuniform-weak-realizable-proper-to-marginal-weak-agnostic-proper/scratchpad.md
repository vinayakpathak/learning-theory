# Scratchpad: Efficient Marginal-Nonuniform Weak Realizable Proper PAC -> Efficient Marginal-Nonuniform Weak Agnostic Proper PAC

Edge file: `atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`

Depth log starts at depth 1 from the main agent's depth 0.

## Current Verdict

Unresolved at launch.

## Depth 1 Attempt

### Files Read

- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/marginal-agnostic-hardness-open.md`
- `atlas/arguments/spike-tilt-uniformization.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/halfspace-agnostic-hardness.md`
- `atlas/arguments/clause-satisfaction-proper-hardness.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/marginal-boosting-open.md`
- relevant witness notes for halfspaces, PCP active slices, clause-satisfaction lookup, and one-way weak handles
- `references.bib`, especially `tiegel2023`, `hanneke2025marginalnonuniform`, `benedek1991fixed`, `blumer1989`, `feldman2012monomials`
- Tiegel 2023 PMLR abstract page: https://proceedings.mlr.press/v195/tiegel23a.html

### Current Conclusion

Not resolved. I do not recommend changing the atlas edge fields at this depth. Keep:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
```

The best structural progress is a reduction of this edge to a sharper already-open core:

```text
efficient-marginal-nonuniform-weak-realizable-proper
  <=>, for purposes of this target, efficient-weak-realizable-proper
```

More precisely:

1. The source of this edge implies `efficient-weak-realizable-proper-pac` by the existing `spike-tilt-uniformization` theorem, under the atlas deterministic-output and pathwise finite-transcript conventions.
2. Conversely, `efficient-weak-realizable-proper-pac` trivially implies the present marginal-nonuniform source by monotone relaxation.
3. Therefore the present edge is true iff the edge
   `efficient-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac`
   is true.

So the marginal-nonuniformity in the source is not the remaining issue. The remaining issue is exactly the proper-output middle-noise selector/neutralizer problem for a distribution-free weak realizable proper learner.

### Formal Restatement of the Remaining Core

Use labels and hypotheses in $\{\pm 1\}$. For a fixed marginal $P$ and agnostic regression

$$
r(x)=\mathbf E[Y\mid X=x],
$$

write

$$
M_{\mathcal C}(r)=\sup_{c\in\mathcal C_s}\mathbf E_P[r(X)c(X)].
$$

The weak agnostic proper target asks for an efficient proper output $h\in\mathcal C_s$ with

$$
\mathbf E_P[r(X)h(X)] \ge M_{\mathcal C}(r)-1+2\alpha_P(s)
$$

for some inverse-polynomial, possibly $P$-dependent $\alpha_P(s)$.

The low-noise branch is already handled: if a near-optimal comparator $c^\star$ has agnostic error below the inverse transcript scale of the clean weak learner, then repeated noisy invocations couple to clean realizable invocations on the same original $P$-distributed instance sequence. Validation over the returned proper candidates gives a proper weak agnostic output.

The unsolved case is the middle-noise branch, where $M_{\mathcal C}(r)$ is not close enough to $1$ for clean-transcript coupling. In this regime the target can be much weaker than finding the optimum: it often suffices to output a legal proper concept with roughly nonnegative correlation against $r$. The source learner does not visibly provide such a legal neutral concept, a complement pair, a balanced sampler, or a searchable proper cover.

### Routes Checked

#### Halfspaces and Tiegel 2023

At first glance, Tiegel's weak agnostic hardness for halfspaces looks dangerous for this edge. The PMLR abstract states hardness of outputting any binary hypothesis with error below $1/2-\gamma$ even when the best halfspace has error $\delta$, and also gives a standard-Gaussian distribution-specific lower bound for strong agnostic learning to $\operatorname{OPT}+\varepsilon$.

This does not presently refute the edge:

- Halfspaces have legal constant classifiers, so the improper low-noise robustification can be made proper for halfspaces.
- If $\operatorname{OPT}\ge \alpha_P(s)$, the better constant has error at most $1/2\le \operatorname{OPT}+1/2-\alpha_P(s)$.
- If $\operatorname{OPT}<\alpha_P(s)$, the same-marginal low-noise coupling applies.
- The standard-Gaussian strong lower bound rules out strong marginal-nonuniform agnostic learning, but not this fixed-additive weak target.
- The weak lower-bound parameters in the abstract do not directly beat the hidden marginal-dependent weak gap once legal constants are available.

Obstacle for future halfspace-based work: remove all legal neutralizers while preserving efficient clean weak proper learning and while retaining a Tiegel-style fixed-marginal weak lower bound. I do not see a source-grounded theorem doing that.

#### PCP Active-Slice Constructions

The active-slice PCP witness gives the right soundness threshold for weak proper agnostic hardness: on the all-positive active slice, a weak proper learner would need a proof accepted on more than half the verifier randomness.

But this same distribution is realizable in satisfiable cases. Therefore a weak realizable proper learner for the class would already decide the PCP language. That is exactly why the current PCP active-slice class fails the source. Adding public handles strong enough to make the source true on the all-positive active slice also gives proper hypotheses accepted on more than half the slice, destroying the target hardness.

Obstacle: one would need handles that help every clean proper target but somehow do not help the all-positive satisfiable target. For perfect-completeness PCPs, the all-positive target is itself a clean target, so this seems blocked.

#### Clause-Satisfaction Lookup

The clause-satisfaction lookup class fixes a marginal over all clauses and encodes the formula in labels, which is attractive for marginal-nonuniform hardness. However, the known argument is a strong proper agnostic hardness argument. It needs accuracy on the order of one clause mass to recover a satisfying assignment.

For the weak target, the additive allowance is about $1/2-\alpha_P(s)$. Unless the construction has a PCP-style soundness gap below one half for every unsatisfiable instance, an arbitrary not-too-bad assignment can still satisfy the weak bound. The lookup class also does not by itself give a clean weak proper source that avoids solving SAT on concentrated realizable formula marginals.

Obstacle: strengthen the clause construction to a PCP soundness gap while preserving the source. This runs into the same active-slice obstruction above.

#### Parity, LPN, and Code Families

Clean parity is efficiently properly learnable, and noisy parity is computationally hard under LPN-style assumptions. But for the atlas weak agnostic target, wrong parities are neutral under the uniform marginal. If the noise rate is above the hidden weak gap, a neutral wrong parity already satisfies

$$
\operatorname{err}(h)\le \operatorname{OPT}+1/2-\alpha_P.
$$

If the noise rate is below the hidden weak gap, the low-noise clean-coupling argument applies.

Code variants face the same geometry. To make every wrong proper concept fail the middle-noise weak threshold, wrong codewords must be inverse-polynomially negatively correlated with the planted codeword. Exact or near-exact pairwise negative correlation for exponentially many codewords on a fixed finite domain runs into Plotkin/PSD/list-decoding barriers already noted in `properization-open`.

Obstacle: a false witness needs computational hardness of finding any neutral proper output, not merely hardness of recovering the planted target.

#### One-Way Image Coordinate and Weak Handles

The one-way image-coordinate class separates weak/strong proper learning after adding handles, but those handles are exactly the kind of legal neutralizers/selectors that make weak agnostic proper learning easy. Without enough handles, clean weak proper learning fails on marginals where a target's positive and negative regions are balanced and hidden. With enough handles, the target weak agnostic problem becomes easy.

Obstacle: build handles that are clean-label-useful but agnostic-label-useless. The existing bounded positive-atom handles are validation-searchable from agnostic data, so they cannot witness falsity.

### Promising Directions for Deeper Subagents

1. **No-neutral fixed-marginal signed search.** Try to construct a finite-support set system $\mathcal F$ with efficient clean promise extension but NP-hardness of finding any $F\in\mathcal F$ with signed weight at least $-1/\operatorname{poly}(s)$ when $\max_F W(F)$ is moderately positive. The obstacle is that the weak threshold is additive half-range, so ordinary hard ERM, max-coverage, nearest-codeword, and set-cover reductions are too strong and leak weak approximate solutions.

2. **Proper neutralizer theorem from weak clean learning.** Try to prove that distribution-free weak realizable proper learning implies a validation-searchable legal neutralizer under each fixed marginal. One possible angle is to combine the spike-tilt uniformization proof with randomly relabeled samples. The obstacle is that the clean learner has no guarantee off the realizable promise, and matching one or a few random labels can produce concepts that behave adversarially on the rest of $P$.

3. **Regional complement selector.** Given a bad proper candidate $h$, the hidden comparator $c^\star$ differs from it on a profitable region. Try to use the clean weak learner on observable error filters to find a legal patch or regional complement. The obstacle is that the observable filter $\{Y\ne h(X)\}$ is clean for $-h$ only under special structure; it is not clean for the hidden comparator without complement/patch closure.

4. **Tiegel-style hardness without constants.** Investigate whether Tiegel's distribution-specific machinery can be adapted to a halfspace-like class with no legal constants, no complement pair usable as a neutralizer, and still efficient clean weak proper learning. The obstacle is preserving the realizable source: most halfspace subclasses that remove neutralizers either lose clean learnability or retain some easy balanced pair.

5. **Hadamard/one-way fixed-length diagnostic.** At one fixed length, Hadamard code geometry plus a one-way image map can make positive correlation identify the secret. Try to stack lengths under a single fixed marginal without active-mass dilution. The obstacle, noted in `properization-open`, is that finite encoded marginals reintroduce wrong-length/default handles or require superpolynomial support.

### Atlas Update Recommendation

No status update yet. If the atlas edge body is later revised, the most useful addition from this pass would be a short equivalence note:

> By spike-tilt uniformization, the source is equivalent for this target to distribution-free efficient weak realizable proper learning. Thus the open content is not marginal-source uniformization but the proper middle-noise selector/neutralizer problem already appearing in `efficient-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac`.

This is explanatory only; it does not change `status`, `evidence`, `assumptions`, `witnesses`, or `ref_keys`.

### Resolved?

No.
## Depth 2 Attempt: No-Neutral Signed Set System

### Question Pursued

Depth 1 reduced this edge, for purposes of the target, to the
distribution-free weak-realizable proper core. I therefore focused on a finite
support formulation:

- a fixed support $\Omega$ with marginal $P$;
- a legal proper family $\mathcal F\subseteq\{\pm1\}^{\Omega}$;
- a signed agnostic regression $r:\Omega\to[-1,1]$;
- the signed objective $W(h)=\langle r,h\rangle_P$.

The target requires an efficient legal $h\in\mathcal F$ with

$$
W(h)\ge W^\star-1+2\alpha_P(s),
\qquad
W^\star=\max_{c\in\mathcal F}W(c).
$$

The possible false witness would be a "no-neutral" set system: exact clean
labels permit efficient weak proper promise extension for every target and
every marginal, but for some fixed marginal and signed regression it is hard to
find even a weakly neutral/profitable legal set, say $W(h)\ge
-1/\operatorname{poly}(s)$, despite $W^\star$ being close enough to $1$ that
the weak agnostic target needs such a neutral output.

I did not resolve the edge. The main result of this attempt is a sharper
obstruction to the no-neutral route: the most natural finite-support CSP
candidate, even with a fixed universal factor graph, leaks a proper balanced
sampler. More generally, a real counterexample must avoid not only constants
and complements, but also any efficiently samplable distribution over legal
concepts whose $P$-average prediction is nearly zero.

### Translation To Noise Parameters

Suppose $r=(1-2\eta)c^\star$ is literally a noisy version of a clean concept.
Then $W^\star=1-2\eta$ and the target threshold is

$$
W(h)\ge 2(\alpha_P(s)-\eta).
$$

So if $\eta\ge \alpha_P(s)$, any legal neutralizer with $W(h)\ge0$ is enough.
If $\eta<\alpha_P(s)$, the known low-noise coupling can be made to apply by
choosing $\alpha_P$ below the inverse transcript scale of the clean weak
learner. This explains why LPN/parity-style planted-noise witnesses keep
failing: wrong parities are neutral.

For planted-noise witnesses, no-neutrality would require nearly all wrong
legal concepts to be negatively correlated with $c^\star$. On a fixed finite
support this is a pairwise negative code condition. Plotkin/PSD-style barriers
then limit how many such concepts can coexist at inverse-polynomial negative
margin. Thus a serious finite-support separation probably cannot be just
"noisy clean labels plus a hard-to-recover target"; it must use a more general
signed regression $r$ that exposes one legal concept while making the easily
findable legal concepts anti-correlated.

### The Max-kLIN / Universal Factor Graph Candidate

The closest false route I found is the assignment-parity set system.

Fix a length $n$ and a family of parity scopes $q=(i,j,k)$, possibly coming
from a universal factor graph. A legal concept is an assignment
$a\in\{0,1\}^n$, represented by

$$
c_a(q)=(-1)^{a_i+a_j+a_k}.
$$

Clean realizable proper learning is easy. Given samples
$(q,c_a(q))$, the learner receives linear equations over $\mathbb F_2$. It can
solve the sampled consistent linear system and output any satisfying
assignment. For a polynomial-size support, standard finite-class/uniform
convergence or direct support coverage gives strong proper clean learning in
polynomial time. This is much stronger than the weak source.

Agnostic labels for this class are exactly weighted Max-3LIN labels over the
fixed scope distribution. At first this looks like the desired signed-search
hardness: Hastad's optimal inapproximability for Max-3LIN, and the later
universal-factor-graph results of Austrin--Brown-Cohen--Hastad, show that
constant advantage over random remains hard even when the factor graph is
fixed in advance. This fixes the marginal in precisely the way ordinary
Label-Cover/FGRW-style reductions do not.

But it still does not refute this atlas edge. Uniformly sampling an assignment
$a$ is an efficient proper sampler and, for every nonempty parity scope $q$,

$$
\mathbb E_a[c_a(q)] = 0.
$$

Therefore for every signed regression $r$,

$$
\mathbb E_a \langle r,c_a\rangle_P=0.
$$

So some legal assignment has nonnegative correlation with $r$, and sampling
polynomially many random assignments followed by validation finds a legal
near-neutral assignment. Combining this with the existing low-noise clean
coupling gives the weak agnostic target for this class: use low-noise coupling
when $\eta$ is below the inverse transcript scale, and otherwise use the
balanced random-assignment sampler.

This also explains why the universal-factor-graph improvement is not enough.
It solves the "fixed marginal" problem for constant-factor CSP hardness, but
the atlas target may choose an inverse-polynomial weak gap. In the middle-noise
regime it only needs a legal near-neutral hypothesis, and random legal
assignments provide exactly that.

Sources checked for this route:

- Hastad, "Some Optimal Inapproximability Results" (JACM 2001),
  https://doi.org/10.1145/502090.502098.
- Austrin, Brown-Cohen, and Hastad, "Optimal Inapproximability with Universal
  Factor Graphs" (SODA 2021), https://doi.org/10.1137/1.9781611976465.27.
- The local atlas notes `marginal-agnostic-hardness-open.md`,
  `pcp-active-slice-weak-proper-hardness.md`, and `properization-open.md`.

### A Conditional Proper Neutralizer Lemma

The Max-kLIN failure suggests the right positive abstraction.

Assume that for a fixed marginal $P$ and representation size $s$ there is a
polynomial-time sampler over legal proper concepts $H\in\mathcal C_s$ such
that its mean prediction

$$
b(x)=\mathbb E[H(x)]
$$

has small $P$-average absolute value, say

$$
\mathbb E_{X\sim P}|b(X)|\le \tau(s).
$$

Then for every regression $r$ with $|r|\le1$,

$$
\mathbb E_H\langle r,H\rangle_P
=\langle r,b\rangle_P
\ge -\tau(s).
$$

Thus a sampled legal concept has correlation at least $-\tau(s)$ with
nonnegligible probability after repetition, and validation can find one. If
$\tau=0$, this is a perfect proper neutralizer. If $\tau$ is inverse
polynomial and the target gap is chosen below both the low-noise transcript
scale and $\tau$, the same low-noise/neutralizer split covers the agnostic
problem.

This lemma is not a resolution, because the source node does not assert such a
sampler. It does, however, identify a large class of failed counterexamples:
parities, affine parities, balanced CSP assignment classes, many complement
closed classes, and any class with legal constants or a validation-searchable
balanced shadow cover.

### What The Clean Source Does Give Locally

The distribution-free weak clean source does imply a very weak local extension
property. Fix a point $x$ and a sign $\sigma$ that is realized by some concept
in $\mathcal C_s$. Run the clean learner on the point-mass marginal
$\delta_x$ with the constant label $\sigma$. Since any positive weak advantage
under a point mass forces zero error, the learner must output, with high
probability, a legal concept $h$ with $h(x)=\sigma$.

So an atlas-valid no-neutral set system cannot make local legal extension
hard. Every attainable atom-label constraint must be efficiently extendable to
some legal concept. The missing control is global: the extension's behavior
off the queried atom can be adversarial under the original marginal $P$.

This separates two notions:

- **Local promise extension**, which the clean source essentially forces.
- **Balanced/neutral extension**, which would be enough for the agnostic target
  but is not visibly forced by the source.

The no-neutral witness must live exactly between these: all local clean
constraints are efficiently extendable, exact clean samples are weakly
learnable under every marginal, yet every efficiently findable global extension
is negatively correlated with some signed regression.

### Why Other Finite Set-System Templates Still Leak Handles

I checked the finite-support templates suggested by the no-neutral formulation.

1. **Max-SAT or clause-satisfaction systems.** Random assignments have a
   constant predicate bias. For ordinary clauses this often gives too much
   baseline usefulness rather than too little. Balanced versions reduce to the
   Max-kLIN situation and have a pointwise balanced sampler.

2. **PCP active slices.** Soundness below one half would create no-neutral
   behavior on the all-positive active slice, but perfect completeness makes
   that all-positive slice clean-realizable. A weak proper clean learner would
   already decide the PCP language, so the source fails.

3. **Sparse families such as cycles, matchings, or small subsets.** Arbitrary
   legal objects agree on the dominant negative region under many natural
   marginals, giving weak handles. If the marginal is balanced to remove this,
   one typically gets either an easy sampler over legal objects or a hard
   clean-extension problem.

4. **Hidden-validity families.** Making it hard to sample any legal balanced
   object by defining legal concepts through an NP witness tends to break the
   clean source. Point-mass clean learning already requires efficient local
   extension for every attainable label, and arbitrary clean marginals require
   more than local extension.

### Current Status Of The No-Neutral Route

I do not have either:

- a finite-support no-neutral set system satisfying the distribution-free weak
  realizable proper source; or
- a proof that the source always yields a validation-searchable proper
  neutralizer/list selector.

The useful negative information is that fixed-marginal CSP hardness, even in
the strong universal-factor-graph form, is not enough. It attacks constant
advantage over random, while this atlas edge can retreat to an
inverse-polynomial neutralizer. A genuine false witness needs all three
properties below at once:

1. **Efficient clean weak proper learning** under every marginal, not merely
   local consistency on the hard marginal.
2. **No efficiently samplable balanced legal distribution** under the hard
   marginal.
3. **Hardness of weak signed search**, where finding any legal $h$ with
   $W(h)\ge -1/\operatorname{poly}(s)$ would decode or solve the hard instance.

I found no known construction satisfying this trio.

### Recommended Next Directions

1. **Sampler-free clean classes.** Search specifically for distribution-free
   weak proper classes where sampling a legal concept, or sampling one with
   small $P$-mean prediction, is computationally hard. The point-mass extension
   test should be applied immediately to any candidate.

2. **Formalize the balanced-sampler lemma.** It would not settle the edge, but
   it cleanly explains why parities, Max-kLIN, complement-closed classes, and
   legal-constant classes are positive for this weak target.

3. **Universal factor graph variants without random-assignment neutrality.**
   Look for predicates where fixed-factor-graph hardness survives, exact clean
   learning remains easy, and uniform legal assignments are not neutral. The
   danger is that non-balanced predicates usually introduce a different public
   baseline handle.

4. **Local-to-global neutralizer theorem.** Try to strengthen the point-mass
   extension fact into a theorem saying that if many local extensions exist and
   clean learning is distribution-free weak, then a polynomial-time balanced
   sampler or small validation list exists. I do not see the proof, but this is
   the cleanest positive route left by this attempt.

### Resolved?

No.

## Depth 3 Attempt: CSP Without Balanced Sampler

### Question Pursued

Depth 2 found that the most natural fixed-marginal CSP witness, Max-$k$LIN on
a universal factor graph, leaks a neutralizer: uniformly random legal
assignments have zero mean on each nontrivial parity constraint. I therefore
looked for ways to constrain the legal assignment family so that:

1. exact clean labels are still weakly properly learnable under every marginal;
2. there is no efficiently samplable distribution over legal assignments with
   small mean prediction under the hard marginal; and
3. for some signed regression $r$, finding a legal assignment with
   $W(h)=\langle r,h\rangle_P\ge -1/\operatorname{poly}(s)$ is computationally
   hard even though $W^\star$ is large enough that the weak target needs such a
   non-anti-correlated output.

I did not resolve the edge. The main conclusion is negative evidence against
this route: the standard ways of destroying the balanced random-assignment
sampler also destroy the algebraic or extension structure that made clean weak
proper learning easy.

### Formal Template

Fix a universal factor graph, or more generally a fixed query set $Q_n$ with
marginal $P_n$. Let $L_n\subseteq\Sigma^n$ be the legal assignment family, and
let each legal assignment $a\in L_n$ define the proper concept

$$
c_a(q)=\phi_q(a)\in\{\pm1\},\qquad q\in Q_n.
$$

The clean source asks for a uniform polynomial-time learner which, for every
marginal $P$ over queries and every target $a^\star\in L_n$, outputs some
$a\in L_n$ with

$$
\Pr_{q\sim P}[c_a(q)=c_{a^\star}(q)]\ge \frac12+\gamma_P(n).
$$

The desired false witness would need a signed instance $r:Q_n\to[-1,1]$ for
which $W^\star=\max_{a\in L_n}\langle r,c_a\rangle_P$ is not in the low-noise
branch, but every efficient way of outputting a legal $a$ has
$\langle r,c_a\rangle_P<-1/\operatorname{poly}(n)$.

This formulation makes the conflict sharp. To prove hardness, $L_n$ must be
complicated enough that weak signed optimization over its trace code is hard.
To satisfy the clean source, the same trace code must admit distribution-free
weak decoding from noiseless samples of an arbitrary codeword.

### Affine And Subgroup Restrictions

The first attempt was to replace the full assignment cube by an affine
subspace, subgroup, coset, or system of linear side constraints. This keeps
clean learning easy: noiseless parity observations plus public linear side
constraints can be solved by Gaussian elimination.

But it also keeps a sampler. Uniform sampling from the affine space is
efficient. For any linear query not fixed by the side constraints, the mean
prediction is exactly zero; for a query fixed by the side constraints, the
prediction is a public constant. Thus the hard coordinates either still have
the old neutral random-assignment behavior or have become public default
handles. This does not give a no-neutral witness.

This is also why the strongest known universal-factor-graph hardness results
do not directly help here. Austrin--Brown-Cohen--Hastad show that many Max-CSP
hardness ratios survive after fixing the factor graph, and their Max-3LIN case
is explicitly a fixed-code nearest-vector-style problem. For this atlas edge,
however, the fixed linear code supplies a uniform proper sampler whose mean is
zero on the unfixed linear tests. Approximation resistance against beating
random is not the same as hardness of finding a non-anti-correlated legal
trace.

Sources checked:

- Austrin, Brown-Cohen, and Hastad, "Optimal Inapproximability with Universal
  Factor Graphs" (SODA 2021), https://doi.org/10.1137/1.9781611976465.27.
- Austrin and Mossel, "Approximation Resistant Predicates From Pairwise
  Independence" (2008), https://arxiv.org/abs/0802.2300.

### Hamming-Slice Restrictions

The next idea was to constrain legal assignments to a Hamming slice, say
$|a|=\rho n$, hoping that the uniform legal assignment is no longer balanced.

This splits into two cases.

If the observed predicates are just literals or low-complexity monotone tests,
clean learning is easy but the agnostic signed problem is also easy: it becomes
top-$k$ or another simple weighted selection problem. The absence of a balanced
sampler is bought by making the signed search too transparent.

If the observed predicates are parities or richer CSP tests, the signed search
can become hard, but the clean source becomes suspect. Noiseless samples now
ask for a legal weight-$\rho n$ assignment satisfying sampled parity
constraints. With $\rho\ne1/2$, this is a fixed-weight syndrome/decoding-style
problem, not ordinary Gaussian elimination. I do not see a uniform weak clean
proper learner for all marginals; concentrated realizable marginals can force
the learner to find a fixed-weight solution to a hard-looking linear system.

The balanced slice $\rho=1/2$ avoids this fixed-weight decoding issue only
partly, and it reintroduces an approximate neutralizer: uniform slice sampling
has nearly zero mean on every constant-size nondegenerate parity test, with
hypergeometric bias of order $O(k^2/n)$. That is small enough for the
marginal-nonuniform weak gap to hide below it.

So Hamming slices expose the main tradeoff cleanly:

- literal/query-simple slices: clean source yes, weak signed search no;
- parity/query-rich slices: weak signed search maybe, clean source no;
- balanced slices: clean source maybe, but approximate sampler yes.

### Public Base-CSP Feasible Sets

I also considered making $L_n$ the satisfying assignments of a fixed public
base CSP $B_n$. This is the most plausible way to have legal concepts that are
searchable from clean information but not easily samplable in a balanced way.

The obstacle is that the clean source is much stronger than finding one
satisfying assignment of $B_n$. For every target $a^\star\in L_n$ and every
marginal over query predicates, the learner must output a legal $a$ whose trace
weakly agrees with the trace of $a^\star$. If clean samples can impose
arbitrary local trace constraints, then the learner needs a weak extension
procedure for every realizable partial trace.

When $B_n$ has a robust extension structure, the examples I know become
positive rather than negative:

- affine spaces give Gaussian elimination and uniform samplers;
- matroid-like bases give greedy/random base generation and weighted
  optimization;
- matching/path/cut families with efficient extension usually also have
  efficient linear optimization or at least public random baselines;
- Horn/2-SAT-style tractable CSPs do not obviously give hardness of the very
  weak signed threshold, and adding predicates rich enough for hardness tends
  to make realizable trace extension hard.

This is not a theorem, but it is a strong obstruction to the proposed route.
The no-balanced-sampler condition wants $B_n$ to be asymmetric and
sampling-poor; the clean source wants enough extension power to handle every
realizable marginal. I could not make both true in a natural CSP family.

### Unbalanced Predicate And Universal-Factor Variants

Another variant is to keep all assignments legal but use unbalanced predicates
or remove the free negations/folding that make random assignments neutral.
This changes the public random-assignment mean

$$
b(q)=\mathbb E_{a}[c_a(q)].
$$

If $b$ is useful for the regression $r$, conditional expectation or simple
random sampling gives a proper handle. If $r$ is chosen to make
$\langle r,b\rangle_P$ negative, the problem becomes "beat a biased public
baseline." Existing universal-factor-graph hardness results are not enough for
the atlas edge for two reasons:

1. the hardness statement is normally calibrated against random-assignment
   value or against a CSP soundness threshold, not against the signed threshold
   $-1/\operatorname{poly}(n)$ required here; and
2. for many predicates with perfect-completeness hardness, the all-satisfied
   clean instance is itself a hard satisfiable CSP search problem, so the
   realizable proper source would already fail on that marginal.

The predicates that avoid the second problem tend to be algebraic, especially
linear-equation or subgroup predicates. But those are exactly the predicates
that restore a balanced or nearly balanced sampler.

### Hidden Sampler / One-Way Legal Family

A final thought was to make legal assignments easy to recognize or use when
clean labels reveal them, but hard to sample in a balanced way. This looks like
a representation-sensitive or cryptographic construction: legal concepts are
images of a generator, satisfying witnesses of a public relation, or canonical
extensions of local labels.

I do not see a sound witness here. If the representation includes a seed or
witness from which the concept is evaluated, then sampling random seeds gives
an efficient proper sampler unless the generator image is deliberately biased.
If legal membership or extension is hidden enough to block sampling, then a
proper learner receiving noiseless samples under adversarial marginals seems
unable to output a legal representation without solving the same hidden search
problem. This repeats the one-way-handle obstruction from depth 1 in CSP
language.

### Best Current Diagnostic

For a constrained CSP route to work, it must avoid the following informal
dichotomy:

1. **Algebraic/tractable extension.** Clean weak proper learning is plausible,
   but the same structure supplies a balanced sampler, approximate sampler,
   complement-pair distribution, public default, or efficient weighted
   selector.
2. **Asymmetric/no-sampler feasible set.** Balanced sampling may disappear,
   but realizable weak proper learning under arbitrary marginals starts to
   require hard constrained extension or decoding.

The depth-3 search did not find a CSP family outside this dichotomy.

### Promising Directions Left

The most concrete remaining direction is to look for a hereditary trace family
$T_n\subseteq\{\pm1\}^{Q_n}$ with the following two properties:

- every realizable partial trace has a polynomial-time weak extension
  algorithm under arbitrary coordinate marginals; but
- weak signed optimization over $T_n$ is hard after subtracting every
  efficiently samplable mean vector.

This is more abstract than ordinary CSP hardness. It resembles a search for a
"weakly decodable but sampler-free and weakly optimization-hard" code. I do not
know a natural example.

A second direction is to formalize a positive theorem for broad CSP-like
families: efficient clean weak proper learning plus a polynomial-time local
extension oracle might imply either a balanced sampler or a validation-searchable
small list. I do not have the proof, but the failed constrained-CSP attempts
all point in that direction.

### Resolved?

No.

RESOLVED: no.

## Depth 8 Final Incorporation Recommendation

RESOLVED: no for the original atlas edge.

The edge should remain `status: "open"` with `evidence: unknown`. The depth-8
search did not find a theorem deriving a same-marginal proper weak agnostic
learner from the marginal-nonuniform weak realizable proper source, and it did
not find an atlas-valid counterexample.

The useful atlas update is explanatory. By spike-tilt uniformization, the
source reduces for this target to the same distribution-free weak-realizable
proper core obstruction: low-noise same-marginal coupling works, while the
middle-noise branch needs a legal proper neutralizer, shadow cover, or signed
selector not supplied by the source.

Recommended summary text:

```yaml
summary: "Open. By spike-tilt uniformization, the source reduces for this target to the distribution-free weak-realizable proper core up to the same middle-noise selector issue. Low-noise same-marginal coupling works, and classes with validation-searchable proper shadow covers or neutralizers satisfy the target, but the source node alone does not provide such an object. CSP, parity/code, and LPN templates leak neutral proper outputs or lose clean weak learnability."
```

Recommended body additions:

- Record the relation to the distribution-free weak-realizable proper core.
- Record that the depth-limited search sharpened the negative route into a
  fixed-ensemble no-neutral signed-search primitive, but no standard assumption
  instantiates it.
- Keep the edge in `family: marginal-agnostic-hardness-open`.

Useful references to keep or add are `benedek1991fixed`, `hopkins2024`,
`feldman2010distributionspecific`, `hanneke2025marginalnonuniform`,
`tiegel2023`, `dacunha2026agnosticboosting`, and `feldman2012monomials`.

## Depth 9 Attempt: Final Marginal Weak Proper Search

RESOLVED: no.

### Scope Of This Final Pass

I treated the preceding scratchpad as the accumulated depth-1 through depth-8
tree, and rechecked both routes that could settle the atlas edge:

1. a positive theorem converting the marginal-nonuniform weak realizable proper
   source into a same-marginal weak agnostic proper learner; and
2. a source-grounded counterexample, preferably under an accepted hardness
   assumption, where clean weak proper learning survives but middle-noise weak
   agnostic proper learning fails for one fixed marginal.

The conclusion is still that the edge should remain open. The final obstruction
is sharper than "agnostic learning can be hard": for this weak additive target,
hardness must rule out every efficient legal proper output whose correlation is
merely nonnegative up to an inverse-polynomial slack. Existing lower bounds and
standard gadgets either attack a stronger target, vary the marginal, or leave a
legal neutralizer.

### Fixed-Marginal Halfspace Check

The tempting false route is to use agnostic halfspace hardness. Tiegel proves,
under worst-case lattice hardness, distribution-independent improper hardness
for getting error below $1/2-\gamma$ when the best halfspace has small error
$\delta$, and also a distribution-specific lower bound under the standard
Gaussian marginal for strong error $\operatorname{OPT}+\varepsilon$
([Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)).

This still does not settle the present edge. The distribution-independent weak
hardness does not give a single fixed marginal suitable for the
marginal-nonuniform target. The standard-Gaussian part is fixed-marginal, but it
is a strong $\operatorname{OPT}+\varepsilon$ lower bound, not a lower bound
against the much weaker target

$$
\operatorname{err}(h)\le \operatorname{OPT}+1/2-\alpha_P(s).
$$

For halfspaces, legal constants or constant halfspaces handle the branch
$\operatorname{OPT}\ge \alpha_P(s)$ by achieving error at most $1/2$. When
$\operatorname{OPT}<\alpha_P(s)$, the same-marginal low-noise coupling from the
edge file applies: a polynomial-size noisy sample is clean with inverse-
polynomial probability once $\alpha_P$ is chosen below the clean learner's
sample scale, and validation selects a proper halfspace returned by the clean
learner. Thus the known halfspace lower bounds are consistent with the atlas
edge remaining open.

This check is important because it explains why the existing false edge
`efficient-weak-realizable-proper-pac -> efficient-weak-agnostic-proper-pac`
does not automatically refute the marginal-nonuniform target. The latter may
choose a much smaller fixed-marginal weak gap and may use the fixed marginal's
legal neutralizers.

### Agnostic Boosting And Distribution-Specific Boosting Check

The positive route through agnostic boosting is also a near miss. Kalai,
Mansour, and Verbin give an agnostic boosting framework for weak agnostic
learners, and Feldman's distribution-specific boosting keeps the instance
marginal fixed by modifying labels rather than the domain distribution
([Kalai--Mansour--Verbin 2008](https://doi.org/10.1145/1374376.1374466),
[Feldman 2010](https://arxiv.org/abs/0909.2927)). Recent work continues to
improve the sample and running-time tradeoffs for agnostic boosting
([da Cunha--Hogsgaard--Paudice 2026](https://arxiv.org/abs/2601.11265)).

None of these theorems gives the missing implication from a realizable proper
weak learner alone. They assume an agnostic weak oracle, a tunable threshold-
correlation primitive, or a quantitative oracle model stronger than the source
node. In the present edge the only black-box guarantee is on exactly realizable
labels. In the middle-noise regime, random guessed clean traces hit a
near-optimal comparator's labels with probability roughly $2^{-m}$ for a
polynomial clean sample size $m$, and no source theorem supplies the filter that
would raise that probability. Such a filter would already look like a weak
correlator with the hidden comparator.

So boosting confirms the shape of a possible positive theorem but does not
provide it. A positive atlas proof would need an additional lemma producing a
proper same-marginal weak selector or a validation-searchable neutral proper
list before agnostic boosting techniques become applicable.

### Sample-Only Equivalence Does Not Computationalize

The sample-efficient analogues are true by the usual VC/ERM equivalences:
without a runtime bound, finite-sample control plus unbounded proper ERM gives
agnostic proper learning. Hanneke, Moran, and Thiessen's marginal-nonuniform
trichotomy clarifies the sample-rate side of the story by allowing rates to
depend on the marginal distribution while remaining uniform over concepts
([Hanneke--Moran--Thiessen 2025](https://openreview.net/forum?id=aoVCFtox89)).

This does not give the efficient edge. At a fixed marginal $P$, finite VC-style
control says that a proper empirical minimizer exists after polynomially many
samples. It does not give a polynomial-time way to find a legal representation.
Enumerating all traces on a polynomial sample is exponential; enumerating a
logarithmic trace is polynomial but too small for the uniform-convergence
transfer needed under $P$. This is exactly where the computational obstruction
lives.

### Last Positive Attempt: Forcing A Neutralizer From The Clean Learner

I also rechecked the most direct way to extract a proper neutralizer from the
source learner itself.

One can run the clean learner on point-mass realizable samples. If a sign
$\sigma$ is attainable at $x$, then under $\delta_x$ any positive weak edge
forces the learner to output a legal concept with value $\sigma$ at $x$. This
gives efficient local extension.

But local extension is not enough. A natural randomized candidate generator is:
sample one or a few labeled examples from the agnostic distribution, force the
clean learner to extend those labels, then validate the resulting proper
concepts. The only guaranteed correlation comes from the forced sample points.
For diffuse or high-min-entropy marginals, that diagonal contribution has
negligible $P$-mass; the extension can be adversarial on the rest of the
domain. For finite marginals with heavy atoms this can help, but the target
requires all marginals and the weak gap must be chosen before seeing the
conditional labels.

Similarly, running the clean learner on random relabelings of a sample does not
force a balanced distribution over legal concepts. If the concept class is
complement-closed, parity-like, affine, or otherwise symmetric, the random
output distribution often has mean zero and becomes a neutralizer. Without such
symmetry, the source guarantee imposes no behavior on unrealizable random-label
inputs. There is no source-grounded reason the resulting proper outputs should
have nonnegative correlation with an arbitrary regression $r$.

Thus the clean learner provides local promise extension, but I do not see a
valid local-to-global argument producing the needed same-marginal neutralizer.

### Last Negative Attempt: Fixed-Marginal No-Neutral Hardness

The counterexample would need a signed finite-support or efficiently sampled
fixed-marginal family with the following properties:

1. exact clean labels are weakly properly learnable under every marginal;
2. for the hard marginal $P$, no efficient sampler over legal proper concepts
   has small mean prediction, so validation cannot find a neutral concept; and
3. for some regression $r$, finding any legal $h$ with
   $\langle r,h\rangle_P\ge -1/\operatorname{poly}(s)$ is hard even though
   $\max_{c\in\mathcal C_s}\langle r,c\rangle_P$ is positive enough that the
   weak agnostic target needs such an $h$.

I did not find a known primitive with all three properties. The standard hard
families fail in consistent ways:

- Parity and code/LPN witnesses give fixed-marginal noisy hardness, but wrong
  parities or random codewords are neutral under the usual marginals.
- Universal-factor-graph and Max-$k$LIN hardness fixes the factor marginal, but
  uniformly random legal assignments still have zero mean on balanced
  constraints.
- PCP and monomial/halfspace weak-agreement hardness, including Feldman,
  Guruswami, Raghavendra, and Wu's weak agnostic hardness result for monomials
  by halfspaces ([Feldman et al. 2012](https://doi.org/10.1137/120865094)),
  does not by itself give the required single fixed marginal with polynomial
  active mass and no legal baseline.
- One-way image-coordinate constructions can make recovery hard under a fixed
  block, but the handles needed for clean weak proper learning are themselves
  validation-searchable weak agnostic handles.

The no-neutral witness must therefore be stronger than ordinary approximate
ERM hardness. It must make every efficiently findable proper output that avoids
decoding the hard witness noticeably anti-correlated with $r$. That is the part
not currently supplied by CSP, PCP, parity, halfspace, or one-way templates.

### Proposed Atlas Updates

No field update is justified. Keep:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: marginal-agnostic-hardness-open
```

The existing depth-8 summary is still the right compact atlas summary. If the
body is expanded later, the depth-9 addition should be a short "final obstacle"
paragraph:

> A final source check found no fixed-marginal halfspace, monomial, parity,
> CSP, PCP, or one-way witness that defeats the weak additive target. Known
> agnostic boosting theorems require an agnostic weak oracle or tunable
> threshold-correlation primitive, while sample-only VC/ERM equivalences do not
> provide polynomial-time proper search. The remaining problem is exactly a
> same-marginal proper middle-noise selector: either prove that clean weak
> proper learning yields a validation-searchable neutral/selector list, or
> build a fixed-marginal no-neutral signed-search primitive with efficient clean
> weak proper extension.

### Final Directions And Obstacles

1. **Selector theorem.** Prove that any efficient weak realizable proper learner
   yields, for every fixed marginal $P$, a polynomial list of legal concepts
   containing either a low-noise clean-coupling candidate or a concept with
   $\langle r,h\rangle_P\ge -1/\operatorname{poly}(s)$. The obstacle is that
   the clean learner has no guarantee on unrealizable or randomly relabeled
   traces.

2. **No-neutral signed-search primitive.** Build a trace family with efficient
   realizable weak extension but hardness of finding even a non-anti-correlated
   legal trace under one fixed marginal. The obstacle is that every known
   tractable extension structure supplies constants, complements, random legal
   samplers, public defaults, or balanced affine samplers.

3. **Fixed-marginal weak hardness below the neutralizer threshold.** Adapt
   halfspace or monomial weak hardness so that the hard marginal is fixed and
   the optimal error is below the eventual inverse-polynomial weak gap, while
   removing legal constants or other neutral proper outputs. The obstacle is
   that fixed-marginal lower bounds currently target strong
   $\operatorname{OPT}+\varepsilon$ learning, and classes with clean proper
   learnability tend to retain a weak proper baseline.

4. **Representation-level sampler assumptions.** Separate the edge into
   positive subcases: complement-closed classes, classes with legal constants,
   classes with efficient balanced proper samplers, and classes with
   validation-searchable proper shadow covers. This would not resolve the
   abstract edge, but it would turn many near-counterexamples into explicit
   positive lemmas and isolate the missing sampler-free case.
