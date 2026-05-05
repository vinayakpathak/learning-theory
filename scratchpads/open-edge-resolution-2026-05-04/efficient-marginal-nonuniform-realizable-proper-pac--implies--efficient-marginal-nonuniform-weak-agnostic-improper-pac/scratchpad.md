# Open Edge Resolution Scratchpad

Edge: `efficient-marginal-nonuniform-realizable-proper-pac -> efficient-marginal-nonuniform-weak-agnostic-improper-pac`
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

- Source node: `efficient-marginal-nonuniform-realizable-proper-pac`. A single uniform learner must, for each fixed marginal $P$, have some marginal-dependent polynomial $p_P$ so that realizable labels by any $c \in \mathcal C$ are learned to arbitrary $\varepsilon$ in time and samples $p_P(s,1/\varepsilon,\log(1/\delta))$, with proper output in $\mathcal C$.
- Target node: `efficient-marginal-nonuniform-weak-agnostic-improper-pac`. A single uniform learner must, for each fixed marginal $P$, have some marginal-dependent polynomial $p_P$ and weak additive tolerance $\beta_P(s)<1/2$ with inverse-polynomial gap from $1/2$, so that for every joint distribution with marginal $P$ it outputs any binary hypothesis with
  $$
  \operatorname{err}_{\mathcal D}(h) \le \inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta_P(s)
  $$
  in time and samples $p_P(s,\log(1/\delta))$.
- The edge is not a monotone relaxation: it changes realizable to agnostic. It is weaker than strong agnostic learning, because the target only asks for a fixed additive tolerance below $1/2$, not arbitrary excess $\varepsilon$.
- Atlas family context: `marginal-agnostic-hardness-open` says distribution-free agnostic hardness does not automatically refute marginal-nonuniform agnostic targets, since the runtime polynomial may depend on the instance marginal.

### Sources Checked

- Local atlas notes:
  - `atlas/definitions/efficient-marginal-nonuniform-realizable-proper-pac.md`
  - `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
  - `atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
  - `atlas/arguments/marginal-agnostic-hardness-open.md`
  - `atlas/witnesses/halfspaces.md`
  - `atlas/registry/edge_families.yml`
  - neighboring halfspace edges, especially the strong marginal agnostic false edge and the distribution-free weak agnostic false edges.
- Benedek and Itai, "Learnability with Respect to Fixed Distributions", DOI: https://doi.org/10.1016/0304-3975(91)90026-X, via atlas citation context.
- Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability", OpenReview/PDF: https://openreview.net/forum?id=aoVCFtox89 and https://openreview.net/pdf?id=aoVCFtox89. Checked the definition of marginal-nonuniform quantifiers and the trichotomy context.
- Tiegel, "Hardness of Agnostically Learning Halfspaces from Worst-Case Lattice Problems", PMLR page/PDF: https://proceedings.mlr.press/v195/tiegel23a.html and https://proceedings.mlr.press/v195/tiegel23a/tiegel23a.pdf. Key checked points:
  - The abstract and introduction state both distribution-independent improper agnostic hardness and distribution-specific standard-Gaussian hardness.
  - Theorem 9 gives distribution-independent no-weak-advantage hardness: no efficient learner achieves error $1/2-\gamma$ even when the best halfspace error is tiny, under worst-case lattice assumptions.
  - Theorem 12 gives fixed Gaussian marginal hardness for achieving $\operatorname{OPT}_{\mathrm{LTF}}+\varepsilon$; Lemma 14 uses the condition $\operatorname{OPT}_{\mathrm{LTF}}+\varepsilon \le 1/2-\tau$.
- Hopkins, Kane, Lovett, and Mahajan, "Realizable Learning is All You Need", TheoretiCS/PDF: https://theoretics.episciences.org/13009 and https://theoretics.episciences.org/13009/pdf. Checked because it gives an agnostic-from-realizable reduction under distributional assumptions; its own discussion says the reduction is inherently computationally inefficient, so it supports only the sample-efficient neighboring edge, not this computational edge.
- Diakonikolas, Kane, and Ren, "Near-Optimal Cryptographic Hardness of Agnostically Learning Halfspaces and ReLU Regression under Gaussian Marginals", PMLR/PDF: https://proceedings.mlr.press/v202/diakonikolas23b.html and https://proceedings.mlr.press/v202/diakonikolas23b/diakonikolas23b.pdf. Checked as another Gaussian-marginal source; it is also an $\operatorname{OPT}+\varepsilon$ hardness result rather than a fixed-marginal weak no-advantage result with tiny $\operatorname{OPT}$.

### Theorem Or Counterexample Attempts

1. Halfspace conditional counterexample via distribution-free weak hardness.

   Boolean halfspaces satisfy the source: realizable proper learning is efficient by linear feasibility plus VC generalization, so the marginal-nonuniform source is satisfied. Tiegel's Theorem 9 is strong enough for the weak target quantitatively: it rules out even a tiny advantage over $1/2$ while the optimum halfspace error is very small.

   Obstruction: Theorem 9 is distribution-independent. The hard marginal is part of the hard family and appears to vary with the hidden CLWE/lattice instance and the dimension. The target allows the polynomial bound to depend on the marginal $P$. A distribution-free lower bound therefore does not by itself show that there is one fixed marginal (or one fixed marginal family in the atlas sense) on which every marginal-dependent polynomial-time weak learner fails.

2. Halfspace conditional counterexample via Tiegel's standard-Gaussian marginal.

   This is enough for the neighboring strong marginal agnostic edge: Theorem 12 fixes the instance marginal to a Gaussian and rules out $\operatorname{OPT}_{\mathrm{LTF}}+\varepsilon$ learning in time polynomial in the dimension and $1/\varepsilon$.

   Obstruction: the present target is weak agnostic. It can choose $\beta_P(s)=1/2-1/q_P(s)$ for some marginal-dependent polynomial $q_P$. Tiegel's Gaussian hard distribution has $\operatorname{OPT}_{\mathrm{LTF}} \le 1/2-\Theta(1/\sqrt M)$ in the proof of Lemma 14; the reduction distinguishes only when $\operatorname{OPT}_{\mathrm{LTF}}+\varepsilon \le 1/2-\tau$. If a weak target takes $\beta_P(M)$ close to $1/2$, then $\operatorname{OPT}_{\mathrm{LTF}}+\beta_P(M)$ is generally above $1/2$ for this construction, making the weak guarantee vacuous or nearly vacuous. Thus the fixed-Gaussian strong hardness does not refute the weak node.

3. Positive reduction from the source learner.

   The Hopkins--Kane--Lovett--Mahajan reduction and the atlas sample-complexity-equivalence note give a clean sample-only route: run the realizable learner on all labelings of an unlabeled sample to build a finite nonuniform cover, then choose a low empirical-error candidate on labeled data.

   Obstruction: enumerating all labelings is exponential in the unlabeled sample size. The cited paper explicitly notes this computational inefficiency is inherent in general, and halfspace agnostic hardness is the standard warning example. I do not see a way to preserve polynomial time from an arbitrary marginal-nonuniform realizable proper learner.

4. Diagonalizing distribution-free hardness into one marginal.

   A tempting route is to combine the hard marginals from Tiegel's distribution-independent weak lower bound across dimensions into a single size-aware marginal on a disjoint union domain. If valid, this could bypass the "polynomial may depend on $P$" loophole: the same fixed $P$ would contain infinitely many hard scales, and any fixed polynomial $p_P$ would eventually be beaten by the lower bound.

   Obstruction: this requires careful compatibility with the atlas representation-size parameter and with what counts as one marginal over the halfspace class across dimensions. I did not find a primary source or existing atlas convention justifying this construction. It may also change the concept class/domain rather than using the standard halfspace witness directly.

### Precise Obstruction

To mark the edge `false` under `conditional-counterexample`, one needs a class satisfying efficient marginal-nonuniform realizable proper PAC learning and, under explicit assumptions, failing the marginal-nonuniform weak agnostic improper target. For halfspaces this would require a fixed marginal $P$ such that no polynomial-time learner achieves even
$$
\operatorname{OPT}_{\mathcal C} + \left(1/2 - 1/\operatorname{poly}(s)\right)
$$
for all agnostic labelings with marginal $P$.

The available halfspace hardness results split the needed properties:

- Tiegel Theorem 9 has the needed weak no-advantage/tiny-OPT form, but not a fixed marginal.
- Tiegel Theorem 12 and Diakonikolas--Kane--Ren have the needed fixed Gaussian marginal, but prove strong $\operatorname{OPT}+\varepsilon$ hardness; their known hard distributions do not force failure of an additive tolerance near $1/2$.

To mark the edge `true`, one would need a polynomial-time agnostic-from-realizable conversion in the marginal-nonuniform setting. The known black-box conversion is sample-efficient but computationally exponential because it enumerates all labelings of an unlabeled sample.

### Final Verdict

`unresolved`.

I do not have a sound atlas-compatible proof of `true`, nor a sound conditional counterexample for `false`. The best current evidence keeps the existing `open` / `unknown` status.

### Concrete Follow-Up Directions

- Check whether Tiegel's distribution-independent weak construction can be formalized as a single marginal-nonuniform hard marginal over a size-indexed disjoint union without leaving the atlas halfspace witness conventions.
- Look for a fixed-Gaussian weak no-advantage halfspace lower bound where $\operatorname{OPT}_{\mathrm{LTF}}$ is tiny, not merely $1/2-\Theta(1/\sqrt d)$ or an $\operatorname{OPT}+\varepsilon$ lower bound.
- Inspect whether any LWE/CLWE construction can preserve the standard Gaussian marginal while making the best halfspace error $o(1)$; current Gaussian constructions seem to encode only a small correlation advantage for halfspaces.
- Clarify in `atlas/README.md` or a registry note whether a "marginal" for representation-size-indexed classes may be a size-aware family $(P_s)_s$ or must be a single distribution over the full domain. This affects whether diagonalizing hard marginals across dimensions is admissible.
- If a positive result is pursued, restrict the source learner further (for example, ERM, SQ, stable, or learner whose induced cover can be generated compactly). The unrestricted black-box source appears too weak computationally.

## Depth-1 Entry - 2026-05-04

### Goal

Follow up on the depth-0 halfspace/CLWE leads for the edge
`efficient-marginal-nonuniform-realizable-proper-pac -> efficient-marginal-nonuniform-weak-agnostic-improper-pac`.

The desired false witness would be a class such as halfspaces, which satisfies the realizable proper source, together with a fixed marginal or atlas-compatible marginal family under which every efficient learner fails the weak agnostic improper target. The weak target is important: for a fixed marginal $P$, the learner may choose
$$
\beta_P(s)=\frac12-\frac{1}{q_P(s)}
$$
for an arbitrary marginal-dependent polynomial $q_P$. A hardness result refutes this only if the hard joint distribution has
$$
\operatorname{OPT}_{\mathcal C} \ll \frac{1}{q_P(s)}
$$
and no efficient algorithm can get advantage comparable to $1/q_P(s)$ over random guessing.

### Sources Checked

- Stefan Tiegel, "Hardness of Agnostically Learning Halfspaces from Worst-Case Lattice Problems", COLT 2023 / arXiv:2207.14030, https://proceedings.mlr.press/v195/tiegel23a.html and https://arxiv.org/abs/2207.14030.
- Ilias Diakonikolas, Daniel M. Kane, and Lisheng Ren, "Near-Optimal Cryptographic Hardness of Agnostically Learning Halfspaces and ReLU Regression under Gaussian Marginals", arXiv:2302.06512, https://arxiv.org/abs/2302.06512.
- Jizhou Huang and Brendan Juba, "Near-Optimal Cryptographic Hardness of Learning With Homogeneous Halfspaces Under Gaussian Marginals", arXiv:2604.26446, submitted 2026-04-29, https://arxiv.org/abs/2604.26446.
- Feldman, Guruswami, Raghavendra, and Wu, "Agnostic Learning of Monomials by Halfspaces is Hard", arXiv:1012.0729 / SIAM J. Comput. 2012, https://arxiv.org/abs/1012.0729. Checked only as an older weak-hardness comparison point; it uses hard distributions over the hypercube and does not give the fixed-marginal improper halfspace statement needed here.
- Local atlas definitions and edge note for the source, target, and current open edge.

### Lead 1: Can Tiegel's Distribution-Independent Weak Hardness Be Made Marginal-Nonuniform?

Tiegel's distribution-free theorem is still the closest-looking counterexample. It rules out any efficient binary hypothesis with error better than $1/2-\gamma$ while the best halfspace error is subconstant, under worst-case lattice assumptions. However, the quantitative form is not enough for the atlas weak target.

The key parameters in the general-distribution construction are asymmetric:

- The no-advantage threshold can be as small as
  $$
  \gamma=\exp(-\Omega(\log^{1+c} d)),
  $$
  smaller than every inverse polynomial.
- The promised optimum is only as small as
  $$
  \delta=\exp(-\Omega(\log^{1-c} d)),
  $$
  which is larger than every inverse polynomial for fixed $0<c<1$ and large $d$.

This is fatal for the current weak target. If a putative marginal-nonuniform learner chooses a very small inverse-polynomial gap $1/q_P(s)$, then eventually
$$
\delta \gg 1/q_P(s),
$$
so the guarantee
$$
\operatorname{err}(h)\le \operatorname{OPT}+\left(\frac12-\frac{1}{q_P(s)}\right)
$$
is above $1/2$ and does not imply a distinguisher for Tiegel's hard distribution. Thus even if one could package Tiegel's hard marginals into a size-indexed family, the known quantitative theorem would not refute the weak node.

There is also still a model-convention obstruction. Tiegel's hard marginal is dimension/construction dependent. The atlas definitions speak of one marginal $P$ over the instance space, with a representation-size parameter $s$, and do not explicitly say that a "fixed marginal" may be a freely chosen sequence $(P_s)_s$ of hard marginals. A disjoint-union construction might be possible, but it would need a formal convention saying that the learning guarantee is evaluated conditionally at each size or otherwise prevents the hard component from being diluted by the mixture weights.

Conclusion for lead 1: no atlas-ready conversion. The obstacle is both quantitative and definitional.

### Lead 2: Fixed-Gaussian Or Fixed-Marginal Weak No-Advantage Bounds With Tiny OPT

I did not find a fixed-Gaussian halfspace result with the needed form:
$$
\operatorname{OPT}_{\mathrm{LTF}}=o(1/\operatorname{poly}(d))
$$
while no efficient improper learner gets inverse-polynomial advantage over $1/2$.

The fixed-Gaussian lower bounds I found remain strong-agnostic, not weak-no-advantage:

- Tiegel's distribution-specific theorem fixes the instance marginal to a Gaussian and proves hardness for achieving $\operatorname{OPT}_{\mathrm{LTF}}+\varepsilon$. In the proof, the available halfspace advantage is only $\Theta(1/\sqrt M)$; equivalently, $\operatorname{OPT}_{\mathrm{LTF}}\le 1/2-\Theta(1/\sqrt M)$, not tiny.
- Diakonikolas--Kane--Ren fix the standard Gaussian marginal and prove near-optimal $\operatorname{OPT}+\varepsilon$ hardness from LWE. Their decision view distinguishes random labels from a case where a halfspace has only a small advantage, on the order of the target excess parameter.
- Huang--Juba's 2026 homogeneous-halfspace paper also fixes the standard Gaussian marginal, but the agnostic-learning corollary is again an additive-approximation lower bound. The alternative case gives a homogeneous halfspace with advantage $\Theta(1/\sqrt{\eta\log d})$, not a near-realizable labeling.

These results are valuable for strong marginal agnostic edges, but a weak agnostic learner with $\beta_P(d)$ very close to $1/2$ can satisfy its guarantee without finding any such small advantage when $\operatorname{OPT}$ itself is close to $1/2$.

Conclusion for lead 2: no fixed-marginal tiny-OPT weak no-advantage lower bound found.

### Lead 3: CLWE/LWE Fixed Gaussian Marginal And Near-Realizable Labels

The CLWE/LWE Gaussian constructions explain why the two desired properties have not appeared together. To force the $x$-marginal to be exactly Gaussian, the reductions encode the hidden direction in periodic or alternating-band label correlations along $\langle s,x\rangle$. A halfspace can detect only a small coarse correlation with those bands. This gives a best-halfspace error of roughly
$$
\frac12-\text{small advantage},
$$
which is perfect for $\operatorname{OPT}+\varepsilon$ hardness but not for near-realizable weak hardness.

Tiegel's near-realizable weak hardness instead uses a more distribution-free construction based on separated CLWE-derived components and a reduction from PTF structure to halfspaces. That construction loses the fixed Gaussian marginal. The depth-1 search did not turn up a variant that simultaneously preserves:

- exact fixed Gaussian marginal,
- best halfspace error below every relevant inverse polynomial,
- hardness of achieving any inverse-polynomial advantage over random guessing,
- improper output lower bound.

Conclusion for lead 3: current CLWE/LWE constructions appear to trade off fixed Gaussian marginal against near-realizable labels. I found no source breaking that tradeoff.

### Proof Attempt Update

The tempting diagonalization over Tiegel hard dimensions is weaker than it first looked. Suppose the atlas allowed a marginal family $P=(P_s)_s$ and we set $P_s$ to the Tiegel hard marginal at size $s$. A marginal-nonuniform weak learner for this $P$ is allowed its own polynomial $q_P$. To contradict it via Tiegel, the hard distribution at size $s$ would need
$$
\operatorname{OPT}_s + \frac12-\frac{1}{q_P(s)} \le \frac12-\gamma_s,
$$
or equivalently
$$
\operatorname{OPT}_s+\gamma_s \le \frac{1}{q_P(s)}.
$$
Tiegel supplies $\gamma_s$ small enough, but the known $\operatorname{OPT}_s$ is too large: $\exp(-\log^{1-c}s)$ eventually dominates $1/q_P(s)$ for every fixed polynomial $q_P$. Therefore the diagonalized family would still not refute the weak agnostic target.

This is a stronger obstruction than the depth-0 "hard marginal varies" concern: even granting a favorable size-indexed marginal convention, the known theorem does not match the atlas weak quantifiers.

### Final Verdict

`unresolved`.

I did not find a sound proof of `resolved true` or `resolved false`. The halfspace evidence still strongly suggests that realizable-to-agnostic computational conversion should fail in some form, but the exact marginal-nonuniform weak improper target is not separated by the currently checked halfspace/CLWE literature.

### Concrete Next Directions

- Quantitative theorem search: look specifically for a lower bound with fixed marginal $P$ and parameters $\operatorname{OPT}\le d^{-\omega(1)}$ or $\operatorname{OPT}\le d^{-K}$ for arbitrary $K$, while ruling out error $1/2-d^{-k}$ for arbitrary fixed $k$. Without this OPT scale, the atlas weak additive tolerance remains too weak to contradict.
- CLWE modification: ask whether the Gaussian-marginal band-label construction can be biased or postprocessed so that labels agree with one halfspace except on $d^{-\omega(1)}$ mass, while the labeled distribution remains computationally indistinguishable from random labels. Current constructions seem to lose either Gaussian marginal or halfspace near-realizability.
- Atlas convention check: decide whether marginal-nonuniform $P$ for size-parameterized domains may mean a family $(P_s)_s$. If yes, record the convention and revisit diagonal hard-family arguments. If no, disjoint-union reductions must handle mixture dilution explicitly.
- Alternative witnesses: search beyond halfspaces for classes with efficient realizable proper learning and fixed-marginal cryptographic weak agnostic hardness where the hard labeling is near-realizable. Parity/LPN-like fixed uniform marginals are tempting, but constant-noise LPN has $\operatorname{OPT}$ too large for this weak additive target unless one has hardness at arbitrarily tiny noise rates.

## Depth-2 Entry - 2026-05-04

### Goal

Check the remaining low-noise fixed-marginal route for the edge
`efficient-marginal-nonuniform-realizable-proper-pac -> efficient-marginal-nonuniform-weak-agnostic-improper-pac`.

The target failure condition is quite specific. For a fixed marginal $P$, a counterexample must rule out every polynomial-time learner that is allowed to choose some marginal-dependent inverse-polynomial weak gap. Thus the hard family should have
$$
\operatorname{OPT}_{\mathcal C}(D_s) \le s^{-K}
$$
for arbitrary relevant $K$ or even $s^{-\omega(1)}$, while no efficient improper learner achieves error $1/2-s^{-k}$ for some inverse-polynomial advantage demanded by the alleged learner. Hardness at $\operatorname{OPT}=1/2-\tau$ or hardness of $\operatorname{OPT}+\varepsilon$ is not enough.

### Sources Checked

- Jizhou Huang and Brendan Juba, "Near-Optimal Cryptographic Hardness of Learning With Homogeneous Halfspaces Under Gaussian Marginals", arXiv:2604.26446, submitted 2026-04-29, https://arxiv.org/abs/2604.26446.
- Ilias Diakonikolas, Daniel M. Kane, and Lisheng Ren, "Near-Optimal Cryptographic Hardness of Agnostically Learning Halfspaces and ReLU Regression under Gaussian Marginals", arXiv:2302.06512, https://arxiv.org/abs/2302.06512.
- Stefan Tiegel, "Hardness of Agnostically Learning Halfspaces from Worst-Case Lattice Problems", arXiv:2207.14030 / COLT 2023, https://arxiv.org/abs/2207.14030.
- Ilias Diakonikolas, Daniel M. Kane, Pasin Manurangsi, and Lisheng Ren, "Cryptographic Hardness of Learning Halfspaces with Massart Noise", arXiv:2207.14266, https://arxiv.org/abs/2207.14266.
- Adam Kalai and Ravi Kanade, "On Agnostic Boosting and Parity Learning", https://www.microsoft.com/en-us/research/publication/agnostic-boosting-parity-learning/.
- Vitaly Feldman, Parikshit Gopalan, Subhash Khot, and Ashok Kumar Ponnuswami, "On Agnostic Learning of Parities, Monomials and Halfspaces", SIAM J. Comput. 2012 / arXiv:1012.0729, https://arxiv.org/abs/1012.0729.
- Adam Klivans and Pravesh Kothari, "Embedding Hard Learning Problems Into Gaussian Space", APPROX/RANDOM 2014, https://drops.dagstuhl.de/entities/document/10.4230/LIPIcs.APPROX-RANDOM.2014.793.
- Xue Chen, Wenxuan Shu, and Zhaienhe Zhou, "Algorithms for Sparse LPN and LSPN Against Low-noise", COLT 2025 extended abstract, https://proceedings.mlr.press/v291/chen25f.html.

### Huang--Juba 2026 Check

Huang--Juba is currently the sharpest-looking fixed-Gaussian source because it handles homogeneous halfspaces under the standard Gaussian marginal and is newer than the depth-1 sources. It still does not resolve this edge.

Their agnostic-learning problem asks for a homogeneous halfspace with error at most $\operatorname{opt}+\varepsilon$ under standard Gaussian $x$-marginals. The main lower bound says, assuming subexponential LWE hardness, that for any $\gamma>1/2$ there is no polynomial-time $(1,1/\log^{1/2+c}d)$-style additive approximation, with the formal corollary giving a forbidden $\varepsilon$ range up to $1/\log^\gamma d$.

The underlying indistinguishability theorem has the same structural limitation as the 2023 Gaussian-marginal LWE results:

- Alternative case: some homogeneous halfspace has agreement
  $$
  \frac12+\Omega\!\left(\frac{1}{\sqrt{\eta\log d}}\right).
  $$
- Null case: every homogeneous halfspace has agreement exactly $1/2$.

So, in the alternative case,
$$
\operatorname{OPT}_{\mathrm{homLTF}} =
\frac12-\Omega\!\left(\frac{1}{\sqrt{\eta\log d}}\right),
$$
not a low-noise or near-realizable instance. This can refute strong additive agnostic learning, but it does not force a weak-agnostic learner with tolerance $\beta_P(d)=1/2-1/q_P(d)$ to output a hypothesis with inverse-polynomial advantage when $q_P$ is large. The required upper bound
$$
\operatorname{OPT}+\beta_P(d) \le \frac12-\frac{1}{\operatorname{poly}(d)}
$$
fails for these instances unless the learner's gap is larger than the halfspace advantage already present in the construction.

Conclusion: Huang--Juba 2026 strengthens fixed-Gaussian homogeneous-halfspace hardness, but it remains an $\operatorname{OPT}+\varepsilon$ / small-correlation lower bound, not a low-noise weak no-advantage lower bound.

### Low-Noise Parity/LPN Check

Parities under the uniform hypercube marginal are the most tempting fixed-marginal witness:

- Realizable proper PAC learning is efficient by Gaussian elimination, so the source side is fine.
- A parity with random classification noise rate $\eta$ has $\operatorname{OPT}=\eta$ under the uniform marginal.
- A weak agnostic learner with gap $1/q(n)$ would be forced to get error below $1/2$ only when $\eta \ll 1/q(n)$.

Known parity/LPN evidence does not give the needed scale.

Constant-noise LPN and agnostic parity are believed hard and the best general algorithms are subexponential, e.g. the Kalai--Kanade parity learner runs in $2^{O(n/\log n)}$ and is explicitly not polynomial. But constant noise gives $\operatorname{OPT}=\Theta(1)$, so the weak additive target is vacuous for sufficiently small inverse-polynomial gaps.

Low-noise LPN assumptions exist, including regimes such as $\eta=n^{-c}$ or $\eta=\log^2 n/n$ in cryptographic work. These are still too large to defeat an arbitrary marginal-dependent gap $1/q_P(n)$; for example $\log^2 n/n$ eventually dominates $1/n^K$ for every $K>1$. Conversely, if $\eta$ is made superpolynomially small, the problem starts becoming algorithmically easy by drawing roughly $n$ equations: when the expected number of corrupted equations is $o(1)$, Gaussian elimination on a clean sample succeeds with noticeable probability and can be amplified or verified with extra samples.

Sparse-LPN-to-Gaussian reductions, such as Klivans--Kothari, give fixed Gaussian marginal hardness for $\operatorname{OPT}+\varepsilon$ learning with time lower bounds like $n^{\Omega(\log(1/\varepsilon))}$ under sparse-LPN assumptions. This is useful context for strong agnostic halfspace edges, but it again does not produce a fixed marginal distribution where $\operatorname{OPT}$ is below every relevant inverse polynomial and weak inverse-polynomial advantage is hard.

Conclusion: LPN/parity supplies the right fixed marginal and the right realizable source class, but available low-noise hardness assumptions either have OPT too large for the atlas weak tolerance or enter a noise regime where simple clean-sample recovery becomes plausible.

### Massart And Fixed-Marginal Variants

The Massart halfspace hardness of Diakonikolas--Kane--Manurangsi--Ren has a superficially attractive "tiny OPT" statement: under LWE hardness, no polynomial-time learner achieves error better than $\Omega(\eta)$ even when $\operatorname{OPT}\le 2^{-\log^{1-\zeta}N}$.

This still misses the present edge for two reasons.

First, the marginal is distribution-independent/arbitrary in the hard construction, not a single fixed Gaussian or hypercube marginal.

Second, the lower bound is not a no-advantage-over-random statement. For constant $\eta$, ruling out error below $\Omega(\eta)$ is much stronger near zero error but much weaker near $1/2$: it does not rule out an algorithm with error $1/2-1/\operatorname{poly}(N)$. For tiny $\eta$, the lower-bound threshold becomes tiny as well. Either way, it does not contradict the weak agnostic target.

This also clarifies why "tiny OPT" alone is not the right search term. The missing theorem must combine tiny OPT with hardness of even weak correlation recovery.

### Updated Verdict

`unresolved`.

I still do not see a sound proof of `true` or a sound conditional counterexample for `false`.

The most plausible false-witness direction remains halfspaces or parities, but the known fixed-marginal hardness results split the needed ingredients:

- fixed Gaussian/hypercube marginal plus $\operatorname{OPT}+\varepsilon$ hardness, with $\operatorname{OPT}$ close to $1/2$ or not controlled at the needed scale;
- low or tiny OPT hardness, but with arbitrary/changing marginals or a conclusion that does not rule out inverse-polynomial advantage over random guessing;
- parity/LPN fixed-uniform low-noise hardness assumptions, but only in noise regimes too large for arbitrary weak gaps or too low to remain plausibly hard.

The atlas edge should remain open/unknown unless a stronger fixed-marginal low-noise weak no-advantage theorem is found or the marginal-nonuniform target is strengthened to require a specified gap.

### Next Directions

- Search specifically for "planted parity with adversarial noise" or "agnostic parity weak learning" lower bounds under the uniform marginal where $\operatorname{OPT}\le n^{-K}$ for arbitrary $K$ but recovering any $n^{-k}$ correlation is hard. I did not find such a theorem in this pass.
- Ask whether any LPN assumption is standard for noise $\eta(n)$ chosen after seeing the learner's weak gap polynomial $q_P$. A nonuniform family of assumptions of this kind would be much stronger than ordinary low-noise LPN and should be flagged explicitly if used.
- For Gaussian halfspaces, look for a construction where labels are almost a true halfspace plus a pseudorandom rare corruption set under the standard Gaussian marginal. The existing CLWE band constructions instead make the best halfspace only mildly correlated with labels.
- If atlas definitions permit specifying the weak gap as part of the target rather than existentially by marginal, revisit Tiegel and low-noise LPN. Several known results would become usable for fixed gaps even though they do not refute the current existential weak target.

## Depth-3 Entry - 2026-05-04

### Goal

Follow the parity/LPN alternative witness more carefully for the edge
`efficient-marginal-nonuniform-realizable-proper-pac -> efficient-marginal-nonuniform-weak-agnostic-improper-pac`.

The question is whether parities under the uniform marginal give a cleaner false witness than halfspaces. They have a fixed natural marginal and a standard cryptographic hardness assumption, but the weak agnostic target has an existential marginal-dependent gap:
$$
\beta_U(n)=\frac12-g_U(n), \qquad g_U(n)\ge \frac{1}{\operatorname{poly}(n)}.
$$
Thus an LPN instance at noise rate $\eta(n)$ only threatens the target if the learner's guarantee forces a nontrivial advantage over random guessing.

### Sources Checked

- Local depth-2 entry above, especially the low-noise parity/LPN notes.
- Kalai, Mansour, and Verbin, "On Agnostic Boosting and Parity Learning", STOC 2008, DOI: https://doi.org/10.1145/1374376.1374466. Used for the computational hardness context of agnostic parity and the known subexponential parity learner.
- Yu, Zhang, Weng, Guo, and Li, "Collision Resistant Hashing from Sub-exponential Learning Parity with Noise", ASIACRYPT 2019, DOI: https://doi.org/10.1007/978-3-030-34621-8_1. The abstract records representative assumptions: constant-noise LPN, and low-noise LPN at rate $1/\sqrt n$ with subexponential hardness.
- Dao and Jain, "Lossy Cryptography from Code-Based Assumptions", arXiv:2402.03633, https://arxiv.org/abs/2402.03633. Checked for the modern status of extremely low-noise LPN; the abstract notes that the $\log^2 n/n$ noise-rate LPN assumption used for some advanced primitives is broken in quasipolynomial time.
- Chen, Shu, and Zhou, "Algorithms for Sparse LPN and LSPN Against Low-noise", arXiv:2407.19215 / COLT 2025, https://arxiv.org/abs/2407.19215. Checked only as supporting algorithmic context that low-noise variants are delicate and often easier as the noise falls.
- Garg, Kothari, Liu, and Raz, "Memory-Sample Lower Bounds for Learning Parity with Noise", RANDOM 2021 / arXiv:2107.02320, https://arxiv.org/abs/2107.02320. Checked to separate generic LPN hardness evidence from unrestricted polynomial-time PAC learning; their lower bound trades memory against samples rather than giving the needed fixed-marginal PAC impossibility.

### Does The Parity Class Satisfy The Source?

Yes.

Let $\mathcal C_n=\{x\mapsto \langle a,x\rangle \bmod 2:a\in\mathbb F_2^n\}$, with the usual representation size $s=\Theta(n)$. In the realizable case, a proper learner collects labeled linear equations and returns any parity consistent with the sample, using Gaussian elimination. Standard VC/PAC generalization for a consistent hypothesis gives distribution-free efficient proper PAC learning with polynomial sample and time bounds. Therefore parities satisfy `efficient-realizable-proper-pac`, hence also the marginal-nonuniform source node.

This part is stronger than needed: no fixed-marginal subtlety is required.

### Noise Rate Versus Weak Gap

For an LPN distribution under the uniform marginal,
$$
y=\langle a,x\rangle \oplus e,\qquad e\sim \operatorname{Bernoulli}(\eta),
$$
the best parity has error
$$
\operatorname{OPT}_{\mathcal C}=\eta.
$$
If a weak agnostic learner for the uniform marginal has gap $g(n)$, its guarantee on this distribution is
$$
\operatorname{err}(h)
\le
\eta+\frac12-g(n)
=
\frac12-(g(n)-\eta).
$$
So the learner yields an LPN distinguisher or predictor with advantage only when
$$
g(n)-\eta(n)\ge \frac{1}{\operatorname{poly}(n)}.
$$
If $\eta(n)\ge g(n)$, the promised error bound is at least $1/2$, and a trivial majority/random-style hypothesis can already meet the weak guarantee. If $\eta(n)$ is only infinitesimally below $g(n)$, the induced advantage may also be too small to contradict ordinary cryptographic LPN assumptions.

This is the central obstruction: the atlas target does not fix $g(n)$. It merely requires some inverse-polynomial gap depending on the marginal. A false witness must defeat even a learner that chooses a very small gap.

### Why Standard Low-Noise LPN Does Not Refute The Target

The usual LPN assumptions do not align with the needed inequality.

- Constant-noise LPN has $\eta=\Theta(1)$. Then $\operatorname{OPT}=\Theta(1)$, and the weak additive guarantee is vacuous for any sufficiently small inverse-polynomial $g(n)$.
- Common low-noise assumptions such as $\eta=1/\sqrt n$ or $\eta=\log^2 n/n$ still have $\eta$ larger than plausible weak gaps such as $g(n)=\Theta(\log n/n)$ or $g(n)=1/n^2$. They therefore do not force the learner to achieve any advantage over $1/2$.
- Assuming hardness at $\eta=n^{-c}$ only helps against learners whose gap is noticeably larger than $n^{-c}$. It cannot refute a target learner that is allowed to choose $g(n)=n^{-(c+1)}$, because then $\eta>g$ and the weak guarantee again permits error at least $1/2$.

To rule out the marginal-nonuniform weak target for parities, one would need something like: for every polynomially small candidate gap $g(n)$, LPN remains hard at some noise $\eta(n)\le g(n)-1/\operatorname{poly}(n)$. But that pushes the assumption below the regime usually treated as cryptographically plausible.

### Clean-Sample Algorithm At Very Low Noise

There is also a positive algorithmic reason not to trust such an assumption.

Under the uniform marginal, suppose $\operatorname{OPT}=\eta$ for some best parity. Draw $m=\Theta(n)$ examples. With constant probability the $x$'s span $\mathbb F_2^n$. Conditional on the best parity, the chance all $m$ labels are uncorrupted is
$$
(1-\eta)^m \approx \exp(-\eta m).
$$
If $\eta=O(\log n/n)$, this probability is at least inverse polynomial. Repeating polynomially many times, solving each clean full-rank system by Gaussian elimination, and validating candidates on fresh data finds a near-optimal parity with high probability. If no parity has error below this scale, then taking the better constant label already has error at most $1/2$, which is enough for a weak guarantee with gap about $\Theta(\log n/n)$ whenever $\operatorname{OPT}\ge g(n)$.

Thus uniform parities themselves appear compatible with a marginal-specific weak agnostic learner with inverse-polynomial gap roughly
$$
g_U(n)=\Theta(\log n/n)
$$
by the elementary "repeat until the sample is clean" strategy. This is not a full atlas proof for every marginal, but it is enough to block the intended fixed-uniform LPN counterexample.

The same calculation explains the boundary:

- $\eta \ll 1/n$: clean samples occur with constant probability, so recovery is plainly polynomial.
- $\eta=\Theta(\log n/n)$: clean samples occur with inverse-polynomial probability, still enough for polynomial repetition.
- $\eta=\Theta(\log^2 n/n)$: clean samples occur with probability $\exp(-\Theta(\log^2 n))$, matching quasipolynomial rather than polynomial behavior; this is a natural low-noise cryptographic regime, but it is above the weak gap $g_U(n)=\Theta(\log n/n)$ and so does not contradict the weak target.
- $\eta=n^{-c}$ with $0<c<1$: this is above $\log n/n$ for large $n$, so it is too noisy to refute such a weak target.

### Verdict For The Parity/LPN Route

`unresolved` for the original edge; `not a resolved false witness` for parities/LPN.

Parities satisfy the source, but standard or plausible subconstant-noise LPN assumptions do not rule out the marginal-nonuniform weak agnostic improper target. The noise rate must lie below the learner's weak gap by an inverse-polynomial margin, while the target may choose a very small marginal-dependent gap. At the low noise levels needed to beat a gap like $\Theta(\log n/n)$, an elementary clean-sample Gaussian-elimination algorithm already gives polynomial-time recovery under the uniform marginal.

So the parity/LPN alternative does not improve the halfspace situation. It clarifies the quantitative obstruction: fixed uniform marginal is available, but the weak gap is too permissive. The atlas edge should remain `open` / `unknown`, not `false` on the basis of LPN.

## Depth-4 Entry - 2026-05-04

### Purpose

This is the final follow-up for
`efficient-marginal-nonuniform-realizable-proper-pac -> efficient-marginal-nonuniform-weak-agnostic-improper-pac`.

Depth 3 for the neighboring distribution-free source found a promising clean-batch robustification: if the realizable learner has one distribution-free polynomial bound, then very-low-noise agnostic instances can be handled by repeatedly running the realizable learner on small batches until one batch is clean, while higher-OPT instances are handled by a constant predictor and validation. The remaining question is whether that proof also works when the source learner has only marginal-dependent polynomial bounds.

### Why The Clean-Batch Proof Does Not Transfer Automatically

Fix an original marginal $P$ and an agnostic joint distribution $\mathcal D$ with marginal $P$. Let $c^\star\in\mathcal C$ be nearly optimal and write
$$
\eta=\operatorname{err}_{\mathcal D}(c^\star).
$$
The clean-batch argument conditions on the event that all labels in a fresh batch agree with $c^\star$. Conditional on this event, the examples are realizable by $c^\star$, but their instance marginal is not generally $P$. For one clean example the conditional marginal is
$$
dQ(x)=\frac{\Pr[Y=c^\star(X)\mid X=x]}{1-\eta}\,dP(x).
$$
For a clean batch, the examples are i.i.d. from this $Q$, labeled by $c^\star$.

In the distribution-free source setting, this change of marginal is harmless: the realizable learner has the same polynomial sample/time bound for every marginal, so running it with the distribution-free batch size works under $Q$ just as it worked under $P$.

In the present marginal-nonuniform source setting, the source only says:
$$
\text{for every marginal } R,\text{ there exists some polynomial } p_R.
$$
Thus the learner has a polynomial bound $p_Q$ on the clean conditional marginal $Q$, but the target learner for the original marginal $P$ needs one polynomial $p_P^{\mathrm{target}}$ that works for every conditional label rule over $P$. The clean-batch proof would need a polynomial envelope, depending only on $P$, that bounds the realizable learner's behavior on every possible clean conditional marginal $Q$ arising from low-noise conditionals over $P$.

The source definition gives no such envelope. Even when $\eta$ is tiny, $Q$ is only close to $P$ in total variation:
$$
\operatorname{TV}(P,Q)\le \frac{\eta}{1-\eta}.
$$
Marginal-nonuniform polynomial bounds are not assumed to be continuous, monotone under bounded-density reweightings, or uniformly controlled in any total-variation neighborhood of $P$. A realizable learner may have a modest polynomial bound under $P$ while having much larger, still polynomial but with uncontrolled exponent or constants, bounds under nearby marginals $Q$. Since $Q$ depends on the unknown conditional label distribution and on the near-optimal concept $c^\star$, allowing the target polynomial to depend on $Q$ would violate the target quantifiers.

This is the exact point where the distribution-free robustification uses more than the current source gives. The obstruction is not statistical: if one ignores runtime, fixed-marginal covers or VC-style arguments can still support agnostic sample guarantees. The obstruction is computational bookkeeping across the family of clean conditional marginals generated from a single original marginal.

### What Would Make The Positive Proof Work

A strengthened source would be enough. For example, the clean-batch proof should go through if the source node also required one of the following:

- a distribution-free polynomial sample/time bound for the realizable learner;
- for every original marginal $P$, a polynomial envelope controlling the learner on all low-noise clean conditional marginals $Q\ll P$ with density bounded near $1$;
- a stability condition saying the learner's marginal-dependent polynomial bound is locally controlled under total-variation-small or bounded-density perturbations of $P$;
- efficient fixed-marginal cover enumeration or agnostic ERM under $P$, which would bypass the clean-batch call to the learner under $Q$.

None of these conditions is part of `efficient-marginal-nonuniform-realizable-proper-pac` as currently defined.

### Negative Routes Rechecked

The earlier false-witness searches still do not resolve the edge.

Halfspaces satisfy the source, but the available hardness results split the needed ingredients:

- Tiegel's distribution-independent halfspace hardness has the right weak no-advantage flavor, but the hard marginals vary and the known $\operatorname{OPT}$ scale is subpolynomially small rather than below an arbitrary marginal-dependent inverse-polynomial weak gap.
- Tiegel's standard-Gaussian theorem and the Diakonikolas--Kane--Ren / Huang--Juba Gaussian-marginal lines fix the marginal, but they prove strong $\operatorname{OPT}+\varepsilon$ hardness where the best halfspace is only mildly correlated with the labels. That does not refute a weak additive tolerance close to $1/2$.
- Daniely/random-CSP and monomial/conjunction hardness results give useful distribution-free weak-hardness evidence, but not a fixed or marginal-nonuniform-compatible hard marginal with $\operatorname{OPT}$ below the unknown weak gap and an arbitrary-improper no-advantage conclusion.
- Parity/LPN under the uniform marginal has the right fixed marginal and the right realizable proper source class, but standard constant or moderate low-noise LPN has $\operatorname{OPT}$ too large for the atlas weak target. Pushing the noise below the clean-batch scale for full parities makes elementary clean-sample Gaussian-elimination attacks polynomial.

Thus there is still no atlas-ready conditional counterexample.

### Atlas-Ready Unresolved Summary

Recommended current atlas status: keep
$$
\texttt{status: "open"},\qquad \texttt{evidence: unknown}.
$$

Suggested summary:

> Open: the distribution-free clean-batch robustification from realizable learning to weak agnostic learning does not automatically apply to a marginal-nonuniform realizable source, because the clean batch is drawn from a conditional marginal $Q$ whose learner polynomial may not be bounded by any polynomial depending only on the original marginal $P$. Known halfspace, random-CSP, Gaussian-marginal, and LPN hardness results also do not provide a fixed-marginal low-OPT weak no-advantage counterexample.

Suggested proof-status text:

> A distribution-free realizable learner can be robustified by running on repeated small batches: if $\operatorname{OPT}$ is not tiny, a constant predictor suffices for the weak additive target; if $\operatorname{OPT}$ is tiny, a batch with no corruptions appears with polynomial probability and the realizable learner produces a candidate that validation can select. For a marginal-nonuniform source, conditioning on a clean batch changes the instance marginal from $P$ to $Q(dx)\propto \Pr[Y=c^\star(X)\mid X=x]P(dx)$. The source gives a polynomial bound for $Q$, but that bound may depend on $Q$, while the target requires one polynomial depending only on $P$ and working for all conditionals over $P$. No local-uniformity or bounded-density stability of the marginal-dependent runtime is assumed. Therefore the clean-batch proof is not an atlas-ready theorem for this edge.

### Final Verdict

`unresolved`.

The edge should not be marked `true` using the clean-batch robustification unless an additional envelope/stability condition is added to the source or proved from the existing marginal-nonuniform definition. It should not be marked `false` either, because the checked hardness literature still lacks a fixed-marginal or marginal-family counterexample with sufficiently tiny $\operatorname{OPT}$ and an arbitrary-improper weak no-advantage lower bound.

## Depth-5 Entry - 2026-05-05

### Verdict

`resolved true`, with evidence `theorem`.

The depth-4 obstruction was real for the conditioned-marginal proof as written, but it is avoidable. One should not condition on the event that a batch is clean and then invoke the learner under the conditional marginal $Q$. Instead, couple the noisy sample from the original marginal $P$ with the realizable sample from the same $P$. When the low-noise sample contains no corruptions among the examples inspected by the realizable learner, the transcript is exactly the transcript of the original marginal-$P$ realizable experiment. Therefore the same marginal-dependent polynomial $p_P$ is enough.

This resolves the edge under the standard atlas convention used by `low-noise-weak-agnostic-robustification`: the source learner is an algorithm that can be run on arbitrary labeled samples, with the running-time/sample bound controlled, for the fixed marginal $P$, by its realizable invocation parameters; only the correctness guarantee is realizability-specific.

### Definitions Used

- Source: `efficient-marginal-nonuniform-realizable-proper-pac`. There is one uniform learner $A$ such that, for each marginal $P$, some polynomial $p_P$ bounds its realizable proper PAC sample/time cost for all targets $c\in\mathcal C$.
- Target: `efficient-marginal-nonuniform-weak-agnostic-improper-pac`. For each marginal $P$, one must produce a polynomial-time learner and an additive tolerance
  $$
  \beta_P(s)=\frac12-\alpha_P(s)
  $$
  where $\alpha_P(s)$ is inverse-polynomial in $s$, such that for every joint distribution $\mathcal D$ with marginal $P$,
  $$
  \operatorname{err}_{\mathcal D}(h)\le \operatorname{OPT}_{\mathcal C}(\mathcal D)+\beta_P(s).
  $$
- Properness only helps the source; the target is improper, so all proper hypotheses returned by $A$ are admissible target hypotheses.
- Marginal nonuniformity allows the final weak gap and runtime polynomial to depend on the original marginal $P$, but not on the agnostic conditional label rule.

### Sources Checked

- Local atlas definitions:
  - `atlas/definitions/efficient-marginal-nonuniform-realizable-proper-pac.md`
  - `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
  - `atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`
  - `atlas/arguments/low-noise-weak-agnostic-robustification.md`
  - `atlas/arguments/marginal-agnostic-hardness-open.md`
  - `atlas/arguments/marginal-boosting-open.md`
  - `atlas/arguments/marginal-uniformization-open.md`
- Local bibliography entries in `references.bib` for `valiant1984`, `blumer1989`, `benedek1991fixed`, `bendavid1995parameterization`, `hanneke2025marginalnonuniform`, and `tiegel2023`.
- Browsed primary-source pages:
  - Hanneke, Moran, and Thiessen, "Marginal-Nonuniform PAC Learnability", OpenReview: https://openreview.net/forum?id=aoVCFtox89. The page states that marginal-nonuniform guarantees may depend on the marginal distribution but hold uniformly over all concepts.
  - Benedek and Itai, "Learnability with respect to fixed distributions", DOI/ScienceDirect: https://doi.org/10.1016/0304-3975(91)90026-X. The abstract records the fixed-distribution learning setting and its finite-cover/sample focus.
- Background URLs already checked in earlier depths remain relevant as false-route near misses: Tiegel 2023 at https://proceedings.mlr.press/v195/tiegel23a.html, Diakonikolas--Kane--Ren 2023 at https://arxiv.org/abs/2302.06512, Huang--Juba 2026 at https://arxiv.org/abs/2604.26446, and the parity/LPN references listed in Depths 2 and 3.

### Theorem Route

Fix a marginal $P$ and representation size $s$. Let $A$ be the source learner. Run $A$ with constant accuracy and confidence parameters, say $\varepsilon_0=1/16$ and failure probability $\delta_0=1/16$. Let
$$
m_P(s)
$$
be a marginal-dependent polynomial upper bound on the number of examples and time used by this invocation of $A$ under marginal $P$. Define the weak gap
$$
\alpha_P(s)=\min\left\{\frac{1}{64},\frac{1}{64m_P(s)}\right\},
\qquad
\beta_P(s)=\frac12-\alpha_P(s).
$$
This is an inverse-polynomial gap depending only on $P$.

The target learner $B$ is simple:

1. Include the two constant classifiers as candidates.
2. Run $A$ independently $R=O(\log(1/\delta))$ times on fresh labeled examples from the agnostic distribution, using the fixed parameters $(\varepsilon_0,\delta_0)$, and add every returned hypothesis to the candidate list.
3. Use a fresh validation sample of size $O(\log(R/\delta))$ to estimate each candidate's error to a small absolute constant, for example $1/32$.
4. Let $b$ be the empirically better constant classifier and let $h$ be the empirically best hypothesis returned by the $A$ runs. Output $h$ only if its empirical error beats $b$ by a fixed margin, say $1/8$; otherwise output $b$.

For this fixed $P$, the sample and time cost are bounded by a polynomial in $m_P(s)$ and $\log(1/\delta)$, hence by a marginal-dependent polynomial.

Now analyze any joint distribution $\mathcal D$ with marginal $P$. Let $c^\star\in\mathcal C$ satisfy
$$
\eta=\operatorname{err}_{\mathcal D}(c^\star)\le \operatorname{OPT}_{\mathcal C}(\mathcal D)+o(1)
$$
or take an $\eta$-near minimizer and absorb the approximation.

If $\operatorname{OPT}_{\mathcal C}(\mathcal D)\ge \alpha_P(s)$, then one of the two constant classifiers has error at most $1/2$, and
$$
\frac12\le \operatorname{OPT}_{\mathcal C}(\mathcal D)+\frac12-\alpha_P(s).
$$
The validation rule either outputs a near-best constant or a candidate that empirically beats that constant by a margin; with the constant-accuracy validation event, the returned hypothesis has true error at most $1/2$ up to harmless slack that is removed by slightly increasing the fixed margins above. Thus the weak guarantee holds in the high-OPT case.

If $\operatorname{OPT}_{\mathcal C}(\mathcal D)<\alpha_P(s)$, choose $c^\star$ with $\eta<\alpha_P(s)$ after the usual approximation. Couple one run of $A$ on noisy examples $(X,Y)\sim\mathcal D$ with one run on realizable examples $(X,c^\star(X))$ using the same instance sequence $X_1,X_2,\ldots$ and the same internal randomness. Since $A$ inspects at most $m_P(s)$ examples in this fixed-marginal invocation, the probability that any inspected label is corrupted is at most
$$
m_P(s)\eta<\frac{1}{64}.
$$
On the no-corruption event, the noisy transcript is exactly the realizable transcript under the original marginal $P$, not under a conditional marginal $Q$. By the source guarantee, with probability at least $1-\delta_0$ the realizable transcript returns $h$ with
$$
\operatorname{err}_P(h,c^\star)\le \varepsilon_0.
$$
Therefore one run produces, with constant probability, a candidate satisfying
$$
\operatorname{err}_{\mathcal D}(h)
\le \eta+\operatorname{err}_P(h,c^\star)
\le \alpha_P(s)+\frac{1}{16}
<\frac18 .
$$
After $O(\log(1/\delta))$ independent runs, such a candidate appears with probability at least $1-\delta/3$. Constant-accuracy validation then either selects a similarly good returned candidate or a constant classifier whose validation error is close to that good candidate's validation error. In both cases the output has true error bounded by an absolute constant below $1/2$, for example below $1/4$ with the constants above. Since
$$
\operatorname{OPT}_{\mathcal C}(\mathcal D)+\frac12-\alpha_P(s)
\ge \frac12-\alpha_P(s)
\ge \frac{31}{64},
$$
the weak agnostic guarantee holds.

The key point is the coupling step. The clean-event conditioning formula
$$
dQ(x)=\frac{\Pr[Y=c^\star(X)\mid X=x]}{1-\eta}\,dP(x)
$$
describes the distribution of examples conditional on cleanliness, but the algorithmic proof need not run the source learner under $Q$. It compares the noisy run directly with the realizable run on the same $P$-distributed instance sequence. This keeps the marginal-dependent polynomial attached to the original $P$ throughout the proof.

### Counterexample Route

The earlier counterexample searches no longer look decisive, and they are not needed for this edge:

- Halfspace hardness from Tiegel and Gaussian-marginal LWE sources remains a near miss for false edges because fixed-marginal results are strong-agnostic rather than low-OPT weak no-advantage, while distribution-free weak no-advantage constructions vary the marginal or have the wrong OPT scale.
- Parity/LPN under the uniform marginal has the right source class and fixed marginal, but the weak gap can be chosen at the clean-sample scale, and very-low-noise parity is attacked by repeated clean Gaussian-elimination samples.
- Random-CSP, monomial, conjunction, and properization-style routes do not refute this edge because the target is improper and the theorem above gives a direct marginal-preserving weak agnostic learner.

Thus the previous false-route obstructions become supporting context rather than evidence for openness.

### Concrete Obstruction Resolved

The concrete obstruction at Depth 4 was:

> A clean batch conditioned on no corruptions has marginal $Q$, and the marginal-nonuniform source gives no $P$-only envelope over the learner's runtime on all such $Q$.

The resolution is:

> Do not condition and then invoke the source guarantee under $Q$. Couple the noisy and realizable experiments using the same $P$-distributed instances. In the low-OPT regime, with constant probability no inspected label is corrupted, so the noisy transcript equals the realizable transcript under $P$. The source guarantee and its polynomial are therefore used only for $P$.

The remaining technical convention to make explicit in the atlas text is that the realizable learner can be executed on arbitrary labeled data, with correctness only promised under realizability. This is the same convention implicitly used by the existing low-noise robustification note.

### Exact Atlas Changes If Applied

Do not edit atlas files in this task, but the resolved atlas patch should make the following changes.

In `atlas/implications/efficient-marginal-nonuniform-realizable-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-improper-pac.md`:

- Change frontmatter:
  - `status: "open"` to `status: "true"`.
  - `evidence: unknown` to `evidence: theorem`.
  - Add `valiant1984` and `blumer1989` to `ref_keys`.
  - Add `[Valiant 1984](https://doi.org/10.1145/1968.1972)` and `[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)` to `refs`.
  - Change `summary` to:
    `"True: a low-noise coupling robustifies the marginal-nonuniform realizable learner without changing the marginal; when OPT is larger than the marginal-dependent weak gap, a constant classifier suffices."`
  - Change `argument_note` to `[[low-noise-weak-agnostic-robustification|Low-Noise Weak Agnostic Robustification]]` or add a new argument note if the atlas wants to keep the marginal-preserving coupling as a separate lemma.
- Replace the verdict/proof body with:

```markdown
## Verdict

`true`, by a marginal-preserving low-noise robustification.

## Proof Sketch

Fix a marginal $P$ and let $A$ be the marginal-nonuniform realizable proper learner. Run $A$ with constant accuracy and confidence, and let $m_P(s)$ be the resulting marginal-dependent polynomial sample/time bound. Set
$$
\alpha_P(s)=\min\{1/64,1/(64m_P(s))\},\qquad
\beta_P(s)=1/2-\alpha_P(s).
$$

The weak agnostic learner includes the two constant classifiers, runs $A$ a logarithmic number of times on fresh agnostic samples, validates all returned hypotheses to constant accuracy, and outputs a returned hypothesis only if it beats the best constant by a fixed validation margin; otherwise it outputs the best constant.

If $\operatorname{OPT}_{\mathcal C}(\mathcal D)\ge \alpha_P(s)$, a constant classifier of error at most $1/2$ already satisfies
$$
1/2\le \operatorname{OPT}_{\mathcal C}(\mathcal D)+1/2-\alpha_P(s).
$$

If $\operatorname{OPT}_{\mathcal C}(\mathcal D)<\alpha_P(s)$, choose a near-optimal $c^\star\in\mathcal C$ with error $\eta<\alpha_P(s)$. Couple one run of $A$ on noisy examples $(X,Y)\sim\mathcal D$ with one run on realizable examples $(X,c^\star(X))$ using the same $P$-distributed instance sequence. Since $A$ inspects at most $m_P(s)$ examples, the probability that any inspected label is corrupted is at most $m_P(s)\eta<1/64$. On the no-corruption event the noisy transcript is exactly the realizable transcript under the original marginal $P$, so the source guarantee gives a hypothesis $h$ with small $\operatorname{err}_P(h,c^\star)$ with constant probability. Then
$$
\operatorname{err}_{\mathcal D}(h)\le \eta+\operatorname{err}_P(h,c^\star)
$$
is bounded by an absolute constant below $1/2$. Repetition and constant-accuracy validation find such a candidate with high probability. This is stronger than the required weak guarantee with tolerance $\beta_P(s)$.

The proof avoids the conditional-marginal obstruction: although conditioning on clean labels would define a marginal $Q\ll P$, the coupling argument never invokes the learner's guarantee under $Q$. The only polynomial used is the original marginal-dependent polynomial $m_P$.
```

In `atlas/arguments/low-noise-weak-agnostic-robustification.md`:

- Update the final sentence that currently says the proof does not automatically apply to marginal-nonuniform sources. Replace it with a note that the conditional-marginal presentation is unnecessary: for marginal-nonuniform realizable sources, the same conclusion follows by coupling noisy and realizable runs on the same original marginal $P$ and choosing the weak gap below the inverse of the $P$-specific sample bound.

In `atlas/arguments/marginal-agnostic-hardness-open.md`:

- Remove this edge from the family discussion or add a sentence saying this particular edge is resolved by the marginal-preserving coupling, while other marginal-source agnostic-hardness edges may remain open if they lack the same low-noise realizable-source structure.
