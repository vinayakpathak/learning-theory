# Edge: efficient-marginal-nonuniform-weak-agnostic-proper-pac -> efficient-realizable-improper-pac

- date: 2026-05-05
- edge_file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-realizable-improper-pac.md`
- worker constraint: only this scratchpad was created/edited; no atlas files were edited
- verdict: unresolved-open
- confidence: 0.90

## Current Atlas State

The edge is currently marked:

```yaml
status: "open"
evidence: unknown
family: marginal-uniformization-open
summary: "Open: the source allows marginal-dependent polynomial bounds, while the target requires one distribution-free polynomial bound."
```

That summary is directionally right but no longer quite sharp after the newer full-support resource-uniformization notes. Under the atlas worst-case finite-transcript convention, the runtime of one call to the single marginal-nonuniform source learner can be made distribution-free by applying the source to a full-support reference marginal. The live obstruction is the weak gap, not the one-call resource bound.

## Definitions Used

The source gives one uniform learner $A$ such that, for every instance marginal $P$, there are a marginal-dependent resource polynomial and weak agnostic tolerance

$$
\beta_P(s)=1/2-\gamma_P(s)<1/2,
$$

where $1/\gamma_P(s)$ is bounded by a $P$-dependent polynomial. For every joint distribution $\mathcal D$ with marginal $P$,

$$
\operatorname{err}_{\mathcal D}(A)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\beta_P(s),
$$

and $A$ outputs a proper hypothesis $h\in\mathcal C$.

On realizable labels from a target $c\in\mathcal C$, this specializes to a proper weak learner under the actual marginal $P$:

$$
\operatorname{err}_P(h,c)\le 1/2-\gamma_P(s).
$$

The target asks for one distribution-free polynomial-time improper realizable PAC learner: for every marginal $P$, target $c\in\mathcal C$, and accuracy $\varepsilon>0$, output some binary hypothesis $h$ with

$$
\operatorname{err}_P(h,c)\le\varepsilon
$$

in time polynomial in the representation size, $1/\varepsilon$, and $\log(1/\delta)$, with the polynomial independent of $P$.

## Sources Checked

Local atlas files:

- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-weak-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--sample-efficient-realizable-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-realizable-improper-pac.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/arguments/realizable-boosting.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/halfspace-agnostic-hardness.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/sample-to-computational-hardness.md`
- `atlas/witnesses/halfspaces.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- `atlas/witnesses/pseudorandom-function-classes.md`
- Neighboring scratchpad `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-realizable-improper-pac/scratchpad.md`
- `references.bib`

Primary-source pages checked online:

- Hanneke, Moran, and Thiessen 2025, Marginal-Nonuniform PAC Learnability: https://openreview.net/forum?id=aoVCFtox89
- Schapire 1990, The Strength of Weak Learnability: https://doi.org/10.1023/A:1022648800760
- Freund 1995, Boosting a Weak Learning Algorithm by Majority: https://doi.org/10.1006/inco.1995.1136
- Feldman 2010, Distribution-Specific Agnostic Boosting: https://arxiv.org/abs/0909.2927
- Ghai and Singh 2025, Sample-Optimal Agnostic Boosting with Unlabeled Data: https://proceedings.mlr.press/v267/ghai25a.html
- da Cunha, Hogsgaard, and Paudice 2026, Sample-Near-Optimal Agnostic Boosting with Improved Running Time: https://arxiv.org/abs/2601.11265
- Tiegel 2023, Hardness of Agnostically Learning Halfspaces from Worst-Case Lattice Problems: https://proceedings.mlr.press/v195/tiegel23a.html
- Hastad and Khot 2005, Query Efficient PCPs with Perfect Completeness: https://theoryofcomputing.org/articles/v001a007/
- Kearns and Valiant 1994, Cryptographic Limitations on Learning Boolean Formulae and Finite Automata: https://doi.org/10.1145/174644.174647

## Positive Route: What Almost Works

### One-Call Resources Uniformize

Let $A$ be the single learner from the source. Choose a full-support reference marginal $P^\star$ over every finitely encoded instance in each representation-size slice. By the source guarantee for $P^\star$, the sample use and runtime of $A$ are bounded by one polynomial $p_{P^\star}$.

Because $P^\star$ has full support, every finite labeled transcript that can occur under any marginal has positive probability under $P^\star$ for some target or conditional labeling rule. Under the atlas worst-case/pathwise resource convention, $A$ cannot exceed $p_{P^\star}$ on any such transcript. Thus a single call to $A$ has a distribution-free polynomial resource bound.

This is useful but not enough. Accuracy under $P^\star$ does not transfer to arbitrary $P$, and in any case the source accuracy under the actual $P$ is only weak:

$$
\operatorname{err}_P(A,c)\le 1/2-\gamma_P(s).
$$

### Standard Realizable Boosting Still Needs A Uniform Gap

Schapire/Freund boosting would convert a weak realizable learner into a strong improper learner if the weak advantage were bounded below by one inverse polynomial. After resource uniformization, the missing statement is something like

$$
\exists r\ \forall Q\quad \gamma_Q(s)\ge 1/r(s),
$$

at least for every marginal $Q$ generated during boosting.

The source only gives

$$
\forall Q\ \exists r_Q\quad \gamma_Q(s)\ge 1/r_Q(s).
$$

The quantifier swap is exactly the unresolved step. The fact that the source output is proper does not fix this; a realizable booster is happy to aggregate proper weak hypotheses into an improper final vote, but the number of rounds still depends on the available weak advantage.

### Reweighted Marginals And Same-Marginal Relabeling

A standard booster calls the weak learner on reweighted marginals $Q_t$. The source gives a guarantee on each $Q_t$, but with a possibly different hidden gap $\gamma_{Q_t}(s)$. No current atlas assumption says these gaps have one polynomial lower envelope, even if $Q_t$ has bounded density with respect to the original marginal.

The agnostic nature of the source suggests a same-marginal route: encode a weighted residual distribution by keeping the instance marginal $P$ and randomizing labels. In $\{\pm1\}$ notation, if

$$
\mathbb E[Y\mid X=x]=a(x)c(x),\qquad 0\le a(x)\le 1,
$$

then the source gives

$$
\operatorname{corr}(h,Y)
\ge
\sup_{c'\in\mathcal C}\operatorname{corr}(c',Y)-2\beta_P(s).
$$

For a target weight $dQ/dP=w$ encoded as $a=w/B$, the best concept has correlation $1/B$. This only yields a positive $Q$-edge when

$$
1/B > 1-2\gamma_P(s),
$$

so $B$ must be very close to $1$ when $\gamma_P(s)$ is tiny. This cannot drive ordinary residual focusing to arbitrary $\varepsilon$.

Modern distribution-specific agnostic boosting results are still relevant: they show that nontrivial correlation-style weak oracles can often be boosted with unlabeled data from the fixed marginal. But their overhead depends on the nontriviality margin, here essentially $2\gamma_P(s)$. That would at best prove a marginal-nonuniform strong learner with a $P$-dependent polynomial. It does not yield the distribution-free target without weak-gap uniformization.

### Conditional True Statement Under Stronger Semantics

There is a clean diagonal argument under a stronger size-indexed semantics. If a marginal were formally a family $P=(P_s)_{s\ge 1}$ and accuracy were evaluated separately on each representation-size slice, then failure of a uniform weak gap would let us choose sizes $s_d$ and marginals $Q_d$ with $\gamma_{Q_d}(s_d)<s_d^{-d}$, stitch them into one diagonal marginal family, and contradict the source guarantee for that single family.

Under that stronger convention, full-support resource uniformization plus ordinary realizable boosting would likely prove this edge true.

I do not think this should be the atlas verdict under the current notes. The present atlas treats a marginal as a distribution over the instance space and explicitly distinguishes resource transfer from accuracy transfer. In a weighted global mixture $P=\sum_d w_dQ_d$, an additive weak guarantee may ignore sufficiently low-mass bad components while still achieving error below $1/2-\gamma_P$ on the mixture. Thus the diagonal weak-gap proof depends on a schema strengthening, not merely on the current definitions.

## Counterexample Search

A false witness must satisfy a demanding combination:

1. It must have one fixed-polynomial-time weak agnostic proper learner after full-support resource uniformization.
2. For every marginal, the learner may have a marginal-dependent inverse-polynomial weak gap.
3. It must still have no distribution-free polynomial-time strong realizable improper learner.

This is much narrower than ordinary computational hardness.

### Halfspaces

Halfspaces are not a counterexample.

They satisfy the source: halfspaces are efficiently realizably properly learnable by linear feasibility and VC generalization, constants are proper halfspaces, and the low-noise robustification gives a proper weak agnostic learner with an inverse-polynomial gap.

They also satisfy the target: the same realizable halfspace learner is an efficient distribution-free realizable improper learner. Tiegel's lattice-based hardness is powerful for agnostic targets, including improper agnostic learning under the standard Gaussian marginal, but it does not refute this realizable improper target.

### PCP Active-Slice Lookup Class

The PCP active-slice witness is also not a counterexample.

It fails the source under $\mathrm{NP}\nsubseteq\mathrm{RP}$: a weak proper learner on the active slice would distinguish satisfiable instances from unsatisfiable instances using perfect completeness and soundness below $1/2$.

It satisfies the target anyway: the active slice has polynomial size, so an improper learner can memorize positive sample points and predict $0$ elsewhere. This gives distribution-free realizable improper learning.

### One-Way Image-Coordinate Witnesses

The one-way image-coordinate weak-handle class is source-positive but target-positive.

Adding constants and singleton concepts gives proper weak handles under every marginal. The same handles plus the marginal-preserving low-noise robustification make the weak agnostic proper source plausible and are already used in nearby scratchpads.

But the target here is improper. An improper realizable learner can memorize the observed positive coordinate atoms and predict $0$ elsewhere; for a length-$n$ seed concept there are only $n$ positive atoms. The one-way lower bound only forces hardness for strong proper recovery, where accuracy under the fixed coordinate marginal excludes constants and singleton handles and forces a seed with the right image.

So this witness separates proper strong targets, not the assigned improper realizable target.

### Pseudorandom Functions And Other Cryptographic Hard Marginals

PRF-style classes fail the target, but they also fail the source. On the hard marginal, no randomized polynomial-time algorithm can even weakly learn without distinguishing pseudorandom functions from random labels.

This rules out the simplest sample-to-computational-hardness route. A valid false witness cannot merely hide a hard marginal; it must remain weakly agnostically and properly learnable on that marginal.

### Rare-Slice And Addressed-Code Templates

The most plausible false template is a family of slices where slice $k$ has cheap weak handles of advantage about $s^{-k}$, but any strong improper learner needs about $s^k$ handles or must solve a hard residual problem. A marginal over slices could then have a $P$-dependent weak-gap exponent, while no distribution-free polynomial exponent would suffice for all slices.

This remains only a template.

The resource side cannot use slice-dependent runtimes: full-support transcript uniformization would make any high-slice transcript visible under $P^\star$, so one source learner cannot run in time $s^{O(k)}$ on slice $k$ for unbounded $k$ at the same representation size. The slice parameter has to appear in the weak advantage, not in the cost of finding one weak hypothesis.

An addressed-code toy model captures the desired shape. Points are coordinates $(i,b)$ of a long codeword $G(u)$, and one observed coordinate gives a weak handle with advantage about $1/N$. Strong prediction would require many coordinates or prediction of unseen coordinates. But this is not atlas-ready:

- proving an agnostic `OPT + 1/2 - 1/N` guarantee under every marginal appears to require validation over many possible handles;
- if handles are cheaply findable on every residual marginal, an improper booster can usually aggregate them;
- if unseen-coordinate prediction is made cryptographically hard, the residual weak source usually fails too;
- under size-indexed marginal semantics, a diagonal marginal following growing $k$ would make the weak gap super-polynomial and violate the source.

Thus the needed false witness would be a genuinely nonboostable cheap-handle family. I do not know one in the existing atlas.

## Proposed Atlas Update

I would keep the edge open, but revise the diagnosis away from pure resource uniformization and toward weak-gap uniformization/boosting.

Suggested frontmatter:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - schapire1990
  - freund1995boosting
  - feldman2010distributionspecific
  - ghai2025agnosticboosting
  - dacunha2026agnosticboosting
  - benedek1991fixed
  - bendavid1995parameterization
  - hanneke2025marginalnonuniform
summary: "Open: full-support marginal uniformization controls the runtime of one weak call, but the source gives only marginal-dependent weak advantages; no theorem turns those hidden gaps into a distribution-free strong realizable improper learner."
family: marginal-boosting-open
argument_note: "[[marginal-boosting-open|Marginal-Nonuniform Boosting Open]]"
```

Suggested body:

```markdown
The source specializes on realizable labels to a proper weak learner with marginal-dependent advantage `gamma_P(s)`. Under the atlas worst-case transcript convention, a full-support reference marginal gives one distribution-free polynomial bound on the runtime and sample use of a single call to the source learner.

The remaining obstruction is the weak gap. Standard realizable boosting would yield an improper strong learner if the weak advantages over booster-generated marginals had one distribution-free inverse-polynomial lower bound. The source only gives a separate inverse-polynomial lower bound for each marginal. Same-marginal agnostic relabeling avoids changing the instance marginal, but the atlas fixed-additive guarantee supplies only a nontriviality margin depending on `gamma_P(s)`, so the resulting overhead is still marginal-dependent.

Known witnesses do not settle the edge. Halfspaces satisfy the target despite agnostic hardness; PCP active-slice classes are source-negative for proper weak learning and target-positive improperly; one-way image-coordinate weak-handle classes are source-positive but target-positive because improper memorization learns the sparse positive atoms. A counterexample would need source-positive, computationally nonboostable weak handles, while a proof would need a weak-gap uniformization theorem.
```

## Concrete Next Directions

1. Add or split out a `weak-gap-uniformization-open` argument family. These edges are not blocked merely by marginal-dependent one-call resources after full-support uniformization.

2. Decide the marginal semantics at the schema level. If marginals are size-indexed families with per-size accuracy guarantees, the diagonal weak-gap lemma may resolve this edge true.

3. Formalize a no-transfer lemma for the current weighted-global semantics: an additive weak guarantee on a mixture need not imply any nontrivial weak guarantee on low-mass components.

4. Try a relativized addressed-code separation before attempting a concrete PAC class. The oracle should make one weak handle cheap under every residual marginal but force any fixed-polynomial improper learner to fail on some large slice.

5. Track improvements in agnostic boosting. A parameter-efficient marginal-preserving booster for the atlas fixed-additive source would settle the marginal-nonuniform strong sibling and reduce this edge entirely to distribution-free weak-gap uniformization.

## Final

verdict: unresolved-open

confidence: 0.90

## Depth 2 Followup: Weak-Gap Diagonal and Dense-Block Handle Search

- date: 2026-05-05
- followup depth: 2
- changed_files: this scratchpad only
- verdict: unresolved-open
- confidence: 0.87

### Question Being Tested

Can the current atlas semantics prove

$$
\text{efficient marginal-nonuniform weak agnostic proper}
\Rightarrow
\text{efficient distribution-free realizable improper}?
$$

Or can one build a rigorous source-positive, target-negative class?

The answer after this pass is still no resolution. The size-indexed diagonal
route would prove a nearby theorem, but it uses stronger semantics than the
current atlas. A denser cryptographic block construction gets closer to a
counterexample than the sparse one-way coordinate witness, but it is not yet
atlas-ready because the weak agnostic source proof has to be uniform in
finite-transcript runtime while allowing hidden, slice-dependent weak gaps.

### Conditional True Theorem Under Size-Indexed Marginals

Here is the clean theorem that would hold under a stronger schema.

**Stronger semantics.** A marginal is not one global distribution over
instances. It is a size-indexed family $P=(P_s)_{s\ge 1}$, and the guarantee at
representation size $s$ is evaluated under $P_s$.

**Claim under that semantics.** The edge should be true.

**Proof sketch.** Let $A$ be the source learner. The full-support transcript
argument still gives one distribution-free polynomial bound for a call to
$A$: apply the marginal-nonuniform source to a full-support size-indexed
reference family $P^\star$.

It remains to uniformize the weak gap. Suppose no distribution-free
inverse-polynomial gap exists. Then for every $d$ there are a size $s_d$, a
size-$s_d$ marginal $Q_d$, and a realizable target $c_d$ such that $A$'s
advantage under $Q_d$ is below $s_d^{-d}$, with $s_d$ chosen large enough to
absorb constants. Define one diagonal marginal family by setting
$P_{s_d}=Q_d$ on the selected sizes and filling the other sizes arbitrarily.
The source guarantee for this single $P$ supplies a polynomial
$r_P(s)\le C s^D$ such that the weak advantage is at least $1/r_P(s)$ for all
sufficiently large selected sizes. Choosing $d>D$ contradicts the construction
of $Q_d$.

Thus under size-indexed semantics $A$ has one distribution-free
inverse-polynomial weak advantage. On realizable labels this is a
distribution-free weak proper learner, and Schapire/Freund boosting gives the
strong improper target.

This is not a proof of the atlas edge as currently written. It proves that a
schema change would likely resolve this family of edges as true.

### Why The Diagonal Fails Under Current Atlas Semantics

The current atlas uses a single global instance marginal $P$ and worst-case
finite-transcript resource bounds. The resource part diagonalizes through a
full-support reference marginal; the accuracy gap does not.

The obstruction can be stated as a no-transfer lemma.

**No-transfer lemma.** Let $Q_j$ be bad size-local marginals, and let
$P=\sum_j w_j Q_j$ be a global mixture with rapidly decreasing weights. A
weak additive guarantee under $P$ need not imply any nontrivial weak guarantee
under a low-mass component $Q_j$.

For example, suppose a target $c_j$ is nontrivial only on the $Q_j$ component
and is zero elsewhere. The all-zero hypothesis has global error at most
$w_j/2$ even if it has error $1/2$ on $Q_j$. If $w_j$ is small, this is a
large global advantage. Therefore the source guarantee for the one global
mixture $P$ can be satisfied while completely ignoring the component on which
the proposed diagonal wanted to force a tiny weak gap.

This is the precise place where the size-indexed proof uses an assumption not
present in the atlas. It needs "at size $s_j$, evaluate on $Q_j$ with full
mass"; the current global mixture only gives "$Q_j$ has weight $w_j$ inside
one distribution."

### Harder Counterexample Route: Dense PRF Blocks Plus Sparse Proper Handles

The old sparse-positive one-way coordinate witness is target-positive because
an improper learner memorizes the few positive atoms. A more serious false
template should make the hard block dense, while keeping one tiny proper weak
handle easy.

A plausible conditional construction is:

1. Blocks are indexed by parameters $(n,k)$. The active block
   $B_{n,k}$ has $N=n^k$ coordinates, with coordinate strings of length
   $O(k\log n)$.
2. A hard concept $c_{n,k,a}$ is zero off $B_{n,k}$ and equals a random-access
   pseudorandom function or generator output on $B_{n,k}$, keyed by
   $a\in\{0,1\}^n$.
3. The proper class also contains constants and sparse sample-handle
   concepts, such as finite sets of labeled coordinates, with representation
   length proportional to the listed coordinates.
4. A weak proper learner uses constants unless the active block has almost all
   the marginal mass. In that exceptional case, it outputs a sparse handle
   from a few labeled examples. Under the uniform marginal on $B_{n,k}$ this
   gives advantage about $1/N=n^{-k}$.
5. For the marginal concentrated on this one block, $n^{-k}$ is still
   inverse-polynomial with a polynomial whose exponent depends on that
   marginal. Across all blocks there is no uniform exponent.
6. Under the uniform marginal on $B_{n,k}$, any distribution-free strong
   improper learner running in $\operatorname{poly}(n+k,1/\varepsilon)$ time
   and achieving error below, say, $1/3$ would predict a pseudorandom function
   on fresh random coordinates and hence distinguish it from a random
   function.

This template avoids the earlier resource mistake: the weak call need not run
for $N$ steps or validate to accuracy $1/N$. It can output a sparse handle
from a polynomial number of observed examples, so the full-support
finite-transcript resource argument is not immediately violated.

It is still not a rigorous atlas counterexample. The missing pieces are real:

1. The representation model has to be fixed carefully. The parameter $k$ should
   be encoded so that coordinate length $O(k\log n)$ and sparse-handle output
   length are polynomial in the target representation size, while
   $N=n^k$ can still be super-polynomial in that size.
2. The pseudorandom object must support random access on coordinates of length
   $O(k\log n)$ and remain secure against $\operatorname{poly}(n+k)$ learners.
3. The weak source must be proved in the agnostic proper sense, not only on
   realizable PRF labels. Validation to accuracy $1/N$ would break the
   full-support pathwise resource convention, so the proof needs a direct
   no-validation weak-handle lemma or a robustification argument that preserves
   uniform finite-transcript runtime.
4. The added sparse handles must not accidentally make the dense PRF targets
   strongly improperly learnable. This is probably true under standard PRF
   prediction hardness, but the reduction must account for the enlarged proper
   class and for learners that output arbitrary hypotheses.
5. For every fixed global marginal $P$, one must prove a single
   $P$-dependent polynomial lower envelope for all target sizes. The intended
   reason is that concepts are active on one block and zero elsewhere:
   all-zero handles every block of mass bounded away from $1$, and at most one
   block can carry mass close to $1$. The exceptional block is fixed, so its
   exponent may be absorbed into the $P$-dependent polynomial.

This is the best false route I see, but it needs a full witness note before it
should change the edge status.

### Current Verdict

The edge should remain `open` under current atlas semantics.

The proposed atlas update from the previous pass still looks right: move the
diagnosis away from `marginal-uniformization-open` and toward
`marginal-boosting-open`, or split out a sharper
`weak-gap-uniformization-open` family. A status change to `true` would require
the size-indexed semantics change. A status change to `false` would require
formalizing the dense-block PRF/sparse-handle construction above.

### Depth 3 Directions

1. Formalize the dense-block PRF/sparse-handle class as a candidate witness.
   Prove first the realizable weak proper source with a uniform pathwise weak
   call and a $P$-dependent weak-gap envelope.

2. Prove or refute the needed agnostic handle lemma: if labels are within
   $\eta$ of a dense block concept and $\eta$ is below the hidden handle mass,
   a sparse observed-label handle gives an
   $\operatorname{OPT}+1/2-\gamma_P(s)$ proper hypothesis without validating to
   scale $\gamma_P(s)$.

3. Write the conditional size-indexed theorem as a separate schema note. If
   the atlas ever changes marginals from global distributions to per-size
   families, this edge should likely flip to `true` by diagonal weak-gap
   uniformization plus realizable boosting.

4. Prove the global-mixture no-transfer lemma as an argument note. It would
   explain why current global marginal semantics cannot support the
   size-indexed diagonal.

## Depth 3 Followup: PRF-Block Sparse-Handle Source Audit

- date: 2026-05-05
- followup depth: 3
- changed_files: this scratchpad only
- verdict: construction-fails-as-atlas-counterexample; edge-remains-open
- confidence: 0.84

### Question Being Tested

Depth 2 left a plausible false route: make the hard region dense by using
large PRF coordinate blocks, but add cheap sparse proper handles so that every
fixed marginal still has a marginal-dependent weak advantage. This pass tests
whether that route can be made atlas-ready under standard PRF or one-way
assumptions.

My conclusion is no. The target lower bound is still plausible, and the
representation/security bookkeeping can probably be cleaned up. The source
proof fails earlier: the proposed proper weak learner cannot reliably select
the correct default orientation on a near-balanced high-scale block using only
one fixed-polynomial number of samples. This is already a realizable proper
weak-learning failure, so the agnostic proper source cannot be obtained by
low-noise robustification.

### Candidate Being Audited

For each pair $(n,k)$, let the active block have

$$
r=n^k
$$

coordinates, represented by points $(n,k,i,b)$ with $i\in[r]$ and
$b\in\{0,1\}$. For a PRF seed $a$, the dense target is

$$
c_{n,k,a}(n',k',i,b)=1
\quad\Longleftrightarrow\quad
(n',k')=(n,k)\ \text{and}\ b=F_a(i).
$$

The proposed proper class also contains constants and sparse lookup handles:
a default label plus a polynomial-size list of coordinates whose two atoms are
labeled according to the examples seen there. A source learner would sample,
build sparse handles for the observed coordinates, validate them, and output a
proper handle.

The representation issue is not the fatal part. One can encode $k$ in unary
or otherwise ensure that the PRF input length $O(k\log n)$ stays polynomial in
the representation size in the regimes used for the lower bound. Standard PRF
security gives the usual prediction hardness on unseen coordinates, and PRFs
can be based on standard one-way assumptions through the existing
`goldreich1986`, `kearns1994cryptographic`, and `hastad1999prg` references.

### Target Hardness Is Plausible But Not Enough

Suppose a distribution-free strong realizable improper learner had sample and
time bound $s^D$. Choose a fixed block scale $k$ much larger than $D$ and put
the marginal uniformly on $B_{n,k}$. With $r=n^k$ coordinates, the learner sees
only a vanishing fraction of coordinates. Any substantial advantage on fresh
unseen coordinates would distinguish the PRF from a truly random function.

Thus the PRF side can plausibly rule out distribution-free strong realizable
improper learning. Sparse handles do not obviously destroy this lower bound:
an improper target learner may memorize its sample, but when $k$ is chosen
larger than its polynomial exponent, memorization covers too little of the
block.

The failure is not on this target side. The failure is that the same class does
not satisfy the source.

### Exact Source Failure: Default Orientation

Under the full-support pathwise resource convention used in the atlas, the
single source learner cannot spend $s^{\Theta(k)}$ samples on a high-scale
block. Applying the source to a full-support reference marginal gives a fixed
pathwise polynomial sample bound for one call; write it as

$$
m=m(s,0.1)\le s^T
$$

for confidence $0.9$.

Fix a high-scale block with $r\gg m^2$ and a PRF seed $a$. Consider two
realizable instance marginals on this same block:

$$
P_+(i,F_a(i))=\frac{1+2\varepsilon}{2r},
\qquad
P_+(i,1-F_a(i))=\frac{1-2\varepsilon}{2r},
$$

and $P_-$ with the two weights swapped. Take

$$
\varepsilon = 10m/r.
$$

Under $P_+$, the target-positive mass is $1/2+\varepsilon$, so the better
unsampled default is the positive/default-one orientation. Under $P_-$, the
better default is the negative/default-zero orientation.

A sparse handle with the wrong default corrects only the coordinates it has
seen. With $m$ examples, that correction has mass $O(m/r)$ with high
probability. Since $\varepsilon$ was chosen larger than this correction scale,
the wrong orientation still has error at least $1/2$ on the corresponding
marginal.

So a proper weak learner must choose opposite default orientations for $P_+$
and $P_-$ with high probability. But the $m$-sample transcript distributions
under these two marginals have total variation at most

$$
O(m\varepsilon)=O(m^2/r),
$$

which is negligible for $r\gg m^2$. The learner therefore cannot distinguish
the two cases well enough to output the right orientation with probability
$0.9$ for both marginals.

There is no obvious third option. Predicting the PRF values on many unseen
coordinates would violate PRF security, and validating the sign of a bias of
order $m/r$ requires about $(r/m)^2$ fresh examples, which is superpolynomial
in the high-$k$ regime. Trying both defaults and selecting empirically has the
same validation-resolution problem.

Thus for at least one of $P_+$ or $P_-$, the proposed learner outputs, with
constant probability, a hypothesis of error at least $1/2$. That violates the
source even with an arbitrarily tiny positive weak gap
$\gamma_P(s)>0$. The issue is not merely that the gap is too small to be
uniformized; the candidate fails to provide any high-probability weak edge on
one of the two marginals.

### Why Agnostic Proper Learning Does Not Repair It

Because the realizable subcase fails, the low-noise weak agnostic
robustification cannot be invoked. The source node requires, for every joint
distribution with the same marginal $P$,

$$
\operatorname{err}(h)
\le
\operatorname{OPT}_{\mathcal C}+1/2-\gamma_P(s).
$$

If the learner cannot satisfy this when $\operatorname{OPT}_{\mathcal C}=0$,
it certainly cannot satisfy it in the agnostic proper setting.

Adding more handles creates a tension:

- A public orientation handle can be ignored by an adversarial marginal unless
  it is forced to have noticeable mass.
- If the handle is forced or made strong enough for every marginal, the
  distribution-free target learner can use it too, undermining the PRF lower
  bound.
- A randomized default would help only if stochastic hypotheses were allowed.
  The atlas definitions use binary hypotheses. Replacing randomness with a
  compact hash leaves correlation fluctuations larger than the desired
  $m/r$ edge on sufficiently high-scale blocks.

So the dense PRF-block plus sparse-handle construction is not atlas-ready as a
conditional false witness under the current definitions.

### Depth 4 Directions

1. Formalize the two-marginal default-orientation obstruction as a reusable
   lemma. It should state that any sparse-handle PRF block whose only
   learnable gain is $O(m/r)$ fails marginal-nonuniform weak realizable
   proper learning for near-balanced biased marginals when $r\gg m^2$.

2. If pursuing a false witness, search for deterministic orientation-free
   handles. The handle must give a weak proper edge for every marginal without
   giving a distribution-free improper learner a uniform inverse-polynomial
   edge.

3. Audit whether any atlas notion permits randomized prediction rules. If it
   did, the random-default version would deserve a separate analysis; under
   the current binary-hypothesis convention it does not repair the witness.

4. Keep the PRF target-hardness calculation separate from source
   learnability. The lower bound is useful only after a valid arbitrary-
   marginal weak agnostic proper source learner is proved.

5. Revisit the positive side through weak-gap uniformization or a clarified
   size-indexed marginal semantics. The depth-2 diagonal proof still looks
   like the cleanest route to a true theorem under stronger slice-conditional
   semantics, but it is not a theorem under current global-marginal semantics.

### Depth 3 Verdict

The dense PRF-block/sparse-handle route fails as an atlas-ready counterexample
for this edge. It cannot presently be promoted to `false`, even conditionally
on standard PRF or one-way assumptions. The edge should remain `open`, with
the main obstruction still recorded as weak-gap uniformization rather than
one-call runtime uniformization.

## Depth 4 Followup: Global-Marginal Theorem Route Barrier

- date: 2026-05-05
- followup depth: 4
- changed_files: this scratchpad only
- verdict: theorem-route-not-closed-under-current-semantics; edge-remains-open
- confidence: 0.88

### Question Being Tested

This pass ignores the dense PRF-block counterexample route, since depth 3
found that the proposed sparse-handle source learner fails on near-balanced
high-scale marginals. The question is whether the positive theorem route can
now settle the edge:

1. Use a full-support reference marginal to make one call to the
   marginal-nonuniform weak agnostic proper learner distribution-free in
   sample and time.
2. Diagonalize the marginal-dependent weak gaps into one distribution-free
   inverse-polynomial weak gap.
3. Apply realizable weak-to-strong boosting and output the improper majority
   vote.

The answer under the current atlas global-marginal semantics is still no. Step
1 works. Step 3 would work if step 2 were available. Step 2 is exactly where
the current semantics are too weak.

### What The Theorem Route Would Need

Let $A$ be the source learner. On realizable labels from $c\in\mathcal C$ and
instance marginal $P$, the source gives

$$
\operatorname{err}_P(A,c)\le 1/2-\gamma_P(s),
$$

where $1/\gamma_P(s)$ is bounded by a polynomial whose degree may depend on
$P$.

Full-support resource uniformization gives one polynomial bound on the sample
use and runtime of a call to $A$. Therefore a standard booster would become a
distribution-free strong improper learner if there were a distribution-free
polynomial $r$ such that every relevant marginal $Q$ satisfies

$$
\gamma_Q(s)\ge 1/r(s).
$$

For a reweighting booster, the relevant marginals are the booster-generated
$Q_t$. For a same-instance-marginal agnostic booster, the relevant quantity is
still a nontriviality margin controlled by $\gamma_P(s)$. In either case the
missing theorem is a weak-gap uniformization statement:

$$
\forall Q\ \exists r_Q
\quad\Longrightarrow?\quad
\exists r\ \forall Q.
$$

The source definition does not include this quantifier swap.

### Why Full Support Does Not Uniformize Accuracy

The full-support argument is pathwise. If a finite sample transcript can occur
under any marginal, it occurs with positive probability under the chosen
full-support reference marginal $P^\star$. Since the source gives a worst-case
resource polynomial for $P^\star$, the learner cannot take longer on that
transcript.

No analogous pathwise statement exists for error. Accuracy is an average under
the actual marginal. A transcript that has positive but tiny probability under
$P^\star$ may be associated with a region on which $A$ has no useful
correlation; this can be invisible to the global error under $P^\star$. Thus
full support transfers halting bounds, but it does not transfer a weak edge
from $P^\star$ to an arbitrary marginal $Q$.

### The Failed Weak-Gap Diagonal

The tempting diagonal proof is:

1. Suppose no distribution-free weak gap exists.
2. For each exponent $d$, choose a bad marginal $Q_d$, size $s_d$, and
   target behavior whose best guaranteed advantage for $A$ is smaller than
   $s_d^{-d}$.
3. Stitch the $Q_d$ into one marginal and contradict the source guarantee for
   that stitched marginal.

This proof is valid only under a size-indexed marginal semantics where a
marginal is a family $(P_s)_{s\ge 1}$ and the size-$s_d$ evaluation can put
full mass on $Q_d$. Under the current atlas semantics, a marginal is one
global distribution over instances. The stitch is necessarily a mixture

$$
P=\sum_d w_d Q_d
$$

with $\sum_d w_d=1$.

The source guarantee for this one $P$ is an additive global-error guarantee.
It can ignore a low-mass component. If a target is difficult only on the
$Q_d$ component and easy or zero elsewhere, then a default hypothesis has
global error at most about $w_d/2$ even if it has error $1/2$ on $Q_d$. For
small $w_d$, this is already far better than a weak guarantee of the form
$1/2-\gamma_P(s_d)$. The bad local gap on $Q_d$ has been multiplied by its
mixture weight before the source guarantee ever sees it.

This is not just a technical defect in the proof. Any countable global mixture
must assign small weights to infinitely many selected bad components, while
the source polynomial for that one mixture is allowed to depend on the entire
weight sequence. The source can have a perfectly respectable
$P$-dependent inverse-polynomial gap while imposing no nontrivial local edge on
the low-mass components that the diagonal wanted to expose.

There is a second, agnostic-specific obstruction. The bad marginals $Q_d$ may
come with different hard target concepts. A global agnostic distribution that
labels each component according to its own $c_d$ need not have a single
low-error comparator in $\mathcal C$. If the stitched labeling is not realized,
the $\operatorname{OPT}_{\mathcal C}$ term can absorb the errors on the
components. If one instead tests one target $c_d$ at a time, the target is
again visible only through its mixture weight $w_d$.

So the diagonal fails twice under global marginals: component mass attenuates
the local error gap, and stitched per-slice labels need not be a low-OPT
agnostic instance for one global comparator.

### Same-Marginal Agnostic Boosting Does Not Dodge The Barrier

The most promising way to avoid booster-generated marginals is to keep the
instance marginal $P$ fixed and encode weights by randomized labels. In
$\{\pm1\}$ notation, set

$$
\mathbb E[Y\mid X=x]=a(x)c(x),\qquad 0\le a(x)\le 1.
$$

The comparator $c$ has correlation $\mathbb E_P a$. The atlas source gives a
useful correlation only above its fixed additive floor:

$$
\operatorname{corr}(h,Y)
\ge
\mathbb E_P a - (1-2\gamma_P(s)).
$$

To simulate a reweighted marginal $Q$ by taking
$a=\lambda\,dQ/dP$, one needs $\lambda>1-2\gamma_P(s)$ just to get a positive
edge. Since $\lambda\le 1/\|dQ/dP\|_\infty$, this only handles density ratios
close to $1$ when $\gamma_P(s)$ is small. It cannot focus on the small
residual regions that strong learning must eventually correct.

Thus same-marginal agnostic boosting may yield a marginal-nonuniform strong
learner with runtime depending on the hidden $\gamma_P$, if the required oracle
conditions are otherwise met. It still does not yield a distribution-free
polynomial strong learner unless weak gaps have already been uniformized.

### Interaction With Properness

The properness of the source is not the blocker for the positive theorem
route. Realizable boosting can aggregate proper weak hypotheses into an
improper final vote, and the target permits improper output. Properness matters
for counterexample construction, because cheap proper handles often become
available to the improper boosted learner as well, but it does not repair the
missing weak-gap envelope.

### Precise Barrier

The theorem route cannot currently be completed because the atlas semantics
provide:

$$
\forall P\ \exists \gamma_P(s)\ge 1/\operatorname{poly}_P(s),
$$

with $P$ a single global marginal, while boosting to the target requires a
uniform polynomial lower bound on the weak edge over the marginals or weighted
label distributions used by the booster. Full-support uniformization changes
the resource quantifier but leaves the accuracy quantifier untouched.

The natural diagonal proof of the missing quantifier swap requires a
size-conditioned evaluation in which each bad slice receives full mass at its
own representation size. The current global-mixture evaluation only gives each
bad slice weight $w_d$, and additive weak error can ignore low-mass slices.
Therefore the theorem route is a conditional theorem under stronger
size-indexed semantics, not an atlas theorem under the current global-marginal
semantics.

### Depth 5 Directions

1. Write the global-mixture no-transfer lemma in a reusable form: for
   $P=\sum_d w_dQ_d$, an additive weak guarantee under $P$ need not imply any
   positive advantage under a component $Q_d$ when $w_d$ is below the target
   weak-gap scale.

2. Separate two possible schema changes. A size-indexed marginal semantics
   would likely make the weak-gap diagonal theorem true. A local-uniformity
   semantics, such as bounded-density or KL-stable envelopes for marginals
   reached by boosting, might be weaker and closer to standard PAC practice.

3. Test whether the sample-only marginal-nonuniform trichotomy can provide any
   computational leverage beyond finite VC dimension. The expected answer is
   no for this edge, because efficient improper ERM may still be hard, but the
   exact handoff point should be documented.

4. Search for an orientation-free weak handle if pursuing a false witness. The
   handle must give a deterministic proper weak edge under every marginal,
   including near-balanced high-scale marginals, without giving an improper
   booster enough reusable handles for strong learning.

5. Track fixed-marginal agnostic boosting theorems with tunable thresholds.
   A theorem that converts the atlas fixed-additive source into a strong
   learner with overhead independent of $\gamma_P$ would be surprising, but it
   is the only same-marginal positive route that would bypass the failed
   diagonal.

### Depth 4 Verdict

The positive theorem route does not settle the edge under the current
global-marginal semantics. Full-support resource uniformization is sound, and
boosting is available once a uniform weak gap is known, but weak-gap
diagonalization is blocked by mixture-weight attenuation and by the lack of a
single low-OPT stitched comparator in the agnostic setting.

The edge should remain `open`. A future `true` verdict needs either a schema
change to size-indexed or locally uniform marginals, or a new theorem that
uniformizes weak gaps without relying on component-to-mixture transfer. A
future `false` verdict needs a source-positive witness with deterministic
orientation-free weak handles; the killed dense PRF-block sparse-handle
construction does not provide one.

## Depth 5 Followup: Finite-Support Theorem and Orientation-Free Handle Audit

- date: 2026-05-05
- purpose: one last substantial pass before depth 6
- constraint: scratchpad-only; no atlas files edited
- tested route: formulate the strongest finite-support/size-conditional theorem
  that actually matches the atlas target, then audit whether a PRF-block
  counterexample can avoid the near-balanced-source failure

### Question Being Tested

Depth 4 left two possible ways forward:

1. A positive theorem might survive if it is stated with an explicit
   finite-support or size-conditioned hypothesis rather than with an implicit
   size-indexed marginal semantics.
2. A false witness might survive if its cheap proper weak handles work under
   every marginal, including near-balanced source marginals, without giving an
   improper learner enough information to learn strongly.

This pass tests both at the level needed to decide whether either should
become the final depth-6 route.

### Correct Finite-Support Theorem

There is a clean theorem, but it is a support-size theorem for the target
itself. It does not use the source node.

**Theorem.** Suppose that for every representation size $s$ there is a known
polynomial $B(s)$ such that every distribution appearing in the
distribution-free realizable target is supported on at most $B(s)$ encoded
instances, and those instances can be stored and compared in polynomial time.
Then every concept class over this domain is efficiently realizably
improperly PAC learnable.

**Learner.** Draw

$$
m =
O\left(
  \frac{B(s)}{\varepsilon}
  \left(\log B(s)+\log\frac{1}{\delta}\right)
\right)
$$

labeled examples. Store the observed label of every sampled point and predict
an arbitrary default label on unseen points.

**Why it works.** Call an atom heavy if its mass is at least
$\varepsilon/B(s)$. There are at most $B(s)$ heavy atoms. With the displayed
sample size, every heavy atom is observed with probability at least
$1-\delta$. The total mass of all light atoms is at most $\varepsilon$.
Since the problem is realizable, the stored labels are consistent with the
target concept. The final hypothesis can therefore err only on unseen light
atoms, whose total mass is at most $\varepsilon$.

This theorem matches the atlas target definition: the learner is improper,
distribution-free over the restricted domain family, and has one polynomial
bound in $s$, $1/\varepsilon$, and $\log(1/\delta)$.

### Why This Does Not Resolve The Edge

The theorem is too strong on the domain side and too weak on the source side.
It proves the target directly whenever the size-$s$ support is uniformly
polynomial. The source assumption is irrelevant.

If the support bound is allowed to depend on the marginal, say $B_P(s)$, the
same memorization proof gives only a marginal-nonuniform strong learner. That
does not match the target, whose polynomial must be independent of $P$.

If the support is finite but superpolynomial, the theorem no longer gives an
efficient target learner. This is exactly where cryptographic examples can
live: a slice of size $N_s=2^s$ can be finite, and a single labeled sample may
give a tiny weak handle of size about $1/N_s$, but memorizing enough of the
slice is not distribution-free polynomial in $s$.

So the only finite-support theorem that cleanly matches the atlas definitions
is a boundary theorem:

$$
\text{uniform polynomial support growth}
\quad\Longrightarrow\quad
\text{efficient realizable improper PAC}.
$$

It does not prove the open edge for general atlas domains, and a
$P$-dependent or merely finite support condition would silently change the
target into a marginal-nonuniform target.

### Counterexample Candidate Revisited

The most plausible false witness remains a cryptographic block construction.

Let the instance space be a disjoint union of slices

$$
X_n = \{n\}\times\{0,1\}^n,
$$

with $N_n=2^n$. For each key $k\in\{0,1\}^n$, include a hard concept
$c_{n,k}$ that behaves like a pseudorandom function on $X_n$ and has a simple
default label off $X_n$. Add cheap proper handles such as constants,
singletons, co-singletons, or bounded-size sample-correction concepts.

The intended target separation is plausible under standard PRF assumptions:
under the uniform marginal on $X_n$, a polynomial-time improper learner cannot
predict $c_{n,k}$ on most unseen points, so it cannot achieve small
realizable error.

The intended source positivity is also tempting:

- If the marginal is concentrated on one hard slice, a labeled point gives a
  proper handle with advantage roughly $1/N_n$.
- Since the marginal itself identifies the hard slice, the gap
  $1/N_n=2^{-n}$ can still be lower-bounded by a $P$-dependent polynomial at
  that one isolated size.
- If a global marginal gives slice $X_n$ tiny mass, a default hypothesis can
  ignore that slice and still have a global weak edge.

This is exactly the shape needed to exploit global-marginal semantics.

### The Remaining Source Failure

The candidate still fails at the source node, for the same reason as the
dense-block sparse-handle attempt but now in a more explicit form: the weak
proper learner must choose the right orientation near balance.

Consider a realizable distribution on one large slice. Let $S$ be the positive
set of the hard concept and let

$$
P(S)=\frac{1}{2}+\eta,
$$

where $0<\eta\ll 1$ and individual atoms have mass about $1/N_n$.

If the learner outputs a positive singleton, its error is approximately

$$
\frac{1}{2}+\eta-\frac{1}{N_n},
$$

which is worse than random whenever $\eta>1/N_n$. If it outputs a
co-singleton based on a negative point, its error is approximately

$$
\frac{1}{2}-\eta-\frac{1}{N_n},
$$

which is a valid weak edge. When $P(S)=1/2-\eta$, the roles reverse.

Thus singletons and co-singletons are not orientation-free. The learner must
determine the sign of $P(S)-1/2$, or otherwise output a handle that works for
both signs.

For any fixed polynomial sample budget $m=s^r$, choose a bias satisfying

$$
\frac{m}{N_n}\ll \eta \ll \frac{1}{\sqrt m}.
$$

This is possible when $N_n=2^n$. With only $m$ samples, the two cases
$P(S)=1/2+\eta$ and $P(S)=1/2-\eta$ are statistically hard to distinguish
with high confidence. But the total mass of all sampled point corrections is
only about $m/N_n$, far smaller than $\eta$. If the learner chooses the wrong
default orientation, its realizable error is above $1/2$, not merely above
$1/2-\gamma_P(s)$.

Adding both orientations to the class does not fix this, because the source
learner must output one proper hypothesis. Randomly choosing an orientation
gives only constant success probability. Validating the sign to accuracy
about $1/N_n$ would require superpolynomial samples on high slices. Under the
atlas worst-case transcript convention, a learner cannot hide such a branch
behind a rare event: a full-support marginal gives every finite transcript
positive probability, so any superpolynomial branch would violate the source
resource requirement for that marginal.

Bounded-size sample-correction concepts have the same defect. They can reduce
the error of the right default by the mass of the corrected sample points, but
they do not remove the need to choose the right default when the true bias is
between the correction mass scale and the sampling-resolution scale.

### Why Agnostic Properness Makes This Harder

The previous paragraph used realizable labels, so it is already enough to
block the source. The agnostic requirement is stricter.

In correlation form, the source must return a proper $h$ satisfying

$$
\operatorname{corr}(h,Y)
\ge
\sup_{c\in\mathcal C}\operatorname{corr}(c,Y)-1+2\gamma_P(s).
$$

When the best comparator is almost perfectly correlated with the labels and
has mass $1/2+\eta$, the same orientation problem appears. A wrong default has
negative or zero useful edge even though a correctly oriented sparse
correction would have a positive edge. Since the labels are arbitrary in the
agnostic source, the learner cannot assume that empirical balance is produced
by a clean PRF target; it must succeed for every conditional label rule with
the same marginal.

This means a valid false witness needs a deterministic, efficiently findable,
proper handle whose weak advantage is genuinely orientation-free under every
near-balanced marginal. I do not currently know such a handle. Every cheap
handle found in this search either:

- needs a default orientation that must be estimated too accurately;
- becomes a reusable correction that an improper booster can aggregate; or
- relies on hard structure, in which case the weak source itself becomes
  cryptographically hard.

### Depth 5 Verdict

The finite-support route yields a correct conditional theorem only under a
uniform polynomial support bound, and then the target follows by memorization
without using the source. It is not an atlas proof of the edge.

The PRF-block counterexample route still does not produce a source-positive
witness. The target lower bound is plausible, but the proper weak agnostic
source fails on near-balanced high-slice marginals unless one supplies an
orientation-free handle. Singletons, co-singletons, and finite
sample-correction handles are not enough.

The edge should remain `open` after depth 5. My confidence in the open verdict
is now slightly higher: the positive theorem route appears to require an
explicit semantic strengthening, while the most plausible false route still
breaks before satisfying the source.

### Depth 6 Final-Pass Instructions

Depth 6 should be a final classification pass, not another broad search.

1. For a `true` verdict, accept only one of the following:
   - a theorem that derives a distribution-free inverse-polynomial weak gap
     from the current global-marginal source quantifiers, while explicitly
     overcoming mixture-weight attenuation and the agnostic stitched-comparator
     problem; or
   - an intentional schema change to size-indexed or locally uniform marginals,
     clearly marked as not the current atlas semantics.

2. For a `false` verdict, require a fully specified class and learner. The
   source proof must include a high-probability proper weak agnostic guarantee
   for every marginal and every conditional label rule, with one uniform
   algorithm and pathwise polynomial runtime. In particular, it must show how
   the learner handles marginals with $P(S)=1/2\pm\eta$ when
   $m/N_s\ll\eta\ll1/\sqrt m$.

3. If pursuing the cryptographic block route, separate the proof obligations:
   - prove source positivity first, without invoking PRF security;
   - then prove target hardness under a standard PRF assumption for the same
     class and representation;
   - finally check that every proper handle used by the source is also
     available to the target learner, and explain why aggregation of those
     handles still cannot learn strongly.

4. If none of those obligations is met, keep the atlas edge open. The final
   atlas-facing diagnosis should be: full-support marginal uniformization
   controls one-call resources, but no known theorem uniformizes the
   marginal-dependent weak gaps, and no known source-positive counterexample
   avoids the near-balanced orientation barrier.

## Depth 6 Final Followup: Current-Semantics Exhaustion

- date: 2026-05-05
- depth: 6, final allowed pass
- constraint: scratchpad-only; no atlas files edited
- verdict: unresolved-open
- confidence: 0.94

### Sources Rechecked

This pass rechecked the local definition, edge, and argument notes for the
source node, target node, `full-support-marginal-uniformization`,
`marginal-uniformization-open`, `marginal-boosting-open`,
`agnostic-boosting-open`, and `realizable-boosting`.

Primary-source pages rechecked online:

- Hanneke, Moran, and Thiessen 2025/2026, `Marginal-Nonuniform PAC
  Learnability`: the marginal-nonuniform constants/rates may depend on the
  marginal, and the main trichotomy is information-theoretic rather than a
  representation-sensitive computational uniformization theorem.
- Feldman 2010, `Distribution-Specific Agnostic Boosting`: the important
  same-marginal route changes labels rather than the instance distribution,
  but it still uses a quantitative weak-oracle margin.
- Ghai and Singh 2025 and da Cunha, Hogsgaard, and Paudice 2026: modern
  agnostic boosting improves sample and runtime tradeoffs for suitable weak
  oracle formulations, but the checked statements do not convert the atlas
  hidden marginal-dependent gap into one distribution-free inverse-polynomial
  gap.

### Final Acceptance Gates

I applied the depth-5 gates literally.

For a `true` verdict, it is not enough to say that standard boosting converts
weak realizable learning to strong realizable learning. The proof must first
derive, under the current global-marginal atlas semantics,

$$
\exists r\ \forall P\quad \gamma_P(s)\ge s^{-r}
$$

or at least such a bound for all booster-relevant marginals, with $r$
independent of $P$.

For a `false` verdict, it is not enough to have a cryptographically hard
strong target. The witness must include one uniform proper weak agnostic
source learner that works for every marginal and every conditional label rule,
with pathwise polynomial resources and high-probability output of a single
proper hypothesis.

Neither gate is met.

### Final True-Route Audit

Let $A$ be the source learner. The full-support argument gives a real gain:
under the atlas worst-case finite-transcript convention, applying the source
to a full-support reference marginal $P^\star$ yields one polynomial resource
bound for one call to $A$. Thus the edge is no longer blocked mainly by the
runtime polynomial $p_P$.

On realizable labels from a target $c\in\mathcal C$, however, the source only
gives

$$
\operatorname{err}_P(A,c)\le \frac12-\gamma_P(s),
$$

where the inverse-polynomial lower bound on $\gamma_P$ may depend on $P$.
Realizable boosting then has round and sample overhead depending
polynomially on $1/\gamma_P(s)$. This proves at most a marginal-nonuniform
strong learner unless the gaps have one distribution-free lower envelope.

The natural diagonal proof still fails. If one chooses bad marginals
$P_k$ and sizes $s_k$ with $\gamma_{P_k}(s_k)<s_k^{-k}$, a global mixture
$P=\sum_k w_kP_k$ need not inherit those bad weak requirements on the
components. A weak additive guarantee on $P$ can ignore sufficiently low-mass
components, and in the agnostic version there is no single stitched
comparator in $\mathcal C$ that simultaneously witnesses low `OPT` on all
components. This is the mixture-weight attenuation and stitched-comparator
obstruction from depth 4, and depth 6 did not remove it.

The finite-support theorem from depth 5 is correct but orthogonal. Uniform
polynomial support growth gives the target directly by memorization. Merely
finite or $P$-dependent support gives only a marginal-nonuniform target. The
Hanneke-Moran-Thiessen sample-rate trichotomy similarly explains why the
sample-only analogue can collapse to a distribution-free sample guarantee,
but it does not produce a polynomial-time improper learner for arbitrary
representations.

### Final False-Route Audit

The only plausible false route found across the passes is a hard-slice or
PRF-block construction: make strong prediction on a large slice
cryptographically hard, but add cheap proper handles so every marginal has a
weak edge. The target hardness side remains plausible under standard PRF
assumptions. The source side still fails before cryptography is needed.

Fix a high-scale slice of size $N_s$ and a realizable target whose positive
set is $S$. Consider two marginals with

$$
P_+(S)=\frac12+\eta,\qquad P_-(S)=\frac12-\eta.
$$

By full-support resource uniformization, any source learner has some fixed
polynomial sample budget $m=s^r$ on finite transcripts. Choose

$$
\frac{m}{N_s}\ll \eta\ll \frac{1}{\sqrt m}.
$$

The empirical data cannot reliably distinguish the sign of the bias, while
the total correction mass contributed by observed singleton or finite-sample
handles is only about $m/N_s$, far smaller than the bias. A learner that
chooses the wrong default orientation has error at least $1/2$ on one of
$P_+$ or $P_-$. Randomizing the orientation does not give the required
high-probability proper output. Adding both orientations to the class also
does not help, because the source learner must output one of them.

This obstruction already lives in the realizable subcase, so the agnostic
proper source only strengthens the failure. A valid false witness would need
a deterministic, efficiently findable, orientation-free proper handle whose
weak advantage survives every near-balanced marginal and every conditional
label rule. Every handle found in this search falls into one of three buckets:
it needs an orientation estimate that costs too much, it is reusable by an
improper booster, or it encodes hard structure and thereby destroys the weak
source property.

### Atlas-Ready Obstacle Summary

The edge should remain `open`.

The sharp obstruction is not one-call resource uniformization. Under the
current atlas pathwise resource convention, a full-support reference marginal
uniformizes the runtime and sample use of a single call to the uniform source
learner. The unresolved issue is weak-gap uniformization: the source gives a
separate inverse-polynomial weak advantage for each marginal, while the
distribution-free strong target would need boosting overhead bounded by one
polynomial independent of the marginal.

Known positive tools do not close this gap. Standard realizable boosting and
same-marginal agnostic boosting depend quantitatively on the weak advantage.
The finite-support memorization theorem proves the target only under uniform
polynomial support growth, and the sample-only marginal-nonuniform trichotomy
does not address representation-sensitive polynomial time.

Known negative templates do not close the edge either. PRF or hard-slice
templates can plausibly refute the strong target, but the added cheap proper
handles fail the source on near-balanced high-slice marginals unless one
solves the orientation problem. No source-positive, target-negative witness
was found.

### Recommended Edge-Note Update

Suggested frontmatter replacement for the existing open note:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - schapire1990
  - freund1995boosting
  - feldman2010distributionspecific
  - ghai2025agnosticboosting
  - dacunha2026agnosticboosting
  - benedek1991fixed
  - bendavid1995parameterization
  - hanneke2025marginalnonuniform
refs:
  - "[Schapire 1990](https://doi.org/10.1023/A:1022648800760)"
  - "[Freund 1995](https://doi.org/10.1006/inco.1995.1136)"
  - "[Feldman 2010](https://arxiv.org/abs/0909.2927)"
  - "[Ghai and Singh 2025](https://proceedings.mlr.press/v267/ghai25a.html)"
  - "[da Cunha et al. 2026](https://arxiv.org/abs/2601.11265)"
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
  - "[Ben-David et al. 1995](https://doi.org/10.1006/inco.1995.1094)"
  - "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
summary: "Open: full-support uniformization controls the resources for one weak call, but the source gives only marginal-dependent weak advantages; no known theorem boosts those hidden gaps to a distribution-free strong realizable improper learner."
family: marginal-boosting-open
argument_note: "[[marginal-boosting-open|Marginal-Nonuniform Boosting Open]]"
```

Suggested body replacement:

```markdown
## Verdict

`open`.

Full-support marginal uniformization controls the resources for one call to
the source learner, but the source still gives only marginal-dependent weak
advantages. No known theorem converts those hidden gaps into a
distribution-free strong realizable improper learner.

## Proof Status

**Goal.** Decide whether an efficient marginal-nonuniform weak agnostic proper
learner must imply an efficient distribution-free strong realizable improper
learner.

**Resource bookkeeping.** Let `A` be the single learner promised by the source.
Under the atlas worst-case finite-transcript convention, applying the source
to a full-support reference marginal yields one polynomial bound on the
sample use and runtime of a single call to `A`. Accuracy is still evaluated
under the actual marginal.

**Weak-gap obstruction.** On realizable labels, `A` is a proper weak learner
with advantage `gamma_P(s)` under the actual marginal `P`. Standard
realizable boosting would produce an improper strong learner if the
advantages over the relevant marginals had one distribution-free
inverse-polynomial lower bound. The source only gives a separate lower bound
for each marginal. Same-marginal agnostic boosting avoids changing the
instance marginal, but its quantitative guarantees still depend on the weak
margin available for that marginal.

**Failed counterexample route.** Hard-slice and PRF-block templates can make
the strong improper target plausibly hard, but they have not supplied the
source. Cheap proper handles such as constants, singletons, co-singletons, or
finite sample-correction concepts fail on near-balanced high-slice marginals:
the learner must choose the correct default orientation, and the sign of the
bias can be statistically invisible at any fixed polynomial sample budget.

**Conclusion.** The edge remains open. A proof would need a weak-gap
uniformization theorem under the current global-marginal semantics; a
counterexample would need a source-positive, target-negative class with
orientation-free proper weak handles.
```

## Final

verdict: unresolved-open
confidence: 0.94
changed_path: `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-realizable-improper-pac/scratchpad.md`
