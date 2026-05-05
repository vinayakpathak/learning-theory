# Open Edge Resolution Scratchpad

Edge: `efficient-marginal-nonuniform-agnostic-improper-pac -> efficient-marginal-nonuniform-realizable-proper-pac`

## Research Log

## Sources Checked

## Proof Or Counterexample Attempts

## Verdict

## Follow-Up Directions

## Depth-1 Entry - 2026-05-05

### Verdict

Resolved as `false`, conditionally.

Assuming length-preserving one-way functions exist, the implication

$$
\texttt{efficient-marginal-nonuniform-agnostic-improper-pac}
\;\Rightarrow\;
\texttt{efficient-marginal-nonuniform-realizable-proper-pac}
$$

fails. The witness is the one-way image-coordinate class, with a strengthened source-side proof: the class is not merely realizably improperly learnable; it is efficiently distribution-free agnostically learnable by an improper sparse lookup-table ERM. The same fixed-marginal proper-learning reduction then inverts the one-way function.

### Definitions Used

- Source: `efficient-marginal-nonuniform-agnostic-improper-pac`. One uniform learner works for all joint distributions; for each fixed marginal $P$, sample complexity and runtime may be bounded by a polynomial $p_P(s,1/\varepsilon,\log(1/\delta))$. The learner may output a hypothesis outside $\mathcal C$ and must achieve excess error at most $\varepsilon$ over the best concept in $\mathcal C$.
- Target: `efficient-marginal-nonuniform-realizable-proper-pac`. For each fixed marginal $P$ and every realizable target $c\in\mathcal C$, one uniform learner must output $h\in\mathcal C$ with error at most $\varepsilon$ in marginal-dependent polynomial sample complexity and runtime.
- Proper representation convention for the witness: a proper hypothesis is a seed $t$, and evaluating it computes the coordinate labels induced by $f(t)$. A sparse lookup table over domain atoms is allowed for the improper source, but is not a proper hypothesis.
- Cryptographic assumption: there is a polynomial-time computable length-preserving one-way function $f:\{0,1\}^n\to\{0,1\}^n$. Injectivity is unnecessary; inversion means finding any $t$ with $f(t)=f(s)$ for a random image.

### Sources Checked

- Local atlas definitions:
  - `atlas/definitions/efficient-marginal-nonuniform-agnostic-improper-pac.md`
  - `atlas/definitions/efficient-marginal-nonuniform-realizable-proper-pac.md`
- Local implication, argument, and witness notes:
  - `atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`
  - `atlas/implications/efficient-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`
  - `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`
  - `atlas/arguments/properization-open.md`
  - `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
  - `atlas/witnesses/one-way-image-coordinate-class.md`
  - `atlas/arguments/clause-satisfaction-proper-hardness.md`
  - `atlas/witnesses/clause-satisfaction-lookup-class.md`
  - `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
  - `atlas/witnesses/pcp-active-slice-lookup-class.md`
  - `atlas/arguments/sample-complexity-equivalence.md`
- Nearby scratchpads:
  - `scratchpads/open-edge-resolution-2026-05-04/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac/scratchpad.md`
  - `scratchpads/open-edge-resolution-2026-05-04/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-proper-pac/scratchpad.md`
- Primary source anchors:
  - Benedek and Itai, fixed-distribution learning, ScienceDirect: https://www.sciencedirect.com/science/article/pii/030439759190026X.
  - Ben-David, Benedek, and Mansour, PAC uniformity parameterization, DOI: https://doi.org/10.1006/inco.1995.1094.
  - Hanneke, Moran, and Thiessen, marginal-nonuniform PAC learnability, OpenReview: https://openreview.net/forum?id=aoVCFtox89.
  - Blumer, Ehrenfeucht, Haussler, and Warmuth, VC/agnostic finite-class learnability background, DOI: https://doi.org/10.1145/76359.76371.
  - Kearns and Valiant, cryptographic learning lower bounds, DOI: https://doi.org/10.1145/174644.174647 and PDF: https://www.cis.upenn.edu/~mkearns/papers/cryptojacm.pdf.
  - Håstad, Impagliazzo, Levin, and Luby, one-way functions and pseudorandomness, DOI: https://doi.org/10.1137/S0097539793244708.

### Theorem Route

A positive theorem would need to convert an efficient agnostic improper learner into an efficient realizable proper learner under the same marginal-nonuniform runtime convention. The sample-only route is clear: once runtime is ignored, ERM over $\mathcal C$ handles proper realizable learning. But the target is computational, and the source gives no projection oracle from an arbitrary low-error external classifier back into the represented class.

The one-way image-coordinate class blocks such a theorem. It makes prediction easy because the labels reveal image coordinates, but makes proper representation recovery cryptographically hard under a single fixed marginal. Therefore no generic computational properization theorem can hold under the stated assumption.

### Counterexample Route

Let $f:\{0,1\}^n\to\{0,1\}^n$ be a length-preserving one-way function. The instance space is

$$
X=\{(1^k,i,b): k\ge 1,\; i\in[k],\; b\in\{0,1\}\}.
$$

For each seed $s\in\{0,1\}^n$, let $y=f(s)$ and define

$$
c_s(1^k,i,b)=1
\quad\Longleftrightarrow\quad
k=n \text{ and } b=y_i .
$$

The represented class is $\mathcal C=\{c_s:s\in\{0,1\}^*\}$, with proper hypotheses represented by seeds.

**Why the source holds.** For size parameter $s=n$, every proper concept of length at most $n$ has at most $n$ positive atoms. Let $\mathcal S_n$ be the improper class of all classifiers whose positive set has size at most $n$. Then $\mathcal C_{\le n}\subseteq \mathcal S_n$, and $\operatorname{VCdim}(\mathcal S_n)=n$: it shatters any $n$ distinct atoms and cannot shatter $n+1$ atoms because it cannot label all $n+1$ as positive.

ERM over $\mathcal S_n$ is polynomial-time on a sample. For each distinct sampled atom $x$, compute the empirical benefit of predicting $1$ rather than $0$ at $x$, namely the number of sampled positive labels at $x$ minus the number of sampled negative labels at $x$. Choose the at most $n$ atoms with positive largest benefits and predict $1$ exactly there, predicting $0$ elsewhere. This is an empirical risk minimizer over $\mathcal S_n$.

Standard VC uniform convergence for binary classification gives an agnostic excess-error bound for $\mathcal S_n$ with sample complexity polynomial in

$$
n,\; 1/\varepsilon,\; \log(1/\delta).
$$

Since $\mathcal S_n$ contains the proper concepts of size at most $n$, the ERM output has true error at most

$$
\inf_{c\in\mathcal C_{\le n}}\operatorname{err}(c)+\varepsilon
$$

with high probability. The hypothesis is an improper sparse lookup table and its construction is polynomial-time. This is efficient distribution-free agnostic improper learning, hence it implies the marginal-nonuniform agnostic improper source.

**Why the target fails.** Fix one marginal $P$ once and for all: choose $k$ with mass

$$
\mu_k=\frac{6}{\pi^2 k^2},
$$

then choose $i\in[k]$ and $b\in\{0,1\}$ uniformly. For a target seed $s\in\{0,1\}^n$, set

$$
\varepsilon_n=\frac{\mu_n}{3n}.
$$

Because $\mu_n=\Theta(1/n^2)$, the quantity $1/\varepsilon_n$ is polynomial in $n$.

If a proper hypothesis $c_t$ has $P$-error at most $\varepsilon_n$ against $c_s$, then $|t|=n$ and $f(t)=f(s)$. If $|t|\ne n$, then $c_t$ is identically $0$ on the length-$n$ block, while $c_s$ has one positive bit-point for every coordinate; this contributes error $\mu_n/2>\varepsilon_n$. If $|t|=n$ but $f(t)$ differs from $f(s)$ in any coordinate, the two bit-points for that coordinate disagree, contributing $\mu_n/n>\varepsilon_n$.

Now suppose the target node held for this class. Given a one-way challenge $y=f(s)$ for unknown random $s\in\{0,1\}^n$, simulate labeled examples from the fixed marginal $P$ by labeling

$$
(1^k,i,b)\mapsto 1
\quad\Longleftrightarrow\quad
k=n \text{ and } b=y_i .
$$

This simulation uses the image $y$, not a preimage. Run the assumed marginal-nonuniform proper learner with accuracy $\varepsilon_n$ and constant confidence. Since the marginal $P$ is fixed, the target gives a fixed polynomial $p_P$, so the runtime is polynomial in $n$ because $1/\varepsilon_n=\operatorname{poly}(n)$. With the learner's success probability, it outputs a seed $t$ satisfying $f(t)=y$. This is a probabilistic polynomial-time inverter with nonnegligible, indeed constant, success probability, contradicting one-wayness.

### Concrete Obstruction

The obstruction is not sample complexity and not agnostic noise. The source can be satisfied by moving to a slightly larger improper sparse class and doing efficient ERM. The obstruction is proper representation recovery: accurate prediction under the fixed marginal forces exact recovery of all $n$ image coordinates, and a proper representation of those coordinates is exactly a seed preimage.

This also explains why the clause-satisfaction fixed-marginal fair-coin trick does not directly settle this edge. That construction is excellent for agnostic proper targets, but the present target is realizable proper, so the noisy non-formula region is unavailable. The one-way image-coordinate witness keeps the target distribution realizable while preserving a fixed marginal.

### Atlas-Ready Counterexample And Metadata Changes

If atlas edits are later allowed, update

`atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`

as follows:

- `status: "false"`
- `evidence: conditional-counterexample`
- `assumptions: ["length-preserving one-way functions exist"]`
- `witnesses: ["one-way-image-coordinate-class"]`
- `ref_keys: ["blumer1989", "kearns1994cryptographic", "hastad1999prg"]`
- `refs:` should include `[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)`, `[Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)`, and `[Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)`.
- `summary: "False under one-way functions: image-coordinate concepts are efficiently agnostically learnable by improper sparse ERM, but fixed-marginal realizable proper learning would invert the one-way function."`
- `family: one-way-image-coordinate-proper-hardness`
- `argument_note: "[[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]]"`
- `witness_note: "[[one-way-image-coordinate-class|One-Way Image Coordinate Class]]"`

Atlas-ready proof body:

Use the one-way image-coordinate class. For the source, enlarge the hypothesis space to all lookup tables with at most $n$ positive atoms. This improper class has VC dimension $n$ and contains all proper concepts represented by seeds of length at most $n$. ERM over it is efficient: on a sample, compute each atom's empirical benefit for predicting $1$ rather than $0$, keep the at most $n$ positive-benefit atoms with largest benefits, and predict $0$ elsewhere. VC uniform convergence gives efficient distribution-free agnostic improper learning, hence the marginal-nonuniform agnostic improper source.

For the target failure, fix $P$ with block masses $\mu_k=6/(\pi^2k^2)$ and run the assumed proper learner at $\varepsilon_n=\mu_n/(3n)$. Any proper hypothesis within this error of target $c_s$ must have the same length and image as $s$. Given a one-way challenge $y=f(s)$, simulate realizable labels under the fixed marginal by using the image bits of $y$. The proper learner returns a seed $t$ with $f(t)=y$ in polynomial time, contradicting the existence of a length-preserving one-way function.

### Promising Next Directions

- Update the atlas edge and, ideally, strengthen `atlas/arguments/one-way-image-coordinate-proper-hardness.md` to record the sparse-ERM agnostic-improper source proof, not only the realizable memorization proof.
- Recheck sibling edges whose source is strong or weak agnostic improper and whose target is marginal-nonuniform realizable proper. The same witness should apply whenever the source accepts distribution-free agnostic improper learning and the target requires strong enough proper realizable accuracy under a fixed marginal.
- Keep the clause-satisfaction lookup witness for agnostic proper targets; keep the one-way image-coordinate witness for realizable proper targets where the fixed-marginal reduction must remain realizable.
