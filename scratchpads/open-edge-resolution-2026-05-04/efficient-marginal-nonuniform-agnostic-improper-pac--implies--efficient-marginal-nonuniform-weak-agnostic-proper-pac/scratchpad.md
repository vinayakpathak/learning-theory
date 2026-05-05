# Open Edge Resolution Scratchpad

Edge: `efficient-marginal-nonuniform-agnostic-improper-pac -> efficient-marginal-nonuniform-weak-agnostic-proper-pac`

## Research Log

## Sources Checked

## Proof Or Counterexample Attempts

## Verdict

## Follow-Up Directions

## Depth-1 Entry - 2026-05-05

### Verdict

Still `open`.

I do not see an atlas-ready proof or counterexample at depth 1. The edge asks whether a strong agnostic improper marginal-nonuniform learner can always be converted into a weak agnostic proper marginal-nonuniform learner:

$$
\text{efficient marginal-nonuniform agnostic improper}
\Rightarrow
\text{efficient marginal-nonuniform weak agnostic proper}.
$$

The source is stronger than the weak-improper sibling, but the remaining difficulty is still computational properization. The source can find an arbitrary efficient hypothesis competing with $\mathcal C$; the target must return an element of $\mathcal C$.

### Definitions Used

- Source definition read: `atlas/definitions/efficient-marginal-nonuniform-agnostic-improper-pac.md`.
  - One uniform learner works for every joint distribution.
  - For each marginal $P$, there is a marginal-dependent polynomial $p_P(s,1/\varepsilon,\log(1/\delta))$.
  - The learner must achieve $\operatorname{err}(h)\le \inf_{c\in\mathcal C}\operatorname{err}(c)+\varepsilon$.
  - The output may be outside $\mathcal C$.
- Target definition read: `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`.
  - One uniform learner works for every joint distribution.
  - For each marginal $P$, there are a marginal-dependent polynomial $p_P(s,\log(1/\delta))$ and an additive tolerance $\beta_P(s)<1/2$ whose gap from $1/2$ is inverse-polynomial.
  - The learner must achieve $\operatorname{err}(h)\le \inf_{c\in\mathcal C}\operatorname{err}(c)+\beta_P(s)$.
  - The output must satisfy $h\in\mathcal C$.
- Edge note read: `atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`.
  - Current status is `open`, evidence `unknown`, family `properization-open`.

### Sources Checked

Local atlas notes checked:

- `atlas/arguments/properization-open.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/marginal-agnostic-hardness-open.md`
- `atlas/arguments/sample-complexity-equivalence.md`
- `atlas/arguments/clause-satisfaction-proper-hardness.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/witnesses/clause-satisfaction-lookup-class.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- Nearby scratchpads and implication notes for the strong proper edge and the weak-improper-to-weak-proper edge.

Primary or near-primary web sources checked:

- Hanneke, Moran, and Thiessen, *Marginal-Nonuniform PAC Learnability*, OpenReview/PDF: https://openreview.net/forum?id=aoVCFtox89 and https://openreview.net/pdf?id=aoVCFtox89. Relevant point: marginal-nonuniform rates may depend on the marginal distribution while remaining uniform over target concepts once the marginal is fixed.
- Feldman, *Distribution-Specific Agnostic Boosting*, arXiv/PDF: https://arxiv.org/abs/0909.2927 and https://www.cs.cmu.edu/~odonnell/hits09/feldman-agnostic-boosting.pdf. Relevant point: distribution-specific agnostic boosting can preserve the instance marginal by modifying labels, but it uses a stronger weak-agnostic oracle format than this atlas target and does not properize.
- Schapire, *The Strength of Weak Learnability*, author PDF / DOI context: https://www.schapire.net/papers/strengthofweak.pdf and https://doi.org/10.1023/A:1022648800760. Relevant point: classical weak-to-strong boosting is improper in general and does not project back into $\mathcal C$.
- Håstad and Khot, *Query Efficient PCPs with Perfect Completeness*, Theory of Computing page: https://theoryofcomputing.org/articles/v001a007/. Relevant point: perfect completeness and soundness below $1/2$ support active-slice weak-proper hardness when the hard instance is placed in the marginal.
- Khot and Saket, *Hardness of Minimizing and Learning DNF Expressions*, author PDF: https://cs.nyu.edu/~khot/papers/minDNF.pdf. Relevant point: fixed-$t$ DNF weak-proper hardness is a near miss because it is distribution-varying and constant-advantage.
- Blumer, Ehrenfeucht, Haussler, and Warmuth, *Learnability and the Vapnik-Chervonenkis Dimension*, DOI/PDF mirror: https://doi.org/10.1145/76359.76371 and https://www.cis.upenn.edu/~danroth/Teaching/CS446-17/Papers/p929-blumer.pdf. Relevant point: finite-class/VC uniform convergence justifies sample-only proper ERM, but not efficient proper ERM.
- Karp, *Reducibility Among Combinatorial Problems*, DOI/search source: https://doi.org/10.1007/978-1-4684-2001-2_9. Relevant point: 3-SAT hardness is the background source for clause/proper-learning reductions.
- Pitt and Valiant, *Computational Limitations on Learning from Examples*, DOI context: https://doi.org/10.1145/48014.63140. Relevant point: historical proper-learning hardness context; I did not rely on it for a new counterexample.

### Theorem Route

Goal: build a target learner $B$ that returns $c\in\mathcal C$ from the source learner $A$.

The direct monotonicity route fails at properness. Running $A$ with any accuracy parameter gives an improper hypothesis $g$ with

$$
\operatorname{err}_{\mathcal D}(g)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\varepsilon.
$$

This certifies that a good competitor exists relative to $\mathcal C$, but it does not identify any efficient way to find a member of $\mathcal C$ with even weak excess error $\beta_P(s)$.

The sample-only route also stops at computation. At a fixed marginal, finite-sample/VC arguments say that exhaustive ERM over $\mathcal C$ would be enough once runtime is ignored. But the target is computationally efficient. Marginal-dependent rates allow the polynomial to depend on $P$; they do not give a proper optimization oracle or representation-specific projection from an improper $g$ back into $\mathcal C$.

Boosting is not the missing theorem either. Schapire-style boosting and Feldman-style distribution-specific agnostic boosting are useful near misses, but this edge is already strong-to-weak. The missing step is not amplification of advantage; it is properization. Existing boosting theorems typically output votes or other combined hypotheses outside the original class, and Feldman's agnostic oracle assumptions are stronger than the atlas fixed-additive weak target.

Conclusion for theorem route: no atlas-ready `true` proof at depth 1. A proof would need a new computational properization principle, such as efficient approximate proper ERM under every fixed marginal, or a structural theorem turning strong improper agnostic learners into proper weak agnostic learners.

### Counterexample Route

I checked three plausible false routes.

1. Clause-satisfaction lookup class.

This class now resolves the stronger target

$$
\text{efficient marginal-nonuniform agnostic improper}
\not\Rightarrow
\text{efficient marginal-nonuniform agnostic proper}
$$

under $\mathrm{NP}\nsubseteq\mathrm{RP}$, using a fixed uniform marginal over all clauses and fair-coin labels off the input formula. It does not resolve the present weak-proper target. The satisfiable and unsatisfiable cases differ by one clause, i.e. about $1/N_n$ under the fixed clause marginal. A weak agnostic proper learner may have additive tolerance $\beta_P(s)$ close to $1/2$, so the one-clause gap is swallowed. The strong-proper reduction needs accuracy $\varepsilon<1/(3N_n)$; the weak target does not provide that.

2. PCP active-slice lookup class.

The active-slice PCP witness has the right weak-gap flavor: perfect completeness gives error $0$ on satisfiable instances, and soundness below $1/2$ makes every proper proof bad on unsatisfiable instances. It resolves distribution-free weak proper hardness when the learner is run on the marginal uniform over the active slice for the input $\varphi$.

The marginal-nonuniform target breaks that reduction. If the active-slice marginal depends on $\varphi$, then the target's hidden polynomial may also depend on $\varphi$, so the reduction does not yield a uniform randomized polynomial-time algorithm for the NP language. Packing every formula slice into one fixed marginal makes each slice's mass too small; the global weak error gap is multiplied by the slice mass and can fall below the unknown $\beta_P(s)$ tolerance.

3. Fixed-marginal PCP with labels encoding the instance.

I tried to repair the active-slice problem by fixing the marginal and encoding the input formula in labels rather than in the marginal. A natural construction gives each proper hypothesis an instance $\psi$ and proof $\pi$, with examples split between an identity-check block for $\psi$ and a PCP-verifier block. Labels encode the given $\varphi$ on the identity block and label verifier-randomness examples by $1$.

This still does not give an atlas-ready witness. If $\psi=\varphi$, PCP soundness handles the unsatisfiable case. If $\psi\ne\varphi$, the identity block must force error above the unknown weak tolerance $\beta_P(s)<1/2$. Polynomial-length binary error-correcting codes give relative distance close to, but generally below, $1/2$; a tolerance arbitrarily close to $1/2$ can still admit the wrong $\psi$. Exact $1/2$-distance encodings such as Hadamard-style encodings appear too large for the easy improper agnostic source, and I do not see a clean polynomial-time improper learner for the resulting class.

Conclusion for counterexample route: no atlas-ready `false` witness at depth 1. The clause witness handles strong proper learning but not weak proper learning; the PCP witness handles weak proper learning but not marginal-nonuniform runtime uniformity.

### Concrete Obstruction

The edge is pinned between two different obstructions:

- A positive proof needs an efficient way to search or project into $\mathcal C$. Strong improper agnostic learning gives a good outside hypothesis, not a proper hypothesis.
- A negative proof needs fixed-marginal weak proper hardness with a visible gap above the target's unknown tolerance $\beta_P(s)$. Standard weak proper hardness puts the hard instance in the marginal; standard fixed-marginal clause hardness only gives a strong-accuracy gap.

The strongest distilled obstruction is:

> To refute this edge, one needs a single fixed marginal whose labels can encode infinitely many hard instances, where every wrong proper hypothesis has error at least $1/2$ while the class remains efficiently agnostically learnable by an improper algorithm. The current clause and PCP witnesses each satisfy only one side of this requirement.

### Promising Next Directions

- Search for fixed-marginal PCP/proper-learning reductions with polynomial-size binary identity tests at distance exactly $1/2$, or with another mechanism forcing every wrong instance hypothesis above the weak tolerance.
- Look for representation classes where improper agnostic learning is easy by a compact dynamic program rather than a lookup table; this might tolerate a larger fixed-marginal hard encoding than clause lookup.
- Formalize the slice-packing obstruction for PCP active-slice witnesses: under one fixed marginal over many slices, quantify how the weak gap decays with slice mass.
- Investigate conditional theorem variants: source plus efficient approximate proper ERM under each fixed marginal, or source plus an efficient projection oracle from improper hypotheses to $\mathcal C$, should imply the target.
- Keep the atlas edge unchanged for now: `status: "open"`, `evidence: unknown`, `assumptions: []`, `witnesses: []`. If the note is expanded later, consider adding `feldman2010distributionspecific`, `hastad2005query`, `blumer1989`, and `hanneke2025marginalnonuniform` as near-miss/context refs rather than resolution refs.

## Depth-2 Entry - 2026-05-05

### Verdict

Still `open`.

Depth 2 sharpened the two requested counterexample directions into near misses rather than an atlas-ready separation. The PCP active-slice class can satisfy the marginal-nonuniform agnostic improper source, but the known weak proper refutation still puts the hard instance into the marginal. The clause-satisfaction fair-noise construction keeps the marginal fixed, but its quantitative gap remains a strong-accuracy gap unless one can make the hard formula region carry more than half of the total weak error budget.

No atlas changes are justified yet.

### Sources Checked

Local sources rechecked:

- `atlas/definitions/efficient-marginal-nonuniform-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/clause-satisfaction-proper-hardness.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/witnesses/clause-satisfaction-lookup-class.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`

Primary or reference web sources checked:

- Hanneke, Moran, and Thiessen, *Marginal-Nonuniform PAC Learnability*, OpenReview/PDF: https://openreview.net/forum?id=aoVCFtox89 and https://openreview.net/pdf?id=aoVCFtox89. Relevant point retained: the marginal-nonuniform rate may depend on the marginal $P$ but must hold uniformly over targets once $P$ is fixed.
- Håstad and Khot, *Query Efficient PCPs with Perfect Completeness*, Theory of Computing page/PDF: https://theoryofcomputing.org/articles/v001a007/ and https://theoryofcomputing.org/articles/v001a007/v001a007.pdf. Relevant point retained: logarithmic randomness, perfect completeness, and soundness $2^{-k^2}+\epsilon$, hence below $1/2$ for fixed large $k$.
- Blumer, Ehrenfeucht, Haussler, and Warmuth, *Learnability and the Vapnik-Chervonenkis Dimension*, JACM/PDF mirror: https://doi.org/10.1145/76359.76371 and https://www.cis.upenn.edu/~danroth/Teaching/CS446-17/Papers/p929-blumer.pdf. Relevant point retained: finite/VC classes give the sample side of ERM, but not efficient proper optimization.
- Plotkin-bound reference check: binary codes with minimum distance at or above the half-distance threshold cannot encode exponentially many messages in polynomial length at exact half-distance without using a Hadamard-scale domain. This is the coding bottleneck in the fixed-marginal identity-block repair.

### Theorem Route

The positive route remains blocked at properization.

Given the source learner $A$, we can set any desired $\varepsilon$ and obtain an improper $g$ satisfying

$$
\operatorname{err}_{\mathcal D}(g)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\varepsilon.
$$

This does not identify a member of $\mathcal C$. Weakening the target only changes the required excess tolerance from arbitrary $\varepsilon$ to some $\beta_P(s)<1/2$; it does not supply a search procedure over $\mathcal C$.

A conditional theorem would be straightforward: source plus an efficient marginal-specific proper approximate ERM/projection oracle with tolerance below $\beta_P(s)$ implies the target. But that extra oracle is exactly the missing computational content. Neither active-slice PCP structure nor clause fair-noise gives a generic positive conversion.

### Counterexample Route

#### PCP Active-Slice

The active-slice class still looks like the right weak-gap gadget. Let proper concepts be indexed by an instance $\varphi$ and proof $\pi$, and on slice $(\psi,r)$ output $V(\varphi,\pi,r)$ only when $\psi=\varphi$.

The source side is plausible and essentially already present in the local argument. An improper learner may compete using the larger class of one-slice lookup tables plus the all-zero hypothesis. On any sample, only sampled slices can beat all-zero, and the best table on each sampled slice is obtained by empirical majority vote over sampled random strings. This gives a uniform polynomial-time improper ERM against a class containing all proper PCP concepts, with polynomial VC/sample control at each size.

The target refutation still fails in the marginal-nonuniform setting:

1. If the learner is run on the active-slice marginal $P_\varphi$ uniform over $\{(\varphi,r)\}$, the hidden runtime polynomial may depend on $\varphi$. That does not produce a uniform randomized polynomial-time decision procedure for the NP language.
2. If all slices are packed into one fixed marginal $P=\sum_\psi w_\psi P_\psi$, the visible error gap on input $\varphi$ is multiplied by $w_\varphi$. Since there are exponentially many length-$n$ instances, no fixed marginal can give every length-$n$ slice inverse-polynomial mass. For low-mass slices, the gap can fall below the unknown weak advantage $1/2-\beta_P(s)$.
3. If the marginal is fixed and the instance is encoded in labels instead, one needs an identity block forcing every wrong proper instance $\psi\ne\varphi$ to incur error at least $1/2$. Otherwise the target tolerance could be close enough to $1/2$ to accept a wrong slice. Binary codes with pairwise relative distance at least $1/2$ for all length-$n$ instances require exponential-length identity domains in the relevant exact-half regime. Hadamard or pairwise-hash identity tests achieve the half-distance idea, but then the identity block is too large or makes the agnostic improper source compete with a hard parity-like class under arbitrary labels.

Conclusion: PCP active-slice can satisfy the source, but I do not see a way for it to refute the marginal-nonuniform weak proper target without a new fixed-marginal identity mechanism.

#### Clause-Satisfaction Fair-Noise

The fair-noise clause construction keeps the marginal fixed, but the weak threshold swallows the useful signal.

Let $P$ be uniform over a fixed clause universe of size $N$, and let a formula $F$ occupy an $\alpha=m/N$ fraction of that universe. Formula clauses have label $1$; non-formula clauses have fair labels. For an assignment $a$ with formula-clause violation rate $u_F(a)$,

$$
\operatorname{err}(a)
=
\frac{1-\alpha}{2}+\alpha u_F(a).
$$

If $F$ is satisfiable, $\operatorname{OPT}=(1-\alpha)/2$. A weak proper learner only guarantees

$$
\operatorname{err}(a)
\le
\frac{1-\alpha}{2}+\beta_P(s),
$$

so it only implies

$$
u_F(a)\le \frac{\beta_P(s)}{\alpha}.
$$

Because $\beta_P(s)$ may be $1/2-\gamma_P(s)$ with $\gamma_P(s)$ merely inverse-polynomial and unknown, this becomes useful only if the internal gap of the formula family satisfies

$$
\alpha\cdot \rho > \frac12
$$

where $\rho$ is the no-case lower bound on the fraction of violated formula constraints. Ordinary 3-SAT gives only a one-clause gap. Standard Max-3SAT-style gap amplification still leaves $\alpha\rho$ far below $1/2$ in the simple fixed universe of all clauses. PCPs can make the internal soundness gap weak-threshold-sized on the active random-string slice, but then the active slice is again formula-dependent unless an identity mechanism fixes the marginal.

Thus fair noise is not just missing a cosmetic amplification. To make it weak-threshold, one needs a fixed marginal where each input formula controls a polynomially visible region and the no-case violation mass across that region exceeds one half of the total weak budget. The checked clause construction does not provide this.

### Concrete Obstruction

The obstruction can now be stated quantitatively.

To refute the edge via PCP or clauses, one needs a single fixed marginal $P$ and an encoding of each hard input $\varphi$ into labels such that:

1. the realizable yes case has a proper concept with low error;
2. every proper concept that does not encode the right instance/proof has error at least $1/2$ or is separated by total mass more than $\beta_P(s)$;
3. the hard region for every length-$s$ input has inverse-polynomial $P$-mass under one fixed marginal;
4. the class remains efficiently strong agnostically learnable by an improper uniform learner.

Known gadgets hit these requirements only in pairs. Active-slice PCP gives items 1, 2, and 4 if the marginal may depend on $\varphi$, but not item 3 under one fixed marginal. Clause fair-noise gives a fixed marginal and item 4, but not item 2 at weak tolerance. Exact-half identity encodings would repair item 2, but they appear to violate item 4 or require exponential support.

### Next Directions

- Search specifically for fixed-marginal PCP encodings with polynomial support and exact half-distance identity tests whose agnostic improper relaxation is still efficiently learnable.
- Look for non-binary or structured-output reductions that can be represented inside binary classification without invoking parity-like agnostic learning on the identity block.
- Quantify the slice-packing lower bound as a lemma: any fixed marginal over exponentially many length-$n$ active slices leaves some slice with sub-inverse-polynomial mass, so active-slice weak gaps cannot uniformly contradict a marginal-nonuniform weak target.
- Test whether any dense PCP/Max-CSP hardness theorem gives $\alpha\rho>1/2$ while the input instance is encoded only in labels over a fixed universe. This is the exact condition needed for clause fair-noise to cross from strong-accuracy hardness to weak-threshold hardness.
- Keep the atlas edge unchanged: `status: "open"`, `evidence: unknown`, `assumptions: []`, `witnesses: []`. No exact atlas changes are available at this depth.

## Depth-4 Entry - 2026-05-05

### Verdict

Still `open`.

The final different lead before depth 5 was to push the one-way image-coordinate construction away from disjoint length blocks and toward shared high-mass code coordinates. This is the most plausible way to make a fixed marginal expose a weak-scale signal for every input length while keeping the hard object equal to a one-way image. The attempt still does not give an atlas-ready counterexample.

The obstruction is now parallel to the PCP active-slice obstruction. In PCP packing, the hard instance loses mass when all active slices are placed under one marginal. In the one-way coordinate route, a shared high-mass encoding avoids that first loss, but then needs a polynomial-length binary code whose distance beats the unknown inverse-polynomial weak gap of the hypothetical learner. Diagonalizing over many code accuracies reintroduces a mass-versus-gap problem, and the current weak-handle class itself is not a hard target because the handles let a weak proper learner avoid recovering the seed.

No atlas changes are justified.

### Sources Checked

Prior scratchpad entries present in this file:

- `Depth-1 Entry - 2026-05-05`
- `Depth-2 Entry - 2026-05-05`

Local atlas notes checked or rechecked:

- `atlas/definitions/efficient-marginal-nonuniform-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `references.bib` entries for `kearns1994cryptographic`, `hastad1999prg`, `hastad2005query`, `karp1972`, `benedek1991fixed`, `bendavid1995parameterization`, and `hanneke2025marginalnonuniform`.

Reference facts used from those notes:

- Kearns-Valiant style cryptographic learning hardness can force proper learners to recover a preimage when accuracy is strong enough on a fixed image-coordinate marginal.
- Håstad et al. give the pseudorandom-generator/one-way-function background used by the atlas one-way-image witnesses.
- Håstad-Khot PCPs give perfect completeness and soundness below $1/2$, which is the quantitative source of active-slice weak proper hardness.
- Marginal-nonuniform learning permits the resource polynomial and weak tolerance to depend on the fixed marginal, but the learner remains one uniform algorithm and receives no marginal-specific advice.

### Theorem Route

A positive theorem would still need a computational properization principle.

For this edge, the source learner can return an arbitrary hypothesis $g$ satisfying

$$
\operatorname{err}_{\mathcal D}(g)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\varepsilon .
$$

Weakening the target to additive tolerance $\beta_P(s)<1/2$ does not turn $g$ into a member of $\mathcal C$. The one-way and PCP attempts both reinforce the same point: the improper learner may use lookup tables, memorization, or histogram-style predictions on the visible part of the marginal, while a proper learner must output a seed, assignment, or proof. Nothing in the source guarantee supplies that representation search.

A conditional theorem remains easy but circular: if for every fixed marginal $P$ there were a polynomial-time proper approximate ERM or projection oracle with excess error at most $\beta_P(s)$, then the source would imply the target. This is exactly the missing ingredient, so it is not an atlas resolution.

### Counterexample Route

#### One-Way Image-Coordinate Weak-Handle Class

The existing weak-handle class does not give weak agnostic proper hardness. It was designed to make weak proper realizable learning easy: constants and singleton-positive-atom concepts give a proper weak handle for image-coordinate targets without recovering the one-way preimage. On the fixed length-block marginal used for strong proper hardness, a learner that is only required to beat error $1/2$ by an inverse polynomial can legally output a handle rather than a seed. Thus the current class points in the wrong direction for this edge.

Removing the handles does not immediately fix the problem. In the original disjoint-block construction, the length-$n$ block has mass $\mu_n\to 0$ under the one fixed marginal over all lengths. Even if labels are perfectly realizable by a seed concept, a weak agnostic proper learner with tolerance near $1/2$ can ignore that small block. Strong proper hardness used accuracy $\varepsilon_n=\mu_n/(3n)$; the weak target does not expose such an accuracy parameter.

The most promising modification is a shared-coordinate code construction. Instead of putting the length-$n$ image on a disjoint block of mass $\mu_n$, let every length-$n$ seed label a common high-mass coordinate set by an efficiently computable codeword

$$
\operatorname{Enc}(f(s)).
$$

If every incorrect image $y'\ne y$ had code distance at least $1/2-\eta(n)$ from $\operatorname{Enc}(y)$ under the fixed marginal, then a proper hypothesis with error at most $1/2-\gamma(n)$ would have to output a seed $t$ with $f(t)=y$, provided $\eta(n)<\gamma(n)$. This would be the right weak-scale analogue of the strong coordinate inversion argument.

The problem is that $\gamma(n)=1/2-\beta_P(n)$ belongs to the hypothetical marginal-nonuniform learner and is only known after fixing the learner and marginal. Polynomial-length binary codes can make relative distance close to $1/2$ for a prespecified inverse-polynomial slack, but the code in the concept class cannot be chosen after seeing the learner's hidden polynomial. Adding many encoding levels for many slacks does not solve this cleanly: the marginal weight assigned to the useful level then multiplies the advantage, recreating the active-slice mass loss.

There is also a source-side tension. Sparse ERM proves agnostic improper learnability for the original image-coordinate class because every proper concept has only $n$ positive atoms. A dense shared-code version would no longer be sparse. One might hope to recover the source by a marginal-nonuniform histogram learner on a countable instance space, but then the proof would have to be written as a new source lemma for the modified class and all marginals. I do not see a compact atlas-ready construction that simultaneously gives:

1. a fixed high-mass weak signal for every input length;
2. distance beating the unknown weak gap of any target learner;
3. proper output forcing exact one-way inversion rather than mild correlation;
4. efficient marginal-nonuniform agnostic improper learning.

So the one-way weak-handle route is a near miss, not a separation.

#### PCP Active-Slice Fixed Marginalization

The PCP active-slice route also remains blocked. If the learner is run on the marginal uniform over the active slice $\{(\varphi,r)\}$, the marginal depends on the input formula $\varphi$. That proves distribution-free weak proper hardness but does not refute a marginal-nonuniform target, because the runtime polynomial may depend on that input-specific marginal.

Packing all active slices into one fixed marginal gives each formula slice weight $w_\varphi$. The weak proper gap on input $\varphi$ is then multiplied by $w_\varphi$. Since there are exponentially many formulas of length $n$, some length-$n$ formulas must have subconstant, and in ordinary packings sub-inverse-polynomial, slice weight. The target learner's tolerance may be $1/2-\gamma_P(n)$ for an unknown inverse-polynomial $\gamma_P$, so the packed gap cannot uniformly cross the weak threshold.

Using a length-dependent fixed marginal $P_n$ uniform over all length-$n$ active slices is not enough. The marginal-nonuniform guarantee gives a polynomial for each $P_n$, but the degree and constants may vary with $n$. An NP reduction needs one uniform randomized polynomial-time algorithm over all input lengths; a family of hidden marginal-specific polynomials does not supply that.

The label-encoded fixed-marginal repair from the earlier entries still hits the identity-test barrier. Wrong formula indices must be penalized by nearly $1/2$ total error before PCP soundness becomes visible to a weak agnostic proper learner. Polynomial-size binary identity blocks do not give exact enough half-distance uniformly over the unknown weak gap, while Hadamard-scale identity blocks threaten both polynomial support and the easy improper source.

### Concrete Obstruction

To resolve the edge as `false`, one needs a fixed marginal $P$ and a concept class $\mathcal C$ such that:

1. for every hard input of size $n$, the input controls a region of $P$ large enough to beat the target learner's unknown inverse-polynomial weak gap;
2. every proper hypothesis that does not encode a valid witness or preimage has error above $\operatorname{OPT}_{\mathcal C}+\beta_P(n)$;
3. the same class has a uniform efficient marginal-nonuniform agnostic improper learner.

The one-way coordinate idea can force exact preimage recovery only at strong accuracy, unless a shared code supplies near-half distance at the hidden weak-gap scale. The PCP idea supplies a natural weak gap only when the active slice is input-dependent, unless a fixed marginal gives every hard input enough mass. Both repairs require a "for all hidden weak gaps" amplification, and every attempted diagonalization spends marginal mass or representation size until the source proof or the hardness proof breaks.

### Next Directions

- Do not change the atlas edge yet: keep `status: "open"`, `evidence: unknown`, `assumptions: []`, and `witnesses: []`.
- If going to depth 5, focus on proving an impossibility lemma for slice-packing and code-level diagonalization: under one fixed marginal, any countable family of disjoint hard regions loses enough mass that a weak agnostic target with hidden inverse-polynomial gap cannot be contradicted uniformly.
- Separately test the shared-code one-way construction as its own witness only if there is an explicit polynomial-time improper agnostic learner for dense coded labels under arbitrary marginals.
- Search for PCP or coding reductions where wrong-instance rejection is achieved structurally rather than by a binary identity block, so that the error barrier is above the unknown $\beta_P(n)$ without spending a separate low-weight marginal slice.
- Exact atlas changes if later resolved as `false`: update the edge note to `status: "false"`, set `evidence: conditional-counterexample`, add the relevant assumption (`length-preserving one-way functions exist` or `NP not subset RP`), add the successful witness id, add the primary `ref_keys`, and replace the proof-status body with the fixed-marginal reduction. No such changes are currently available.

## Depth-5 Entry - 2026-05-05

### Verdict

Still `open`.

I do not see a conservative atlas-ready theorem or counterexample. The source is quite strong: it asks for efficient strong agnostic improper learning with marginal-dependent polynomial bounds. That helps source-side proofs for lookup-style witnesses, but it does not solve the target's properness requirement. The target may have only a tiny inverse-polynomial advantage

$$
\alpha_P(s)=\frac12-\beta_P(s),
$$

where the exponent is hidden in the fixed marginal. Every false route I can make source-compatible either loses this weak-scale gap under one fixed marginal or stops being efficiently agnostically learnable improperly.

Recommended parent action: leave the atlas edge as `status: "open"`, `evidence: unknown`, with no witness or assumption.

### Definitions Used

- Source node: `efficient-marginal-nonuniform-agnostic-improper-pac`.
  - One uniform learner works for all joint distributions.
  - For each instance marginal $P$, the runtime and sample bound may be a polynomial $p_P(s,1/\varepsilon,\log(1/\delta))$ depending on $P$.
  - The guarantee is strong agnostic:

    $$
    \operatorname{err}_{\mathcal D}(g)
    \le
    \inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\varepsilon .
    $$

  - The output may be outside $\mathcal C$.
- Target node: `efficient-marginal-nonuniform-weak-agnostic-proper-pac`.
  - One uniform learner works for all joint distributions.
  - For each marginal $P$, there are a marginal-dependent polynomial and a weak tolerance $\beta_P(s)<1/2$ with inverse-polynomial gap from $1/2$.
  - The learner must output $h\in\mathcal C$ with

    $$
    \operatorname{err}_{\mathcal D}(h)
    \le
    \inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta_P(s).
    $$

The edge is therefore not about boosting strength. It is about whether arbitrary-accuracy improper prediction can be turned into any inverse-polynomial proper advantage under the same marginal-nonuniform computational convention.

### Sources Checked

Local atlas and scratchpad material checked or rechecked:

- `atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/marginal-agnostic-hardness-open.md`
- `atlas/arguments/clause-satisfaction-proper-hardness.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/witnesses/clause-satisfaction-lookup-class.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- Sibling scratchpads for strong proper marginal agnostic separation, weak improper-to-weak proper marginal agnostic properization, and weak realizable marginal properization.

Primary or near-primary sources checked across this depth and prior entries:

- Hanneke, Moran, and Thiessen, *Marginal-Nonuniform PAC Learnability*, OpenReview/PDF: https://openreview.net/forum?id=aoVCFtox89.
- Benedek and Itai, fixed-distribution learnability, DOI in atlas: https://doi.org/10.1016/0304-3975(91)90026-X.
- Ben-David, Benedek, and Mansour, distribution-dependent PAC parameterization, DOI in atlas: https://doi.org/10.1006/inco.1995.1094.
- Blumer, Ehrenfeucht, Haussler, and Warmuth, VC/finite-class learnability, DOI in atlas: https://doi.org/10.1145/76359.76371.
- Schapire, *The Strength of Weak Learnability*, DOI/PDF checked in earlier entries: https://doi.org/10.1023/A:1022648800760.
- Ben-David, Long, and Mansour, *Agnostic Boosting*, DOI in atlas: https://doi.org/10.1007/3-540-44581-1_33.
- Feldman, *Distribution-Specific Agnostic Boosting*, arXiv/PDF checked earlier: https://arxiv.org/abs/0909.2927.
- Pitt and Valiant, proper-learning hardness context, DOI in atlas: https://doi.org/10.1145/48014.63140.
- Khot and Saket, DNF hardness, DOI/PDF checked earlier: https://doi.org/10.1109/FOCS.2008.37.
- Håstad and Khot, perfect-completeness PCPs, Theory of Computing page: https://theoryofcomputing.org/articles/v001a007/.
- Karp, NP-completeness source for SAT reductions, DOI in atlas: https://doi.org/10.1007/978-3-540-68279-0_8.
- Kearns and Valiant, cryptographic learning limitations, DOI/metadata checked: https://doi.org/10.1145/174644.174647.
- Håstad, Impagliazzo, Levin, and Luby, PRGs from one-way functions, DOI in atlas: https://doi.org/10.1137/S0097539793244708.
- Goldreich and Levin, *A Hard-Core Predicate for all One-Way Functions*, author PDF checked: https://www.cs.bu.edu/fac/lnd/pdf/hard.pdf.
- Mahaney, *Sparse Complete Sets for NP*, bibliographic checks: JCSS 1982 and DOI pointer https://doi.org/10.1137/0208034. Used only as a warning about sparse-heavy-slice rescue attempts, not as a formal barrier theorem for this atlas edge.

### Theorem Route

A positive proof would need to build a proper learner $B$ from the source learner $A$. Running $A$ at small $\varepsilon$ gives an improper hypothesis $g$ close to the best proper concept:

$$
\operatorname{err}(g)
\le
\operatorname{OPT}_{\mathcal C}+\varepsilon .
$$

The target asks instead for an efficiently found representation $h\in\mathcal C$ with error at most $\operatorname{OPT}_{\mathcal C}+\beta_P(s)$.

The route fails at the same computational point as earlier depths. Uniform convergence, finite-class ERM, and marginal-dependent sample bounds show that good proper hypotheses exist; they do not show that approximate proper ERM over $\mathcal C$ is polynomial-time. The source learner may have learned by sparse lookup, empirical majority, linear prediction, or another improper representation that has no efficient inverse map into the proper representation.

Boosting is not the missing ingredient. The source is already strong, and standard boosting outputs votes or aggregates outside the base class. Feldman-style distribution-specific agnostic boosting is a useful marginal-preserving near miss, but it assumes a different weak-oracle format and still does not produce a generic proper projection.

The only theorem I can state is conditional and circular:

> If, for every fixed marginal $P$, there is an efficient approximate proper ERM/projection oracle for $\mathcal C$ at tolerance $\beta_P(s)$, then the source implies the target.

That extra oracle is exactly the desired properization content, so it is not an atlas resolution.

### Counterexample Route

#### Clause-Satisfaction Lookup

The fixed uniform-clause marginal plus fair-noise padding resolves the strong proper marginal agnostic edge, but it still does not resolve this weak target.

For a formula $F$ occupying an $\alpha$ fraction of the clause universe, every assignment has error

$$
\frac{1-\alpha}{2}+\alpha\cdot\text{formula-violation-rate}.
$$

Strong agnostic proper learning can be run at accuracy below $1/|X_n|$ and therefore recovers a satisfying assignment when one exists. A weak agnostic proper learner may allow additive tolerance $1/2-\alpha_P(s)$ with unknown inverse-polynomial $\alpha_P(s)$; the one-clause or sparse-formula gap is swallowed. Making the formula region dense enough to cross the weak threshold is not a harmless amplification, because dense CSP/MAX-SAT variants enter a different approximation regime and the checked atlas notes do not contain a source-grounded dense fixed-marginal NP-hardness construction.

#### PCP Active Slice

The PCP active-slice witness has the right local weak gap. On the marginal uniform over $\{(\varphi,r)\}$, a weak proper learner would output a proof accepted above the PCP soundness threshold for satisfiable $\varphi$. The source side is also compatible with this edge: one-slice lookup-table ERM gives strong agnostic improper learning against the proper PCP class.

The target-side reduction still fails because the hard marginal depends on $\varphi$. Marginal-nonuniform learning permits the runtime polynomial and weak advantage to depend on that marginal, so this does not yield one uniform randomized polynomial-time SAT solver.

Packing all slices into one fixed marginal multiplies the PCP gap by the slice mass $w_\varphi$. Since there are exponentially many formulas of length $n$, most slices cannot have inverse-polynomial mass. Trying to keep only polynomially many heavy hard slices per length would amount to reducing SAT to a sparse heavy-slice family. Mahaney-style sparse-complete-set results are not a formal impossibility theorem for every promise/randomized variant one might invent, but they are a strong warning that this is not a routine repair of the PCP construction.

#### One-Way Image Coordinates

The one-way image-coordinate class is the cleanest strong-proper counterexample. Its source side is excellent for this edge: sparse lookup-table ERM gives distribution-free strong agnostic improper learning. But weak proper learning can avoid inversion. Under the fixed all-length marginal, the challenged length block has mass $\mu_n$, and a wrong-length or low-support proper hypothesis can already achieve global error well below $1/2$ for large $n$. Adding explicit constants and singletons only makes this hidden weak-handle issue more visible.

A dense shared-code repair would need each wrong image to have distance at least $1/2-\eta(s)$ from the true image, with $\eta(s)$ smaller than the hidden weak advantage $\alpha_P(s)$. Polynomial-length binary codes cannot provide exact half-distance for exponentially many images at every inverse-polynomial scale; adding many scales spends marginal mass and recreates the active-slice dilution.

#### Balanced Parity / Hadamard Image Code

The final checked lead was the balanced parity-of-image idea from the weak-realizable sibling scratchpads. At a single fixed length, define

$$
c_s(r)=\langle f(s),r\rangle \pmod 2
$$

under uniform $r\in\{0,1\}^n$. Distinct image parities disagree on exactly half the domain, so any proper weak advantage would force a seed $t$ with $f(t)=f(s)$. This is the right target-side geometry.

For the present agnostic source, however, the source side breaks. In the realizable case, an improper learner can recover $f(s)$ by linear equations and output the parity indexed by the image. In the agnostic case, competing with the best image parity under arbitrary label noise is an agnostic parity-learning problem; under natural marginals such as the uniform hypercube this is exactly the kind of task connected to noisy parity/LPN hardness, not an available efficient improper learner. A full lookup-table learner over the Hadamard domain would need support size $2^n$, which is not polynomial in the representation size.

Packing lengths into one fixed marginal also returns to length-tail dilution, and using a clean product-like infinite Walsh system would leave the finitely encoded atlas setting. So this lead is useful as a diagnostic, but it is not a counterexample for a strong agnostic improper source.

### Concrete Obstruction

The final obstruction is a three-way tension.

1. Proper weak hardness must rule out every proper hypothesis with inverse-polynomial correlation, not just every hypothesis failing exact recovery.
2. Marginal-nonuniformity forbids using an input-specific hard marginal in a polynomial-time contradiction, because the hidden polynomial and hidden weak gap may depend on that marginal.
3. The source requires efficient strong agnostic improper learning. Constructions with polynomial support make lookup ERM easy but do not usually give weak-scale proper hardness. Constructions with exact half-distance, such as Hadamard/parity encodings, give the right weak geometry but make agnostic improper learning computationally hard or exponentially large.

In one sentence:

> A separation needs a fixed-marginal, weak-scale proper-only hardness construction whose labels are still strongly agnostically learnable by an efficient improper algorithm; the known clause, PCP, sparse one-way, shared-code, and parity/Hadamard templates each satisfy only two of these requirements at a time.

### Next Directions

- Keep this edge open in the atlas. Do not promote the clause or one-way witnesses to this weak agnostic proper target.
- If pursuing `false`, search for a dense fixed-marginal cryptographic/code witness with an explicit efficient agnostic improper learner. The key missing lemma is not realizable decoding; it is efficient agnostic competition with the proper seed class.
- If pursuing the PCP route, isolate a formal slice-packing lemma: under one fixed marginal, only polynomially many active slices per length can have inverse-polynomial mass. Then specify what complexity assumption would justify using a sparse hard promise family.
- If pursuing `true`, look for a representation-sensitive theorem: source plus efficient fixed-marginal approximate proper ERM/projection implies the target. Without this extra assumption, the current sources do not justify properization.
- A useful atlas expansion, if edits are later allowed, would be an argument note for "fixed-marginal weak properization obstruction" collecting the mass-vs-advantage and agnostic-source barriers.

### Atlas-Ready Open-Problem Distillation

This edge asks whether strong marginal-nonuniform agnostic improper learning always yields weak marginal-nonuniform agnostic proper learning. The positive direction lacks a computational projection theorem: an improper hypothesis near $\operatorname{OPT}_{\mathcal C}$ need not reveal any efficiently findable member of $\mathcal C$.

The negative direction also lacks a witness. Clause and PCP constructions either give only strong-accuracy gaps or put the hard instance in the marginal. One-way coordinate constructions give strong proper hardness with an agnostic improper source, but weak proper learners can exploit low-mass blocks or residual correlations. Balanced Hadamard/parity encodings remove the weak handle at a fixed length, but in the agnostic setting they no longer have an evident efficient improper learner. Thus the edge remains a genuine computational marginal-nonuniform properization open problem.

Exact atlas changes if resolved now: none.
