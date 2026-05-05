# Open Edge Resolution Scratchpad

Edge: `efficient-marginal-nonuniform-realizable-improper-pac -> efficient-marginal-nonuniform-weak-realizable-proper-pac`

## Research Log

## Sources Checked

## Proof Or Counterexample Attempts

## Verdict

## Follow-Up Directions

## Depth-1 Entry - 2026-05-05

### Verdict

`unresolved`; keep the atlas edge `open` with `evidence: unknown`.

I do not see an atlas-ready proof of the implication, and I also do not see a valid false witness for this exact marginal-nonuniform weak-proper target. The source is stronger than the neighboring weak-improper source, because it gives arbitrary-accuracy improper prediction for each marginal. But the target's properness requirement still asks for a polynomial-time way to output a member of $\mathcal C$, and the checked routes do not provide a generic projection back into the represented class.

No exact status/evidence/assumptions/witnesses/ref_keys change is justified yet.

### Definitions Used

Source node:
`efficient-marginal-nonuniform-realizable-improper-pac`.

One uniform learner $A$ works for every marginal $P$. For each fixed $P$, there is a marginal-dependent polynomial $p_P$ such that for every target $c\in\mathcal C$ and every $\varepsilon,\delta\in(0,1)$, $A$ outputs an arbitrary polynomially evaluable hypothesis $h$, not necessarily in $\mathcal C$, with

$$
\operatorname{err}_P(h,c)\le \varepsilon
$$

using sample and time bounded by $p_P(s,1/\varepsilon,\log(1/\delta))$.

Target node:
`efficient-marginal-nonuniform-weak-realizable-proper-pac`.

One uniform learner must output $h\in\mathcal C$. For every fixed marginal $P$, there are a marginal-dependent polynomial $p_P$ and an inverse-polynomial advantage $\gamma_P(s)>0$ such that, for every target $c\in\mathcal C$ and confidence $\delta$,

$$
\operatorname{err}_P(h,c)\le \frac12-\gamma_P(s)
$$

with sample and runtime bounded by $p_P(s,\log(1/\delta))$.

Thus the edge changes two axes at once: strong-to-weak is a relaxation, but improper-to-proper is a computational representation constraint. The strong source implies the marginal-nonuniform weak improper source, but that sibling properization edge is itself unresolved in the current scratchpads.

### Sources Checked

- Local source definition: `atlas/definitions/efficient-marginal-nonuniform-realizable-improper-pac.md`.
- Local target definition: `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`.
- Local edge note: `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`.
- Local argument and comparison notes: `atlas/arguments/properization-open.md`, `atlas/arguments/marginal-boosting-open.md`, `atlas/arguments/marginal-uniformization-open.md`, `atlas/arguments/one-way-image-coordinate-proper-hardness.md`, `atlas/witnesses/one-way-image-coordinate-class.md`, `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`, `atlas/witnesses/pcp-active-slice-lookup-class.md`, `atlas/arguments/fixed-k-term-dnf-proper-boosting-separation.md`, and `atlas/witnesses/fixed-k-term-DNF.md`.
- Local sibling scratchpads: `efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac`, `efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac`, and `efficient-weak-realizable-improper-pac--implies--efficient-weak-realizable-proper-pac`.
- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability" (NeurIPS 2025), OpenReview: https://openreview.net/forum?id=aoVCFtox89. Checked for the modern marginal-nonuniform quantifier pattern: the rate may depend on the marginal, but the learner is still uniform over concepts.
- Benedek and Itai, "Learnability with respect to fixed distributions" (1991), ScienceDirect page: https://www.sciencedirect.com/science/article/pii/030439759190026X. Checked for fixed-distribution background.
- Ben-David, Benedek, and Mansour, "A Parameterization Scheme for Classifying Models of PAC Learnability" (1995), DOI: https://doi.org/10.1006/inco.1995.1094. Checked for the uniformity-parameter viewpoint.
- Schapire, "The Strength of Weak Learnability" (1990), DOI: https://doi.org/10.1023/A:1022648800760 and author PDF: https://www.schapire.net/papers/strengthofweak.pdf. Checked for weak-to-strong boosting and the fact that the generic boosted hypothesis is representation-independent/improper.
- Pitt and Valiant, "Computational Limitations on Learning from Examples" (1988), JACM record/DOI: https://doi.org/10.1145/48014.63140. Checked as the classical proper-learning hardness anchor.
- Khot and Saket, "Hardness of Minimizing and Learning DNF Expressions" (FOCS 2008), DOI: https://doi.org/10.1109/FOCS.2008.37. Checked for constant-advantage DNF proper-learning hardness.
- Håstad and Khot, "Query Efficient PCPs with Perfect Completeness" (2005), Theory of Computing page: https://theoryofcomputing.org/articles/v001a007/. Checked for logarithmic-randomness perfect-completeness PCPs with soundness below $1/2$.
- Kearns and Valiant, "Cryptographic Limitations on Learning Boolean Formulae and Finite Automata" (JACM 1994), DOI: https://doi.org/10.1145/174644.174647 and PDF: https://www.cis.upenn.edu/~mkearns/papers/cryptojacm.pdf. Checked as a cryptographic learning-hardness anchor.
- Håstad, Impagliazzo, Levin, and Luby, "A Pseudorandom Generator from any One-Way Function" (SIAM J. Comput. 1999), DOI: https://doi.org/10.1137/S0097539793244708. Checked for the standard one-way-function-to-pseudorandomness route behind possible dense cryptographic witnesses.

### Theorem Route

The most direct positive attempt is:

1. Run the source learner to get an improper $h$ with very small $P$-error against the realizable target $c$.
2. Use samples, $h$, or both to find some proper $c'\in\mathcal C$ with nontrivial $P$-agreement with $c$.

The second step is exactly the missing computational properization step. Information-theoretically, the target concept itself has zero error. For a finite sample, an unbounded search over $\mathcal C$ could find a consistent proper hypothesis. But the target is computational: it asks for a uniform polynomial-time algorithm, with only the polynomial allowed to depend on $P$. The source learner may be efficient precisely because it uses an outside representation that avoids a hard search problem over $\mathcal C$.

Boosting also does not prove the edge. Schapire-style boosting converts weak predictors into a strong predictor by composing/voting over hypotheses, but the final predictor is generally improper. Here we already have a strong improper predictor; the missing operation is not accuracy amplification but projection into $\mathcal C$.

The marginal-nonuniform sample-complexity results checked are likewise not enough. They explain distribution-sensitive rates and, in sample-only settings, can support proper ERM by exhaustive search. They do not provide a polynomial-time proper ERM or projection algorithm for an arbitrary represented concept class.

Conclusion for the theorem route: no checked source gives

$$
\text{efficient marginal-nonuniform strong improper realizable learning}
\Rightarrow
\text{efficient marginal-nonuniform weak proper realizable learning}.
$$

A positive result would need a new structural condition on $\mathcal C$ or on the marginal $P$, not just the current source definition.

### Counterexample Route

The distribution-free PCP active-slice witness separates `efficient-realizable-improper-pac` from `efficient-weak-realizable-proper-pac` under $\mathrm{NP}\nsubseteq\mathrm{RP}$. It therefore looks like the closest non-cryptographic false route. The construction puts a fixed NP instance $\varphi$ on an active PCP slice, labels every verifier-randomness point by $1$, and observes that a weak proper learner would output a proof accepted on more than half of the random strings.

This does not transfer to the present marginal-nonuniform target. If the reduction chooses the marginal $P_\varphi$ depending on the input instance $\varphi$, the target only supplies a polynomial $p_{P_\varphi}$ whose constants and degree may depend on the whole marginal, hence on $\varphi$. That does not yield a uniform randomized polynomial-time algorithm for the NP language. Packing all instance slices into one fixed marginal $P^\star$ causes dilution: exponentially many formulas of length $n$ cannot each receive inverse-polynomial mass, so a global weak advantage $1/\operatorname{poly}(s)$ need not imply any detectable local advantage on the hard slice.

The one-way image-coordinate witness resolves the stronger proper target edge

$$
\texttt{efficient-marginal-nonuniform-realizable-improper-pac}
\not\Rightarrow
\texttt{efficient-marginal-nonuniform-realizable-proper-pac}
$$

under length-preserving one-way functions, but it does not resolve this weak target. In that witness, the fixed marginal gives the length-$n$ block mass $\mu_n=\Theta(1/n^2)$, and a strong proper learner run at accuracy $\varepsilon_n\ll \mu_n/n$ must recover a seed $t$ with $f(t)=f(s)$. A weak proper learner is not forced to do that. The concepts are sparse across length blocks: a wrong-length proper concept with sufficiently small own block can already have error roughly $\mu_n/2+\mu_m/2$, far below $1/2$ by a constant for the usual mixture. Thus weak global advantage can be achieved without inverting the function.

The Pitt-Valiant and Khot-Saket DNF routes are also near misses. They are proper-learning hardness results, and Khot-Saket gives constant-advantage hardness for restricted DNF outputs, but the atlas target permits any inverse-polynomial advantage and a marginal-dependent polynomial. The local sibling scratchpads already note that fixed-$k$ DNF has Schapire-style inverse-polynomial weak proper learners, so constant-advantage hardness cannot by itself refute this weak node.

I also considered a denser cryptographic variant of the image-coordinate idea: put the bits of a one-way image or pseudorandom-generator output on a common high-mass prefix rather than on a low-mass length block. An improper learner could memorize high-mass coordinates, while a proper learner might have to output a seed whose image/codeword correlates with the observed labels. This is the most promising false direction I found, but it is not atlas-ready. The construction must simultaneously ensure:

- distribution-free strong improper learning with sample/time polynomial in the representation size;
- one fixed marginal with enough mass on the hard coordinates for every representation size;
- weak proper error below $1/2-1/\operatorname{poly}(s)$ forces computationally meaningful correlation with the hidden image;
- random or pseudorandom labels do not admit an efficiently findable correlated proper seed by overfitting the sampled coordinates;
- the stretch, random-access evaluation, and representation-size accounting survive an arbitrary target learner's unknown polynomial runtime and unknown weak advantage.

I did not find a primary theorem that supplies this exact "find a correlated range element under a fixed marginal" hardness statement.

### Concrete Obstruction

Two obstructions meet here.

First, marginal-nonuniformity shields instance-dependent reductions:

$$
\forall P\ \exists p_P,\gamma_P\ \forall c.
$$

A lower bound that changes the marginal with the hard input usually loses the uniform polynomial-time contradiction, because $p_P$ may depend arbitrarily on that input-coded marginal. A lower bound using one fixed marginal must keep infinitely many hard instances visible with enough probability mass.

Second, the target is only weak. Strong proper lower bounds can force exact recovery by asking for $\varepsilon$ below a block's coordinate mass. Weak proper learning only needs some global advantage over $1/2$. Sparse active-block witnesses often become easy at this threshold, because a harmless proper hypothesis can ignore the hard block and still beat random guessing globally.

So a valid false witness must be dense enough that weak advantage reveals hard information, yet simple enough that strong improper memorization remains efficient for arbitrary marginals. The checked PCP, DNF, and one-way-coordinate witnesses each satisfy only part of this requirement.

### Promising Next Directions

1. Develop the dense cryptographic-prefix idea. A plausible target is a random-access PRG/codeword class where improper learning memorizes a polynomial-size high-mass prefix, but any proper weak learner under one fixed marginal yields a seed with inverse-polynomial correlation to a hidden pseudorandom image. The main technical task is matching stretch and representation size to an unknown learner polynomial.
2. Search specifically for fixed-marginal weak proper lower bounds, not distribution-free lower bounds whose hard distribution varies with the input. Useful keywords: fixed distribution proper PAC hardness, weak proper learning, inverse-polynomial advantage, correlated preimage, and proper learning under a single marginal.
3. Try a sparse or padded hard-language construction that gives one hard slice per length enough mass under a fixed marginal. This must confront sparse NP-hardness barriers if the goal is an NP/RP contradiction.
4. Formalize positive cases for effectively finite marginals. If the support portion relevant at size $s$ is bounded by a $P$-dependent polynomial and proper ERM over the induced trace is searchable, then marginal-nonuniform weak properization may hold locally.
5. Keep the edge open until one of the above routes produces either a generic polynomial-time properization theorem or a fixed-marginal counterexample whose weak advantage really forces hard proper search.

## Depth-2 Entry - 2026-05-05

### Verdict

Still `unresolved`; keep the atlas edge `open` with `evidence: unknown`.

Depth 2 sharpened both requested directions but did not resolve the edge.

The one-way image-coordinate witness does not force weak proper error below $1/2$. Its fixed marginal can force exact image recovery only when the proper learner is run at a strong accuracy level below the mass of a single coordinate. At the weak threshold, a wrong-length proper concept can ignore the hard length-$n$ block and still have error far below $1/2$ for the usual block-mixture marginal.

The PCP active-slice witness does satisfy the strong improper realizable source: every target concept has positives only on one polynomial-size active slice, so the usual positive-atom memorization learner gives distribution-free arbitrary-accuracy improper learning. But this does not give a marginal-nonuniform false edge. The proper lower-bound reduction still needs the marginal to focus on the input-dependent slice, or else the PCP gap is diluted in a fixed universal marginal.

No exact atlas changes are justified.

### Sources Checked

Local atlas and scratchpad material rechecked:

- `atlas/definitions/efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- sibling scratchpad `efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac/scratchpad.md`
- sibling scratchpad `efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`
- sibling scratchpad `efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac/scratchpad.md`

Primary or near-primary sources checked:

- Hanneke, Moran, and Thiessen, *Marginal-Nonuniform PAC Learnability*, OpenReview/PDF: https://openreview.net/forum?id=aoVCFtox89. Used for the quantifier order: the rate may depend on the marginal, but after fixing that marginal it must hold uniformly over concepts.
- Håstad and Khot, *Query Efficient PCPs with Perfect Completeness*, Theory of Computing page: https://theoryofcomputing.org/articles/v001a007/. Used for logarithmic randomness, perfect completeness, and soundness below $1/2$ in the active-slice template.
- Kearns and Valiant, *Cryptographic Limitations on Learning Boolean Formulae and Finite Automata*, JACM/PDF: https://www.cis.upenn.edu/~mkearns/papers/cryptojacm.pdf. Used as the cryptographic learning-hardness anchor.
- Håstad, Impagliazzo, Levin, and Luby, *A Pseudorandom Generator from any One-way Function*, SIAM J. Comput. DOI page: https://doi.org/10.1137/S0097539793244708. Used as the standard one-way-function/PRG background for possible dense cryptographic variants.
- Schapire, *The Strength of Weak Learnability*, DOI/PDF: https://doi.org/10.1023/A:1022648800760 and https://www.schapire.net/papers/strengthofweak.pdf. Used to check that weak-to-strong boosting remains an improper aggregation route, not a properization theorem.
- Pitt and Valiant, *Computational Limitations on Learning from Examples*, DOI: https://doi.org/10.1145/48014.63140. Used as a classical proper-learning hardness comparison.
- Khot and Saket, *Hardness of Minimizing and Learning DNF Expressions*, DOI: https://doi.org/10.1109/FOCS.2008.37. Used as a constant-advantage weak proper near miss, still not an inverse-polynomial weak lower bound for this edge.

### Theorem Route

The positive route remains the same generic properization problem:

1. Run the strong marginal-nonuniform improper learner at a fixed marginal $P$ to get an accurate polynomially evaluable hypothesis $h$.
2. Find, in polynomial time, some proper $c'\in\mathcal C$ with nontrivial $P$-agreement with the true target $c$.

The first step is supplied by the source. The second step is not supplied by the source or by the checked literature. Sample-only reasoning says a good proper concept exists, namely the target itself, and unbounded ERM over $\mathcal C$ would find one on a finite sample. The target node is computational, so existence and finite-sample control are not enough.

Boosting does not repair this. Schapire-style boosting can turn weak predictors into an accurate vote, and here the source is already strong, but the vote or memorized table is generally outside $\mathcal C$. The operation needed here is not amplification; it is polynomial-time projection into the represented class.

Conclusion for the theorem route: no generic theorem checked at Depth 2. A positive result would need an additional hypothesis such as efficient proper ERM, approximate projection, or a finite searchable trace for each fixed marginal.

### Counterexample Route

#### One-Way Image-Coordinate Route

The strong proper version of the one-way image-coordinate witness works because the learner can be run at accuracy

$$
\varepsilon_n \ll \frac{\mu_n}{n},
$$

where $\mu_n$ is the fixed marginal mass of the length-$n$ coordinate block. Then any proper hypothesis with low enough error must have the right length and every image bit correct, yielding a preimage of the challenge $y=f(s)$.

For weak proper learning, this forcing disappears. Let the target be $c_s$ of length $n$ and let a wrong-length proper hypothesis be $c_t$ of length $m\ne n$. In the standard construction, $c_s$ is positive on half of the length-$n$ block and zero elsewhere, while $c_t$ is positive on half of the length-$m$ block and zero elsewhere. Their disagreement is

$$
\operatorname{err}_P(c_t,c_s)=\frac{\mu_n}{2}+\frac{\mu_m}{2}
$$

when the active blocks are disjoint. Since $\sum_k \mu_k=1$, a fixed marginal has infinitely many small blocks. For large $n$, and especially by choosing a small-mass wrong block $m$, this error is well below $1/2$ for typical choices such as $\mu_k=\Theta(1/k^2)$. Thus a weak proper learner can meet

$$
\operatorname{err}_P(h,c_s)\le \frac12-\gamma_P(n)
$$

without matching $f(s)$ at all.

The obstruction is not an artifact of $\Theta(1/k^2)$ weights. To force every wrong-length hypothesis above the weak threshold, one would need roughly

$$
\frac{\mu_n}{2}+\inf_{m\ne n}\frac{\mu_m}{2} > \frac12-\gamma_P(n),
$$

and since $\inf_m\mu_m=0$ for any fixed marginal over infinitely many length blocks, this essentially requires $\mu_n>1-2\gamma_P(n)$. A single fixed marginal cannot give near-unit mass to every length $n$.

This rules out the current one-way image-coordinate witness as a weak-target counterexample. It also explains why the dense cryptographic-prefix variant is nontrivial: the hard bits must live on common high-mass coordinates, but then the source learner must still be able to learn arbitrary-accuracy improper hypotheses efficiently for every marginal.

#### PCP Active-Slice Route

The PCP active-slice class does meet the stronger improper source. For a proper concept indexed by $(\varphi,\pi)$, examples outside the $\varphi$ slice are labeled $0$, and examples on the active slice are labeled by the verifier $V(\varphi,\pi,r)$. The verifier has logarithmic randomness, so the active slice has polynomially many random strings in $|\varphi|$. Therefore a distribution-free improper learner can record observed positive atoms and predict $0$ elsewhere. With polynomially many samples in the representation size and $1/\varepsilon$, all positive atoms of mass at least $\varepsilon/R$ are seen with high probability, where $R=\operatorname{poly}(|\varphi|)$ is the active-slice size; the unseen positives have total mass at most $\varepsilon$.

So the strong source is not the problem. The problem is the marginal-nonuniform weak proper lower bound.

If the reduction on input $\varphi$ uses the uniform marginal on the active slice $\{(\varphi,r)\}$, then satisfiable $\varphi$ is realizable by a proof accepted with probability $1$, while unsatisfiable $\varphi$ has every proper proof accepted with probability at most $s<1/2$. A weak proper learner would decide the language. But this marginal is $P_\varphi$, and the target definition permits both $p_{P_\varphi}$ and $\gamma_{P_\varphi}$ to depend on that whole marginal. The reduction no longer obtains a uniform randomized polynomial-time algorithm for NP.

If instead one fixes a universal marginal $P^\star$ over all slices, each slice $\varphi$ receives weight $w_\varphi$. The local PCP gap contributes only about

$$
w_\varphi(1/2-s)
$$

to the global error gap. For exponentially many formulas of length $n$, most $w_\varphi$ must be exponentially small. The target's weak advantage only promises some inverse-polynomial $\gamma_{P^\star}(s)$, so the global weak guarantee need not reveal anything about the selected slice.

Packing slices by length rather than by formula does not by itself fix this. A proper hypothesis can choose a different active instance, and forcing it to choose the encoded input under one fixed marginal consumes probability mass before the PCP gap is even used. The same mass-budget obstruction from the weak agnostic scratchpad reappears: the construction must both identify the intended instance and leave enough mass on the PCP checks to cross a $1/2-\gamma$ threshold.

### Concrete Obstruction

The edge is blocked by a combined weak-threshold and marginal-nonuniform mass-budget problem.

For the one-way image-coordinate witness, strong proper learning can demand tiny $\varepsilon$ and thereby force exact recovery on a small block. Weak proper learning cannot: unless the hard block has nearly all the fixed marginal mass, a wrong proper concept can ignore the hard image and still beat random guessing globally.

For the PCP active-slice witness, the class is source-valid even for strong improper learning, but the lower bound is not target-valid. An input-dependent active-slice marginal is neutralized by the quantifier

$$
\forall P\ \exists p_P,\gamma_P\ \forall c,
$$

while a fixed marginal over all slices dilutes each hard slice below the inverse-polynomial weak advantage that the target may choose.

Thus a false witness must be denser than the current one-way and PCP slice constructions. It must place hard information on fixed, polynomially visible mass for infinitely many representation sizes, while preserving an efficient arbitrary-accuracy improper learner for every marginal. I do not have such a construction.

### Next Directions

1. Try to prove a small "block-mass lemma" for sparse-block witnesses: if each target's support lies in a block of mass $\mu_s=o(1)$ and there are proper hypotheses with disjoint small blocks, then the class cannot refute weak proper learning because some wrong-block proper hypothesis has error below $1/2-1/\operatorname{poly}(s)$.
2. Explore dense cryptographic classes where target labels encode $f(s)$ or a PRG/codeword on a common high-mass coordinate set. The required hardness statement is not inversion from exact recovery, but inverse-polynomial correlation with a hidden range element under a fixed marginal.
3. For the PCP route, look for a fixed-marginal PCP/CSP formulation where the hard instance is encoded in labels or target concepts rather than in the marginal, and where wrong-instance proper hypotheses are ruled out without spending most of the probability mass.
4. Search specifically for fixed-distribution weak proper lower bounds with inverse-polynomial advantage. Distribution-free strong proper lower bounds and active-slice reductions remain near misses unless they control the marginal-dependent polynomial and advantage uniformly.
5. Keep this edge open unless one of the above yields either a real polynomial-time properization theorem or a fixed-marginal counterexample whose weak advantage provably forces hard proper search.

## Depth-3 Entry - 2026-05-05

### Verdict

Still `unresolved`; keep the atlas edge `open` with `evidence: unknown`.

The one-way image-coordinate weak-handle construction cannot refute this edge as stated. It does satisfy the source, and in fact satisfies a stronger distribution-free strong improper realizable guarantee after adding a simple validation step. But the same handles make the target true rather than false: constants and singleton-positive-atom concepts give an efficient proper weak learner under every marginal.

So this lead fails in a precise way. Proper weak handles are useful for separating weak proper learning from strong proper learning, but they defeat any lower bound whose target is already weak proper. No exact atlas changes are justified at this depth.

### Sources Checked

- Current scratchpad Depth 1 and Depth 2 entries for this edge.
- `atlas/definitions/efficient-marginal-nonuniform-realizable-improper-pac.md`.
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`.
- `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`.
- `atlas/witnesses/one-way-image-coordinate-class.md`.
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`.
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`.
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`.
- Sibling scratchpad `scratchpads/open-edge-resolution-2026-05-04/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac/scratchpad.md`, especially the Depth-2 weak-handle construction.
- Kearns and Valiant, *Cryptographic Limitations on Learning Boolean Formulae and Finite Automata* (JACM 1994), used as the one-way-function learning-hardness anchor.
- Håstad, Impagliazzo, Levin, and Luby, *A Pseudorandom Generator from any One-way Function* (SIAM J. Comput. 1999), used only for the standard one-way-function/PRG background.
- Hanneke, Moran, and Thiessen, *Marginal-Nonuniform PAC Learnability* (NeurIPS 2025), used for the quantifier order: one learner, marginal-dependent polynomial and advantage.
- Schapire, *The Strength of Weak Learnability* (1990), used again as a check that boosting does not preserve proper representation.

### Theorem Route

The weak-handle construction does not give a generic theorem for this edge. It proves a class-specific fact:

$$
\text{image-coordinate class} + \{0,1,\text{singletons}\}
\in
\texttt{efficient-marginal-nonuniform-weak-realizable-proper-pac}.
$$

That is not a properization theorem from an arbitrary strong improper learner. It works only because the class was enlarged with explicit proper concepts that are easy to find from samples.

For the bare edge, the positive route still needs a computational projection step. The source can output a polynomially evaluable hypothesis outside $\mathcal C$ with arbitrarily small $P$-error. Nothing in the source says that constants, singletons, finite positive atoms, or any other useful weak handles belong to $\mathcal C$. Nor does it give an efficient way to search for a proper concept with nontrivial agreement. Thus the theorem route remains blocked at the same representation-sensitive step:

$$
\text{accurate improper predictor}
\not\Rightarrow
\text{efficiently findable proper weak predictor}.
$$

### Counterexample Route

The attempted adaptation starts with the one-way image-coordinate class. For a length-preserving one-way function $f$, a seed $s\in\{0,1\}^n$ defines

$$
c_s(1^k,i,b)=1
\quad\Longleftrightarrow\quad
k=n \text{ and } b=f(s)_i.
$$

The original class already satisfies the strong improper source. For a target $c_s$, the positive set has only $n$ atoms. An improper learner can record observed positive atoms and predict $0$ elsewhere; all unseen positive mass is made at most $\varepsilon$ with polynomially many samples.

Now add the weak handles:

$$
\mathcal C'
=\{c_s:s\in\{0,1\}^*\}
\cup\{0,1\}
\cup\{\mathbf 1_a:a\in X\}.
$$

This enlarged class still satisfies the source. For image-coordinate targets and singleton targets, positive-atom memorization gives arbitrary accuracy. For the all-zero and all-one targets, include the two constant hypotheses as candidates. A uniform improper learner can build the memorizer, constants, and observed singleton candidates, then use a fresh validation sample to select one with empirical error near the best candidate. This gives distribution-free strong realizable improper learning, hence the marginal-nonuniform source.

But the lower bound now collapses because $\mathcal C'$ is weak properly learnable.

For an image-coordinate target $c_s$ of length $n$, let

$$
M=P(c_s^{-1}(1)).
$$

The all-zero handle has error $M$, the all-one handle has error $1-M$, and a singleton on a heaviest positive atom has error at most $M(1-1/n)$. Therefore

$$
\min\{1-M,\ M(1-1/n)\}
\le
\frac{n-1}{2n-1}
<
\frac12-\frac{1}{4n}
\quad(n\ge 2).
$$

Samples find the needed handle: if constants are good, validation selects one; if the singleton route is needed, a positive atom with mass comparable to the heaviest positive atom appears with polynomially many samples. Handle targets are also weakly easy. Constants are learned exactly by validation, and for a singleton $\mathbf 1_a$, either $0$ already has error bounded below $1/2$ or the atom $a$ has enough mass to be observed and output.

This directly refutes the attempted counterexample. Under the fixed image-coordinate marginal $P^\star$ with length-block mass $\mu_n=\Theta(1/n^2)$, a strong proper learner at accuracy $\varepsilon_n\ll \mu_n/n$ must output a seed preimage. A weak proper learner does not. The all-zero handle alone has error

$$
\operatorname{err}_{P^\star}(0,c_s)=\mu_n/2=\Theta(1/n^2),
$$

which is far below $1/2$. If the marginal is instead concentrated on the active length-$n$ block to remove this escape, a positive singleton has error

$$
\frac{n-1}{2n}
=
\frac12-\frac{1}{2n}.
$$

Thus the handles defeat both the sparse fixed-marginal lower bound and the dense active-block variant. The proper learner can win weakly without outputting any seed and without learning anything cryptographically meaningful about $f^{-1}(y)$.

I also checked the natural repair: do not add handles to $\mathcal C$, but try to force weak proper hardness using a coded image-coordinate target. Replace $f(s)$ by a polynomial-length error-correcting code $E(f(s))$, so that any seed whose proper concept has agreement above $1/2+\gamma$ with the target should determine the same image. This still is not atlas-ready. If the code has relative distance $1/2-\eta(n)$, then weak error $1/2-\gamma_P(n)$ forces equality only when $\gamma_P(n)>\eta(n)$. The target definition may choose an arbitrarily small inverse-polynomial advantage for the fixed marginal. Making $\eta(n)$ smaller than every inverse polynomial requires superpolynomial-length binary codes by the usual rate-distance tradeoff, which breaks the polynomial positive-support/memorization argument and no longer gives a polynomial-time inversion reduction in the original seed length.

So the coded variant remains a possible new witness only under a stronger, carefully parameterized cryptographic/coding assumption. It is not a consequence of the existing one-way image-coordinate weak-handle argument.

### Concrete Obstruction

The obstruction is that weak proper learning asks only for some inverse-polynomial advantage, not for recovery of the hard representation.

In the strong lower bound, the accuracy parameter can be set below the mass of one coordinate:

$$
\varepsilon_n \ll \mu_n/n.
$$

That forces a proper hypothesis to match every image coordinate and therefore to invert $f$. In the weak target there is no $\varepsilon$ input. Once constants and singletons are proper concepts, they supply hypotheses with error $1/2-\Omega(1/n)$ or better for every marginal. Those hypotheses intentionally avoid the hard seed-search problem.

This is not a minor proof gap. The weak handles are exactly an efficient proper weak learner. They cannot be used as auxiliary gadgets in a counterexample to weak proper learnability unless they are withheld from the proper concept class; but if they are withheld, the argument no longer explains why every proper weak learner must recover a seed rather than find a merely correlated seed.

### Next Directions

1. Keep the current edge open. The weak-handle construction resolves the sibling weak-proper-to-strong-proper edge, not this incoming improper-to-weak-proper edge.
2. If pursuing a false witness, abandon proper weak handles. The hard class must satisfy the strong improper source using only improper hypotheses, while making every proper concept that beats $1/2$ by inverse polynomial reveal hard information.
3. Develop the coded image-coordinate route only if the parameters are explicit: polynomial coordinate length, efficient random-access evaluation, positive support polynomial in representation size, and a proof that any inverse-polynomial weak advantage yields an invertible amount of information.
4. Search for a stronger primitive than ordinary one-wayness, such as hardness of finding any range element with inverse-polynomial correlation to a hidden codeword under a fixed marginal. This is the exact missing statement.
5. A useful interim atlas note, if edits are later allowed, would say that `one-way-image-coordinate-weak-handle-class` is a non-witness for this edge because its handles satisfy the weak proper target.

## Depth-4 Entry - 2026-05-05

### Verdict

Still `unresolved`; keep the atlas edge `open` with `evidence: unknown`.

Depth 4 pursued the requested lead: hide every explicit weak handle while preserving strong improper realizable learnability. The best new candidate is a parity-of-image variant. For a single fixed input length it has exactly the right shape: an improper learner can recover the image string by linear algebra, while any proper hypothesis with even tiny positive advantage under the uniform parity marginal must output a preimage. But turning this into an atlas witness for all representation sizes requires one fixed marginal over finitely encoded examples that behaves like a common product distribution for every length. I do not see a valid construction of that kind.

So the edge is not resolved. The lead sharpens the obstruction: weak handles need not be explicit constants or singletons. They can also appear as length padding, finite-code residual correlations, or off-prefix agreement created when a globally balanced hard marginal is forced back into finite encoded examples.

No exact atlas changes are justified.

### Sources Checked

- Current Depth 1--3 entries in this scratchpad.
- `atlas/definitions/efficient-marginal-nonuniform-realizable-improper-pac.md`.
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`.
- `atlas/README.md`, especially the convention that computationally efficient nodes use worst-case/pathwise bounds on finite encoded sample transcripts.
- `atlas/witnesses/one-way-image-coordinate-class.md`.
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`.
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`.
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`.
- Sibling scratchpad `efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`, especially the fixed-marginal balanced-code discussion.
- Kearns and Valiant, *Cryptographic Limitations on Learning Boolean Formulae and Finite Automata*, JACM 1994, DOI https://doi.org/10.1145/174644.174647.
- Håstad, Impagliazzo, Levin, and Luby, *A Pseudorandom Generator from any One-Way Function*, SIAM J. Comput. 1999, DOI https://doi.org/10.1137/S0097539793244708.
- Goldreich and Levin, *A Hard-Core Predicate for all One-Way Functions*, STOC 1989, DOI metadata https://doi.org/10.1145/73007.73010 and Goldreich's paper page https://www.wisdom.weizmann.ac.il/~oded/gl.html. Used for the parity/hard-core intuition and the fact that random linear queries can concentrate search hardness.
- Standard coding-bound background, especially the Plotkin/Elias-Bassalygo style rate-distance barrier near relative distance $1/2$. Used only for the qualitative warning that polynomial-length binary codes with exponentially many messages cannot make all unintended correlations smaller than every inverse polynomial.
- Schapire, *The Strength of Weak Learnability*, 1990, DOI https://doi.org/10.1023/A:1022648800760. Rechecked only to confirm that boosting remains an improper aggregation theorem, not a proper projection theorem.

### Theorem Route

The positive theorem route remains blocked at proper projection.

Given the source learner at a fixed marginal $P$, we can obtain an arbitrary-accuracy polynomially evaluable hypothesis $g$. To prove the target, we would still need a uniform polynomial-time procedure that converts the information in samples and $g$ into some represented concept $c'\in\mathcal C$ with

$$
\operatorname{err}_P(c',c)\le \frac12-\gamma_P(s).
$$

The hidden-handle investigation does not produce such a procedure. It instead clarifies why a theorem cannot be obtained just by saying that a weak handle exists information-theoretically. The target concept itself is a perfect proper handle, but finding any proper weak handle may encode the hard representation search.

The parity-of-image thought experiment is the cleanest illustration. Suppose a seed $s\in\{0,1\}^n$ defines labels

$$
c_s(r)=\langle f(s),r\rangle \pmod 2
$$

on random $r\in\{0,1\}^n$. From labeled examples, an improper learner can recover some vector $y$ consistent with the observed linear equations and output the parity $r\mapsto\langle y,r\rangle$. Uniform convergence over the $2^n$ parity vectors, or direct linear-algebra analysis, gives efficient strong improper realizable learning for this length-specific problem. But a proper learner must output a seed $t$, and under the uniform marginal over $r$, any $f(t)\ne f(s)$ gives exactly error $1/2$.

This shows that the theorem route is genuinely representation-sensitive: the improper learner can learn the easy external representation $y=f(s)$, while the proper learner must invert $f$. However, this is only a length-specific fixed-marginal story so far, not a marginal-nonuniform atlas theorem or counterexample over one finitely encoded instance space.

### Counterexample Route

The goal was to hide all weak handles while keeping strong improper realizable learning. I checked three versions.

First, simply deleting constants and singletons from the weak-handle image-coordinate class does not work. It returns to the sparse-block witness from Depth 1--2. Under the fixed marginal with block masses $\mu_n$, a wrong-length proper concept has small global error because both the target block and the wrong block have small mass. The weak handle is no longer an explicit constant or singleton, but the wrong-length concept itself becomes the handle.

Second, replace sparse image coordinates by a polynomial-length balanced code $E(f(s))$. If every nonmatching proper seed had distance at least $1/2-\eta(n)$ from the target under the fixed marginal, then weak advantage greater than $\eta(n)$ would force a preimage. But the target is allowed to choose an arbitrary inverse-polynomial advantage $\gamma_P(n)$. To rule out every non-inverting proper hypothesis as a hidden weak handle, the residual correlation $\eta(n)$ must be smaller than every inverse polynomial. Standard binary-code rate-distance bounds make that incompatible with a polynomial-length code carrying $2^n$ possible images. With polynomial length, some inverse-polynomial slack remains available, and that slack is precisely where a hidden weak handle may live.

Third, the parity-of-image candidate avoids the finite-code residual-correlation problem at a fixed length. Distinct parity functions are exactly orthogonal under the uniform marginal on $\{0,1\}^n$, so any proper weak advantage forces $f(t)=f(s)$. The source side is also attractive: improper learning parities is efficient by Gaussian elimination and sample validation, even under arbitrary marginals on the $n$-bit domain.

The problem is globalizing the marginal. The atlas edge needs one concept class over finitely encoded examples and one fixed hard marginal $P^\star$ for the lower-bound contradiction. If we put each length $n$ on a disjoint block with mass $\mu_n$, the old dilution returns: nonmatching concepts can agree off the active block and get global error far below $1/2$. If we instead imagine one common infinite product marginal, then every finite parity has full variance and the construction looks separated, but examples are no longer finitely encoded sample transcripts in the atlas sense. If we approximate the infinite product marginal by finite strings with a length tail, then the part of the sample carrying $n$ fresh random bits has tail mass, and agreement on the complement again becomes a hidden weak handle unless the construction explains how short examples still carry balanced $n$-bit linear measurements.

Thus the parity route is a near miss, not an atlas-ready counterexample. It identifies the missing object very precisely: a finitely encoded fixed marginal that supplies, for every representation size $n$, enough common high-mass random linear measurements to make all nonmatching proper concepts have error exactly $1/2$, while still permitting a polynomial-time improper learner to recover the external image representation.

### Concrete Obstruction

The sharpened obstruction is a trilemma.

1. To refute weak proper learning, every efficiently findable non-inverting proper hypothesis must have error at least

$$
\frac12-\operatorname{negl}(s),
$$

because the target learner may certify an arbitrarily small inverse-polynomial advantage.

2. To preserve strong improper realizable learning by memorization or linear reconstruction, the hard labels must be learnable from polynomially many finitely encoded samples for every marginal. Sparse supports and polynomial coordinate sets satisfy this, but they create weak handles through off-support agreement or residual inverse-polynomial code correlations.

3. To avoid those handles, the fixed hard marginal must make each target globally balanced against all wrong proper concepts. The natural way is a common product distribution over all coordinates, as in parity/Hadamard measurements. But a literal common product source gives infinite examples, while finite encodings reintroduce either length-block mass decay or an unexplained feature map that must simulate fresh $n$-bit randomness for all $n$ from one fixed finite distribution.

This is stronger than the earlier "block mass" obstruction. Even when hard information is placed in the target labels rather than in an input-dependent marginal, hiding explicit handles forces a balance condition so strong that the source-side improper learner loses its simple polynomial sample argument, unless one can produce a new global finite-encoding trick.

### Next Directions

1. Try to formalize the parity-of-image construction as a separate conditional lemma in an idealized model with infinite product examples. This would isolate exactly which finite-encoding axiom prevents the atlas separation.
2. Search for a finitely encoded universal feature distribution whose pushforward gives near-uniform $n$-bit linear measurements for every $n$ without length-tail dilution. This is the key missing ingredient for the parity route.
3. If such a distribution exists, prove the full source side under arbitrary marginals: the learner should use linear constraints plus validation to output an improper parity predictor with arbitrary accuracy.
4. If no such distribution can exist, turn the obstruction into a lemma: any finite-encoded fixed marginal that exposes $n$ independent balanced bits only on a tail event creates a hidden weak handle of size at least the complement agreement.
5. Keep the atlas edge open. If the parity route is later made finite and rigorous, the likely atlas update would set the edge to `status: "false"`, `evidence: conditional-counterexample`, add a new parity-of-image witness, cite Kearns-Valiant and Goldreich-Levin, and use the assumption that length-preserving one-way functions exist.

### Exact Atlas Changes If Resolved

None. This depth did not resolve the edge, and this task forbids atlas edits.

## Depth-5 Entry - 2026-05-05

### Final Verdict

Final depth verdict: `unresolved`.

Keep the atlas edge

$$
\texttt{efficient-marginal-nonuniform-realizable-improper-pac}
\to
\texttt{efficient-marginal-nonuniform-weak-realizable-proper-pac}
$$

as `status: "open"` with `evidence: unknown`.

I do not have an atlas-ready proof of the implication, and I do not have an atlas-ready counterexample. The strongest false route is still the parity-of-image idea, but the final finite-encoding attempt exposes a missing measure-theoretic/combinatorial ingredient rather than a construction. No atlas file should be changed on the basis of this scratchpad.

### Sources Checked

Local files and prior entries checked:

- This scratchpad, Depth 1 through Depth 4.
- `atlas/definitions/efficient-marginal-nonuniform-realizable-improper-pac.md`.
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`.
- `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`.
- `atlas/README.md`, for the finite encoded transcript convention used by the computational nodes.
- `atlas/arguments/properization-open.md`.
- `atlas/arguments/marginal-boosting-open.md`.
- `atlas/arguments/marginal-uniformization-open.md`.
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`.
- `atlas/witnesses/one-way-image-coordinate-class.md`.
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`.
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`.
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`.
- `atlas/witnesses/pcp-active-slice-lookup-class.md`.
- Sibling scratchpad `efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`.
- Sibling scratchpad `efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac/scratchpad.md`.
- Sibling scratchpad `efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac/scratchpad.md`.

Primary or near-primary external sources checked:

- Hanneke, Moran, and Thiessen, *Marginal-Nonuniform PAC Learnability*, OpenReview/PDF, for the quantifier order: one learner, with rates depending on the marginal but uniform over concepts once the marginal is fixed.
- Benedek and Itai, *Learnability with respect to fixed distributions*, for fixed-distribution background.
- Ben-David, Benedek, and Mansour, *A Parameterization Scheme for Classifying Models of PAC Learnability*, for the classical uniformity-parameter viewpoint.
- Schapire, *The Strength of Weak Learnability*, for weak-to-strong boosting and the fact that the generic boosted hypothesis is representation-independent rather than proper.
- Pitt and Valiant, *Computational Limitations on Learning from Examples*, for classical proper-learning hardness.
- Khot and Saket, *Hardness of Minimizing and Learning DNF Expressions*, for constant-advantage proper DNF hardness and why it is still not the inverse-polynomial marginal-nonuniform weak separation needed here.
- Håstad and Khot, *Query Efficient PCPs with Perfect Completeness*, for the active-slice PCP route.
- Kearns and Valiant, *Cryptographic Limitations on Learning Boolean Formulae and Finite Automata*, for cryptographic learning-hardness context.
- Håstad, Impagliazzo, Levin, and Luby, *A Pseudorandom Generator from any One-Way Function*, for the standard one-way-function to pseudorandomness background.
- Goldreich and Levin, *A Hard-Core Predicate for all One-Way Functions*, for the parity/hard-core intuition behind the final parity-of-image lead.
- Standard Rademacher/Walsh-system references checked during the final lead, mainly to test whether a countable finite-encoding substitute for an infinite product space could supply common balanced parity queries.
- Targeted web searches for "fixed distribution proper learning weak PAC hardness", "weak proper learning fixed distribution", and related variants. I did not find a known theorem matching this exact marginal-nonuniform weak properization edge.

### Theorem Route

The positive route remains blocked by efficient properization.

The source gives a uniform algorithm that, for each fixed marginal $P$, can output an arbitrary polynomially evaluable hypothesis $g$ with

$$
\operatorname{err}_P(g,c)\le \varepsilon
$$

for every target $c\in\mathcal C$. The target asks for a uniform polynomial-time algorithm that outputs some represented concept $h\in\mathcal C$ with

$$
\operatorname{err}_P(h,c)\le \frac12-\gamma_P(s).
$$

The missing step is not accuracy. It is representation search:

$$
\text{accurate improper predictor}
\quad\Longrightarrow?\quad
\text{efficiently findable proper weak predictor}.
$$

Information-theoretically, the target concept itself is a perfect proper hypothesis. With unbounded computation, an exhaustive proper ERM argument might find one on finite samples. But the edge is computational. The marginal-dependent polynomial may depend on $P$, not on the hidden target concept, and the learner itself cannot receive distribution-specific or concept-specific advice.

Schapire-style boosting does not help. Boosting turns weak hypotheses into a strong vote, but that vote is generally an improper hypothesis. Here the source is already strong and improper; the problem is projection into $\mathcal C$.

The marginal-nonuniform sample-complexity results also do not prove the edge. They control rates after a marginal is fixed, but the checked characterizations are not representation-sensitive polynomial-time properization theorems. Therefore no theorem route is atlas-ready.

### Counterexample Route

All checked false routes remain near misses.

The PCP active-slice route gives the right distribution-free intuition. If the marginal is uniform on the slice for a hard formula $\varphi$, then a weak proper learner would produce a proof accepted on more than the soundness threshold. But the marginal-nonuniform target permits $p_{P_\varphi}$ and $\gamma_{P_\varphi}$ to depend on that input-coded marginal. This prevents a uniform polynomial-time reduction from SAT. Packing all formula slices into one fixed marginal dilutes a typical slice to exponentially small mass, below the inverse-polynomial advantage that the target may choose.

The one-way image-coordinate route proves only the strong proper separation. At strong accuracy $\varepsilon\ll \mu_n/n$, a proper learner must match the image coordinates and invert a one-way function. At the weak threshold, sparse length blocks create easy hidden handles: a wrong-length concept, or a constant/low-support concept if handles are present, can beat $1/2$ without recovering any preimage.

The coded-image route also fails at this depth. A polynomial-length binary code can make wrong images nearly balanced, but not closer than every inverse polynomial while still carrying exponentially many messages. Since the target's advantage $\gamma_P(s)$ may be any inverse polynomial chosen for the fixed marginal, residual inverse-polynomial correlations remain possible weak handles.

The best final lead was a countable weighted Walsh/parity version of the Depth-4 parity-of-image construction. The ideal fixed-length construction is clean: let a target seed $s$ label random parity queries by

$$
c_s(r)=\langle f(s),r\rangle \pmod 2.
$$

An improper learner can recover the image vector $f(s)$ by linear algebra, while any proper weak learner under the uniform parity marginal must output a seed $t$ with $f(t)=f(s)$. The final attempt was to replace the length-specific uniform distribution by one fixed finitely encoded marginal $P^\star$ over countably many examples $x$, together with computable feature maps $A_n(x)\in\{0,1\}^n$, so that all functions

$$
x\mapsto \langle y,A_{|y|}(x)\rangle
$$

are balanced and pairwise nearly orthogonal under $P^\star$ across all lengths.

That would resolve the edge under one-way functions if it also preserved efficient strong improper learning. But I do not have such a construction. The natural source of infinitely many independent parity queries is a nonatomic product space such as $[0,1]$ with Rademacher/Walsh functions. The atlas computational setting expects finitely encoded examples. Once the marginal is moved to finite strings or countably many atoms, every known encoding reintroduces one of the earlier escape routes: length-tail dilution, large atoms that spoil exact balance, or residual correlations that may be large enough for an inverse-polynomial weak advantage.

Thus the final lead sharpens the target object but does not produce it. A valid counterexample still needs a finitely encoded fixed marginal that acts like a common high-mass product distribution for all representation sizes, plus a proof that every proper weak hypothesis yields a computationally hard preimage or correlated range element. No checked source supplies this.

### Concrete Obstruction

The final obstruction is a four-way tension.

1. Weak proper learning only requires error below $1/2$ by some inverse polynomial. Therefore a lower bound must rule out every proper hypothesis with inverse-polynomial correlation, not merely every hypothesis that fails to recover the exact target representation.

2. Marginal-nonuniformity blocks input-dependent hard distributions. A reduction that chooses $P_\varphi$ or $P_n$ for the instance can lose polynomial uniformity because $p_P$ and $\gamma_P$ may depend arbitrarily on that marginal.

3. A single fixed marginal over infinitely many hard sizes has a mass budget. Sparse blocks, active slices, and finite-code coordinate sets leave most of the probability mass outside the challenged information, and this outside agreement becomes a hidden weak handle.

4. The natural way to avoid hidden handles is a common product-like parity marginal, but the clean product space is not finitely encoded. Known finite encodings of such a space either expose only a tail event for large $n$ or require an unproved countable weighted Walsh system with negligible cross-correlation and efficient reconstruction.

This is why neither direction is currently justified. A positive result would need a general polynomial-time proper weak projection theorem. A negative result would need a dense fixed-marginal cryptographic witness, stronger than the current PCP, DNF, image-coordinate, weak-handle, and parity sketches.

### Atlas-Ready Open-Note Text

Suggested replacement or expansion text for the existing atlas edge, if atlas edits are later allowed:

```markdown
`open`.

This edge asks whether strong efficient marginal-nonuniform realizable improper learning can always be properized to weak efficient marginal-nonuniform realizable learning. The source supplies arbitrary-accuracy polynomial-time prediction by hypotheses outside $\mathcal C$, while the target requires a polynomial-time output in $\mathcal C$ with inverse-polynomial advantage. No checked boosting or marginal-nonuniform sample-complexity theorem provides this representation-sensitive projection step.

The known counterexample templates are near misses. PCP active-slice and proper-DNF hardness arguments use hard distributions that vary with the input instance; marginal-nonuniform learning permits the runtime polynomial and weak advantage to depend on such a marginal. Packing all slices into one fixed marginal dilutes the hard slice below the inverse-polynomial advantage promised by the target. Cryptographic image-coordinate witnesses separate improper learning from strong proper learning, but at the weak threshold sparse blocks, wrong-length concepts, constants, singletons, or residual code correlations can provide proper hypotheses that beat random guessing without inverting the one-way function.

A promising but unresolved false route is a dense parity-of-image construction: improper learning would recover an external image vector by linear algebra, while proper weak learning under a common parity marginal would require finding a preimage. The length-specific version has this shape, but no finitely encoded fixed marginal is currently known that supplies balanced high-mass parity queries for every representation size without reintroducing tail dilution or other hidden weak handles.

Therefore the edge remains open as a computational marginal-nonuniform properization problem.
```

### Exact Atlas Changes If Resolved

None. The edge is not resolved, and this task forbids atlas edits.
