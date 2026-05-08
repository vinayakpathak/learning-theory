# Open Edge Resolution Scratchpad

Edge:

```text
efficient-weak-realizable-improper-pac
->
efficient-marginal-nonuniform-realizable-proper-pac
```

- assigned edge: `atlas/implications/efficient-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`
- family: `properization-open`
- depth: 1
- date: 2026-05-05
- working constraint: atlas files are read-only in this pass

## Bottom Line

Resolved as `false`, conditionally.

Assuming length-preserving one-way functions exist, the implication fails. The
same one-way image-coordinate witness that separates efficient strong improper
realizable learning from marginal-nonuniform strong proper realizable learning
also refutes this edge, because that witness satisfies an even stronger source
than `efficient-weak-realizable-improper-pac`.

The proof does not need a delicate marginal-nonuniform boosting analysis. The
class is distribution-free strongly learnable by an improper memorization
learner. But under one fixed marginal, any sufficiently accurate proper learner
must output a seed whose one-way image matches the target image, and therefore
would invert the one-way function.

## Sources Checked

Local atlas notes:

- `atlas/definitions/efficient-weak-realizable-improper-pac.md`
- `atlas/definitions/efficient-realizable-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-realizable-proper-pac.md`
- `atlas/implications/efficient-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`
- `atlas/implications/efficient-realizable-improper-pac--implies--efficient-weak-realizable-improper-pac.md`
- `atlas/implications/efficient-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`
- `atlas/implications/efficient-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/implications/efficient-weak-realizable-improper-pac--implies--efficient-weak-realizable-proper-pac.md`
- `atlas/arguments/realizable-boosting.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/fixed-k-term-dnf-proper-boosting-separation.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/witnesses/fixed-k-term-DNF.md`

Neighboring scratchpads:

- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac/scratchpad.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`

Primary-source anchors used through the atlas notes:

- Schapire, "The Strength of Weak Learnability" (1990), for weak-to-strong
  boosting with improper aggregate hypotheses.
- Kearns and Valiant, "Cryptographic Limitations on Learning Boolean Formulae
  and Finite Automata" (1994), for cryptographic learning lower bounds.
- Hastad, Impagliazzo, Levin, and Luby, "A Pseudorandom Generator from any
  One-way Function" (1999), for the standard one-way-function assumption.
- Hastad and Khot, "Query Efficient PCPs with Perfect Completeness" (2005),
  for the PCP active-slice near miss.
- Pitt and Valiant / Khot and Saket / Haussler et al. as recorded in the atlas
  for fixed-term DNF proper-learning near misses.

## Definitions Used

The source node, `efficient-weak-realizable-improper-pac`, requires a
distribution-free efficient weak learner. On every marginal $D$ and every
realizable target $c\in\mathcal C$, it outputs an arbitrary hypothesis
$h\notin\mathcal C$ allowed with error at most

$$
\operatorname{err}_D(h,c)\le \frac12-\gamma(s),
$$

for inverse-polynomial advantage $\gamma$ and polynomial sample/runtime bounds.

The target node, `efficient-marginal-nonuniform-realizable-proper-pac`,
requires one uniform learner which, for every fixed marginal $P$, has some
$P$-dependent polynomial bound in $s,1/\varepsilon,\log(1/\delta)$ and outputs
a proper concept $h\in\mathcal C$ with error at most $\varepsilon$.

Thus the edge asks whether distribution-free weak improper learnability forces
fixed-marginal strong proper learnability. It combines weak-to-strong and
properization.

## Counterexample

Assume a length-preserving one-way function

$$
f:\{0,1\}^n\to\{0,1\}^n
$$

exists for infinitely many lengths, in the usual family sense. Use the
one-way image-coordinate class from the atlas.

The instance space contains triples

$$
(1^k,i,b), \qquad i\in[k],\ b\in\{0,1\}.
$$

A seed $s\in\{0,1\}^n$ represents the proper concept $c_s$ defined by

$$
c_s(1^k,i,b)=1
\quad\Longleftrightarrow\quad
k=n\text{ and }b=f(s)_i.
$$

So a length-$n$ target has exactly $n$ positive atoms, one for each coordinate
of the one-way image $f(s)$. Proper output means outputting a seed $t$, whose
concept is $c_t$.

## Source Side

The class satisfies a stronger source than assigned: efficient
distribution-free strong realizable improper PAC learning.

Given labeled examples from any distribution $D$ and any target $c_s$ of
length $n$, the improper learner records every positive atom observed in the
sample and predicts $0$ elsewhere. This learner never makes false positive
errors. If a positive atom has marginal mass at least $\varepsilon/n$, then

$$
O\left(\frac{n}{\varepsilon}\log\frac{n}{\delta}\right)
$$

examples see that atom with high enough probability to union-bound over the
$n$ positive atoms. The total mass of unseen positive atoms below the
$\varepsilon/n$ threshold is at most $\varepsilon$. Hence with probability at
least $1-\delta$, the improper lookup hypothesis has error at most
$\varepsilon$.

This gives polynomial sample complexity and runtime in $n,1/\varepsilon$ and
$\log(1/\delta)$, uniformly over marginals. Running the same learner at any
constant $\varepsilon<1/2$ gives an efficient distribution-free weak improper
learner. Therefore the witness satisfies
`efficient-weak-realizable-improper-pac`.

Equivalently, the atlas already records the monotone implication

```text
efficient-realizable-improper-pac
->
efficient-weak-realizable-improper-pac
```

and the one-way image-coordinate class satisfies the left-hand side.

## Target Failure

Fix one marginal $P^\star$:

1. choose length $k$ with mass
   $$
   \mu_k=\frac{6}{\pi^2 k^2};
   $$
2. conditional on $k$, choose $i\in[k]$ and $b\in\{0,1\}$ uniformly.

For a target seed $s\in\{0,1\}^n$, set

$$
\varepsilon_n=\frac{\mu_n}{3n}.
$$

Since $\mu_n=\Theta(1/n^2)$, the parameter $1/\varepsilon_n$ is polynomial in
$n$.

Claim: if a proper hypothesis $c_t$ has

$$
\operatorname{err}_{P^\star}(c_t,c_s)\le \varepsilon_n,
$$

then $|t|=n$ and $f(t)=f(s)$.

First, if $|t|\ne n$, then $c_t$ predicts $0$ throughout the length-$n$ block,
while $c_s$ is positive on exactly one of the two bit-atoms for each coordinate.
The error on the length-$n$ block is therefore $\mu_n/2>\varepsilon_n$.

Second, if $|t|=n$ but $f(t)$ and $f(s)$ disagree in some coordinate $i$, then
the two concepts disagree on both atoms $(1^n,i,0)$ and $(1^n,i,1)$. This costs
at least

$$
\frac{\mu_n}{n}>\varepsilon_n.
$$

Thus accuracy $\varepsilon_n$ forces equality of one-way images.

Now suppose the target learner existed. Given a challenge image
$y=f(s)$ for an unknown seed $s\in\{0,1\}^n$, we can simulate labeled examples
from $P^\star$ by labeling

$$
(1^k,i,b)\mapsto 1
\quad\Longleftrightarrow\quad
k=n\text{ and }b=y_i.
$$

This simulation uses only the challenge image $y$, not a preimage. Run the
assumed marginal-nonuniform proper learner for the fixed marginal $P^\star$ at
accuracy $\varepsilon_n$ and constant confidence. The marginal is fixed once
and for all, so its allowed polynomial $p_{P^\star}$ gives runtime polynomial
in $n$ and $1/\varepsilon_n$, hence polynomial in $n$. With nonnegligible
success probability, the learner outputs a proper seed $t$ satisfying
$f(t)=y$. That is a probabilistic polynomial-time inverter for $f$,
contradicting the one-way-function assumption.

Therefore the target node fails for this class.

## Why This Resolves The Assigned Edge

The assigned source is weaker than the source already satisfied by the
witness, while the assigned target is exactly the target already ruled out by
the fixed-marginal proper recovery argument.

In implication terms:

```text
one-way image-coordinate class
  satisfies efficient-realizable-improper-pac
  hence satisfies efficient-weak-realizable-improper-pac
  but fails efficient-marginal-nonuniform-realizable-proper-pac.
```

So the implication is not merely unresolved by known boosting/properization
tools; it is conditionally false.

## Requested Route Checks

### One-Way Image-Coordinate

This is the primary resolution. The ordinary one-way image-coordinate class is
enough; the weak-handle variant is not needed.

The key point is that the source allows improper output and asks only for weak
accuracy. The ordinary class gives much more: strong distribution-free
improper learning by sparse positive-atom memorization. The target asks for
proper output at arbitrary accuracy under a fixed marginal, which forces seed
recovery and contradicts one-wayness.

### One-Way Image-Coordinate Weak Handles

The weak-handle variant also refutes the assigned edge, but it is a less direct
witness. Adding constants and singleton-positive-atom concepts gives even weak
proper handles, while the same fixed-marginal strong proper lower bound
persists once the requested accuracy is small enough to exclude constants and
singletons.

This variant is useful for neighboring edges whose source is already weak
proper and whose target is strong proper. For the present edge, the ordinary
image-coordinate class is cleaner because it directly exploits the improper
source.

### PCP Active Slice

The PCP active-slice construction separates distribution-free weak improper
learning from distribution-free weak proper learning under
$\mathrm{NP}\nsubseteq\mathrm{RP}$. It is therefore relevant to the
properization part of the edge.

It is not the best witness for this exact target. The hard weak-proper
reduction uses a marginal uniform on the active slice of the input formula
$\varphi$. In a marginal-nonuniform target, a polynomial may depend on that
fixed marginal, so a formula-dependent marginal does not directly give a
uniform polynomial-time SAT decider. Packing all slices into one fixed marginal
also dilutes the active-slice gap. The one-way coordinate witness avoids both
issues by fixing one marginal and putting the hard information in the target
labels rather than in the marginal.

### Fixed-k DNF

Fixed-$k$ term DNF is the standard proper weak-to-strong separation family:
weak proper learning can be easy while strong proper learning is hard. It does
not give the cleanest resolution here for two reasons.

First, the assigned source is improper, and the one-way coordinate class
already gives a stronger improper source-positive witness. Second, the fixed-DNF
proper hardness recorded in the atlas is distribution-free and representation
specific; converting it into a marginal-nonuniform strong proper lower bound
would require one fixed marginal and an accuracy request that forces the hard
proper representation. The one-way coordinate construction supplies exactly
that fixed-marginal recovery mechanism.

### Existing Properization Notes

The `properization-open` note remains accurate as a general bucket for edges
where no generic efficient improper-to-proper theorem is known. This particular
edge should be carved out of that bucket. It is covered by the already-recorded
`one-way-image-coordinate-proper-hardness` argument, because the false witness
satisfies strong improper learnability and therefore also weak improper
learnability.

The marginal-boosting obstacle is also bypassed. Schapire boosting would turn
distribution-free weak improper learning into strong improper learning, and the
atlas already records that implication. But even after boosting, proper output
is impossible for this witness under the fixed marginal unless one-way
functions can be inverted.

## Proposed Atlas Update

No atlas files were edited. If edits are later allowed, update

```text
atlas/implications/efficient-weak-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md
```

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

```markdown
`false`, assuming length-preserving one-way functions exist.

Use the one-way image-coordinate class. For a length-$n$ target there are only
$n$ positive atoms, so the improper learner that memorizes observed positive
atoms and predicts $0$ elsewhere learns to error $\varepsilon$ with
$O((n/\varepsilon)\log(n/\delta))$ samples. This gives efficient
distribution-free strong improper realizable learning, hence the weak improper
source.

For the target failure, fix the coordinate marginal with length masses
$\mu_k=6/(\pi^2k^2)$ and set $\varepsilon_n=\mu_n/(3n)$. Any proper hypothesis
within error $\varepsilon_n$ of a length-$n$ target must have the same length
and the same one-way image. Given a challenge $y=f(s)$, labeled examples from
this fixed marginal can be simulated using $y$ alone. A marginal-nonuniform
proper learner would therefore output a seed $t$ with $f(t)=y$ in polynomial
time, contradicting one-wayness.
```

## Depth-2 Directions

This edge is resolved conditionally, so depth-2 work should focus on cleaning
the atlas rather than searching for a new proof.

1. Propagate the one-way image-coordinate proper-hardness family to every open
   edge whose source is at most `efficient-realizable-improper-pac` and whose
   target is `efficient-marginal-nonuniform-realizable-proper-pac`.
2. Check whether the ordinary image-coordinate class, rather than the
   weak-handle variant, should be the default witness whenever the source is
   improper and the target is strong proper.
3. Keep the weak-handle variant for edges whose source itself is proper weak
   and whose target is strong proper.
4. Preserve PCP active-slice as the witness for distribution-free weak
   properization failures, not for fixed-marginal strong proper recovery.
5. Audit remaining `properization-open` edges for the simple monotonicity
   pattern: if a stronger source already has a false witness against the same
   target, the weaker-source edge is also false.

verdict: false conditional on length-preserving one-way functions existing
confidence: high
