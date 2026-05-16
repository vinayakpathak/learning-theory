## Summary

The explorer’s core algebra is sound as a restricted one-call, proper-output support-function obstruction. The Anchor Lock-In Lemma follows from convexity of the support function, and it correctly shows that linearly mixing a public anchor with the target direction cannot force movement past fixed additive slack $\alpha=2\beta$.

The critique is that the report sometimes phrases this as a generic obstruction to anchor doping or to the atlas edge. That is too strong. The atlas source is improper, query directions must be sampleable normalized PAC query distributions, and multi-call postprocessing/validation is not ruled out by a single-call cap-separation criterion.

## Issue List

1. **Missing assumption / false if read literally: proper vs improper outputs.**  
   The cap criterion uses
   $$
   C_{\mathrm{bad}}(\epsilon)=\{c\in C:\langle c,a\rangle\le \sigma_C(a)-2\epsilon\}.
   $$
   It characterizes when a proper weak response from $C$ is forced to be target-good. The atlas weak learner may return arbitrary improper binary hypotheses. Even if every legal proper response is target-good, an improper hypothesis can still satisfy
   $$
   \langle h,z\rangle\ge \sigma_C(z)-\alpha
   $$
   while being target-bad under $a$. The positive “iff” needs either a proper-oracle restriction or a bad set over the full output universe.

2. **Worth pursuing, but scoped: the negative half survives.**  
   If there exists a target-bad $c_0\in C$ that is legal for the weak guarantee, an adversarial improper learner may return that proper $c_0$. So the obstruction is valid against reductions that must tolerate adversarial legal weak learners.

3. **Missing assumption: feasible query directions.**  
   The report treats $z$ as an arbitrary support-function direction. In PAC terms, $z$ must come from a sampleable distribution with bounded conditional label mean. Reweighting or signed directions may be infeasible, and the additive error $\alpha=2\beta$ is in normalized correlation units. A formal statement needs an allowed query family $\mathcal Q$.

4. **Plausible but incomplete: cap-separation criterion needs attainment/strictness.**  
   If
   $$
   \sigma_C(z)-\sigma_{C_{\mathrm{bad}}}(z)\le \alpha,
   $$
   a legal bad concept exists only if the bad supremum is attained, or if one weakens the statement with an $\eta$-approximation and strict $<\alpha$. For infinite classes this matters.

5. **Overstatement: “can work only if anchor creates an $\alpha$-margin separation.”**  
   This is true for a single call whose returned proper hypothesis itself must be target-good. It does not rule out adaptive multi-query procedures, aggregation of several weak outputs, or postprocessing that constructs a new improper hypothesis.

6. **False without an extra restriction: “validation cannot help if the oracle never emits the good vertex.”**  
   In the two-vertex example, if both vertices are explicitly evaluable or enumerable, fresh validation over them selects the good one. The statement is only correct for candidate-generation procedures whose validation list is limited to oracle-emitted or cheaply generated hypotheses.

7. **Plausible but incomplete: value-based finite-difference obstruction.**  
   The weak learner is not a two-sided value oracle for $\sigma_C(z)$. With improper outputs, the returned value can even exceed $\sigma_C(z)$. This part should be framed as an obstruction for a stronger proper approximate-optimization oracle, not directly for the atlas weak learner.

## Counterexamples Or Stress Tests

- **Improper-output stress test:** choose a query direction $z$ where all target-bad concepts in $C$ are separated by more than $\alpha$, but the full binary output class contains an $h$ with high $\langle h,z\rangle$ and low $\langle h,a\rangle$. The proper cap criterion says success, but the improper atlas oracle may legally return $h$.

- **Two-vertex validation stress test:** for $C=\{c_{\mathrm{good}},c_{\mathrm{bad}}\}$ with target gap in $(2\epsilon,\alpha]$, the lock-in lemma shows the oracle may keep returning $c_{\mathrm{bad}}$. But if the learner can directly validate both vertices, strong learning is trivial. Thus this is not a lower bound without a candidate-access restriction.

- **Boundary stress test:** if $C_{\mathrm{bad}}$ does not attain $\sigma_{C_{\mathrm{bad}}}(z)$ and the gap equals $\alpha$, the claimed legal bad response may not exist.

## Literature Or Known-Result Conflicts

No external citation conflict: the explorer used only local notes.

The result is consistent with the run ledger’s hard-band obstruction and with the warning that fixed additive support approximation cannot resolve $\epsilon$-scale distinctions. It should not be stated as conflicting with da Cunha-style residual-free boosting, since that route does not rely on forcing a single approximate support maximizer to be target-good.

## What Survives The Critique

- The Anchor Lock-In Lemma is algebraically valid:
  $$
  \sigma_C(z_\lambda)-\langle c_0,z_\lambda\rangle
  \le (1-\lambda)\kappa+\lambda\Delta.
  $$
- The two-vertex obstruction is a clean black-box warning for line-segment anchor homotopies.
- The quantity
  $$
  M_{\mathcal Q}(\epsilon)=\sup_{z\in\mathcal Q}
  \left(\sigma_C(z)-\sigma_{C_{\mathrm{bad}}(\epsilon)}(z)\right)
  $$
  is a useful diagnostic for proper, single-call anchor forcing.

## Recommended Next Checks

1. Formalize the sampleable query family $\mathcal Q$ for label doping and reweighting.

2. Rewrite the cap criterion for the actual improper output universe, or explicitly restrict to proper oracle responses.

3. Add strict/approximate variants handling nonattainment of support suprema.

4. Try to prove an adaptive adversarial-oracle theorem, not just a one-call lemma.

5. Record this as a restricted black-box obstruction to anchor-doping support refinement, not as evidence that the atlas implication is false.