# Open Edge Resolution Scratchpad

Edge: `efficient-weak-agnostic-improper-pac -> efficient-marginal-nonuniform-agnostic-proper-pac`

Assigned edge note:
`atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-proper-pac.md`

Depth: 1

Date: 2026-05-05

## Verdict

Resolved `false`, conditional on $\mathrm{NP}\nsubseteq \mathrm{RP}$.

The clause-satisfaction lookup class satisfies the source by a stronger property:
it is efficiently distribution-free strong agnostic learnable by an improper
lookup-table ERM. It fails the target because a marginal-nonuniform strong
agnostic proper learner under the fixed uniform-clause marginal would decide
3-SAT with one-sided randomized error.

Thus this edge does not need a new agnostic boosting theorem to be refuted. The
source side can be made strong already; the obstruction is properization under
a fixed marginal.

## Files Checked

- `atlas/definitions/efficient-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-agnostic-proper-pac.md`
- `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-proper-pac.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/clause-satisfaction-proper-hardness.md`
- `atlas/witnesses/clause-satisfaction-lookup-class.md`
- `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-agnostic-proper-pac.md`
- `atlas/implications/efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-proper-pac.md`
- `atlas/implications/efficient-agnostic-improper-pac--implies--efficient-weak-agnostic-improper-pac.md`
- `references.bib`

Reference keys checked in `references.bib`:

- `blumer1989`: finite-class/VC uniform convergence background.
- `karp1972`: NP-completeness of satisfiability/3-SAT.
- `bendavid2001` and `kalai2008agnosticboosting`: context for the weak
  agnostic source and why fixed-additive agnostic boosting is tracked
  separately.
- `benedek1991fixed`, `bendavid1995parameterization`, and
  `hanneke2025marginalnonuniform`: context for the marginal-nonuniform target
  convention.

No additional external primary-source check was needed for the resolution,
because the counterexample uses the finite-domain ERM calculation and Karp
hardness facts already recorded in the atlas references.

## Definitions Used

The source requires one distribution-free polynomial-time learner which, for
every joint distribution, outputs an arbitrary hypothesis with

$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta
$$

for a fixed $\beta<1/2$.

The target requires one uniform learner which outputs $h\in\mathcal C$ and, for
each fixed marginal $P$, has a polynomial $p_P$ so that for every conditional
label distribution with marginal $P$ it achieves

$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\varepsilon
$$

in time and samples bounded by
$p_P(s,1/\varepsilon,\log(1/\delta))$.

The clause-satisfaction witness satisfies the stronger
`efficient-agnostic-improper-pac` source. By the monotone implication
`efficient-agnostic-improper-pac -> efficient-weak-agnostic-improper-pac`, it
satisfies the assigned source.

## Counterexample

### Construction

For each $n$, let $X_n$ be the set of all 3-CNF clauses over variables
$x_1,\ldots,x_n$, after any harmless convention fixing the exact finite clause
universe. In particular,

$$
N_n=|X_n|=\operatorname{poly}(n).
$$

For each assignment $a\in\{0,1\}^n$, define the proper hypothesis

$$
h_a(C)=1
\quad\Longleftrightarrow\quad
a \text{ satisfies } C .
$$

Let

$$
\mathcal H_n=\{h_a:a\in\{0,1\}^n\}.
$$

Proper hypotheses are assignments. Evaluating $h_a(C)$ is polynomial time.

### Why The Source Holds

Let $\mathcal F_n=\{0,1\}^{X_n}$ be the improper class of all Boolean lookup
tables on the clause universe. Since $N_n=\operatorname{poly}(n)$,

$$
\log|\mathcal F_n|=N_n=\operatorname{poly}(n).
$$

Given a labeled sample from an arbitrary distribution on
$X_n\times\{0,1\}$, compute an ERM over $\mathcal F_n$ by empirical majority
vote separately for each sampled clause, with arbitrary defaults on unseen
clauses. Standard finite-class uniform convergence gives, for

$$
m=O\left(\frac{N_n+\log(1/\delta)}{\varepsilon^2}\right),
$$

with probability at least $1-\delta$,

$$
\operatorname{err}_{\mathcal D}(\hat g)
\le
\inf_{g\in\mathcal F_n}\operatorname{err}_{\mathcal D}(g)+\varepsilon
\le
\inf_{h\in\mathcal H_n}\operatorname{err}_{\mathcal D}(h)+\varepsilon .
$$

The ERM and output table have polynomial size and are computable in polynomial
time because the clause universe is polynomial. Hence the class is efficiently
strong agnostic learnable by an improper learner. Running this stronger learner
at any fixed constant accuracy, for example $\varepsilon=1/6$, gives the
assigned fixed-additive weak agnostic improper guarantee.

### Why The Target Fails

Use the atlas marginal-nonuniform convention exactly as in
`clause-satisfaction-proper-hardness`: fix, for each size $n$, the marginal
$P_{\mathrm{clause},n}$ uniform over $X_n$. Equivalently, this is the fixed
uniform-clause marginal family; it does not depend on the input formula.

Assume toward contradiction that the target learner exists. For this fixed
marginal family, the target gives one polynomial $p_{P_{\mathrm{clause}}}$
bounding its time and samples.

Given a 3-CNF formula

$$
\varphi=C_1\wedge\cdots\wedge C_M
$$

over $x_1,\ldots,x_n$, remove duplicate clauses. Define a joint distribution
$\mathcal D_\varphi$ with marginal uniform over $X_n$ as follows:

- if $C\in\{C_1,\ldots,C_M\}$, label $C$ by $1$;
- if $C\notin\{C_1,\ldots,C_M\}$, label $C$ by an independent fair coin.

For every assignment $a$,

$$
\operatorname{err}_{\mathcal D_\varphi}(h_a)
=
\frac{N_n-M}{2N_n}
+
\frac{|\{j:h_a(C_j)=0\}|}{N_n}.
$$

The first term is the same fair-noise contribution for every proper
hypothesis. Each unsatisfied formula clause adds exactly $1/N_n$ error.

If $\varphi$ is satisfiable, some assignment has error

$$
B_\varphi=\frac{N_n-M}{2N_n}.
$$

Any assignment missing at least one clause has error at least
$B_\varphi+1/N_n$. Run the assumed marginal-nonuniform proper agnostic learner
with

$$
\varepsilon=\frac{1}{3N_n},
\qquad
\delta=\frac13.
$$

On satisfiable $\varphi$, with probability at least $2/3$, the learner returns
a proper hypothesis whose error is below $B_\varphi+1/N_n$, hence an
assignment satisfying every clause of $\varphi$.

On unsatisfiable $\varphi$, no proper hypothesis corresponds to a satisfying
assignment. Therefore the decision procedure that runs the learner and accepts
iff the returned assignment satisfies all clauses has one-sided error:

- YES instances are accepted with probability at least $2/3$;
- NO instances are never accepted.

The samples from $\mathcal D_\varphi$ are efficiently simulable: draw a uniform
clause from $X_n$, test membership in the input formula, and flip a fair coin
off the formula. Since $P_{\mathrm{clause}}$ is fixed independently of
$\varphi$, the learner's runtime is bounded by

$$
p_{P_{\mathrm{clause}}}(n,3N_n,O(1)),
$$

which is polynomial in the formula size. Thus the target would put 3-SAT in
$\mathrm{RP}$, and hence $\mathrm{NP}\subseteq\mathrm{RP}$ by Karp's theorem.

Under $\mathrm{NP}\nsubseteq\mathrm{RP}$, the target cannot hold for this
class.

## Relation To Agnostic Boosting And Properization

The assigned edge formally changes two axes: weak-to-strong and
improper-to-proper. The counterexample shows that the properization obstruction
alone is enough.

The witness is already strong agnostic improperly learnable, so no positive or
negative fact about fixed-additive agnostic boosting is needed. Even if the
source weak learner could always be boosted to a strong improper learner, the
fixed-marginal proper learner would still have to search the assignment class,
and that search would solve 3-SAT in randomized polynomial time.

This also explains why the current edge note's marginal-dependent boosting
obstacle is not the sharp obstruction for this particular source/target pair:
the source is distribution-free and the counterexample bypasses boosting
entirely.

## Secondary Witness Check

The one-way image-coordinate class gives a second conditional route under
length-preserving one-way functions:

- It is distribution-free agnostically learnable by improper sparse ERM over
  hypotheses with at most $n$ positive atoms.
- Under the fixed coordinate marginal with inverse-polynomial mass on each
  length block, marginal-nonuniform realizable proper learning would recover a
  preimage of a one-way image.
- Since the assigned target is stronger than realizable proper learning on
  realizable distributions, the same witness would also refute this edge.

This secondary route is useful if the atlas wants a single-global-marginal
cryptographic witness. The clause-satisfaction proof above is the simpler
atlas-ready update because the existing `clause-satisfaction-proper-hardness`
argument already records the fixed uniform-clause marginal agnostic trick.

## Proposed Atlas Changes

For
`atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-proper-pac.md`,
change the frontmatter along these lines:

```yaml
status: "false"
evidence: conditional-counterexample
assumptions:
  - "NP not subset RP"
witnesses:
  - clause-satisfaction-lookup-class
witness_note: "[[clause-satisfaction-lookup-class|Clause-Satisfaction Lookup Class]]"
ref_keys:
  - blumer1989
  - karp1972
refs:
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
  - "[Karp 1972](https://doi.org/10.1007/978-1-4684-2001-2_9)"
summary: "False under NP not subset RP: the clause-satisfaction lookup class is efficiently agnostically learnable improperly, hence satisfies the weak distribution-free source, but fixed-marginal proper agnostic learning would decide 3-SAT."
family: clause-satisfaction-proper-hardness
argument_note: "[[clause-satisfaction-proper-hardness|Clause-Satisfaction Proper Hardness]]"
```

Atlas-ready body sketch:

> Use the clause-satisfaction lookup class. Improper ERM over all Boolean
> lookup tables on the polynomial-size clause universe gives efficient
> distribution-free strong agnostic improper learning, hence the weak source.
> For the target lower bound, fix the uniform marginal over all clauses on
> $n$ variables. Given a formula, label its clauses by $1$ and all other clauses
> by fair coins. The fair-noise region contributes the same error to every
> assignment, while each unsatisfied formula clause adds exactly $1/|X_n|$.
> A marginal-nonuniform agnostic proper learner run to accuracy
> $1/(3|X_n|)$ would therefore return a satisfying assignment whenever one
> exists. Checking the returned assignment gives an RP algorithm for 3-SAT,
> contradicting $\mathrm{NP}\nsubseteq\mathrm{RP}$.

## Follow-Up Directions

1. Update the assigned edge from `properization-open` to
   `clause-satisfaction-proper-hardness`.
2. Audit all remaining edges with target
   `efficient-marginal-nonuniform-agnostic-proper-pac`: any source implied by
   `efficient-agnostic-improper-pac` should likely inherit the same
   clause-satisfaction counterexample.
3. Consider strengthening `clause-satisfaction-lookup-class.md` with the
   fixed-marginal fair-noise calculation, since the current witness note only
   states the role at a high level.

verdict: false, conditional on $\mathrm{NP}\nsubseteq\mathrm{RP}$
confidence: 0.91
