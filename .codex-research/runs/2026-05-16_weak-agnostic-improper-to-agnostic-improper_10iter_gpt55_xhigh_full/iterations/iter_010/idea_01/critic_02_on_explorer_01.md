## Summary

The explorer’s main conclusion survives: the ghost sample gives a valid statistical transfer lemma, but it does not supply the missing DCHP middle layer. I do not see a clear false claim in the report. The main “break” is that any positive use of the lemma still needs an independent proof that the generated bag/list is good on the independent ghost clean sample. Generation-sample clean success gives no such guarantee.

## Issue List

- **Plausible but incomplete:** The Ghost Transfer Lemma is only conditional on a ghost-good event. It says: if some $v\in V_T$ has low empirical error on an independent clean ghost sample, then $v$ has low $D_c^+$ error. It does not show that such a $v$ exists for the generated bag.

- **Fatal gap for the route, not for the explorer’s cautious claim:** DCHP-style proofs certify success on the hidden clean sample/transcript used to build the bag. The ghost lemma needs success on an independent sample. Without VC/dual-VC, stability, compression, or a population-valid generator, this is exactly the old bottleneck.

- **Missing assumption:** Independence must mean that $B$ or $V(B)$ is fixed before seeing the ghost sample, including the ghost $X$ values, labels, clean mask, and any random seed correlated with them. Reusing a global sample pool or adapting to ghost covariates breaks the stated transfer.

- **Missing assumption:** The raw ghost claim needs the endpoint split stated explicitly. The assertion $p=\Pr[Y=c(X)]\ge 1/2$ is valid only after choosing a near-optimal comparator with error $<1/2$; if $\operatorname{OPT}_C\ge 1/2-O(\epsilon)$, constants already solve the target.

- **Plausible but incomplete:** The mask-discovery bound $Lp^m$ requires a precise mask-neutral model: candidate subsets must be selected without useful information about clean indicators, must involve distinct positions, and must not use posterior-biased public regions, repeated-coordinate denoising, or oracle-output leakage.

- **Plausible but incomplete:** The sample size $m=\Theta((\log N+\log(1/\delta))/\epsilon^2)$ is a standard additive uniform-convergence scale, but not universal. Realizable/one-sided or relative bounds can sometimes improve the exponent to $1/\epsilon$. The qualitative exponential-mask-search obstruction remains, but the quantitative claim should be tied to the exact certification target.

- **Worth pursuing:** The decomposition into independent generation and ghost certification is useful as a clean conditional primitive. It should be recorded as analysis-only unless paired with a real generator-to-ghost-success theorem.

- **Unsupported citation:** None detected. The explorer used only local notes and standard finite-class concentration.

## Counterexamples Or Stress Tests

- **Memorizing singleton bag:** Generate $B=\{h\}$ where $h$ memorizes $S^{gen,+}$ and is random off-sample. Then $h$ has zero generation-clean empirical error but ghost-clean and population error about $1/2$. This directly breaks “generation success implies ghost success.”

- **Hidden-mask anti-hitting:** If $p<1$ is constant and the proof needs $m$ explicitly certified clean ghost positions, a polynomial menu has success at most $Lp^m$. For $m$ growing polynomially in $1/\epsilon$ or even linearly in $1/\epsilon$, this is not atlas-polynomial.

- **Observable clean regions:** If public features identify a high-clean region, the $p^m$ bound is too pessimistic. This stresses that the anti-hitting statement needs mask-neutrality or an information budget.

- **Repeated-coordinate denoising:** On finite or repeated domains, majority over repeated samples can recover labels without finding an all-clean tuple. This blocks overbroad clean-mask lower bounds.

- **Final selector stress:** Even if ghost transfer proves some vote in $\operatorname{sign}(B^{(T)})$ is population-good, selecting it is still the exact sparse-majority problem; arbitrary-bag Set-Cover hardness remains relevant.

## Literature Or Known-Result Conflicts

No conflict with the run’s accepted notes. The report is consistent with C019/L005 finite-list validation, C045/L043 DCHP three-layer decomposition, and O016/F015 memorization overfitting.

The main caveat is already in the local ledger: hidden-mask anti-hitting is only a restricted proof-skeleton obstruction, not a general lower bound. The explorer states this informally but should make the model assumptions explicit if promoted to a lemma.

## What Survives The Critique

The Ghost Transfer Lemma survives as a standard conditional concentration statement: condition on an independent transcript $T$, then union-bound over finite $V_T$.

The raw ghost sampling observation survives after endpoint handling.

The useful conceptual output is the separation of tasks:

1. generate a validation-independent bag/list;
2. prove independent ghost-clean success;
3. transfer ghost success to $D_c^+$;
4. solve final selection or provide an explicit polynomial list.

Only step 3 is solved by the explorer.

## Recommended Next Checks

- Formalize a theorem with exact quantifiers: probability over generation transcript, probability over ghost sample, and the event “$\exists v\in V(B)$ with ghost-clean empirical error $\le\alpha$.”

- Try to prove a stability/compression lemma of the form: generation-clean success implies ghost-clean success for DCHP-generated bags.

- Define the hidden-mask anti-hitting model precisely before using $Lp^m$: mask neutrality, distinct positions, transcript information, and allowed public posterior bias.

- Keep final selection separate: either output a polynomial list of complete classifiers or state an explicit selector for the exact $\operatorname{sign}(B^{(T)})$ class.