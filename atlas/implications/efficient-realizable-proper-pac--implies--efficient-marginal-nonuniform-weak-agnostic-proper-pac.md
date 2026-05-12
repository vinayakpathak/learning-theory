---
type: implication
id: efficient-realizable-proper-pac__implies__efficient-marginal-nonuniform-weak-agnostic-proper-pac
source: efficient-realizable-proper-pac
target: efficient-marginal-nonuniform-weak-agnostic-proper-pac
source_note: "[[efficient-realizable-proper-pac|Efficient Realizable Proper PAC Learning]]"
target_note: "[[efficient-marginal-nonuniform-weak-agnostic-proper-pac|Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - benedek1991fixed
  - hopkins2024
  - hanneke2025marginalnonuniform
  - tiegel2023
refs:
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
  - "[Hopkins et al. 2024](https://doi.org/10.46298/theoretics.24.2)"
  - "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
  - "[Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)"
summary: "Open: the edge follows from the unresolved weak-realizable proper core edge, and the strong source handles the low-noise branch by clean-transcript coupling, but trace-cover, pseudo-label projection, and agnostic-boosting routes do not supply the required polynomial-time same-marginal proper selector in the middle-noise regime."
family: marginal-agnostic-hardness-open
axis_delta:
  resource: same
  distribution: distribution-free-to-marginal-nonuniform
  strength: strong-to-weak
  realizability: realizable-to-agnostic
  properness: same
argument_note: "[[marginal-agnostic-hardness-open|Marginal-Nonuniform Agnostic Hardness Open]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Realizable Proper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning

## Verdict

`open`.

Open. The low-noise branch is resolved by coupling a noisy run to a clean realizable run of the proper learner. The unresolved part is the middle-noise regime, where the target needs a same-marginal legal proper selector rather than clean decoding.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le\varepsilon$. There is one polynomial $p$, independent of $P$ and $c$, such that the worst-case sample size and running time are bounded by $p(s,1/\varepsilon,\log(1/\delta))$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+1/2-\gamma_P(s)$. For every marginal $P$ there is a polynomial $p_P$ and an inverse-polynomial weak gap $\gamma_P(s)>0$ such that the worst-case sample size and running time are bounded by $p_P(s,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ and $\gamma_P$ may depend on $P$ but not on the conditional label distribution or $\delta$.

Open problem: Does every binary concept class satisfying the source guarantee also satisfy the target guarantee?

## Proof Status

**Goal.** Decide whether strong realizable proper learning implies weak agnostic proper learning under each fixed marginal.

**Low-noise branch.** Let $A$ be the efficient distribution-free strong realizable proper learner. Run $A$ at clean accuracy $1/32$ and let $m_0(s)$ bound the number of inspected labels. Set

$$
\alpha_A(s)=\min\{1/64,1/(128m_0(s))\}
$$

and choose an inverse-polynomial $\gamma_P(s)\le\min\{1/64,\alpha_A(s)/8\}$. If $\operatorname{OPT}_{\mathcal C}(\mathcal D)<\alpha_A(s)$, couple samples from $\mathcal D$ to clean samples from a near-optimal $c^\star\in\mathcal C$ under the same marginal $P$. With constant probability no inspected label is corrupted, so the noisy transcript is a successful clean transcript and the proper output has error at most

$$
\operatorname{OPT}_{\mathcal C}(\mathcal D)+3/64.
$$

Repetition and holdout validation give a legal weak agnostic candidate. This resolves the low-noise branch.

**Reduction to the weak-realizable core.** This edge is implied by the unresolved core edge [[efficient-weak-realizable-proper-pac|Efficient Weak Realizable Proper PAC Learning]] $\Rightarrow$ [[efficient-marginal-nonuniform-weak-agnostic-proper-pac|Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning]], because strong realizable proper learning immediately gives weak realizable proper learning by running the source learner to any fixed constant accuracy. The reduction is one-way: the strong source gives additional fixed-$P$ trace-cover intuition, but the depth-8 search found no way to convert that implicit cover into the needed effective selector.

**Selector equivalence.** In the remaining regime $\eta=\operatorname{OPT}_{\mathcal C}(\mathcal D)\ge\alpha_A(s)$, the missing object is a fixed-marginal middle-noise selector: a $P$-polynomial algorithm that outputs a polynomial list of proper concepts containing some $h$ with

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\frac12-4\gamma_P(s).
$$

Combining such a list with the low-noise list and validating $O(\gamma_P^{-2}\log(B/\delta))$ candidates proves the target. Conversely, any target learner gives a singleton selector after shrinking constants. Thus this selector is theorem-equivalent to the unresolved middle-noise content of the edge. Equivalently, since $\gamma_P\le\alpha_A/8$, it would suffice in the middle-noise branch to find any proper $h$ with correlation at least $-\alpha_A(s)$ against the agnostic labels.

**Why the source does not supply the selector.** The realizable proper learner is only constrained on realizable labeled distributions. Off-promise calls on arbitrary, residual, random, or filtered labels can behave adversarially without violating the source node. Used safely, the learner is only a clean promise-extension oracle: it can realize a clean trace after the trace or label corrections have been guessed. In middle noise, source-scale clean subsamples are exponentially rare, while small clean subsamples do not force global weak correlation. Fixed-marginal VC covers, compression, or trace enumeration need additional effectivity assumptions.

**Strong-source near misses.** Pseudo-label projection would work only with an extra tolerant or agnostic proper projection oracle. Strong realizable learning is off-promise on pseudo-labels generated by an improper predictor, and even ideal unweighted projection can optimize the wrong objective for agnostic proper learning. Benedek--Itai style fixed-distribution finite covers give the sample-level intuition, but the current computational source does not control the size, enumerability, or proper projection complexity of the cover.

**Why current witnesses miss.** Parity and LPN examples leak neutral wrong hypotheses. Code and planted-code guards run into Bessel/Gram barriers or balanced samplers. One-way and PRF templates either force the clean learner to recover the secret on some marginal or legalize a nonsecret weak handle. PCP and active-slice constructions either encode the hard instance in the marginal, dilute the hard slice, or leave wrong-instance handles. Finite-support set-system templates make exact optimization hard but generally have defaults, local moves, approximations, or balanced samplers inside the additive $1/2-\gamma$ window; removing those handles tends to break clean promise extension.

**Missing negative primitive.** A false result would need a fixed-marginal weak signed-search construction: efficient clean proper promise extension, one fixed marginal for all hard labels, and hardness of finding any legal proper hypothesis with correlation at least $-1/\operatorname{poly}(s)$, with no constants, complements, neutral samplers, defaults, local moves, wrong-code handles, or wrong-instance handles. No standard hardness template currently provides this.

**Depth-9 final check.** The final pass confirmed that strong clean learning adds useful trace-cover intuition but not the missing agnostic primitive. Calls to the source on agnostic labels, residual labels, random labels, or pseudo-labels are off-promise; calls on genuinely clean labels require guessing or enumerating clean traces. Any later amplification step can use a selector once one exists, but it does not create a same-$P$ proper selector from a purely realizable proper learner.

**Conclusion.** The edge remains open. The realizable proper source proves same-marginal low-noise robustification, but the middle-noise proper selector is neither implied by the source definition nor refuted by known fixed-marginal counterexample templates.

## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Hopkins et al. 2024](https://doi.org/10.46298/theoretics.24.2)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
- [Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)
