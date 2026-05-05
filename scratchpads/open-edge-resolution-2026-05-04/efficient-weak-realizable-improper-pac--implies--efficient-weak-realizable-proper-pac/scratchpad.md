# Open Edge Resolution Scratchpad

Edge: `efficient-weak-realizable-improper-pac -> efficient-weak-realizable-proper-pac`
Depth: 0 root pending
Current atlas status: `open`, evidence `unknown`
Family: `properization-open`

## Research Log

## Sources Checked

## Proof Or Counterexample Attempts

## Verdict

Unresolved pending depth-0 investigation.

## Follow-Up Directions

## Depth-0 Entry - 2026-05-04

### Relevant Definitions

- Source node: `efficient-weak-realizable-improper-pac`. A randomized polynomial-time distribution-free realizable learner may output hypotheses outside the target class and only needs error at most $1/2-\gamma$ for inverse-polynomial $\gamma$.
- Target node: `efficient-weak-realizable-proper-pac`. The same weak realizable distribution-free guarantee is required, but the output must be a member of the original concept class $\mathcal C$.
- Registry context: this edge changes only the `properness` axis from `improper` to `proper` while keeping computational efficiency, distribution-free learning, realizability, and weak strength fixed. The edge family registry permits an `open/unknown` properization edge unless there is either a generic theorem or a conditional counterexample.
- Current implication note verdict: `open`, with the stated obstruction that no known polynomial-time generic properization converts an improper inverse-polynomial weak learner into a proper one.

### Sources Checked

- Atlas definition notes:
  - `atlas/definitions/efficient-weak-realizable-improper-pac.md`
  - `atlas/definitions/efficient-weak-realizable-proper-pac.md`
- Atlas edge and argument notes:
  - `atlas/implications/efficient-weak-realizable-improper-pac--implies--efficient-weak-realizable-proper-pac.md`
  - `atlas/arguments/properization-open.md`
  - `atlas/arguments/realizable-boosting.md`
  - `atlas/arguments/clause-satisfaction-proper-hardness.md`
  - `atlas/arguments/fixed-k-term-dnf-proper-boosting-separation.md`
- Atlas witness and registry notes:
  - `atlas/witnesses/clause-satisfaction-lookup-class.md`
  - `atlas/witnesses/fixed-k-term-DNF.md`
  - `atlas/registry/axes.yml`
  - `atlas/registry/edge_families.yml`
- Primary and near-primary sources checked:
  - Schapire, "The Strength of Weak Learnability" (1990), especially the representation-independent weak-to-strong theorem and the "Fixed hypotheses" discussion.
  - Pitt and Valiant, "Computational Limitations on Learning from Examples" (1988), especially the representation-dependent hardness framing and hardness for disjunctions of two monomials.
  - Blumer, Ehrenfeucht, Haussler, and Warmuth, "Learnability and the Vapnik-Chervonenkis Dimension" (1989), especially the finite-VC/sample-only proper ERM route and the separate computational proper-learnability requirements.
  - Khot and Saket, "Hardness of Minimizing and Learning DNF Expressions" (2008), especially Theorem 5 on learning two-term DNF by $t$-term DNF only to constant advantage.
  - Alekhnovich, Braverman, Feldman, Klivans, and Pitassi, "The Complexity of Properly Learning Simple Concept Classes" (2008), as a check for stronger proper-learning hardness; it supports strong proper-learning separations, but did not give the missing inverse-polynomial weak separation.

### Theorem And Counterexample Attempts

1. **Generic boosting/properization attempt.** Schapire boosting turns an improper weak learner into a high-accuracy vote of weak hypotheses. This proves the neighboring improper weak-to-strong direction, but the final vote is not guaranteed to lie in $\mathcal C$. The "fixed hypotheses" discussion in Schapire explicitly identifies this representation-preservation issue, so this does not prove the target.

2. **Sample-complexity/VC attempt.** Ignoring runtime, weak distribution-free learnability gives finite-sample control, and finite VC dimension plus exhaustive ERM can give proper sample-efficient learning. The obstruction is computational: selecting a consistent or low-error member of $\mathcal C$ is exactly where proper learning can encode NP-hard search. Blumer et al. separate finite sample control from the existence of an efficient proper hypothesis finder, so this route does not prove the efficient target.

3. **Fixed-$k$ DNF counterexample attempt.** Fixed-$k$-term DNF is not a counterexample. Schapire's sketch gives a proper weak learner with inverse-polynomial advantage by using constants or a small clause/disjunction witness, while Pitt-Valiant style hardness separates weak proper learning from strong proper learning. Khot-Saket comes closer by ruling out constant-advantage learning of two-term DNF by any fixed number of DNF terms under $\mathrm{NP}\nsubseteq\mathrm{RP}$, but the atlas target only asks for inverse-polynomial advantage. I found no valid amplification from an inverse-polynomial proper weak learner to the fixed constant advantage ruled out by Khot-Saket that keeps the final hypothesis proper.

4. **Clause-satisfaction lookup counterexample attempt.** The lookup class satisfies the source because an improper learner can memorize or estimate labels on the polynomial-size clause domain. The recorded proper hardness proof for strong realizable learning needs accuracy below about $1/M$ on the uniform distribution over the $M$ clauses of a formula, so that every clause is forced correct and a satisfying assignment can be recovered. A weak proper learner would only return an assignment beating $1/2$ by an inverse-polynomial margin. Accepting only when the returned assignment satisfies all clauses no longer gives one-sided success in the satisfiable case. Positive-only clause distributions are also too weak for this purpose, since random assignments already satisfy a large fraction of ordinary clauses. I did not obtain a SAT/RP reduction from merely weak proper performance for this witness.

5. **Representation-engineered/gap attempt.** A conditional false result would need a class that is efficiently weakly learnable improperly, but for which every efficient proper learner fails to obtain even $1/2+1/\operatorname{poly}$ agreement on some realizable distribution. The natural way to try this is a PCP/gap-CSP encoding whose domain remains lookup-learnable improperly while proper hypotheses encode hard witnesses. The checked sources give high-accuracy proper hardness or constant-advantage hardness for fixed-size DNF hypotheses, but not the exact inverse-polynomial weak proper lower bound needed for this atlas edge.

### Precise Obstruction

The unresolved quantitative point is the inverse-polynomial weak margin. Existing proper-learning hardness notes in the atlas force either near-perfect proper accuracy, as in the clause-satisfaction lookup reduction, or failure of constant advantage for restricted DNF hypotheses, as in Khot-Saket. Neither rules out a proper learner that always obtains a very small inverse-polynomial edge over random guessing.

Conversely, the positive sample-only reasoning does not become an efficient theorem because proper ERM or even weak proper correlation search can be computationally hard. Thus neither atlas-valid status change is justified: there is no theorem for `true/theorem`, and no source-verified witness for `false/conditional-counterexample`.

### Final Verdict

`unresolved`.

I would keep the atlas edge at `status: "open"` and `evidence: unknown`.

### Follow-Up Directions

- Inspect the Khot-Saket proof parameters, not just the theorem statement, to see whether the constant $\epsilon$ in the two-term-DNF weak-learning hardness can be made inverse-polynomial while preserving a polynomial-time randomized reduction. If yes, this may yield a conditional false edge; if no, record the parameter blowup explicitly.
- Analyze the clause-satisfaction lookup class directly at the weak proper level. Either find a weak proper learner for it, which would remove it as a candidate witness, or formulate a gap version in which realizability by an assignment and failure of $1/2+1/\operatorname{poly}$ agreement are both NP-hard to distinguish.
- Search for representation-dependent hardness results stated specifically as "not weakly properly learnable" with inverse-polynomial advantage, rather than strong PAC hardness or fixed constant-advantage hardness.
- Check whether proof-complexity/automatizability connections in Alekhnovich et al. can be weakened to a weak proper learner. The current theorems are strong PAC statements, but their framework may suggest the right hard search object.
- If no natural class works, consider a deliberately engineered PCP lookup class whose improper learner estimates a finite table while proper hypotheses encode PCP witnesses. Any such proposal must verify polynomial evaluation, realizability, source weak improper learning, and an explicit complexity assumption before changing the atlas edge.

## Depth-1 Entry - 2026-05-04

### Leads Pursued

Depth 1 focused on the three quantitative weak-properization leads from depth 0:

1. whether the Khot--Saket two-term-DNF hardness can be pushed from constant advantage to inverse-polynomial advantage;
2. whether the clause-satisfaction lookup witness itself rules out weak proper learning;
3. whether the literature states a representation-dependent hardness theorem that explicitly rules out weak proper PAC learning with inverse-polynomial advantage.

### Additional Sources Checked

- Schapire, "The Strength of Weak Learnability" (1990), author PDF: https://www.schapire.net/papers/strengthofweak.pdf.
- Khot and Saket, "Hardness of Minimizing and Learning DNF Expressions" (FOCS 2008), author PDF: https://cs.nyu.edu/~khot/papers/minDNF.pdf; DOI: https://doi.org/10.1109/FOCS.2008.37.
- Alekhnovich, Braverman, Feldman, Klivans, and Pitassi, "The Complexity of Properly Learning Simple Concept Classes" (JCSS 2008), author PDF: https://mbraverm.princeton.edu/files/ABFKP_Proper_Hardness_08.pdf; DOI: https://doi.org/10.1016/j.jcss.2007.04.011.
- Ghoshal and Saket, "Hardness of Learning DNFs using Halfspaces" (STOC 2021), conference abstract checked at https://acm-stoc.org/stoc2021/toc.html.
- Håstad, "Some Optimal Inapproximability Results" (JACM 2001), DOI: https://doi.org/10.1145/502090.502098, plus the ICALP 2025 promise-equations paper's summary of the classical Max-3-LIN threshold: https://doi.org/10.4230/LIPIcs.ICALP.2025.38.
- Web searches for phrases including "weak proper learning", "not weakly properly learnable", "inverse polynomial advantage", "1/2+1/poly", "proper PAC", and "DNF".

### Lead 1: Khot--Saket Parameters

The Khot--Saket theorem remains a near miss, not a resolution.

Their Appendix A proves the two-term-DNF hardness via an equivalent two-clause-CNF construction from Label Cover. In the NO-case analysis, a hypothetical $t$-clause CNF with agreement $1/2+\epsilon$ yields a Label Cover labeling satisfying a fraction

$$
p^*(\epsilon,t) \gtrsim {\epsilon^2 \over t}\cdot \nu,
\qquad
\nu =
\left({1\over \mu}\log {t\over \epsilon'}\right)^{-1},
\qquad
\mu={\epsilon^2\over 16t^3},
\qquad
\epsilon'\ge \epsilon/8.
$$

Thus $p^*(\epsilon,t)$ is roughly $\epsilon^4/(t^4\log(t/\epsilon))$ up to constants. For constant $\epsilon$ and fixed $t$, this is still a constant, so constant-soundness Label Cover is enough. For $\epsilon=1/\operatorname{poly}(n)$, the same proof would require inverse-polynomial Label Cover soundness while preserving the rest of the reduction.

Two more proof details block a direct atlas-ready strengthening:

- The argument that not all clauses contain a negative literal uses the coordinate sparsity term $\xi(N)=o(1)$ and then requires $t\xi(N)\le \epsilon/2$. This is automatic for constant $\epsilon$, but for an unspecified inverse-polynomial weak edge one would need explicit padding or a sharper construction whose sparsity beats the unknown weak learner's polynomial.
- The published learning theorem keeps the Label Cover alphabet sizes, degrees, perturbation parameter, and support-size bookkeeping constant. If one drives Label Cover soundness down to $1/\operatorname{poly}(n)$ by repetition, those quantities must be rechecked. The sample generator may still be polynomial for some parameter settings, but the paper's stated theorem does not do this analysis.

There is also a conceptual warning sign: Schapire Section 5.3 gives a weak proper learner for fixed-$k$ term DNF with inverse-polynomial advantage, by outputting either a constant hypothesis or a disjunction of at most $k$ literals. The sketched advantage is about $\Omega(1/n^k)$. Therefore Khot--Saket cannot possibly be extended to rule out every inverse-polynomial proper weak learner for the same fixed-$k$ DNF class. At most, their proof might rule out advantages above some threshold, not the atlas weak target itself.

Conclusion for this lead: no conditional false edge follows from Khot--Saket. The quantitative obstruction is now more precise: the proof's extracted Label Cover value shrinks like a polynomial in $\epsilon$, and Schapire's fixed-DNF weak learner leaves an actual inverse-polynomial proper advantage on the table.

### Lead 2: Clause-Satisfaction Lookup Class

The standard clause-satisfaction lookup witness still does not refute weak proper learning.

For the usual SAT-style reduction, the distribution is uniform over the clauses of a satisfiable formula and every example is labeled positive. A proper hypothesis is an assignment, evaluated by whether it satisfies the clause. On 3-CNF clauses, a uniformly random assignment satisfies each clause with probability $7/8$, so it already has constant weak advantage over $1/2$ on any positive-only clause distribution. With empirical checking over a polynomial sample, one can boost the success probability of this trivial weak proper strategy. Thus the positive-only lookup reduction is fundamentally a strong-accuracy hardness argument: it needs $\epsilon<1/M$ to force all $M$ clauses correct.

I also considered the more direct "labeled by an assignment" version where examples may be positive or negative according to whether the unknown assignment satisfies a clause. This is not the SAT reduction in the atlas witness. In that version, negative examples are informative because a falsified clause reveals the target values of its variables. I did not prove a full weak proper learner for this richer distributional problem, but I also found no reduction from SAT/RP: the usual all-positive distribution is too easy, and arbitrary negative labels no longer arise from the simple satisfiable-formula oracle without knowing the satisfying assignment.

A better gap-lookup template would use predicates whose random-assignment baseline is exactly $1/2$, so that a weak proper learner has to do nontrivial search. Max-3-LIN is the first thought, and Håstad's theorem gives constant-gap hardness around the $1/2$ threshold for almost satisfiable instances. But satisfiable GF(2) linear systems can be solved by Gaussian elimination once the equations are known, so a positive-only 3-LIN lookup class is not a clean proper-hardness witness in the realizable setting. More exotic promise-CSP or non-abelian equation systems may avoid this, but they would need a fresh construction.

Conclusion for this lead: the existing clause-satisfaction lookup class is not a weak-proper counterexample. A viable replacement would need a satisfiable predicate family where random assignment gives only $1/2$, finding a weakly better assignment is hard at inverse-polynomial advantage, and the improper learner still succeeds by polynomial-size lookup.

### Lead 3: Search For Explicit Inverse-Polynomial Weak Proper Hardness

I did not find a source that explicitly proves the needed statement:

> There is a concept class that is efficiently weakly realizably learnable improperly, but not efficiently weakly realizably learnable properly with inverse-polynomial advantage.

The nearby results found are all quantitatively or model-wise different:

- Pitt--Valiant and Alekhnovich--Braverman--Feldman--Klivans--Pitassi give strong proper PAC hardness. Their reductions run the learner at $\epsilon<1/|S|$ or otherwise force consistency / high accuracy, so they do not rule out a tiny weak proper edge.
- Khot--Saket and Ghoshal--Saket give constant-advantage weak-learning hardness for restricted output representations. This is stronger than strong-learning hardness in spirit, but still not the inverse-polynomial no-weak-learning statement needed here.
- Agnostic/noisy hardness results for monomials, halfspaces, and PTFs often rule out $1/2+\epsilon$ agreement for constant $\epsilon$, and some variants push $\epsilon$ subconstant under stronger assumptions. These do not fit the present realizable properization edge unless one also supplies an efficiently weak improper realizable source class and converts the noisy/agnostic promise into a realizable one.
- The modern circuit-learning and semi-proper hardness literature gives inverse-polynomial or parameterized lower bounds in some settings, but I did not find one that matches this exact proper-vs-improper weak realizable PAC edge.

### Current Verdict

`unresolved`.

I would not change the atlas edge yet. Depth 1 sharpened the obstruction but did not produce either:

- a generic theorem converting efficient weak improper learning to efficient weak proper learning; or
- a source-verified conditional counterexample ruling out every inverse-polynomial proper weak advantage.

### Concrete Next Directions

1. Work out Schapire's fixed-$k$ DNF weak proper learner as a small atlas lemma. It explains why constant-advantage DNF hardness does not settle the edge and gives a useful calibration point: any DNF-based false witness must use growing-size DNF or a different class, not fixed two-term DNF alone.

2. Try an engineered PCP lookup class with balanced predicates rather than ordinary 3-CNF clauses. Required checklist: polynomial-size instance domain or polynomial-time sampler; realizability by a proper witness; random-assignment baseline exactly $1/2$; inverse-polynomial hardness of beating $1/2$; and an improper learner that can learn the finite table distribution-free.

3. Search specifically for "barely satisfiable" or "inverse-polynomial gap" PCP/CSP hardness with perfect completeness and polynomial-time sampling. Constant-gap Håstad-style results are not enough for this atlas edge unless the weak learner's advantage can be lower-bounded above that constant, which the definition does not allow.

4. Examine whether proper weak learners for finite-domain lookup classes can always be obtained when each proper hypothesis is an efficiently evaluable assignment-like object. A positive structural lemma here could eliminate a broad family of proposed counterexamples.

5. If pursuing a conditional false result, avoid reductions that require $\epsilon<1/M$ consistency. Such reductions prove strong proper hardness, but they leave the inverse-polynomial weak proper target untouched.

## Depth-2 Entry - 2026-05-04

### Goal

Depth 2 tests the proposed engineered PCP lookup class with balanced predicates. The checklist is:

- polynomial-size instance domain or polynomial-time sampler;
- realizability by a proper witness;
- random-assignment baseline exactly $1/2$;
- inverse-polynomial hardness of beating $1/2$;
- an improper learner that can learn the finite table distribution-free.

The conclusion is that the template is coherent and would give a conditional false edge if supplied with the right PCP/CSP hardness theorem, but the exact theorem needed is not among the checked sources.

### Conditional PCP Lookup Template

A clean version of the template is as follows. For an NP instance $\varphi$, let $V_\varphi$ be a PCP verifier with random string set $R_\varphi$ of size $\operatorname{poly}(|\varphi|)$. Each random string $r$ defines a local predicate $P_{\varphi,r}$ on the queried proof symbols. The learning domain consists of pairs $(\psi,r)$, where $\psi$ is an encoded instance and $r$ is a verifier random string for $\psi$.

For each pair $(\varphi,\pi)$ of an instance and proof string, define a proper concept

$$
h_{\varphi,\pi}(\psi,r)=
\begin{cases}
P_{\varphi,r}(\pi) & \text{if } \psi=\varphi,\\
0 & \text{otherwise.}
\end{cases}
$$

On the hard distribution $D_\varphi$, draw $(\varphi,r)$ uniformly over $r\in R_\varphi$ and label every example by $1$. If $\varphi$ is satisfiable and the PCP has perfect completeness, then there is a proof $\pi^\star$ such that $h_{\varphi,\pi^\star}=1$ on all of $D_\varphi$, so the distribution is realizable by a proper witness. A proper weak learner for this concept class, run on $D_\varphi$, must output some $h_{\varphi,\pi}$ with

$$
\Pr_{r\sim R_\varphi}[P_{\varphi,r}(\pi)=1]\ge {1\over 2}+\gamma(n),
$$

except for its allowed failure probability. If the verifier random strings can be enumerated or sampled in polynomial time, the reduction can estimate or exactly compute the returned proof's acceptance probability.

This construction also explains why the finite-table improper learner is plausible. For a fixed target $h_{\varphi,\pi}$, the only nontrivial part of the domain is the slice $\{(\varphi,r):r\in R_\varphi\}$, whose size is polynomial. Outside that slice the label is identically $0$. An improper learner can store observed labeled points on the active slice, default to $0$ elsewhere, and with polynomially many samples cover all but an $\epsilon$-mass of any distribution. This is stronger than weak learning and is distribution-free for the engineered class, provided $|R_\varphi|$ and evaluation of $P_{\varphi,r}$ are polynomially bounded in the concept representation length.

### Where The Checklist Succeeds

- **Polynomial domain/sampler:** PCP verifiers with $O(\log n)$ randomness give polynomially many random strings. Even if the global domain of all encoded instances is huge, each target concept has only one polynomial-size active slice, and the default-off-slice design lets the improper memorization learner handle arbitrary distributions.
- **Proper realizability:** perfect completeness gives a proof $\pi^\star$ accepted on every random string, so the all-positive hard distribution is realizable by $h_{\varphi,\pi^\star}$.
- **Improper learning:** the active-slice lookup learner gives efficient improper PAC learning for this engineered representation.
- **Reduction shape:** a proper weak learner would be a search algorithm for a proof assignment beating the verifier's random-assignment threshold on a satisfiable instance.

These points mean the construction is not blocked by the old clause-lookup problem that random 3-CNF assignments already satisfy $7/8$ of positive clauses. Balanced predicates really do line up the weak PAC threshold with the CSP baseline.

### The Exact Blocker

The missing ingredient is a source-verified hardness theorem of the following form:

> For some polynomial-time PCP/CSP reduction with perfect completeness and polynomially many constraints, each local predicate is balanced so that a uniformly random proof assignment satisfies exactly half of the constraints in expectation, yet it is NP/RP-hard, or hard under an explicit standard assumption, to find an assignment satisfying more than $1/2+1/\operatorname{poly}(n)$ of the constraints even when the instance is satisfiable.

This is stronger, and more parameter-sensitive, than the standard facts checked so far.

Håstad's optimal inapproximability theorem gives the right $1/2+\epsilon$ threshold for Max-E3-LIN-style balanced tests, but in the usual Boolean linear-equation setting the perfectly satisfiable case is not hard: if the full GF(2) linear system is satisfiable, Gaussian elimination finds a satisfying assignment. The hard Max-E3-LIN statements are naturally almost-satisfiable or no-case gap statements, not a proper realizable lookup witness with perfect completeness and hard satisfiable search.

Low-error PCPs, such as Moshkovitz--Raz two-query PCPs and Dinur--Harsha--Kindler polynomially low-error PCPs, go in a different direction. They provide perfect completeness with subconstant or inverse-polynomial soundness and polynomial or near-polynomial size parameters. But soundness below $1/2$ is incompatible with the requested balanced-predicate baseline: if each local predicate accepts exactly half of local assignments, then averaging over a uniformly random proof gives acceptance probability exactly $1/2$ for every instance. These low-error PCPs therefore do not directly supply the desired "balanced around $1/2$ plus inverse-polynomial gap" theorem.

Known satisfiable-CSP approximation-resistance results are also near misses. Håstad's Max-Not-2 result proves tight satisfiable-instance hardness at the random baseline $5/8+\epsilon$, and Huang constructs approximation-resistant satisfiable predicates with few accepting inputs. O'Donnell--Wu/Huang-style perfect-completeness results for predicates related to parity, and newer Bhangale--Khot--Minzer work on satisfiable 3-CSPs, show that perfect-completeness approximation resistance is a real phenomenon. But the statements I found are constant-$\epsilon$ hardness results, often with random baselines different from $1/2$, or are conditional on specialized games conjectures. A constant-$\epsilon$ theorem does not rule out a PAC weak learner whose advantage is only $\gamma(n)=1/\operatorname{poly}(n)$.

Subconstant 3-LIN hardness is still not enough as checked. Bhangale, Khot, and Minzer's improved 3LIN hardness via Linear Label Cover rules out satisfying $1/2+\epsilon$ for $\epsilon=(\log n)^{-c}$ in nearly satisfiable instances under $\mathrm{NP}\nsubseteq\mathrm{BPP}$, but the completeness is $1-\epsilon$, not exact realizability, and the gap is polylogarithmic rather than an arbitrary inverse polynomial. It therefore does not instantiate the atlas edge.

### Failed Balancing Tricks

Simple transformations do not remove the blocker.

- Repeating a balanced predicate and accepting only if all repetitions accept changes the random baseline from $1/2$ to $2^{-t}$, so the PAC weak threshold no longer matches the CSP baseline.
- XORing with a fresh balancing bit makes predicates balanced, but if the bit is fresh per constraint then every instance becomes trivially satisfiable; if the bit is shared or consistency-constrained, one needs a new soundness proof.
- Non-abelian equation systems may make satisfiable equation search hard, unlike GF(2) linear systems, but the random equation baseline is typically $1/|G|$ or another group-dependent value rather than exactly $1/2$. Converting that baseline to the binary PAC threshold without introducing an easy dummy strategy is nontrivial.
- Constant-gap satisfiable approximation resistance cannot be plugged into the reduction by running the weak learner longer, because the weak learner's promised edge is existential and may be much smaller than the constant gap.

### Conditional Resolution Lemma

If one can prove the balanced inverse-polynomial perfect-completeness hardness theorem stated above, then the engineered lookup class would resolve this atlas edge as `false` under the corresponding assumption.

The proof would be:

1. Build the concept class $h_{\varphi,\pi}$ from the balanced PCP verifier, with the off-instance default value $0$.
2. The improper learner memorizes the polynomial-size active slice and hence efficiently learns distribution-free.
3. On satisfiable $\varphi$, the all-positive uniform distribution over verifier random strings is realizable by the accepting proof.
4. A proper weak learner must output a proof satisfying $1/2+\gamma(n)$ of the verifier tests.
5. Since $\gamma(n)$ is inverse-polynomial for that learner, choose the PCP gap below $\gamma(n)$, estimate the returned acceptance probability by enumeration or sampling, and distinguish satisfiable instances from soundness-no instances.

The currently missing step is exactly step 5's PCP gap theorem with balanced predicates and perfect completeness at the inverse-polynomial scale.

### Sources Checked

- Johan Håstad, "Some Optimal Inapproximability Results" (JACM 2001), DOI: https://doi.org/10.1145/502090.502098.
- Dana Moshkovitz and Ran Raz, "Two-Query PCP with Subconstant Error" (FOCS 2008 / JACM 2010), DOI: https://doi.org/10.1145/1754399.1754402; author PDF checked at https://www.math.ias.edu/files/Moshkovitz_2Query.pdf.
- Irit Dinur, Prahladh Harsha, and Guy Kindler, "Polynomially Low Error PCPs with polyloglog n Queries via Modular Composition" (STOC 2015), DOI: https://doi.org/10.1145/2746539.2746630; arXiv: https://arxiv.org/abs/1505.06362.
- Amey Bhangale, Subhash Khot, and Dor Minzer, "Improved 3LIN Hardness via Linear Label Cover" (APPROX/RANDOM 2019), DOI: https://doi.org/10.4230/LIPIcs.APPROX-RANDOM.2019.9.
- Johan Håstad, "On the NP-Hardness of Max-Not-2" (SIAM Journal on Computing 2014), DOI: https://doi.org/10.1137/120882718.
- Sangxia Huang, "Approximation Resistance on Satisfiable Instances for Predicates with Few Accepting Inputs" (Theory of Computing 2014), DOI: https://doi.org/10.4086/toc.2014.v010a014.
- Ryan O'Donnell and Yi Wu, "Circumventing d-to-1 for Approximation Resistance of Satisfiable Predicates Strictly Containing Parity of Width at Least Four" (Theory of Computing 2013), DOI: https://doi.org/10.4086/toc.2013.v009a023.
- Amey Bhangale, Subhash Khot, and Dor Minzer, "On Approximability of Satisfiable k-CSPs: I" (Computational Complexity 2025), DOI: https://doi.org/10.1007/s00037-025-00267-6.

### Verdict

`unresolved`.

The engineered PCP lookup class is a promising conditional counterexample template, but it does not yet resolve the edge as false. The exact blocker is the absence, in the checked sources, of an inverse-polynomial-gap, perfectly complete, balanced-predicate satisfiable-CSP hardness theorem at threshold $1/2$ with polynomial-size constraints or a polynomial-time sampler. It also does not resolve the edge as true; proper weak search can still encode hard approximation/search problems.

### Next Directions

1. Search specifically for "perfect completeness approximation resistance inverse polynomial" and "sliding scale satisfiable CSP balanced predicate." The needed result is closer to a perfect-completeness sliding-scale theorem than to ordinary PCP soundness amplification.
2. Check whether any perfect-completeness approximation-resistant predicate has random baseline exactly $1/2$ and whether its reduction parameters can be made subconstant in $\epsilon$ without super-polynomial blowup.
3. Explore non-abelian or promise-CSP equations only if a baseline-normalization gadget can preserve both satisfiable hardness and the PAC threshold $1/2$.
4. Formalize the conditional lookup lemma above as a reusable atlas argument if a suitable PCP/CSP theorem is found.

## Depth-3 Entry - 2026-05-04

### Question For This Pass

Depth 3 asked for a focused check of the remaining PCP/CSP issue:

> Is there a known perfect-completeness PCP/CSP theorem for balanced predicates, with polynomially many constraints or a polynomial-time sampler, for which it is hard to beat the random baseline $1/2$ by an inverse-polynomial advantage? If not, can parallel repetition or gap amplification be tuned to inverse-polynomial advantage without losing perfect completeness or polynomial sampler size?

The short answer is: I did not find such a balanced-predicate theorem in the checked sources. However, this balanced theorem is not actually necessary for the original learning edge. A standard perfect-completeness PCP with logarithmic randomness and soundness bounded above by a constant below $1/2$ already gives an engineered lookup class that is efficiently weakly learnable improperly but not efficiently weakly learnable properly unless $\mathrm{NP}\subseteq\mathrm{RP}$.

### Sources Checked

- Håstad and Khot, "Query Efficient PCPs with Perfect Completeness" (Theory of Computing 2005), DOI: https://doi.org/10.4086/toc.2005.v001a007. The abstract states that for every integer $k>0$ and constant $\epsilon>0$, NP has a PCP with logarithmic randomness, perfect completeness, $4k+k^2$ non-adaptive Boolean queries, and soundness at most $2^{-k^2}+\epsilon$.
- Dinur, Harsha, and Kindler, "Polynomially Low Error PCPs with polyloglog n Queries via Modular Composition" (STOC 2015), DOI: https://doi.org/10.1145/2746539.2746630; arXiv: https://arxiv.org/abs/1505.06362. The advertised parameters include $O(\log n)$ randomness, perfect completeness, and soundness $1/\operatorname{poly}(n)$, but the resulting predicates are not the balanced threshold-$1/2$ CSP theorem sought here.
- Moshkovitz and Raz, "Two-Query PCP with Subconstant Error" (JACM 2010), DOI: https://doi.org/10.1145/1754399.1754402. This supplies subconstant-error projection PCPs, with strong size parameters, but again not the exact balanced perfect-completeness satisfiable-CSP statement.
- Wenner, "Circumventing d-to-1 for Approximation Resistance of Satisfiable Predicates Strictly Containing Parity of Width at Least Four" (Theory of Computing 2013), DOI: https://doi.org/10.4086/toc.2013.v009a023. This gives perfect-completeness satisfiable-instance approximation resistance for predicates strictly containing parity, subject only to $\mathrm{P}\ne\mathrm{NP}$ in the width-at-least-four case. The random baseline is larger than $1/2$; for the width-four Not-Two-style predicate discussed in the paper the baseline is $9/16$.
- Huang, "Approximation Resistance on Satisfiable Instances for Predicates with Few Accepting Inputs" (Theory of Computing 2014), DOI: https://doi.org/10.4086/toc.2014.v010a014. This is a strong perfect-completeness satisfiable-CSP result, but its predicates are sparse rather than balanced.
- Brakensiek and Guruswami, "The Quest for Strong Inapproximability Results with Perfect Completeness" (APPROX/RANDOM 2017), DOI: https://doi.org/10.4230/LIPIcs.APPROX-RANDOM.2017.4. The abstract explicitly frames perfectly satisfiable CSP approximability as still poorly understood and proceeds through a conjectural V-label-cover route.

### Balanced Predicate Status

I still do not have a source-verified theorem with all of the desired properties simultaneously:

1. perfect completeness, so satisfiable instances have value exactly $1$;
2. balanced local predicates, so a uniformly random local assignment satisfies exactly half of each constraint;
3. hardness of finding value $>1/2+1/\operatorname{poly}(n)$;
4. polynomially many constraints, or at least a polynomial-time sampler compatible with the learning reduction; and
5. parameters stated uniformly enough to plug in an inverse-polynomial advantage.

The known perfect-completeness satisfiable-CSP approximation-resistance results are still near misses. Wenner's parity-containing predicates and Huang's sparse predicates show that perfect-completeness approximation resistance is real, but their baselines are not exactly $1/2$. The older Max-3-LIN-style threshold is balanced at $1/2$, but perfect satisfiable GF(2) systems are solvable by Gaussian elimination, so that does not give hard satisfiable search.

The phrase "for every $\epsilon>0$" in constant-gap approximation-resistance theorems also does not by itself give the inverse-polynomial statement. In these PCP reductions, $\epsilon$ is normally a fixed accuracy parameter; the label sizes, smoothness, projection degrees, or other reduction constants may depend badly on $1/\epsilon$. Without an explicit sliding-scale parameter analysis, one cannot set $\epsilon=1/\operatorname{poly}(n)$ and keep the reduction polynomial-size.

### Parallel Repetition And Gap Amplification

Parallel repetition preserves perfect completeness in the usual verifier/game sense, and low-error PCP constructions show that inverse-polynomial soundness can coexist with $O(\log n)$ randomness and polynomial proof size. So the obstacle is not perfect completeness or sampler size in isolation.

The obstacle is preserving the balanced threshold-$1/2$ CSP interpretation. Naive AND repetition of a balanced predicate changes the random baseline from $1/2$ to $2^{-t}$. Direct-product or projection-game repetition gives low soundness, but the resulting acceptance test is not a balanced Boolean predicate at threshold $1/2$. XOR-style rebalance gadgets are tempting, but with a fresh balancing bit they can make the instance trivially satisfiable, and with shared or consistency-constrained bits they need a new soundness proof. I did not find an off-the-shelf repetition theorem that simultaneously preserves perfect completeness, gives inverse-polynomial hardness above $1/2$, keeps polynomial-size/samplable constraints, and keeps every local predicate balanced.

### Stronger Bypass For The Learning Edge

The balanced-CSP requirement is stronger than what the learning counterexample needs. For the original properization edge, it suffices to use a perfect-completeness PCP whose NO-case soundness is any constant below $1/2$.

Fix, for example, Håstad--Khot with a constant $k$ and $\epsilon$ chosen so that the soundness $s<1/2$. It has $O(\log n)$ randomness, hence only $\operatorname{poly}(n)$ verifier random strings.

Define a concept class from the verifier as follows. A proper concept is indexed by an NP instance $\varphi$ and a proof string $\pi$:

$$
h_{\varphi,\pi}(\psi,r)=
\begin{cases}
V(\varphi,\pi,r) & \text{if } \psi=\varphi,\\
0 & \text{otherwise.}
\end{cases}
$$

The domain consists of encoded pairs $(\psi,r)$. Evaluation is polynomial time: compare $\psi$ with $\varphi$ and, on the matching slice, run the PCP verifier.

This class is efficiently learnable improperly, indeed strongly PAC learnable, by memorization. For a target $h_{\varphi,\pi}$, all positive examples lie in the active slice $\{(\varphi,r):r\in R_\varphi\}$, whose size is polynomial because the verifier uses $O(\log |\varphi|)$ random bits. An improper learner stores the positive sample points and predicts $0$ elsewhere. With polynomially many samples it covers all but $\epsilon$ mass of the positive part of any distribution. This argument is distribution-free and does not require knowing $\varphi$ in advance.

Now suppose there is an efficient proper weak learner for this class. Given an NP instance $\varphi$, draw training examples uniformly from $\{(\varphi,r):r\in R_\varphi\}$ and label every example by $1$.

- If $\varphi$ is satisfiable, perfect completeness gives a proof $\pi^\star$ with $h_{\varphi,\pi^\star}=1$ on the entire distribution. The proper weak learner must, with its success probability, return some proper hypothesis with error at most $1/2-\gamma$, i.e. acceptance probability at least $1/2+\gamma$.
- If $\varphi$ is unsatisfiable, every returned proper hypothesis either has the wrong instance slice, hence acceptance $0$, or has the form $h_{\varphi,\pi}$ for some proof $\pi$, whose acceptance is at most the PCP soundness $s<1/2$.

Because the verifier has polynomially many random strings, the reduction can enumerate them, or simply estimate with a constant margin, and accept iff the returned proper hypothesis has acceptance above a fixed threshold between $s$ and $1/2$. This is one-sided: NO instances are never accepted, and YES instances are accepted with the learner's success probability. Therefore an efficient proper weak learner would put NP in RP.

### Verdict For The Original Edge

`resolved false`, conditional on $\mathrm{NP}\nsubseteq\mathrm{RP}$.

The depth-2 balanced-PCP template remains an interesting but unnecessary route. The cleaner witness is the PCP active-slice lookup class above. It separates efficient weak realizable improper PAC learning from efficient weak realizable proper PAC learning because improper memorization learns the polynomial active slice, while proper weak learning would recover a PCP proof accepted on more than half the verifier random strings for satisfiable instances and thereby decide an NP-complete language in randomized polynomial time.
