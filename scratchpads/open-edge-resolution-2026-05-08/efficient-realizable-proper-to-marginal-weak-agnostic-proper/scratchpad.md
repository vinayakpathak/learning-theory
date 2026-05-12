# Scratchpad: Efficient Realizable Proper PAC -> Efficient Marginal-Nonuniform Weak Agnostic Proper PAC

Edge file: `atlas/implications/efficient-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`

Depth log starts at depth 1 from the main agent's depth 0.

## Current Verdict

Unresolved at launch.

## Depth 1 Attempt

### Verdict

I did not resolve the edge. My current recommendation is to keep the atlas
edge `status: "open"` with `evidence: unknown`.

The existing edge note has the right obstruction: distribution-free strong
realizable proper learning gives a same-marginal low-noise coupling, but I do
not see a way to derive the middle-noise proper selector required by
`efficient-marginal-nonuniform-weak-agnostic-proper-pac`. I also do not see a
known counterexample whose hardness survives the target's marginal-nonuniform
and very weak additive quantifiers.

### Definitions And Algebra Checked

For a fixed marginal $P$ and joint distribution $\mathcal D$ with labels
$Y\in\{\pm1\}$, write

$$
\rho(h)=\mathbf E[h(X)Y],\qquad
\rho^\star=\sup_{c\in\mathcal C}\mathbf E[c(X)Y].
$$

The target guarantee

$$
\operatorname{err}_{\mathcal D}(h)
\le \operatorname{OPT}_{\mathcal C}(\mathcal D)+1/2-\gamma_P(s)
$$

is equivalent to

$$
\rho(h)\ge \rho^\star-1+2\gamma_P(s).
$$

If $\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D)$ is at least the
low-noise threshold $\alpha_A(s)$ from a constant-accuracy run of the source
learner, and $\gamma_P(s)\ll \alpha_A(s)$, it is enough to find a proper
hypothesis with correlation only slightly negative, for instance
$\rho(h)\ge-\alpha_A(s)$. This is the "middle-noise neutralizer/selector"
problem.

The source learner can be used safely on clean realizable labels. It can also
be used for the low-noise branch: if a near-optimal $c^\star$ has label-noise
rate $\eta<1/\operatorname{poly}(s)$ small enough relative to the number of
labels inspected by a constant-accuracy run, then with inverse-polynomial
probability the noisy transcript equals a clean transcript for $c^\star$ under
the same original marginal $P$. Repetition plus validation gives a good proper
candidate.

The same argument stops in middle noise because a VC/source-scale clean trace
has probability roughly $(1-\eta)^m$, exponentially small when
$m=\operatorname{poly}(s)$ and $\eta$ is inverse-polynomial but not below
$1/m$.

### Positive Routes Tried

1. **Use realizable-to-agnostic black-box reductions.** Hopkins, Kane, Lovett,
   and Mahajan give a black-box sample-complexity reduction from realizable to
   agnostic learning. Their basic algorithm draws an unlabeled sample and runs
   the realizable learner over all labelings of that sample. This is exactly
   the missing fixed-marginal cover idea, but it is not a polynomial-time
   conversion in the atlas sense. Even for the atlas's weak additive tolerance,
   the unlabeled sample size needed by the source learner at constant accuracy
   is generally $\operatorname{poly}(s)$, so enumerating all labelings or all
   induced traces can be $2^{\operatorname{poly}(s)}$ or
   $s^{\operatorname{poly}(s)}$.

2. **Use finite VC or marginal-nonuniform sample theory.** The source implies
   finite VC dimension at the sample-complexity level, and Hanneke--Moran--
   Thiessen give marginal-nonuniform sample-rate structure. This supports
   unbounded proper ERM, but it does not give an efficient proper ERM, an
   efficiently enumerable $L_1(P)$ cover, or a polynomial-time legal selector.

3. **Use an arbitrary proper anchor.** If an anchor $h_0\in\mathcal C$ is not
   too anti-correlated with the labels, validation would accept it. If it fails,
   then a good concept is far from $h_0$, but conditioning on the mistake
   region still leaves agnostic noise and patching/flipping the anchor need not
   produce a legal concept in $\mathcal C$. This route needs complements,
   restrictions, pasting, or a projection oracle, none of which follows from
   realizable proper learning.

### Negative Routes Tried

1. **Halfspaces via Tiegel.** Tiegel proves weak improper agnostic hardness for
   halfspaces in the distribution-independent setting, and fixed-Gaussian
   excess-error lower bounds in the distribution-specific setting. This does
   not settle this edge. The distribution-independent hard marginal can vary
   with the instance, while the target allows the polynomial and weak gap to
   depend on each fixed marginal. The fixed-Gaussian lower bound is for
   achieving $\operatorname{OPT}+\varepsilon$ in time
   $d^{\tilde\Omega(1/\varepsilon^{2-\beta})}$; at the atlas weak tolerance
   $\varepsilon\approx 1/2$, this is not a super-polynomial obstruction to
   merely getting some inverse-polynomial advantage over $1/2$.

2. **Conjunction/set-cover hardness.** Kearns--Schapire--Sellie hardness for
   proper agnostic conjunction learning explains the false strong-agnostic
   edge, but it requires near-optimal additive accuracy. The present target may
   choose a nearly-half additive tolerance. To use conjunctions here one would
   need a fixed-marginal construction in which every conjunction satisfying the
   weak threshold still decodes a hard set-cover witness. I did not find such
   a statement in the local notes or references.

3. **Noisy parities/LPN.** Clean parities are efficiently properly learnable
   and noisy parity is the right kind of "clean easy, noisy hard" primitive.
   But parities under the uniform marginal have abundant neutral wrong
   hypotheses: in the middle-noise regime a wrong parity with correlation near
   zero already satisfies the atlas additive weak target.

4. **Biased code or planted-code variants.** To make a false witness, one
   wants every efficiently findable wrong proper hypothesis to be
   anti-correlated with the hard labels. Pure geometry seems to block the
   strongest version: for a large nearly orthogonal code family, Bessel/Gram
   constraints force many wrong codewords to have small correlation with any
   bounded label regression. Such neutral codewords are legal weak handles.
   A real counterexample would therefore need computational hidden-handle
   hardness, not just pairwise anti-correlation.

### Concrete Obstacles

- The source learner is only constrained on realizable labeled distributions.
  Calls on arbitrary agnostic labels can be adversarially bad without violating
  the source node.

- The sample-only realizable-to-agnostic conversion enumerates clean traces;
  this is generally exponential in the representation size and so does not
  yield an efficient atlas target.

- Known distribution-free weak agnostic hardness results do not automatically
  transfer to marginal-nonuniform targets, because the hard marginal may vary
  and the target may choose a marginal-dependent polynomial and gap.

- Known fixed-marginal lower bounds for halfspaces are strong-excess lower
  bounds, not fixed-marginal no-weak-advantage lower bounds at every
  inverse-polynomial scale.

- Standard cleanly decodable noisy-hard classes leak neutral handles
  (parities, random codewords, constants, wrong slices, wrong lengths, or local
  moves), and eliminating those handles tends to make clean proper learning
  hard or to move the hard instance into the marginal.

### Promising Directions For Deeper Subagents

1. **Formal selector equivalence.** Prove a clean lemma: low-noise coupling plus
   a same-marginal middle-noise proper selector is equivalent, up to validation
   slack, to the target node. This will not resolve the edge, but it precisely
   isolates what remains to prove or refute.

2. **Tiegel fixed-Gaussian weak audit.** Read the full fixed-Gaussian theorem
   and known Gaussian halfspace algorithms to determine whether there is any
   hidden no-weak-advantage corollary. My current reading says no, but this is
   worth a focused pass.

3. **KSS weak-threshold audit.** Revisit the conjunction/set-cover reduction
   and ask whether weights can be set so that merely achieving error below
   $1/2-1/\operatorname{poly}$ forces a hard cover, while keeping one fixed
   marginal and avoiding easy weak handles.

4. **Computational hidden-handle construction.** Search for a fixed-marginal
   trace family with efficient clean proper promise extension, but where
   finding any legal trace with correlation at least
   $-1/\operatorname{poly}(s)$ is computationally hard. This is narrower than
   ordinary hard ERM or nearest-codeword hardness.

5. **Positive subclasses.** Prove the edge under extra structure: computable
   $L_1(P)$ proper covers, efficient cost-sensitive trace optimization,
   complements or balanced proper samplers, SQ/noise-tolerant realizable
   learners, or legal projection/pasting operations.

### Sources Consulted

- `atlas/definitions/efficient-realizable-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/arguments/marginal-agnostic-hardness-open.md`
- `atlas/arguments/properization-open.md`
- Prior scratchpad:
  `scratchpads/open-edge-resolution-2026-05-07/efficient-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`
- Hopkins--Kane--Lovett--Mahajan, "Realizable Learning is All You Need",
  arXiv:2111.04746 / TheoretiCS 2024.
- Hanneke--Moran--Thiessen, "Marginal-Nonuniform PAC Learnability", NeurIPS
  2025 / OpenReview.
- Tiegel, "Hardness of Agnostically Learning Halfspaces from Worst-Case
  Lattice Problems", COLT 2023.

RESOLVED: no

## Depth 2 Attempt: Selector Equivalence and Tiegel Weak Audit

### Verdict

I did not resolve the edge. The clean conclusion is sharper than depth 1:
after the low-noise coupling, the exact remaining content is a same-marginal
middle-noise proper selector. Tiegel's halfspace hardness does not supply a
counterexample to this selector. In fact, for the fixed standard-Gaussian
marginal, known proper Gaussian halfspace algorithms give the atlas weak target
for halfspaces at constant slack.

### Setup And Notation

Use labels in $\{\pm1\}$. For a fixed marginal $P$ and a joint distribution
$\mathcal D$ with regression labels $Y$, define

$$
\rho_{\mathcal D}(h)=\mathbf E_{\mathcal D}[h(X)Y],
\qquad
\rho^\star_{\mathcal D}=\sup_{c\in\mathcal C}\rho_{\mathcal D}(c),
\qquad
\eta_{\mathcal D}=\operatorname{OPT}_{\mathcal C}(\mathcal D).
$$

Then $\eta_{\mathcal D}=(1-\rho^\star_{\mathcal D})/2$, and the target
condition

$$
\operatorname{err}_{\mathcal D}(h)
\le \eta_{\mathcal D}+\frac12-\gamma_P(s)
$$

is exactly

$$
\rho_{\mathcal D}(h)
\ge \rho^\star_{\mathcal D}-1+2\gamma_P(s).
$$

Fix a distribution-free realizable proper learner $A$. Run it at a constant
clean accuracy, say $1/64$, and let $m_A(s)$ be a worst-case bound on the number
of labels inspected in such a run at constant confidence. Set

$$
\alpha_A(s)=\min\{1/128,\;1/(256m_A(s))\}.
$$

The exact constants are not important; what matters is that $\alpha_A$ is
inverse-polynomial and small enough that a batch seen by $A$ is uncorrupted with
inverse-polynomial probability when $\operatorname{OPT}<\alpha_A$.

### Low-Noise Coupling

If $\eta_{\mathcal D}<\alpha_A(s)$, choose a near-optimal
$c^\star\in\mathcal C$ with
$\Pr[c^\star(X)\ne Y]\le\eta_{\mathcal D}+o(\alpha_A)$. Couple a noisy run and a
clean realizable run using the same instance sequence $X_i\sim P$: the clean
labels are $c^\star(X_i)$ and the noisy labels are $Y_i$.

With probability at least $1-m_A(s)(\eta_{\mathcal D}+o(\alpha_A))$, all labels
inspected by the constant-accuracy run are uncorrupted. On that event the noisy
transcript is a valid successful clean transcript under the original marginal
$P$, so the output $h\in\mathcal C$ satisfies

$$
\operatorname{err}_P(h,c^\star)\le 1/64.
$$

Thus

$$
\operatorname{err}_{\mathcal D}(h)
\le \eta_{\mathcal D}+1/64+o(\alpha_A).
$$

Repetition and holdout validation turn this into a polynomial list containing a
candidate satisfying the target with large slack, for every weak gap
$\gamma_P(s)\ll\alpha_A(s)$. This part is genuinely marginal-preserving: the
clean comparison run uses the same original $P$, not a conditional clean
marginal.

### Exact Selector Equivalence

For this edge, after the low-noise branch above, the following middle-noise
selector is theorem-equivalent to the target, up to constant slack.

For every fixed marginal $P$, there should exist an inverse-polynomial
$\gamma_P(s)\le\alpha_A(s)/100$ and one uniform algorithm $S$ with
$P$-dependent polynomial resource bound such that, for every joint distribution
$\mathcal D$ with marginal $P$ and
$\eta_{\mathcal D}\ge\alpha_A(s)$, with high probability $S$ outputs a
polynomial-size list $L\subseteq\mathcal C$ containing some $h$ with

$$
\operatorname{err}_{\mathcal D}(h)
\le \eta_{\mathcal D}+\frac12-8\gamma_P(s),
$$

equivalently

$$
\rho_{\mathcal D}(h)
\ge \rho^\star_{\mathcal D}-1+16\gamma_P(s).
$$

Why this is sufficient: run the low-noise candidate generator and $S$ in
parallel, union their lists, and validate all candidates on a fresh sample of
size $O(\gamma_P(s)^{-2}\log(|L|/\delta))$. If
$\eta_{\mathcal D}<\alpha_A$, the low-noise list contains a good candidate; if
$\eta_{\mathcal D}\ge\alpha_A$, the selector list contains one. Empirical
minimization over the validated list loses only constant-factor slack in
$\gamma_P$, proving the marginal-nonuniform weak agnostic proper target.

Why this is necessary: if the target learner already exists with gap
$\Gamma_P(s)$, then in the middle-noise regime a singleton selector is obtained
by running that learner once and setting $\gamma_P=\Gamma_P/8$ for the selector
statement. Thus the selector is not merely a helpful sufficient condition; it is
exactly the missing middle-noise content once the low-noise coupling is granted.

### Neutralizer Form

The selector can be phrased as a signed neutralization problem. In the
middle-noise regime $\eta_{\mathcal D}\ge\alpha_A(s)$, we have

$$
\rho^\star_{\mathcal D}\le 1-2\alpha_A(s).
$$

Therefore a stronger but very clean sufficient condition is to find a legal
proper hypothesis satisfying

$$
\rho_{\mathcal D}(h)\ge -\alpha_A(s)
$$

whenever $\gamma_P(s)\le\alpha_A(s)/2$, since then

$$
-\alpha_A(s)
\ge -2\alpha_A(s)+2\gamma_P(s)
\ge \rho^\star_{\mathcal D}-1+2\gamma_P(s).
$$

This "not noticeably anti-correlated" proper neutralizer would prove the edge.
However, it is not necessary. The exact target only requires
$\rho(h)\ge\rho^\star-1+2\gamma_P$, which may be far below $-\alpha_A$ when
$\eta_{\mathcal D}$ is much larger than $\alpha_A$. So the exact equivalence is
the selector above; the fixed-threshold neutralizer is a useful sufficient
strengthening.

This also explains why constants solve the improper version: one of the two
constant classifiers has nonnegative correlation with any labels. Proper
learning lacks that neutralizer unless constants, complements, a balanced
sampler, or some other legal handle is present in $\mathcal C$.

### Tiegel Distribution-Independent Hardness Audit

Tiegel's distribution-independent theorem rules out even improper weak learning
of halfspaces under worst-case lattice assumptions. The informal theorem says
there is no polynomial-time algorithm outputting any binary hypothesis with
error $1/2-1/\operatorname{poly}(M)$, and the formal construction gives
hardness of advantage as tiny as $\exp(-\Omega(\log^{1+c} M))$, while the best
halfspace error is as small as $\exp(-\Omega(\log^{1-c'}M))$.

This does not settle the present marginal-nonuniform weak edge for two separate
reasons.

First, the hard marginal in the distribution-independent construction varies
with the hidden CLWE direction and with the reduction. Marginal-nonuniform
learning allows the runtime polynomial to depend on each fixed instance
marginal, so a uniform distribution-free lower bound over a moving hard family
does not immediately refute a marginal-nonuniform target.

Second, and more decisively for the atlas weak guarantee, the hard construction
has

$$
\operatorname{OPT}_{\mathrm{LTF}}
\approx \exp(-\Omega(\log^{1-c'}M)),
$$

which is larger than every inverse polynomial for large $M$. Since the atlas
target may choose $\gamma_P(M)=1/\operatorname{poly}(M)$, even an error-$1/2$
neutral hypothesis would satisfy

$$
\frac12
\le \operatorname{OPT}_{\mathrm{LTF}}+\frac12-\gamma_P(M)
$$

for sufficiently small inverse-polynomial $\gamma_P$. Thus the
distribution-independent theorem is a strong absolute weak-learning lower bound,
but it is not a no-selector lower bound at the atlas's additive
$\operatorname{OPT}+1/2-\gamma$ threshold.

### Tiegel Fixed-Gaussian Hardness Audit

The fixed-Gaussian theorem is closer to what this edge needs because the
instance marginal is fixed. Tiegel proves that for Gaussian marginal, learning
halfspaces to error

$$
\operatorname{OPT}_{\mathrm{LTF}}+\varepsilon
$$

requires time/sample roughly

$$
M^{\tilde\Omega(1/\varepsilon^{2-\beta})}
$$

under the same lattice assumptions. In the proof, the hard distribution has
$\operatorname{OPT}_{\mathrm{LTF}}\le 1/2-c/\sqrt M$, and the reduction turns an
$\operatorname{OPT}+\varepsilon$ learner into a distinguisher only when
$\varepsilon=O(1/\sqrt M)$, so that the learned hypothesis has absolute error
below $1/2-1/\operatorname{poly}(M)$.

That is a strong-accuracy obstruction, not a weak-additive obstruction. The
atlas target for the fixed Gaussian marginal could ask only for, say,

$$
\operatorname{err}(h)\le \operatorname{OPT}_{\mathrm{LTF}}+\frac14,
$$

which corresponds to a constant weak gap
$\gamma_{\mathrm{Gauss}}=1/4$. Tiegel's lower bound at constant
$\varepsilon$ is only polynomial in $M$, so it cannot contradict such a
constant-slack weak target.

Known algorithms point in the positive direction for this marginal. Kalai,
Klivans, Mansour, and Servedio's $L_1$ polynomial-regression method gives an
improper Gaussian/log-concave agnostic learner with error
$\operatorname{OPT}+\varepsilon$ in polynomial dimension time for every fixed
constant $\varepsilon$. More importantly for this proper edge, Diakonikolas,
Kane, Kontonis, Tzamos, and Zarifis give a proper Gaussian halfspace learner
with

$$
\operatorname{err}(h)\le\operatorname{OPT}+\varepsilon
$$

and runtime/sample complexity $d^{\operatorname{poly}(1/\varepsilon)}$ (more
specifically their main theorem has sample $d^{O(1/\varepsilon^4)}$ up to
polynomial factors). Setting $\varepsilon=1/4$ gives a polynomial-time proper
weak agnostic learner for halfspaces under the fixed Gaussian marginal.

So the fixed-Gaussian audit goes the opposite way from a separation: the
Gaussian marginal is not a hard marginal for this weak proper target. It is a
hard marginal only for high-accuracy excess-error learning.

### What Would Still Be Needed For A False Result

A Tiegel-style false witness for this exact edge would need a fixed marginal
$P$ and a concept class with efficient distribution-free realizable proper
learning such that, for some hard conditional label distributions with
$\operatorname{OPT}\le\gamma_P(s)$, no polynomial-time algorithm can find even a
proper hypothesis of absolute error below $1/2-\gamma_P(s)$. Equivalently, in
the selector language, every efficiently findable legal proper concept would
have correlation below the exact threshold
$\rho^\star-1+2\gamma_P(s)$.

Tiegel's distribution-independent hard instances have the no-advantage feature
but not a usable fixed-marginal atlas separation. Tiegel's fixed-Gaussian
instances have the fixed marginal but not the no-weak-additive feature; known
proper Gaussian algorithms already give the weak target. This leaves the same
open primitive as before: a fixed-marginal weak signed-search hardness result
with no constants, no neutral handles, and efficient clean proper
realizability.

### Sources Checked

- Current edge note:
  `atlas/implications/efficient-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- Target definition:
  `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- Tiegel, "Hardness of Agnostically Learning Halfspaces from Worst-Case
  Lattice Problems", COLT 2023:
  https://proceedings.mlr.press/v195/tiegel23a.html
- Diakonikolas, Kane, Kontonis, Tzamos, and Zarifis, "Agnostic Proper Learning
  of Halfspaces under Gaussian Marginals", COLT 2021:
  https://proceedings.mlr.press/v134/diakonikolas21b.html
- Kalai, Klivans, Mansour, and Servedio, "Agnostically Learning Halfspaces",
  SIAM Journal on Computing 2008:
  https://doi.org/10.1137/060649057

RESOLVED: no

## Depth 3 Attempt: KSS Weak-Threshold Audit

### Verdict

I did not resolve the edge. The Kearns--Schapire--Sellie
conjunction/set-cover reduction is still a strong-accuracy proper agnostic
hardness result, not a fixed-marginal weak-threshold separation for this atlas
edge.

The short reason is that the KSS gadget has easy legal handles. The same
"all variables" conjunction that KSS use to upper-bound the optimum is already
a very good weak hypothesis, and the empty conjunction, when legal, is another
near-neutral handle. Tuning the object/set weights runs into a two-anchor
barrier: one can force exact or near-exact set-cover recovery only by asking for
additive accuracy on the order of the set-cover penalty, while the atlas target
may choose a much smaller inverse-polynomial weak gap.

### What The Weak Target Requires

For labels in $\{\pm 1\}$, write

$$
\rho(h)=\mathbf E[h(X)Y],
\qquad
\rho^\star=\sup_{c\in\mathcal C}\mathbf E[c(X)Y].
$$

The target guarantee

$$
\operatorname{err}(h)\le \operatorname{OPT}_{\mathcal C}+\frac12-\gamma
$$

is equivalent to

$$
\rho(h)\ge \rho^\star-1+2\gamma.
$$

So a false witness must prevent even very weak legal selectors. If there is an
easy proper $h_0$ with error at most $1/2$, then every hard instance with
$\operatorname{OPT}\ge\gamma$ is harmless: $h_0$ already satisfies

$$
\operatorname{err}(h_0)\le \frac12
\le \operatorname{OPT}+\frac12-\gamma.
$$

Since the marginal-nonuniform target may choose $\gamma=1/p_P(s)$ with a very
large marginal-dependent polynomial, any KSS-style lower bound whose hard
instances have inverse-polynomial $\operatorname{OPT}$ leaves room for such a
neutral selector.

### KSS Gadget Audit

KSS reduce minimum set cover to proper agnostic learning of conjunctions. For a
set-cover instance with objects $o_i$ and sets $S_j$, they create negative
points $a_i$, positive points $b_j$, and a positive point
$c=(1,\ldots,1)$. A monotone conjunction corresponding to a set subfamily
$B\subseteq[n]$ has the schematic empirical error

$$
\text{uncovered object mass} + \text{selected set penalty}.
$$

In the original weights, each missed object has enough mass that an
$\operatorname{OPT}+\varepsilon$ learner must cover every object, and the
selected $b_j$ penalties then force a minimum-cardinality cover. The proof sets
$\varepsilon$ on the order of $1/(n(t+1))$, far below the weak additive
$1/2-\gamma$ window.

For the weak target, the reduction leaks an immediate handle: the conjunction
of all variables covers every object and only errs on the $b_j$ points. In the
original KSS weighting its error is $1/(4(t+1))$, which is exactly why KSS can
upper-bound $\operatorname{OPT}$ by that quantity. This all-variables
conjunction reveals no minimum cover, but it easily satisfies

$$
\operatorname{err}(h)\le \operatorname{OPT}+\frac12-\gamma
$$

for every inverse-polynomial $\gamma$ smaller than a fixed constant. Thus a
weak-threshold learner could output this legal conjunction and pass validation
without solving set cover.

If the empty conjunction is included, it gives a second simple handle: it
predicts positive everywhere and errs only on the negative object mass. In the
original KSS distribution that error is just below $1/2$. Even if the empty
conjunction is disallowed by convention, the all-variables conjunction remains
legal for the usual conjunction class.

### Weight-Tuning Obstruction

I tried to abstract the KSS construction as a weighted set system. Let

- $A$ be the total mass of object/negative points,
- $B$ be the total mass of selected-set penalty points,
- $C$ be any enforcement mass, such as the positive point used to rule out
  negated literals.

The empty conjunction, if legal, has error $A$. The all-variables conjunction
has error $B$ and is correct on the object points and on the usual positive
enforcement point $c$. Since $A+B+C=1$ with $C\ge 0$, one has
$\min(A,B)\le 1/2$.

Therefore, whenever the KSS hard labels have
$\operatorname{OPT}\ge\gamma$, at least one of these canonical handles has
error at most $1/2$ and hence satisfies the weak atlas inequality. Raising the
$b_j$ weights to punish the all-variables conjunction lowers the relative
object mass and makes the empty/all-positive handle better; raising object
weights has the opposite effect. The original exact-cover forcing works because
the requested additive tolerance is tiny, not because the construction removes
all weak selectors.

One might try to set $A\approx B\approx 1/2$ and make
$\operatorname{OPT}<\gamma$, so both anchors miss a threshold slightly below
$1/2$. That does not give a clean separation for this edge. If
$\operatorname{OPT}$ is inverse-polynomial, the target can choose a smaller
inverse-polynomial $\gamma$. If $\operatorname{OPT}$ is below the polynomial
low-noise scale, the generic low-noise coupling from the realizable proper
source becomes applicable and produces a valid proper candidate by clean-run
simulation plus validation. This is exactly the low-noise branch already
isolated in depths 1 and 2.

Restricting the class to remove the all-variables conjunction also looks
dangerous. Size-bounded or exact-size conjunction classes can make the clean
realizable proper problem itself set-cover-like: on an arbitrary marginal, a
proper learner may need to find a small conjunction consistent with the sample.
So this route risks destroying the source node rather than separating the
target.

### Fixed-Marginal Obstruction

There is also a separate marginal-nonuniform problem. The KSS distribution
places the set-cover instance directly into the support points $a_i$ and
$b_j$. Thus the hard marginal varies with the set-cover instance. A
marginal-nonuniform learner is allowed a polynomial bound depending on each
fixed marginal, so the usual distribution-free KSS reduction does not refute
the target.

A universal-slice repair would put all set-cover instances into one fixed
marginal and use the label rule to select the hard slice. But there are
exponentially many instances of each size, so assigning all slices noticeable
mass is impossible. If the selected slice has exponentially small mass, the
weak atlas threshold cannot force the learner to solve that slice. If one
hardwires a single polynomial-mass sequence of hard instances into the marginal,
the statement becomes nonuniform/average-case rather than an $\mathrm{RP}\ne
\mathrm{NP}$ consequence of KSS.

### Stronger Monomial Weak-Hardness Results

Feldman, Guruswami, Raghavendra, and Wu prove a much closer-looking theorem:
given labeled examples for which some monomial has error at most a constant
$\varepsilon$, it is NP-hard to find even a halfspace with accuracy
$1/2+\varepsilon$. This is genuine weak agnostic hardness for monomials, and it
subsumes proper monomial hardness.

However, it still does not settle this edge. First, the hard distribution is
produced from a Label Cover instance, so the marginal again moves with the hard
instance. Second, their target conclusion asks for absolute error below
$1/2-\varepsilon$, whereas the atlas guarantee allows

$$
\operatorname{OPT}+\frac12-\gamma.
$$

When $\operatorname{OPT}\le\varepsilon$ and $\gamma\ll\varepsilon$, error
$1/2$ is already acceptable. To turn their theorem into an atlas separation one
would need a no-advantage fixed-marginal statement at every inverse-polynomial
gap scale, not just constant weak learning hardness for a moving hard
distribution.

### Conclusion

The KSS/set-cover route does not currently resolve the edge. The reduction can
force exact cover recovery for $\operatorname{OPT}+\varepsilon$ learning, but
the weak threshold $\operatorname{OPT}+1/2-\gamma$ admits legal neutral or
near-neutral conjunctions. Weight tuning appears blocked by the two-anchor
tradeoff between all-positive and all-selected conjunctions, and the original
reduction also encodes the hard instance in the marginal.

The most promising continuation is not another KSS weight tweak, but a
different fixed-marginal signed-search construction: efficient clean proper
learning, no constants or universal legal handles, and hardness of finding any
proper hypothesis with correlation at least $-1/\operatorname{poly}(s)$ in the
middle-noise regime.

Sources checked:

- Kearns, Schapire, and Sellie, "Toward Efficient Agnostic Learning",
  Machine Learning 1994:
  https://www.cis.upenn.edu/~mkearns/papers/agnostic-journal.pdf
- Feldman, Guruswami, Raghavendra, and Wu, "Agnostic Learning of Monomials by
  Halfspaces Is Hard", SIAM Journal on Computing 2012:
  https://doi.org/10.1137/120865094
- Current scratchpad depths 1 and 2 above.

RESOLVED: no

## Depth 4 Attempt: Strong Realizable Source and Random Relabeling

### Verdict

I did not resolve the edge. Strong realizable proper learning helps in the
already-handled low-noise regime, but I do not see a sound way to convert it
into a same-$P$ proper neutralizer or selector by running the learner on random
relabelings or small synthetic mixtures.

The basic obstruction is still the promise boundary. The strong source learner
is guaranteed only when its labeled example oracle is exactly realizable by some
$c\in\mathcal C$. Random labels, agnostic labels, and most mixtures are not
realizable distributions. Asking for higher accuracy makes the clean guarantee
stronger, but it does not impose any new behavior on these off-promise calls.

### Goal Of This Pass

The hope was that the strong source, unlike a weak source, might let us run the
proper learner at very high accuracy on synthetic same-marginal tasks and thereby
manufacture a list of legal hypotheses. One would then validate this list on the
true agnostic examples and pick a hypothesis satisfying

$$
\operatorname{err}(h)\le \operatorname{OPT}_{\mathcal C}+\frac12-\gamma_P(s).
$$

In correlation notation, this would amount to generating a polynomial list
$L\subseteq\mathcal C$ that contains some $h$ with

$$
\rho(h)\ge \rho^\star-1+2\gamma_P(s),
$$

or, in the stronger middle-noise neutralizer form, some $h$ with
$\rho(h)\ge -1/\operatorname{poly}(s)$.

I considered three variants:

1. draw $X_1,\ldots,X_m\sim P$, assign independent random labels, and run the
   strong proper learner;
2. use a small synthetic mixture of true agnostic labels, random labels, and/or
   labels from a known anchor concept;
3. use random relabelings only as a way to sample many proper concepts, then use
   holdout validation on the real labels to select among them.

All three run into the same missing ingredient: a way to ensure that the
learner's synthetic call is a realizable same-$P$ task, or at least a way to
control the learner's behavior when it is not.

### Random Labels Are Not A Realizable Oracle

Let $A$ be the strong realizable proper learner. Its theorem applies to an
oracle of the form

$$
X\sim P,\qquad Z=c(X)
$$

for some fixed $c\in\mathcal C$. If instead $Z$ is an independent random sign
or bit, then for every deterministic $c$,

$$
\Pr[Z\ne c(X)]=1/2.
$$

So the synthetic distribution is maximally agnostic, not realizable. Running
$A$ on this oracle is an off-promise call. The definition of
[[efficient-realizable-proper-pac|Efficient Realizable Proper PAC Learning]]
does not require $A$ to behave like ERM, to return a best proper fit, to return
a random extension, or even to have error below $1/2$ on such labels.

One can try to avoid the repeated-label problem by first drawing a finite
unlabeled sample $S=\{x_1,\ldots,x_m\}$ and assigning one random label $r_i$ to
each atom. This creates an empirical labeled distribution. But this empirical
distribution is realizable only if the random trace

$$
(r_1,\ldots,r_m)
$$

extends to some concept in $\mathcal C$. For a fixed useful concept $c$, a
random trace agrees with $c$ on all $m$ points with probability $2^{-m}$. If the
source learner is run at accuracy small enough to support an inverse-polynomial
weak gap or a reliable same-$P$ selector, its sample size is generally
$m=\operatorname{poly}(s)$, so hitting the trace of any particular useful
concept by random relabeling is exponentially unlikely. Taking
$m=O(\log s)$ makes the hit probability polynomial, but then the trace is too
small to force any global same-$P$ behavior.

Even when the random trace is realizable, the conclusion is only accuracy on
the synthetic empirical distribution. A high-accuracy fit to random labels on a
finite set does not by itself say that the extension is neutral under $P$ or
under the true agnostic labels. It may simply be an arbitrary legal extension
chosen by the implementation of $A$.

### High Accuracy Makes The Random-Hit Problem Worse

The strong source is useful when the labels are clean. In the low-noise branch,
we run $A$ at a fixed clean accuracy and couple the noisy sample to a clean
sample from a near-optimal $c^\star$. If the noise rate is below about
$1/m_A(s)$, a whole source-scale transcript is uncorrupted with inverse-
polynomial probability, and validation recovers a good proper candidate.

Random relabeling has the opposite monotonicity. Running $A$ to higher accuracy
usually increases the number of labels whose consistency must be explained by a
single concept. A randomly chosen labeling agrees with a desired clean trace
with probability $2^{-m_A(s,\varepsilon)}$. Thus the extra strength of the
source does not create more chances to find a clean trace; it decreases the
chance that a random synthetic trace is the clean trace of any particular
candidate one wants.

This is the same barrier as the trace-enumeration route in the
realizable-to-agnostic sample reductions. Enumerating all labelings of a
source-scale unlabeled sample is statistically powerful because one labeling
matches the near-optimal concept. Sampling polynomially many random labelings
does not replace that enumeration when the source-scale sample size is
polynomial.

### Synthetic Mixtures Still Break The Promise

A second idea is to add a small clean or random component to the true agnostic
data, hoping to tilt the problem toward a realizable distribution while keeping
the marginal essentially $P$.

This does not preserve the source promise. If the synthetic label is

$$
Z =
\begin{cases}
Y & \text{with probability } 1-\lambda,\\
R & \text{with probability } \lambda,
\end{cases}
$$

where $R$ is random, then conditional on $X=x$ the label is generally
stochastic. Unless the original labels already agree almost surely with some
$c\in\mathcal C$, there is no deterministic concept realizing this mixture.
Replacing $R$ by an anchor label $c_0(X)$ gives the same issue: a mixture of
two label rules is not a realizable concept-labeling distribution unless the
class is closed under the relevant pasting operation and the mixture is
implemented by deterministic regions of the instance space.

If one uses only the clean anchor labels, the learner just returns something
close to the anchor. That is useful only when the anchor is already a legal
neutralizer. The open problem is precisely that a general proper class need not
provide constants, complements, balanced samplers, or any other anchor that is
guaranteed not to be noticeably anti-correlated with the agnostic labels.

If one tags examples or moves the synthetic component to a disjoint support, the
task also stops being the same fixed marginal $P$ unless the original class and
instance space already contain the required tagging/pasting structure. That is
extra structure, not a consequence of strong realizable proper PAC learning.

### Random Relabeling As A Sampler Over Proper Concepts

A more charitable version avoids using the output of $A$ as a learner for the
synthetic labels. Instead, random relabeling is just a way to induce a
distribution $\Pi_P$ over legal concepts. Then the real labels are used only for
validation: draw $h_1,\ldots,h_N\sim\Pi_P$, estimate their real errors, and keep
the best.

This would work if $\Pi_P$ were known to be balanced enough that, for every
label regression function $\mu(x)=\mathbf E[Y\mid X=x]$, a polynomial sample
from $\Pi_P$ contains some $h$ with nonnegative or only mildly negative
correlation

$$
\mathbf E_{X\sim P}[h(X)\mu(X)].
$$

But random relabeling through an arbitrary proper learner gives no such balance
condition. If

$$
q(x)=\mathbf E_{h\sim\Pi_P}[h(x)]
$$

is not approximately zero on the relevant support, then an adversarial
conditional label rule can align $\mu(x)$ against $q(x)$, making the average
sampled hypothesis anti-correlated. Complements or a pointwise balanced proper
sampler would fix this, but neither is implied by the source node.

Validation can only choose among candidates that have actually been generated.
It cannot repair a generator whose polynomial list misses every same-$P$
neutral or weakly good proper hypothesis for the current labels.

### Why Finite-Sample Consistency Is Not Enough

There is a tempting finite-VC thought: if a random trace is realizable on a
large sample $S$, perhaps the resulting proper extension is nearly orthogonal
to every fixed concept in $\mathcal C$ under $P$, because its labels on $S$ look
random. This can be true under extra assumptions: for example, if the trace is
realizable, if the sample is a uniform-convergence sample for
$\mathcal C\triangle\mathcal C$, and if $A$ returns an extension that really
fits that trace.

Even this stronger statement would not settle the agnostic selector. The labels
$Y$ in the target are arbitrary; they need not be a concept plus benign noise.
Near-orthogonality to every concept in $\mathcal C$ does not imply
near-orthogonality to an arbitrary regression function $\mu$. Also, the
preconditions are not supplied by the source guarantee: random traces need not
be realizable, and the learner's choice among possible extensions can be
uncontrolled.

So finite-sample realizability would be a possible extra route for rich,
well-behaved classes with a balanced extension sampler. It is not a theorem
from strong realizable proper PAC learning alone.

### Black-Box Lesson

This attempt reinforces the black-box obstruction. Any reduction that uses
$A$ only on genuinely clean concept labels is safe but seems limited to the
low-noise coupling and exponential clean-trace enumeration. Any reduction that
uses $A$ on arbitrary, random, residual, or mixed labels needs an additional
promise about off-realizable behavior.

The source definition permits a correct realizable learner whose behavior on
non-realizable call distributions is completely unhelpful. Strong accuracy
changes the quantitative guarantee on realizable distributions; it does not
turn the learner into a tolerant proper ERM oracle, a cost-sensitive optimizer,
a balanced sampler, or a projection operator.

### Remaining Directions

The random-relabeling idea could still become useful under extra hypotheses:

- an efficient same-$P$ sampler over proper concepts with
  $\mathbf E[h(x)]\approx 0$ pointwise or in $L_1(P)$;
- an efficient proper extension algorithm that, on random realizable traces,
  samples a balanced version space rather than an arbitrary extension;
- a polynomial proper cover/list generator for each fixed marginal $P$;
- closure under complements, randomized mixtures that can be derandomized
  properly, or deterministic pasting operations;
- a tolerant proper learner or cost-sensitive oracle, which is already much
  closer to the desired agnostic selector.

None of these follows from the current source node. My conclusion is that
strong realizable proper learning does not by itself make random relabeling or
small synthetic mixtures a sound path to the same-$P$ proper neutralizer.

RESOLVED: no

## Depth 5 Attempt: Reduction To Weak Realizable Core

Question for this attempt: does the edge

$$
\texttt{efficient-realizable-proper-pac}
\to
\texttt{efficient-marginal-nonuniform-weak-agnostic-proper-pac}
$$

reduce to the same target edge with the weaker source

$$
\texttt{efficient-weak-realizable-proper-pac}
\to
\texttt{efficient-marginal-nonuniform-weak-agnostic-proper-pac}?
$$

### Exact Reduction

Let

$$
S=\texttt{efficient-realizable-proper-pac},
\quad
W=\texttt{efficient-weak-realizable-proper-pac},
\quad
T=\texttt{efficient-marginal-nonuniform-weak-agnostic-proper-pac}.
$$

The atlas already has the monotone implication $S\to W$: a strong realizable
proper learner can be run at any fixed constant accuracy, say
$\varepsilon=1/4$, to obtain a weak realizable proper learner with advantage
$\gamma=1/4$. The output remains proper, and the running time and sample
complexity stay polynomial because $1/\varepsilon$ is constant.

Therefore any theorem proving $W\to T$ immediately proves $S\to T$ by
composition:

1. Start with a class $\mathcal C$ satisfying $S$.
2. Convert its strong proper realizable learner $A_S$ into a weak proper
   realizable learner $A_W$ by calling $A_S(\varepsilon=1/4,\delta)$.
3. Apply the hypothetical proof or transformer for $W\to T$ to $A_W$.
4. The resulting learner witnesses $T$ for $\mathcal C$.

Equivalently, the positive proof obligation for this strong-source edge is a
special case of the weak-realizable-core edge. No marginal-nonuniform issue is
introduced by the reduction: the marginal-dependent polynomial and weak gap in
$T$ are exactly those delivered by the hypothetical $W\to T$ theorem.

For negative results the direction is one-sided but still informative. If
there is a counterexample to $S\to T$, then that same class is also a
counterexample to $W\to T$, because every strong realizable proper learner gives
a weak realizable proper learner. But a counterexample to $W\to T$ need not
counterexample $S\to T$, since it might satisfy weak proper learnability without
satisfying strong proper learnability.

### What Remains Unique Here

This scratchpad still contains useful information not literally contained in
the weak-source scratchpad, but it is mainly diagnostic rather than a separate
core obstruction.

The unique positive information is that strong realizable proper learning gives
arbitrary clean accuracy. This makes the low-noise coupling cleaner: one can
set a small clean error such as $1/32$ and define the low-noise threshold from
the number of labels inspected by that strong run. The weak-source edge has the
same kind of low-noise coupling, but with constants tied to the fixed weak
advantage. In both cases this only handles the low-noise branch.

The unique negative/diagnostic information is that attempts to exploit strong
accuracy did not produce the missing middle-noise selector. Strong learning
controls only realizable labeled distributions. It does not constrain calls on
random labels, residual labels, mixed labels, filtered noisy labels, or
off-promise synthetic examples. Thus arbitrary accuracy does not by itself give
a same-marginal proper neutralizer, a balanced sampler over legal concepts, a
proper cover/list generator, or a tolerant/cost-sensitive proper oracle.

So the remaining content of this scratchpad should be read as evidence that the
extra strength in $S$ improves constants and low-noise bookkeeping but has not
revealed any leverage over the middle-noise proper-selector problem. The
mathematical core remains the weak-source edge $W\to T$ unless one finds a new
argument using arbitrary clean accuracy in a way that avoids off-promise calls.

RESOLVED: yes for the reduction question. The original atlas edge remains open
because the weak-realizable-core edge remains open.

## Depth 6 Attempt: Pseudo-Label Projection

Question for this attempt: can the extra strength of
`efficient-realizable-proper-pac` be used as a projection device? More
concretely, suppose we first construct an improper predictor $g:X\to\{\pm1\}$
from the agnostic data, then pseudo-label fresh unlabeled examples by
$\tilde Y=g(X)$, and finally run the high-accuracy realizable proper learner on
$(X,\tilde Y)$ in order to output a proper $h\in\mathcal C$. If this worked, it
would turn an improper weak agnostic handle into the needed proper weak
agnostic hypothesis.

### Conditional Argument If Projection Were Real

There is a clean conditional theorem here, but it assumes almost exactly the
missing primitive.

Assume an oracle $\Pi$ with the following tolerant projection guarantee: given
sample access to $X\sim P$ and pseudo-labels $g(X)$, it outputs $h\in\mathcal C$
with

$$
\Pr_P[h(X)\ne g(X)]
\le
\inf_{c\in\mathcal C}\Pr_P[c(X)\ne g(X)] + \tau.
$$

If, in addition, there is a proper comparator $c^\star\in\mathcal C$ close to
$g$ under $P$, then validation on the real agnostic labels would preserve
correlation up to the projection error. Indeed, for $\mu(x)=\mathbf E[Y\mid X=x]$,

$$
\left|\mathbf E_P[(h(X)-g(X))\mu(X)]\right|
\le 2\Pr_P[h(X)\ne g(X)].
$$

So if $g$ has correlation $\mathbf E[g\mu]$ and $\Pi$ returns a hypothesis
within distance $\kappa$ of $g$, then

$$
\mathbf E[h\mu]\ge \mathbf E[g\mu]-2\kappa.
$$

A polynomial-time proper tolerant projection oracle, together with an improper
predictor whose good behavior is witnessed by a nearby proper concept, would
therefore give a route to the weak proper target.

But this is not supplied by strong realizable proper learning. It is a
tolerant/agnostic projection assumption.

### First Flaw: The Pseudo-Labeled Distribution Is Off Promise

The realizable learner $A$ is guaranteed only when the pseudo-labels are
generated by some $c\in\mathcal C$. For a general improper predictor $g$, the
distribution

$$
X\sim P,\qquad \tilde Y=g(X)
$$

is deterministic but need not be realizable by $\mathcal C$. Thus running $A$
on these labels is an off-promise call. High clean accuracy does not constrain
what $A$ does on that call.

This is not just a black-box nicety. A learner can be perfectly correct on all
realizable input distributions while its fallback behavior on inputs that its
clean-learning routine does not recognize is a fixed, unhelpful proper
hypothesis. If the fallback has negligible probability under every realizable
distribution, the source guarantee is unchanged, but pseudo-label calls may
hit it systematically. A positive atlas implication cannot rely on such
off-promise behavior unless the source definition explicitly includes
tolerance, empirical-risk minimization, or approximate projection.

### Second Flaw: Improper Accuracy Does Not Mean Proper Closeness

Even if $g$ is an excellent improper predictor of the real labels, there need
not be any proper $c\in\mathcal C$ close to $g$ under $P$. The target asks for a
proper hypothesis correlated with the true regression function $\mu$, not a
proper hypothesis close in unweighted disagreement to an arbitrary improper
classifier.

The difference matters because agnostic proper learning optimizes the weighted
objective

$$
\max_{c\in\mathcal C}\mathbf E_P[c(X)\mu(X)],
$$

whereas pseudo-label projection to $g=\operatorname{sign}(\mu)$ optimizes an
unweighted disagreement objective. These can point in opposite directions.

A toy two-block example shows the failure of the objective. Let $P(A)=0.9$,
$P(B)=0.1$, let $\mu=+0.01$ on $A$ and $\mu=-1$ on $B$, and let
$g=\operatorname{sign}(\mu)$. For the class containing only the two constants,
unweighted projection to $g$ selects the constant $+1$, since it disagrees only
on $B$. But the agnostic objective prefers the constant $-1$:

$$
\mathbf E[(+1)\mu]=0.9(0.01)-0.1=-0.091,
$$

while

$$
\mathbf E[(-1)\mu]=-0.9(0.01)+0.1=0.091.
$$

So even projection to the Bayes sign labels can return a proper hypothesis
with negative correlation when the correct proper agnostic choice has positive
correlation. Validation can choose between a polynomial list of candidates, but
plain projection supplies only the candidate produced by its search objective.

### Why Real Labels Do Not Patch This For Free

One might try to use the real labels to build better pseudo-labels or weights.
For instance, if we could sample from the weighted distribution
proportional to $|\mu(x)|\,dP(x)$ and label by $\operatorname{sign}(\mu(x))$,
then the projection objective would match the agnostic objective. But estimating
and optimizing with these weights is already a cost-sensitive or agnostic
proper learning problem over $\mathcal C$.

Another variant is to run many improper predictors $g_1,\ldots,g_N$, project
each one, and validate the resulting proper hypotheses. This would work if the
projection routine generated a polynomial list containing a weakly good proper
candidate. The realizable source guarantee gives no reason for such a list to
exist. It again requires a tolerant proper projector, a cost-sensitive oracle,
a balanced sampler, or a polynomial proper cover/list generator.

### Conclusion

The pseudo-label projection route does not break the current conclusion. It
would prove the edge under an additional tolerant projection assumption, but
strong realizable proper PAC learning alone gives only clean-distribution
accuracy. Pseudo-labels from an improper predictor are generally off-promise,
and even an ideal unweighted projection to those labels can optimize the wrong
objective for agnostic proper learning.

So the flaw is not a constant-loss bookkeeping issue. The proposed projection
is exactly the missing middle-noise proper selector in another form.

RESOLVED: no

## Depth 7 Attempt: Atlas-Ready Strong-To-Weak Core Reduction

Goal of this final pass: write atlas-ready wording for the edge

$$
\texttt{efficient-realizable-proper-pac}
\to
\texttt{efficient-marginal-nonuniform-weak-agnostic-proper-pac}
$$

and check whether any current theorem appears to close it.

### Atlas-Ready Verdict

`open`.

This edge is implied by the still-unresolved weak-realizable proper core edge

$$
\texttt{efficient-weak-realizable-proper-pac}
\to
\texttt{efficient-marginal-nonuniform-weak-agnostic-proper-pac}.
$$

Indeed, a strong realizable proper learner is automatically a weak realizable
proper learner: call it with any fixed constant accuracy, for example
$\varepsilon=1/4$, and keep its proper output. Therefore any proof of the core
edge immediately proves this edge by composition. This reduction is lossless
for the target: the marginal-dependent polynomial bound and inverse-polynomial
weak gap are exactly those supplied by the hypothetical proof of the core edge.

The converse is not available. A counterexample to the weak-realizable proper
core edge need not be strongly realizably properly learnable. Thus the strong
source edge is a special case of the weak-source core, not an equivalent
reformulation.

### Atlas-Ready Proof Status Text

The low-noise branch follows from the strong source by clean-transcript
coupling. Fix the strong realizable proper learner $A$ and run it at constant
clean accuracy. If the agnostic distribution has a near-optimal comparator
$c^\star\in\mathcal C$ with sufficiently small error, then with inverse
polynomial probability the labels inspected by $A$ agree with the clean labels
$c^\star(X)$. Repetition and holdout validation over the resulting proper
outputs give a weak agnostic proper candidate under the same marginal.

The unresolved part is the middle-noise branch. Once
$\operatorname{OPT}_{\mathcal C}(\mathcal D)$ is above the clean-transcript
coupling scale, it would suffice to find a same-marginal proper selector:
a marginal-dependent polynomial-time procedure that outputs a validation-sized
list of concepts containing some $h\in\mathcal C$ with error

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\frac12-\gamma_P(s).
$$

The strong realizable learner does not provide such a selector. It is
constrained only on realizable labeled distributions. Calls on arbitrary,
random, residual, filtered, mixed, or pseudo-labeled examples are off-promise,
and may behave unhelpfully without violating the source guarantee.

Thus the additional strength in the source improves constants and low-noise
bookkeeping, but it has not produced leverage over the same middle-noise
proper-selector problem that blocks the weak-realizable proper core edge.

### Strong-Source Near Misses

The trace-cover route is the closest statistical positive theorem. Benedek and
Itai characterize fixed-distribution learnability by finite coverability, and
the Hopkins-Kane-Lovett-Mahajan black-box reduction runs a realizable learner
over all labelings of an unlabeled sample to obtain an agnostic cover. Since
the source learner here is proper, this cover consists of proper outputs.
However, the construction is computationally label-enumerating. Hopkins et al.
explicitly note that their basic reduction is inherently computationally
inefficient and focus on information-theoretic considerations. This closes the
sample-complexity analogue, not the atlas's polynomial-time implication.

The pseudo-label projection route is another useful restatement of the missing
primitive. If one had a tolerant same-$P$ projection oracle that, given
pseudo-labels from an improper or real-valued predictor, returned a proper
$h\in\mathcal C$ nearly minimizing disagreement or the right weighted
correlation objective, then validation could convert improper or residual
handles into the target proper learner. But strong realizable proper PAC
learning supplies no tolerant projection guarantee. Pseudo-labels are generally
off-promise, and even exact unweighted projection can optimize the wrong
objective for agnostic labels. This is not a settled theorem; it is the
middle-noise selector in projection language.

### Theorem-Check Pass

I found no theorem that closes the original computational edge.

- [Realizable Learning is All You Need](https://proceedings.mlr.press/v178/hopkins22a.html)
  gives the right black-box statistical reduction, including distributional
  assumption settings, but its Algorithm 1 enumerates all labelings of an
  unlabeled sample. The paper explicitly says the reduction is inherently
  computationally inefficient unless one adds extra structure.
- [Learnability with respect to fixed distributions](https://doi.org/10.1016/0304-3975(91)90026-X)
  and [Marginal-Nonuniform PAC Learnability](https://openreview.net/forum?id=aoVCFtox89)
  support the finite-cover/rate picture, but they do not supply an effective
  marginal-dependent proper selector for arbitrary agnostic labels.
- Recent agnostic boosting results, including
  [Revisiting Agnostic Boosting](https://openreview.net/pdf/ed08767fa9494c581d3b229f4c2dfa37adc1b9d1.pdf)
  and [Sample-Near-Optimal Agnostic Boosting with Improved Running Time](https://arxiv.org/abs/2601.11265),
  start from an agnostic weak learner. They do not derive the needed same-$P$
  proper agnostic weak learner from a clean realizable proper learner. The 2026
  improved-time result is polynomial in the sample size with other parameters
  fixed, so it is still not a general polynomial-time proper selector theorem
  for this atlas edge.
- [Tiegel's halfspace hardness](https://proceedings.mlr.press/v195/tiegel23a.html)
  remains a near miss rather than a closing counterexample. The
  distribution-independent lower bound does not match the marginal-nonuniform
  target, and the fixed-Gaussian result is an $\operatorname{OPT}+\varepsilon$
  high-accuracy barrier rather than a refutation of this weak additive target.

### Suggested Atlas Wording

Suggested summary:

> Open: this strong-source edge is a special case of the unresolved
> weak-realizable proper core edge. Strong realizable proper learning gives the
> same low-noise clean-transcript coupling and implicit trace covers, but known
> trace-cover and pseudo-label projection routes do not yield the required
> polynomial-time same-marginal proper selector in the middle-noise regime.

Suggested body addition:

> The edge would follow immediately from
> `efficient-weak-realizable-proper-pac -> efficient-marginal-nonuniform-weak-agnostic-proper-pac`,
> because a strong realizable proper learner can be run at constant accuracy to
> obtain a weak realizable proper learner. The extra strength of the source only
> gives arbitrary clean accuracy. It sharpens the low-noise coupling and the
> implicit fixed-marginal trace-cover intuition, but it does not control
> off-promise calls on agnostic, residual, random, or pseudo-labeled examples.
> Known statistical realizable-to-agnostic reductions enumerate labelings or
> covers and are not computationally efficient in general; known agnostic
> boosting theorems assume an agnostic weak oracle rather than deriving one from
> clean proper learning. Hence the remaining obstruction is the same
> middle-noise same-$P$ proper selector that appears in the weak-realizable
> proper core edge.

RESOLVED: no for the original edge. The only resolved statement here is the
one-way reduction: a proof of the unresolved weak-realizable proper core edge
would imply this strong-source edge.

## Depth 8 Final Incorporation Recommendation

RESOLVED: no for the original edge.

The atlas edge should remain `open`. The depth-1 through depth-8 search did
not find a positive polynomial-time proper selector theorem or a sound
fixed-marginal counterexample. The only settled statement is a one-way
reduction: if the weak-realizable proper core edge

```text
efficient-weak-realizable-proper-pac
  -> efficient-marginal-nonuniform-weak-agnostic-proper-pac
```

is ever proved, then this edge follows immediately, because strong realizable
proper learning implies weak realizable proper learning by running the source
learner at any fixed constant accuracy.

Suggested atlas file:

```text
atlas/implications/efficient-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md
```

Suggested frontmatter updates:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - benedek1991fixed
  - hopkins2024
  - hanneke2025marginalnonuniform
  - dacunha2026agnosticboosting
  - tiegel2023
refs:
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
  - "[Hopkins et al. 2024](https://doi.org/10.46298/theoretics.24.2)"
  - "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
  - "[da Cunha et al. 2026](https://arxiv.org/abs/2601.11265)"
  - "[Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)"
summary: "Open: the edge follows from the unresolved weak-realizable proper core edge, and the strong source handles the low-noise branch by clean-transcript coupling, but trace-cover, pseudo-label projection, and agnostic-boosting routes do not supply the required polynomial-time same-marginal proper selector in the middle-noise regime."
```

Suggested replacement for the short `## Verdict` paragraph:

```markdown
`open`.

Open. The edge is a strong-source special case of the unresolved
weak-realizable proper core edge
`efficient-weak-realizable-proper-pac -> efficient-marginal-nonuniform-weak-agnostic-proper-pac`.
Strong realizable proper learning gives the low-noise clean-transcript
coupling, but no known argument turns the extra clean accuracy into a
polynomial-time same-marginal proper selector for the middle-noise agnostic
regime.
```

Suggested addition to `## Proof Status`, after the low-noise branch:

```markdown
**Reduction to the weak-realizable proper core.** This edge would follow
immediately from
`efficient-weak-realizable-proper-pac -> efficient-marginal-nonuniform-weak-agnostic-proper-pac`.
A strong realizable proper learner can be run with any fixed constant accuracy,
for example $\varepsilon=1/4$, and its proper output is then a weak realizable
proper learner. Thus any proof of the weak-source core edge composes with this
trivial relaxation to prove the present edge. The converse is not known: a
class separating the weak-source core edge need not be strongly realizably
properly learnable.
```

Suggested replacement for the current `Why the source does not supply the
selector` paragraph:

```markdown
**Why the strong source still does not supply the selector.** The extra source
strength gives arbitrary clean accuracy, which improves constants in the
low-noise branch, but it does not control off-promise calls. The learner is
only required to behave on realizable labeled distributions. Calls on agnostic,
residual, filtered, random, mixed, or pseudo-labeled examples may behave
unhelpfully without violating the source guarantee. Therefore the strong source
does not by itself produce the same-marginal proper selector needed when
$\operatorname{OPT}_{\mathcal C}(\mathcal D)$ is in the middle-noise range.
```

Suggested new near-misses subsection before `## References`:

```markdown
## Strong-Source Near Misses

**Trace-cover obstruction.** Fixed-distribution theory and the
realizable-to-agnostic statistical reduction suggest an implicit proper cover:
run the realizable learner over all labelings of an unlabeled sample and keep
the resulting proper hypotheses. This proves the right kind of sample-complexity
intuition, but the cover is generated by label enumeration and can be
computationally exponential. The source learner therefore gives an implicit
trace cover, not an effective marginal-dependent proper selector.

**Pseudo-label projection obstruction.** If one had a tolerant same-marginal
projection oracle that converted pseudo-labels, residual labels, or an improper
predictor into a proper concept with nearly optimal weighted correlation, then
the edge would likely follow by validation. Strong realizable proper PAC
learning does not give such an oracle. Pseudo-labeled samples are usually
off-promise, and even exact unweighted projection can optimize the wrong
objective for agnostic labels.

**Agnostic boosting near miss.** Modern agnostic boosting theorems start from
an agnostic weak learner or from access to residual/correlation oracles. They
do not derive the needed same-$P$ proper agnostic weak learner from a clean
realizable proper learner alone. Improved-time boosting results still leave
parameter dependences that are not a general atlas-polynomial proper selector
when the relevant dimensions grow.

**Hardness near miss.** Tiegel-style halfspace hardness and related templates
do not currently refute this weak marginal-nonuniform proper target. The known
fixed-marginal barriers are high-accuracy $\operatorname{OPT}+\varepsilon$
results or leak neutral/proper handles at the weaker additive threshold.
```

Suggested final conclusion:

```markdown
**Conclusion.** The edge remains open. The strong source proves the low-noise
branch and reduces the problem to the same middle-noise same-$P$ proper selector
that blocks the weak-realizable proper core edge. Trace-cover and pseudo-label
projection routes identify useful sufficient primitives, but neither is
supplied by strong realizable proper PAC learning, and no current hardness
template gives a clean false witness for this exact marginal-nonuniform weak
proper target.
```

No atlas files should be edited as part of this depth-8 pass.

## Depth 9 Attempt: Final Strong-To-Weak Proper Search

### Verdict

RESOLVED: no

I did not find a theorem or witness that resolves the original atlas edge. The
strong source still gives only one genuine advantage over the weak-source core:
it makes the same-marginal low-noise coupling quantitatively clean. I found no
source-grounded way to turn arbitrary clean accuracy into the missing
middle-noise proper selector, and I found no known fixed-marginal hardness
template that defeats the atlas target's very weak OPT-relative guarantee.

The recommended atlas status remains:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
```

The depth-8 summary/field updates are still the best incorporation target. At
most, the atlas body could add the sharper depth-9 slogan: the unresolved part
is not "realizable versus agnostic" in the sample-theoretic sense, but
"effective same-marginal proper signed search" in the middle-noise regime.

### Final Reduction Check

Let labels be in $\{\pm 1\}$ and write

$$
\rho(h)=\mathbf E[h(X)Y],
\qquad
\rho^\star=\sup_{c\in\mathcal C}\mathbf E[c(X)Y],
\qquad
\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D)
     ={1-\rho^\star\over 2}.
$$

The target inequality

$$
\operatorname{err}_{\mathcal D}(h)
\le
\eta+\frac12-\gamma_P(s)
$$

is equivalent to

$$
\rho(h)\ge \rho^\star-1+2\gamma_P(s).
$$

Fix a distribution-free strong realizable proper learner $A$ and run it at a
constant clean accuracy, e.g. $1/64$. Let $m_A(s)$ be the number of labels
inspected at constant confidence, and set

$$
\alpha_A(s)\ll {1\over m_A(s)}
$$

inverse-polynomially. If $\eta<\alpha_A(s)$, the noisy transcript can be
coupled to a clean transcript from a near-optimal $c^\star\in\mathcal C$ under
the same original marginal $P$. Repetition plus holdout validation gives a
proper weak-agnostic candidate. This part is settled.

For $\eta\ge\alpha_A(s)$, the remaining content is equivalent, up to validation
slack, to the following fixed-marginal selector:

> For every marginal $P$, generate in $P$-dependent polynomial time a
> polynomial-size list $L\subseteq\mathcal C$ such that for every conditional
> label distribution over that same $P$, some $h\in L$ satisfies
> $\rho(h)\ge\rho^\star-1+2\gamma_P(s)$.

Since $\rho^\star\le 1-2\alpha_A(s)$ in this regime, the stronger but easier to
remember sufficient condition is a legal proper neutralizer with
$\rho(h)\ge-\alpha_A(s)$, after choosing $\gamma_P(s)\ll\alpha_A(s)$. The
selector formulation is the exact one; the neutralizer formulation is the
useful diagnostic.

The strong-source edge is therefore still a special case of the unresolved
weak-realizable proper core edge

```text
efficient-weak-realizable-proper-pac
  -> efficient-marginal-nonuniform-weak-agnostic-proper-pac
```

because strong realizable proper learning implies weak realizable proper
learning by running the source learner at any fixed constant accuracy. The
depth-9 search did not find a converse reduction or any new use of arbitrary
clean accuracy that avoids the selector.

### Why The Positive Theorems Still Miss

The statistical cover theorems are real but not algorithmic enough for this
edge. Benedek--Itai fixed-distribution learnability and the
Hanneke--Moran--Thiessen marginal-nonuniform trichotomy give the right
distribution-sensitive sample-complexity picture. Hopkins--Kane--Lovett--
Mahajan give a black-box realizable-to-agnostic reduction, and the arXiv/PMLR
abstract emphasizes the broad equivalence of realizable and agnostic
learnability. But the reduction obtains an agnostic cover by running the
realizable learner over labelings of an unlabeled sample; for a source learner
with $m_A(s)=\operatorname{poly}(s)$, that is generally
$2^{m_A(s)}$, not an atlas-polynomial-time proper selector.

The strong source does not repair this enumeration cost. If the reduction calls
$A$ only on genuinely clean labels, then in middle noise it must either guess a
source-scale clean trace or enumerate many traces. Guessing has probability
exponential in $-m_A(s)$, while enumeration is exponential in $m_A(s)$. If the
reduction instead calls $A$ on agnostic labels, residual labels, random labels,
or pseudo-labels from an improper predictor, it has left the source promise.
The definition of efficient realizable proper PAC learning imposes no tolerant
ERM, projection, signed-correlation, or balanced-sampling behavior on those
off-promise calls.

Agnostic boosting remains a near miss in the same way. The relevant boosting
theorems start with an agnostic weak learner or a residual/correlation oracle.
The 2026 da Cunha--Hogsgaard--Paudice paper is useful evidence about improved
running time once such an agnostic weak primitive is available, but its abstract
states polynomial time in the sample size with other parameters fixed; it does
not derive the missing same-$P$ proper weak learner from a clean realizable
proper learner. Thus boosting can amplify the selector, but it does not create
it.

### Why The Hardness Theorems Still Miss

The known hardness results also remain just short of the exact target.

- Tiegel's distribution-independent halfspace theorem has a strong
  no-advantage flavor, but the hard marginal moves with the instance and the
  low-OPT parameter in the theorem can be larger than every inverse polynomial.
  A marginal-nonuniform learner is allowed to choose its polynomial and weak
  gap after the marginal is fixed, so an error-$1/2$ legal handle is not
  automatically ruled out at the atlas threshold.

- Tiegel's fixed-Gaussian theorem has the right fixed marginal, but it is a
  high-accuracy $\operatorname{OPT}+\varepsilon$ lower bound. At constant
  $\varepsilon$ it does not exclude a polynomial-time constant-slack weak
  proper learner, and proper Gaussian halfspace algorithms at constant excess
  error point in the opposite direction for this weak target.

- Kearns--Schapire--Sellie conjunction hardness and the Feldman--Guruswami--
  Raghavendra--Wu weak monomial hardness encode the hard instance in the
  distribution or ask for an absolute $1/2-\varepsilon$ advantage. They do not
  yield a fixed-marginal, OPT-relative, all-inverse-polynomial-gap
  non-selector theorem. In the conjunction gadget, all-selected/all-positive
  handles already sit near the weak threshold.

- Parity/LPN, random-code, one-way, PRF, PCP, and active-slice templates each
  fail one of the same tests. Either clean proper learning would already have
  to recover the hard secret on some distribution-free clean marginal, or the
  construction leaks legal neutral handles: wrong parities, wrong codewords,
  constants, public defaults, wrong lengths, wrong slices, local moves, or
  bounded subset handles.

The geometric obstruction is worth keeping in the atlas memory. A false
witness cannot simply make every wrong proper concept noticeably
anti-correlated with every hard label rule: large binary families with uniform
fixed marginals run into Gram/Plotkin-style barriers. A successful separation
would need computational hidden-handle hardness: neutral or weakly good proper
hypotheses may exist, but finding any of them under the fixed marginal must be
hard.

### Final Atlas-Suitable Obstacles And Directions

1. **Positive primitive to look for.** Prove the edge under an extra
   fixed-marginal effective-cover assumption: for every $P$, a uniform
   algorithm enumerates a $P$-dependent polynomial-size proper cover/list of
   $\mathcal C_s$ at the resolution needed for the weak selector. This would
   convert the Benedek--Itai/Hopkins statistical cover intuition into an
   actual atlas-polynomial learner.

2. **Projection primitive to look for.** Prove the edge for classes with a
   tolerant same-$P$ proper projection or cost-sensitive optimizer. It is not
   enough to project to unweighted pseudo-labels; the selector needs weighted
   correlation against the regression $\mu(x)=\mathbf E[Y\mid X=x]$.

3. **Sampler primitive to look for.** Prove the edge for classes with an
   efficiently sampleable, legal, approximately balanced distribution over
   proper concepts under each fixed $P$. Such a sampler would supply the
   middle-noise neutralizer that constants supply in the improper proof.

4. **Negative primitive to look for.** A separation should instantiate a
   fixed-marginal no-neutral signed-search primitive: one size-indexed marginal
   ensemble, efficient distribution-free clean proper learning, and hard
   conditional label rules for which every polynomial-time proper output fails
   the OPT-relative threshold for every inverse-polynomial gap allowed by the
   target. The construction must avoid moving the hard instance into the
   marginal and must block public defaults, complements, constants, wrong-code
   handles, wrong-slice handles, and balanced samplers.

5. **Atlas wording.** The current edge summary is accurate. A compact final
   body sentence would be:

   > Depth-9 search found no stronger use of arbitrary clean accuracy beyond
   > the low-noise clean-transcript coupling. The unresolved middle-noise
   > branch is equivalent to an effective same-marginal proper selector; known
   > statistical cover, agnostic boosting, halfspace hardness, conjunction/PCP,
   > parity/code, and one-way templates remain near misses.

### Sources Rechecked

- Benedek and Itai, "Learnability with respect to fixed distributions",
  Theoretical Computer Science 1991:
  https://doi.org/10.1016/0304-3975(91)90026-X
- Hopkins, Kane, Lovett, and Mahajan, "Realizable Learning is All You Need",
  TheoretiCS 2024 / COLT 2022:
  https://doi.org/10.46298/theoretics.24.2
- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability",
  NeurIPS 2025:
  https://openreview.net/forum?id=aoVCFtox89
- Tiegel, "Hardness of Agnostically Learning Halfspaces from Worst-Case
  Lattice Problems", COLT 2023:
  https://proceedings.mlr.press/v195/tiegel23a.html
- da Cunha, Hogsgaard, and Paudice, "Sample-Near-Optimal Agnostic Boosting with
  Improved Running Time", ALT 2026:
  https://arxiv.org/abs/2601.11265
- Feldman, Guruswami, Raghavendra, and Wu, "Agnostic Learning of Monomials by
  Halfspaces Is Hard", SIAM Journal on Computing 2012:
  https://doi.org/10.1137/120865094

Final conclusion: keep the edge open. The most precise remaining question is
whether efficient distribution-free clean proper learning implies, for each
fixed marginal, an efficient proper signed selector in the middle-noise
agnostic regime. No checked source supplies that selector, and no checked
hardness template refutes it.
