## Summary

The da Cunha-Hogsgaard-Paudice 2026 final selector is not an unrestricted real-weighted vote. It is an empirical risk minimizer over

$$
\operatorname{sign}(B^{(T)}),\qquad
B^{(T)}=\left\{ \frac1T\sum_{t=1}^T h_t:\ h_t\in B\right\},
$$

where repetitions are allowed, all weights are nonnegative integer multiples of $1/T$, the threshold is fixed at $0$, and $\operatorname{sign}(0)=+1$. Thus the exact final class is a bounded $T$-wise unweighted majority over the generated bag $B$, not arbitrary halfspaces unless complements/constants and enough multiplicity are available.

Algorithm-extraction verdict: the proof gives a useful hidden-clean empirical margin certificate, but not an observable noisy-label surrogate certificate. Therefore LP/convex selection is plausible only under an extra assumption; it is not extracted from the fixed-slack source alone.

## Concrete Progress

The final line of the 2026 algorithm is exactly:

$$
\hat v\in \arg\min_{\rho\in \operatorname{sign}(B^{(T)})}\ell_{S_2}(\rho).
$$

Equivalently, for $B=\{h_1,\dots,h_M\}$, it optimizes over count vectors

$$
n_i\in \mathbb Z_{\ge 0},\qquad \sum_i n_i=T,
$$

and classifiers

$$
x\mapsto \operatorname{sign}\left(\sum_{i=1}^M n_i h_i(x)\right).
$$

The proof constructs a hidden-clean AdaBoost trajectory on $S_f=\{(x,y)\in S_1:y=f(x)\}$, obtains a margin on $S_f$, then uses the dual-VC pruning lemma to show existence of a $T$-term average. With the paper’s constants, applying the pruning lemma to the AdaBoost $\theta/2$ margin gives a pruned average with positive hidden-clean empirical margin about $\theta/100$.

This suggests a conditional algorithmic replacement:

If the hidden-clean labeled sample $S_f$ were observable, or if a public certificate identified an equivalent clean constraint set, then one could search over $\operatorname{conv}(B)$ by LP for a margin separator and then use the dual-VC pruning argument to obtain a $T$-wise majority. But in the actual agnostic problem, $S_f$ is hidden because $f$ is the near-optimal comparator.

## Claims Or Lemmas

**Exact Selector Class.**  
For fixed generated bag $B$, da Cunha-Hogsgaard-Paudice select from sparse nonnegative integer majorities:

$$
V_{B,T}=\operatorname{sign}(B^{(T)}).
$$

This is more structured than arbitrary real-weighted thresholding, but still a $0$-$1$ sparse majority ERM problem.

**Approximate Selector Primitive.**  
A sufficient replacement for the final exhaustive search is an algorithm that, given fixed $B,T$ and fresh labeled sample $S_2$, returns $\hat v\in V_{B,T}$ with

$$
\ell_{S_2}(\hat v)\le \inf_{v\in V_{B,T}}\ell_{S_2}(v)+O(\epsilon).
$$

Uniform convergence over $\operatorname{sign}(H^{(T)})$ then preserves the proof with an extra $O(\epsilon)$ term. This is a genuine extra primitive; it is not supplied by the original weak learner.

**Hidden-Margin LP Conditional.**  
If a procedure can expose clean constraints on which some $\operatorname{conv}(B)$ score has margin $\Omega(\theta)$, LP feasibility can find a convex combination. The DCHP pruning lemma then gives a $T=O(d^*/\theta^2)$ sparse average. The missing part is exposing the clean constraints.

## Proof Attempts

First attempt: replace exhaustive search over $B^T$ by ordinary convex ERM over $\operatorname{conv}(B)$ on $S_2$. This fails as a proof extraction. The DCHP guarantee is a $0$-$1$ risk guarantee for noisy labels, while the margin certificate lives on the hidden clean subset $S_f$. No theorem in the proof says the good sparse vote has low hinge/logistic/exponential loss on the noisy validation distribution.

Second attempt: treat $V_{B,T}$ as generic halfspace ERM over features $h_i(x)$. This is exact only after relaxing the DCHP restrictions. The true class has nonnegative integer weights, fixed zero threshold, and total mass $T$. If $B$ contains complements and constants, this can simulate richer integer halfspaces; without them, it is a monotone/sparse threshold class.

Third attempt: use column generation. The required pricing problem is to find a useful hypothesis among all weak-learner outputs from all hidden-clean tuples/seeds. For an arbitrary improper weak learner, this pricing oracle is not available and can hide the same enumeration cost as the original proof.

## Gaps And Risks

Solving the final selector alone does not remove the upstream bottleneck: DCHP still generates $B$ by enumerating ordered $m_0$-tuples from $S_1$ and random seeds.

The hidden-clean margin is empirical and comparator-dependent. It does not justify noisy-label convex surrogate minimization without an additional calibration or margin theorem.

A formal hardness claim for the exact selector class still needs work. Generic halfspace hardness is only a warning unless mapped to nonnegative integer $T$-majorities with the right threshold and complement assumptions.

## Counterexamples Or Obstructions

Coordinate-bag stress test: if $B$ contains coordinate projections, their negations, and a constant feature, then $V_{B,T}$ contains bounded-integer sparse halfspaces over the generated feature map. A generic efficient selector for all such bags would be a strong sparse halfspace ERM primitive, not something implied by weak learning for $C$.

Surrogate obstruction: a classifier can be excellent on the clean conditional but incur large convex loss on the noisy slice. The DCHP proof uses held-out $0$-$1$ validation precisely to avoid needing a surrogate certificate.

Hard-band obstruction remains: polynomially many observable weak calls can all have $\operatorname{OPT}_C\ge\gamma$, allowing legal dummy responses and producing a bag with no hidden-clean-useful columns.

## Sources Consulted

- Required local run files: `problem.md`, `working_notes/*.md`, and `iterations/iter_006/idea_03/idea.md`.
- Prior local selector reports from iteration 4.
- Arthur da Cunha, Mikael Moller Hogsgaard, Andrea Paudice, “Sample-Near-Optimal Agnostic Boosting with Improved Running Time,” arXiv:2601.11265: https://arxiv.org/abs/2601.11265

## Recommended Next Steps

1. Formalize `ApproxSparseMajorityERM(B,T)` as the exact final-selector primitive for DCHP, separate from unrestricted halfspace ERM.
2. Prove either a positive algorithm for this primitive under structural assumptions on $B$, or a hardness result for nonnegative integer $T$-majorities.
3. Separately test the hidden-margin LP route: assume observable clean constraints, prove LP plus dual-VC rounding, then isolate exactly what information is needed to make those constraints public.