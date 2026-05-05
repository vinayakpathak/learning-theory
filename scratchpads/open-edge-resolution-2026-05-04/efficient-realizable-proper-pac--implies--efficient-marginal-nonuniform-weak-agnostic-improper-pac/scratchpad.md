# Open Edge Resolution Scratchpad

Edge: `efficient-realizable-proper-pac -> efficient-marginal-nonuniform-weak-agnostic-improper-pac`
Depth: 0 root pending
Current atlas status: `open`, evidence `unknown`
Family: `marginal-agnostic-hardness-open`

## Research Log

## Sources Checked

## Proof Or Counterexample Attempts

## Verdict

Unresolved pending depth-0 investigation.

## Follow-Up Directions

## Depth-0 Entry - 2026-05-04

### Relevant Definitions

Source node: `efficient-realizable-proper-pac`. A learner gets realizable labeled examples from an arbitrary marginal distribution and must, in polynomial samples/time, output a concept-class member with error at most the requested `epsilon`. This is distribution-free, strong, proper, realizable, and computationally efficient.

Target node: `efficient-marginal-nonuniform-weak-agnostic-improper-pac`. A single uniform learner must work for every joint distribution over examples and labels, may output an improper binary hypothesis, and only needs the weak agnostic guarantee
`err(h) <= inf_{c in C} err(c) + beta_P(s)`,
where the marginal-dependent tolerance satisfies `beta_P(s) < 1/2` with inverse-polynomial gap from `1/2`, and the runtime/sample polynomial may depend on the marginal `P` but not on the conditional label rule.

For a counterexample, one therefore needs a class satisfying efficient distribution-free realizable proper learning, plus a fixed marginal (or fixed marginal family, depending on the atlas parameterization) for which every polynomial-time learner fails to obtain even inverse-polynomial advantage over random guessing relative to the best concept. A distribution-free hard family is not enough if each hard marginal can receive its own polynomial bound.

### Sources Checked

- Local atlas notes:
  - `atlas/definitions/efficient-realizable-proper-pac.md`
  - `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
  - `atlas/implications/efficient-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
  - `atlas/arguments/marginal-agnostic-hardness-open.md`
  - `atlas/arguments/halfspace-agnostic-hardness.md`
  - `atlas/witnesses/halfspaces.md`
  - `atlas/registry/edge_families.yml`
  - `atlas/registry/axes.yml`
  - neighboring halfspace edges, especially the false strong marginal agnostic halfspace notes.
- Benedek and Itai, "Learnability with respect to fixed distributions", ScienceDirect/DOI page: https://doi.org/10.1016/0304-3975(91)90026-X. The abstract records the finite-cover characterization for fixed-distribution learnability and explicitly notes that the main concern is sample complexity rather than feasible computation.
- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability", OpenReview: https://openreview.net/forum?id=aoVCFtox89. The abstract describes marginal-nonuniform rates and the sample-complexity trichotomy; it does not give a representation-sensitive computational conversion for this edge.
- Tiegel, "Hardness of Agnostically Learning Halfspaces from Worst-Case Lattice Problems", PMLR page and PDF:
  - https://proceedings.mlr.press/v195/tiegel23a.html
  - https://proceedings.mlr.press/v195/tiegel23a/tiegel23a.pdf
  Relevant checked statements: informal Theorems 1 and 2, formal Theorems 9 and 12, Lemmas 13-14, and the proof of Lemma 14.

### Theorem Or Counterexample Attempts

Attempt 1: use halfspaces and Tiegel's distribution-free weak agnostic hardness.

Halfspaces satisfy the source: in the realizable case, solve a linear feasibility problem on a polynomial-size sample and use VC generalization; the output is a halfspace, so the learner is proper.

Tiegel's Theorem 9 gives, under the CLWE/lattice hardness assumption, a distribution over `R^M x {+-1}` for which no `exp(Omega(log^{1+c} M))`-time learner outputs any binary hypothesis of error `1/2 - exp(-Omega(log^{1+c} M))`, even though some halfspace has error as small as `exp(-Omega(log^{1-c'} M))`. Quantitatively, this is more than enough to contradict a weak agnostic tolerance whose gap from `1/2` is inverse-polynomial, if the hard distributions share one marginal family with one polynomial bound.

Obstruction: this is the distribution-independent construction. The hard marginal changes with the constructed hard instance/parameters. Under the current edge note and argument-note convention, that does not automatically refute a marginal-nonuniform target, because the polynomial may depend on the marginal. To turn this into `status: false`, one would need to freeze or coherently diagonalize the hard marginals into a single marginal family `P` for infinitely many dimensions/representation sizes, then show every polynomial `p_P` is beaten by the lower bound. I did not find that step in the checked sources.

Attempt 2: use Tiegel's standard-Gaussian distribution-specific halfspace hardness.

This route works for neighboring strong marginal agnostic edges, and the atlas already records those as false. Tiegel's Theorem 12 fixes the marginal to the standard Gaussian and shows that learning halfspaces to error `OPT_LTF + epsilon` takes time at least roughly `M^{Omega((1/epsilon^2)^delta / log(1/epsilon))}` under the same lattice assumption.

Precise obstruction for the weak target: the target here does not ask for `OPT + epsilon` for small `epsilon`; it allows additive tolerance `beta_P(s) = 1/2 - alpha_P(s)` where `alpha_P(s)` may be only inverse-polynomial. Tiegel's proof of Lemma 14 uses the condition `OPT_LTF + epsilon <= 1/2 - tau`. For the standard-Gaussian hard distribution, the proof bounds `OPT_LTF <= 1/2 - Theta(1/sqrt(M))`, not `OPT_LTF` near zero. Thus a weak learner with tolerance close to `1/2` would only promise
`err(h) <= OPT_LTF + 1/2 - alpha_P(M)`,
which need not be below `1/2` and gives no distinguisher. The standard-Gaussian theorem is an excess-error hardness theorem, not a fixed-marginal weak-advantage hardness theorem.

Attempt 3: prove the implication using fixed-marginal covers.

Benedek-Itai fixed-distribution learnability and the Hanneke-Moran-Thiessen marginal-nonuniform trichotomy suggest an information-theoretic path: at a fixed marginal, finite covers can reduce agnostic learning to empirical selection over a cover. But the target is computational. Benedek-Itai explicitly separate the cover/sample issue from feasible computation, and the Hanneke et al. result is a rate characterization rather than a uniform polynomial-time procedure. I do not see a way to obtain a single uniform algorithm with marginal-dependent polynomial runtime from the source's realizable learner alone. The realizable learner need not optimize noisy empirical error and can fail completely on non-realizable samples.

### Final Verdict

`unresolved`.

I do not think the present evidence supports changing this edge to true or false. The halfspace witness remains the best candidate, but Tiegel supplies either:

- weak agnostic hardness with hard marginals that are not fixed in the way the marginal-nonuniform target requires, or
- fixed-standard-Gaussian hardness only for strong excess-error agnostic learning, which is too strong a target to refute the atlas weak agnostic node.

### Concrete Follow-Up Directions

1. Check whether Tiegel's distribution-independent Theorem 9 can be converted into a single marginal family across infinitely many dimensions, with one distribution-dependent polynomial `p_P` unable to absorb the lower bound. This would likely resolve the edge as `false`, with `evidence: conditional-counterexample`, `assumptions: ["worst-case lattice hardness"]`, and witness `halfspaces`.
2. Search for a fixed-marginal weak agnostic lower bound for halfspaces, conjunctions, or another efficiently realizable proper class. The needed statement is not `OPT + epsilon` hardness; it must rule out error `1/2 - 1/poly(s)` while the best concept has error below that advantage threshold.
3. Investigate a positive theorem from efficient realizable proper learning to marginal-nonuniform weak agnostic improper learning. A plausible route would combine finite fixed-marginal covers with enumeration and validation, but the missing point is a uniform polynomial-time bound in the representation size rather than merely finite sample complexity.
4. Reconcile the local atlas language around halfspace marginal hardness: strong marginal agnostic edges can cite the standard-Gaussian distribution-specific theorem, but weak marginal agnostic edges need the separate weak-advantage argument above.

## Depth-1 Entry - 2026-05-04

### Final Verdict

`unresolved`.

Depth 1 does not justify changing the atlas edge yet. The most promising halfspace route gets past the marginal-dependent runtime issue only partially: Tiegel's distribution-independent lower bound is superpolynomial enough to defeat any one marginal-dependent polynomial after assembling one hard marginal family across dimensions, but its hard instances only make the best halfspace error subpolynomially small. That is not small enough to force the atlas weak agnostic guarantee below random guessing when the learner's marginal-dependent weak gap may be merely inverse-polynomial with an unknown exponent.

### Sources Checked

- Stefan Tiegel, "Hardness of Agnostically Learning Halfspaces from Worst-Case Lattice Problems", COLT/PMLR 2023:
  - PMLR page: https://proceedings.mlr.press/v195/tiegel23a.html
  - PDF: https://proceedings.mlr.press/v195/tiegel23a/tiegel23a.pdf
  - Checked the abstract, informal Theorems 1 and 2, the distribution-independent proof sketch, and Lemma 14's reduction from an agnostic learner to a distinguisher.
- Ilias Diakonikolas, Daniel M. Kane, and Lisheng Ren, "Near-Optimal Cryptographic Hardness of Agnostically Learning Halfspaces and ReLU Regression under Gaussian Marginals", arXiv:2302.06512:
  - https://arxiv.org/abs/2302.06512
  - PDF mirror checked: https://cseweb.ucsd.edu/~dakane/CryptoHardnessLearningHalfspaces.pdf
- Vitaly Feldman, Venkatesan Guruswami, Prasad Raghavendra, and Yi Wu, "Agnostic Learning of Monomials by Halfspaces is Hard", arXiv:1012.0729 / SIAM J. Comput.:
  - https://arxiv.org/abs/1012.0729
  - https://epubs.siam.org/doi/10.1137/120865094
- Benedek and Itai, "Learnability with respect to fixed distributions":
  - https://doi.org/10.1016/0304-3975(91)90026-X
- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability":
  - https://openreview.net/forum?id=aoVCFtox89

### Lead 1: Diagonalizing Tiegel's Distribution-Independent Hardness

The target quantifiers are:

1. one uniform learner $A$;
2. for every marginal family $P$, there exist a polynomial $p_P$ and a weak gap $\alpha_P(s)=1/2-\beta_P(s)$ that is at least inverse-polynomial in the representation size $s$;
3. for every conditional label rule over that same marginal, $A$ must run within $p_P$ and output
   $$
   \operatorname{err}(h)\le \operatorname{OPT}_{\mathcal C}+\frac12-\alpha_P(s).
   $$

Tiegel's distribution-independent theorem gives, under worst-case lattice hardness, halfspace instances in dimension $M$ for which no subexponential-time learner can output any binary hypothesis with error noticeably below $1/2$, even though the best halfspace has vanishing error. Informally, the runtime lower bound is of the form $\exp(\Omega(\log^{1+c}M))$, and the forbidden advantage can be as small as $\exp(-\Omega(\log^{1+c}M))$.

The runtime diagonalization itself looks viable. For each $M$, choose one of Tiegel's hard distributions $D_M$ and let $P_M=(D_M)_X$. Treat $P=\{P_M\}_{M\ge 1}$ as the dimension-indexed marginal family. If a marginal-nonuniform learner had runtime bounded by some polynomial $p_P(M)$, then for all sufficiently large $M$ this runtime is below Tiegel's superpolynomial lower bound. Thus the marginal-dependent polynomial cannot by itself absorb the lower bound.

However, the weak-agnostic tolerance creates a second obstruction. Tiegel's theorem only makes
$$
\operatorname{OPT}_{\mathrm{LTF}}(D_M)\le \exp(-\Omega(\log^{1-c}M))
$$
for an arbitrary fixed $0<c<1$. This quantity is larger than $M^{-k}$ for every fixed $k$ once $M$ is large enough. The atlas weak gap $\alpha_P(M)$ may be only $M^{-K}$ for some marginal-dependent $K$. Then the target guarantee need only give
$$
\operatorname{err}(h)\le \frac12 + \exp(-\Omega(\log^{1-c}M)) - M^{-K},
$$
which is eventually above $1/2$ and therefore gives no distinguisher. Lemma 14 in Tiegel makes this dependence explicit: the reduction needs $\operatorname{OPT}+\varepsilon\le 1/2-\tau$ in order to turn the learner into a test against random labels.

Conclusion for lead 1: the hard marginals can likely be assembled into one family for the purpose of beating $p_P$, but the known quantitative OPT bound is too weak for this atlas target. To resolve `false` via this route, one needs either Tiegel-style weak hardness with $\operatorname{OPT}\le M^{-K}$ for every fixed $K$ needed by the marginal weak gap, or a theorem whose conclusion directly rules out the additive guarantee $\operatorname{OPT}+1/2-1/\operatorname{poly}(M)$.

### Lead 2: Fixed-Marginal Weak Agnostic Hardness Search

I did not find an atlas-ready fixed-marginal weak agnostic lower bound.

For halfspaces, Tiegel's standard-Gaussian result and the Diakonikolas-Kane-Ren LWE result both address the strong excess-error task under Gaussian marginals: output error at most $\operatorname{OPT}+\varepsilon$. This is enough for the neighboring strong marginal agnostic edges, but it is not enough for the present weak node because the allowed tolerance is close to $1/2$. Tiegel also notes that under Gaussian marginals, known algorithms learn to $\operatorname{OPT}+\varepsilon$ in time roughly $M^{O(1/\varepsilon^2)}$, and Diakonikolas-Kane-Ren similarly frame the Gaussian task as strong additive-error agnostic learning.

For conjunctions, monomials, and decision lists, Feldman-Guruswami-Raghavendra-Wu prove NP-hardness of weak agnostic learning of monomials even when the learner may output a halfspace, and derive hardness for decision lists. This is a distribution-free finite-sample hardness statement: the hard marginal is part of the reduction instance. It is strong evidence for ordinary distribution-free weak agnostic hardness, but it does not by itself supply one fixed marginal family with a single marginal-dependent polynomial bound. It also uses constant noise/constant advantage parameters, while the atlas weak target can choose a much smaller inverse-polynomial advantage gap.

I also checked current Gaussian-halfspace hardness summaries. They continue to target $\operatorname{OPT}+\varepsilon$ or restricted-model/SQ lower bounds, not a general fixed-marginal theorem of the form: for one fixed marginal family $P$, no polynomial-time learner can achieve error
$$
\operatorname{OPT}_{\mathcal C}+1/2-1/\operatorname{poly}(s)
$$
when $\operatorname{OPT}_{\mathcal C}$ is small enough to make this below $1/2$.

### Lead 3: Positive Theorem via Fixed-Marginal Covers

The fixed-marginal cover route remains a near miss, not a proof.

Benedek-Itai characterize fixed-distribution learnability by finite covers, and explicitly emphasize that the main concern is sample complexity rather than feasible computation. Hanneke-Moran-Thiessen's marginal-nonuniform trichotomy is also statistical: it says marginal-dependent rates are governed by combinatorial structure, not that the relevant covers can be enumerated or optimized over in polynomial time.

A tempting algorithm would be:

1. for the fixed marginal $P$, take a finite $P$-cover of the concept class at radius $\alpha_P(s)$;
2. estimate the noisy error of every cover element;
3. output the empirical minimizer.

This would give weak agnostic learning if the cover were explicitly enumerable in polynomial time. The source assumption does not provide that. An efficient realizable proper learner only has to find a consistent concept on realizable samples; it need not expose a cover, solve noisy empirical risk minimization, or behave usefully on inconsistent labels. Even distribution-free finite VC control does not solve the computational issue: a cover at inverse-polynomial scale can have size roughly $(1/\alpha)^d$, and for classes such as halfspaces $d$ grows with the representation size.

Conclusion for lead 3: a positive theorem would need an extra representation-sensitive hypothesis, such as polynomial-time cover enumeration, efficient agnostic ERM over a cover, or a realizable learner with a robust/noisy optimization guarantee. It does not follow from efficient realizable proper PAC learning alone by the standard fixed-marginal cover argument.

### Current Resolution State

The edge remains `unresolved`.

The strongest current candidate for a conditional counterexample is still halfspaces under worst-case lattice assumptions, but the precise missing theorem is sharper than depth 0 stated:

- not merely distribution-free weak agnostic hardness;
- not merely fixed-Gaussian $\operatorname{OPT}+\varepsilon$ hardness;
- rather, a dimension-indexed hard marginal family $P=\{P_M\}$ and hard conditionals with $\operatorname{OPT}_{\mathrm{LTF}}(D_M)$ below the eventual inverse-polynomial weak gap of any candidate marginal-nonuniform learner, while still ruling out every polynomial-time learner from getting below $1/2$ by that gap.

### Concrete Next Directions

1. Re-read Tiegel's parameter choices in Theorem 9 and the underlying CLWE-to-hCLWE truncation lemmas to see whether $\operatorname{OPT}_{\mathrm{LTF}}$ can be pushed down to $M^{-K}$ while preserving a superpolynomial lower bound. The depth-1 obstruction is exactly the current $\exp(-\log^{1-c}M)$ optimum.
2. Search specifically for "low-noise weak agnostic hardness" or "almost realizable agnostic hardness" for halfspaces: the needed regime is $\operatorname{OPT}\le 1/\operatorname{poly}(d)$ plus no inverse-polynomial advantage over random guessing.
3. Check whether Daniely-style random-CSP hardness gives a tunable OPT as small as $1/\operatorname{poly}(d)$ with improper hypotheses and whether its hard marginals can be made into one dimension-indexed family. Existing summaries suggest distribution-free hardness, but not the fixed-family marginal statement needed here.
4. Look for fixed-marginal weak hardness under uniform hypercube or Gaussian marginals for conjunctions, decision lists, or sparse parities where the best concept error is inverse-polynomially small. Constant-OPT weak hardness is not enough for the atlas weak node.
5. If pursuing a positive result, add an explicit computational cover/enumerability assumption and prove that version first. Without such an assumption, Benedek-Itai and Hanneke-Moran-Thiessen support only the statistical part of the argument.

## Depth-2 Entry - 2026-05-04

### Search Target

The desired false-edge statement would have the following form.

Use a class such as halfspaces, conjunctions, monomials, or parities that is efficiently realizable proper PAC learnable. Exhibit one fixed marginal, or one coherent dimension-indexed marginal family compatible with the marginal-nonuniform quantifier, such that for infinitely many dimensions there are label conditionals with
$$
\operatorname{OPT}_{\mathcal C}(D)\le 1/\operatorname{poly}(d)
$$
or at least smaller than the weak gap $\alpha_P(d)$ of any candidate marginal-nonuniform learner, while every polynomial-time improper learner fails to output error at most
$$
1/2 - 1/\operatorname{poly}(d).
$$

This is stronger than ordinary agnostic hardness. It must rule out weak prediction below random guessing after adding $\operatorname{OPT}_{\mathcal C}$ to the weak tolerance.

### Primary Sources Checked

- Amit Daniely, "Complexity Theoretic Limitations on Learning Halfspaces", arXiv:1505.05800 / STOC 2016:
  - https://arxiv.org/abs/1505.05800
  - Checked the abstract, random $K$-XOR assumptions, Theorem 1, and the parameter calculation in the reduction.
- Amit Daniely and Shai Shalev-Shwartz, "Complexity Theoretic Limitations on Learning DNF's", COLT/PMLR 2016:
  - https://proceedings.mlr.press/v49/daniely16.html
  - PDF/source checked for Theorems on DNF, conjunctions, halfspaces, the scattered-sample reduction, and the random $K$-SAT assumption.
- Amit Daniely, Nati Linial, and Shai Shalev-Shwartz, "From average case complexity to improper learning complexity", arXiv:1311.2272 / STOC 2014:
  - https://arxiv.org/abs/1311.2272
  - Checked learning definitions, the improper-learning framework, and the agnostic halfspace consequence under generalized random-CSP assumptions.
- Vitaly Feldman, Venkatesan Guruswami, Prasad Raghavendra, and Yi Wu, "Agnostic Learning of Monomials by Halfspaces Is Hard", FOCS/SICOMP:
  - https://research.ibm.com/publications/agnostic-learning-of-monomials-by-halfspaces-is-hard
  - https://doi.org/10.1137/120865094
- Ilias Diakonikolas, Daniel Kane, Pasin Manurangsi, and Lisheng Ren, "Cryptographic Hardness of Learning Halfspaces with Massart Noise", NeurIPS 2022:
  - https://arxiv.org/abs/2207.14266
  - https://research.google/pubs/cryptographic-hardness-of-learning-halfspaces-with-massart-noise/
- Rajai Nasser and Stefan Tiegel, "Optimal SQ Lower Bounds for Learning Halfspaces with Massart Noise", COLT/PMLR 2022:
  - https://proceedings.mlr.press/v178/nasser22a.html
- Ilias Diakonikolas, Themis Gouleakis, and Christos Tzamos, "Distribution-Independent PAC Learning of Halfspaces with Massart Noise", NeurIPS 2019:
  - https://papers.nips.cc/paper/8722-distribution-independent-pac-learning-of-halfspaces-with-massart-noise
- Stefan Tiegel, "Hardness of Agnostically Learning Halfspaces from Worst-Case Lattice Problems", arXiv/PMLR 2023:
  - https://arxiv.org/abs/2207.14030
  - https://proceedings.mlr.press/v195/tiegel23a.html

### Daniely / Random-CSP Route

Daniely's halfspace paper is the closest random-CSP source. It proves, under random $K$-XOR refutation assumptions, that no polynomial-time improper learner has nontrivial worst-case performance for agnostically learning halfspaces even when the distribution is supported on $\{\pm 1\}^n\times\{\pm 1\}$ and the best halfspace error is small. In the paper's terminology, nontrivial means error at most $1/2-1/n^c$ for some $c>0$.

This has exactly the right improper-learner and weak-advantage flavor. Halfspaces also satisfy the source node: realizable proper learning is by linear feasibility plus VC generalization.

The miss is quantitative. Under the base assumption, the theorem allows every arbitrarily small **constant** $\eta>0$, not a dimension-dependent $\eta(d)$ below an unknown inverse polynomial. Under the stronger polylogarithmic-$K$ assumption, the paper gets
$$
\eta = 2^{-\log^{1-\nu}(n)}
$$
for arbitrarily small constant $\nu>0$. This is still subpolynomially small, hence eventually larger than $n^{-K}$ for every fixed $K$. A marginal-nonuniform weak learner is allowed to have a weak gap $\alpha_P(n)=n^{-K_P}$ for an unknown marginal-dependent exponent. The guarantee
$$
\operatorname{err}(h)\le \operatorname{OPT}+1/2-\alpha_P(n)
$$
need not be below $1/2$ if $\operatorname{OPT}=\eta$ is subpolynomially larger than $\alpha_P(n)$.

There is also still a marginal issue. The random-CSP reductions are distribution-free hardness statements: the hard labeled distributions come from reduction instances. As in depth 1, one can try to assemble a dimension-indexed family of hard marginals to defeat any fixed marginal-dependent polynomial runtime, but the OPT/gap mismatch remains even if that assembly is granted.

Daniely-Shalev-Shwartz's DNF paper has two additional near misses:

- DNF hardness itself does not fit the source because polynomial-size DNF is not known to be efficiently realizable properly PAC learnable.
- The paper lists agnostic hardness consequences for conjunctions and halfspaces, and conjunctions do satisfy efficient realizable proper learning. But the conjunction consequence is still a distribution-free random-CSP hardness result, not a fixed-marginal low-OPT weak-advantage theorem. The scattered-sample framework uses constant scattering thresholds such as $1/4$, and the paper's quantitative "random guessing is essentially optimal" remark comes through boosting hardness for ordinary efficient learning, not a theorem with $\operatorname{OPT}\le 1/\operatorname{poly}(d)$ under one fixed marginal family.

The older Daniely-Linial-Shalev-Shwartz framework has the same shape. It introduced the average-case-to-improper-learning method and gives agnostic halfspace hardness with a constant approximation ratio under a generalized random-CSP assumption. That is valuable background, but a constant approximation-ratio lower bound does not imply failure of the atlas weak target when $\operatorname{OPT}$ is above the unknown inverse-polynomial weak gap.

### Monomial / Conjunction Weak-Agnostic Hardness Route

Feldman-Guruswami-Raghavendra-Wu prove a clean weak-agnostic statement for an efficiently realizable proper class: for any constant $\epsilon>0$, it is NP-hard to find a halfspace agreeing with more than $1/2+\epsilon$ of the examples even when some monomial agrees with at least $1-\epsilon$.

This misses the present edge in three ways.

First, the parameters are constant. The best monomial error is $\epsilon$, and the forbidden advantage is also constant. This refutes ordinary weak agnostic learning at a fixed constant scale, but the atlas marginal-nonuniform weak node may choose an inverse-polynomial gap smaller than any fixed constant.

Second, the theorem is a finite-sample/distribution-free hardness statement built from Label Cover. It does not provide one fixed marginal, such as the uniform hypercube, with a marginal-dependent polynomial bound that must fail across infinitely many dimensions.

Third, the hardness only rules out halfspace outputs. The abstract and theorem phrase the improper target as learning monomials by the richer class of halfspaces. The atlas target allows arbitrary improper binary hypotheses. The theorem is therefore not by itself a full improper lower bound for the target node.

### Low-Noise / Massart Route

The Massart line is close because it studies almost-realizable halfspace labels and, in some papers, very small $\operatorname{OPT}$.

Diakonikolas-Kane-Manurangsi-Ren prove cryptographic hardness for learning halfspaces with Massart noise under LWE assumptions. Their headline lower bound is that no polynomial-time Massart halfspace learner achieves error better than $\Omega(\eta)$, even when $\operatorname{OPT}=2^{-\log^c(N)}$ for any fixed $0<c<1$.

This is not a weak-agnostic separation. If $\eta$ is a small constant, an error lower bound of $\Omega(\eta)$ is far below $1/2$ and does not rule out a hypothesis with error $1/2-1/\operatorname{poly}(N)$. If $\eta$ is taken close to $1/2$, the statement as advertised is still an $\Omega(\eta)$ lower bound, not a tight lower bound at $1/2-1/\operatorname{poly}(N)$. In either case, the theorem targets near-optimal Massart accuracy rather than no weak advantage over random guessing.

Nasser-Tiegel's SQ lower bound is more directly relevant in form. It says that for arbitrary $\eta\in[0,1/2]$, SQ algorithms achieving error better than $\eta$ need superpolynomial resources, and this can hold with $\operatorname{OPT}$ as small as $\exp(-\log^c(d))$. In particular, choosing $\eta=1/2-d^{-k}$ would look like SQ-hardness of weak advantage.

But this still misses the needed statement:

- it is an SQ lower bound, while the atlas target is against arbitrary polynomial-time improper learners;
- the available $\operatorname{OPT}$ is again subpolynomial, not below an unknown inverse-polynomial weak gap;
- the abstract explicitly frames this as matching known polynomial-time Massart algorithms, which achieve error roughly $\eta+\epsilon$ rather than showing no weak learner exists.

Diakonikolas-Gouleakis-Tzamos supply the complementary positive result: distribution-independent Massart halfspaces can be learned in polynomial time to error $\eta+\epsilon$. This reinforces that Massart noise is not automatically an agnostic weak-hardness witness. It is a structured-noise model with dedicated algorithms; its lower bounds are about improving the dependence on $\eta$ or achieving optimal accuracy, not about ruling out all inverse-polynomial advantage over random guessing.

### Fixed-Marginal Status

I did not find a primary-source theorem with a fixed or marginal-nonuniform-compatible hard marginal satisfying the needed low-OPT weak-advantage form.

The fixed-Gaussian halfspace hardness results remain strong-excess-error results. Tiegel's distribution-specific theorem fixes the standard Gaussian marginal but shows hardness for achieving $\operatorname{OPT}+\epsilon$. As depth 0 noted, the corresponding best-halfspace error in the fixed-Gaussian construction is close to $1/2$ up to about $1/\sqrt{d}$, so the weak target's additive tolerance can sit above $1/2$. Tiegel explicitly remarks that in the distribution-specific LTF/PTF setting, $\operatorname{OPT}$ is very close to $1/2$ for all known lower bounds.

The distribution-independent Daniely/Tiegel hard distributions have much better weak-advantage conclusions, but their marginals are not fixed in the required way and their low-noise parameters are subpolynomial rather than inverse-polynomial.

### Depth-2 Verdict

`unresolved`.

The edge should not be changed to `false` on the basis of the Daniely/random-CSP or low-noise literature checked here.

The strongest route is still:

1. Use halfspaces as the source-satisfying class.
2. Assemble the distribution-independent hard instances into one dimension-indexed hard marginal family.
3. Strengthen the low-noise parameter from $\exp(-\log^{1-c}d)$ or $2^{-\log^{1-\nu}d}$ to below the eventual inverse-polynomial weak gap of an arbitrary marginal-nonuniform learner.
4. Retain hardness for arbitrary improper binary hypotheses with error threshold $1/2-1/\operatorname{poly}(d)$.

Step 3 is the blocker. I found no primary source that supplies it. The random-CSP and lattice constructions repeatedly stop at subpolynomial OPT, while Massart/SQ constructions either prove only restricted-model lower bounds or lower bounds around $\eta$ rather than around $1/2$.

The edge also should not be changed to `true`. The positive evidence remains only statistical or requires extra computational structure, such as efficiently enumerable fixed-marginal covers or a realizable learner that can be converted into an agnostic/noisy optimizer. None of the depth-2 sources gives such a conversion from efficient realizable proper PAC learning alone.

### Next Directions

1. Look for low-noise **improper** weak-agnostic hardness where the statement explicitly allows $\operatorname{OPT}\le d^{-K}$ for arbitrarily large fixed $K$, not merely $\exp(-\log^c d)$.
2. Search LPN/LWE-to-binary-classification reductions for parity-like classes under a fixed uniform marginal with inverse-polynomial label noise and hardness of any inverse-polynomial prediction advantage. The source class would need to remain efficiently realizable proper, and the theorem must be against arbitrary binary hypotheses.
3. Check whether any random-CSP refutation assumption has a tunable near-satisfiable regime with value $1-d^{-K}$ and still yields Daniely-style scatteredness strong enough for improper weak hardness.
4. For a positive result, isolate a strengthened source node: efficient realizable proper learning plus polynomial-time access to fixed-marginal covers/ERM. Under that added assumption the fixed-marginal cover argument should become provable, but it is not a consequence of the present source node.

## Depth-3 Entry - 2026-05-04

### Search Target

This pass focused on fixed-uniform-marginal cryptographic candidates, especially parities/LPN. The desired counterexample would need all of the following at once:

1. the benchmark class is efficiently distribution-free realizable properly PAC learnable;
2. under a fixed marginal such as the uniform distribution on $\{0,1\}^n$, there are agnostic label conditionals with
   $$
   \operatorname{OPT}_{\mathcal C}(D)
   $$
   below the inverse-polynomial weak gap allowed for that marginal; and
3. every polynomial-time improper learner still fails to output error below
   $$
   1/2-1/\operatorname{poly}(n).
   $$

The third condition must be against arbitrary binary hypotheses, not merely against parities or another restricted output class.

### Sources Checked

- Blum, Kalai, and Wasserman, "Noise-Tolerant Learning, the Parity Problem, and the Statistical Query Model" / JACM 2003:
  - https://www.microsoft.com/en-us/research/wp-content/uploads/2016/11/2003-Noise-Tolerant_Learning.pdf
  - Checked the abstract, the discussion of parity as efficiently learnable without noise but not by SQ under uniform, the weak-learning definition, and Theorem 2's BKW parameter dependence.
- Feldman, Gopalan, Khot, and Ponnuswami, "On Agnostic Learning of Parities, Monomials and Halfspaces":
  - https://cs.nyu.edu/~khot/papers/hs-parity-monomial_SIAM.pdf
  - Checked the abstract and Section 1.1. The paper states that under the uniform distribution, agnostic learning of parities reduces to learning parities with random classification noise, and calls noisy parity a notorious open problem.
- Blum, Furst, Kearns, and Lipton, "Cryptographic Primitives Based on Hard Learning Problems", CRYPTO 1993:
  - https://dblp.org/rec/conf/crypto/BlumFKL93
  - Used as the standard historical source for cryptographic assumptions based on noisy parity / hard learning.
- Alekhnovich, "More on average case vs approximation complexity", FOCS 2003:
  - https://www.cs.toronto.edu/~toni/Courses/PCP/handouts/misha.pdf
  - Checked the average-case hardness framing for random linear systems and the explicit warning that these are strong cryptographic conjectures.
- Recent low-noise LPN-over-large-fields discussion and attacks:
  - https://academic.oup.com/comjnl/article/67/4/1438/7224395
  - Checked the low-noise regime discussion, especially the folklore/information-set attack using error-free equations and the contrast with BKW for high/constant noise.

### Parities / LPN Candidate

Parities fit the source node. In the realizable case, a proper learner can collect labeled equations and solve a linear system over $\mathbb F_2$; standard VC/generalization bookkeeping gives distribution-free PAC learning with polynomial samples and time.

The fixed marginal is also exactly right: LPN uses $x\sim U(\{0,1\}^n)$ and labels
$$
y=\langle s,x\rangle \oplus e
$$
with independent noise $e\sim\operatorname{Bernoulli}(\eta)$. The best parity has error $\eta$. Moreover, any improper learner that outputs a hypothesis with fresh-example error $1/2-\gamma$ on this noisy-parity distribution gives a decisional LPN distinguisher: on a holdout set, the learner's hypothesis has advantage $\gamma$ against LPN labels, while against truly random labels it has no such advantage except with small validation probability. Thus the improper-output issue is not the blocker for LPN; decisional LPN is naturally a hardness statement against arbitrary distinguishers.

The blocker is the atlas weak-gap quantifier. The marginal-nonuniform target may choose, for the uniform marginal, a very small inverse-polynomial weak gap $\alpha_U(n)=1/\operatorname{poly}(n)$. The target guarantee is only
$$
\operatorname{err}(h)\le \eta+\frac12-\alpha_U(n).
$$
This forces error below $1/2$ only when $\eta<\alpha_U(n)$. Constant-noise LPN is standard and cryptographically meaningful, but constant $\eta$ is much larger than a permissible $\alpha_U(n)$, so it does not refute the atlas weak target.

One could postulate low-noise LPN with $\eta(n)<\alpha_U(n)$. That is not a standard enough assumption for this edge, and in the range needed to beat an arbitrary marginal weak gap it can become algorithmically false. For full parities, the realizable learner needs only $O(n)$ clean equations for a constant-accuracy weak hypothesis. If $\eta\ll 1/n$, then $O(n)$ samples are all clean with constant probability, and repeated Gaussian elimination learns the parity in polynomial time. More generally, the common low-noise cryptographic regimes, such as $\eta=n^{-\gamma}$ with $\gamma<1$ or $\eta=\operatorname{polylog}(n)/n$, do not cover an arbitrary inverse-polynomial gap chosen by the marginal-nonuniform learner. If the learner chooses a gap around $1/n$ or smaller, these noises are not below the gap; if one pushes the noise much below $1/n$, clean-sample attacks become polynomial.

Conclusion for LPN: it is an excellent sanity check but not a counterexample. Standard constant-noise decisional LPN gives hardness of weak prediction under the fixed uniform marginal, but with $\operatorname{OPT}$ too large. Nonstandard ultra-low-noise LPN would be needed for the atlas edge, and that assumption is either unsupported or contradicted by elementary clean-equation algorithms in the relevant parity parameter range.

### Other Fixed-Uniform Cryptographic Candidates

Sparse parity with noise is also a near miss. If the parity size $k$ is constant, then the class is efficiently realizable properly learnable and noisy learning is polynomial by enumerating $n^k$ parities. If $k$ grows enough for sparse LPN hardness to be plausible, the corresponding class is no longer efficiently realizable properly learnable by a polynomial-time brute-force learner under the usual representation-size accounting, unless one assumes an additional realizable sparse-parity algorithm.

DNF, decision trees, juntas, and related uniform-distribution reductions in Feldman--Gopalan--Khot--Ponnuswami also do not produce this edge's witness. Their reductions emphasize the centrality of noisy parity for uniform-distribution agnostic learning, but the natural classes either are not known to satisfy the source node distribution-free properly and efficiently, or the hardness is inherited from noisy parity with the same low-OPT/gap obstruction.

Pseudorandom-function classes under the uniform marginal would easily give fixed-marginal weak-prediction hardness, but they fail the source node: if a class is a secure PRF family, it is not efficiently distribution-free realizable PAC learnable from random examples under the same representation, since such a learner would distinguish the PRF from random labels.

### Positive Resolution Suggested By The Low-Noise Obstruction

The failed LPN route points to a generic positive argument. The target's weak agnostic guarantee is nontrivial only when
$$
\operatorname{OPT}_{\mathcal C}(D)<\alpha(s),
$$
because if $\operatorname{OPT}_{\mathcal C}(D)\ge \alpha(s)$ then the better constant labeler has error at most $1/2$, which already meets
$$
\operatorname{OPT}_{\mathcal C}(D)+1/2-\alpha(s).
$$

So it suffices to handle the very-low-noise case. Let $L$ be the source efficient realizable proper learner. Fix constant accuracy $\varepsilon_0=1/4$ and confidence, and let $m(s)$ be a polynomial upper bound on the number of examples used by $L$ at those fixed parameters. Set the target weak gap, for instance, to
$$
\alpha(s)=\frac{1}{100m(s)}.
$$

Given agnostic samples, the target learner repeatedly runs $L$ on fresh batches of $m(s)$ examples, treating the noisy labels as if they were realizable, and then validates the produced hypotheses together with the two constant hypotheses on a fresh validation sample. The validation accuracy only needs inverse-polynomial precision in $\alpha(s)$, so the total sample and time bounds remain polynomial. This learner is improper-allowed but actually outputs either a proper hypothesis from $L$ or a constant.

Why this works:

- If $\operatorname{OPT}\ge 2\alpha(s)$, the best constant has error at most $1/2$, and validation to $O(\alpha)$ accuracy selects a hypothesis with error at most $1/2+O(\alpha)\le \operatorname{OPT}+1/2-\alpha$.
- If $\operatorname{OPT}=\eta<2\alpha(s)$, choose $c^\star\in\mathcal C$ with noisy-label error $\eta$. With probability at least $(1-\eta)^{m(s)}$, a fresh batch contains no labels corrupted relative to $c^\star$; by the choice of $\alpha$, this probability is still a positive constant. Conditioned on that event, the labels are realizable by $c^\star$ under the conditional clean marginal $Q$. The clean marginal $Q$ is within total variation $O(\eta)$ of the original marginal $P$, so a hypothesis with error at most $\varepsilon_0$ under $Q$ has error at most $\varepsilon_0+O(\eta)$ under $P$. Its noisy-label error is therefore at most $\varepsilon_0+O(\eta)$, far below $1/2-\alpha+\eta$ for the above constants. Repetition gives such a candidate with high probability, and validation finds one.

The conditioning point matters: the clean examples are drawn from $P$ biased by the event $y=c^\star(x)$, not exactly from $P$. But this bias has total variation at most about $\eta/(1-\eta)$, which is harmless because $\eta<2\alpha(s)$ and the proof only needs a constant weak advantage.

This is a direct black-box conversion from efficient realizable proper learning to efficient weak agnostic improper learning with an inverse-polynomial gap. It does not need a fixed-marginal cover, and it is stronger than marginal-nonuniform: the polynomial and weak gap can be chosen distribution-free from the source learner's own polynomial bounds.

### Depth-3 Verdict

`resolved true`.

The parity/LPN investigation does not yield a conditional false edge. Constant-noise LPN is standard but has $\operatorname{OPT}$ too large for this atlas weak target. Ultra-low-noise LPN below an arbitrary inverse-polynomial weak gap is not a standard assumption and, for full parities once the noise is below the clean-batch scale, is defeated by elementary Gaussian-elimination repetition.

More importantly, the same clean-batch idea gives a generic positive proof for the edge. Efficient realizable proper PAC learning is enough to obtain an efficient weak agnostic improper learner: when $\operatorname{OPT}$ is not tiny, constants suffice; when $\operatorname{OPT}$ is tiny, repeated realizable learning on small batches hits an uncorrupted batch with polynomially bounded probability and yields a constant-advantage hypothesis after validation.

Recommended atlas update, if editing were allowed in a later pass: change the implication to `status: "true"` with `evidence: theorem`, citing the argument as a generic low-noise robustification of realizable learning rather than a cryptographic hardness edge.
