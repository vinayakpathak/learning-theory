## Summary

Definition check verdict: the parity/LPN idea does **not** instantiate the current atlas source if `beta < 1/2` means a representation-uniform constant slack. It does give a credible conditional separation for a different, weaker source notion where the weak gap is allowed to shrink like `gamma_n = 1/2 - beta_n = O(log n / n)`.

The main useful progress is that the weak parity learner can be made definitionally cleaner than the solver sketch: the span-capture lemma must be applied to the **clean conditional marginal**, not the original marginal, then transferred back using `OPT = eta = O(gamma)`.

## Concrete Progress

For `C_n = {x -> (-1)^{s·x}: s in F_2^n}`, a weak learner with shrinking gap `gamma = a/n` can plausibly work as follows.

Draw `m = O(n)` labeled examples. If all labels are clean relative to an optimal parity `c*`, solve the linear equations and output any consistent parity. This parity agrees with `c*` on the span `V` of the sampled points.

Correction to the sketch: conditioned on the all-clean event, the sampled `X` values are drawn from `D_X | [Y=c*(X)]`, not from `D_X`. If that clean conditional marginal gives `mu^+(V) >= 1/2 + 4gamma` and `eta = err(c*) <= 2gamma`, then

$$
D_X(V) \ge (1-\eta)\mu^+(V) \ge 1/2 + 2gamma
$$

for small enough `gamma`. Hence the candidate parity disagrees with `c*` on at most `1/2 - 2gamma` original marginal mass, giving

$$
err_D(h,Y) \le eta + 1/2 - 2gamma = OPT_C(D) + beta - gamma.
$$

A finite candidate list plus fresh validation with accuracy `O(gamma)` then preserves the `OPT + beta` weak guarantee. If `eta > 2gamma`, constants suffice because the better constant has error at most `1/2 < eta + beta`.

## Claims Or Lemmas

**Lemma 1: Span Capture.** For any distribution `mu` on `F_2^n`, if `x_1,...,x_m ~ mu` and `V = span(x_1,...,x_m)`, then for `m = O(n)`,

$$
mu(V) \ge 1/2 + O(1/n)
$$

with high constant probability. More generally, while `mu(V) < tau`, the next sample increases the span with probability at least `1-tau`; taking `tau = 1/2 + K/n` and `m = 4n` gives failure probability exponentially small in `n`.

**Lemma 2: Shrinking-Gap Weak Parity Learner.** For `gamma = a/n` with sufficiently small fixed `a`, parities have an efficient `OPT + (1/2-gamma)` weak agnostic learner, using `O(n)` samples per trial, polynomially many trials, Gaussian elimination, constants, and fresh validation.

This lemma can likely be extended to `gamma = O(log n / n)` with polynomial repetition cost, since the all-clean event has probability roughly `exp(-O(gamma n))`.

**Lemma 3: Strong Improper Parity Learner Breaks LPN.** Under uniform RCN labels `Y = chi_s(X)N_eta`,

$$
err(h,Y)=eta+(1-2eta)err(h,chi_s).
$$

An `OPT + epsilon` learner with `epsilon < (1-2eta)/4` returns an evaluable predictor correlated with `chi_s`. Goldreich-Levin then recovers the heavy parity coefficient, hence `s`, in polynomial time. This contradicts standard LPN hardness for constant `eta`.

## Proof Attempts

The positive weak-side proof is viable only after the clean-conditional correction above. The original “span captures the marginal” argument is not literally valid under agnostic noise, because conditioning on a clean batch changes the `X` distribution. Low `eta = O(gamma)` repairs this by total-mass transfer.

The strong-side reduction is clean under the usual PAC convention that the improper hypothesis is efficiently evaluable on arbitrary inputs. If the output were merely transductive sample labels, Goldreich-Levin would not apply; that is not the atlas model.

## Gaps And Risks

The construction does not supply one fixed `beta < 1/2` across all dimensions. It supplies `beta_n = 1/2 - Theta(1/n)` or perhaps `1/2 - O(log n/n)`.

If “parameterized weak learner” means an algorithm must achieve arbitrary requested inverse-polynomial `gamma`, this parity learner still falls short: for `gamma n` superlogarithmic, the all-clean `O(n)` batch probability becomes superpolynomially small.

For fixed constant `gamma`, the weak side becomes noisy parity learning at constant noise, which is exactly the LPN-hard regime. So under LPN, parities are not a counterexample to the current fixed-constant atlas edge.

## Counterexamples Or Obstructions

The decisive obstruction is definitional: `gamma_n -> 0`. No representation-uniform constant weak advantage is obtained.

A second obstruction is computational: making `gamma` constant would require learning parities from constant random classification noise, not merely catching an all-clean batch. That is the assumed hard problem.

## Sources Consulted

Local run files: `problem.md`, `working_notes/*`, and `iterations/iter_008/idea_01/idea.md`.

External:
- Avrim Blum, Adam Kalai, Hal Wasserman, “Noise-Tolerant Learning, the Parity Problem, and the Statistical Query Model” https://www.microsoft.com/en-us/research/wp-content/uploads/2016/11/2003-Noise-Tolerant_Learning.pdf
- Oded Goldreich and Leonid Levin, “A Hard-Core Predicate for all One-Way Functions” https://www.wisdom.weizmann.ac.il/~oded/gl.html

## Recommended Next Steps

Record this as a warning note for a **shrinking-gap weak agnostic** variant, not as progress on the fixed-constant edge.

If formalizing, state the weak lemma with exact constants using the clean conditional marginal, validation slack, and the split `OPT <= 2gamma` versus `OPT > 2gamma`.

Then define a separate “size-dependent weak slack” edge; under LPN, parity is a plausible conditional non-implication for that edge.