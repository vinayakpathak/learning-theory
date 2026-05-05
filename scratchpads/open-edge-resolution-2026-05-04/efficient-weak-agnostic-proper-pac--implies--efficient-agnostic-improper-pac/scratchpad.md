# Open Edge Resolution Scratchpad

Edge: `efficient-weak-agnostic-proper-pac -> efficient-agnostic-improper-pac`
Depth: 0 root pending
Current atlas status: `open`, evidence `unknown`
Family: `agnostic-boosting-open`

## Research Log

## Sources Checked

## Proof Or Counterexample Attempts

## Verdict

Unresolved pending depth-0 investigation.

## Follow-Up Directions

## Depth-0 Entry - 2026-05-04

### Relevant Definitions

Source: `efficient-weak-agnostic-proper-pac`. For every distribution over
examples, the learner outputs $h \in \mathcal C$ with

$$
\operatorname{err}_{\mathcal D}(h) \le
\inf_{c \in \mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta
$$

for a fixed additive $\beta<1/2$, in time and sample complexity polynomial in
the representation size and $\log(1/\delta)$. This is the Ben-David--Long--
Mansour fixed-additive weak agnostic notion, not an accuracy-sensitive weak
oracle.

Target: `efficient-agnostic-improper-pac`. For every $\varepsilon>0$, the
learner must output a possibly improper hypothesis $h$ with

$$
\operatorname{err}_{\mathcal D}(h) \le
\inf_{c \in \mathcal C}\operatorname{err}_{\mathcal D}(c)+\varepsilon
$$

in time and sample complexity polynomial in the representation size,
$1/\varepsilon$, and $\log(1/\delta)$.

In $\{\pm 1\}$ notation,
$\operatorname{corr}_{\mathcal D}(h)=1-2\operatorname{err}_{\mathcal D}(h)$, so
the source guarantee implies

$$
\operatorname{corr}_{\mathcal D}(h)
\ge \sup_{c\in\mathcal C}\operatorname{corr}_{\mathcal D}(c)-2\beta.
$$

Thus the atlas source can be viewed as a da Cunha--Hogsgaard--Paudice style
agnostic weak learner with $\gamma_0=1$, $\epsilon_0=2\beta$, and base class
$\mathcal H=\mathcal C$. Since $\beta<1/2$, this is nontrivial:
$\gamma_0>\epsilon_0$.

### Sources Checked

- `atlas/definitions/efficient-weak-agnostic-proper-pac.md`.
- `atlas/definitions/efficient-agnostic-improper-pac.md`.
- `atlas/implications/efficient-weak-agnostic-proper-pac--implies--efficient-agnostic-improper-pac.md`.
- `atlas/arguments/agnostic-boosting-open.md`.
- `atlas/registry/edge_families.yml`, especially the `agnostic-boosting-open`
  family.
- Ben-David, Long, and Mansour, "Agnostic Boosting", COLT/EuroCOLT 2001,
  DOI: https://doi.org/10.1007/3-540-44581-1_33.
- Gavinsky, "Optimally-Smooth Adaptive Boosting and Application to Agnostic
  Learning", JMLR 2003: https://www.jmlr.org/papers/v4/gavinsky03a.html.
- Kalai, Mansour, and Verbin, "Agnostic Boosting and Parity Learning", STOC
  2008, DOI: https://doi.org/10.1145/1374376.1374466.
- Ghai and Singh, "Sample-Optimal Agnostic Boosting with Unlabeled Data", ICML
  2025: https://proceedings.mlr.press/v267/ghai25a.html.
- da Cunha, Hogsgaard, and Paudice, "Sample-Near-Optimal Agnostic Boosting with
  Improved Running Time", arXiv 2601.11265: https://arxiv.org/abs/2601.11265.
- Tiegel, "Hardness of Agnostically Learning Halfspaces from Worst-Case Lattice
  Problems", COLT 2023: https://proceedings.mlr.press/v195/tiegel23a.html.

### Theorem Attempts

Direct boosting via da Cunha--Hogsgaard--Paudice almost proves the edge. Their
Definition 1 uses an agnostic weak learner satisfying

$$
\operatorname{corr}_{\mathcal D}(w)
\ge \gamma_0 \sup_{f\in\mathcal F}\operatorname{corr}_{\mathcal D}(f)
-\epsilon_0.
$$

The source gives exactly this with $(\gamma_0,\epsilon_0)=(1,2\beta)$. Their
main theorem then gives an improper classifier with excess error tending to
$0$ as the sample size grows. This is a genuine statistical/oracle weak-to-
strong result for any nontrivial fixed-additive weak learner.

The obstruction is computational. Their algorithm calls the weak learner at
most $O(n^{m_0+3})$ times and has running time

$$
\operatorname{Eval}_{\mathcal H}(1)\cdot
n^{O(m_0\min\{d^*,\log n\}/\theta^2)}
$$

where $m_0$ is the weak learner sample parameter, $d^*$ is the dual VC
dimension of the base class, and $\theta=(\gamma_0-\epsilon_0)/2$. The paper
explicitly frames the runtime as polynomial in the sample size when the other
parameters are fixed, and lists fully polynomial dependence on all parameters
as an open question. In the atlas, $m_0$ and representation-sensitive
dimensions may grow polynomially with the representation size. Therefore the
displayed bound can be $n^{\operatorname{poly}(s)}$, which is not polynomial in
the usual efficient PAC sense.

Ghai--Singh gives a fully efficient agnostic boosting algorithm in the
correlation-oracle framework, including an improper final classifier, but its
guarantee is

$$
\operatorname{corr}_{\mathcal D}(\bar h)
\ge \max_{h\in\mathcal H}\operatorname{corr}_{\mathcal D}(h)
-2\epsilon_0/\gamma-\epsilon.
$$

With the atlas source translated as $\gamma=1,\epsilon_0=2\beta$, this leaves a
constant correlation loss $4\beta+\epsilon$, not arbitrary excess error. Their
text notes that $\epsilon_0$ can be made small by feeding more samples to the
weak learner, but the atlas source is only a fixed-additive weak learner and
does not provide an accuracy parameter that drives $\epsilon_0$ to $O(\epsilon)$.

The older Kalai--Mansour--Verbin/Feldman-style routes have the same issue in a
different form: to get final excess $\epsilon$, the weak oracle must have a
tolerance depending on $\epsilon$, or must be distribution-specific/relabeling
in a way stronger than the atlas source. Gavinsky and the original
Ben-David--Long--Mansour line explain why agnostic boosting is the right
question, but do not supply a representation-uniform polynomial-time conversion
from the fixed-additive source to the strong target.

### Counterexample Attempts

Halfspaces are the natural hard target, because Tiegel rules out efficient
distribution-free improper agnostic learning under worst-case lattice
assumptions. They do not witness this edge. Tiegel's hardness also rules out
nontrivial weak agnostic learning of halfspaces in the relevant sense, so
halfspaces fail the source as well as the target.

Cryptographic or PRF-style classes also do not immediately witness the edge.
If a class contains hard pseudorandom targets, then on realizable distributions
the source learner would still need to output a proper class member with error
below $1/2$ by a constant. That is already a weak proper learner for the hard
class and is exactly what the standard assumptions tend to forbid.

Fixed-$k$-term DNF separates weak proper agnostic learning from strong proper
learning under the atlas's recorded hardness, but the target here is improper.
I did not find a primary-source theorem showing fixed-$k$-term DNF is hard for
strong improper agnostic PAC learning while remaining fixed-additive weak
agnostic properly learnable.

### Precise Obstruction

The additive weak guarantee is strong enough information-theoretically:

$$
\operatorname{err}(h)\le \operatorname{opt}_{\mathcal C}+\beta
\quad\Longleftrightarrow\quad
\operatorname{corr}(h)\ge \sup_{c\in\mathcal C}\operatorname{corr}(c)-2\beta.
$$

Because $2\beta<1$, da Cunha--Hogsgaard--Paudice boosts it statistically. The
only missing step is a representation-uniform polynomial-time simulation. The
known nontrivial-tolerance booster searches over all $m_0$-subsamples and then
over combinations controlled by the dual VC dimension. This is compatible with
fixed-parameter oracle boosting, but not with the atlas target's polynomial
runtime in representation size and $1/\epsilon$.

### Final Verdict

`unresolved`.

The edge should remain `status: "open"`, `evidence: unknown` under the current
atlas conventions. It is resolved true for a statistical/oracle or
fixed-parameter reading of agnostic boosting, but not for the efficient PAC edge
as stated. I found no conditional counterexample satisfying the source.

### Follow-Up Directions

- Try to remove the $n^{m_0}$ and $n^{m_0 d^*}$ style dependence from the
  da Cunha--Hogsgaard--Paudice construction, or show that for representation
  classes of interest the needed $m_0,d^*$ parameters are bounded by constants
  or logarithms.
- Look for a computational lower bound tailored to fixed-additive agnostic weak
  learning: a class with an efficient proper learner achieving
  $\operatorname{opt}+\beta$ for some fixed $\beta<1/2$, but no efficient
  improper learner achieving $\operatorname{opt}+\epsilon$.
- Check whether recent agnostic boosting work after arXiv:2601.11265 obtains
  fully polynomial dependence on $m_0$, $d^*$, and $1/(1-2\beta)$. That is the
  cleanest route to upgrading this edge to `true` with `evidence: theorem`.

## Depth-1 Entry - 2026-05-04

### Question Rechecked

Depth 1 focused on the exact computational gap left by depth 0:

1. Does da Cunha--Hogsgaard--Paudice 2026, or any later primary source found by
   search, give runtime fully polynomial in the representation size, weak
   learner runtime, $1/(1-2\beta)$, and the final $1/\varepsilon$?
2. Do the terms $n^{m_0}$ and $n^{m_0d^*}$ become harmless once $m_0$ is read
   through the atlas definition of efficient weak agnostic proper PAC learning?
3. If not, is there a conditional witness class with efficient proper
   $\operatorname{opt}+\beta$ learning but no efficient improper
   $\operatorname{opt}+\varepsilon$ learning?

### Sources Checked

- da Cunha, Hogsgaard, and Paudice, "Sample-Near-Optimal Agnostic Boosting with
  Improved Running Time", arXiv:2601.11265 / ALT 2026:
  https://arxiv.org/abs/2601.11265. I inspected the arXiv source, especially
  the weak learner definition, Theorem 1 / Theorem 2.1, the computational
  complexity proof, and the conclusion.
- da Cunha, Hogsgaard, Paudice, and Sun, "Revisiting Agnostic Boosting",
  arXiv:2503.09384 / NeurIPS 2025: https://arxiv.org/abs/2503.09384. This is
  the statistically near-optimal predecessor; its own introduction says the
  algorithm is not computationally efficient.
- Ghai and Singh, "Sample-Optimal Agnostic Boosting with Unlabeled Data",
  ICML 2025 / arXiv:2503.04706:
  https://proceedings.mlr.press/v267/ghai25a.html and
  https://arxiv.org/abs/2503.04706.
- Tiegel, "Hardness of Agnostically Learning Halfspaces from Worst-Case Lattice
  Problems", COLT 2023: https://proceedings.mlr.press/v195/tiegel23a.html.
- Feldman, Gopalan, Khot, and Ponnuswami, "On Agnostic Learning of Parities,
  Monomials, and Halfspaces", SIAM J. Comput. 2009:
  https://doi.org/10.1137/070684914.
- Local atlas context: the two endpoint definitions, the open edge note, the
  `agnostic-boosting-open` argument, the fixed-$k$-term DNF witness, the
  clause-satisfaction lookup witness, the PRF sample-to-computational hardness
  witness, and the halfspace hardness argument.

I also searched for later primary sources using combinations of "agnostic
boosting", "improved running time", "fully polynomial", "weak learner", and
"2026". I found no post-arXiv:2601.11265 primary source that removes the
parameter dependence below.

### Runtime Reading Of da Cunha--Hogsgaard--Paudice 2026

The paper uses the correlation-style weak learner

$$
\operatorname{corr}_{\mathcal D}(w)
\ge
\gamma_0\sup_{f\in\mathcal F}\operatorname{corr}_{\mathcal D}(f)-\epsilon_0
$$

with sample parameter $m_0$. The atlas source gives this with
$\gamma_0=1$, $\epsilon_0=2\beta$, base class $\mathcal H=\mathcal C$, and

$$
\theta=\frac{\gamma_0-\epsilon_0}{2}=\frac{1-2\beta}{2}.
$$

So the theorem is quantitatively compatible with every fixed
$\beta<1/2$.

The problem is runtime. Their main theorem states that, in the non-vacuous
sample regime, the algorithm invokes the weak learner at most

$$
O(n^{m_0+3})
$$

times and has running time

$$
\operatorname{Eval}_{\mathcal H}(1)\cdot
n^{O(m_0\min\{d^*,\log n\}/\theta^2)},
$$

where $d^*$ is the dual VC dimension of $\mathcal H$. The proof explains the
source of these terms: the algorithm enumerates $m_0$-subsamples of half the
training set, then searches over $T$-wise combinations of the resulting
hypotheses, with

$$
T=O(\min\{d^*,\log n\}/\theta^2).
$$

The conclusion is explicit that the result is polynomial in the sample size
when the other parameters are fixed, and asks whether one can obtain a
statistically near-optimal algorithm whose running time is fully polynomial in
all parameters.

### Do The Exponents Become Harmless In The Atlas?

No, not for a general atlas implication.

Under `efficient-weak-agnostic-proper-pac`, the weak learner's sample and
runtime bounds are polynomial in the representation size $s$ and
$\log(1/\delta)$, and polynomial in $1/(1/2-\beta)$ if $\beta$ is treated as a
parameter. Thus, for the fixed confidence used inside the booster, it is
legitimate for

$$
m_0=p(s,1/(1/2-\beta))
$$

to be a nonconstant polynomial. The target sample size $n$ needed for final
excess $\varepsilon$ is itself polynomial in the relevant dimensions,
$1/\theta$, $1/\varepsilon$, and $\log(1/\delta)$. Substituting
$m_0=\operatorname{poly}(s)$ into $n^{m_0}$ or
$n^{O(m_0d^*/\theta^2)}$ gives $n^{\operatorname{poly}(s)}$, not a polynomial
in $s$ and $1/\varepsilon$.

The dual VC dimension is an independent obstruction. In the atlas translation
the base class is $\mathcal H=\mathcal C$. The definition of efficient weak
agnostic proper PAC learning does not require the dual VC dimension of
$\mathcal C$ to be constant, logarithmic, or even polynomially bounded in a way
that keeps it out of an exponent. The 2026 paper notes that $d^*$ is small for
many simple geometric base classes, but the atlas edge is representation-uniform
over arbitrary classes satisfying the source.

Therefore the 2026 theorem proves the edge for fixed-parameter subclasses where
$m_0$, $d^*$, $1/(1-2\beta)$, and evaluation cost are controlled as constants
or otherwise kept out of the exponent. It does not prove the efficient PAC edge
as stated.

### Why Other Positive Sources Still Do Not Settle It

The 2025 "Revisiting Agnostic Boosting" paper is the statistical predecessor:
it boosts any nontrivial weak learner, but the authors explicitly describe the
algorithm as not computationally efficient and list efficient near-optimal
boosting as future work.

Ghai--Singh 2025 gives a computationally efficient agnostic booster, but its
guarantee has a residual weak-oracle tolerance term. In their notation one
obtains

$$
\operatorname{corr}_{\mathcal D}(\bar h)
\ge
\max_{h\in\mathcal H}\operatorname{corr}_{\mathcal D}(h)
-\frac{2\varepsilon_0}{\gamma}-\varepsilon.
$$

With the atlas source translated as $\gamma=1$ and
$\varepsilon_0=2\beta$, this leaves a constant correlation loss
$4\beta+\varepsilon$. To get final $\operatorname{opt}+\varepsilon$, one would
need an accuracy-sensitive weak learner with $\varepsilon_0=O(\varepsilon)$.
The atlas source gives only a fixed additive $\beta<1/2$.

### Conditional Lower-Bound Search

I did not find an atlas-valid false witness.

Halfspaces are the first natural candidate because Tiegel gives
distribution-free improper agnostic hardness under worst-case lattice
assumptions. But this also destroys the source: Tiegel rules out any efficient
binary hypothesis with nontrivial advantage over $1/2$ even when the best
halfspace has tiny error. Since the atlas source must handle realizable and
near-realizable distributions with a fixed $\beta<1/2$, halfspaces fail the
source, not just the target.

The older Feldman--Gopalan--Khot--Ponnuswami hardness results for monomials and
halfspaces have the same shape for this edge: they are weak agnostic hardness
results, including proper weak agnostic hardness. They are useful for showing
that some classes fail the source, but not for a source-true / target-false
separation.

Cryptographic PRF-style classes also fail in the wrong direction. On realizable
distributions, the source would already require a proper hypothesis with error
below $1/2$ by a fixed constant. Standard PRF lower bounds are designed to rule
out even weak prediction under the hard marginal, so they refute the source.

Fixed-$k$-term DNF remains a near miss. The atlas uses it for weak proper versus
strong proper separations. This edge's target is improper, however. I did not
find a primary theorem saying fixed-$k$-term DNF is hard for strong improper
agnostic PAC learning while still satisfying efficient fixed-additive weak
agnostic proper PAC learning.

The clause-satisfaction lookup class is also the wrong shape. It separates
improper learning from proper learning, but the present target is improper; the
lookup learner is a positive improper learner rather than a target-hard
witness.

### Final Verdict

`unresolved`.

The positive side is now very close: da Cunha--Hogsgaard--Paudice 2026 proves
the statistical and fixed-parameter weak-to-strong conversion for exactly the
kind of nontrivial weak learner induced by the atlas source. The negative side
also has no witness: the known hard classes either fail weak agnostic learning
already, or separate only proper strong learning. The remaining obstruction is
precisely representation-uniform polynomial time.

### Concrete Next Directions

1. Track the ALT 2026 camera-ready and follow-up papers for a booster whose
   runtime is polynomial in $m_0$, the weak learner runtime, $d$ or $d^*$,
   $1/(1-2\beta)$, and $1/\varepsilon$, rather than putting $m_0d^*$ in the
   exponent.
2. Try to replace the 2026 enumeration of all $m_0$-subsamples by a sampling,
   online-learning, or compression argument that preserves the ability to find
   a weak hypothesis for each AdaBoost-style distribution. This is the most
   direct route to `resolved true`.
3. For a false witness, search specifically for "efficient constant-additive
   agnostic approximation but no improper PTAS" results. Ordinary weak
   agnostic hardness is too strong and kills the source.
4. Revisit fixed-$k$-term DNF and related PCP/gap-CSP encodings only if the
   hardness theorem rules out arbitrary polynomially evaluable improper
   hypotheses achieving $\operatorname{opt}+\varepsilon$. Proper-output
   hardness alone cannot settle this edge.

## Depth-2 Entry - 2026-05-04

### Narrow Question

Depth 2 checked two specific positive routes.

1. Can the da Cunha--Hogsgaard--Paudice 2026 exponent
   $m_0\min\{d^*,\log n\}/\theta^2$ be bounded from the atlas source
   definition by VC dimension, dual VC dimension, compression, or the weak
   learner's sample bound?
2. Is there a post-arXiv:2601.11265 primary source, or an ALT 2026
   camera-ready version, that upgrades the theorem to fully polynomial
   dependence on all parameters?

### Sources Rechecked

- da Cunha, Hogsgaard, and Paudice, "Sample-Near-Optimal Agnostic Boosting
  with Improved Running Time", arXiv:2601.11265 v3, submitted January 16,
  2026 and last revised February 3, 2026:
  https://arxiv.org/abs/2601.11265.
- The OpenReview ALT 2026 page for the same paper, last modified February 21,
  2026: https://openreview.net/forum?id=pt6v6evstE.
- The ALT 2026 accepted-papers and schedule pages. These list the talk as
  "Sample-Near-Optimal Agnostic Boosting in Fixed-Parameter Tractable Time",
  which is weaker than fully polynomial time:
  https://algorithmiclearningtheory.org/alt2026/accepted-papers/ and
  https://algorithmiclearningtheory.org/alt2026/conference-schedule/.
- arXiv searches for later "agnostic boosting" and "weak agnostic learner"
  papers. The latest directly relevant arXiv hit remains arXiv:2601.11265;
  newer-looking hits were either unrelated, quantum/special-class results, or
  older boosting frameworks.
- Ghai and Singh, "Sample-Optimal Agnostic Boosting with Unlabeled Data",
  arXiv:2503.04706 / ICML 2025:
  https://arxiv.org/abs/2503.04706.
- Ghai and Singh, "Sample-Efficient Agnostic Boosting", arXiv:2410.23632 /
  NeurIPS 2024 camera ready: https://arxiv.org/abs/2410.23632.
- Moran and Yehudayoff, "Sample Compression Schemes for VC Classes", JACM
  2016 / arXiv:1503.06960: https://arxiv.org/abs/1503.06960.

### Route 1: Bounding $m_0,d^*$ From Atlas Parameters

This route still fails for the atlas implication.

The atlas source gives a proper learner with

$$
\operatorname{err}(h)\le \operatorname{opt}_{\mathcal C}+\beta
$$

for some fixed $\beta<1/2$. In correlation notation this is a
$(\gamma_0,\epsilon_0)=(1,2\beta)$ weak learner for da
Cunha--Hogsgaard--Paudice, with

$$
\theta=\frac{\gamma_0-\epsilon_0}{2}=\frac{1-2\beta}{2}.
$$

Their theorem is therefore semantically matched to the atlas weak learner. The
problem is entirely resource accounting.

The 2026 theorem uses a sample parameter $m_0$ for the weak learner and a base
class $\mathcal H$. With $\mathcal H=\mathcal C$, the atlas source permits

$$
m_0=\operatorname{poly}(s,1/(1/2-\beta),\log(1/\delta_0)),
$$

where $s$ is representation size. The da Cunha--Hogsgaard--Paudice algorithm
calls the weak learner on all $m_0$-subsamples of a half-sample and then
searches over $T$-wise votes, giving at most $O(n^{m_0+3})$ weak calls and
runtime

$$
\operatorname{Eval}_{\mathcal H}(1)\cdot
n^{O(m_0\min\{d^*,\log n\}/\theta^2)}.
$$

Substituting $m_0=\operatorname{poly}(s)$ gives
$n^{\operatorname{poly}(s)}$, not $(s,n,1/\varepsilon)^{O(1)}$.

VC/sample-complexity control does not remove this. Since the source is a weak
realizable learner on realizable distributions, standard sample-complexity
logic implies finite VC dimension and, quantitatively, one expects
$d=O(m_0)$ up to the usual constants/logs for fixed weak advantage. But the
2026 exponent contains $m_0$ itself, not only $d$; bounding $d$ by $m_0$ does
not keep $m_0$ out of the exponent.

Dual VC control also does not save the general edge. The paper notes that
$d^*$ can be exponentially larger than $d$ in the worst case, while for simple
geometric base classes it can be small. The atlas implication is not restricted
to those simple base classes. Even if one uses the theorem's
$\min\{d^*,\log n\}$ to avoid the exponential worst case, the exponent becomes
$O(m_0\log n/\theta^2)$, yielding quasi-polynomial dependence in $n$ when
$m_0$ is constant and super-polynomial dependence in $s$ when
$m_0=\operatorname{poly}(s)$.

Compression bounds have the same shape. Moran--Yehudayoff show that every VC
class has a compression scheme of size exponential in $d$, and later work
improves or specializes pieces of this story, but a generic compression-size
bound is not an algorithmic replacement for the 2026 enumeration. Even a
polynomial-size compression scheme would have to be used in a new booster that
avoids an exponent depending on the compression or weak-sample parameter. The
currently cited 2026 algorithm does not provide that conversion.

So the strongest atlas-ready positive statement available from this route is:
the edge is true for fixed-parameter subclasses where $m_0$,
$\min\{d^*,\log n\}$, $\theta^{-1}$, and evaluation time are treated as
constants or otherwise excluded from the polynomial-time exponent. That is not
the representation-uniform efficient PAC edge.

### Route 2: Later Or Camera-Ready Fully Polynomial Results

This route also failed.

The arXiv page says v3 was last revised on February 3, 2026 and accepted at
ALT 2026. Its abstract still states polynomial time in the sample size "when
considering the other parameters of the problem fixed." The OpenReview ALT
2026 page, last modified February 21, 2026, has the same TL;DR: polynomial run
time when the other parameters are fixed. The ALT accepted-papers and schedule
pages strengthen the interpretation in the opposite direction by listing the
talk title as "Sample-Near-Optimal Agnostic Boosting in Fixed-Parameter
Tractable Time."

I found no primary post-arXiv:2601.11265 source giving fully polynomial
dependence. The relevant arXiv search is still topped by arXiv:2601.11265,
followed by the 2025/2024 Ghai--Singh papers and the 2025 "Revisiting
Agnostic Boosting" predecessor. The Ghai--Singh papers remain polynomial-time
for their oracle model but retain a final residual loss proportional to the
weak oracle tolerance, e.g. $2\epsilon_0/\gamma+\varepsilon$ or
$3\epsilon_0/\gamma+\varepsilon$ depending on the theorem. With the atlas
fixed-additive source, $\epsilon_0=2\beta$ is constant, so these results still
do not yield $\operatorname{opt}+\varepsilon$.

### Exact Missing Lemma

The missing lemma can be stated in atlas-ready form as follows.

**Fixed-additive agnostic weak-to-strong boosting lemma.** Let
$\mathcal C_s\subseteq\{\pm1\}^{\mathcal X_s}$ be a representation-indexed
binary concept class. Suppose there is a proper distribution-free learner
$W$ and a fixed $\beta<1/2$ such that, for every distribution
$\mathcal D$ over $\mathcal X_s\times\{\pm1\}$ and confidence $\delta$,
$W$ runs in time $p(s,\log(1/\delta),1/(1/2-\beta))$, uses at most
$p(s,\log(1/\delta),1/(1/2-\beta))$ samples, and outputs
$h\in\mathcal C_s$ satisfying

$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c\in\mathcal C_s}\operatorname{err}_{\mathcal D}(c)+\beta
$$

with probability at least $1-\delta$. Then there is an improper learner $A$
that, for every $\varepsilon,\delta>0$, runs in time
$\operatorname{poly}(s,1/\varepsilon,\log(1/\delta),1/(1/2-\beta))$ with oracle
access to/equivalent black-box use of $W$, and outputs a polynomially
evaluable hypothesis $g$ satisfying

$$
\operatorname{err}_{\mathcal D}(g)
\le
\inf_{c\in\mathcal C_s}\operatorname{err}_{\mathcal D}(c)+\varepsilon
$$

with probability at least $1-\delta$.

Equivalently, in da Cunha--Hogsgaard--Paudice notation, the desired lemma is a
booster for every nontrivial
$(\gamma_0,\epsilon_0,\delta_0,m_0)$ agnostic weak learner with
$\gamma_0>\epsilon_0$ whose runtime is polynomial in the final sample size,
weak learner runtime, $m_0$, $d$ or $d^*$ if used, $1/(\gamma_0-\epsilon_0)$,
and $\log(1/\delta)$, rather than having $m_0d^*$ or
$m_0\log n$ in an exponent.

### Verdict

`unresolved`.

The edge is not resolved true by current primary sources: the best theorem is
fixed-parameter tractable, not fully polynomial under atlas resource
bookkeeping. The edge is also not resolved false: no witness class is known
here with efficient proper $\operatorname{opt}+\beta$ learning but hard
improper $\operatorname{opt}+\varepsilon$ learning.

### Next Directions

1. Try to prove the missing lemma by replacing the all-$m_0$-subsample
   enumeration in the 2026 booster with a direct adaptive simulation of the
   weak learner, or with an online/sampling argument that controls adaptivity
   without union-bounding over all subsamples.
2. Look for a compression-to-boosting theorem whose running time is polynomial
   in compression size and weak learner runtime, and whose compression size is
   itself polynomially bounded by the atlas representation parameter. Existing
   generic VC compression alone is too large and not plugged into the 2026
   algorithm.
3. Track future versions of arXiv:2601.11265, PMLR ALT 2026 proceedings, and
   follow-up papers explicitly advertising "fully polynomial" agnostic
   boosting for nontrivial fixed-additive weak learners.
4. For a negative direction, search for approximation-theoretic learning
   classes with an efficient all-distributions additive-$\beta<1/2$ proper
   approximator but no efficient improper PTAS. Standard halfspace, PRF, and
   weak-agnostic-hard examples fail because they already refute the source.

## Depth-3 Entry - 2026-05-04

### Narrow Question

Depth 3 focused on whether the non-polynomial dependence on $m_0$ and $d^*$
in current nontrivial-tolerance agnostic boosters is known to be necessary, or
whether it should be treated as an artifact of the available algorithms.

Here $m_0$ is the weak learner's sample parameter and $d^*$ is the dual VC
dimension of the base class. For the atlas edge, both may scale with the
representation size. Thus a runtime such as

$$
n^{O(m_0\min\{d^*,\log n\}/\theta^2)}
$$

is not an efficient PAC runtime unless those parameters are fixed or otherwise
kept out of the exponent.

### Sources Checked For Lower Bounds

- da Cunha, Hogsgaard, Paudice, and Sun, "Revisiting Agnostic Boosting",
  NeurIPS 2025 / OpenReview:
  https://openreview.net/pdf?id=aFf30XJpl4.
- da Cunha, Hogsgaard, and Paudice, "Sample-Near-Optimal Agnostic Boosting with
  Improved Running Time", ALT 2026 / arXiv:2601.11265:
  https://arxiv.org/pdf/2601.11265.
- Ghai and Singh, "Sample-Efficient Agnostic Boosting", NeurIPS 2024 /
  OpenReview: https://openreview.net/pdf?id=ufKBRvYxtp.
- Ghai and Singh, "Sample-Optimal Agnostic Boosting with Unlabeled Data", ICML
  2025 / PMLR: https://proceedings.mlr.press/v267/ghai25a.html.
- Karbasi and Green Larsen, "The Impossibility of Parallelizing Boosting", ALT
  2024 / PMLR: https://proceedings.mlr.press/v237/karbasi24a.html.
- Lyu, Wu, and Yang, "The Cost of Parallelizing Boosting", arXiv:2402.15145:
  https://arxiv.org/pdf/2402.15145.
- Goldman, Kearns, and Schapire, "On the Sample Complexity of Weakly Learning",
  WUCS-92-33 / Information and Computation 1995:
  https://openscholarship.wustl.edu/cse_research/596/.
- Searches for combinations of "agnostic boosting lower bound", "oracle
  complexity", "weak learner sample size", "$m_0$", "dual VC dimension", and
  "$d^*$".

### What The Lower Bounds Actually Show

The relevant agnostic lower bound is currently statistical, not computational.
The "Revisiting Agnostic Boosting" theorem constructs classes for which a
$(\gamma,\epsilon_0,\delta_0,m_0,\mathcal F,\mathcal H)$ agnostic weak learner
exists, with $\operatorname{VC}(\mathcal H)\le d$, but any final learner needs
roughly the usual agnostic sample size on the order of

$$
\widetilde{\Omega}\!\left(\frac{d}{\gamma^2\varepsilon^2}\right)
$$

up to the paper's logarithmic and low-noise refinements. This supports the
sample size target of the 2026 booster. It does not say that a booster must
enumerate all $m_0$-subsamples, put $m_0$ in an exponent, or pay exponential
dependence on $d^*$.

The older weak-learning sample lower bounds are also not the missing theorem.
Goldman--Kearns--Schapire show that weak learning itself can require
nontrivial sample size as a function of VC dimension, even before boosting.
That makes it unsurprising that $m_0$ may be polynomial in the representation
size. It does not imply that a weak-to-strong agnostic booster must have
runtime exponential in $m_0$.

The oracle-complexity lower bounds for classical boosting are real, but they
concern different bottlenecks. Karbasi--Larsen and Lyu--Wu--Yang show that
boosting is inherently sequential in a black-box weak-oracle model: if one
tries to reduce the number of adaptive rounds, there is an exponential blow-up
in oracle calls/work, with tradeoffs involving the VC dimension and weak edge.
These results do not rule out an ordinary sequential booster that makes
polynomially many adaptive weak-learner calls and has runtime polynomial in
$m_0$, VC parameters, and $1/\varepsilon$. In fact, standard realizable
boosting already uses polynomially many sequential weak-learner calls.

I also did not find a lower bound specifically involving the dual VC dimension
in agnostic boosting. The 2026 algorithm uses $d^*$ to bound the number of
distinct label patterns / combinations it needs to search over, and the paper
notes that $d^*$ can be favorable for simple geometric base classes but bad in
general. I found no theorem saying that every nontrivial-tolerance agnostic
booster must have $d^*$, or $m_0d^*$, in the exponent.

### Positive Results Still Stop Short

The ALT 2026 booster is the strongest positive source for the atlas source
notion. Its Definition 1 exactly allows fixed, large $\epsilon_0$ and
$\delta_0$ with $\gamma_0>\epsilon_0$, which matches the atlas translation
$\gamma_0=1$, $\epsilon_0=2\beta$. It explicitly contrasts this with
Kalai--Kanade, Feldman, and Ghai--Singh style efficient algorithms, which need
the weak tolerance $\epsilon_0$ to shrink with the final accuracy
$\varepsilon$.

But the same theorem states that the algorithm invokes the weak learner at most
$O(n^{m_0+3})$ times and runs in

$$
\operatorname{Eval}_{\mathcal H}(1)\cdot
n^{O(m_0\min\{d^*,\log n\}/\theta^2)}.
$$

The paper's own abstract and theorem discussion describe this as polynomial in
the sample size when the other parameters are fixed. That is fixed-parameter
tractability, not the atlas target's representation-uniform polynomial time.

The Ghai--Singh algorithms give efficient oracle complexity, and the NeurIPS
2024 paper lists polynomially many weak calls for $\varepsilon$-excess error
under its weak-oracle model. However, those algorithms require the weak
oracle's tolerance parameter to be $O(\varepsilon)$, or otherwise leave a
residual loss proportional to the weak tolerance. With only the atlas fixed
$\beta<1/2$, they do not imply $\operatorname{opt}+\varepsilon$ for arbitrary
$\varepsilon$.

### Artifact Or Necessity?

Current evidence points to "artifact or open algorithmic barrier", not
"known necessary".

The reason is asymmetrical:

1. There are sample-complexity lower bounds for agnostic boosting, but they are
   matched by sample-efficient algorithms and do not force non-polynomial
   runtime in $m_0$ or $d^*$.
2. There are oracle/round lower bounds for parallelizing classical boosting,
   but they do not preclude a fully sequential polynomial-time agnostic
   booster.
3. The one theorem that handles fixed-additive nontrivial agnostic weak
   learners uses enumeration over $m_0$-subsamples and a dual-VC-controlled
   search. Those are proof/algorithmic devices in the current construction;
   I found no lower bound showing they are inherent.
4. No source-true / target-false concept-class witness emerged. Known
   agnostic hardness examples, such as halfspaces under lattice assumptions or
   PRF-style classes, already break the weak source in the relevant sense.

So the cleanest description is: the edge remains open because the literature
lacks a fully polynomial fixed-additive agnostic weak-to-strong boosting
theorem. It is not open because a lower bound shows such a theorem impossible.

### Verdict For Existing Edge

`unresolved`.

The existing atlas edge should remain `status: "open"`, `evidence: unknown`.
The best positive theorem resolves the statistical/fixed-parameter version but
not the efficient PAC implication as stated. The best negative results do not
resolve it false: they either concern sample complexity, parallelization, or
classes that fail the source hypothesis. The non-polynomial $m_0,d^*$
dependence in current boosters is therefore a missing algorithmic theorem, not
a known necessary obstruction.

## Depth-4 Entry - 2026-05-04

### Final Verdict

`unresolved`.

No atlas-valid resolution to `true` or `false` is available from the current
sources. The edge should remain

```yaml
status: "open"
evidence: unknown
```

The positive literature proves the right statistical statement and an
important fixed-parameter computational statement, but not the
representation-uniform polynomial-time implication required by
`efficient-agnostic-improper-pac`. The negative literature gives no
source-true / target-false witness.

### Exact Obstruction

The source gives a proper fixed-additive agnostic weak learner: for some
constant $\beta<1/2$,

$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta.
$$

Equivalently,

$$
\operatorname{corr}_{\mathcal D}(h)
\ge
\sup_{c\in\mathcal C}\operatorname{corr}_{\mathcal D}(c)-2\beta.
$$

Thus in the da Cunha--Hogsgaard--Paudice notation this is a nontrivial
agnostic weak learner with

$$
\gamma_0=1,\qquad \epsilon_0=2\beta,\qquad
\theta=\frac{\gamma_0-\epsilon_0}{2}=\frac{1-2\beta}{2}>0.
$$

So there is no semantic mismatch between the atlas source and the modern
nontrivial-tolerance agnostic boosting theorem. The obstruction is only the
runtime exponent.

The 2026 booster constructs its candidate pool by running the weak learner on
all $m_0$-subsamples and then searching over bounded-size votes. Its stated
resource bound includes at most

$$
O(n^{m_0+3})
$$

weak-learner invocations and running time

$$
\operatorname{Eval}_{\mathcal H}(1)\cdot
n^{O(m_0\min\{d^*,\log n\}/\theta^2)}.
$$

For the atlas edge, $m_0$ is the sample complexity of the assumed efficient
weak agnostic learner. The source definition permits
$m_0=\operatorname{poly}(s,1/(1/2-\beta),\log(1/\delta_0))$, where $s$ is the
representation size. Substituting this into the 2026 theorem gives

$$
n^{\operatorname{poly}(s)}
$$

or worse, not $\operatorname{poly}(s,1/\varepsilon,\log(1/\delta))$. The
$\min\{d^*,\log n\}$ term prevents the worst dual-VC blowup from being the
only issue, but it does not remove $m_0$ from the exponent. Even the fallback
exponent $O(m_0\log n/\theta^2)$ is not an efficient PAC runtime when
$m_0$ grows polynomially with the representation size.

This is the current runtime-exponent barrier: known boosters that tolerate a
fixed nonzero weak-oracle additive loss can boost statistically, but the known
algorithm pays for that tolerance by enumerating weak-learner samples and
votes in a way that is fixed-parameter tractable rather than fully
polynomial.

### Strongest Near-Miss Theorem

The strongest near miss is da Cunha--Hogsgaard--Paudice 2026,
`dacunha2026agnosticboosting`.

It is near-perfect for the atlas statement because it handles the original
Ben-David--Long--Mansour style nontrivial weak agnostic learner, not merely an
accuracy-sensitive weak oracle. With the atlas translation
$(\gamma_0,\epsilon_0)=(1,2\beta)$, it gives a weak-to-strong improper
agnostic learner with near-optimal sample complexity whenever
$\beta<1/2$.

It still cannot be cited as proving the edge because its running time is
polynomial in the final sample size only when $m_0$, $d^*$, $\theta^{-1}$, and
evaluation cost are treated as fixed parameters. The ALT 2026 presentation
title "Sample-Near-Optimal Agnostic Boosting in Fixed-Parameter Tractable
Time" matches this reading.

The strongest efficient near miss is Ghai--Singh 2025,
`ghai2025agnosticboosting`. It gives efficient agnostic boosting in a
correlation-oracle framework, but the final guarantee retains a residual term
proportional to the weak oracle tolerance, of the form
$2\epsilon_0/\gamma+\varepsilon$ in correlation loss. Under the atlas source
$\epsilon_0=2\beta$ is fixed, so this leaves constant excess loss rather than
arbitrary $\varepsilon$.

### Sources To Cite

Use these references if this unresolved edge note is updated:

- `bendavid2001`: original agnostic boosting / fixed-additive weak agnostic
  motivation.
- `gavinsky2003`: smooth adaptive boosting context for agnostic learning.
- `kalai2008agnosticboosting`: weak agnostic boosting and parity-learning
  framework; useful for explaining accuracy-sensitive weak learners.
- `ghai2025agnosticboosting`: efficient/sample-optimal modern agnostic
  booster, but with residual weak-tolerance loss.
- `dacunha2026agnosticboosting`: strongest current theorem for nontrivial
  fixed-additive agnostic weak learners; resolves the statistical and
  fixed-parameter version, but not the atlas efficient edge.

The narrow live check on 2026-05-04 did not find a later primary source
advertising fully polynomial agnostic boosting for nontrivial fixed-additive
weak learners. The latest directly relevant result remains
`dacunha2026agnosticboosting`.

### Atlas-Ready Unresolved Summary

This edge asks whether an efficient proper learner achieving
$\operatorname{opt}_{\mathcal C}+\beta$ for some fixed $\beta<1/2$ can always
be converted into an efficient improper learner achieving
$\operatorname{opt}_{\mathcal C}+\varepsilon$ for arbitrary
$\varepsilon>0$.

Known agnostic boosting theorems do not settle the efficient implication. The
modern fixed-additive theorem of da Cunha--Hogsgaard--Paudice applies to the
right weak-learner notion and gives near-optimal sample complexity, but its
runtime includes $O(n^{m_0+3})$ weak calls and
$n^{O(m_0\min\{d^*,\log n\}/\theta^2)}$ additional dependence. Since the atlas
source allows $m_0$ to grow polynomially with the representation size, this is
not polynomial time in the target sense. Efficient boosters such as
Ghai--Singh require weak-oracle tolerance shrinking with the target accuracy,
or else leave a constant residual loss under the atlas fixed-additive source.

No false witness is currently available. Standard hardness examples for
halfspaces, monomials, PRF-style classes, or related agnostic-hard classes
typically rule out nontrivial weak agnostic learning already, so they fail the
source rather than separating the target. Proper-learning separations such as
fixed-$k$-term DNF also do not apply because the target here is improper.

### Future Result That Would Settle The Edge

To resolve the edge `true`, it would suffice to prove the following
fully-polynomial fixed-additive agnostic boosting theorem.

Given oracle or black-box access to a proper learner $W$ that, for every
distribution over examples, outputs $h\in\mathcal C$ with

$$
\operatorname{err}(h)
\le
\inf_{c\in\mathcal C}\operatorname{err}(c)+\beta
$$

for some $\beta<1/2$, construct an improper learner whose runtime is

$$
\operatorname{poly}(s,1/\varepsilon,\log(1/\delta),
1/(1/2-\beta),\operatorname{time}(W),m_0,d)
$$

or the analogous bound with $d^*$, but with none of $m_0$, $d$, or $d^*$ in an
exponent depending on the final sample size. The output hypothesis must be
polynomially evaluable and satisfy

$$
\operatorname{err}(g)
\le
\inf_{c\in\mathcal C}\operatorname{err}(c)+\varepsilon.
$$

To resolve the edge `false`, it would suffice to exhibit a representation
class with an efficient proper all-distributions
$\operatorname{opt}+\beta$ learner for some fixed $\beta<1/2$, but no
efficient improper $\operatorname{opt}+\varepsilon$ learner under a standard
complexity assumption. Existing weak-agnostic hardness results do not have
this shape because they usually rule out the source learner too.

## Depth-5 Entry - 2026-05-05

### Verdict

`unresolved`.

The edge should remain open. I did not find a primary-source theorem that
upgrades the fixed-additive weak agnostic proper learner to a
representation-uniform polynomial-time strong improper agnostic learner. I
also did not find a source-true / target-false witness. The best classification
is still: true for statistical/oracle or fixed-parameter readings, open for the
efficient PAC implication as recorded in the atlas.

No atlas files should be changed on the basis of this entry.

### Definitions Used

Source: `efficient-weak-agnostic-proper-pac`. There is a proper learner for
some fixed additive $\beta<1/2$ such that, for every distribution
$\mathcal D$ over examples,

$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta,
\qquad h\in\mathcal C,
$$

with sample complexity and running time polynomial in the representation size
and confidence parameters.

Target: `efficient-agnostic-improper-pac`. For every $\varepsilon>0$, the
learner must output a polynomially evaluable, possibly improper hypothesis
$g$ satisfying

$$
\operatorname{err}_{\mathcal D}(g)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\varepsilon
$$

in time polynomial in the representation size, $1/\varepsilon$, and
$\log(1/\delta)$.

In $\{\pm1\}$ notation, the source translates to

$$
\operatorname{corr}_{\mathcal D}(h)
\ge
\sup_{c\in\mathcal C}\operatorname{corr}_{\mathcal D}(c)-2\beta.
$$

So it is a correlation weak learner with $\gamma=1$ and fixed slack
$\epsilon_0=2\beta$. The fixedness of this slack is the point that keeps
returning.

### Sources Checked

Local read-only context:

- `atlas/definitions/efficient-weak-agnostic-proper-pac.md`.
- `atlas/definitions/efficient-agnostic-improper-pac.md`.
- `atlas/implications/efficient-weak-agnostic-proper-pac--implies--efficient-agnostic-improper-pac.md`.
- `atlas/arguments/agnostic-boosting-open.md`.
- Existing depth 0--4 entries in this scratchpad.
- Local witness/argument notes for halfspaces, fixed-$k$-term DNF,
  clause-satisfaction lookup classes, PRF-style hardness, and the new
  PCP active-slice weak proper hardness notes.

Primary/live sources checked:

- da Cunha, Hogsgaard, and Paudice, "Sample-Near-Optimal Agnostic Boosting
  with Improved Running Time", arXiv:2601.11265, v3 last revised 2026-02-03:
  https://arxiv.org/abs/2601.11265 and https://arxiv.org/pdf/2601.11265.
- OpenReview ALT 2026 page for the same paper, last modified 2026-02-21:
  https://openreview.net/forum?id=pt6v6evstE.
- ALT 2026 accepted-papers page, listing the work as "Sample-Near-Optimal
  Agnostic Boosting in Fixed-Parameter Tractable Time":
  https://algorithmiclearningtheory.org/alt2026/accepted-papers/.
- Ghai and Singh, "Sample-Efficient Agnostic Boosting", arXiv:2410.23632:
  https://arxiv.org/abs/2410.23632 and https://arxiv.org/pdf/2410.23632.
- Ghai and Singh, "Sample-Optimal Agnostic Boosting with Unlabeled Data",
  ICML 2025 / PMLR: https://proceedings.mlr.press/v267/ghai25a.html.
- Kalai and Kanade, "Potential-Based Agnostic Boosting", NeurIPS 2009:
  https://papers.nips.cc/paper/3676-potential-based-agnostic-boosting and
  https://papers.neurips.cc/paper_files/paper/2009/file/13f9896df61279c928f19721878fac41-Paper.pdf.
- Feldman, "Distribution-Specific Agnostic Boosting", arXiv:0909.2927:
  https://arxiv.org/abs/0909.2927.
- Targeted web searches on 2026-05-05 for fully polynomial agnostic boosting,
  fixed-additive weak agnostic learners, and follow-ups to arXiv:2601.11265.

The live search did not find a post-ALT 2026 primary source removing the
fixed-parameter dependence.

### Theorem Route

The positive route splits into two known booster families, and each misses in a
different way.

First, the fully polynomial potential/relabeling boosters are efficient, but
they need an accuracy-sensitive weak learner. Kalai--Kanade define a weak
learner by

$$
\operatorname{corr}(h,D)\ge
\gamma\sup_{c\in C}\operatorname{corr}(c,D)-\epsilon_0,
$$

and their Theorem 1 outputs a classifier with correlation at least

$$
\operatorname{corr}(C,D)-\epsilon_0/\gamma-\epsilon.
$$

Ghai--Singh's modern versions have the same structural issue: their finite and
VC-dimensional theorems give final correlation loss

$$
2\epsilon_0/\gamma+\epsilon.
$$

The atlas source only gives $\gamma=1,\epsilon_0=2\beta$ for fixed
$\beta<1/2$. Plugging that into these efficient boosters leaves constant
excess loss, not arbitrary $\varepsilon$. These theorems would prove the edge
only for a stronger source node where the weak learner's slack can be driven
to $O(\varepsilon)$.

Second, da Cunha--Hogsgaard--Paudice 2026 handles the right fixed-additive
notion. With the atlas translation

$$
\gamma_0=1,\qquad \epsilon_0=2\beta,\qquad
\theta=(1-2\beta)/2>0,
$$

their theorem gives the desired statistical weak-to-strong conclusion. The
runtime, however, is still the same obstruction recorded at earlier depths:
the algorithm enumerates all $m_0$-subsamples and then searches over bounded
votes, with at most

$$
O(n^{m_0+3})
$$

weak-learner calls and additional dependence of the form

$$
n^{O(m_0\min\{d^*,\log n\}/\theta^2)}.
$$

The atlas source allows $m_0$ to be polynomial in the representation size.
Therefore this gives $n^{\operatorname{poly}(s)}$, not
$\operatorname{poly}(s,1/\varepsilon,\log(1/\delta))$. The OpenReview TL;DR,
arXiv abstract, and ALT title all describe the result as polynomial only when
the other parameters are fixed, so this is not merely a pessimistic reading of
the proof.

The tempting direct-adaptive idea also stops here. Because the source learner
is distribution-free, one can feed it relabeled or reweighted distributions
generated by a booster. But the known polynomial analyses of exactly that
style still pay the residual $\epsilon_0/\gamma$ or $2\epsilon_0/\gamma$ loss.
The 2026 theorem is precisely the known way around that residual fixed slack,
and it pays with fixed-parameter rather than fully polynomial time.

### Counterexample Route

No checked witness has the required shape.

Halfspaces remain target-hard under Tiegel's lattice-based agnostic hardness,
but they fail the source: the hardness rules out nontrivial weak agnostic
learning, even improperly, on low-OPT distributions.

PRF-style classes and parity-with-noise style assumptions also fail in the
wrong direction. On realizable distributions, the source would already give a
proper predictor with constant advantage. Standard pseudorandomness or noisy
parity assumptions are designed to rule out that weak prediction.

Fixed-$k$-term DNF and related proper-boosting examples separate weak proper
learning from strong proper learning. They do not separate this edge because
the target is improper; I found no primary theorem here saying that the class
is hard for strong improper agnostic PAC learning while satisfying the
fixed-additive proper weak agnostic source.

Clause-satisfaction lookup classes and the PCP active-slice lookup class also
do not fit. The clause-satisfaction lookup class is a positive example for
improper agnostic learning, so it cannot be target-hard. The PCP active-slice
construction is built to make weak proper learning hard, so it attacks the
source rather than witnessing source true / target false.

I also checked the more abstract "constant additive approximation but no
PTAS" route suggested by PCP/Max-CSP hardness. It does not immediately yield
an atlas witness. The source is not merely a constant approximation on
positive constraint instances; it must work for every labeled distribution and
must still weakly learn every realizable slice. Known PCP gadgets that make
proper optimization hard tend either to rule out the source weak learner or to
separate only proper targets.

### Concrete Obstruction

The unresolved point can be stated as a two-sided incompatibility between the
available theorem families:

- Fully polynomial agnostic boosters are known when the weak oracle tolerance
  is accuracy-sensitive; with the atlas fixed $\epsilon_0=2\beta$, their final
  guarantee retains a constant residual term.
- The only checked theorem that boosts a genuinely fixed nontrivial tolerance
  to arbitrary excess error is fixed-parameter tractable in $m_0,d^*$, and
  those parameters are allowed to grow with the representation size in the
  atlas source.

Thus the exact missing lemma remains:

Given black-box access to a proper learner $W$ with
$\operatorname{err}(W)\le\operatorname{opt}_{\mathcal C}+\beta$ for fixed
$\beta<1/2$, construct an improper learner with runtime polynomial in

$$
s,\;1/\varepsilon,\;\log(1/\delta),\;1/(1/2-\beta),\;
\operatorname{time}(W),\;m_0,
$$

and any VC or dual-VC parameter used, with none of these parameters appearing
in the exponent of the final sample size. No checked source proves this, and
no checked lower bound rules it out.

### Atlas-Ready Text If Still Open

`status: "open"`

`evidence: unknown`

Suggested summary:

> Open as a representation-uniform efficient PAC implication. A fixed-additive
> proper weak agnostic learner gives a nontrivial correlation weak learner with
> parameters $\gamma_0=1$ and $\epsilon_0=2\beta$. Modern fixed-additive
> agnostic boosting proves the corresponding statistical and fixed-parameter
> theorem, but its runtime enumerates weak-learner samples and includes
> $n^{O(m_0\min\{d^*,\log n\}/(1-2\beta)^2)}$-type dependence. Since the weak
> learner sample parameter $m_0$ may grow polynomially with representation
> size, this is not polynomial time in the atlas sense. Efficient
> potential-based boosters avoid this runtime exponent only when the weak
> oracle tolerance can shrink with the target accuracy; with the atlas fixed
> $\beta$, they leave constant excess loss. No source-true / target-false
> witness is known from the checked hardness examples.

Suggested refs if the edge note is refreshed:

- `bendavid2001`
- `kalai2008agnosticboosting`
- `gavinsky2003`
- `feldman2010distributionspecific`
- `ghai2025agnosticboosting`
- `dacunha2026agnosticboosting`
- optionally add Kalai--Kanade 2009 if a new bibliography key is introduced
  for the potential-based polynomial booster near miss.
