# Open Edge Resolution Scratchpad

Edge: `efficient-marginal-nonuniform-weak-realizable-improper-pac -> efficient-marginal-nonuniform-weak-realizable-proper-pac`

## Research Log

## Sources Checked

## Proof Or Counterexample Attempts

## Verdict

## Follow-Up Directions

---

## Depth-1 Entry - 2026-05-05

### Verdict

`unresolved`; keep the atlas edge `open` with `evidence: unknown`.

I tried both directions hard. I do not see a theorem route from the current source to the target, and the known proper-learning hardness routes still fall short of a valid marginal-nonuniform counterexample. No atlas-ready status/evidence/assumptions/witnesses/ref_keys change is justified yet.

### Definitions Used

Source node:
`efficient-marginal-nonuniform-weak-realizable-improper-pac`.

The source supplies one uniform learner $A$ such that for every marginal $P$ there are a marginal-dependent polynomial $p_P$ and inverse-polynomial edge $\gamma_P(s)>0$ with

$$
\operatorname{err}_P(h,c)\le \frac12-\gamma_P(s)
$$

for every target $c\in\mathcal C$ and confidence $\delta$. The learner may output $h\notin\mathcal C$, and the sample/runtime polynomial may depend on $P$ but not on $c$.

Target node:
`efficient-marginal-nonuniform-weak-realizable-proper-pac`.

The target asks for the same marginal-nonuniform weak realizable guarantee, but the learner must output $h\in\mathcal C$.

The only axis change is improper-to-proper. There is no requested boosting, agnostic conversion, or distribution-free uniformization in this edge.

### Sources Checked

- Local source definition: `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-improper-pac.md`.
- Local target definition: `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`.
- Local edge note: `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`.
- Local argument note: `atlas/arguments/properization-open.md`.
- Local comparison notes: `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`, `atlas/witnesses/pcp-active-slice-lookup-class.md`, and `atlas/witnesses/clause-satisfaction-lookup-class.md`.
- Distribution-free resolved comparison edge: `atlas/implications/efficient-weak-realizable-improper-pac--implies--efficient-weak-realizable-proper-pac.md`.
- Schapire, "The Strength of Weak Learnability" (1990), author PDF: https://www.schapire.net/papers/strengthofweak.pdf. Checked for the classical distribution-free weak/strong theorem and for the fact that the theorem is representation-independent/improper and exploits access to arbitrary induced distributions.
- Pitt and Valiant, "Computational Limitations on Learning from Examples" (1988), PDF checked at https://www.cis.upenn.edu/~danroth/Teaching/CS446-17/Papers/p965-pitt.pdf. Checked for the k-term-DNF proper-hardness source and the k-CNF improper upper route.
- Khot and Saket, "Hardness of Minimizing and Learning DNF Expressions" (2008), PDF checked at https://cs.nyu.edu/~khot/papers/minDNF.pdf. Checked for the constant-advantage DNF proper weak-learning lower bound.
- Håstad and Khot, "Query Efficient PCPs with Perfect Completeness" (2005), Theory of Computing page checked at https://theoryofcomputing.org/articles/v001a007/. Checked for logarithmic-randomness perfect-completeness PCPs with soundness below $1/2$.
- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability" (NeurIPS 2025), OpenReview page checked at https://openreview.net/forum?id=aoVCFtox89. Checked for the marginal-nonuniform quantifier pattern: rates may depend on the marginal but must hold uniformly over concepts.

### Theorem Route

Goal: turn the weak improper learner $A$ into a weak proper learner $B$ for the same fixed marginal $P$.

The naive projection route fails. Since the realizable target concept $c$ itself is a zero-error proper hypothesis, it is statistically present in $\mathcal C$, but the source learner may output an arbitrary outside hypothesis $h$. The source promise gives no efficient method to find any $c'\in\mathcal C$ whose $P$-error is below $1/2-\gamma_P(s)$ once an outside weak predictor has been found.

Sample-only ERM is also not enough. For a fixed marginal, one could imagine searching over $\mathcal C$ for a proper empirical weak hypothesis. But the target is computational: it needs one uniform algorithm with a $P$-dependent polynomial runtime. The existing source learner may owe its efficiency exactly to using an easier improper representation, as in the Pitt-Valiant style k-term-DNF versus k-CNF phenomenon.

Classical boosting does not repair properness. Schapire's theorem converts distribution-free weak learning into strong learning, but its final hypothesis is a vote/composition of weak hypotheses and is generally improper. Boosting can improve accuracy; it is not a generic polynomial-time projection back into the original representation class.

I therefore do not have a positive theorem under the current node definitions. A true result would need a new properization theorem: from any efficiently marginal-nonuniform weak improper learner, construct an efficiently marginal-nonuniform weak learner whose output lies in $\mathcal C$. None of the checked sources gives such a theorem.

### Counterexample Route

The distribution-free PCP active-slice witness is the strongest local near miss. It separates `efficient-weak-realizable-improper-pac` from `efficient-weak-realizable-proper-pac` under $\mathrm{NP}\nsubseteq\mathrm{RP}$. The reduction fixes an NP instance $\varphi$, samples uniformly from its active PCP randomness slice, labels everything by $1$, and observes that a weak proper learner would output a proof accepted on more than half the random strings.

Why this does not refute the present target: the target is marginal-nonuniform. For each fixed active-slice marginal $P_\varphi$, the allowed polynomial $p_{P_\varphi}$ may depend on $\varphi$. A reduction from $\varphi$ to learning under $P_\varphi$ therefore does not get a uniform polynomial-time bound in $|\varphi|$. The hard instance can be hidden in the marginal-dependent constant/exponent.

Packing all active slices into one fixed marginal also has the usual dilution problem. If a single marginal $P^\star$ assigns mass $w_\varphi$ to the slice for $\varphi$, then any proper-learning gap on that slice is multiplied by $w_\varphi$. For exponentially many formulas of length $n$, no fixed probability distribution can give every slice inverse-polynomial mass. Once $w_\varphi$ is exponentially small, the weak target's inverse-polynomial global advantage need not recover the local PCP gap.

The Pitt-Valiant and Khot-Saket DNF routes are also near misses. Pitt-Valiant show representation-dependent proper hardness and an improper k-CNF upper route for k-term DNF, while Khot-Saket strengthen this to constant-advantage hardness for learning 2-term DNF by any fixed t-term DNF. But these lower bounds are distribution-free/adversarial-distribution statements. They do not by themselves show failure for every algorithm under a single fixed marginal with the runtime polynomial allowed to depend on that marginal. Khot-Saket is also keyed to constant advantage; the atlas weak node allows inverse-polynomial advantage.

### Concrete Obstruction

The obstruction is the same quantifier shield that defines marginal-nonuniform learning:

$$
\forall P\ \exists p_P,\gamma_P\ \forall c.
$$

To prove a false edge from an NP-hardness reduction that chooses a marginal $P_x$ depending on an input instance $x$, one normally needs a runtime bound polynomial in $|x|$. The target would only give a polynomial $p_{P_x}$ whose coefficients and degree may depend on the entire marginal $P_x$, hence may depend arbitrarily on $x$. That does not yield an RP algorithm for the underlying NP-complete language.

To avoid that dependence, a counterexample would need one fixed marginal $P^\star$ carrying infinitely many hard instances with enough probability mass that a global weak proper advantage gives a detectable local advantage on each hard slice. The standard slice constructions do not achieve this, because the mass of individual hard slices decays too quickly when all instances are packed into one distribution.

Conversely, this quantifier shield is not a theorem route either. It explains why existing false witnesses fail, but it does not supply a uniform polynomial-time method to properize an arbitrary improper weak hypothesis.

### Promising Next Directions

1. Try to build a fixed-marginal proper-hardness construction with polynomially heavy hard slices, perhaps using a sparse hard language or a padded promise family. The main risk is that known sparse NP-hardness barriers make this delicate.
2. Look for primary sources on fixed-distribution proper learning hardness, not just distribution-free proper PAC hardness. A valid negative result should name one marginal $P^\star$ and show no $P^\star$-polynomial-time proper weak learner exists while an improper weak learner exists for every marginal.
3. Formalize conditions under which marginal-nonuniform properization is true for locally finite or effectively discrete marginals. The PCP active-slice discussion suggests fixed finite-support marginals may be too easy because exhaustive proper search can be hidden in the marginal-dependent polynomial.
4. Search for representation-dependent weak proper lower bounds with inverse-polynomial advantage under a single natural marginal. Khot-Saket gives constant-advantage distribution-free evidence, but not the exact marginal-nonuniform weak separation needed here.
5. Consider adding an atlas subquestion for "fixed-marginal weak properization": for a fixed $P$, when does efficient weak improper learnability uniformly over $c$ imply efficient weak proper learnability with a polynomial allowed to depend on $P$?

## Depth-2 Entry - 2026-05-05

### Verdict

Still `unresolved`; keep the atlas edge `open` with `evidence: unknown`.

Depth 2 rules out the two most tempting direct continuations from Depth 1:

- The PCP active-slice witness still does not survive marginal nonuniformity, because its hard marginal varies with the NP instance or becomes too diluted when packed into one fixed marginal.
- The one-way image-coordinate witness that resolves the strong realizable marginal edge does not refute the weak proper target. It forces exact inversion only when the proper learner is asked for accuracy on the order of the active block mass divided by the number of coordinates. The weak target has no $\varepsilon$ input, and a global inverse-polynomial advantage can ignore a small active block.

No positive properization theorem emerged either. There are therefore no exact atlas changes justified for this edge.

### Sources Checked

Local notes rechecked:

- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/implications/efficient-weak-realizable-improper-pac--implies--efficient-weak-realizable-proper-pac.md`
- `scratchpads/open-edge-resolution-2026-05-04/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac/scratchpad.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- neighboring marginal weak agnostic scratchpad for the same properization obstruction.

Primary sources checked or rechecked:

- Benedek and Itai, "Learnability with respect to fixed distributions," Theoretical Computer Science 86(2), 1991, DOI page https://www.sciencedirect.com/science/article/pii/030439759190026X. Used for the fixed-distribution distinction: rates may be distribution-sensitive, but this is not a computational projection theorem.
- Ben-David, Benedek, and Mansour, "A parameterization scheme for classifying models of PAC learnability," Information and Computation 120(1), 1995, DOI https://doi.org/10.1006/inco.1995.1094. Used for the uniformity-parameter viewpoint and for the warning that these classifications are primarily information-theoretic.
- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability," OpenReview https://openreview.net/forum?id=aoVCFtox89. Used for the modern marginal-nonuniform quantifier order: the learner is uniform, while rates may depend on the marginal.
- Håstad and Khot, "Query Efficient PCPs with Perfect Completeness," Theory of Computing 1(7), 2005, DOI https://doi.org/10.4086/toc.2005.v001a007. Used for logarithmic-randomness, perfect-completeness PCPs with soundness below $1/2$.
- Khot and Saket, "Hardness of Minimizing and Learning DNF Expressions," FOCS 2008, author PDF https://cs.nyu.edu/~khot/papers/minDNF.pdf and DOI metadata https://doi.org/10.1109/FOCS.2008.37. Used as a constant-advantage proper weak-learning lower bound that still varies the hard distribution.
- Pitt and Valiant, "Computational Limitations on Learning from Examples," JACM 35(4), 1988, DOI https://doi.org/10.1145/48014.63140, PDF mirror https://www.cis.upenn.edu/~danroth/Teaching/CS446-17/Papers/p965-pitt.pdf. Used as representation-dependent proper-hardness background.
- Kearns and Valiant, "Cryptographic Limitations on Learning Boolean Formulae and Finite Automata," JACM 41(1), 1994, DOI https://doi.org/10.1145/174644.174647. Used as the learning-theoretic cryptographic-hardness anchor.
- Håstad, Impagliazzo, Levin, and Luby, "A Pseudorandom Generator from any One-Way Function," SIAM Journal on Computing 28(4), 1999, DOI https://doi.org/10.1137/S0097539793244708. Used for the standard one-way-function assumption.
- Goldreich and Levin, "A Hard-Core Predicate for all One-Way Functions," STOC 1989, checked as a possible route from weak correlation to inversion; it does not by itself turn correlation with visible image bits into preimage recovery for this edge.

### Theorem Route

Goal: prove

$$
\text{efficient marginal-nonuniform weak realizable improper}
\Longrightarrow
\text{efficient marginal-nonuniform weak realizable proper}.
$$

The sample-theoretic route remains plausible only after deleting runtime. The source gives a marginal-dependent polynomial sample bound, and the marginal-nonuniform sample theory can often be pushed through VC/ERM arguments. But the target is computational and requires the output representation to lie in $\mathcal C$.

The missing operation is still efficient proper projection. Given samples and an improper weak hypothesis $g$, one would need to find some $c'\in\mathcal C$ with

$$
\operatorname{err}_P(c',c)\le \frac12-\gamma_P(s)
$$

for every realizable target $c$. The fact that $c$ itself has zero error proves existence, not efficient search. The polynomial $p_P$ may depend on the marginal, but the algorithm cannot receive target-dependent advice and cannot run exponential search over all size-$s$ representations.

The one-way image-coordinate sibling reinforces the absence of a generic strong properization theorem. It does not refute the weak edge, but it shows that once accuracy is requested, a fixed marginal can make proper projection equivalent to cryptographic inversion. I found no primary source that supplies a general computational properization theorem at the weak marginal-nonuniform level.

### Counterexample Route

#### PCP Active-Slice

The active-slice PCP class satisfies the weak improper source, indeed more strongly than needed: the active slice for a target NP instance has polynomial size, so an improper learner can memorize positive sample points and predict $0$ elsewhere.

For distribution-free weak proper learning, the reduction chooses the marginal $P_\varphi$ uniformly on the active slice of the input formula $\varphi$ and labels all examples by $1$. Perfect completeness gives realizability in the yes case, and soundness below $1/2$ makes any weak proper hypothesis distinguish satisfiable from unsatisfiable instances.

This still fails for the marginal-nonuniform target. If the reduction uses $P_\varphi$, the target's runtime polynomial is $p_{P_\varphi}$ and may depend arbitrarily on $\varphi$. If instead one fixed marginal $P^\star$ packs all active slices, the mass assigned to a typical length-$n$ formula slice is exponentially small. The local PCP gap is then multiplied by that mass, and the weak target's allowed inverse-polynomial global advantage need not identify the hard slice.

This is not merely a proof inconvenience: a fixed probability measure cannot give inverse-polynomial mass to exponentially many formula-specific slices at the same input length.

#### One-Way Image-Coordinate

The strong marginal realizable edge is resolved by the image-coordinate class. For a target seed $s\in\{0,1\}^n$, the concept exposes the bits of $y=f(s)$ on the length-$n$ coordinate block. An improper learner can learn by memorizing positive coordinates, while a sufficiently accurate proper learner under the fixed marginal

$$
\mu_k=\frac{6}{\pi^2 k^2}
$$

must output a seed $t$ with $f(t)=f(s)$.

The weak target breaks exactly at "sufficiently accurate." In that proof the learner is run at

$$
\varepsilon_n=\frac{\mu_n}{3n}=\Theta(n^{-3}),
$$

so one wrong image coordinate contributes too much error. The present target has no $\varepsilon$ parameter. It asks only for some marginal-dependent inverse-polynomial advantage over $1/2$.

In the image-coordinate class, a hypothesis whose active length is far from $n$ is nearly all-zero on the target's active block. Against $c_s$, its error from that block is only $\mu_n/2=\Theta(n^{-2})$, plus whatever small mass its own active block contributes. This is already far below $1/2$ for large $n$, so weak proper learning can succeed without recovering any preimage. Thus the existing image-coordinate witness is too sparse for weak proper hardness.

A natural attempted repair is to replace image bits by a balanced code, for example parity labels $\langle f(s),a\rangle$ on random coordinates $a$. Under a length-$n$ uniform marginal, any proper weak advantage would force $f(t)=f(s)$, because distinct parities disagree on exactly half the points. But this again uses a marginal concentrated on the target length. Packing all lengths into one fixed marginal dilutes the length-$n$ block, and defining concepts to be inactive off their own length reintroduces the trivial weak learner. Making every target balanced on one common fixed marginal would require a computable global code whose distinct messages stay near distance $1/2$ under that same marginal while remaining efficiently improperly learnable under every marginal. I did not find such a construction in the checked sources or local atlas notes.

Goldreich-Levin-style hard-core predicates also do not immediately repair this. They can turn prediction of a hidden preimage bit into a cryptographic contradiction, but the image-coordinate setup gives the reduction the image $y=f(s)$ and asks the proper learner to output a seed. Weak correlation with visible image coordinates, or with an arbitrary code of the image, is not the same as recovering a preimage unless the fixed marginal/code makes every distinct proper seed have error at least $1/2$.

### Concrete Obstruction

The precise obstruction is a two-sided dilution/projection barrier.

For PCP-style witnesses, hard-instance variation lives in the marginal. Marginal nonuniformity then shields the target: each input-dependent marginal may have its own polynomial runtime bound.

For the one-way image-coordinate witness, hard-instance variation lives in the target labels, which is the right idea for fixed-marginal hardness. But the construction proves only a strong proper lower bound. Its information is located on a length-specific block of mass $\mu_n=\operatorname{poly}(1/n)$, and weak learning measures global error against $1/2$. A proper learner can obtain a global weak advantage while ignoring the block that would reveal the one-way image.

To resolve the edge as false, one needs a class with all three properties at once:

1. a uniform efficient weak improper learner for every marginal;
2. one fixed marginal $P^\star$ under which every target is globally balanced enough that weak proper advantage cannot ignore the hard information;
3. a representation constraint forcing any proper hypothesis with inverse-polynomial advantage under $P^\star$ to solve an NP-hard or cryptographic task.

The PCP active-slice witness has properties 1 and 3 only with an input-dependent marginal. The current one-way image-coordinate witness has properties 1 and 3 for strong accuracy, but not property 2 for weak accuracy.

### Next Directions

1. Search for a fixed-marginal, globally balanced one-way-code class. The promising shape is: labels are efficiently decodable/improperly learnable linear measurements of $f(s)$, while every distinct proper seed has distance at least $1/2-\operatorname{negl}(n)$ under one fixed marginal. The hard part is making this compatible with finite, polynomial-time examples for all target lengths.
2. Look for primary sources on distribution-specific or fixed-marginal representation hardness, especially lower bounds where the hard object is encoded in the target concept rather than the marginal.
3. Formalize a "weak dilution lemma" for active-slice reductions: if a fixed marginal assigns mass $w_x$ to an instance slice $x$, then a local constant weak-learning gap gives only global advantage $O(w_x)$; exponentially many slices force some $w_x$ below every inverse polynomial.
4. Try a conditional positive theorem under an explicit extra oracle: source plus efficient fixed-marginal approximate proper ERM/projection implies target. That would isolate exactly the missing computational assumption.
5. If future atlas edits are allowed before full resolution, add a non-status-changing note to the edge body recording that the one-way image-coordinate strong separation does not automatically imply the weak separation because the weak target lacks an $\varepsilon$ parameter.

### Exact Atlas Changes If Resolved

None, because this depth does not resolve the edge.

If a future balanced one-way-code construction works, the likely atlas update would be:

- `status: "false"`
- `evidence: conditional-counterexample`
- `assumptions: ["length-preserving one-way functions exist"]` or the stronger cryptographic assumption actually used
- `witnesses: ["balanced-one-way-code-class"]`
- `ref_keys`: include `kearns1994cryptographic`, `hastad1999prg`, and any coding/hard-core source used
- `summary`: "False under cryptographic assumptions: a fixed globally balanced marginal permits improper recovery of an easy code of the image, while weak proper advantage would recover a valid preimage."

## Depth-3 Entry - 2026-05-05

### Verdict

Still `unresolved`; keep the atlas edge `open` with `evidence: unknown`.

The new lead was to alter the two near-miss witnesses rather than reuse them verbatim:

1. make PCP active slices live under a single fixed marginal, or
2. replace one-way image coordinates by a balanced image-code, for example a Hadamard/parity code of the image.

Both variants clarify the shape of a possible counterexample, but neither currently gives an atlas-ready separation. The PCP variant still needs too many hard slices to have inverse-polynomial mass under one fixed distribution. The balanced one-way-code variant blocks weak proper learning for a length-specific marginal, but the marginal-nonuniform target allows the runtime polynomial to depend on that marginal; packing all lengths into one fixed marginal reintroduces dilution or lets the learner gain weak advantage away from the challenged block.

No exact atlas changes are justified.

### Sources Checked

Local notes and witnesses:

- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`

Primary-source hooks checked:

- Håstad and Khot, "Query Efficient PCPs with Perfect Completeness," Theory of Computing 2005, https://theoryofcomputing.org/articles/v001a007/. Used for logarithmic randomness, perfect completeness, and soundness below $1/2$.
- Karp, "Reducibility Among Combinatorial Problems," 1972. Used only as the NP-completeness anchor for PCP reductions.
- Benedek and Itai, "Learnability with respect to fixed distributions," Theoretical Computer Science 1991, https://doi.org/10.1016/0304-3975(91)90026-X. Used for the fixed-distribution distinction and the warning that fixed-distribution learnability is not automatically an efficient computational properization theorem.
- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability," OpenReview 2025, https://openreview.net/forum?id=aoVCFtox89. Used for the quantifier pattern that rates may depend on the marginal.
- Kearns and Valiant, "Cryptographic Limitations on Learning Boolean Formulae and Finite Automata," JACM 1994, https://doi.org/10.1145/174644.174647. Used as the representation-independent weak-prediction cryptographic-hardness background.
- Håstad, Impagliazzo, Levin, and Luby, "A Pseudorandom Generator from any One-Way Function," SIAM Journal on Computing 1999, https://doi.org/10.1137/S0097539793244708. Used as the standard one-way-function-to-PRG anchor.
- Goldreich and Levin, "A Hard-Core Predicate for all One-Way Functions," STOC 1989, author PDF checked at https://www.cs.bu.edu/fac/lnd/pdf/hard.pdf. Used for the balanced parity/hard-core idea.
- Mahaney, "Sparse Complete Sets for NP: Solution of a Conjecture of Berman and Hartmanis," JCSS 1982 / SIAM pointer https://doi.org/10.1137/0208034. Used only as a complexity-theoretic warning about trying to make the hard PCP family sparse enough to receive large fixed marginal mass.

### Theorem Route

The theorem route is unchanged: I still do not see a general implication from weak improper to weak proper learning under the computational marginal-nonuniform definitions.

For a fixed marginal $P$, the source learner supplies a uniform weak predictor $g$ outside $\mathcal C$. The target needs an efficient search procedure that returns some $h\in\mathcal C$ with

$$
\operatorname{err}_P(h,c)\le \frac12-\gamma_P(s)
$$

for every realizable target $c$. Existence is trivial because $c$ itself has zero error. Efficient target-independent proper search is not. The PCP and one-way constructions below keep demonstrating that the hard part is not weak prediction as a statistical task; it is recovering a permitted representation.

The balanced-code attempt also does not produce a hidden positive theorem. It shows that if the improper learner can recover an easily learnable codeword, then proper projection may require solving a hard inverse problem. That is evidence against a black-box properization theorem, not evidence for one. I found no checked source that gives a computational fixed-marginal projection theorem strong enough to imply this edge.

### Counterexample Route

#### PCP Active-Slice Variants

The tempting modification is to fix one global marginal $P^\star$ over all active PCP slices:

$$
P^\star(\varphi,r)=w_\varphi\cdot U_{\{0,1\}^{R(|\varphi|)}}(r),
$$

where $R(n)=O(\log n)$. A proper concept indexed by $(\varphi,\pi)$ accepts on the $\varphi$-slice according to the verifier and is inactive elsewhere. An improper learner still has an easy route on any one slice, because the active slice has polynomial size.

This does not block weak proper learning. If $P^\star$ spreads mass over all formulas of length $n$, then some length-$n$ formulas have exponentially small $w_\varphi$. The local PCP gap below $1/2$ is multiplied by $w_\varphi$, so it becomes exponentially smaller than the inverse-polynomial global advantage allowed in the weak target. A proper hypothesis for a different slice, or any proper hypothesis with small off-slice support, can already be globally weak against a target concentrated on such a tiny slice without solving the PCP instance.

Trying to give every relevant hard slice inverse-polynomial mass forces a sparse hard family. That would require the reduction from arbitrary SAT instances to land in only polynomially many heavy slices per length. This is exactly the kind of sparsification that runs into Mahaney-style barriers for NP-hard sets under standard assumptions. This is not a formal impossibility theorem for every randomized or promise variant, but it blocks the straightforward fixed-marginal PCP route.

A second attempted repair is to add a large common balancing slice so that each target has global mass near $1/2$ and cannot be ignored. The problem is then improper learnability. If the balancing labels encode an arbitrary proof-dependent or instance-dependent hard object on a large domain, a memorization learner no longer generalizes. If the balancing labels are easy enough for the improper learner to learn under every marginal, they tend to create a cheap weak handle for proper learners unless the proper representation is carefully constrained. I do not have a construction satisfying all three requirements at once.

#### One-Way Image-Code Variants

The most promising different lead is to replace coordinate bits by a balanced code of the one-way image. Let $f:\{0,1\}^n\to\{0,1\}^n$ be length preserving and define, on the length-$n$ block,

$$
c_s(a)=\langle f(s),a\rangle \pmod 2,
\qquad a\in\{0,1\}^n.
$$

Under the uniform marginal on $\{0,1\}^n$, this is much better than the old sparse coordinate witness. An improper learner can learn the parity vector $y=f(s)$ by linear equations and output the parity hypothesis indexed by $y$, without finding a seed $t$ with $f(t)=y$. A proper hypothesis must be indexed by some seed $t$ and represents the parity vector $f(t)$. Since distinct Hadamard codewords disagree on exactly half the points, any weak proper advantage under the length-$n$ uniform marginal forces $f(t)=f(s)$ and hence inverts the one-way function.

This would separate weak improper from weak proper learning in a length-specific fixed-distribution model. It still does not refute the atlas target. If the reduction uses the marginal $P_n=U_{\{0,1\}^n}$, then the marginal-nonuniform runtime polynomial is $p_{P_n}$, which may depend arbitrarily on $n$. That does not yield a uniform polynomial-time inverter.

Packing all lengths into one fixed marginal

$$
P^\star=\sum_{n\ge 1}\mu_n P_n
$$

returns to the old problem. If a length-$n$ target is active only on the length-$n$ block, then the block has mass $\mu_n$ and a weak learner may be able to win globally without identifying $f(s)$. If the target is made balanced on all other blocks, the reduction from an inversion challenge $y=f(s)$ must still be able to simulate labels on those other blocks without knowing $s$. Image-dependent labels are simulable on the challenged length; seed-dependent labels away from that length are not.

Goldreich-Levin does not by itself close this gap. It says that inner products with a hidden preimage can be hard to predict from the image. Here the learner's examples must be labeled by a concept that the reduction can simulate from the one-way challenge. Using $\langle f(s),a\rangle$ is simulable and improperly learnable, but then a fixed all-length marginal dilutes the challenged length. Using $\langle s,a\rangle$ could give hard-core prediction, but the reduction cannot label examples without knowing $s$.

The weak-handle witness confirms the danger from the other side. Once constants or singletons are admitted as proper hypotheses, weak proper learning becomes easy even though strong proper learning remains cryptographically hard. A successful weak separation must therefore make every cheap global handle unavailable while keeping improper weak learning efficient under arbitrary marginals.

### Concrete Obstruction

The obstruction is now sharper than in Depth 2:

$$
\text{balanced enough to force weak proper inversion}
\quad+\quad
\text{fixed across all target sizes}
\quad+\quad
\text{simulable from the hard challenge}
$$

is hard to reconcile with efficient improper learnability.

PCP active-slice variants can make proper hypotheses certify hard instances, but the hard instance sits in the slice name. Under marginal nonuniformity, an input-dependent marginal gives no uniform runtime bound; under one fixed packed marginal, exponentially many slices dilute the weak gap.

One-way image-code variants can make weak proper advantage imply inversion under a length-specific balanced marginal. But using a different marginal for each length again loses the uniform cryptographic reduction. A single all-length marginal either dilutes the challenged length or requires labels away from the challenged length that the inverter cannot simulate from $y=f(s)$.

Thus the missing object is not just a balanced code. It is a globally balanced, fixed-marginal, challenge-simulable code family whose proper representations are exactly hard-to-find preimages, while an improper learner can still learn enough of the code under every marginal in marginal-dependent polynomial time.

### Next Directions

1. Formalize the Hadamard image-code as a clean failed witness. It is useful because it isolates precisely where marginal-nonuniformity defeats a length-specific fixed-distribution weak separation.
2. Search for a cryptographic construction with public, challenge-simulable labels on every length block, so an inverter given $y=f(s)$ can sample the entire fixed marginal, not just the challenged block.
3. Investigate whether a direct-product or error-correcting-code construction can make correlation on any nonnegligible block recover the same preimage, rather than allowing the learner to gain weak advantage on irrelevant blocks.
4. For PCPs, prove a small lemma in the scratchpad: any fixed marginal assigning inverse-polynomial mass to every formula slice at a given length can support only polynomially many such slices. Then state explicitly why SAT-hardness would need a non-sparse reduction target.
5. Look for fixed-distribution proper lower bounds where the hard target is encoded in the concept, not the marginal, and where the simulator can label samples from one fixed distribution using only the hard challenge.

### Exact Atlas Changes If Resolved

None. This depth does not resolve the edge and does not justify editing atlas files.

If the Hadamard image-code idea is later upgraded to a genuine fixed-marginal all-length construction, the likely atlas change would be:

- `status: "false"`
- `evidence: conditional-counterexample`
- `assumptions: ["length-preserving one-way functions exist"]` or the exact stronger primitive needed for all-length challenge simulation
- `witnesses: ["fixed-marginal-balanced-one-way-image-code-class"]`
- `ref_keys`: include `kearns1994cryptographic`, `hastad1999prg`, `goldreich1989hardcore`, and any coding/direct-product source actually used
- `summary`: "False under cryptographic assumptions: an improper learner can recover a public balanced code of the one-way image, while any weak proper learner under one fixed marginal must output a preimage."

## Depth-4 Entry - 2026-05-05

### Verdict

Still `unresolved`; keep the atlas edge `open` with `evidence: unknown`.

The new PCP lead was to keep the active-slice proper hypotheses hard, but add "improper-only handles" that make the class marginal-nonuniform weak-improper learnable. I do not currently see a construction that does this without creating proper weak handles or reintroducing the same fixed-marginal dilution that defeated the earlier PCP attempts.

No exact atlas changes are justified.

### Sources Checked

Local notes rechecked:

- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`

Primary-source hooks from the prior entries remain the relevant ones:

- Håstad and Khot, "Query Efficient PCPs with Perfect Completeness," Theory of Computing 2005, https://doi.org/10.4086/toc.2005.v001a007. Used for perfect-completeness PCPs with logarithmic randomness and soundness below $1/2$.
- Karp, "Reducibility Among Combinatorial Problems," 1972, https://doi.org/10.1007/978-3-540-68279-0_8. Used only as the NP-completeness anchor.
- Benedek and Itai, "Learnability with respect to fixed distributions," TCS 1991, https://doi.org/10.1016/0304-3975(91)90026-X, and Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability," 2025, https://openreview.net/forum?id=aoVCFtox89. Used for the marginal-dependent-rate quantifier pattern.
- Mahaney, "Sparse Complete Sets for NP," JCSS 1982 / SIAM pointer https://doi.org/10.1137/0208034. Used as a warning sign for attempts to make only polynomially many PCP slices per length carry inverse-polynomial mass.

### Theorem Route

The theorem route remains blocked by efficient projection.

For a fixed marginal $P$, a weak improper learner may output a handle outside $\mathcal C$: a slice indicator, a one-slice lookup table, a default predictor with a learned exception set, or some other hypothesis family that is not a permitted proper representation. Such handles can be excellent weak predictors. But the target asks for an efficient algorithm that outputs an element of $\mathcal C$ itself.

The PCP handle thought experiment does not reveal a generic way to convert an external handle into a proper PCP proof concept. If the handle says only "this is the active slice," it contains no proof. If it says "these verifier random strings accept," then it is essentially a lookup table for the proof's acceptance pattern, and finding a proper proof with comparable acceptance is exactly the hard search problem. The existence of the realizing proof gives a proper hypothesis statistically, but not an efficient target-independent method for finding it.

Thus Depth 4 gives no positive properization theorem. It sharpens the missing operation: one would need an efficient projection from an improper weak handle to a proper proof hypothesis under an arbitrary fixed marginal, and the PCP construction is designed precisely so that this projection certifies an NP instance.

### Counterexample Route

The attempted counterexample has the following desired shape.

Use the active-slice PCP class as before. A proper hypothesis is indexed by an instance-proof pair $(\varphi,\pi)$ and behaves like the PCP verifier on the $\varphi$-slice. To beat marginal nonuniformity, try to place all slices under one fixed marginal $P^\star$ and give the improper learner extra external handles, not in $\mathcal C$, so it can weakly learn every realizable target even when the target's own slice has substantial $P^\star$-mass.

The first handle family is one-slice lookup tables. These make improper learning easy on a polynomial-size active slice: from enough samples, the learner can memorize or ERM over the observed slice. They do not solve the fixed-marginal weak hardness problem. If $P^\star$ spreads mass over exponentially many instance slices, most slices have exponentially small mass, so a proper learner can obtain its required global weak advantage without solving the local PCP instance. If $P^\star$ gives inverse-polynomial mass to every challenged slice, then only polynomially many slices per length can be challenged; turning arbitrary SAT into such a sparse family would require a nontrivial sparsification of the hard language.

The second handle family is a large common balancing handle. The idea is to attach an easy, target-correlated region of large $P^\star$-mass that an improper learner can exploit, while proper hypotheses still need the PCP proof to gain weak advantage. This runs into a proper-handle leak. If the common region has target-independent labels, then some proper hypotheses from irrelevant slices, constants if present, or near-default concepts agree with that region and become weak proper handles. If the common region has target-dependent labels, then either the improper learner cannot generalize there under arbitrary marginals, or the handle itself carries enough information to act as an alternate proper representation unless the class is carefully forbidden from expressing it.

The third variant is to make cross-slice behavior balanced: every proper concept should disagree with every unrelated target on about half of the fixed marginal, so off-slice concepts cannot serve as weak handles. This protects hardness, but it damages the improper side. The improper learner must now learn the balancing labels on a large part of $P^\star$, not just a polynomial active slice. If those labels are generated by an easy public rule, proper concepts tend to inherit an easy weak correlation. If they are generated by the PCP proof or by a hidden hard object, the reduction can no longer claim efficient weak-improper learnability for every marginal.

So the "improper-only" adjective is not enough. Because the source learner may already output arbitrary hypotheses, external handles are allowed for free. The hard part is making those handles both sample-learnable for all marginals and unavailable to every proper concept under the one fixed marginal used for hardness.

### Concrete Obstruction

The obstruction is a handle leakage trilemma.

1. **Local handles dilute.** A handle confined to the PCP active slice gives only $w_\varphi$ global advantage under a packed fixed marginal. With exponentially many formulas of a given length, some $w_\varphi$ is exponentially small, below the inverse-polynomial edge relevant to weak learning.

2. **Global easy handles leak.** A handle with large fixed-marginal mass and easy labels makes weak improper learning plausible, but the same easy mass tends to create a proper weak handle through constants, off-slice proof concepts, default concepts, or any proper hypothesis sharing the common labels.

3. **Global hard handles break the source.** A handle whose large-mass labels are proof-dependent or instance-dependent can block proper shortcuts, but then the improper learner must learn a hard global object under arbitrary marginals. Memorization no longer suffices unless the support is polynomially small, which returns to the local-handle case.

This is the PCP analogue of the weak-handle warning from the one-way image-coordinate notes. Adding proper handles made weak proper learning easy there; keeping the handles improper avoids adding them to $\mathcal C$ syntactically, but it does not by itself stop existing proper concepts from approximating the same easy mass well enough for weak learning.

### Next Directions

1. Formalize the handle leakage trilemma as a lemma for active-slice constructions: under one fixed marginal, any large-mass easy region that is common across targets must be checked for off-slice proper hypotheses with weak correlation.
2. Try a promise-family version with only polynomially many hard PCP slices per length. This would need a careful complexity assumption or a promise problem, since ordinary NP-hardness plus polynomially many heavy slices runs into sparse-hard-set concerns.
3. Look for PCP reductions where the hard object is encoded in the target concept rather than the marginal slice name, so a single fixed marginal can remain balanced without spreading mass over exponentially many instance-specific slices.
4. Investigate whether error-correcting cross-slice labels can be public, globally balanced, and still proof-binding: proper concepts would need a real proof to correlate, while improper learners could recover only the public code. I do not currently know such a PCP construction.
5. Keep the atlas edge open unless a future construction supplies all three pieces simultaneously: marginal-nonuniform weak-improper learnability, one fixed marginal for weak-proper hardness, and a proof that every proper weak advantage recovers or certifies the PCP witness.

## Depth-5 Entry - 2026-05-05

### Final Verdict

Final depth verdict: `unresolved`; keep the atlas edge

`efficient-marginal-nonuniform-weak-realizable-improper-pac -> efficient-marginal-nonuniform-weak-realizable-proper-pac`

as `status: "open"` with `evidence: unknown`.

I found no atlas-ready theorem converting the source to the target, and no atlas-ready counterexample separating them. The mature state of the search is not "probably true" or "probably false"; it is a precise open computational properization problem. Existing hardness routes show why a generic projection should be treated with suspicion, but marginal-nonuniformity and weak advantage defeat every checked separation attempt.

No atlas files should be changed from this scratchpad pass.

### Sources Checked

Local atlas and scratchpad sources synthesized:

- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- The neighboring scratchpads for the strong marginal realizable properization edge and the weak marginal agnostic properization edge.

Primary sources synthesized from prior depths:

- Schapire, "The Strength of Weak Learnability" (1990), DOI https://doi.org/10.1023/A:1022648800760. Used for the classical distribution-free weak-to-strong theorem and the warning that boosting outputs improper combinations in general.
- Pitt and Valiant, "Computational Limitations on Learning from Examples" (1988), DOI https://doi.org/10.1145/48014.63140. Used for representation-dependent proper hardness.
- Khot and Saket, "Hardness of Minimizing and Learning DNF Expressions" (2008), DOI https://doi.org/10.1109/FOCS.2008.37. Used for constant-advantage proper DNF hardness, still distribution-free rather than fixed-marginal in the needed sense.
- Håstad and Khot, "Query Efficient PCPs with Perfect Completeness" (2005), DOI https://doi.org/10.4086/toc.2005.v001a007. Used for perfect-completeness PCP active-slice witnesses.
- Benedek and Itai, "Learnability with respect to fixed distributions" (1991), DOI https://doi.org/10.1016/0304-3975(91)90026-X, and Ben-David, Benedek, and Mansour, "A parameterization scheme for classifying models of PAC learnability" (1995), DOI https://doi.org/10.1006/inco.1995.1094. Used for fixed-distribution and uniformity-parameter bookkeeping.
- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability" (2025), OpenReview https://openreview.net/forum?id=aoVCFtox89. Used for the modern marginal-nonuniform quantifier pattern.
- Kearns and Valiant, "Cryptographic Limitations on Learning Boolean Formulae and Finite Automata" (1994), DOI https://doi.org/10.1145/174644.174647; Håstad, Impagliazzo, Levin, and Luby, "A Pseudorandom Generator from any One-Way Function" (1999), DOI https://doi.org/10.1137/S0097539793244708; and Goldreich and Levin, "A Hard-Core Predicate for all One-Way Functions" (1989). Used for the one-way and balanced-code attempts.
- Mahaney, "Sparse Complete Sets for NP" (1982), DOI pointer https://doi.org/10.1137/0208034. Used only as a barrier warning for fixed-marginal PCP slice packing.

New Depth-5 source checked:

- Asilis, Devic, Dughmi, Sharan, and Teng, "Proper Learnability and the Role of Unlabeled Data" (ALT 2025), OpenReview https://openreview.net/forum?id=lEhg21XO0R. This was the final new lead: in their distribution-fixed PAC model, the learner receives the marginal distribution and there is an optimal proper learner for finite learning problems and metric losses. This does not resolve the present edge because the atlas target is binary, computational, and only marginal-nonuniform in its bounds: the learner is still one uniform algorithm and is not handed a marginal-specific projection oracle or marginal-specific code.

### Theorem Route

Goal: prove that every efficiently marginal-nonuniform weak realizable improper learner can be converted into an efficiently marginal-nonuniform weak realizable proper learner for the same binary class.

The sample-theoretic intuition points in the positive direction but stops before the computational requirement. In binary classification, finite VC-style arguments can often replace improper hypotheses by proper ERM once runtime is ignored. Marginal-nonuniformity also permits the sample polynomial and weak edge to depend on the fixed marginal $P$.

The missing step is efficient proper search. Given samples from $(P,c)$ and an outside weak hypothesis $g$, one needs a uniform algorithm that finds some $h\in\mathcal C$ with

$$
\operatorname{err}_P(h,c)\le \frac12-\gamma_P(s).
$$

The existence of such an $h$ is trivial because $c$ itself has zero error. But none of the checked sources gives a uniform polynomial-time method for finding it. Boosting improves weak predictors but generally outputs votes or other improper compositions. Fixed-distribution and distribution-fixed learning results clarify the quantifiers around $P$, but they do not provide a marginal-specific computational projection usable by a single atlas learner.

The Depth-5 lead from Asilis et al. is especially clarifying. If the learner is given the full marginal distribution, there are broad information-theoretic proper-learning statements. The atlas target is weaker in advice and stronger in computation: the learner receives labeled examples from $P$, not an explicit distribution object or an arbitrary $P$-dependent algorithm. Its runtime bound may depend on $P$, but the code of the learner cannot. That distinction keeps the theorem route blocked.

### Counterexample Route

The strongest counterexample evidence still comes from three near misses.

First, PCP active-slice classes separate weak improper from weak proper learning in distribution-free settings under standard complexity assumptions. The construction chooses a marginal tied to the NP instance, uses perfect completeness for realizability, and uses soundness below $1/2$ to make weak proper success certify the instance. This fails against the present target because a marginal $P_\varphi$ depending on the input formula gives only a polynomial $p_{P_\varphi}$ that may depend arbitrarily on $\varphi$. A reduction gets no uniform polynomial-time SAT solver.

Second, packing all PCP slices into one fixed marginal creates dilution. If exponentially many formulas of length $n$ receive mass under a single $P^\star$, most formula slices have exponentially small mass. The local PCP gap is multiplied by the slice weight, so a global weak advantage can be achieved without solving the local instance. Giving every challenged slice inverse-polynomial mass would require only polynomially many heavy slices per length, which is not supplied by ordinary NP-hard reductions and runs into sparse-hard-set concerns.

Third, the one-way image-coordinate and Hadamard image-code ideas show how to make proper weak advantage imply inversion under a length-specific balanced marginal. For a fixed length $n$, labels of the form $\langle f(s),a\rangle$ are simulable from $y=f(s)$ and are improperly learnable by recovering the image/codeword, while a proper hypothesis with nontrivial correlation must output a seed mapping to the same image. But the marginal-nonuniform target again defeats this if the marginal is $P_n$ for each length, because the runtime polynomial may depend on $P_n$ and hence on $n$. Packing all lengths into one fixed marginal either dilutes the challenged block or requires labels on other blocks that an inverter given only $y=f(s)$ cannot simulate.

The Depth-4 "improper-only handle" PCP variant also remains a near miss. Local handles dilute; global easy handles leak to proper weak predictors; global hard handles break the source learner. I do not see a way to satisfy all requirements simultaneously.

### Concrete Obstruction

The final obstruction is the interaction of three constraints:

1. **Uniform learner, nonuniform bounds.** The learner must be one algorithm for all marginals, but the polynomial bound and advantage may depend on the marginal. This is enough nonuniformity to block input-dependent-marginal hardness reductions, but not enough to hand the learner a proper projection oracle.

2. **Weak global advantage.** The target asks only for inverse-polynomial advantage over $1/2$, not accuracy $\varepsilon$. Any hard information confined to a small block or slice can be ignored unless the fixed marginal gives that block enough mass.

3. **Proper projection is computational.** The target concept itself is always a perfect proper hypothesis, but finding a good proper representation may encode an NP witness or a cryptographic preimage. Improper learners can use lookup tables, codeword hypotheses, votes, or other external handles that need not be convertible into $\mathcal C$ efficiently.

In compact quantifier form, the source and target both allow

$$
\forall P\ \exists p_P,\gamma_P\ \forall c,
$$

but the implication would require a uniform computational transformation from outside hypotheses to proper concepts. Existing positive sample-complexity theory proves existence, not efficient projection. Existing negative proper-learning theory proves hardness, but usually by varying the marginal or by requiring strong accuracy.

### Atlas-Ready Open-Note Text

Recommended replacement or augmentation for the edge body, without changing the status:

```markdown
## Verdict

`open`.

This is the weak marginal-nonuniform properization edge. The source supplies one uniform learner whose runtime and weak advantage may depend on the marginal, but whose output may lie outside the concept class. The target asks for the same marginal-nonuniform weak realizable guarantee with output in the original class.

## Proof Status

**Theorem route.** No general computational properization theorem is known here. For a fixed marginal, the realizing concept itself is a zero-error proper hypothesis, so the obstacle is not statistical existence. The obstacle is efficient search: an improper weak learner may output a lookup table, codeword, vote, or other external handle, and standard boosting does not project such a hypothesis back into the representation class.

**Counterexample route.** Standard proper-learning hardness witnesses are near misses. PCP active-slice reductions refute distribution-free weak proper learning, but their hard marginal varies with the input instance. Marginal-nonuniformity permits the runtime polynomial to depend on that marginal, so the reduction does not yield a uniform polynomial-time decision procedure. Packing all slices into one fixed marginal dilutes the local PCP gap below the inverse-polynomial global advantage required for weak learning. One-way image-coordinate and balanced image-code witnesses can force proper inversion at a fixed length or under strong accuracy, but the weak all-length marginal version again suffers from dilution or from labels that cannot be simulated from the cryptographic challenge.

**Conclusion.** Keep this edge open. A resolution would need either a uniform efficient projection theorem from marginal-nonuniform weak improper learners to proper learners, or a fixed-marginal weak proper hardness construction that avoids both input-dependent-marginal nonuniformity and weak-advantage dilution.
```
