# Open Edge Resolution Scratchpad

Edge: `efficient-agnostic-improper-pac -> efficient-marginal-nonuniform-agnostic-proper-pac`

## Research Log

## Sources Checked

## Proof Or Counterexample Attempts

## Verdict

## Follow-Up Directions

## Depth-1 Entry - 2026-05-05

### Verdict

Resolved `false`, under the assumption $\mathrm{NP}\nsubseteq\mathrm{RP}$.

The old open note treats this as a generic properization problem, but the agnostic target gives a cleaner fixed-marginal hardness route. The clause-satisfaction lookup class satisfies `efficient-agnostic-improper-pac` by a polynomial-size lookup-table learner. If it also satisfied `efficient-marginal-nonuniform-agnostic-proper-pac`, then applying the learner under one fixed uniform-clause marginal would give a one-sided randomized polynomial-time algorithm for 3-SAT.

### Definitions Used

- Source: `atlas/definitions/efficient-agnostic-improper-pac.md`.
  The learner must work distribution-free, strongly agnostically, in polynomial sample complexity and runtime, but may output a hypothesis outside $\mathcal C$.
- Target: `atlas/definitions/efficient-marginal-nonuniform-agnostic-proper-pac.md`.
  One uniform learner must output $h\in\mathcal C$. For every marginal $P$, its sample complexity and runtime are bounded by a polynomial $p_P(s,1/\varepsilon,\log(1/\delta))$ that may depend on $P$ but not on the conditional label rule.
- Edge note: `atlas/implications/efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-proper-pac.md`.
  Current atlas status is `open`, evidence `unknown`, family `properization-open`.
- Witness/argument notes:
  `atlas/witnesses/clause-satisfaction-lookup-class.md` and `atlas/arguments/clause-satisfaction-proper-hardness.md`.

### Sources Checked

Local notes checked:

- `atlas/definitions/efficient-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-agnostic-proper-pac.md`
- `atlas/implications/efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-proper-pac.md`
- `atlas/implications/efficient-agnostic-improper-pac--implies--efficient-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-agnostic-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/clause-satisfaction-proper-hardness.md`
- `atlas/witnesses/clause-satisfaction-lookup-class.md`
- `atlas/arguments/sample-complexity-equivalence.md`

Primary or near-primary web sources checked:

- Blumer, Ehrenfeucht, Haussler, and Warmuth, "Learnability and the Vapnik-Chervonenkis Dimension", DOI/search/PDF checked via https://doi.org/10.1145/76359.76371 and https://trhvidsten.com/docs/classics/Blumer-1989.pdf. Used for the standard PAC/finite-class uniform-convergence background behind the lookup learner.
- Karp, "Reducibility Among Combinatorial Problems", Springer page checked at https://link.springer.com/chapter/10.1007/978-3-540-68279-0_8. Used for NP-completeness of satisfiability/3-SAT.
- Benedek and Itai, "Learnability with respect to fixed distributions", ScienceDirect page checked at https://www.sciencedirect.com/science/article/pii/030439759190026X. Used only to confirm the fixed-distribution/marginal-nonuniform interpretation; the counterexample itself is self-contained once the atlas target definition is fixed.

### Theorem Route

A generic theorem route would have to turn an efficient agnostic improper learner into an efficient agnostic proper learner under every fixed marginal. The source learner may output an arbitrary lookup table or other outside representation, and the target asks for an efficient search procedure over $\mathcal C$. The sample-only theorem route is real: unbounded ERM over $\mathcal C$ would remove the obstruction. But computationally, no checked source supplies a general projection from a good improper hypothesis to a near-optimal proper one.

So the positive route fails for the usual reason: the source gives prediction power, not an optimizer over the proper representation class.

### Counterexample Route

Use the clause-satisfaction lookup class.

For each $n$, let $X_n$ be the set of all 3-CNF clauses over variables $x_1,\ldots,x_n$, allowing a harmless preprocessing step that removes duplicate clauses from input formulas. Then $N_n=|X_n|=O(n^3)$. For each assignment $a\in\{0,1\}^n$, define

$$
h_a(C)=1
\quad\Longleftrightarrow\quad
a\text{ satisfies }C.
$$

Let $\mathcal H_n=\{h_a:a\in\{0,1\}^n\}$. Proper hypotheses are assignments. Evaluating a proper hypothesis on a clause is polynomial time.

Why the source holds:
Let $\mathcal F_n=\{0,1\}^{X_n}$ be all Boolean lookup tables on clauses. Since $\log|\mathcal F_n|=N_n=O(n^3)$, standard finite-class uniform convergence gives agnostic learning of $\mathcal F_n$ with

$$
m=O\left(\frac{n^3+\log(1/\delta)}{\varepsilon^2}\right)
$$

samples. The learner computes the empirical majority label for every clause seen, stores a lookup table, and uses a default value for unseen clauses. Equivalently, it can compute an ERM over $\mathcal F_n$ by clause-wise majority. Since $\mathcal H_n\subseteq\mathcal F_n$, the resulting improper hypothesis has error at most

$$
\inf_{h\in\mathcal H_n}\operatorname{err}_{\mathcal D}(h)+\varepsilon
$$

with high probability, for every distribution $\mathcal D$ over $X_n\times\{0,1\}$. Runtime is polynomial in $n,1/\varepsilon,\log(1/\delta)$. Hence the class satisfies `efficient-agnostic-improper-pac`.

Why the target fails:
Fix the marginal family $P_{\mathrm{clause}}$, where at size $n$ the marginal is uniform over $X_n$. If the target held, there would be one polynomial $p_{P_{\mathrm{clause}}}$ bounding the runtime of the uniform proper agnostic learner under this fixed marginal family.

Given a 3-CNF formula

$$
\varphi=C_1\wedge\cdots\wedge C_M
$$

over $x_1,\ldots,x_n$, with duplicates removed, define a joint distribution $\mathcal D_\varphi$ with marginal $P_{\mathrm{clause}}$ as follows. Draw $C$ uniformly from $X_n$. If $C$ is a clause of $\varphi$, label it $1$ deterministically. If $C$ is not a clause of $\varphi$, label it by an independent fair coin.

For any assignment $a$,

$$
\operatorname{err}_{\mathcal D_\varphi}(h_a)
=
\frac{N_n-M}{2N_n}
+
\frac{|\{j:h_a(C_j)=0\}|}{N_n}.
$$

If $\varphi$ is satisfiable, some assignment has error

$$
B_\varphi=\frac{N_n-M}{2N_n}.
$$

If an assignment misses even one formula clause, its error is at least $B_\varphi+1/N_n$. Therefore, run the assumed marginal-nonuniform agnostic proper learner with

$$
\varepsilon=\frac{1}{3N_n},
\qquad
\delta=\frac13.
$$

On satisfiable $\varphi$, with probability at least $2/3$ it returns a proper hypothesis of error below $B_\varphi+1/N_n$, hence an assignment satisfying every clause of $\varphi$. On unsatisfiable $\varphi$, no proper hypothesis satisfies every clause, so the test "accept iff the returned assignment satisfies all clauses" never accepts.

The reduction can simulate samples from $\mathcal D_\varphi$ in polynomial time by drawing a uniform clause from $X_n$, checking membership in the input formula, and flipping fair coins off the formula. Since $P_{\mathrm{clause}}$ is fixed independently of $\varphi$, the learner's runtime is bounded by the single polynomial $p_{P_{\mathrm{clause}}}(n,3N_n,O(1))$, which is polynomial in the formula size. Thus the target would put 3-SAT in $\mathrm{RP}$, and hence $\mathrm{NP}\subseteq\mathrm{RP}$ by Karp's NP-completeness theorem.

Under $\mathrm{NP}\nsubseteq\mathrm{RP}$, the target cannot hold for this class.

### Concrete Obstruction

The obstruction is not merely "improper versus proper" in the abstract. The improper learner can learn arbitrary clause-label tables on the polynomial-size clause universe. The proper learner must return an assignment. By fixing the marginal to be uniform over all clauses and placing the SAT instance only in the conditional label rule, the marginal-nonuniform escape hatch is closed: the polynomial may depend on the uniform-clause marginal, but that marginal is the same for every formula of size $n$ in the reduction.

Fair noise on non-formula clauses is the key agnostic trick. It contributes exactly $1/2$ error to every assignment, so excess error under the fixed marginal measures only how many formula clauses the returned assignment fails to satisfy.

### Atlas-Ready Proof/Counterexample

The counterexample above is atlas-ready. It can replace the current open proof status with a conditional-counterexample proof using the clause-satisfaction lookup class.

Exact frontmatter changes for the implication note:

```yaml
status: "false"
evidence: conditional-counterexample
assumptions:
  - "NP not subset RP"
witnesses:
  - clause-satisfaction-lookup-class
ref_keys:
  - blumer1989
  - karp1972
  - benedek1991fixed
summary: "The clause-satisfaction lookup class is efficiently agnostically improperly learnable, but a marginal-nonuniform agnostic proper learner under the fixed uniform-clause marginal would decide 3-SAT in RP."
family: clause-satisfaction-proper-hardness
argument_note: "[[clause-satisfaction-proper-hardness|Clause-Satisfaction Proper Hardness]]"
witness_note: "[[clause-satisfaction-lookup-class|Clause-Satisfaction Lookup Class]]"
```

The body should state the verdict as `false` under $\mathrm{NP}\nsubseteq\mathrm{RP}$, give the construction of $\mathcal H_n$, prove the lookup-table agnostic improper learner, and then give the fixed uniform-clause marginal reduction above.

### Promising Next Directions

- Update the atlas implication note to use `clause-satisfaction-proper-hardness` instead of `properization-open`.
- Consider expanding `atlas/arguments/clause-satisfaction-proper-hardness.md` with the fixed uniform-clause marginal and fair-noise calculation, since that calculation is exactly what resolves marginal-nonuniform agnostic proper targets.
- Audit neighboring strong agnostic marginal-properization edges for the same fixed-marginal fair-noise argument. Weak edges are different because random assignments can already give weak advantage on ordinary 3-CNF clauses.
