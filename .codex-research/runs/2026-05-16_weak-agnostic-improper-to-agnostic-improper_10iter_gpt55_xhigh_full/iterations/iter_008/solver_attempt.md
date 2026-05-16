## Verdict

SOLVED: no

I do not see a proof of the fixed-constant slack edge. The most concrete progress is a nearby conditional separation: parities give a plausible LPN-based counterexample if the weak advantage is allowed to shrink as $\gamma=1/2-\beta=\Theta(1/n)$. This does **not** settle the stated atlas edge if $\beta<1/2$ must be a representation-uniform constant.

## Candidate Solution Or Main Attempt

Try the parity/LPN route with
$$
C_n=\{\chi_s(x)=(-1)^{s\cdot x}:s\in\mathbb F_2^n\}.
$$

For inverse-polynomial weak advantage, say $\gamma=\Theta(1/n)$ and $\beta=1/2-\gamma$, parities appear to satisfy the weak source. If $\operatorname{OPT}_{C_n}(D)$ is $O(\gamma)$, sample $O(n)$ examples. With constant probability none are corrupted relative to a best parity $c^\star$, and their linear span captures more than half the marginal mass. Any parity consistent with that clean batch agrees with $c^\star$ on the span, hence has disagreement at most $1/2-\Omega(\gamma)$ with $c^\star$. Repeating and validating against constants yields an $\operatorname{OPT}+\beta$ weak learner.

But a strong improper agnostic learner for parities under uniform random classification noise at any constant $\eta<1/2$ would output an evaluable predictor correlated with the hidden parity. Goldreich-Levin-style recovery from that predictor would break standard LPN hardness.

So: this gives a serious conditional separation for a **parameterized inverse-polynomial weak gap** version, not for the fixed-constant $\beta$ edge.

## Concrete Lemmas Or Reductions

**Span-capture lemma.** For any distribution $\mu$ on $\mathbb F_2^n$, if $x_1,\dots,x_m\sim\mu$ and $V=\operatorname{span}(x_1,\dots,x_m)$, then for $m=O(n)$,
$$
\mu(V)\ge 1/2+\Omega(\gamma)
$$
with high constant probability, for $\gamma=\Theta(1/n)$. While $\mu(V)<1/2+\Omega(\gamma)$, the next sample increases the span with probability bounded below by a constant.

**Low-noise weak parity learner.** Let $\gamma=a/n$ for small constant $a$. Repeat $O(\log(1/\delta))$ times: draw $m=O(n)$ examples, solve the parity consistency equations if possible, and add one solution to a candidate list. Add both constants. Fresh validation selects among the list.

If $\eta=\operatorname{OPT}_{C_n}(D)\le 2\gamma$, a clean spanning batch appears with constant probability, giving a candidate of error at most
$$
\eta+1/2-\Omega(\gamma)<\eta+\beta.
$$
If $\eta\ge 2\gamma$, a validated constant is within the legal hard-band threshold.

**Strong learner breaks LPN.** Under uniform RCN labels $Y=\chi_s(X)N_\eta$,
$$
\operatorname{err}(h,Y)=\eta+(1-2\eta)\operatorname{err}(h,\chi_s).
$$
Thus an $\operatorname{OPT}+\epsilon$ learner with $\epsilon<c(1-2\eta)$ gives a predictor for $\chi_s$ with constant advantage, from which $s$ can be recovered or distinguished, contradicting LPN hardness.

## Gaps And Failure Points

The parity weak learner relies on $\gamma n=O(1)$. For fixed constant $\gamma$, the clean $O(n)$ batch probability becomes exponentially small, and the weak source is essentially noisy parity learning at constant noise, already LPN-hard.

Thus parity does not instantiate the current fixed-constant source. It only pressures the exact meaning of “fixed” versus “parameterized” weak slack.

## Counterexamples Or Obstructions

The existing obstructions remain decisive for the constant-slack edge:

- hard-band silence: when $\operatorname{OPT}\ge\gamma$, the weak learner may return a near-random hypothesis;
- residual forcing from excess alone fails by the public-posterior examples;
- DCHP-style boosting still needs hidden-clean transcript generation and efficient final sparse-majority selection;
- generic sparse-majority ERM is Set-Cover hard;
- semantic weak correctness gives no free range or dual-VC control.

## Promising Ideas To Explore

1. Formalize the parity inverse-polynomial separation as a separate atlas edge or warning note.
2. Search for a succinct code/class with **constant** low-noise weak learning but high-noise improper prediction hardness.
3. Continue the DCHP route only with extra generated-bag structure or an explicit polynomial final-list mechanism.
4. Treat any claimed positive proof as needing a real public way to find clean mass, not just excess over a hidden comparator.

## Notes For Critics

The key thing to audit is definitional: if the source permits $\gamma=1/\operatorname{poly}(n)$ as the fixed weak gap, the parity/LPN route may be a conditional counterexample. If the atlas edge requires a representation-uniform constant $\gamma>0$, then this is only a near miss and the verdict stays open.