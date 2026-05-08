# Open Edge Resolution Scratchpad

Edge: `efficient-marginal-nonuniform-weak-realizable-improper-pac -> efficient-marginal-nonuniform-realizable-proper-pac`

## Verdict

Resolved as `false`, conditionally.

Assuming length-preserving one-way functions exist, the implication fails. The
clean counterexample is the one-way image-coordinate class. It is efficiently
distribution-free strongly realizably learnable by an improper memorization
learner, so it satisfies the weaker marginal-nonuniform weak improper source.
But a strong proper learner under one fixed marginal would invert the one-way
function.

Confidence: high, modulo the standard one-way-function assumption and the atlas
convention that a proper hypothesis for this witness must be represented by a
seed.

## Definitions Used

Source: `efficient-marginal-nonuniform-weak-realizable-improper-pac`.
For every marginal $P$, one uniform learner has a $P$-dependent polynomial
sample/runtime bound and achieves

$$
\operatorname{err}_P(h,c) \le 1/2 - \gamma_P(s)
$$

for an inverse-polynomial advantage $\gamma_P$, with no requirement that
$h \in \mathcal C$.

Target: `efficient-marginal-nonuniform-realizable-proper-pac`.
For every marginal $P$, one uniform learner has a $P$-dependent polynomial
sample/runtime bound in $s,1/\varepsilon,\log(1/\delta)$, and must output
$h \in \mathcal C$ with error at most $\varepsilon$.

The target is stronger in two ways: weak-to-strong and improper-to-proper.

## Sources Checked

Local atlas notes:

- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/realizable-boosting.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`

Primary source anchors checked:

- Schapire, "The Strength of Weak Learnability" (1990), DOI page
  https://doi.org/10.1023/A:1022648800760. Used for the classical
  weak-to-strong boosting context.
- Kearns and Valiant, "Cryptographic Limitations on Learning Boolean Formulae
  and Finite Automata" (1994), DOI page https://doi.org/10.1145/174644.174647.
  Used as the learning-theoretic cryptographic-hardness anchor.
- Hastad, Impagliazzo, Levin, and Luby, "A Pseudorandom Generator from any
  One-way Function" (1999), DOI page
  https://doi.org/10.1137/S0097539793244708. Used as a standard source for
  one-way functions as a cryptographic assumption.
- Hastad and Khot, "Query Efficient PCPs with Perfect Completeness" (2005),
  Theory of Computing page https://theoryofcomputing.org/articles/v001a007/.
  Used for the PCP active-slice near miss.
- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability" (2025),
  OpenReview page https://openreview.net/forum?id=aoVCFtox89. Used for the
  marginal-nonuniform quantifier pattern: rates may depend on the marginal but
  must hold uniformly over target concepts.

## Counterexample

Let $f:\{0,1\}^n \to \{0,1\}^n$ be a length-preserving one-way function. The
instance space contains triples

$$
(1^k,i,b), \qquad i \in [k],\ b \in \{0,1\}.
$$

For a seed $s \in \{0,1\}^n$, write $y=f(s)$ and define the proper concept
$c_s$ by

$$
c_s(1^k,i,b)=1
\quad\Longleftrightarrow\quad
k=n \text{ and } b=y_i.
$$

Thus a length-$n$ target has exactly $n$ positive atoms, one for each
coordinate of the one-way image. Proper representation means outputting a seed
$t$; the corresponding proper hypothesis is $c_t$.

### Why The Source Holds

The source asks only for weak marginal-nonuniform improper learning. The witness
has a stronger learner: distribution-free strong realizable improper learning.

Given a realizable target $c_s$ of length $n$, the learner records every
positive atom seen in the sample and predicts $0$ elsewhere. It never makes
false positive errors. With

$$
O\left(\frac{n}{\varepsilon}\log\frac{n}{\delta}\right)
$$

examples, with probability at least $1-\delta$ it sees every positive atom of
marginal mass at least $\varepsilon/n$. The total mass of unseen positive atoms
below this threshold is at most $\varepsilon$, so the error is at most
$\varepsilon$.

Running this strong improper learner at, say, $\varepsilon=1/3$ gives a weak
improper learner with advantage at least $1/6$ and polynomial distribution-free
resources. Therefore the class satisfies the marginal-nonuniform weak improper
source.

### Why The Target Fails

Fix one marginal $P$ once and for all. Choose the length $k$ with mass

$$
\mu_k=\frac{6}{\pi^2 k^2},
$$

then choose $i \in [k]$ and $b \in \{0,1\}$ uniformly. For a target seed
$s \in \{0,1\}^n$, set

$$
\varepsilon_n=\frac{\mu_n}{3n}.
$$

Since $\mu_n=\Theta(1/n^2)$, $1/\varepsilon_n=O(n^3)$.

If a proper hypothesis $c_t$ has $P$-error at most $\varepsilon_n$ against
$c_s$, then $|t|=n$ and $f(t)=f(s)$. If $|t|\neq n$, then $c_t$ is zero on the
length-$n$ block while $c_s$ is positive on exactly half of that block, giving
error $\mu_n/2>\varepsilon_n$. If $|t|=n$ but $f(t)$ differs from $f(s)$ in one
coordinate, the two concepts disagree on both bit-atoms for that coordinate,
giving error at least $\mu_n/n>\varepsilon_n$.

Now suppose the target learner existed. Given a one-way challenge $y=f(s)$ for
unknown uniform $s \in \{0,1\}^n$, simulate labeled examples from the fixed
marginal $P$ by labeling

$$
(1^k,i,b) \mapsto 1
\quad\Longleftrightarrow\quad
k=n \text{ and } b=y_i.
$$

This simulation uses $y$ but not a preimage. Run the assumed marginal-nonuniform
proper learner with accuracy $\varepsilon_n$ and constant confidence. Because
$P$ is fixed, its runtime bound is polynomial in $n$ and
$1/\varepsilon_n=O(n^3)$. With the learner's success probability, it outputs a
proper seed $t$ satisfying $f(t)=y$. This is a probabilistic polynomial-time
inverter for $f$, contradicting one-wayness.

## Checks Against Requested Routes

### Properization Plus Boosting

A black-box positive proof would have to combine two nontrivial steps:

1. boost the weak improper source to arbitrary accuracy under a
   marginal-dependent runtime convention; and
2. convert the resulting improper predictor into a proper hypothesis.

The current edge does not need these steps to be analyzed to completion,
because the one-way image-coordinate class is source-positive even at the
strong improper level and target-negative at the strong proper level. Thus the
edge is false before any marginal-nonuniform boosting envelope issue becomes
decisive.

### PCP Active-Slice Witness

The PCP active-slice lookup class remains a useful near miss but is not the
right final witness here. It separates distribution-free weak improper learning
from distribution-free weak proper learning under $\mathrm{NP}\nsubseteq
\mathrm{RP}$, using an instance-dependent active-slice marginal. In the
marginal-nonuniform target, an input-dependent marginal can hide the input
inside the allowed $P$-dependent polynomial. Packing all slices into one fixed
marginal dilutes the slice mass. The one-way image-coordinate construction
avoids this by using one fixed marginal and putting the hard object in the
target labels rather than in the marginal.

### One-Way Image-Coordinate Proper Witness

This is the primary resolution. The ordinary one-way image-coordinate class
already satisfies a source stronger than needed: efficient distribution-free
strong realizable improper PAC learning. Its target failure is exactly the
fixed-marginal strong proper lower bound.

### One-Way Image-Coordinate Weak-Handle Witness

The weak-handle variant gives an independent, also valid route. Adding constants
and singleton concepts makes marginal-nonuniform weak proper learning easy, and
weak proper learning implies weak improper learning. The same fixed-coordinate
marginal and accuracy request exclude the added handles and still force
recovery of a seed preimage. Thus this variant also refutes the current edge.

If the atlas wants the family label to emphasize weak-to-strong failure, use
`one-way-image-coordinate-weak-handle-hardness`. If it wants the shortest proof
from the current source, use `one-way-image-coordinate-proper-hardness`, because
the ordinary class satisfies a stronger improper source.

## Proposed Atlas Update

Do not edit atlas files in this pass. If edits are later allowed, update

`atlas/implications/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`

to the following metadata shape:

```yaml
status: "false"
evidence: conditional-counterexample
assumptions:
  - length-preserving one-way functions exist
witnesses:
  - one-way-image-coordinate-class
ref_keys:
  - kearns1994cryptographic
  - hastad1999prg
refs:
  - "[Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)"
  - "[Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)"
summary: "False under one-way functions: image-coordinate concepts satisfy even distribution-free strong improper realizable learning, but fixed-marginal strong proper learning would invert the one-way function."
family: one-way-image-coordinate-proper-hardness
argument_note: "[[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]]"
witness_note: "[[one-way-image-coordinate-class|One-Way Image Coordinate Class]]"
```

Suggested proof body:

The one-way image-coordinate class satisfies the source by a distribution-free
improper memorization learner. For a length-$n$ target, there are only $n$
positive atoms; recording observed positive atoms and predicting $0$ elsewhere
learns to error $\varepsilon$ with polynomial samples and time. In particular,
running at constant $\varepsilon<1/2$ gives the weak improper source.

For the target failure, fix the coordinate marginal with length masses
$\mu_k=6/(\pi^2 k^2)$ and run the assumed proper learner at
$\varepsilon_n=\mu_n/(3n)$. Any proper hypothesis within this error against a
length-$n$ target must have the same length and the same one-way image. Given a
challenge $y=f(s)$, labeled examples can be simulated directly from $y$, so the
proper learner would output a seed $t$ with $f(t)=y$ in polynomial time. This
contradicts the one-way-function assumption.

Optional note for the body: the weak-handle variant also refutes this edge,
because it satisfies even the marginal-nonuniform weak proper source while the
same fixed-marginal strong proper lower bound persists.

## Follow-Up Directions

- Apply the proposed atlas update when atlas edits are allowed.
- Consider whether this edge should list only `one-way-image-coordinate-class`
  or also mention `one-way-image-coordinate-weak-handle-class` in prose as a
  second witness.
- Leave `marginal-boosting-open` intact for edges whose target is improper
  strong learning; this edge is settled by proper representation recovery
  hardness, not by resolving the boosting envelope problem.
