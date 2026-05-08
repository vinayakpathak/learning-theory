# Edge: efficient-marginal-nonuniform-agnostic-improper-pac -> efficient-marginal-nonuniform-weak-agnostic-proper-pac

- depth: 1
- edge_file: atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md
- verdict: unresolved
- confidence: medium

## Context

The source is strong agnostic marginal-nonuniform improper learning: for each fixed instance marginal $P$, one uniform learner may have a $P$-dependent polynomial bound and may output hypotheses outside $\mathcal C$, with error at most $\operatorname{OPT}_{\mathcal C}+\varepsilon$.

The target is weak agnostic marginal-nonuniform proper learning: for each $P$, the learner must output $h\in\mathcal C$ with
$$
\operatorname{err}_{\mathcal D}(h)\le \operatorname{OPT}_{\mathcal C}+\beta_P(s),
$$
where $\beta_P(s)<1/2$ and the gap $\alpha_P(s)=1/2-\beta_P(s)$ is only promised to be inverse-polynomial, with the polynomial allowed to depend on $P$.

The current edge note marks the implication open under the [[properization-open|Properization Open]] family. The neighboring weak-improper-to-weak-proper marginal edge is also open and records the same core obstruction: generic finite-sample existence of a good proper hypothesis does not give an efficient proper ERM/projection, while known separations lose the weak gap after the marginal is fixed.

## Attempted Resolution

I first checked the obvious positive route. A strong improper agnostic learner gives a predictor $g$ whose error is close to the best concept in $\mathcal C$, but it gives no evident way to find a concept in $\mathcal C$. Uniform convergence says a good proper hypothesis exists on large samples, yet efficient proper ERM over $\mathcal C$ is exactly the missing computational step. Boosting also does not properize: agnostic boosting constructions typically output votes or weighted aggregates, and the source is already strong.

I then checked the known false-edge witnesses.

1. The clause-satisfaction lookup class gives fixed-marginal hardness for strong proper agnostic learning. Under the uniform clause marginal, formula clauses are labeled $1$ and non-formula clauses get fair noise, so satisfiable and unsatisfiable formulas differ in optimum proper error by at least $1/|X_n|$. This resolves strong-accuracy proper targets, because one can run the learner to accuracy $O(1/|X_n|)$. It does not resolve the present weak target: a weak learner may have additive tolerance $\beta_P(s)$ close to $1/2$, far larger than the inverse-polynomial optimum gap.

2. The PCP active-slice witness gives distribution-free weak proper hardness. The reduction puts all mass on the active slice for the input instance $\varphi$, so a satisfiable instance forces the returned proof to accept on more than half of the verifier random strings. For a marginal-nonuniform target this does not directly work, because the hard active slice is part of the marginal. Packing all input slices into one fixed marginal gives exponentially small mass to individual formulas, which is below the hidden weak advantage scale.

3. The one-way image-coordinate witness gives fixed-marginal strong proper hardness. It fails for weak proper learning because the length-$n$ block has mass $\mu_n\ll 1$, so a hypothesis that ignores that block can still have total error below $1/2-\alpha_P(s)$ for large $n$.

The most promising new separation attempt was a shared-coordinate code construction. Let a seed $u$ define a proper concept by a codeword $E(f(u))$, where $f$ is a length-preserving one-way function. If the marginal is uniform over code coordinates and the labels are $E(y)$ for $y=f(u)$, then a weak proper learner would have to output a seed $t$ whose codeword correlates with $E(y)$ by at least $\alpha_P(s)$.

This has the right shape:

- If $E$ is a Hadamard/parity code, then any wrong image codeword is exactly distance $1/2$ from $E(y)$, so any error below $1/2$ recovers a preimage. But the coordinate domain has size $2^n$, and agnostically competing with the best image parity is not known to have an efficient improper learner. For one-way permutations it is at least as hard-looking as agnostic parity learning.
- If $E$ is a polynomial-length small-bias or error-correcting code, then the coordinate domain is polynomial and an improper lookup-table learner can agnostically learn over the code-coordinate domain. However, with $2^n$ messages and polynomial length, the best uniform pairwise distance is only $1/2-\eta(n)$ for some inverse polynomial depending on the chosen length. The weak target's advantage $\alpha_P(s)$ is hidden and may be a smaller inverse polynomial than $\eta(n)$. Then a wrong codeword at distance $1/2-\eta(n)$ may still satisfy the weak guarantee.
- Adding many amplification levels might beat any eventual inverse-polynomial weak gap, but then either the coordinate domain becomes superpolynomial for the lookup-table source, or the construction needs the hard marginal/block to vary with the unknown weak-gap polynomial. I did not find a clean way to keep one fixed efficient class and one fixed marginal while covering all possible weak-gap exponents.

So the code idea explains the obstruction more sharply but does not close the edge.

## Proposed Atlas Update

No resolved update proposed.

If the atlas note is revised, I would keep:

- `status: "open"`
- `evidence: unknown`
- `assumptions: []`
- `witnesses: []`
- `family: properization-open`

A possible summary refinement would be:

> Open: strong improper agnostic learning gives no known efficient proper projection, while fixed-marginal weak proper hardness needs either polynomial-mass active slices or shared-coordinate codes whose separation scale beats the unknown marginal-dependent weak gap.

I would not change the edge status without either a generic efficient properization theorem or a fixed-marginal weak proper separation whose improper source remains strongly agnostically learnable.

## Obstacles

The main positive obstacle is computational, not statistical. For fixed $P$, sample complexity can certify that a proper near-optimum exists, but the source learner may output an arbitrary improper predictor and supplies no efficient search procedure over $\mathcal C$.

The main negative obstacle is the weak-gap quantifier. A false witness must force a proper output using only an error threshold of the form $1/2-\alpha_P(s)$, where $\alpha_P$ may be an arbitrarily small inverse polynomial depending on the fixed marginal. Active-slice reductions lose because hard slices have too little mass; polynomial-length code reductions lose because their nontrivial distance/correlation margin may be larger than the learner's hidden advantage scale.

There is also a source-side tension. Dense codewords give the right weak geometry for proper hardness, but then strong agnostic improper learning becomes a nontrivial agnostic decoding/correlation problem. Sparse or polynomial lookup domains keep improper learning easy, but do not obviously force a weak proper learner to recover the hard proper representation.

## Next Directions

1. Try to formalize an adaptive-amplification code witness with a fixed concept class whose coordinate domain remains polynomial in the relevant representation size. The target is a family of explicit small-bias sets or concatenated codes that beats every possible marginal-dependent inverse-polynomial weak gap without sacrificing the lookup-table improper learner.

2. Look for a fixed-marginal PCP/CSP encoding where the input instance is carried by labels, not by the marginal, and where unsatisfiability creates a constant gap for every unrelated proper hypothesis. The clause-satisfaction construction only gives a $1/|X_n|$ optimum gap; the active-slice PCP construction gives a constant gap but currently puts the input slice in the marginal.

3. Investigate whether the definition of marginal-nonuniform weak learning in Hanneke-Moran-Thiessen-style models gives any effective access to, or normalization of, the weak advantage polynomial. If the weak gap can be requested or amplified under the fixed marginal, the polynomial-length code obstruction might disappear.

4. Search for representation-specific properization theorems under fixed marginals, perhaps using finite support, effective separability, or distribution-specific compression. Such a theorem would need to convert the improper predictor into an actual member of $\mathcal C$ in marginal-dependent polynomial time.

## References Checked

- [[efficient-marginal-nonuniform-agnostic-improper-pac|Efficient Marginal-Nonuniform Agnostic Improper PAC Learning]]
- [[efficient-marginal-nonuniform-weak-agnostic-proper-pac|Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning]]
- [[properization-open|Properization Open]]
- [[clause-satisfaction-proper-hardness|Clause-Satisfaction Proper Hardness]]
- [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]
- [[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]]
- [[clause-satisfaction-lookup-class|Clause-Satisfaction Lookup Class]]
- [[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]]
- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
- [Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)
- [Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)
- [Kearns and Valiant 1994](https://doi.org/10.1145/174644.174647)
- [Hastad et al. 1999](https://doi.org/10.1137/S0097539793244708)

## Depth 2 Follow-Up: Shared-Code Separation Route

- depth: 2
- verdict: unresolved
- confidence: medium-high

## Context

The depth-1 note identified the right false-witness target: keep one fixed marginal and encode the hard instance in the conditional labels, so that marginal-nonuniformity cannot hide a different polynomial for each input instance. I pushed on the proposed shared-coordinate code route:

1. A polynomial-size coordinate domain should let the source learner be an improper lookup-table or finite-domain ERM.
2. Proper concepts should be representations of hard certificates, such as one-way preimages or PCP proofs.
3. For a challenge label vector $Y_z$ under one fixed marginal, every proper concept not certifying $z$ should fail to get even inverse-polynomial weak advantage.

The third item is much stronger than ordinary error correction. The target learner's gap $\alpha_P(s)=1/2-\beta_P(s)$ is hidden and may be $s^{-k}$ for an arbitrarily large constant $k$ depending on the fixed marginal and the alleged learner. Thus a direct black-box lower bound cannot tolerate a bad proper concept at distance $1/2-\eta(s)$ for any fixed inverse-polynomial $\eta$ unless the reduction has an additional way to turn that weakly correlated output into the desired certificate.

## Attempted Resolution

### Polynomial-Size Shared Codes

Suppose formulas, images, or PCP instances $z$ are mapped to binary label vectors $Y_z\in\{0,1\}^N$, where $N=\operatorname{poly}(s)$ so that an improper learner can agnostically learn by lookup/ERM over the coordinate domain. If the reduction labels examples by $Y_z$, then every satisfiable or invertible challenge needs some proper concept $c_z$ close to $Y_z$. For a no-instance or a one-way challenge, any unrelated proper concept $c_{z'}$ with

$$
\operatorname{err}(c_{z'},Y_z) < 1/2
$$

is already a possible weak proper output for some inverse-polynomial target gap. Unless that output can itself be converted into the right certificate for $z$, the clean separation wants pairwise distance at least $N/2$ between all relevant yes/certificate codewords.

That requirement is essentially Plotkin/Hadamard territory. The binary Plotkin bound says that codes with minimum distance above $N/2$ have only $O(N)$ codewords, and the exact $N/2$ Hadamard regime also supports only $O(N)$ mutually orthogonal binary codewords. Therefore a polynomial-length binary code cannot give exponentially many hard instances pairwise nonpositive correlation. To encode exponentially many formulas or one-way images with this exact weak-safe geometry, the coordinate domain becomes exponential, which destroys the simple lookup-ERM source.

Small-bias and ordinary error-correcting codes improve the depth-1 attempt but not enough. They can make wrong codewords have correlation at most $\eta(s)$ with $N=\operatorname{poly}(s,1/\eta)$, yet the target's hidden weak gap may be smaller than $\eta(s)$. Padding the representation with a larger polynomial-size code does not fix this uniformly: if the coordinate length is counted in the representation size $S$, the promised weak gap may shrink like $S^{-k}$ while the best achievable correlation scale shrinks only according to the chosen construction. If the coordinate length is made exponential but represented succinctly, lookup ERM is no longer polynomial in $S$.

### Hadamard and List-Decodable Codes

Hadamard encoding of a one-way image has the ideal proper-hardness geometry. If $E(y)(r)=\langle y,r\rangle$ under the uniform coordinate marginal, then every wrong image is exactly distance $1/2$ from $E(y)$; any proper weak output with error below $1/2$ gives a seed $t$ with $f(t)=y$.

The source side is the blocker. Strong agnostic improper learning against the image-Hadamard class would require, under the uniform marginal over $r$, competing with the best parity-like codeword from random labeled examples. Outputting the image $y$ rather than a seed would be an allowed improper hypothesis, but finding the best noisy parity/image codeword is the agnostic parity/LPN-shaped task that the sparse lookup witnesses avoid. Goldreich-Levin-style list decoding uses oracle/query access in its natural form; random PAC examples under an arbitrary agnostic labeling do not give the needed adaptive access.

List-decodable polynomial-size codes give a more nuanced possible escape. If every ball of radius $1/2-\alpha$ contained a short list, a weak proper learner's output might identify a small list containing the true image or formula. But for the present edge this does not by itself invert or decide anything:

- The learner returns one proper representation, and it may be a wrong list element whose image is merely close to $Y_z$.
- In a SAT/PCP reduction, a satisfiable unrelated formula in the list is a false weak handle unless formula identity is also protected.
- Binary list-decoding near radius $1/2-\alpha$ has rate on the order of $\alpha^2$ in the usual capacity heuristic. With $\alpha=S^{-k}$ hidden and $k$ unbounded, no fixed polynomial-length code simultaneously covers all possible weak gaps while keeping exponentially many messages and lookup-style improper ERM.

So list decoding suggests a depth-3 refinement only if the reduction can repeatedly eliminate wrong list elements without changing the marginal or making $\operatorname{OPT}$ so large that the agnostic weak guarantee becomes vacuous.

### PCP-Code Hybrids

The most plausible PCP hybrid would replace the active slice $(\varphi,r)$ by a shared coordinate $j$ and use a formula-identity code together with PCP acceptance:

$$
c_{\psi,\pi}(j)
\approx
\text{CodeID}(\psi)_j \oplus \text{PCPAccept}(\psi,\pi,j).
$$

For input $\varphi$, the labels would be a corresponding target vector $Y_\varphi$. If $\varphi$ is satisfiable, some proof concept should agree with $Y_\varphi$; if $\varphi$ is unsatisfiable, no proper concept should have error below $1/2$.

The unrelated-formula problem remains fatal. A satisfiable $\psi\ne\varphi$ with a perfect proof becomes a weak handle unless the formula-ID component alone makes $c_{\psi,\pi}$ distance at least $1/2$ from $Y_\varphi$. Giving the ID component only mass $\lambda<1$ is not enough, because then wrong satisfiable formulas can have error around $\lambda/2$, well below the weak threshold. Giving the ID component enough mass brings back the same Plotkin/Hadamard obstruction for exponentially many formulas at one representation size.

This also explains why the clause-satisfaction fixed-marginal witness stops at strong agnostic proper hardness. It uses the conditional labels to identify the input formula over a polynomial clause universe, but the non-formula region must be neutralized with fair noise. That raises $\operatorname{OPT}$ close to $1/2$, and the weak agnostic guarantee $\operatorname{OPT}+1/2-\alpha$ no longer forces a meaningful assignment.

## Proposed Atlas Update

No resolved atlas update. I would keep the edge:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
```

Suggested summary refinement:

> Open: shared-code fixed-marginal separations run into a Plotkin/list-decoding tradeoff. Polynomial coordinate domains preserve improper lookup ERM but cannot make exponentially many proper certificates all pairwise weak-safe; Hadamard-like domains give the right weak geometry but make the improper agnostic source parity-like rather than lookup-easy.

Suggested body paragraph to add if the atlas note is refreshed:

> A depth-2 shared-code check suggests a coding bottleneck. To make a fixed-marginal weak lower bound, every wrong proper certificate must be at distance at least $1/2$ from the challenge labels, or else it may satisfy the target's hidden inverse-polynomial weak gap. Binary polynomial-length codes cannot give this nonpositive-correlation geometry for exponentially many hard instances by the Plotkin/Hadamard bound. Relaxing to small-bias or list-decodable codes leaves wrong codewords with inverse-polynomial correlation, while Hadamard encodings move the source-side learner into agnostic parity/list-decoding territory rather than polynomial lookup ERM.

## Obstacles

1. **Exact weak-safe separation is too expensive.** Direct fixed-marginal weak hardness wants bad proper concepts at error at least $1/2$, not merely $1/2-\eta(s)$, because $\eta(s)$ may exceed the learner's hidden weak advantage.

2. **Polynomial lookup domains cannot host enough orthogonal labels.** A polynomial-size binary domain can support only polynomially many pairwise distance-$1/2$ challenge codewords. Exponentially many formulas/images require either nonzero correlations or an exponential coordinate domain.

3. **Hadamard-style repairs lose the source.** Exact orthogonality makes proper weak learning invertive, but agnostic improper learning becomes best-parity decoding from random examples. That is not the lookup-table ERM used by the clause, PCP-slice, and sparse image-coordinate witnesses.

4. **PCP identity protection reduces to the same code problem.** Once the active formula slice is removed from the marginal, unrelated satisfiable formulas become proper weak handles unless formula identity is encoded with near-Hadamard separation.

5. **Agnostic weak additivity punishes fair-noise neutralization.** Clause-style labels can hide non-input regions with fair noise, but then $\operatorname{OPT}$ rises and the additive weak guarantee becomes too permissive.

## Next Directions

1. **Adaptive list-elimination under one marginal.** Try to design a reduction that tolerates a polynomial list of weakly close wrong codewords and, using only changes to the conditional label distribution under the same fixed marginal, eliminates returned wrong preimages one by one while keeping the true certificate's $\operatorname{OPT}$ low.

2. **Random-example agnostic decodable exact codes.** Search for a binary code family with Hadamard-like distance among exponentially many messages and a random-example agnostic decoder that outputs the message but not its one-way preimage. If such a code existed, it would separate the source and target cleanly; the danger is that it would amount to efficient agnostic parity/noisy-codeword decoding.

3. **Gap-preserving formula compression.** Look for PCP or hardness-of-approximation machinery that maps exponentially many formulas of size $n$ into only $\operatorname{poly}(n)$ shared label patterns while preserving yes/no distance from all proper proof concepts. This would evade the pairwise-code-counting obstruction, but it would need to avoid collisions between yes and no instances.

4. **Formal impossibility lemma for this route.** Prove a conditional "shared-code template cannot work" statement: any fixed-marginal lookup-ERM witness whose weak lower bound is certified solely by pairwise Hamming separation of challenge labels either has only polynomially many hard challenges per size or has a bad proper weak handle.

## References Checked

- Depth-1 references above.
- [[efficient-agnostic-improper-pac|Efficient Agnostic Improper PAC Learning]]
- [[efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac|Efficient Agnostic Improper PAC Learning -> Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning]]
- [[efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac|Efficient Marginal-Nonuniform Agnostic Improper PAC Learning -> Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]]
- [[efficient-agnostic-improper-pac--implies--efficient-marginal-nonuniform-realizable-proper-pac|Efficient Agnostic Improper PAC Learning -> Efficient Marginal-Nonuniform Realizable Proper PAC Learning]]
- [[one-way-image-coordinate-weak-handle-hardness|One-Way Image Coordinate Weak-Handle Hardness]]
- Plotkin, "Binary codes with specified minimum distance," IRE Transactions on Information Theory 6(4):445--450, 1960, DOI [10.1109/TIT.1960.1057584](https://doi.org/10.1109/TIT.1960.1057584).
- Guruswami and Vadhan, "A Lower Bound on List Size for List Decoding," IEEE Transactions on Information Theory 56(11):5681--5688, 2010, DOI [10.1109/TIT.2010.2070170](https://doi.org/10.1109/TIT.2010.2070170).

## Depth 3 Follow-Up: Plotkin/List-Decoding Bottleneck

- depth: 3
- verdict: unresolved, but the direct shared-code/PCP route looks blocked
- confidence: medium-high

## Focus Question

Can one build a fixed-marginal separation using a polynomial-size coordinate domain, exponentially many proper certificates, enough pairwise distance for weak safety, and a polynomial-time improper agnostic ERM? Or do coding bounds rule out that template?

The depth-3 answer is: I do not see such a construction, and standard coding bounds give a principled reason to doubt this route. They do not prove the atlas edge true, but they do appear to rule out any separation whose only safety mechanism is Hamming separation among exponentially many shared-coordinate certificate vectors.

## Template Under Test

Fix a size parameter $s$ and a shared coordinate set $Q_s$ of size $N=\operatorname{poly}(s)$. The marginal is uniform, or at least efficiently samplable with comparable weights, on $Q_s$. A hard challenge $z$ determines labels $Y_z\in\{0,1\}^{Q_s}$, and every proper certificate $a$ gives a vector $C_a\in\{0,1\}^{Q_s}$.

The source side is easy if the improper learner may output arbitrary lookup tables on $Q_s$: empirical majority by coordinate gives polynomial-time agnostic ERM with sample complexity polynomial in $N$, hence polynomial in $s$.

The target-side lower bound wants the following weak-safety property. For each challenge $z$, any proper certificate that does not reveal the desired witness for $z$ should have

$$
\operatorname{err}(C_a,Y_z)\ge 1/2-\alpha(s)
$$

at a scale that beats the target learner's hidden marginal-dependent weak advantage. Since the target may have $\alpha_P(s)=s^{-k}$ for an unknown and arbitrarily large constant $k$, a black-box reduction cannot safely tolerate an unrelated certificate with positive correlation $s^{-K}$ for any fixed $K$. Either that output must itself be convertible into the desired witness, or the construction needs essentially nonpositive correlation, or at least super-polynomially small positive correlation, for all wrong certificates.

## Exact Safety Is Plotkin-Bound Impossible

If the yes-label vector $Y_z$ is itself, or is close to, a proper certificate vector, then choosing one realizing certificate for each of exponentially many challenges yields an exponentially large binary code of length $N$. Exact weak safety requires every wrong realizing certificate to be at distance at least $N/2$ from the target labels, up to the small realization slack.

This is exactly the Plotkin/Hadamard regime. Binary codes of length $N$ and minimum distance at least $N/2$ have only $O(N)$ codewords in the standard Plotkin-bound form; for distance strictly above $N/2$ the bound is even smaller, and at the Hadamard boundary one still gets only linear-in-$N$ many mutually orthogonal binary codewords. Thus a polynomial coordinate domain cannot host exponentially many challenges with exact pairwise weak safety.

This rules out the cleanest code idea:

1. encode each formula, image, or proof certificate as a shared-coordinate binary vector;
2. use lookup-table ERM as the improper source learner;
3. force any weak proper output to identify the correct certificate solely because all wrong certificates are at distance at least $1/2$.

The only known way to get the exact geometry for exponentially many messages is Hadamard/parity-like encoding, whose coordinate domain has size exponential in the message length. Once the domain is represented succinctly instead of explicitly, the source-side learner is no longer lookup ERM; it becomes a noisy-parity or agnostic codeword-decoding problem.

## Approximate Safety Runs Into Rate-Versus-Radius Bounds

Relaxing exact safety to distance $1/2-\eta$ does not seem enough for this edge. Suppose there are $M=2^{\Omega(s)}$ possible challenges or certificates and $N=s^c$ shared coordinates. The code rate is

$$
R=\frac{\log_2 M}{N}=\Omega(s^{1-c}).
$$

For binary codes at relative distance $1/2-\eta$, the usual rate bounds and random-code heuristics put the feasible scale at roughly $R\lesssim \Theta(\eta^2)$, up to logarithmic factors depending on the bound used. Equivalently, with rate $R=s^{1-c}$, some positive-correlation scale $\eta\gtrsim s^{(1-c)/2}$ is unavoidable up to logs. This is still inverse-polynomial in $s$ for every fixed polynomial coordinate length.

That is fatal for the hidden-gap weak target. If a wrong certificate has error $1/2-\eta(s)$ for a fixed inverse-polynomial $\eta$, an alleged marginal-nonuniform weak learner whose promised advantage is smaller than $\eta$ could legally return that wrong certificate. The reduction would then fail unless the wrong certificate can also be decoded into the hard witness.

Taking $c$ very large merely pushes the correlation to a smaller fixed inverse polynomial. It does not cover all possible marginal-dependent weak gaps. To make $\eta$ super-polynomially small while keeping $M=2^{\Omega(s)}$, the coordinate length must become super-polynomial in $s$, and then the lookup-table improper ERM is no longer polynomial time/sample in the representation size.

## List Decoding Does Not Repair the Template

List decoding is the natural relaxation: allow several certificates inside a ball of radius $1/2-\alpha$, then hope to postprocess the learner's output. But the list-decoding lens reinforces the same bottleneck.

For binary codes near radius $1/2-\alpha$, the capacity scale is again rate on the order of $\alpha^2$. Guruswami-Vadhan-style lower bounds show that near this radius, small-list guarantees require paying polynomially in $1/\alpha$ and cannot magically support high rate at arbitrarily tiny $\alpha$. Therefore a fixed polynomial-length code with exponentially many messages can only promise useful list control down to some fixed inverse-polynomial radius scale.

Even if such a list is polynomial, the learner returns one proper hypothesis, not the whole list. A wrong but close list element is harmless only if it can be converted into the same witness as the target challenge. In one-way-function witnesses, a wrong close image does not invert the challenge image. In PCP/SAT witnesses, a satisfiable unrelated formula or proof is a false weak handle unless formula identity has already been protected by the same near-Hadamard separation that Plotkin blocks.

So list decoding suggests a possible non-black-box direction, not a ready construction: the reduction would need an interactive or adaptive elimination procedure under the same fixed marginal, where each wrong weak output gives useful information and can be ruled out without raising $\operatorname{OPT}$ toward $1/2$.

## PCP Hybrids Reduce To Identity Coding

I also do not see a PCP construction that evades the coding bottleneck while keeping the coordinate domain polynomial. A shared-coordinate PCP hybrid has to remove the active formula slice from the marginal. Once that happens, the verifier randomness coordinate no longer identifies the input formula.

For a target formula $\varphi$, labels might combine a formula-identity code and PCP acceptance bits. But if there is a satisfiable $\psi\ne\varphi$, then a proper proof for $\psi$ becomes a weakly good output unless the identity component alone forces $\psi$ far from $\varphi$ at the hidden weak-gap scale. With exponentially many formulas of size $s$ and only polynomially many shared coordinates, that identity layer is just the same code problem again.

Parallel repetition or stronger PCP soundness improves the acceptance gap on an active slice, but it does not solve unrelated-formula identity over one fixed shared marginal. The active-slice witness works precisely because the marginal names $\varphi$; the marginal-nonuniform setting prevents using a different active-slice marginal for each input when trying to refute the fixed-marginal target.

## Depth-3 Verdict

No atlas status change yet. The edge should remain:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
```

But the shared-code lower-bound route can be recorded as locally blocked:

> A fixed-marginal lookup-ERM separation cannot rely only on shared-coordinate Hamming separation among exponentially many certificates. Exact weak safety is ruled out by the Plotkin/Hadamard bound, and approximate or list-decodable safety leaves an inverse-polynomial positive-correlation scale whenever the coordinate domain is polynomial. That scale may exceed the hidden marginal-dependent weak advantage.

This does not rule out all separations. It rules out the most direct "polynomial domain + exponentially many certificates + pairwise distance safety + lookup ERM" template.

## Next Depth-4 Directions

1. **Formalize the template impossibility lemma.** State a lemma for any construction with $M=2^{\Omega(s)}$ challenge labels, coordinate length $N=\operatorname{poly}(s)$, and safety certified only by pairwise Hamming distances. Prove that either $M=O(N)$ under exact distance-$1/2$ safety, or some wrong certificate has inverse-polynomial positive correlation under approximate safety.

2. **Check whether wrong close certificates can be useful rather than fatal.** The only escape from the coding bound is to make every weakly close certificate decode to the desired witness. For one-way images this seems unlikely; for PCPs it would require a self-correcting or agreement theorem saying that any proof/formula with weak shared-coordinate correlation identifies the target formula.

3. **Search for agreement-theorem PCPs, not ordinary PCPs.** Ordinary PCP soundness controls proofs for one fixed formula. The needed object is closer to direct-product/low-degree agreement testing across formulas: any object weakly correlated with the target transcript must reveal the target instance or witness.

4. **Separate source ERM from coordinate size.** Investigate whether there is a succinct, exponentially long, Hadamard-like code with a polynomial-time improper agnostic learner for the induced concept class that is not just agnostic parity/LPN in disguise. A positive result here would revive the Hadamard route; a hardness result would strengthen the obstruction.

5. **Audit definitions for weak-gap normalization.** If the weak marginal-nonuniform definition ever gives the reduction access to the advantage polynomial, then a fixed inverse-polynomial small-bias code could be tuned to beat it. Under the current atlas reading, the reduction does not know or control that polynomial, so fixed polynomial-length approximate codes are insufficient.

## Additional References Checked

- Plotkin, "Binary codes with specified minimum distance," IRE Transactions on Information Theory 6(4):445--450, 1960, DOI [10.1109/TIT.1960.1057584](https://doi.org/10.1109/TIT.1960.1057584).
- Quistorff, "Some Remarks on the Plotkin Bound," Electronic Journal of Combinatorics 10(1), 2003, DOI [10.37236/1746](https://doi.org/10.37236/1746).
- MacWilliams and Sloane, "Bounds on the size of a code," in The Theory of Error-Correcting Codes, 1977, DOI [10.1016/S0924-6509(08)70542-7](https://doi.org/10.1016/S0924-6509(08)70542-7).
- Guruswami and Vadhan, "A Lower Bound on List Size for List Decoding," IEEE Transactions on Information Theory 56(11):5681--5688, 2010, DOI [10.1109/TIT.2010.2070170](https://doi.org/10.1109/TIT.2010.2070170).

## Depth 4 Follow-Up: Approximate/List-Decodable Route

- depth: 4
- verdict: unresolved for the atlas edge; the approximate/list-decodable route looks blockable as a template, but not yet as a theorem about all possible separations
- confidence: medium-high

## Focus Question

Can one choose a concrete inverse-polynomial correlation gap, use approximate or list-decodable codes to keep the shared coordinate set polynomial, and thereby get a fixed-marginal separation? Or can the hidden marginal-dependent weak advantage be turned into a clean proof that this route cannot separate?

The depth-4 answer is: a chosen inverse-polynomial gap can plausibly separate a stronger fixed-gap weak target, but it does not separate the current atlas node. For the current node, the weak advantage $\alpha_P(s)=1/2-\beta_P(s)$ is existential and may be $s^{-k}$ for an arbitrarily large constant $k$ depending on the fixed marginal and on the alleged learner. Any construction that leaves wrong proper certificates with correlation $s^{-K}$ for a fixed $K$ cannot force the learner to output a useful certificate.

## Correlation Translation

Use $\{\pm1\}$ notation. For a challenge label vector $Y_z$ and a proper certificate vector $C_a$ under the fixed marginal,

$$
\operatorname{err}(C_a,Y_z)=\frac{1-\langle C_a,Y_z\rangle_P}{2}.
$$

In the realizable or nearly realizable case, a weak proper guarantee with advantage $\alpha_P(s)$ only rules out a wrong certificate if

$$
\langle C_a,Y_z\rangle_P < 2\alpha_P(s)
$$

for every non-witness $a$, up to the small $\operatorname{OPT}$ slack. Thus a wrong certificate with positive correlation $\rho(s)$ is a legal weak output whenever $\alpha_P(s)\le \rho(s)/2$. Since the current target permits $\alpha_P(s)$ to be any inverse polynomial, a residual correlation $\rho(s)=s^{-K}$ is not safe.

This is the central quantifier problem. A lower bound cannot simply choose $K$ and prove all wrong certificates have correlation at most $s^{-K}$, because the target learner may have advantage $s^{-(K+10)}$. The reduction is not given $K$ or $\alpha_P$, and the node does not ask the learner to accept a requested advantage parameter.

## What Coding Bounds Actually Give

The coding bounds give a useful template obstruction, not a full edge resolution.

Let $Q_s$ be a shared coordinate set of size $N=\operatorname{poly}(s)$, and suppose there are $M=2^{\Omega(n)}$ challenge or certificate vectors at comparable representation size. If the source learner is the intended lookup-table ERM, then $N$ must remain polynomially visible.

1. **Exact weak safety.** If all wrong realizing certificate vectors have nonpositive correlation with each challenge vector, the construction is in the Plotkin/Hadamard regime. A binary length-$N$ code with this geometry has only $O(N)$ codewords. This cannot encode exponentially many formulas, images, or certificates at one size.

2. **Approximate safety.** If the code has rate $R=(\log_2 M)/N$ and relative distance $1/2-\eta$, standard LP/rate-versus-distance bounds put the best possible $\eta$ at an inverse-polynomial scale when $N$ is polynomial. Random-code heuristics give the same scale $\eta\approx\sqrt{R}$, and list-decoding capacity near radius $1/2-\alpha$ gives the same qualitative threshold $R=O(\alpha^2)$ up to logarithmic factors. Therefore polynomial shared-coordinate domains leave some inverse-polynomial positive-correlation scale visible.

3. **List decoding.** A polynomial list inside radius $1/2-\alpha$ only helps if every item in the list can be converted into the desired witness. The learner returns one proper hypothesis, not the list. For one-way images, a wrong nearby image does not invert the challenge image. For PCP/SAT encodings, a wrong satisfiable formula or proof is a false handle unless identity agreement has already been protected by the same near-Hadamard geometry.

So list decoding can certify that there are few close wrong handles above a chosen radius. It does not certify that the learner's one returned handle is useful, and it cannot make the chosen radius beat every possible hidden inverse-polynomial weak advantage while $N$ remains polynomial.

## Why "Choose a Smaller Gap" Does Not Work

A tempting repair is to add many amplification levels: for each desired exponent $K$, choose a code with wrong-certificate correlations below $s^{-K}$. This would work against a target whose advantage exponent were fixed in advance.

It does not work for the present node for two related reasons.

First, a class fixed with one exponent $K$ only refutes learners with $\alpha_P(s)\gg s^{-K}$. The atlas weak target allows smaller advantages.

Second, putting all exponents into one class while preserving lookup-style improper learning appears to break polynomial time. If level $K$ uses $N=n^{\Theta(K)}$ explicit coordinates and $K$ is part of the instance description, then lookup ERM over the coordinate set costs $n^{\Theta(K)}$, which is not polynomial in the natural representation length $n+K$. If instead the representation size is inflated to include the whole coordinate table, the weak advantage is measured in the inflated size $S$, and the hidden exponent can again be larger than the fixed correlation exponent available from a polynomial-size domain. The attempted amplification is renormalized away by the target definition.

This is the closest I can get to a route-impossibility statement:

> In any fixed-marginal separation template where the source is an explicit polynomial-coordinate lookup ERM and target hardness is certified only by Hamming/correlation separation from wrong proper certificates, approximate or list-decodable codes cannot separate the current marginal-nonuniform weak target. They can at best separate a fixed-advantage or requested-advantage variant.

## Possible Fixed-Gap Variant

For a modified node that fixed an advantage requirement, say $\alpha(s)\ge s^{-k_0}$ with known $k_0$, the approximate-code route would become much more plausible. One could choose a polynomial coordinate length large enough that the maximum wrong correlation is below $s^{-k_0}$, while lookup-table improper ERM remains polynomial for that fixed exponent. The proper lower bound would still need a clean identity or witness argument, but the hidden-gap obstruction would disappear.

That would not resolve the assigned edge. The assigned target only requires some marginal-dependent inverse-polynomial advantage, with no normalization and no requested gap parameter. A separation for the fixed-$k_0$ variant would therefore be evidence about a stricter target, not a counterexample to the atlas target.

## Depth-4 Verdict

No atlas status change.

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
```

The remaining approximate/list-decodable route should be marked as locally blocked in its standard form. Coding and list-decoding bounds can plausibly prove a no-go theorem for the explicit shared-coordinate lookup-ERM template, because polynomial coordinate domains leave inverse-polynomial residual correlations or inverse-polynomial list-decoding radii. The hidden marginal-dependent weak advantage then makes every fixed residual scale too coarse.

This does not prove the edge true. It leaves two possible escapes: a non-Hamming agreement theorem where every weakly close wrong certificate still reveals the target witness, or a non-lookup improper learner for a succinct near-Hadamard code that avoids agnostic parity/list-decoding hardness.

## Depth-5 Directions

1. **Write the template no-go as a lemma.** Formalize the assumptions: explicit coordinate set $Q_s$ with $|Q_s|=\operatorname{poly}(s)$; exponentially many challenge labels; proper hardness certified only by upper-bounding correlations of non-witness certificates; no postprocessing value from wrong close certificates. Prove exact safety by Plotkin/rank and approximate safety by rate-versus-distance or list-decoding capacity bounds.

2. **Separate fixed-gap from hidden-gap targets.** Add a short comparison note explaining that approximate codes may refute a known-$k_0$ weak target, while the atlas node's marginal-dependent hidden $\alpha_P$ blocks the same construction.

3. **Look for agreement, not list size.** Search for PCP/direct-product/low-degree agreement theorems where any object with correlation $s^{-K}$ to the target transcript identifies the target formula or witness. A mere small list is insufficient; the returned single hypothesis must be useful.

4. **Test succinct-code source learnability.** Try to formulate the Hadamard/image-code source as an agnostic improper learning problem. If the best possible improper learner is equivalent to agnostic parity or LPN-style decoding from random examples, record that as a conditional source-side obstruction.

5. **Audit whether weak learners can be gap-queried.** If a future atlas variant lets the reduction request an advantage parameter, then approximate/list-decodable codes should be revisited. Under the current definition, the learner has one hidden marginal-dependent gap and no tunable accuracy input.

## Depth 5 Follow-Up: Shared-Coordinate Lookup-ERM No-Go

- depth: 5
- verdict: unresolved for the atlas edge; the standard shared-coordinate lookup-ERM separation template is now locally blocked
- confidence: high for the template no-go, medium-high for leaving the edge open

## Focus

This pass followed the depth-4 directions that were most relevant to the assigned edge:

1. make the shared-coordinate lookup-ERM obstruction precise enough to be reusable;
2. distinguish what would be possible for fixed-gap weak proper targets from what is needed for the current marginal-nonuniform hidden-gap target; and
3. prepare candidate atlas wording if the edge remains open.

The conclusion is still `open`. The useful progress is a cleaner no-go for a natural false-witness template. The template can show hardness for a fixed requested advantage, but it does not refute the atlas target, where the proper learner's advantage may be an arbitrarily small inverse polynomial depending on the fixed marginal.

## Template Under Test

Fix a size parameter $s$. The template has four ingredients.

First, there is an explicit shared coordinate set $Q_s$ with

$$
N(s)=|Q_s|=\operatorname{poly}(s),
$$

and one fixed marginal $P_s$ on $Q_s$, usually uniform or with all visible coordinates having comparable mass. The input challenge changes only the conditional labels, not the marginal.

Second, each challenge $z$ gives a label vector $Y_z\in\{\pm1\}^{Q_s}$, and each proper certificate or representation $a$ gives a proper concept vector $C_a\in\{\pm1\}^{Q_s}$. For yes or invertible challenges there is at least one useful certificate $a(z)$ with small error against $Y_z$.

Third, the source is an improper lookup learner. Since $N(s)$ is polynomial, ERM over arbitrary lookup tables on $Q_s$, or over a slightly structured finite table class, gives strong agnostic improper learning in time polynomial in $N(s)$ and the usual accuracy parameters.

Fourth, the target-side lower bound is certified only by correlations. In $\{\pm1\}$ notation,

$$
\operatorname{err}_{P_s}(C_a,Y_z)
=
\frac{1-\langle C_a,Y_z\rangle_{P_s}}{2}.
$$

If the target weak advantage is $\alpha_{P_s}(s)$ and the yes optimum is negligible, a non-witness $a$ is excluded only when

$$
\langle C_a,Y_z\rangle_{P_s} < 2\alpha_{P_s}(s)
$$

up to the realization or agnostic slack. Therefore the template needs every useless proper certificate to have correlation below the learner's unknown weak advantage scale, unless a weakly close wrong certificate can itself be converted into the desired witness.

## Exact-Safety No-Go

Here is the clean exact version.

**Lemma (exact shared-coordinate safety is too expensive).** Suppose that, for infinitely many $s$, a shared-coordinate lookup witness contains $M(s)$ challenges whose realizing proper vectors are pairwise weak-safe in the sense that every wrong realizing vector has nonpositive correlation with the target labels:

$$
\langle C_{z'},Y_z\rangle_{P_s}\le 0
\qquad (z'\ne z).
$$

In the simplest realizable code case $Y_z=C_z$ and $P_s$ is uniform on $N(s)$ coordinates. Then $M(s)\le O(N(s))$ by the standard Plotkin/Hadamard, equivalently obtuse-set, bound for sign vectors in $\mathbb R^{N(s)}$. Thus a polynomial coordinate domain cannot host exponentially many formulas, one-way images, or certificates with exact pairwise weak safety.

**Proof sketch.** With uniform $P_s$, the vectors $C_z/\sqrt{N}$ lie on the unit sphere in $\mathbb R^N$ and have pairwise inner products at most $0$. A set of pairwise nonacute sign vectors in $N$ dimensions has size at most linear in $N$; Hadamard codewords and their complements show this is the right scale up to constants. Equivalently, this is the boundary case of the Plotkin/Hadamard coding regime. Since the hardness reductions need $M(s)=2^{\Omega(s)}$ challenges at one representation size, exact safety forces $N(s)$ to be exponential and destroys the explicit lookup-ERM source.

Small realization slack does not change the moral. If useful targets are only $\tau(s)$-close to proper codewords, then wrong certificates must have correlation at most about $O(\tau(s))$ to be exact-safe. For a weak lower bound against an unknown inverse-polynomial advantage, this still pushes the construction toward nonpositive or super-polynomially small wrong correlations.

## Approximate-Safety No-Go For The Atlas Target

Approximate codes avoid the linear-size Plotkin wall. For any chosen exponent $K$, one can try to take $N(s)$ large enough that all wrong certificates have correlation at most

$$
\rho(s)\le s^{-K}.
$$

This is the right idea for a fixed-gap target. It is not enough for the current edge.

The target node does not require a known advantage such as $s^{-k_0}$, and it does not let the reduction request an advantage parameter. It only says that for the fixed marginal $P_s$ there exists some inverse-polynomial gap

$$
\alpha_{P_s}(s)\ge s^{-k_P}
$$

for an exponent $k_P$ that may depend on the marginal and on the alleged learner's analysis. If a construction leaves a useless proper certificate with correlation $\rho(s)=s^{-K}$, then a learner whose valid guarantee has advantage $\alpha_{P_s}(s)\le \rho(s)/2$ may legally return that certificate. The lower-bound reduction receives a proper output but no witness.

So a correlation-only separation for this atlas node needs one of the following:

- exact or nonpositive wrong correlations;
- super-polynomially small positive correlations, so $\rho(s)<s^{-k}$ for every fixed $k$ eventually; or
- an agreement theorem saying that every certificate with even tiny positive correlation already reveals the challenge witness.

Polynomial shared-coordinate lookup domains do not appear to provide the first two for exponentially many challenges. Exact safety is blocked by the Plotkin/Hadamard regime. Standard rate-versus-distance and list-decoding bounds say that polynomial-length binary codes with exponentially many messages leave an inverse-polynomial residual scale whenever the rate is inverse-polynomial. Increasing the polynomial degree only changes the residual exponent; it does not dominate every possible hidden exponent $k_P$.

This is the promised route no-go:

> A fixed-marginal separation whose source is explicit polynomial-coordinate lookup ERM and whose proper hardness is certified only by pairwise Hamming or correlation separation cannot refute the current hidden-gap marginal-nonuniform weak target. It can rule out learners with a specified advantage scale, but the atlas target allows a smaller marginal-dependent inverse-polynomial advantage.

## Fixed-Gap Variants Are Different

The approximate-code route should not be discarded entirely. It points to a real distinction between two weak-proper notions.

For a fixed-gap variant, say a target requiring advantage at least $s^{-k_0}$ for a known constant $k_0$, the shared-code strategy could plausibly work at the gap-bookkeeping level. Choose a polynomial coordinate length with degree large enough that wrong-code correlations are below $s^{-k_0}$, run lookup-table ERM as the improper source, and use the proper learner's output to recover a witness. One would still need to solve the identity or witness problem, but the hidden-gap obstruction would be gone.

The same is true for a requested-advantage variant where the learner takes $\gamma$ as an input and promises error at most $\operatorname{OPT}+1/2-\gamma$ in time polynomial in $1/\gamma$. Then the lower bound could tune the code to the requested $\gamma$ before invoking the learner.

The current atlas node is weaker and more slippery. It has one learner, no $\gamma$ input, and one marginal-dependent weak gap that is only known to exist. A class built with one fixed exponent $K$ only challenges learners whose hidden exponent is smaller than $K$. Trying to include all exponents as explicit levels reintroduces the renormalization problem from depth 4: if level $K$ has $n^{\Theta(K)}$ coordinates, lookup ERM is not polynomial in the natural size $n+K$; if the representation size is inflated to the coordinate length $S$, the weak gap is measured in $S$ and may again be smaller than the residual correlation achieved at that level.

Thus a fixed-gap separation would be evidence about a stricter target, not a counterexample to this edge.

## Consequences For Existing Routes

The no-go explains the failures of the existing witnesses in one language.

The clause-satisfaction fixed-marginal construction has an efficient improper lookup source, but its optimum gap is an accuracy gap of order $1/|X_n|$. That is useful for strong agnostic proper targets, where the learner can be run to small $\varepsilon$, but a weak proper learner may spend nearly $1/2$ additive error and never recover a satisfying assignment.

The PCP active-slice construction has the right weak gap on one active slice, but the slice is part of the marginal. Once all instances are packed into one fixed marginal, each active slice has too little mass. Replacing active slices by shared coordinates creates unrelated satisfiable-instance handles unless formula identity is protected by the same near-Hadamard code geometry.

The one-way image-coordinate construction has a fixed marginal and an agnostic improper sparse-ERM source, but the length blocks are low mass and wrong same-length images are too good at the weak threshold. Dense shared-code repairs need near-zero wrong correlations; exact Hadamard geometry makes the source look like agnostic parity or noisy codeword decoding instead of lookup ERM.

## Proposed Atlas Update

No resolved status change is justified. Keep:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
```

Candidate summary:

> Open: strong marginal-nonuniform agnostic improper learning gives no known efficient projection to a proper hypothesis, and fixed-marginal weak proper separations require more than polynomial-coordinate lookup hardness because the target's weak advantage is hidden and marginal-dependent.

Candidate body paragraph:

> A shared-coordinate lookup-ERM template appears locally blocked. If all hard challenges are encoded over one polynomial-size coordinate marginal, the improper source can learn by table ERM, but weak proper hardness would have to rule out every non-witness proper certificate at the unknown advantage scale $\alpha_P(s)$. Exact nonpositive-correlation safety for exponentially many certificates is impossible on polynomially many binary coordinates by the Plotkin/Hadamard or obtuse-set bound. Approximate codes leave an inverse-polynomial residual correlation scale, which may exceed the hidden marginal-dependent weak gap. Such codes could address a fixed-gap or requested-gap weak variant, but they do not separate the current atlas node without an additional agreement theorem turning every weakly close wrong certificate into the desired witness.

## Obstacles

1. **Hidden weak-gap quantifier.** A residual wrong-certificate correlation $s^{-K}$ is harmless only against learners whose advantage is larger than that scale. The atlas learner may have advantage $s^{-(K+10)}$ under the fixed marginal and still satisfy the target.

2. **Exact safety is dimension-limited.** Nonpositive pairwise correlation among exponentially many target/certificate vectors requires exponentially many shared coordinates; polynomial lookup ERM then loses the intended runtime scale.

3. **Approximate safety renormalizes.** Adding larger polynomial code blocks only changes an exponent. If all exponents are placed into one class, either lookup ERM is not polynomial in the natural representation length or the representation length is inflated so the target's hidden gap shrinks along with it.

4. **List decoding returns the wrong object.** A small list of close certificates would not be enough, because the learner returns one proper hypothesis. Wrong close list elements must be useful witnesses, not merely few in number.

5. **Hadamard safety loses the source.** Exact orthogonal encodings make weak proper outputs informative, but strong agnostic improper learning becomes an agnostic parity or correlation-search problem rather than the sparse/table ERM used by the atlas witnesses.

## Depth-6 Directions

1. **Make the approximate coding bound citation-grade.** State the best available binary rate-versus-distance or list-decoding bound in the variables $M(s)$, $N(s)$, and $\rho(s)$, then record exactly what residual correlation scale is unavoidable for $M(s)=2^{\Omega(s)}$ and $N(s)=\operatorname{poly}(s)$.

2. **Formalize the all-exponents renormalization lemma.** Model a union over levels $K$ with coordinate length $N_K(n)$ and representation size $S(n,K)$, and prove that either lookup ERM is not polynomial in $S$ or the residual correlation is only a fixed inverse polynomial in $S$, hence still vulnerable to a smaller hidden weak gap.

3. **Search for agreement theorems rather than better codes.** The only visible escape from the no-go is a theorem saying any proper hypothesis with correlation $s^{-K}$ to the target transcript reveals the target witness. PCP agreement, direct-product tests, or low-degree self-correction are more relevant than ordinary list-size guarantees.

4. **Define and compare fixed-gap atlas variants.** Write candidate nodes for known-$k_0$ weak proper learning or requested-gap weak proper learning. Then check whether the approximate shared-code construction can produce an actual conditional false edge there, keeping the current hidden-gap edge open.

5. **Audit projection-style positive routes.** If no separation survives the hidden-gap issue, revisit whether efficient marginal-nonuniform agnostic improper learning plus some effective fixed-marginal trace property implies weak properization. The needed extra object is a projection oracle from an improper predictor to a weakly correlated proper concept.

## References Checked

- Depth-1 through depth-4 notes in this scratchpad.
- [[efficient-marginal-nonuniform-agnostic-improper-pac|Efficient Marginal-Nonuniform Agnostic Improper PAC Learning]]
- [[efficient-marginal-nonuniform-weak-agnostic-proper-pac|Efficient Marginal-Nonuniform Weak Agnostic Proper PAC Learning]]
- [[properization-open|Properization Open]]
- [[clause-satisfaction-proper-hardness|Clause-Satisfaction Proper Hardness]]
- [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]
- [[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]]
- [[one-way-image-coordinate-weak-handle-hardness|One-Way Image Coordinate Weak-Handle Hardness]]
- [[clause-satisfaction-lookup-class|Clause-Satisfaction Lookup Class]]
- [[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]]
- [[one-way-image-coordinate-class|One-Way Image Coordinate Class]]
- [[one-way-image-coordinate-weak-handle-class|One-Way Image Coordinate Weak-Handle Class]]
- Sibling scratchpads for the distribution-free target and the weak-realizable marginal target under the same source.
- Plotkin 1960, Guruswami-Vadhan 2010, and the coding references already recorded in depths 2--4.

---

# Depth-6 Final Follow-Up

- depth: 6
- edge_file: atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md
- verdict: unresolved
- confidence: high that the atlas edge should remain `open`; high that the shared-coordinate lookup-ERM route is blocked in its standard form

## Final Focus

This last pass followed the depth-6 directions one more time:

1. make the approximate coding obstruction citation-grade;
2. formalize the all-exponents renormalization problem;
3. check whether agreement-style theorems, rather than ordinary list-decoding, could evade the obstruction;
4. separate fixed-gap variants from the current hidden-gap target; and
5. audit whether the strong agnostic improper source gives any projection-style positive theorem.

I did not find a resolution. The edge remains a genuine fixed-marginal weak properization problem. The source gives a single efficient marginal-nonuniform strong agnostic improper learner, but the target requires a proper hypothesis with some inverse-polynomial additive weak advantage whose scale is hidden and may depend on the marginal. No generic efficient projection from improper predictors into $\mathcal C$ is known, and the natural fixed-marginal counterexample templates lose either the weak-gap scale or the efficient agnostic improper source.

## Citation-Grade Coding Obstruction

The standard shared-coordinate false-witness template has a coordinate set $Q_s$ of size $N(s)$, one fixed marginal $P_s$ on $Q_s$, challenge label vectors $Y_z\in\{\pm1\}^{Q_s}$, and proper certificate vectors $C_a\in\{\pm1\}^{Q_s}$. If $P_s$ is uniform, then

$$
\operatorname{err}(C_a,Y_z)=\frac{1-\langle C_a,Y_z\rangle}{2}.
$$

For a nearly realizable challenge, a non-witness certificate $a$ is ruled out by a weak proper learner only when

$$
\langle C_a,Y_z\rangle < 2\alpha_{P_s}(s)
$$

up to the optimum slack, where $\alpha_{P_s}(s)=1/2-\beta_{P_s}(s)$ is the hidden weak advantage. Thus a correlation-only lower bound must make every useless certificate have correlation below an unknown inverse-polynomial threshold.

The exact version is blocked by the Plotkin/Hadamard regime. If one chooses one realizing proper vector for each of $M$ hard challenges and requires pairwise nonpositive correlation, then the corresponding binary code has relative distance at least $1/2$. The Plotkin bound, equivalently the obtuse-set bound for sign vectors in $\mathbb R^N$, gives only $M=O(N)$ codewords at this boundary. Therefore a polynomial coordinate domain cannot encode exponentially many formulas, one-way images, or certificates with exact weak-safe pairwise geometry.

The approximate version is also too weak for the current atlas node. Let $M$ codewords of length $N$ have relative distance at least $1/2-\eta$, i.e. pairwise correlations at most $2\eta$. Writing the rate as

$$
R=\frac{\log_2 M}{N},
$$

the McEliece-Rodemich-Rumsey-Welch linear-programming bound for binary codes implies, near distance $1/2$, a rate upper bound of the form

$$
R \le O(\eta^2\log(1/\eta)).
$$

Equivalently, if $M=2^{\Omega(s)}$ and $N=s^c$, then some residual positive-correlation scale

$$
\eta \gtrsim \frac{s^{(1-c)/2}}{\operatorname{polylog}(s)}
$$

is unavoidable up to constants and logarithmic factors. This is still an inverse polynomial for every fixed polynomial coordinate length. List-decoding bounds near radius $1/2-\alpha$ give the same qualitative conclusion: polynomial-length binary codes with exponentially many messages can control lists only down to a fixed inverse-polynomial radius scale, not below every possible inverse-polynomial weak advantage.

This does not prove the edge true. It does block any separation whose only safety mechanism is pairwise Hamming or correlation distance on an explicit polynomial coordinate set.

## All-Exponents Renormalization Lemma

The natural attempted repair is to include many amplification levels. For level $K$, choose a code length $N_K(n)$ large enough that wrong-certificate correlations are at most $n^{-K}$. This can beat any fixed requested weak advantage exponent known in advance.

It does not beat the current hidden-gap target. A useful way to state the obstruction is:

> **Renormalization lemma for lookup-code templates.** Consider a fixed class built as a union of levels $K$, where level $(n,K)$ has $M(n)=2^{\Omega(n)}$ challenges and an explicit coordinate set of size $N_K(n)$. If the improper source is lookup-style ERM, then its runtime is at least polynomial in the visible coordinate scale $N_K(n)$. If $N_K(n)$ is superpolynomial in the natural representation length $S(n,K)$, the source is not efficient. If $N_K(n)$ is polynomial in $S(n,K)$, then the coding bounds above leave only an inverse-polynomial residual correlation in $S(n,K)$, and the target learner's hidden advantage may be smaller.

For example, taking $N_K(n)=n^{\Theta(K)}$ is not polynomial in $S=n+K$ for unbounded $K$. If the representation is instead inflated so that $S\approx N_K(n)$, then the residual correlation is at best $S^{-O(1)}$ for that level, while the marginal-nonuniform weak learner is allowed to have advantage $S^{-B}$ for a larger hidden constant $B$. The exponent has merely been moved into the size parameter.

Thus a union over all exponents either destroys the explicit lookup-ERM source or still leaves a fixed inverse-polynomial wrong-correlation scale at each represented size.

## Agreement Theorems Versus List Decoding

The only visible escape from the coding no-go is not a better ordinary code. It would be an agreement theorem saying that every weakly correlated proper object already reveals the target witness:

$$
\langle C_a,Y_z\rangle \ge s^{-K}
\quad\Longrightarrow\quad
a \text{ can be converted into a witness for } z .
$$

A small list of nearby objects is insufficient because the learner returns one proper hypothesis, not the list. For a one-way image construction, a wrong nearby image does not invert the challenge image. For a PCP/SAT construction, a satisfiable unrelated formula or proof is a false weak handle unless formula identity is already protected by near-Hadamard separation.

Ordinary PCP soundness controls proofs for one fixed formula on that formula's active slice. Once the active formula is removed from the marginal, unrelated formulas become legal proper weak handles. Direct-product, low-degree, or agreement-test PCP machinery is the right literature to inspect next, but the needed statement is stronger than list-size control: the returned single hypothesis must itself identify the target instance or be eliminable under the same fixed marginal without raising $\operatorname{OPT}$ toward $1/2$.

No existing atlas argument supplies such an agreement theorem.

## Fixed-Gap Variants Are Easier Than This Edge

Approximate shared codes may still be relevant for stricter variants:

- a known-exponent weak target requiring advantage at least $s^{-k_0}$;
- a requested-gap weak target where the learner takes $\gamma$ and promises $\operatorname{OPT}+1/2-\gamma$ in time polynomial in $1/\gamma$; or
- a threshold/correlation weak oracle of the kind used in some agnostic boosting formulations.

For those variants, one can choose a polynomial coordinate length whose residual wrong-certificate correlation is below the requested or known gap. The remaining identity/witness issue would still need proof, but the hidden-gap obstruction disappears.

The assigned node is weaker. It only promises that some marginal-dependent inverse-polynomial $\alpha_P(s)$ exists, and the learner is not queried with $\gamma$. A counterexample to a fixed-gap variant would not refute this atlas edge.

## Positive Route Audit

The source learner outputs an improper predictor $g$ satisfying

$$
\operatorname{err}_{\mathcal D}(g)\le \operatorname{OPT}_{\mathcal C}+\varepsilon.
$$

To prove the target from this, one needs a properization step. In the realizable case this looks like fixed-marginal weak projection: from a predictor close to some $c^\star\in\mathcal C$, find $h\in\mathcal C$ with nontrivial $P$-correlation. In the agnostic case it is even more representation-sensitive: low-margin regions of the conditional label distribution may allow large $L_1(P)$ disagreement without increasing error much, while high-margin regions matter. A plain $L_1(P)$ cover or projection is sufficient only under extra quantitative assumptions; the abstract source learner does not provide such a cover.

The following additional assumptions would imply restricted positive results, but none follows from the source definition:

1. polynomial-time fixed-marginal approximate proper ERM;
2. a computable polynomial-size $L_1(P)$ cover by valid concepts, together with validation;
3. effective finite support plus efficient proper trace-realization search; or
4. a constant-slack projection oracle from low-error improper predictors to valid concepts.

Marginal nonuniformity does not itself provide these objects. The learner is one uniform algorithm; the $P$-dependent polynomial bound is not $P$-dependent advice, a support ordering, a cover, or a projection map.

## Final Verdict For Atlas Incorporation

Keep the edge open.

Suggested metadata:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
argument_note: "[[properization-open|Properization Open]]"
summary: "Open: no efficient fixed-marginal projection from strong agnostic improper predictors to weak agnostic proper hypotheses is known, and standard fixed-marginal separations lose either the hidden weak-gap scale or the efficient agnostic improper source."
```

Suggested atlas body:

> **Goal.** Convert a strong marginal-nonuniform agnostic improper learner into a proper learner with inverse-polynomial additive weak advantage under the same marginal.
>
> **Positive obstruction.** The source supplies accurate external prediction, not an efficient search procedure over $\mathcal C$. Uniform convergence shows that good proper hypotheses exist, but efficient proper ERM, effective $P$-dependent covers by valid concepts, or projection from an improper predictor back into $\mathcal C$ are additional representation-level assumptions.
>
> **Counterexample obstruction.** Existing improper/proper separations do not settle the fixed-marginal weak agnostic target. Clause-satisfaction fixed-marginal hardness gives only a strong-accuracy gap. PCP active-slice hardness has a constant weak gap but makes the hard slice part of the marginal. One-way image-coordinate hardness gives fixed-marginal strong proper hardness, but weak learners can use wrong-image or low-mass handles. Shared-coordinate balanced-code repairs run into coding bounds: exact nonpositive-correlation safety for exponentially many certificates requires Hadamard/Plotkin-scale coordinate domains, while polynomial coordinate domains leave inverse-polynomial residual correlations that may exceed the hidden marginal-dependent weak advantage.
>
> **Conclusion.** The implication remains open as a fixed-marginal weak agnostic properization question.

## Crisp Obstacles

1. **No generic proper projection.** A strong improper learner can predict well without producing or locating a valid concept representation.

2. **Agnostic projection is weighted, not plain trace recovery.** In noisy regions, disagreement with the best proper concept may be cheap; in high-margin regions, it is expensive. The source guarantee alone does not expose the right cost-sensitive proper search problem.

3. **Hidden weak gap.** A wrong proper concept with correlation $s^{-K}$ can be a legal output for a learner whose marginal-dependent advantage is $s^{-(K+10)}$.

4. **Fixed-marginal packing dilutes active slices.** PCP-style weak hardness loses its constant gap when exponentially many input slices are packed into one marginal.

5. **Exact shared-code safety is dimension-limited.** Plotkin/Hadamard bounds allow only $O(N)$ pairwise nonpositively correlated binary vectors on $N$ explicit coordinates.

6. **Approximate shared-code safety renormalizes.** MRRW/list-decoding bounds leave inverse-polynomial residual correlations for polynomial coordinate domains; adding all exponents either breaks lookup-ERM efficiency or inflates the representation size.

7. **Agreement is stronger than list decoding.** A wrong close list element must reveal the hard witness or be eliminable under the same marginal; ordinary small-list guarantees do not provide that.

8. **Hadamard repairs lose the source.** Exact orthogonality makes weak proper outputs informative, but the improper agnostic learner becomes parity/noisy-codeword-like rather than lookup-ERM-like.

## Best Future Directions

1. Search for agreement-test or direct-product PCP statements where weak correlation with one shared transcript forces recovery of the target instance or witness.

2. Formalize the shared-coordinate lookup-ERM no-go as an auxiliary argument note, using Plotkin for exact safety and MRRW or list-decoding bounds for approximate safety.

3. Define optional fixed-gap or requested-gap weak nodes separately; approximate shared-code constructions may be meaningful there even though they do not resolve this hidden-gap edge.

4. Develop a restricted positive theorem for classes with computable fixed-marginal proper covers, approximate proper ERM, or constant-slack projection oracles.

5. Investigate whether any non-lookup improper relaxation of Hadamard/image-code concepts is efficiently agnostically learnable from random examples without amounting to agnostic parity or LPN-style decoding.

## References Checked In This Final Pass

- `atlas/definitions/efficient-marginal-nonuniform-agnostic-improper-pac.md`
- `atlas/definitions/efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-weak-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-marginal-nonuniform-agnostic-proper-pac--implies--efficient-marginal-nonuniform-weak-agnostic-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/arguments/full-support-marginal-uniformization.md`
- `atlas/arguments/marginal-uniformization-open.md`
- `atlas/arguments/clause-satisfaction-proper-hardness.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-proper-hardness.md`
- `atlas/arguments/one-way-image-coordinate-weak-handle-hardness.md`
- `atlas/witnesses/clause-satisfaction-lookup-class.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/witnesses/one-way-image-coordinate-class.md`
- `atlas/witnesses/one-way-image-coordinate-weak-handle-class.md`
- Sibling scratchpad: `efficient-marginal-nonuniform-agnostic-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`
- Plotkin, "Binary codes with specified minimum distance," IRE Transactions on Information Theory 6(4):445--450, 1960, DOI [10.1109/TIT.1960.1057584](https://doi.org/10.1109/TIT.1960.1057584).
- McEliece, Rodemich, Rumsey, and Welch, "New upper bounds on the rate of a code via the Delsarte-MacWilliams inequalities," IEEE Transactions on Information Theory 23(2):157--166, 1977, DOI [10.1109/TIT.1977.1055688](https://doi.org/10.1109/TIT.1977.1055688).
- Guruswami and Vadhan, "A Lower Bound on List Size for List Decoding," IEEE Transactions on Information Theory 56(11):5681--5688, 2010, DOI [10.1109/TIT.2010.2070170](https://doi.org/10.1109/TIT.2010.2070170).
