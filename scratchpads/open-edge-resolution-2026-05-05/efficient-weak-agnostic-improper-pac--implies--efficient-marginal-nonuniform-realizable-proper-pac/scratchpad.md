# Scratchpad: `efficient-weak-agnostic-improper-pac` Implies `efficient-marginal-nonuniform-realizable-proper-pac`

Assigned edge:

`atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`

## Short Verdict

The edge should be marked `false`, conditionally on length-preserving one-way functions.

No new witness is needed. The existing [[one-way-image-coordinate-class|One-Way Image Coordinate Class]] satisfies a stronger source, namely efficient distribution-free strong agnostic improper PAC learning, and fails the target by the existing fixed-marginal proper recovery argument.

## Relevant Local Notes Read

- `atlas/definitions/efficient-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-realizable-proper-pac.md`
- `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/implications/efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`

The key discovery is monotonic: if a class is efficiently agnostically improperly PAC learnable distribution-free, then it is also efficiently weak agnostically improperly PAC learnable distribution-free by running the strong learner at any fixed constant excess error $\beta<1/2$.

## Witness Construction

Assume a length-preserving one-way function

$$
f_n:\{0,1\}^n \to \{0,1\}^n .
$$

The instance domain contains triples $(1^k,i,b)$ where $i\in[k]$ and $b\in\{0,1\}$. A proper concept is represented by a seed $s\in\{0,1\}^n$ and is defined by

$$
c_s(1^k,i,b)=1
\quad\Longleftrightarrow\quad
k=n \text{ and } b=f_n(s)_i .
$$

Thus a length-$n$ proper concept has exactly $n$ positive atoms in the length-$n$ block and is zero off that block.

## Why The Source Holds

The source is efficient weak agnostic improper PAC learning. It is enough to show the stronger efficient agnostic improper property.

For size parameter $n$, use the improper hypothesis class $\mathcal S_n$ of all lookup tables with at most $n$ positive atoms. This class contains every length-$n$ proper image-coordinate concept. More generally, if the benchmark permits concepts of size at most $n$, use at most $n$ positive atoms and the same argument contains all benchmark concepts.

The class $\mathcal S_n$ has VC dimension $n$: it shatters any $n$ atoms, and it cannot realize the all-positive labeling on $n+1$ distinct atoms.

There is a polynomial-time empirical risk minimizer over $\mathcal S_n$ on a finite sample. Start from the all-zero hypothesis. For each sampled atom $x$, compute

$$
\mathrm{benefit}(x)
=
\#\{(x,1)\text{ in the sample}\}
-
\#\{(x,0)\text{ in the sample}\}.
$$

Choose the at most $n$ sampled atoms with largest positive benefit and label exactly those atoms by $1$. This minimizes empirical error over all at-most-$n$-positive lookup tables.

By the standard VC uniform-convergence theorem for ERM over a VC-$n$ class, with polynomially many samples and polynomial time this improper learner returns $h$ with

$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c\in\mathcal C_n}\operatorname{err}_{\mathcal D}(c)+\varepsilon .
$$

Running it at a fixed constant $\varepsilon=\beta<1/2$ gives the assigned weak agnostic improper source.

Primary-source support:

- Blumer, Ehrenfeucht, Haussler, and Warmuth give the standard finite-VC learnability/ERM foundation.
- Kearns and Valiant give the cryptographic learning-hardness template.
- Hastad, Impagliazzo, Levin, and Luby give the standard one-way-function to pseudorandomness context; the atlas witness only needs the stated length-preserving one-way-function assumption.

## Why The Target Fails

The target asks for one uniform proper learner such that, for every marginal $P$, there is a $P$-dependent polynomial runtime/sample bound. It is therefore refuted by exhibiting one fixed marginal $P$ on which proper learning would invert $f$.

Use the fixed coordinate marginal from the atlas note: choose a length block $k$ with mass

$$
\mu_k=\frac{6}{\pi^2 k^2},
$$

then choose $i\in[k]$ and $b\in\{0,1\}$ uniformly. Any other efficiently samplable fixed distribution with $\mu_n=n^{-O(1)}$ would also work; a dyadic block distribution can be used if one wants to avoid the irrational normalizer in a fully algorithmic presentation.

Fix a challenge image $y=f_n(s)$. We can simulate labeled realizable examples under the same fixed marginal $P$ by labeling

$$
(1^k,i,b) \mapsto 1
\quad\Longleftrightarrow\quad
k=n \text{ and } b=y_i .
$$

These labels are realizable by $c_s$.

Run the assumed marginal-nonuniform realizable proper learner at

$$
\varepsilon_n=\frac{\mu_n}{3n}.
$$

Since $\mu_n=\Theta(1/n^2)$, $1/\varepsilon_n=\Theta(n^3)$, so the $P$-specific polynomial bound would still be polynomial in $n$.

Now any proper hypothesis $c_t$ with $P$-error at most $\varepsilon_n$ against $c_s$ must recover the one-way image:

1. If $|t|\ne n$, then $c_t$ is zero on the length-$n$ block, while $c_s$ is positive on exactly half that block. The error contribution is $\mu_n/2>\varepsilon_n$.
2. If $|t|=n$ but $f_n(t)$ differs from $f_n(s)$ in at least one coordinate, then on such a coordinate the two concepts disagree on both choices of $b$. The error contribution is at least $\mu_n/n>\varepsilon_n$.

Therefore the learner's proper output must be a seed $t$ with

$$
f_n(t)=y .
$$

This is an inverter for the one-way function running in randomized polynomial time: the marginal $P$ is fixed across all input lengths, and the requested accuracy has polynomial inverse. This contradicts the assumed one-wayness.

## Proposed Atlas Change

The assigned edge can be moved out of `properization-open` and into the existing one-way image-coordinate false family.

Suggested frontmatter changes:

```yaml
status: "false"
evidence: conditional-counterexample
assumptions:
  - length-preserving one-way functions exist
witnesses:
  - one-way-image-coordinate-class
ref_keys:
  - blumer1989
  - kearns1994cryptographic
  - hastad1999prg
refs:
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
  - "[Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)"
  - "[Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)"
summary: "False under one-way functions: image-coordinate concepts are distribution-free agnostically learnable by improper sparse ERM, hence satisfy the weak agnostic improper source, but fixed-marginal realizable proper learning would invert the one-way function."
family: one-way-image-coordinate-proper-hardness
argument_note: "[[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]]"
witness_note: "[[one-way-image-coordinate-class|One-Way Image Coordinate Class]]"
```

Suggested body replacement:

```markdown
## Verdict

`false`, assuming length-preserving one-way functions exist.

Use the [[one-way-image-coordinate-class|One-Way Image Coordinate Class]]. It is efficiently distribution-free agnostically learnable by improper sparse ERM, so it satisfies the weaker efficient weak agnostic improper source. A marginal-nonuniform realizable proper learner under one fixed coordinate marginal would invert the one-way function.

## Proof Status

**Goal.** Separate efficient weak agnostic improper learning from efficient marginal-nonuniform realizable proper learning.

**Why the source holds.** For size parameter $n$, let the improper hypotheses be all lookup tables with at most $n$ positive atoms. This sparse class has VC dimension $n$, contains the proper image-coordinate concepts, and admits polynomial-time ERM by keeping the sampled atoms with largest positive empirical benefit. VC uniform convergence gives efficient distribution-free agnostic improper learning against the proper class. Running this stronger learner at fixed constant excess error gives the assigned weak agnostic improper source.

**Why the target fails.** Fix the coordinate marginal with length-$k$ block mass $\mu_k=6/(\pi^2k^2)$ and uniform coordinates inside each block. For a length-$n$ target seed $s$, any proper hypothesis with error at most $\mu_n/(3n)$ must have length $n$ and the same image $f(s)$: a wrong length costs $\mu_n/2$, and one wrong image coordinate costs at least $\mu_n/n$.

Given a one-way challenge $y=f(s)$, labeled examples from this fixed marginal can be simulated using $y$ by labeling $(1^k,i,b)$ positive exactly when $k=n$ and $b=y_i$. A marginal-nonuniform realizable proper learner run at accuracy $\mu_n/(3n)$ would output a seed $t$ with $f(t)=y$ in randomized polynomial time, contradicting one-wayness.
```

## Depth-2 Directions

No depth-2 search is needed for this edge after the monotone witness transfer. The useful follow-up is consistency cleanup: the assigned edge should match the already-false edges

- `efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac`
- `efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac`

because the same witness satisfies the assigned source and refutes the same target.

verdict: false, under length-preserving one-way functions
confidence: high
