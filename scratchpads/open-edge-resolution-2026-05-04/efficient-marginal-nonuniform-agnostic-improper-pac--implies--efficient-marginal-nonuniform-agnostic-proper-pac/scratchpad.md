# Open Edge Resolution Scratchpad

Edge: `efficient-marginal-nonuniform-agnostic-improper-pac -> efficient-marginal-nonuniform-agnostic-proper-pac`

## Research Log

## Sources Checked

## Proof Or Counterexample Attempts

## Verdict

## Follow-Up Directions

## Depth-1 Entry - 2026-05-05

### Verdict

Resolved as `false`, under the assumption $\mathrm{NP}\nsubseteq\mathrm{RP}$.

The existing clause-satisfaction lookup witness can be adapted to the marginal-nonuniform target by fixing the marginal in advance. Use the uniform marginal over all possible 3-CNF clauses on $n$ variables. Encode the input formula only in the conditional label rule: formula clauses are labeled $1$, while all non-formula clauses receive independent fair-coin labels. The fair-coin region contributes exactly $1/2$ error for every proper assignment hypothesis, so it is neutral; the formula clauses retain an inverse-polynomial gap.

### Definitions Used

- Source: `efficient-marginal-nonuniform-agnostic-improper-pac`. A single uniform learner may output outside $\mathcal C$; for each marginal $P$, sample and time bounds are bounded by a polynomial $p_P(s,1/\varepsilon,\log(1/\delta))$.
- Target: `efficient-marginal-nonuniform-agnostic-proper-pac`. Same marginal-dependent strong agnostic guarantee, but the learner must output $h\in\mathcal C$.
- Proper hypotheses for the witness are assignment concepts $h_a$, where $h_a(C)=1$ iff assignment $a$ satisfies clause $C$.

### Sources Checked

- Atlas source definition: `atlas/definitions/efficient-marginal-nonuniform-agnostic-improper-pac.md`.
- Atlas target definition: `atlas/definitions/efficient-marginal-nonuniform-agnostic-proper-pac.md`.
- Atlas edge note: `atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-proper-pac.md`.
- Atlas argument/witness notes: `atlas/arguments/properization-open.md`, `atlas/arguments/clause-satisfaction-proper-hardness.md`, `atlas/witnesses/clause-satisfaction-lookup-class.md`, `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`, `atlas/witnesses/pcp-active-slice-lookup-class.md`, and `atlas/arguments/fixed-k-term-dnf-proper-boosting-separation.md`.
- Benedek and Itai, fixed-distribution learning, ScienceDirect page: https://www.sciencedirect.com/science/article/pii/030439759190026X.
- Ben-David, Benedek, and Mansour, parameterization of PAC models, DOI/Tel Aviv page: https://cris.tau.ac.il/en/publications/a-parameterization-scheme-for-classifying-models-of-pac-learnabil.
- Hanneke, Moran, and Thiessen, marginal-nonuniform PAC learnability, OpenReview: https://openreview.net/forum?id=aoVCFtox89.
- Blumer, Ehrenfeucht, Haussler, and Warmuth, VC/finite-class learnability, PDF mirror of JACM paper: https://www.cis.upenn.edu/~danroth/Teaching/CS446-17/Papers/p929-blumer.pdf.
- Pitt and Valiant, computational limitations/proper-learning hardness context, ACM DOI/PDF listing: https://dl.acm.org/doi/10.1145/48014.63140 and PDF mirror https://www.cis.upenn.edu/~danroth/Teaching/CS446-17/Papers/p965-pitt.pdf.
- Karp, NP-completeness of 3-SAT source via atlas DOI: https://doi.org/10.1007/978-3-540-68279-0_8.
- Khot and Saket DNF hardness was checked only as a near-miss for properization: https://cs.nyu.edu/~khot/papers/minDNF.pdf.

### Theorem Route

I do not see a plausible generic theorem route. The source learner outputs an arbitrary efficient hypothesis competing with $\mathcal C$, and the target asks for a polynomial-time projection back into $\mathcal C$. The marginal-dependent polynomial only says that the runtime/sample bound may depend on the fixed marginal; it does not give an optimization oracle over proper hypotheses. Information-theoretic marginal-nonuniform results and finite-VC sample equivalences remove sample-complexity obstructions, but they do not supply a computational properization algorithm.

### Counterexample Route

Use the clause-satisfaction lookup class.

For each $n$, let $X_n$ be the set of all 3-CNF clauses over variables $x_1,\ldots,x_n$, allowing repeated literals if desired, so $N_n=|X_n|\le (2n)^3$. For every assignment $a\in\{0,1\}^n$, define a proper hypothesis

$$
h_a(C)=1 \quad\Longleftrightarrow\quad a \text{ satisfies } C.
$$

Let $\mathcal H_n=\{h_a:a\in\{0,1\}^n\}$.

**Why the source holds.** The improper class $\{0,1\}^{X_n}$ contains $\mathcal H_n$ and has $\log|\{0,1\}^{X_n}|=N_n=O(n^3)$. An improper learner can output the empirical majority label for each clause. Standard finite-class uniform convergence gives strong agnostic error within $\varepsilon$ of the best lookup table, hence within $\varepsilon$ of the best $h_a$, using polynomial samples and time. This is distribution-free efficient agnostic improper learning, so it implies the marginal-nonuniform source.

**Fixed marginal for the target hardness.** Fix, for every $n$, the marginal $P_n$ uniform on $X_n$. Suppose the target held for $\mathcal H$. For this fixed marginal family, the assumed learner has runtime polynomial in $n,1/\varepsilon,\log(1/\delta)$.

Given a 3-CNF formula $\varphi$ over $n$ variables, first remove duplicate clauses. Let $F\subseteq X_n$ be its set of clauses and $M=|F|\le N_n$. Define a joint distribution $\mathcal D_\varphi$ with marginal $P_n$ as follows:

- sample $C\sim P_n$;
- if $C\in F$, output label $Y=1$;
- if $C\notin F$, output an independent fair coin label.

For every assignment $a$,

$$
\operatorname{err}_{\mathcal D_\varphi}(h_a)
=
\frac{|\{C\in F:h_a(C)=0\}|}{N_n}
+
\frac{N_n-M}{2N_n}.
$$

The fair-coin part is exactly the same for all proper hypotheses. If $\varphi$ is satisfiable, some $a^\star$ has formula-clause error $0$, so the optimum proper error is $(N_n-M)/(2N_n)$. If $\varphi$ is unsatisfiable, every assignment falsifies at least one clause in $F$, so the optimum proper error is at least $(N_n-M)/(2N_n)+1/N_n$.

Run the assumed proper marginal-nonuniform agnostic learner on samples from $\mathcal D_\varphi$ with, say,

$$
\varepsilon=\frac{1}{3N_n},\qquad \delta=\frac13.
$$

In the satisfiable case, with probability at least $2/3$ the returned proper hypothesis $h_a$ has total error at most $(N_n-M)/(2N_n)+1/(3N_n)$. Since the non-formula contribution is fixed at $(N_n-M)/(2N_n)$ for every assignment, this forces $|\{C\in F:h_a(C)=0\}|<1$, hence $a$ satisfies every clause. In the unsatisfiable case, no proper hypothesis satisfies every clause.

The randomized decision algorithm for 3-SAT samples from $\mathcal D_\varphi$, runs the learner, and accepts iff the returned proper hypothesis satisfies all clauses of $\varphi$. It accepts satisfiable formulas with probability at least $2/3$ and never accepts unsatisfiable formulas. Because $N_n=O(n^3)$ and the learner's bound for the fixed uniform-clause marginal is polynomial, this puts 3-SAT in $\mathrm{RP}$. Thus the target cannot hold unless $\mathrm{NP}\subseteq\mathrm{RP}$.

### Concrete Obstruction

The old obstruction said formula-specific distributions do not refute a marginal-nonuniform target because the target may choose a separate polynomial for each marginal. The repair is to hold the marginal fixed: use uniform mass on every possible clause, and encode the formula through conditional labels. The only delicate point is avoiding irrelevant clauses swamping the formula signal; fair-coin labels make the irrelevant region contribute exactly $1/2$ error for every assignment, leaving a visible $1/N_n$ gap on formula clauses.

### Atlas-Ready Counterexample

**Verdict.** `false`, under $\mathrm{NP}\nsubseteq\mathrm{RP}$.

**Proof skeleton.** The clause-satisfaction lookup class is efficiently agnostically improperly PAC learnable by a polynomial-size lookup-table ERM. If it were efficiently marginal-nonuniform agnostically properly PAC learnable, apply the proper learner under the fixed uniform marginal over all 3-CNF clauses. For an input formula $\varphi$, label clauses of $\varphi$ by $1$ and all other clauses by fair coins. Every assignment has the same error on non-formula clauses, while satisfiable and unsatisfiable formulas differ by at least $1/N_n$ in the optimum proper error. Running the learner to accuracy $1/(3N_n)$ and checking whether the returned assignment satisfies all clauses decides 3-SAT with one-sided randomized error. This contradicts $\mathrm{NP}\nsubseteq\mathrm{RP}$.

**Exact atlas metadata changes if applied later.**

- `status: "false"`
- `evidence: conditional-counterexample`
- `assumptions: ["NP not subset RP"]`
- `witnesses: ["clause-satisfaction-lookup-class"]`
- `ref_keys: ["blumer1989", "karp1972"]`
- `family: clause-satisfaction-proper-hardness`
- `argument_note: "[[clause-satisfaction-proper-hardness|Clause-Satisfaction Proper Hardness]]"`
- `witness_note: "[[clause-satisfaction-lookup-class|Clause-Satisfaction Lookup Class]]"`
- `summary: "The clause-satisfaction lookup class is efficiently agnostically improperly learnable, while a marginal-nonuniform proper agnostic learner under the fixed uniform-clause marginal would decide 3-SAT by encoding the formula in conditional labels."`

### Promising Next Directions

- Update the atlas edge note with the fixed-marginal fair-coin-label proof above.
- Check sibling marginal-nonuniform properization edges: the same fixed-uniform-marginal repair should also resolve any target at least as weak as realizable/weak proper only if the agnostic fair-coin construction can be specialized to that target's guarantee. For purely realizable targets, the fair-coin trick no longer applies directly.
- Consider whether the PCP active-slice witness can be similarly fixed by padding every inactive slice with label noise; this may resolve marginal-nonuniform weak proper agnostic variants where a constant advantage gap is enough.
