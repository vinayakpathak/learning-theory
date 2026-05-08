# Edge: efficient-weak-agnostic-proper-pac -> efficient-marginal-nonuniform-realizable-proper-pac

- edge_file: `atlas/implications/efficient-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`
- source: `efficient-weak-agnostic-proper-pac`
- target: `efficient-marginal-nonuniform-realizable-proper-pac`
- assigned_family: `marginal-boosting-open`
- depth: 1

## Resolution

I think this edge is `false`, assuming length-preserving one-way functions exist.

The open note frames the issue as marginal-nonuniform boosting, but the source here is already distribution-free. The real obstruction is the proper final output. Schapire/Freund boosting can aggregate the proper weak hypotheses into a strong improper vote, and indeed the neighboring improper-target edge is true. The assigned target, however, requires a single hypothesis in the original representation class.

The cleanest counterexample is a strengthened version of the existing one-way image-coordinate weak-handle witness. The existing singleton-handle version already separates the edge if the source is read with the atlas's inverse-polynomial weak-gap convention. To avoid the literal "fixed beta" wording in `efficient-weak-agnostic-proper-pac.md`, use bounded subset handles instead of singleton handles; this gives a constant weak agnostic proper source while preserving the same fixed-marginal strong-proper hardness.

## Files Checked

- `atlas/definitions/efficient-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-realizable-proper-pac.md`
- `atlas/implications/efficient-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`
- `atlas/implications/efficient-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-realizable-improper-pac.md`
- `atlas/implications/efficient-weak-agnostic-proper-pac--implies--efficient-realizable-proper-pac.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/realizable-boosting.md`
- `atlas/arguments/fixed-k-term-dnf-proper-boosting-separation.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/witnesses/fixed-k-term-DNF.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`

## Why Fixed-k DNF and PCP Do Not Settle This Edge

Fixed-$k$ DNF is still the right warning sign: it shows that proper weak-to-strong boosting is not automatic. But the standard Pitt-Valiant proper-learning hardness is distribution-free/adversarial-distribution hardness. It does not by itself refute a marginal-nonuniform target, because a marginal-nonuniform learner may have a polynomial whose constants and degree depend on the marginal. A reduction that chooses a different hard marginal for each NP instance does not get a uniform polynomial-time decision procedure.

The PCP active-slice construction has the same marginal shield, and in this edge it also points the wrong way. Its active-slice argument is useful for ruling out weak proper learners, while the present source already requires a distribution-free weak agnostic proper learner. Packing all PCP slices into one fixed marginal dilutes individual slices too much unless one has a new sparse-hardness ingredient.

The one-way image-coordinate construction avoids both problems: it uses one fixed marginal with inverse-polynomial mass on every length block, and the hard information is in the labels for a length-$n$ block rather than in an input-dependent marginal.

## Counterexample Class

Assume a length-preserving one-way function

$$
f:\{0,1\}^n \to \{0,1\}^n .
$$

The instance domain contains atoms

$$
(1^k,i,b), \qquad i\in[k],\ b\in\{0,1\}.
$$

For a seed $s\in\{0,1\}^n$, define the seed concept

$$
c_s(1^k,i,b)=1
\quad\Longleftrightarrow\quad
k=n \text{ and } b=f(s)_i .
$$

Thus a seed concept has exactly $n$ positive atoms, one for each coordinate of $f(s)$, and is zero outside its own length block.

Now enlarge the proper class by adding:

1. the two constant concepts;
2. for every length $k$, every length-$k$ subset handle $h_{k,T}$, where

$$
T\subseteq [k]\times\{0,1\}, \qquad |T|\le \lfloor k/4\rfloor,
$$

and

$$
h_{k,T}(1^\ell,i,b)=1
\quad\Longleftrightarrow\quad
\ell=k \text{ and } (i,b)\in T.
$$

The proper class is

$$
\mathcal C
=
\{c_s:s\in\{0,1\}^\ast\}
\cup \{\mathbf 0,\mathbf 1\}
\cup \{h_{k,T}: |T|\le \lfloor k/4\rfloor\}.
$$

This is just the existing one-way image-coordinate weak-handle witness with quarter-subset handles replacing singleton handles. The quarter cap is arbitrary; any fixed fraction below $1$ would work after adjusting constants.

## Source Holds: Distribution-Free Weak Agnostic Proper

First prove the realizable weak handle lemma.

Let $P$ be any marginal and let the target be a seed concept $c_s$ of length $n$. Let

$$
M=P(c_s(X)=1)
$$

be the positive mass. The all-zero concept has error $M$, and the all-one concept has error $1-M$.

Let $T$ be the $\lfloor n/4\rfloor$ positive atoms of $c_s$ with largest $P$-mass. Since $c_s$ has $n$ positive atoms,

$$
P(T)\ge M/4.
$$

The subset handle $h_{n,T}$ has no false positives relative to $c_s$, so

$$
\operatorname{err}_P(h_{n,T},c_s)
=M-P(T)
\le 3M/4.
$$

Therefore

$$
\min\{M,\ 1-M,\ 3M/4\}\le 3/7
=1/2-1/14,
$$

with the worst case at $3M/4=1-M$. So every seed target has a proper weak handle with constant advantage. Constant targets are trivial, and subset-handle targets are handled by the target handle itself.

This handle search is efficient from samples. For a size bound $s$, the learner considers the two constants and, for each observed length $k\le s$, the empirical best subset handle of size at most $\lfloor k/4\rfloor$: start from all-zero and choose the atoms in that length block with largest positive empirical benefit, up to the cap. This is the usual sparse-lookup ERM and is polynomial in the sample size and $s$.

The same candidate family gives weak agnostic proper learning. For any joint distribution $\mathcal D$ and any near-optimal $c^\star\in\mathcal C$, the realizable handle lemma gives a proper candidate $g$ in the searchable handle/constant subfamily with

$$
\Pr[g(X)\ne c^\star(X)]\le 3/7
$$

when $c^\star$ is a seed, and gives $g=c^\star$ when $c^\star$ is a constant or subset handle. Hence, in the seed case,

$$
\operatorname{err}_{\mathcal D}(g)
\le
\operatorname{err}_{\mathcal D}(c^\star)
+
\Pr[g(X)\ne c^\star(X)]
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+3/7+o(1).
$$

Uniform convergence for the polynomial-VC sparse-handle family, plus empirical validation over the constants and best handles, gives an efficient proper learner with additive tolerance, for example,

$$
\beta=13/28 < 1/2.
$$

Thus $\mathcal C$ satisfies `efficient-weak-agnostic-proper-pac` in the literal fixed-tolerance sense. If the atlas weak source is instead read with inverse-polynomial gap, the original singleton-handle class in `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md` already suffices.

## Target Fails: Fixed-Marginal Strong Proper Learning Inverts

Use the same fixed coordinate marginal as the existing one-way image-coordinate notes. Let $P^\star$ choose length $k$ with

$$
\mu_k=\frac{6}{\pi^2 k^2},
$$

then choose $i\in[k]$ and $b\in\{0,1\}$ uniformly.

Given a one-way challenge $y=f(s)$ of length $n$, define realizable labels by the length-$n$ seed rule:

$$
Y(1^k,i,b)=1
\quad\Longleftrightarrow\quad
k=n \text{ and } b=y_i.
$$

This distribution is realizable by some seed concept $c_s\in\mathcal C$.

Set

$$
\varepsilon_n=\frac{\mu_n}{3n}.
$$

Any proper hypothesis with $P^\star$-error at most $\varepsilon_n$ must be a seed concept of length $n$ with image exactly $y$:

- a wrong-length seed misses the positive half of the length-$n$ block, costing at least $\mu_n/2$;
- a same-length seed with one wrong image bit disagrees on both atoms for that coordinate, costing $\mu_n/n$;
- a constant has error at least $\mu_n/2$ on the active block or worse off it;
- a length-$n$ subset handle contains at most $n/4$ of the $n$ positive atoms, so it misses at least $3n/4$ positive atoms and costs at least $3\mu_n/8$;
- a subset handle of any other length labels zero on the active positive atoms and costs at least $\mu_n/2$.

All of these lower bounds exceed $\varepsilon_n$ for large $n$.

If an `efficient-marginal-nonuniform-realizable-proper-pac` learner existed for $\mathcal C$, then for the single fixed marginal $P^\star$ there would be a polynomial $p_{P^\star}$ bounding its runtime in $n$, $1/\varepsilon$, and $\log(1/\delta)$. On input $y$, simulate labeled examples from $P^\star$ using the displayed label rule and run the learner with $\varepsilon_n$ and constant confidence. The output must be a seed $t$ with

$$
f(t)=y.
$$

Since $1/\varepsilon_n=O(n^3)$ and $P^\star$ is fixed, this is a randomized polynomial-time inverter for $f$, contradicting the one-way assumption.

## Proposed Atlas Update

If updating the edge later, the atlas fields should be changed roughly as follows:

```yaml
status: "false"
evidence: conditional-counterexample
assumptions:
  - length-preserving one-way functions exist
witnesses:
  - one-way-image-coordinate-bounded-handle-class
ref_keys:
  - kearns1994cryptographic
  - hastad1999prg
summary: "False under one-way functions: bounded proper handles give distribution-free weak agnostic proper learning, but fixed-marginal strong realizable proper learning would recover a one-way preimage."
family: one-way-image-coordinate-weak-handle-hardness
```

This would either need a new witness note for the bounded-handle variant, or a short strengthening of the existing `one-way-image-coordinate-weak-handle-class` note explaining that singleton handles are enough for inverse-polynomial weak gaps while bounded subset handles give a fixed additive weak-agnostic tolerance.

## Depth-2 Directions If This Is Not Accepted

1. Resolve the source-definition ambiguity: decide whether `efficient-weak-agnostic-proper-pac` requires a fixed constant $\beta<1/2$ or allows an inverse-polynomial gap as in the fixed-$k$ DNF notes. The bounded-handle variant above is meant to satisfy the fixed-constant reading.
2. Formalize the sparse-handle agnostic ERM lemma as a reusable argument note. It is a simple finite/VC calculation, but it is the one extra ingredient beyond the existing singleton weak-handle witness.
3. If the atlas wants only pre-existing witnesses, use the current one-way image-coordinate weak-handle class and state the result under the inverse-polynomial weak-gap convention.
4. Do not use fixed-$k$ DNF or PCP active slices as the main witness for this particular marginal-nonuniform target unless a fixed hard marginal is added; their standard reductions still leave the marginal-dependent runtime loophole.

verdict: false under length-preserving one-way functions
confidence: medium-high
