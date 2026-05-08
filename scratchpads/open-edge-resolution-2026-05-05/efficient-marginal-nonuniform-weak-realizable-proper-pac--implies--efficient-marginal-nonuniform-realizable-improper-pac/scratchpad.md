# Edge: efficient-marginal-nonuniform-weak-realizable-proper-pac -> efficient-marginal-nonuniform-realizable-improper-pac

- date: 2026-05-05
- edge_file: `atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac.md`
- source: `efficient-marginal-nonuniform-weak-realizable-proper-pac`
- target: `efficient-marginal-nonuniform-realizable-improper-pac`
- verdict: unresolved-open
- confidence: 0.80
- worker constraint: scratchpad only; no atlas files edited

## Executive Verdict

I do not see an atlas-ready proof or an atlas-ready counterexample. The edge
should remain `open`.

Classical realizable boosting proves the analogous distribution-free
weak-to-strong implication, and the target is improper, so the final boosted
vote would be allowed. The obstruction is the marginal-nonuniform quantifier:
boosting calls the weak learner on residual or reweighted marginals $Q_t$,
while the source gives only pointwise weak gaps

$$
\forall Q\ \exists \gamma_Q(s)\ge 1/\operatorname{poly}_Q(s).
$$

The target would need one polynomial depending only on the original marginal
$P$ that controls all weak gaps on the booster-induced marginals before
accuracy $\varepsilon$.

The best false route is a rare-block PRF or random-oracle construction with
proper singleton handles. It plausibly makes strong improper learning under
one fixed mixture marginal hard. However, the proper weak source proof breaks
on a default-orientation problem: constants and singleton handles are not
enough unless the learner can choose the correct side of a near-balanced hard
block. Under the atlas worst-case finite-transcript convention, validating a
hidden $1/N$-scale bias on unbounded blocks is not available to a single
source learner.

## Files And Sources Checked

Local files:

- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/realizable-boosting.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- `atlas/witnesses/pseudorandom-function-classes.md`
- neighboring scratchpads for the weak-improper and weak-agnostic proper variants

Primary sources checked online:

- Schapire 1990, *The Strength of Weak Learnability*: https://www.schapire.net/papers/strengthofweak.pdf
- Freund 1995, *Boosting a Weak Learning Algorithm by Majority*: https://doi.org/10.1006/inco.1995.1136
- Feldman 2010, *Distribution-Specific Agnostic Boosting*: https://arxiv.org/abs/0909.2927
- Ghai and Singh 2025, *Sample-Optimal Agnostic Boosting with Unlabeled Data*: https://proceedings.mlr.press/v267/ghai25a.html
- da Cunha, Hogsgaard, and Paudice 2026, *Sample-Near-Optimal Agnostic Boosting with Improved Running Time*: https://arxiv.org/abs/2601.11265
- Hanneke, Moran, and Thiessen 2025, *Marginal-Nonuniform PAC Learnability*: https://openreview.net/forum?id=aoVCFtox89
- Kearns and Valiant 1994, *Cryptographic Limitations on Learning Boolean Formulae and Finite Automata*: https://doi.org/10.1145/174644.174647
- Goldreich, Goldwasser, and Micali 1986, *How to Construct Random Functions*: https://www.wisdom.weizmann.ac.il/~oded/ggm.html

## Current Edge State

The atlas edge currently records:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - schapire1990
  - benedek1991fixed
summary: "Open: boosting from a marginal-nonuniform weak learner does not automatically give one marginal-dependent polynomial bound for the strong target."
family: marginal-boosting-open
argument_note: "[[marginal-boosting-open|Marginal-Nonuniform Boosting Open]]"
```

That status still looks right. I would sharpen the diagnosis from "runtime"
to "weak-gap envelope": `full-support-marginal-uniformization` controls the
pathwise resource bound of one weak call, but it does not transfer accuracy or
weak advantage across marginals.

## Positive Proof Attempt

### Goal

Fix an original marginal $P$ and a target concept $c\in\mathcal C$. We need a
single learner $B$ and a polynomial $q_P$ such that for every
$\varepsilon,\delta$,

$$
\operatorname{err}_P(B,c)\le \varepsilon
$$

using at most

$$
q_P(s,1/\varepsilon,\log(1/\delta))
$$

samples and time. The polynomial may depend on $P$, but not on $c$ or on the
boosting transcript.

### Standard Boosting

Schapire/Freund boosting calls the weak learner on marginals $Q_t$ obtained by
filtering or reweighting $P$ according to the current ensemble. In the
distribution-free setting, the same inverse-polynomial weak gap applies to
every $Q_t$.

Here the source only gives, for each induced marginal $Q_t$, its own polynomial
gap. A direct proof would need the extra envelope:

$$
\forall P\ \exists r_P\ \forall Q_t\text{ reachable before }\varepsilon,
\qquad
\gamma_{Q_t}(s)\ge 1/r_P(s,1/\varepsilon).
$$

The source definition gives no such quantifier swap. The reachable marginals
depend on the target, previous proper hypotheses, validation randomness, and
the requested accuracy. Since the target polynomial cannot depend on the
target path, this is the central missing theorem.

### Smooth Boosting

Smooth boosting is the most promising version of the positive route because
it only asks for weak learning under bounded-density perturbations of $P$:

$$
Q\ll P,\qquad dQ/dP\le B(s,1/\varepsilon).
$$

This would prove the edge if the source implied

$$
\inf_{Q\ll P,\ dQ/dP\le B}\gamma_Q(s)
\ge
1/r_P(s,B)
$$

for one polynomial $r_P$. I do not see that implication. Bounded density can
still focus on a rare block of $P$ with mass about $1/B$, and the source is
compatible with the weak gap on that conditional block having a degree tied to
the block parameter.

### Same-Marginal Agnostic Boosting

Feldman-style distribution-specific agnostic boosting is attractive because it
keeps the instance marginal fixed and changes only labels. That would avoid
the changing-$Q_t$ problem.

It does not apply to this source. The source is realizable only, so relabeled
or noisy calls are outside its guarantee. Even for neighboring weak-agnostic
sources, the known theorems have quantitative requirements not supplied by the
atlas fixed-additive weak node: the weak oracle needs tunable slack or the
runtime has weak-parameter-dependent exponents. This is a useful near miss,
not a proof of this edge.

### Dovetailing

Running many guessed boosters and validating on fresh $P$-samples can find a
successful candidate once one appears. It does not give a polynomial bound on
when the first successful candidate appears. If the relevant residual
marginals have gaps like $s^{-j}$ for unbounded $j$ as
$\varepsilon$ decreases, dovetailing can be superpolynomial in
$(s,1/\varepsilon)$.

## Counterexample Search

### Direct PRF Cores

Plain PRF classes fail the target under the usual hard marginal, but they also
fail the source: under that marginal no polynomial-time learner can get an
inverse-polynomial weak prediction advantage without distinguishing the PRF
from random labels.

### Fixed-k DNF

Fixed-$k$-term DNF separates weak proper learning from strong proper learning.
It does not separate this edge, because the target is improper. With a
distribution-free weak proper learner and a uniform gap, ordinary boosting can
aggregate proper weak hypotheses into an improper vote.

### One-Way Image-Coordinate Weak Handles

The one-way image-coordinate weak-handle class is source-positive for weak
proper marginal realizable learning: constants and singleton concepts are
legal proper handles. Its lower bound is a strong proper lower bound, though.
The present target is improper, and an improper learner can memorize sparse
positive atoms or use lookup-style hypotheses, so this witness does not refute
the edge.

### Rare-Block PRF With Proper Singleton Handles

This is the best false route I found.

The intended construction has blocks

$$
B_{n,j}=\{(n,j,u,b):u\in U_{n,j},\ b\in\{0,1\}\},
\qquad |U_{n,j}|=N_{n,j}=n^j.
$$

A hard concept $c_{n,j,k}$ is zero off one active block and, on that block,
labels exactly one of the two atoms $(u,0),(u,1)$ positive according to a PRF
or random oracle bit $F_k(u)$. Add constants and singleton concepts to
$\mathcal C$ so the cheap handles are proper.

For a fixed mixture marginal

$$
P(B_{n,j})=Z^{-1}2^{-j}n^{-2}
$$

uniformly within each block, strong learning $c_{n,j,k}$ to
$\varepsilon=w_{n,j}/64$ forces small conditional error on $B_{n,j}$. If an
alleged target learner has polynomial degree $D$, choose a fixed $j>D$. The
learner then sees too few active coordinates to predict unseen random-oracle
labels, or would distinguish a PRF from a random function. This target-failure
calculation is plausible and survives improper output: memorizing sampled
singletons covers too little of the active block.

The problem is the source proof.

For block-uniform marginals, a sampled positive singleton gives advantage
$1/(2N_{n,j})$, which is inverse-polynomial with a degree depending on the
isolated block. But the source must hold for every marginal, not only the
uniform one, and the learner must output a proper binary hypothesis. It has to
choose the correct default orientation when the positive mass is close to
$1/2$.

The obstruction can be made explicit. Let a source learner have global
pathwise sample bound $m(s)$; full-support marginal uniformization justifies
viewing this as one fixed polynomial for finite transcripts. Pick a block with
$N\gg m(s)^2$. For a fixed hard target define two marginals on the same block:

$$
P_+(\text{target-positive atoms})=1/2+\eta,\qquad
P_-(\text{target-positive atoms})=1/2-\eta,
$$

with the mass spread nearly uniformly inside each side and

$$
\eta \asymp m(s)/N.
$$

Under $P_+$, the good default is essentially all-one, or a co-singleton-style
correction. Under $P_-$, the good default is all-zero, or a positive singleton
correction. A sparse handle based on $m$ samples can correct only
$O(m/N)$ mass, so the wrong default still has error at least $1/2$.

But the $m$-sample transcript distributions under $P_+$ and $P_-$ have total
variation $O(m\eta)=O(m^2/N)$, which is tiny. No learner can reliably choose
opposite orientations for both marginals. Validating the sign of the
$\eta$-scale bias would require superpolynomially many samples on the
unbounded block family, which violates the full-support pathwise resource
convention.

Thus the rare-block PRF/singleton construction is not an atlas-ready proper
source witness. It remains an important template, but the missing ingredient
is an orientation-free deterministic proper handle.

## Proposed Atlas Posture

Do not change the edge status yet.

Suggested sharper summary if the edge note is later edited:

```yaml
summary: "Open: realizable boosting would need one original-marginal polynomial controlling weak advantages on booster-induced marginals. Proper singleton-handle PRF templates give plausible target hardness, but currently fail the arbitrary-marginal proper weak source because near-balanced blocks require hidden-scale orientation."
```

Suggested body emphasis:

```markdown
The obstruction is a weak-gap envelope, not merely the running time of one weak
call. Under the atlas worst-case finite-transcript convention, a full-support
reference marginal can uniformize the pathwise sample and time bound of the
single source learner. It cannot say that the same learner has an
original-marginal-controlled weak advantage on the reweighted marginals needed
by boosting.

Rare-block PRF constructions with constants and singleton handles are the
closest known false route. They can make strong improper learning under one
fixed mixture marginal look hard, but the proper weak source must work for
arbitrary marginals concentrated on a near-balanced hard block. Choosing the
right constant/singleton orientation appears to require resolving a bias at
the hidden block scale, which is not compatible with one pathwise polynomial
source learner.
```

## Promising Directions

1. Prove or refute a bounded-density weak-gap envelope for a named smooth
   booster. This is the cleanest positive route.

2. Isolate the default-orientation obstruction as a lemma for rare-block
   proper-handle witnesses. It explains why sparse deterministic handles do
   not automatically certify weak proper learnability under arbitrary
   marginals.

3. Search for deterministic orientation-free proper handles. A false witness
   needs one weak proper handle to be easy under every marginal while making
   enough independent handles hard to obtain for low-error improper
   prediction.

4. Clarify whether any atlas variant permits randomized prediction rules. A
   randomized default outside sampled atoms would remove the orientation
   problem, but the current binary-classification notes appear to use
   deterministic hypotheses.

5. Consider a size-indexed marginal semantics note. If marginals were families
   $(P_s)$ evaluated separately by representation size, the diagonal
   weak-gap-uniformization proof would likely make this edge true by ordinary
   realizable boosting. The current global-mixture semantics blocks that
   proof because low-mass bad slices can be ignored by a weak learner.

## Final

verdict: unresolved-open

confidence: 0.80

## Depth 2 Branch: bounded-density weak-gap envelope

### Question

Fix the original marginal $P$. Smooth boosting would avoid arbitrary
booster-induced marginals if every weak call used a reweighting

$$
Q\ll P,\qquad \frac{dQ}{dP}\le B
$$

where $B=\operatorname{poly}(1/\varepsilon)$, or at least
$B=\operatorname{poly}_P(s,1/\varepsilon)$. The needed extra theorem would be
a local weak-gap envelope:

$$
\exists r_P\text{ polynomial}\quad
\forall B\ge 1\quad
\forall Q\ll P,\ dQ/dP\le B,\qquad
\gamma_Q(s)\ge \frac{1}{r_P(s,B)}.
$$

Here $\gamma_Q$ is the weak advantage supplied by the single
marginal-nonuniform proper weak learner when its sample marginal is $Q$.

### Negative Quantifier Test

I do not see such an envelope following from the source definition. The
reason is that bounded density only says how much of $P$ a reweighting can
focus on. It does not say that the marginal-dependent weak-gap polynomial on
that focused region has degree controlled by the inverse mass of the region.

A clean measure-theoretic obstruction is a disjoint rare-block mixture. Let

$$
P=\sum_{j\ge 1} w_j P_j,\qquad w_j=Z^{-1}2^{-j},
$$

where each $P_j$ lives on a block $S_j$. Let $Q_j=P_j=P(\cdot\mid S_j)$. Then

$$
\frac{dQ_j}{dP}=\frac{1}{w_j}\mathbf 1_{S_j},
\qquad
\|dQ_j/dP\|_\infty \asymp 2^j.
$$

The marginal-nonuniform source is compatible, at the level of quantifiers,
with the weak gap on $Q_j$ being

$$
\gamma_{Q_j}(s)=s^{-j^2}
$$

or even just $s^{-j}$ with a slower-decaying block mass. Each individual
$Q_j$ still has an inverse-polynomial weak gap in $s$, so this does not
contradict marginal-nonuniform weak learnability. But no polynomial
$r_P(s,B)=C s^a B^b$ can dominate all these conditionals. For
$B_j\asymp 2^j$,

$$
\frac{1}{\gamma_{Q_j}(s)}=s^{j^2}
\gg
C s^a 2^{bj}=r_P(s,B_j)
$$

once $j$ and then $s$ are chosen large enough. Thus a smooth booster whose
density cap grows only polynomially in $1/\varepsilon$ can still encounter
conditionals whose weak gap is super-polynomial in $(s,B)$.

Using polynomial block weights makes the same point with less notation. If
$w_j\asymp j^{-2}$ and $\gamma_{Q_j}(s)=s^{-j}$, then $B_j\asymp j^2$ and
$1/\gamma_{Q_j}(s)=s^j=s^{\Theta(\sqrt{B_j})}$, again not bounded by any fixed
polynomial in $(s,B_j)$.

### Rare-Block Interpretation

This obstruction matches the rare-block intuition from depth 1. On block
$S_j$, imagine the best cheap proper weak handle has advantage about
$1/N_j$, with $N_j=s^j$ or $s^{j^2}$. The global marginal $P$ gives $S_j$
mass $w_j$, so a bounded-density reweighting with cap $B\ge 1/w_j$ may
condition on that block. The source can still be true block-by-block, with a
$Q_j$-dependent weak-gap exponent. Smoothness has only paid the price
$1/w_j$; it has not paid for the hidden handle scale $N_j$.

This is not yet an atlas-ready counterexample for the edge. To become one,
the rare-block construction must still supply a single proper weak learner
for every global marginal. The depth-1 PRF/singleton version fails exactly at
that point: near-balanced hard blocks can force a hidden-scale orientation
test. The present argument is weaker but cleaner: it rules out the proposed
positive proof unless one adds a new local-uniformity hypothesis connecting
weak gaps to bounded density.

### Consequence For Smooth Boosting

Smooth boosting would prove the edge if the source implied the envelope above.
The rare-block calculation shows the current marginal-nonuniform definition
does not supply it. A smooth booster can guarantee
$dQ_t/dP\le \operatorname{poly}(1/\varepsilon)$ and still have no
$P$-polynomial bound on the number of weak calls, because the relevant
$\gamma_{Q_t}$ may have degree growing faster than any polynomial in the
density cap.

### Verdict

No: marginal-nonuniform weak proper learning does not, from the current
quantifiers alone, imply a $P$-dependent polynomial lower envelope over weak
gaps for all bounded-density reweightings $Q\ll P$.

This is a measure-theoretic/quantifier obstruction to the smooth-boosting
route, not a completed false witness for the atlas edge.

confidence: 0.78

next branch ideas:

1. Try to upgrade the rare-block obstruction into a genuine class by finding
   orientation-free proper handles whose weak edge on block $j$ is
   $s^{-j}$, while a boosted improper learner still needs many independent
   handles.
2. Formalize a reusable lemma: bounded density plus pointwise
   marginal-nonuniform weak gaps does not imply a polynomial envelope unless
   one assumes local uniformity of the weak learner over the $L_\infty(P)$
   density ball.
3. Audit named smooth boosters for any stronger property than bounded
   density, such as KL control, finite support over transcript cells, or
   monotone filtering, that might rule out the rare-block conditioning
   obstruction.

## Depth 3 Branch: compactness envelope for booster marginals

### Question

Can one fix the original marginal $P$ and use a finite-cover,
VC-eluder, or marginal-nonuniform-trichotomy style compactness argument to
force the missing envelope

$$
\forall \varepsilon\in(0,1)\quad
\forall Q\in\mathcal R_P(\varepsilon),\qquad
\gamma_Q(s)\ge \frac{1}{r_P(s,1/\varepsilon)}
$$

for all booster-reachable marginals $\mathcal R_P(\varepsilon)$ before
accuracy $\varepsilon$?

Here $\gamma_Q$ is the weak advantage obtained by the single proper weak
source learner when its sample marginal is $Q$. The polynomial $r_P$ may
depend on $P$, but its exponents must be fixed once and for all; they cannot
grow as $\varepsilon$ decreases.

### What Compactness Would Need To Prove

For each fixed marginal $Q$, the source gives some inverse-polynomial weak
gap and some polynomial resource bound. Write this schematically as

$$
\gamma_Q(s)\ge s^{-a(Q)},\qquad m_Q(s)\le s^{b(Q)}
$$

after hiding constants. The exact exponents are not part of the source data;
the source only says they are finite for each fixed $Q$.

A compactness proof would need more than a finite set for each fixed
$\varepsilon$. It would need a polynomial modulus:

$$
\exists A,B,C<\infty\quad
\forall \varepsilon,\ \forall Q\in\mathcal R_P(\varepsilon),\qquad
\gamma_Q(s)^{-1}\le C s^A (1/\varepsilon)^B.
$$

Equivalently, the representation-size exponent of the weak gap must be
uniformly bounded over every booster marginal that can become relevant at any
accuracy scale. A finite cover at a single scale only gives

$$
\max_{Q_i\in F_\varepsilon} a(Q_i)<\infty,
$$

which is qualitatively weaker. If this maximum grows with
$\varepsilon^{-1}$, the result is generally not a polynomial in the two PAC
variables $(s,1/\varepsilon)$.

### Why A Fixed-$P$ Cover Does Not Control Conditionals

A $P$-metric cover of concepts is blind to small $P$-mass regions until the
cover resolution reaches their mass. If $S$ has $P(S)=\alpha$ and
$Q=P(\cdot\mid S)$, then two concepts that differ only on $S$ are
$\alpha$-close under $P$ but can be distance $1$ under $Q$.

Thus a booster that focuses on residual set $S$ asks for weak learning at the
conditional scale, not merely at the original $P$-scale. To transfer a
$P$-cover to $Q$, the cover resolution must be smaller than roughly
$\alpha\gamma_Q$. This is circular: the required cover resolution depends on
the very weak gap one is trying to lower-bound.

Smooth or bounded-density boosters soften the issue but do not remove it.
If $dQ/dP\le B$, then a $P$-cover at scale $\rho/B$ controls $Q$-error at
scale $\rho$. But the depth-2 rare-block calculation shows that the weak-gap
exponent on such a conditional can still grow independently of $B$.

### Exact Finite-Cover Obstruction

Consider the abstract rare-block pattern

$$
P=\sum_{j\ge 1} w_j P_j,\qquad w_j\asymp 2^{-j},
$$

where the blocks are disjoint and $Q_j=P_j=P(\cdot\mid S_j)$. Suppose a
booster-reachable family before accuracy $\varepsilon$ contains the
conditionals $Q_j$ whenever $w_j\gtrsim \varepsilon$. This is the natural
regime: a block of mass larger than the target error cannot simply be ignored.

Now suppose the source learner has, on $Q_j$, a valid but increasingly weak
inverse-polynomial gap

$$
\gamma_{Q_j}(s)=s^{-a_j},
$$

with $a_j=j$ or $a_j=j^2$. This is completely compatible with the
marginal-nonuniform weak source at the quantifier level, since for each fixed
$Q_j$ the exponent $a_j$ is finite and the polynomial may depend on $Q_j$.

For a fixed $\varepsilon$, only

$$
j\le J(\varepsilon)\asymp \log(1/\varepsilon)
$$

blocks have $w_j\gtrsim\varepsilon$. A finite-cover argument can therefore
take the finite cover

$$
F_\varepsilon=\{Q_1,\dots,Q_{J(\varepsilon)}\}
$$

and obtain a positive minimum gap

$$
\min_{Q_i\in F_\varepsilon}\gamma_{Q_i}(s)
=s^{-\max_{i\le J(\varepsilon)}a_i}.
$$

But this is not a PAC polynomial envelope. If a candidate envelope were

$$
r_P(s,1/\varepsilon)\le C(s+1/\varepsilon)^D,
$$

choose $j>D+1$, take $\varepsilon\le c w_j$ so that $Q_j$ is still relevant,
and then choose $s$ large. The required inequality

$$
s^{a_j}\le C(s+1/\varepsilon)^D
$$

fails. The factor $(1/\varepsilon)^D$ cannot absorb an unbounded exponent of
$s$, because the target polynomial must hold uniformly over both $s$ and
$\varepsilon$.

This is the exact finite-cover obstruction: compactness can make the active
cover finite at each fixed accuracy scale, but it does not bound the
representation-size degrees of the weak guarantees along the tower of covers
as $\varepsilon\downarrow 0$.

### VC-Eluder And Trichotomy Interpretation

The marginal-nonuniform trichotomy is still useful background. It explains
why sample-only polynomial marginal-nonuniform rates can collapse to ordinary
finite-dimensional sample learnability. That is an information-theoretic
statement about existence of learners or covers.

This edge is computational and uses a fixed proper weak learner as its source
algorithm. A finite VC-eluder or finite-cover statement does not by itself
provide:

1. an efficient selector or ERM over the cover;
2. a weak proper hypothesis found by the given source learner with a
   uniform gap on every reweighted marginal;
3. a polynomial modulus controlling how the cover depth and the weak-gap
   exponent grow as smaller $P$-mass residual regions become relevant.

So the trichotomy can explain why the sample-efficient analogue is benign,
but it does not force the computational boosting envelope needed here.

### Conclusion

The compactness route does not settle the edge. It would become viable only
with an additional local-uniformity hypothesis, for example:

$$
\exists A,B,C\quad
\forall \varepsilon,\ \forall Q\in\mathcal R_P(\varepsilon),\qquad
\gamma_Q(s)^{-1}\le C s^A (1/\varepsilon)^B,
$$

or an equivalent finite-cover condition whose cover representatives have
uniformly bounded representation-size exponents and only polynomially growing
constants. The current marginal-nonuniform weak source supplies pointwise
polynomials, not that modulus.

verdict: unresolved-open; fixed-$P$ compactness gives finite active covers but
does not force a $P$-dependent polynomial weak-gap envelope over
booster-reachable marginals.

confidence: 0.82

next branch ideas:

1. Formalize the rare-block finite-cover obstruction as a lemma about
   pointwise polynomial weak gaps on conditionals $Q_j=P(\cdot\mid S_j)$.
2. Look for a concrete orientation-free proper-handle class realizing
   $\gamma_{Q_j}(s)=s^{-j}$ while preserving target hardness for strong
   improper learning.
3. Test whether any named booster has a stronger reachability structure than
   "condition on every non-negligible residual block," such as a monotone
   finite menu of residuals whose weak-gap exponents can be uniformly bounded.
4. Separate a possible positive theorem under an explicit local-uniformity
   axiom from the current atlas edge, so the edge note can keep the open
   status without conflating it with the stronger theorem.

## Depth 4 Branch: same-marginal realizable boosting

### Question

Can one avoid the changing-marginal obstruction by forcing every weak call to
have the original instance marginal $P$? The hoped-for transformation would
move the boosting state into labels, subsampling, or residual targets, while
never asking the source weak learner to operate under a reweighted marginal
$Q_t$.

This branch tests three variants:

1. deterministic relabeling under the same marginal $P$;
2. rejection or subsampling schemes that claim to preserve $P$;
3. agnostic-style residual labels while using only the realizable weak source.

### Source-Guarantee Constraint

The source learner is only guaranteed on sample streams of the form

$$
X\sim P,\qquad Y=c(X),\qquad c\in\mathcal C.
$$

If a same-marginal booster makes an auxiliary weak call with labels
$Y_t=g_t(X)$, then this call is inside the source guarantee only when
$g_t\in\mathcal C$. In that case the weak learner returns a proper
$h_t\in\mathcal C$ satisfying, schematically,

$$
\operatorname{err}_P(h_t,g_t)\le \frac12-\gamma_P(s_t).
$$

Thus the booster needs a class-internal residualization operation:

$$
(c,h_1,\dots,h_{t-1})\mapsto g_t\in\mathcal C
$$

together with a decoder saying that weak prediction of these $g_t$'s under
$P$ improves prediction of the original $c$ under $P$. No such closure or
decoder is part of the atlas node. Without it, the only universally valid
choice is essentially $g_t=c$ again, or possibly a complement if the class is
known to be closed under complements. Repeating same-marginal weak calls on
the same target does not force diversity: a valid weak learner may keep
returning the same weak proper hypothesis with error $1/2-\gamma_P(s)$.

This is the core obstruction. Standard boosting changes the marginal exactly
to force the next weak hypothesis to be good on the current residual region.
If the marginal is fixed and the labels remain realizable by the original
target $c$, the weak learner has no reason, and no guarantee, to address the
errors of the current ensemble.

### Deterministic Relabeling

A natural attempt is to define residual labels from the current margin. With
$\{\pm1\}$ labels and ensemble score $F_t$, examples with small or wrong
margin receive a new label such as

$$
g_t(x)=c(x)\operatorname{sign}(-F_t(x))
$$

or a mistake indicator. If $g_t$ were learnable under $P$, one might combine
the result with the current ensemble and reduce the residual error.

The problem is realizability. For a general class $\mathcal C$, the residual
function above need not belong to $\mathcal C$. It is built from the unknown
target and from an improper aggregate of previous hypotheses. The realizable
weak source does not promise anything on such labels, even if they are
deterministic and even if the original labels are perfectly realizable.

There is also a magnitude problem. A reweighted boosting call asks for
correlation

$$
\mathbb E_P[w_t(X)c(X)h(X)]>0
$$

for a nonnegative residual weight $w_t$. A deterministic same-marginal label
$g_t(X)\in\{\pm1\}$ can encode a sign pattern but not the magnitude
$w_t(X)$. Randomized labels can encode magnitudes through
$\mathbb E[Y_t\mid X=x]$, but then the labels are noisy and generally not
realizable by a concept in $\mathcal C$. Deterministic relabeling therefore
does not simulate weighted boosting except under extra algebraic structure
that the edge does not assume.

### Rejection While Preserving $P$

Suppose a booster tries to focus on hard examples by accepting an example
$x$ with probability $a_t(x)$ and rejecting it otherwise. The marginal of
accepted examples is

$$
P_{a_t}(A)=
\frac{\int_A a_t(x)\,dP(x)}
     {\int a_t(x)\,dP(x)}.
$$

This equals $P(A)$ for every measurable $A$ only when $a_t(x)$ is constant
$P$-almost surely. So nontrivial rejection changes the instance marginal.
If rejection is independent of $x$, the marginal remains $P$ but the booster
has not focused on residual errors.

One can try to keep all rejected examples as filler so that the total stream
still has marginal $P$. But then the weak learner sees the original
unweighted marginal, not the focused residual marginal. If the filler labels
are modified to cancel their influence, the resulting conditional label rule
is noisy or artificial and again leaves the realizable source guarantee.

Duplicating accepted examples has the same issue: the empirical marginal seen
by the weak learner is a reweighted marginal. Marking examples with an
acceptance bit changes the instance space or the concept class, which is not
available in this implication.

### Agnostic-Style Residual Labels

Distribution-specific agnostic boosting is the closest positive analogy,
because it can keep the instance marginal fixed and put the boosting state
into labels or losses. That analogy does not fit the present source.

The agnostic route needs a weak oracle that remains meaningful when the label
rule is not realizable by $\mathcal C$: for example, an oracle with advantage
over $\operatorname{OPT}_{\mathcal C}$, a correlation oracle, or a tunable
slack parameter. The current source only gives

$$
\operatorname{OPT}_{\mathcal C}(P,Y)=0
\quad\Longrightarrow\quad
\text{find }h\in\mathcal C\text{ with error }\le 1/2-\gamma_P(s).
$$

Residual labels usually have $\operatorname{OPT}_{\mathcal C}>0$, and may
have no inverse-polynomial correlation with any proper concept. The weak
learner can behave arbitrarily on those calls without violating the source
definition. Consequently, agnostic-style same-marginal boosting would prove a
different edge with a stronger weak source, not this one.

### Black-Box No-Go Intuition

The obstruction can be phrased as a black-box limitation. Consider a proposed
booster that invokes the weak learner only on streams with marginal $P$ and
labels realizable by $\mathcal C$.

If, for a target $c$, all valid calls use the original labels $c(X)$, then an
adversarial but source-valid weak learner may return the same proper weak
hypothesis on every call. The booster receives no mechanism forcing weak
hypotheses specialized to the current mistakes.

If the booster uses auxiliary labels $g_t(X)$, then each $g_t$ must itself be
a concept in $\mathcal C$ for the source guarantee to apply. A generic class
need not contain residuals, mistake indicators, complements, XORs with the
current vote, or thresholded margin functions. Even when some auxiliary
$g_t\in\mathcal C$ exists, the atlas source does not provide a general
decoder from weak approximations to these auxiliary concepts into a strong
approximation of $c$.

This does not prove the atlas edge false, because a non-black-box existence
proof might use structure of every marginal-nonuniform weakly proper class in
some unexpected way. It does block the intended same-marginal realizable
boosting route: preserving $P$ forces the residual information into the
labels, and putting it into the labels leaves the realizable source guarantee
unless the class has extra closure or the weak learner has agnostic power.

### Conclusion

Same-marginal realizable boosting does not appear to solve the edge. The only
source-valid same-marginal calls are calls with labels from concepts in
$\mathcal C$. General residual labels are not in $\mathcal C$; randomized or
soft labels are not realizable; and rejection that truly focuses on residuals
changes the marginal. Thus the route either collapses back to repeated weak
learning of the original target under $P$, which need not amplify, or assumes
additional closure/agnostic-oracle structure not present in the source node.

verdict: unresolved-open; the same-marginal realizable boosting branch is
blocked as a general proof strategy, but this is not a counterexample to the
edge.

confidence: 0.86

next branch ideas:

1. Formalize a black-box no-go lemma for boosters whose only valid oracle
   calls are same-marginal realizable calls to $\mathcal C$.
2. Isolate a positive theorem under explicit closure assumptions, such as
   residual/XOR closure plus efficient decoding, to separate "same-marginal
   boosting with structure" from the atlas edge.
3. Compare the exact oracle strength needed by Feldman/Ghai-style
   same-marginal agnostic boosting with the atlas weak-agnostic nodes.
4. Return to false-witness construction: search for computationally
   nonboostable weak handles where one same-marginal proper handle is easy
   under every marginal, but finding enough independent handles for strong
   improper learning remains hard.

## Depth 5 Branch: relativized separation or final synthesis

### Question

Can an oracle or relativized construction separate the edge under the current
finite-transcript convention, or do the previous failures indicate that the
right atlas action is to retain `open` and sharpen the notes at depth 6?

The target edge is still:

$$
\text{efficient marginal-nonuniform weak realizable proper PAC}
\Longrightarrow
\text{efficient marginal-nonuniform realizable improper PAC}.
$$

The current convention matters. The source learner is one algorithm. Its
sample use and running time are pathwise bounds on finite encoded sample
transcripts. Therefore a full-support reference marginal can uniformize the
resource bound of one call to the source learner. Any separation must exploit
weak advantage or prediction hardness, not slice-dependent running time.

### Relativized Target-Hardness Template

The natural oracle template is still a rare-block random-function class.
Choose blocks

$$
B_{n,j}=\{(n,j,u,b):u\in [N_{n,j}],\ b\in\{0,1\}\},
\qquad N_{n,j}=n^j,
$$

and let an oracle bit $O(n,j,u)$ decide which of the pair
$(u,0),(u,1)$ is positive. A hard target concept is zero off one active block
and follows these oracle bits on the active block. Put a fixed mixture
marginal $P^\star$ on blocks, for example with mass $w_{n,j}$ on $B_{n,j}$ and
uniform mass inside the block.

For the strong target, this gives the usual diagonal lower-bound shape. Fix a
candidate marginal-nonuniform strong learner whose polynomial for
$P^\star$ has degree $D$. Choose $j\gg D$ and ask for
$\varepsilon\ll w_{n,j}$. The learner sees only a negligible fraction of
$[N_{n,j}]$, so on a random oracle block it cannot predict unseen pair labels
substantially better than chance. Improper output does not help: an arbitrary
lookup table can memorize sampled pairs, but it cannot infer the unqueried
oracle bits.

This part is plausible as a relativized strong-learning lower bound. It is
also the same part that made the rare-block PRF construction attractive in
depth 1.

### Why This Is Not Yet A Separation

The source side has to hold for every marginal, not only for the fixed mixture
$P^\star$ and not only for uniform block marginals. In particular, it must
hold for a marginal concentrated on a single hard block with an adversarial
small imbalance between positive and negative mass.

Adding constants and finite singleton handles gives a weak proper learner on
nice block-uniform marginals. A sampled positive singleton, or a sampled pair
handle, can create advantage about $1/N_{n,j}$, which is inverse-polynomial
with a marginal-dependent degree. But arbitrary marginals recreate the
orientation problem.

Let the source learner read at most $m(s)$ examples and make at most $m(s)$
oracle queries on size-$s$ inputs. Under the finite-transcript convention,
$m$ has one fixed polynomial exponent. Pick a block with
$N\gg m(s)^2$. Construct two marginals on the same labeled oracle block:

$$
P_+(\text{positive atoms})=1/2+\eta,\qquad
P_-(\text{positive atoms})=1/2-\eta,
$$

with $\eta\asymp m(s)/N$ and with mass spread almost uniformly inside each
side. The correct default orientation is opposite for $P_+$ and $P_-$. A
finite-exception proper handle built from the transcript can correct only
$O(m/N)$ mass. By choosing constants in $\eta$, the wrong default still has
error at least $1/2$.

At the same time, the finite transcript distributions under $P_+$ and $P_-$
have total variation $O(m\eta)=O(m^2/N)$. Oracle access to labels at queried
points does not reveal the marginal's hidden orientation: the learner can see
oracle labels for finitely many atoms, but it cannot learn how much
unobserved marginal mass lies on the positive side versus the negative side.
Thus a single pathwise-polynomial source learner cannot, with high
probability, output opposite defaults for both marginals.

This kills the clean relativized separation attempt. The random oracle makes
strong prediction on a large block hard, but the same construction does not
certify the weak proper source under all marginals.

### Why A Stronger Oracle Would Be Cheating

One could force the source to work by giving the learner an oracle that, on
input a target and a marginal, returns the correct weak orientation or a
correlated handle. That would not be a standard relativized PAC example.
The marginal $P$ is not part of the learner's finite input; it is represented
only through samples. An oracle with semantic access to the current marginal
would be distribution-specific advice, not an ordinary computational oracle.

Similarly, an oracle that is tailored to the designated weak learner but not
to arbitrary strong learners would not witness an atlas implication failure.
Both source and target algorithms relativize to the same oracle. If the oracle
exposes enough information to choose hidden orientations or many independent
handles, a strong improper learner may be able to exploit that information as
well. If it exposes only finitely many sampled handles, the arbitrary-marginal
source proof runs into the indistinguishability argument above.

So the oracle route has a narrow acceptable target:

1. one shared oracle;
2. one uniform proper weak learner with fixed pathwise polynomial resources;
3. weak success for every marginal, including isolated near-balanced blocks;
4. no strong improper learner under one fixed marginal-dependent polynomial.

The known rare-block/random-oracle template satisfies item 4 and maybe item 2,
but fails item 3. The obvious repairs to item 3 either become nonstandard
distribution advice or hand too much structure to the strong learner.

### Positive Route Recheck

The failures also do not amount to a proof of the edge. The positive routes
still need an envelope that is not present in the source definition.

Changing-marginal boosting would need, for each original marginal $P$, one
polynomial controlling the weak gaps on the booster-induced marginals $Q_t$:

$$
\gamma_{Q_t}(s)\ge 1/r_P(s,1/\varepsilon,\log(1/\delta)).
$$

Bounded-density or smooth boosting only narrows the family of $Q_t$'s. It
does not force a lower envelope, because a bounded-density reweighting can
condition on a rare block of $P$ whose isolated weak gap has a much worse
degree.

Compactness gives finite covers for a fixed finite run, but the cover can
change with $\varepsilon$, the target, and the residual path. A finite cover
does not by itself turn pointwise marginal-dependent exponents into one
polynomial in $(s,1/\varepsilon,\log(1/\delta))$.

Same-marginal realizable boosting avoids changing $P$ only by moving residual
information into labels. Those labels are generally not concepts in
$\mathcal C$, and the source is realizable rather than agnostic. Repeating
same-marginal calls on the original target can return the same weak hypothesis
forever.

The full-support finite-transcript convention helps only with resources. It
rules out runtime diagonalizations and hidden slow transcripts. It does not
turn

$$
\forall Q\ \exists \gamma_Q(s)\ge s^{-k(Q)}
$$

into a useful lower bound over the moving family of residual marginals.

### Synthesis

The depth-5 conclusion is therefore negative in both directions:

- I do not see an atlas-ready proof. Every proof route asks for a
  local-uniformity or weak-gap-envelope theorem that the source node does not
  state.
- I do not see an atlas-ready counterexample. The best relativized/random
  oracle construction makes strong improper learning hard under a fixed rare
  block mixture, but it does not satisfy the arbitrary-marginal weak proper
  source because of the hidden-orientation obstruction.

The most accurate atlas posture is to keep the edge `open`, but sharpen the
note so it says exactly what is known after the finite-transcript cleanup:
the obstacle is no longer the runtime of a weak call. The obstacle is the
absence of an original-marginal polynomial envelope for weak advantages on
residual marginals, while the strongest false witnesses fail to prove the
proper weak source under arbitrary marginals.

Depth 6 should probably be an atlas-note pass rather than another construction
search, unless a genuinely orientation-free weak handle appears.

verdict: unresolved-open

confidence: 0.88

next branch ideas:

1. Edit the atlas edge note, if permitted, to distinguish resource
   uniformization from weak-gap nonuniformity and to mention the rare-block
   orientation obstruction.
2. Formalize the hidden-orientation lemma for finite-exception proper handles
   under two near-balanced block marginals $P_+$ and $P_-$.
3. State a conditional positive theorem: if booster-induced marginals satisfy
   a $P$-dependent weak-gap envelope, then standard realizable boosting proves
   the edge.
4. Only continue counterexample search if an orientation-free deterministic
   proper handle is found; sparse singleton, pair, and finite-sample handles
   appear blocked under arbitrary marginals.

## Depth 6 Final Synthesis

Final hard pass: I still do not see a proof or a counterexample that is
strong enough for the atlas. The correct edge status is `open`.

The exact obstruction is a weak-gap envelope, not properness of the final
vote and not the pathwise running time of one weak call. Since the source
learner is one algorithm and atlas efficiency is worst-case over finite sample
transcripts, the full-support marginal-uniformization argument can make the
sample/time bound of that one weak learner uniform. What remains nonuniform is
the advantage:

$$
\forall Q\quad \gamma_Q(s)^{-1}\le s^{k(Q)}
$$

for some marginal-dependent exponent $k(Q)$. A strong learner under the
original marginal $P$ would need one polynomial $r_P$ such that every weak
call made before accuracy $\varepsilon$ satisfies

$$
\gamma_{Q_t}(s)^{-1}
\le r_P(s,1/\varepsilon,\log(1/\delta)),
$$

where the $Q_t$ are the reweighted, filtered, or residual marginals generated
by the booster. The source definition gives each $Q_t$ its own polynomial. It
does not bound the degrees of those polynomials as the booster focuses on
smaller residual regions of $P$.

The positive routes all fail at this same quantifier swap.

Standard Schapire/Freund boosting gives the distribution-free weak-to-strong
theorem, and the improper target would allow the final majority vote. But the
number of calls depends quantitatively on the weak advantage. Freund's
distribution-dependent extension is also only a near miss: it asks for a
controlled relation between weak accuracy and the discrepancy of the induced
distribution from the original one. The atlas source supplies no function of
maximal-ratio divergence, KL divergence, or density bound that lower-bounds
$\gamma_Q$.

Smooth or bounded-density boosting narrows the family of $Q_t$ but does not
remove the gap problem. A rare-block mixture

$$
P=\sum_j w_jP_j,\qquad Q_j=P_j=P(\cdot\mid S_j)
$$

has $dQ_j/dP\le 1/w_j$. The source is still compatible with
$\gamma_{Q_j}(s)=s^{-j}$ or $s^{-j^2}$. No polynomial in
$(s,1/w_j)$ dominates these gaps for all $j$. Thus bounded density would prove
the edge only after adding a local-uniformity axiom not present in the node.

Compactness and marginal-nonuniform sample-complexity structure do not supply
that axiom. Hanneke-Moran-Thiessen explain the information-theoretic
distribution-sensitive rate landscape, and finite covers can control a fixed
accuracy scale. But a finite cover at each $\varepsilon$ can have a maximum
representation-size exponent growing with the active rare block. That growth
is not a polynomial in the two PAC variables $(s,1/\varepsilon)$.

Same-marginal boosting also does not repair the proof. If every weak call
keeps marginal $P$, the residual information has to move into the labels or
losses. The source is realizable only, so those auxiliary labels must still be
concepts in $\mathcal C$. General residual labels, mistake indicators, soft
labels, and randomized labels are outside the guarantee. Distribution-specific
agnostic boosting and newer generalized boosting theorems are useful analogies,
but they require correlation, threshold, cost-sensitive, or tunable-slack
oracles stronger than the present weak realizable proper source.

Dovetailing over guessed weak gaps and validating candidate ensembles also
does not yield a polynomial target learner. It eventually finds a successful
run if a suitable finite transcript exists, but the first successful guess can
occur at a degree depending on residual marginals rather than on the original
$P$.

The counterexample routes are equally blocked.

Plain PRF or random-oracle concept classes give the right strong-improper
hardness under a hard marginal, but then the source fails on that same
marginal: no efficient weak learner can get inverse-polynomial prediction
advantage without distinguishing pseudorandom labels from random labels.

Fixed-$k$ DNF and the one-way image-coordinate weak-handle class separate
proper strong learning from weaker sources, but they do not refute this edge.
The target here is improper, so classical boosted votes, lookup tables, or
memorized sparse atoms are allowed. The known one-way weak-handle lower bound
is a strong proper lower bound.

The closest false template remains the rare-block PRF/random-oracle
construction with constants and singleton-style proper handles. Under one
fixed mixture marginal $P^\star$, it plausibly defeats every strong improper
learner: choose a block whose hidden size parameter exceeds the learner's
$P^\star$-polynomial degree, ask for accuracy below that block's mass, and the
learner sees too few coordinates to predict unseen PRF or random-oracle bits.
Improper output does not help against unseen independent labels.

But this template does not prove the source. The source must weakly learn
under every marginal, including a marginal isolated on one hard block with
positive mass

$$
P_+(\text{positive})=1/2+\eta
$$

or

$$
P_-(\text{positive})=1/2-\eta.
$$

A finite-exception handle can correct only the mass of sampled atoms, so it
must also choose the correct default orientation: all-zero/singleton-like on
one side, all-one/co-singleton-like on the other. If the source learner uses
at most $m(s)$ samples and oracle queries, choose the block size
$N\gg m(s)^2$ and $\eta\asymp m(s)/N$. The transcript distributions under
$P_+$ and $P_-$ have total variation $O(m(s)^2/N)$, so the learner cannot
reliably choose opposite orientations. With the wrong orientation, sparse
corrections leave error at least $1/2$. Randomized prediction outside sampled
atoms would avoid this obstruction, but the atlas binary PAC hypotheses are
deterministic. An oracle that directly reveals the correct orientation would
be distribution-specific advice, not a standard relativized separation.

So the best synthesis for the atlas edge note is:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
summary: "Open: realizable boosting would require one original-marginal polynomial controlling weak advantages on booster-induced residual marginals. Rare-block PRF/singleton-handle templates suggest possible target hardness, but currently fail to certify the arbitrary-marginal proper weak source because near-balanced blocks require a hidden default-orientation test."
family: marginal-boosting-open
argument_note: "[[marginal-boosting-open|Marginal-Nonuniform Boosting Open]]"
```

References and argument notes to cite if the atlas note is sharpened:

- `[[marginal-boosting-open|Marginal-Nonuniform Boosting Open]]` for the main
  envelope obstruction.
- `[[realizable-boosting|Realizable Boosting]]` with `schapire1990` and
  `freund1995boosting` for the classical theorem and its distribution-dependent
  near miss.
- `[[full-support-marginal-uniformization|Full-Support Marginal Uniformization]]`
  and `[[marginal-uniformization-open|Marginal Uniformization Open]]` for the
  distinction between resource uniformization and weak-gap uniformization.
- `benedek1991fixed`, `bendavid1995parameterization`, and
  `hanneke2025marginalnonuniform` for the marginal-nonuniform quantifier
  pattern.
- `feldman2010distributionspecific`, `ghai2025agnosticboosting`, and
  `dacunha2026agnosticboosting` only as same-marginal/agnostic near misses, not
  as proofs of this realizable edge.
- `[[pseudorandom-function-classes|Pseudorandom Function Classes]]`,
  `goldreich1986`, and `kearns1994cryptographic` for the failed PRF
  counterexample template.
- `[[one-way-image-coordinate-weak-handle-hardness|One-Way Image Coordinate Weak-Handle Hardness]]`
  as a nearby proper-target separation that should not be cited as a witness
  for this improper target.

No atlas-ready resolution was found at the last allowed depth.

verdict: unresolved-open

confidence: 0.90
