# Edge: efficient-marginal-nonuniform-weak-agnostic-proper-pac -> efficient-marginal-nonuniform-realizable-proper-pac

- date: 2026-05-05
- edge_file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`
- verdict: resolved-false
- confidence: high
- assumption: length-preserving one-way functions exist
- witness: `one-way-image-coordinate-weak-handle-class`
- worker constraint: no atlas files edited

## Resolution Summary

This implication is false, assuming length-preserving one-way functions exist.

The current edge note marks the edge open as a marginal-nonuniform boosting problem. That boosting obstacle is real for a black-box positive theorem, but this edge has a direct fixed-marginal counterexample. Use the one-way image-coordinate weak-handle class: image-coordinate seed concepts, both constants, and all singleton-positive-atom concepts.

The already-recorded weak-handle argument separates

```text
efficient-marginal-nonuniform-weak-realizable-proper-pac
-> efficient-marginal-nonuniform-realizable-proper-pac.
```

The extra point for this edge is that the same class satisfies the stronger weak agnostic proper source. The class contains constants as proper hypotheses, and its weak realizable proper learner is robustified to weak agnostic proper learning by the marginal-preserving low-noise argument. The target still fails because sufficiently accurate proper realizable learning under one fixed coordinate marginal recovers a preimage of a one-way-function image.

## Definitions Checked

The source asks for one uniform learner such that, for every instance marginal $P$, there are a $P$-dependent polynomial bound and a weak tolerance

$$
\beta_P(s)=1/2-\gamma_P(s)<1/2,
$$

where $1/\gamma_P(s)$ is bounded by a $P$-dependent polynomial, and for every joint distribution $\mathcal D$ with marginal $P$ the learner outputs $h\in\mathcal C$ with

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\beta_P(s).
$$

The target asks for one uniform learner such that, for every marginal $P$, every realizable target $c\in\mathcal C$, and every $\varepsilon,\delta\in(0,1)$, the learner outputs $h\in\mathcal C$ with

$$
\operatorname{err}_{P}(h,c)\le \varepsilon
$$

in time and samples bounded by a $P$-dependent polynomial in $s,1/\varepsilon,\log(1/\delta)$.

## Counterexample Construction

Assume a polynomial-time computable length-preserving one-way function

$$
f:\{0,1\}^n\to\{0,1\}^n .
$$

The instance domain is

$$
X=\{(1^k,i,b): k\ge 1,\ i\in[k],\ b\in\{0,1\}\}.
$$

For a seed $s\in\{0,1\}^n$, let $y=f(s)$ and define the image-coordinate concept

$$
c_s(1^k,i,b)=1
\quad\Longleftrightarrow\quad
k=n \text{ and } b=y_i.
$$

Now enlarge the represented class by adding proper weak handles:

- the all-zero concept;
- the all-one concept;
- for every atom $a\in X$, the singleton concept $\mathbf 1_a$.

Thus

$$
\mathcal C
=
\{c_s:s\in\{0,1\}^\ast\}
\cup\{0,1\}
\cup\{\mathbf 1_a:a\in X\}.
$$

All of these are proper hypotheses for this class.

## Why The Source Holds

First show weak realizable proper learning. For a length-$n$ image-coordinate target $c_s$, let

$$
M=P(c_s^{-1}(1))
$$

be its positive mass under an arbitrary marginal $P$. The all-zero concept has error $M$, the all-one concept has error $1-M$, and a singleton on a heaviest positive atom has error at most $M(1-1/n)$. Therefore the best of these proper handles has error at most

$$
\min\{M,\ 1-M,\ M(1-1/n)\}
\le
1/2-\Omega(1/n).
$$

Samples and validation find such a handle in polynomial time. If a singleton is needed, a heaviest positive atom has inverse-polynomial mass in the relevant size parameter and is seen with polynomially many examples. Constant and singleton targets are weakly learnable by the same constants-or-singleton strategy: constants can be output exactly, and a singleton target is either already weakly approximated by zero or its atom is sampled quickly.

Now upgrade to the assigned weak agnostic proper source. Fix a marginal $P$. Let $L$ be the weak realizable proper learner just described, with $P$-specific polynomial sample bound $m_P(s)$ and realizable weak advantage $\rho_P(s)$. Choose

$$
\alpha_P(s)
\le
\min\{\rho_P(s)/4,\ 1/(16m_P(s))\}.
$$

On agnostic data $\mathcal D$ with marginal $P$, build a candidate list by including the two constants and repeatedly running $L$ on fresh noisy samples. Validate all candidates on fresh examples and output the empirically best one.

Let $\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D)$. If $\eta\ge 2\alpha_P(s)$, the better constant has error at most $1/2$, hence after a constant-factor validation slack it is within

$$
\eta+1/2-\alpha_P(s).
$$

If $\eta<2\alpha_P(s)$, choose $c^\star\in\mathcal C$ with error close to $\eta$. Couple a noisy run of $L$ on $(X,Y)\sim\mathcal D$ with a clean realizable run on $(X,c^\star(X))$, using the same $P$-distributed instance sequence and the same internal randomness. Since $L$ inspects at most $m_P(s)$ examples, the probability that any inspected label is corrupted is at most

$$
m_P(s)\eta < 1/8.
$$

On the no-corruption event, the noisy transcript is exactly a realizable transcript under the original marginal $P$. Thus, with inverse-polynomially bounded probability after accounting for $L$'s own success probability, $L$ outputs a proper $h$ satisfying

$$
\operatorname{err}_{P}(h,c^\star)
\le
1/2-\rho_P(s).
$$

Then

$$
\operatorname{err}_{\mathcal D}(h)
\le
\eta+\operatorname{err}_P(h,c^\star)
\le
\eta+1/2-\rho_P(s)
\le
\eta+1/2-4\alpha_P(s).
$$

Repetition and validation preserve an inverse-polynomial gap, say $\alpha_P(s)$. Every candidate is proper: $L$ outputs concepts in $\mathcal C$, and constants are explicitly in $\mathcal C$. Hence the class satisfies `efficient-marginal-nonuniform-weak-agnostic-proper-pac`.

This is the key reason the one-way weak-handle witness works for this edge. The low-noise robustification can fail to preserve properness for arbitrary classes because constants need not be legal proper hypotheses; here they are.

## Why The Target Fails

Fix the coordinate marginal $P^\star$ that chooses a length block $k$ with mass

$$
\mu_k=\frac{6}{\pi^2k^2},
$$

and then chooses $i\in[k]$ and $b\in\{0,1\}$ uniformly.

For a length-$n$ seed target $c_s$, set

$$
\varepsilon_n=\frac{\mu_n}{3n}.
$$

Since $\mu_n=\Theta(1/n^2)$, $1/\varepsilon_n=\operatorname{poly}(n)$.

Any proper hypothesis with $P^\star$-error at most $\varepsilon_n$ against $c_s$ must be a seed concept $c_t$ of length $n$ with $f(t)=f(s)$.

- The all-zero concept has error $\mu_n/2$ on the length-$n$ block.
- The all-one concept has error at least $1-\mu_n/2$.
- Any singleton has error at least $\mu_n/2-\mu_n/(2n)$.
- A seed concept of the wrong length has error at least $\mu_n/2$ on the length-$n$ block.
- A same-length seed with one wrong image bit disagrees on both bit-points for that coordinate, contributing error at least $\mu_n/n$.

All of these errors exceed $\varepsilon_n$ for large $n$, except the same-image seed case.

Now suppose the target node held for this class. Given a one-way challenge $y=f(s)$ for unknown $s\in\{0,1\}^n$, simulate labeled examples from $P^\star$ by labeling

$$
(1^k,i,b)\mapsto 1
\quad\Longleftrightarrow\quad
k=n \text{ and } b=y_i.
$$

This distribution is realizable by the seed concept $c_s$, and it can be sampled using only $y$. Run the alleged marginal-nonuniform realizable proper learner with accuracy $\varepsilon_n$ and constant confidence. Because $P^\star$ is fixed, the target promise supplies one fixed polynomial $p_{P^\star}$, and because $1/\varepsilon_n=\operatorname{poly}(n)$, the learner runs in randomized polynomial time in $n$. With constant probability it outputs a seed $t$ satisfying $f(t)=y$, contradicting one-wayness.

Thus the target fails under the one-way-function assumption.

## Proper Boosting Obstacles Checked

Classical weak-to-strong boosting does not rescue the implication. Schapire/Freund-style boosters form votes or weighted majorities over weak hypotheses. Those aggregates need not be concepts in $\mathcal C$. In this witness the issue is concrete: constants and singletons give cheap weak proper handles, but a sufficiently accurate proper hypothesis under the fixed coordinate marginal must be a seed concept with the exact hidden image.

The marginal-nonuniform rate issue is also a real obstruction for a generic positive theorem: boosting calls the weak learner on reweighted marginals, while the source supplies only one polynomial for each marginal separately. However, the counterexample does not rely on this envelope failure. The source learner for the weak-handle class is already simple and can be made distribution-free polynomial; the failure is the proper strong target's representation-recovery requirement.

## Proposed Atlas Update

If atlas edits are later allowed, update

`atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`

to:

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
refs:
  - "[Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)"
  - "[Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)"
summary: "False under one-way functions: proper constants and singleton handles give the weak agnostic marginal-nonuniform proper source, but fixed-marginal realizable proper learning would invert the one-way function."
family: one-way-image-coordinate-weak-handle-hardness
argument_note: "[[one-way-image-coordinate-weak-handle-hardness|One-Way Image Coordinate Weak-Handle Hardness]]"
witness_note: "[[one-way-image-coordinate-weak-handle-class|One-Way Image Coordinate Weak-Handle Class]]"
```

Suggested body:

```markdown
## Verdict

`false`, assuming length-preserving one-way functions exist.

Use the one-way image-coordinate weak-handle class: image-coordinate seed concepts, the two constants, and all singleton-positive-atom concepts. The handles give marginal-nonuniform weak realizable proper learning. Because constants are themselves proper concepts in this class, the marginal-preserving low-noise robustification gives weak agnostic proper learning: if the agnostic optimum is not tiny, a constant is within `OPT + 1/2 - gamma_P`; if the optimum is tiny, a noisy run of the weak learner couples to a clean realizable run under the same original marginal, and validation finds a proper weak candidate.

For the target lower bound, fix the coordinate marginal with length-`k` mass `mu_k = 6/(pi^2 k^2)`. On a length-`n` one-way challenge `y=f(s)`, label the length-`n` coordinate block according to `y`. This is realizable by a seed concept. A realizable proper learner run with `epsilon = mu_n/(3n)` must output a seed concept of length `n` with the same image, since constants, singletons, wrong lengths, and wrong images all have larger error. This recovers a preimage of `y` in randomized polynomial time, contradicting one-wayness.
```

The `axis_delta` should remain:

```yaml
resource: same
distribution: same
strength: weak-to-strong
realizability: agnostic-to-realizable
properness: same
```

## Sources Checked

- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-realizable-proper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-agnostic-proper-pac.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `references.bib`
- Kearns and Valiant 1994 bibliographic/abstract metadata, DOI `10.1145/174644.174647`
- Hastad, Impagliazzo, Levin, and Luby 1999 bibliographic/abstract metadata, DOI `10.1137/S0097539793244708`

## Final

verdict: resolved-false

confidence: high
