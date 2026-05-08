# Edge: efficient-agnostic-improper-pac -> efficient-marginal-nonuniform-weak-agnostic-proper-pac

- depth: 1
- edge_file: atlas/implications/efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md
- verdict: unresolved
- confidence: medium

## Context

The source node gives one polynomial-time distribution-free agnostic learner, allowed to output hypotheses outside $\mathcal C$, with arbitrary excess accuracy $\varepsilon$.

The target node asks for one uniform proper learner, but only in the marginal-nonuniform weak agnostic sense. For each instance marginal $P$, the learner may have a $P$-dependent polynomial resource bound and a $P$-dependent additive tolerance $\beta_P(s)<1/2$ with inverse-polynomial gap from $1/2$. The learner itself is not supplied as $P$-specific advice.

Thus the only hard direction is properization. Distribution-free strong agnostic improper learning immediately gives marginal-nonuniform weak agnostic improper learning, but the output still need not lie in $\mathcal C$.

The current edge note classifies the edge under [[properization-open|Properization Open]]. I checked the linked argument note and the two carved-out counterexample families:

- [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]
- [[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]]
- [[one-way-image-coordinate-weak-handle-hardness|One-Way Image Coordinate Weak-Handle Hardness]]

## Attempted Resolution

### Positive route: project the improper learner

The source learner can be run to very small excess error. If the best proper concept has noticeable advantage over random guessing under a fixed marginal $P$, the improper learner can produce an equally good predictor. However, I found no generic way to convert that predictor into a member of $\mathcal C$ in polynomial time.

The sample-only analogue is not a guide for the computational edge: unbounded ERM plus VC theory can recover proper hypotheses, but the target is still computationally efficient. Marginal-nonuniformity only relaxes the polynomial bound after $P$ is fixed; it does not give the learner a $P$-specific search procedure or advice for optimizing over $\mathcal C$.

### PCP active-slice counterexample route

The PCP active-slice lookup class is promising because the atlas already records that it is agnostically learnable by an improper one-slice lookup-table ERM, while weak proper learning would decide an NP-complete language in the distribution-free setting.

The obstruction is exactly marginal nonuniformity. The hard reduction chooses the marginal concentrated on the active slice of the input instance $\varphi$. If a marginal-nonuniform proper learner is assumed, the polynomial resource bound may depend on this particular slice marginal $P_\varphi$. A reduction deciding the NP instance would need a runtime bound polynomial uniformly in $|\varphi|$, but the hidden constants and exponent in $p_{P_\varphi}$ may depend on $\varphi$ itself. For a fixed finite slice, even exhaustive search over proofs can be absorbed into the $P_\varphi$-dependent constant. So this witness separates distribution-free weak proper learning, but does not refute the marginal-nonuniform target.

Packing all active slices into one fixed marginal also does not immediately work. If each instance slice receives small mass, the PCP acceptance gap is multiplied by that slice mass. Since the target only requires inverse-polynomial weak advantage at representation size $s$, exponentially many possible input slices cannot all receive inverse-polynomial mass under one fixed marginal.

### One-way image-coordinate route

The one-way image-coordinate class gives efficient agnostic improper learning by sparse lookup-table ERM and rules out marginal-nonuniform strong proper learning under length-preserving one-way functions. But that lower bound uses accuracy $\varepsilon_n=\mu_n/(3n)$ under the fixed coordinate marginal, which forces recovery of a seed whose image equals the one-way challenge.

The present target is weak. Under the fixed coordinate marginal, a weak proper learner need only beat error $1/2$ by an inverse polynomial. The usual sparse image-coordinate construction has easy weak escape routes: wrong-length seed concepts, constants, singleton handles, or other low-support hypotheses can achieve nontrivial error without identifying the challenge image. The weak-handle variant in the atlas is explicitly designed to make weak proper learning easy while preserving strong proper hardness, so it cannot refute this edge.

A denser code-based variant is tempting: encode $f(s)$ as a balanced codeword so that any proper hypothesis with inverse-polynomial advantage must recover a preimage. But this runs into a tradeoff. Polynomial-length binary codes can make wrong codewords have only bounded inverse-polynomial correlation, yet the target learner may choose an even smaller inverse-polynomial gap. Hadamard-style exact orthogonality would solve the weak-gap issue, but then the domain is exponentially large and agnostic improper learnability becomes essentially agnostic parity learning rather than the easy sparse lookup-table ERM used by the current witness.

## Proposed Atlas Update

No resolved atlas update proposed.

If the edge note is refreshed, I would keep:

- `status: "open"`
- `evidence: unknown`
- `assumptions: []`
- `witnesses: []`
- `family: properization-open`

Suggested summary replacement:

> Open: distribution-free agnostic improper learning gives the required weak agnostic prediction guarantee, but no generic polynomial-time projection to a proper hypothesis is known; current PCP and one-way-function witnesses fail to refute the marginal-nonuniform weak target.

Suggested body sketch:

> The edge reduces to a marginal-nonuniform weak properization problem. Running the source learner under a fixed marginal gives a strong improper agnostic predictor, hence certainly a weak one, but the target requires output in $\mathcal C$. The PCP active-slice witness separates distribution-free weak proper learning, yet its hard marginal varies with the input slice and marginal-nonuniform runtime bounds may depend on that slice. The one-way image-coordinate witness separates strong marginal proper learning, but weak proper learners can exploit low-support or handle hypotheses without inverting the one-way function. Thus neither known counterexample family resolves the edge, and no positive projection theorem is recorded.

## Obstacles

- A positive proof would need a computationally efficient properization theorem from an arbitrary agnostic improper learner to a proper weak learner at each fixed marginal. VC/sample-complexity properization does not provide this.
- The PCP active-slice lower bound gives the right weak proper hardness, but only with input-dependent marginals. Marginal-nonuniformity hides the resulting per-instance search cost in $p_{P_\varphi}$.
- Fixed-marginal cryptographic witnesses give strong proper hardness, but the weak threshold allows hypotheses that beat random guessing without recovering the hard representation.
- DNF-based properization separations remain near misses: fixed-$k$ DNF has proper weak learners, and Khot-Saket constant-advantage hardness does not rule out the atlas's inverse-polynomial weak convention.

## Next Directions

1. Try to build a fixed-marginal PCP packing with inverse-polynomial mass for all hard slices of a given representation size, perhaps by changing the representation so only polynomially many slices compete at each size.
2. Look for a cryptographic class with efficient agnostic improper learning and a balanced fixed marginal where every inverse-polynomially weak proper hypothesis yields an inverter. A locally decodable or nearly orthogonal code of one-way images is the natural template, but it must avoid agnostic-parity hardness for the improper learner.
3. Investigate whether marginal-nonuniform weak agnostic proper learning follows from efficient agnostic improper learning under additional assumptions on the class representation, such as efficient proper ERM over finite traces or effective discreteness of each fixed marginal.
4. Check whether any primary source has a true weak properization theorem for agnostic improper PAC learning with inverse-polynomial advantage; none is recorded in the current atlas notes.

## References Checked

- [[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]]
- [[efficient-marginal-nonuniform-weak-agnostic-proper-pac|Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning]]
- [[properization-open|Properization Open]]
- [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]
- [[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]]
- [[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]]
- [[one-way-image-coordinate-class|One-Way Image Coordinate Class]]
- [[one-way-image-coordinate-weak-handle-hardness|One-Way Image Coordinate Weak-Handle Hardness]]
- [[one-way-image-coordinate-weak-handle-class|One-Way Image Coordinate Weak-Handle Class]]
- Schapire 1990, Pitt and Valiant 1988, Khot and Saket 2008 as cited by the edge note
- Kearns and Valiant 1994 and Håstad et al. 1999 as cited by the one-way-function witnesses
- Håstad and Khot 2005 and Karp 1972 as cited by the PCP active-slice witness

---

# Depth-2 Follow-Up

- depth: 2
- edge_file: atlas/implications/efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md
- verdict: unresolved
- confidence: medium-high

## Context

The target guarantee is weaker than a usual excess-accuracy target in a way that matters for all three proposed false routes. For a fixed marginal $P$, the learner may return any proper $h$ with
$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\beta_P(s),
\qquad
\beta_P(s)=1/2-\gamma_P(s),
$$
where $\gamma_P(s)$ is only some inverse-polynomial advantage. Thus a hard gadget of total marginal mass $w$ does not become visible merely because $w$ is inverse-polynomial. If the rest of the distribution is easy or pure baseline noise, then ignoring the gadget costs only $w$, and this can already be below the allowed additive tolerance. To force a local weak decision on the gadget from the global weak guarantee, the gadget usually needs mass bounded close to a constant, not just $1/\operatorname{poly}(s)$.

I checked this point against the three requested routes:

1. PCP active-slice packing.
2. One-way image-coordinate weak proper hardness.
3. Clause-satisfaction proper hardness with low-noise or margin amplification.

## Attempted Resolution

### 1. PCP Active-Slice Packing

The tempting construction is to put all active PCP slices into one fixed marginal $P^\star$, giving slice $\varphi$ mass $w_\varphi$, and on input $\varphi$ label the active slice by $1$ while making the off-slice region harmless. This does not refute the target unless $w_\varphi$ is essentially constant.

For the clean realizable version, label the $\varphi$ slice by $1$ and all other slices by $0$. If $\varphi$ is satisfiable, a proper concept $(\varphi,\pi)$ realizes the distribution. A weak proper learner is only required to output global error at most $1/2-\gamma_{P^\star}(s)$. A hypothesis that simply misses the entire active slice has global error $w_\varphi$. Therefore, unless
$$
w_\varphi > 1/2-\gamma_{P^\star}(s),
$$
the weak guarantee does not even force the returned proper hypothesis to notice the active slice. With fair-noise padding off the active slice, the same calculation reappears after subtracting the shared baseline: the active-slice error budget is still roughly $1/2-\gamma_{P^\star}(s)$, so local acceptance above $1/2$ requires active mass near one.

This is stronger than the depth-1 "exponentially many slices cannot all have inverse-polynomial mass" obstruction. Inverse-polynomial mass per slice would be enough for a strong accuracy target that can ask for $\varepsilon \ll w_\varphi$, but it is not enough for the atlas weak agnostic target because the additive tolerance is close to $1/2$.

Could we reduce the number of hard slices at each size to polynomially many so each receives constant or large mass? Not in the usual way. A polynomial-slice packing would amount to a sparse hard set or a representation that blows the NP instance length up so much that a runtime polynomial in the representation size is no longer a polynomial-time algorithm for the original instance. In particular, assigning mass $2^{-|\varphi|}$ can be made inverse-polynomial only by taking representation size about $2^{|\varphi|}$, which destroys the NP-hardness contradiction.

### 2. One-Way Image-Coordinate Weak Proper Hardness

The original image-coordinate witness is strong because accuracy $\varepsilon_n=\mu_n/(3n)$ forces exact recovery of the length-$n$ image block. The weak target does not ask for such accuracy. Under the fixed all-length marginal, the length-$n$ block has mass $\mu_n=6/(\pi^2 n^2)$, and any same-length seed concept has error at most $\mu_n$ against the target, even if its image is completely wrong. Since $\mu_n \ll 1/2-\gamma_P(n)$ for all large $n$, such wrong-image concepts are already valid weak outputs.

Trying to make the block heavy enough for weak learning runs into a counting barrier: one fixed marginal cannot assign mass close to one to infinitely many disjoint length blocks. Concentrating on a single length $n$ would let the marginal-dependent runtime polynomial depend on that $n$, so it would not give a uniform inverter for a length-preserving one-way function.

The only plausible repair is to make all lengths share a common high-mass coordinate space, for example by encoding $f(s)$ as a balanced codeword over a common marginal. Then any weakly correlated proper codeword might reveal a preimage. But the source side becomes the problem. Hadamard or parity-style encodings give the right pairwise distance, yet agnostic improper learning becomes a noisy-parity/correlation-search task rather than sparse lookup-table ERM. Polynomial-length codes keep lookup ERM easy only on finite blocks, and then either wrong codewords have nonzero inverse-polynomial correlations at an unknown scale or the block-mass dilution returns.

So the one-way route still looks like a strong-proper separation only. I do not see a way to strengthen it to weak proper without replacing the sparse coordinate idea by a genuinely new dense-code construction whose agnostic improper learner remains efficient.

### 3. Clause-Satisfaction Hardness With Low Noise Or Amplification

The clause-satisfaction class resolves the corresponding strong marginal agnostic proper edge because the learner can be run to accuracy $O(1/|X_n|)$. It does not directly touch this weak edge.

Under the fixed uniform clause marginal $P_n$, with formula clauses labeled $1$ and non-formula clauses fair-noisy, every assignment $a$ has error
$$
\operatorname{err}(h_a)
=
\frac{\#\{C\in F:a\text{ falsifies }C\}}{|X_n|}
+\frac{|X_n|-|F|}{2|X_n|}.
$$
The satisfiable/unsatisfiable optimum gap is only $1/|X_n|$. A weak learner may add almost $1/2$, so it need not return an assignment satisfying all formula clauses, or even one close enough to certify satisfiability.

Low-noise padding does not fix the basic additive-tolerance problem. If the satisfiable optimum is $\eta$, the guarantee is still only $\eta+1/2-\gamma_P(n)$. To force a returned assignment to satisfy an input clause exactly, falsifying that clause would have to cost more than roughly $1/2$ of the total marginal mass. No fixed marginal over polynomially many possible clauses can give that much mass to every possible input clause.

Margin amplification by direct products also runs into the source/size tradeoff. Repeating clauses until one violated clause causes constant error requires product length on the order of the clause universe size in the worst case; the naive product domain then has superpolynomial size, breaking the simple lookup-table agnostic improper learner. PCPs are exactly the efficient way to get constant soundness with logarithmic randomness, but the known active-slice implementation puts the hard instance into the marginal, which returns us to the packing obstacle above. A fixed-marginal PCP whose input is carried only by labels would need to prevent proper hypotheses for unrelated satisfiable instances from acting as weak handles; I did not find such a construction.

## Proposed Atlas Update

No resolved atlas update proposed. I would keep:

- `status: "open"`
- `evidence: unknown`
- `assumptions: []`
- `witnesses: []`
- `family: properization-open`

Suggested sharper summary:

> Open: strong agnostic improper learning gives accurate external prediction, but no efficient projection to even a weak proper concept is known; current fixed-marginal hardness templates either require strong accuracy or lose the hard gadget under the weak additive $1/2-\gamma$ tolerance.

Suggested body addition:

> A fixed-marginal active-slice counterexample would need more than inverse-polynomial mass on each hard slice. Because the target's weak agnostic tolerance is close to $1/2$, a learner can ignore any low-mass hard slice and still satisfy the global weak guarantee. This blocks straightforward PCP packing. The one-way image-coordinate witness has the same defect at the weak threshold: wrong same-length seed concepts have only low global error under the all-length marginal. Clause-satisfaction fixed-marginal hardness gives strong-accuracy gaps of order $1/|X_n|$, but low-noise or direct-product amplification has not produced a polynomial-size, fixed-marginal weak separation with an efficient agnostic improper lookup learner.

## Obstacles

- Weak additive tolerance is the dominant obstruction. A gadget of mass $w \ll 1/2$ can often be ignored, even when $w$ is inverse-polynomial.
- Marginal-nonuniformity prevents using a separate hard marginal $P_\varphi$ for each input instance, because the runtime polynomial and weak gap may depend on that marginal.
- Dense shared-coordinate cryptographic encodings would need near-orthogonality against all wrong proper concepts while preserving efficient distribution-free agnostic improper learning.
- Clause/CSP amplification must make every relevant violation cost constant mass without making the instance domain superpolynomial or smuggling the hard instance back into the marginal.

## Next Directions

1. Search specifically for fixed-marginal PCPs or label-cover encodings where the input instance appears in labels but unrelated proper hypotheses are automatically near-random, not useful weak handles. This is the most direct way to rescue the PCP route.
2. Explore shared-domain code families for one-way images with an explicit improper agnostic learner. A candidate would need a tractable relaxation richer than proper codewords but easier than agnostic parity.
3. Try sampler-based clause amplification: replace naive direct products by an explicit polynomial-size family of tests, then check whether labels can encode the formula while satisfiable assignments have low error and unsatisfiable assignments exceed $1/2$ error under the fixed marginal.
4. Investigate a positive theorem under local representation assumptions: if for every fixed marginal the trace of $\mathcal C$ on polynomial samples has an efficiently searchable weak cover, then the source improper learner can be projected. This would not resolve the atlas edge globally, but it would delimit what a counterexample must violate.

## References Checked

- [[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]]
- [[efficient-marginal-nonuniform-weak-agnostic-proper-pac|Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning]]
- [[efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-proper-pac|Efficient Agnostic Improper PAC Learning -> Efficient Marginal-Nonuniform Agnostic Proper PAC Learning]]
- [[efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac|Efficient Marginal-Nonuniform Agnostic Improper PAC Learning -> Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning]]
- [[clause-satisfaction-proper-hardness|Clause-Satisfaction Proper Hardness]]
- [[clause-satisfaction-lookup-class|Clause-Satisfaction Lookup Class]]
- [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]
- [[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]]
- [[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]]
- [[one-way-image-coordinate-class|One-Way Image Coordinate Class]]
- [[one-way-image-coordinate-weak-handle-hardness|One-Way Image Coordinate Weak-Handle Hardness]]
- Håstad and Khot 2005, Query Efficient PCPs with Perfect Completeness. The abstract states logarithmic randomness, perfect completeness, and arbitrarily small soundness via query-efficient PCPs.
- Khot and Saket 2008, Hardness of Minimizing and Learning DNF Expressions. The abstract states constant-advantage hardness for learning two-term DNF by fixed-size DNF under $\mathrm{NP}\nsubseteq\mathrm{RP}$.
- Kearns and Valiant 1994, Cryptographic Limitations on Learning Boolean Formulae and Finite Automata, as the standard cryptographic-learning hardness template behind the one-way-function witnesses.

---

# Depth-3 Follow-Up

- depth: 3
- edge_file: atlas/implications/efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md
- verdict: unresolved
- confidence: medium-high

## Focus

Depth 2 showed that low-mass hard slices are invisible to the atlas weak agnostic target. This pass asks whether the hard instances can instead share one fixed high-mass marginal: a single $P^\star$ that puts constant mass on the hardness gadget while an improper agnostic learner remains efficient for all concept sizes.

The useful dichotomy is:

1. If size-$n$ gadgets live on disjoint blocks, then one fixed marginal cannot give all blocks constant mass. Tail weights $\mu_n\to 0$ return the weak-tolerance obstruction.
2. If all sizes or all instances share a high-mass block, then the construction must prevent unrelated proper hypotheses from becoming weak handles on that same block.

I did not find an existing atlas construction that satisfies the second requirement.

## Attempted Resolution

### 1. Constant-Mass Disjoint Gadgets

Putting constant mass on one hard gadget is easy for one fixed size or one fixed NP instance family, but it does not give a uniform lower bound across concept sizes. A marginal such as
$$
P^\star=\sum_n \mu_n P_n
$$
must have $\mu_n\to 0$ on infinitely many size blocks. For a weak target, the proper learner may ignore the length-$n$ block once $\mu_n < 1/2-\gamma_{P^\star}(s_n)$, and the reduction cannot demand a smaller accuracy parameter. This is exactly why the one-way image-coordinate marginal works for strong accuracy but not for the weak target.

Trying to hide the decay by inflating the representation size also does not preserve a hardness contradiction. If $\mu_n$ is made inverse-polynomial by representing length-$n$ instances at size about $1/\mu_n$, then a learner running in time polynomial in the representation size may be superpolynomial in the original hard instance length.

So a real counterexample needs a shared high-mass domain rather than a summable family of disjoint hard blocks.

### 2. Shared PCP Verifier Domains

The most tempting shared-domain PCP variant is: use a verifier with a common random-string domain $R_n$, let proper concepts be proof-indexed verifier transcripts, and label the uniform distribution over $R_n$ by the input instance. If satisfiable instances have accepting proofs and unsatisfiable instances have acceptance below $1/2$, then a weak proper learner would decide the language.

The obstruction is that standard PCP predicates depend on the input instance. There are two ways to expose that dependence, and both break the hoped-for fixed-marginal construction.

First, if the example contains the instance or its induced local predicate, then the support or marginal again depends on the input unless all possible predicates are included under one global distribution. Including all possible predicates dilutes the particular input's tests, recreating the active-slice packing problem.

Second, if the example is only the common random string and the proper hypothesis carries an instance-proof pair $(\psi,\pi)$, then unrelated satisfiable instances become handles. With perfect completeness, any satisfiable $\psi$ has a proof accepted on every random string in its own verifier computation. On a shared $R_n$ domain, such a hypothesis can look like an all-one or high-acceptance predictor even when the target labels came from a different input $\varphi$. The active-slice construction avoided exactly this by forcing concepts for $\psi\ne\varphi$ to output $0$ on the $\varphi$ slice.

A more local encoding could put examples of the form "test index plus local answer" into the domain and let labels encode the input predicate's truth table. This makes the marginal closer to fixed, but then proper proof hypotheses do not naturally realize the label function: a proof selects one local answer tuple, while the predicate truth table may mark many tuples as accepting. If the concept is allowed to include the formula so it can evaluate the predicate on the proof's tuple, unrelated-formula handles return; if the concept is not allowed to include the formula, the proper hypothesis lacks the information needed to compute the target predicate.

Thus the shared-PCP route still needs a genuinely fixed verifier/test distribution in which the input changes a constant fraction of labels, satisfiable inputs have a proper witness, unsatisfiable inputs have no weakly correlated proper witness, and unrelated satisfiable inputs do not give generic weak handles. I do not see such a construction in the current notes.

### 3. Dense Encodings And Shared Coordinate Spaces

Dense code encodings are the cleanest way to make all targets share one high-mass coordinate space. For a one-way function, encode $f(s)$ as a balanced codeword over a common domain $U_n$ and define proper concepts by seeds. If every wrong seed has correlation below the target's weak advantage, then any weak proper output would recover a preimage.

The quantitative barrier is the unknown inverse-polynomial weak gap. Under the target definition, for the fixed marginal $P^\star$ there merely exists some polynomial lower bound $\gamma_{P^\star}(s)\ge 1/q_{P^\star}(s)$. A hardness construction cannot assume the exponent. Therefore, wrong proper concepts must have correlation smaller than every possible inverse polynomial in the relevant size, or at least small enough by a parameter that does not destroy the reduction.

Polynomial-length dense codes do not seem to give this. With $2^n$ messages and block length $N=\operatorname{poly}(n)$, one can make pairwise correlations inverse-polynomially small by taking $N$ large, but not smaller than every inverse polynomial while keeping $N$ polynomial. A weak learner whose guaranteed advantage is below the residual correlation could legally output a wrong seed and still satisfy the target guarantee.

Hadamard-style orthogonal encodings would fix the weak-gap issue: distinct messages have zero correlation, so any nonzero weak advantage identifies a matching image. But the domain has size $2^n$. Then the source side stops being the easy sparse or polynomial-domain lookup ERM; learning the codeword from arbitrary noisy examples becomes a parity/correlation-search problem rather than the atlas's efficient agnostic improper learner.

This leaves a narrow possible window: a structured relaxation that is richer than the proper seed-codeword class, efficiently agnostically learnable, and still forces every proper weak output to recover the seed. No such relaxation is recorded here.

### 4. Direct Products And Repetition

Direct products can reduce residual correlations or amplify local soundness gaps, but they do not remove the shared-marginal problem.

For dense codes, taking $t$ tensor powers shrinks a wrong-codeword correlation from $\rho$ to $\rho^t$. A constant $t$ only changes the inverse-polynomial exponent. A superconstant $t$ can beat more exponents, but the product domain grows as $N^t$. If this is kept explicit so that the improper learner can do polynomial-domain lookup, the representation size grows with $N^t$; a reduction from length-$n$ one-way inversion or NP instances may then run in time polynomial in $N^t$, not polynomial in $n$.

For PCP/CSP gadgets, parallel repetition lowers soundness on the active test distribution, but the active test distribution still has to be attached to the input instance. If the repeated tests are packed into a fixed global marginal, the active mass is diluted. If all inputs share the repeated test distribution, unrelated satisfiable instances or formula-carrying hypotheses again become weak handles unless the construction prevents them by design.

So repetition is useful only after a constant-mass shared-domain base construction is found. It does not by itself produce one.

### 5. Existing Proper-Hardness Constructions With Fixed Marginals

The atlas has fixed-marginal or near-fixed-marginal proper-hardness examples, but none gives the needed constant global weak gap for this edge.

- The one-way image-coordinate construction has one fixed all-length marginal, but the length-$n$ hard block has mass $\mu_n=O(1/n^2)$. Strong accuracy can ask for $\varepsilon\ll\mu_n/n$; weak agnostic learning cannot.
- The clause-satisfaction construction has a fixed uniform clause marginal at a fixed variable size and gives a proper-search hardness template. Its gap is $1/|X_n|$ for exact clause satisfaction, and depth 2 already noted that the weak additive tolerance can absorb this. Low-noise padding does not make every clause violation cost constant mass.
- Khot-Saket style DNF hardness is a genuine constant-advantage proper-learning lower bound, but it is a near miss for the atlas convention: the target only asks for inverse-polynomial weak advantage, and fixed-$k$ DNF is already weakly properly learnable at that scale.
- The PCP active-slice construction gives the right constant local weak gap, but only because the marginal is the active input slice. Once made marginal-nonuniform, that input-specific marginal lets the learner's polynomial depend on the instance.

I therefore do not see a known proper-hardness construction in the current atlas that already has: one fixed marginal, constant mass on every relevant hard instance, an efficient distribution-free agnostic improper learner, and no weak proper handles.

## Verdict

Still unresolved. The constant-mass idea sharpens the counterexample requirements but does not yet produce a separation. A fixed marginal can put constant mass on a single shared hardness arena, but then the arena must encode all hard instances through labels or shared coordinates without giving the proper learner an unrelated weak handle. Existing PCP, clause/CSP, DNF, and one-way-coordinate constructions each miss one part of that package.

## Obstacles

- A fixed marginal over disjoint size or instance blocks cannot assign constant mass to infinitely many hard blocks.
- Shared PCP domains lose the active-slice isolation: either the input-dependent tests enter the marginal, or unrelated satisfiable instances become high-acceptance proper handles.
- Dense polynomial-length codes leave residual inverse-polynomial correlations, while the target's weak advantage may be an even smaller inverse polynomial.
- Orthogonal/Hadamard encodings remove residual correlations but make the improper agnostic learner look like a hard correlation-search learner rather than a polynomial lookup ERM.
- Direct products amplify gaps only after a shared constant-mass base gadget exists; by themselves they increase domain or representation size enough to threaten the hardness reduction.

## Next Depth-4 Directions

1. Formalize the shared-PCP obstruction as a lemma: in a perfect-completeness shared-randomness PCP class where concepts include instance-proof pairs, any satisfiable unrelated instance gives an all-one or high-acceptance weak handle unless the example domain includes an active-instance coordinate.
2. Search for PCP or label-cover normal forms with a universal constraint hypergraph and binary labels encoding predicates, then test whether proof-only proper hypotheses can realize satisfiable instances without carrying the formula as advice.
3. Quantify the dense-code lower bound needed here: for $2^n$ messages and polynomial domain length $N(s)$, bound the best possible maximum wrong correlation and compare it to an unknown $\gamma_{P^\star}(s)=1/s^{k_P}$.
4. Look for an improper agnostic learner for a rich relaxation of Hadamard/codeword concepts that avoids full agnostic parity learning but still contains every proper seed concept.
5. Audit fixed-marginal hardness papers for constructions where the input changes labels on a constant fraction of a universal domain and all wrong proper hypotheses are provably at error at least $1/2-o(1/\operatorname{poly})$; that is the exact missing shape.

## References Checked

- [[properization-open|Properization Open]]
- [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]
- [[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]]
- [[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]]
- [[one-way-image-coordinate-class|One-Way Image Coordinate Class]]
- [[one-way-image-coordinate-weak-handle-hardness|One-Way Image Coordinate Weak-Handle Hardness]]
- [[clause-satisfaction-proper-hardness|Clause-Satisfaction Proper Hardness]]
- [[clause-satisfaction-lookup-class|Clause-Satisfaction Lookup Class]]
- [[fixed-k-term-dnf-proper-boosting-separation|Fixed-k-Term DNF Proper Boosting Separation]]
- Håstad and Khot 2005, Khot and Saket 2008, Kearns and Valiant 1994, Håstad et al. 1999, Pitt and Valiant 1988, and Schapire 1990 as cited in the atlas notes above.

---

# Depth-4 Follow-Up

- depth: 4
- edge_file: atlas/implications/efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md
- verdict: unresolved
- confidence: medium-high

## Focus

This pass follows the depth-3 directions most directly relevant to a fixed-marginal weak separation:

1. shared-PCP obstruction lemmas,
2. universal label-cover normal forms,
3. dense-code correlation bounds, and
4. Hadamard-style relaxations.

The outcome is negative but useful. I do not see a real separation or positive theorem from these routes. What does emerge are concrete impossibility statements for several natural templates. Each template can satisfy two of the needed properties, but not all three:

- one fixed high-mass marginal,
- no inverse-polynomial weak proper handles except genuine witnesses,
- efficient distribution-free agnostic improper learning.

## Attempted Resolution

### 1. Shared-PCP Lemmas

The clean shared-randomness PCP idea is to replace the active slice $(\varphi,r)$ by a common random-string domain $R_n$. Proper concepts would be indexed by an instance-proof pair $(\psi,\pi)$ and output
$$
h_{\psi,\pi}(r)=V(\psi,\pi,r).
$$
The target labels for input $\varphi$ would live on the same marginal, usually the uniform distribution on $R_n$.

This has a simple handle obstruction. With perfect completeness, every satisfiable $\psi$ has a proof $\pi_\psi$ accepted on every $r\in R_n$. Hence $h_{\psi,\pi_\psi}$ is the all-one function on the shared domain. If any satisfiable instance of the same size is present in the class, the proper class already contains an all-one handle. Then labeling the shared domain by all ones for a satisfiable $\varphi$ does not force the learner to return a proof for $\varphi$, and labeling it by a verifier-derived predicate for an unsatisfiable $\varphi$ is not enough to prevent unrelated satisfiable handles unless the construction reintroduces an active-instance coordinate or otherwise makes cross-instance hypotheses nearly orthogonal.

This gives a concrete no-go for the most direct shared-PCP template:

> In a perfect-completeness shared-randomness PCP class where concepts include unrestricted instance-proof pairs and examples do not contain an active-instance gate, satisfiable unrelated instances create proper hypotheses with constant positive advantage on the shared marginal. Such a class cannot yield the desired weak marginal-nonuniform separation.

The active-slice construction avoids this exactly by forcing $h_{\psi,\pi}$ to output $0$ on the $\varphi$ slice when $\psi\ne\varphi$. Removing that gate loses the isolation; keeping it makes the hard marginal input-dependent.

### 2. Universal Label-Cover Forms

Universal label-cover is the natural attempt to keep a fixed marginal while avoiding the all-one shared-PCP handle. Put all size-$n$ instances on one fixed constraint graph or test hypergraph, sample a uniformly random edge/test, and let the input instance change only the local constraint predicates.

There are two representation choices, and both are blocked.

If a proper hypothesis includes the instance predicates, then unrelated satisfiable instances again become handles: a hypothesis for $(\psi,\pi)$ can compute $\psi$'s local predicates on the shared test graph, and if $\psi$ is satisfiable it may have high acceptance independent of the target $\varphi$.

If a proper hypothesis does not include the instance predicates and is only a proof or label assignment, then it generally cannot realize a satisfiable target. An assignment supplies one local answer tuple per edge, whereas the target label function for a constraint usually marks a set of accepting tuples. To make a proof-only hypothesis match the target labels, examples must include answer tuples or predicate descriptions. Including predicate descriptions under a fixed global marginal dilutes the active predicates for a particular input; including only the target predicates makes the marginal input-dependent.

Thus the universal-label-cover route has a realization-or-handle dilemma:

> Either the formula/constraint data is inside the proper hypothesis, in which case unrelated satisfiable formulas supply weak handles, or the formula/constraint data is outside the hypothesis, in which case proof-only concepts do not naturally realize satisfiable instances without moving the input dependence into the marginal or into a diluted global predicate universe.

I do not see a universal label-cover normal form in the current notes that avoids this dilemma. A successful version would need a fixed test distribution where the input changes a constant fraction of labels, satisfiable instances have proper witnesses, and every witness for the wrong instance has correlation below every relevant inverse-polynomial weak gap.

### 3. Dense-Code Correlation Bounds

Dense code encodings address the constant-mass problem directly. Put all messages on one fixed coordinate domain $U_n$ and let a proper seed/message $m$ output a codeword $C(m)\in\{\pm1\}^{U_n}$. If every wrong codeword has negligible correlation with $C(m)$, then any weak proper learner with nonzero inverse-polynomial advantage would have to identify $m$.

For polynomial-length codes, there is a quantitative obstruction. Suppose there are $M=2^n$ possible messages and code length $N=\operatorname{poly}(n)$, with normalized code vectors in $\mathbb R^N$. A Gram-matrix or Welch-bound argument implies that some pair of codewords has absolute correlation at least on the order of $1/\sqrt N$ when $M\gg N$. Even random or optimized polynomial-length codes only push the maximum wrong correlation down to an inverse polynomial whose exponent is controlled by $N$.

That is not enough for this edge. For the fixed marginal $P^\star$, the target learner's weak advantage is only known to be some inverse polynomial $\gamma_{P^\star}(s)=1/s^{k_P}$, with unknown exponent. If wrong codewords retain correlation $\rho(s)=1/\operatorname{poly}(s)$, then a putative learner with guaranteed advantage below $\rho(s)$ may legally output a wrong correlated codeword. The reduction cannot demand a larger advantage.

So polynomial dense codes give a concrete impossibility for this template:

> A polynomial-length shared code cannot uniformly force all wrong proper hypotheses below every possible inverse-polynomial weak advantage unless it has exact orthogonality or superpolynomially small correlations. Pairwise-distance amplification with a fixed polynomial block length only changes the exponent and cannot cover the unknown marginal-dependent weak exponent.

This does not rule out all dense-code separations, but it rules out the standard "choose a sufficiently good polynomial code" repair.

### 4. Hadamard-Style Relaxations

Hadamard codes solve the previous correlation problem. Distinct messages have zero correlation on the uniform domain, so any positive weak proper advantage against the target codeword identifies the exact message.

The cost is on the source side. With the Hadamard domain represented implicitly as $\{0,1\}^n$, agnostically learning the proper codewords is agnostic parity learning under arbitrary noise and arbitrary distributions. An efficient distribution-free agnostic improper learner for a relaxation containing these codewords would be a very strong algorithmic object, not the lookup-style ERM used by the atlas witnesses.

Representing the Hadamard domain explicitly avoids the parity-search interpretation, but then the domain size is $2^n$ and any learner polynomial in the explicit domain size is exponential in the message or one-way-function length. Such a learner would not give a polynomial-time inverter or NP decision procedure.

This yields a second concrete no-go:

> Exact orthogonality via Hadamard-style encodings removes weak handles, but either the representation is implicit, making the source require efficient agnostic parity/correlation search, or the representation is explicit, making the learner's allowed polynomial time too large for the intended hardness reduction.

A useful relaxation would have to sit between these extremes: rich enough to be agnostically learnable improperly by a polynomial-time algorithm, but restrictive enough that the only weakly correlated proper hypotheses are genuine preimages or witnesses. I found no such relaxation in the atlas notes.

## Verdict

Still unresolved. None of the targeted routes currently gives a real separation, and none gives a positive theorem from efficient agnostic improper learning to marginal-nonuniform weak agnostic proper learning.

The depth-4 progress is template-level. The direct shared-PCP and universal-label-cover forms fail because of weak handles or because the input dependence reenters the marginal. Polynomial dense codes fail quantitatively because the target's weak advantage exponent is unknown. Hadamard-style orthogonality repairs the weak-gap issue but makes the improper agnostic source look like agnostic parity learning, or else makes the representation too large for a hardness contradiction.

I would keep the atlas edge unchanged:

- `status: "open"`
- `evidence: unknown`
- `assumptions: []`
- `witnesses: []`
- `family: properization-open`

## Obstacles

- Shared-PCP concepts carrying instance-proof pairs admit unrelated satisfiable-instance handles unless an active-instance gate is restored.
- Universal label-cover forms face a realization-or-handle dilemma: either constraints are carried by the hypothesis, creating unrelated handles, or constraints are not carried by the hypothesis, making satisfiable targets hard to realize as proper binary classifiers.
- Polynomial dense codes cannot beat every possible inverse-polynomial weak gap; a fixed marginal may have a weaker guaranteed advantage than the code's residual wrong-correlation scale.
- Hadamard-style encodings trade weak-gap robustness for computational hardness on the source side, since agnostic improper learning becomes parity/correlation search on an implicit exponential domain.
- Direct-product amplification is not a standalone fix: it either only changes an inverse-polynomial exponent or increases the representation/domain enough to weaken the reduction.

## Depth-5 Directions

1. Prove a formal shared-PCP handle lemma with explicit hypotheses: perfect completeness, shared random-string marginal, concepts indexed by unrestricted instance-proof pairs, and no active-instance coordinate. Then record it as a reusable obstruction if it is clean enough.
2. Search for "projection games on a universal graph" or "universal label-cover" forms where wrong-instance assignments are provably near-random under the same fixed edge distribution. The key test is whether formula data can affect labels on constant mass without being carried by proper hypotheses.
3. Quantify the dense-code obstruction in representation-size variables. A useful lemma would state: if $M(s)$ messages are embedded into $N(s)=\operatorname{poly}(s)$ binary coordinates with $M(s)\gg N(s)$, then some wrong proper concept has correlation at least $1/\operatorname{poly}(s)$, so the construction cannot refute an unknown inverse-polynomial weak target.
4. Look for relaxations of Hadamard/parity code classes with known efficient agnostic improper learners under arbitrary distributions. If all known relaxations imply agnostic parity or noisy parity search, treat this route as conditionally blocked rather than merely unimplemented.
5. Investigate whether a positive theorem can be proved for effectively finite fixed marginals: if the $P$-visible trace of $\mathcal C$ has a marginal-dependent polynomial weak cover with an efficient membership or optimization oracle, then the source improper learner can be projected weakly. This would not resolve the edge globally, but it would isolate the structural feature any counterexample must violate.

## References Checked

- [[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]]
- [[efficient-marginal-nonuniform-weak-agnostic-proper-pac|Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning]]
- [[efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac|Efficient Agnostic Improper PAC Learning -> Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning]]
- [[properization-open|Properization Open]]
- [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]
- [[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]]
- [[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]]
- [[one-way-image-coordinate-weak-handle-hardness|One-Way Image Coordinate Weak-Handle Hardness]]
- [[clause-satisfaction-proper-hardness|Clause-Satisfaction Proper Hardness]]
- Depth-1, depth-2, and depth-3 notes in this scratchpad.

---

# Depth-5 Follow-Up

- depth: 5
- edge_file: atlas/implications/efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md
- verdict: unresolved
- confidence: high on the template obstructions, medium-high on keeping the atlas edge open

## Focus

Depth 5 targeted the three remaining concrete routes from depth 4:

1. make the shared-PCP handle obstruction into an explicit lemma;
2. quantify the dense-code obstruction in representation-size variables;
3. check whether Hadamard/parity encodings have a tractable improper agnostic relaxation that avoids full agnostic parity search.

The outcome is still not a resolution of the implication. It is a sharper candidate note for why the edge remains open: the natural false-witness templates fail for structural reasons, while the natural positive route still needs an efficient proper trace selector not supplied by the improper learner.

## Attempted Resolution

### 1. Shared-PCP Handle Lemma

Here is the clean obstruction for the most direct shared-PCP replacement of the active-slice witness.

**Lemma (shared-PCP all-one handle).** Fix an input length $n$ and a common PCP random-string set $R_n$. Suppose proper concepts are indexed by unrestricted instance-proof pairs $(\psi,\pi)$ and are evaluated on the shared marginal $U(R_n)$ by

$$
h_{\psi,\pi}(r)=V(\psi,\pi,r).
$$

Assume perfect completeness: if $\psi$ is satisfiable, then some proof $\pi_\psi$ satisfies $V(\psi,\pi_\psi,r)=1$ for every $r\in R_n$. If the example domain has no active-instance coordinate or other gate that forces $\psi=\varphi$, then the class contains the all-one function on $R_n$ as soon as there exists one satisfiable instance $\psi$ of length $n$.

Consequently, the standard weak-PCP reduction cannot work on this shared marginal. On the all-one labeled distribution, even an unsatisfiable input $\varphi$ has $\operatorname{OPT}_{\mathcal C}=0$, witnessed by the unrelated satisfiable instance $\psi$. A weak proper learner may output $(\psi,\pi_\psi)$ and satisfy the guarantee while revealing nothing about $\varphi$.

**Proof.** Perfect completeness gives $h_{\psi,\pi_\psi}(r)=1$ for all $r$. Since the domain point is only $r$, not $(\varphi,r)$, this hypothesis is the same all-one function no matter which input formula the reduction is trying to decide. Thus the all-one labeling is realizable for every target input, including unsatisfiable $\varphi$. The reduction loses the satisfiable/unsatisfiable gap before learning begins.

This exactly explains why the active-slice construction uses examples $(\varphi,r)$ and defines

$$
h_{\psi,\pi}(\varphi,r)=0\quad\text{when }\psi\ne\varphi.
$$

The active-instance gate prevents unrelated satisfiable instances from becoming all-one handles. Removing the gate restores a fixed shared marginal, but also restores the handle.

There is a slightly broader version.

**Lemma (realization-or-handle dilemma for shared PCPs).** In a shared-randomness PCP concept class with fixed marginal over tests, either:

- the proper hypothesis carries enough instance data to evaluate the input-dependent predicate, in which case satisfiable wrong instances can become weak handles unless identity is separately protected; or
- the proper hypothesis does not carry the instance data, in which case a proof-only object generally cannot realize the labels for satisfiable targets without moving the input-dependent predicate into the marginal or into a diluted global predicate universe.

The first branch reduces to a formula-identity coding problem; the second branch loses realizability. I found no atlas normal form, including universal label-cover phrasing, that avoids this dilemma.

### 2. Quantified Dense-Code Obstruction

Dense shared-coordinate codes are the cleanest way to keep all hard instances on one high-mass marginal. The target shape is:

- a coordinate set $Q_s$ of length $N(s)$, with fixed marginal $P^\star_s$;
- exponentially many hard messages or certificates, say $M(s)=2^{\Omega(s)}$;
- proper concepts represented by code vectors $C_a\in\{\pm1\}^{Q_s}$;
- challenge labels $Y_z$ such that any proper concept with correlation above the weak advantage decodes a witness for $z$;
- an improper agnostic learner that can compete by lookup or another polynomial-time relaxation.

The weak target forces a severe correlation requirement. For the fixed marginal $P^\star$, the learner's advantage is only promised to be

$$
\gamma_{P^\star}(s)\ge s^{-k_{P^\star}}
$$

for some hidden exponent $k_{P^\star}$. A black-box false witness cannot safely leave a wrong proper certificate with correlation $s^{-K}$ for any fixed $K$, unless that wrong certificate also decodes the desired witness. An alleged learner whose guaranteed advantage is smaller than $s^{-K}$ could legally return that wrong certificate.

There are two useful quantitative statements.

**Exact weak-safety bound.** If the construction protects identity solely by requiring every wrong realizing certificate to have nonpositive correlation with every challenge label, then the binary code is in the Plotkin/Hadamard regime. With block length $N$, one cannot support exponentially many mutually nonpositively correlated binary vectors; the standard Plotkin-style bound gives only $O(N)$ such codewords, up to the usual boundary constants. Therefore a polynomial coordinate domain cannot host exponentially many formulas/images with exact weak safety.

**Approximate weak-safety scale.** If exact safety is relaxed to correlation at most $\eta(s)>0$, standard rate-vs-distance bounds for binary codes near relative distance $1/2$ put the needed block length on the order

$$
N(s)\gtrsim \frac{\log M(s)}{\eta(s)^2}
$$

up to constants and logarithmic refinements. Thus for $M(s)=2^{\Omega(s)}$ and $N(s)=s^c$, the achievable residual correlation scale is at best a fixed inverse polynomial, roughly

$$
\eta(s)\gtrsim s^{(1-c)/2}
$$

in this template. Increasing $c$ only chooses a smaller fixed inverse-polynomial scale. It does not beat every possible hidden weak exponent $k_{P^\star}$ while keeping $N(s)$ polynomial.

This does not prove that no dense-code separation exists. It rules out the standard route where pairwise Hamming separation alone makes all wrong certificates weak-useless. A viable code witness would need an additional agreement theorem:

> every proper concept with even tiny inverse-polynomial correlation to $Y_z$ must decode the same hard witness for $z$.

For one-way images this is stronger than ordinary one-wayness, since a nearby wrong image need not invert the challenge image. For PCP/SAT labels it is exactly the wrong-instance-handle problem in another language.

### 3. Hadamard And Parity Relaxations

Hadamard encodings solve the correlation problem perfectly. If a message $y\in\{0,1\}^n$ is represented by

$$
H_y(r)=(-1)^{\langle y,r\rangle},\qquad r\in\{0,1\}^n,
$$

then distinct messages are orthogonal under the uniform marginal. For a one-way image target $y=f(u)$, any proper seed concept with error below $1/2$ must have the same image and hence gives a preimage.

The source side is the blocker. I checked the obvious relaxations:

- **Improper output may be the image $y$.** This would be enough representation-wise, since evaluating $H_y(r)$ is easy once $y$ is known. But finding the $y$ with best agnostic correlation from random examples is exactly agnostic parity/correlation search over $2^n$ parities under arbitrary labels and distributions.
- **Uniform-marginal Fourier estimation.** Under the uniform marginal, one can estimate the correlation of a fixed parity from samples, but searching over all parities is still exponential. The source node is distribution-free agnostic, not fixed-uniform with extra Fourier-query access.
- **Goldreich-Levin/list-decoding style access.** Those algorithms use oracle/query structure or a promised correlated oracle. The PAC agnostic learner here gets random examples from an arbitrary joint distribution and must compete with the best class member; it cannot adaptively query the target codeword.
- **Explicit truth-table domain.** If the Hadamard coordinate domain is represented explicitly as size $2^n$, lookup-table ERM becomes polynomial in the explicit domain size. But then the learner's allowed runtime is exponential in the one-way or NP instance length, so the lower-bound reduction no longer contradicts polynomial-time hardness.
- **Small-bias or polynomial-length substitutes.** These return to the approximate dense-code obstruction above: residual wrong correlations are inverse-polynomial at a fixed exponent controlled by the block length.

So the Hadamard route remains conditionally blocked: exact orthogonality gives the right weak-proper hardness geometry, but every tractable source-side relaxation I see is either agnostic parity in disguise or permits a runtime too large for the intended hardness contradiction.

### 4. Positive Route Rechecked

The only positive theorem shape that survived the depth-5 check is still conditional on a proper trace selector.

For a fixed marginal $P$, suppose there is a marginal-dependent polynomial-time routine which, given samples labeled by an arbitrary joint distribution and possibly an accurate improper predictor $g$, outputs $h\in\mathcal C$ with

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+1/2-\gamma_P(s)
$$

for some inverse-polynomial $\gamma_P$. Then the target follows. But this selector is essentially the target learner. Efficient agnostic improper learning supplies the predictor $g$; it does not supply the representation-finding step.

Finite-support, VC, Occam, compression, and ERM arguments all become useful only after adding an efficient proper consistency, weak-correlation, or reconstruction oracle. Without that oracle, they prove statistical existence but not computational properization.

## Candidate Atlas Note

No status change is justified after depth 5. A crisp atlas refresh would keep:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
```

Suggested replacement summary:

> Open: strong agnostic improper learning gives accurate external prediction, but no generic efficient projection to even a weak proper concept is known; fixed-marginal weak separation templates fail because shared PCPs have wrong-instance handles, polynomial dense codes leave inverse-polynomial residual correlations, and Hadamard-style repairs make the improper source parity-like or exponentially large.

Suggested proof-status body:

> The source learner can be run under any fixed marginal to obtain a hypothesis outside $\mathcal C$ with error close to $\operatorname{OPT}_{\mathcal C}$. The missing step is computational properization: find a member of $\mathcal C$ with even inverse-polynomial weak advantage. Standard statistical tools show that good proper hypotheses exist on samples, but efficient proper ERM or weak trace selection is not implied by the improper learner.
>
> Known false-witness routes remain near misses. The PCP active-slice construction refutes distribution-free weak properization, but the hard marginal names the input instance; if one removes the active-instance gate and uses a shared random-string marginal, any unrelated satisfiable instance with perfect completeness supplies an all-one proper handle. Dense fixed-marginal code variants would need every wrong proper certificate to have correlation below the target's hidden marginal-dependent inverse-polynomial advantage. Polynomial-length binary codes cannot provide this uniformly for exponentially many hard messages by Plotkin/rate-vs-distance bounds. Hadamard or parity encodings have exact orthogonality, but then agnostic improper learning becomes agnostic parity/correlation search on an implicit exponential domain, or lookup ERM only after making the representation too large for the hardness reduction.
>
> Thus neither a positive properization theorem nor a fixed-marginal weak proper separation is currently recorded.

## Depth-5 Verdict

Still unresolved. The edge should remain open.

The strongest new reusable result is the shared-PCP all-one handle lemma: once the active-instance coordinate is removed, perfect-completeness PCP concepts indexed by unrestricted instance-proof pairs contain all-one hypotheses from unrelated satisfiable instances. This blocks the direct attempt to convert active-slice weak proper hardness into a fixed-marginal marginal-nonuniform separation.

The dense-code route is also now quantitatively blocked as a pairwise-distance template. Exact weak safety needs Plotkin/Hadamard-scale geometry and only supports polynomially many messages on a polynomial domain; approximate safety leaves a fixed inverse-polynomial residual correlation scale, while the target's weak advantage exponent is hidden and may be smaller.

The Hadamard/parity route remains the one mathematically clean possible separation geometry, but I found no tractable distribution-free agnostic improper relaxation. The source becomes agnostic parity/search unless the domain is made explicit, in which case the reduction loses polynomial-time hardness.

## Depth-6 Directions

1. Try to turn the shared-PCP handle lemma into a reusable atlas argument note for failed fixed-marginal PCP properization attempts.
2. Search specifically for agreement-theorem PCPs or direct-product tests where any weakly correlated wrong-instance proof identifies the target instance, rather than merely being a nearby unrelated satisfiable handle.
3. Investigate cryptographic assumptions stronger than one-wayness, such as pseudorandom or correlation-intractable image encodings, that might make every weakly correlated proper codeword decode the challenge while preserving an easy improper learner.
4. Look for known efficient agnostic learners for restricted parity/Hadamard relaxations under arbitrary distributions. A useful relaxation must output an external predictor without finding a seed, yet still compete with the best seed-codeword.
5. Formalize the positive conditional theorem around fixed-marginal weak proper trace selectors, with the selector's input/output separated from the agnostic improper learner. This would clarify exactly what additional structure makes the edge true for friendly representations.
6. If the atlas is updated before a resolution, add the candidate body above to the assigned edge and cross-link it with the neighboring marginal-nonuniform agnostic-improper to weak-agnostic-proper open edge, since both now have the same shared-code and trace-selector obstruction.

---

# Depth-6 Final Follow-Up

- depth: 6
- edge_file: atlas/implications/efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md
- verdict: unresolved
- confidence: high that the current atlas should keep the edge open; medium that the listed obstructions cover the natural templates

## Focus

This is the last allowed depth. I retried the remaining depth-6 directions:

1. reusable shared-PCP obstruction;
2. agreement/direct-product PCP variants;
3. stronger cryptographic image encodings;
4. restricted parity/Hadamard relaxations;
5. a positive conditional trace-selector theorem.

I did not find a proof of the implication or a valid counterexample. The best atlas incorporation is therefore an improved `open` note: the source supplies strong improper prediction, but neither statistical existence nor known hardness templates supply efficient weak properization under a fixed marginal.

## Final Verdict

Unresolved. Keep:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
```

The edge remains a genuine properization question. Distribution-free agnostic improper learning immediately gives the target's prediction quality if improper outputs were allowed. The only missing step is computational: find some $h\in\mathcal C$ with weak excess tolerance $\beta_P(s)<1/2$ under each fixed marginal $P$.

## Depth-6 Checks

### 1. Reusable Shared-PCP Obstruction

The shared-PCP handle lemma from depth 5 is clean enough to reuse as an obstruction note, but it is not a counterexample.

**Reusable obstruction.** Let the marginal be uniform over a shared PCP randomness space $R_n$, and let proper concepts be unrestricted instance-proof pairs
$$
h_{\psi,\pi}(r)=V(\psi,\pi,r).
$$
If the PCP has perfect completeness and there is any satisfiable $\psi$ of length $n$, then some $h_{\psi,\pi_\psi}$ is the all-one function on $R_n$. Without an active-instance coordinate, this all-one concept is a proper weak handle for every target instance on the shared marginal.

Thus the active-slice construction cannot be made fixed-marginal merely by dropping the active slice. Dropping it restores a fixed marginal but destroys instance identity; keeping it preserves identity but makes the hard marginal input-dependent, which marginal-nonuniformity absorbs.

This supports a reusable atlas argument note for failed fixed-marginal PCP properization attempts, but it does not settle the assigned edge because a more sophisticated PCP could in principle encode identity by another mechanism.

### 2. Agreement-Theorem And Direct-Product Variants

I checked whether agreement tests or direct-product PCP machinery could repair the shared-PCP handle problem. The modern agreement-test viewpoint gives local-to-global theorems: sufficiently consistent local pieces are close to restrictions of a global object. This is useful for PCP soundness, but it is not the missing identity test here.

For this edge, the needed statement is stronger and differently targeted:

> If a wrong-instance proof or certificate has any inverse-polynomial weak correlation with the labels for the target instance on a fixed marginal, then it identifies the target instance or yields a valid witness for it.

Standard agreement theorems do not provide this. They decode an internally consistent global object from local consistency. They do not prevent a proof for an unrelated satisfiable instance from being a valid global object with weak correlation against the target labels. Adding an explicit identity predicate reintroduces either an active-instance coordinate or a global universe of predicates whose active part is diluted.

So agreement/direct-product PCPs sharpen the desired shape but do not by themselves bypass the wrong-instance-handle dilemma.

### 3. Stronger Cryptographic Image Encodings

The depth-5 dense-code route suggested using stronger cryptography than one-wayness, such as pseudorandom, correlation-intractable, or correlation-robust image encodings.

This does not currently yield a witness for the assigned edge.

- Pseudorandom function classes are the wrong source-side shape. They are useful for sample-to-computational separations because no efficient learner can even weakly learn them under the hard marginal. Here the source must be efficiently agnostically learnable improperly.
- Correlation intractability is aimed at preventing an algorithm, given a random function from a family, from finding input-output pairs in sparse relations. The learning setup here gives labeled samples from the challenge concept and asks for competition with the best proper concept. A correlation-intractable family would not automatically give the easy improper agnostic learner needed by the source.
- Known caveats around basing correlation intractability on one-wayness reinforce that this would be a substantially stronger and more bespoke assumption, not a routine repair of the one-way image-coordinate witness.

A cryptographic counterexample would need all three properties simultaneously:

1. a fixed high-mass marginal;
2. every weakly correlated proper output decodes the challenge witness, even at the hidden inverse-polynomial weak scale;
3. an efficient distribution-free agnostic improper learner for a relaxation containing the proper concepts.

I found no atlas construction or standard cryptographic template with all three.

### 4. Restricted Parity/Hadamard Relaxations

Hadamard encodings still give the cleanest weak geometry: distinct messages are exactly orthogonal under the uniform coordinate marginal, so any proper hypothesis with error below $1/2$ identifies the message.

The obstruction remains the source. A distribution-free agnostic learner that competes with the best Hadamard codeword under arbitrary labeled examples is an agnostic parity/correlation-search learner. Known agnostic-learning references treat parity-like problems as computationally difficult or only subexponentially approachable in special settings; they do not provide the polynomial-time arbitrary-distribution improper learner required here.

Restricted variants do not obviously help:

- If the restriction keeps exact orthogonality and exponentially many messages, it tends to retain parity/correlation-search hardness.
- If the restriction makes lookup ERM easy by using a polynomial explicit coordinate set, exact orthogonality for exponentially many messages is lost, and residual wrong-code correlations are only inverse-polynomial at a fixed exponent.
- If the entire exponential truth table is made explicit, the learner is polynomial only in the explicit table size, too large for an NP or one-way-function contradiction.

Thus Hadamard/parity remains a useful mental model for what a weak fixed-marginal separation would require, but not a resolved witness.

### 5. Positive Conditional Trace-Selector Theorem

The clean positive statement is conditional and nearly tautological, but it isolates the missing structure.

**Conditional theorem shape.** Fix a marginal $P$. Suppose there is a marginal-dependent polynomial-time proper weak trace selector $S_P$ such that, for every joint distribution $\mathcal D$ with marginal $P$, given samples from $\mathcal D$ and optionally oracle/evaluation access to an improper predictor $g$ with
$$
\operatorname{err}_{\mathcal D}(g)\le \operatorname{OPT}_{\mathcal C}(\mathcal D)+\varepsilon,
$$
the selector outputs $h\in\mathcal C$ satisfying
$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+1/2-\gamma_P(s)
$$
for some inverse-polynomial $\gamma_P$. Then the assigned implication holds for classes with such selectors: run the source learner to small $\varepsilon$, then run $S_P$.

This theorem is not a resolution because $S_P$ is essentially the target-side computational content. Its value is diagnostic: finite VC dimension, sample compression, unbounded ERM, and Occam arguments provide statistical existence of good proper concepts, but the implication needs an efficient marginal-dependent method for finding one. The source improper learner gives a predictor; it does not give a representation finder.

## Crisp Obstacles For Atlas Incorporation

- **Properization is computational, not statistical.** The source guarantees an accurate external predictor, but no generic polynomial-time projection from that predictor to a representation in $\mathcal C$ is known.
- **Marginal-nonuniformity defeats input-specific hard marginals.** PCP active-slice lower bounds choose a marginal tied to the input instance. A marginal-dependent runtime polynomial may hide per-instance search costs, so this does not refute the target.
- **Weak additive tolerance hides low-mass gadgets.** Packing many hard slices into one fixed marginal multiplies each local gap by its slice mass. Since the target only requires excess error below roughly $1/2$, low-mass slices can be ignored.
- **Shared PCP domains create wrong-instance handles.** Perfect-completeness PCP concepts indexed by unrestricted instance-proof pairs contain all-one or high-acceptance concepts from unrelated satisfiable instances unless an active-instance gate is restored.
- **Dense polynomial codes leave residual weak handles.** Polynomial-length codes for exponentially many messages can only force wrong-code correlations down to a fixed inverse-polynomial scale, while the target's marginal-dependent weak advantage may be smaller.
- **Orthogonal codes shift hardness to the source.** Hadamard/parity encodings eliminate weak handles, but agnostic improper learning becomes parity/correlation search on an implicit exponential domain, or lookup over an explicit domain too large for the reduction.
- **Cryptographic PRF-style hardness has the wrong sign.** It rules out efficient weak learning altogether, whereas the assigned source requires efficient agnostic improper learning.

## Best Future Directions

1. Build a fixed-marginal identity-protected PCP where wrong-instance proofs with any inverse-polynomial correlation decode the target instance rather than acting as handles. This is the most direct false-witness route.
2. Search for a dense shared-code construction with an agreement theorem stronger than pairwise distance: every weakly correlated proper codeword must decode the same challenge witness, while a richer improper relaxation remains efficiently agnostically learnable.
3. Investigate restricted Hadamard/parity relaxations only if they avoid arbitrary-distribution agnostic parity search. The relaxation must output an external predictor without finding the seed, yet still compete with the best seed-codeword.
4. Develop positive results for representation families with efficient marginal-dependent weak trace selectors, finite effective supports, or polynomial weak covers. Such theorems would not settle the edge globally but would clarify which structural feature a counterexample must violate.
5. If updating the atlas now, refresh this edge together with [[efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac|Efficient Marginal-Nonuniform Agnostic Improper PAC Learning -> Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning]], since both share the same fixed-marginal weak properization obstruction.

## Proposed Atlas Update

No resolved atlas status update is justified. The proposed incorporation is a stronger open-edge note.

Suggested summary:

> Open: strong agnostic improper learning gives accurate external prediction, but no generic efficient projection to even a marginal-nonuniform weak proper concept is known; fixed-marginal weak separation templates fail because low-mass gadgets are hidden by the weak tolerance, shared PCPs have wrong-instance handles, dense polynomial codes leave inverse-polynomial residual correlations, and Hadamard-style repairs make the source parity-like or exponentially large.

Suggested proof-status body:

> The source learner can be run under any fixed marginal to obtain a hypothesis outside $\mathcal C$ with error close to $\operatorname{OPT}_{\mathcal C}$. The missing step is computational properization: find a member of $\mathcal C$ with even inverse-polynomial weak advantage. Standard VC, compression, and ERM arguments show statistical existence only when computational search is ignored; they do not provide an efficient proper trace selector.
>
> Known false-witness routes remain near misses. The PCP active-slice construction refutes distribution-free weak properization, but its hard marginal names the input instance; marginal-nonuniform runtime bounds may depend on that marginal. Packing all slices into one fixed marginal loses the local gap under the target's additive $1/2-\gamma$ tolerance. Removing the active-instance coordinate and using a shared PCP randomness marginal creates wrong-instance handles: a satisfiable unrelated instance with perfect completeness can supply an all-one proper hypothesis. One-way image-coordinate witnesses give strong fixed-marginal proper hardness, but weak learners can use low-mass or wrong-length handles. Dense shared-code variants would need every wrong proper certificate below the target's hidden inverse-polynomial weak advantage; polynomial-length codes leave residual inverse-polynomial correlations, while Hadamard/parity encodings make agnostic improper learning a parity/correlation-search problem or require an explicit exponential domain.
>
> Thus neither a positive properization theorem nor a fixed-marginal weak proper separation is currently recorded.

Suggested refs if the atlas edge is refreshed without adding new bibliography entries:

```yaml
ref_keys:
  - schapire1990
  - pitt1988
  - khot2008dnf
  - hastad2005query
  - kearns1994cryptographic
  - hastad1999prg
  - kearns1994
```

## References Checked

- [[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]]
- [[efficient-marginal-nonuniform-weak-agnostic-proper-pac|Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning]]
- [[efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac|Efficient Agnostic Improper PAC Learning -> Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning]]
- [[efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac|Efficient Marginal-Nonuniform Agnostic Improper PAC Learning -> Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning]]
- [[efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-proper-pac|Efficient Agnostic Improper PAC Learning -> Efficient Marginal-Nonuniform Agnostic Proper PAC Learning]]
- [[efficient-agnostic-improper-pac--implies--efficient-weak-agnostic-proper-pac|Efficient Agnostic Improper PAC Learning -> Efficient Weak Agnostic Proper PAC Learning]]
- [[properization-open|Properization Open]]
- [[agnostic-boosting-open|Agnostic Boosting Open]]
- [[marginal-boosting-open|Marginal-Nonuniform Boosting Open]]
- [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]
- [[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]]
- [[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]]
- [[one-way-image-coordinate-class|One-Way Image Coordinate Class]]
- [[one-way-image-coordinate-weak-handle-hardness|One-Way Image Coordinate Weak-Handle Hardness]]
- [[one-way-image-coordinate-weak-handle-class|One-Way Image Coordinate Weak-Handle Class]]
- [[clause-satisfaction-proper-hardness|Clause-Satisfaction Proper Hardness]]
- [[clause-satisfaction-lookup-class|Clause-Satisfaction Lookup Class]]
- [[fixed-k-term-dnf-proper-boosting-separation|Fixed-k-Term DNF Proper Boosting Separation]]
- [[fixed-k-term-DNF|Fixed-k-Term DNF]]
- [[pseudorandom-function-classes|Pseudorandom Function Classes]]
- [[sample-to-computational-hardness|Sample-to-Computational Hardness]]
- Schapire 1990; Pitt and Valiant 1988; Khot and Saket 2008; Håstad and Khot 2005; Kearns and Valiant 1994; Håstad et al. 1999; Kearns, Schapire, and Sellie 1994, as cited in the atlas.
- Dinur, Filmus, and Harsha, "Agreement Tests on Graphs and Hypergraphs", SIAM Journal on Computing 2025, for the agreement-test/direct-product perspective.
- Canetti, Goldreich, and Halevi, "The Random Oracle Methodology, Revisited", ePrint 1998/011, and Hada and Tanaka, "A Relationship between One-Wayness and Correlation Intractability", ePrint 1999/010, for the correlation-intractability route.
- Kalai, Klivans, Mansour, and Servedio, "Agnostically Learning Halfspaces", and related agnostic parity discussion, as a check that Hadamard/parity-style source learning is not a known generic polynomial-time primitive.
