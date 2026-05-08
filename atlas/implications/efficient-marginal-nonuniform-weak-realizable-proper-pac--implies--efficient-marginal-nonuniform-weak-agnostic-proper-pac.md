---
type: implication
id: efficient-marginal-nonuniform-weak-realizable-proper-pac__implies__efficient-marginal-nonuniform-weak-agnostic-proper-pac
source: efficient-marginal-nonuniform-weak-realizable-proper-pac
target: efficient-marginal-nonuniform-weak-agnostic-proper-pac
source_note: "[[efficient-marginal-nonuniform-weak-realizable-proper-pac|Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]]"
target_note: "[[efficient-marginal-nonuniform-weak-agnostic-proper-pac|Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - benedek1991fixed
  - hanneke2025marginalnonuniform
  - tiegel2023
refs:
  - "[Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)"
  - "[Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)"
  - "[Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)"
summary: "Open. The implication is true in the low-noise same-marginal regime and true for classes with a validation-searchable proper shadow cover or proper neutralizer, but the source node alone does not appear to provide such an object. The unresolved middle-noise case is a proper selector problem; existing parity/code/LPN-style hardness does not refute the edge because neutral wrong hypotheses already meet the weak additive target."
family: marginal-agnostic-hardness-open
axis_delta:
  resource: same
  distribution: same
  strength: same
  realizability: realizable-to-agnostic
  properness: same
argument_note: "[[marginal-agnostic-hardness-open|Marginal-Nonuniform Agnostic Hardness Open]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning

## Verdict

`open`.

Open. Same-marginal low-noise coupling handles the near-realizable branch, but the middle-noise agnostic branch needs a legal proper shadow, neutralizer, or selector that is not supplied by the weak realizable source.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le 1/2-\gamma_P(s)$. For every marginal $P$ there is a polynomial $p_P$ and an inverse-polynomial weak gap $\gamma_P(s)>0$ such that the worst-case sample size and running time are bounded by $p_P(s,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ and $\gamma_P$ may depend on $P$ but not on the target concept or $\delta$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+1/2-\gamma_P(s)$. For every marginal $P$ there is a polynomial $p_P$ and an inverse-polynomial weak gap $\gamma_P(s)>0$ such that the worst-case sample size and running time are bounded by $p_P(s,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ and $\gamma_P$ may depend on $P$ but not on the conditional label distribution or $\delta$.

Open problem: Does every binary concept class satisfying the source guarantee also satisfy the target guarantee?

## Proof Status

**Goal.** Decide whether a weak realizable proper learner for each fixed marginal yields a weak agnostic proper learner for that same fixed marginal.

Use $\{\pm1\}$ labels and fix the marginal $P$. Let

$$
M(r)=\sup_{c\in\mathcal C_s}\langle r,c\rangle_P.
$$

The target is equivalent to finding $h\in\mathcal C_s$ with

$$
\langle r,h\rangle_P\ge M(r)-1+2\alpha_P(s)
$$

for some inverse-polynomial, marginal-dependent $\alpha_P(s)$.

**Low-noise branch.** For a fixed marginal $P$, one can couple a noisy run to a clean realizable run on the same $P$-distributed instance sequence. If a near-optimal proper comparator $c^\star$ has agnostic error below the inverse sample scale of the source learner, then an invocation of the realizable learner on the noisy sample agrees with a clean realizable invocation with inverse-polynomial probability. Since this coupling uses the same $P$-distributed instances, the source guarantee applies directly. Repetition and holdout validation give a deterministic proper $h$ satisfying the weak agnostic bound.

**Legal-neutralizer branch.** For larger noise, the standard improper fallback would use constants, but constants need not be legal proper hypotheses. The same regime is solved under any additional legal proper neutralizer or shadow-cover hypothesis: legal constants, complement-pair anchors, balanced samplers over deterministic proper hypotheses, or a $P$-polynomial list intersecting the weak $P$-shadow of every concept. The atlas source definition does not include any of these structures.

**Why local handles do not globalize.** Every-marginal clean weak proper learning gives local proper completions on point masses and finite supports. Those completions may behave adversarially off support under the original marginal $P$, and marginal-nonuniform runtimes for auxiliary trace marginals do not automatically give a $P$-polynomial global candidate generator. Validation selects among candidates; it does not create a missing deterministic proper shadow or neutral hypothesis.

**Why current witnesses miss.** Conversely, no atlas-ready false witness is known. A separation would need a hard class where exact clean labels enable weak proper learning under every marginal, but noisy labels make it hard to output even a neutral deterministic proper hypothesis. Standard LPN, noisy parity, nearest-codeword, one-way-handle, and pure code-distance constructions fail because they leak either clean shadows, legal handles, or neutral wrong hypotheses. Ordinary recovery hardness is not enough: in the middle-noise regime, wrong but neutral proper hypotheses already satisfy the weak additive target.

**Missing lemma.** A positive resolution would follow from a fixed-marginal proper weak selector theorem: from samples with regression $r$, produce $h\in\mathcal C_s$ with correlation within the weak threshold of $M(r)$, or at least produce a validation-searchable neutral proper sampler whenever $M(r)$ is small. A negative resolution would need no-neutral-sampler hardness: every efficient deterministic proper output with correlation at least $-1/\operatorname{poly}(s)$ would have to decode the hidden witness, while exact clean labels remain weakly properly learnable under every marginal.

**Conclusion.** The edge remains open pending either a proper neutralizer/selector theorem or a residual-block witness that blocks neutral proper outputs without breaking the weak realizable source.

## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
- [Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)
