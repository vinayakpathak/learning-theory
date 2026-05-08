# Edge: efficient-agnostic-improper-pac -> efficient-marginal-nonuniform-weak-realizable-proper-pac

- date: 2026-05-07
- assigned edge file: `atlas/implications/efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- source: [[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]]
- target: [[efficient-marginal-nonuniform-weak-realizable-proper-pac|Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]]
- linked argument: [[properization-open|Properization Open]]
- verdict: unresolved
- confidence: high that current atlas witnesses do not resolve the edge; medium-high that the closest positive result is conditional on representation and stopping semantics

## Local Context Checked

The source node is strong distribution-free agnostic improper PAC learning. On realizable labels from $c\in\mathcal C$, the source learner can be run with, say, $\varepsilon=1/10$ to output an external predictor $g$ with small $P$-error against $c$ under every marginal $P$.

The target node is much weaker statistically but stronger syntactically. It asks for one uniform learner which, for every fixed marginal $P$, has a $P$-dependent polynomial sample and pathwise runtime bound and outputs a proper $h\in\mathcal C$ with

$$
\operatorname{err}_P(h,c)\le \frac12-\gamma_P(s),
$$

where $1/\gamma_P(s)$ is bounded by a polynomial that may depend on $P$, but not on the target concept.

The current edge note records the edge as `open`, with `evidence: unknown`, in the `properization-open` family. That classification is still justified after this pass.

## What Would Prove The Edge True

The clean positive route is a fixed-marginal weak proper selector:

> Given realizable labeled samples from $(P,c)$, or sample/evaluation access to an accurate external predictor for $c$, efficiently output some represented $h\in\mathcal C$ with inverse-polynomial positive correlation with $c$ under $P$.

If such a selector exists for every fixed marginal $P$, with a target-uniform $P$-dependent polynomial bound, then the implication follows immediately. The source supplies the external predictor; validation can choose among any polynomially generated list of legal candidates.

The source assumption itself does not supply this selector. It says there is an efficient prediction algorithm in a possibly external representation. It does not say how to recover even a weakly correlated member of the original representation class.

## Conditional Finite-Trace Near Theorem

The strongest positive observation is the finite-trace dovetailing theorem from neighboring scratchpads, adapted to this edge.

**Conditional theorem.** Suppose the atlas semantics were strengthened with all of the following:

1. the instance space seen by computational learners is countable and finitely encoded;
2. legal proper descriptions for $\mathcal C$ are recursively enumerable;
3. every enumerated description has an effective total evaluator on encoded examples;
4. the marginal-nonuniform runtime convention supplies a legitimate pathwise stopping rule or stopping certificate for the finite proper search below.

Then the target node holds for every such class, and the improper source is not needed.

**Proof plan.** Fix a marginal $P$. Choose a finite set $F$ with $P(F)>3/4$. For every trace $\tau:F\to\{0,1\}$ realized by some concept in $\mathcal C$, let $h_\tau$ be the first proper description in the enumeration that realizes $\tau$. There are finitely many such traces, so the largest enumeration index and evaluation cost among the $h_\tau$ are finite constants depending on $P$ and the representation, but not on the target concept.

For samples labeled by a target $c$, the representative $h_{c|F}$ agrees with $c$ on all of $F$, hence has error at most $P(X\setminus F)<1/4$. With a valid way to search far enough and stop, a learner can find and validate a candidate of true error below $1/2$, giving a constant weak advantage.

**Why this does not resolve the current edge.** The current atlas definitions say that efficient resources are worst-case/pathwise bounds on finite encoded sample transcripts. They do not explicitly give every proper class a recursive legal-description enumeration, a total evaluator, or a stopping certificate for "searched far enough to include a good high-mass-trace representative." A validation-until-success procedure has random stopping time and is not automatically a pathwise polynomial-time PAC learner. Conversely, a fixed bounded search budget cannot depend on the hidden marginal $P$.

Adopting the conditional theorem as implicit would be a model-level clarification. It would make many weak marginal-nonuniform proper targets true for countable recursive representations, regardless of improper learnability. That is too broad to treat as a source-to-target implication under the notes as written.

## Why Known False Routes Still Miss

### PCP Active Slices

The [[pcp-active-slice-weak-proper-hardness|PCP active-slice]] witness is source-positive: one-slice lookup-table ERM gives efficient agnostic improper learning against the proper PCP-proof class. It also separates distribution-free weak improper learning from distribution-free weak proper learning under $\mathrm{NP}\nsubseteq\mathrm{RP}$, using a perfect-completeness PCP with logarithmic randomness and soundness below $1/2$.

It does not refute the assigned target. The hardness reduction samples from the active slice of the input formula $\varphi$, so the marginal is $P_\varphi$. A marginal-nonuniform learner may have a polynomial bound depending on this exact marginal, which prevents a uniform polynomial-time SAT reduction.

Packing all slices into one fixed marginal also fails. If

$$
P^\star=\sum_\psi w_\psi U_\psi,
$$

then the local PCP gap on slice $\varphi$ is multiplied by $w_\varphi$. For low-mass slices, wrong-slice or mostly-zero proper hypotheses can already achieve global error far below $1/2$ without producing a proof for $\varphi$. A fixed distribution cannot give constant mass to exponentially many hard instances.

### One-Way Image Coordinates

The [[one-way-image-coordinate-proper-hardness|one-way image-coordinate]] class is the closest existing source-positive cryptographic witness. It is efficiently agnostically learnable by improper sparse ERM, because length-$n$ proper concepts have only $n$ positive atoms and are contained in a sparse lookup class of VC dimension $n$.

The witness proves strong fixed-marginal proper hardness, not weak fixed-marginal proper hardness. Under the all-length marginal with block mass $\mu_n=\Theta(1/n^2)$, high accuracy on the length-$n$ block forces a seed $t$ with $f(t)=f(s)$. But weak learning permits global error just below $1/2$. Wrong-length concepts, low-support concepts, constants if present, or other target-independent handles can beat random guessing globally while ignoring the hard block and without inverting the one-way function.

The weak-handle variant makes this explicit: adding proper singleton or bounded-subset handles gives weak proper learning while preserving strong proper hardness at sufficiently small requested accuracy.

### Dense Hadamard Or Image-Code Repairs

The tempting repair is to encode the one-way image densely. At one fixed length, define labels by a Hadamard-style predicate

$$
c_s(r)=\langle f(s),r\rangle \pmod 2.
$$

Under the uniform length-$n$ marginal, an improper learner that can output the coefficient $f(s)$ need not invert $f$, while any positively correlated proper seed should have the same image and hence give a preimage.

This is not an atlas-ready counterexample. If the hard marginal is the length-specific uniform marginal, then the target's polynomial may depend on that marginal and hence on $n$, so the reduction does not yield a uniform inverter. Packing lengths into one fixed finite-string marginal reintroduces tail dilution and wrong-length/default handles. Shared polynomial-size coordinate systems leave inverse-polynomial residual correlations, which may be enough for the hidden $\gamma_P(s)$ target. Exact all-length orthogonality seems to require atomless or infinite-product structure outside the present finite-transcript convention, or else makes the source look like agnostic parity/codeword learning rather than sparse ERM.

### PRF, LPN, And Other Fixed-Marginal Hardness

Pseudorandom-function and LPN-style classes have fixed-marginal weak-prediction hardness, but that is too strong for this edge. They would rule out efficient improper prediction itself, so they cannot witness a class satisfying [[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]].

### Clause-Satisfaction And DNF Proper Hardness

Clause-satisfaction lookup classes explain why improper agnostic learning can be much easier than proper learning. But their hard agnostic reductions encode the input formula in the distribution or conditional labels. The assigned target is realizable and weak. Under realizable assignment labels, unrelated assignments or default behavior can agree on enough mass to be weak proper handles unless the marginal is made instance-specific again.

## Main Obstruction

The unresolved object is **fixed-marginal weak proper selection**.

A true theorem would need an efficient representation-independent way to project an accurate external predictor, or a finite trace of labels, back into $\mathcal C$ with positive inverse-polynomial correlation. VC theory, Occam bounds, sample compression, and unbounded ERM give statistical existence or sample-only properization, but not the required polynomial-time represented output.

A false theorem would need a class and one fixed marginal $P^\star$ such that:

1. efficient distribution-free agnostic improper learning holds;
2. labels from a hard target under $P^\star$ can be simulated from the challenge;
3. every inverse-polynomially correlated proper hypothesis decodes a hard witness;
4. no constants, wrong slices, wrong lengths, finite-prefix concepts, low-support concepts, shared guards, or residual-code concepts give weak proper handles;
5. the construction keeps the original hard instance size polynomially related to the atlas representation size.

No checked PCP, DNF, one-way, PRF, sparse lookup, or dense code template satisfies all five requirements.

## Proposed Atlas Status

No atlas file should be changed from this pass. The edge should remain:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
argument_note: "[[properization-open|Properization Open]]"
```

If later edits are allowed, the edge body could be sharpened by adding the finite-trace semantics fork:

> A finite-trace dovetailing argument would prove the target for countable recursive representations with total evaluators and a valid pathwise stopping rule, but those representation and stopping assumptions are not currently part of the atlas node semantics. Under the current wording, the implication remains open.

## Follow-Up Directions

1. Decide the semantics fork explicitly: do computational atlas classes always have recursively enumerable legal proper descriptions and total evaluators? If yes, formalize the finite-trace proper-learning theorem and revisit all weak marginal-nonuniform properization edges.

2. Settle the stopping-rule issue. The missing technical object is a pathwise polynomial enumerate-and-validate procedure whose bound may depend on $P$ without giving the learner $P$ as advice.

3. Search for a fixed-marginal weak proper selector hardness witness, not merely exact proper ERM hardness. The lower bound must apply to every inverse-polynomially correlated proper output.

4. Revisit dense one-way image codes only if there is an independently efficient agnostic improper decoder or relaxation. Otherwise the source side becomes agnostic parity/codeword learning.

5. Treat PRF/LPN-style lower bounds cautiously. They are useful for sample-to-computational separations but usually rule out the improper source needed here.

## Sources Checked

Atlas notes checked:

- [[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]]
- [[efficient-marginal-nonuniform-weak-realizable-proper-pac|Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]]
- [[properization-open|Properization Open]]
- [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]
- [[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]]
- [[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]]
- [[one-way-image-coordinate-class|One-Way Image Coordinate Class]]
- [[one-way-image-coordinate-weak-handle-hardness|One-Way Image Coordinate Weak-Handle Hardness]]
- [[one-way-image-coordinate-weak-handle-class|One-Way Image Coordinate Weak-Handle Class]]
- [[pseudorandom-function-classes|Pseudorandom Function Classes]]
- [[clause-satisfaction-proper-hardness|Clause-Satisfaction Proper Hardness]]
- [[sample-complexity-equivalence|Sample-Complexity Equivalence]]
- [[realizable-boosting|Realizable Boosting]]
- [[full-support-marginal-uniformization|Full-Support Marginal Uniformization]]
- [[marginal-uniformization-open|Marginal Uniformization Open]]
- [[marginal-boosting-open|Marginal-Nonuniform Boosting Open]]
- neighboring open implication notes into [[efficient-marginal-nonuniform-weak-realizable-proper-pac|Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]]
- previous exact-edge scratchpad under `scratchpads/open-edge-resolution-2026-05-05/efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`
- neighboring finite-trace scratchpads under `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/`

Primary/external sources checked:

- [Hanneke, Moran, and Thiessen 2025, Marginal-Nonuniform PAC Learnability](https://openreview.net/forum?id=aoVCFtox89)
- [Asilis, Devic, Dughmi, Sharan, and Teng 2025, Proper Learnability and the Role of Unlabeled Data](https://proceedings.mlr.press/v272/asilis25b.html)
- [Hastad and Khot 2005, Query Efficient PCPs with Perfect Completeness](https://theoryofcomputing.org/articles/v001a007/)
- [Kearns and Valiant 1994, Cryptographic Limitations on Learning Boolean Formulae and Finite Automata](https://www.cis.upenn.edu/~mkearns/papers/cryptojacm.pdf)

## Final Verdict

`unresolved`.

The finite-trace argument is the main conditional positive lead, but it depends on representation and pathwise stopping semantics not currently stated in the atlas. Existing hardness witnesses still fail at the weak fixed-marginal target because they use input-dependent marginals, leak weak proper handles, or make improper agnostic learning hard as well.

## Depth 2 Branch A: Finite-Trace Stopping Semantics

- date: 2026-05-07
- branch: finite-trace/stopping-semantics positive route
- verdict: unresolved
- confidence: high that recursively enumerable legal descriptions plus total evaluators are not enough under the atlas's current pathwise runtime semantics

### Question

Does the current atlas semantics already make the finite-trace argument a proof? More concretely, suppose the computational representation is countable and finitely encoded, legal proper descriptions are recursively enumerable, and every enumerated description has a total evaluator. Is that enough to prove

```text
efficient-agnostic-improper-pac
->
efficient-marginal-nonuniform-weak-realizable-proper-pac
```

by enumerating proper concepts until a high-mass finite trace is covered?

### Local Semantic Facts

The target note says that one uniform learner must work for all marginals $P$, that the polynomial $p_P$ may depend on $P$, and that the learner is not given a separate $P$-specific algorithm or advice. The atlas README adds the crucial resource convention: computationally efficient resource bounds are worst-case/pathwise bounds on finite encoded sample transcripts, not merely expected or high-probability running times under the marginal.

The reusable [[full-support-marginal-uniformization|Full-Support Marginal Uniformization]] argument is directly relevant. Under this pathwise convention, if a single marginal-nonuniform learner is valid for every marginal, then applying it to a full-support reference marginal $P^\star$ gives one polynomial resource bound for every finite transcript that can occur under any marginal. Thus hidden dependence on $P$ cannot be used as an unbounded search clock. Marginal nonuniformity remains meaningful for the accuracy gap $\gamma_P$, but not as permission for an unobservable, arbitrarily long pathwise search.

This is a semantic consequence of the current atlas wording, not an external theorem. The primary marginal-nonuniform sources cited by the target note, Benedek-Itai, Ben-David-Benedek-Mansour, and Hanneke-Moran-Thiessen, justify the fixed/marginal-dependent quantifier pattern; the stopping issue here is caused by the atlas's additional computational pathwise convention.

### What RE Descriptions And Total Evaluators Do Give

Fix a countable finitely encoded instance space and a fixed marginal $P$. For every $\eta>0$ there is a finite set $F\subseteq \mathcal X$ with $P(F)>1-\eta$. Taking $\eta=1/4$, each target $c\in\mathcal C$ has a trace $c|_F$. If legal proper descriptions can be recursively enumerated and evaluated, then for each realized trace $\tau$ there is a first enumerated legal description $h_\tau$ whose concept realizes $\tau$. Since there are at most $2^{|F|}$ traces, the finite family

$$
H_P=\{h_\tau:\tau \text{ is realized on } F\}
$$

is finite and depends only on $P$ and the representation, not on the target concept. For every $c$, the representative $h_{c|_F}$ has

$$
\operatorname{err}_P(h_{c|_F},c)\le P(\mathcal X\setminus F)<1/4.
$$

This is the genuine finite-trace insight. It proves existence of a finite $P$-dependent proper weak cover, and it would be enough in a sample-only or unbounded-computation setting.

### Why This Still Does Not Produce An Atlas Learner

The uniform learner does not know $P$, does not know $F$, and does not know the enumeration depth by which all representatives in $H_P$ have appeared. Let $K_P$ denote such a depth, including the evaluator running times needed on the finite traces. The proof above shows only that $K_P<\infty$.

There are two possible stopping strategies, and both miss the current target.

1. **Stop after a fixed bounded search.** If the learner searches only through a code-determined budget $T(s,\log(1/\delta))$, then the finite-trace argument works only for marginals whose needed $K_P$ is below that budget. Recursively enumerable legality gives no polynomial bound, and no completion certificate saying that every relevant legal trace representative has appeared. A bad enumeration order can delay short legal descriptions arbitrarily long while remaining recursively enumerable.

2. **Dovetail until validation succeeds.** This gives at best a high-probability stopping time. Validation samples can be atypical for arbitrarily long finite prefixes, and finite data cannot certify that an unseen region has small $P$-mass. Therefore this procedure does not have a worst-case/pathwise polynomial bound on all finite transcripts. It may be a perfectly natural Las Vegas or high-probability-time learner, but the atlas explicitly rules out treating such stopping as computational efficiency.

The important point is that the learner need not know the polynomial $p_P$ in ordinary marginal-nonuniform syntax, but a pathwise bound must nevertheless be true of the actual computation on every finite transcript from that marginal. For a learner required to work for all marginals, the full-support argument would then give a single global pathwise resource polynomial. Thus a hidden $P$-dependent stopping depth cannot rescue the dovetailing proof.

### Exact Missing Assumption

The missing assumption is not merely "finite encodings are countable" or "proper concepts are recursively enumerable." Those are semantic clarifications that make the finite-trace search definable.

The missing assumption is an effective, pathwise-bounded proper trace selector. One usable form would be:

> For the represented class, there is one uniform algorithm $S$ such that, for every marginal $P$, there is a polynomial $q_P$ with the following property. On input size parameter $s$ and confidence $\delta$, $S$ halts within $q_P(s,\log(1/\delta))$ on every finite encoded transcript compatible with $P$ and, with probability at least $1-\delta$ over realizable samples from any $c\in\mathcal C$, outputs a legal proper $h\in\mathcal C$ with $\operatorname{err}_P(h,c)\le 1/2-\gamma_P(s)$ for inverse-polynomial $\gamma_P$.

But this is essentially the target learner or a target-level selector oracle. A less tautological sufficient assumption would be a computable sequence of polynomial-time generated legal lists $L_s$ such that, for every fixed $P$, $L_s$ is a weak $P$-cover of $\mathcal C_s$ with an inverse-polynomial $P$-dependent gap. That is a real representation/algorithmic strengthening: it rules out arbitrary recursively enumerable delays and supplies the missing proper search bound.

Alternatively, the route would work after changing the learning model to allow one of the following:

- $P$-specific advice or a $P$-specific stopping budget supplied to the learner;
- expected-time or high-probability-time efficiency rather than pathwise efficiency;
- an external certificate that a finite enumerated candidate set covers a set of $P$-mass above $3/4$ for all target traces.

Each option changes the computational model. It is not implicit in the atlas notes as currently written.

### Conditional Positive Theorem Under The Strengthened Assumption

**Theorem.** Suppose the class has countable finite encodings, recursively enumerable legal descriptions, total evaluators, and a pathwise polynomial fixed-marginal trace-cover generator in the following sense: for every marginal $P$ there are a polynomial $q_P$ and an inverse-polynomial $\gamma_P$ such that one uniform algorithm $G$, on input $s,\delta$, halts within $q_P(s,\log(1/\delta))$ on every compatible finite transcript and outputs a finite list of legal descriptions $L$ for which, with probability at least $1-\delta/2$ over a realizable sample transcript from any target $c\in\mathcal C_s$, some $h\in L$ satisfies $\operatorname{err}_P(h,c)\le 1/2-2\gamma_P(s)$. Then the target node holds. The source efficient agnostic improper learner is not needed.

**Proof.** Run $G$ with confidence $\delta/2$ to obtain $L$. Use fresh labeled validation samples and the total evaluator to estimate the error of every $h\in L$ to accuracy $\gamma_P(s)/2$, with failure probability at most $\delta/2$ after a union bound over the generated list. Output the empirically best legal candidate. On the event that $G$ supplies a $2\gamma_P$-good candidate and validation succeeds, the selected hypothesis has error at most $1/2-\gamma_P(s)$. The sample use and runtime are bounded by a polynomial depending on $P$, because $G$ is pathwise polynomial by assumption and the list size and evaluation costs are bounded by its runtime. This is an atlas-valid marginal-nonuniform weak realizable proper learner.

The theorem is deliberately stated with the trace-cover generator as an assumption. Recursively enumerable legal descriptions and total evaluators alone do not provide it.

### Branch Verdict

The finite-trace route remains a conditional-only positive route. Under the atlas's current stated computational semantics, countable finite encoding plus recursively enumerable legal proper descriptions plus total evaluators is not enough to prove the target. The exact gap is a pathwise stopping/search-bound assumption for the proper trace search. Treating that gap as solved would be a genuine strengthening of the representation or runtime model, not just a harmless clarification of the existing node semantics.
