# Edge: efficient-marginal-nonuniform-weak-agnostic-improper-pac -> efficient-marginal-nonuniform-weak-agnostic-proper-pac

- depth: 1
- date: 2026-05-05
- verdict: unresolved-open
- confidence: medium-high

## Task

Decide whether

```text
efficient-marginal-nonuniform-weak-agnostic-improper-pac
->
efficient-marginal-nonuniform-weak-agnostic-proper-pac
```

should be resolved as true or false. I only wrote this scratchpad and did not edit atlas files.

## Bottom Line

I do not see an atlas-ready proof or counterexample. The implication should remain `open`.

The source and target differ only in properness. The source gives one uniform learner whose output may be outside $\mathcal C$ and, for every fixed marginal $P$, has a $P$-dependent polynomial bound and weak additive tolerance

$$
\beta_P(s)=1/2-\alpha_P(s)<1/2.
$$

The target asks for the same kind of marginal-dependent weak agnostic guarantee, but the output must be in $\mathcal C$.

The positive direction would require a generic efficient fixed-marginal properization procedure. The negative direction would require a fixed-marginal proper-only hardness construction that remains visible at an unknown inverse-polynomial weak advantage while preserving an easy improper weak agnostic learner. The local notes and a targeted web check did not supply either.

## Sources Checked

Local atlas files:

- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/arguments/halfspace-agnostic-hardness.md`
- `atlas/arguments/clause-satisfaction-proper-hardness.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/arguments/marginal-agnostic-hardness-open.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- `atlas/witnesses/clause-satisfaction-lookup-class.md`
- prior scratchpad for this same edge from `open-edge-resolution-2026-05-04`
- sibling scratchpads for the nearby marginal weak properization edges on 2026-05-05

External checks:

- Hanneke, Moran, and Thiessen, *Marginal-Nonuniform PAC Learnability*, OpenReview page last modified 2026-04-21: https://openreview.net/forum?id=aoVCFtox89. Relevant point: the marginal-nonuniform rate constants may depend on the marginal, while the guarantee remains uniform over concepts for that marginal.
- Ben-David, Long, and Mansour, *Agnostic Boosting*, Tel Aviv publication page / DOI: https://cris.tau.ac.il/en/publications/agnostic-boosting/. Relevant point: the classical weak agnostic notion is additive, but boosting does not by itself return a proper member of the original class.
- Kane et al., *Agnostic Proper Learning of Halfspaces under Gaussian Marginals*, PDF: https://cseweb.ucsd.edu/~dakane/ProperHalfspaceAgnostic.pdf. Relevant point: recent halfspace work gives a class-specific properization under Gaussian marginals, using structure of halfspaces and polynomial regression; it is evidence that properization can hold for special classes, not a generic theorem for this edge.

## Positive Route: Why A General Theorem Is Missing

To prove the implication true, one would need to transform an improper learner $A$ into a proper learner $B$.

For a fixed marginal $P$, the source can output an external hypothesis $g$ satisfying

$$
\operatorname{err}_{\mathcal D}(g)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\beta_P(s).
$$

The target needs an efficient procedure returning $c\in\mathcal C$ with a comparable bound. Uniform convergence can justify the existence of a good proper empirical minimizer, but it does not give polynomial-time proper ERM or projection into $\mathcal C$.

The marginal-nonuniform quantifier does not supply advice. It permits a $P$-dependent polynomial analysis for the same uniform algorithm; it does not hand the learner a $P$-specific support enumeration, cover, search tree, or projection oracle.

Agnostic boosting is also a near miss. It can improve weak guarantees under stronger oracle formulations, and distribution-specific variants can preserve the instance marginal, but the combined predictor is generally an improper aggregate. Even if weak-to-strong boosting were available for the atlas fixed-additive formulation, it would not solve the proper output constraint.

The recent Gaussian halfspace result reinforces the diagnosis rather than resolving it. It begins with an improper polynomial-regression style object and compresses it to a halfspace using halfspace/Gaussian structure. That is exactly the sort of representation-specific projection missing from the abstract source node.

Possible conditional theorem, not implied by the source:

> If for every fixed marginal $P$ the class has an efficient approximate proper ERM, an efficiently searchable weak cover by valid concepts, or a constant-slack projection oracle from good improper predictors into $\mathcal C$, then the source could be followed by that operation to obtain the target.

No local note or source shows that such structure follows from efficient marginal-nonuniform weak agnostic improper learning.

## Negative Route: Why The Known Witnesses Still Miss

### Clause-Satisfaction Lookup

The clause-satisfaction lookup class is a strong improper source: the clause universe is polynomial-size, so an improper lookup-table ERM learns agnostically. It gives fixed-marginal hardness for strong proper agnostic learning by using the uniform clause marginal and encoding the input formula in conditional labels.

This does not refute the weak target. Under the fixed clause marginal, one violated formula clause changes total error by about $1/|X_n|$. A strong learner can be run with $\varepsilon \ll 1/|X_n|$ and forced to return a satisfying assignment. A weak learner may have tolerance $\operatorname{OPT}+1/2-\alpha_P(s)$ with $\alpha_P(s)$ only some hidden inverse polynomial. Such a learner can return an assignment with weak correlation without satisfying the formula.

So clause-satisfaction resolves neighboring strong-proper targets, but not this weak-proper edge.

### PCP Active Slice

The PCP active-slice witness has the right weak proper hardness shape. If the marginal is uniform on the active slice for input $\varphi$, a weak proper learner would output a proof accepted on more than half the verifier random strings, contradicting $\mathrm{NP}\nsubseteq\mathrm{RP}$.

The problem is that the active-slice marginal depends on $\varphi$. In a marginal-nonuniform target, the runtime polynomial may depend on that marginal, so the reduction no longer gets a uniform polynomial SAT algorithm.

Packing all active slices into one fixed marginal dilutes the gap. If the hard slice has mass $w$ and the active labels have noise rate $\eta$, the active slice can force useful PCP acceptance only when roughly

$$
\beta_P(s) < w(1-2\eta)(1-s_{\mathrm{pcp}}).
$$

Because $\beta_P(s)$ may be close to $1/2$, this requires constant or near-constant mass on the hard slice. One fixed marginal cannot give that much mass to many input-specific slices.

### One-Way Image Coordinate

The one-way image-coordinate witness gives fixed-marginal strong proper hardness: sufficiently accurate proper learning recovers a seed preimage. It does not give weak proper hardness. Under the usual all-length coordinate marginal, the hard length-$n$ block has small mass, and weak learners can ignore it or use weak handles.

The weak-handle variant makes this explicit: adding constants and singleton concepts makes weak proper learning easy while preserving strong proper hardness.

The tempting repair is a shared-coordinate code. Use one fixed coordinate marginal, make proper concepts be codewords or PRG outputs indexed by hard seeds, and let the improper learner use coordinate lookup. A weak proper learner on realizable labels would need to output a seed with correlation at least $\alpha_P(s)$.

This route runs into the hidden weak-gap obstruction. For random-looking codewords over $N$ coordinates, a union bound needs

$$
\alpha_P(s)^2 N \gg \log|\mathcal C_s|
$$

to ensure that no wrong seed has enough correlation. But the atlas target permits $\alpha_P(s)$ to be an arbitrarily small inverse polynomial in the effective size parameter. If $N$ is polynomially visible so lookup ERM is efficient, the inequality can fail for the unknown exponent. If $N$ is made Hadamard-scale or exponential to get exact orthogonality, the improper source becomes parity/noisy-codeword agnostic learning rather than polynomial lookup ERM.

The prior scratchpads sharpen this into a template obstruction: exact nonpositive-correlation safety for exponentially many binary certificates over $N$ shared coordinates is blocked by Plotkin/Hadamard-type bounds, while approximate or list-decodable codes leave inverse-polynomial residual correlations. A residual correlation $s^{-K}$ may exceed the target learner's hidden advantage if that advantage is $s^{-(K+10)}$.

### Halfspaces

The halfspace hardness note does not separate this edge. Tiegel-style hardness is aimed at agnostic learning of halfspaces and can rule out improper agnostic learners in the relevant distribution-free or marginal formulations. That fails the source side of an improper-to-proper separation.

Recent proper halfspace learning under Gaussian marginals is positive for a special structured class. It shows that properization can sometimes be done by exploiting Gaussian and halfspace geometry, but it does not imply a generic conversion from arbitrary improper learners to proper learners.

## Concrete Obstacles

Positive obstacle:

> The source supplies prediction, not search. It may output an arbitrary external hypothesis. Marginal-nonuniform sample and runtime bounds do not imply efficient fixed-marginal proper ERM, a computable proper cover, or a projection from predictors to concepts.

Negative obstacle:

> A false witness must keep the marginal fixed while making every hard instance visible at the weak scale. Active-slice reductions lose mass. Clause fixed-marginal reductions produce strong-accuracy gaps but not weak gaps. Shared-coordinate code reductions either need exact weak-safe geometry, which is dimension-limited, or leave inverse-polynomial wrong-certificate correlations, which may be larger than the target's hidden weak advantage.

This makes the edge genuinely open rather than merely uncited.

## Proposed Atlas Update

No atlas update is justified.

Keep the implication metadata as:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
argument_note: "[[properization-open|Properization Open]]"
```

Optional summary refinement:

```text
Open: no efficient fixed-marginal projection from weak agnostic improper predictors to weak agnostic proper hypotheses is known, and standard fixed-marginal separations lose either the hidden weak-gap scale or the efficient improper source.
```

Optional body text:

```markdown
The source gives a uniform learner whose output may lie outside $\mathcal C$ and whose fixed-marginal weak tolerance is $\beta_P(s)<1/2$. A positive proof would need an efficient properization step under each fixed marginal, such as approximate proper ERM, a computable proper cover, or a projection oracle. These are representation-level assumptions not implied by the source.

Known false witnesses remain near misses. Clause-satisfaction fixed-marginal hardness gives only strong-accuracy gaps. PCP active-slice hardness creates a weak gap only by putting the hard instance in the marginal. One-way image-coordinate witnesses force proper recovery only at strong accuracy or admit weak handles. Shared-coordinate code repairs preserve the fixed marginal but run into the hidden-gap problem: polynomial coordinate domains leave inverse-polynomial wrong correlations, while exact Hadamard-style safety breaks the easy improper agnostic learner.
```

## Next Directions

1. Search for an agreement-style PCP or direct-product theorem where any weakly correlated proper object already reveals the target instance or witness. Ordinary list decoding is not enough because the learner returns one hypothesis, not a list.
2. Formalize the shared-coordinate lookup-ERM no-go as an auxiliary atlas argument: Plotkin/Hadamard for exact safety, and MRRW/list-decoding style bounds for approximate safety.
3. Define separate fixed-gap or requested-gap weak variants. Approximate shared codes may separate those stricter targets, even though they do not refute the present hidden-gap node.
4. Develop restricted positive results for classes with computable fixed-marginal proper covers, approximate proper ERM, or class-specific projection oracles.

verdict: unresolved-open
confidence: medium-high

---

# Depth-2 Follow-Up

- depth: 2
- date: 2026-05-05
- verdict: unresolved-open
- confidence: high that the current atlas edge should remain open; medium that the standard fixed-marginal counterexample templates are genuinely blocked rather than merely unfinished

## Task Focus

This pass tried to move past the depth-1 conclusion in one of two ways:

1. find a restricted positive theorem that is still forced by the abstract source node; or
2. turn the fixed-marginal projection failure into a concrete false witness.

I did not find either. The edge still looks like a real open properization problem. The useful progress is a sharper description of why the two most tempting counterexample repairs, shared PCPs and fixed-marginal PRG/code families, fail for the current hidden-gap marginal-nonuniform weak target.

## Positive Route Audit

The only positive theorem shape I can justify is conditional:

> If every class satisfying the source also had an efficient fixed-marginal weak proper selector, then the edge would be true.

More explicitly, for a fixed marginal $P$, suppose there is a uniform procedure which, from samples and optional evaluation access to an improper predictor $g$ with

$$
\operatorname{err}_{\mathcal D}(g)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\varepsilon,
$$

outputs some $h\in\mathcal C$ satisfying

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+1/2-\gamma_P(s)
$$

for inverse-polynomial $\gamma_P$. Then the source learner followed by this selector gives the target.

This is not an atlas resolution because the selector is exactly the missing computational content. Marginal nonuniformity gives a $P$-dependent polynomial analysis of one learner; it does not give $P$-dependent advice, an enumeration of a useful support, a proper ERM oracle, or a projection map into $\mathcal C$.

Recent halfspace work is a good sanity check but not a generic theorem. Diakonikolas, Kane, Kontonis, Tzamos, and Zarifis give a proper agnostic learner for halfspaces under Gaussian marginals with complexity comparable to the best improper learner, but their proof uses Gaussian and halfspace structure. Tiegel's hardness result points the other way for distribution-independent and certain distribution-specific agnostic halfspace learning: it rules out even improper binary hypotheses under lattice assumptions, so halfspaces do not satisfy the source side of this edge. Thus the halfspace literature supports "class-specific properization can happen" and "agnostic improper learning can already be hard", not "all efficient weak agnostic improper learners can be properized".

## Counterexample Attempt 1: Shared PCPs

The PCP active-slice witness gives the right weak proper hardness only because the marginal names the input instance. For a satisfiable instance $\varphi$, the active slice distribution over verifier randomness has a proper proof with error $0$; for an unsatisfiable instance, every proof has error above $1/2$. A weak proper learner would distinguish.

The marginal-nonuniform target absorbs that construction, because the runtime polynomial may depend on the active-slice marginal. The natural repair is to use one fixed marginal over a shared randomness space $R_n$ and let proper concepts be instance-proof pairs

$$
h_{\psi,\pi}(r)=V(\psi,\pi,r).
$$

This loses identity. With perfect completeness, any satisfiable unrelated instance $\psi$ has a proof $\pi_\psi$ for which $h_{\psi,\pi_\psi}$ is the all-one function on $R_n$. That proper hypothesis is a perfect weak handle for every target whose labels are all $1$, including unsatisfiable target instances. If we add an identity coordinate to stop wrong-instance handles, we have recreated the active-slice marginal. If we pack all identities into one marginal, each hard slice has too little mass.

This is more than a bookkeeping problem. The weak agnostic target only needs some additive advantage over $1/2$, with hidden inverse-polynomial gap $\alpha_P(s)$. A packed slice of mass $w_\varphi$ contributes only $w_\varphi$ times the local PCP gap. Unless $w_\varphi$ is comparable to the hidden $\alpha_P(s)$, the learner may ignore the slice and still satisfy the target. One fixed marginal cannot give polynomially visible mass to exponentially many input slices.

## Counterexample Attempt 2: Fixed-Marginal PRG Or Code Families

The most attractive fixed-marginal idea is to put all hard instances on one coordinate domain $Q_s$ and make proper concepts be codewords. For example, a seed or witness $z$ determines a binary vector $C_z\in\{\pm 1\}^{Q_s}$, the marginal is uniform on $Q_s$, and the label rule is $Y_z=C_z$. An improper learner can be easy if $|Q_s|=N(s)$ is polynomially visible: lookup-table ERM on coordinates competes with every proper codeword.

To refute the weak proper target, however, every nonrevealing proper certificate must have correlation below the learner's hidden weak advantage:

$$
\langle C_t,Y_z\rangle_P < 2\alpha_P(s)
\quad\text{for all useless }t.
$$

Exact safety would require nonpositive correlation for all wrong certificates. For exponentially many hard messages on $N$ binary coordinates, this is in the Plotkin/Hadamard regime and supports only $O(N)$ mutually nonpositively correlated codewords. Getting exact orthogonality for exponentially many messages pushes the coordinate domain to Hadamard size; then the easy lookup-ERM source is no longer polynomial in the hard instance size, or the source becomes agnostic parity/correlation search on an implicit domain.

Approximate safety is not enough for the atlas node. Polynomial-length dense codes or PRG output vectors can leave wrong-code correlations around an inverse-polynomial scale. For any fixed scale $s^{-K}$ this can be beaten by increasing the coordinate length, but the target's $\alpha_P(s)$ is not a requested parameter. It may be $s^{-(K+10)}$. Encoding all exponents by adding levels either makes the lookup domain superpolynomial in the represented size, or inflates the represented size so the residual correlation is again only inverse-polynomial in that size.

Cryptographic phrasing does not remove the obstacle. A PRF-style family usually makes even weak prediction hard, which violates the source. A PRG/image-code family with polynomial explicit output length keeps the source plausible by lookup ERM, but weakly correlated wrong seeds may exist at the hidden-gap scale. A useful cryptographic witness would need all of the following at once:

1. one fixed high-mass marginal;
2. efficient weak agnostic improper learning, preferably by a relaxation richer than the proper family;
3. hardness of finding any proper hypothesis with inverse-polynomial correlation, at every hidden inverse-polynomial scale allowed by the target.

I do not see a standard construction with these three properties.

## Why Clause And DNF Witnesses Do Not Fill The Gap

The clause-satisfaction lookup class resolves strong proper agnostic targets, but not this weak target. Under the fixed uniform clause marginal, a proper agnostic learner run to accuracy $O(1/|X_n|)$ must find a satisfying assignment. A weak learner is not run to a requested accuracy; it may tolerate nearly $1/2$ excess error. The fair-noise padding that makes the fixed marginal work for strong learning also raises the baseline so a weak guarantee need not expose a satisfying assignment.

Fixed-$k$-term DNF goes in the opposite direction. It is a proper weak positive example used for weak-to-strong proper separations. Since it already satisfies the target, it cannot separate improper weak learning from proper weak learning.

## Depth-3 Directions

1. **Identity-protected fixed-marginal PCP.** Look for a PCP or agreement-test construction where every weakly correlated proper output on one shared marginal identifies the target instance or yields a witness for it. A small list of nearby objects is not enough; the learner returns one hypothesis, and wrong satisfiable instances must not become handles.

2. **Formal lookup-code no-go.** Turn the code obstruction into a lemma for atlas use: if the improper source is lookup ERM over an explicit coordinate domain of size polynomial in representation length, then pairwise-distance safety cannot defeat all hidden inverse-polynomial weak gaps for exponentially many hard messages.

3. **Non-lookup improper relaxations.** Search for a relaxation of Hadamard/parity or PRG-code concepts that is efficiently agnostically learnable under arbitrary labeled distributions without recovering the proper seed. This is the one route where exact weak-safety geometry might coexist with an easy improper source, but it currently looks parity-hard.

4. **Restricted positive theorem.** Add a separate lemma for classes with efficient fixed-marginal weak trace selectors, computable $L_1(P)$ covers by valid concepts, finite effective supports plus proper search, or approximate proper ERM. This would not settle the global edge, but it would name the extra structure missing from the source definition.

5. **Definition audit.** Keep the representation-size and explicit-domain conventions visible. Several near-counterexamples work only by making the coordinate domain polynomial in a hidden hard length but superpolynomial in the atlas representation length, which is not an efficient source witness.

## References Checked

- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/clause-satisfaction-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/arguments/fixed-k-term-dnf-proper-boosting-separation.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- sibling scratchpad `efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`
- Diakonikolas, Kane, Kontonis, Tzamos, and Zarifis, "Agnostic Proper Learning of Halfspaces under Gaussian Marginals", COLT 2021: https://proceedings.mlr.press/v134/diakonikolas21b.html
- Tiegel, "Hardness of Agnostically Learning Halfspaces from Worst-Case Lattice Problems", COLT 2023: https://proceedings.mlr.press/v195/tiegel23a.html

verdict: unresolved-open
confidence: high

---

# Depth-3 Follow-Up

- depth: 3
- date: 2026-05-05
- verdict: unresolved-open
- confidence: high that the shared-code/PRG lookup route is blocked as an atlas-ready counterexample; medium-high that the edge itself remains genuinely open

## Task Focus

This pass tried to force the fixed-marginal code/PRG construction into a real
separation. I did not find a counterexample. I can make the obstruction more
formal for the natural version of the route:

1. use one fixed coordinate marginal, usually uniform on an explicit block;
2. make proper concepts be codewords or PRG output strings indexed by hard
   seeds/witnesses;
3. make the improper source easy by allowing lookup-table or sparse-table ERM
   over that explicit coordinate block; and
4. prove weak proper hardness by saying that any sufficiently correlated proper
   codeword identifies the hidden seed/witness.

The obstruction is not just that the weak gap is unknown to the reduction. The
problem is that polynomial-size explicit coordinate blocks necessarily leave
inverse-polynomial wrong-codeword correlations at some scale, while the target
learner is allowed to have an even smaller inverse-polynomial advantage.

## The PRG Distinguisher Attempt

The cleanest attempted false witness is:

- choose a generator or code map
  $G_n:\{0,1\}^n\to\{\pm 1\}^{N(n)}$;
- let the fixed marginal on the length-$n$ block be uniform over coordinates
  $i\in[N(n)]$;
- let a proper concept be a seed $z$ with value $G_n(z)_i$ at coordinate $i$;
- let the improper learner use coordinate lookup-table ERM, so agnostic
  improper learning is easy when $N(n)$ is polynomially visible.

On the realizable distribution labeled by $G_n(z)$, a weak proper learner with
gap $\gamma(n)$ returns some seed $t$ satisfying

$$
\mathbb E_i[G_n(t)_iG_n(z)_i]\ge 2\gamma(n).
$$

One would like to turn this into a distinguisher or inverter: run the learner on
coordinate samples from a challenge string $y$, output "generator" if the
returned seed has noticeable correlation with $y$.

This reduction only has a sound random-string case if a random
$y\in\{\pm 1\}^{N(n)}$ has no seed $t$ with correlation at the learner's
threshold. A union bound gives

$$
\Pr_y\left[\exists t:\left|\mathbb E_i[G_n(t)_iy_i]\right|\ge \tau\right]
\le
2^n\exp(-\Omega(N(n)\tau^2)).
$$

Thus the distinguisher proof needs roughly

$$
N(n)\tau^2 \gg n.
$$

If $N(n)=n^d$, this excludes random handles only down to
$\tau\approx n^{-(d-1)/2}$, up to logarithmic factors. But the atlas target may
have a hidden gap $\gamma(n)=n^{-K}$ for any larger $K$ depending on the fixed
marginal and on the alleged learner. For such a learner, random strings can
have proper codeword handles at the same scale that the reduction needs to
validate. Then PRG pseudorandomness or one-wayness does not contradict the weak
proper learner: the learner is only forced to output a weakly correlated seed on
true codewords, and the validation test may no longer separate true generator
outputs from random strings.

Increasing $N$ repairs any fixed requested exponent. It does not repair the
current node. If $N(n)=n^d$ for one fixed $d$, there is still a smaller hidden
gap. If one lets $d$ grow with the instance or packs many exponents into one
class, then either lookup-table agnostic learning costs $N(n)$ and is no longer
polynomial in the atlas size parameter, or the construction reintroduces a
low-mass active-slice problem.

## Coding-Theoretic Form Of The Same Obstruction

The previous paragraph used random-string handles. The intrinsic code version
is similar. Suppose the hard family contains
$M_s$ proper codewords on an explicit coordinate block of size $N_s$, with
$M_s$ exponential in the hard seed length and $N_s$ polynomial in the atlas size
parameter $s$.

To make proper weak learning reveal the correct seed by information-theoretic
geometry alone, one would want every wrong codeword to have correlation below
the learner's hidden advantage:

$$
\langle C_u,C_v\rangle_P < 2\gamma_P(s)
\qquad (u\ne v).
$$

For binary codes under a uniform block, standard Plotkin/Hadamard bounds give
only $O(N_s)$ codewords at nonpositive pairwise correlation. Allowing a positive
threshold $\tau$ permits exponentially many codewords, but only at rate on the
order controlled by $N_s\tau^2$ (up to the usual logarithmic/list-decoding
losses near distance $1/2$). Equivalently, with $M_s$ exponentially large and
$N_s=s^d$, one cannot rule out wrong-code correlations at some inverse
polynomial scale. Making $\tau$ smaller than every inverse polynomial forces
$N_s$ superpolynomial for this lookup-code template.

This is enough to block the pure shared-code argument:

> A polynomial-coordinate lookup-code witness can be made safe for a fixed
> advertised weak gap, but it cannot be made safe for the atlas target's
> hidden marginal-dependent inverse-polynomial gap while keeping the improper
> agnostic learner as explicit lookup ERM.

This is a route-specific obstruction, not a proof that the implication is true.
It leaves open a more subtle computational construction in which weakly
correlated wrong handles exist but are themselves hard to find.

## Why This Does Not Yet Resolve The Edge

The obstruction above defeats the obvious false proof shape, but it is not a
black-box properization theorem.

On the positive side, the source learner still only returns an external
predictor. Even if that predictor has weak advantage over the best proper
concept, there is no generic way to search $\mathcal C$ for a proper concept
with weak advantage. Uniform convergence gives existence and unbounded ERM; it
does not give polynomial-time proper ERM, a fixed-marginal cover, or a
projection from an arbitrary predictor to a concept.

On the negative side, a future counterexample could avoid the pure-geometry
obstruction by making weak handles computationally hard to find rather than
information-theoretically absent. That would need more than a standard PRG
hybrid: the reduction must handle the fact that the weak learner's gap is
unknown and that random or wrong-codeword handles may exist at smaller
inverse-polynomial scales.

## Depth-4 Directions And Obstacles

1. **Formal polynomial-coordinate lemma.** Write a standalone lemma for the
   lookup-code template: if $M_s$ hard proper objects are encoded as binary
   functions on $N_s=\operatorname{poly}(s)$ explicit coordinates, then
   pairwise correlation cannot be bounded below every inverse polynomial unless
   $M_s$ is only polynomial. The weighted-marginal version should use effective
   support or truncate to a high-mass finite block.

2. **Computational weak-handle hardness.** Search for a construction where
   wrong weakly correlated proper hypotheses may exist, but finding any such
   hypothesis from samples is as hard as solving the original problem. This is
   the main remaining PRG/code escape hatch, and it needs a validation argument
   that survives an unknown $\gamma_P(s)$.

3. **Oracle separation attempt.** An oracle class could diagonalize against
   proper weak learners while leaving an explicit improper lookup learner. This
   would test whether the edge is likely false for purely computational reasons
   even though natural PCP/PRG templates fail.

4. **Requested-gap variant.** Define or inspect a variant where the weak learner
   must meet a supplied gap parameter, or where the weak gap is fixed in the
   node. Polynomial-length codes and PRG outputs look much more promising for
   that strengthened target, because $N$ can be chosen as a polynomial in the
   requested $1/\gamma$.

5. **Positive selectors.** Develop restricted positive results for classes with
   efficient fixed-marginal weak selectors: approximate proper ERM, computable
   $L_1(P)$ covers by valid concepts, baseline proper hypotheses with error at
   most $1/2$, or projection oracles from good improper predictors. These
   assumptions name exactly what the abstract source node does not provide.

## References Checked In This Pass

- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- sibling scratchpad `efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac/scratchpad.md`
- sibling scratchpad `efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`

verdict: unresolved-open
confidence: high

---

# Depth-4 Follow-Up: Hidden-Gap Escape Routes

- depth: 4
- date: 2026-05-05
- verdict: unresolved-open
- confidence: high that the all-exponents/list-decoding variants below do not
  yet resolve the edge; medium-high that the edge itself should remain open

## Task Focus

Depth 3 isolated the quantitative obstruction for polynomial-coordinate
lookup or PRG witnesses: for any fixed advertised weak gap one can make the
coordinate block long enough, but the target learner's actual
marginal-dependent gap is hidden and may be a smaller inverse polynomial. This
pass tested three possible repairs:

1. include all coding exponents in one class;
2. use representation padding so the lower-bound proof can choose a large
   coordinate exponent after seeing the alleged learner; and
3. replace unique decoding by list decoding or agreement decoding.

I do not see an atlas-ready resolution. The useful conclusion is that these
repairs mostly move the hidden-gap obstruction into the size parameter,
the fixed marginal, or the source-side agnostic learner.

## All-Exponents Coding

The tempting idea is to build, for each exponent $q$, a shared-coordinate
subconstruction whose wrong proper certificates have correlation at most
$s^{-q}$. If a target learner has hidden advantage
$\gamma_P(s)\ge s^{-K}$, then a lower-bound proof could choose $q>K$ and force
the learner to return a certificate revealing the hard object.

This works only as a per-exponent thought experiment. To become a single atlas
witness, the construction must say how the exponent $q$ is represented and how
one fixed marginal supports all hard sizes.

If $q$ is charged to the representation by padding the concept or the
coordinate system, then the weak gap is measured in the padded size $S$, not in
the original hard length $n$. A code of length polynomial in $S$ can suppress
wrong correlations to some inverse polynomial in $S$ chosen by the
construction, but the target's hidden gap may be $S^{-K'}$ for a larger $K'$.
Making the coordinate domain superpolynomial in $S$ would restore the geometry,
but then the improper lookup or finite-domain ERM is no longer efficient in the
atlas size parameter.

If $q$ is not charged to the representation and is instead absorbed into a
fixed-marginal polynomial, then the source proof becomes fragile. A marginal
concentrated on one exponent block may allow a $q$-dependent polynomial, but a
single learner must satisfy the source for every marginal, including marginals
that mix unbounded exponents. For such marginals there need not be one
polynomial sample bound for arbitrary lookup ERM unless the high-exponent tail
is ignored. Ignoring the tail is exactly what the lower bound cannot permit if
that tail is supposed to beat the hidden weak gap.

There is also a fixed-marginal geometry problem independent of the exponent
bookkeeping. Under the atlas finite-encoded transcript convention, a fixed
countable marginal $P$ has most of its mass on a finite set $F$. For any
$\varepsilon>0$, choose $F$ with $P(F)>1-\varepsilon$. Among sufficiently many
binary proper concepts, two agree on all of $F$ by pigeonhole, so their
correlation under $P$ is at least $1-2\varepsilon$. Thus a pure geometry
construction over one fixed atomic marginal cannot make an unbounded hard
family pairwise noncorrelated, let alone safe below every inverse polynomial.
This does not rule out a computational lower bound where weak handles exist
but are hard to find, but it blocks the clean all-exponents codebook route.

## Representation Padding

Padding helps only in the usual fixed-gap sense. If a hard length-$n$ instance
is padded to size $S=n^r$, then a coordinate domain of size $n^{O(r)}$ becomes
polynomial in $S$ and lookup ERM can remain efficient. For any fixed alleged
gap exponent this can be arranged with $r$ large enough.

The hidden-gap target changes the accounting. The proper learner's advantage
is allowed to shrink as an inverse polynomial in $S$. Increasing $S$ therefore
lowers the required advantage at the same time as it makes the code longer.
For polynomial-coordinate constructions this is a treadmill: after padding,
wrong-code correlations are still only controlled at some inverse-polynomial
scale in the parameter used by the learner.

One might try to choose the padding exponent after fixing the alleged proper
learner. That is a legitimate shape for a contradiction only if the resulting
class has a uniform source learner and the lower-bound marginal is fixed once
and for all. I do not see how to satisfy both conditions. If the proof uses a
separate marginal for the chosen padding exponent or hard length, the
marginal-nonuniform target can hide the search in that marginal's polynomial.
If all padded regimes are packed into one marginal, either the hard regime has
too little mass for a weak additive guarantee or the atomic high-agreement
obstruction above produces weak handles.

## Hadamard-Style Exact Codes

Hadamard encodings show what would be needed to beat the hidden gap. At one
fixed length and under the uniform coordinate marginal, encoding an image
$y=f(s)$ by

$$
H_y(r)=\langle y,r\rangle \pmod 2
$$

makes every wrong image exactly uncorrelated. Then any proper weak learner on
realizable labels must output a seed $t$ with $f(t)=y$.

The source and marginal requirements are the blockers.

First, the fixed-length uniform marginal cannot be used directly for a
marginal-nonuniform lower bound over all lengths, because the polynomial bound
for that marginal may depend on the length. Packing lengths into one
finite-encoded marginal gives each length vanishing mass, so weak learning can
ignore the active length unless the concept also carries a length-identity code
on high mass. That identity code is another instance of the same
all-length orthogonality problem.

Second, the agnostic improper source is no longer lookup ERM. In the realizable
case, an improper learner could recover the image parity by linear algebra and
output the parity vector rather than a preimage. In the agnostic case, if the
best image parity has non-negligible noise, finding a correlated parity is the
usual noisy-parity/correlation-search problem. One can make a very-low-noise
weak guarantee plausible by taking a tiny inverse-polynomial source gap and
using a clean-sample event, but that does not give the full weak agnostic
source for arbitrary fixed marginals and arbitrary conditional labels. The
Hadamard repair therefore fixes the target-side hidden gap by sacrificing the
easy improper agnostic learner.

## List-Decoding And Agreement

List decoding weakens the target-side requirement from "every weakly close
proper object is the right one" to "every weakly close proper object belongs to
a short list." That is not enough for this edge.

The learner returns one proper hypothesis, not a list. If it returns a wrong
list element that is still weakly correlated with the challenge labels, the PAC
guarantee has been met. The reduction can validate and reject that element, but
rerunning the same learner on the same distribution need not produce a
different element. Adaptive elimination would require changing the conditional
labels while preserving the same marginal and while keeping
$\operatorname{OPT}_{\mathcal C}$ low. I do not see a way to do this without
knowing the hidden gap or consuming the weak slack after only a few
eliminations.

Quantitatively, list decoding near radius $1/2-\alpha$ also inherits the same
scale problem. For $\alpha=s^{-K}$ with hidden $K$, the relevant list sizes and
coordinate lengths have to be polynomial at an unknown exponent. If the code
is fixed at polynomial length, wrong list elements may remain at a larger
inverse-polynomial correlation. If all exponents are included, the bookkeeping
and fixed-marginal obstacles above return.

Agreement-test PCPs have the same issue in a different language. A weakly
agreeing proof for an unrelated satisfiable instance is a valid weak handle
unless the agreement theorem decodes the target identity from any weak
agreement. But forcing target identity from arbitrary weak agreement is again
a near-Hadamard identity-code requirement over one fixed marginal.

## Current State

The hidden-gap obstruction is not resolved. The all-exponents and padding
ideas can beat any fixed gap but do not produce a clean single-class,
single-marginal separation in the atlas model. List decoding and agreement
reduce the amount of geometry needed, but they do not address the fact that
the learner may legally return one wrong weak handle.

This leaves the edge open for the same two reasons as before:

- A positive proof still needs a generic efficient fixed-marginal proper
  selector or projection, and the source gives only an improper predictor.
- A negative proof still needs a fixed-marginal construction where weak
  handles either do not exist at the hidden inverse-polynomial scale or are
  computationally hard to find, while the improper weak agnostic learner
  remains efficient.

## Depth-5 Directions And Obstacles

1. **Computational weak-handle hardness.** The most plausible false route is no
   longer pure coding distance. It should allow wrong weak handles to exist but
   make finding any of them as hard as finding the true witness. The obstacle is
   validation: a reduction must still distinguish useful and useless outputs
   without knowing the learner's hidden gap.

2. **Diagonal or oracle witness.** Try an oracle construction that diagonalizes
   against proper weak learners while preserving an explicit improper weak
   learner. This may clarify whether the remaining obstruction is merely the
   natural-code template or a real consequence of the definitions.

3. **Atomless or succinct-domain audit.** Exact orthogonal systems exist over
   atomless spaces, but the atlas computational model assumes finite encoded
   sample transcripts. A depth-5 pass could check whether any permitted
   succinct or real-valued instance model evades the finite-atom pigeonhole
   obstruction without making samples non-computational.

4. **Adaptive list-elimination formalization.** If list decoding is to work,
   one needs a procedure that, after rejecting a wrong proper output, changes
   only the conditional labels under the same marginal and preserves a low
   proper optimum for the true certificate. The obstacle is that each change
   may raise $\operatorname{OPT}$ or shrink the effective advantage below the
   hidden $\gamma_P(s)$.

5. **Restricted positive theorem.** Formalize a selector theorem for classes
   with efficient fixed-marginal weak covers, approximate proper ERM, or
   projection from predictors to concepts. This would not prove the edge, but
   it would isolate exactly which extra representation-level assumption all
   counterexamples must violate.

## References Checked In This Pass

- `atlas/README.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`

verdict: unresolved-open
confidence: high

---

# Depth-5 Follow-Up: Source-Readable Hints Versus Hidden Gaps

- depth: 5
- date: 2026-05-05
- verdict: unresolved-open
- confidence: high that the two-channel construction below does not resolve
  the edge; medium-high that the edge should remain open pending a genuinely
  new weak-handle hardness idea

## Task Focus

Depth 4 left one plausible escape route: maybe exact orthogonality can beat the
hidden weak gap, while a separate easy channel lets the improper learner avoid
agnostic parity or noisy-codeword search. This pass tried to make that work.

I do not see a valid construction. The attempt sharpens the obstruction into a
trilemma:

1. an exact high-mass hard channel makes every proper weak output identify the
   hidden object;
2. a polynomial-mass hint channel makes the improper learner efficient; but
3. unless that hint channel is itself hidden-gap-safe, it creates inverse-
   polynomial proper weak handles, and making it hidden-gap-safe turns it back
   into the same hard agnostic coding problem.

## Two-Channel Construction Attempt

Work in $\{\pm1\}$ notation. Let a hidden seed $z$ have image
$y=f(z)$ under a one-way map. Split one fixed marginal as

$$
P = (1-\lambda)P_H + \lambda P_R .
$$

The hard channel $H$ uses an exact orthogonal code, for example a Hadamard
character:

$$
c_z(r)=\chi_{f(z)}(r) \qquad r\sim P_H .
$$

If $y'\ne y$, then

$$
\mathbb E_{P_H}[\chi_y(r)\chi_{y'}(r)] = 0 .
$$

Thus, on the $H$ channel alone, any proper hypothesis with positive correlation
must have the same image and therefore inverts the one-way map. This is exactly
the feature missing from polynomial shared-code attempts.

The source-side problem is agnostic improper learning. Learning the best image
character from random labeled examples under $P_H$ is noisy parity/correlation
search, not lookup ERM. So add a readable channel $R$ whose labels reveal enough
about $y$ for an improper learner to recover an external descriptor and then
predict on $H$. For instance, $R$ might expose direct bits or a polynomial-length
codeword $A_y$.

This gives the hoped-for source story only if $\lambda$ is inverse-polynomial
in the representation size $S$. Otherwise the learner cannot see enough of $R$
in polynomially many samples to recover the descriptor. But once $\lambda$ is
inverse-polynomial, the proper learner can also use whatever correlations the
proper concepts have on $R$.

Suppose the $R$ labels are part of the proper concepts, so that the target
distribution remains realizable or near-realizable by $c_z$. If the $R$ code is
polynomially visible, then the same coding obstruction returns on $R$: for
exponentially many possible images and only polynomially many readable
coordinates, wrong proper objects cannot all have correlation below every
inverse polynomial. There is some residual scale

$$
\rho_R(S) \ge S^{-a}
$$

for a wrong image or wrong seed, unless the $R$ channel is itself Hadamard-scale
or otherwise exact-orthogonal. The global wrong correlation is then roughly

$$
\lambda \rho_R(S) \ge S^{-(a+b)}
$$

when $\lambda\ge S^{-b}$. A target learner whose hidden advantage is only
$S^{-(a+b+10)}$ may legally output this wrong proper concept. Validation does
not help: the wrong concept is not an error of the learner; it satisfies the
weak PAC promise.

If the $R$ channel is made exact-orthogonal too, then it no longer looks like an
easy readable hint. It is another Hadamard/parity-style channel. The improper
source has to solve agnostic correlation search on the hint itself, or the
coordinate domain becomes superpolynomial for lookup-style ERM.

## Why Non-Concept Hints Do Not Save It

A more devious variant is to let the labels on $R$ reveal $y$ but not require
proper concepts to match those labels. Then the hint need not create proper
weak handles, and an improper learner could use the hint to predict the hard
channel.

This fails the source quantifier. The source learner must work for every joint
distribution with the same marginal, not only for specially designed
distributions where the non-concept labels honestly reveal the best concept.
Under the same marginal, choose labels on $H$ that are close to some image
character and make the labels on $R$ independent noise or misleading hints.
The best proper concept is still determined by the $H$ channel, but the
improper learner can no longer recover it from $R$. It is back to agnostic
parity/correlation search on $H$.

So hints outside the concept class can make one lower-bound distribution easy,
but they do not prove efficient marginal-nonuniform weak agnostic improper
learnability of the class.

## Atomless And Succinct-Domain Audit

Exact orthogonal systems over succinct domains are real: Hadamard characters
on $\{0,1\}^m$ have exponentially many pairwise orthogonal concepts with
polynomial-time evaluation and polynomial-length samples. This beats the
finite-coordinate Plotkin obstruction at the level of representation.

The obstacle is not evaluation; it is agnostic learning from random examples.
For realizable labels, Gaussian elimination can recover the image vector
without finding a preimage. For agnostic labels, even weakly finding a
correlated hidden character is the noisy parity problem. Membership-query or
Fourier-oracle algorithms would change the model, but the atlas PAC learner
gets random examples. Thus succinct exact orthogonality solves the target-side
hidden-gap problem precisely by leaving the source side unsupported.

For countable fixed marginals, the depth-4 finite-atom argument still explains
why pure geometry cannot do the job: most mass lies on a finite set, and a
large enough binary proper family contains many concepts agreeing there. A
succinct uniform block avoids that only by moving to exponentially many
possible sample points, where random-example agnostic correlation search
becomes the hard part.

## Current Strongest Open Summary

The implication should remain open.

The positive route still lacks a generic selector. The source gives an external
predictor with weak agnostic excess error, but it gives no polynomial-time
procedure for finding any valid concept with nontrivial advantage. Uniform
convergence supplies existence, not representation search; marginal
nonuniformity supplies a $P$-dependent polynomial analysis, not $P$-dependent
advice, covers, projections, or proper ERM.

The negative route now looks constrained by the following tradeoff:

- **Active-slice PCPs** get a constant weak gap, but only by making the hard
  instance part of the marginal.
- **Polynomial lookup/code witnesses** keep the source easy and the marginal
  fixed, but leave inverse-polynomial wrong proper correlations.
- **Hadamard or parity witnesses** remove wrong correlations at every hidden
  inverse-polynomial scale, but the improper agnostic source becomes noisy
  parity/correlation search.
- **Readable-hint hybrids** either put the hint inside the proper concepts,
  where it creates inverse-polynomial weak handles, or keep the hint outside
  the concepts, where the source guarantee fails on other conditionals with
  the same marginal.

Thus a real false witness needs something stronger and more computational than
"wrong handles do not exist." It must allow the hidden weak-gap scale while
making every efficiently findable proper weak handle decode a hard certificate,
yet still provide an efficient improper weak agnostic learner for arbitrary
conditional labels under the same fixed marginal. None of the current
templates has all three properties.

## Final Depth-6 Directions

1. **Computational weak-handle hardness, not geometric absence.** Look for a
   fixed marginal where wrong weak handles may exist, but every polynomial-time
   way of finding one yields a certificate or inversion. The missing piece is a
   validation argument that does not know the learner's hidden gap and cannot
   simply reject legal weak outputs.

2. **Agnostically learnable exact-orthogonal relaxations.** Search for a
   non-parity exact-orthogonal family where an external descriptor is weakly
   agnostically learnable from random examples, while converting that descriptor
   to a proper representation is hard. This is the cleanest possible way to
   beat the hidden gap, but Hadamard/image-character attempts reduce to noisy
   parity.

3. **Hint-channel no-go lemma.** Formalize the two-channel obstruction: any
   polynomial-mass source-readable channel that is represented by proper
   concepts must itself be hidden-gap-safe; if it is only polynomially coded,
   it leaves inverse-polynomial proper handles, while if it is exact-coded it
   stops being an easy agnostic source.

4. **Selector conditional theorem.** State the strongest positive theorem with
   an explicit extra assumption: source plus fixed-marginal approximate proper
   ERM, a computable proper weak cover, or a projection/selector from external
   predictors to legal concepts implies the target. This will make clear that
   the open edge is exactly a missing search principle.

5. **Oracle or black-box model test.** A relativized example may clarify
   whether the remaining obstruction is methodological or definitional. The
   oracle should expose an improper predictor or descriptor while hiding every
   proper weak selector; it must still satisfy the full agnostic source
   quantifier, not just realizable examples.

6. **Separate fixed-gap nodes.** Shared-code and readable-hint constructions
   may separate variants where the weak advantage is requested or fixed in
   advance. They should not be used as evidence against this hidden-gap
   marginal-nonuniform edge without an additional all-exponents argument that
   survives the size-parameter renormalization.

## References Rechecked

- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- sibling scratchpad `efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`
- sibling scratchpad `efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`

verdict: unresolved-open
confidence: high

---

# Depth-6 Final Pass: Low-Noise Hadamard Revival And Final Open Verdict

- depth: 6
- date: 2026-05-05
- verdict: unresolved-open
- confidence: high

## Task Focus

This final pass tested the strongest remaining escape route from the depth-5
trilemma. The earlier note treated Hadamard/image-character witnesses as source
failures because agnostic parity is hard. There is a subtle repair: for the
atlas weak agnostic source, the gap may be chosen extremely small, so the
low-noise robustification argument can sometimes turn realizable parity
learning into weak agnostic improper learning. I checked whether this revives a
Hadamard-coded one-way-function counterexample.

It does not give an atlas-ready resolution. The route works at one isolated
length and one isolated marginal, but it fails when converted into one fixed
finite-encoded marginal with polynomial bounds across all hard lengths.

## Final Counterexample Attempt: Hadamard-Coded One-Way Images

Assume a length-preserving one-way map $f_n:\{0,1\}^n\to\{0,1\}^n$. A tempting
concept class has proper concepts

$$
c_s(r)=\chi_{f_n(s)}(r)
$$

where $r\in\{0,1\}^n$ and $\chi_y(r)=(-1)^{\langle y,r\rangle}$. Under the
uniform Hadamard marginal on $\{0,1\}^n$, distinct images are exactly
orthogonal. Hence, on realizable labels $c_s$, any proper weak learner with any
positive advantage must output $t$ with $f_n(t)=f_n(s)$.

The source side is less hopeless than depth 5 made it sound. Parities are
efficiently realizably learnable from random examples by linear algebra, and an
improper learner may output the recovered image/parity vector rather than a
seed. The atlas [[low-noise-weak-agnostic-robustification|low-noise
robustification]] then gives a weak agnostic improper learner with a very small
inverse-polynomial gap: if $\operatorname{OPT}$ is above that gap, a constant
predictor is already within $\operatorname{OPT}+1/2-\alpha$; if
$\operatorname{OPT}$ is below the gap, repeated clean-batch runs of the
realizable learner and validation recover a good external parity.

So at a single length, with the marginal fixed to the uniform Hadamard cube for
that length, the construction has exactly the desired flavor.

## Why This Still Fails The Marginal-Nonuniform Edge

The lower bound needs one fixed marginal $P$ for infinitely many hard lengths.
Using a separate uniform Hadamard marginal $P_n$ for each length is not enough:
the marginal-nonuniform target may attach a different polynomial $p_{P_n}$ to
each $P_n$, with no uniform polynomial bound from which to build a one-way
function inverter.

Packing the length-$n$ Hadamard cubes into one finite-encoded marginal brings
back active-mass dilution. If the length-$n$ block has mass $w_n$, then a wrong
same-length image has global error only $w_n/2$ on the orthogonal block, plus
whatever bookkeeping errors occur elsewhere. Since $w_n\to 0$, this error is
far below the weak target threshold $1/2-\alpha_P(s)$ for large $n$. The weak
proper learner may legally output a wrong image; exact orthogonality on the
active slice is invisible at the global additive weak scale.

Making each length-$n$ concept depend on all longer sample strings does not fix
this under finite encodings. For every probability distribution on finite
strings, the tail mass of strings long enough to support the first $n$ random
bits tends to zero. To keep mass one for every $n$ would require samples that
contain an infinite random string or oracle access to one, which is outside the
atlas convention that computationally efficient learners have worst-case
polynomial bounds on finite encoded sample transcripts.

Nor can one put an infinite Hadamard system on a single countable finite-string
marginal by pure geometry. Let $x_0$ be an atom of maximum mass $p>0$. Among a
large family of binary concepts, a subfamily of half the concepts agrees on
$x_0$. Inside that subfamily, nonpositive pairwise correlations under $P$ would
force the correlations on the remaining mass to be at most $-p/(1-p)$. The
standard positive-semidefinite/simplex bound permits only $O(1/p)$ such
vectors. Thus a fixed atomic marginal cannot support an unbounded proper family
whose wrong concepts are all nonpositively correlated, let alone safe below
every hidden inverse-polynomial weak gap.

The low-noise parity repair is therefore a source-side repair only. It does
not solve the fixed-marginal visibility problem.

## Final Atlas-Ready Open Summary

The implication should remain `open`.

The source gives one uniform learner whose output may be outside
$\mathcal C$ and whose fixed-marginal weak agnostic tolerance is
$\operatorname{OPT}_{\mathcal C}+1/2-\alpha_P(s)$ for some marginal-dependent
inverse-polynomial gap. The target asks for an efficient way to return a valid
concept in $\mathcal C$ with a comparable weak guarantee. No generic
fixed-marginal proper selector follows from the source: uniform convergence
gives existence, but not polynomial-time proper ERM, a computable proper cover,
or a projection from external predictors to concepts.

Known separation templates remain near misses. Active-slice PCPs get a weak
gap by placing the hard instance in the marginal. Clause and one-way coordinate
witnesses give strong proper recovery hardness but allow weak proper handles.
Polynomial shared-code witnesses keep the source easy but leave
inverse-polynomial wrong correlations, which can exceed the target learner's
hidden advantage. Exact Hadamard/image-character witnesses remove wrong
correlations at one length, and low-noise robustification can even support the
weak improper source there, but one fixed finite-encoded marginal reintroduces
length dilution or countable-atom orthogonality barriers.

Suggested atlas metadata remains:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
argument_note: "[[properization-open|Properization Open]]"
summary: "Open: no generic efficient fixed-marginal proper selector is known, and current fixed-marginal separation templates lose the hidden weak gap through active-mass dilution, weak handles, or finite-encoded orthogonality barriers."
```

Suggested body text:

```markdown
The edge is a weak agnostic properization problem. The source supplies an
external predictor but no representation-level mechanism for finding a valid
concept with weak advantage. A positive proof would need additional structure,
such as fixed-marginal approximate proper ERM, a computable proper weak cover,
or a projection/selector from predictors into $\mathcal C$.

The strongest false-witness templates do not yet apply. PCP active slices vary
the marginal, while packing slices into one marginal dilutes the weak gap.
One-way coordinate witnesses force proper recovery only at strong accuracy or
leak weak handles. Shared-code and PRG constructions with polynomially visible
coordinates leave inverse-polynomial wrong correlations. Hadamard-coded
one-way images defeat wrong correlations at an isolated length, and low-noise
robustification can make the improper weak agnostic source plausible there,
but a single finite-encoded marginal across all lengths again dilutes the hard
mass or would require an impossible all-length exact orthogonal system on a
countable atomic sample space.
```

## Future Directions To Incorporate

1. **Computational weak-handle hardness.** A real counterexample likely cannot
   rely on geometric absence of weak handles. It should allow weakly correlated
   wrong proper hypotheses but make every polynomial-time method for finding
   one yield an inversion, witness, or certificate.

2. **Formal finite-marginal orthogonality lemma.** Record the atom/simplex
   obstruction as a reusable no-go lemma: under one fixed countable
   finite-encoded marginal, no unbounded binary family can have all wrong
   concepts nonpositively correlated.

3. **Hadamard low-noise note.** The Hadamard one-way image attempt is still
   useful as a diagnostic. It shows that noisy parity is not the whole source
   obstruction for weak agnostic learning; the fatal issue is the all-length
   fixed-marginal conversion.

4. **Selector conditional theorem.** State a positive conditional theorem:
   source plus fixed-marginal approximate proper ERM, computable proper weak
   cover, or predictor-to-concept projection implies the target.

5. **Fixed-gap variants.** Shared-code and readable-hint constructions may
   separate variants where the weak advantage is requested or fixed in
   advance. They should not be used for this hidden-gap node without an
   all-exponents argument that survives size-parameter renormalization.

6. **Model-boundary audit.** If a future atlas version allows nonatomic
   examples, oracle samples, or infinite random strings as computational
   objects, the Hadamard one-way route should be revisited. Under the current
   finite-encoded transcript convention, it is not admissible.

verdict: unresolved-open
confidence: high
