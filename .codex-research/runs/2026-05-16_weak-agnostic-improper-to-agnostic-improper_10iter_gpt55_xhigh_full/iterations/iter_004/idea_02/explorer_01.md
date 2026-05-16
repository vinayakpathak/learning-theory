## Summary

The implicit-vote idea gives a clean conditional positive route, but it does not by itself close the atlas edge. Once a polynomial realized bag of weak outputs contains a good final vote, the remaining statistical problem is mild: weighted votes over a fixed bag have VC dimension $O(M)$ for bag size $M$. The hard parts are algorithmic and generative:

1. producing a bag that contains a clean-useful final vote without hidden-clean tuple enumeration;
2. efficiently finding a low noisy-risk threshold over the bag features.

Convex optimization can replace vote enumeration only under an extra margin/surrogate assumption. Plain fixed-slack weak learning does not provide that assumption.

## Concrete Progress

Let a generation phase output a validation-independent bag

$$
B=\{h_1,\dots,h_M\}
$$

of evaluable weak hypotheses, with $M=\operatorname{poly}(s,1/\epsilon)$. Define the weighted-vote class

$$
V_B=\left\{x\mapsto \operatorname{sign}\left(\sum_{i=1}^M w_i h_i(x)-\theta\right): w\in\mathbb R^M,\theta\in\mathbb R\right\}.
$$

Then the final selection problem over $V_B$ is just agnostic halfspace learning in the feature map $\phi_B(x)=(h_1(x),\dots,h_M(x))$.

Statistically, this is fine: $\operatorname{VC}(V_B)\le M+1$, so fresh samples give uniform convergence with polynomial sample size. Computationally, exact $0$-$1$ ERM over $V_B$ is the usual minimum-disagreement halfspace problem in $M$ dimensions. Arrangement enumeration costs roughly $n^{O(M)}$, which is not atlas-polynomial when $M$ is polynomial.

Thus implicit selection can remove the explicit $|B|^T$ vote enumeration only if we assume an efficient agnostic selector over the realized feature class, or add a margin/surrogate condition strong enough for convex optimization.

## Claims Or Lemmas

**Conditional vote-selector lemma.**  
Let $c\in C$ satisfy $\operatorname{err}_D(c)\le \operatorname{OPT}_C(D)+\tau$. Suppose a validation-independent bag $B$ and class $V_B$ satisfy

$$
\exists v\in V_B:\quad \operatorname{err}_{D_c^+}(v,c)\le \alpha.
$$

If an efficient selector returns $\hat h$ with

$$
\operatorname{err}_D(\hat h,Y)\le \inf_{v\in V_B}\operatorname{err}_D(v,Y)+\xi,
$$

then

$$
\operatorname{err}_D(\hat h,Y)\le \operatorname{OPT}_C(D)+\tau+\alpha+\xi.
$$

Proof is immediate from the clean-conditional excess bound in the run notes.

**Statistical/computational split.**  
For fixed polynomial $B$, final generalization is not the main obstacle: $V_B$ has VC dimension $O(M)$. The obstacle is computing, or otherwise finding, a near-best threshold over the $M$ weak-output features.

**Column-generation obstruction.**  
Trying to generate votes by convex/online column generation still needs weak hypotheses correlated with the current gradient. The fixed source only guarantees additive best-correlation approximation and can be dummy on hard-band queries with $\operatorname{OPT}_C\ge\gamma$. So ordinary gradient boosting again hits the fixed-slack floor unless the algorithm can manufacture target-useful low-OPT queries.

## Proof Attempts

First attempt: split samples into generation, selector-training, and validation. Generate $B$ using polynomially many fresh population calls to the weak learner. Then run an agnostic selector over $V_B$ on fresh noisy samples, and validate the resulting finite list of selector outputs.

This proves a useful conditional theorem, but the selector is an extra primitive. The original weak learner for $C$ is not a learner for halfspaces over $\phi_B(X)$.

Second attempt: replace $0$-$1$ ERM by convex risk minimization over scores $F_w(x)=\sum_i w_i h_i(x)$. This is polynomial-time, but it optimizes hinge/logistic risk, not noisy $0$-$1$ risk. It works only if the good vote has a certified low surrogate risk or a margin condition. Da Cunha-style existence of a good clean vote does not automatically give such a noisy-label surrogate certificate.

Third attempt: use the weak learner itself as a separation/column oracle. This fails in the hard band: if the residual or gradient query has $\operatorname{OPT}_C\ge\gamma$, a legal fixed-slack implementation may return only a majority constant or other non-informative dummy.

## Gaps And Risks

The bag-containment assumption is essentially a hidden-clean transcript generator in another form. If no polynomial procedure produces a bag containing a clean-useful final vote, implicit selection has nothing to select.

Convex selection is not justified distribution-free without an added margin, calibration, or benign-noise assumption.

Empirical low-OPT calls can produce hypotheses that memorize or fit public relabelings without population value. Fresh validation can reject bad complete classifiers, but it cannot make a bad generated bag good.

## Counterexamples Or Obstructions

If all generated population queries remain in the hard band, an adversarial valid weak learner may return dummy hypotheses throughout. Then $B$ contains no target-useful columns, and no final selector can recover the missing information from the weak calls.

A polynomial bag can still overfit if generated from hidden clean samples without population control. This matches the existing singleton-bag obstruction.

Weighted votes over a polynomial bag avoid finite $T$-tuple enumeration statistically, but exact optimization becomes agnostic halfspace ERM in $M$ dimensions; naive enumeration is $n^{O(M)}$.

## Sources Consulted

No web sources consulted.

Local run files consulted: `problem.md`, `working_notes/canonical_summary.md`, `working_notes/claim_ledger.md`, `working_notes/lemma_bank.md`, `working_notes/failed_attempts.md`, `working_notes/counterexamples.md`, `working_notes/literature_map.md`, `working_notes/promising_directions.md`, `working_notes/iteration_summaries.md`, and `iterations/iter_004/idea_02/idea.md`.

## Recommended Next Steps

Formalize the conditional vote-selector lemma as a primitive: `PolynomialBagGenerator + EfficientAgnosticVoteSelector => strong agnostic learner`.

Then decide whether to treat `EfficientAgnosticVoteSelector` as an explicit extra assumption, or try to replace it with a margin-based convex selector.

For the original atlas edge, focus next on bag generation. The implicit selector only helps after the hidden-clean generation and clean-population generalization problems have already been solved.