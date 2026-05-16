## Summary

The exact DCHP sparse-majority selector appears computationally blocked in the worst case. I found a direct Set Cover reduction showing that generic exact ERM, and even tunable additive empirical ERM, over

$$
V_{B,T}=\left\{x\mapsto \operatorname{sign}\left(\sum_j k_jh_j(x)\right): k_j\in\mathbb N,\ \sum_j k_j=T\right\}
$$

is NP-hard and W[2]-hard parameterized by $T$ for arbitrary binary bags $B$.

This does not close the atlas edge: it only says a worst-case `ApproxSparseMajorityERM(B,T)` primitive is too strong unless it uses extra structure from the generated DCHP bag, a margin certificate, or a different final-list mechanism.

## Concrete Progress

Define the empirical selector problem: given sample rows, labels, a bag $B=\{h_1,\dots,h_M\}$, and $T$, choose nonnegative integer counts summing to $T$ to minimize training mistakes under `sign(0)=+1`.

Reduction from Set Cover. Given universe $U$, sets $S_1,\dots,S_M$, and integer $k$, build $B=\{a,h_1,\dots,h_M\}$ and set $T=2k$.

Rows:

| row | label | $a$ | $h_j$ |
|---|---:|---:|---:|
| upper control $u$ | $+1$ | $-1$ | $+1$ for all $j$ |
| lower control $\ell$ | $+1$ | $+1$ | $-1$ for all $j$ |
| element row $x_e$ | $-1$ | $-1$ | $-1$ if $e\in S_j$, else $+1$ |

Let $r$ be the number of copies of $a$ in the selected $2k$ votes.

The upper control row is correct iff $2k-2r\ge 0$, so $r\le k$.

The lower control row is correct iff $2r-2k\ge 0$, so $r\ge k$.

Thus any zero-error vote must have exactly $r=k$, leaving exactly $k$ set-columns. For an element $e$, if $c_e$ selected set-columns cover $e$, the margin is

$$
-k + ((k-c_e)-c_e)=-2c_e.
$$

Since the label is $-1$ and `sign(0)=+1`, the element row is correct iff $c_e\ge 1$. Therefore zero empirical error exists iff the selected $k$ sets cover $U$.

## Claims Or Lemmas

**Lemma 1: Exact selector hardness.** Exact empirical risk minimization over $V_{B,T}$ for arbitrary binary bags is NP-hard. Parameterized by $T$, it is W[2]-hard via $T=2k$ from Set Cover.

**Lemma 2: Tunable additive selector hardness.** If an algorithm returns empirical risk at most $\inf_{v\in V_{B,T}}\widehat{\operatorname{err}}(v)+\xi$ in time $f(T)\operatorname{poly}(M,n,1/\xi)$, then with $\xi<1/(2n)$ it distinguishes zero-error from nonzero-error instances. Hence such an FPT additive selector would imply FPT for Set Cover.

**Lemma 3: The obstruction is exact-integer, not just halfspace relaxation.** The reduction uses nonnegative integer vote counts and the DCHP tie rule. Relaxing to arbitrary real convex weights changes the control behavior and may no longer encode size-$k$ cover.

## Proof Attempts

The successful proof strategy is to view each training example as a threshold constraint over the selected columns. The two control rows force exactly half of the vote budget onto a special offset column. The remaining half then acts as the selected set-cover family, and negative element rows test whether at least one selected set covers the element.

A halfspace-hardness route is less precise. If a bag contains coordinates, complements, and constants, sparse majorities can simulate some sparse signed halfspaces or monomials, and known halfspace hardness is suggestive. But that route risks missing the exact zero-threshold, nonnegative, integer, bounded-$T$ structure. The Set Cover gadget is cleaner because it stays inside the exact DCHP class.

## Gaps And Risks

The hardness is for arbitrary binary bags. It does not rule out a selector exploiting special structure of bags produced by a fixed weak learner or by the DCHP hidden-clean construction.

The reduction uses even $T$ and the `sign(0)=+1` tie rule. If a future selector only handles odd $T$ or tie-free margins, a padding gadget would be needed.

The bag is not complement-closed, and the special offset column is not a literal constant. Hardness for complement-closed bags or bags containing only natural constants remains a separate reduction task.

This does not refute margin-based or surrogate-based selection under extra observable assumptions. It only blocks generic worst-case 0-1 ERM/additive ERM over the exact class.

## Counterexamples Or Obstructions

The main obstruction is now concrete: a generic `ApproxSparseMajorityERM(B,T)` primitive would solve Set Cover when run to inverse-polynomial empirical accuracy. Thus the positive DCHP route cannot simply assume efficient ERM over `sign(B^(T))`.

This also explains why finite statistical size is misleading. The class has finite cardinality and validation cost about $T\log |B|$, but computational optimization over the class can still encode W[2]-hard selection.

## Sources Consulted

Project notes: `problem.md`, all listed `working_notes/*.md`, and `iterations/iter_007/idea_01/idea.md`.

External context:
- Guruswami and Raghavendra, “Hardness of Learning Halfspaces with Noise”: https://epubs.siam.org/doi/10.1137/070685798
- Dell, Kim, Lampis, Mitsou, Mömke, “Complexity and Approximability of Parameterized MAX-CSPs”: https://arxiv.org/abs/1511.05546
- Lin, “Constant Approximating Parameterized k-SetCover is W[2]-hard”: https://arxiv.org/abs/2202.04377

## Recommended Next Steps

Record the Set Cover selector-hardness lemma as an iteration-7 claim after checking the reduction details.

Then split future selector work into restricted variants: DCHP-generated bags, margin-certified bags, complement-closed bags, odd-$T$ votes, and convex/nonnegative real-weight relaxations. The generic worst-case selector should be treated as unavailable.