# Scratchpad: Efficient Weak Agnostic Proper PAC -> Efficient Agnostic Improper PAC

Edge file: `atlas/implications/efficient-weak-agnostic-proper-pac--implies--efficient-agnostic-improper-pac.md`

Depth log starts at depth 1 from the main agent's depth 0.

## Current Verdict

Unresolved at launch.

## Depth 1 Attempt

### Question And Interpretation

Edge under study:

`efficient-weak-agnostic-proper-pac -> efficient-agnostic-improper-pac`.

The source note defines the Ben-David--Long--Mansour additive weak agnostic notion:

$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta,
\qquad \beta<1/2,
$$

with proper output. The target asks for an efficient improper learner with error
\(\operatorname{OPT}_{\mathcal C}+\varepsilon\).

Important schema point: the definition prose says "fixed additive weak-agnostic tolerance" \(\beta<1/2\). Many generated theorem statements rewrite this as
\(\operatorname{OPT}+1/2-\gamma(s)\) with inverse-polynomial \(\gamma(s)\). The current edge note itself treats the active atlas node as the fixed-constant-\(\beta\) version and explicitly separates off the inverse-polynomial-gap variant. My conclusion below follows that local interpretation. If the intended schema is instead inverse-polynomial weak gap, this edge needs separate reclassification rather than just more research.

### Translation To Known Agnostic Boosting Oracles

In \(\{-1,1\}\) labels, the source guarantee is equivalent to

$$
\operatorname{corr}_{\mathcal D}(h,Y)
\ge
\sup_{c\in\mathcal C}\operatorname{corr}_{\mathcal D}(c,Y)-2\beta.
$$

Thus it is a da Cunha--Hogsgaard--Paudice / Ghai--Singh style agnostic weak learner with parameters \(\gamma_0=1\) and \(\epsilon_0=2\beta\). Since \(\beta<1/2\), it is nontrivial in the statistical sense \(\epsilon_0<\gamma_0\).

Primary-source check:

- Ben-David, Long, and Mansour define this additive weak agnostic learner and obtain a boosted error bound of the form \(\max\{c_1(\beta)\operatorname{err}(\mathcal F)^{c_2(\beta)},\varepsilon\}\), not \(\operatorname{OPT}+\varepsilon\). DOI: https://doi.org/10.1007/3-540-44581-1_33.
- Gavinsky's JMLR paper improves the black-box agnostic boosting guarantee to roughly \((1/(1/2-\beta))\operatorname{OPT}+\zeta\), and describes this as essentially optimal for that smooth boosting approach. This still is not \(\operatorname{OPT}+\varepsilon\). Source: https://www.jmlr.org/papers/v4/gavinsky03a.html.
- Revisiting Agnostic Boosting (arXiv:2503.09384) states a very general weak learner condition \( \operatorname{corr}(w)\ge \gamma\sup_{f\in F}\operatorname{corr}(f)-\epsilon_0 \). Its Theorem 1.3 says any nontrivial weak learner \(\gamma>\epsilon_0\) is statistically boostable, but the paper explicitly says the method is not computationally efficient. Source: https://arxiv.org/abs/2503.09384.
- Sample-Near-Optimal Agnostic Boosting with Improved Running Time (arXiv:2601.11265) gives a polynomial-in-sample-size algorithm when the other parameters are fixed. Its theorem invokes the weak learner \(O(n^{m_0+3})\) times, where \(m_0\) is the weak learner's sample parameter, and also depends on the dual VC dimension. Source: https://arxiv.org/abs/2601.11265.
- Ghai and Singh's ICML 2025 theorem is computationally efficient but its guarantee loses \(2\epsilon_0/\gamma\). For a fixed additive oracle with \(\gamma=1,\epsilon_0=2\beta\), that does not approach \(\operatorname{OPT}+\varepsilon\). Source: https://proceedings.mlr.press/v267/ghai25a.html.

This confirms the edge note's positive near miss: the fixed-additive source is statistically boostable by the newest oracle results, but the only currently checked computational theorem has exponent \(m_0\). In this atlas, \(m_0\) can be polynomial in the representation size, so \(n^{m_0}\) is not a polynomial-time PAC reduction.

### Positive Route Tried: Avoid Clean-Subset Enumeration

The 2026 algorithm succeeds by generating a large set of weak hypotheses, including hypotheses obtained from samples that are "clean" with respect to a near-optimal \(f^\star\). Since \(f^\star\) is unknown, the algorithm enumerates all \(m_0\)-subsets of the sample, hence \(n^{m_0}\) weak-learner calls.

A fully positive resolution would need a polynomial replacement for this enumeration. A plausible lemma would say:

> Given samples from \(\mathcal D\) and a proper fixed-additive weak agnostic learner \(W\), construct in time \(\operatorname{poly}(s,1/\varepsilon,\log(1/\delta))\) a polynomial list of proper hypotheses whose small improper votes contain a classifier of error \(\operatorname{OPT}_{\mathcal C}+\varepsilon\).

I do not see such a lemma from the current sources. Standard OCO / relabeling boosters need a weak oracle whose additive correlation slack is \(O(\varepsilon)\), while the atlas source supplies a fixed slack. The fixed-slack oracle can legally return uninformative decoys on booster-induced distributions where the best comparator correlation is below the fixed slack.

Concrete obstacle: the first useful call seems to require either finding a distribution under which a near-optimal comparator has almost perfect labels, or shrinking the weak slack. The first is what clean-subset enumeration does; the second is not supplied by the source.

### False Route Tried: Halfspaces

Halfspaces are the natural target-hard class. Tiegel proves, under worst-case lattice hardness, hardness of improper agnostic learning of halfspaces, including distribution-independent hardness and a standard-Gaussian distribution-specific lower bound. The PMLR abstract states that no efficient algorithm outputs any binary hypothesis with error better than \(1/2-\gamma\) even when the optimal halfspace error is as small as \(\delta\), with \(\gamma\) allowed smaller than inverse-polynomial and \(\delta=\exp(-\Omega(\log^{1-c} d))\). Source: https://proceedings.mlr.press/v195/tiegel23a.html.

This does not give a false witness for the present fixed-\(\beta\) source. If the source has fixed gap \(a=1/2-\beta>0\), then on Tiegel's hard low-\(\operatorname{OPT}\) distributions a weak agnostic source learner would have to output error below \(1/2-a/2\) for large enough dimension, contradicting Tiegel. So halfspaces fail the source as well as the target.

However, this branch exposes a schema fork. If the atlas source were interpreted as merely inverse-polynomial weak gap, halfspaces plus the local low-noise robustification argument would become a serious conditional false candidate: realizable proper learning plus constants can give an inverse-polynomial weak agnostic proper learner, while Tiegel rules out strong agnostic improper learning. That is not the interpretation used by the current edge note, but it is worth flagging for schema cleanup.

### False Route Tried: Parities / LPN

Affine parities under the uniform marginal are another natural candidate. Strong agnostic improper learning at constant classification noise would distinguish noisy parities, i.e. violate a decision-LPN-type assumption.

This separates only an inverse-polynomial-gap variant. A realizable parity learner can be robustified by clean-batch Gaussian elimination when the permitted weak gap is of order \(1/\operatorname{poly}(n)\). For the fixed-constant \(\beta\) source, the learner must handle \(\operatorname{OPT}<1/2-\beta\), including constant-noise parity instances. That is exactly the hard LPN regime, so parities are source-negative for the current edge.

Concrete obstacle: wrong parities have error exactly \(1/2\) under the uniform marginal. They are legal weak outputs only when \(\operatorname{OPT}\ge 1/2-\beta\). For a fixed source gap, low-noise parity with noise below \(1/2-\beta\) still requires finding a correlated parity.

### Other Separation Templates Considered

1. PRF classes: sample-efficient and cryptographically hard, but an efficient fixed-additive weak agnostic proper learner would already distinguish pseudorandom labels in low-\(\operatorname{OPT}\) regimes. Source side fails.

2. PCP / active-slice lookup classes: good for proper-vs-improper separations, but adding public handles or lookup relaxations that make weak agnostic learning easy also tends to give an improper learner enough information for the strong target.

3. Error-correcting code classes: the dream witness is a code with efficient constant-radius weak decoding under arbitrary weighted coordinate distributions, but hard near-half-distance agnostic decoding. I did not find an atlas-ready construction. Ordinary list decoding is usually for uniform Hamming noise, whereas the distribution-free source requires weighted/adversarial marginals. If handles are added to make weighted weak decoding easy, those handles often become enough for improper voting or validation.

4. Fixed-\(k\) DNF style classes: proper strong hardness is known, but the target here is improper. Existing weak proper algorithms and improper votes do not give a known strong improper hardness separation for this edge.

### Current Best Classification

Not resolved. I would keep the edge status as `open` under the fixed-additive atlas interpretation.

No atlas fields should be updated from this depth-1 attempt.

Promising next directions for deeper subagents:

1. **Polynomial clean-witness generation.** Try to replace the \(n^{m_0}\) enumeration in arXiv:2601.11265 with sample compression, hard-core set search, or stability arguments that use the fact \(W\) is an actual PAC learner rather than an arbitrary oracle.

2. **Weighted decoding separation.** Search coding-theoretic or cryptographic classes with efficient weak decoding below a fixed weighted noise radius for every marginal, but hard agnostic nearest-codeword approximation near radius \(1/2\). The source requirement is weighted distribution-free decoding, not just uniform Hamming decoding.

3. **Schema fork audit.** Decide whether `efficient-weak-agnostic-proper-pac` means fixed constant \(\beta<1/2\) or inverse-polynomial \(1/2-\gamma(s)\). If it means inverse-polynomial, revisit halfspaces/Tiegel and low-noise robustification as a possible conditional false resolution.

4. **Black-box barrier formalization.** Gavinsky and later papers suggest fixed-additive black-box boosting cannot reach \(\operatorname{OPT}+\varepsilon\). A deeper pass could try to turn that into an oracle separation, then check whether any representation-level diagonalization realizes the oracle as a concept class.

### Depth 1 Outcome

RESOLVED: no.

## Depth 2 Attempt: Polynomial Clean-Witness Generation

### Target Of This Attempt

I pursued the proposed positive route: replace the $n^{m_0}$ clean-subset enumeration in da Cunha--Hogsgaard--Paudice's fixed-slack agnostic boosting algorithm by a polynomial procedure using sample compression, hard-core set search, stability, or the extra fact that the weak oracle $W$ is an actual PAC learner.

I did not edit atlas files.

### Primary-Source Check

The bottleneck in [da Cunha et al. 2026](https://arxiv.org/abs/2601.11265) is very explicit. Their main theorem assumes a $(\gamma_0,\epsilon_0,\delta_0,m_0)$ agnostic weak learner and sets $\theta=(\gamma_0-\epsilon_0)/2$. The algorithm calls the weak learner on all ordered $m_0$-tuples from the first half of the sample, repeated enough times for confidence amplification. The proof counts
$$
R\cdot M\cdot (n/2)^{m_0}
$$
weak-learner calls, and the theorem states a total running time of the form
$$
\operatorname{Eval}_{\mathcal H}(1)\cdot
n^{O(m_0\min\{d^\ast,\ln n\}/\theta^2)}.
$$
Thus even when the weak gap is inverse-polynomial and $m_0=\operatorname{poly}(s)$, this is not a polynomial-time PAC reduction in the representation size.

The reason for the enumeration is not cosmetic. Their proof fixes a near-optimal $f^\star\in\mathcal F$ and lets $S_{f^\star}$ be the examples in the first half whose observed label equals $f^\star(x)$. On every distribution $D'$ supported on this clean set, $f^\star$ has correlation $1$, so the agnostic weak learner behaves as a realizable weak learner. But the booster cannot sample from $D'$ because it does not know $f^\star$ or which examples are clean. Enumerating every $m_0$-tuple from the sample guarantees that, for every AdaBoost reweighting of $S_{f^\star}$, at least one of the tried tuples is a tuple that could have been drawn from that clean distribution.

This matches the earlier [Revisiting Agnostic Boosting](https://arxiv.org/abs/2503.09384) framework: it runs the realizable learner on all relevant relabelings and is explicitly information-theoretic rather than computationally efficient. The 2026 paper improves the exhaustive relabeling idea to exhaustive clean $m_0$-tuple generation, but the exponent remains $m_0$.

The efficient potential-based route in [Ghai and Singh 2025](https://proceedings.mlr.press/v267/ghai25a.html) avoids this enumeration, but only under a different quantitative oracle. Their theorem gives a final correlation loss of order $2\epsilon_0/\gamma+\epsilon$ and their definition lets the weak learner's additive slack $\epsilon_0$ be chosen small by feeding more samples to the weak learner. The present atlas source gives only one fixed additive weak guarantee, equivalently $\epsilon_0=1-2\gamma(s)$ in the $\gamma_0=1$ normalization. That fixed slack is far too large for the Ghai--Singh proof to drive the final excess error to arbitrary $\epsilon$.

### Sample Compression Route

A tempting hope is that an actual PAC learner should have a small clean witness: maybe instead of trying every $m_0$-tuple, one could try only a compressed core and reconstruct the useful weak hypotheses.

The generic compression literature does not seem to give this. [Moran and Yehudayoff 2016](https://arxiv.org/abs/1503.06960) proves that every VC class has a sample compression scheme of size $2^{O(d)}$, and with dual VC dimension $d^\ast$ a scheme of size $O(dd^\ast\log(dd^\ast))$. This has two problems here.

First, the size bound is not representation-uniformly small. From the weak source one can at best infer finite sample control on realizable restrictions, hence some finite VC dimension bounded in terms of the weak learner's sample needs, but $2^{O(d)}$ or $O(dd^\ast\log(dd^\ast))$ can still be super-polynomial in the representation size. Enumerating $n^k$ compressed cores is only a polynomial-time replacement if $k=O(1)$ or at most logarithmic in the relevant input parameters, which is not implied by efficient weak agnostic PAC learning.

Second, compression assumes a clean labeled sample. Here the clean labels are exactly the hidden object. Even if a small compression set exists for the clean $f^\star$-labeled sample, the algorithm sees noisy labels and does not know which examples agree with $f^\star$. To use the compressor generically, it would still have to search over possible cores, labels, and side information, or run a reconstructor over many possible relabelings. That falls back toward the Hopkins-style all-relabelings framework.

There is also a black-box obstacle. The source says that $W$ is efficient and PAC-correct on i.i.d. samples from every distribution, but it does not say that the output of $W$ is stable, compressible, or determined by a small subtrace. A legal learner can use all $m_0$ input examples in its tie-breaking. It may output a useful hypothesis on clean realizable samples and a harmless decoy on mixed/noisy samples where that decoy is still within the fixed additive tolerance. The PAC guarantee rules out bad distributional performance, not brittle dependence on the whole input tuple.

### Random Hitting Route

Could one simply sample polynomially many $m_0$-tuples from the observed data and hope some are clean? Not in the worst case. If $\operatorname{OPT}=\eta$ is a fixed constant below the weak threshold and $m_0=\operatorname{poly}(s)$, then an observed $m_0$-tuple is fully clean with probability roughly $(1-\eta)^{m_0}=\exp(-\Omega(m_0))$. Polynomially many random tries do not hit such a tuple with high probability.

This is why the 2026 enumeration is over all $m_0$-tuples: it is a deterministic hitting device for an exponentially rare event under the noisy sample distribution.

### Hard-Core And Potential Search Route

Hard-core set search also seems blocked at the same quantitative point. Classical and modern agnostic boosters use reweighting or relabeling to search for regions where the current aggregate predictor still has exploitable correlation. This is effective when the weak oracle remains informative at the target scale, for example with a guarantee
$$
\operatorname{corr}(W)\ge \gamma\max_{h\in\mathcal H}\operatorname{corr}(h)-\epsilon_0
$$
where $\epsilon_0=O(\gamma\epsilon)$.

The present fixed-slack source does not supply that. On a booster-induced distribution where the best comparator correlation is below the fixed slack floor, $W$ may legally return a hypothesis with essentially no useful correlation. A hard-core search can find a hard region for the current vote, but it cannot certify that the labels in that region have been cleaned with respect to $f^\star$. Without that cleaning, the fixed-slack weak learner is allowed to be silent exactly in the middle-noise regimes where boosting still needs progress.

The Massart-noise boosting literature is suggestive but does not solve this agnostic edge. Recent Massart boosters keep weak-learner queries inside a noise regime where the weak guarantee remains valid by avoiding unsafe reweightings. In the fully agnostic setting here, there is no known way to identify the analogous safe distribution without knowing a near-optimal $f^\star$.

### Stability Route

If the source learner were known to be stable, or known to be a canonical ERM with a small, efficiently enumerable compression scheme, then one could imagine a polynomial list of likely weak outputs generated from noisy samples. But stability is an additional algorithmic property, not a consequence of the atlas source.

The "actual PAC learner" condition is therefore weaker than what the clean-witness lemma needs. It gives distributional correctness for samples drawn from a queried distribution. It does not provide an efficient inverse map from observed noisy samples to the hidden clean traces on which the learner would have behaved realizably.

### What Would Be Enough

A positive resolution would follow from one of the following strictly stronger hypotheses:

1. $m_0=O(1)$, or at most $O(\log \operatorname{poly}(s,1/\epsilon,1/\delta))$, so that the existing clean-tuple enumeration is already polynomial.

2. A tunable agnostic weak learner with additive slack $\epsilon_0=O(\gamma\epsilon)$. This is the regime of the efficient Ghai--Singh-style potential boosters, but it is a stronger node than the current fixed-slack source.

3. An efficiently computable compression or reconstruction scheme of logarithmic size for the particular source learner, together with an observable validation/orientation test that does not require knowing $f^\star$.

4. A new hard-core theorem that turns fixed additive weak agnostic learning into a tunable weak correlation oracle on the booster-induced relabeling distributions. I did not find such a theorem, and the known efficient boosters appear to assume this tunability rather than derive it.

### Current Obstacle As A Barrier

The clean-witness enumeration can be viewed as searching a hidden marked set of $m_0$-tuples. A black-box weak learner may be useful only on tuples whose labels are fully consistent with the unknown near-optimal $f^\star$, while returning legal decoys elsewhere. Validation can choose among hypotheses once they are generated, but it does not reveal the missing clean tuple. This gives a plausible black-box barrier to replacing $n^{m_0}$ by $\operatorname{poly}(n,m_0)$.

This is not yet an atlas-level separation. To mark the edge false, one would still need to realize the barrier by an explicit concept class with efficient fixed-additive weak agnostic proper learning and hard strong agnostic improper learning. I did not obtain that construction.

### Next Directions

1. **Formalize the black-box lower bound.** Model $W$ as an oracle whose useful outputs are hidden behind clean $m_0$-tuples and prove that any booster making $\operatorname{poly}(n,m_0)$ calls fails. Then investigate whether a concept class can realize the oracle behavior.

2. **Search for restricted positive theorems.** For classes with small dual VC dimension, canonical ERM, or known logarithmic compression schemes, check whether the 2026 enumeration can be reduced enough to become polynomial.

3. **Schema audit.** The local edge file phrases the weak gap as inverse-polynomial $\gamma(s)$, while depth 1 flagged fixed-constant wording elsewhere. The clean-witness obstruction applies to both, but the inverse-polynomial version also pays the $1/\theta^2$ exponent in the 2026 runtime.

4. **Hard-core theorem variant.** Look specifically for a theorem converting a fixed additive weak agnostic learner into a tunable distribution-specific weak oracle by adding random label smoothing, abstention, or calibration. Existing Ghai--Singh and Feldman/Kanade-style arguments do not appear to supply this conversion.

### Depth 2 Outcome

RESOLVED: no.

## Depth 3 Attempt: Restricted Positive Theorems

### Target Of This Attempt

I pursued the restricted-positive route suggested by Depth 2: look for additional structural hypotheses under which a fixed-additive proper weak agnostic learner can be boosted to a fully polynomial-time improper strong agnostic learner.

I did not edit atlas files. This note uses the fixed-slack interpretation from the source definition: the weak learner achieves

$$
\operatorname{err}(h)\le \operatorname{OPT}_{\mathcal C}+\beta
$$

for a fixed $\beta<1/2$. Equivalently, in the da Cunha--Hogsgaard--Paudice correlation notation, $\gamma_0=1$, $\epsilon_0=2\beta$, and $\theta=(\gamma_0-\epsilon_0)/2=(1-2\beta)/2$ is a positive constant. If the edge file's inverse-polynomial gap wording is taken as authoritative instead, then $\theta$ may be inverse-polynomial, and every runtime below that has an exponent depending on $1/\theta^2$ becomes non-polynomial unless an additional constant-gap assumption is added.

### Source Check

The current best general positive theorem remains [da Cunha--Hogsgaard--Paudice 2026](https://arxiv.org/abs/2601.11265): their algorithm is polynomial in the sample size when all weak-learning parameters are fixed, and the abstract explicitly phrases the result this way. Their proof improves the earlier [Revisiting Agnostic Boosting](https://arxiv.org/abs/2503.09384) information-theoretic algorithm, but the computational cost still comes from generating clean witnesses.

The efficient potential-based route of [Ghai and Singh 2025](https://proceedings.mlr.press/v267/ghai25a.html) is not enough for this fixed-slack node, because it is efficient in the regime where the weak oracle's additive correlation slack is tunable down to the target accuracy scale. The source node gives only one fixed additive slack.

On compression, [Moran and Yehudayoff](https://arxiv.org/abs/1503.06960) show that binary VC classes admit sample compression of size exponential in VC dimension. Later work still treats the linear-size sample-compression conjecture as an open conditional input in related reductions; see, for example, [Attias--Hanneke--Ramaswami 2025](https://arxiv.org/abs/2410.13012). I also noticed a very recent [Liu--Li 2026](https://arxiv.org/abs/2603.23561) arXiv claim about no-clash teaching/ordered compression for finite classes, but I did not rely on it: even a linear clean-compression theorem would not automatically give an efficient way to find the hidden clean witnesses inside an agnostic sample, and a compression size $k=\operatorname{VC}(\mathcal C_s)$ can still be $\operatorname{poly}(s)$.

### Conditional Positive Theorem

A fully polynomial positive result follows from the following clean-witness generator hypothesis.

**Hypothesis.** For every sample $S$ of size

$$
n=\operatorname{poly}(s,1/\varepsilon,\log(1/\delta)),
$$

there is an algorithm $G$ running in $\operatorname{poly}(n,s,1/\varepsilon,\log(1/\delta))$ time that outputs a polynomial-size list $L(S)\subseteq \mathcal C$ with this property: for every near-optimal comparator $f^\star\in\mathcal C$ and every clean reweighting over

$$
S_{f^\star}=\{(x_i,y_i)\in S:y_i=f^\star(x_i)\}
$$

that appears in the realizable booster/filtering analysis, $L(S)$ contains a proper hypothesis with the weak edge needed on that clean reweighting.

**Conclusion.** Under this hypothesis, the edge is true for the restricted class family. The proof is just the da Cunha--Hogsgaard--Paudice proof with the exhaustive list of all clean $m_0$-tuples replaced by $L(S)$. Once the list is polynomial, the margin filtering, validation, and final improper voting/aggregation steps are polynomial. Properness of the weak hypotheses is harmless because the final learner may output an improper vote.

This abstraction captures exactly what Depth 2 called the missing lemma. Every restricted positive theorem below is an attempt to instantiate $G$.

### Small Dual VC Dimension

Small dual VC dimension helps, but only together with a small weak-witness size. The 2026 running-time dependence has the form

$$
n^{O(m_0\min\{d^\ast,\log n\}/\theta^2)}
$$

up to polynomial factors, where $m_0$ is the weak learner's sample parameter and $d^\ast$ is the dual VC dimension of the base class. With fixed slack, $\theta$ is constant. Therefore the known theorem is fully polynomial if

$$
m_0\min\{d^\ast,\log n\}=O(1).
$$

In particular, constant $d^\ast$ and constant $m_0$ give a restricted positive theorem. Merely logarithmic or polynomial $d^\ast$ does not: even $m_0=O(1)$ and $d^\ast=\Theta(\log s)$ gives $n^{\Theta(\log s)}$, i.e. quasi-polynomial rather than polynomial. Constant $d^\ast$ alone also does not help if $m_0=\operatorname{poly}(s)$.

The source node does not imply this restriction. It gives a polynomial-time weak learner, hence some polynomial sample parameter, but it does not force $m_0=O(1)$ or $d^\ast=O(1)$. Standard VC duality only bounds $d^\ast$ exponentially in the primal VC dimension, and that bound is tight in general. So small dual dimension is a useful fixed-parameter positive case, not a consequence of efficient weak agnostic proper PAC learning.

### Logarithmic Sample Compression

A clean compression scheme can replace $m_0$ by a smaller witness size $k$, but the enumeration cost is still $n^k$ times the side-information search.

If $k=O(1)$ and the reconstruction map is efficient, then there is a clean restricted theorem: enumerate all $k$-subsamples and side strings, reconstruct all candidate proper hypotheses, and feed that polynomial list into the conditional theorem above.

If $k=O(\log n)$, plain deterministic enumeration is only quasi-polynomial:

$$
n^{O(\log n)}.
$$

This is better than $n^{\operatorname{poly}(s)}$, but it is not a fully polynomial PAC reduction. A logarithmic compression scheme would become enough only with an additional density or samplability promise: for every clean reweighting used by the booster, polynomially many random compressed cores and side strings hit a valid reconstruction with non-negligible probability. Ordinary sample compression gives existence of a small clean core, not many cores, and it assumes the learner is handed a realizable clean sample. It does not tell us how to find the right core inside the observed noisy sample.

The source node does not imply logarithmic compression in any representation-sensitive sense. Even generic binary compression bounds depend on VC dimension, and the source allows VC dimension and weak sample size to grow polynomially with the representation size. More importantly for this edge, realizable compression is a structural clean-sample property; the agnostic fixed-slack learner may still hide its useful behavior behind a unique or very sparse clean trace.

### Canonical ERM

Canonical ERM would help if it came with an efficient trace enumerator:

> Given the observed sample $S$, list in polynomial time every hypothesis that the canonical ERM could output on any clean subsample/relabeling induced by a near-optimal $f^\star\in\mathcal C$ and any booster reweighting.

With such a trace enumerator, we again get the polynomial clean-witness generator $G$ and therefore a restricted positive theorem.

Canonical ERM by itself does not appear to be enough. The unknown object is not just the ERM tie-breaking rule; it is the hidden clean labeling $f^\star|_S$. The number of possible labelings of $S$ induced by $\mathcal C$ is controlled by the primal VC dimension, not by the fact that the ERM is canonical. If that dimension is $\operatorname{poly}(s)$, enumerating all induced traces is $n^{\operatorname{poly}(s)}$. Also, the source node does not imply that ERM is computationally efficient. It only promises some proper weak agnostic learner, which may be algorithmically quite different from empirical risk minimization.

So the useful restricted theorem is "efficient canonical trace enumeration implies the edge," not "canonical ERM alone implies the edge."

### Stable Proper Weak Learners

Stability is the most promising conceptual route, but the needed stability is stronger than standard generalization stability.

A sufficient condition would be a corruption-stable weak learner: for every booster reweighting, running the learner on polynomially many noisy samples from the observed distribution produces, with non-negligible probability, a hypothesis whose performance is comparable to what the learner would have produced on the hidden clean distribution for $f^\star$. Then the generator $G$ can be implemented by direct calls to this stable learner rather than by enumerating hidden clean traces.

Ordinary uniform stability or replace-one stability does not seem to imply this. Those notions control the sensitivity of the output risk to small sample perturbations. In the agnostic boosting obstruction, a constant fraction of labels may be corrupt relative to $f^\star$, and the weak guarantee permits the learner to output a legal decoy whenever the queried noisy distribution has

$$
\operatorname{OPT}_{\mathcal C}\ge 1/2-\beta.
$$

Thus the stability needed here is closer to "the learner's useful clean behavior remains visible under constant noisy contamination" than to usual algorithmic stability.

The source node does not imply this stronger property. PAC correctness constrains the distributional error of the final output, but it says nothing about whether the algorithm is stable, canonical, compressive, or trace-enumerable.

### Obstruction

All of these restricted positives are ways to solve the same hidden-witness problem. The fixed-slack weak learner is useful on distributions where a comparator is visible below the threshold $1/2-\beta$. During strong agnostic boosting, the needed progress may occur on clean views of the sample that are not directly observable. The known fixed-slack theorem finds those views by exhaustive clean-witness enumeration. To make the edge fully polynomial, one must replace that enumeration by a polynomial generator.

Small dual VC dimension, logarithmic compression, canonical ERM, and stability can each help only when upgraded to such a generator:

1. constant $d^\ast$ plus constant $m_0$;
2. constant-size clean compression, or logarithmic compression with dense/samplable witnesses;
3. canonical ERM with polynomial trace enumeration;
4. corruption-stable weak learning that makes clean traces observable through noisy samples.

None of these properties is implied by the source node as currently written. They are extra structural assumptions on the class or on the chosen weak learner.

### Depth 3 Outcome

RESOLVED: no.

The edge remains open. This attempt produced a useful conditional theorem: polynomial clean-witness generation is sufficient, and several natural restrictions imply it only in strengthened forms. But the efficient weak agnostic proper source does not itself imply small dual VC dimension, logarithmic/dense compression, canonical ERM, or corruption-stable weak learning.

## Depth 4 Attempt: Does Proper Weak Output Help Boosting?

### Target Of This Attempt

I pursued the specific possibility that was left open by the previous attempts: maybe the fact that the weak learner's outputs are proper, i.e. always in $\mathcal C$, forces some compact witness set or menu of hypotheses that an improper booster can validate and combine.

The answer I found is negative at the level of current techniques. Properness is useful after candidate hypotheses have been generated, because a final improper learner can validate, weight, flip, and vote over proper base hypotheses. But I do not see a way for properness alone to generate the candidates polynomially. The hidden clean-witness obstruction remains.

I did not edit atlas files.

### Validation Over Proper Outputs

Validation solves a selection problem, not a generation problem. If a procedure has already produced a polynomial list

$$
L=\{h_1,\ldots,h_N\}\subseteq \mathcal C
$$

with $N=\operatorname{poly}(s,1/\varepsilon,\log(1/\delta))$, then a holdout sample can estimate each $h_i$'s error and the empirical risk of small votes over $L$. Since the target is improper, the final hypothesis may be any weighted vote or threshold of these proper hypotheses. In this sense properness is perfectly compatible with strong improper boosting.

The difficulty is that validation cannot find a missing hypothesis. In the fixed-slack agnostic setting, the weak learner may be informative only on distributions or subsamples where a near-optimal comparator $f^\star$ is effectively clean. On the observed noisy distribution, or on booster-induced distributions whose best comparator correlation is below the fixed slack floor, the weak learner may legally output a proper decoy. A holdout set can reject a bad decoy after it appears, but it gives no way to discover the hidden clean $m_0$-tuple on which the learner would have output a useful proper hypothesis.

Trying to validate over "all proper hypotheses" would amount to solving an agnostic optimization problem over $\mathcal C$, which is at least as strong as the target problem. The source learner is only a fixed-additive weak learner. It is not an oracle for empirical risk minimization, nor an oracle whose additive slack can be tuned down to $O(\varepsilon)$.

Thus the useful conditional statement remains:

> Proper weak outputs plus a polynomially constructible menu imply efficient improper strong agnostic learning.

But properness by itself does not produce the menu.

### Dual VC Dimension

The most plausible structural benefit of properness is that every weak hypothesis lies in the same class $\mathcal C$, so maybe the dual VC dimension of $\mathcal C$ bounds the number of relevant output patterns.

This is already essentially the parameter used by the current fixed-slack agnostic boosting theorem. The running-time dependence in [da Cunha--Hogsgaard--Paudice 2026](https://arxiv.org/abs/2601.11265) has an exponent involving

$$
m_0 \min\{d^\ast,\log n\}/\theta^2,
$$

where $m_0$ is the weak learner's sample parameter, $d^\ast$ is the dual VC dimension, and $\theta$ is the nontriviality gap. Properness lets us take the relevant base class to be $\mathcal C$, but the source node does not imply that $d^\ast$ is constant or even logarithmically useful.

At most, the source's sample complexity can force a finite primal VC dimension for each representation size, because even weak realizable learning at error below $1/2$ has VC-type lower bounds. But that dimension may still be $\operatorname{poly}(s)$, and the dual VC dimension can be exponentially larger in the primal dimension in general. The theorem protects itself with $\min\{d^\ast,\log n\}$, but then the exponent can still contain $m_0\log n$. If $m_0=\operatorname{poly}(s)$, this is not a polynomial-time PAC reduction.

One could instead look at the **range** of a particular learner $W$, rather than all of $\mathcal C$. That also does not follow from properness. A deterministic proper learner can tie-break using all coordinates of its $m_0$ training examples and have a very large range of possible proper outputs, while still satisfying the same distributional weak guarantee. The PAC guarantee constrains the risk of the output under the queried distribution, not the combinatorial complexity of the learner's range over all possible clean traces.

So small dual VC dimension gives another restricted positive theorem only when it is an extra assumption, for example constant $d^\ast$ together with constant $m_0$. Properness alone does not imply it.

### Sample Compression

Properness also suggests a compression hope: if the useful weak hypotheses are in $\mathcal C$, perhaps each has a short clean witness that can be enumerated.

There are two separate barriers.

First, known general compression theorems are not small enough for this computational edge. [Moran and Yehudayoff 2016](https://arxiv.org/abs/1503.06960) show that VC classes have sample compression schemes of size exponential in VC dimension. Even if one had a linear-size compression scheme, the VC dimension allowed by the source may be $\operatorname{poly}(s)$, and enumerating $n^{\operatorname{poly}(s)}$ compressed cores is still not polynomial time.

Second, compression is a clean-sample statement. The fixed-slack agnostic booster needs hypotheses that would have been produced on examples clean with respect to an unknown near-optimal comparator $f^\star$. The observed sample contains corrupted labels, and the algorithm does not know which examples agree with $f^\star$. A proper reconstruction map would output a concept in $\mathcal C$ once given the right clean core, but it does not identify the right core. Without a density or samplability property for valid cores, compression just changes the exhaustive search from $m_0$-tuples to $k$-cores.

The weak learner itself gives only a trivial algorithm-dependent witness: its input sample, plus its random seed if randomized. That witness has size $m_0$ and is exactly the object whose exhaustive enumeration caused the earlier bottleneck. Properness of the output does not shorten this witness.

### A Proper-Decoy Barrier

The black-box obstruction can be made proper. Imagine an oracle weak learner whose useful outputs are proper concepts indexed by hidden clean $m_0$-traces, and whose fallback answers are also proper concepts, for example neutral or otherwise validation-bad decoys that remain within the fixed additive tolerance on the noisy query distributions.

A booster making only polynomially many calls can validate every returned proper concept, but if it never queries a clean trace it never sees the useful proper concepts. The fact that all answers are in $\mathcal C$ does not expose the hidden index. This is not an atlas-level separation, because it still has to be realized by an explicit represented concept class satisfying the source guarantee, but it shows why a proof that uses only properness is unlikely to replace clean-witness enumeration.

This also explains why closure tricks do not settle the edge. The final improper learner may take majorities, thresholds, signs, or calibrated votes over proper hypotheses. Those operations are powerful once the right base hypotheses are present. They do not force the weak learner to reveal the right base hypotheses under fixed slack.

### What Would Be Enough

The depth-3 clean-witness generator can be refined to a range-sensitive version:

> For every observed sample $S$, construct in polynomial time a polynomial-size set $L(S)\subseteq\mathcal C$ such that, for every near-optimal $f^\star$ and every clean distribution used in the fixed-slack boosting analysis, $L(S)$ contains a proper hypothesis that has the weak edge on that clean distribution.

Properness is part of this statement, but it is not the engine. The engine would have to be one of the following additional properties:

1. constant $m_0$ and constant dual VC dimension;
2. constant-size clean compression, or larger compression with dense/samplable valid cores;
3. a canonical learner with polynomially enumerable output traces on $S$;
4. a stability or corruption-robustness property saying that useful clean outputs appear with non-negligible probability when $W$ is run on observable noisy samples;
5. a tunable weak learner whose additive slack can be made $O(\varepsilon)$, so the efficient potential-based boosters apply directly.

None of these follows from the statement "the weak output is proper."

### Depth 4 Outcome

RESOLVED: no.

I did not find a positive implication from proper weak outputs to a compact menu for improper boosting. Properness helps only after a polynomial candidate list exists. Validation over proper outputs, dual VC bounds, and sample compression all remain blocked unless strengthened by extra assumptions that are not part of `efficient-weak-agnostic-proper-pac`.

## Depth 5 Attempt: Proper Source Reduces To Improper Core

RESOLVED: yes for the focused reduction question. This does not resolve the original atlas edge, because the improper weak-to-strong agnostic boosting edge remains open.

### Focus

The question in this attempt is narrower than the whole edge:

> Is `efficient-weak-agnostic-proper-pac -> efficient-agnostic-improper-pac` genuinely no harder, as a positive implication, than the known open edge `efficient-weak-agnostic-improper-pac -> efficient-agnostic-improper-pac`?

The answer is yes. The proper source is a syntactic strengthening of the improper source with the same benchmark $\operatorname{OPT}_{\mathcal C}$ and the same fixed additive slack.

### Formal Node-Level Reduction

Let $\mathcal C$ be a represented binary class. Suppose $\mathcal C$ satisfies `efficient-weak-agnostic-proper-pac`. Then there is an efficient learner $A$ and a fixed $\beta<1/2$ such that, for every distribution $\mathcal D$ over $\mathcal X\times\{0,1\}$, with high probability $A$ outputs $h\in\mathcal C$ satisfying

$$
\operatorname{err}_{\mathcal D}(h)
\le
\inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta.
$$

But the improper weak agnostic node asks for exactly the same error guarantee while allowing the output hypothesis to be any efficiently evaluable binary hypothesis, possibly outside $\mathcal C$. Since every $h\in\mathcal C$ is also an allowed improper output, the same learner $A$ witnesses `efficient-weak-agnostic-improper-pac` with unchanged sample complexity, runtime, confidence handling, and weak slack.

Thus the implication

$$
\texttt{efficient-weak-agnostic-proper-pac}
\Longrightarrow
\texttt{efficient-weak-agnostic-improper-pac}
$$

is immediate.

Now assume the known open improper-core boosting implication is true:

$$
\texttt{efficient-weak-agnostic-improper-pac}
\Longrightarrow
\texttt{efficient-agnostic-improper-pac}.
$$

By transitivity, every class satisfying the proper weak source satisfies the strong improper target. Therefore:

$$
(\texttt{proper weak} \Rightarrow \texttt{improper weak})
\quad+\quad
(\texttt{improper weak} \Rightarrow \texttt{strong improper})
\quad\Longrightarrow\quad
(\texttt{proper weak} \Rightarrow \texttt{strong improper}).
$$

This is a complete reduction at the atlas implication level.

### Black-Box Booster Form

The same reduction works in oracle form. Suppose `Boost` is any fully polynomial fixed-slack agnostic booster that is correct for every valid improper weak agnostic learner $W$ for $\mathcal C$. Given a proper weak learner $A$, define $W=A$ and pass it to `Boost`. Every oracle answer returned by $A$ is in $\mathcal C$, hence is also a legal improper answer. Since `Boost` must be correct for all legal improper weak learners, it must be correct for this special proper one.

There is no extra compatibility condition unless the booster requires a representation that can be evaluated efficiently. The proper source already supplies an efficient learner whose output hypotheses are usable PAC hypotheses; if this were not true, the source node itself would not be an efficient learning notion in the usual computational sense.

### What This Does And Does Not Prove

This removes one possible worry from the earlier attempts: properness of the weak source cannot make the positive direction harder than the improper-core open edge. Any proof of the improper-core edge automatically proves this edge.

The reduction is one-way. A counterexample to the improper-core edge need not transfer to the proper-source edge. Such a counterexample might have an efficient weak agnostic improper learner only because it outputs hypotheses outside $\mathcal C$, while no efficient proper weak learner exists. To refute the proper-source edge, one would still need a class that has the stronger proper weak source and lacks strong improper agnostic learning.

So the clean classification after this attempt is:

1. For proving the edge true, it is enough to resolve the improper weak-to-strong agnostic boosting edge.
2. For proving the edge false, the proper-source edge may require a strictly more specialized witness than a false witness for the improper-core edge.
3. The depth-2 through depth-4 obstructions about clean witnesses, fixed slack, and hidden comparator information are exactly the same positive-direction obstruction as in the improper-core edge; they are not caused by properness.

### Depth 5 Outcome

RESOLVED: yes, for the focused reduction question.

The edge `efficient-weak-agnostic-proper-pac -> efficient-agnostic-improper-pac` is no harder on the positive side than `efficient-weak-agnostic-improper-pac -> efficient-agnostic-improper-pac`: the proper source first implies the improper weak source for free, then the known open improper boosting edge would finish the target. The original atlas edge remains open only because that improper-core boosting edge is open.

## Depth 6 Attempt: OCO Over Proper Outputs

RESOLVED: no.

### Focus

This attempt tries to break the current conclusion from a different angle. Suppose the proper weak learner's output class $\mathcal C$ has enough structure that an improper learner is allowed to output a vote, average, threshold, or calibrated randomized mixture of concepts from $\mathcal C$. Can we run online convex optimization directly over the convex hull of proper outputs, avoiding the clean-trace enumeration that appears in the fixed-slack boosting arguments?

The short answer is that this gives a clean restricted positive route, but not a generic one. OCO over votes does not need an explicit enumeration of all clean traces, but it needs a linear optimization or separation oracle over $\mathcal C$ at the precision of the final accuracy parameter. The fixed-additive weak agnostic learner is not such an oracle.

### OCO Formulation

Work on an empirical sample $S=\{(x_i,y_i)\}_{i=1}^n$ with labels in $\{\pm 1\}$. Each proper hypothesis $h\in\mathcal C$ gives a vector

$$
v_h=(h(x_1),\ldots,h(x_n))\in\{\pm1\}^n.
$$

An improper vote is a point $F$ in $\operatorname{conv}\{v_h:h\in\mathcal C\}$, followed by a sign, randomized prediction, or calibrated threshold. A natural convex relaxation is to minimize

$$
L(F)=\frac1n\sum_{i=1}^n \phi(y_iF_i)
$$

for a convex margin loss $\phi$. Projected OCO, mirror descent, Frank-Wolfe, or follow-the-regularized-leader can all be phrased in terms of repeatedly asking for a proper hypothesis that is well aligned with the current negative gradient.

For decreasing margin losses, the gradient has the form

$$
\nabla_i L(F)=-w_i y_i
$$

with $w_i\ge 0$ depending on the current margin. Thus the required oracle call is:

$$
\text{given weights }w_i\ge0,\quad
\text{find }h\in\mathcal C\text{ nearly maximizing }\sum_i w_i y_i h(x_i).
$$

Equivalently, it is weighted agnostic empirical risk minimization over $\mathcal C$ on the current reweighted sample. If one uses losses whose gradients can change sign, the oracle becomes the slightly more general cost-sensitive linear oracle

$$
\text{given arbitrary costs }a_i,\quad
\text{find }h\in\mathcal C\text{ nearly maximizing }\sum_i a_i h(x_i).
$$

Either way, the primitive is not just "proper outputs can be voted." It is optimization over proper outputs.

### What The Weak Learner Supplies

Calling the fixed-slack weak agnostic learner on the reweighted labeled sample gives, in correlation form,

$$
\mathbb E_w[yh(x)]
\ge
\max_{c\in\mathcal C}\mathbb E_w[yc(x)]-2\beta
$$

for some fixed $\beta<1/2$. This is an additive-constant approximate linear optimization oracle over $\mathcal C$ under normalized nonnegative weights.

That is enough to make progress only while the best available direction beats the current vote by a constant margin. It is not enough for an $\varepsilon$-accurate OCO guarantee. In the late phase of any strong agnostic learner, the useful improving directions have advantage on the order of $\varepsilon$, because the current vote is already close to the best convex or thresholded combination one can certify from the sample. At that point an oracle with additive error $2\beta$ may legally return a proper decoy even when a small but crucial improving direction exists.

This is the same obstruction as before in a different coordinate system. Clean-trace enumeration is one way to manufacture the small-advantage directions from hidden low-noise views. OCO avoids writing down those views, but then it needs an oracle that can find the corresponding small-advantage direction directly.

### The Exact Missing Oracle

The missing primitive is an accuracy-tunable weighted linear optimization oracle over $\mathcal C$.

One sufficient version is:

> **Weighted Correlation Oracle.** Given any finite weighted labeled sample $(x_i,y_i,w_i)$ and tolerance $\eta>0$, run in time $\operatorname{poly}(s,n,1/\eta)$ and output $h\in\mathcal C$ such that
> $$
> \sum_i w_i y_i h(x_i)
> \ge
> \max_{c\in\mathcal C}\sum_i w_i y_i c(x_i)-\eta\sum_i w_i.
> $$

For OCO methods that need certification rather than approximate optimization, the equivalent form is:

> **Residual Separation Oracle.** Given a residual vector $r\in[-1,1]^n$ and tolerance $\eta>0$, either output $h\in\mathcal C$ with
> $$
> \langle r,v_h\rangle\ge \eta n,
> $$
> or certify that $\max_{c\in\mathcal C}\langle r,v_c\rangle<2\eta n$.

The first form is weighted agnostic ERM to additive tolerance $\eta$; the second form is the separation oracle for the convex hull of proper output vectors. With either oracle, standard OCO/Frank-Wolfe machinery gives a polynomial-time improper vote for the empirical problem, and uniform convergence or validation can lift it to the PAC target in the usual way.

But this oracle is much stronger than the source node. Setting $\eta=O(\varepsilon)$ is essentially a strong agnostic optimization primitive over $\mathcal C$ on arbitrary reweightings. If it were available generically, the target would be nearly immediate; if it is not available, OCO has no way to distinguish "no useful direction remains" from "the fixed-slack weak learner hid a useful small direction behind an allowed decoy."

### Why Properness Does Not Fill The Gap

Properness ensures that every base vector $v_h$ comes from $\mathcal C$, so the final predictor can be represented as an improper vote over legal proper hypotheses. It does not give the separation oracle.

The online learner can maintain coefficients, compute gradients, and validate candidate votes without enumerating $\mathcal C$. The one nontrivial step is always the same: from the current gradient or residual, find a proper hypothesis with nearly best correlation. A fixed-additive weak learner gives only constant-precision access to that step. Rescaling the gradients does not help, because the weak guarantee is for normalized classification error/correlation; the additive loss in normalized correlation remains constant. Randomized restarts also do not help unless they make the hidden useful direction appear with non-negligible probability, which is exactly a stability or dense-clean-witness assumption not present in the source node.

Thus the OCO route gives the following conditional theorem:

> If `efficient-weak-agnostic-proper-pac` is strengthened by a polynomial-time $O(\varepsilon)$ weighted correlation/separation oracle over $\mathcal C$, then the class has efficient agnostic improper PAC learning via OCO over votes of proper hypotheses.

This is a genuine restricted positive result, but the strengthening is doing the work. It is not implied by efficient fixed-additive weak agnostic proper learning.

### Depth 6 Outcome

OCO over proper outputs does not break the current conclusion. It replaces clean-trace enumeration with a sharper missing oracle: an accuracy-tunable weighted correlation, cost-sensitive ERM, or residual-separation oracle over $\mathcal C$. The fixed-slack proper weak learner is only a constant-additive version of that oracle, and constant-additive linear optimization is insufficient for an $\varepsilon$-accurate improper agnostic learner.

## Depth 7 Attempt: Atlas-Ready Proper-To-Improper Boosting Reduction

RESOLVED: no.

The original edge

`efficient-weak-agnostic-proper-pac -> efficient-agnostic-improper-pac`

should remain `open`. The theorem-check pass does, however, support adding an explicit reduction note to the atlas text: this proper-source edge is conditionally implied by the improper-core open edge

`efficient-weak-agnostic-improper-pac -> efficient-agnostic-improper-pac`.

The reduction is immediate and sound. First use the monotone-relaxation edge

`efficient-weak-agnostic-proper-pac -> efficient-weak-agnostic-improper-pac`,

which is already marked `true`: a proper weak agnostic learner is also an improper weak agnostic learner, since the improper model allows outputs from $\mathcal C$. Then compose with any future positive resolution of the improper-core edge. Therefore a proof that fixed-additive weak agnostic improper learning boosts to efficient agnostic improper learning would automatically prove the proper-source edge.

This is only a one-way positive reduction. A false witness for the improper-core edge would not automatically refute the proper-source edge, because the witness might satisfy weak agnostic improper learning only through hypotheses outside $\mathcal C$ while failing the stronger proper weak source. Conversely, the proper-source edge might be easier than the improper-core edge for special structural reasons. Thus the reduction justifies a cross-reference and a sharper explanation of the obstruction, but not a status change.

### Atlas-Ready Summary Wording

Possible replacement for the frontmatter `summary`:

> Open. The edge is no harder on the positive side than the improper-core boosting edge, since efficient weak agnostic proper learning trivially implies efficient weak agnostic improper learning. Thus any fully polynomial fixed-slack booster for `efficient-weak-agnostic-improper-pac -> efficient-agnostic-improper-pac` would prove this edge, but the improper-core edge is itself open; false witnesses do not transfer back without preserving the stronger proper weak source.

### Atlas-Ready Body Wording

Possible paragraph to add near the start of `## Proof Status`, after the goal paragraph:

> **Reduction to the improper-core edge.** This edge is conditionally implied by the open improper-core boosting edge
> `efficient-weak-agnostic-improper-pac -> efficient-agnostic-improper-pac`.
> Indeed, the source node already implies `efficient-weak-agnostic-improper-pac` by monotone relaxation: a proper weak agnostic learner outputs hypotheses in $\mathcal C$, and these are allowed outputs in the improper weak model with the same sample and time bounds. Therefore any fully polynomial fixed-slack agnostic booster for the improper weak source would compose with this relaxation and yield the target learner here.
>
> The converse does not follow. A separation for the improper-core edge may rely on a class whose weak learner is only improper, and such a class need not satisfy the stronger proper weak source used here. So this reduction identifies the main positive-direction obstruction but does not settle the current edge.

Possible short sentence for the conclusion:

> Equivalently, the current edge can be viewed as a proper-source specialization of the unresolved improper weak-to-strong agnostic boosting problem; resolving the improper-core edge positively would resolve this edge positively, while a negative resolution would require an additional proper-source-preserving witness.

### Depth 7 Outcome

The atlas verdict should stay `open`. The useful update is explanatory: mention the monotone reduction through `efficient-weak-agnostic-improper-pac`, and make clear that the remaining open issue is the same positive-direction fixed-slack boosting obstruction as in the improper-core edge.

## Depth 8 Final Incorporation Recommendation

RESOLVED: no.

The edge

`efficient-weak-agnostic-proper-pac -> efficient-agnostic-improper-pac`

should remain `open`. The final incorporation pass should not claim a theorem or a separation. It should make the open status sharper: this edge is a proper-source specialization of the unresolved fixed-slack weak-to-strong agnostic boosting problem.

### Exact Suggested Frontmatter Updates

Recommended future atlas frontmatter for `atlas/implications/efficient-weak-agnostic-proper-pac--implies--efficient-agnostic-improper-pac.md`:

```yaml
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
  - feldman2010distributionspecific
refs:
  - "[Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)"
  - "[Kalai et al. 2008](https://doi.org/10.1145/1374376.1374466)"
  - "[Gavinsky 2003](https://www.jmlr.org/papers/v4/gavinsky03a.html)"
  - "[Ghai and Singh 2025](https://proceedings.mlr.press/v267/ghai25a.html)"
  - "[da Cunha et al. 2026](https://arxiv.org/abs/2601.11265)"
  - "[Tiegel 2023](https://proceedings.mlr.press/v195/tiegel23a.html)"
  - "[Feldman 2010](https://arxiv.org/abs/0909.2927)"
summary: "Open. Efficient weak agnostic proper learning immediately relaxes to efficient weak agnostic improper learning, so any positive resolution of the improper weak-to-strong agnostic boosting edge would prove this edge. Current boosting/OCO routes require an accuracy-tunable weighted correlation, cost-sensitive ERM, or residual-separation oracle; properness alone gives legal base hypotheses for voting but not that oracle."
```

If the atlas maintainers want to keep the bibliography minimal, `feldman2010distributionspecific` can be omitted. It is useful for the distribution-specific/cost-sensitive boosting context, but the indispensable references are `bendavid2001`, `kalai2008agnosticboosting`, `gavinsky2003`, `ghai2025agnosticboosting`, and `dacunha2026agnosticboosting`. `tiegel2023` should be kept if the body continues to discuss the failed halfspace separation route.

### Exact Suggested Body Updates

Add this paragraph near the beginning of `## Proof Status`, after the goal paragraph:

```markdown
**Reduction to the improper weak-agnostic core.** This edge is conditionally implied by the open improper-core edge
`efficient-weak-agnostic-improper-pac -> efficient-agnostic-improper-pac`.
Indeed, the source node already implies `efficient-weak-agnostic-improper-pac` by monotone relaxation: a proper weak agnostic learner outputs hypotheses in $\mathcal C$, and those hypotheses are also allowed outputs in the improper weak model with the same sample and time bounds. Therefore any fully polynomial fixed-slack agnostic booster for the improper weak source would compose with this relaxation and yield the target learner here.

The converse does not follow. A negative resolution of the improper-core edge may use a class whose weak learner is only improper, and such a class need not satisfy the stronger proper weak source used here. Thus this reduction identifies the main positive-direction obstruction but does not settle the current edge.
```

Replace or supplement the existing "What properness contributes" discussion with:

```markdown
**Properness is not enough.** Properness gives a clean representation for each base hypothesis used by an eventual improper vote, but it does not give the optimization primitive needed by known efficient boosters. The nontrivial step in OCO, Frank-Wolfe, or residual-fitting views of agnostic boosting is: given a weighted labeled sample or residual vector, find a proper hypothesis whose correlation is nearly optimal at tolerance $O(\varepsilon)$. The source learner supplies only fixed-additive weak agnostic optimization, i.e. constant-precision access to this linear objective. Rescaling weights, validating votes, or combining proper hypotheses improperly does not turn a constant-additive oracle into an $O(\varepsilon)$ cost-sensitive oracle.
```

Add this paragraph after the current discussion of da Cunha et al. and Ghai-Singh:

```markdown
**OCO/cost-sensitive oracle obstruction.** In the convex-vote formulation, each $h\in\mathcal C$ gives a vector $(h(x_1),\ldots,h(x_n))$, and an improper learner searches over votes in their convex hull. Standard online convex optimization or Frank-Wolfe methods would be efficient if they could call a weighted correlation oracle: given weights $w_i$ and labels $y_i$, output $h\in\mathcal C$ with correlation within $\eta=O(\varepsilon)$ of $\max_{c\in\mathcal C}\sum_i w_i y_i c(x_i)$. Equivalently, one needs a cost-sensitive ERM or residual-separation oracle over $\mathcal C$ at accuracy $O(\varepsilon)$. The fixed-slack weak learner gives only constant-additive correlation, which may legally miss the small residual directions needed in the late boosting phase.
```

Replace the conclusion with:

```markdown
**Conclusion.** The edge remains open. A positive solution would follow from either a fully polynomial fixed-slack booster for the improper weak-agnostic core edge, or from an additional lemma showing that proper fixed-slack weak agnostic learning yields the missing $O(\varepsilon)$ weighted correlation/cost-sensitive oracle. Current results give statistical or fixed-parameter boosting, but their known running times still depend exponentially or with representation-dependent exponents on weak-learner parameters such as clean-witness size or dual VC dimension. A negative solution would require a class with efficient fixed-additive weak agnostic proper learning but hard strong agnostic improper learning; the standard halfspace, parity/LPN, PRF, code, and PCP templates checked so far miss one side of this requirement.
```

### References To Keep Or Add

Keep:

- `bendavid2001`: original fixed-additive agnostic weak learning/boosting formulation and residual-loss obstruction.
- `kalai2008agnosticboosting`: agnostic boosting and parity-learning context.
- `gavinsky2003`: smooth boosting route and its weaker-than-`OPT + epsilon` guarantee for this fixed-slack setting.
- `ghai2025agnosticboosting`: efficient modern booster, but requiring a quantitatively stronger/tunable oracle than this source supplies.
- `dacunha2026agnosticboosting`: closest modern fixed-slack positive theorem; still fixed-parameter rather than representation-uniform polynomial for this atlas edge.
- `tiegel2023`: keep only as a documented failed separation route via halfspaces.

Add if the atlas text includes the OCO/distribution-specific oracle discussion:

- `feldman2010distributionspecific`: useful background for distribution-specific agnostic boosting and oracle-style formulations. This key already exists in `references.bib`.

### Final Status

After depth 8, the atlas edge should still be marked `open`, with no assumptions and no witnesses. The scratchpad evidence supports a better explanatory note, not a resolution.

## Depth 9 Attempt: Final Proper-Source Boosting Search

RESOLVED: no.

### Scope And Final Literature Check

I made one last pass specifically for a theorem that would use the **proper** weak source, not merely the improper weak source, to get a representation-uniform polynomial-time agnostic improper learner.

The up-to-date boosting picture still supports the depth-8 recommendation. [Revisiting Agnostic Boosting](https://arxiv.org/abs/2503.09384) gives very strong sample-complexity evidence for agnostic weak-to-strong boosting under broad oracle conditions, but its own abstract frames the contribution as statistical/sample complexity rather than a fully polynomial representation-uniform reduction. [da Cunha--Moller Hogsgaard--Paudice 2026](https://arxiv.org/abs/2601.11265), last revised February 3, 2026 and accepted at ALT 2026, is still the closest fixed-slack source: its abstract explicitly says the algorithm is polynomial in sample size when the other parameters are fixed. This is exactly the atlas obstruction, because the weak learner's sample parameter and the relevant capacity parameters may grow with representation size. [Ghai--Singh 2025](https://proceedings.mlr.press/v267/ghai25a.html) remains the closest fully computational efficient booster, but it works in a stronger oracle regime; its theorem does not turn one non-tunable Ben-David additive slack into arbitrary final excess error.

I did not find a later primary-source theorem removing this quantitative gap, nor a source claiming that proper weak outputs alone provide the missing oracle.

### Properness-Specific Positive Search

The strongest positive statement remains the monotone reduction:

$$
\text{efficient weak agnostic proper PAC}
\Rightarrow
\text{efficient weak agnostic improper PAC}.
$$

Thus any future fully polynomial solution of

$$
\text{efficient weak agnostic improper PAC}
\Rightarrow
\text{efficient agnostic improper PAC}
$$

would immediately settle this edge positively. That reduction is complete and should stay in the atlas body.

I tried to find an extra advantage from properness itself. The natural hope is that, since every weak hypothesis lies in $\mathcal C$, the final improper learner can search over votes of legal base hypotheses and validate them. This still leaves the same missing primitive: generate a polynomial menu of useful proper hypotheses. Properness says a useful hypothesis, once generated, is a legal base vector for a vote. It does not identify the hidden clean trace, relabeling, or residual distribution on which the fixed-slack learner is forced to return that hypothesis.

In OCO or Frank-Wolfe language, each $h\in\mathcal C$ gives a vector $(h(x_1),\ldots,h(x_n))$, and an improper vote lives in the convex hull of these vectors. Efficient optimization over this hull needs an $O(\varepsilon)$ weighted correlation or residual-separation oracle over $\mathcal C$:

$$
\sum_i w_i y_i h(x_i)
\ge
\max_{c\in\mathcal C}\sum_i w_i y_i c(x_i)-O(\varepsilon)\sum_i w_i .
$$

The source learner gives only fixed-additive optimization:

$$
\operatorname{corr}(h,Y)
\ge
\max_{c\in\mathcal C}\operatorname{corr}(c,Y)-2\beta .
$$

That is a constant-precision oracle, not a final-accuracy oracle. There is no generic normalization theorem in the checked sources that converts the former into the latter by using only that outputs are proper.

### Proper-Source Separation Search

I also rechecked the plausible false witnesses, asking whether they satisfy the **proper** fixed-additive source while failing the improper target.

The parity/LPN route is the most important schema fork. If the edge's theorem statement is read literally as allowing only an inverse-polynomial weak gap

$$
\operatorname{err}(h)\le \operatorname{OPT}_{\mathcal C}+1/2-\gamma(s),
\qquad
\gamma(s)\ge 1/\operatorname{poly}(s),
$$

then affine parities give a conditional false witness under standard decision-LPN hardness. The source learner is proper: use Gaussian elimination as the realizable parity learner, run it on many small batches, include the two constant affine parities, and validate. If $\operatorname{OPT}\ge\gamma(s)$, a constant classifier has error at most $1/2\le \operatorname{OPT}+1/2-\gamma(s)$. If $\operatorname{OPT}<\gamma(s)$ and $\gamma(s)$ is chosen below the inverse of the clean sample size, a fresh batch is clean with constant probability; Gaussian elimination returns an affine parity with weak advantage after validation. Strong agnostic improper learning of affine parities under the uniform marginal and constant classification noise would distinguish LPN samples from random labels by holdout validation. This is the depth-1 parity argument from the neighboring improper-source scratchpad, and properness does not weaken it because the weak outputs are affine parities.

However, the current edge file and definition note have been interpreted throughout this scratchpad as the fixed-constant Ben-David source: one additive tolerance $\beta<1/2$ with a representation-independent gap $1/2-\beta=\Omega(1)$. Under that interpretation, parity/LPN is **not** a witness. A fixed-gap weak learner for low constant-noise parity instances would already output a constant-correlation predictor and would itself break LPN.

The other standard candidates still miss an atlas requirement:

- Halfspaces fail the weak source under Tiegel's improper agnostic hardness; they cannot witness a class with efficient proper weak agnostic learning.
- Fixed-$k$-term DNF separates weak proper from strong proper learning, but the target here is improper. The known atlas witness only proves a proper-output obstruction.
- PCP active-slice and public-lookup constructions tend to make improper agnostic learning easy by one-slice lookup or validation, so they point in the wrong direction for this edge.
- PRF, public-handle, and coding templates either fail the distribution-free low-noise proper weak source or expose enough public structure for an improper vote or lookup learner to plausibly achieve the target.

### Atlas-Suitable Final Obstacles

The clean final positive obstacle is:

> **Proper clean-witness generator.** Given samples from an agnostic distribution and a fixed-additive proper weak agnostic learner, generate in time $\operatorname{poly}(s,1/\varepsilon,\log(1/\delta))$ a polynomial-size list $L\subseteq\mathcal C$ such that votes over $L$ contain a classifier with error at most $\operatorname{OPT}_{\mathcal C}+\varepsilon$.

Equivalently, generate a polynomial menu of weak-learner calls containing one low-noise/clean residual exposure for a near-optimal comparator. This would replace the fixed-parameter clean-slice enumeration in the da Cunha et al. route. Properness belongs in the output type of this lemma, but the missing work is the polynomial generation.

The clean final negative obstacle is:

> **Proper threshold-decodable pseudorandom code.** Construct a represented class with a public distribution-free proper weak decoder below one fixed noise radius for every marginal and corruption pattern, but with one fixed marginal and a larger constant noise rate where even improper prediction to $\operatorname{OPT}+\varepsilon$ is computationally hard.

No standard halfspace, parity/LPN, code, PCP, or PRF construction checked so far satisfies both halves. The source is very demanding because it must handle every marginal; the target is very permissive because it allows arbitrary improper hypotheses.

### Proposed Atlas Treatment

For the current fixed-constant interpretation, keep:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
```

The current summary is already close. I would add one schema caveat to the body or theorem statement:

```markdown
If the weak node is instead interpreted as a nonconstant inverse-polynomial gap
$1/2-\gamma(s)$, affine parities under decision-LPN give a conditional false
witness, and the weak learner in that witness is proper. Under the fixed-constant
Ben-David tolerance used here, that parity witness fails the source, so the edge
remains open.
```

If the atlas later decides that `efficient-weak-agnostic-proper-pac` really means inverse-polynomial weak gap rather than fixed constant gap, then the proposed status for this edge should be reconsidered as:

```yaml
status: "false"
evidence: conditional-counterexample
assumptions:
  - "decision-LPN hardness for affine parities with constant classification noise"
witnesses:
  - "affine parities"
ref_keys:
  - kalai2008agnosticboosting
```

with a new `blum2003` or equivalent LPN reference added to `references.bib`. Under the current edge interpretation, though, I do not recommend that update.

### Depth 9 Outcome

The final verdict is still `open`. Properness does not currently supply the missing polynomial clean-witness/cost-sensitive oracle, and no proper-source-preserving separation is known for the fixed-constant weak agnostic node. The most useful atlas improvement is to keep the edge open while explicitly recording the schema fork: inverse-polynomial weak gap would be conditionally false via affine parities/LPN; fixed-constant weak gap remains unresolved.
