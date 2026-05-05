# Open Edge Resolution Scratchpad

Edge: `efficient-marginal-nonuniform-weak-realizable-proper-pac -> efficient-marginal-nonuniform-realizable-proper-pac`

## Research Log

## Sources Checked

## Proof Or Counterexample Attempts

## Verdict

## Follow-Up Directions

## Depth-1 Entry - 2026-05-05

### Verdict

Still `open` at depth 1. I do not see an atlas-ready proof or counterexample. The edge asks whether a single uniform proper weak learner whose polynomial may depend on each marginal $P$ can always be converted into a single uniform proper strong learner whose polynomial depends only on the original marginal $P$. Standard boosting and the known proper weak-to-strong separation each miss one of these quantifiers.

### Definitions Used

- Source: [[efficient-marginal-nonuniform-weak-realizable-proper-pac|Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]]. One learner works for every marginal $P$ and target $c\in\mathcal C$, outputs $h\in\mathcal C$, and for each fixed $P$ has a marginal-dependent polynomial bound and inverse-polynomial advantage $1/2-\gamma_P(s)$.
- Target: [[efficient-marginal-nonuniform-realizable-proper-pac|Efficient Marginal-Nonuniform Realizable Proper PAC Learning]]. One learner works for every marginal $P$ and target $c\in\mathcal C$, outputs $h\in\mathcal C$, and for each fixed $P$ has a marginal-dependent polynomial bound in $s,1/\varepsilon,\log(1/\delta)$.
- Edge note checked: `atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`, currently `status: "open"`, `evidence: unknown`, family `marginal-boosting-open`.
- Relevant argument/witness notes checked: [[marginal-boosting-open|Marginal-Nonuniform Boosting Open]], [[properization-open|Properization Open]], [[fixed-k-term-dnf-proper-boosting-separation|Fixed-k-Term DNF Proper Boosting Separation]], and [[fixed-k-term-DNF|Fixed-k-Term DNF]].

### Sources Checked

- Schapire, "The Strength of Weak Learnability" (1990), primary PDF: https://www.schapire.net/papers/strengthofweak.pdf. Checked the theorem route: the paper answers distribution-free weak-to-strong boosting affirmatively, but explicitly uses filtering/reweighted example distributions and notes that the construction need not preserve the weak learner's hypothesis representation.
- Freund, "Boosting a Weak Learning Algorithm by Majority" (1995), DOI/ScienceDirect page: https://doi.org/10.1006/inco.1995.1136 and author PDF: https://cseweb.ucsd.edu/~yfreund/papers/BoostByMajority.pdf. Checked for the distribution-dependent near miss: the abstract says the algorithm combines hypotheses trained on different example sets and includes extensions where weak accuracy depends on the instance distribution, but this still requires quantitative control over the weak learner on the induced distributions.
- Benedek and Itai, "Learnability with Respect to Fixed Distributions" (1991), DOI page: https://doi.org/10.1016/0304-3975(91)90026-X. Checked fixed-distribution context: the paper characterizes sample learnability for a fixed distribution and emphasizes that computation may be infeasible or even undecidable in the general fixed-distribution setting.
- Benedek and Itai, "Dominating Distributions and Learnability" (COLT 1992), Technion page: https://cris.technion.ac.il/en/publications/dominating-distributions-and-learnability/. Checked the domination route: for polynomial sample transfer from one fixed distribution to another, $D_2$ must be bounded multiplicatively by $D_1$, suggesting a possible bounded-density envelope condition but not giving it for this edge.
- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability" (2025), OpenReview PDF: https://openreview.net/pdf?id=aoVCFtox89. Checked the marginal-nonuniform quantifiers: guarantees may depend on the marginal but must hold uniformly over all target concepts once the marginal is fixed. The paper is sample/rate-theoretic, not a computational proper boosting theorem.
- Pitt and Valiant, "Computational Limitations on Learning from Examples" (1988), primary PDF mirror: https://www.cis.upenn.edu/~danroth/Teaching/CS446-17/Papers/p965-pitt.pdf. Checked the proper counterexample route: fixed-$k$-term DNF is hard to learn properly distribution-free, and the proof constructs distributions from each coloring instance; this does not immediately provide one fixed marginal $P$ witnessing failure of marginal-nonuniform strong proper learning.
- Haussler, Kearns, Littlestone, and Warmuth, "Equivalence of Models for Polynomial Learnability" (1990/1991), primary PDF: https://www.cis.upenn.edu/~mkearns/papers/models.pdf. Checked only as support for translating classical polynomial learnability variants; no marginal-nonuniform computational proper conversion found.

### Theorem Route

Goal: use the weak learner as a black box and boost to error $\varepsilon$ while preserving both marginal-nonuniform polynomial control and proper output.

Standard Schapire/Freund boosting does not directly prove the edge. The booster calls the weak learner under filtered or reweighted distributions $Q_t$ derived from $P$, the target $c$, and previous hypotheses. The source gives a polynomial $p_Q$ for each such $Q$, but the target needs a single polynomial $p_P$ that works for all targets $c$ and all accuracies $\varepsilon$. There is no definition-level domination saying that the collection of possible $p_{Q_t}$ is bounded by one polynomial depending only on $P$.

There is also a properness problem. Even if all weak calls output concepts in $\mathcal C$, the boosted predictor is normally a majority/threshold vote over those concepts. That vote need not itself lie in $\mathcal C$. Schapire explicitly flags that the construction does not generally preserve the weak learner's hypothesis form. Therefore the distribution-free theorem more naturally supports an improper target, or a target with a closure condition on $\mathcal C$ under the booster's vote, not this proper target.

Near misses:

- If the source were strengthened to require one polynomial envelope for every boosted marginal $Q_t$ reachable from $P$ with $T=\mathrm{poly}(s,1/\varepsilon,\log(1/\delta))$ rounds, then the runtime/sample bookkeeping obstruction would disappear.
- If $\mathcal C$ were efficiently closed under the booster's final vote, or if there were an efficient projection/ERM step from the vote back into $\mathcal C$ under $P$, then the properness obstruction would disappear.
- A distribution-specific agnostic/correlation-style weak learner over the fixed marginal $P$ might avoid reweighting $P$ by modifying labels instead, but the source is only realizable weak learning of concepts in $\mathcal C$, not agnostic weak learning for arbitrary relabelings.

### Counterexample Route

The obvious distribution-free witness is fixed-$k$-term DNF. It satisfies weak proper learning, while strong proper distribution-free learning would contradict Pitt-Valiant unless $\mathrm{RP}=\mathrm{NP}$. This does not currently resolve the marginal-nonuniform edge. The marginal-nonuniform target may choose a different polynomial for each fixed marginal $P$, and Pitt-Valiant's proof constructs positive and negative example distributions from each NP-hard coloring instance. That is enough for distribution-free hardness, but not enough to exhibit one marginal $P$ for which every polynomial-time proper learner fails uniformly over all targets.

A successful false proof would need to package the hard instances into a single fixed marginal with polynomially visible mass for the relevant slice, while keeping the target concept inside the same representation class and preserving the weak proper source. Existing "slice packing" attempts in the local notes lose hardness because the slice mass can become too small; the target learner's polynomial is allowed to depend on that fixed marginal.

### Concrete Obstruction

The unresolved quantifier is:

$$
\forall P\ \exists p_P\ \forall c,\varepsilon,\delta
$$

for the target, versus the source information available during boosting:

$$
\forall Q\ \exists p_Q
$$

where the boosted marginals $Q$ are generated adaptively and may depend on $c$, previous weak hypotheses, and $\varepsilon$. Nothing in the source forces the map $Q\mapsto p_Q$ to be locally bounded around $P$, even for $Q\ll P$ or for distributions reached by bounded-density reweightings. Separately, nothing in the source lets an improper boosted vote be efficiently converted into a concept in $\mathcal C$.

### Promising Next Directions

- Try to prove a conditional positive theorem with an explicit "boosting envelope" assumption: for every original marginal $P$ and every polynomial round bound $T$, all filtered/reweighted marginals reachable by Schapire/Freund boosting have weak-learner runtimes dominated by one polynomial depending on $P$ and $T$.
- Look for a label-modifying distribution-specific booster requiring only weak calls under the original marginal $P$; then isolate exactly which stronger weak condition it needs beyond realizable weak PAC.
- Build a fixed-marginal hardness witness by embedding Pitt-Valiant $k$-term-DNF consistency instances into one marginal with polynomially large active blocks and target-dependent labels, avoiding the exponential slice-mass dilution noted in [[properization-open|Properization Open]].
- Check whether bounded-density transfer results in Benedek-Itai's "Dominating Distributions and Learnability" can be adapted from sample transfer to computational weak-learner runtime envelopes. This would not settle the current definition, but it could identify the weakest extra regularity assumption under which the edge becomes true.

### Atlas-Ready Changes If Resolved

None. Keep the atlas edge as `status: "open"`, `evidence: unknown`, with no new assumptions, witnesses, or `ref_keys` changes at this depth.

## Depth-2 Entry - 2026-05-05

### Verdict

Resolved as `false`, conditionally on length-preserving one-way functions.

The Depth-1 obstruction can be turned into a fixed-marginal separation. The usual one-way image-coordinate class already blocks strong marginal-nonuniform proper learning, but by itself it need not satisfy weak proper learning. Add simple proper weak handles: all-zero, all-one, and singleton-positive-atom concepts. These handles make weak proper learning easy for every marginal and every target, while any sufficiently accurate proper learner for an image-coordinate target under one fixed marginal must still output a seed whose image is the challenge string. That would invert the one-way function.

So the atlas edge

$$
\texttt{efficient-marginal-nonuniform-weak-realizable-proper-pac}
\;\Rightarrow\;
\texttt{efficient-marginal-nonuniform-realizable-proper-pac}
$$

should be recorded as `status: "false"` with `evidence: conditional-counterexample`.

### Sources Checked

- Local Depth-1 entry in this scratchpad, especially the fixed-marginal separation direction and the warning that Pitt-Valiant/DNF slice packing does not survive marginal-nonuniform constants.
- Local notes: `atlas/arguments/marginal-boosting-open.md`, `atlas/arguments/properization-open.md`, `atlas/arguments/realizable-boosting.md`, `atlas/arguments/one-way-image-coordinate-proper-hardness.md`, and `atlas/witnesses/one-way-image-coordinate-class.md`.
- Sibling scratchpad: `scratchpads/open-edge-resolution-2026-05-04/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac/scratchpad.md`, which gives the strong improper-to-proper one-way image-coordinate lower bound.
- Schapire, "The Strength of Weak Learnability" (1990), author PDF: https://www.schapire.net/papers/strengthofweak.pdf. Used for the classical boosting theorem and for confirming that properness is not preserved by the boosted vote.
- Freund, "Boosting a Weak Learning Algorithm by Majority" (1995), DOI/PDF: https://doi.org/10.1006/inco.1995.1136 and https://cseweb.ucsd.edu/~yfreund/papers/BoostByMajority.pdf. Used for the distribution-specific/KL-envelope near miss.
- Servedio, "Smooth Boosting and Learning with Malicious Noise" (JMLR 2003), JMLR page: https://jmlr.org/papers/v4/servedio03a.html. Checked as a bounded-density/smooth-distribution route; it supplies smooth reweightings only under an extra smoothness requirement, not from the bare atlas source.
- Feldman, "Distribution-Specific Agnostic Boosting" (ICS 2010 / arXiv:0909.2927), PDF: https://www.cs.cmu.edu/~odonnell/hits09/feldman-agnostic-boosting.pdf. Checked as the fixed-marginal label-modification route; it needs weak agnostic/correlation access, not merely realizable weak PAC.
- Benedek and Itai, "Dominating Distributions and Learnability" (COLT 1992), Technion page: https://cris.technion.ac.il/en/publications/dominating-distributions-and-learnability/. Used for the bounded-density transfer intuition: domination is an extra condition, not automatic.
- Kearns and Valiant, "Cryptographic Limitations on Learning Boolean Formulae and Finite Automata" (JACM 1994), DOI/PDF: https://doi.org/10.1145/174644.174647 and https://www.cis.upenn.edu/~mkearns/papers/cryptojacm.pdf. Used as the learning-theoretic cryptographic-hardness anchor.
- Håstad, Impagliazzo, Levin, and Luby, "A Pseudorandom Generator from any One-Way Function" (SIAM J. Comput. 1999), DOI/PDF: https://doi.org/10.1137/S0097539793244708 and https://www.cs.bu.edu/fac/lnd/pdf/hill.pdf. Used for the standard one-way-function assumption.

### Theorem Route

The positive theorem route still needs extra hypotheses. A Schapire/Freund booster can be made marginal-nonuniform only if the weak learner has an original-marginal envelope over every reweighted marginal the booster may generate:

$$
\forall P\ \exists R_P,G_P\ \forall Q\in\mathsf{BoostReach}(P)
$$

where $R_P$ bounds the weak call's time/sample cost and $1/G_P$ lower-bounds the weak advantage. Smooth or KL-controlled boosting supplies such a statement only when smoothness, bounded-density domination, or a KL-sensitive accuracy condition is assumed. Distribution-specific agnostic boosting avoids reweighting the instance marginal, but it changes the label distribution and therefore calls for a weak agnostic learner. The current source is realizable-only.

Even with that envelope, the proper edge needs an additional closure/projection condition. The boosted predictor is a majority or weighted vote over concepts in $\mathcal C$, and that vote need not lie in $\mathcal C$. A conditional positive theorem would therefore require both:

- an original-marginal polynomial envelope for all booster-generated reweighted marginals; and
- efficient closure of $\mathcal C$ under the booster's vote, or an efficient marginal-specific projection/ERM oracle back into $\mathcal C$.

The counterexample below shows that the second requirement is not cosmetic: generic properization fails under a fixed marginal.

### Counterexample Route

Assume a polynomial-time computable length-preserving one-way function

$$
f:\{0,1\}^n\to\{0,1\}^n .
$$

Use the instance space

$$
X=\{(1^k,i,b): k\ge 1,\ i\in[k],\ b\in\{0,1\}\}.
$$

For each seed $s\in\{0,1\}^n$, let $y=f(s)$ and define the image-coordinate concept

$$
c_s(1^k,i,b)=1
\quad\Longleftrightarrow\quad
k=n\ \text{and}\ b=y_i .
$$

Now enlarge the represented class by adding weak handles:

- the all-zero concept $0$;
- the all-one concept $1$;
- for every atom $a\in X$, the singleton concept $\mathbf 1_a$ that labels only $a$ positive.

The final class is

$$
\mathcal C
= \{c_s:s\in\{0,1\}^*\}
\cup \{0,1\}
\cup \{\mathbf 1_a:a\in X\}.
$$

Proper representations are the seed $s$, the two constants, and the atom name $a$ for singletons.

**Why the weak proper source holds.** Consider a target image-coordinate concept $c_s$ of length $n$. Let

$$
M=P(c_s^{-1}(1))
$$

be the positive mass under an arbitrary marginal $P$. The positive set of $c_s$ has exactly $n$ atoms, so some positive atom has mass at least $M/n$ when $M>0$.

Compare two proper hypotheses:

$$
h_0=0,
\qquad
h_a=\mathbf 1_a
$$

where $a$ is a heaviest positive atom. Their errors are $M$ and $M-P(a)$. Also compare the all-one concept, whose error is $1-M$. Hence the best of $1$ and $h_a$ has error at most

$$
\min\{1-M,\ M(1-1/n)\}.
$$

For $M\in[0,1]$, this quantity is at most $1/2-\Omega(1/n)$; more explicitly, the maximum occurs near $M=n/(2n-1)$ and is $(n-1)/(2n-1)<1/2-1/(4n)$ for $n\ge 2$. For $n=1$, a singleton positive atom learns the seed target exactly. Thus one of the constant or singleton proper handles has inverse-polynomial weak advantage under every marginal.

A uniform weak learner can find such a handle from samples. It estimates the errors of $0$ and $1$, records observed positive atoms, and validates the constants plus observed singleton candidates on a fresh sample. With $O(n^2\log(1/\delta))$ examples, a positive atom with mass within a constant factor of the heaviest positive atom is seen whenever the singleton route is needed, and validation selects a hypothesis with error at most $1/2-\Omega(1/n)$. The learner is proper and distribution-free polynomial for image-coordinate targets.

For the added handle targets, weak proper learning is easier. If the target is $0$ or $1$, output it. If the target is a singleton $\mathbf 1_a$, either $0$ already has error $P(a)\le 1/2-\Omega(1)$, or $P(a)$ is bounded away from zero and the atom $a$ is seen quickly; then output $\mathbf 1_a$ and learn exactly. Standard validation gives a single uniform procedure with an inverse-polynomial weak edge. Therefore $\mathcal C$ satisfies `efficient-marginal-nonuniform-weak-realizable-proper-pac`.

**Why the strong proper target fails.** Fix the marginal $P^\star$ that chooses $k$ with mass

$$
\mu_k=\frac{6}{\pi^2k^2},
$$

then chooses $i\in[k]$ and $b\in\{0,1\}$ uniformly. For a length-$n$ seed target $c_s$, set

$$
\varepsilon_n=\frac{\mu_n}{3n}.
$$

Since $\mu_n=\Theta(1/n^2)$, $1/\varepsilon_n=\operatorname{poly}(n)$.

Any proper hypothesis with $P^\star$-error at most $\varepsilon_n$ against $c_s$ must be an image-coordinate seed concept $c_t$ with $|t|=n$ and $f(t)=f(s)$. The added handles are too inaccurate: $0$ has error $\mu_n/2$, $1$ has error at least $1-\mu_n/2$, and any singleton has error at least $\mu_n/2-\mu_n/(2n)$, all larger than $\varepsilon_n$ for $n\ge 2$. If a seed hypothesis has the wrong length, it misses all $n$ positive atoms in the length-$n$ block and has error at least $\mu_n/2$. If it has length $n$ but one wrong image bit, the two atoms for that coordinate disagree and contribute error $\mu_n/n>\varepsilon_n$.

Now suppose a strong marginal-nonuniform proper learner existed for $\mathcal C$. Given a one-way challenge $y=f(s)$ for unknown uniform $s\in\{0,1\}^n$, simulate labeled examples from $P^\star$ by labeling

$$
(1^k,i,b)\mapsto 1
\quad\Longleftrightarrow\quad
k=n\ \text{and}\ b=y_i .
$$

This is exactly the realizable distribution for the unknown concept $c_s$, and it can be sampled using $y$ without knowing any preimage. Run the assumed proper learner with accuracy $\varepsilon_n$ and constant confidence. Because $P^\star$ is fixed, its marginal-dependent polynomial bound gives runtime polynomial in $n$. With nonnegligible probability the learner returns a seed $t$ with $f(t)=y$, contradicting one-wayness.

### Concrete Obstruction

The separation isolates a properness obstruction that survives fixed-marginal nonuniformity. The weak source can be satisfied by local proper handles that recover a small but inverse-polynomial edge under every marginal. Strong proper learning, however, is forced by the fixed marginal and the inverse-polynomial accuracy request to recover the entire image string in a seed representation. The hard instance is carried by the target labels, not by a varying marginal, so the marginal-dependent polynomial cannot hide the reduction instance.

This also clarifies why the Depth-1 DNF route stalled. Pitt-Valiant-style reductions vary the hard distribution or lose mass when packed into one universal marginal. Here $P^\star$ is fixed once, gives the length-$n$ block inverse-polynomial mass, and makes $\varepsilon_n$ polynomially reachable.

### Exact Atlas Changes If Edits Are Allowed

Update `atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`:

- `status: "false"`
- `evidence: conditional-counterexample`
- `assumptions: ["length-preserving one-way functions exist"]`
- `witnesses: ["one-way-image-coordinate-weak-handle-class"]`
- `ref_keys: ["kearns1994cryptographic", "hastad1999prg"]`
- `refs:` include `[Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)` and `[Håstad et al. 1999](https://doi.org/10.1137/S0097539793244708)`
- `summary: "False under one-way functions: adding proper weak handles to the image-coordinate class gives marginal-nonuniform weak proper learning, but fixed-marginal strong proper learning would invert the one-way function."`
- `family: one-way-image-coordinate-proper-hardness`
- `argument_note: "[[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]]"` or a new argument note if the atlas wants the weak-handle variant separated from the existing improper-to-proper witness.
- `witness_note: "[[one-way-image-coordinate-weak-handle-class|One-Way Image-Coordinate Weak-Handle Class]]"` if a new witness note is created.

Add a new witness note `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md` with the construction above, or extend `atlas/witnesses/one-way-image-coordinate-class.md` to include the weak-handle augmentation as a named variant. The cleaner atlas change is a new witness note, because the existing witness is designed for improper-to-proper strong separation and does not explicitly assert weak proper learnability.

### Next Directions

- When atlas edits are permitted, add the weak-handle witness note and update this edge to `false` under one-way functions.
- Check sibling edges whose source is weak proper and whose target is strong proper; this witness should apply whenever the source does not demand distribution-free strong proper learning.
- Keep the envelope/stability route as a conditional positive theorem for restricted classes. It is still useful, but it should be recorded as an additional assumption rather than as a proof of the bare edge.

## Depth-3 Entry - 2026-05-05

### Verdict

Resolved as `false`, conditionally. Depth 2 gives the stronger route under length-preserving one-way functions by adding explicit weak handles. This Depth 3 pass pursued a different lead: whether the edge can still fail when the weak proper learner has an original-marginal polynomial envelope, so the filtered-marginal bookkeeping problem is not the bottleneck.

Yes. Under the stronger but cleaner assumption that length-preserving one-way permutations exist, the image-coordinate class can be made weakly properly learnable by random proper seeds, without the singleton weak handles from Depth 2. The weak learner is distribution-free and has an inverse-polynomial edge. Nevertheless, strong marginal-nonuniform proper learning under one fixed inverse-square marginal would invert the permutation.

So the atlas-level conclusion is still `status: "false"` with `evidence: conditional-counterexample`. If using the Depth 2 witness, the assumption can be stated as length-preserving one-way functions. If using this Depth 3 alternate witness, state the cleaner assumption as length-preserving one-way permutations.

### Sources Checked

- Existing entries in this scratchpad, including the newly present Depth 2 weak-handle construction.
- Local files: `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`, `atlas/definitions/efficient-marginal-nonuniform-realizable-proper-pac.md`, `atlas/arguments/marginal-boosting-open.md`, `atlas/arguments/properization-open.md`, `atlas/arguments/realizable-boosting.md`, `atlas/arguments/sample-complexity-equivalence.md`, `atlas/arguments/one-way-image-coordinate-proper-hardness.md`, and `atlas/witnesses/one-way-image-coordinate-class.md`.
- Sibling scratchpad: `scratchpads/open-edge-resolution-2026-05-04/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac/scratchpad.md`, especially the original-marginal envelope lemma.
- Schapire, "The Strength of Weak Learnability" (1990), author PDF: https://www.schapire.net/papers/strengthofweak.pdf. Used for the classical improper boosted-vote theorem and the filtering/reweighting issue.
- Freund, "Boosting a Weak Learning Algorithm by Majority" (1995), DOI: https://doi.org/10.1006/inco.1995.1136. Used for boost-by-majority and the distribution-dependent weak-accuracy near miss.
- Feldman, "Distribution-Specific Agnostic Boosting" (2010), arXiv: https://arxiv.org/abs/0909.2927. Checked for the fixed-marginal label-modification route; it requires weak agnostic access, not just realizable weak learning.
- Kearns and Valiant, "Cryptographic Limitations on Learning Boolean Formulae and Finite Automata" (1994), DOI/PDF: https://doi.org/10.1145/174644.174647 and https://www.cis.upenn.edu/~mkearns/papers/cryptojacm.pdf. Used as the cryptographic-learning lower-bound template.
- Hastad, Impagliazzo, Levin, and Luby, "A Pseudorandom Generator from any One-Way Function" (1999), DOI: https://doi.org/10.1137/S0097539793244708. Checked for standard one-way-function background; the alternate witness below assumes the stronger permutation primitive.

### Theorem Route

The envelope route proves at most an improper theorem unless the class has efficient closure under the boosted vote or an efficient projection back into $\mathcal C$. The alternate witness makes this sharp.

For the one-way permutation coordinate class, the weak learner can be given a distribution-free polynomial envelope. Thus for every original marginal $P_0$, the weak edge and weak runtime are bounded by a single polynomial independent of all booster-generated marginals. Classical boosting can therefore produce a low-error vote of proper seed concepts. But the target node requires one final proper seed concept, and that properization step is exactly where the cryptographic hardness enters.

Feldman's distribution-specific agnostic boosting does not repair this. It avoids changing the instance marginal by modifying labels, but the source node is realizable weak proper PAC. It does not promise the agnostic/correlation behavior required on the intermediate relabeled distributions.

### Counterexample Route

Assume a polynomial-time computable length-preserving one-way permutation family

$$
f_n:\{0,1\}^n\to\{0,1\}^n .
$$

Use domain points $(1^k,i,b)$ with $k\ge 1$, $i\in[k]$, and $b\in\{0,1\}$. For a seed $s\in\{0,1\}^n$, define

$$
c_s(1^k,i,b)=1
\quad\Longleftrightarrow\quad
k=n\text{ and }b=f_n(s)_i .
$$

Also include the all-zero concept $0$. Proper hypotheses are therefore $0$ or seed concepts $c_t$.

Weak proper learning is distribution-free. Fix any marginal $Q$ and target $c_s$ of length $n$, with image $y=f_n(s)$. The learner validates the all-zero concept and, when positive examples reveal the target length $n$, validates polynomially many random same-length seeds $t$.

If the positive mass of the target is at most $1/2-\Omega(1/\sqrt n)$, the all-zero concept already has weak advantage. Otherwise positive examples reveal $n$ with high probability. Since $f_n$ is a permutation, a random seed $t$ gives a uniformly random image string $f_n(t)$. For the coordinate weights induced by $Q$ on the length-$n$ block, the weighted agreement between $f_n(t)$ and $y$ is a weighted Rademacher sum around mean $1/2$, with $\ell_2$ scale at least $1/\sqrt n$ in the nontrivial case. A constant number, or polynomial number after validation and confidence amplification, of random seeds therefore contains a same-length proper hypothesis with error at most $1/2-\Omega(1/\sqrt n)$.

Outside the target length block, same-length seed hypotheses and the target both label every point $0$, so no extra off-block penalty appears. Standard validation over the finite candidate list preserves an inverse-polynomial edge. Hence this class satisfies `efficient-marginal-nonuniform-weak-realizable-proper-pac`, indeed with a distribution-free weak polynomial.

For the strong lower bound, fix $P^\star$ by choosing length $k$ with mass

$$
\mu_k=\frac{6}{\pi^2 k^2},
$$

then choosing $i\in[k]$ and $b\in\{0,1\}$ uniformly. For a length-$n$ target $c_s$, set

$$
\varepsilon_n=\frac{\mu_n}{3n}.
$$

Any proper hypothesis with $P^\star$-error at most $\varepsilon_n$ must be a same-length seed $c_t$ with $f_n(t)=f_n(s)$. The all-zero concept and wrong-length seeds have error at least $\mu_n/2$ on the length-$n$ block. A same-length seed with one wrong image bit has error at least $\mu_n/n$, because both atoms for that coordinate are mislabeled.

Given an inversion challenge $y=f_n(s)$, simulate labeled examples from $P^\star$ by labeling $(1^k,i,b)$ positive exactly when $k=n$ and $b=y_i$. A marginal-nonuniform strong proper learner run at accuracy $\varepsilon_n$ would output a seed $t$ with $f_n(t)=y$ in time polynomial in $n$, since $P^\star$ is fixed and $1/\varepsilon_n=\operatorname{poly}(n)$. This contradicts one-wayness.

### Concrete Obstruction

This pass separates two obstructions that were previously tangled together.

The original-marginal envelope obstruction blocks generic boosting for the bare marginal-nonuniform weak source. But even when that envelope is available, as in the permutation-coordinate class, the proper target can still fail. The boosted vote can predict the coordinate image bits accurately without producing a seed. A proper learner that reaches accuracy below $\mu_n/(3n)$ must recover the exact seed preimage.

So the final obstruction for this edge is proper representation recovery under a fixed marginal. Diagonal reweighting is not needed once the hard target labels are packed into inverse-polynomial-mass coordinate blocks.

### Next Directions

- Prefer the Depth 2 weak-handle witness for atlas edits if its proof is accepted, because it works under the weaker length-preserving one-way-function assumption.
- Use this Depth 3 permutation witness as a cleaner backup or explanatory note showing that an original-marginal weak envelope still does not imply the proper strong target.
- Exact atlas changes remain those listed in Depth 2 for the weak-handle witness: update the edge to `status: "false"`, `evidence: conditional-counterexample`, add the one-way assumption, add the weak-handle witness, and summarize that fixed-marginal strong proper learning would invert.
- If choosing the permutation backup instead, add a separate `one-way-permutation-coordinate-class` witness and set the assumption to `length-preserving one-way permutations exist`.
