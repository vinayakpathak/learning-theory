# Edge: efficient-marginal-nonuniform-weak-agnostic-proper-pac -> efficient-marginal-nonuniform-agnostic-proper-pac

- depth: 1
- edge_file: `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-agnostic-proper-pac.md`
- verdict: resolved-false
- confidence: medium-high
- assumption: length-preserving one-way functions exist
- witness: `one-way-image-coordinate-weak-handle-class`

## Resolution Summary

This edge is false, assuming length-preserving one-way functions exist.

The current edge note correctly identifies why ordinary boosting is not a proof: boosted votes over proper weak hypotheses are generally improper, and marginal-nonuniform boosting also has rate-envelope issues. But there is a sharper fixed-marginal counterexample already present nearby in the atlas.

Use the one-way image-coordinate weak-handle class. The existing atlas note uses it to refute

```text
efficient-marginal-nonuniform-weak-realizable-proper-pac
-> efficient-marginal-nonuniform-realizable-proper-pac.
```

The additional point needed for this edge is that the same class satisfies the stronger weak agnostic proper source. This uses the low-noise robustification argument, but here it remains proper because the class explicitly contains the two constant concepts and the weak realizable learner already outputs proper concepts.

## Definitions Checked

The source asks for one uniform learner which, for each instance marginal $P$, has a $P$-dependent polynomial sample/time bound and outputs $h\in\mathcal C$ satisfying

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\beta_P(s),
\qquad
\beta_P(s)=1/2-\gamma_P(s),
$$

where $\gamma_P(s)$ is inverse-polynomial under a $P$-dependent polynomial.

The target asks for the same marginal-nonuniform resource convention, still with proper output, but for arbitrary excess error:

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\varepsilon.
$$

In particular, the target restricted to realizable distributions would give efficient marginal-nonuniform strong realizable proper learning.

## Counterexample

Assume a length-preserving one-way function $f:\{0,1\}^n\to\{0,1\}^n$.

The instance domain contains coordinate atoms $(1^k,i,b)$, where $i\in[k]$ and $b\in\{0,1\}$. A seed $s\in\{0,1\}^n$ defines an image-coordinate concept

$$
c_s(1^k,i,b)=1
\quad\Longleftrightarrow\quad
k=n \text{ and } b=f(s)_i.
$$

Let $\mathcal C$ contain all such seed concepts, the two constants, and every singleton-positive-atom concept. This is `one-way-image-coordinate-weak-handle-class`.

### Source Holds

First, the class is marginal-nonuniform weak realizable proper learnable.

For an image-coordinate target of length $n$, let $M$ be the marginal mass of its positive set. The all-zero concept has error $M$, the all-one concept has error $1-M$, and a singleton on a heaviest positive atom has error at most $M(1-1/n)$. Therefore one of these proper handles has error at most $1/2-\Omega(1/n)$. Samples and validation find such a handle in polynomial time. Constant and singleton targets are weakly learnable by the same constants-or-singleton strategy.

Now upgrade this witness to the assigned weak agnostic proper source.

Fix a marginal $P$. Let $L$ be the weak realizable proper learner under $P$, with constant-confidence sample bound $m_P(s)$ and realizable advantage $\rho_P(s)$. Define

$$
\alpha_P(s)=\min\{\rho_P(s)/4, 1/(16m_P(s))\}.
$$

On agnostic data $\mathcal D$ with marginal $P$, run $L$ several times on fresh noisy samples, add the two constant concepts to the candidate list, validate all candidates on fresh examples, and output the empirically best candidate. Every candidate is proper because $L$ is proper and both constants are in $\mathcal C$.

Let $\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D)$.

If $\eta\ge\alpha_P(s)$, the better constant has error at most $1/2$, hence

$$
1/2\le \eta+1/2-\alpha_P(s).
$$

So validation can safely return a proper constant while preserving an inverse-polynomial weak gap, up to harmless constant-factor slack.

If $\eta<\alpha_P(s)$, choose $c^\star\in\mathcal C$ with error close to $\eta$. Couple a noisy run of $L$ on $(X,Y)\sim\mathcal D$ with a clean realizable run on $(X,c^\star(X))$, using the same $P$-distributed instance sequence and the same internal randomness. Since $L$ inspects at most $m_P(s)$ examples, the probability of seeing any corrupted label is at most

$$
m_P(s)\eta < 1/16.
$$

On the no-corruption event, the noisy transcript is exactly a realizable transcript under the original marginal $P$, not under a conditioned marginal. With constant probability, $L$ returns a proper $h$ satisfying

$$
\operatorname{err}_P(h,c^\star)\le 1/2-\rho_P(s).
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

Repetition and validation preserve a gap of, say, $\alpha_P(s)$ after constant-factor losses. Thus the class satisfies `efficient-marginal-nonuniform-weak-agnostic-proper-pac`.

The properness point is essential: the standard low-noise robustification in the atlas is stated for improper targets because constants need not be legal proper concepts in an arbitrary class. Here constants are explicitly part of the class, so the robustified learner remains proper.

### Target Fails

Use the fixed all-length coordinate marginal from the existing one-way image-coordinate hardness note:

$$
\mu_k=\frac{6}{\pi^2k^2},
$$

then, conditional on length $k$, choose $i\in[k]$ and $b\in\{0,1\}$ uniformly.

Suppose an efficient marginal-nonuniform agnostic proper learner $A$ existed for this class. Given a one-way challenge $y=f(s)\in\{0,1\}^n$, simulate labeled examples from the fixed marginal by labeling

$$
(1^k,i,b) \mapsto 1
\quad\Longleftrightarrow\quad
k=n \text{ and } b=y_i.
$$

This distribution is realizable by the seed concept $c_s$, so its agnostic optimum is $0$. Run $A$ with

$$
\varepsilon_n=\frac{\mu_n}{3n}.
$$

The runtime is polynomial in $n$ because the marginal $P$ is fixed once and for all, so its polynomial $p_P$ is a fixed polynomial, and $1/\varepsilon_n=O(n^3)$.

Any output with error at most $\varepsilon_n$ must be a seed concept $c_t$ of length $n$ with $f(t)=y$:

- a constant has error at least $\mu_n/2$;
- a singleton handle has error at least $\mu_n/2-\mu_n/(2n)$;
- a seed of the wrong length has error at least $\mu_n/2$ on the length-$n$ block;
- a same-length seed with one wrong image bit disagrees on a whole coordinate pair and has error at least $\mu_n/n$.

All of these exceed $\varepsilon_n$ for large $n$, except the same-image seed case. Thus $A$ would output a preimage $t$ of $y$ in randomized polynomial time, contradicting one-wayness.

Therefore the strong marginal-nonuniform agnostic proper target fails for this class.

## Proper Aggregate Issue

This counterexample is also a warning against reading agnostic boosting as a proper-output theorem. Even when every weak call returns a proper hypothesis, a boosted vote or weighted aggregate need not lie in $\mathcal C$. The weak-handle class makes this concrete: the easy weak hypotheses are constants and singletons, while a strong proper learner must recover the hidden seed concept. Aggregating handles may help prediction, but the target demands one valid proper concept, and achieving the requested inverse-polynomial accuracy under the fixed coordinate marginal forces inversion.

## Proposed Atlas Update

Change the assigned implication to:

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
summary: "False under one-way functions: proper constants and singleton handles give the weak agnostic marginal-nonuniform proper source, but strong proper agnostic learning under the fixed coordinate marginal would invert the one-way function."
family: one-way-image-coordinate-weak-handle-hardness
argument_note: "[[one-way-image-coordinate-weak-handle-hardness|One-Way Image Coordinate Weak-Handle Hardness]]"
witness_note: "[[one-way-image-coordinate-weak-handle-class|One-Way Image Coordinate Weak-Handle Class]]"
```

Suggested body replacement:

```markdown
## Verdict

`false`, assuming length-preserving one-way functions exist.

Use the one-way image-coordinate weak-handle class: image-coordinate seed concepts, the two constants, and all singleton-positive-atom concepts. The handles give marginal-nonuniform weak realizable proper learning. Because the constants are themselves proper concepts, the marginal-preserving low-noise robustification converts this into weak agnostic proper learning: if the agnostic optimum is not tiny, a constant is within the weak additive tolerance; if the optimum is tiny, a noisy run of the weak learner couples to a clean realizable run under the same marginal with inverse-polynomial probability, and validation finds a proper weak candidate.

For the target lower bound, fix the coordinate marginal with length-$k$ mass $\mu_k=6/(\pi^2k^2)$. On a length-$n$ one-way challenge $y=f(s)$, label only the length-$n$ coordinate block according to $y$. A strong agnostic proper learner run with $\varepsilon=\mu_n/(3n)$ must output a seed concept of length $n$ with the same image, since constants, singletons, wrong lengths, and wrong images all have larger error. This inverts the one-way function in polynomial time.
```

## References Checked

- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-agnostic-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-agnostic-proper-pac.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/realizable-boosting.md`
- `atlas/arguments/sample-complexity-equivalence.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `references.bib`

verdict: resolved-false
confidence: medium-high
