# Edge: efficient-weak-agnostic-improper-pac -> efficient-marginal-nonuniform-weak-agnostic-proper-pac

- depth: 1
- date: 2026-05-05
- edge_file: `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- source: `efficient-weak-agnostic-improper-pac`
- target: `efficient-marginal-nonuniform-weak-agnostic-proper-pac`
- family: `properization-open`

## Bottom Line

I do not resolve the edge. My recommendation is to keep it `open`.

The source already gives a distribution-free polynomial-time weak agnostic predictor, but it may output an arbitrary hypothesis outside $\mathcal C$. The target relaxes the distribution quantifier to marginal-nonuniform and stays weak agnostic, but it requires the output to be a valid concept in $\mathcal C$.

Thus the issue is not sample complexity and not ordinary marginal resource bookkeeping. It is fixed-marginal weak properization:

$$
\text{good external weak predictor}
\quad\Longrightarrow?\quad
\text{efficiently find a weakly good } c\in\mathcal C.
$$

I found no generic theorem giving this projection, and the known proper-hardness witnesses still miss the marginal-nonuniform weak target.

## Definitions Used

The source note `atlas/definitions/efficient-weak-agnostic-improper-pac.md` uses the additive weak agnostic guarantee. There is one distribution-free learner and some fixed $\beta<1/2$ such that, for every joint distribution $\mathcal D$,

$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta,
$$

with polynomial sample and time bounds. The output may be outside $\mathcal C$.

The target note `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md` asks for one uniform learner outputting $h\in\mathcal C$. For every instance marginal $P$, there may be a $P$-dependent polynomial $p_P$ and a $P$-dependent weak tolerance

$$
\beta_P(s)=1/2-\gamma_P(s)<1/2,
$$

where $\gamma_P$ is inverse-polynomial in the representation-size parameter under a marginal-dependent polynomial. The learner is not given $P$-specific advice.

The edge note currently says `open`, with summary:

> Open: this asks for properization from an improper marginal-nonuniform learner.

That summary is directionally right. For this specific edge it can be sharpened: the source is stronger than a marginal-nonuniform improper weak learner in its resource bound, but it is still improper.

## Sources Checked

Local atlas files:

- `AGENTS.md`
- `atlas/README.md`
- `atlas/definitions/efficient-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-agnostic-improper-pac.md`
- `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/arguments/clause-satisfaction-proper-hardness.md`
- `atlas/arguments/fixed-k-term-dnf-proper-boosting-separation.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/marginal-agnostic-hardness-open.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- `atlas/witnesses/clause-satisfaction-lookup-class.md`
- `atlas/witnesses/fixed-k-term-DNF.md`
- `atlas/witnesses/halfspaces.md`
- `references.bib`
- sibling scratchpads from 2026-05-04 and 2026-05-05 for the marginal weak properization and stronger-source variants.

External primary/source pages checked:

- Hanneke, Moran, and Thiessen, *Marginal-Nonuniform PAC Learnability*, OpenReview page last modified 2026-04-21: https://openreview.net/forum?id=aoVCFtox89. Relevant point: marginal-nonuniform guarantees may depend on the marginal distribution, but hold uniformly over all concepts for that marginal.
- Håstad and Khot, *Query Efficient PCPs with Perfect Completeness*, Theory of Computing page: https://theoryofcomputing.org/articles/v001a007/. Relevant point: logarithmic randomness, perfect completeness, and soundness below $1/2$ are available.
- Khot and Saket, *Hardness of Minimizing and Learning DNF Expressions*, author PDF: https://cs.nyu.edu/~khot/papers/minDNF.pdf. Relevant point: constant-advantage hardness for proper weak learning of small DNF variants is a real phenomenon, but it is hypothesis-class-specific and not a marginal-nonuniform properization theorem.
- Ben-David, Long, and Mansour, *Agnostic Boosting*, DOI / author-uploaded abstract pages. Relevant point: the classical weak agnostic notion is $\operatorname{err}\le \operatorname{OPT}+\beta$.
- Diakonikolas, Kane, Kontonis, Tzamos, and Zarifis, *Agnostic Proper Learning of Halfspaces under Gaussian Marginals*, arXiv: https://arxiv.org/abs/2102.05629. Relevant point: class-specific properization under Gaussian marginals exists for halfspaces, but uses special structure.
- Tiegel, *Hardness of Agnostically Learning Halfspaces from Worst-Case Lattice Problems*, arXiv: https://arxiv.org/abs/2207.14030. Relevant point: halfspaces do not supply a source-positive separation here because the result rules out even improper agnostic learning in the relevant regimes.

## Positive Route

### Goal

Prove that an efficient distribution-free weak agnostic improper learner $A$ can be converted to a marginal-nonuniform weak agnostic proper learner $B$.

### What The Source Gives

For every fixed marginal $P$ and every conditional label rule, $A$ already gives a polynomial-time external predictor satisfying

$$
\operatorname{err}_{\mathcal D}(g)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\beta,
$$

with one distribution-free polynomial bound. Since the target is marginal-nonuniform and weak, the resource side of the source is more than enough. If improper outputs were legal, the edge would be true by a monotone relaxation.

### Missing Step

The missing step is a proper selector. From samples, or from samples plus an external predictor $g$, we would need to output a valid concept $c\in\mathcal C$ with

$$
\operatorname{err}_{\mathcal D}(c)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+1/2-\gamma_P(s)
$$

for some inverse-polynomial $\gamma_P$.

Finite VC or fixed-marginal uniform convergence gives statistical existence of good proper hypotheses. It does not give polynomial-time proper ERM, an efficiently searchable $L_1(P)$ cover by valid concepts, or a projection oracle from $g$ into $\mathcal C$.

Marginal-nonuniformity also does not give advice. It lets the analysis use a $P$-dependent polynomial for one fixed uniform learner; it does not give the learner a $P$-specific enumeration of useful traces, a support decomposition, or a concept-search procedure.

### Boosting Is Not Enough

Agnostic boosting is a near miss. Boosting an improper weak learner usually returns an aggregate or randomized predictor outside the original class. Even if the atlas fixed-additive weak agnostic guarantee could be boosted efficiently under the same marginal, the final predictor would not be a proper member of $\mathcal C$.

Class-specific positive results, such as proper agnostic halfspace learning under Gaussian marginals, support a different statement: with enough geometry, an improper-looking object can sometimes be compressed to a proper hypothesis. They do not imply a representation-independent properization theorem.

### Conditional Positive Statement

The following restricted theorem would be valid but is not implied by the source:

> If every fixed marginal $P$ admits a uniform polynomial-time weak proper selector for $\mathcal C$ from samples and optional evaluation access to a good external predictor, then the source learner followed by that selector gives the target.

This isolates the missing structure rather than resolving the edge.

## Negative Route

A false witness must satisfy two conditions at once:

1. Efficient distribution-free weak agnostic improper learning.
2. Failure of efficient marginal-nonuniform weak agnostic proper learning for some fixed marginal $P$.

The first condition is quite strong: the class must be easy enough for one uniform improper weak learner over all labeled distributions. The second condition is also strong: the hard marginal cannot vary with the NP instance or cryptographic challenge, because the target's polynomial may depend on that marginal.

### PCP Active Slice

The PCP active-slice lookup class resolves the distribution-free weak properization sibling. It is agnostically learnable by an improper one-slice lookup-table ERM. If a weak proper learner worked under the active-slice marginal for an input instance $\varphi$, it would find a proof accepted on more than half the PCP random strings, contradicting $\mathrm{NP}\nsubseteq\mathrm{RP}$.

This does not refute the assigned edge. The hard marginal is $P_\varphi$, uniform on the active slice of the input instance. A marginal-nonuniform target learner may have a polynomial $p_{P_\varphi}$ depending on this very slice. A reduction from $\varphi$ to a uniform polynomial-time SAT algorithm cannot control that hidden dependence.

Packing all active slices into one fixed marginal loses the weak gap. If slice $\varphi$ has mass $w_\varphi$, the local PCP acceptance gap is multiplied by $w_\varphi$. Since the target only promises a hidden inverse-polynomial advantage $\gamma_P(s)$, a low-mass hard slice can be ignored while still satisfying the global weak guarantee. For a weak additive tolerance close to $1/2$, inverse-polynomial slice mass is not automatically enough; one needs the hard part to have mass comparable to the hidden weak advantage, and one fixed marginal cannot give constant mass to exponentially many isolated input slices.

Shared-randomness PCP variants also run into wrong-instance handles. If examples are just verifier random strings and a proper hypothesis carries an instance-proof pair $(\psi,\pi)$, then unrelated satisfiable instances can produce high-acceptance or all-one hypotheses on the shared domain. Adding an active-instance coordinate removes those handles but recreates the input-dependent marginal.

### Clause-Satisfaction Lookup

The clause-satisfaction lookup class is a strong improper source and gives fixed-marginal hardness for strong agnostic proper learning: use the uniform marginal over all clauses and encode the input formula in the conditional labels.

This is a strong-accuracy separation, not a weak one. Under the uniform clause marginal, one violated input clause changes total error by about $1/|X_n|$. A proper learner run to accuracy much smaller than that must find a satisfying assignment. The assigned target cannot request such an $\varepsilon$; it allows nearly $1/2$ additive excess. Low-noise padding preserves the fixed marginal but does not make every relevant violated clause cost constant mass.

### One-Way Image Coordinate

The one-way image-coordinate class gives fixed-marginal strong proper hardness. With accuracy $\varepsilon_n=\mu_n/(3n)$ under the coordinate marginal, a proper learner must recover a seed whose image matches the one-way challenge.

The weak target does not ask for that accuracy. Under the all-length marginal, the length-$n$ hard block has mass $\mu_n=O(1/n^2)$. A weak learner can often ignore that block, use a wrong-length seed, or use added weak handles. The atlas weak-handle variant makes this explicit: constants and singleton concepts give weak proper learning while strong recovery remains hard.

### Shared-Code And PRG Attempts

The natural repair is to put all hard instances on one shared high-mass coordinate domain. A seed or witness $z$ defines a codeword $C_z\in\{\pm1\}^{N(s)}$. The improper learner uses lookup-table ERM on the explicit coordinates, while a weak proper learner returning any $t$ with

$$
\mathbb E_i[C_t(i)C_z(i)]\ge 2\gamma_P(s)
$$

would ideally reveal the hard witness.

This route runs into the hidden weak-gap problem. For exponentially many proper codewords on $N=\operatorname{poly}(s)$ binary coordinates, exact nonpositive correlation for all wrong codewords is blocked by Plotkin/Hadamard-type bounds. Approximate codes leave residual inverse-polynomial correlations. But the target learner's guaranteed advantage may be an even smaller inverse polynomial, so a wrong weakly correlated concept can remain a legal output.

Hadamard-style exact orthogonality solves the geometry at one length, but the coordinate domain is exponential. Then the easy improper lookup ERM is no longer polynomial in the natural representation size, or the source becomes an agnostic parity/correlation-search problem rather than an easy improper learner.

Cryptographic PRG language does not remove the issue. A PRF-like family tends to make even improper weak prediction hard unless the domain is polynomially enumerable; if the domain is polynomially enumerable, random/wrong-code correlations at some inverse-polynomial scale are hard to rule out for the atlas hidden-gap target.

### Halfspaces

Halfspaces are not a separation for this edge. Tiegel's hardness is source-negative here: it rules out even improper agnostic learning under the relevant assumptions. On the other side, Gaussian halfspace properization is positive but class-specific.

## Why The Stronger-Source Sibling Does Not Settle This

The sibling edge

```text
efficient-agnostic-improper-pac
->
efficient-marginal-nonuniform-weak-agnostic-proper-pac
```

is already open in the current scratchpads and atlas notes. Since that source is stronger than the assigned source, its unresolved status does not imply anything formal here.

However, its obstacles transfer directly. If even strong agnostic improper prediction has no known generic projection to a marginal-nonuniform weak proper concept, then the assigned weak source has the same properness obstruction plus less accuracy. Conversely, all false-witness attempts that satisfy the stronger source, such as clause lookup or PCP one-slice lookup, still fail at the fixed-marginal weak target for the same reasons above.

## Proposed Atlas Changes

No resolved atlas edit is justified.

If refreshing the edge note, I would keep:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
argument_note: "[[properization-open|Properization Open]]"
```

Suggested summary:

```text
Open: the source gives a distribution-free weak agnostic improper predictor, but no efficient fixed-marginal projection to even a weak proper concept is known; current PCP, clause, DNF, halfspace, and one-way/code witnesses either vary the hard marginal, require strong accuracy, fail the source, or leave weak proper handles.
```

Suggested body sketch:

```markdown
The edge reduces to fixed-marginal weak properization. The source learner already has a distribution-free polynomial resource bound and supplies the target's prediction guarantee if improper outputs are allowed. The unresolved step is selecting a valid concept in $\mathcal C$.

Known proper-hardness witnesses remain near misses. PCP active-slice hardness refutes distribution-free weak properization, but the hard marginal names the input instance; a marginal-nonuniform learner may hide instance-specific search cost in $p_{P_\varphi}$. Packing slices into one fixed marginal dilutes the local weak gap. Clause-satisfaction fixed-marginal hardness gives strong-accuracy gaps, not weak ones. One-way coordinate witnesses force proper recovery only at requested strong accuracy or admit weak handles. Shared-code repairs over polynomial coordinate domains leave inverse-polynomial wrong-code correlations, while exact Hadamard-style safety breaks the easy improper agnostic source.
```

## Depth-2 Directions

1. **Computational weak-handle hardness.** Build a fixed-marginal class where weakly correlated proper handles exist information-theoretically, but finding any legal handle decodes an NP witness or inverts a one-way function. This avoids needing exact code orthogonality, but needs a real hardness assumption matched to "find any inverse-polynomial correlation."

2. **Identity-protected shared PCP.** Search for a universal PCP or agreement-test domain where the input instance changes labels on a constant-mass shared marginal, satisfiable instances have proper witnesses, and every weakly correlated proper output identifies the same instance rather than an unrelated satisfiable one.

3. **Formal shared-code no-go.** Turn the Plotkin/Hadamard and list-decoding observations into a reusable lemma: polynomially visible lookup domains cannot make exponentially many wrong proper certificates all weak-safe at every hidden inverse-polynomial scale.

4. **Non-lookup improper relaxations.** Look for a relaxation of Hadamard/image-code concepts that is efficiently weak agnostically learnable under arbitrary distributions, but whose proper subfamily remains hard to search. This is the only path where exact weak-safe geometry and a fixed high-mass marginal might coexist.

5. **Restricted positive theorem.** Prove the implication for classes with efficient fixed-marginal approximate proper ERM, computable $L_1(P)$ covers by valid concepts, trace selectors, or constant-slack projection oracles. That would not resolve the atlas edge globally but would identify exactly what a counterexample must violate.

verdict: unresolved-open
confidence: medium-high

## Depth 3 Branch: weak agnostic improper properization witness search

- date: 2026-05-05
- branch question: can the clause, one-way, or bounded-handle witnesses be made source-positive and target-negative for
  `efficient-weak-agnostic-improper-pac -> efficient-marginal-nonuniform-weak-agnostic-proper-pac`?
- constraint: scratchpad-only; no atlas files edited

### Counterexample Target

A false witness for this edge must satisfy two requirements simultaneously.

First, it must be source-positive: there is one distribution-free polynomial-time learner which, for every labeled distribution $\mathcal D$, outputs an arbitrary hypothesis $h\notin\mathcal C$ if needed and achieves

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\beta
$$

for a fixed $\beta<1/2$.

Second, it must be target-negative: for some fixed instance marginal $P$, no polynomial-time learner outputting $c\in\mathcal C$ can guarantee

$$
\operatorname{err}_{\mathcal D}(c)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+1/2-\gamma_P(s)
$$

for any inverse-polynomial marginal weak gap $\gamma_P$. In a realizable reduction this means that any proper concept with even inverse-polynomial advantage over random guessing should decode the hard witness. Strong proper recovery is not enough.

### Clause-Satisfaction Lookup

The clause-satisfaction lookup class is source-positive in the stronger agnostic improper sense when the example domain is the polynomial-size universe of clauses. An improper lookup-table ERM over the clause domain competes with every assignment concept, so the weak agnostic source is not the problem.

The target-negative side breaks at the weak threshold. The fixed-marginal clause reduction works for strong agnostic proper learning by using the uniform marginal over all clauses and encoding the formula in the labels. A proper learner with accuracy below the mass of one clause would identify a satisfying assignment or distinguish a PCP gap.

For the present target, the learner is allowed nearly $1/2$ additive excess. If the hard formula occupies only a fraction $q$ of the fixed clause universe, then every formula-satisfaction gap is multiplied by $q$. A weak target can ignore the formula part unless $q$ dominates the hidden $\gamma_P(s)$. Making $q$ large by moving to the active formula clauses changes the marginal with the formula, which marginal nonuniformity can absorb. Packing many active formula slices into one fixed marginal repeats the dilution problem: each slice receives mass $w_\varphi$, and the local PCP soundness gap becomes only $w_\varphi$ globally.

Plain 3-SAT clauses also do not give the right weak soundness. Unsatisfiable formulas can still have assignments satisfying well over half their clauses. PCP soundness can push the satisfiable-vs-unsatisfiable gap below $1/2$, but the known active-slice version then names the input instance in the marginal. Removing that identity allows unrelated satisfiable instances or high-agreement assignments to become weak proper handles on the shared clause domain.

Conclusion for clauses: source-positive yes, target-negative no. The obstacle is not the weak improper learner; it is forcing every weakly good proper assignment under one fixed marginal to solve the encoded instance.

### One-Way Image Coordinates

The one-way image-coordinate class is also source-positive, in fact for stronger agnostic improper learning. Sparse lookup ERM over at most $n$ positive coordinate atoms contains all length-$n$ seed concepts and is polynomial on samples.

The standard lower bound is strong-accuracy proper recovery. Under the fixed all-length marginal with block masses $\mu_n$, requesting error at most $\mu_n/(3n)$ forces a proper seed $t$ with $f(t)=f(s)$. The weak target never requests that accuracy. On the all-length marginal, a wrong-length seed can have error about $\mu_n/2+\mu_k/2$ against a length-$n$ target, which is already far below $1/2$ for large hard blocks. Such an output is weakly legal and need not invert anything.

Concentrating the marginal on one length removes the wrong-length escape, but then weak proper learning only asks for a seed whose image has inverse-polynomial correlation with the challenge image. Ordinary one-wayness rules out exact preimage recovery, not every nontrivially correlated image. A random or wrong seed may have residual correlation on the polynomial coordinate domain, and the marginal target's hidden $\gamma_P$ may be smaller than that residual.

The natural repair is Hadamard or error-correcting geometry: arrange that every wrong proper seed has exactly zero or negligible correlation, so any weak advantage identifies the hard seed. This is the sharp boundary. Exact Hadamard orthogonality uses an exponential coordinate domain, making the improper lookup/sparse-ERM source non-polynomial or turning the source into an agnostic parity-like problem. Polynomial coordinate sets leave inverse-polynomial residual correlations, which are too large for an unknown marginal weak gap.

Conclusion for one-way coordinates: source-positive yes, target-negative only for strong accuracy. Current one-way/image-code geometry does not rule out weak proper junk outputs under a fixed marginal.

### Bounded-Handle Variants

Bounded handles move in the wrong direction for this edge. In the atlas weak-handle class, constants and bounded positive-atom subset concepts are added to $\mathcal C$. They make weak proper learning easy: if a seed target has positive mass $M$, then constants cover the very biased cases, and a handle on a heavy bounded subset of positive atoms gives a fixed weak improvement in the balanced cases. Thus the construction is source-positive but target-positive.

One could try to use handles only as improper outputs, leaving them outside $\mathcal C$. That is legal for the source, but it does not by itself make the target hard. For the sparse one-way coordinate class, external handles help the already-easy improper learner while the proper target still has wrong-length or weak-correlation escapes. For a dense balanced code where every weak proper correlation would decode the witness, external bounded handles would need to correct a constant fraction of the mass to get a fixed $\beta<1/2$ realizable guarantee. If the coordinate domain is polynomial, those handles usually give visible weak correlations or searchable structure; if the coordinate domain is exponential, the source learner cannot find enough mass in polynomial time.

There is also an agnostic issue. The source must compete with $\operatorname{OPT}_{\mathcal C}$ for every conditional label rule, not just clean seed targets. A sample-found handle proof has to work when the best proper concept has error just below $1/2$ and the relevant positive/negative orientation is hard to estimate from the available sample. If the handles are made robust and efficiently selectable for all such distributions, they tend to become legal weak proper outputs once included in $\mathcal C$; if they are hidden enough to block the target, the source proof fails.

Conclusion for bounded handles: as proper concepts they destroy the desired target lower bound; as purely improper helpers they do not solve the weak-safe code problem.

### Current Diagnosis

The source strength is helpful but not decisive. Clause and one-way witnesses can be made source-positive because improper lookup or sparse ERM can compete with the concept class. The target, however, is weak and marginal-nonuniform. To refute it, a fixed marginal must make every inverse-polynomially good proper output decode the hard instance. The known witnesses only force exact or strong-accuracy recovery, or else they leak weak proper handles.

The missing object is a source-positive, weak-safe proper code:

1. improper weak agnostic learning is polynomial for every distribution;
2. under one fixed marginal, every proper concept with error below $1/2-1/\operatorname{poly}(s)$ decodes the hard witness;
3. the proof is stable against the target's hidden marginal-dependent weak gap;
4. cheap handles used by the source are not also valid target outputs.

No clause, one-way coordinate, or bounded-handle construction checked here satisfies all four.

verdict: unresolved-open; no source-positive and target-negative clause/one-way/bounded-handle witness found.

confidence: 0.87

next branches:

1. Formalize a weak-safe-code necessary condition: under fixed $P$, every $c\in\mathcal C$ with correlation at least $1/\operatorname{poly}(s)$ with the hard labeling must decode the witness. Then check which known proper-hardness witnesses fail it quantitatively.
2. Search for a polynomial-domain code family with negligible correlations against all nondecoding proper hypotheses while preserving polynomial-time improper weak agnostic ERM.
3. Explore an external-improper-handle construction where the source can find a constant-mass weak correction but the corresponding handles are not in $\mathcal C$; the key test is whether the realizable and agnostic near-balanced orientation cases can be handled without giving the target a weak proper concept.

---

# Depth-4 Follow-Up: Candidate Selectors And Hard Weak Handles

- depth: 4
- date: 2026-05-05
- edge_file: `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- verdict: unresolved-open
- confidence: high that black-box improper access does not by itself give a selector; medium-high that the known proper-hardness templates still fail the marginal-nonuniform weak target
- write scope: this scratchpad only; no atlas files edited

## Focus

This pass pushed on the specific properization question:

$$
\text{weak agnostic improper predictor}
\quad\Longrightarrow?\quad
\text{short proper candidate list or proper selector}.
$$

It also asked whether a proper-hardness class can remain source-positive for
`efficient-weak-agnostic-improper-pac`: easy weak agnostic prediction by
external hypotheses, but hard weak proper search under one fixed marginal.

I do not resolve the edge. The best current statement is still that the edge is
a real open properization problem. The positive route lacks a selector theorem;
the negative route lacks a fixed-marginal weak-hard class whose improper
learner is robustly agnostic.

## Positive Route: Why Improper Access Does Not Produce A Proper List

Suppose $A$ is the source learner. For every joint distribution $\mathcal D$ it
outputs some external $g$ with

$$
\operatorname{err}_{\mathcal D}(g)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\beta,
\qquad \beta<1/2.
$$

The target needs a uniform algorithm which, for each fixed marginal $P$, finds a
proper $c\in\mathcal C$ with error at most
$\operatorname{OPT}_{\mathcal C}+1/2-\gamma_P(s)$ for an inverse-polynomial
hidden gap $\gamma_P$.

The first attempted selector is validation over a candidate list produced by
rerunning $A$. This fails at the first step: $A$ produces predictors, not names
of concepts. Even if several runs on bootstrap samples or relabeled samples
produce many good external predictors, holdout validation can only choose among
those external predictors. It cannot validate a proper concept that was never
generated.

The second attempted selector is "project $g$ to a nearby concept." The source
guarantee gives no nearness. In the realizable case, $g$ may have error
$\beta=0.49$ under a balanced marginal and can be far from every canonical
representation of the target. In the agnostic case, $g$ may exploit structure
outside $\mathcal C$ and need not identify any near-optimal concept. A
projection oracle from arbitrary predictors to weakly good proper concepts is
exactly extra representation-level structure, not a consequence of the source
node.

The third attempted selector is to boost first. On realizable labels,
distribution-free weak improper learning can be boosted to a strong improper
predictor. But strong external prediction still does not recover a proper
representation. It gives approximate membership information under $P$, and
proper learning from approximate membership information is precisely the hard
search problem in PCP and cryptographic witnesses.

The fourth attempted selector is fixed-marginal finite-trace enumeration. Since
the target is marginal-nonuniform, perhaps for each $P$ a large enough finite
trace captures the relevant behavior. This is only a sample-complexity
observation. The learner is not given $P$-specific advice, and the atlas
computational convention uses pathwise polynomial time on finite encoded sample
transcripts. Enumerating all proper concepts or all traces consistent with a
sample can be NP-hard or worse. Marginal-nonuniformity can change the polynomial
used in the analysis; it does not install a proper ERM oracle.

The PCP active-slice class is the diagnostic example. On the active slice, the
improper lookup table is an excellent external predictor. A selector which
turns that table into a weakly good proper proof would decide the underlying NP
instance. This does not refute the assigned marginal-nonuniform edge, because
the active-slice marginal varies with the input, but it shows why the selector
does not follow black-box from improper prediction.

Conclusion for the positive route: an atlas-ready proof would need an
additional theorem of the form "efficient weak agnostic improper learnability
implies an efficient fixed-marginal weak proper selector." I found no route to
such a theorem from boosting, validation, finite VC theory, or marginal
nonuniformity alone.

## Candidate-List Lemma That Would Suffice

A useful restricted theorem would be:

> For each fixed marginal $P$, suppose there is one uniform procedure $S$ which,
> from samples and optional evaluation access to any predictor $g$ satisfying
> $\operatorname{err}(g)\le\operatorname{OPT}_{\mathcal C}+\beta$, outputs a
> polynomial-size list $L\subseteq\mathcal C$ containing some
> $c$ with
> $\operatorname{err}(c)\le\operatorname{OPT}_{\mathcal C}+1/2-\gamma_P(s)$.
> Then validation over $L$ converts the source learner into the target learner.

This lemma is almost tautological, but it usefully isolates the missing
ingredient. The source learner supplies $g$; concentration supplies validation;
the only nontrivial operation is generating $L\subseteq\mathcal C$.

Known sufficient structures would include efficient approximate proper ERM,
computable $L_1(P)$ covers by valid concepts, an efficient trace selector, or a
projection oracle with constant slack. None of these is implied by the source
definition. In particular, a polynomial-size list of external hypotheses is not
enough; the list must contain valid concepts.

## Negative Route: What A False Witness Must Now Do

A false witness needs four properties at once:

1. **Source-positive.** One distribution-free polynomial-time weak agnostic
   improper learner works for all labeled distributions.
2. **Fixed-marginal hard.** There is one marginal $P^\star$, fixed before the
   hard instance, under which weak proper learning would solve the hard search
   problem.
3. **Hidden-gap safe.** Every proper hypothesis achieving even the unknown
   inverse-polynomial target advantage $\gamma_{P^\star}(s)$ must be useful for
   the reduction.
4. **No legal cheap handles.** The tricks that make the improper learner easy
   must not also be available as proper outputs.

The current witnesses satisfy only subsets of these requirements.

PCP active slices satisfy the source side strongly: one-slice lookup-table ERM
is agnostic and improper. They also give weak proper hardness on the active
slice. They fail the fixed-marginal requirement because the active slice names
the NP instance. Packing slices into a single marginal dilutes the weak gap:
the local PCP soundness gap is multiplied by the slice mass, while the target
may tolerate almost $1/2$ additive excess.

Clause-satisfaction lookup classes also satisfy the source side. A lookup ERM
over the clause universe competes with assignment concepts. They fail the
hidden-gap requirement. The fixed-marginal clause reduction creates
strong-accuracy gaps of order one clause mass; a weak proper learner need not
return an assignment accurate enough to certify satisfiability.

One-way image-coordinate classes satisfy the source side via sparse lookup ERM
and give fixed-marginal strong proper hardness. They fail at the weak scale:
wrong lengths, sparse overlaps, constants, singleton handles, or residual
codeword correlations can give weak proper advantage without inverting.
Hadamard-style encodings remove residual correlations at one length, but then
the source becomes noisy-parity/correlation learning rather than easy
distribution-free agnostic improper learning.

Thus the remaining false route is not "remove all weak handles." On a fixed
polynomially visible domain, coding bounds and finite-trace pigeonhole
phenomena make that unrealistic for large proper families. The more plausible
route is **computational weak-handle hardness**: weakly good proper hypotheses
may exist, but finding any of them from samples is hard, while an improper
relaxation can still find a weak predictor.

## Why Computational Weak-Handle Hardness Is Hard To Instantiate

The natural analogy is an LP/SDP or lookup relaxation for a CSP: the improper
learner can output a relaxed local object, while proper hypotheses are integral
witnesses. To settle this edge, the construction would need a fixed marginal
where labels encode the hard instance on constant mass, satisfiable instances
have a good proper witness, and unsatisfiable instances have no efficiently
findable weak proper witness.

The usual CSP/PCP implementations put the instance into the constraint set,
hence into the marginal. If instead one uses a universal fixed constraint
domain and puts the instance only in labels, then either the hard constraints
occupy small mass, or unrelated satisfiable instances/assignments become weak
handles. This is the same identity-protection problem seen in the shared-PCP
attempt.

There is also an agnostic-source tension. The source learner must compete with
$\operatorname{OPT}_{\mathcal C}$ for arbitrary conditional labels, not only
clean satisfiable instances. A relaxation that is easy only in the realizable
or very-low-noise case is not enough. If the relaxation is strong enough to
give a fixed additive weak agnostic guarantee for every distribution, it often
resembles an efficiently searchable weak cover. Once such a cover is made of
proper concepts, the target is positive; once it is kept improper, the lower
bound must still show that no proper weak handle can be efficiently found.

This is the precise unresolved middle: an improper weak agnostic relaxation
that is genuinely easier than integral weak search under one fixed marginal.

## Current Verdict

`unresolved-open`.

I do not see a proof that the implication is true. The source provides
prediction but not proper search, and the marginal-nonuniform target still
requires one uniform polynomial-time algorithm outputting a valid concept.

I also do not see a proof that the implication is false. The source-positive
proper-hardness classes either use an input-dependent hard marginal, require
strong accuracy, or leak weak proper handles. The strongest remaining false
template would need computationally hard weak handles under a fixed marginal,
not merely a code family with small correlations.

## Next Directions

1. **Selector theorem boundary.** Prove the conditional candidate-list lemma
   cleanly for classes with fixed-marginal approximate proper ERM, computable
   $L_1(P)$ covers, or trace selectors. Use it as a checklist for future
   counterexamples.
2. **Fixed-marginal CSP relaxation.** Search for a PCP/CSP representation where
   the input changes labels on a constant-mass universal marginal, improper
   local lookup is weak agnostically learnable, and every weak integral
   solution is computationally hard to find.
3. **Identity-protected shared PCP.** Look for a verifier/test distribution in
   which unrelated satisfiable instances cannot act as all-one or high-bias
   handles on the target instance's labels.
4. **Computational weak-handle lower bound.** Replace the impossible-looking
   requirement "no wrong weak handles exist" with "finding any wrong weak
   handle is hard," and check whether PRG, planted-CSP, or label-cover
   assumptions can support the unknown-gap validation.
5. **Black-box separation diagnostic.** Build an oracle model where an
   improper lookup learner exists but every polynomial-time proper selector
   fails under one fixed marginal. This would not settle the atlas edge, but it
   would test whether the missing selector is inherently non-black-box.

Final depth-4 verdict: unresolved-open. No atlas metadata change is justified.

---

# Depth-5 Follow-Up: Selector Extraction, Weak Handles, And Correlation-Inversion Witnesses

- depth: 5
- date: 2026-05-05
- edge_file: `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- verdict: unresolved-open
- confidence: high that the existing witness templates do not resolve the edge; medium-high that a genuine counterexample would need computational weak-handle hardness rather than only coding geometry
- write scope: this scratchpad only; no atlas files edited

## Focus

This pass isolates the part of properization that remains after depth 4:

$$
\text{distribution-free weak agnostic improper learner}
\quad\Longrightarrow?\quad
\text{fixed-marginal weak agnostic proper selector}.
$$

The source is weaker than the strong agnostic improper siblings: it supplies only
a fixed additive weak tolerance $\beta<1/2$, not arbitrary excess accuracy. But
this does not make the properization obstruction disappear. It makes the
candidate-list route even thinner: the source supplies a weak external
predictor, while the target needs a valid concept name.

I still do not resolve the edge. The positive route needs a selector theorem
not implied by the source. The negative route needs a source-positive
proper-hardness class where every fixed-marginal weak proper output is already
a useful witness. The known classes each fail one of these requirements.

## Candidate-List And Selector Extraction

A useful positive theorem would have the following shape. For each fixed
marginal $P$, there is one uniform polynomial-time procedure $S$ which, given
samples from any joint distribution $\mathcal D$ with marginal $P$ and optional
evaluation access to an external predictor $g$ satisfying

$$
\operatorname{err}_{\mathcal D}(g)
\le \operatorname{OPT}_{\mathcal C}(\mathcal D)+\beta,
$$

outputs a polynomial-size list $L\subseteq\mathcal C$ containing some
$c$ with

$$
\operatorname{err}_{\mathcal D}(c)
\le \operatorname{OPT}_{\mathcal C}(\mathcal D)+1/2-\gamma_P(s)
$$

for an inverse-polynomial $\gamma_P$. Then the source learner followed by
holdout validation over $L$ gives the target.

This lemma is only conditional. It names exactly the missing operation:
generate legal proper candidates. Rerunning the improper learner on bootstrap
samples, relabeled samples, or residual distributions gives more external
predictors, not concepts in $\mathcal C$. Validation can choose among a list
only after the list exists.

Projection from $g$ to $\mathcal C$ is also not forced. In the realizable case
the source may output a hypothesis of error $0.49$ under a balanced marginal,
with no representation-level trace of the target concept. In the agnostic
case, $g$ may use correlations outside $\mathcal C$ and need not be close to
any near-optimal proper concept. Boosting or aggregation can improve external
prediction when applicable, but the aggregate is still generally improper.

Marginal nonuniformity changes the allowed analysis, not the learner's
information. It permits a $P$-dependent polynomial bound for one uniform
algorithm. It does not give $P$-dependent advice, a support enumeration, a
proper ERM oracle, a trace selector, or a projection oracle. Thus a positive
resolution still needs a genuine fixed-marginal weak proper selector theorem.

## Weak Handles: Why Target-Negative Is So Hard

For a false witness, it is not enough that exact or strong proper learning is
hard. The target may accept any proper hypothesis whose error beats
$\operatorname{OPT}_{\mathcal C}+1/2$ by an unknown inverse polynomial.

This creates the weak-handle problem. A handle is any legal proper hypothesis
which is weakly good but does not reveal the hard witness. Constants, wrong
lengths, singleton positive atoms, bounded positive subsets, unrelated
satisfiable PCP instances, and wrong codewords with residual correlation are
all handles in different templates.

The one-way image-coordinate weak-handle class makes the point sharply. Adding
constants and bounded positive-atom subset concepts makes weak proper learning
easy, while strong proper recovery under the fixed coordinate marginal still
inverts a one-way function. That construction separates weak proper from
strong proper targets, but it cannot separate this edge because the target is
already weak.

Removing legal handles is not enough either. On an explicit polynomial
coordinate domain, exponentially many proper certificates cannot all be
orthogonal below every inverse-polynomial scale. Some weakly correlated wrong
objects are expected unless the domain is Hadamard-scale or otherwise
superpolynomial. But making the domain that large destroys the lookup/sparse
ERM argument that made the improper source easy, or turns the source into a
parity/correlation-search problem.

The more plausible negative route is therefore not "no weak handles exist."
It is:

> weak handles may exist, but finding any weak handle from samples is hard;
> meanwhile an improper relaxation can still weakly agnostically compete with
> $\mathcal C$ distribution-free.

No current atlas witness supplies this computational weak-handle hardness.

## Fixed-Marginal Correlation-Inversion Witnesses

The cleanest target-negative template can be written in correlation form. Work
with labels and concepts in $\{\pm1\}$. For each hard object $z$, define a
labeling $Y_z$ over one fixed marginal $P^\star$. Proper hypotheses are
concepts $c_t\in\mathcal C$. In the realizable case, the weak proper target
would return some $t$ with

$$
\langle c_t,Y_z\rangle_{P^\star}\ge 2\gamma_{P^\star}(s).
$$

To turn this into an inverter or NP witness extractor, every efficiently
reachable $t$ satisfying this inequality must reveal useful information about
$z$.

Polynomial shared-code witnesses fail at the hidden-gap scale. If
$2^n$ seeds are encoded as binary vectors on $N(s)=\operatorname{poly}(s)$
explicit coordinates, pairwise correlations can be made small only at some
inverse-polynomial scale controlled by $N$. The target's guaranteed
$\gamma_{P^\star}(s)$ may be a smaller inverse polynomial. A wrong seed with
correlation above that smaller gap is then a legal weak proper output and need
not invert anything.

Hadamard-style encodings fix this information-theoretically. Distinct images
are exactly orthogonal, so any positive correlation identifies the image. But
then the domain is exponential or implicit. With an explicit domain, a
polynomial-time learner is no longer polynomial in the original hard length.
With an implicit domain, weak agnostic improper learning becomes a noisy
parity/correlation-search problem under arbitrary distributions, not the easy
improper lookup learner used in the known source-positive witnesses.

Thus a correlation-inversion counterexample must satisfy three demands at
once:

1. one fixed high-mass marginal, not an input-specific active slice;
2. an efficient distribution-free weak agnostic improper learner;
3. hardness of finding any proper hypothesis with inverse-polynomial
   correlation at the learner's hidden weak scale.

The known code, PCP, clause, and one-way-coordinate templates do not meet all
three.

## Do Source-Positive Proper-Hardness Classes Exist?

Yes, but not for this exact target-negative requirement.

The PCP active-slice lookup class is source-positive for this edge: one-slice
lookup-table ERM is agnostic and improper, and the weak proper lower bound is
real on the active slice. It fails the assigned edge because the active-slice
marginal names the input instance. The marginal-nonuniform target can hide the
instance-dependent search cost in the polynomial for that marginal. Packing
slices into one marginal dilutes the weak gap.

The clause-satisfaction lookup class is source-positive, even in a stronger
agnostic improper sense. It gives fixed-marginal strong proper hardness by
encoding the formula in labels over the uniform clause marginal. It fails the
weak target because a weak learner need not find an assignment accurate enough
to satisfy every relevant clause; the strong lower bound uses accuracy at the
single-clause mass scale.

The one-way image-coordinate class is also source-positive through sparse
lookup ERM. It gives fixed-marginal strong proper recovery hardness. It fails
the weak target because wrong lengths, sparse overlaps, constants, singleton
handles, or residual code correlations can be weakly legal without inverting
the one-way function.

So the current answer is:

> source-positive proper-hardness classes exist for nearby edges, but no known
> class is simultaneously source-positive and target-negative for fixed-marginal
> weak agnostic proper learning.

## Current Verdict

`unresolved-open`.

The implication is not proved true because weak agnostic improper prediction
does not generate a proper candidate list or selector. It is not proved false
because existing proper-hardness witnesses either vary the hard marginal,
require strong accuracy, leak weak proper handles, or lose the easy improper
agnostic source when made correlation-safe.

No atlas metadata change is justified.

## Concrete Depth-6 Directions

1. **Selector boundary theorem.** Formalize the conditional candidate-list
   lemma for fixed marginals: samples plus a weak external predictor plus an
   efficient trace selector imply the target. Then list minimal sufficient
   structures, such as approximate proper ERM, computable $L_1(P)$ covers,
   legal neutralizers, or projection oracles.

2. **Computational weak-handle hardness.** Search for a class where weak proper
   handles exist but finding any one is hard, while an improper relaxation is
   distribution-free weak agnostically learnable. Planted CSP, label-cover, and
   PRG-code relaxations are the natural places to test this.

3. **Fixed-marginal correlation-inversion reduction.** Try to build a single
   marginal $P^\star$ and labels $Y_z$ where every proper hypothesis with
   inverse-polynomial correlation at any hidden scale yields an inverter. The
   first check should be whether the source learner remains weak agnostic, not
   merely realizable.

4. **Shared-PCP identity protection.** Look for PCP or universal label-cover
   forms where the input changes labels on constant mass but wrong satisfiable
   instances are near-random rather than weak handles. Avoiding an active
   instance coordinate is the key constraint.

5. **Oracle or black-box separation.** Build an oracle model with an improper
   weak agnostic lookup learner but no polynomial-time proper weak selector
   under one fixed marginal. This would not settle the atlas edge, but it would
   test whether the selector obstruction is genuinely non-black-box.

Final depth-5 verdict: unresolved-open.

---

# Depth-6 Final Attempt: Selector Or Weak-Handle Hardness

- depth: 6
- date: 2026-05-05
- edge_file: `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- verdict: unresolved-open
- confidence: high that the current atlas witnesses do not resolve the edge; medium that the right future false witness, if it exists, must be a computational weak-handle construction rather than a purely geometric code construction
- write scope: this scratchpad only; no atlas files edited

## Verdict

I do not resolve the edge.

The edge should remain:

```yaml
status: "open"
evidence: unknown
family: properization-open
```

The atlas-facing summary I would use is:

```text
Open: the source gives a distribution-free weak agnostic improper predictor, but no general method is known for extracting even a fixed-marginal weak proper candidate. Existing proper-hardness witnesses are source-positive for nearby improper nodes, but for this weak marginal-nonuniform target they either use an input-dependent marginal, require strong accuracy, leak weak proper handles, or lose the easy agnostic improper learner when made correlation-safe.
```

The remaining problem is exactly:

$$
\text{external weak agnostic prediction}
\quad\Longrightarrow?\quad
\text{uniform polynomial-time search for a weakly useful } c\in\mathcal C
\text{ under each fixed marginal.}
$$

This final pass tried four routes: candidate-list extraction, weak-handle
removal, fixed-marginal correlation inversion, and source-positive proper
hardness. Each route still hits a precise obstruction.

## 1. Candidate-List Extraction

The tempting positive proof is to run the source learner $A$, obtain an
external predictor $g$, and somehow extract a short list
$L\subseteq\mathcal C$ containing a weakly good proper concept. Holdout
validation would then choose from $L$.

The missing lemma would be:

> **Fixed-marginal weak selector lemma.** For every fixed marginal $P$, there is
> one uniform polynomial-time procedure $S$ such that, from samples from any
> joint distribution $\mathcal D$ with marginal $P$ and optional evaluation
> access to any $g$ satisfying
> $$
> \operatorname{err}_{\mathcal D}(g)
> \le \operatorname{OPT}_{\mathcal C}(\mathcal D)+\beta,
> $$
> it outputs a polynomial-size list $L\subseteq\mathcal C$ containing some
> $c$ with
> $$
> \operatorname{err}_{\mathcal D}(c)
> \le \operatorname{OPT}_{\mathcal C}(\mathcal D)+1/2-\gamma_P(s)
> $$
> for an inverse-polynomial $\gamma_P$.

If this lemma were available, the edge would be true. Run $A$, run $S$, and
validate the polynomial list. The source gives the external weak benchmark;
standard concentration handles the list selection; the target's
marginal-nonuniformity absorbs the fixed-$P$ sample and runtime polynomial.

But the lemma is not a consequence of the source definition. Rerunning $A$ on
bootstrap samples, residual labels, random relabelings, or mixtures with $g$
only produces more external predictors. It does not produce names of concepts
in $\mathcal C$. Validation cannot choose a concept that was never generated.

Projection also fails as a black-box operation. In the realizable case, $g$ may
have error $0.49$ against a balanced target and carry no representation-level
information about the proper concept. In the agnostic case, $g$ may exploit
features outside $\mathcal C$ and need not be close in $L_1(P)$ to any
near-optimal proper hypothesis. Boosting, when applicable, improves external
prediction but normally returns an aggregate or randomized predictor outside
$\mathcal C$.

Marginal nonuniformity does not supply advice. It only permits the analysis of
one fixed uniform learner to use a $P$-dependent polynomial. It does not hand
the learner a $P$-specific support enumeration, a finite trace basis, a proper
ERM oracle, or a projection oracle. Even for a fixed marginal, enumerating
proper concepts can remain exponential in the representation size; an arbitrary
large $P$-dependent polynomial degree cannot cover a generic $2^s$ search.

So the positive route reduces to a conditional theorem for structured classes:
efficient fixed-marginal approximate proper ERM, computable $L_1(P)$ covers by
valid concepts, trace selectors, or constant-slack projection oracles would
suffice. None of those structures is implied by efficient weak agnostic
improper learnability.

## 2. Weak-Handle Obstructions

The negative route must rule out every weakly acceptable proper output under
one fixed marginal. This is much stronger than ruling out strong proper
learning.

Use $\{\pm1\}$ labels. For a realizable hard labeling $Y_z$ under a fixed
marginal $P^\star$, a weak proper learner may output any $c\in\mathcal C$ with

$$
\langle c,Y_z\rangle_{P^\star}\ge 2\gamma_{P^\star}(s),
$$

where $\gamma_{P^\star}$ is hidden and may be a small inverse polynomial. A
target-negative reduction must show that any efficiently findable $c$ with
that much correlation decodes the hard witness or solves the hard instance.

Known handles defeat this:

- **Constants and biases.** If the hard labeling is imbalanced, a constant can
  be weakly good while revealing nothing.
- **Wrong lengths or wrong blocks.** In all-length one-way coordinate
  marginals, a concept on another block can have small total error simply
  because the hard block has limited mass.
- **Singleton or bounded positive atoms.** Sparse coordinate witnesses often
  have visible heavy positive atoms; a proper handle covering a few of them
  gives inverse-polynomial or even constant weak advantage.
- **Unrelated satisfiable instances.** Shared-PCP attempts without an active
  instance coordinate allow a proof for the wrong instance to behave like a
  high-bias weak handle.
- **Residual code correlations.** On polynomially many explicit coordinates,
  wrong codewords can have inverse-polynomial correlation. The target's hidden
  weak gap may be smaller than that residual.

Removing these handles by brute force usually breaks the source. Exact
orthogonality for exponentially many proper certificates wants a Hadamard-scale
or implicit domain. Then lookup or sparse ERM is no longer polynomial in the
natural hard-instance size, or the source learner becomes a hard correlation
search problem. Keeping the domain explicit and polynomial preserves the easy
improper source but leaves weak handles at some inverse-polynomial scale.

Thus the likely false route is not "no weak handles exist." It must be:

> weak proper handles may exist information-theoretically, but finding any one
> from samples is computationally hard, while an improper relaxation remains
> distribution-free weak agnostically learnable.

No current witness in the atlas proves this.

## 3. Fixed-Marginal Correlation-Inversion Witnesses

The sharpest candidate counterexample would be a correlation-inversion family.
Fix a marginal $P^\star$ once and for all. A hard object $z$ defines labels
$Y_z$. Proper concepts are indexed by candidate witnesses $t$. The reduction
requires:

1. if a proper learner returns any $t$ with
   $\langle c_t,Y_z\rangle_{P^\star}\ge 1/\operatorname{poly}(s)$ at the
   target's hidden scale, then $t$ yields an inverter or NP witness;
2. nevertheless, an improper learner can weak agnostically compete with
   $\mathcal C$ under every distribution in polynomial time.

The one-way image coordinate class gets the second property and gets a strong
version of the first property, but not the weak version. It forces inversion
only when the learner reaches accuracy on the order of a bit or block mass.
The weak target can stop far earlier, at a correlation that may be obtained by
a wrong length, a sparse overlap, or a residual coordinate-code correlation.

A PRF or pseudorandom-code class goes in the opposite direction. It can make
proper weak correlation computationally hard under the uniform marginal, but
then the source is no longer positive: an improper weak learner for arbitrary
distributions would itself be finding nontrivial correlations with a
pseudorandom family, or would have to memorize an exponential uniform domain.

Hadamard image codes are the clean boundary example. At one fixed length,
distinct images can be made orthogonal, so any positive correlation identifies
the image. But the coordinate domain is exponential unless represented
implicitly. With explicit coordinates, the improper learner is not polynomial
in the seed length. With implicit coordinates, the source is essentially noisy
parity/correlation learning under arbitrary distributions, which is not the
easy lookup or sparse ERM source used by the atlas witnesses.

This is the core tradeoff:

```text
polynomial visible domain  -> easy improper lookup, but weak residual handles
correlation-safe domain    -> weak proper hardness, but source no longer easy
```

I do not see a construction that escapes the tradeoff.

## 4. Source-Positive Proper-Hardness Classes

There are source-positive proper-hardness classes, but not for this exact
target.

**PCP active-slice lookup.** This class is source-positive even for weak
agnostic improper learning: one-slice lookup-table ERM competes with every
proper proof concept. It gives genuine weak proper hardness on the active
slice. But the active marginal is $P_\varphi$, which names the input instance
$\varphi$. A marginal-nonuniform target may hide the instance-specific search
cost in $p_{P_\varphi}$. Packing all slices into one fixed marginal dilutes
the local PCP gap by the slice mass, and weak learning can ignore small slices.

**Clause-satisfaction lookup.** This class is source-positive in the stronger
agnostic improper sense: the clause universe is polynomial and lookup ERM can
compete with assignments. The fixed uniform clause marginal is useful for
strong proper hardness because requested accuracy can be below the mass of a
single relevant clause. The weak target never requests that accuracy. A proper
assignment with only a slight global advantage over random guessing may reveal
nothing about satisfiability.

**One-way image coordinate.** This class is source-positive through sparse ERM.
It gives fixed-marginal strong proper recovery hardness. It does not give weak
proper hardness because weak outputs can be wrong-length, sparse-overlap, or
handle hypotheses. The weak-handle variant makes this explicit: adding handles
keeps strong recovery hard but makes weak proper learning easy.

**Fixed-$k$ DNF and Khot-Saket style hardness.** These are good reminders that
constant-advantage proper weak hardness exists for natural classes. They do
not by themselves settle this edge, because the atlas target is
marginal-nonuniform with an inverse-polynomial hidden weak gap, and the source
must be a distribution-free weak agnostic improper learner for the same class.
The known DNF results do not supply the required fixed-marginal,
source-positive, no-weak-handle witness.

**Halfspaces.** Halfspace hardness is source-negative for this edge in the
relevant worst-case regimes: the obstruction can rule out improper agnostic
learning too. Gaussian properization results are positive but class-specific.

So the current witness table is:

```text
PCP active slice:          source-positive, weak-hard, but marginal varies
clause lookup:             source-positive, fixed marginal, but strong-accuracy only
one-way image coordinates: source-positive, fixed marginal, but weak handles remain
PRF / pseudorandom codes:  weak-hard, fixed marginal, but source-negative
Hadamard image codes:      weak-safe geometry, but source no longer polynomial lookup
halfspaces:                source-negative or class-specific positive
```

## Missing Lemmas

Resolving the edge true would require something like:

```text
Weak Improper Selector Lemma:
For every efficiently weak agnostically improperly learnable class, every fixed
marginal admits a uniform polynomial-time weak proper candidate selector.
```

This looks too strong. It would turn external prediction into representation
search without assuming proper ERM, trace search, covers, or projection.

Resolving the edge false would require something like:

```text
Fixed-Marginal Weak-Handle Hardness Lemma:
There is a class C with an efficient distribution-free weak agnostic improper
learner and a fixed marginal P* such that finding any proper c in C with
inverse-polynomial correlation with the hard labels under P* solves an NP-hard
or cryptographic search problem.
```

This is plausible as a target but not currently instantiated. The known
templates either make weak handles easy to find or make improper weak agnostic
learning hard as well.

## Atlas-Facing Synthesis

This edge should stay in `properization-open`.

Recommended implication note wording:

```markdown
The edge is open as a fixed-marginal weak properization problem. The source
learner already supplies a distribution-free polynomial-time weak agnostic
external predictor, so the only missing step is to output a valid concept in
$\mathcal C$. Standard validation, boosting, and marginal nonuniformity do not
generate a proper candidate list.

Known false-witness templates are near misses. PCP active-slice lookup gives
weak proper hardness but uses a hard marginal depending on the instance.
Clause-satisfaction lookup gives fixed-marginal proper hardness only at strong
accuracy. One-way image-coordinate witnesses give fixed-marginal strong
recovery hardness, but weak proper handles such as wrong blocks, sparse
overlaps, constants, or residual code correlations can be legal weak outputs.
Hadamard or PRF-style repairs improve weak correlation safety but lose the easy
distribution-free agnostic improper source.

A resolution would need either a general fixed-marginal weak proper selector
from improper predictors, or a source-positive fixed-marginal class where
finding any inverse-polynomially correlated proper handle is computationally
hard.
```

Recommended family: `properization-open`.

Recommended status: `open`.

Recommended evidence: `unknown`.

Recommended witnesses: none.

Final depth-6 verdict: unresolved-open.
