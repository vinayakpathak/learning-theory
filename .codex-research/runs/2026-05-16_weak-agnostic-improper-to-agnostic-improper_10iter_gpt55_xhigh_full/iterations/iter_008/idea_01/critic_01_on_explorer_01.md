## Summary

The explorer’s main conclusion is basically right: the parity/LPN route is a credible **parameterized near-separation** for shrinking weak gap \(\gamma=1/2-\beta=\Theta(1/n)\), but it gives no proof or separation for the atlas edge with representation-uniform constant \(\beta<1/2\).

I do not see a fatal flaw in the repaired weak-side parity sketch, provided the theorem is stated with shrinking \(\gamma\), fresh validation, efficiently evaluable hypotheses, and conditional LPN hardness.

## Issue List

- **Fatal gap for atlas edge:** The weak learner uses \(\gamma=a/n\), so \(\beta_n=1/2-a/n\) is not a fixed representation-uniform constant. This cannot instantiate the source guarantee in `problem.md`.

- **Plausible but incomplete:** The weak learner needs a fully quantified theorem: repetitions, validation tolerance \(<\gamma/2\), failure probability, sample complexity \(O(\gamma^{-2})\), and no branch depending on unknown \(\eta=\operatorname{OPT}\).

- **Missing assumption:** The LPN reduction needs the strong learner’s output to be efficiently evaluable on arbitrary uniform \(x\). This is standard PAC hygiene, and the explorer notes it, but it must be in the theorem statement.

- **Unsupported citation / assumption boundary:** “Breaks LPN” is conditional on standard computational LPN hardness. Goldreich-Levin gives recovery from a correlated evaluable predictor; it does not supply LPN hardness.

- **Plausible but incomplete:** The span-capture lemma should be written with an adaptive Chernoff/stochastic-domination proof. The argument is sound-looking, but it is currently a sketch.

- **Minor convention issue:** State whether \(C_n\) is homogeneous parities, affine parities, or closed under negation. The weak learner may output both constants improperly, so this is not fatal, but the LPN and validation statements should use one convention consistently.

## Counterexamples Or Stress Tests

Uniform clean marginal is the key stress test. Under uniform \(X\), any proper subspace has mass at most \(1/2\), so capturing \(>1/2+2\gamma\) requires full rank, hence essentially \(n\) clean equations. For constant \(\gamma\), getting \(n\) clean examples when \(\eta=\Theta(1)\) costs \(\exp(-\Omega(n))\). This blocks any constant-gap upgrade by this method.

The hard band \(\eta\in[\gamma,2\gamma)\) is handled only by the clean-batch candidate, not constants. Thus the formal proof must ensure a good candidate appears with high probability and that validation cannot select an illegal constant due to estimation noise.

Adversarial, \(x\)-dependent noise is not a counterexample after the explorer’s repair: conditioning on all examples being clean relative to fixed \(c^\star\) makes the \(X_i\)’s iid from \(D_{c^\star}^+\).

## Literature Or Known-Result Conflicts

No conflict with the run ledger. This matches the existing parity/LPN warning: constant weak advantage for noisy parities would itself threaten LPN, so parities are not a fixed-constant source candidate.

No unconditional lower bound is obtained. BKW/SQ-style parity-noise results are background; the strong-side obstruction should be stated as conditional LPN hardness plus Goldreich-Levin recovery from a correlated predictor.

## What Survives The Critique

The clean-conditioned span argument is worth preserving. For \(\gamma=a/n\), all-clean \(O(n)\)-batches occur with constant probability, and span capture gives a parity with clean-conditional error \(\le 1/2-2\gamma\).

The strong learner \(\Rightarrow\) LPN reduction also survives, assuming evaluable binary hypotheses and uniform RCN labels.

The result is useful as a warning note: inverse-polynomial weak slack and fixed-constant weak slack behave qualitatively differently.

## Recommended Next Checks

Formalize a theorem for \(\gamma_n\) with \(n\gamma_n=O(\log n)\), including runtime \(\exp(O(n\gamma_n))\operatorname{poly}(n,1/\gamma_n,\log(1/\delta))\).

Write the span-capture lemma cleanly over an arbitrary clean-conditioned marginal.

Write the LPN implication as a conditional proposition: strong improper agnostic parity learning under uniform RCN, with evaluable outputs, implies polynomial-time LPN recovery via Goldreich-Levin.

Do not use this as evidence for the fixed-constant atlas implication except as a boundary/obstruction example.