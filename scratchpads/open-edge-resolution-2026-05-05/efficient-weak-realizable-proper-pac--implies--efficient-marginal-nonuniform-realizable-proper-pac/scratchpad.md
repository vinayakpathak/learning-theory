# Edge: efficient-weak-realizable-proper-pac -> efficient-marginal-nonuniform-realizable-proper-pac

- edge_file: `atlas/implications/efficient-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`
- source: `efficient-weak-realizable-proper-pac`
- target: `efficient-marginal-nonuniform-realizable-proper-pac`
- assigned_family: `marginal-boosting-open`
- depth: 1

## Resolution

The edge should be marked `false`, conditionally on the existence of
length-preserving one-way functions.

The right witness is the existing
`one-way-image-coordinate-weak-handle-class`. For this particular realizable
weak source, singleton positive-atom handles are already enough. The bounded
handles used in the neighboring weak-agnostic notes are a harmless stronger
variant, but they are not needed here.

## Witness Class

Let $f_n:\{0,1\}^n\to\{0,1\}^n$ be a length-preserving one-way function family.
The instance domain contains atoms

$$
(1^k,i,b),\qquad i\in[k],\ b\in\{0,1\}.
$$

For each seed $s\in\{0,1\}^n$, define the image-coordinate concept

$$
c_s(1^k,i,b)=1
\quad\Longleftrightarrow\quad
k=n\text{ and }b=f_n(s)_i.
$$

Thus a length-$n$ seed concept has exactly one positive atom for each
coordinate $i\in[n]$. Enlarge the proper class by adding the two constants and
singleton positive-atom handles $a_{k,i,b}$, where

$$
a_{k,i,b}(x)=1\quad\Longleftrightarrow\quad x=(1^k,i,b).
$$

If one wants to reuse the full bounded-handle witness from the atlas, allow
handles of size at most $\lfloor k/4\rfloor$ inside a length-$k$ block. The
argument below uses only singleton handles for the weak realizable source.

Representations are explicit: a seed $s$, a constant bit, or a listed handle.
The output of the weak learner and of the alleged strong learner is therefore
proper.

## Source: Distribution-Free Weak Realizable Proper Learning

Goal: for every marginal $D$ and every realizable target $c\in\mathcal C$, find
a legal proper $h\in\mathcal C$ with error at most $1/2-\gamma(s)$ for an
inverse-polynomial $\gamma$.

First consider a length-$n$ seed target. Let $M=D(c^{-1}(1))$ be the positive
mass. The all-zero concept has error $M$, and the all-one concept has error
$1-M$. If either $M\le 1/2-1/(8n)$ or $M\ge 1/2+1/(8n)$, one of the constants
is already a weak hypothesis.

It remains to handle the middle case

$$
|M-1/2|<1/(8n).
$$

Among the $n$ positive atoms, some positive atom has mass at least $M/n$. The
singleton handle on that atom has no false positives and misses only the other
positive mass, so its error is at most

$$
M(1-1/n)
\le
(1/2+1/(8n))(1-1/n)
<
1/2-1/(8n).
$$

A polynomial-time weak learner can find such a handle from samples. In the
middle case the heaviest positive atom has mass $\Omega(1/n)$, so
$O(n\log(1/\delta))$ examples reveal it with high probability. The learner
forms the candidate list consisting of the two constants and singleton handles
for positive atoms seen in the sample, then uses an independent validation
sample to choose a candidate whose true error is within, say, $1/(16n)$ of the
best candidate in the list. This gives error below $1/2-\Omega(1/n)$.

Constant targets are learned by the constants. Singleton-handle targets are
also weakly learnable: either the all-zero/all-one constants are already weak,
or the unique positive atom has constant-order mass and is seen quickly, after
which the exact singleton handle is available. Bounded-handle targets, if
included, are handled the same way using an observed positive singleton as a
weak legal hypothesis.

Therefore the class satisfies the distribution-free efficient weak realizable
proper PAC source with a uniform inverse-polynomial weak gap.

## Target Failure: Fixed-Marginal Strong Proper Learning Inverts

Fix one marginal $P$ once and for all. Put mass

$$
\mu_k=\frac{6}{\pi^2k^2}
$$

on the length-$k$ block, then choose $i\in[k]$ and $b\in\{0,1\}$ uniformly.

Suppose, toward contradiction, that the class has an efficient
marginal-nonuniform realizable proper learner. For this fixed $P$, there is a
polynomial $p_P$ bounding runtime and sample complexity as a polynomial in the
representation size, $1/\varepsilon$, and $\log(1/\delta)$.

Given a one-way challenge $y=f_n(s)$, simulate labeled examples from $P$ by
labeling

$$
(1^k,i,b)\mapsto 1
\quad\Longleftrightarrow\quad
k=n\text{ and }b=y_i.
$$

This distribution is realizable by any seed preimage $s$ of $y$. Run the
alleged proper learner with

$$
\varepsilon_n=\frac{\mu_n}{3n},\qquad \delta=1/3.
$$

Since $1/\varepsilon_n=O(n^3)$ and $P$ is fixed, the runtime
$p_P(n,1/\varepsilon_n,O(1))$ is polynomial in $n$.

Any proper output with $P$-error at most $\varepsilon_n$ must be a same-length
seed concept with image $y$:

- The all-zero concept has error $\mu_n/2>\varepsilon_n$.
- The all-one concept has error at least $1-\mu_n/2>\varepsilon_n$.
- A singleton handle has error at least $\mu_n/2-\mu_n/(2n)>\varepsilon_n$ for
  $n\ge 2$. More generally, a bounded handle of size at most $n/4$ has error
  at least $3\mu_n/8>\varepsilon_n$.
- A seed of the wrong length disagrees on the target length-$n$ positives and
  has error at least $\mu_n/2>\varepsilon_n$.
- A same-length seed whose image differs from $y$ in one coordinate has error
  at least $\mu_n/n>\varepsilon_n$, because the two concepts swap the positive
  and negative atom at that coordinate.

Thus the learner outputs a seed $t$ such that $f_n(t)=y$ with probability at
least $2/3$. This is a randomized polynomial-time inverter for the
length-preserving one-way function, contradiction.

So the class does not satisfy efficient marginal-nonuniform realizable proper
PAC learning.

## Comparison With Fixed-k DNF

Fixed-$k$-term DNF is the standard proper boosting separation for the
distribution-free strong proper target: it is weakly properly learnable, while
strong proper distribution-free learning is hard unless $\mathrm{RP}=\mathrm{NP}$.

That does not by itself resolve this assigned edge. The target here is
marginal-nonuniform, so a hardness proof whose hard distribution varies with
the reduction instance does not rule out a single learner with a
distribution-dependent polynomial bound for each fixed marginal. This is the
main target-side loophole.

The one-way image-coordinate construction removes the loophole by hardwiring a
single marginal $P$. The hard learning run for every length $n$ occurs under
that same $P$, and the requested accuracy has polynomial reciprocal. Hence even
a $P$-dependent polynomial bound would give a polynomial-time inverter.

## Relation To Marginal Boosting

The current atlas edge is filed under `marginal-boosting-open`, but this
specific source is distribution-free weak realizable proper. Standard boosting
already gives a distribution-free strong improper learner from it. The obstacle
for this edge is not the usual marginal-nonuniform reweighting envelope; it is
the proper final-output requirement combined with the marginal-nonuniform target
loophole.

The witness above is stronger than an envelope obstruction. It gives a concrete
proper weak learner and proves that any fixed-marginal strong proper learner
would invert. Thus this edge should move from the open marginal-boosting family
to the one-way weak-handle hardness family.

## Proposed Atlas Changes

For
`atlas/implications/efficient-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`:

```yaml
status: "false"
evidence: conditional-counterexample
assumptions:
  - length-preserving one-way functions exist
witnesses:
  - one-way-image-coordinate-weak-handle-class
ref_keys:
  - kearns1994cryptographic
  - hastad1999prg
summary: "False under one-way functions: singleton proper handles give distribution-free weak realizable proper learning, but fixed-marginal strong realizable proper learning would recover a one-way preimage."
family: one-way-image-coordinate-weak-handle-hardness
argument_note: "[[one-way-image-coordinate-weak-handle-hardness|One-Way Image Coordinate Weak-Handle Hardness]]"
witness_note: "[[one-way-image-coordinate-weak-handle-class|One-Way Image Coordinate Weak-Handle Class]]"
```

Suggested `axis_delta`:

```yaml
axis_delta:
  resource: same
  distribution: distribution-free-to-marginal-nonuniform
  strength: weak-to-strong
  realizability: same
  properness: same
```

Suggested body replacement:

1. State the verdict as false under length-preserving one-way functions.
2. Define or cite the one-way image-coordinate weak-handle class.
3. Prove the distribution-free weak realizable proper source using constants
   and singleton positive-atom handles.
4. Prove the target failure under the fixed coordinate marginal with
   $\varepsilon_n=\mu_n/(3n)$.
5. Note that fixed-$k$ DNF only separates the distribution-free proper strong
   target, while this witness defeats the marginal-nonuniform target directly.

References already present in the atlas:

- Kearns and Valiant 1994, `kearns1994cryptographic`.
- Hastad, Impagliazzo, Levin, and Luby 1999, `hastad1999prg`.

verdict: false, conditional on length-preserving one-way functions
confidence: high
