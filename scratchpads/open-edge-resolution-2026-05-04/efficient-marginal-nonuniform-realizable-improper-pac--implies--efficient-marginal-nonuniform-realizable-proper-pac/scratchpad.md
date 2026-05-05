# Open Edge Resolution Scratchpad

Edge: `efficient-marginal-nonuniform-realizable-improper-pac -> efficient-marginal-nonuniform-realizable-proper-pac`

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
\texttt{efficient-marginal-nonuniform-realizable-improper-pac}
\;\Rightarrow\;
\texttt{efficient-marginal-nonuniform-realizable-proper-pac}
$$

fails. The witness is the one-way image-coordinate class: labels reveal the image $f(s)$ one coordinate at a time, so improper prediction is easy by memorization, but any sufficiently accurate proper hypothesis under one fixed marginal must output a seed $t$ with $f(t)=f(s)$ and therefore invert the one-way function.

This is stronger than the local source requires. The witness is efficiently distribution-free realizably learnable with improper hypotheses, hence it also satisfies the marginal-nonuniform improper source.

### Definitions Used

- Source: `efficient-marginal-nonuniform-realizable-improper-pac`. One uniform learner works for all marginals $P$; for each fixed $P$, sample complexity and runtime are bounded by a polynomial $p_P(s,1/\varepsilon,\log(1/\delta))$. The output may lie outside $\mathcal C$.
- Target: `efficient-marginal-nonuniform-realizable-proper-pac`. The same marginal-dependent polynomial guarantee is required, but the learner must output $h\in\mathcal C$.
- Properness convention for the witness: a proper hypothesis is represented by a seed $t$, and evaluation computes the coordinate labels induced by $f(t)$. Thus a proper learner must output a valid seed, not merely a table of observed image bits.
- Cryptographic assumption: there is a polynomial-time computable length-preserving one-way function $f:\{0,1\}^n\to\{0,1\}^n$, hard to invert with nonnegligible probability over uniform $s\in\{0,1\}^n$. Injectivity is not needed; inversion means finding any $t$ with $f(t)=f(s)$.

### Sources Checked

- Local atlas definitions:
  - `atlas/definitions/efficient-marginal-nonuniform-realizable-improper-pac.md`
  - `atlas/definitions/efficient-marginal-nonuniform-realizable-proper-pac.md`
  - `atlas/definitions/efficient-realizable-improper-pac.md`
- Local edge, argument, and witness notes:
  - `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`
  - `atlas/implications/efficient-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`
  - `atlas/arguments/properization-open.md`
  - `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
  - `atlas/witnesses/one-way-image-coordinate-class.md`
  - `atlas/arguments/clause-satisfaction-proper-hardness.md`
  - `atlas/witnesses/clause-satisfaction-lookup-class.md`
  - `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
  - `atlas/witnesses/pcp-active-slice-lookup-class.md`
  - `atlas/arguments/fixed-k-term-dnf-proper-boosting-separation.md`
  - `atlas/witnesses/fixed-k-term-DNF.md`
  - `atlas/registry/edge_families.yml`
- Primary source anchors:
  - Benedek and Itai, "Learnability with respect to fixed distributions" (1991), DOI page: https://www.sciencedirect.com/science/article/pii/030439759190026X. Used for the fixed-distribution background and the distinction between distribution-sensitive sample rates and computation.
  - Ben-David, Benedek, and Mansour, "A Parameterization Scheme for Classifying Models of PAC Learnability" (1995), DOI: https://doi.org/10.1006/inco.1995.1094. Used for the uniformity-parameter viewpoint.
  - Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability" (NeurIPS 2025), OpenReview: https://openreview.net/forum?id=aoVCFtox89. Used for the modern marginal-nonuniform convention: rates may depend on the marginal but the learner remains uniform over targets.
  - Kearns and Valiant, "Cryptographic Limitations on Learning Boolean Formulae and Finite Automata" (JACM 1994), DOI: https://doi.org/10.1145/174644.174647 and PDF: https://www.cis.upenn.edu/~mkearns/papers/cryptojacm.pdf. Used as the learning-theoretic cryptographic hardness anchor.
  - Håstad, Impagliazzo, Levin, and Luby, "A Pseudorandom Generator from any One-Way Function" (SIAM J. Comput. 1999), DOI: https://doi.org/10.1137/S0097539793244708 and PDF: https://www.cs.bu.edu/fac/lnd/pdf/hill.pdf. Used for the standardness of one-way functions as a cryptographic assumption.
  - Goldreich and Levin, "A Hard-Core Predicate for all One-Way Functions" (STOC 1989), PDF: https://www.cs.bu.edu/fac/lnd/pdf/hard.pdf. Checked as an additional one-way-function reference.
  - Pitt and Valiant, "Computational Limitations on Learning from Examples" (JACM 1988), PDF mirror: https://www.cis.upenn.edu/~danroth/Teaching/CS446-17/Papers/p965-pitt.pdf, and Khot and Saket, "Hardness of Minimizing and Learning DNF Expressions" (FOCS 2008), PDF: https://cs.nyu.edu/~khot/papers/minDNF.pdf. Checked as natural but ultimately less sharp properization witnesses for this marginal-nonuniform edge.

### Theorem Route

A positive theorem would need a generic computational properization principle:

$$
\text{efficient marginal-nonuniform improper realizable learning}
\Longrightarrow
\text{efficient marginal-nonuniform proper realizable learning}.
$$

The checked fixed-distribution and marginal-nonuniform sources support information-theoretic cover/rate statements, not a polynomial-time projection from an external classifier back into the represented class. Unbounded ERM over $\mathcal C$ would be enough for sample-only proper learning, but the target is computational.

The one-way image-coordinate witness rules out such a generic theorem under the one-way-function assumption. Even under a simple computable discrete marginal, an accurate proper projection would recover a seed preimage, while the improper learner only needs to predict visible positive atoms.

### Counterexample Route

Let $f:\{0,1\}^n\to\{0,1\}^n$ be a length-preserving one-way function. Define the instance space

$$
X=\{(1^k,i,b): k\ge 1,\; i\in[k],\; b\in\{0,1\}\}.
$$

For each seed $s\in\{0,1\}^n$, let $y=f(s)$ and define a concept $c_s$ by

$$
c_s(1^k,i,b)=1
\quad\Longleftrightarrow\quad
k=n \text{ and } b=y_i .
$$

Thus the length-$n$ block has exactly one positive point per coordinate $i$, namely the bit value equal to the $i$th bit of $f(s)$; all other length blocks are negative. The represented class is

$$
\mathcal C=\{c_s:s\in\{0,1\}^*\},
$$

with proper representation given by the seed $s$.

**Why the source holds.** For a target seed of length $n$, there are at most $n$ positive atoms. A distribution-free improper learner records every positive atom seen in the sample and predicts $0$ elsewhere. With

$$
O\left(\frac{n}{\varepsilon}\log\frac{n}{\delta}\right)
$$

examples, every positive atom of marginal mass at least $\varepsilon/n$ is observed with probability at least $1-\delta$, and the total mass of unobserved positive atoms below that threshold is at most $\varepsilon$. The learner has no false positives and has error at most $\varepsilon$. Its sample complexity and runtime are polynomial and distribution-free, so the class satisfies the marginal-nonuniform improper source.

**Why the target fails.** Fix one marginal $P$ as follows: choose $k$ with mass

$$
\mu_k=\frac{6}{\pi^2 k^2},
$$

then choose $i\in[k]$ and $b\in\{0,1\}$ uniformly. For a length-$n$ target, set

$$
\varepsilon_n=\frac{\mu_n}{3n}.
$$

Since $\mu_n=\Theta(1/n^2)$, we have $1/\varepsilon_n=O(n^3)$.

If a proper hypothesis $c_t$ has $P$-error at most $\varepsilon_n$ against $c_s$, then $|t|=n$ and $f(t)=f(s)$. If $|t|\ne n$, then on the length-$n$ block, $c_t$ is identically $0$ while $c_s$ has one positive bit-point for each coordinate, contributing error $\mu_n/2>\varepsilon_n$. If $|t|=n$ but $f(t)$ differs from $f(s)$ in one coordinate, the two bit-points for that coordinate both disagree, contributing error $\mu_n/n>\varepsilon_n$.

Now suppose the target node held for this class. Fix the marginal $P$ above, and let $A$ be the target's marginal-nonuniform proper learner with fixed polynomial bound $p_P$. Given a one-way challenge $y=f(s)$ for unknown uniform $s\in\{0,1\}^n$, simulate labeled examples from $P$ by labeling

$$
(1^k,i,b) \mapsto 1
\quad\Longleftrightarrow\quad
k=n \text{ and } b=y_i .
$$

This simulation uses $y$ but not a preimage $s$. Run $A$ with accuracy $\varepsilon_n$ and constant confidence. With the learner's success probability, the returned proper hypothesis is some seed $t$ with $f(t)=y$. The runtime is polynomial in $n$ because $P$ is fixed and $1/\varepsilon_n=O(n^3)$. This gives a probabilistic polynomial-time inverter with nonnegligible, indeed constant, success probability, contradicting the one-way-function assumption.

### Concrete Obstruction

The obstruction is representation recovery, not predictive accuracy. The labels expose the image bits directly, so an improper learner can predict by storing observed positive coordinates. But a proper learner is forced to name a seed whose image matches those coordinates. The fixed marginal gives the length-$n$ coordinate block inverse-polynomial mass, so an inverse-polynomial accuracy request forces exact recovery of all image bits and hence inversion.

This avoids the failure mode of the classical lookup, PCP, and DNF proper-hardness attempts. Those reductions usually place the hard input in a marginal or slice that varies with the NP instance, or they lose polynomial visibility when all instances are packed into a universal marginal. Here the marginal is fixed once and for all; the hard instance is the target image $f(s)$, visible through labels on one polynomial-mass coordinate block.

### Atlas-Ready Proof And Metadata Changes

If atlas edits are later allowed, update the exact edge

`atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac.md`

as follows:

- `status: "false"`
- `evidence: conditional-counterexample`
- `assumptions: ["length-preserving one-way functions exist"]`
- `witnesses: ["one-way-image-coordinate-class"]`
- `ref_keys: ["kearns1994cryptographic", "hastad1999prg"]`
- `refs:` should include `[Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)` and `[Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)`.
- `summary: "False under one-way functions: image-coordinate concepts satisfy marginal-nonuniform improper realizable learning, but fixed-marginal proper learning would invert the one-way function."`
- `family: one-way-image-coordinate-proper-hardness`
- `argument_note: "[[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]]"`
- `witness_note: "[[one-way-image-coordinate-class|One-Way Image Coordinate Class]]"`

Proof body to use:

The one-way image-coordinate class satisfies the source by the distribution-free improper memorization learner above: a length-$n$ target has only $n$ positive atoms, and recording observed positive atoms learns to error $\varepsilon$ with $O((n/\varepsilon)\log(n/\delta))$ examples. For the target failure, fix $P$ with block masses $\mu_k=6/(\pi^2k^2)$ and run the assumed proper learner at $\varepsilon_n=\mu_n/(3n)$. Any proper hypothesis within this error must have the same length and image as the target seed. Therefore, labeled examples generated from a one-way challenge $y=f(s)$ allow the learner to output a seed $t$ with $f(t)=y$ in polynomial time, contradicting one-wayness.

### Promising Next Directions

- Apply the same metadata update to this edge when atlas edits are allowed; the witness and argument notes already exist locally in the current worktree.
- Check sibling marginal-nonuniform strong improper-to-proper edges. Any source node implied by distribution-free improper realizable learning and any target requiring marginal-nonuniform strong proper realizable learning should inherit this witness, subject to the exact source/target axes.
- Keep the clause-satisfaction and DNF notes as near-miss context for non-cryptographic properization: they explain why instance-dependent hard marginals do not automatically refute marginal-nonuniform proper learning.
