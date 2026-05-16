## Summary

Under the computational-complexity lens, idea_01 looks negative for arbitrary bags. The exact DCHP selector problem contains Set Cover / Max k-Cover as a special case once the bag includes even one public `+1` constant. This gives a clean obstruction to a generic polynomial or FPT selector for

$$
V_{B,T}=\left\{\operatorname{sign}\left(\sum_j k_j h_j\right): k_j\in \mathbb N,\ \sum_j k_j=T\right\}.
$$

The main progress is a direct reduction showing exact zero-error ERM is NP-hard and W[2]-hard parameterized by `T`. A gap version also transfers Max k-Cover hardness to additive empirical-risk approximation for arbitrary bags.

## Concrete Progress

Define `SparseMajorityERM(B,T)` on a labeled sample. For each example, write the bag evaluations as `h_j(x_i) in {+-1}`. The selector chooses a multiset of exactly `T` bag columns and predicts by majority, with `sign(0)=1`.

Reduction from Set Cover with universe `U`, sets `S_1,...,S_M`, and budget `k`:

- For each set `S_j`, create a hypothesis `h_j`.
- For each element `u in U`, create a positive example with `h_j(u)=+1` iff `u in S_j`, else `-1`.
- Add one dummy negative example `d` with `h_j(d)=-1` for all set columns.
- Add one filler hypothesis `c_+` with `c_+(x)=+1` on every example.
- Set `T=2k-1`.

Then a `k`-set cover exists iff there is a zero-error classifier in `V_{B,T}`.

This is stronger than a relaxed-halfspace warning: it hits the exact nonnegative integer, zero-threshold, fixed-`T` DCHP vote class.

## Claims Or Lemmas

**Lemma 1: Exact sparse-majority ERM is Set-Cover hard.**  
For arbitrary finite bags containing a constant `+1` hypothesis, deciding whether empirical error `0` is achievable by a `T`-wise sparse majority is NP-hard. Parameterized by `T`, it is W[2]-hard unless the usual W-hierarchy collapses.

**Lemma 2: Gap Max k-Cover transfers.**  
If the dummy negative row is duplicated `W>|U|` times, then every optimal vote must classify the dummy rows correctly. Among such votes, maximizing correctly classified positive rows is exactly Max k-Cover with budget `k`. Thus standard Max k-Cover gaps become additive empirical-risk gaps for `SparseMajorityERM`.

**Lemma 3: Complements/constants embed bounded integer halfspaces.**  
If `B` contains features, their complements, and both constants, then the exact DCHP class contains signed integer halfspaces with bounded `l1` weight, up to harmless canceling filler pairs. This explains why generic halfspace-selection hardness is relevant, but the Set Cover gadget is the cleaner exact-class obstruction.

## Proof Attempts

For Lemma 1, if `S_{j_1},...,S_{j_k}` cover `U`, choose those `k` set columns plus `k-1` copies of `c_+`. For an element covered `r>=1` times, the vote sum is

$$
2r-k+(k-1)=2r-1>0.
$$

On the dummy negative example, the sum is

$$
-k+(k-1)=-1<0.
$$

So the vote has zero empirical error.

Conversely, suppose a zero-error vote exists. Let `q` be the number of copies of `c_+`, and let `s=T-q` be the number of selected set-column copies. Dummy correctness gives `q<s`, hence `s>=k`. For any positive element `u`, let `r_u` be the number of selected set copies covering it. Positive correctness gives

$$
2r_u-s+q>0.
$$

Since `q=2k-1-s`, this implies

$$
r_u \ge s-k+1.
$$

Remove any `s-k` selected set occurrences. Each element still has at least one covering occurrence left. The remaining `k` occurrences therefore give a set cover of size at most `k`.

## Gaps And Risks

This hardness is for arbitrary bags with a constant. It does not rule out selectors for special bags produced by a controlled weak learner, nor margin-restricted or distributional selectors.

If the DCHP pipeline cannot add constants to `B`, the reduction does not directly apply. A no-constant hardness reduction is still worth checking.

The gap lemma gives worst-case empirical ERM hardness. It does not rule out surrogate optimization under an additional observable margin/calibration condition.

## Counterexamples Or Obstructions

A generic `ApproxSparseMajorityERM(B,T)` primitive for arbitrary bags would imply an FPT algorithm for Set Cover with parameter `k=(T+1)/2`, so it is not a reasonable unconditional primitive.

All-positive examples alone are not enough for a reduction, because the all-constant vote can become trivial. The dummy negative calibration row is essential.

## Sources Consulted

Local run files: `problem.md`, all listed `working_notes/*.md`, and `iterations/iter_007/idea_01/idea.md`.

External sources:

- Downey and Fellows, “Fixed-Parameter Tractability and Completeness I,” for W[2] background and W[2]-complete domination: https://epubs.siam.org/doi/10.1137/S0097539792228228
- Feige, “A threshold of ln n for approximating set cover,” including Max k-Cover hardness: https://doi.org/10.1145/285055.285059
- Lin, Ren, Sun, Wang, “Constant Approximating Parameterized k-SetCover is W[2]-hard”: https://arxiv.org/abs/2202.04377
- Tiegel, “Hardness of Agnostically Learning Halfspaces from Worst-Case Lattice Problems,” for improper halfspace-hardness context: https://proceedings.mlr.press/v195/tiegel23a.html

## Recommended Next Steps

Record the Set Cover reduction as a new selector-hardness claim. Then decide whether DCHP’s actual generated bags can include constants or complements; if yes, a generic exact/FPT selector is computationally blocked.

Next, test the no-constant exact class. If that remains hard, the selector bottleneck is robust. If not, the right conditional positive primitive should explicitly require the structural restriction on `B`, not arbitrary sparse-majority ERM.