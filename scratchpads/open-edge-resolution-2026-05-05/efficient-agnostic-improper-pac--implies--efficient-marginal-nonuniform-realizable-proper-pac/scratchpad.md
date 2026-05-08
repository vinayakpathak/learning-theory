# Edge: efficient-agnostic-improper-pac -> efficient-marginal-nonuniform-realizable-proper-pac

- depth: 1
- edge_file: atlas/implications/efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md
- verdict: resolved-false
- confidence: high

## Context

The current edge note leaves this as an open properization question: the source allows a polynomial-time improper agnostic learner, while the target asks for a proper realizable learner with a marginal-dependent polynomial bound.

The relevant neighboring atlas material already contains a stronger counterexample family than the open note uses. In particular, [[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]] and [[one-way-image-coordinate-class|One-Way Image Coordinate Class]] state that, assuming length-preserving one-way functions, the image-coordinate class is:

- efficiently learnable by a distribution-free improper learner;
- in fact efficiently agnostically learnable by improper sparse ERM; and
- not efficiently marginal-nonuniform realizably properly learnable, because a proper learner under one fixed marginal would invert the one-way function.

This matches the assigned source more strongly than the already-resolved edge
`efficient-marginal-nonuniform-agnostic-improper-pac -> efficient-marginal-nonuniform-realizable-proper-pac`.

## Attempted Resolution

**Goal.** Exhibit a class satisfying efficient agnostic improper PAC learning but failing efficient marginal-nonuniform realizable proper PAC learning.

Assume a length-preserving one-way function $f:\{0,1\}^n\to\{0,1\}^n$. The image-coordinate domain contains triples $(1^k,i,b)$, where $i\in[k]$ and $b\in\{0,1\}$. A seed $s\in\{0,1\}^n$ defines the proper concept

$$
c_s(1^k,i,b)=1
\quad\Longleftrightarrow\quad
k=n \text{ and } b=f(s)_i .
$$

### Why The Source Holds

For size parameter $s$, use the improper hypothesis class of all lookup tables with at most $s$ positive atoms. This hypothesis class contains every proper image-coordinate concept of representation size at most $s$, since a length-$n$ concept has exactly $n\le s$ positive atoms.

It has VC dimension at most $s$ and admits a polynomial-time empirical risk minimizer on a sample: for each observed atom, compute the empirical benefit of labeling that atom $1$ rather than $0$, keep the at most $s$ sampled atoms with largest positive benefit, and label all other atoms $0$. Standard VC uniform convergence for finite-VC classes, as in Blumer et al. 1989, turns this ERM into a distribution-free agnostic improper learner against the original proper class. The sample and runtime are polynomial in $s$, $1/\varepsilon$, and $\log(1/\delta)$.

Thus the witness satisfies the assigned source node, not merely the marginal-nonuniform agnostic improper source.

### Why The Target Fails

Use the fixed marginal from [[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]]: it puts mass $\mu_k=6/(\pi^2k^2)$ on the length-$k$ coordinate block and then chooses $i\in[k]$ and $b\in\{0,1\}$ uniformly.

For a length-$n$ target seed $s$, set

$$
\varepsilon_n=\frac{\mu_n}{3n}.
$$

This accuracy parameter is inverse-polynomial in $n$. If a proper hypothesis $c_t$ has $P$-error at most $\varepsilon_n$ against $c_s$, then $|t|=n$ and $f(t)=f(s)$. A wrong length makes error $\mu_n/2$, and a single wrong image bit contributes at least $\mu_n/n$ error, both exceeding the requested tolerance.

Given a one-way challenge $y=f(s)$, simulate realizable examples under this fixed marginal by labeling $(1^k,i,b)$ positive exactly when $k=n$ and $b=y_i$. A marginal-nonuniform realizable proper learner for this fixed $P$, run with accuracy $\varepsilon_n$ and constant success probability, would output a seed $t$ with $f(t)=y$ in polynomial time. This contradicts one-wayness.

Therefore the implication is false under the stated cryptographic assumption.

## Proposed Atlas Update

Set the edge to the same counterexample family already used for nearby properization edges:

```yaml
status: "false"
evidence: conditional-counterexample
result_origin: "unclear"
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
summary: "False under one-way functions: image-coordinate concepts are distribution-free agnostically learnable by improper sparse ERM, but fixed-marginal realizable proper learning would invert the one-way function."
family: one-way-image-coordinate-proper-hardness
argument_note: "[[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]]"
witness_note: "[[one-way-image-coordinate-class|One-Way Image Coordinate Class]]"
```

Suggested replacement body:

```markdown
## Verdict

`false`, assuming length-preserving one-way functions exist.

Image-coordinate concepts are distribution-free agnostically learnable by improper sparse ERM, but marginal-nonuniform realizable proper learning under one fixed marginal would recover a preimage of a one-way image.

## Proof Status

Use the [[one-way-image-coordinate-class|one-way image-coordinate class]]. For a length-preserving one-way function $f$, a seed $s\in\{0,1\}^n$ defines $c_s(1^k,i,b)=1$ exactly when $k=n$ and $b=f(s)_i$.

**Why the source holds.** For size parameter $s$, allow improper lookup tables with at most $s$ positive atoms. This class contains every proper concept of size at most $s$, has VC dimension at most $s$, and has a polynomial-time ERM: keep the at most $s$ sampled atoms with largest positive empirical benefit and predict $0$ elsewhere. VC uniform convergence gives efficient distribution-free agnostic improper PAC learning.

**Why the target fails.** Fix the marginal $P$ with length-$k$ block mass $\mu_k=6/(\pi^2k^2)$ and uniform coordinates inside each block. For a target $c_s$ of length $n$, any proper hypothesis with error at most $\mu_n/(3n)$ must have the same length and the same image $f(s)$. Given a challenge $y=f(s)$, one can simulate realizable examples from this fixed marginal using the bits of $y$. A marginal-nonuniform proper learner would therefore output a seed $t$ with $f(t)=y$ in polynomial time, contradicting one-wayness.
```

## Obstacles

No remaining obstacle for a conditional resolution. The only caveat is that the conclusion is conditional on length-preserving one-way functions, matching the existing atlas witness and nearby resolved properization edges.

## Next Directions

- Update the assigned atlas edge to the `one-way-image-coordinate-proper-hardness` family.
- Consider removing this exact edge from the broader `properization-open` bucket once the atlas note is changed.
- Optionally audit other edges with source at least as strong as `efficient-agnostic-improper-pac` and target `efficient-marginal-nonuniform-realizable-proper-pac`; they may be resolved by the same witness if still open.

## References Checked

- [[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]]
- [[efficient-marginal-nonuniform-realizable-proper-pac|Efficient Marginal-Nonuniform Realizable Proper PAC Learning]]
- [[properization-open|Properization Open]]
- [[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]]
- [[one-way-image-coordinate-class|One-Way Image Coordinate Class]]
- `atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`
- `atlas/implications/efficient-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`
- Blumer et al. 1989 (`blumer1989`)
- Kearns and Valiant 1994 (`kearns1994cryptographic`)
- Hastad et al. 1999 (`hastad1999prg`)
