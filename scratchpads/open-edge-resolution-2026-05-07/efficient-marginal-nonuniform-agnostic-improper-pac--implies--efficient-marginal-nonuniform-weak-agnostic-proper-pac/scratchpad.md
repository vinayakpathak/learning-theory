# Open Edge Resolution Scratchpad

Edge: `efficient-marginal-nonuniform-agnostic-improper-pac -> efficient-marginal-nonuniform-weak-agnostic-proper-pac`

Date: 2026-05-07

Worker depth: 1

Verdict: `unresolved`

## Edge And Definitions Checked

Read:

- `atlas/README.md`
- `atlas/definitions/efficient-marginal-nonuniform-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/arguments/properization-open.md`
- Prior exact-edge scratchpads:
  - `scratchpads/open-edge-resolution-2026-05-04/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`
  - `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`

The source gives one uniform learner which, for every fixed marginal $P$, has a $P$-dependent polynomial bound and returns an arbitrary hypothesis $g$ with

$$
\operatorname{err}_{\mathcal D}(g)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\varepsilon .
$$

The target asks for one uniform learner which, for every fixed marginal $P$, has a $P$-dependent polynomial runtime and outputs a proper $h\in\mathcal C$ satisfying

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\beta_P(s),
$$

where $\beta_P(s)<1/2$ and $\alpha_P(s)=1/2-\beta_P(s)$ is inverse-polynomial in the representation/size parameter, with the polynomial allowed to depend on $P$. The edge currently belongs to [[properization-open|Properization Open]] and has status `open`.

## Primary Sources Checked

- Hanneke, Moran, and Thiessen, *Marginal-Nonuniform PAC Learnability*, OpenReview/PDF: https://openreview.net/forum?id=aoVCFtox89 and https://openreview.net/pdf?id=aoVCFtox89. Used for the marginal-nonuniform quantifier: the rate may depend on the marginal $P$, but once $P$ is fixed the guarantee is uniform over targets.
- Feldman, *Distribution-Specific Agnostic Boosting*, arXiv: https://arxiv.org/abs/0909.2927. Used as a near miss: distribution-specific agnostic boosting preserves the instance marginal by changing labels, but assumes a weak agnostic oracle and does not properize the output.
- Schapire, *The Strength of Weak Learnability*, author PDF/DOI context: https://www.schapire.net/papers/strengthofweak.pdf and https://doi.org/10.1023/A:1022648800760. Used as the classical weak-to-strong reference; it does not supply a properization theorem for this edge.
- Ben-David, Long, and Mansour, *Agnostic Boosting*, DOI context: https://doi.org/10.1007/3-540-44581-1_33. Used for the weak agnostic tolerance format $\operatorname{OPT}+\beta$.
- Hastad and Khot, *Query Efficient PCPs with Perfect Completeness*, Theory of Computing: https://theoryofcomputing.org/articles/v001a007/. Used for the active-slice weak proper hardness template: logarithmic randomness, perfect completeness, and soundness below $1/2$.
- Pitt and Valiant, *Computational Limitations on Learning from Examples*, DOI context: https://doi.org/10.1145/48014.63140, and Kearns and Valiant, *Cryptographic Limitations on Learning Boolean Formulae and Finite Automata*, DOI context: https://doi.org/10.1145/174644.174647. Used only as background for proper/improper computational separations.
- Plotkin, *Binary codes with specified minimum distance*, DOI context: https://doi.org/10.1109/TIT.1960.1057584; McEliece, Rodemich, Rumsey, and Welch, *New upper bounds on the rate of a code via the Delsarte-MacWilliams inequalities*, CaltechAUTHORS: https://authors.library.caltech.edu/records/3mas1-6h321; Guruswami and Vadhan, *A Lower Bound on List Size for List Decoding*, author page/PDF: https://salil.seas.harvard.edu/publications/lower-bound-list-size-list-decoding. Used for the shared-code obstruction.

## Positive Route Attempt

### Goal

Prove the edge by converting a strong marginal-nonuniform agnostic improper learner $A$ into a weak marginal-nonuniform agnostic proper learner $B$.

### Why the direct route fails

Running $A$ with a small $\varepsilon$ produces an accurate external predictor $g$, not a representation of a concept in $\mathcal C$. The guarantee says that $g$ competes with the best proper concept, but it does not identify a good concept, implement proper ERM, or expose a projection map $g\mapsto h\in\mathcal C$.

Uniform convergence gives only the statistical half of the story. For a fixed marginal and a finite or VC-bounded trace class, a good proper hypothesis exists on a large enough sample. But the target is computationally efficient. Exhaustive search over $\mathcal C$ is exactly the step known to fail in standard proper/improper separations.

Boosting is also not the missing ingredient. Schapire-style weak-to-strong boosting amplifies advantage but commonly returns a vote or aggregate outside the base class. Feldman-style distribution-specific agnostic boosting is closer to the marginal issue, because it keeps the instance marginal fixed, but it assumes access to a weak agnostic learner and still does not turn an improper strong learner into a proper hypothesis.

### Conditional theorem that would work

The following extra assumptions would imply the target, but none follows from the source definition:

1. For every fixed marginal $P$, a polynomial-time approximate proper ERM/projection oracle exists for $\mathcal C$ under $P$.
2. For every fixed $P$, there is a computable polynomial-size $L_1(P)$ cover by valid concepts, with efficient validation against samples.
3. On every relevant finite trace of $P$, proper consistency or approximate trace realization is searchable in marginal-dependent polynomial time.
4. There is a constant-slack projection oracle which, from any low-error improper predictor, returns $h\in\mathcal C$ with nontrivial excess-error advantage.

With any one of these, one can run the source learner only as a statistical guide or ignore it and perform the promised proper search. Without such representation-level structure, I do not see a proof of `true`.

## Counterexample Route Attempts

### Clause-Satisfaction Lookup

The clause-satisfaction lookup witness keeps the marginal fixed: use the uniform marginal over a polynomial clause universe, label the input formula's clauses by $1$, and label non-formula clauses by fair noise. Improper lookup-table learning is easy, while highly accurate proper learning would solve SAT.

This resolves strong proper targets, not the present weak target. If formula clauses have mass $\alpha$ and a proper assignment violates a $\rho$ fraction of them, the excess error is only $\alpha\rho$. A weak learner may have tolerance

$$
\beta_P(s)=1/2-\alpha_P(s)
$$

with hidden inverse-polynomial $\alpha_P(s)$. The one-clause or inverse-polynomial gap used by the strong proper reduction is swallowed by an additive tolerance close to $1/2$. To make this route work, the no case would need to force wrong assignments above the weak threshold on one fixed marginal, not merely above a small accuracy threshold.

### PCP Active Slice

The PCP active-slice witness has the right weak-gap geometry. With a perfect-completeness PCP and soundness $q<1/2$, a satisfiable instance has a proof accepted on all random strings, while an unsatisfiable instance has no proof accepted on more than a $q$ fraction. This refutes distribution-free weak proper learning when the marginal is uniform on the active slice for the input instance.

The marginal-nonuniform target defeats the standard reduction. If the active slice marginal depends on the input formula $\varphi$, then the target's runtime polynomial may also depend on $\varphi$, so the reduction no longer yields a uniform randomized polynomial-time SAT algorithm. If all active slices are packed into one fixed marginal, each formula slice has exponentially small mass, and the weak gap is multiplied by that mass. The resulting global gap can be smaller than the target's hidden advantage $\alpha_P(s)$.

### One-Way Image Coordinate

The one-way image-coordinate witness gives fixed-marginal strong proper hardness. The length-$n$ block has mass $\mu_n$, and a strong proper learner run to accuracy $O(\mu_n/n)$ must output a seed with the correct one-way image.

This does not refute weak proper learning. A wrong-length/default hypothesis has error on the hard block only around $\mu_n/2$. Since $\beta_P(s)$ may be close to $1/2$, the weak learner may ignore the hard block entirely. The local note [[one-way-image-coordinate-weak-handle-hardness|One-Way Image Coordinate Weak-Handle Hardness]] records the same phenomenon from the other direction: weak handles can exist even when strong recovery remains cryptographically hard.

### Shared-Code / Hadamard Repair

The natural repair is to make every hard instance use the whole fixed marginal instead of a small active slice. Let each hard challenge $z$ define labels $Y_z\in\{\pm1\}^{Q_s}$ on a shared coordinate set $Q_s$, and let each proper certificate $a$ define $C_a\in\{\pm1\}^{Q_s}$. In $\{\pm1\}$ notation,

$$
\operatorname{err}_{P_s}(C_a,Y_z)
=
\frac{1-\langle C_a,Y_z\rangle_{P_s}}{2}.
$$

For a nearly realizable challenge, a non-witness proper certificate is excluded by the weak target only if

$$
\langle C_a,Y_z\rangle_{P_s}
<
2\alpha_P(s)
$$

up to small optimum slack. Since $\alpha_P(s)$ is hidden and may be $s^{-k}$ for an arbitrarily large constant $k$, any residual wrong-certificate correlation $s^{-K}$ is unsafe.

Exact nonpositive-correlation safety would solve the weak-gap issue, but it is dimension-limited. For uniform $P_s$ and $Y_z=C_z$, pairwise nonpositive correlations are the Plotkin/Hadamard regime: a binary code of length $N=|Q_s|$ with relative distances at least $1/2$ has only $O(N)$ codewords. A polynomial shared coordinate domain cannot encode exponentially many formulas, images, or certificates with that geometry.

Approximate codes do not close the assigned edge. The MRRW bound near relative distance $1/2-\eta$ gives, as an inference, a rate bound of order $O(\eta^2\log(1/\eta))$. Thus if $M=2^{\Omega(s)}$ challenges are encoded on $N=s^c$ coordinates, some inverse-polynomial positive correlation remains at every fixed polynomial coordinate scale. Guruswami-Vadhan-style list-size lower bounds near radius $1/2-\alpha$ point in the same qualitative direction: list control near half distance has a polynomial-in-$1/\alpha$ cost and does not remove every inverse-polynomial weak handle.

Hadamard/parity encodings have the exact geometry: under the uniform marginal on $r\in\{0,1\}^n$, any proper output with positive correlation with the parity $\langle y,r\rangle$ identifies $y$. If proper concepts are indexed by seeds $t$ with image $f(t)$, a weak proper learner would invert $y=f(s)$. The source side is the blocker. Strong agnostic improper learning against image parities under random examples is essentially an agnostic parity/noisy-codeword problem; the usual lookup-ERM witnesses avoid exactly this.

### Header/Public-Key Repair Attempt

I also checked a hybrid idea not worth promoting to an atlas update yet. Add an easy "header" region that reveals a public image/key $y=f(s)$, while a large shared Hadamard-like body forces weak proper outputs to invert $y$.

This fails in the strong agnostic source. In realizable cases the header lets an improper learner recover $y$ and predict the body. But in arbitrary agnostic label distributions, the best concept may be selected by correlations on the body, not by the header. If the body has enough mass to force weak proper inversion, then competing to arbitrary $\varepsilon$ again requires solving the hard shared-code/agnostic-parity search. If the body has small mass so the header dominates agnostic ERM, then the weak proper lower bound disappears. This is the same mass-versus-geometry tradeoff in another costume.

## Current Obstacles

1. **No generic proper projection.** The source outputs accurate external predictors, not searchable proper representations.

2. **Agnostic properization is cost-sensitive.** Low-margin parts of the conditional label distribution may allow large $P$-disagreement at little error cost, while high-margin parts matter. A plain metric projection is not justified by the source guarantee.

3. **Weak-gap quantifier.** The target's advantage $\alpha_P(s)$ is existential, hidden, and marginal-dependent. A fixed inverse-polynomial residual correlation in a counterexample may still be a legal weak output.

4. **Active-slice dilution.** PCP-style weak hardness loses its constant gap when input-dependent slices are packed into one fixed marginal.

5. **Shared-code dimension bounds.** Exact weak-safe geometry for exponentially many certificates needs Hadamard/Plotkin-scale coordinate domains; polynomial coordinate domains leave inverse-polynomial residual correlations.

6. **Source-side decoding hardness.** Dense orthogonal encodings would make weak proper outputs informative, but they also make the strong agnostic improper learner solve parity/list-decoding-like optimization rather than easy lookup ERM.

## Promising Follow-Up Directions

1. Search for agreement-test or direct-product PCP theorems where any proper object with even inverse-polynomial correlation to a shared transcript must reveal the target instance or witness. Ordinary list decoding is too weak because the learner returns one hypothesis, not a list.

2. Formalize the shared-coordinate lookup-ERM no-go as a reusable argument note: Plotkin for exact safety; MRRW/list-decoding bounds for approximate safety; and a separate lemma explaining why adding all amplification exponents renormalizes into the representation size.

3. Study fixed-gap or requested-gap variants of weak agnostic proper learning. Approximate shared-code constructions may separate those stricter targets even though they do not refute this hidden-gap marginal-nonuniform target.

4. Look for representation-specific positive theorems: fixed-marginal approximate proper ERM, computable marginal-dependent covers by valid concepts, or projection oracles from improper predictors to weakly good proper concepts.

5. Revisit public-key style witnesses only if there is a public function family whose key can be agnostically learned from random examples while wrong secret-key representations are weak-safe at an unknown inverse-polynomial scale.

## Proposed Atlas Action

No atlas file should be changed from this scratchpad alone.

Recommended status remains:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
```

Suggested concise summary, if the edge note is refreshed later:

> Open: strong marginal-nonuniform agnostic improper learning gives no known efficient projection to a proper hypothesis, and fixed-marginal weak proper separations lose either the hidden weak-gap scale or the efficient agnostic improper source.

## Final Verdict

Unresolved. I found no source-grounded proof of the implication and no atlas-ready counterexample. The strongest conclusion is conditional-only in both directions: projection/ERM structure would prove the edge, while a fixed-marginal agreement-style hardness gadget could refute it. Neither is currently supplied by the atlas notes or the primary sources checked.

## Depth 2 Branch A: Agreement PCP Weak-Safe Shared Transcript Route

### Branch Goal

Test the following repair of the shared-code obstruction. Replace bare pairwise code geometry by an agreement-test, direct-product, or list-decoding PCP transcript system. The desired object would use one fixed marginal $P$ over a shared transcript domain $Q_s$ and, for every hard instance $x$, an efficiently computable label vector $Y_x\in\{\pm1\}^{Q_s}$. Proper hypotheses would be transcript objects $H_a\in\mathcal C_s$, indexed by candidate instances/proofs/certificates.

The route would refute the edge if it supplied the following weak-safe selector property:

$$
\langle H_a,Y_x\rangle_P \ge s^{-k}
\quad\Longrightarrow\quad
\text{one can recover a valid witness for }x\text{ from }a
$$

for every constant $k$, or at least for the hidden inverse-polynomial advantage $\alpha_P(s)$ promised by the marginal-nonuniform weak target. Completeness would give some $a^\star$ with large positive correlation on yes instances. The source node would be handled by a richer improper class, for example polynomial-size lookup tables or efficiently searchable transcript tables, so that agnostic ERM is easy even though proper weak selection is hard.

If such a polynomial-size shared-transcript PCP existed, it would give a clean conditional counterexample under $\mathrm{NP}\nsubseteq\mathrm{RP}$: on input $x$, run the assumed weak proper learner on the fixed marginal $P$ with labels $Y_x$; weak success returns a proper $H_a$ with positive inverse-polynomial correlation; weak-safe decoding yields a witness for $x$; the no case is ruled out by soundness. This would make the implication `false` with `evidence: conditional-counterexample`.

### What The Agreement Literature Gives

The checked agreement/direct-product sources support the local-to-global intuition, but not the exact weak-safe selector above.

- [Dinur and Steurer 2014](https://eccc.weizmann.ac.il/report/2013/179/) analyze the canonical two-query direct-product test. In the list-decoding/small-soundness regime, passing the test with probability at least $\exp(-k)$ implies agreement with a direct-product structure on local parts. This is a test-to-list/global-structure theorem, not a uniqueness theorem saying that every inverse-polynomially correlated proper object identifies the intended hard witness.

- [Impagliazzo, Jaiswal, and Kabanets 2006/2009](https://www.cs.sfu.ca/~kabanets/Research/approx-list-dec.html) and [Impagliazzo, Jaiswal, Kabanets, and Wigderson 2008/2010](https://www2.cs.sfu.ca/~kabanets/Research/opt-DP.html) give efficient approximate list decoding for direct-product codes. Agreement $\varepsilon$ yields a list of size polynomial, or $O(1/\varepsilon)$ in the optimized theorem, containing a good approximation to the underlying message. This is exactly the wrong shape for the present edge: a weak learner returns one legal hypothesis, and the reduction needs that one hypothesis to carry the target witness, not merely to be one member of a list of possible correlated messages.

- [Dinur and Kaufman 2017](https://eccc.weizmann.ac.il/eccc-reports/2017/TR17-089/) show high-dimensional expanders can derandomize direct-product tests with linearly many subsets. This helps the representation-blowup side of the route, but the result is primarily an agreement-expansion/direct-product testing statement. It does not remove the hidden weak-gap issue or wrong-transcript handles by itself.

- Low-acceptance agreement work makes the same limitation more explicit. [Dikstein and Dinur 2024](https://doi.org/10.1145/3618260.3649685) study the low-acceptance, or "1%" regime, and show that covers can determine whether the expected agreement conclusion holds. [Gotlib and Kaufman 2022](https://arxiv.org/abs/2210.15714) introduce list agreement expansion, again with an explicitly list-valued global structure. [Bafna, Lifshitz, and Minzer 2024](https://arxiv.org/abs/2402.00850) obtain constant-degree direct-product testers with small soundness for suitable high-dimensional expanders, but the guarantee is still a soundness/testing guarantee rather than a target-unique weak selector for all inverse-polynomial correlations.

### Why This Does Not Yet Close The Edge

**List size blocker.** List decoding is not enough for this reduction. If $H_a$ has correlation $\varepsilon$ with $Y_x$, a decoder may output a polynomial-size list containing the intended transcript/message. But the weak learner is free to output a different correlated proper object whose decoded message is a wrong instance, a satisfiable dummy instance, or a cover-lift artifact. Detecting that the returned object is wrong does not help: the learning guarantee did not promise a second output that is right.

**Hidden weak-gap blocker.** The target's advantage $\alpha_P(s)$ is existential and hidden. A construction that is safe above a chosen threshold $\varepsilon=s^{-K}$ still leaves open the possibility that the legal weak learner has advantage $s^{-K'}$ with $K'>K$. To refute this marginal-nonuniform node, the transcript family must rule out every inverse-polynomial wrong positive correlation, or provide a construction whose parameters cover all exponents without changing the size parameter in a way that renormalizes the gap.

**Representation-blowup blocker.** Ordinary direct-product encodings use large domains such as $N^k$. Taking $k$ large enough to push list-decoding error below all relevant weak gaps makes the shared transcript domain quasi-polynomial or worse unless one uses derandomized set systems. High-dimensional expander tests improve this for fixed soundness regimes, but parameterizing soundness/list radius against an unknown inverse-polynomial weak advantage tends either to increase degree/domain size as a function of the exponent or to inflate the representation size $s$, after which the target may choose a smaller inverse polynomial in the new $s$.

**Source-side agnostic blocker.** The improper source is strong agnostic, not just realizable prediction on the hard labels $Y_x$. If the shared transcript is dense enough that every weakly correlated proper object reveals a witness, then agnostic competition against $\mathcal C$ often becomes a noisy direct-product/list-decoding or parity-like search problem. That is not the lookup-ERM situation used by the active-slice witness. Keeping the improper class rich enough for easy agnostic ERM usually means allowing transcript lookup tables, but then $Q_s$ must be polynomially searchable under the fixed marginal; pushing agreement parameters hard enough can break exactly that.

### Conditional Statement Is Still Missing

The branch therefore gives only a conditional template:

> If there is a polynomial-size fixed-marginal shared-transcript PCP for an NP-complete language with efficiently computable labels, an efficiently agnostically learnable improper transcript-table closure, perfect completeness, and target-unique decoding from every inverse-polynomially positive proper correlation, then this edge is false under $\mathrm{NP}\nsubseteq\mathrm{RP}$.

Known agreement/direct-product/list-decoding PCP theorems supply pieces of this template, especially local-to-global decoding and derandomization, but I did not find a primary-source theorem supplying the target-unique, all-inverse-polynomial weak-safe selector. The best diagnosis is unresolved, with the main blockers ordered as: hidden weak-gap scale and list size first; representation blowup and source-side agnostic hardness second.
