---
type: implication
id: efficient-weak-agnostic-proper-pac__implies__efficient-agnostic-improper-pac
source: efficient-weak-agnostic-proper-pac
target: efficient-agnostic-improper-pac
source_note: "[[efficient-weak-agnostic-proper-pac|Efficient Weak Agnostic Proper PAC Learning]]"
target_note: "[[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "open"
evidence: unknown
assumptions: []
witnesses: []
ref_keys:
  - bendavid2001
  - kalai2008agnosticboosting
  - gavinsky2003
  - ghai2025agnosticboosting
  - dacunha2026agnosticboosting
  - tiegel2023
refs:
  - "[Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)"
  - "[Kalai et al. 2008](https://doi.org/10.1145/1374376.1374466)"
  - "[Gavinsky 2003](https://www.jmlr.org/papers/v4/gavinsky03a.html)"
  - "[Ghai and Singh 2025](https://proceedings.mlr.press/v267/ghai25a.html)"
  - "[da Cunha et al. 2026](https://arxiv.org/abs/2601.11265)"
  - "[Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)"
summary: "Open: fixed-additive proper weak agnostic learning gives a nontrivial constant-slack oracle and is boostable statistically or with fixed weak parameters, but known fixed-slack boosters use clean-witness enumeration with representation-dependent exponents; no fixed-gap class separation is known."
family: agnostic-boosting-open
axis_delta:
  resource: same
  distribution: same
  strength: weak-to-strong
  realizability: same
  properness: proper-to-improper
argument_note: "[[agnostic-boosting-open|Agnostic Boosting Open]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Agnostic Proper PAC Learning $\Rightarrow$ Efficient Agnostic Improper PAC Learning

## Verdict

`open`.

Open as an efficient PAC implication. The statistical or fixed-parameter oracle version is essentially settled by recent agnostic boosting, but the known running-time bounds do not give the representation-uniform polynomial-time reduction required by this atlas node.

## Theorem Statement

Let $\mathcal C$ be a binary concept class over an instance space $\mathcal X$, with representation-size parameter $s$; all errors are zero-one errors.

The **source guarantee** is: there is a single learner $A$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, outputs a hypothesis $h\in\mathcal C$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+1/2-\gamma(s)$. There is one polynomial $p$ and an inverse-polynomial weak gap $\gamma(s)>0$, independent of $P$ and $\mathcal D$, such that the worst-case sample size and running time are bounded by $p(s,\log(1/\delta))$.

The **target guarantee** is: there is a single learner $B$ that, given i.i.d. examples $(X,Y)\sim\mathcal D$ from an arbitrary joint distribution on $\mathcal X\times\{0,1\}$, with instance marginal $P=\mathcal D_X$, confidence parameter $\delta\in(0,1)$, accuracy parameter $\varepsilon>0$, outputs an arbitrary binary hypothesis $h$ with probability at least $1-\delta$. For every joint distribution $\mathcal D$, the guarantee is $\Pr[h(X)\ne Y]\le \inf_{c\in\mathcal C}\Pr[c(X)\ne Y]+\varepsilon$. There is one polynomial $p$, independent of $P$ and $\mathcal D$, such that the worst-case sample size and running time are bounded by $p(s,1/\varepsilon,\log(1/\delta))$.

Open problem: Does every binary concept class satisfying the source guarantee also satisfy the target guarantee?

## Proof Status

**Goal.** Decide whether weak agnostic proper learning can be boosted to strong agnostic improper learning.

**What properness contributes.** The source hypotheses lie in $\mathcal C$, but the target allows an improper final vote. Thus properness of the weak hypotheses is not the obstacle; useful proper hypotheses can be validated, sign-flipped, weighted, and combined by an improper learner. The real question is whether the fixed-additive weak agnostic learner supplies enough oracle power for efficient agnostic boosting.

**Translation to the boosting oracle.** Work in $\{-1,1\}$ labels. The fixed-additive condition
$$
\operatorname{err}(h) \le \operatorname{opt}_{\mathcal C}+\beta
$$
is equivalent to
$$
\operatorname{corr}(h,Y) \ge \max_{c\in\mathcal C}\operatorname{corr}(c,Y)-2\beta .
$$
Thus a $\beta$-weak agnostic proper learner gives the agnostic weak oracle of da Cunha et al. with parameters $\gamma_0=1$ and $\epsilon_0=2\beta$. Since $\beta<1/2$, this is nontrivial: $\gamma_0>\epsilon_0$.

**What this proves statistically.** Da Cunha et al.'s theorem for nontrivial agnostic weak learners then yields an improper classifier $v$ with
$$
\operatorname{err}_{\mathcal D}(v)\le \operatorname{opt}_{\mathcal C}+O(\varepsilon)
$$
after choosing the sample size large enough. So, if the weak learner is treated as an oracle with fixed parameters and the cost measure is polynomial in the sample size, this edge should be regarded as true.

**Why this still does not settle the efficient edge.** The atlas edge is a representation-uniform computational claim. The da Cunha et al. running-time bound is polynomial in the sample size only when the weak-learner parameters are fixed; more explicitly, the displayed bound has an exponent depending on the weak learner's sample parameter $m_0$ and on the dual VC dimension of the base class. In an efficient PAC implication, $m_0$ and the relevant dimensions may grow with the representation size, so a bound of the form $n^{\operatorname{poly}(s)}$ is not polynomial time in the usual sense. Earlier efficient agnostic boosting results, including Ghai and Singh, require a more accuracy-sensitive oracle, for example $\epsilon_0=O(\varepsilon)$, while the atlas source gives only the fixed value $\epsilon_0=2\beta$. Ben-David, Long, and Mansour use exactly the fixed-additive weak notion, but their guarantee is weaker than $\operatorname{opt}_{\mathcal C}+\varepsilon$.

The noisy-comparator calculation gives the same obstruction operationally. If $Y=f(X)N$ with $f\in\mathcal C$ and noise rate $\eta>1/2-\beta$, the weak learner may legally be neutral on the original distribution. Agreement filtering with a current predictor lowers the selected noise below the weak threshold only after that predictor already has substantial correlation with $f$. Thus generic observable denoising does not produce the first useful weak call.

**Clean-witness obstruction.** Properness of the weak outputs is not the problem, since the target may output an improper vote over proper hypotheses. The quantitative issue is that a fixed-additive weak learner may legally return decoys whenever the queried distribution has $\operatorname{opt}_{\mathcal C}\ge 1/2-\beta$. To drive excess error below an arbitrary $\varepsilon$, a booster must discover query distributions or clean subsets on which a near-optimal comparator is visible below this threshold. The current fixed-slack theorem does this by exhaustive clean-subset enumeration, which gives fixed-parameter rather than fully polynomial running time.

**Counterexample route checked.** Halfspaces would be the natural target-hard candidate, because Tiegel rules out even improper agnostic learning of halfspaces under worst-case lattice assumptions. But Tiegel's result also rules out the weak agnostic source for halfspaces: no efficient algorithm can output any binary hypothesis with nontrivial advantage even when the optimum halfspace error is tiny. Thus halfspaces cannot witness this implication's failure.

Affine parities give a useful model fork but not a current-edge separation. Under constant-noise decision-LPN, they separate a parameterized inverse-polynomial weak-gap variant: clean-batch Gaussian elimination gives proper weak learning at gap $\Theta(1/n)$, while strong improper agnostic learning under the uniform marginal would distinguish LPN. For the fixed constant $\beta$ in this atlas node, the same class is source-negative: low-noise parity with noise below $1/2-\beta$ would already require weak recovery of the hidden parity.

**Why this is not a separation.** The decoy-oracle picture is only a black-box barrier. A valid false edge would need a represented class with a uniform polynomial-time proper $\operatorname{opt}_{\mathcal C}+\beta$ learner for every labeled distribution, while every polynomial-time improper learner fails to achieve $\operatorname{opt}_{\mathcal C}+\varepsilon$ for some distribution. Current PRF, one-way-handle, PCP, halfspace, parity, coding, and fixed-$k$ DNF templates miss one side of this requirement: either the weak source also becomes hard, or the public handles and improper voting make the strong target easy.

A real fixed-gap separation would need a class with a public distribution-free proper weak decoder for every weighted corruption pattern below a fixed noise radius, but with hard improper agnostic prediction at a larger constant noise rate. No standard candidate currently supplies both sides.

**Missing lemma.** A positive resolution would follow from a polynomial clean-witness generation lemma: from samples of $\mathcal D$ and a proper $\operatorname{opt}_{\mathcal C}+\beta$ weak agnostic learner with sample bound $m_0$, construct in time polynomial in the representation size, $m_0$, $1/\varepsilon$, and $\log(1/\delta)$ a polynomial list of proper hypotheses whose small improper votes contain an $\operatorname{opt}_{\mathcal C}+\varepsilon$ classifier. Equivalently, replace the $n^{m_0}$ clean-subset enumeration in the fixed-slack booster by a polynomial-size hitting, compression, stability, or hard-core-search procedure.

**Conclusion.** The best current classification is: true for the statistical/oracle or fixed-parameter boosting formulation, still open for the efficient PAC implication as stated here. To mark the edge true, one needs a fully polynomial clean-witness generator. To mark it false, one needs a class with efficient fixed-additive weak agnostic proper learning but hard strong agnostic improper learning.

## References

- [Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)
- [Kalai et al. 2008](https://doi.org/10.1145/1374376.1374466)
- [Gavinsky 2003](https://www.jmlr.org/papers/v4/gavinsky03a.html)
- [Ghai and Singh 2025](https://proceedings.mlr.press/v267/ghai25a.html)
- [da Cunha et al. 2026](https://arxiv.org/abs/2601.11265)
- [Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)
