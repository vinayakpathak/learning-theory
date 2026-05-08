# Edge: efficient-marginal-nonuniform-weak-agnostic-improper-pac -> efficient-marginal-nonuniform-realizable-proper-pac

- depth: 1
- edge_file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`
- verdict: resolved-false
- confidence: high
- assumption: length-preserving one-way functions exist
- witness: `one-way-image-coordinate-class`

## Resolution Summary

This edge is false under the standard cryptographic assumption that length-preserving one-way functions exist.

The current edge note treats the implication as a combined weak-to-strong boosting and improper-to-proper conversion problem. That is a real black-box obstruction, but a direct counterexample is already available in the atlas: the one-way image-coordinate class is efficiently agnostically learnable by an improper sparse ERM, hence it satisfies the assigned weak marginal-nonuniform agnostic improper source. At the same time, a marginal-nonuniform realizable proper learner under one fixed marginal would invert the one-way function.

Thus the weak source does not need to be boosted. The witness satisfies a stronger source:

```text
efficient-agnostic-improper-pac
  -> efficient-marginal-nonuniform-agnostic-improper-pac
  -> efficient-marginal-nonuniform-weak-agnostic-improper-pac.
```

The target failure is the same fixed-marginal strong proper recovery lower bound recorded in `one-way-image-coordinate-proper-hardness`.

## Definitions Checked

The source, `efficient-marginal-nonuniform-weak-agnostic-improper-pac`, asks for one uniform learner which may output outside $\mathcal C$. For every marginal $P$, there are a $P$-dependent polynomial sample/time bound and an additive tolerance

$$
\beta_P(s)=1/2-\gamma_P(s)<1/2
$$

with inverse-polynomial gap, such that for every joint distribution with marginal $P$,

$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta_P(s).
$$

The target, `efficient-marginal-nonuniform-realizable-proper-pac`, asks for one uniform learner which, for every marginal $P$, every realizable target $c\in\mathcal C$, and every $\varepsilon,\delta$, outputs $h\in\mathcal C$ with

$$
\operatorname{err}_{P}(h,c)\le \varepsilon
$$

in time and samples bounded by a $P$-dependent polynomial in $s,1/\varepsilon,\log(1/\delta)$.

## Counterexample

Assume a polynomial-time computable length-preserving one-way function

$$
f:\{0,1\}^n\to\{0,1\}^n
$$

for infinitely many lengths. The instance domain is

$$
X=\{(1^k,i,b): k\ge 1,\ i\in[k],\ b\in\{0,1\}\}.
$$

For a seed $s\in\{0,1\}^n$, let $y=f(s)$ and define the proper concept

$$
c_s(1^k,i,b)=1
\quad\Longleftrightarrow\quad
k=n \text{ and } b=y_i.
$$

A proper hypothesis is represented by a seed $t$; evaluating it computes the coordinate labels induced by $f(t)$. An improper hypothesis may instead be an explicit sparse lookup table on domain atoms.

## Why The Source Holds

For size bound $n$, let $\mathcal S_n$ be the improper class of all lookup-table classifiers whose positive set has size at most $n$. Every proper image-coordinate concept of length at most $n$ belongs to $\mathcal S_n$, because a length-$k$ seed has exactly $k\le n$ positive atoms.

The class $\mathcal S_n$ has VC dimension $n$: it shatters any $n$ distinct atoms and cannot shatter $n+1$ atoms because the all-positive labeling would require more than $n$ positive atoms.

ERM over $\mathcal S_n$ is polynomial-time. On the sample, compute for each distinct atom $x$ the empirical benefit of predicting $1$ rather than $0$:

$$
\#\{(x,1)\text{ in the sample}\}
-
\#\{(x,0)\text{ in the sample}\}.
$$

Choose the at most $n$ sampled atoms with largest positive benefit and predict $1$ exactly there; predict $0$ elsewhere. This minimizes empirical zero-one loss over all at-most-$n$-sparse lookup tables.

Standard VC uniform convergence then gives efficient distribution-free agnostic improper PAC learning against the proper class, with sample complexity and runtime polynomial in $n,1/\varepsilon,\log(1/\delta)$. Running this stronger learner with a fixed constant accuracy, say $\varepsilon=1/6$, gives the assigned weak agnostic improper source with constant gap from $1/2$. The same distribution-free polynomial works for every marginal, so the marginal-nonuniform source is satisfied.

## Why The Target Fails

Fix one marginal $P$ once and for all. It chooses a length block $k$ with mass

$$
\mu_k=\frac{6}{\pi^2k^2},
$$

then chooses $i\in[k]$ and $b\in\{0,1\}$ uniformly. For a length-$n$ target seed $s$, set

$$
\varepsilon_n=\frac{\mu_n}{3n}.
$$

Since $\mu_n=\Theta(1/n^2)$, $1/\varepsilon_n$ is polynomial in $n$.

If a proper hypothesis $c_t$ has $P$-error at most $\varepsilon_n$ against $c_s$, then $|t|=n$ and $f(t)=f(s)$.

- If $|t|\ne n$, then $c_t$ is zero on the length-$n$ block, while $c_s$ is positive on exactly one of the two bit-points for each coordinate. This creates error $\mu_n/2>\varepsilon_n$.
- If $|t|=n$ but $f(t)$ differs from $f(s)$ in some coordinate, the two concepts disagree on both bit-points for that coordinate, creating error at least $\mu_n/n>\varepsilon_n$.

Now suppose the target node held for this class. Given a one-way challenge $y=f(s)$ for a random unknown $s\in\{0,1\}^n$, simulate realizable labeled examples from the fixed marginal $P$ by labeling

$$
(1^k,i,b)\mapsto 1
\quad\Longleftrightarrow\quad
k=n \text{ and } b=y_i.
$$

This uses only the image $y$, not a preimage. Run the alleged marginal-nonuniform realizable proper learner with accuracy $\varepsilon_n$ and constant confidence. Because $P$ is fixed, the target promise supplies one polynomial $p_P$, and because $1/\varepsilon_n=\operatorname{poly}(n)$, the learner runs in polynomial time in $n$. With constant probability it outputs a seed $t$ such that $f(t)=y$, giving a polynomial-time inverter for $f$. This contradicts the one-wayness assumption.

## Relation To The Requested Notes

`marginal-boosting-open` is not needed for this edge. The counterexample satisfies the weak source by a stronger distribution-free agnostic improper learner, so no weak-to-strong amplification is required.

`properization-open` is the right broad family, but this particular edge should be carved out of it. The obstruction is proper representation recovery: prediction is easy by sparse lookup tables, while a sufficiently accurate proper predictor must recover a seed preimage.

`clause-satisfaction-proper-hardness` is useful for strong agnostic proper targets, where labels outside the formula can be made fair noise. It is not the cleanest witness here because the target is realizable. The one-way image-coordinate construction keeps the fixed-marginal lower bound realizable.

`one-way-image-coordinate-proper-hardness` is the exact argument note for the false direction. Its sparse-ERM source proof is strong enough to imply the assigned weak source.

## Proposed Atlas Update

If atlas edits are later allowed, update

`atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`

to:

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
summary: "False under one-way functions: image-coordinate concepts are distribution-free agnostically learnable by improper sparse ERM, hence satisfy the weak marginal-nonuniform agnostic improper source, but fixed-marginal realizable proper learning would invert the one-way function."
family: one-way-image-coordinate-proper-hardness
argument_note: "[[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]]"
witness_note: "[[one-way-image-coordinate-class|One-Way Image Coordinate Class]]"
```

Suggested body:

```markdown
## Verdict

`false`, assuming length-preserving one-way functions exist.

Use the one-way image-coordinate class. For the source, allow improper lookup tables with at most `n` positive atoms. This sparse class has VC dimension `n`, contains all length-at-most-`n` proper concepts, and has a polynomial-time ERM obtained by keeping the sampled atoms with largest positive empirical benefit. VC uniform convergence gives efficient distribution-free agnostic improper learning; running it at fixed constant accuracy gives the weaker marginal-nonuniform weak agnostic improper source.

For the target lower bound, fix the marginal with length-block masses `mu_k = 6/(pi^2 k^2)`. For a length-`n` target, any proper hypothesis within error `mu_n/(3n)` must have the same length and the same one-way image. Given a challenge image `y = f(s)`, labeled examples can be simulated under this fixed marginal using the bits of `y`. A marginal-nonuniform realizable proper learner run at that accuracy would output a seed `t` with `f(t)=y` in polynomial time, contradicting one-wayness.
```

## References Checked

- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-realizable-proper-pac.md`
- `atlas/definitions/efficient-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-agnostic-improper-pac.md`
- `atlas/implications/efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/implications/efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/clause-satisfaction-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- neighboring scratchpads for the agnostic-improper-to-realizable-proper and weak-agnostic-improper-to-strong/weak-realizable edges

verdict: resolved-false

confidence: high
