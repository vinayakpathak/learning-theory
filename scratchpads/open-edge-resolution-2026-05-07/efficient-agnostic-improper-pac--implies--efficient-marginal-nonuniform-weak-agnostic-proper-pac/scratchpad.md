# Edge: efficient-agnostic-improper-pac -> efficient-marginal-nonuniform-weak-agnostic-proper-pac

- worker depth: 1 of 7
- edge file: `atlas/implications/efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- source: [[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]]
- target: [[efficient-marginal-nonuniform-weak-agnostic-proper-pac|Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning]]
- verdict: unresolved
- confidence: medium-high that the current atlas should keep the edge open

## Short Verdict

I do not see a proof or a valid counterexample under the current atlas semantics. The edge remains a properization problem:

1. The source learner gives a polynomial-time distribution-free agnostic predictor, but that predictor may lie outside $\mathcal C$.
2. The target asks for a single uniform learner that outputs $h\in\mathcal C$, with a marginal-dependent polynomial bound and a marginal-dependent weak gap $\gamma_P(s)>0$ satisfying $\gamma_P(s)\ge 1/\operatorname{poly}_P(s)$.
3. The known improper-vs-proper witnesses either use an input-dependent hard marginal, require strong accuracy, or leave weak proper handles under a fixed marginal.

So I would keep the atlas edge:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
```

## Context Read

I read:

- `atlas/README.md`
- the assigned edge note
- both endpoint definition notes
- [[properization-open|Properization Open]]
- [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]] and [[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]]
- [[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]] and [[one-way-image-coordinate-class|One-Way Image Coordinate Class]]
- [[one-way-image-coordinate-weak-handle-hardness|One-Way Image Coordinate Weak-Handle Hardness]] and [[one-way-image-coordinate-weak-handle-class|One-Way Image Coordinate Weak-Handle Class]]
- [[clause-satisfaction-proper-hardness|Clause-Satisfaction Proper Hardness]] and [[clause-satisfaction-lookup-class|Clause-Satisfaction Lookup Class]]
- neighboring implication notes, especially the true improper relaxation edge and the open marginal-nonuniform improper-to-proper weak edge
- the previous exact-edge scratchpad under `scratchpads/open-edge-resolution-2026-05-05/.../scratchpad.md`

I did not find a previous exact-edge scratchpad under `scratchpads/open-edge-resolution-2026-05-04`.

## What The Source Gives

Let $A$ be the source learner. For every joint distribution $\mathcal D$ over examples and labels, $A$ can be run with accuracy $\varepsilon$ to output an external hypothesis $g$ satisfying

$$
\operatorname{err}_{\mathcal D}(g)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\varepsilon.
$$

This immediately implies the corresponding marginal-nonuniform weak agnostic **improper** target: keep the same algorithm and use the same distribution-free polynomial as the polynomial for every marginal $P$.

The assigned edge differs only in properness. The missing step is:

> Given samples, and perhaps an accurate external predictor $g$, find a representation of some $h\in\mathcal C$ with
> $$
> \operatorname{err}_{\mathcal D}(h)
> \le
> \operatorname{OPT}_{\mathcal C}(\mathcal D)+1/2-\gamma_P(s)
> $$
> for the fixed marginal $P$.

Uniform convergence, VC theory, and unbounded ERM can say that good proper hypotheses exist statistically. They do not give a polynomial-time search over the representations of $\mathcal C$. The source learner is a prediction procedure, not a projection oracle onto $\mathcal C$.

## Positive Route Status

I do not see a generic positive theorem.

A tempting proof is: run the improper learner, then project its predictor to a nearby concept. But no such efficient projection is part of the source definition. In an agnostic problem, closeness to the optimal error also does not imply that the predictor is close in $L_1(P)$ to any particular optimal concept; low-margin regions can absorb large disagreement without much excess error.

The clean conditional theorem is nearly tautological:

**Conditional selector theorem.** If for every fixed marginal $P$ there is a marginal-dependent polynomial-time weak proper trace selector that, from samples and optional evaluation access to an accurate improper predictor, outputs $h\in\mathcal C$ with inverse-polynomial weak excess gap, then the assigned implication holds.

This isolates the missing content but does not resolve the edge. The selector is essentially the target-side algorithm.

## Counterexample Route 1: PCP Active Slices

The strongest known weak proper separation is the PCP active-slice lookup class. It uses a perfect-completeness PCP with logarithmic randomness and soundness below $1/2$, as in Hastad and Khot. Proper concepts encode an instance-proof pair $(\varphi,\pi)$ and are active only on the $\varphi$ slice. An improper learner can use one-slice lookup-table ERM, while a weak proper learner on the active slice would distinguish satisfiable instances from unsatisfiable ones.

This proves the distribution-free weak proper edge false under $\mathrm{NP}\nsubseteq\mathrm{RP}$, but it does not refute the assigned marginal-nonuniform target.

The hard marginal in the reduction is $P_\varphi$, uniform on the slice $\{(\varphi,r)\}$. A marginal-nonuniform learner may have a runtime polynomial $p_{P_\varphi}$ depending on this particular marginal. Since $P_\varphi$ encodes the input instance, the hidden polynomial may also encode instance-specific search cost. That does not yield one uniform polynomial-time randomized algorithm for the NP language.

Packing many active slices into a single fixed marginal $P^\star$ also fails at the weak target. If the slice for $\varphi$ has mass $w_\varphi$, then the local PCP gap is multiplied by $w_\varphi$. The target only asks for excess error below roughly $1/2$, namely $1/2-\gamma_{P^\star}(s)$. If $w_\varphi < 1/2-\gamma_{P^\star}(s)$, a hypothesis can ignore the whole active slice and still be within the global weak tolerance. A weak reduction therefore needs the active hard region to have mass close to one, not merely inverse-polynomial mass. One fixed marginal cannot give that much mass to all hard slices.

Removing the active-instance coordinate gives a different problem: wrong-instance handles. In a shared-randomness PCP class with concepts

$$
h_{\psi,\pi}(r)=V(\psi,\pi,r),
$$

perfect completeness implies that any satisfiable unrelated instance $\psi$ contributes an all-one concept on the shared random-string domain. Such a proper concept can be a legal weak output while revealing nothing about the target instance $\varphi$. The active-slice gate prevents this; removing the gate restores a fixed marginal but loses identity protection.

## Counterexample Route 2: Clause-Satisfaction Lookup

The clause-satisfaction lookup class gives a fixed-marginal strong agnostic proper separation: use the uniform marginal on the polynomially many clauses over $n$ variables, label formula clauses by $1$, and put fair noise on non-formula clauses. An improper lookup learner can compete with assignments, while a sufficiently accurate proper learner can recover a satisfying assignment.

For the assigned weak target, the additive tolerance is too large. Suppose formula clauses have total marginal mass $\alpha$ and the satisfiable optimum is the fair-noise baseline $(1-\alpha)/2$. The weak guarantee permits error up to

$$
(1-\alpha)/2 + 1/2-\gamma_P(s).
$$

Thus it only forces the returned assignment to have formula-clause falsification rate at most $(1/2-\gamma_P(s))/\alpha$. Unless $\alpha$ is close to one, this need not even be below $1/2$. A fixed clause universe cannot assign near-unit mass to every possible input formula's active clauses. PCP amplification is meant to create constant local gaps, but once the active PCP tests are put into a fixed global marginal, the same active-mass or wrong-instance-handle obstruction returns.

## Counterexample Route 3: One-Way Image Coordinates

The one-way image-coordinate class is an excellent strong proper separation. Proper hypotheses are seeds $s$ and expose the coordinates of $f(s)$ for a length-preserving one-way function $f$. Sparse improper ERM agnostically learns the class, because each length-$n$ concept has only $n$ positive atoms. Under the fixed all-length marginal with block mass $\mu_n=6/(\pi^2n^2)$, sufficiently strong proper accuracy forces recovery of a seed $t$ with $f(t)=f(s)$.

The assigned target is weak, and this loses the recovery force. A wrong-length or wrong-image seed can have global error on the order of the length-$n$ block mass, which is far below $1/2-\gamma_P(s)$ for large $n$. The weak-handle variant in the atlas makes this explicit: adding constants and bounded positive-atom handles makes weak proper learning easy while preserving strong proper hardness at much smaller accuracy.

This witness therefore separates strong proper recovery, not marginal-nonuniform weak properization.

## Counterexample Route 4: Fixed High-Mass Shared Codes

The natural way around slice dilution is to put all hard targets on one fixed high-mass coordinate space. Encode a hard message $y$ as a balanced codeword $C_y$ under a fixed marginal. Proper concepts are seed-codewords, while an improper learner competes by a larger lookup or relaxation class.

This has the right shape only if every wrong proper codeword has correlation below the target learner's hidden weak advantage. The hidden scale matters. For a fixed marginal $P$, the target only promises some

$$
\gamma_P(s)\ge s^{-k_P},
$$

where $k_P$ is not known to the reduction. A wrong codeword with correlation $s^{-K}$ is a legal weak handle for any learner whose guaranteed gap is smaller.

Polynomial-length binary codes cannot remove all such handles for exponentially many messages by distance alone. Exact nonpositive correlation is in the Plotkin/Hadamard regime and supports only linearly many mutually safe binary vectors on a finite coordinate set. Approximate distance near $1/2$ leaves inverse-polynomial residual correlations at a fixed exponent controlled by the block length. Increasing the polynomial exponent only moves the residual scale; it does not beat every possible marginal-dependent weak exponent.

Hadamard codes fix the geometry: distinct messages are exactly orthogonal, so any positive weak correlation identifies the message. But then the source side becomes agnostic parity/correlation search on an implicit exponential domain. Making the domain explicit restores lookup ERM but makes the learner polynomial only in an exponentially inflated representation, too large for the usual NP or one-way-function contradiction.

## Additional Attempt: Nested Prefix Marginals

I also checked a possible escape from the "disjoint blocks have vanishing mass" objection. Instead of putting length-$n$ gadgets on disjoint blocks, take one fixed countable marginal whose prefixes have high mass, and let length-$n$ codewords live on a large prefix. Then every length could have nearly constant visible mass.

This does not currently produce a counterexample.

If the prefix has only polynomially many coordinates in the representation size, lookup-style agnostic improper learning remains plausible, but coding bounds again leave inverse-polynomial wrong-code correlations. Since the target's weak gap exponent is hidden, these wrong correlations can be legal weak handles.

If the prefix is superpolynomial or Hadamard-sized to force exact or superpolynomially small correlations, the source is no longer a polynomial-time lookup learner in the original hard-instance size, or the resulting proper learner's allowed runtime is too large to contradict the standard assumptions. Longer-size concepts also become potential prefix handles unless identity is protected by another code, which reintroduces the same correlation-scale problem.

So nested prefixes avoid one mass-dilution symptom but not the core weak-gap/properization obstruction.

## Why Neighboring Edges Do Not Settle This One

There is a true monotone edge

[[efficient-agnostic-improper-pac]] -> [[efficient-marginal-nonuniform-weak-agnostic-improper-pac]]

because the target relaxes distribution, strength, and keeps improperness.

There is also a false edge

[[efficient-agnostic-improper-pac]] -> [[efficient-weak-agnostic-proper-pac]]

under $\mathrm{NP}\nsubseteq\mathrm{RP}$, using the PCP active-slice witness.

The assigned target sits between these: it still asks for proper outputs, but it weakens distribution-free to marginal-nonuniform. The active-slice lower bound does not survive that weakening, and the true improper relaxation does not supply proper representations.

## Concrete Obstacles

- **No generic projection.** An accurate improper predictor is not a polynomial-time representation finder for $\mathcal C$.
- **Marginal-dependent runtimes hide active-slice reductions.** If the hard marginal names the input instance, the target's polynomial may depend on that instance.
- **Weak tolerance hides low-mass gadgets.** A hard region of mass $w\ll 1/2$ can often be ignored while staying within $\operatorname{OPT}+1/2-\gamma_P(s)$.
- **Shared PCPs create wrong-instance handles.** Perfect completeness gives all-one or high-acceptance concepts from unrelated satisfiable instances unless the active-instance gate is retained.
- **Fixed-marginal strong proper hardness is not weak hardness.** One-way coordinate witnesses force recovery only at strong accuracy; weak learners can exploit wrong blocks, constants, or bounded handles.
- **Dense code repairs face the hidden exponent.** Polynomial coordinate sets leave inverse-polynomial residual correlations; exact orthogonality makes the source parity-like or the representation too large.

## Promising Follow-Up Directions

1. Look for a fixed-marginal, identity-protected PCP or label-cover construction where any weakly correlated wrong-instance proof decodes the target instance, instead of acting as a handle.
2. Search for a dense-code-plus-agreement theorem stronger than pairwise distance: every proper concept with any inverse-polynomial correlation must decode the same challenge witness, while a richer improper class remains efficiently agnostically learnable.
3. Formalize the nested-prefix obstruction. It is a useful variant of the mass-dilution discussion because it shows that high prefix mass alone is not enough; the hidden weak exponent and cross-size handles still have to be controlled.
4. Develop positive theorems for classes with explicit marginal-dependent weak trace selectors, effective finite supports, or efficiently searchable weak covers. These would not settle the edge globally, but they would mark the exact structural assumption missing from the source node.
5. Compare this edge with [[efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac|Efficient Marginal-Nonuniform Agnostic Improper PAC Learning -> Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning]], since the remaining obstruction is the same fixed-marginal weak properization step.

## References Checked

- [[properization-open|Properization Open]]
- [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]
- [[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]]
- [[one-way-image-coordinate-weak-handle-hardness|One-Way Image Coordinate Weak-Handle Hardness]]
- [[clause-satisfaction-proper-hardness|Clause-Satisfaction Proper Hardness]]
- [[marginal-boosting-open|Marginal-Nonuniform Boosting Open]]
- [[marginal-agnostic-hardness-open|Marginal-Nonuniform Agnostic Hardness Open]]
- Hanneke, Moran, and Thiessen 2025, "Marginal-Nonuniform PAC Learnability" ([OpenReview](https://openreview.net/forum?id=aoVCFtox89)), for the marginal-dependent-rate model.
- Hastad and Khot 2005, "Query Efficient PCPs with Perfect Completeness" ([Theory of Computing](https://theoryofcomputing.org/articles/v001a007/)), for logarithmic-randomness PCPs with perfect completeness and small soundness.
- Kearns and Valiant 1994, "Cryptographic Limitations on Learning Boolean Formulae and Finite Automata" ([DOI](https://doi.org/10.1145/174644.174647)), for the cryptographic learning-hardness template.
- Hastad et al. 1999, "A Pseudorandom Generator from any One-way Function" ([DOI](https://doi.org/10.1137/S0097539793244708)), as cited by the one-way-function witnesses.
- Khot and Saket 2008, "Hardness of Minimizing and Learning DNF Expressions" ([FOCS/PDF](https://cs.nyu.edu/~khot/papers/minDNF.pdf)), as a near-miss constant-advantage proper-learning hardness result.
- Plotkin 1960, McEliece et al. 1977, and Guruswami-Vadhan 2010, as cited in [[properization-open|Properization Open]], for the coding-theoretic obstruction near distance $1/2$.

## Depth 2 Branch A: Fixed-Marginal Identity-Protected PCP Route

### Targeted Counterexample Shape

The desired negative route would fix one marginal $P$ once and for all, then reduce an NP-hard language $L$ to weak proper learning under that same $P$. In $\{\pm 1\}$ notation, if the labels for an input instance $\varphi$ are $y_\varphi$, then a weak agnostic proper learner with gap $\gamma_P(s)$ and realizable optimum $0$ must output a proper $h$ with

$$
\mathbb{E}_{x\sim P}[y_\varphi(x)h(x)] \ge 2\gamma_P(s).
$$

Thus a counterexample needs an identity-protected family with the following property: every proper concept with inverse-polynomial positive correlation against $y_\varphi$ decodes the same hard instance $\varphi$ and a valid witness/proof for it. The source side still needs a distribution-free efficient agnostic improper learner, typically by allowing an improper lookup-table or sparse/table relaxation whose effective support is polynomial in the representation size.

I do not see a construction of this kind under a standard assumption. The clean fixed-marginal versions either lose the identity guarantee, or keep identity by adding dense codes and then lose the easy improper agnostic learner or the fixed-marginal high-mass condition.

### Active-Slice PCP

The active-slice PCP witness is still the best distribution-free weak proper lower bound. Håstad and Khot give PCPs for NP with logarithmic randomness, perfect completeness, and soundness below any fixed constant below $1/2$ by choosing the query parameter; this is exactly the shape used by [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]] ([Hastad-Khot 2005](https://theoryofcomputing.org/articles/v001a007/)).

The construction protects identity by putting the instance name in the example: $h_{\psi,\pi}(\varphi,r)$ is active only when $\psi=\varphi$. This prevents wrong satisfiable instances from being handles. But the hard marginal is then $P_\varphi$, uniform on the $\varphi$ slice. If all slices are mixed into one fixed $P^\star$, the $\varphi$ slice has mass $w_\varphi$, and the local PCP advantage is multiplied by $w_\varphi$. Since the target permits error up to $\operatorname{OPT}+1/2-\gamma_{P^\star}(s)$, any slice with $w_\varphi\ll 1$ can be ignored. This is not a technical loss in the proof; it is the reason the active-slice identity trick is incompatible with a fixed weak marginal.

### Shared-Randomness PCP

The obvious fixed-marginal repair removes the instance coordinate and lets all instances share the same random-string space:

$$
h_{\psi,\pi}(r)=V(\psi,\pi,r).
$$

Now the marginal can be uniform over verifier randomness. The identity protection is gone. Perfect completeness implies that every satisfiable $\psi$ has a proof $\pi_\psi$ with $h_{\psi,\pi_\psi}(r)=1$ for every $r$. If the target labels for a satisfiable $\varphi$ are all $1$, this all-one concept is a valid weak output for every other satisfiable $\psi$ and carries no information about $\varphi$. If the labels are modified by an instance code $b_\varphi(r)$, the construction becomes a dense-code route rather than a PCP route.

Multiplying the verifier output by a code, for example $h_{\psi,\pi}(r)=b_\psi(r)\cdot a_{\psi,\pi}(r)$ with $a_{\psi,\pi}\in\{\pm 1\}$ derived from acceptance, also fails without a new cross-instance soundness theorem. Pairwise small correlation of $b_\varphi$ and $b_\psi$ does not control correlation after multiplication by the proof-dependent mask $a_{\psi,\pi}$. A wrong satisfiable instance can use noncanonical proofs, and ordinary PCP soundness constrains false statements for their own verifier, not correlations between accepting masks for one statement and the identity code of another.

### Label-Cover And Agreement Tests

Label-cover and parallel-repetition machinery is excellent for reducing the value of a fixed constraint system. Raz's parallel repetition theorem shows exponential decay of error for repeated two-prover games ([Raz 1998](https://doi.org/10.1137/S0097539795280895)). Agreement and direct-product tests then give local-to-global decoding: if many local views agree, one can often recover a global object. This is the role of direct-product and agreement tests in PCP composition; see, for example, Dinur-Kaufman on agreement expanders ([FOCS 2017](https://doi.org/10.1109/FOCS.2017.94)), Dinur-Filmus-Harsha on agreement tests ([SIAM J. Comput.](https://doi.org/10.1137/21M1397684)), and Impagliazzo-Jaiswal-Kabanets-Wigderson on uniform derandomized direct products ([SIAM J. Comput.](https://doi.org/10.1137/080734030)).

These tools do not by themselves solve the present edge. Their conclusion is usually: substantial agreement with a collection of local views decodes some global assignment for the same underlying object, or gives a short list of such objects. The needed conclusion is stronger and cross-instance: any proper hypothesis from any satisfiable wrong instance that has even inverse-polynomial correlation with $y_\varphi$ must decode $\varphi$ itself. Standard label-cover soundness is not an identity-protection statement of this form.

There is also a weak-threshold issue. Many agreement theorems are most useful in high-agreement or constant-soundness regimes, while this edge hides the marginal-dependent scale $\gamma_P(s)\ge s^{-k_P}$. One can imagine adding an amplification parameter $L$ and, after seeing a hypothetical learner with exponent $k_P$, choosing $L>k_P$. But then the class must contain all amplified gadgets while keeping one fixed high-mass marginal and an easy distribution-free improper agnostic learner. That requirement pushes the construction into the dense-code obstruction below.

### Dense Identity Codes

The most promising abstraction is to separate identity from proof checking. Let a valid witness $w$ for $\psi$ define the proper concept

$$
c_{\psi,w}^{(L)}(j)=b_\psi^{(L)}(j),
$$

and include no concept for invalid witnesses. If $\varphi\in L$, the labels $b_\varphi^{(L)}$ are realizable. If $\varphi\notin L$, then any weak proper output whose code identity decodes to $\varphi$ would give a false witness, while any output decoding to $\psi\ne\varphi$ should have correlation below $\gamma_P(s)$.

On a length-specific finite uniform block this is plausible. A random or explicit small-bias style code with $m=\operatorname{poly}(n,1/\varepsilon)$ coordinates can make exponentially many length-$n$ identities have pairwise correlation at most $\varepsilon$, and an improper learner can agnostically learn arbitrary labels on that polynomial block by lookup-table ERM. The hidden weak exponent can even be handled in the usual lower-bound way: if a learner for the fixed marginal has gap exponent $k_P$, choose a constant amplification level $L>k_P$.

The fixed-marginal problem is the obstruction. If separate length/amplification blocks are given masses $\mu_{n,L}$, then the weak advantage on the hard block is multiplied by $\mu_{n,L}$ and eventually becomes ignorable. If instead every length uses a high-mass prefix of a single countable marginal $P$, then finite heavy atoms force large wrong-instance agreement. Concretely, fix $\eta<1/4$ and choose a finite set $S$ with $P(S)>1-\eta$. For all large $n$, there are exponentially many satisfiable length-$n$ instances but only $2^{|S|}$ sign patterns on $S$, so two distinct valid identities agree on all atoms of $S$. Their $\{\pm 1\}$ correlation under $P$ is at least

$$
P(S)-P(S^c)>1-2\eta,
$$

far above any inverse-polynomial weak threshold. Thus a fixed countable marginal cannot simultaneously give every hard length near-unit active mass and make all wrong identities weak-safe. This is the exact obstruction for finite-transcript dense-code repairs.

Hadamard/parity identities avoid the finite-block coding barrier on an atomless or exponentially large uniform domain: distinct messages are exactly orthogonal, and BLR-style linearity testing is the classical local test for this geometry ([Blum-Luby-Rubinfeld 1993](https://doi.org/10.1016/0022-0000(93)90044-W)). But then the source learner is no longer the easy lookup learner. Under the uniform parity domain, agnostic improper learning of the identity family becomes parity/correlation search rather than finite-support memorization; making the Hadamard domain explicit restores lookup learning only by making the representation or support exponential. This is the same model-boundary issue noted in [[properization-open|Properization Open]].

### DNF And Proper-Learning Hardness Templates

The classical proper-learning hardness results are also near-misses rather than fixed-marginal counterexamples. Pitt and Valiant show distribution-free computational limitations for several representation classes, including disjunctions of two monomials, unless $\mathrm{RP}=\mathrm{NP}$ ([Pitt-Valiant 1988](https://doi.org/10.1145/48014.63140)). Khot and Saket prove, assuming $\mathrm{NP}\nsubseteq\mathrm{RP}$, that two-term DNF cannot be PAC-learned by fixed $t$-term DNF to accuracy $1/2+\epsilon$ for constant $\epsilon$ ([Khot-Saket 2008](https://cs.nyu.edu/~khot/papers/minDNF.pdf)).

These are proper-output hardness templates, but they do not give the assigned edge. Their hard distributions encode the reduction instance, so marginal-nonuniformity can hide the runtime. They also do not provide, for the same benchmark class, a distribution-free efficient agnostic improper learner of the kind the source node requires. In the atlas, fixed-$k$ DNF is instead a positive weak-proper boundary example, while the lookup-style DNF/constraint witnesses that have easy improper learners use instance-specific active mass.

### Conditional Statement That Would Suffice

A conditional counterexample under $\mathrm{NP}\nsubseteq\mathrm{RP}$ would follow from the following additional primitive, but I do not know a standard theorem that supplies it.

For every NP language $L$, construct a concept class $\mathcal C$ with polynomial-time evaluation and one fixed efficiently samplable marginal $P$ such that:

1. $\mathcal C$ is distribution-free efficiently agnostically learnable by an improper learner.
2. For each input $\varphi$ and amplification level $L_0$, one can sample labels $y_{\varphi,L_0}$ over the same $P$ in polynomial time.
3. If $\varphi\in L$, some proper concept $c_{\varphi,w,L_0}$ realizes $y_{\varphi,L_0}$.
4. For every proper $c\in\mathcal C$, if $\mathbb{E}_P[y_{\varphi,L_0}c]\ge |\varphi|^{-K}$ for any chosen constant $K$, then $c$ efficiently decodes a valid witness for $\varphi$.
5. The representation size and the source improper learner remain polynomial in $|\varphi|$ for each fixed $K$.

Items 2--4 are an identity-protected low-correlation agreement code under one fixed high-mass marginal. Active-slice PCPs satisfy identity without a fixed marginal. Shared-randomness PCPs satisfy fixed marginal without identity. Dense finite codes satisfy low cross-correlation on one polynomial block but not under one fixed high-mass marginal across all lengths. Hadamard-style codes satisfy identity geometry but break the easy improper agnostic source.

### Branch Verdict

This branch does not resolve the edge. The exact obstruction is now sharper: a fixed-marginal weak proper lower bound needs computational weak-handle hardness, not merely PCP soundness or pairwise code distance. Wrong-instance proper hypotheses may exist with inverse-polynomial correlation; a successful counterexample would have to show that finding any such weak handle is itself hard, while still preserving an efficient distribution-free agnostic improper learner. The standard PCP, label-cover, agreement-test, dense-code, and DNF proper-learning templates do not currently provide that combination.

Verdict for this branch: unresolved.
