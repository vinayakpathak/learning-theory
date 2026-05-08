# Edge: efficient-marginal-nonuniform-weak-agnostic-improper-pac -> efficient-marginal-nonuniform-agnostic-proper-pac

- depth: 1
- edge_file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-proper-pac.md`
- verdict: resolved-false
- confidence: high
- assumption: `NP not subset RP`
- witness: `clause-satisfaction-lookup-class`

## Resolution Summary

This edge is false under the existing clause-satisfaction proper-hardness witness.

The current edge note treats the edge as a combined weak-to-strong agnostic boosting plus improper-to-proper conversion problem. That is a real obstruction for a black-box positive theorem, but it is not needed to refute the implication. The atlas already records the stronger false edge

```text
efficient-agnostic-improper-pac -> efficient-marginal-nonuniform-agnostic-proper-pac
```

using the clause-satisfaction lookup class. Since

```text
efficient-agnostic-improper-pac -> efficient-marginal-nonuniform-weak-agnostic-improper-pac
```

is a trivial monotone relaxation, the same witness separates the assigned source from the assigned target.

So the edge should be moved out of `properization-open` / `agnostic-boosting-open` and marked as a conditional counterexample.

## Definitions Checked

The source, `efficient-marginal-nonuniform-weak-agnostic-improper-pac`, asks for one uniform learner which may output outside $\mathcal C$ and, for each marginal $P$, has a $P$-dependent polynomial sample/time bound and achieves

$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta_P(s),
$$

where $\beta_P(s)<1/2$ with inverse-polynomial gap from $1/2$.

The target, `efficient-marginal-nonuniform-agnostic-proper-pac`, asks for a proper output $h\in\mathcal C$ and arbitrary excess accuracy $\varepsilon$ in $P$-dependent polynomial time:

$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\varepsilon.
$$

Thus any class satisfying distribution-free strong agnostic improper PAC learning automatically satisfies the assigned source, but may still fail the assigned target because of the proper-output requirement.

## Counterexample

Use the clause-satisfaction lookup class from `atlas/witnesses/clause-satisfaction-lookup-class.md` and `atlas/arguments/clause-satisfaction-proper-hardness.md`.

For size parameter $n$, let $X_n$ be the polynomial-size universe of 3-CNF clauses over variables $x_1,\ldots,x_n$. A proper hypothesis is indexed by an assignment $a\in\{0,1\}^n$ and labels a clause $C\in X_n$ by

$$
h_a(C)=1
\quad\Longleftrightarrow\quad
a \text{ satisfies } C.
$$

### Source Holds

The class is efficiently agnostically learnable improperly in the distribution-free sense. The improper learner competes with the proper assignment class by using arbitrary lookup tables on the polynomial-size clause universe $X_n$.

Concretely, empirical risk minimization over all Boolean tables on $X_n$ is polynomial-time because $|X_n|=\operatorname{poly}(n)$. A per-clause empirical majority table minimizes empirical error over this improper lookup class. Since the lookup class contains every assignment hypothesis, standard finite-domain uniform convergence gives, for every distribution over $X_n\times\{0,1\}$,

$$
\operatorname{err}(h)
\le
\inf_{a\in\{0,1\}^n}\operatorname{err}(h_a)+\varepsilon
$$

with sample complexity and runtime polynomial in $n,1/\varepsilon,\log(1/\delta)$.

Therefore the class satisfies `efficient-agnostic-improper-pac`. Running this stronger learner with a fixed constant accuracy, for example $\varepsilon=1/6$, gives the assigned weak marginal-nonuniform improper source, with the same polynomial usable for every marginal.

### Target Fails

Assume, toward contradiction, that there is an efficient marginal-nonuniform agnostic proper learner $A$ for this class.

Fix the clause marginal used in the existing atlas proof: for each input size $n$, take $P_n$ uniform over $X_n$. Given a 3-CNF formula $\varphi$ with clause set $F\subseteq X_n$, define a joint distribution $\mathcal D_\varphi$ with marginal $P_n$ as follows:

- if $C\in F$, label $C$ by $1$;
- if $C\notin F$, label $C$ by an independent fair coin.

For every assignment $a$,

$$
\operatorname{err}_{\mathcal D_\varphi}(h_a)
=
\frac{|\{C\in F:h_a(C)=0\}|}{|X_n|}
+
\frac{|X_n|-|F|}{2|X_n|}.
$$

The fair-noise term is identical for all assignments. If $\varphi$ is satisfiable, some assignment has error

$$
B_\varphi=\frac{|X_n|-|F|}{2|X_n|}.
$$

Any assignment violating even one formula clause has error at least

$$
B_\varphi+\frac{1}{|X_n|}.
$$

Run the alleged proper agnostic learner with accuracy

$$
\varepsilon=\frac{1}{3|X_n|},
$$

and constant confidence. In the satisfiable case, its output must be a proper assignment with error at most $B_\varphi+\varepsilon$, hence it cannot violate any clause of $\varphi$. Checking the returned assignment therefore accepts satisfiable formulas with constant probability. In the unsatisfiable case, no returned assignment can satisfy all clauses, so the same check always rejects.

This gives a randomized polynomial-time one-sided algorithm for 3-SAT, contradicting $\mathrm{NP}\nsubseteq\mathrm{RP}$.

If one wants to avoid per-size wording for the fixed marginal, the same proof can be packaged with a single all-size marginal that gives the length-$n$ clause block mass $\mu_n=\Theta(n^{-4})$ and is uniform within each block. Then the distinguishing accuracy becomes $\mu_n/(3|X_n|)$, still inverse-polynomial in $n$, and the marginal is fixed once and for all.

## Relation To The Requested Open-Edge Notes

`agnostic-boosting-open` and distribution-specific agnostic boosting are not needed for the counterexample. The witness satisfies a stronger source than the assigned weak source, so there is no weak-to-strong conversion step to perform.

`properization-open` is relevant only as the broad family of possible positive obstructions. For this particular strong proper target, `clause-satisfaction-proper-hardness` already supplies a fixed-marginal strong-accuracy lower bound. The weak-gap dilution problem that blocks weak proper targets does not apply, because the target learner must accept an arbitrary $\varepsilon$, and the reduction asks for $\varepsilon$ on the order of one clause mass.

The neighboring open edge

```text
efficient-agnostic-improper-pac -> efficient-marginal-nonuniform-weak-agnostic-proper-pac
```

remains consistent with this result: the clause-satisfaction construction does not force a weak proper learner to find a satisfying assignment, but it does force a strong proper agnostic learner when run to inverse-polynomial accuracy.

## Proposed Atlas Update

Change the assigned implication to:

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
refs:
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
  - "[Karp 1972](https://doi.org/10.1007/978-1-4684-2001-2_9)"
summary: "False under NP not subset RP: the clause-satisfaction lookup class is efficiently agnostically learnable improperly, hence satisfies the weak marginal-nonuniform improper source, but fixed-marginal proper agnostic learning would decide 3-SAT."
family: clause-satisfaction-proper-hardness
argument_note: "[[clause-satisfaction-proper-hardness|Clause-Satisfaction Proper Hardness]]"
witness_note: "[[clause-satisfaction-lookup-class|Clause-Satisfaction Lookup Class]]"
```

Suggested body replacement:

```markdown
## Verdict

`false`, under the assumption $\mathrm{NP}\nsubseteq\mathrm{RP}$.

Use the clause-satisfaction lookup class. It is efficiently agnostically learnable by an improper lookup-table learner over the polynomial-size clause universe, so it satisfies the weaker marginal-nonuniform weak agnostic improper source by monotone relaxation.

For the target lower bound, fix the uniform marginal over clauses on $n$ variables. Given a 3-CNF formula $\varphi$, label formula clauses by $1$ and non-formula clauses by fair coins. The fair-noise contribution is the same for every assignment hypothesis, while each unsatisfied formula clause adds exactly $1/|X_n|$ error. Running a marginal-nonuniform agnostic proper learner to accuracy $1/(3|X_n|)$ would return a satisfying assignment whenever one exists; checking the returned assignment gives a one-sided randomized polynomial-time algorithm for 3-SAT.
```

## References Checked

- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-agnostic-proper-pac.md`
- `atlas/implications/efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/implications/efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-proper-pac.md`
- `atlas/definitions/efficient-agnostic-improper-pac.md`
- `atlas/witnesses/clause-satisfaction-lookup-class.md`
- `atlas/arguments/clause-satisfaction-proper-hardness.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/arguments/marginal-agnostic-hardness-open.md`
- `references.bib`

verdict: resolved-false
confidence: high
