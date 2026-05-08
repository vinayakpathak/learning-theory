---
type: implication
id: efficient-weak-realizable-proper-pac__implies__efficient-marginal-nonuniform-weak-agnostic-proper-pac
source: efficient-weak-realizable-proper-pac
target: efficient-marginal-nonuniform-weak-agnostic-proper-pac
source_note: "[[efficient-weak-realizable-proper-pac|Efficient Weak Realizable Proper PAC Learning]]"
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
summary: "Open: the distribution-free source gives a uniform low-noise agnostic robustification by clean-transcript coupling, but the middle-noise regime still needs a same-marginal proper neutralizer or hidden disagreement-region selector. No known witness blocks all neutral proper outputs while preserving distribution-free clean weak proper learning."
family: marginal-agnostic-hardness-open
axis_delta:
  resource: same
  distribution: distribution-free-to-marginal-nonuniform
  strength: same
  realizability: realizable-to-agnostic
  properness: same
argument_note: "[[marginal-agnostic-hardness-open|Marginal-Nonuniform Agnostic Hardness Open]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Realizable Proper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning

## Verdict

`open`.

Open. Clean weak proper learning gives a uniform low-noise branch by coupling, but it does not supply the middle-noise proper selector needed for arbitrary agnostic labels.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,c(X))$ with $X\sim P$ and $c\in\mathcal C$, confidence parameter $\delta\in(0,1)$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every marginal $P$ and target $c\in\mathcal C$, the guarantee is $\Pr_{X\sim P}[h(X)\ne c(X)]\le 1/2-\gamma(s)$. There is one polynomial $p$ and an inverse-polynomial weak gap $\gamma(s)>0$, independent of $P$ and $c$, such that the worst-case sample size and running time are bounded by $p(s,\log(1/\delta))$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+1/2-\gamma_P(s)$. For every marginal $P$ there is a polynomial $p_P$ and an inverse-polynomial weak gap $\gamma_P(s)>0$ such that the worst-case sample size and running time are bounded by $p_P(s,\log(1/\delta))$; the same learner works for all marginals, and $p_P$ and $\gamma_P$ may depend on $P$ but not on the conditional label distribution or $\delta$.

Open problem: Does every binary concept class satisfying the source guarantee also satisfy the target guarantee?

## Proof Status

**Goal.** Decide whether an efficient distribution-free weak realizable proper learner yields an efficient marginal-nonuniform weak agnostic proper learner.

**Uniform low-noise branch.** Let the source learner have uniform clean advantage $\gamma(s)$ and sample bound $m(s,\log(1/\delta))$. If the agnostic labels have error below the inverse transcript scale relative to a near-optimal concept $c^\star$, a noisy source call agrees with a clean call on labels $c^\star(X)$ with inverse-polynomial probability. Repetition and validation over proper outputs give

$$
\operatorname{err}_{\mathcal D}(h)
\le
\operatorname{OPT}_{\mathcal C}(\mathcal D)
+\frac12-\Omega(\gamma(s)).
$$

This part is positive, and distribution-freeness makes it uniform over marginals.

**Middle-noise obstruction.** When $\operatorname{OPT}_{\mathcal C}(\mathcal D)$ is above the low-noise scale, the target is satisfied by any legal hypothesis with roughly nonnegative correlation against the regression $r(x)=\mathbf E[Y\mid X=x]$. Clean weak proper learning does not supply a validation-searchable legal constant, complement, balanced sampler, proper shadow cover, or OPT-relative selector. If a proper candidate $h$ fails, a near-optimal comparator identifies a profitable hidden disagreement region

$$
D_{h,c^\star}=\{x:c^\star(x)\ne h(x)\}.
$$

The needed repair is weak optimization of

$$
\mathbf E_P[-r(X)h(X)\mathbf 1_D(X)]
$$

over legal disagreement regions $D\in\Delta_h=\{D_{h,g}:g\in\mathcal C_s\}$. The source learner works once a clean legal target on a chosen marginal is available; it does not find this signed region from agnostic labels.

**Regional complements.** The observable failure filter $F=\{Y\ne h(X)\}$ has labels clean for $-h$, not for the hidden comparator. A source call on the filter is therefore justified only under extra structure: legal complements, searchable regional complements, or proper patching. These are neutralizer assumptions in another form.

**Why current witnesses miss.** Parity, LPN, and code constructions leak neutral wrong proper hypotheses in the middle-noise regime. Halfspaces have legal constants, and known hardness targets a stronger accuracy requirement. Point-function and monotone examples show that missing complements do not matter unless a legal profitable patch exists. PCP, hard-slice, and handle templates either break distribution-free clean weak learning on concentrated marginals or add public fallbacks that solve the agnostic weak target.

**Missing lemma.** A positive resolution would derive a same-$P$ proper neutralizer or disagreement-region selector from distribution-free weak realizable proper learning. A negative resolution would require a fixed-marginal no-neutral-output witness: exact clean labels remain distribution-free weak properly learnable, but every proper output meeting the weak OPT-relative agnostic threshold decodes a hidden hard patch.

**Conclusion.** The implication remains open in `marginal-agnostic-hardness-open`; the unresolved subproblem is the proper-output middle-noise branch under fixed marginals.

## References

- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Hanneke et al. 2025](https://openreview.net/forum?id=aoVCFtox89)
- [Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)
