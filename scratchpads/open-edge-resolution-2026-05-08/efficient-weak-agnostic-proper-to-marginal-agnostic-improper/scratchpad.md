# Scratchpad: Efficient Weak Agnostic Proper PAC -> Efficient Marginal-Nonuniform Agnostic Improper PAC

Edge file: `atlas/implications/efficient-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac.md`

Depth log starts at depth 1 from the main agent's depth 0.

## Current Verdict

Unresolved at launch.

## Depth 1 Attempt

## Main-Agent Audit

Any depth-1 claim using halfspaces as the source witness is **not accepted** under the current atlas definition.

The source `efficient-weak-agnostic-proper-pac` is fixed-additive weak agnostic learning: for some fixed `beta < 1/2`, the learner must achieve `err <= opt_C + beta` distribution-free. Tiegel's distribution-independent lower bound for halfspaces blocks this source. For a fixed gap `a = 1/2 - beta`, the hard instances have `OPT` eventually below `a`, while no efficient improper learner gets error below `1/2 - gamma` for tiny `gamma`; a fixed-gap weak learner would contradict that. Requiring proper output only makes the source harder, so halfspaces cannot witness this edge.

The standard-Gaussian part of Tiegel remains a valid target obstruction, but a false witness must first satisfy the fixed-gap weak agnostic proper source. Depth-2 follow-up should focus on either a fully polynomial fixed-slack agnostic booster or a class with genuine constant-slack proper weak agnostic learning but no marginal-nonuniform strong improper agnostic learner.

### Verdict

Resolved as **false under Tiegel's worst-case lattice hardness assumption**.

The witness should be Boolean halfspaces. The source side is not obtained by generic agnostic boosting; it is obtained by a direct low-noise weak-agnostic robustification of the realizable proper halfspace learner, with the two constant classifiers included as proper halfspaces. The target side is ruled out by Tiegel's distribution-specific hardness for agnostically learning halfspaces under the standard Gaussian marginal.

### Edge

Source:

`efficient-weak-agnostic-proper-pac`

Target:

`efficient-marginal-nonuniform-agnostic-improper-pac`

The source asks for one distribution-free polynomial-time learner outputting $h \in \mathcal C$ with

$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta
$$

for a fixed additive tolerance $\beta < 1/2$, equivalently gap $\alpha=1/2-\beta \ge 1/\operatorname{poly}(s)$.

The target asks for one learner, possibly improper, whose runtime and sample bound may depend polynomially on the fixed instance marginal $P$, and which achieves $\operatorname{OPT}_{\mathcal C}+\varepsilon$ for every conditional label rule over that same $P$.

### Witness Class

Let $\mathcal C_d$ be the class of Boolean halfspaces over $\mathbb R^d$:

$$
h_{w,\theta}(x)=\mathbf 1[\langle w,x\rangle \ge \theta].
$$

The constant classifiers are proper halfspaces: for example, take $w=0$ and thresholds on either side of $0$.

### Why The Source Holds

Goal: construct an efficient weak agnostic **proper** PAC learner for halfspaces.

Halfspaces are efficiently realizably properly PAC learnable: on a realizable sample, linear feasibility finds a consistent separator, and the VC dimension of halfspaces gives polynomial sample complexity. The standard PAC/VC references already present in the atlas are Valiant 1984 and Blumer--Ehrenfeucht--Haussler--Warmuth 1989.

Fix a proper realizable learner $L$ for halfspaces. Run it to clean error at most, say, $1/8$ with constant confidence. Let $m(d)$ be the resulting polynomial sample bound, and set

$$
\alpha(d)=\min\{1/64,\ 1/(16m(d))\}.
$$

Given agnostic examples from $\mathcal D$ and confidence $\delta$, form a candidate list consisting of:

- the two constant halfspaces;
- many repetitions of $L$ on fresh batches of $m(d)$ agnostic examples, treating the observed labels as if realizable and skipping failed infeasible runs if needed.

Finally, validate the candidate list on a fresh holdout sample and output the empirically best candidate. The output is always a proper halfspace.

Let $\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D)$ and choose a best comparator $c^\star\in\mathcal C$ up to negligible slack.

If $\eta\ge \alpha(d)$, one of the two constants has error at most $1/2$, hence

$$
1/2 \le \eta+1/2-\alpha(d),
$$

so a proper constant halfspace already satisfies the weak agnostic guarantee.

If $\eta<\alpha(d)$, a fresh batch of size $m(d)$ is fully consistent with $c^\star$ with probability at least

$$
(1-\eta)^{m(d)}\ge 1-m(d)\eta \ge 15/16
$$

after decreasing constants in the definition of $\alpha$ if necessary. Conditioned on this clean-batch event, the batch is realizable by $c^\star$ under a conditional marginal $Q$ whose total-variation distance from the original marginal $P$ is $O(\eta)$. Since $L$ is distribution-free and proper, it returns a proper halfspace $h$ with

$$
\Pr_{X\sim Q}[h(X)\ne c^\star(X)]\le 1/8
$$

with constant probability. Transferring from $Q$ back to $P$ costs $O(\eta)$, and comparing to the noisy labels costs another $\eta$, so for $\eta<\alpha(d)$ and the above constants,

$$
\operatorname{err}_{\mathcal D}(h)
\le
\eta+1/8+O(\eta)
\le
\eta+1/2-\alpha(d).
$$

Polynomial repetition makes such an $h$ appear in the candidate list with probability $1-\delta/2$, and polynomial holdout validation selects a candidate with true error within a small fraction of $\alpha(d)$. Thus halfspaces satisfy `efficient-weak-agnostic-proper-pac` with inverse-polynomial gap $\alpha(d)$.

Important caveat: this does not contradict Tiegel's distribution-independent weak-looking hardness statement. In the PMLR abstract, the hard distributions can have best halfspace error $\delta_{\mathrm{opt}}$ as small as $\exp(-\Omega(\log^{1-c} d))$, which is still larger than any fixed inverse polynomial for large $d$. For the atlas additive weak guarantee with gap $\alpha(d)=1/\operatorname{poly}(d)$, a constant classifier is already legal whenever $\operatorname{OPT}\ge\alpha(d)$. The robustification only needs to extract signal in the very-low-noise regime $\operatorname{OPT}<\alpha(d)$, where clean-batch search succeeds.

### Why The Target Fails

Tiegel 2023 proves hardness of improperly learning halfspaces in the agnostic model from worst-case lattice assumptions. The result includes a distribution-specific lower bound under the standard Gaussian marginal: for every constant $\rho>0$, learning halfspaces to error

$$
\operatorname{OPT}_{\mathrm{LTF}}+\varepsilon
$$

under the standard Gaussian marginal requires time

$$
d^{\widetilde{\Omega}(1/\varepsilon^{2-\rho})}.
$$

This is not polynomial in $d$ and $1/\varepsilon$. Under the atlas convention already used in nearby halfspace implication notes, the standard Gaussian marginal family is a valid fixed-marginal witness for failure of `efficient-marginal-nonuniform-agnostic-improper-pac`: the target may choose a polynomial depending on the marginal, but it still cannot have degree growing with $d$ or with $1/\varepsilon$ in the way required by Tiegel's lower bound. The target also allows improper output, but Tiegel's lower bound is already improper.

Therefore halfspaces satisfy the source but fail the target under the stated lattice assumption.

### Proposed Atlas Field Updates

For `atlas/implications/efficient-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac.md`:

```yaml
status: "false"
evidence: conditional-counterexample
assumptions:
  - worst-case lattice hardness
witnesses:
  - halfspaces
ref_keys:
  - valiant1984
  - blumer1989
  - tiegel2023
summary: "False under worst-case lattice hardness: halfspaces satisfy the distribution-free proper fixed-additive weak agnostic source by low-noise robustification of their realizable proper learner with proper constant halfspaces, but Tiegel's standard-Gaussian distribution-specific hardness rules out the marginal-nonuniform strong agnostic improper target."
```

Suggested ancillary fields if the atlas maintainer wants consistency with nearby halfspace edges:

```yaml
family: halfspace-agnostic-hardness
argument_note: "[[halfspace-agnostic-hardness|Halfspace Agnostic Hardness]]"
witness_note: "[[halfspaces|Halfspaces]]"
```

The explanatory body should include both ingredients, because the source side is easy to miss:

1. Halfspaces are efficiently realizably properly learnable by linear feasibility plus VC generalization.
2. Since constants are proper halfspaces, the low-noise robustification outputs only proper hypotheses and gives a distribution-free fixed-additive weak agnostic learner with inverse-polynomial gap.
3. Tiegel's standard-Gaussian hardness rules out polynomial-time $\operatorname{OPT}+\varepsilon$ agnostic learning even for improper hypotheses, so the marginal-nonuniform strong target fails.

### Sources Checked

- Valiant 1984, "A Theory of the Learnable" (`valiant1984`), for the PAC framework.
- Blumer--Ehrenfeucht--Haussler--Warmuth 1989 (`blumer1989`), for VC-style sample guarantees.
- Tiegel 2023 (`tiegel2023`), PMLR page and abstract, for worst-case-lattice hardness of improper agnostic halfspace learning and the standard-Gaussian distribution-specific lower bound.

RESOLVED: yes

## Depth 2 Attempt: Weighted Decoding Separation

### Verdict

RESOLVED: no.

I did not find a coding-theoretic or cryptographic witness that soundly separates

`efficient-weak-agnostic-proper-pac`

from

`efficient-marginal-nonuniform-agnostic-improper-pac`.

The most useful conclusion is negative: the candidate must satisfy a very strong
weighted-decoding property under **arbitrary** instance marginals. Standard code and
crypto hardness sources either fail this source condition or only obstruct proper
decoding, while the target here is improper.

### Translation To Weighted Decoding

Model a concept class as a family of codewords over a coordinate domain $X_s$.
For a marginal $P$ on coordinates and an arbitrary received word/label rule
$y:X_s\to\{0,1\}$, the source learner must output a legal codeword $c\in C_s$
with

$$
d_P(c,y)\le \min_{c'\in C_s} d_P(c',y)+\beta,
$$

where $\beta=1/2-\gamma<1/2$ is the fixed weak tolerance. If constants are legal,
they handle the regime $\operatorname{OPT}\ge \gamma$, because a best constant has
error at most $1/2$. The nontrivial regime is therefore
$\operatorname{OPT}<\gamma$: the learner must perform bounded-distance,
proper, sample-based decoding below a fixed noise radius for every weighting
$P$ of the coordinates.

This is stronger than ordinary uniform decoding. If $P$ is supported on an
arbitrary subset of coordinates, the source has to decode the corresponding
punctured/weighted code. Thus a candidate with a hard hidden slice cannot simply
say "the uniform code is decodable"; the adversary can put all marginal mass on
the hard slice.

### Why General Nearest-Codeword Hardness Does Not Directly Work

The classical coding hardness route is tempting. Berlekamp--McEliece--van
Tilborg prove NP-completeness of general linear-code decoding and weight
problems; see the Caltech record for
[On the inherent intractability of certain coding problems](https://authors.library.caltech.edu/records/aw9vs-ann16).
Arora--Babai--Stern--Sweedyk prove hardness of approximating nearest-codeword
type optima; see the Princeton record for
[The Hardness of Approximate Optima in Lattices, Codes, and Systems of Linear Equations](https://collaborate.princeton.edu/en/publications/the-hardness-of-approximate-optima-in-lattices-codes-and-systems-/).
Preprocessing versions of nearest-codeword are also hard in the proper decoding
sense, e.g. Alekhnovich--Khot--Kindler--Vishnoi.

But this edge's target is **improper**. On a polynomial-size coordinate domain,
an improper marginal-nonuniform agnostic learner does not need to find a nearby
codeword at all. It can learn the received word as a lookup table, up to
epsilon-mass, from samples. For a fixed finite marginal this costs polynomially
in the support size and $1/\varepsilon$, and the polynomial may depend on the
fixed marginal. Therefore nearest-codeword hardness blocks strong **proper**
learning, not this strong improper target, unless the coordinate domain at the
hard marginal is exponentially large or otherwise cannot be memorized.

Once the coordinate domain is exponential, however, the source becomes the
problem. A distribution-free constant-slack proper weak learner would have to
decode from random examples under the same hard marginal whenever the labels are
near a legal codeword. For Hadamard/parity-style codes this is exactly the
constant-noise parity problem rather than a trivial bounded-distance task.

### Parity / Hadamard Route

Affine parities over $\{0,1\}^n$ are the cleanest code lens: they are Hadamard
codewords. Under the uniform marginal, strong agnostic learning of parities is
the usual noisy-parity/agnostic-parity problem. Kalai--Mansour--Verbin describe
agnostic parity learning over arbitrary distributions and give a
$2^{O(n/\log n)}$ algorithm, matching the best known subexponential behavior for
the easier noisy-parity variants; see
[Agnostic Boosting and Parity Learning](https://www.microsoft.com/en-us/research/publication/agnostic-boosting-parity-learning/).

This gives a conditional obstruction to the target under LPN-like assumptions,
but it also obstructs the source at constant slack. If $\gamma$ is a fixed
constant and the labels are a parity with random classification noise
$\eta<\gamma$ under the uniform marginal, the source learner must output a
proper parity with nontrivial constant advantage. That is already a noisy-parity
learner. The inverse-polynomial clean-batch trick from the earlier scratchpad
does not scale to fixed $\gamma$: a clean basis-sized batch has probability
$(1-\eta)^{\Theta(n)}$, which is exponentially small for constant $\eta$.

Goldreich--Levin style list decoding also does not rescue this edge. It is a
uniform/query-access or membership-query phenomenon. The atlas source is from
random examples and is distribution-free over arbitrary marginals. Feldman's
membership-query separation is a useful warning sign: distribution-specific
query algorithms can exist while random-example agnostic learning remains hard
under one-way functions; see
[On The Power of Membership Queries in Agnostic Learning](https://www.jmlr.org/papers/v10/feldman09a.html).
That is not enough for the present source.

### PRF / Cryptographic Route

Pseudorandom-function classes give the right target obstruction. Kearns and
Valiant's cryptographic learning lower bounds, and the standard GGM-style PRF
line behind them, are exactly the kind of reason an improper learner under the
uniform marginal should not strongly learn a realizable target; see the DBLP
entry for
[Cryptographic Limitations on Learning Boolean Formulae and Finite Automata](https://dblp.org/rec/journals/jacm/KearnsV94.html).

But the source fails even more directly. On the uniform marginal with noiseless
labels from a random PRF key, the source would have to output a proper concept
with error at most $1/2-\gamma$. Validating that output on fresh examples would
distinguish the PRF-labeled distribution from uniformly random labels. Thus a
standard PRF class cannot satisfy constant-slack weak agnostic proper learning.

Adding public handles has the same obstruction. If the marginal can concentrate
on the PRF-looking part of the domain, a handle that lives elsewhere is useless.
If handles are dense enough to give constant advantage under the uniform
marginal for every PRF target, then those handles themselves are a weak
predictor and threaten the PRF hardness assumption. This is the same
"computationally nonboostable handles" problem noted in nearby atlas notes, but
I do not see a concrete construction that makes it work.

### One-Way Coordinate / Handle Classes

The existing one-way image-coordinate weak-handle class is close in flavor. It
has constants and bounded subset handles that make weak proper learning easy, and
strong proper learning under a fixed marginal forces inversion.

It does **not** separate this edge because the target is improper. On each
finite length block the coordinate set is polynomial-size, so an improper
learner can sample the block and output a lookup table for the observed labels
to the requested accuracy. The one-way hardness there is a proper-output
hardness: the learner must return a seed/image-coordinate concept. Once improper
lookup tables are allowed, decoding the one-way preimage is unnecessary.

Trying to repair this by making the blocks exponentially large runs into the
same issue as PRFs and Hadamard codes. The hard block would no longer be
memorizable, but then the distribution-free weak source would need a real
constant-noise weak decoder on that block.

### What A Successful Coding Witness Would Need

A valid false witness from this direction seems to require all of the following.

1. An exponential or otherwise non-memorizable fixed marginal $P_\star$, so that
   improper lookup does not make the target trivial.
2. A proper constant-slack weak agnostic learner that works under every marginal
   $P$, equivalently an efficient sample-based weighted bounded-distance decoder
   for every weighting of the coordinates.
3. A high-noise or fine-accuracy regime under $P_\star$ where achieving
   $\operatorname{OPT}+\varepsilon$ is computationally hard even for arbitrary
   binary output.
4. Legal constants or neutralizers for the $\operatorname{OPT}\ge\gamma$ regime,
   without giving the improper learner enough handles to boost to strong
   accuracy.

I did not find an existing code family with this combination. General linear
codes have the hardness but not the source. Hadamard/parity and PRF-like codes
have target hardness but fail the constant-slack source under the hard marginal.
Polynomial-coordinate handle constructions have the source but fail to obstruct
improper learning.

### Promising Next Directions

The most promising next subagents should not search for ordinary nearest-codeword
hardness alone. That route keeps proving proper-output hardness. Better targets:

- Look for explicit exponential-length code families with efficient
  **weighted** bounded-distance decoding from random examples under arbitrary
  coordinate marginals, while maximum-likelihood or agnostic prediction under
  the uniform marginal is hard. This is a soft-decision/weighted-decoding
  question, not just a uniform unique-decoding question.
- Formalize a no-go lemma for PRF-style witnesses: any distribution-free
  constant-slack weak learner for a PRF-containing class weakly distinguishes
  PRF labels from random labels under the uniform marginal, unless the legal
  weak output comes from a public handle family with constant correlation on
  every PRF target.
- Investigate whether public handle families can be made nonboostable under an
  exponential marginal. The obstacle is that arbitrary marginals can avoid
  sparse handles, while dense handles appear to leak weak predictors under the
  hard marginal.
- Check trapdoor/bounded-distance code families where a public algorithm decodes
  below a tiny fixed constant radius for all weights, but high-noise agnostic
  prediction remains hard even with the trapdoor. I do not know such a family,
  and the arbitrary-weight requirement looks severe.

No atlas edits are justified from this attempt.

## Depth 3 Attempt: PRF and Public-Handle No-Go

### Verdict

RESOLVED: no.

This attempt rules out a broad PRF-style false-witness template, but it does not
resolve the edge. The remaining possible cryptographic route would need a
public low-noise decoder or handle system that is not a standard PRF predictor
and that remains hard for high-noise strong agnostic learning. I did not find
such an object.

### Setup

Let $P_n$ be the usual hard marginal on an exponentially large domain, say the
uniform distribution on $\{0,1\}^n$. Let $F_k:\{0,1\}^n\to\{0,1\}$ be a
pseudorandom function family. A PRF-style target obstruction would say that, if
an agnostic improper learner achieves $\operatorname{OPT}_{\mathcal C}+\epsilon$
under $P_n$, then it predicts either $F_k$ or a noisy version of $F_k$ with
nonnegligible advantage, contradicting PRF security.

The source for this edge is much stronger at low noise. It asks for a
distribution-free proper learner $A$ and a fixed constant gap $\gamma>0$ such
that

$$
\operatorname{err}(A)\le \operatorname{OPT}_{\mathcal C}+1/2-\gamma .
$$

Thus, whenever labels are within noise $\eta<\gamma/4$ of some concept in
$\mathcal C$, the source must return a proper hypothesis with error below
$1/2-\Omega(\gamma)$.

### Direct PRF No-Go

Suppose the concept class contains the PRF concepts themselves, or contains
proper concepts $c_k$ whose labels on the hard marginal are computationally
indistinguishable from PRF labels. Then the source already gives a PRF
distinguisher.

The distinguisher gets sample access to an oracle-labeled distribution under
$P_n$, where the labels are either $F_k(X)$ for a random key $k$ or independent
uniform bits. It runs the source learner $A$ on the training examples and then
estimates the returned proper hypothesis on fresh examples. If the labels are
PRF labels, $\operatorname{OPT}=0$, so with high probability

$$
\operatorname{err}_{P_n}(h,F_k)\le 1/2-\gamma .
$$

Fresh validation accepts with threshold, say, $1/2-\gamma/2$. If the labels are
truly random, then conditioned on any training transcript and any efficiently
evaluable output $h$, the fresh labels are still independent fair bits. A
Chernoff bound makes the probability that validation sees error below
$1/2-\gamma/2$ exponentially small in the validation sample size. Hence $A$
distinguishes PRF labels from random labels.

The same argument works for $\eta$-noisy PRF labels with
$\eta<\gamma/4$: applying independent classification noise to a PRF preserves
computational indistinguishability from random labels, while the source would
still output $h$ with fresh-label error below $1/2-\Omega(\gamma)$.

Conclusion: a standard PRF or cryptographic class that puts the hidden hard
functions themselves inside $\mathcal C$ cannot satisfy the distribution-free
constant-slack weak agnostic proper source.

### What If Public Handles Supply The Weak Output?

The only apparent escape is to add proper public handles. For each hidden PRF
target $F_k$, the source learner might output a handle $g$ rather than recover
or represent $F_k$. I see three cases.

1. **Handles outside the hard marginal.** If $P_n$ can be restricted to the
   PRF-looking coordinates, handles living on separate coordinates do not help.
   The distribution-free source quantifies over this restricted marginal too,
   so the direct PRF no-go returns.

2. **Handles with constant correlation on the hard marginal.** If a polynomial
   learner can find an efficiently evaluable handle $g$ with
   $\Pr[g(X)\ne F_k(X)]\le 1/2-\gamma'$ under $P_n$, then the same fresh
   validation test distinguishes PRF labels from random labels. This is true
   even if $g$ is public, simple, or not key-recovering. A constant predictor
   against a PRF is already a PRF distinguisher.

3. **Handles with only tiny high-noise advantage.** If every public handle has
   advantage $\tau<\gamma$, then constants already satisfy the weak source in
   the high-noise regime where $\operatorname{OPT}\ge\gamma$. Such handles
   might still be relevant to the strong target, because
   $\operatorname{OPT}+\epsilon$ learning with $\epsilon\ll\tau$ must recover
   the tiny advantage. But this no longer repairs a PRF-containing concept
   class: on noiseless or $\eta<\gamma$ labels from any proper hard concept,
   the source again needs a constant-advantage predictor. Therefore the proper
   concepts used by the handles must themselves be low-noise learnable by some
   non-PRF mechanism.

This reduces the possible cryptographic witness to a more specific
bounded-distance/high-noise split: low-noise learning of legal concepts must be
easy under every marginal, while high-noise agnostic recovery of tiny advantages
under one fixed marginal remains hard even improperly. That is closer to a
special error-correcting-code or decoding-threshold object than to ordinary PRFs.

### Do Public Handles Become Learnable Improperly?

For the handle systems already present in the atlas, yes.

The one-way image-coordinate weak-handle class adds constants and bounded
positive-atom subset handles. Those handles give a proper weak learner, but they
also make the improper target easy on each finite length block: the coordinate
domain is polynomial-size, so an improper learner can use samples to build a
lookup table or run the sparse weighted-benefit rule over sampled atoms. The
one-way hardness is a proper-output recovery obstruction, not an improper
agnostic prediction obstruction.

More generally, if the public handle family is polynomial-size or has an
efficient empirical optimizer under the fixed marginal, then
marginal-nonuniform agnostic improper learning can just validate or ERM over the
handles, and then aggregate/memorize as needed. This covers sparse atom handles,
bounded subset handles, active finite-slice lookup handles, and any handle
family where the "public" repair is literally searchable from samples.

If the handle family is exponential and empirical optimization is hard, it no
longer automatically gives the source. In low-noise realizable distributions
over that same hard marginal, the source learner must still find some
constant-correlated legal handle from random examples. If the target labels are
PRF-like at low noise, that search is exactly the validation distinguisher above.
If the low-noise concepts are not PRF-like and have a public decoder, then the
witness has left the PRF template and become the weighted-decoding template from
Depth 2.

### Current Obstacle

The PRF/public-handle route therefore seems blocked as a counterexample to this
edge:

- plain PRF concepts violate the source;
- handles off the hard marginal are invisible to the source;
- constant-correlation handles on the hard marginal violate PRF
  pseudorandomness;
- searchable public handles tend to make the marginal-nonuniform improper
  target learnable;
- unsearchable exponential handles do not certify the source unless there is a
  separate low-noise decoder.

The remaining promising direction is not ordinary PRFs, but a threshold-style
decoding primitive: a class with efficient distribution-free proper decoding
below a fixed constant noise radius for arbitrary coordinate weights, and
fixed-marginal hardness of $\operatorname{OPT}+\epsilon$ prediction at a higher
or near-half noise level even for improper hypotheses. I did not find such a
primitive in this pass.

## Depth 4 Attempt: Public Neutralizer Plus Hidden Comparator

### Verdict

RESOLVED: no.

I did not find a counterexample of this form. The useful outcome is a sharper
obstruction: a public-neutralizer wrapper cannot by itself turn a hard hidden
comparator family into a witness for this edge. Either the public repair is
sample-searchable under the hard marginal, in which case the strong improper
target can usually learn by validation or lookup, or the hidden residual remains
nonmemorizable, in which case the distribution-free weak source has to solve the
same residual hard problem under a restricted marginal.

### Template Tested

I modeled the intended witness as a concept class

$$
\mathcal C = \mathcal H \cup \mathcal N \cup \mathcal G,
$$

where:

- $\mathcal H=\{h_k\}$ is a hidden comparator family that should be hard to
  strongly learn under some fixed marginal $P_\star$;
- $\mathcal N$ is a public neutralizer or handle family meant to give the
  constant-slack weak proper learner without recovering $k$;
- $\mathcal G$ contains constants or other simple fallbacks for the
  $\operatorname{OPT}_{\mathcal C}\ge \gamma$ regime.

The source requires a single distribution-free proper learner with

$$
\operatorname{err}(A)\le \operatorname{OPT}_{\mathcal C}+1/2-\gamma
$$

for a fixed $\gamma>0$. The target would fail if, under $P_\star$, no polynomial
improper learner can achieve

$$
\operatorname{err}(B)\le \operatorname{OPT}_{\mathcal C}+\varepsilon
$$

for all $\varepsilon>0$.

The tempting plan is: $\mathcal N$ gives a weak but not strong approximation to
each $h_k$, while the remaining gap between the neutralizer and $h_k$ hides a
cryptographic or coding-theoretic comparator.

### Residual Restriction Obstruction

Fix a hidden comparator $h_k$ and a proposed public neutralizer $n_k$. Let

$$
R_k=\{x:n_k(x)\ne h_k(x)\}
$$

be the residual region. If $P_\star(R_k)>0$, then a strong agnostic target run
with $\varepsilon \ll P_\star(R_k)$ must learn something about the labels on
$R_k$; merely outputting the neutralizer loses too much.

Now consider the distribution-free source under the restricted marginal

$$
Q_k = P_\star(\cdot \mid R_k),
$$

with noiseless labels from $h_k$. Under $Q_k$, the neutralizer has error $1$.
Any public handle that was useful only because $R_k$ had small $P_\star$-mass is
also useless. Since $\operatorname{OPT}_{\mathcal C}=0$ on these labels, the
source learner must output some proper concept $c\in\mathcal C$ with

$$
\operatorname{err}_{Q_k}(c,h_k)\le 1/2-\gamma .
$$

Thus the wrapper has not avoided the hard comparator. It has pushed the required
weak learning task onto the residual restriction. If the residual labels are
PRF-like, LPN-like, or otherwise intended to be computationally opaque, this
weak learner is already a distinguisher. If the residual has a public decoder or
searchable handles, then the target can usually exploit the same structure.

This is the cleanest no-go statement I can justify:

> A public neutralizer can hide a hard comparator from the weak source only on
> marginals where the residual has small mass. Because the source is
> distribution-free, the learner may be tested on the residual marginal itself.
> Therefore the residual must either be weakly learnable by legal proper
> hypotheses, or the source fails.

That does not prove the edge true, because weak learnability of the residual may
still fail to boost strongly. But it shows that the public-neutralizer wrapper is
not an independent separation strategy. Any successful construction still needs
a residual class that already has the source behavior and fails the target.

### Why Sparse Lookup Makes The Target Easy

The one-way image-coordinate weak-handle construction illustrates the easy
case. Public bounded-subset handles give a proper weak agnostic learner, but the
hard region at each length has only polynomially many coordinates. Under the
fixed coordinate marginal, an improper learner can sample the relevant length
block and output a lookup table for the observed labels. The proper learner would
need to recover a seed/preimage, but the improper target has no such obligation.

More generally, if the residual region on which $h_k$ differs from its public
neutralizer is $P_\star$-sample-coverable in polynomial time, the target can:

1. use empirical heavy-point discovery to cover all but $\varepsilon$ residual
   mass;
2. estimate majority labels on the discovered points or cells;
3. splice this lookup table with the public neutralizer outside the discovered
   residual.

For the intended hard marginal, this gives an improper hypothesis with error
within $\operatorname{OPT}_{\mathcal C}+\varepsilon$ whenever the benchmark
advantage over the neutralizer is concentrated on sampled atoms or finitely many
public cells. This covers the existing sparse-handle and finite-active-slice
templates.

### Why Validation Over Public Handles Also Leaks Structure

Suppose instead that the residual is not pointwise memorizable, but the weak
source works because there is a public handle class $\mathcal N$ with a
polynomial-time search or empirical validation routine. Then under a fixed
marginal $P_\star$, the strong improper learner can enumerate or generate the
same public candidates, validate them on fresh data, and combine them with
lookup on heavy cells.

This does not automatically give a generic fixed-slack agnostic booster; that is
the global open problem. The narrower point is that public handles are not a
hard hidden comparator. If they are rich enough to find a constant-correlation
repair for arbitrary low-noise residual labels, then their empirical behavior is
visible to the target learner. If they are too large or unsearchable for the
target to validate, then they also do not certify the source unless there is a
separate public low-noise decoder.

The attempted counterexample therefore falls into a trilemma:

1. **Sparse residual:** the neutralizer is wrong only on a sample-coverable
   region; improper lookup learns it.
2. **Opaque residual:** the residual is large or diffuse enough to defeat
   lookup; the source fails on the marginal conditioned on that residual unless
   the residual class itself is weakly learnable.
3. **Searchable public handles:** the weak source uses handles that are visible
   enough for validation; this weakens the target obstruction and reduces the
   remaining issue to fixed-slack boosting over the handle/residual class.

### Failed Counterexample Sketch

I tried the following wrapper idea. Let $h_k=n_0\oplus r_k$, where $n_0$ is a
public neutralizer and $r_k$ is supported on a small hard subset $S_k$. The weak
learner outputs $n_0$ unless the marginal puts much mass on $S_k$, in which case
it uses local public handles. Under $P_\star$, strong learning with
$\varepsilon\ll P_\star(S_k)$ should require learning $r_k$.

The construction breaks in exactly the two expected ways. If $S_k$ has
polynomial sample cover under $P_\star$, an improper learner memorizes it. If
$S_k$ is diffuse enough to avoid memorization, then the source learner under the
conditional marginal $P_\star(\cdot\mid S_k)$ must weakly learn $r_k$ with
constant advantage. For a cryptographic $r_k$, this is the old PRF/noisy-parity
failure; for a public-decodable $r_k$, the witness has become the
weighted-decoding threshold primitive from Depth 2 rather than a
neutralizer-plus-hidden-comparator construction.

### Current State

This depth did not resolve the edge. It rules out, to my satisfaction, the
specific hope that a public neutralizer can make the source easy while a hidden
comparator independently blocks the strong improper target. The only way the
template can still work is if the residual comparator class already has the
desired combination: distribution-free fixed-slack proper weak agnostic learning
under every residual marginal, but fixed-marginal hardness of
$\operatorname{OPT}+\varepsilon$ improper prediction. That is precisely the
unresolved weighted-decoding/fixed-slack-boosting core, not a new reduction.

Promising next directions:

- Formalize the residual restriction obstruction as a reusable lemma for
  wrapper constructions: any disagreement region of positive hard-marginal mass
  becomes a legitimate source-test marginal.
- Search specifically for residual classes with arbitrary-weight
  bounded-distance proper weak decoding and high-noise improper prediction
  hardness.
- Separately investigate whether fixed-slack boosting becomes polynomial for
  public handle classes with empirical optimization, since that would turn the
  validation intuition above into a positive theorem for a broad subclass.

## Depth 5 Attempt: Reduction To Improper Source Edge

RESOLVED: no.

This attempt only checks whether the present edge

$$
\text{efficient-weak-agnostic-proper-pac}
\;\Rightarrow\;
\text{efficient-marginal-nonuniform-agnostic-improper-pac}
$$

reduces to the neighboring improper-source edge

$$
\text{efficient-weak-agnostic-improper-pac}
\;\Rightarrow\;
\text{efficient-marginal-nonuniform-agnostic-improper-pac}.
$$

Let $\mathsf{WP}(\mathcal C)$ denote the proper weak agnostic source property,
let $\mathsf{WI}(\mathcal C)$ denote the improper weak agnostic source property,
and let $\mathsf{MNAI}(\mathcal C)$ denote the marginal-nonuniform strong
agnostic improper target property. The atlas already has the monotone relaxation

$$
\mathsf{WP}(\mathcal C) \Rightarrow \mathsf{WI}(\mathcal C),
$$

because a proper weak learner outputs hypotheses in $\mathcal C$, and those are
also legal improper hypotheses with the same sample bound, runtime bound,
confidence behavior, and weak gap. No transformation of examples or hypotheses
is needed.

Therefore there is an exact one-line positive reduction:

1. Assume the improper-source edge is true, i.e. for every class $\mathcal C$,
   $\mathsf{WI}(\mathcal C) \Rightarrow \mathsf{MNAI}(\mathcal C)$.
2. Given a class $\mathcal C$ satisfying the present proper source
   $\mathsf{WP}(\mathcal C)$, view the same learner as an improper weak learner.
   Hence $\mathsf{WI}(\mathcal C)$.
3. Apply the assumed improper-source theorem to conclude
   $\mathsf{MNAI}(\mathcal C)$.

The target learner is exactly the one supplied by the improper-source theorem.
The reduction adds no samples, no runtime overhead, and no marginal dependence:
the per-marginal polynomial $p_P$ in the target is whatever the improper-source
theorem gives.

This is only a one-way reduction for positive results. It does not make the two
edges equivalent. If the present proper-source edge were false, the same witness
would also falsify the improper-source edge, because $\mathsf{WP}$ implies
$\mathsf{WI}$. But a counterexample to the improper-source edge need only have
an improper weak agnostic learner; it need not have any proper weak agnostic
learner. Without an additional properization lemma for the source learner, such
a witness cannot be copied back to this edge.

Conclusion: this edge is no harder than the improper-source edge on the positive
side. If the improper weak-agnostic-to-marginal-agnostic improper edge is later
proved true, this edge should be updated to true by composition with the
monotone relaxation. Since that neighboring edge is still open, and since a
false result for it would not automatically transfer, this reduction alone does
not change the atlas status of the present edge. It should remain open for now.

## Depth 6 Attempt: Neutralizer Residual Stress Test

RESOLVED: no.

This attempt tries to break the current conclusion by making the
public-neutralizer construction as adversarial as possible. The hoped-for
counterexample is a class $\mathcal C$ containing, for each hidden key $k$, a
comparator $h_k$ and a public proper neutralizer $n_k$. Under a fixed hard
marginal $P_\star$, $n_k$ is easy to find and gets weak agnostic error, but the
remaining excess

$$
R_k=\{x:n_k(x)\ne h_k(x)\}
$$

is meant to be hidden so thoroughly that no strong improper learner can recover
the residual correction. In the strongest version, the neutralizer "hides all
residuals": every polynomially visible reweighting of $P_\star$ still makes the
residual look either tiny, label-noisy, or pseudorandom.

### Stress Test 1: Arbitrary Source Marginals

The first obstruction survives the stronger hidden-residual story. The source
property is distribution-free, not tied to $P_\star$. If $P_\star(R_k)>0$, then
the conditional marginal

$$
Q_k = P_\star(\cdot \mid R_k)
$$

is a legal source-test marginal. With noiseless labels $Y=h_k(X)$ under $Q_k$,
the best proper error is $0$, so the source learner must output some proper
$c\in\mathcal C$ with

$$
\Pr_{Q_k}[c(X)\ne h_k(X)]\le 1/2-\gamma .
$$

This requirement does not care that $R_k$ is hidden from an algorithm that only
sees samples from $P_\star$. In the PAC quantifier order, the learner is simply
handed samples from $Q_k$. Thus a residual cannot be cryptographically opaque
under its own conditional marginal unless the source node already fails.

The attempted escape is to make every residual conditional weakly learnable by
some legal proper hypothesis while still hard to exploit from the original
marginal $P_\star$. That is coherent, but it is no longer a neutralizer-only
separation. It is exactly a residual class with distribution-free fixed-slack
proper weak agnostic learning and fixed-marginal strong improper hardness.

### Stress Test 2: Label-Dependent Reweighting

Could the counterexample say that $Q_k$ is irrelevant because the target learner
cannot sample it? This is the most serious version of the objection. The target
gets only labeled examples from $P_\star$, and if membership in $R_k$ is
label-dependent or hidden by noise, it may not be able to simulate
$P_\star(\cdot\mid R_k)$.

In the noiseless residual case, however, a found neutralizer leaks a rejection
sampler: points with $Y\ne n_k(X)$ are exactly the residual. Once $n_k$ is
validated, the target can collect residual samples at rate $P_\star(R_k)$ and
run the source learner or a validation routine on that slice. If
$P_\star(R_k)\ge \varepsilon$, the marginal-nonuniform target's polynomial in
$1/\varepsilon$ budget permits enough residual examples. If
$P_\star(R_k)<\varepsilon$, the neutralizer is already within $\varepsilon$ of
the comparator on that part.

With agnostic noise this clean rejection sampler becomes noisy: mistakes of
$n_k$ mix true residuals and ambient label noise. But then the construction has
shifted into the known fixed-slack boosting barrier. The source learner is only
guaranteed to help on reweighted distributions where the best proper error is
below the weak threshold. A target-side booster must find label-dependent tilts
that both expose the residual and keep the weak call nontrivial. I did not find
a way for the neutralizer itself to create a new lower-bound mechanism here.

### Stress Test 3: Validation Against Public Handles

Suppose the residual is not isolated by mistakes of one neutralizer, but the
source succeeds using a public family of handles $\mathcal N$. If the handle
family is polynomial-size, sample-coverable, or searchable by empirical
validation, the fixed marginal $P_\star$ gives the improper target the same
observable menu. It can validate neutralizers and handles on fresh samples,
combine the best few, and memorize heavy residual cells. This does not prove a
generic booster, but it prevents the handles from being an information-theoretic
secret.

If $\mathcal N$ is exponentially large and empirical optimization over it is
hard, then it no longer explains the source learner unless there is another
efficient procedure that finds a good proper handle under every low-noise
distribution. Under residual conditionals, that procedure is already a weak
decoder for the hidden comparator. Under $P_\star$, either that decoder can be
driven by validation/reweighting, or the remaining gap is again the
fixed-slack-to-strong boosting problem.

### Attempted Stronger Counterexample

The best adversarial template I can state is:

1. $n_k$ is public and near-optimal under $P_\star$ up to a fixed residual gap.
2. Residual membership is not marginally recognizable; it is visible only
   through labels and is corrupted enough that conditioning on $Y\ne n_k(X)$ is
   a noisy mixture.
3. For every residual or mixture marginal that can arise in the source
   guarantee, there is an efficient proper weak decoder in $\mathcal C$.
4. Nevertheless, under the original $P_\star$, no polynomial improper learner
   can combine these weak decoders into an $\operatorname{OPT}+\varepsilon$
   predictor.

This template is internally consistent, but it has abandoned the claim that the
neutralizer hides all residuals by itself. The decisive object is the residual
decoder family in item 3 plus the nonboostability claim in item 4. That is the
same weighted-decoding / fixed-slack agnostic boosting core identified in the
earlier depths.

### Conclusion

I could not break the current conclusion. A public neutralizer can hide residual
structure from a learner restricted to the original marginal, but the source
property permits arbitrary residual marginals, and validation makes any public
handle structure visible under the hard marginal. The remaining possible
counterexample would need residuals that are weakly decodable under every
source-test marginal while still not strongly learnable from $P_\star$ by any
improper polynomial-time learner. I do not know such an object, and the
neutralizer wrapper does not construct it.

Recent agnostic-boosting work remains consistent with this diagnosis: the known
positive algorithms give strong evidence for same-marginal boosting, but the
fully representation-uniform fixed-slack runtime needed by this atlas edge is
still the missing quantitative step.

## Depth 7 Attempt: Atlas-Ready Marginal Proper Reduction

RESOLVED: no for the original edge.

This final theorem-check pass asks whether the edge

$$
\text{efficient-weak-agnostic-proper-pac}
\Rightarrow
\text{efficient-marginal-nonuniform-agnostic-improper-pac}
$$

should be documented as a one-way reduction to the neighboring improper-source
edge

$$
\text{efficient-weak-agnostic-improper-pac}
\Rightarrow
\text{efficient-marginal-nonuniform-agnostic-improper-pac}.
$$

Yes: that is the clean atlas-ready relationship. The reduction is just the
monotone relaxation

$$
\text{efficient-weak-agnostic-proper-pac}
\Rightarrow
\text{efficient-weak-agnostic-improper-pac},
$$

followed by the improper-source-to-marginal theorem, if that theorem is ever
proved. A proper weak agnostic learner outputs hypotheses in $\mathcal C$; the
improper weak agnostic model permits those same hypotheses, with exactly the
same samples, runtime, confidence parameter, and weak additive tolerance. This
argument is insensitive to whether the atlas phrases the weak gap as a fixed
constant slack or as an inverse-polynomial parameter: whatever weak guarantee
the proper learner has is inherited unchanged by the improper weak learner.

### Atlas-Ready Wording

Suggested replacement/augmentation for the proof-status text:

> This edge reduces on the positive side to the neighboring improper-source
> edge. Indeed, a proper weak agnostic learner is already an improper weak
> agnostic learner, since the improper model only relaxes the output
> constraint. Therefore any theorem proving
> [[efficient-weak-agnostic-improper-pac|Efficient Weak Agnostic Improper PAC
> Learning]] implies
> [[efficient-marginal-nonuniform-agnostic-improper-pac|Efficient
> Marginal-Nonuniform Agnostic Improper PAC Learning]] immediately proves this
> edge by composition with the monotone relaxation
> [[efficient-weak-agnostic-proper-pac|Efficient Weak Agnostic Proper PAC
> Learning]] $\Rightarrow$
> [[efficient-weak-agnostic-improper-pac|Efficient Weak Agnostic Improper PAC
> Learning]].
>
> The reduction is one-way. A counterexample to the improper-source edge need
> not satisfy the proper weak agnostic source condition, so it would not
> automatically refute this edge. Conversely, any counterexample to this edge
> would also refute the improper-source edge, because the proper source already
> implies the improper source. Thus no separate proper-output obstruction is
> currently known; the live obstruction is the same fixed-additive weak-to-strong
> agnostic boosting problem tracked by the improper-source edge.

Suggested summary wording:

> Open. This edge is no harder than the corresponding improper-source edge on
> the positive side: proper weak agnostic learning immediately relaxes to
> improper weak agnostic learning. The reduction is not an equivalence, because
> an improper-source counterexample may fail to have a proper weak learner. No
> proper-specific separation is known; the remaining obstruction is the same
> fully polynomial fixed-additive agnostic boosting problem as in the
> improper-source-to-marginal edge.

### Theorem-Check Notes

The quantifiers line up without extra bookkeeping. The source learner is
distribution-free, so viewing its proper output as an improper output does not
introduce any marginal dependence. If the improper-source theorem supplies a
single marginal-nonuniform target learner with a $P$-dependent polynomial
$p_P$, the composed proof uses that same target learner and the same polynomial
$p_P$. There is no additional dependence on the proper source learner beyond
establishing that the class lies in the improper weak source node.

The negative-transfer direction is exactly where care is needed. A false result
for the neighboring improper-source edge would produce a class with an improper
weak agnostic learner and no marginal-nonuniform strong agnostic improper
learner. Such a class may rely essentially on improper weak hypotheses, so it
does not necessarily satisfy the present proper-source premise. To transfer a
negative result back to this edge, one would need either the same witness to
have a proper weak agnostic learner or an independent properization lemma for
the source learner.

I therefore would not mark the original edge true or false from this pass. The
right atlas action, if editing were allowed, would be to keep `status: "open"`
and explicitly record the positive reduction to the improper-source edge plus
the absence of any known proper-specific separation.

## Depth 8 Final Incorporation Recommendation

RESOLVED: no.

The edge should remain `open`. The depth-8 tree did not produce either a fully
polynomial fixed-slack agnostic booster or an atlas-valid false witness with a
distribution-free proper weak agnostic source and one fixed-marginal improper
strong-learning obstruction.

### Exact Suggested Atlas Frontmatter Updates

If atlas editing is allowed later, update only the present edge note

`atlas/implications/efficient-weak-agnostic-proper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac.md`

as follows.

Keep:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: agnostic-boosting-open
argument_note: "[[agnostic-boosting-open|Agnostic Boosting Open]]"
```

Replace the current `summary` with:

```yaml
summary: "Open. This edge has a one-way positive reduction to the improper-source marginal edge, because a proper weak agnostic learner is automatically an improper weak agnostic learner. The reduction is not an equivalence: an improper-source counterexample need not have proper weak hypotheses. PRF/handle and public-neutralizer wrappers did not yield an atlas-valid separation; the remaining obstruction is still the fully polynomial fixed-additive agnostic boosting or threshold-decoding problem."
```

Recommended `ref_keys`:

```yaml
ref_keys:
  - bendavid2001
  - feldman2010distributionspecific
  - kalai2008agnosticboosting
  - ghai2025agnosticboosting
  - dacunha2026agnosticboosting
  - kearns1994cryptographic
  - goldreich1986
  - hastad1999prg
```

Recommended `refs`:

```yaml
refs:
  - "[Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)"
  - "[Feldman 2010](https://arxiv.org/abs/0909.2927)"
  - "[Kalai, Mansour, and Verbin 2008](https://doi.org/10.1145/1374376.1374466)"
  - "[Ghai and Singh 2025](https://proceedings.mlr.press/v267/ghai25a.html)"
  - "[da Cunha et al. 2026](https://arxiv.org/abs/2601.11265)"
  - "[Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)"
  - "[Goldreich, Goldwasser, and Micali 1986](https://doi.org/10.1145/6490.6503)"
  - "[Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)"
```

Rationale for refs:

- Keep `bendavid2001`, `feldman2010distributionspecific`,
  `ghai2025agnosticboosting`, and `dacunha2026agnosticboosting` as the core
  agnostic-boosting references.
- Add `kalai2008agnosticboosting` because the nearest parity/LPN and
  fixed-slack boosting discussions belong to that neighborhood.
- Add `kearns1994cryptographic`, `goldreich1986`, and `hastad1999prg` only if
  the body includes the PRF/handle no-go paragraph below. These are background
  for the failed cryptographic route, not evidence for a separation.

### Exact Suggested Body Updates

Keep the verdict as:

```markdown
`open`.

Open. The source is distribution-free, and proper weak hypotheses are already
legal improper weak hypotheses. Thus this edge is no harder, on the positive
side, than the neighboring improper-source marginal edge. The current obstacle
is still fixed-additive weak-to-strong agnostic boosting, not a marginal-change
or proper-output issue.
```

Add this paragraph near the start of `## Proof Status`, after the goal:

```markdown
**Reduction to the improper-source marginal edge.** There is a one-way positive
reduction
[[efficient-weak-agnostic-proper-pac|Efficient Weak Agnostic Proper PAC
Learning]] $\Rightarrow$
[[efficient-weak-agnostic-improper-pac|Efficient Weak Agnostic Improper PAC
Learning]] by simply viewing the proper output as an allowed improper output.
Therefore any proof of
[[efficient-weak-agnostic-improper-pac|Efficient Weak Agnostic Improper PAC
Learning]] $\Rightarrow$
[[efficient-marginal-nonuniform-agnostic-improper-pac|Efficient
Marginal-Nonuniform Agnostic Improper PAC Learning]] would prove this edge by
composition. The reduction is not an equivalence: a counterexample to the
improper-source edge may rely essentially on improper weak hypotheses and need
not satisfy the present proper-source premise.
```

Replace or augment the current negative-evidence paragraph with:

```markdown
**Failed separation routes.** The most direct cryptographic templates do not
settle the edge. Plain PRF-style witnesses fail the source: if the hard
concepts themselves are pseudorandom, then a distribution-free proper
fixed-slack weak agnostic learner gives a fresh-validation distinguisher
between PRF-labeled examples and random labels. Public handle variants also do
not by themselves work. Handles off the hard marginal do not help the source on
the restricted hard marginal; constant-correlation handles on the hard marginal
again distinguish pseudorandom labels; and searchable public handles tend to
make the marginal-nonuniform improper target learnable by validation, lookup,
or aggregation.

Public neutralizer wrappers face the same residual obstruction. If a public
neutralizer disagrees with a hidden comparator on a residual set of positive
hard-marginal mass, the residual conditional distribution is a legal source
marginal. The source learner must therefore weakly decode the residual under
that conditional distribution. If the residual is sample-coverable, the improper
target can memorize it; if it is diffuse or cryptographic, the source itself
needs a separate low-noise decoder. Thus the neutralizer construction reduces
back to the unresolved fixed-slack boosting or threshold-decoding core rather
than giving an independent false witness.
```

Replace `What would resolve the edge` with:

```markdown
**What would resolve the edge.** A true proof would follow from a fully
polynomial fixed-additive agnostic booster for distribution-free weak agnostic
learners, with runtime polynomial in the representation size, weak learner
sample/time bounds, and accuracy parameters rather than exponential in
clean-witness or capacity parameters. A false proof would need a class with
distribution-free proper fixed-slack weak agnostic learning, but one fixed
marginal under which even improper $\operatorname{OPT}+\varepsilon$ prediction
is computationally hard. The plausible false-witness shape is a public
threshold-decoding primitive: arbitrary-weight low-noise proper weak decoding
is easy below the source threshold, while high-accuracy fixed-marginal improper
prediction remains hard. No standard PRF, public-handle, neutralizer, parity,
or code template currently satisfies all of these quantifiers.
```

### Final Recommendation

Do not mark the edge true or false. Incorporate the reduction to the
improper-source marginal edge and the failed-route diagnostics, but keep the
status open with no assumptions and no witnesses. The note should make clear
that any future proof of the improper-source marginal edge immediately proves
this edge, while any future false result must either directly satisfy the
proper-source premise or include a separate properization argument.

## Depth 9 Attempt: Final Proper-To-Marginal Boosting Search

RESOLVED: no.

I do not have a source-grounded theorem or separation that resolves the edge
under the fixed-constant additive weak-agnostic reading used by the accepted
depth-1 audit and the later scratchpad tree. The right atlas status remains
`open`. The final useful outcome of this pass is a sharper warning: the edge
file currently mixes two readings of the weak gap. If the source is read
literally as allowing an inverse-polynomial gap $\gamma(s)$, then the edge is
very likely already conditionally false by standard low-noise robustification
plus existing agnostic-hardness witnesses. If the source is read as the
constant-gap Ben-David--Long--Mansour $\beta$-weak agnostic notion, the previous
open verdict is still the honest one.

### Primary-Source Check

Ben-David--Long--Mansour define the relevant $\beta$-weak agnostic learner as
one that outputs $h$ with error at most $\operatorname{er}_P(F)+\beta$, where
$\beta<1/2$. Their boosting theorem does not give the target conclusion
$\operatorname{OPT}+\varepsilon$; the advertised guarantee is of the form
$$
\operatorname{err}(H)\le
\max\{c_1(\beta)\operatorname{er}(F)^{c_2(\beta)},\varepsilon\}.
$$
This is exactly why the original agnostic-boosting theorem is a near miss
rather than a proof of this edge.

Feldman's distribution-specific agnostic boosting is also close but not enough
for this source. It preserves the instance marginal by modifying labels rather
than reweighting instances, which is ideal for marginal-nonuniform targets, but
it assumes a weak agnostic oracle strong enough to drive same-marginal boosting.
The atlas source only promises the fixed floor
$\operatorname{OPT}+1/2-\gamma$, so a label-modified weak call may be completely
uninformative unless the modified problem has very low optimum error.

The recent Ghai--Singh and da Cunha--Hogsgaard--Paudice papers strengthen the
positive evidence, but still do not close the atlas edge. Ghai--Singh give a
computationally efficient agnostic booster with sample-optimal behavior using
unlabeled data, but it is stated for the usual agnostic weak-learning oracle,
not for the atlas's weaker fixed-additive oracle. Da Cunha--Hogsgaard--Paudice
explicitly improve the running-time side of sample-near-optimal agnostic
boosting, but the arXiv abstract says the running time is polynomial in the
sample size when the other parameters are fixed. That is not a representation-
uniform polynomial in all atlas parameters.

### Positive Search

Properness gives no extra obstacle on the positive side. A proper weak learner
is already an improper weak learner, and the target is improper, so a booster is
free to output votes, randomized-looking aggregates, or any binary predictor
built from proper weak hypotheses. Therefore a proof of the neighboring edge
$$
\text{efficient-weak-agnostic-improper-pac}
\Rightarrow
\text{efficient-marginal-nonuniform-agnostic-improper-pac}
$$
would prove this edge verbatim.

I tried to find a proper-specific improvement over that reduction, but the same
low-OPT forcing barrier remains. Standard agnostic boosting wants to call the
weak learner on distributions or relabelings where failure of the current
aggregate creates a useful weak hypothesis. With only
$\operatorname{OPT}+\beta$ for fixed $\beta<1/2$, a weak call is forced to beat
random guessing only when the induced problem has optimum error below
$1/2-\beta$. I do not see a source-grounded way to manufacture such low-noise
weak calls from an arbitrary medium-noise agnostic target without already
knowing a correlated comparator.

### Negative Search

The tempting inverse-polynomial witnesses remain model-boundary examples, not
accepted fixed-constant-gap separations. Affine parities under constant-noise
decision-LPN would satisfy an inverse-polynomial weak agnostic proper source by
clean-batch Gaussian elimination: constants handle
$\operatorname{OPT}\ge \gamma(n)$, and when
$\operatorname{OPT}<\gamma(n)$ a clean basis-sized batch occurs with polynomial
probability for $\gamma(n)=1/\operatorname{poly}(n)$. Strong improper agnostic
learning under the uniform marginal would distinguish noisy parity labels from
random labels by fresh validation.

Halfspaces show the same ambiguity even more sharply. They are efficiently
realizably properly learnable, and the low-noise robustification argument gives
an inverse-polynomial weak agnostic proper learner if that is all the source
requires. Tiegel's COLT 2023 result gives distribution-specific hardness for
improper agnostic halfspace learning under the standard Gaussian marginal, and
his distribution-independent hard instances have $\operatorname{OPT}$ as small
as $\exp(-\Omega(\log^{1-c}d))$, which blocks a fixed constant gap but not an
inverse-polynomial-gap robustification where constants are already legal in the
larger-OPT regime.

Those examples are not a resolution under the current depth tree because the
accepted convention for this edge is a fixed constant additive tolerance. Under
that convention, parity/LPN and halfspaces fail the source: low-noise
robustification cannot handle constant classification noise, and a constant-gap
weak learner on the hard marginal would itself give the relevant distinguisher
or contradict the halfspace lower bound.

The remaining false-witness families still miss one of the quantifiers. PRF
classes fail the low-noise source by fresh validation. Public handles and
neutralizers are either avoidable by source marginals, visible enough for an
improper target to validate or memorize, or they reduce back to the same
threshold-decoding problem. Fixed-$k$-term DNF gives proper weak-to-strong
hardness, but only for proper strong output; I did not find a primary-source
hardness statement ruling out the marginal-nonuniform improper agnostic target.
One-way image-coordinate handles likewise obstruct proper recovery, while the
improper target can use lookup or sparse ERM on the fixed coordinate block.

### Atlas-Relevant Obstacles And Directions

1. **Clarify the weak-gap convention.** The edge theorem statement says
   "inverse-polynomial weak gap $\gamma(s)$", while the proof status and the
   accepted scratchpad audit reason about a fixed constant gap. This should be
   resolved before the atlas treats this edge as stable. If inverse-polynomial
   gaps are allowed, then the halfspace or affine-parity route should be
   re-opened as a conditional `false` update. If fixed constant $\beta<1/2$ is
   intended, remove or rewrite the inverse-polynomial wording in the edge body.

2. **Positive route.** Prove a fully polynomial fixed-$\beta$ agnostic booster:
   runtime polynomial in representation size, weak-learner resources,
   $1/\varepsilon$, and $\log(1/\delta)$, not merely polynomial for fixed
   capacity or weak-sample parameters. It must convert the Ben-David--style
   $\operatorname{OPT}+\beta$ oracle into an additive
   $\operatorname{OPT}+\varepsilon$ learner.

3. **Negative route.** Find a constant-noise threshold-decoding primitive:
   distribution-free, arbitrary-weight, proper weak decoding below a fixed
   constant noise radius, but one fixed marginal under which
   $\operatorname{OPT}+\varepsilon$ prediction is hard even for arbitrary
   improper binary hypotheses. Standard PRF, parity/LPN, halfspace, sparse
   handle, one-way coordinate, and fixed-$k$ DNF templates do not currently
   instantiate all of these requirements.

### Proposed Atlas Updates If Editing Later

Keep the edge status open under the fixed-constant-gap reading:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
summary: "Open under the fixed-constant additive weak-agnostic reading. Proper weak hypotheses relax immediately to improper weak hypotheses, so any proof of the improper-source marginal edge proves this edge. Existing agnostic boosters do not turn the Ben-David-style OPT+beta oracle into an OPT+epsilon learner with fully polynomial atlas resources, and no standard PRF, parity, halfspace, handle, one-way-coordinate, or fixed-k-DNF template gives a constant-gap proper-source/improper-target separation."
```

Add a body warning:

```markdown
**Weak-gap convention.** This note treats the source as a fixed constant
additive weak-agnostic guarantee. If the node is instead interpreted as allowing
an inverse-polynomial gap depending on representation size, then low-noise
robustification reopens conditional separations such as halfspaces under
Tiegel's worst-case lattice hardness or affine parities under constant-noise
decision-LPN. The edge status should not be migrated without first fixing this
convention.
```

No atlas file should be marked true or false from this depth-9 pass alone.
