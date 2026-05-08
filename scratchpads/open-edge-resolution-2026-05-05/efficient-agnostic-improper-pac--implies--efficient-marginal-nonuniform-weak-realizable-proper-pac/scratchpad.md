# Edge: efficient-agnostic-improper-pac -> efficient-marginal-nonuniform-weak-realizable-proper-pac

- depth: 1
- edge_file: atlas/implications/efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md
- verdict: unresolved
- confidence: medium

## Context

The source is [[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]]: a distribution-free polynomial-time agnostic learner may output hypotheses outside the class. In the realizable case, it can be run with small $\varepsilon$ to get an accurate improper predictor under any marginal.

The target is [[efficient-marginal-nonuniform-weak-realizable-proper-pac|Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]]: one uniform algorithm must, for each fixed marginal $P$, have a $P$-dependent polynomial runtime/sample bound and a $P$-dependent inverse-polynomial advantage, but the output must be a member of $\mathcal C$.

The edge note currently records this as a `properization-open` edge. Neighboring notes are important:

- [[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]] resolves strong proper targets under one-way functions: the class is agnostically learnable by improper sparse ERM, but strong marginal-nonuniform proper learning under a fixed coordinate marginal would invert the one-way function.
- [[efficient-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac|Efficient Realizable Improper PAC Learning -> Efficient Marginal-Nonuniform Realizable Proper PAC Learning]] is already false by this witness.
- [[efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac|Efficient Marginal-Nonuniform Realizable Improper PAC Learning -> Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]] and [[efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac|Efficient Marginal-Nonuniform Weak Realizable Improper PAC Learning -> Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]] remain open for essentially the same weak properization obstacle.

## Attempted Resolution

### Possible true route

The source gives excellent improper prediction on realizable distributions. If $A$ is the agnostic improper learner and the data are labeled by $c\in\mathcal C$, then running $A$ with constant or inverse-polynomial accuracy gives a hypothesis $g$ with small $P$-error to $c$.

This does not by itself give the target, because the target requires outputting a representation in $\mathcal C$. The missing step is an efficient projection/search procedure:

$$
g \approx_P c \in \mathcal C
\quad\Longrightarrow\quad
\text{find } h\in\mathcal C \text{ with } \operatorname{err}_P(h,c) \le 1/2-\gamma_P(s).
$$

Information-theoretically, such an $h$ exists, namely $c$ itself. Sample-complexity results also erase the obstacle when runtime is ignored. Computationally, however, the source learner's output can be a lookup table, sparse ERM solution, vote, or other external handle, and I did not find a generic way to convert that handle into even a weak proper concept.

Enumeration is not enough in the atlas model: although the polynomial bound may depend on the marginal, it cannot depend on the target concept, and there may be exponentially many proper representations of size $s$ to search. Standard boosting is also a near miss, since it improves predictors but normally outputs an aggregate outside $\mathcal C$ rather than a single proper concept.

### Possible false route

The strongest available false-route candidate is the one-way image-coordinate class. It is actually well matched to the source: the atlas argument says it is efficiently agnostically learnable by improper sparse ERM, because the improper sparse lookup class has VC dimension $n$ and admits a simple polynomial-time ERM over sampled atoms.

The same witness does not appear to refute the weak target. Under the fixed all-length marginal used for strong proper hardness, a length-$n$ block has mass $\mu_n=6/(\pi^2n^2)$. For a length-$n$ target, any arbitrary same-length proper seed concept has total error at most about $\mu_n$ on that block, hence far below $1/2$ for large $n$, without inverting the one-way image. Wrong-length or low-support behavior creates similar weak handles. Thus the strong accuracy threshold $\mu_n/(3n)$ forces inversion, but the weak threshold $1/2-\gamma_P(n)$ does not.

PCP active-slice and proper-DNF hardness routes also look insufficient at this depth. They can make proper weak learning hard when the marginal/distribution encodes the hard instance, but marginal-nonuniformity lets the polynomial runtime depend on that marginal. Packing all hard instances into one fixed marginal dilutes each slice's contribution, and the target's hidden advantage $\gamma_P(s)$ may be smaller or larger than any particular slice mass in a way the reduction cannot control.

Dense image-code variants are tempting: make every length-$n$ proper hypothesis balanced under a shared marginal so that weak correlation would force nontrivial information about the hidden one-way image. I did not find a construction that simultaneously has:

- one fixed marginal serving all representation sizes without tail dilution;
- labels simulatable from a one-way challenge $y=f(s)$;
- efficient distribution-free agnostic improper learning;
- no trivial proper handles, such as constants, wrong lengths, shared coordinates, or nearby codewords.

## Proposed Atlas Update

No status change proposed. Keep the edge `open` with `evidence: unknown`.

A slightly sharper summary/body could mention that the source's agnostic strength matches the sparse-ERM part of the one-way image-coordinate witness, but the target's weak global threshold is exactly where that witness stops working.

Possible replacement summary:

> Open: agnostic improper learning gives accurate external prediction, but no efficient projection to even a weak proper concept is known; strong fixed-marginal proper hardness witnesses lose force at the weak threshold.

## Obstacles

1. The central theorem obstacle is representation-sensitive proper search, not statistical existence. The target concept is a zero-error proper hypothesis, but the improper learner need not reveal any efficiently decodable proper representation.

2. Strong proper lower bounds do not automatically imply weak proper lower bounds. In the one-way image-coordinate witness, the fixed marginal puts only inverse-polynomial mass on each length block, so weak global error can be achieved without recovering the one-way preimage.

3. Input-dependent hard distributions do not refute marginal-nonuniform targets, because the target permits the resource polynomial and weak advantage to depend on the fixed marginal.

4. Packing many hard slices into one marginal dilutes the weak gap. A depth-1 attempt did not identify a fixed-marginal construction that avoids both dilution and accidental weak proper handles while preserving efficient agnostic improper learnability.

## Next Directions

1. Try to prove a distribution-specific weak properization theorem from an agnostic improper learner plus finite VC dimension, perhaps under additional representation assumptions such as evaluable/enumerable concepts, then check whether those assumptions are already implicit in the atlas.

2. Search for a fixed-marginal cryptographic class with balanced labels at every size, where any weakly correlated proper hypothesis yields a preimage or predictor for a one-way image, while an improper learner can still agnostically compete by a tractable external representation.

3. Revisit dense code constructions based on error-correcting codes, Hadamard codes, or Goldreich-Levin-style predicates. The key test is whether improper agnostic learning remains easy or becomes a noisy-parity-like problem.

4. Examine whether known proper weak learning hardness results, including PCP/query-learning variants, have a marginal-fixed formulation where the weak advantage remains inverse-polynomial after all hard instances are embedded into one marginal.

## References Checked

- [[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]]
- [[efficient-marginal-nonuniform-weak-realizable-proper-pac|Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]]
- [[properization-open|Properization Open]]
- [[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]]
- [[one-way-image-coordinate-weak-handle-hardness|One-Way Image Coordinate Weak-Handle Hardness]]
- [[one-way-image-coordinate-class|One-Way Image Coordinate Class]]
- [[one-way-image-coordinate-weak-handle-class|One-Way Image Coordinate Weak-Handle Class]]
- [[efficient-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac|Efficient Realizable Improper PAC Learning -> Efficient Marginal-Nonuniform Realizable Proper PAC Learning]]
- [[efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac|Efficient Marginal-Nonuniform Realizable Improper PAC Learning -> Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]]
- [[efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac|Efficient Marginal-Nonuniform Weak Realizable Improper PAC Learning -> Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]]
- [[efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac|Efficient Marginal-Nonuniform Agnostic Improper PAC Learning -> Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning]]

---

## Depth 2 Follow-Up

- depth: 2
- edge_file: atlas/implications/efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md
- verdict: unresolved
- confidence: medium-high

### Context Rechecked

The source node is stronger than several known improper sources: it gives one distribution-free polynomial-time agnostic improper learner with arbitrary excess error. The target is much weaker statistically, but it still requires a proper output. Its two marginal-nonuniform weak relaxations matter:

- the resource polynomial may depend on the fixed marginal $P$;
- the weak advantage $\gamma_P(s)$ may also depend on $P$, with only marginal-dependent inverse-polynomial control.

This second relaxation is why the newer [[full-support-marginal-uniformization|Full-Support Marginal Uniformization]] argument does not immediately collapse this target to [[efficient-weak-realizable-proper-pac|Efficient Weak Realizable Proper PAC Learning]]. Full support can uniformize worst-case transcript runtime for a single marginal-nonuniform learner, but it does not turn the family of advantages $\gamma_P$ into one distribution-free inverse-polynomial advantage. The atlas edge [[efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-weak-realizable-proper-pac|Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning -> Efficient Weak Realizable Proper PAC Learning]] is therefore still a relevant open uniformization obstacle.

### Attempted Resolution

#### 1. PCP active slices with one fixed marginal

The distribution-free PCP witness is very strong for nearby edges. The atlas now records [[efficient-agnostic-improper-pac--implies--efficient-weak-realizable-proper-pac|Efficient Agnostic Improper PAC Learning -> Efficient Weak Realizable Proper PAC Learning]] as false via [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]. The same witness also refutes the weak agnostic proper target. It does not directly refute this marginal-nonuniform target.

The original reduction uses the marginal $P_\varphi$ that is uniform on the active verifier-randomness slice of the input formula $\varphi$. That makes weak proper learning yield a PCP proof accepted on more than half the random strings. For a marginal-nonuniform target, however, the polynomial bound may depend on this exact $P_\varphi$. Since $P_\varphi$ varies with the input formula, the hidden polynomial can vary with the NP instance itself. A reduction deciding SAT would not get one runtime polynomial in $|\varphi|$.

I then tried the fixed-marginal packing variant. Let

$$
P=\sum_\psi w_\psi U_\psi,
$$

where $U_\psi$ is uniform on the active slice for $\psi$. For a satisfiable target formula $\varphi$, the realizing concept $c_{\varphi,\pi}$ labels only the $\varphi$ slice positively and is zero off that slice. If a proper hypothesis chooses a different slice $\psi\ne\varphi$, then its error against $c_{\varphi,\pi}$ is at most the missed positive mass $w_\varphi$ plus whatever false-positive mass it creates on its own slice, at most $w_\psi$. Taking a very low-mass $\psi$ gives a proper hypothesis with error essentially $w_\varphi$ without solving the PCP instance.

Thus inverse-polynomial slice mass is not enough. If $w_\varphi=1/\operatorname{poly}(|\varphi|)$, then an unrelated proper concept already has error far below $1/2$. To force a weak proper learner to recover a good proof, the active slice mass would have to be close to $1/2$ for each hard formula, up to the unknown target advantage $\gamma_P(s)$. One fixed probability distribution cannot assign near-half mass to all NP instances of a given size. Packing only polynomially many slices at a size would no longer cover a standard NP-hard language.

I also considered adding a high-mass "guard" or background region to defeat wrong-slice concepts. If the guard labels are common to all proper concepts, wrong-slice concepts match the guard too and the argument is unchanged. If the guard labels are target-dependent and balanced, the construction becomes a dense code problem rather than the sparse active-slice lookup class, and the existing polynomial-time agnostic improper ERM no longer applies.

#### 2. One-way image-coordinate variants without easy weak predictors

The existing [[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]] is a near-perfect source witness: it is distribution-free agnostically learnable by improper sparse ERM. Its lower bound is strong, not weak. Under the all-length fixed marginal with length block masses $\mu_n$, the target block has total mass $\mu_n$ and positive mass $\mu_n/2$. A wrong-length seed, or any sufficiently low-support proper handle, can beat random guessing globally without giving a preimage of the one-way image.

Putting all marginal mass on one length-$n$ block removes the global dilution and makes constants unhelpful on that block, but it changes the marginal with $n$. The target's marginal-dependent polynomial could then depend on the chosen length-specific marginal, so this does not yield a uniform inverter for a one-way function family across all $n$.

The natural dense-code replacement is: encode $f(s)$ as a balanced codeword $E(f(s))$, let examples query coordinates of the codeword, and require proper hypotheses to output seeds. If every wrong seed has negligible correlation with the target codeword, then any inverse-polynomial weak proper learner would have to output a seed $t$ with $f(t)=f(s)$. The catch is preserving the source. With sparse coordinate exposure, agnostic improper learning is easy by sparse ERM but weak proper predictors are too easy. With Hadamard-style balanced exposure, wrong codewords can be exactly orthogonal, but agnostic improper learning becomes agnostic learning of parities/Hadamard codewords under arbitrary distributions, which is not supplied by the existing witness and is a standard hard-looking problem. Polynomial-length error-correcting codes give only inverse-polynomial correlation control, while the target's unknown $\gamma_P(s)$ may be smaller than that residual correlation.

One-wayness alone also seems too weak for this route. It rules out finding a preimage, not necessarily finding a seed whose image has slight positive correlation with the challenge image under the chosen code. A usable lower bound would need a stronger pseudorandom or hardcore-code property while still leaving an efficient distribution-free agnostic improper learner.

#### 3. Monotonicity transfer from known weak proper false edges

I checked the known false edges into and around weak proper targets.

The false edge [[efficient-agnostic-improper-pac--implies--efficient-weak-realizable-proper-pac|Efficient Agnostic Improper PAC Learning -> Efficient Weak Realizable Proper PAC Learning]] does not transfer by monotonicity, because the assigned target is weaker: it relaxes distribution-free resources to marginal-dependent resources and allows the weak advantage to depend on the marginal. Failure of the stronger distribution-free weak proper node does not imply failure of the marginal-nonuniform weak proper node.

The false edge [[efficient-agnostic-improper-pac--implies--efficient-weak-agnostic-proper-pac|Efficient Agnostic Improper PAC Learning -> Efficient Weak Agnostic Proper PAC Learning]] also does not transfer, for the same reason plus the agnostic-to-realizable relaxation.

False sample-to-computational edges with target [[efficient-marginal-nonuniform-weak-realizable-proper-pac|Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]] use [[pseudorandom-function-classes|Pseudorandom Function Classes]]. Those witnesses satisfy sample-efficient sources but fail efficient weak learning under cryptographic assumptions, so they do not satisfy the assigned computational source [[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]].

The monotonicity test therefore leaves the edge unresolved. Any clean transfer would need either:

- a proof that the marginal-nonuniform weak proper target implies the distribution-free weak proper target, including a uniform weak advantage, or
- a known false edge whose witness satisfies the assigned efficient agnostic improper source and fails the assigned marginal-nonuniform weak proper target directly.

I found neither in the current atlas notes.

### Proposed Atlas Update

No status change proposed. Keep:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
```

Suggested sharper summary:

> Open: PCP active-slice witnesses refute distribution-free weak properization, and one-way image-coordinate witnesses refute strong fixed-marginal properization, but neither currently rules out marginal-dependent weak proper learning.

Suggested body addition:

> The closest monotonicity route is blocked by the target's marginal-dependent weak advantage. A full-support marginal can uniformize worst-case runtime for strong marginal learners, but it does not supply one distribution-free inverse-polynomial weak advantage when the source guarantee itself is weak and marginal-dependent. Thus the PCP false edge to distribution-free weak proper learning does not automatically refute this marginal-nonuniform weak target.

### Obstacles

1. Fixed-marginal PCP packing has a quantitative weak-threshold problem. A slice with only inverse-polynomial mass is easy to ignore while still achieving global error well below $1/2$.

2. Input-dependent PCP marginals are absorbed by marginal nonuniformity: the learner's polynomial may depend on the very slice used by the reduction.

3. Sparse one-way image-coordinate classes preserve efficient agnostic improper ERM but leak weak proper predictors through low-mass blocks or wrong-length concepts.

4. Dense balanced image codes could eliminate weak handles, but the obvious constructions turn the source into agnostic parity/codeword learning rather than sparse ERM.

5. Existing false edges point in the wrong monotone direction or use witnesses that do not satisfy the assigned efficient agnostic improper source.

### Next Depth-3 Directions

1. Formalize a "PCP packing barrier" lemma for the active-slice witness: under a fixed mixture marginal, if the target slice mass is below $1/2-\gamma$, a wrong-slice proper concept is already a weak predictor. This would prevent future workers from re-chasing the same packing idea unless they add a genuinely target-dependent balanced guard.

2. Search for an efficiently agnostically learnable dense image-code class. The needed object is not just an error-correcting code, but a binary concept class whose improper agnostic ERM is polynomial-time while proper weak correlation implies preimage recovery.

3. Revisit the open edge [[efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-weak-realizable-proper-pac|Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning -> Efficient Weak Realizable Proper PAC Learning]]. A true uniform weak-advantage theorem there would let the existing PCP false edge resolve the assigned edge as false by composition; a counterexample there might clarify why this assigned edge remains open.

4. Check whether a stronger weak convention, with a fixed distribution-free advantage rather than $\gamma_P$, is intended anywhere in the atlas. Under such a convention the PCP transfer would become much more plausible, but it would be a schema change rather than a resolution of the current node.

### References Checked

- [[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]]
- [[efficient-marginal-nonuniform-weak-realizable-proper-pac|Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]]
- [[efficient-weak-realizable-proper-pac|Efficient Weak Realizable Proper PAC Learning]]
- [[properization-open|Properization Open]]
- [[full-support-marginal-uniformization|Full-Support Marginal Uniformization]]
- [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]
- [[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]]
- [[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]]
- [[one-way-image-coordinate-class|One-Way Image Coordinate Class]]
- [[one-way-image-coordinate-weak-handle-hardness|One-Way Image Coordinate Weak-Handle Hardness]]
- [[one-way-image-coordinate-weak-handle-class|One-Way Image Coordinate Weak-Handle Class]]
- [[pseudorandom-function-classes|Pseudorandom Function Classes]]
- [[efficient-agnostic-improper-pac--implies--efficient-weak-realizable-proper-pac|Efficient Agnostic Improper PAC Learning -> Efficient Weak Realizable Proper PAC Learning]]
- [[efficient-agnostic-improper-pac--implies--efficient-weak-agnostic-proper-pac|Efficient Agnostic Improper PAC Learning -> Efficient Weak Agnostic Proper PAC Learning]]
- [[sample-efficient-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac|Sample-Efficient Weak Agnostic Improper PAC Learning -> Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]]

---

## Depth 3 Follow-Up

- depth: 3
- edge_file: atlas/implications/efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md
- verdict: unresolved
- confidence: medium-high

### Focus

This pass tested the optimistic possibility that the target's marginal-dependent runtime and marginal-dependent weak advantage might turn the edge into a theorem. The three candidate routes were:

1. finite-support or effective-support compression for each fixed marginal $P$;
2. ERM over the finite trace family induced by samples from $P$;
3. sample-dependent generation of a small list of proper candidates, using the agnostic improper learner only as a guide.

The conclusion is still negative-for-now: these ideas give useful conditional theorems, but each conditional theorem assumes an efficient **proper trace selector**. That selector is not supplied by efficient agnostic improper learning, and it is precisely the representation-sensitive properization problem.

### Conditional Positive Result

There is a clean theorem under an extra algorithmic assumption.

Fix a marginal $P$. Suppose that for every representation size $s$ there are marginal-dependent polynomials $m_P(s)$ and $q_P(s)$ with the following property: from $m_P(s)$ labeled examples realizable by some $c\in\mathcal C_s$, one can in time $q_P(s)$ output a proper hypothesis $h\in\mathcal C$ whose empirical trace is good enough that standard fixed-$P$ generalization gives

$$
\operatorname{err}_P(h,c)\le \frac12-\gamma_P(s)
$$

for some inverse-polynomial $\gamma_P$. Then the assigned target follows. In fact, the agnostic improper learner is not doing essential work in this argument; realizability plus the proper trace selector already gives the weak proper learner.

Finite-support compression is one special case. If, for each $s$, a polynomial number of sampled atoms covers all but $<1/4$ of the $P$-mass relevant to $\mathcal C_s$, and if there is a polynomial-time routine that realizes or weakly fits the observed trace by a member of $\mathcal C$, then outputting that realized trace gives error $<1/4$ plus the sampling slack. This easily beats $1/2$ by a marginal-dependent constant.

This is a useful sanity check: marginal nonuniformity really does remove the statistical obstruction on friendly marginals. It lets the algorithm spend a $P$-dependent polynomial amount of time discovering the effective support or obtaining enough repetitions of heavy atoms. What it does not provide is a way to convert a labeled trace into a representation in $\mathcal C$.

### Why Finite-Support Compression Does Not Prove the Edge

The missing uniform ingredient is not just support discovery. Even on a finite support $T$, the proper learner must output a representation of a concept in $\mathcal C$, not merely the table $c|_T$.

For a fixed marginal $P$, the target polynomial may depend on $P$, but it may not depend on the unknown target concept $c$. Therefore a generic enumeration argument is insufficient. If the first proper representation consistent with the observed trace appears after a concept-dependent or exponential number of candidates, the runtime is not bounded by a single $p_P(s)$ for all targets of size $s$.

The obstruction can be phrased as a fixed-marginal trace-selection problem:

> Given a labeled finite trace known to be induced by some $c\in\mathcal C_s$, find any $h\in\mathcal C$ whose trace has nontrivial positive correlation with it under the trace weights.

Efficient agnostic improper PAC learning gives an external predictor for the labels. It does not give an oracle for this trace-selection problem. If the trace selector exists, the target is easy; if it does not, finite-support compression stops at an improper lookup table.

### Why ERM Over Traces Does Not Prove the Edge

ERM over the observed trace has exactly the same gap. Statistically, realizability guarantees that empirical proper ERM has zero training error. Computationally, empirical proper ERM may be the hard part of the class representation.

The source learner can avoid this hardness by optimizing over a richer improper class. In lookup-style witnesses, for example, the improper ERM stores the sampled labels directly. That hypothesis is excellent for agnostic prediction and can be distribution-free efficient, but it contains no short proper certificate unless one can solve the underlying proper search problem.

Marginal-dependent runtime does not eliminate this issue unless the marginal itself makes the search space effectively small in a target-independent way. A fixed marginal can make a particular hard instance harmless by allowing constants hidden in $p_P$, which is why input-dependent separation reductions fail. But a theorem must handle arbitrary fixed marginals and all targets under that marginal using one algorithm. Without an explicit $P$-dependent but target-uniform proper ERM procedure, the ERM route assumes what it needs to prove.

### Why Sample-Dependent Candidate Lists Do Not Prove the Edge

One might try to run the agnostic improper learner on many subsamples, perturbations, or relabelings, then extract a small list of candidate proper hypotheses from the outputs. I do not see a generic extraction step.

The agnostic learner's outputs may be tables, votes, linear relaxations, or other external handles. Their agreement with the true concept under $P$ certifies the existence of a nearby proper concept, namely the target $c$, but not an efficiently decodable representation of such a concept. A sample-dependent list is useful only if every realizable trace has a short target-independent list of proper representatives covering it at weak accuracy. That is again a trace-selector/list-realizer assumption.

There is also a quantitative weak-advantage issue. Because $\gamma_P(s)$ is hidden and may be very small, a candidate-list proof must guarantee some inverse-polynomial advantage for every fixed $P$ without knowing the relevant scale. A finite list of accidental weak handles can help on sparse marginals, but dense balanced trace families can make all obvious candidates nearly uncorrelated.

### Concrete Obstruction Identified

The concrete obstruction is **target-uniform proper trace selection under a fixed marginal**.

A successful theorem needs the following implication:

$$
\text{efficient external prediction near } c
\quad\Longrightarrow\quad
\text{efficiently find } h\in\mathcal C \text{ weakly correlated with } c.
$$

The left side is what the source provides in the realizable case. The right side is a representation-finding statement about $\mathcal C$ restricted to $P$. Marginal nonuniformity allows the runtime and advantage to depend on $P$, but it does not allow advice depending on $c$, and it does not turn an improper table into a proper representation.

This obstruction explains both sides of the previous notes:

- Sparse PCP or image-coordinate separations fail because wrong-slice or wrong-length proper concepts can be weakly good once the hard slice has small global mass.
- The theorem attempts fail because removing those easy weak handles requires a dense or balanced trace family, and then the remaining task is exactly to select a correlated proper representation from many possible traces.

Thus the present evidence still supports `open`, not `true` or `false`.

### Proposed Atlas Update

No status change proposed. Keep:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
```

A sharper body sentence for the edge would be:

> Marginal-dependent runtime makes finite-support properization plausible when the marginal admits a polynomial-time proper trace selector, but efficient agnostic improper learning supplies only an external predictor and no generic way to select a weakly correlated member of the original class.

### Next Depth-4 Directions

1. Try to isolate the trace-selector condition as a reusable lemma: if every fixed marginal $P$ admits polynomial-time weak proper trace selection for $\mathcal C$, then efficient agnostic improper learning implies the assigned target. This would separate the easy statistical part from the real computational assumption.

2. Search for a class with efficient agnostic improper learning but fixed-marginal hard trace selection. The ideal witness would have a dense balanced marginal where every weakly correlated proper trace encodes a hard witness, while an improper learner can still agnostically compete by a tractable relaxation or lookup representation.

3. Revisit finite-support marginals with superpolynomial trace complexity. The question is whether one can build a fixed $P$ for which every target-independent polynomial-time selector sees too small a part of the support to find a weak proper representative, without destroying distribution-free agnostic improper learnability.

4. Compare this obstruction with known proper-ERM hardness examples. If an existing class has easy improper agnostic ERM and hard proper weak trace selection under one fixed marginal, it would be a better false witness than PCP slice packing.

5. Check whether the atlas should add a short note to [[properization-open|Properization Open]] naming "proper trace selection" as the remaining algorithmic bottleneck for the marginal-nonuniform weak cases.

### References Rechecked

- [[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]]
- [[efficient-marginal-nonuniform-weak-realizable-proper-pac|Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]]
- [[properization-open|Properization Open]]
- [[full-support-marginal-uniformization|Full-Support Marginal Uniformization]]
- [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]
- [[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]]
- [[efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac|Efficient Agnostic Improper PAC Learning -> Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]]

---

## Depth 4 Follow-Up

- depth: 4
- edge_file: atlas/implications/efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md
- verdict: unresolved
- confidence: high on the barrier, medium-high on the edge status

### Narrow Question

This pass focused only on the efficient proper trace selector barrier:

> Given a fixed marginal $P$, a polynomial-size labeled trace from some unknown $c\in\mathcal C_s$, and possibly an improper/table predictor $g$ that is accurate on that trace, is there a representation-independent polynomial-time way to output a proper $h\in\mathcal C$ with positive inverse-polynomial correlation with $c$ under $P$?

I did not find such a representation-independent method. The known representation-independent tools give statistical existence or compression, but their computational versions require exactly the missing proper reconstruction/search procedure.

### Finite Support

Finite support removes much of the sampling issue, not the representation issue. If a fixed marginal $P$ has support $T$ and enough samples identify a high-mass subset of $T$, then the labels of the target on that subset can be learned as a table. An improper learner can output this table directly.

For a proper learner, the remaining task is:

$$
\text{input: a weighted labeled trace on }T
\quad\mapsto\quad
\text{some representation }h\in\mathcal C
\text{ with weak positive correlation.}
$$

There are two easy but non-generic escapes.

First, if $T$ is finite and there is a known polynomial-time proper consistency or weak-correlation search routine for $\mathcal C|_T$, then the edge is true for this $P$. But this is just the trace selector assumption.

Second, if one ignores computation, exhaustive proper ERM over all representations works whenever a consistent proper concept exists. That is why the sample-efficient layer has no analogous obstruction. Computationally, however, enumerating all size-$s$ proper representations can take exponential time in $s$, and the marginal-dependent polynomial $p_P(s)$ may not depend on the target concept. A fixed finite support by itself does not make representation search polynomial in $s$.

There is a subtle uniformity point: the atlas target allows the resource bound to depend on $P$, but it does not give the learner $P$-dependent advice. One uniform algorithm still has to find the proper representation from samples. Thus even a finite support does not license hardwiring a lookup table from every possible trace to a proper concept unless that lookup is effectively produced by the algorithm.

### VC And Sample Compression

VC theory and sample compression are helpful sanity checks, but they do not currently solve the efficient selector problem.

From the source, the class has polynomial sample complexity in the representation size, so the relevant finite-dimensional statistical story is benign. Standard VC/ERM arguments say that a proper concept with low true error exists and that an empirical proper minimizer generalizes. They do not say how to find such a minimizer in the given representation.

Sample compression is similar. The classical Littlestone-Warmuth/Floyd-Warmuth direction says compression gives learnability, and Moran-Yehudayoff show that every finite-VC class has a compression scheme of size exponential in the VC dimension. This is representation-independent existence, not a uniform efficient reconstruction algorithm for the atlas representation. Even if the reconstruction outputs a concept from $\mathcal C$ rather than an external hypothesis, the theorem supplies no polynomial-time method for computing the compression map or decoding a short proper representation from an arbitrary table predictor.

The size bound is also not automatically compatible with the efficient weak target. If $\operatorname{VC}(\mathcal C_s)$ is only known to be polynomial in $s$, an exponential-in-VC compression size can be superpolynomial in $s$. That may still prove statistical learnability, but not the requested polynomial sample/time bound.

So the compression route yields a conditional statement:

> If $\mathcal C$ has a polynomial-size compression scheme whose compression and reconstruction maps are computable in polynomial time and whose reconstruction is proper, then fixed-marginal weak proper learning follows.

That condition is stronger than efficient agnostic improper PAC learning and is not known to be representation-independent.

### Occam, ERM, And Oracles

Occam-style arguments also stop at the same line. A short consistent proper hypothesis would generalize from a sufficiently large sample. But the Occam theorem assumes an Occam algorithm: a procedure that actually finds a short consistent hypothesis. For this edge, the hard part is precisely finding the short proper hypothesis rather than storing the labels externally.

The oracle variants clarify the issue:

- A membership/evaluation oracle for concepts, given a representation $r$ and point $x$, only verifies candidates. It does not search the exponentially large representation space.
- A proper consistency oracle, given a labeled sample, returns a representation in $\mathcal C$ if one exists. This immediately gives a proper trace selector, hence gives the target under standard fixed-$P$ generalization.
- A proper empirical-risk or weak-correlation optimization oracle is even closer to the desired conclusion; it directly selects the target output.
- A realizability-decision oracle can sometimes be self-reduced to a search oracle if the representation language has a clean prefix structure and the oracle answers extension queries. That is an additional representation-specific assumption, not a representation-independent theorem.

Thus membership/search-oracle assumptions give useful conditional positive results, but they do not derive from the improper learner. They name the missing capability.

### Can Absence Of A Selector Be A Separation?

The absence of a selector can be turned into a separation only if it is upgraded to a uniform hardness statement for weak proper trace selection under one fixed marginal.

A bare statement such as "no efficient exact proper ERM is known" is not enough. The weak target may output any proper concept with error below $1/2-\gamma_P(s)$, not necessarily an exact or optimal proper fit. Sparse witnesses show the danger: even when exact proper recovery is hard, wrong-length, wrong-slice, constant, or low-support proper concepts can be weakly good globally.

A valid false witness would need a fixed marginal $P^\star$ and a hard family of realizable traces such that:

1. labels for a challenge trace can be simulated without knowing the hidden proper representation;
2. distribution-free agnostic improper learning remains polynomial-time, usually by a tractable table, sparse, or relaxation class that contains the proper traces;
3. every proper hypothesis with inverse-polynomial positive correlation under $P^\star$ reveals a hard witness, not merely every exact or high-accuracy hypothesis;
4. the marginal does not dilute the hard part below the unknown weak advantage $\gamma_{P^\star}(s)$;
5. there are no target-independent weak handles shared across the hard family.

This is stronger than standard proper-ERM hardness. It is closer to a fixed-marginal cryptographic search problem where "any weakly correlated proper representation" solves the challenge.

The existing one-way image-coordinate construction has items 1 and 2 and gives strong proper hardness, but fails item 3 for the weak target because low-mass length blocks leave easy global weak handles. The PCP active-slice construction gives item 3 on an input-dependent marginal, but fails item 4 when hard slices are packed into one fixed marginal. Dense code variants are the right shape for item 3, but the obvious versions threaten item 2 by making improper agnostic learning as hard as learning the dense code family.

### Depth-4 Verdict

No status change is justified. The edge should remain:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
```

The sharper conclusion is:

> There is no known representation-independent efficient method that converts an accurate improper/table predictor on a fixed marginal into even a weakly correlated proper concept. Finite support, VC/sample compression, Occam bounds, and ERM all become positive only after adding an efficient proper trace selector, proper reconstruction, or proper optimization oracle. Conversely, turning the selector's absence into a separation requires a fixed-marginal weak selector hardness construction, not just hard exact proper ERM.

### Next Depth-5 Directions

1. Formalize the conditional lemma with minimal oracle assumptions: fixed $P$ plus a polynomial-time weak proper trace selector implies the assigned target. State the selector's input/output and sample size so it can be reused by other open properization edges.

2. Try to define "weak proper trace-selection hardness" as an atlas witness template. The template should require that every $h\in\mathcal C$ with $\operatorname{corr}_{P^\star}(h,c)\ge 1/\operatorname{poly}(s)$ decodes a hard witness.

3. Search specifically for fixed-distribution proper weak-learning lower bounds where the lower bound already rules out every weakly correlated proper hypothesis, not just exact ERM or high-accuracy proper learning.

4. Revisit sample compression only under algorithmic restrictions: polynomial-size, polynomial-time, proper reconstruction. If any common concept-class family has this while still allowing improper agnostic learning, it may provide a positive subcase rather than a general theorem.

5. Test dense one-way code candidates against item 2 above. The desired object is a balanced trace family with easy improper agnostic ERM; if improper learning collapses to noisy parity/codeword learning, the candidate is not useful for this edge.

### Additional References Checked

- [Moran and Yehudayoff 2016, Sample Compression Schemes for VC Classes](https://doi.org/10.1145/2890490)
- [Floyd and Warmuth 1995, Sample Compression, Learnability, and the Vapnik-Chervonenkis Dimension](https://doi.org/10.1007/BF00994018)
- [Blumer et al. 1987, Occam's Razor](https://doi.org/10.1016/0020-0190(87)90114-1)
- [Blumer et al. 1989, Learnability and the Vapnik-Chervonenkis Dimension](https://doi.org/10.1145/76359.76371)

---

## Depth 5 Follow-Up

- depth: 5
- edge_file: atlas/implications/efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md
- verdict: unresolved
- confidence: high on the distinction between exact ERM hardness and weak selector hardness; medium-high on the open status

### Focus

This pass focused on the requested false-route question:

> Can one formalize a fixed-marginal separation in which weakly correlated proper reconstruction is hard, while agnostic improper prediction remains easy?

The short answer is: not yet from the current atlas witnesses. The right separation target is not exact proper ERM hardness. It is **fixed-marginal weak proper selector hardness**.

For a fixed marginal $P^\star$ and represented class $\mathcal C$, the selector problem is:

$$
\text{given realizable labeled examples from }(P^\star,c_\theta),
\quad
\text{output }h\in\mathcal C
\text{ with }
\operatorname{corr}_{P^\star}(h,c_\theta)\ge 1/\operatorname{poly}(s).
$$

Here correlation is the $\{\pm 1\}$ correlation, equivalently error at most $1/2-1/\operatorname{poly}(s)$. A false atlas edge would need a class where this selector is hard for every polynomial-time proper learner, but where a distribution-free agnostic improper learner can still compete efficiently with $\mathcal C$.

### Exact Proper ERM Versus Weak Selector Hardness

Exact proper ERM hardness is strictly weaker evidence than the edge needs.

Exact proper ERM asks for a proper hypothesis with zero empirical error, minimum empirical error, or very high target accuracy. The one-way image-coordinate witness proves this kind of hardness cleanly: sufficiently small error under the fixed all-length marginal forces recovery of a seed $t$ with $f(t)=f(s)$.

The target here asks for much less. It permits any proper output beating random guessing by some marginal-dependent inverse polynomial. This changes the reduction completely. A concept class can have hard exact proper reconstruction and still be weakly properly learnable by:

- a constant concept when the target is biased;
- a wrong-length or wrong-slice concept when the hard part has small marginal mass;
- a singleton or other low-support handle;
- an unrelated proper concept that agrees on an easy shared region and ignores the hard region.

Thus a separation must prove that **every** proper weak selector reveals the hard witness, not merely that every exact or high-accuracy proper ERM does. The current one-way coordinate class fails exactly here: wrong same-length or low-support proper hypotheses can have small global error without inverting the one-way image. The PCP active-slice class also fails after packing because the hard slice's contribution to global correlation is multiplied by its fixed marginal mass.

### What A Fixed-Marginal Weak Selector Witness Would Need

A valid false witness should have the following shape.

1. **Easy improper agnostic prediction.** There is an efficiently searchable improper class $\mathcal H$ containing or competing with $\mathcal C$, with polynomial VC/sample behavior and polynomial-time agnostic ERM or another robust agnostic algorithm. This must hold distribution-free, not only under $P^\star$.

2. **One fixed hard marginal.** A single marginal $P^\star$ works for all target sizes needed by the hardness reduction. The reduction may simulate labeled samples from $P^\star$ using the hard challenge, but it may not choose a new marginal $P_x$ per NP or cryptographic instance.

3. **Balanced targets.** For every hard target $c_\theta$, constants and target-independent handles must have correlation at most negligible, or at least below every possible inverse-polynomial selector guarantee. A merely small fixed inverse-polynomial residual correlation is not enough, because the target learner's $\gamma_{P^\star}(s)$ is hidden and may be smaller.

4. **Selector-to-witness decoding.** Any proper $h\in\mathcal C$ with inverse-polynomial positive correlation with $c_\theta$ under $P^\star$ must decode a witness: a satisfying proof, a preimage, or another hard certificate. This is the weak selector hardness statement.

5. **No size-scale escape.** The representation size used by the learner must remain polynomially related to the original hard instance length. Padding an exponentially large code domain into the representation can turn a polynomial-time learner in the atlas size parameter into only a subexponential or exponential-time algorithm in the original hard parameter, losing the standard contradiction.

The known witnesses each satisfy only part of this template. PCP active slices have easy improper learning and selector hardness on an input-dependent marginal, but not one fixed hard marginal. Image-coordinate concepts have easy improper agnostic sparse ERM and fixed-marginal strong reconstruction hardness, but not balanced targets or weak selector hardness. Hadamard/parity-style image codes have excellent balance and selector geometry at one length, but the agnostic improper source becomes parity-like rather than lookup-like.

### Why Dense One-Way Codes Still Do Not Resolve The Edge

The most tempting candidate remains a dense code of one-way images. Let a seed $s$ define labels by a public codeword $E(f(s))$ under a fixed marginal. If wrong images have zero or negligible correlation with $E(f(s))$, any weakly correlated proper seed would invert $f$.

This isolates the source-side problem. Sparse coordinate codes make agnostic improper learning easy by lookup or sparse ERM, but they leave weak handles. Dense orthogonal codes remove weak handles, but efficient distribution-free agnostic improper learning appears to become an agnostic decoding problem. For Hadamard-style codes, a realizable learner can recover the image vector from noiseless linear equations under friendly marginals, but the atlas source is stronger: it requires arbitrary-distribution agnostic learning with zero-one loss. That is much closer to agnostic parity learning than to sparse ERM.

Polynomial-length error-correcting codes do not fully solve the hidden-gap issue. They can bound wrong-code correlation by a chosen inverse polynomial, but a marginal-nonuniform weak learner may have a smaller hidden advantage. To refute every possible target learner, the non-witness correlation should be negligible in the atlas size parameter or nonpositive. Achieving that for exponentially many hard images while preserving a polynomial-time agnostic improper learner is exactly the missing construction.

### Conditional Positive Lemma Worth Recording Later

The positive side can be cleanly stated with the selector as an extra assumption.

**Lemma schema.** Fix $\mathcal C$ and suppose there is an efficient agnostic improper learner for $\mathcal C$. If for every marginal $P$ there is a target-uniform polynomial-time weak proper selector that, from realizable samples or from sample/evaluation access to any sufficiently accurate external predictor, outputs $h\in\mathcal C$ with inverse-polynomial $P$-correlation with the target, then the assigned implication is true.

This lemma is almost tautological, but useful: it says the statistical part is easy and all remaining work is computational proper trace selection. It also prevents confusing finite VC, Occam, or exact ERM existence with the actual missing algorithm.

### Proposed Atlas Update

No status change is justified. Keep:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
```

Candidate replacement summary:

> Open: agnostic improper learning gives accurate external prediction, but the remaining task is fixed-marginal weak proper selection. Exact proper ERM hardness and strong proper reconstruction witnesses do not rule out weak proper learners that exploit constants, low-mass slices, or other weak handles.

Candidate replacement proof-status text:

> The edge remains a marginal-nonuniform weak properization problem. Running the source learner on realizable data gives an accurate improper predictor, but no general polynomial-time method is known for selecting even a weakly correlated member of $\mathcal C$. Existing hardness witnesses do not settle the edge. PCP active-slice hardness uses input-dependent marginals, and packing the slices into one fixed marginal dilutes the weak gap. The one-way image-coordinate witness gives fixed-marginal strong proper hardness, but it proves only exact or high-accuracy reconstruction hardness; at the weak threshold, wrong-length, wrong-slice, low-support, or biased proper hypotheses may already beat random guessing without recovering the hard witness. A false result would need fixed-marginal weak selector hardness: every inverse-polynomially correlated proper hypothesis must decode a hard witness while an improper agnostic learner remains efficient.

### Obstacles

1. **Weak selector hardness is stronger than exact ERM hardness.** Hardness of finding the exact target representation does not preclude easy weak proper handles.

2. **The hidden advantage forces negligible non-witness correlation.** It is not enough to make wrong proper concepts have correlation at most $1/s^k$ for one chosen $k$, because the target learner's advantage may be $1/s^{k+1}$.

3. **Dense balance conflicts with the source.** The constructions that make every wrong proper concept nearly orthogonal tend to make improper agnostic learning parity/codeword-like rather than sparse/table-like.

4. **Fixed-marginal packing remains quantitatively wrong for weak learning.** Low-mass hard slices can be ignored even when their mass is inverse-polynomial; weak global error is close to $1/2$, not an adjustable $\varepsilon$.

5. **Length-specific hard marginals do not yield uniform reductions.** A marginal concentrated on one size can make weak selector hardness visible, but the marginal-dependent runtime polynomial may then depend on that size.

### Depth-6 Directions

1. Formalize a reusable definition of **fixed-marginal weak proper selector hardness**: specify the challenge distribution, simulator, correlation threshold, and decoder from correlated proper hypotheses to hard witnesses.

2. Test Hadamard image-code witnesses under the full agnostic improper source, not merely realizable learning. The key question is whether any tractable improper class can agnostically learn the public codeword $E(f(s))$ under arbitrary marginals without solving an agnostic parity-style problem.

3. Search for representation-sensitive fixed-distribution lower bounds that are proper-only: the lower bound should rule out correlated proper outputs while explicitly allowing an efficient improper agnostic learner. Standard fixed-distribution cryptographic hardness is too strong because it usually rules out prediction itself.

4. Prove a small "weak handle" lemma for future counterexamples: if every hard target has a target-independent proper hypothesis with correlation at least $1/\operatorname{poly}(s)$ under the proposed fixed marginal, then the witness cannot refute this edge, regardless of exact proper ERM hardness.

5. Investigate whether pseudorandom or pairwise-independent code families with efficient agnostic decoding into an improper representation exist at the right scale. The desired object needs negligible correlation for wrong proper seeds, polynomial representation size, and distribution-free agnostic improper learnability.

### References Rechecked

- [[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]]
- [[efficient-marginal-nonuniform-weak-realizable-proper-pac|Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]]
- [[properization-open|Properization Open]]
- [[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]]
- [[one-way-image-coordinate-class|One-Way Image Coordinate Class]]
- [[one-way-image-coordinate-weak-handle-hardness|One-Way Image Coordinate Weak-Handle Hardness]]
- [[one-way-image-coordinate-weak-handle-class|One-Way Image Coordinate Weak-Handle Class]]
- [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]
- [[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]]
- [[clause-satisfaction-proper-hardness|Clause-Satisfaction Proper Hardness]]
- [[clause-satisfaction-lookup-class|Clause-Satisfaction Lookup Class]]
- [[fixed-k-term-DNF|Fixed-k-Term DNF]]
- [[pseudorandom-function-classes|Pseudorandom Function Classes]]
- [[full-support-marginal-uniformization|Full-Support Marginal Uniformization]]
- [[marginal-uniformization-open|Marginal Uniformization Open]]
- [[marginal-boosting-open|Marginal-Nonuniform Boosting Open]]
- [[efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac|Efficient Agnostic Improper PAC Learning -> Efficient Marginal-Nonuniform Realizable Proper PAC Learning]]
- [[efficient-agnostic-improper-pac--implies--efficient-weak-realizable-proper-pac|Efficient Agnostic Improper PAC Learning -> Efficient Weak Realizable Proper PAC Learning]]

---

## Depth 6 Final Follow-Up

- depth: 6
- edge_file: atlas/implications/efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md
- verdict: unresolved
- confidence: high that current atlas witnesses do not resolve the edge; medium-high that the right obstruction is fixed-marginal weak proper selection

### Final Verdict

No status change is justified. The edge should remain:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
```

The last pass did not find a theorem converting efficient agnostic improper learning into marginal-nonuniform weak realizable proper learning, and it did not find a fixed-marginal counterexample satisfying the strong source. The final obstruction is now quite crisp:

> The source gives efficient external prediction. The target requires efficient selection of a weakly correlated member of the original representation class under each fixed marginal. No representation-independent polynomial-time selector follows from the improper learner, and no checked witness proves such selection hard while preserving distribution-free agnostic improper learnability.

### Depth-6 Direction 1: Fixed-Marginal Weak Proper Selector Hardness

A false witness for this edge should be phrased as a selector-hardness object, not as exact proper ERM hardness.

**Template.** A fixed-marginal weak proper selector hardness witness consists of:

1. a represented binary class $\mathcal C=\{c_\theta\}$ and size measure $s(\theta)$;
2. one marginal $P^\star$ over the instance space, independent of $\theta$ and of the hard input except for the usual size parameter encoded in examples;
3. a simulator which, from a hard challenge $z$ associated with some hidden $\theta$, samples labeled examples $(X,c_\theta(X))$ with $X\sim P^\star$ without knowing a proper representation of $\theta$;
4. an efficient distribution-free agnostic improper learner for $\mathcal C$;
5. a decoder $D$ such that every proper hypothesis $h\in\mathcal C$ satisfying

$$
\operatorname{corr}_{P^\star}(h,c_\theta)
=
\mathbb E_{X\sim P^\star}[\tilde h(X)\tilde c_\theta(X)]
\ge \frac{1}{\operatorname{poly}(s(\theta))}
$$

lets $D(h,z)$ recover a hard witness, such as a satisfying proof or a one-way preimage.

Here $\tilde h,\tilde c\in\{\pm1\}$ are the sign encodings. This is stronger than saying that exact or high-accuracy proper recovery is hard. It says that **every** inverse-polynomially correlated proper output is already a hard witness.

The existing atlas witnesses fail one of these clauses:

- PCP active slices have weak selector hardness on the input-specific active marginal, but not on one fixed marginal with target-independent polynomial control.
- The one-way image-coordinate class has one fixed marginal and an efficient agnostic improper sparse ERM, but only high-accuracy proper outputs decode a preimage.
- Pseudorandom-function classes give computational hardness under a fixed hard marginal, but they rule out efficient prediction itself and therefore do not satisfy the assigned efficient agnostic improper source.

### Depth-6 Direction 2: Hadamard And Dense Image-Code Tests

The dense one-way-code idea remains the closest-looking false route, but it still fails the source test.

Let a seed $s$ label examples by a balanced codeword $E(f(s))$. If $E$ is Hadamard-like, wrong images can be exactly orthogonal under the uniform coordinate marginal. Then any proper seed with positive inverse-polynomial correlation would appear to reveal a seed $t$ whose image agrees with $f(s)$ in the relevant decoded sense.

The source requirement breaks this candidate. Under arbitrary labeled distributions, competing agnostically with the best image-codeword becomes an agnostic codeword/parity problem. For Hadamard encodings, the hypotheses are parity-like functions over coordinates. A realizable learner under friendly marginals can solve noiseless linear equations; an agnostic distribution-free learner with zero-one loss must handle arbitrary corruptions and arbitrary coordinate marginals. The best known general agnostic parity-type algorithms are not polynomial in the dimension, and the standard hardness folklore points the wrong way for using this as an easy improper source.

Sparse coordinate exposure goes the other way: it supports the source via lookup-table or sparse ERM, but it creates weak handles. Dense exposure removes weak handles, but seems to destroy the efficient agnostic improper learner. I did not find a code family with all three needed properties:

- negligible correlation for every non-witness proper seed;
- labels simulatable from the hard challenge;
- distribution-free polynomial-time agnostic improper learning by some external representation.

Polynomial-length error-correcting codes also do not settle the hidden-advantage problem. Bounding non-witness correlation by $1/s^k$ is insufficient against an unknown learner whose allowed advantage might be $1/s^{k+1}$.

### Depth-6 Direction 3: Fixed-Distribution Proper-Only Lower Bounds

The literature and atlas notes checked do not provide the needed fixed-distribution proper-only lower bound.

Some fixed-distribution results show proper algorithms are possible under structured marginals, for example recent proper agnostic halfspace learning under Gaussian marginals. These are positive special cases, not separations.

Other fixed-distribution hardness results, such as cryptographic or lattice-based hardness for weak prediction under a specific marginal, are too strong for this edge: they rule out any efficient learner outputting any binary predictor, so they cannot coexist with the assigned efficient agnostic improper source.

Recent distribution-fixed proper-learning work is also a near miss. It shows that when the marginal distribution is explicitly given, optimal proper learners can exist in broad finite settings. This does not prove the atlas edge because the atlas learner is one uniform algorithm, is not handed an arbitrary exact description of $P$, and must be computationally polynomial in the representation size. The theorem is therefore useful context for the statistical side of fixed-marginal properization, but it does not supply the missing efficient proper trace selector.

### Depth-6 Direction 4: Weak Handle Lemma

The following small lemma is useful for future attempted counterexamples.

**Weak Handle Lemma.** Fix a proposed hard marginal $P^\star$ and target family $\{c_\theta:\theta\in\Theta_s\}\subseteq\mathcal C$. Suppose there is a uniform polynomial-time procedure which, from realizable samples labeled by $c_\theta$, outputs a proper hypothesis $h_\theta\in\mathcal C$ with

$$
\operatorname{corr}_{P^\star}(h_\theta,c_\theta)
\ge \frac{1}{q(s)}
$$

for some polynomial $q$, and this procedure does not decode the hard witness. Then this family cannot refute the assigned edge under the marginal $P^\star$.

**Why.** The target node only requires some marginal-dependent inverse-polynomial advantage. The above handle already supplies such an advantage, so any hardness proof based on forcing exact recovery, high accuracy, or inversion is bypassed at the weak threshold.

The handle can be a constant, a singleton, a wrong-length concept, a wrong-slice concept, a shared guard-label concept, or any other proper member whose positive correlation is visible before solving the hard problem. This lemma explains why strong reconstruction witnesses do not automatically become weak-learning witnesses.

### Depth-6 Direction 5: Pseudorandom Or Pairwise-Independent Code Families

Pseudorandom or pairwise-independent labels have the right geometry for defeating weak handles: nonmatching proper seeds should look nearly uncorrelated with the target. The problem is that this geometry normally makes improper agnostic learning hard as well.

If the improper learner can only see labeled samples from arbitrary distributions, then an external predictor must either:

- recover enough of the target codeword to compete with it under arbitrary corruptions; or
- optimize over a tractable relaxation whose predictions are as good as the best proper seed.

For pseudorandom or parity-like codes, both tasks look as hard as the usual agnostic parity/noisy-codeword problems unless the code has extra sparse structure. But that sparse structure is exactly what reintroduces weak handles. I found no known construction at the right scale.

### Final Unresolved Summary Suitable For Atlas Incorporation

**Verdict.** Keep the implication open with `evidence: unknown`.

**Short atlas summary.**

> Open: efficient agnostic improper learning gives accurate external prediction on realizable data, but no generic polynomial-time method is known for selecting even a weakly correlated proper concept under a fixed marginal; existing strong proper hardness witnesses lose force at the weak threshold.

**Suggested proof-status replacement.**

> The edge remains a marginal-nonuniform weak properization problem. Running the source learner on realizable data gives an accurate improper predictor, but the target asks for a member of $\mathcal C$. The missing step is a target-uniform fixed-marginal weak proper selector: from samples, or from an accurate external predictor, efficiently output $h\in\mathcal C$ with inverse-polynomial positive correlation with the realizing concept. Finite VC theory, Occam bounds, sample compression, and unbounded ERM give statistical existence but not this representation-sensitive polynomial-time search procedure.
>
> Known separation templates do not settle the edge. PCP active-slice hardness refutes distribution-free weak properization, but it uses marginals tied to the input instance; packing all slices into one fixed marginal dilutes the weak gap and creates wrong-slice handles. The one-way image-coordinate witness is distribution-free agnostically learnable by improper sparse ERM and refutes strong fixed-marginal proper learning, but at the weak threshold wrong-length, low-support, or otherwise target-independent proper hypotheses can beat random guessing without recovering a one-way preimage. Dense Hadamard or pseudorandom image-code variants would remove these handles, but then the improper agnostic source becomes a parity/codeword-style agnostic learning problem rather than a sparse lookup problem.
>
> A false result would need fixed-marginal weak proper selector hardness: every inverse-polynomially correlated proper hypothesis must decode a hard witness, while an efficient distribution-free agnostic improper learner still exists. A true result would need an efficient representation-independent proper trace selector or an equivalent projection theorem. Neither is currently present in the checked notes.

### Crisp Obstacles

1. **Proper trace selection is the missing algorithmic step.** The realizing concept itself is proper and has zero error, but an accurate improper predictor need not encode any efficiently recoverable member of $\mathcal C$.

2. **Marginal nonuniformity blocks input-specific reductions.** If the hard marginal depends on the SAT instance, PCP instance, or cryptographic length in a way not controlled by one fixed $P$, the hidden polynomial may depend on the challenge itself.

3. **Weak learning is too permissive for strong hardness witnesses.** Exact or high-accuracy proper recovery can be hard while constants, wrong slices, wrong lengths, singleton handles, or shared guard behavior already give inverse-polynomial positive correlation.

4. **Fixed-marginal packing dilutes gaps.** A hard slice with small global mass can be ignored while still achieving error below $1/2-\gamma_P(s)$ for some inverse-polynomial $\gamma_P$.

5. **Dense balance conflicts with easy improper agnostic learning.** The constructions that make every non-witness proper concept nearly orthogonal tend to require solving agnostic parity/codeword search to compete improperly.

6. **Known computational hardness for weak prediction is too strong.** PRF and lattice-style hard marginals usually rule out all efficient predictors, so they cannot be witnesses for a class satisfying the assigned efficient agnostic improper source.

### Best Future Directions

1. Add a reusable atlas argument note defining **fixed-marginal weak proper selector hardness** as the right false-witness template.

2. Try to prove a conditional positive lemma: efficient agnostic improper learning plus a target-uniform polynomial-time weak proper trace selector for every fixed marginal implies this edge.

3. Search for a concrete class with easy distribution-free improper agnostic ERM and hard fixed-marginal weak proper selector. The construction must eliminate all target-independent weak handles, not just make exact recovery hard.

4. Revisit dense one-way image codes only if there is an independently efficient agnostic improper decoder or relaxation. The source-side test should be applied before investing in the preimage-decoding lower bound.

5. Look for proper-only fixed-distribution lower bounds whose statement explicitly allows efficient improper agnostic prediction. Lower bounds against all binary predictors are not usable for this edge.

6. Consider adding a short warning to [[properization-open|Properization Open]]: for marginal-nonuniform weak proper targets, "proper ERM is hard" is not enough; the required obstruction is weak proper selector hardness.

### References Checked At Final Depth

Atlas notes:

- [[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]]
- [[efficient-marginal-nonuniform-weak-realizable-proper-pac|Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]]
- [[properization-open|Properization Open]]
- [[full-support-marginal-uniformization|Full-Support Marginal Uniformization]]
- [[marginal-uniformization-open|Marginal Uniformization Open]]
- [[marginal-boosting-open|Marginal-Nonuniform Boosting Open]]
- [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]
- [[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]]
- [[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]]
- [[one-way-image-coordinate-class|One-Way Image Coordinate Class]]
- [[one-way-image-coordinate-weak-handle-hardness|One-Way Image Coordinate Weak-Handle Hardness]]
- [[one-way-image-coordinate-weak-handle-class|One-Way Image Coordinate Weak-Handle Class]]
- [[clause-satisfaction-proper-hardness|Clause-Satisfaction Proper Hardness]]
- [[clause-satisfaction-lookup-class|Clause-Satisfaction Lookup Class]]
- [[fixed-k-term-DNF|Fixed-k-Term DNF]]
- [[pseudorandom-function-classes|Pseudorandom Function Classes]]
- [[efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac|Efficient Agnostic Improper PAC Learning -> Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]]
- [[efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac|Efficient Agnostic Improper PAC Learning -> Efficient Marginal-Nonuniform Realizable Proper PAC Learning]]
- [[efficient-agnostic-improper-pac--implies--efficient-weak-realizable-proper-pac|Efficient Agnostic Improper PAC Learning -> Efficient Weak Realizable Proper PAC Learning]]
- [[efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac|Efficient Marginal-Nonuniform Realizable Improper PAC Learning -> Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]]
- [[efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac|Efficient Marginal-Nonuniform Weak Realizable Improper PAC Learning -> Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]]
- [[efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac|Efficient Marginal-Nonuniform Agnostic Improper PAC Learning -> Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning]]
- [[efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-weak-realizable-proper-pac|Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning -> Efficient Weak Realizable Proper PAC Learning]]

External references checked for the final pass:

- [Asilis, Devic, Dughmi, Sharan, and Teng 2025, Proper Learnability and the Role of Unlabeled Data](https://proceedings.mlr.press/v272/asilis25b.html)
- [Kalai, Mansour, and Verbin 2008, On Agnostic Boosting and Parity Learning](https://www.microsoft.com/en-us/research/publication/agnostic-boosting-parity-learning/)
- [Kalai, Klivans, Mansour, and Servedio 2008, Agnostically Learning Halfspaces](https://doi.org/10.1137/060649057)
- [Feldman, Guruswami, Raghavendra, and Wu 2009/2010, Agnostic Learning of Monomials by Halfspaces is Hard](https://arxiv.org/abs/1012.0729)
- [Tiegel 2022, Hardness of Agnostically Learning Halfspaces from Worst-Case Lattice Problems](https://arxiv.org/abs/2207.14030)
