# Edge: efficient-marginal-nonuniform-weak-agnostic-improper-pac -> efficient-marginal-nonuniform-agnostic-improper-pac

Date: 2026-05-05

Worker constraint: wrote only this scratchpad; no atlas files edited.

## Files And Sources Read

- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-agnostic-improper-pac.md`
- `atlas/definitions/efficient-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/arguments/marginal-boosting-open.md`
- `atlas/arguments/sample-complexity-equivalence.md`
- `atlas/arguments/low-noise-weak-agnostic-robustification.md`
- `references.bib`
- Primary sources checked online: Feldman 2010 `arXiv:0909.2927`, Ghai--Singh 2025 `arXiv:2503.04706` / PMLR, da Cunha--Hogsgaard--Paudice 2026 `arXiv:2601.11265`.

## Existing Edge State

The edge is currently `status: "open"` with `evidence: unknown`, family `agnostic-boosting-open`.

The current note says the main obstruction is that standard boosting either reweights the instance marginal, which is awkward for marginal-nonuniform runtime bounds, or uses a stronger threshold/correlation weak agnostic oracle than the atlas source provides.

After checking the definitions and the newer boosting references, I think this remains the right status. I do not have a theorem or a concrete separating class.

## Definitions In This Edge

The source supplies one uniform learner $A$ such that, for every instance marginal $P$, there are a marginal-dependent polynomial $p_P$ and weak tolerance
$$
\beta_P(s) = 1/2 - \gamma_P(s) < 1/2,
$$
where $\gamma_P(s)$ is only inverse-polynomial in $s$ under a marginal-dependent polynomial. For every joint distribution $\mathcal D$ with marginal $P$,
$$
\operatorname{err}_{\mathcal D}(A) \le \operatorname{OPT}_{\mathcal C}(\mathcal D) + 1/2 - \gamma_P(s)
$$
in time and samples bounded by $p_P(s,\log(1/\delta))$.

The target asks for the same kind of marginal-dependent polynomial bound, but for arbitrary excess error:
$$
\operatorname{err}_{\mathcal D}(h) \le \operatorname{OPT}_{\mathcal C}(\mathcal D) + \varepsilon
$$
with runtime and samples bounded by some polynomial $p_P(s,1/\varepsilon,\log(1/\delta))$ depending on the original marginal $P$.

## Correlation Translation

Use $\{\pm 1\}$ labels and write
$$
C_{\mathcal D} = \sup_{c\in\mathcal C}\operatorname{corr}_{\mathcal D}(c)
              = 1 - 2\operatorname{OPT}_{\mathcal C}(\mathcal D).
$$
The atlas fixed-additive weak guarantee becomes
$$
\operatorname{corr}_{\mathcal D}(A)
\ge C_{\mathcal D} - (1 - 2\gamma_P(s)).
$$

So it is a very weak additive correlation approximation. It is useful on distributions where $C_{\mathcal D}$ is close to $1$, i.e. low-noise or realizable subproblems, but it gives essentially no positive correlation when the best concept only has modest correlation.

This is exactly why the sample-only implication can go through by VC/ERM, but the efficient implication is not automatic.

## Near Miss 1: Feldman And Label-Only Distribution-Specific Boosting

Feldman's distribution-specific agnostic boosting is well aligned with marginal-nonuniform bookkeeping because it modifies labels, not the instance marginal. Ghai--Singh's unlabeled-data booster also explicitly notes the distribution-specific setting and uses relabeling so weak-learner calls preserve the original feature marginal.

This would be the cleanest route to a true edge, because all weak calls would remain under the same $P$ and hence under the same marginal-dependent polynomial.

But the weak oracle required there is correlation/threshold-style. In the Ghai--Singh notation, for tunable $\varepsilon_0,\delta_0$ a $\gamma$-agnostic weak learner returns $W$ with
$$
\operatorname{corr}_{\mathcal D'}(W)
\ge \gamma\max_{h\in\mathcal H}\operatorname{corr}_{\mathcal D'}(h)-\varepsilon_0.
$$
Their final guarantee loses a term of order $\varepsilon_0/\gamma$, so $\varepsilon_0$ has to be chosen at the final target scale.

The atlas source does not supply such a tunable weak oracle. Mapping the atlas guarantee into this form gives, at best, $\gamma=1$ and $\varepsilon_0=1-2\gamma_P(s)$, which is close to $1$ when the weak advantage is merely inverse-polynomial. That makes the final excess guarantee vacuous. Choosing a smaller multiplicative $\gamma$ does not fix this, since the additive slack still has to be at least about $1-2\gamma_P(s)$ for low-correlation distributions.

Conclusion: Feldman/Ghai prove a plausible strengthened edge, but not this atlas edge.

## Near Miss 2: da Cunha--Hogsgaard--Paudice 2026

The da Cunha--Hogsgaard--Paudice theorem is closer to the fixed-additive setting. Their agnostic weak learner condition is
$$
\operatorname{corr}_{\mathcal D}(W)
\ge \gamma_0 \sup_{f\in\mathcal F}\operatorname{corr}_{\mathcal D}(f)-\varepsilon_0
$$
with only the nontriviality condition $\gamma_0>\varepsilon_0$. The atlas source can be viewed as this condition with $\gamma_0=1$ and $\varepsilon_0=1-2\gamma_P(s)$, so the margin parameter is
$$
\theta = (\gamma_0-\varepsilon_0)/2 = \gamma_P(s).
$$

This is the strongest positive evidence I found. However it still does not resolve the atlas efficient marginal-nonuniform edge, for three reasons.

First, the running time is not polynomial in the atlas sense when the weak learner's own sample size and advantage depend on the representation size. The theorem's main algorithm calls the weak learner on all subsequences of length $m_0$ and has a running-time term of the form
$$
n^{O(m_0\min\{d^*,\log n\}/\theta^2)}
$$
up to hypothesis-evaluation factors. In this edge, $m_0=p_P(s,O(1))$ and $1/\theta=1/\gamma_P(s)$ may both be polynomial in $s$. Then the exponent is polynomial in $s$, so the resulting time is generally $n^{\operatorname{poly}(s)}$, not a polynomial in $(s,1/\varepsilon,\log(1/\delta))$ with fixed degree.

Second, the theorem is stated for a weak learner with a controlled base class $\mathcal H$ and finite VC/dual-VC parameters. A generic improper computational learner has an output representation, so one might try to upper-bound these parameters by the number of possible outputs in a time bound. But doing that still feeds into the exponent above and does not recover an atlas-polynomial runtime.

Third, the algorithmic calls are not as cleanly original-marginal-preserving as Feldman/Ghai label-only boosting. The proof enumerates weak-learner outputs on subsequences of a training sample. For a distribution-free oracle this is fine. For a marginal-nonuniform source, correctness and runtime guarantees for calls associated with empirical or induced marginals are not automatically controlled by the polynomial attached to the original marginal $P$. This is the same local-uniformity issue recorded in `marginal-boosting-open`.

Conclusion: da Cunha et al. explain why the fixed-additive source is conceptually boostable, but the quantitative runtime and marginal-bookkeeping losses are too large for this atlas target.

## Counterexample Search

I did not find a concrete false witness.

Halfspaces are the obvious strong-target failure candidate because Tiegel's distribution-specific hardness rules out strong marginal-nonuniform agnostic improper learning under worst-case lattice assumptions. But this does not establish the source: the lower bound is about achieving small excess $\varepsilon$, while the atlas source only asks for a fixed additive tolerance close to $1/2$. The existing definition note also says the halfspace hardness does not settle this exact weak marginal-nonuniform node.

Noisy parity-style candidates have the opposite problem. They can make strong agnostic learning hard, but when $\operatorname{OPT}$ is very small, the source requires nontrivial correlation. That is already the hard part for noisy parities, so they do not obviously satisfy the source.

Finite lookup or constraint-system candidates tend to collapse on the improper side: once the relevant active domain is polynomial-sized, empirical majority/ERM over the lookup table gives strong agnostic improper learning rather than only weak learning.

An oracle diagonalization could assign unrelated bad polynomials to all boosted or reweighted marginals while keeping the original $P$ easy, but that is not an atlas counterexample unless realized by a single concrete concept class and one uniform learner satisfying the source for every marginal.

## Proposed Atlas Update

Do not change the edge status. If updating the note, I would keep:

```yaml
status: "open"
evidence: unknown
family: agnostic-boosting-open
```

Suggested summary refinement:

> Open: label-only distribution-specific agnostic boosting would preserve the original marginal but needs a tunable correlation-style weak oracle; the fixed-additive atlas source is only covered by known boosters with non-polynomial parameter dependence or uncontrolled induced-marginal bookkeeping.

Suggested body addition:

> The closest fixed-additive positive route is da Cunha--Hogsgaard--Paudice 2026. Translating the source gives their nontriviality gap $\theta=\gamma_P(s)$, but their runtime has exponent depending on the weak sample size and $1/\theta^2$. Since these may be polynomial in the representation size, the resulting bound is generally $n^{\operatorname{poly}(s)}$, not an atlas-polynomial bound in $(s,1/\varepsilon,\log(1/\delta))$. Feldman 2010 and Ghai--Singh 2025 are better for marginal preservation because their weak calls keep the feature marginal fixed, but their oracle requires tunable correlation slack rather than the atlas fixed-additive tolerance.

## Next Directions

1. Add or use a strengthened node for marginal-nonuniform correlation-style weak agnostic improper learning with tunable slack. The edge from that node to strong marginal-nonuniform agnostic improper learning should likely be true via Feldman or Ghai--Singh, because the weak calls preserve the original feature marginal.

2. Look for a polynomial-parameter version of da Cunha--Hogsgaard--Paudice: runtime polynomial in $m_0$, $1/\theta$, VC/dual-VC quantities, and $1/\varepsilon$, rather than with those quantities in the exponent. Such a theorem would be a serious candidate to resolve this edge true.

3. Try to build a concrete class that is easy in the low-noise/fixed-additive weak sense but hard for fine agnostic excess error under one fixed marginal. The witness would need to satisfy the source uniformly over all marginals, so standard noisy-parity and halfspace examples are not enough as-is.

4. Clarify whether the atlas runtime convention for marginal-nonuniform learners is worst-case over all samples of the given length or only high-probability under the relevant marginal. The former would make some empirical-subsequence calls less problematic, but still would not repair the da Cunha exponent.

## Verdict

verdict: unresolved-open

confidence: 0.78

## Additional Depth-2 Entry - 2026-05-05

### Question

Can the hidden fixed additive slack in the source be found or adapted by a marginal-nonuniform search, or can a false witness encode an unknown slack/exponent barrier?

### Sources Checked

I reread the edge file, both endpoint definitions, `agnostic-boosting-open`, `marginal-boosting-open`, the May 4 same-edge scratchpad, and the current scratchpad above. I also checked the TeX/source or abstract-level statements for Feldman 2010, Ghai--Singh 2025, da Cunha--Hogsgaard--Paudice 2025/2026. The relevant source facts were:

- Feldman preserves the instance marginal by relabeling, but his threshold weak learner must work at a chosen threshold scale.
- Ghai--Singh use a correlation weak learner and relabeling/distribution-specific calls, but the final excess contains a term proportional to the weak oracle's additive correlation slack divided by the multiplicative advantage.
- da Cunha--Hogsgaard--Paudice allow any nontrivial correlation gap, so they are closest to the fixed-additive source, but their improved-time theorem still has weak-learner parameters in the exponent, e.g. weak-call count/running time terms like $n^{m_0+O(1)}$ and $n^{O(m_0\min\{d^*,\log n\}/\theta^2)}$.

### Hidden Slack Is Searchable, But Not Shrinkable

Let the source tolerance for marginal $P$ be
$$
\beta_P(s)=1/2-\gamma_P(s)
$$
with $\gamma_P(s)$ inverse-polynomial under some marginal-dependent polynomial. In correlation form the source gives
$$
\operatorname{corr}(h)\ge \sup_{c\in\mathcal C}\operatorname{corr}(c)-2\beta_P(s),
$$
so it is a da-Cunha-style nontrivial correlation weak learner with parameters $\gamma_0=1$, $\varepsilon_0=2\beta_P(s)$, and gap
$$
\theta=(\gamma_0-\varepsilon_0)/2=\gamma_P(s).
$$

The fact that $\gamma_P(s)$ and the degree of its inverse-polynomial lower bound are hidden does not look like a real obstruction in the marginal-nonuniform target. If a fully polynomial booster existed with runtime polynomial in $m_0$, the weak learner runtime, $1/\theta$, $1/\varepsilon$, and $\log(1/\delta)$, then a uniform target learner could dovetail over guesses for:

- the weak sample/time budget;
- the exponent $d$ in a candidate lower bound $\theta\ge s^{-d}$;
- booster parameters and confidence splits.

For a fixed marginal $P$, one of those guesses would eventually dominate the true marginal-dependent weak parameters. Running all smaller guesses and selecting among the resulting candidate hypotheses by a holdout sample would only multiply the runtime by another marginal-dependent polynomial. The target definition allows exactly this: the final polynomial may depend on $P$ and can have the hidden degree needed for that marginal.

So "the booster does not know the slack" is not enough for a false edge. Unknown inverse-polynomial exponents are absorbable by marginal-nonuniform search, at least when the underlying booster is genuinely polynomial in those parameters and produces a finite polynomial-size candidate list that can be validated.

What search cannot do is make the fixed slack tunable. Feldman/Ghai-style routes that need additive correlation slack at the final scale, e.g. $\varepsilon_0=O(\gamma\varepsilon)$, are not repaired by guessing $\gamma_P(s)$: the source only supplies the fixed $\varepsilon_0=2\beta_P(s)$, which may be close to $1$. A search can find the weak edge; it cannot lower the additive slack below what the source guarantees.

### Why This Still Does Not Resolve True

The da Cunha route is the right conceptual match because it only needs a nontrivial gap $\theta>0$, not $\varepsilon_0=O(\varepsilon)$. If its runtime were fully polynomial in all weak-learner parameters, the hidden-slack search above would likely turn the edge true.

The current theorem does not give that. In the atlas setting, $m_0$ and $1/\theta$ may be marginal-dependent polynomials in $s$. A term such as
$$
n^{O(m_0\min\{d^*,\log n\}/\theta^2)}
$$
then becomes roughly $(\operatorname{poly}(s,1/\varepsilon))^{\operatorname{poly}(s)}$ in the worst case, not a polynomial in $(s,1/\varepsilon,\log(1/\delta))$ with fixed exponent for that marginal. Enumerating guesses for $m_0$ and $\theta$ cannot change this exponent barrier.

There is also still a representation/capacity mismatch. The atlas source permits arbitrary improper outputs from a time-bounded learner. One possible way to control this is to define the budgeted output class of all hypotheses the weak learner can print within budget $B$; its description length is at most $B$, so a theorem depending polynomially on $\log|\mathcal H_B|$ or VC-like dimension of budgeted circuits might be usable. But the available nontrivial-gap theorem places these quantities in an exponent or requires finite/dual-VC structure not present in the node.

### Why This Does Not Resolve False

An "unknown exponent" counterexample is also too weak. A class where the weak advantage under $P$ is only $s^{-d(P)}$ still fits a marginal-dependent polynomial target if a strong learner can be built in time $s^{O(d(P))}\operatorname{poly}(1/\varepsilon)$. The learner need not know $d(P)$ in advance; dovetailing plus validation can absorb it.

A real false witness would need more: for some fixed marginal $P_0$, strong agnostic improper learning must require super-polynomial time in $(s,1/\varepsilon)$, while the fixed-additive weak source still holds for every marginal. The usual candidates still fail this shape. Halfspace/lattice, parity/LPN, PRF, and monomial hardness tend to rule out weak prediction when $\operatorname{OPT}$ is small, killing the source. CSP, clustering, and signed-disagreement approximation templates either address proper optimization or live on polynomial-size domains where an improper learner can estimate labels pointwise.

### Proposed Atlas Update

Keep the edge open:

```yaml
status: "open"
evidence: unknown
family: agnostic-boosting-open
```

Sharper summary:

> Open: the hidden fixed weak slack is searchable under marginal-nonuniform polynomial conventions, and the fixed-additive source gives a nontrivial correlation gap, but known agnostic boosters either require tunable additive correlation slack or place weak-learner parameters in the runtime exponent; no source-positive improper hardness witness is known.

Suggested body sentence:

> The obstruction is not merely that $\gamma_P(s)$ is unknown. A marginal-nonuniform learner could dovetail over inverse-polynomial guesses and validate candidates if a booster were polynomial in $1/\gamma_P(s)$ and the weak learner's sample/runtime parameters. The missing ingredient is such a fully polynomial nontrivial-gap agnostic booster, or else a concrete class where fixed-additive weak agnostic improper learning holds for every marginal but strong improper agnostic learning is hard under one fixed marginal.

### Concrete Depth-3 Directions

1. Try to prove a fully polynomial version of the nontrivial-correlation agnostic booster: runtime polynomial in $m_0$, weak-evaluation time, $1/\theta$, capacity of the weak output class, $1/\varepsilon$, and $\log(1/\delta)$, with relabeling-only calls that preserve the original marginal. If this exists, combine it with dovetailing over hidden $m_0,\theta$ and holdout validation to resolve the edge true.

2. Formalize the budgeted-output-class route for improper weak learners. For a weak learner run with budget $B$, all printable hypotheses have descriptions of length at most $B$. Check whether existing Ghai/da-Cunha analyses can be restated with polynomial dependence on this budgeted class size/dimension rather than exponentiating it.

3. Separate "unknown slack" from "super-polynomial strong hardness" in any false attempt. A valid counterexample must not merely hide a polynomial exponent in $P$; it must force every strong improper learner to take super-polynomial time under some fixed $P_0$ while preserving the weak source for all marginals.

4. Search for exponential-domain coding or decoding classes with an efficient additive-$\beta<1/2$ agnostic decoder for every marginal but hard additive-$\varepsilon$ decoding under a fixed marginal, and make sure the hardness rules out arbitrary improper binary hypotheses rather than only proper codewords.

5. Build an oracle/black-box separation as a diagnostic only: construct an oracle where fixed-additive weak access with hidden slack cannot be boosted in fully polynomial black-box time. This would not settle the atlas edge, but it could identify which part of a concrete class construction must prevent dovetailing/validation from succeeding.

## Verdict

verdict: unresolved-open

confidence: 0.82

## Additional Depth-3 Resolution Entry - 2026-05-05

### Short Verdict

This edge should be marked `false`, conditionally on the same worst-case lattice hardness assumption already used in the atlas halfspace notes.

The earlier obstruction analysis was right about fixed-additive weak learners not giving the Feldman/Ghai correlation oracle, but it missed an existing atlas route that establishes the source for halfspaces: low-noise weak agnostic robustification from distribution-free realizable proper learning. Combining that with Tiegel's standard-Gaussian distribution-specific agnostic halfspace hardness gives a counterexample to this exact edge.

### Why Fixed Additive Still Does Not Become A Tunable Correlation Oracle

Let labels be in $\{\pm 1\}$ and let
$$
C_{\mathcal D}=\sup_{c\in\mathcal C}\operatorname{corr}_{\mathcal D}(c).
$$
If the source weak learner has tolerance
$$
\beta_P(s)=1/2-\gamma_P(s),
$$
then its guarantee is only
$$
\operatorname{corr}_{\mathcal D}(h)
\ge C_{\mathcal D}-2\beta_P(s)
= C_{\mathcal D}-1+2\gamma_P(s).
$$

Thus it gives positive correlation only when $C_{\mathcal D}>1-2\gamma_P(s)$, i.e. when the induced task is almost realizable. This is exactly enough for low-noise robustification, but not enough for Feldman/Ghai-style potential boosting, where the weak learner must be useful on relabeled residual distributions whose best correlation can be merely moderate.

Equivalently, the fixed-additive source can be viewed as a da-Cunha-style weak learner with $\gamma_0=1$ and $\varepsilon_0=1-2\gamma_P(s)$, but it cannot be converted to a Ghai/Feldman oracle with additive slack $O(\varepsilon)$ unless the source itself supplies a tunable $\beta_P(s,\varepsilon)$. Search over hidden exponents can find $\gamma_P(s)$, but it cannot shrink the slack $1-2\gamma_P(s)$.

### Counterexample

**Goal.** Refute
$$
\text{efficient-marginal-nonuniform-weak-agnostic-improper-pac}
\Rightarrow
\text{efficient-marginal-nonuniform-agnostic-improper-pac}.
$$

**Witness class.** Let $\mathcal C$ be Boolean halfspaces over $\mathbb R^d$, represented by a weight vector and threshold.

**Why the source holds.** Halfspaces are efficiently realizably properly PAC learnable distribution-free: on a realizable sample, find a separating halfspace by linear feasibility and use the VC dimension of halfspaces for generalization.

The atlas already records the theorem
$$
\text{efficient-realizable-proper-pac}
\Rightarrow
\text{efficient-marginal-nonuniform-weak-agnostic-improper-pac}
$$
under `low-noise-weak-agnostic-robustification`. Applying that theorem to halfspaces gives the exact source of this edge. The resulting weak agnostic learner is allowed to have only an inverse-polynomial marginal-dependent gap, and it is designed to be useful mainly in the low-noise regime; it need not solve the full agnostic halfspace problem.

**Why the target fails.** Tiegel 2023 proves, under worst-case lattice hardness, distribution-specific hardness for agnostically learning halfspaces under the standard Gaussian marginal. In the atlas formulation already used by neighboring implication notes, for every constant $\beta>0$, learning to error
$$
\operatorname{OPT}_{\mathrm{LTF}}+\varepsilon
$$
under the standard Gaussian marginal requires time
$$
d^{\widetilde{\Omega}(1/\varepsilon^{2-\beta})}.
$$
This is not polynomial in $(d,1/\varepsilon)$ for that fixed marginal. Since the target node requires one marginal-dependent polynomial for the standard Gaussian marginal family, the target fails.

**Conclusion.** Halfspaces satisfy the source but fail the target under the stated lattice assumption. The edge is therefore conditionally false. The additive-vs-correlation mismatch is still a useful explanation of why a direct booster cannot be cited, but a stronger conclusion is available: the atlas source is broad enough to include low-noise robustified halfspace learners, while the target is ruled out by Tiegel's strong agnostic hardness.

### Proposed Atlas Update

Proposed frontmatter:

```yaml
status: "false"
evidence: conditional-counterexample
assumptions:
  - worst-case lattice hardness
witnesses:
  - halfspaces
ref_keys:
  - tiegel2023
  - valiant1984
  - blumer1989
family: halfspace-agnostic-hardness
```

Suggested summary:

> False under worst-case lattice hardness: halfspaces satisfy the weak marginal-nonuniform agnostic improper source via low-noise robustification from efficient realizable proper learning, but Tiegel's standard-Gaussian distribution-specific hardness rules out the strong marginal-nonuniform agnostic improper target.

Suggested proof body:

> Use Boolean halfspaces. They are efficiently realizably properly PAC learnable by linear feasibility plus VC generalization. By the low-noise weak agnostic robustification argument, this implies efficient marginal-nonuniform weak agnostic improper PAC learning with an inverse-polynomial marginal-dependent weak gap. However, Tiegel's lattice-based hardness result rules out polynomial-time agnostic improper learning of halfspaces to excess $\varepsilon$ under the standard Gaussian marginal, with lower bound $d^{\widetilde{\Omega}(1/\varepsilon^{2-\beta})}$ for every constant $\beta>0$. This contradicts the target's required polynomial bound for that fixed marginal.

### Caveat To Check Before Editing Atlas

The update should cite the existing `low-noise-weak-agnostic-robustification` argument for the source, not claim that the fixed-additive weak halfspace learner is obtained by Feldman/Ghai boosting. The source learner is a low-noise robustification of realizable learning; the target failure is the standard-Gaussian strong agnostic hardness.

## Verdict

verdict: resolved-false

confidence: 0.88
