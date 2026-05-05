# Open Edge Resolution Scratchpad

Edge: `efficient-realizable-improper-pac -> efficient-marginal-nonuniform-realizable-proper-pac`
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

- Source node: `efficient-realizable-improper-pac`. One randomized polynomial-time distribution-free realizable PAC learner works for every marginal distribution and every target $c\in\mathcal C$, with sample complexity and runtime bounded by a distribution-independent polynomial in the representation size, $1/\varepsilon$, and $\log(1/\delta)$. The output hypothesis may lie outside $\mathcal C$.
- Target node: `efficient-marginal-nonuniform-realizable-proper-pac`. One uniform learner works for every marginal $P$, but for each fixed $P$ the sample and runtime polynomial $p_P$ may depend on $P$. The output must lie in $\mathcal C$, and the polynomial may not depend on the target concept, $\varepsilon$, or $\delta$.
- Axis context: the implication relaxes `distribution` from distribution-free to marginal-nonuniform, keeps computational efficiency, strong accuracy, and realizability, and strengthens `properness` from improper to proper. In the registry this is a `properization-open` edge, where an atlas resolution to `true` needs a theorem and a resolution to `false` needs a counterexample or conditional counterexample.
- Current edge note: `status: "open"`, `evidence: unknown`, with the stated obstruction that an improper learner gives no general polynomial-time projection back into $\mathcal C$.

### Sources Checked

- Atlas definition notes:
  - `atlas/definitions/efficient-realizable-improper-pac.md`
  - `atlas/definitions/efficient-marginal-nonuniform-realizable-proper-pac.md`
  - `atlas/definitions/sample-efficient-marginal-nonuniform-realizable-proper-pac.md`
- Atlas edge, argument, witness, and registry notes:
  - `atlas/implications/efficient-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`
  - `atlas/arguments/properization-open.md`
  - `atlas/arguments/sample-complexity-equivalence.md`
  - `atlas/arguments/clause-satisfaction-proper-hardness.md`
  - `atlas/arguments/fixed-k-term-dnf-proper-boosting-separation.md`
  - `atlas/witnesses/clause-satisfaction-lookup-class.md`
  - `atlas/witnesses/fixed-k-term-DNF.md`
  - `atlas/registry/axes.yml`
  - `atlas/registry/edge_families.yml`
- Primary and near-primary sources checked:
  - Blumer, Ehrenfeucht, Haussler, and Warmuth, "Learnability and the Vapnik-Chervonenkis Dimension" (1989), for the finite-VC/sample-complexity route and the distinction between sample bounds and efficient hypothesis finding.
  - Schapire, "The Strength of Weak Learnability" (1990), especially the boosting construction and the "Fixed hypotheses" discussion noting that boosting does not generally preserve the representation class.
  - Pitt and Valiant, "Computational Limitations on Learning from Examples" (1988), especially the $k$-term-DNF hardness construction using instance-dependent distributions $D^+$ and $D^-$, and the positive result that $k$-term DNF is learnable by $k$-CNF.
  - Khot and Saket, "Hardness of Minimizing and Learning DNF Expressions" (2008), especially Theorem 5: under $\mathrm{NP}\nsubseteq\mathrm{RP}$, two-term DNF is not PAC-learnable by fixed $t$-term DNF to constant advantage over $1/2$ on the constructed input distribution.
  - Benedek and Itai, "Learnability with respect to fixed distributions" (1991), for fixed-distribution learnability background; the source is mainly sample-complexity oriented.
  - Ben-David, Benedek, and Mansour, "A parameterization scheme for classifying models of PAC learnability" (1995), for the uniformity-parameter framework; the source is information-theoretic rather than a computational properization theorem.
  - Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability" (NeurIPS 2025), for the definition that marginal-dependent rates may depend on $P$ but must hold uniformly over concepts, and for the sample-rate trichotomy.

### Theorem And Counterexample Attempts

1. **Direct properization attempt.** Since the source learner is distribution-free, it also gives a marginal-nonuniform improper learner. The missing step is to convert its hypothesis $h\notin\mathcal C$ into some $c'\in\mathcal C$ with comparable $P$-error. A validation sample can estimate the error of a candidate, but it does not produce a member of $\mathcal C$. Exhaustive proper ERM or projection onto $\mathcal C$ is exactly the computational search problem that proper-learning hardness results exploit. I found no source giving a generic polynomial-time projection whose polynomial may depend only on $P$.

2. **Sample-only detour.** Ignoring runtime, the implication has the usual finite-VC flavor: distribution-free PAC learnability gives polynomial sample control, and unbounded ERM over $\mathcal C$ can output a proper hypothesis. Hanneke--Moran--Thiessen's marginal-nonuniform trichotomy reinforces that polynomial marginal-dependent sample rates do not create a new sample-only separation here. This does not prove the efficient target, because the target still requires a polynomial-time proper hypothesis finder.

3. **Schapire compression/boosting route.** Schapire's theorem can improve weak learners and yields efficient small hypotheses from learnability, but the produced hypotheses are combinations or transformations of hypotheses from the learner. The paper explicitly flags that these constructions need not preserve a fixed hypothesis representation. Since the target asks for $h\in\mathcal C$, this is not a properization theorem.

4. **Clause-satisfaction lookup counterexample attempt.** The lookup class satisfies the source: an improper learner can estimate or memorize labels on the polynomial-size clause domain. The known proper hardness reduction, however, chooses a distribution such as the uniform distribution over the clauses of the input formula and asks for accuracy below about $1/M$ to force every clause correct. For a marginal-nonuniform target, that marginal varies with the SAT instance, so the allowed polynomial $p_{P_F}$ may have constants or degree depending on the formula-specific distribution $P_F$. Running the target learner on a different $P_F$ for every formula therefore does not yield a uniform randomized polynomial-time SAT algorithm. A fixed universal marginal over all formulas also seems unable to assign inverse-polynomial mass to every formula-size-$n$ instance without making the requested $\varepsilon$ exponentially small. Thus the standard lookup witness does not give an atlas-valid conditional false result for this edge.

5. **Fixed-$k$-term DNF counterexample attempt.** Fixed-$k$-term DNF is the right representation-sensitive shape: Pitt--Valiant show proper hardness for $k$-term DNF, while $k$-term DNF is learnable improperly by moving to $k$-CNF. But the relevant hardness reductions construct distributions from the hard instance, so the same marginal-nonuniform loophole appears. Khot--Saket strengthen the proper DNF obstruction to constant-advantage weak learning by fixed $t$-term DNF, but their theorem is also stated for an input distribution $D$ constructed by the reduction. I did not find a fixed-marginal, for example uniform-distribution, proper-hardness theorem that would refute the marginal-nonuniform target for a class already known to satisfy the source.

### Precise Obstruction

To prove `true`, one needs a uniform algorithmic projection principle:

$$
\text{efficient improper strong PAC learner for }\mathcal C
\quad\Longrightarrow\quad
\text{for every }P,\text{ proper learning under }P\text{ in }p_P\text{ time}.
$$

The checked sources give sample-only projection by unbounded ERM, but not a computational projection. The improper learner may reveal a useful classifier without giving any efficient way to find a nearby member of the original representation class.

To prove `false` by the existing proper-hardness witnesses, one needs a hard marginal that is fixed independently of the NP instance, or else a reduction that controls the marginal-dependent polynomial uniformly over the instance-generated marginals. The clause-satisfaction, Pitt--Valiant, and Khot--Saket reductions checked here vary the learning distribution with the hard instance. Under the target definition, the runtime polynomial may vary with that distribution, so these reductions do not by themselves imply $\mathrm{NP}\subseteq\mathrm{RP}$ or $\mathrm{RP}=\mathrm{NP}$ from a marginal-nonuniform proper learner.

### Final Verdict

`unresolved`.

I would keep the atlas edge at `status: "open"` and `evidence: unknown`. The search found no atlas-valid theorem for `resolved true` and no conditional counterexample strong enough for `resolved false`.

### Concrete Follow-Up Directions

- Search specifically for fixed-marginal proper-learning hardness, especially uniform-distribution hardness without membership queries, for a class that is distribution-free efficiently learnable improperly. Such a result would be the cleanest path to a conditional false edge.
- Revisit Pitt--Valiant and later DNF proper-learning hardness to separate which theorems use arbitrary distributions, which use the uniform distribution, and whether the positive improper learner has exactly the same target class and representation-size convention used by the atlas.
- Analyze the clause-satisfaction lookup class under each fixed clause marginal. Either prove a marginal-nonuniform proper learner for it, which would remove it as a false-witness candidate, or find a single fixed marginal that still encodes NP-hard proper learning with polynomially visible mass on every relevant instance.
- Try to formalize the "universal marginal over hard instances" idea and prove the mass obstruction: summability appears to force exponentially small mass for most size-$n$ formulas, which makes the required accuracy and runtime too large for an NP reduction.
- Look for computational marginal-nonuniform properization under extra assumptions such as finite support with efficiently recoverable heavy atoms, efficient agnostic/proper ERM, or an efficient projection oracle from improper hypotheses to $\mathcal C$.
- If no natural witness exists, consider an engineered PCP lookup class whose hard instances are embedded into one fixed marginal with polynomial mass at every size. This would need a precise complexity assumption and a careful check that the source remains efficiently distribution-free improperly learnable.

## Depth-1 Entry - 2026-05-04

### Search Focus

Depth 1 pursued three leads from the depth-0 note:

1. fixed-marginal proper-learning hardness, especially uniform-distribution hardness without membership queries, for a class already known to be distribution-free efficiently learnable improperly;
2. Pitt--Valiant and later DNF proper-learning hardness, separating arbitrary-distribution hardness from uniform-distribution statements and checking whether the positive improper learner uses the same target class;
3. the clause-satisfaction lookup witness under fixed clause marginals and under attempted universal marginals.

### Additional Sources Checked

- Pitt and Valiant, "Computational Limitations on Learning from Examples" (JACM 1988), DOI: https://doi.org/10.1145/48014.63140. The accessible abstract records distribution-free hardness for several representation classes, including disjunctions of two monomials, threshold functions, and read-once formulas. The paper also contains the positive result that fixed $k$-term DNF is learnable by $k$-CNF.
- Feldman's "Hardness of Proper Learning" encyclopedia entry (2008), https://doi.org/10.1007/978-0-387-30162-4_177. The entry summarizes Pitt--Valiant as showing that $\mathsf{DNF}(k)$ is not properly learnable unless $\mathsf{RP}=\mathsf{NP}$, while $\mathsf{DNF}(k)$ is learnable by $k$-CNF. It also records Feldman's later uniform-distribution, membership-query hardness for $n^c$-term DNF in a strongly proper setting.
- Feldman, "Hardness of Approximate Two-level Logic Minimization and PAC Learning with Membership Queries" (JCSS 2009 / STOC 2006), PDF: https://vtaly.net/papers/F_MinDNF_MQ_08.pdf. Feldman explicitly distinguishes the basic PAC model from PAC+MQ and notes that the distribution-specific version in the paper is the uniform distribution. The uniform result is for strongly proper or mildly relaxed DNF hypotheses with membership queries; the positive contrast is Jackson's improper uniform-distribution DNF learner with membership queries, not a distribution-free random-example improper learner for the same class.
- Alekhnovich, Braverman, Feldman, Klivans, and Pitassi, "The Complexity of Properly Learning Simple Concept Classes" (JCSS 2008), PDF: https://mbraverm.princeton.edu/files/ABFKP_Proper_Hardness_08.pdf. This removes earlier output-size restrictions for proper DNF hardness in the distribution-free random-example model, but it does not give a fixed-marginal hardness theorem.
- Khot and Saket, "Hardness of Minimizing and Learning DNF Expressions" (FOCS 2008), PDF: https://cs.nyu.edu/~khot/papers/minDNF.pdf. Their introduction stresses that earlier DNF hardness rules out inverse-polynomial error but not constant-error weak learning; their Theorem 2 gives constant-advantage hardness for learning 2-term DNF by fixed $t$-term DNF. The reduction constructs an explicit polynomial-support distribution $D$ from the Label Cover instance, so the marginal varies with the hard instance.
- Liśkiewicz, Lutter, and Reischuk, "Proper Learning of k-term DNF Formulas from Satisfying Assignments" (JCSS 2019), DOI: https://doi.org/10.1016/j.jcss.2019.07.004. Their abstract and introduction are important for this edge because they give a positive fixed-distribution result: for every fixed $k$ and $q$, $k$-term DNF is properly learnable over $q$-bounded distributions, including uniform-type distributions, from positive examples alone and without false positives. Their survey table marks fixed $k$-term DNF as distribution-free hard but uniform/q-bounded positive.

### Lead 1: Fixed-Marginal Proper Hardness

I did not find a fixed-marginal, no-membership-query proper-hardness theorem that fits the edge's needs.

The clean false-edge template would be:

$$
\mathcal C \text{ is efficiently distribution-free improperly PAC learnable,}
$$

but for some single fixed marginal $P$,

$$
\mathcal C \text{ is not efficiently properly PAC learnable under } P
$$

unless a standard complexity collapse occurs.

The sources checked give near misses rather than this template. Feldman's uniform-distribution hardness is genuinely fixed-marginal and even allows membership queries, but it concerns larger DNF classes for which the corresponding distribution-free improper random-example learner is not known. Khot--Saket gives a strong proper lower bound for a class with the right "improperly learnable by another representation" flavor, but the hard distribution is generated from the Label Cover instance. Pitt--Valiant gives the classic source/target separation for fixed $k$-term DNF, but again in the distribution-free model with instance-dependent distributions.

The Liśkiewicz--Lutter--Reischuk result is a useful negative signal for this search direction. For fixed $k$-term DNF, the most tempting witness, uniform and $q$-bounded marginals are not hard in the same way as arbitrary marginals; they are actually positive settings for proper learning. This does not prove the atlas edge true, but it blocks the simplest uniform-DNF counterexample.

### Lead 2: DNF Hardness, Uniformity, And Same-Class Positive Learners

The DNF story separates into three regimes.

**Fixed $k$-term DNF.** This remains the best representation-sensitive illustration of impropriety helping. Pitt--Valiant show proper distribution-free hardness, while fixed $k$-term DNF is learnable improperly by $k$-CNF. This exactly explains why the ordinary distribution-free properization edge is false. It does not refute the present edge because the hard marginal in the reduction depends on the NP instance.

**Polynomial-size or unrestricted DNF.** Later proper-hardness results, including Alekhnovich et al. and Feldman, remove or relax output-size restrictions. Feldman also obtains a uniform-distribution membership-query hardness statement in a strongly proper DNF setting. But these classes do not currently satisfy the atlas source node: polynomial-size/unrestricted DNF is not known to be efficiently distribution-free PAC learnable improperly from random examples alone. Jackson's celebrated positive learner is uniform-distribution with membership queries, not distribution-free random-example PAC learning.

**Uniform or bounded fixed-distribution fixed-$k$ DNF.** Liśkiewicz--Lutter--Reischuk move in the opposite direction from the desired counterexample: for fixed $k$ they give efficient proper algorithms over $q$-bounded distributions. Thus fixed $k$ DNF looks like evidence that arbitrary-distribution proper hardness can disappear under fixed benign marginals, not evidence for a fixed-marginal false edge.

Bottom line: DNF still justifies leaving the atlas edge open, but I do not see an atlas-valid DNF-based `resolved false` argument.

### Lead 3: Clause-Satisfaction Lookup Under Fixed Marginals

The lookup witness also does not presently yield a false resolution.

For a formula $F$ with $M$ clauses, the standard proper-hardness reduction uses a formula-dependent marginal $P_F$, typically uniform on the clauses of $F$. This is what makes example simulation possible in the satisfiable case: every sampled clause can be labeled positive without knowing a satisfying assignment. If a proper learner returns an assignment with error below $1/M$, it must satisfy every clause in $F$.

That argument breaks against the marginal-nonuniform target for two independent reasons.

First, if we keep $P_F$ formula-dependent, the target learner is allowed a polynomial $p_{P_F}$ depending on that marginal. Since $P_F$ changes with the SAT instance, a reduction cannot extract one uniform randomized polynomial-time SAT algorithm from the existence of the learner.

Second, replacing $P_F$ by a fixed "all clauses over $n$ variables" marginal does not solve the simulation problem. Under such a marginal, examples include clauses outside the input formula. To label those examples as an assignment-satisfaction concept, the reduction would need the unknown satisfying assignment. The formula-dependent marginal avoids exactly this problem by sampling only clauses whose label is known to be $1$ in every satisfying assignment of $F$.

One can try to repair this by moving to a fixed marginal over pairs $(F,C)$, where $C$ is a clause of $F$, so that the reduction can label all examples for the queried formula component. But then there are exponentially many formulas of a given size. Any single summable marginal must give most formula components exponentially small mass. For a formula $F$ with component mass $\mu_F$, forcing correctness on all $M$ clauses needs roughly

$$
\varepsilon < \mu_F/M
$$

or a comparable inverse-mass accuracy requirement. For most formulas this makes $1/\varepsilon$ exponential in the SAT input length, so the resulting call to the learner is not a polynomial-time reduction. This is the universal-marginal mass obstruction in a sharper form: polynomially visible mass for every hard instance is incompatible with one fixed probability distribution over exponentially many instances.

### Current Verdict

`unresolved`.

Depth 1 strengthens the reason for keeping the edge open. I found no fixed-marginal hardness theorem that applies to a class satisfying `efficient-realizable-improper-pac`, and the two natural candidate families remain near misses:

- fixed $k$-term DNF has the right distribution-free improper/proper separation, but its hardness reductions use instance-dependent marginals; fixed uniform/q-bounded versions are positive for proper learning;
- clause-satisfaction lookup gives a clean distribution-free proper-hardness witness, but its reduction relies on formula-dependent marginals, while fixed universal marginals either cannot be simulated without a witness or assign too little mass to each formula component.

### Concrete Next Directions

1. Search for fixed-distribution proper-hardness results for classes with known distribution-free improper random-example learners, not membership-query learners. Promising query strings: "fixed distribution proper PAC hardness random examples", "uniform distribution proper learning hardness no membership queries", and "distribution-specific proper PAC lower bound improper learnable".
2. Check whether any of the Alekhnovich--Braverman--Feldman--Klivans--Pitassi DNF/OR-of-thresholds reductions can be made to use one fixed marginal while keeping example labels simulatable from the NP instance. My expectation after this pass is no, but this is the most direct DNF follow-up.
3. Look beyond DNF to representation classes where the target class is distribution-free improperly learnable for structural reasons, but proper fitting under a fixed natural marginal encodes an NP-hard search problem. Candidate areas: intersections/unions of simple geometric concepts, decision-tree variants with known improper learners, or engineered CSP lookup classes.
4. Formalize a lemma for the lookup witness: any SAT-to-learning reduction that uses a fixed marginal over formula-indexed components and needs clause-level accuracy for every size-$n$ formula must either have exponentially small component mass for some formulas or use a non-summable distribution. This would not resolve the atlas edge, but it would retire a tempting false-witness strategy.
5. Separately search for positive marginal-nonuniform properization under additional structure, such as finite support with an efficiently learnable support partition, efficiently enumerable high-mass atoms, or a projection oracle from improper hypotheses to $\mathcal C$. These could become conditional true subedges even if the general edge remains open.

## Depth-2 Entry - 2026-05-04

### Engineered Route Tested

This pass focuses only on the proposed PCP/CSP lookup false-witness route.

The desired construction would look like this. For every hard instance $I$ of length $n$, such as a 3-SAT formula, Label Cover instance, or bounded-query PCP/CSP instance, create a component $X_I$ of examples. A proper hypothesis encodes a witness or proof $\pi$ and labels the local checks in $X_I$ according to whether $\pi$ satisfies them. An improper learner avoids witness search: on a finite local check domain it estimates or memorizes the induced label table. This is the same representation-sensitive idea behind the clause-satisfaction lookup class and the classical proper/improper separations of Pitt--Valiant and Blumer--Ehrenfeucht--Haussler--Warmuth.

The hope is to strengthen the old clause-distribution reduction by using PCP soundness. If $I$ is satisfiable, some proper hypothesis has zero error on the $I$-component. If $I$ is unsatisfiable, every proper hypothesis has error at least a constant $\gamma>0$ on the $I$-component. The PCP theorem and its CSP formulations give exactly this kind of constant completeness/soundness gap for NP-hard instances; see Arora--Lund--Motwani--Sudan--Szegedy and Dinur for standard PCP references. Compared with the raw clause lookup argument, PCP gap removes the need to force every clause/check correct.

The question for this edge is sharper: can one choose a single fixed/global marginal $P$ that gives every size-$n$ hard instance polynomially visible mass, so that a marginal-nonuniform proper learner under this one $P$ would still imply a uniform randomized polynomial-time algorithm for the NP-hard language?

### Component-Mass Accounting

Let $\mathcal I_n$ be the set of hard instances of length $n$ used by the reduction. For SAT-like or PCP/CSP encodings, $|\mathcal I_n|$ is exponential in $n$ after restricting to any standard binary encoding with at least $2^{\Omega(n)}$ syntactically valid instances.

A fixed global marginal over formula-indexed examples has component masses

$$
\mu_I = P(X_I),
\qquad I\in\bigcup_n \mathcal I_n,
$$

where the components $X_I$ are disjoint or can be made disjoint by including the instance identifier in the example. For each $n$,

$$
\sum_{I\in\mathcal I_n}\mu_I \le 1.
$$

Therefore, for any threshold $\tau_n>0$, at most $1/\tau_n$ instances in $\mathcal I_n$ can have $\mu_I\ge \tau_n$. In particular, if $\tau_n=1/\operatorname{poly}(n)$, then only polynomially many size-$n$ instances can have polynomially visible mass, while $\mathcal I_n$ contains exponentially many instances. Equivalently, for every polynomial $q$, for all large $n$ there is some $I\in\mathcal I_n$ with

$$
\mu_I < \frac{1}{q(n)}.
$$

More strongly, the average component mass inside $\mathcal I_n$ is at most $1/|\mathcal I_n|$, so most components have exponentially small mass unless the distribution spends exponentially large total mass on size $n$, which is impossible in a probability distribution.

### Mass-Obstruction Lemma

**Lemma.** Consider any reduction that tries to refute marginal-nonuniform proper learnability by embedding each hard instance $I\in\mathcal I_n$ into a component $X_I$ of one fixed marginal $P$. Suppose the reduction needs the learner's final hypothesis to distinguish the satisfiable case

$$
\operatorname{err}_{P(\cdot\mid X_I)}(h)=0
$$

from the unsatisfiable case

$$
\operatorname{err}_{P(\cdot\mid X_I)}(h)\ge \gamma(n)
$$

for every proper witness-encoding hypothesis $h$, where $\gamma(n)\ge 1/\operatorname{poly}(n)$; PCP gap is the constant-$\gamma$ special case. Then a polynomial-time many-one or randomized Turing reduction using the marginal-nonuniform learner under this fixed $P$ requires $\mu_I\gamma(n)\ge 1/\operatorname{poly}(n)$ for every size-$n$ hard instance it must decide. No fixed probability distribution can satisfy this for all exponentially many size-$n$ instances.

**Proof sketch.** Under the global marginal $P$, the conditional component gap $\gamma(n)$ becomes an unconditional learning-error gap of only $\mu_I\gamma(n)$. To force the learner to reveal the witness distinction, the reduction must ask for accuracy

$$
\varepsilon < c\,\mu_I\gamma(n)
$$

for some constant $c<1$. The target learner's runtime for the fixed marginal is bounded by a polynomial $p_P(n,1/\varepsilon,\log(1/\delta))$. Since $p_P$ is polynomial in $1/\varepsilon$, the reduction remains polynomial-time only when $1/(\mu_I\gamma(n))$ is polynomially bounded. If $\gamma(n)\ge 1/\operatorname{poly}(n)$, this requires $\mu_I\ge 1/\operatorname{poly}(n)$.

But the component-mass accounting above shows that a fixed probability distribution can assign inverse-polynomial mass to only polynomially many members of an exponentially large $\mathcal I_n$. Hence some size-$n$ hard instances necessarily have too little mass, making the needed $1/\varepsilon$ superpolynomial. This blocks the uniform NP-hardness reduction.

### Why PCP Does Not Repair The Route

PCP gap improves the old clause lookup requirement from roughly

$$
\varepsilon < \mu_I/M_I
$$

to roughly

$$
\varepsilon < \gamma\mu_I,
$$

where $M_I$ is the number of local checks and $\gamma>0$ is the soundness gap. This is a real improvement inside one component. It removes the extra polynomial factor $M_I$, but it does not remove the component mass $\mu_I$. The global marginal still has to allocate mass among exponentially many instance components. Thus for some hard size-$n$ instances, even constant-gap PCP soundness is visible only at exponentially small global error scale.

This is exactly where the marginal-nonuniform definition matters. If the reduction used an instance-dependent marginal $P_I$, the learner's polynomial $p_{P_I}$ could depend on $I$, so the reduction would not obtain one uniform polynomial-time algorithm. If the reduction uses one fixed $P$, the polynomial $p_P$ is fixed, but the mass of most instance components is too small to query the learner at polynomially bounded $1/\varepsilon$.

### Side Constraint: Keeping The Source True

There is also a source-side engineering constraint. In the original clause-satisfaction lookup class, the size-$n$ domain is just the set of $O(n^3)$ clauses over $n$ variables, so an improper learner can estimate a finite table in polynomial time. If a global PCP/CSP construction includes the instance identifier inside the example, then the apparent size-$n$ domain may contain exponentially many $(I,\text{check})$ atoms. A distribution-free improper learner cannot simply estimate the whole global table unless the representation-size convention or the class structure keeps the relevant finite table polynomially bounded. This is not the main obstruction above, but it is another reason the engineered route needs care before it can even qualify as a source-node witness.

### Verdict

`unresolved`, with this false-witness route blocked.

The PCP/CSP lookup strategy does not currently resolve the edge as `false`. The clean obstruction is: a fixed/global marginal cannot put polynomially visible mass on every hard instance of length $n$ while remaining a probability distribution. PCP soundness gives a constant conditional gap inside each component, but after mixing all components into one fixed marginal the visible global gap is multiplied by the component mass. Since exponentially many size-$n$ hard instances compete for total mass at most $1$, some instances have exponentially small visible gap, and the reduction's required accuracy becomes superpolynomial.

This does not prove the edge `true`. It only retires the most tempting engineered fixed-marginal version of the clause/PCP lookup counterexample. The remaining open problem is still the generic properization question: whether every efficiently distribution-free improperly realizable class admits an efficient marginal-nonuniform proper learner.

### Citations And Anchors

- Valiant 1984 and Blumer--Ehrenfeucht--Haussler--Warmuth 1989 for the PAC framework and finite-class/VC sample-control background.
- Karp 1972 for NP-completeness of SAT/3-SAT-style source problems used in the lookup reductions.
- Pitt--Valiant 1988 for the classical representation-sensitive proper/improper learning separation.
- Arora--Lund--Motwani--Sudan--Szegedy 1998, "Proof Verification and the Hardness of Approximation Problems," JACM 45(3):501--555, DOI `10.1145/278298.278306`, and Dinur 2007, "The PCP theorem by gap amplification," JACM 54(3), DOI `10.1145/1236457.1236459`, for constant-gap PCP/CSP hardness.
- Hanneke--Moran--Thiessen 2025 for the marginal-nonuniform convention that the learner is uniform but its polynomial bound may depend on the fixed marginal $P$, not on the target concept or requested accuracy/confidence.

### Next Directions

1. Stop pursuing formula-indexed universal marginals for PCP/CSP lookup witnesses unless the construction has a way to avoid one component per hard instance or to amplify exponentially small component mass without exponentially small $\varepsilon$.
2. Look instead for a single natural fixed marginal whose support does not decompose into exponentially many low-mass hard-instance components, but under which proper hypotheses still encode an NP-hard witness search problem.
3. Separately test positive marginal-nonuniform properization for lookup-like classes: for a fixed $P$, heavy atoms or heavy components may be learnable/properizable by spending the marginal-dependent polynomial on discovering the relevant finite support, while low-mass components can be ignored at accuracy $\varepsilon$.

## Depth-3 Entry - 2026-05-04

### Focus Of This Pass

This pass tests the positive direction suggested at the end of depth 2:

> Does the fixed marginal in the target let us properize by exhaustive ERM, because the runtime polynomial may depend on that marginal?

The target quantifiers matter. The learner is still one uniform algorithm. It is not given a $P$-specific advice string, table of covers, list of heavy atoms, or proper consistency oracle. For each fixed marginal $P$, its sample complexity and runtime only have to be bounded by some polynomial $p_P(s,1/\varepsilon,\log(1/\delta))$, where $p_P$ may depend on $P$ but not on the target concept $c$.

Thus a positive argument may spend $P$-dependent time discovering features of $P$ from samples, and may have constants or degrees depending on $P$. It may not hide target-dependent search or superpolynomial dependence on $s$ or $1/\varepsilon$ inside the phrase "fixed marginal."

### What Fixed Finite Support Does Give

There is a genuine conditional positive theorem for very discrete marginals.

Assume $P$ has finite support $S_P$, all atoms can be recognized from examples, concepts in $\mathcal C$ are effectively enumerable and evaluable, and every labeling of $S_P$ realized by some concept of size at most $s$ has at least one representative whose discovery time under the enumeration is bounded by a $P$-dependent polynomial in $s$. Then proper learning under $P$ is possible by a marginal-nonuniform exhaustive procedure:

1. sample long enough to see all atoms in $S_P$ with high probability; the needed time depends on the minimum atom mass of $P$;
2. record the target labels on the observed support;
3. enumerate concepts until finding a member of $\mathcal C$ consistent with those labels;
4. output that concept.

For fixed finite $S_P$, even an expensive enumeration over all label patterns on $S_P$ has only a $P$-dependent constant number of patterns. If the minimal representatives for those patterns have finite lengths bounded by a constant depending on $P$, then this is a valid marginal-nonuniform proper learner. In this special case the result does not need the source improper learner; finite support alone collapses the computational problem to a finite amount of $P$-dependent work.

This is the cleanest sense in which "precomputation" helps. But it helps only if the uniform learner can effectively discover the required finite object, or if the object is recoverable by enumeration in time bounded independently of the target concept. The target definition does not permit a different hardwired algorithm for each marginal.

### Heavy Atoms And Effective Discrete Tails

The same idea extends partway to countable/discrete marginals with effective tails. For each $\varepsilon$, let $H_{P,\varepsilon}$ be a finite set of atoms with

$$
P(X\setminus H_{P,\varepsilon})\le \varepsilon/4.
$$

If a learner can identify $H_{P,\varepsilon}$ from samples in $P$-dependent polynomial time and can find, uniformly over all target concepts, a proper concept matching the observed labels on $H_{P,\varepsilon}$ in $P$-dependent polynomial time, then the tail can be ignored and the finite-support argument gives proper error at most $\varepsilon$.

This gives a useful conditional positive subedge, but it is not a consequence of finite VC dimension alone. The proper consistency step over $H_{P,\varepsilon}$ can still be hard. If one precomputes representatives for every realized labeling of $H_{P,\varepsilon}$, the table has up to

$$
2^{|H_{P,\varepsilon}|}
$$

entries. This is polynomial in $1/\varepsilon$ only under strong growth conditions such as $|H_{P,\varepsilon}|=O_P(\log(1/\varepsilon))$, or under a separate structural assumption giving a polynomial-time proper consistency solver. If $|H_{P,\varepsilon}|$ grows like a power of $1/\varepsilon$, brute-force representative tables are generally superpolynomial.

A second subtlety is target-uniformity. Enumerating concepts until one consistent with the labeled heavy atoms appears can take time depending on the particular target's representation or on the first representative realizing that target's trace. The marginal-nonuniform target allows dependence on the representation-size parameter $s$, but not on which $c$ of size $s$ generated the labels except through a polynomial bound uniform over all such $c$. So the needed assumption is not merely "a representative exists"; it is a uniform polynomial search bound for all realizable traces on the heavy support.

### Why Finite VC And Exhaustive ERM Do Not Suffice

Finite VC dimension gives the sample-complexity half of the story. For each fixed $P$ and $\varepsilon$, the pseudometric

$$
d_P(c,c')=P(c\triangle c')
$$

has finite covers at the relevant scale, and unbounded ERM can choose a proper hypothesis. Benedek--Itai and Ben-David--Benedek--Mansour are exactly in this information-theoretic world: fixed-distribution learnability is characterized by finite covers or related uniformity parameters, while computation is either secondary or explicitly outside the main characterization.

But a finite cover is not the same as an efficiently constructible cover, and an empirical risk minimizer is not the same as a polynomial-time proper learner. Even under a fixed marginal, the algorithm must solve a representation-sensitive search problem:

$$
\text{given labeled samples, find some } c'\in\mathcal C \text{ consistent with them, or nearly so under } P.
$$

That is exactly the step classical proper-learning hardness results exploit. The source improper learner can output an accurate external classifier $h$, but it does not supply a projection

$$
h \mapsto c'\in\mathcal C
$$

with small $P$-error. Exhaustive ERM over representations of length $\le s$ is generally exponential in $s$, and a $P$-dependent polynomial cannot absorb exponential dependence on the representation-size parameter.

### Continuous And Arbitrary Infinite-Support Marginals

Arbitrary fixed marginals defeat the heavy-atom route outright. If $P$ is non-atomic, every singleton has mass $0$, so there is no finite high-mass atom set to discover. A learner can still draw samples and finite VC theory can still guarantee generalization, but the properization problem is now a geometric or syntactic projection problem over a continuum-scale support. The fixed marginal may define finite $\varepsilon$-covers in $d_P$, but those covers may be nonconstructive, may require representatives with no efficiently discoverable descriptions, and may not be recoverable from unlabeled samples in polynomial time.

Even for countably infinite support, there need not be an effective polynomial tail schedule. A fixed marginal can have a very long tail, and although the polynomial $p_P$ may depend on that tail, the dependence must still be polynomial in $1/\varepsilon$. Marginals whose effective support size grows faster than every polynomial in $1/\varepsilon$ defeat the naive "learn all heavy atoms" implementation unless extra structure gives a compressed proper representation.

Thus arbitrary continuous or infinite-support marginals block the proposed generic theorem. They do not by themselves give a counterexample, but they show that finite VC/sample learnability plus an efficient improper learner does not automatically produce an efficient marginal-nonuniform proper learner by exhaustive fixed-marginal ERM.

### Relation To The Source Improper Learner

The source assumption is still useful only if it can be paired with an efficient projection or compression principle. A plausible conditional positive statement would be:

> If $\mathcal C$ has an efficient distribution-free improper realizable learner and, for every marginal $P$, there is a $P$-dependent polynomial-time proper projection procedure that maps any accurate improper hypothesis to a concept $c'\in\mathcal C$ with comparable $P$-error, then $\mathcal C$ satisfies `efficient-marginal-nonuniform-realizable-proper-pac`.

But the projection procedure is exactly the missing extra structure. Finite VC dimension supplies enough samples to validate a proposed projection, not enough computation to find one.

For lookup-like classes the fixed-marginal story is more optimistic: if each fixed $P$ exposes only finitely or logarithmically many relevant atoms at accuracy $\varepsilon$, then a $P$-dependent exhaustive properization may work. This would explain why the old formula-dependent hard marginals fail as false witnesses and why some discrete fixed marginals become positive. It remains a class-specific theorem, not a generic implication from the source node.

### Verdict For The Original Edge

`unresolved`.

Depth 3 supports a conditional positive result under strong fixed-marginal structure, especially finite support or effectively discrete heavy-atom support plus a target-uniform proper consistency/projection bound. It does not resolve the atlas edge as `true`, because arbitrary fixed marginals can be continuous or have ineffective/infinite support, and finite VC/sample learnability gives no polynomial-time proper ERM procedure. It also does not resolve the edge as `false`, because this pass did not produce a fixed-marginal hardness witness satisfying the efficient distribution-free improper source.

The best current atlas verdict remains `open` with `evidence: unknown`.

### Follow-Up Directions

1. Formulate a positive auxiliary lemma for finite-support marginals: every effectively enumerable concept class is marginal-nonuniform properly learnable under a fixed finite support, provided the uniform learner can discover support atoms and representative concepts with target-uniform $P$-dependent bounds.
2. Look for an intermediate "effectively discrete marginal" condition where $|H_{P,\varepsilon}|=O_P(\log(1/\varepsilon))$ or where traces on $H_{P,\varepsilon}$ have polynomial-size representative sets.
3. Search for a class with an efficient improper learner but where, under one fixed continuous marginal, proper projection of an accurate improper hypothesis is conditionally hard. This would be a stronger and cleaner false-witness route than formula-indexed universal marginals.
4. Keep finite VC/sample learnability separate from computational ERM in the atlas prose: the former gives existence of proper hypotheses under $P$, while the latter is the unresolved search problem.

### Sources And Anchors

- Benedek and Itai, "Learnability with respect to fixed distributions," Theoretical Computer Science 86(2), 1991, DOI `10.1016/0304-3975(91)90026-X`. The abstract characterizes fixed-distribution learnability by finite covers and explicitly notes that the main focus is sample count rather than computation; it also records the special role of discrete distributions.
- Ben-David, Benedek, and Mansour, "A parameterization scheme for classifying models of PAC learnability," Information and Computation 120(1), 1995, DOI `10.1006/inco.1995.1094`. Relevant for the uniformity-parameter and cover viewpoint, but explicitly information-theoretic rather than a computational properization theorem.
- Blumer--Ehrenfeucht--Haussler--Warmuth 1989 for the finite-VC sample-complexity route and the distinction between sample control and efficient hypothesis finding.
- Pitt--Valiant 1988 and the DNF/lookup witnesses from earlier entries for the representation-sensitive proper-search obstruction.

## Depth-4 Entry - 2026-05-05

### Verdict

`resolved false`, conditionally.

Assuming a length-preserving one-way function, the edge

$$
\texttt{efficient-realizable-improper-pac}
\;\Rightarrow\;
\texttt{efficient-marginal-nonuniform-realizable-proper-pac}
$$

fails. The counterexample is not a PRF class, since PRF classes would also defeat the efficient improper source. Instead it is an image-coordinate representation class: the labels reveal the one-way image coordinate-by-coordinate, so an improper learner can memorize the visible coordinates, but any sufficiently accurate proper learner under one fixed marginal must output a preimage and hence invert the one-way function.

This resolves the obstruction left by depths 0--3. The earlier lookup/PCP attempts failed because a fixed marginal had to allocate mass separately to exponentially many hard instances. Here the fixed marginal allocates inverse-polynomial mass to one coordinate block per length; the hard instance is the target concept's hidden seed, not a separate low-mass marginal component.

### Definitions Used

- Source: `efficient-realizable-improper-pac`. One distribution-free randomized polynomial-time learner must PAC-learn every target concept, but it may output hypotheses outside the representation class.
- Target: `efficient-marginal-nonuniform-realizable-proper-pac`. One uniform learner must work for every fixed marginal $P$, with a $P$-dependent polynomial runtime/sample bound, and must output a hypothesis in the original class.
- Properness convention: a proper hypothesis must be represented by a valid concept representation. For the counterexample below, that means outputting a seed $t$ whose image under the one-way function induces the learned coordinate labels.
- Cryptographic assumption: there is a polynomial-time computable length-preserving one-way function $f:\{0,1\}^n\to\{0,1\}^n$, hard to invert with non-negligible probability over uniform $s\in\{0,1\}^n$. A one-way permutation is more than enough; injectivity is not essential if "invert" means finding any preimage.

### Sources Checked

- Existing atlas context:
  - `atlas/definitions/efficient-realizable-improper-pac.md`
  - `atlas/definitions/efficient-marginal-nonuniform-realizable-proper-pac.md`
  - `atlas/implications/efficient-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`
  - `atlas/arguments/properization-open.md`
  - `atlas/witnesses/pseudorandom-function-classes.md`
  - `atlas/arguments/sample-to-computational-hardness.md`
  - `references.bib`, especially existing keys `goldreich1986` and `kearns1994cryptographic`
- Primary source anchors:
  - Kearns and Valiant, "Cryptographic Limitations on Learning Boolean Formulae and Finite Automata," JACM 1994, DOI `10.1145/174644.174647`, PDF checked at https://www.cis.upenn.edu/~mkearns/papers/cryptojacm.pdf. Their introduction explicitly frames cryptographic inversion as a learning obstruction and distinguishes representation-independent from representation-based hardness.
  - Goldreich, Goldwasser, and Micali, "How to Construct Random Functions," JACM 1986, DOI `10.1145/6490.6503`, already used in the atlas for cryptographic learning witnesses.
  - Goldreich and Levin, "A Hard-Core Predicate for all One-Way Functions," STOC 1989, PDF checked at https://www.cs.bu.edu/fac/lnd/pdf/hard.pdf, for the standard easy-to-evaluate/hard-to-invert one-way-function viewpoint.
  - Håstad, Impagliazzo, Levin, and Luby, "A Pseudorandom Generator from any One-way Function," SIAM J. Comput. 1999, DOI `10.1137/S0097539793244708`, checked at https://epubs.siam.org/doi/10.1137/S0097539793244708, for the centrality and standardness of one-way functions as a cryptographic assumption.

### Theorem Route

The positive theorem route still fails. The source learner gives only an accurate external classifier. It gives no generic way to produce a valid concept representation. The depth-3 finite-support idea also does not save the edge because the fixed marginal below has very simple, effectively discrete support and still forces proper inversion.

In fact, this counterexample shows that the missing projection principle is impossible under the one-way-function assumption: an efficient $P$-dependent proper projection for this class would invert $f$.

### Counterexample Route

Let $f:\{0,1\}^n\to\{0,1\}^n$ be a length-preserving one-way function. Define the domain

$$
X=\{(1^k,i,b): k\ge 1,\; i\in[k],\; b\in\{0,1\}\}.
$$

For a seed $s\in\{0,1\}^n$, let $y=f(s)$ and define the concept $c_s$ by

$$
c_s(1^k,i,b)=1
\quad\Longleftrightarrow\quad
k=n \text{ and } b=y_i.
$$

Thus the length-$n$ block contains exactly one positive point for each coordinate $i$, namely the point whose bit component equals the $i$th bit of $f(s)$. All other length blocks are labeled $0$. The representation class is

$$
\mathcal C=\{c_s:s\in\{0,1\}^*\},
$$

where a proper representation is the seed $s$ and evaluation computes $f(s)$.

**Why the source holds.** There is a distribution-free improper learner. On samples labeled by $c_s$, record every positive atom seen and output the lookup hypothesis that labels those recorded atoms $1$ and every other point $0$. There are at most $n$ positive atoms for a target of representation size $n$. With

$$
O\!\left(\frac{n}{\varepsilon}\log\frac{n}{\delta}\right)
$$

examples, every positive atom of mass at least $\varepsilon/n$ is seen with probability at least $1-\delta$, and the total mass of unseen positive atoms is at most $\varepsilon$. The learner is polynomial-time and distribution-free, but improper because the recorded partial table need not be the image-coordinate table of any seed.

**Fixed marginal for the target failure.** Define one computable marginal $P$ by choosing $k$ with mass

$$
\mu_k=\frac{6}{\pi^2 k^2},
$$

then choosing $i$ uniformly from $[k]$ and $b$ uniformly from $\{0,1\}$. For a target $c_s$ with $|s|=n$, set

$$
\varepsilon_n=\frac{\mu_n}{3n}.
$$

This has $1/\varepsilon_n=O(n^3)$.

If a proper hypothesis $c_t$ has $P$-error at most $\varepsilon_n$ against $c_s$, then $|t|=n$ and $f(t)=f(s)$. Indeed, if $|t|\ne n$, then on the length-$n$ block $c_t$ labels every point $0$, while $c_s$ labels one of the two bit-points positive for each coordinate, giving error $\mu_n/2>\varepsilon_n$. If $|t|=n$ but $f(t)$ differs from $f(s)$ in at least one coordinate, that coordinate contributes error $\mu_n/n>\varepsilon_n$. Hence low proper error forces exact image equality.

Now suppose the target node held for this class. Fix the marginal $P$ above, and let $A$ be the marginal-nonuniform proper learner with polynomial $p_P$. Given a one-way-function challenge $y=f(s)$ for uniform unknown $s\in\{0,1\}^n$, simulate labeled examples for the target concept whose length-$n$ image is $y$: sample $(1^k,i,b)\sim P$ and return label $1$ exactly when $k=n$ and $b=y_i$. Run $A$ with accuracy $\varepsilon_n$ and constant confidence, then output its proper seed $t$.

The simulation uses only $y$, not $s$. The runtime is polynomial in $n$ because $p_P$ is a fixed polynomial and $1/\varepsilon_n=O(n^3)$. With the learner's success probability, the output satisfies $f(t)=y$. This is a probabilistic polynomial-time inverter for $f$ with non-negligible, in fact constant, success probability over uniform $s$, contradicting the one-way-function assumption.

### Concrete Obstruction

The concrete obstruction is syntactic properness, not prediction. Prediction is easy because the labels directly expose the image bits on any high-mass coordinates. Proper learning is hard because the only proper names for the same labeling are seeds whose images match those bits. Under the fixed marginal $P$, requesting inverse-polynomial accuracy forces all $n$ image bits to match, so proper learning performs inversion.

This also explains why the standard PRF witness was too strong for this edge. PRF labels remain hard even for improper prediction. The image-coordinate class is deliberately weaker: it is designed so improper prediction is easy, while proper representation recovery is cryptographically hard.

### Exact Atlas Changes If Applied

Do not apply these in this pass because the user restricted edits to this scratchpad. The exact atlas update would be:

1. Add a new witness note, e.g. `atlas/witnesses/one-way-image-coordinate-class.md`, with:
   - `type: witness`
   - `id: one-way-image-coordinate-class`
   - `title: One-Way Image Coordinate Class`
   - `assumptions: ["length-preserving one-way functions exist"]`
   - `ref_keys: [kearns1994cryptographic, goldreich1986]`
   - body defining the class above, proving efficient distribution-free improper realizable learning, and proving fixed-marginal proper inversion hardness.
2. Update `references.bib` only if a separate one-way-function reference key is desired. Existing keys `goldreich1986` and `kearns1994cryptographic` are already present; optional additions would be Goldreich--Levin 1989 and Håstad--Impagliazzo--Levin--Luby 1999.
3. Update `atlas/implications/efficient-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`:
   - `status: "false"`
   - `evidence: conditional-counterexample`
   - `assumptions: ["length-preserving one-way functions exist"]`
   - `witnesses: ["one-way-image-coordinate-class"]`
   - `ref_keys:` include `kearns1994cryptographic` and `goldreich1986`, plus any added one-way-function keys
   - replace the current open verdict with the counterexample proof above
   - consider changing `family` from `properization-open` to a new family such as `cryptographic-proper-representation-hardness`, or keep the family while updating the family note to say this marginal-nonuniform subedge is no longer open.
4. Update `atlas/arguments/properization-open.md` to remove or qualify the claim that this marginal-nonuniform edge remains open; add a sentence that image-coordinate cryptographic witnesses can defeat marginal-nonuniform properization because all hard targets of a given length share one visible coordinate block.
5. Update `atlas/registry/edge_families.yml` if a new family is introduced.

### Next Directions

1. Formalize whether the atlas prefers the assumption phrase "length-preserving one-way functions exist", "one-way permutations exist", or the broader "standard cryptographic assumptions". The cleanest proof uses a length-preserving one-way function; a one-way permutation makes the exposition even simpler.
2. Add the witness note and update the edge when atlas edits are allowed.
3. Check neighboring properization-open edges: the same image-coordinate witness likely resolves other improper-to-proper marginal-nonuniform strong edges, and variants may resolve distribution-free properization edges as well.
4. Decide whether to add Goldreich--Levin 1989 or HILL 1999 to `references.bib` for a direct one-way-function citation, or rely on existing `goldreich1986` and `kearns1994cryptographic` keys already used for cryptographic learning hardness.
