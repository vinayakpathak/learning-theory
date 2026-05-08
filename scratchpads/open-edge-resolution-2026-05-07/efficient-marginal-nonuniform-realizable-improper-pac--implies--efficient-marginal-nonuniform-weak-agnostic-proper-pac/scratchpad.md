# Edge: efficient-marginal-nonuniform-realizable-improper-pac -> efficient-marginal-nonuniform-weak-agnostic-proper-pac

- worker depth: 1 of 7
- date: 2026-05-07
- edge file: `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- verdict: unresolved
- confidence: high that the current atlas `open` status should not be changed yet; medium-low about the edge's ultimate mathematical truth

## Question

Does
[[efficient-marginal-nonuniform-realizable-improper-pac|Efficient Marginal-Nonuniform Realizable Improper PAC Learning]]
imply
[[efficient-marginal-nonuniform-weak-agnostic-proper-pac|Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning]]?

The source gives one uniform learner $A$ such that, for every fixed marginal
$P$, there is a $P$-dependent polynomial sample/time bound for arbitrary
accuracy on labels realizable by some $c\in\mathcal C$. The learner may output
hypotheses outside $\mathcal C$.

The target asks for one uniform learner which, for every joint distribution
$\mathcal D$ with marginal $P$, outputs $h\in\mathcal C$ and satisfies

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\frac12-\gamma_P(s),
$$

where $\gamma_P(s)$ is inverse-polynomial under a $P$-dependent polynomial.
Thus marginal-nonuniformity relaxes rates, not the learner itself: the
algorithm is not given $P$-specific advice, and the bound must remain uniform
over target concepts and conditionals for the fixed marginal.

## Sources Checked

Local atlas files:

- `atlas/README.md`
- `atlas/definitions/efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/marginal-agnostic-hardness-open.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/clause-satisfaction-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/witnesses/clause-satisfaction-lookup-class.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`

Previous scratchpad for this exact edge:

- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`

No exact scratchpad for this edge was present under
`scratchpads/open-edge-resolution-2026-05-04`.

Primary or near-primary sources checked:

- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability",
  OpenReview page last modified 2026-04-21:
  https://openreview.net/forum?id=aoVCFtox89. Used for the marginal-nonuniform
  quantifier pattern: rates may depend on the marginal distribution, but hold
  uniformly over concepts.
- Schapire, "The Strength of Weak Learnability", Machine Learning 1990:
  https://doi.org/10.1023/A:1022648800760. Used as the weak-to-strong
  background, with the caveat that boosting aggregates hypotheses and is not a
  properization theorem.
- Hastad and Khot, "Query Efficient PCPs with Perfect Completeness", Theory of
  Computing 2005: https://theoryofcomputing.org/articles/v001a007/. Used for
  logarithmic-randomness, perfect-completeness PCPs with soundness below
  $1/2$.
- Khot and Saket, "Hardness of Minimizing and Learning DNF Expressions", FOCS
  2008: https://cs.nyu.edu/~khot/papers/minDNF.pdf. Used as a proper weak
  learning hardness comparison, not as a settlement of this marginal edge.
- Kearns and Valiant, "Cryptographic Limitations on Learning Boolean Formulae
  and Finite Automata", JACM 1994: https://doi.org/10.1145/174644.174647. Used
  as the representation-independent cryptographic learning-hardness anchor.
- Hastad, Impagliazzo, Levin, and Luby, "A Pseudorandom Generator from any
  One-way Function", SIAM J. Comput. 1999:
  https://doi.org/10.1137/S0097539793244708. Used for the one-way-function to
  pseudorandomness background behind dense cryptographic routes.
- Feldman et al., "Agnostic Learning of Monomials by Halfspaces Is Hard", SIAM
  J. Comput. 2012: https://doi.org/10.1137/120865094. Used as a fixed-looking
  weak agnostic hardness comparison, but its distributions do not provide this
  edge's fixed-marginal proper selector.
- Asilis, Devic, Dughmi, Sharan, and Teng, "Proper Learnability and the Role of
  Unlabeled Data", arXiv 2025: https://arxiv.org/abs/2502.10359. Checked as a
  nearby proper-learning source. It gives information-theoretic distribution-
  fixed structure when the marginal is supplied, but it does not give the
  computational, uniform, marginal-nonuniform proper selector needed here.

## Current Verdict

`unresolved`; keep the atlas edge `open` with `evidence: unknown`.

The strongest available positive fact is the sibling edge to
`efficient-marginal-nonuniform-weak-agnostic-improper-pac`: low-noise
robustification preserves the original marginal and produces an improper weak
agnostic predictor. The assigned edge asks for an additional properization
operation, and I do not see that operation in the source assumption.

The strongest available negative routes are PCP active slices, fixed clause
marginals, and one-way image-coordinate/code witnesses. Each still misses the
weak agnostic marginal-nonuniform target for a different reason.

## Positive Route Attempt

The marginal-preserving low-noise argument gives the following. Fix a marginal
$P$, let $A$ be the source learner, and run $A$ at constant clean accuracy. Let
$m_P(s)$ be the corresponding $P$-dependent sample/time bound. Choose
$\alpha_P(s)$ below $1/m_P(s)$.

If $\operatorname{OPT}_{\mathcal C}(\mathcal D)$ is very small, choose a
near-optimal $c^\star\in\mathcal C$ and couple a noisy run of $A$ on
$\mathcal D$ to a clean realizable run on $(X,c^\star(X))$, using the same
$P$-distributed instance sequence. With inverse-polynomial probability no
queried label is corrupted, so the noisy transcript is a valid clean transcript
under the same marginal $P$. Repetition and validation yield an external weak
agnostic predictor.

This proves only the improper sibling edge. To get the assigned target one
would need a further step:

$$
\text{external weak predictor } g
\quad\Longrightarrow\quad
\text{efficiently find } h\in\mathcal C \text{ weakly good under } P.
$$

The source learner does not supply this. Running it on pseudo-labels from $g$
again returns an external hypothesis. Searching for a concept in $\mathcal C$
that correlates with $g$, or directly with the noisy labels, is exactly a
proper weak ERM or trace-selection problem over $\mathcal C$.

The medium/high-OPT branch is also not proper for free. The improper
robustification can fall back to constant classifiers because one constant has
error at most $1/2$. The proper target cannot use this unless constants, or
some equivalent legal neutralizers, already belong to $\mathcal C$.

Thus a positive theorem would need an additional structure such as:

- a fixed-$P$ polynomial-time proper weak ERM routine;
- an efficiently searchable fixed-$P$ weak cover of sample traces of
  $\mathcal C$;
- a polynomial generator of legal candidates whose validation covers the weak
  agnostic target;
- legal constant/complement/fallback handles plus a low-noise projection
  routine.

None of these follows from efficient marginal-nonuniform realizable improper
learning alone.

## Correlation Form Of The Obstruction

Using $\{\pm1\}$ labels, the target inequality is equivalent to

$$
\mathbf E[h(X)Y]
\ge
\sup_{c\in\mathcal C}\mathbf E[c(X)Y]+2\gamma_P(s)-1.
$$

In a realizable case the best proper correlation is $1$, so the target requires
positive inverse-polynomial correlation with the target:

$$
\mathbf E[h(X)c^\star(X)]\ge 2\gamma_P(s).
$$

For a false witness, it is therefore not enough to make exact recovery hard.
Every proper concept with any inverse-polynomial positive correlation must
either be hard to find or be decodable into a hard witness.

The weak agnostic form makes slice constructions especially fragile. If the
hard information occupies only mass $\mu$ and the rest is fair noise or
irrelevant padding, then the best proper correlation can be only about $\mu$.
The guarantee becomes

$$
\mathbf E[h(X)Y]\ge \mu+2\gamma_P(s)-1,
$$

which is vacuous unless $\mu$ is close to $1$. A fixed-marginal counterexample
therefore needs either high-mass hard information or a way to make all weakly
correlated wrong proper outputs useful.

## Counterexample Route Attempts

### PCP Active Slice

The PCP active-slice class has the right distribution-free weak proper
hardness shape. Proper hypotheses encode a PCP proof for one instance
$\varphi$, and the verifier has logarithmic randomness, so the active slice is
polynomial size. An improper learner can memorize positive points on the
active slice, and the agnostic improper one-slice lookup ERM is also
polynomial on sampled slices.

The lower bound, however, uses the marginal concentrated on the input-dependent
active slice $\{(\varphi,r)\}$. In the marginal-nonuniform target, the runtime
polynomial and weak gap may depend on that whole marginal. A reduction that
chooses $P_\varphi$ therefore does not obtain a uniform randomized polynomial
algorithm for the NP language.

Packing all slices into one fixed marginal loses the weak signal. A slice of
mass $w_\varphi$ contributes only $w_\varphi$ times the local PCP gap to the
global correlation. Since there are exponentially many possible instances at a
length, one fixed marginal cannot keep every input slice visible at the scale
needed by an unknown inverse-polynomial weak gap.

### Clause-Satisfaction Fixed Marginal

The clause-satisfaction lookup class is closer to the correct marginal
quantifiers: the marginal can be the uniform distribution over all clauses on
$n$ variables, and the input formula is encoded in the conditional labels.
This is enough for strong proper lower bounds, because a learner run at
accuracy below the formula-clause gap can distinguish satisfiable from
unsatisfiable formulas.

It does not settle the weak agnostic target. The formula occupies only an
inverse-polynomial fraction of the whole clause universe, and fair-noise or
non-formula clauses reduce the best global correlation. In the correlation
inequality above, the weak additive tolerance can absorb the formula-clause
gap unless the hard part carries near-total mass. Making every violated
constraint cost constant mass is essentially a PCP amplification task, which
returns to the active-slice or wrong-instance-handle obstruction.

### One-Way Image Coordinates

The one-way image-coordinate class separates the source from strong proper
marginal-nonuniform learning under length-preserving one-way functions. A
length-$n$ seed $s$ exposes the bits of $f(s)$ on a length-$n$ coordinate
block. An improper learner memorizes observed positive atoms or performs
sparse ERM. Under the fixed block marginal, sufficiently small accuracy
$\varepsilon_n\ll \mu_n/n$ forces any proper hypothesis to output a seed
$t$ with $f(t)=f(s)$.

The weak target does not demand such accuracy. Wrong-length concepts, sparse
default concepts, constants, singletons, or low-mass block handles can often
obtain error below $1/2-\gamma_P(s)$ without inverting $f$. Adding explicit
weak handles makes weak proper learning easy, as recorded in the weak-handle
witness, but then the class is no longer a false witness for this edge.

### Dense Hadamard/Image Codes

The most tempting repair is a balanced code. At one fixed length, define

$$
c_s(a)=(-1)^{\langle f(s),a\rangle},\qquad a\in\{0,1\}^n.
$$

Under the uniform marginal on $a$, an improper learner can recover the image
$y=f(s)$ by linear equations and output the parity with coefficient $y$,
without finding $s$. A proper learner must output a seed. Since wrong seeds
are orthogonal to the target at that fixed length, any positive-correlation
proper output inverts the one-way function.

This is not yet an atlas-valid counterexample. If each length gets its own
block under one finite-string marginal, the block mass $\mu_n$ dilutes the
weak agnostic signal. If the code is moved to shared high-mass coordinates for
all lengths, a fixed finite-string marginal is countably atomic. The previous
scratchpad's Fourier/atomicity calculation indicates that dense, easily
samplable proper code families then expose validation-findable random weak
handles: wrong seeds need not invert $f$, but some of them correlate
positively at the marginal's atom-induced scale.

So the dense route is stuck in a mass-dimension trap:

- weak agnostic hardness needs the hard encoding on most of the fixed
  marginal's mass;
- proper weak safety needs wrong concepts to be nearly orthogonal, or else
  every correlated wrong concept must decode a witness;
- all-length finite-string packings either move dimension into tail mass or
  expose atomic random handles;
- sparse constructions avoid random handles but fall back to dilution or
  wrong-length/default handles.

## Nearby Results That Do Not Resolve The Edge

Schapire's weak-to-strong theorem shows that weak and strong learnability
coincide in the usual efficient PAC setting when the relevant weak learners are
available. It does not project an arbitrary external predictor into the
original representation class. Boosted hypotheses are generally votes or other
compositions, hence improper for this edge.

The marginal-nonuniform work of Hanneke, Moran, and Thiessen supports the
atlas quantifier order: marginal-dependent rates must still hold uniformly
over concepts for a fixed marginal. This does not provide a computational
proper ERM routine.

The distribution-fixed proper-learning result of Asilis et al. is also not a
positive theorem for this edge. Its learner is supplied with the marginal
distribution and the result is information-theoretic for finite learning
problems. The atlas target is a computational uniform learner whose polynomial
bound may depend on $P$, but which is not given a $P$-specific proper search
procedure as advice.

Known weak agnostic hardness results such as Feldman et al. have the right
flavor, but their hard distributions do not give the required one-fixed-
marginal selector for this abstract properization edge.

## Concrete Obstacles

1. The source-to-improper weak agnostic theorem is available, but it outputs an
   external predictor and uses constants as a high-OPT fallback.

2. Properness is a computational representation constraint. Finite-sample
   existence of a good concept, or unbounded ERM, is not enough for the
   efficient target.

3. Marginal-nonuniform lower bounds cannot choose a new hard marginal for each
   input instance unless they control how the $P$-dependent polynomial and weak
   gap depend on that marginal.

4. Fixed universal marginals must keep infinitely many hard instances visible.
   Sparse active slices lose global weak correlation, while dense shared-code
   designs tend to create validation-findable wrong proper handles.

5. The weak agnostic additive guarantee is much less forcing than strong
   proper accuracy. A separation must rule out every proper inverse-polynomial
   weak output, not merely every near-exact output.

## Promising Follow-Up Directions

1. Formalize a fixed-marginal proper weak selector property. Prove that this
   selector plus the low-noise improper robustification would imply the target,
   and isolate exactly why the source learner does not implement the selector.

2. Search for wrong-output-usefulness gadgets: one fixed marginal where every
   legal proper concept with inverse-polynomial positive correlation can be
   decoded into the hard witness. This would avoid needing all wrong concepts
   to be superpolynomially orthogonal.

3. Prove a finite-string mass-dimension lemma for dense code attempts. A useful
   statement would say that all-length dense proper codes over one atomic
   marginal either place distinguishing coordinates in low tail mass or admit
   validation-findable random weak handles.

4. Revisit fixed-label PCP or label-cover constructions where the hard instance
   is encoded in labels under a shared marginal and unrelated proper proofs are
   forced to be near-random, not weak handles.

5. Check whether the atlas intentionally excludes non-atomic computational
   instance models. If infinite-product examples with finite-access evaluation
   were allowed, the Walsh/Hadamard fixed-marginal idea might become a real
   conditional counterexample. Under the current finite-transcript convention,
   it appears outside the model.

## Recommendation

Do not change the atlas edge yet. The current frontmatter remains appropriate:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
argument_note: "[[properization-open|Properization Open]]"
```

Suggested short summary if the edge note is later refreshed:

> Open: marginal-preserving low-noise robustification gives only an improper
> weak agnostic predictor. A proper target would require a fixed-marginal legal
> trace selector or weak proper ERM routine not implied by the source. Known
> fixed-marginal counterexample routes either dilute the hard signal, leak
> proper weak handles, or need shared-code geometry outside the finite-string
> model.

VERDICT: unresolved

## Depth 2 Branch A: Finite-String Mass-Dimension Lemma

### Branch Verdict

`conditional-only`.

The finite-string dense-code route can be blocked in a useful conditional
sense. Under one fixed countable marginal, any all-length proper code family
that tries to make every non-witness proper concept useless must either encode
the witness-distinguishing trace outside every fixed high-mass finite core, or
it creates high-correlation proper handles. If those handles are hit by an
efficient proper-concept sampler with inverse-polynomial probability, ordinary
validation finds a weak proper hypothesis without decoding the hard witness.

This does not resolve the atlas edge. It rules out the clean version of the
Hadamard/Walsh one-way image counterexample in the finite-string model, but it
leaves a possible escape route through exponentially isolated trace cells whose
weak handles exist but are not efficiently findable.

### Setup

Work with labels in $\{\pm1\}$ and one fixed countable instance space $X$ of
finite strings. Let $P$ be the fixed marginal. For concepts $c,h:X\to\{\pm1\}$
write

$$
\langle c,h\rangle_P=\mathbf E_{X\sim P}[c(X)h(X)].
$$

For a hard length $n$, let $\mathcal C_n$ be the proper code family. In the
one-way image attempt, a seed $s$ determines an image $y=f_n(s)$ and the ideal
dense code is the Walsh/Hadamard character

$$
c_s(a)=\chi_{f_n(s)}(a)=(-1)^{\langle f_n(s),a\rangle}.
$$

At one fixed length under the uniform marginal on $a\in\{0,1\}^n$, distinct
characters are orthogonal. An improper learner can recover the image
$f_n(s)$ from labeled linear equations and output the parity indexed by that
image. A proper learner must output a seed. Thus any same-length proper
hypothesis with positive correlation must have the same image and therefore
inverts the one-way image relation. This is the attractive one-length
construction, and it is the same inner-product geometry behind the
Goldreich-Levin hard-core predicate theorem and the cryptographic learning
barriers of Kearns-Valiant and Håstad-Impagliazzo-Levin-Luby.

The problem is making this work for all hard lengths under one finite-string
marginal $P$.

### Lemma: Finite-Core Trace Collision

**Claim.** Fix a countable marginal $P$ on $X$, a finite set $F\subseteq X$,
and $\eta=P(X\setminus F)$. If two binary concepts $c,h$ agree on every point
of $F$, then

$$
\langle c,h\rangle_P\ge 1-2\eta.
$$

Consequently, on realizable labels $Y=c(X)$, the proper concept $h$ has error
at most $\eta$. If $h$ does not decode the same witness as $c$, then $h$ is a
non-decoding weak handle whenever $\eta<1/2-\gamma$.

**Proof.** On $F$, the product $c(x)h(x)$ is $1$. On the complement it is at
least $-1$. Therefore

$$
\langle c,h\rangle_P
=\sum_{x\in F}P(x)c(x)h(x)+\sum_{x\notin F}P(x)c(x)h(x)
\ge P(F)-P(X\setminus F)=1-2\eta.
$$

The error statement is the same calculation in $0/1$ form:
$\operatorname{err}_P(h,c)=P[h(X)\ne c(X)]\le P(X\setminus F)=\eta$.

**Code-family consequence.** Let $\equiv_F$ denote equality of traces on
$F$. If a hard family $\mathcal C_n$ contains two non-equivalent witnesses
whose proper concepts are $\equiv_F$-equal, then the false-witness plan fails
for at least one of them at weak scale $\gamma<1/2-\eta$: the other concept is
a legal proper hypothesis with strong positive correlation and need not decode
the target witness.

Thus, to make every non-decoding proper concept have correlation below an
inverse-polynomial threshold, the construction must make the trace map

$$
c\mapsto c|_F
$$

injective on the relevant hard witnesses. Since $F$ has only $2^{|F|}$ binary
traces, a hard length with $M_n$ distinguishable witnesses needs
$|F|\ge \log_2 M_n$ on every finite core whose complement mass is below the
weak scale being protected.

This is the finite-string mass-dimension tradeoff. For every fixed
high-mass finite core $F$, sufficiently large hard lengths either collide on
$F$ and leak non-decoding weak handles, or they put the information that
distinguishes witnesses in $X\setminus F$. Since $P(X\setminus F)$ can be made
arbitrarily small for a countable marginal, the latter option moves the
decoding-critical coordinates into arbitrarily low tail mass.

### Relation To Plotkin And Walsh Geometry

The lemma is a trace-level version of the same obstruction seen from coding
theory. A one-length Walsh/Hadamard family with $2^n$ codewords lives on
$2^n$ coordinates and has pairwise distance exactly one half under the uniform
coordinate measure. That is precisely the boundary at which positive
correlation disappears.

Plotkin's binary-code bound says that if the relative distance is pushed above
$1/2$, equivalently if pairwise correlations are uniformly negative, then the
number of codewords is only linear in the block dimension. At distance exactly
$1/2$, Hadamard codes attain the boundary with linearly many codewords in the
coordinate dimension. Therefore a seed family of size $2^n$ needs about
$2^n$ effective coordinates if it wants exact Walsh-style safety.

This explains the two bad cases for the all-length one-way image attempt.

1. **Separate length blocks.** If length $n$ gets its own nearly uniform
Hadamard block of mass $\mu_n$, exact same-length orthogonality is possible,
but $\sum_n\mu_n\le1$, so $\mu_n\to0$. The global weak agnostic signal of the
hard block is then scaled by $\mu_n$. This is tail-mass dilution.

2. **Shared high-mass coordinates.** If many lengths reuse one fixed
high-mass finite core, then long lengths have more witnesses than trace
patterns on that core. Trace collisions create concepts agreeing with the
target on almost all $P$-mass, hence proper weak handles that do not decode
the target. This is the finite-atom collision obstruction.

Approximate codes do not remove the tension. Allowing small positive
correlations permits exponentially many codewords on a finite block, but those
small positive correlations are exactly legal weak handles unless every such
handle is computationally as hard to find as decoding. The weak agnostic target
only asks for inverse-polynomial advantage, so residual inverse-polynomial
correlation cannot be dismissed as harmless geometry.

### Validation-Findable Handle Lemma

The collision lemma is information-theoretic. To turn it into an algorithmic
block against a counterexample, add the following natural sampler condition.

Assume there is a polynomial-time randomized generator $G_n$ for legal proper
concepts at length $n$. Suppose that for every hard target $c\in\mathcal C_n$,
with probability at least $\pi_n\ge n^{-O(1)}$, $G_n$ outputs a non-decoding
$h\in\mathcal C_n$ satisfying

$$
\langle c,h\rangle_P\ge 2\gamma_n,
$$

where $\gamma_n\ge n^{-O(1)}$. Then weak proper agnostic learning is easy on
the realizable target distribution $Y=c(X)$: draw $O(\pi_n^{-1}\log(1/\delta))$
candidates, estimate their correlations on
$O(\gamma_n^{-2}\log(\pi_n^{-1}/\delta))$ labeled validation samples, and
output any candidate with empirical correlation at least $\gamma_n$. Standard
Hoeffding validation succeeds with constant probability and outputs a proper
hypothesis of error at most $1/2-\gamma_n/2$ after adjusting constants.

This candidate does not decode the hard witness by assumption. Therefore any
dense-code separation must violate the sampler condition: non-decoding weak
handles must be absent, or present only in exponentially hard-to-find trace
cells.

For natural dense code attempts, such as random seeds in a shared-code family,
the sampler condition is hard to avoid. Once a high-mass core has only
polynomially or subexponentially many trace cells, many targets sit in large
cells, and a random proper seed has noticeable probability of landing in a
same-trace or positively correlated cell. Validation then finds the handle
without inspecting or inverting the one-way image.

### What This Blocks

This blocks the clean Hadamard/Walsh all-length false witness in the current
atlas model.

At one fixed length, the construction is coherent:

$$
s\mapsto f_n(s)\mapsto \chi_{f_n(s)}
$$

lets an improper learner recover the image but forces a proper positively
correlated output to recover a preimage. Across all lengths under one
countable finite-string marginal, the construction must choose between:

- disjoint dense blocks, which make the hard block mass $\mu_n$ vanish;
- shared high-mass atoms, which cause trace collisions and weak handles;
- approximate shared codes, which leave residual inverse-polynomial
  correlations unless finding all such correlations is computationally hard;
- exponentially isolated high-mass traces, which evade this lemma but no
  longer look like the simple dense Walsh counterexample.

The last option is the only remaining dense-code escape route suggested by
this branch. It would need a new computational statement: not merely that
decoding the witness is hard, but that finding any non-decoding concept with
inverse-polynomial positive correlation is hard under the fixed marginal.
That is a substantially stronger wrong-output-usefulness requirement than the
standard one-way image story.

### Model Boundary

The obstruction uses countable atomicity. If the atlas allowed atomless
product examples or oracle-valued infinite random strings as computational
instances, one could try to keep a high-mass Walsh coordinate system for every
length without allocating separate finite-string mass to each length. In that
larger model, the one-way image/Hadamard idea might become a real conditional
counterexample. Under the present finite-transcript convention, the
finite-core lemma says that the route is at best conditional and currently
does not justify changing the edge status.

Primary anchors for this branch:

- [Goldreich and Levin 1989](https://www.wisdom.weizmann.ac.il/~oded/gl.html)
  for the inner-product hard-core predicate viewpoint.
- [Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647) and
  [Håstad, Impagliazzo, Levin, and Luby 1999](https://doi.org/10.1137/S0097539793244708)
  for one-way-function and pseudorandomness learning barriers.
- [Plotkin 1960](https://doi.org/10.1109/TIT.1960.1057584) for the binary-code
  distance bound underlying the dimension comparison.

VERDICT: conditional-only
