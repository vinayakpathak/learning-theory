# Edge: efficient-marginal-nonuniform-agnostic-improper-pac -> efficient-marginal-nonuniform-weak-realizable-proper-pac

- depth: 1
- edge_file: `atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- source: [[efficient-marginal-nonuniform-agnostic-improper-pac|Efficient Marginal-Nonuniform Agnostic Improper PAC Learning]]
- target: [[efficient-marginal-nonuniform-weak-realizable-proper-pac|Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]]
- verdict: resolved-false, conditional on $\mathrm{NP}\nsubseteq\mathrm{RP}$
- confidence: medium-high under the current atlas pathwise runtime convention

## Executive Summary

The edge should be false under the same PCP active-slice witness used for the distribution-free weak proper separations.

The previous scratchpad left this edge open because the hard active-slice marginal depends on the input formula, so a marginal-nonuniform target learner may have a formula-dependent polynomial and a formula-dependent weak advantage. Under the current `atlas/README.md` convention, however, efficient learners have worst-case/pathwise polynomial running time on finite encoded sample transcripts. That lets us uniformize the runtime of a hypothetical marginal-nonuniform weak proper learner by applying its resource bound to a full-support reference marginal.

The remaining formula-dependent weak advantage is not a problem for the PCP active-slice reduction. On a satisfiable instance, any positive weak advantage means the returned proper proof accepts strictly more than half of the verifier random strings. On an unsatisfiable instance, PCP soundness keeps every proper proof below one half. Because the verifier uses logarithmic randomness, the active slice is polynomial size and the acceptance probability can be checked exactly.

Thus an efficient marginal-nonuniform weak realizable proper learner for the PCP active-slice lookup class would give an RP algorithm for an NP-complete language.

## Sources Read

- `atlas/README.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/implications/efficient-agnostic-improper-pac--implies--efficient-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`
- Primary-source checks: Håstad-Khot 2005 for logarithmic-randomness perfect-completeness PCPs with soundness below $1/2$; Benedek-Itai 1991 and Hanneke-Moran-Thiessen 2025 for the fixed/marginal-nonuniform background; Schapire 1990 only for weak-learning context.

## Witness

Use the [[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]] from [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]].

Choose a perfect-completeness PCP for an NP-complete language with $O(\log n)$ random bits and soundness $q<1/2$. Håstad and Khot give logarithmic randomness, perfect completeness, and soundness $2^{-k^2}+\epsilon$; take, for example, $k=2$ and a small enough constant $\epsilon$.

The instance domain contains pairs $(\psi,r)$, where $\psi$ is an NP instance and $r$ is a verifier random string. A proper concept is indexed by an instance-proof pair $(\varphi,\pi)$ and is defined by

$$
c_{\varphi,\pi}(\psi,r)=
\begin{cases}
V(\varphi,\pi,r), & \psi=\varphi,\\
0, & \psi\ne\varphi.
\end{cases}
$$

For a fixed $\varphi$, the active slice $\{(\varphi,r):r\in R_\varphi\}$ has polynomial size because $|R_\varphi|=2^{O(\log |\varphi|)}=\operatorname{poly}(|\varphi|)$.

## Source Holds

The witness satisfies the stronger [[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]] node, hence it satisfies the assigned marginal-nonuniform agnostic improper source.

For size $s$, let the improper comparison class contain:

- the all-zero hypothesis;
- for every instance slice $\psi$ of size at most $s$, every Boolean lookup table on the polynomial-size active slice $R_\psi$.

This improper class contains every proper concept of size at most $s$. Its logarithmic cardinality is polynomial in $s$: there are exponentially many possible slices and exponentially many tables on each polynomial-size slice, so the logarithm is still polynomial.

ERM over this improper class is polynomial on a sample. Only slices appearing in the sample can beat the all-zero hypothesis, and for each sampled slice the best table is obtained by empirical majority vote on the observed verifier-randomness points. Standard finite-class uniform convergence, as in the VC/finite-class PAC bounds of Blumer-Ehrenfeucht-Haussler-Warmuth, then gives efficient distribution-free agnostic improper learning against the proper class. Distribution-free learning immediately implies the marginal-nonuniform source.

## Target Fails

Assume, for contradiction, that the same class has an efficient marginal-nonuniform weak realizable proper learner $A$.

### Runtime Uniformization

The atlas currently states that computationally efficient resource bounds are worst-case/pathwise bounds on finite encoded sample transcripts. Therefore $A$ cannot hide exponential running time on the active-slice transcripts just because the active-slice marginal varies with the input.

Formally, fix a full-support reference marginal $P^\star$ over all finitely encoded examples $(\psi,r)$. Applying the target guarantee to $P^\star$ gives some polynomial $p_{P^\star}$ bounding the sample use and running time of this one learner on finite transcripts. Since the resource bound is pathwise, $p_{P^\star}$ also bounds the active-slice transcripts used below. This is exactly the runtime part of [[full-support-marginal-uniformization|Full-Support Marginal Uniformization]].

This is the point that changes the previous open analysis. The active-slice marginal $P_\varphi$ may still have its own hidden weak advantage $\gamma_{P_\varphi}(s)$, but the reduction no longer loses polynomial-time control of $A$.

### Reduction

Given an NP instance $\varphi$, let $P_\varphi$ be the uniform marginal on the active slice $\{(\varphi,r):r\in R_\varphi\}$. Feed $A$ examples labeled constantly by $1$:

$$
(\varphi,r)\mapsto 1.
$$

Run $A$ with confidence, say, $\delta=1/3$. The run is polynomial time by the full-support pathwise bound above.

If $\varphi$ is satisfiable, perfect completeness gives a proof $\pi$ such that $c_{\varphi,\pi}(\varphi,r)=1$ for every $r$. Thus the labeled active-slice distribution is realizable. The marginal-nonuniform weak guarantee for $P_\varphi$ gives, with probability at least $2/3$, a proper hypothesis $h\in\mathcal C$ with

$$
\operatorname{err}_{P_\varphi}(h,1)\le \frac12-\gamma_{P_\varphi}(s)
$$

for some $\gamma_{P_\varphi}(s)>0$. Equivalently, $h$ outputs $1$ on strictly more than half of the active slice.

If $\varphi$ is unsatisfiable, every valid proper concept has active-slice acceptance at most $q<1/2$: concepts indexed by $\varphi$ are bounded by PCP soundness, and concepts indexed by $\psi\ne\varphi$ output $0$ on the $\varphi$ slice. Invalid outputs can simply be rejected by the reduction.

Since the active slice has polynomial size, enumerate all verifier random strings $r\in R_\varphi$ and compute the exact fraction of points on which the returned proper hypothesis outputs $1$. Accept iff this fraction is strictly greater than $1/2$.

This is a one-sided randomized polynomial-time decision procedure:

- satisfiable instances are accepted with probability at least $2/3$;
- unsatisfiable instances are never accepted.

Therefore the target learner would imply $\mathrm{NP}\subseteq\mathrm{RP}$.

## Why the Hidden Weak Gap Is Harmless Here

For many marginal-nonuniform-to-distribution-free questions, the hidden exponent in $\gamma_P(s)$ is a genuine obstruction. Here it is not.

The reduction never needs to know or estimate $\gamma_{P_\varphi}(s)$. It only uses the qualitative fact that $\gamma_{P_\varphi}(s)>0$. On the active slice, proper hypotheses have rational acceptance probabilities over a polynomial-size set, and we check the exact acceptance against the threshold $1/2$. Thus any positive weak advantage crosses the threshold in the satisfiable case, while soundness keeps the unsatisfiable case below the threshold.

The only marginal-nonuniform loophole was runtime. The current atlas pathwise convention closes that loophole through the full-support transcript bound.

## Caveat

This resolution depends on the current atlas semantics that efficient running time is worst-case/pathwise over finite encoded sample transcripts. If the atlas were changed to allow running-time bounds only with high probability under the current marginal, or only on realizable transcripts in a way that permits arbitrary behavior on the unsatisfiable active-slice labels, then the older open obstruction would return.

Under the present `atlas/README.md` convention, however, the edge is resolved as a conditional non-implication.

## Suggested Atlas Update

Do not apply this here; the assigned write target is only this scratchpad. If the edge is updated later, the metadata should be along the following lines:

```yaml
status: "false"
evidence: conditional-counterexample
assumptions:
  - "NP not subset RP"
witnesses:
  - pcp-active-slice-lookup-class
ref_keys:
  - blumer1989
  - hastad2005query
  - karp1972
summary: "False under NP not subset RP: the PCP active-slice lookup class is efficiently agnostically learnable improperly, but a marginal-nonuniform weak realizable proper learner would have pathwise uniform runtime and any positive active-slice weak advantage would produce a PCP proof accepted on more than half the verifier random strings."
family: pcp-active-slice-weak-proper-hardness
argument_note: "[[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]"
witness_note: "[[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]]"
```

## References

- [Håstad and Khot 2005](https://theoryofcomputing.org/articles/v001a007/)
- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
- [Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)
- [Benedek and Itai 1991](https://doi.org/10.1016/0304-3975(91)90026-X)
- [Hanneke, Moran, and Thiessen 2025](https://openreview.net/forum?id=aoVCFtox89)
