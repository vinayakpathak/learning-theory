# Edge: efficient-marginal-nonuniform-realizable-improper-pac -> efficient-marginal-nonuniform-weak-realizable-proper-pac

- date: 2026-05-07
- depth: 1
- edge_file: `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`
- source: [[efficient-marginal-nonuniform-realizable-improper-pac|Efficient Marginal-Nonuniform Realizable Improper PAC Learning]]
- target: [[efficient-marginal-nonuniform-weak-realizable-proper-pac|Efficient Marginal-Nonuniform Weak Realizable Proper PAC Learning]]
- verdict: unresolved
- confidence: high that the current atlas status should remain `open` under the finite-encoded computational convention

## Question

Does a strong efficient marginal-nonuniform realizable **improper** learner always yield a weak efficient marginal-nonuniform realizable **proper** learner?

The source gives one uniform learner that, for every fixed marginal $P$, predicts every realizable target $c\in\mathcal C_s$ to arbitrary error using a $P$-dependent polynomial time/sample bound. The target asks for one uniform learner that, for every fixed $P$, outputs an actual member of $\mathcal C$ with error at most

$$
\frac12-\gamma_P(s),
$$

where $1/\gamma_P(s)$ is bounded by a $P$-dependent polynomial.

Thus the only relaxation is statistical strength; the hard move is representation-sensitive properization.

## Sources Checked

Local atlas files:

- `atlas/README.md`, especially the convention that computationally efficient nodes use worst-case/pathwise bounds on finite encoded sample transcripts.
- `atlas/definitions/efficient-marginal-nonuniform-realizable-improper-pac.md`.
- `atlas/definitions/efficient-marginal-nonuniform-weak-realizable-proper-pac.md`.
- `atlas/implications/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac.md`.
- [[properization-open|Properization Open]].
- [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]] and [[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]].
- [[one-way-image-coordinate-proper-hardness|One-Way Image Coordinate Proper Hardness]] and [[one-way-image-coordinate-class|One-Way Image Coordinate Class]].
- [[one-way-image-coordinate-weak-handle-hardness|One-Way Image Coordinate Weak-Handle Hardness]] and [[one-way-image-coordinate-weak-handle-class|One-Way Image Coordinate Weak-Handle Class]].
- [[marginal-boosting-open|Marginal-Nonuniform Boosting Open]].

Previous exact-edge scratchpads:

- `scratchpads/open-edge-resolution-2026-05-04/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`.
- `scratchpads/open-edge-resolution-2026-05-05/efficient-marginal-nonuniform-realizable-improper-pac--implies--efficient-marginal-nonuniform-weak-realizable-proper-pac/scratchpad.md`.

Primary or near-primary sources checked:

- Hanneke, Moran, and Thiessen, *Marginal-Nonuniform PAC Learnability*, OpenReview 2025/2026: https://openreview.net/forum?id=aoVCFtox89. Used for the quantifier pattern: rates may depend on the marginal, but after fixing the marginal they hold uniformly over concepts.
- Benedek and Itai, *Learnability with Respect to Fixed Distributions*, Theoretical Computer Science 1991, DOI https://doi.org/10.1016/0304-3975(91)90026-X.
- Ben-David, Benedek, and Mansour, *A Parameterization Scheme for Classifying Models of PAC Learnability*, Information and Computation 1995, DOI https://doi.org/10.1006/inco.1995.1094.
- Schapire, *The Strength of Weak Learnability*, Machine Learning 1990, DOI https://doi.org/10.1023/A:1022648800760. Used only to check that standard boosting gives an aggregate predictor, not a generic proper projection.
- Håstad and Khot, *Query Efficient PCPs with Perfect Completeness*, Theory of Computing 2005, DOI https://doi.org/10.4086/toc.2005.v001a007.
- Pitt and Valiant, *Computational Limitations on Learning from Examples*, JACM 1988, DOI https://doi.org/10.1145/48014.63140.
- Khot and Saket, *Hardness of Minimizing and Learning DNF Expressions*, FOCS 2008, DOI https://doi.org/10.1109/FOCS.2008.37.
- Kearns and Valiant, *Cryptographic Limitations on Learning Boolean Formulae and Finite Automata*, JACM 1994, DOI https://doi.org/10.1145/174644.174647.
- Håstad, Impagliazzo, Levin, and Luby, *A Pseudorandom Generator from any One-Way Function*, SIAM J. Comput. 1999, DOI https://doi.org/10.1137/S0097539793244708.
- Goldreich and Levin, *A Hard-Core Predicate for all One-Way Functions*, STOC 1989, DOI https://doi.org/10.1145/73007.73010. Used for the parity/hard-core intuition, not as an atlas-ready witness.
- Plotkin, *Binary Codes with Specified Minimum Distance*, IRE Trans. Information Theory 1960, DOI https://doi.org/10.1109/TIT.1960.1057584, plus McEliece-Rodemich-Rumsey-Welch 1977 and Guruswami-Vadhan 2010 for the qualitative coding-bound backdrop near distance $1/2$.
- Asilis, Devic, Dughmi, Sharan, and Teng, *Proper Learnability and the Role of Unlabeled Data*, ALT 2025/OpenReview: https://openreview.net/forum?id=lEhg21XO0R. Useful context: distribution-fixed proper learnability has strong information-theoretic existence results for finite problems, but this does not supply the computational proper selector needed here.

## Theorem Route

The direct positive proof would be:

1. run the source learner under the fixed marginal $P$ to obtain an improper predictor $g$ with $\operatorname{err}_P(g,c)\le 1/16$;
2. efficiently find $h\in\mathcal C$ with nontrivial $P$-agreement with $c$;
3. validate among finitely many candidates, if needed, to get error below $1/2-\gamma_P(s)$.

Step 1 is exactly the source. Step 3 is routine once a polynomial-size proper candidate list exists. Step 2 is not supplied by any checked theorem.

The information-theoretic proper hypothesis exists: it is the target concept $c$ itself. In sample-efficient settings, an unbounded ERM or finite-problem optimal learner can exploit that existence. In the computational atlas node, however, the learner must output a representation in $\mathcal C$ in polynomial time. The source learner may have avoided the proper search by outputting a table, sparse memorizer, parity vector, vote, or other external representation.

Boosting does not fill this gap. Schapire-style boosting addresses weak-to-strong prediction, while this edge needs improper-to-proper projection. The source is already strong; the missing operation is a fixed-marginal weak proper selector.

A conditional positive lemma would be valid:

> If, for every fixed marginal $P$, there is a uniform procedure running in $P$-dependent polynomial time that takes samples and/or an accurate improper predictor $g$ and outputs a polynomial-size list $L\subseteq\mathcal C$ containing some $h$ with $\operatorname{err}_P(h,c)\le 1/2-1/\operatorname{poly}_P(s)$, then the edge holds by holdout validation.

But this selector is an extra assumption, not a consequence of the source definition.

## Counterexample Route

### PCP Active Slices

The PCP active-slice class gives the right distribution-free weak-proper lower-bound shape. For a fixed formula $\varphi$, the active slice has polynomially many random strings, and a weak proper learner under the uniform active-slice marginal would output a proof accepted above the soundness threshold.

This does not refute the assigned marginal-nonuniform target. If the reduction chooses the marginal $P_\varphi$ depending on the input formula, the target only promises a polynomial $p_{P_\varphi}$ and advantage $\gamma_{P_\varphi}$ that may depend on that whole marginal. That dependence blocks a uniform polynomial-time NP/RP contradiction.

Packing all formula slices into one fixed marginal $P^\star$ dilutes the local PCP gap by the slice mass $w_\varphi$. Since there are exponentially many formulas of length $n$, a typical $w_\varphi$ is exponentially small. A global weak guarantee of inverse-polynomial advantage under $P^\star$ need not reveal anything useful about the selected formula.

### One-Way Image Coordinates

The one-way image-coordinate class proves strong proper recovery hardness under a fixed marginal. If the length-$n$ block has mass $\mu_n$, then asking for strong proper error $\varepsilon\ll \mu_n/n$ forces a proper seed whose image matches every coordinate of the challenge.

Weak proper learning does not force that. A wrong-length proper concept, a sparse wrong-image concept, or an added constant/singleton handle can beat random guessing without inverting. The weak-handle atlas note makes this explicit: constants and positive-atom handles destroy weak lower bounds while preserving strong proper hardness.

The lesson is that a false witness must make **every efficiently findable inverse-polynomial weak handle** computationally meaningful. Strong recovery hardness is not enough.

### Dense Parity-Image Model Warning

There is a clean conditional separation in a broader example model.

Assume a length-preserving one-way function $f_n:\{0,1\}^n\to\{0,1\}^n$. For a seed $s$, define a proper concept by the parity

$$
c_s(x)=\langle f_n(s),x\rangle \pmod 2
$$

under the uniform marginal on $x\in\{0,1\}^n$. Improper learning is easy in the realizable case: Gaussian elimination learns the parity vector $f_n(s)$ from labeled examples. Proper learning must output a seed $t$. Under the uniform marginal, any seed with $f_n(t)\ne f_n(s)$ has error exactly $1/2$, so any weak proper learner with positive advantage inverts $f$.

If the atlas permitted one fixed non-atomic product space, such as lazy fair-bit examples $x\in\{0,1\}^{\mathbb N}$ where an algorithm reads only finitely many coordinates, this parity-image construction would be a conditional false witness for the edge under one-way functions.

I do not treat it as atlas-ready. `atlas/README.md` states that computational resource bounds are worst-case/pathwise bounds on finite encoded sample transcripts, and the existing computational witnesses use finite strings or finite tuples. A lazy random-bit oracle is a different sample access model.

### Finite-Encoding Barrier For Pure Orthogonality

Trying to simulate the parity-product construction on a fixed countable finite-encoded marginal runs into a simple heavy-atom obstruction.

Let $P$ be a fixed countable marginal, and let $x_0$ be an atom of largest mass $\alpha>0$. Suppose a finite-encoded parity-image surrogate had, for infinitely many sizes $n$, a large binary proper family $\mathcal F_n$ such that every wrong pair had correlation

$$
\rho_P(f,g)=\mathbb E_{X\sim P}[f(X)g(X)]\le \eta_n
$$

with $\eta_n$ eventually below the hidden inverse-polynomial weak advantage. Pick a subfamily $S\subseteq\mathcal F_n$ of size $m\ge |\mathcal F_n|/2$ agreeing on $x_0$. On $X\setminus\{x_0\}$, the restricted Gram matrix

$$
H_{fg}=\sum_{x\ne x_0}P(x)f(x)g(x)
$$

is positive semidefinite, has diagonal $1-\alpha$, and has off-diagonal entries at most $\eta_n-\alpha$. Testing on the all-ones vector gives

$$
0\le m(1-\alpha)+m(m-1)(\eta_n-\alpha).
$$

If $\eta_n\le \alpha/2$, then $m\le 1+2(1-\alpha)/\alpha$, so $|\mathcal F_n|$ is bounded by a constant depending only on $P$. This rules out the exact or hidden-gap-safe pairwise orthogonality needed by the parity-image inversion reduction for an unbounded finite-encoded proper family.

This does not prove the implication. It only blocks the clean geometric counterexample route. A finite-encoded negative result would need computational weak-handle hardness: positively correlated non-witness proper concepts may exist, but finding any one of them would have to solve a hard search problem.

## Current Obstacles

1. **No proper selector from the source.** Accurate improper prediction does not provide a polynomial-time map back into $\mathcal C$.

2. **Weak targets admit hidden handles.** Any inverse-polynomial positive correlation is enough. Constants, wrong-length concepts, partial matches, and residual code correlations can all satisfy a weak target without recovering the hard representation.

3. **Input-dependent marginals are absorbed.** PCP-style lower bounds that focus the marginal on the hard instance do not contradict marginal-nonuniform learning, because the polynomial and weak advantage may depend on that marginal.

4. **One fixed finite marginal has a mass budget.** Packing exponentially many hard slices into one marginal dilutes each slice. Pure dense orthogonality is blocked by the heavy-atom argument above.

5. **Approximate finite codes are not enough.** Polynomial-length codes with residual inverse-polynomial correlations leave possible weak handles. Making residual correlations smaller than every inverse polynomial pushes toward superpolynomial code length or a non-atomic product model.

6. **Computational weak-handle hardness is missing.** The remaining false route must show not that weak handles do not exist, but that no efficient learner can find any valid weak handle under the fixed marginal. I did not find a standard PCP, one-way-function, or coding theorem that gives this exact statement.

## Follow-Up Directions

1. Formalize a reusable `fixed-marginal weak proper selector` conditional theorem. It should state exactly how an accurate improper predictor plus a searchable proper candidate list yields the target by validation.

2. Search for a standard computational weak-handle hardness assumption: a fixed marginal and concept class where weakly correlated proper hypotheses exist information-theoretically, but finding any such hypothesis is hard.

3. Revisit dense cryptographic encodings only if the lower bound controls **all** inverse-polynomial correlations at the representation-size scale. Ordinary one-way inversion and polynomial-length ECC distance are not enough.

4. Keep the lazy-product parity-image construction as a model warning. If the atlas later admits non-atomic examples or oracle-valued lazy samples, this edge should be reconsidered as conditionally false under length-preserving one-way functions.

5. Avoid pure finite-encoded orthogonality as a sole route. The heavy-atom Gram argument shows why that geometry cannot scale to unbounded proper families under one fixed countable marginal.

## Verdict

`unresolved`.

No atlas-ready theorem or counterexample is justified under current finite-encoded atlas semantics. The edge should remain:

```yaml
status: "open"
evidence: unknown
assumptions: []
witnesses: []
family: properization-open
```

The best sharpened summary is:

> Strong marginal-nonuniform improper learning gives accurate prediction but no known efficient weak proper selector. A lazy-product parity-image construction would separate the edge in an expanded example model, but finite fixed marginals have heavy-atom and weak-handle obstructions. Existing PCP and one-way constructions either use input-dependent hard marginals, dilute the hard slice, or leave easy partial-match proper hypotheses.

## Depth 2 Branch A: Heavy-Atom Gram Obstruction

- branch date: 2026-05-07
- focus: heavy-atom obstruction to finite-encoded dense orthogonality
- verdict: reusable obstruction lemma, but not a resolution of the edge

### Reusable Lemma

Work in $\{\pm 1\}$ notation, so that

$$
\operatorname{err}_P(h,c)=\frac{1-\rho_P(h,c)}2,
\qquad
\rho_P(h,c)=\mathbb E_{X\sim P}[h(X)c(X)].
$$

Thus weak advantage $\gamma$ is the same as correlation at least $2\gamma$.

**Lemma.** Let $P$ be one fixed probability distribution on a countable finite-encoded instance space $X$. Let

$$
\alpha=\max_{x\in X}P(x)>0.
$$

For any finite family $\mathcal F$ of $\{\pm 1\}$-valued functions, if every distinct pair satisfies

$$
\rho_P(f,g)\le \eta<\alpha,
$$

then

$$
|\mathcal F|
\le
2+2\frac{1-\alpha}{\alpha-\eta}.
$$

In particular, if $\eta\le \alpha/2$, then $|\mathcal F|\le 2+4(1-\alpha)/\alpha$. Hence one fixed countable marginal cannot support an unbounded binary family whose wrong-pair correlations are all exact-zero, nonpositive, or below any scale that is eventually less than $\alpha$.

**Proof.** A countable probability distribution has a largest atom: if the supremum of the positive atom masses were not attained, then infinitely many atoms would have mass above half the supremum, contradicting summability. Pick $x_0$ with $P(x_0)=\alpha$.

By pigeonhole, some subfamily $S\subseteq\mathcal F$ of size $m\ge |\mathcal F|/2$ has a common value at $x_0$. For $f,g\in S$, form the restricted Gram matrix

$$
H_{fg}
=
\sum_{x\ne x_0}P(x)f(x)g(x).
$$

This is positive semidefinite, because it is the Gram matrix of the restricted vectors in $L_2(P|_{X\setminus\{x_0\}})$. Its diagonal entries are $1-\alpha$. For $f\ne g$, the common sign at $x_0$ gives

$$
H_{fg}
=
\rho_P(f,g)-\alpha
\le
\eta-\alpha.
$$

Testing positive semidefiniteness on the all-ones vector,

$$
0
\le
\mathbf 1^\top H\mathbf 1
\le
m(1-\alpha)+m(m-1)(\eta-\alpha).
$$

Since $\eta<\alpha$, this implies

$$
m
\le
1+\frac{1-\alpha}{\alpha-\eta}.
$$

The claimed bound follows from $|\mathcal F|\le 2m$.

This is an elementary PSD/Plotkin-style bound; no external theorem is needed. The coding-theory analogy is with Plotkin's binary-code bound near relative distance $1/2$ [Plotkin 1960](https://doi.org/10.1109/TIT.1960.1057584), but the atom-weighted statement above is the exact local obstruction needed here.

### What The Lemma Does And Does Not Say

The lemma verifies the scratchpad's heavy-atom argument, with the quantitative refinement that the threshold is any $\eta<\alpha$, not only $\eta\le\alpha/2$. For hidden weak proper learning, this is decisive against pure orthogonality arguments. To rule out the target definition, a soundness proof cannot rely on knowing the learner's marginal-dependent advantage exponent; it normally has to make every non-preimage correlation nonpositive or smaller than every inverse polynomial. For a fixed countable $P$, that would eventually put all wrong-pair correlations below the constant $\alpha/2$. The lemma says that cannot happen for an unbounded proper family.

The statement is already in signed-label form. For $\{0,1\}$ labels, replace each label $b$ by $(-1)^b$ or $1-2b$; the weak-advantage condition is exactly the same up to the factor of two between advantage and correlation. If the proposed code asks for small absolute correlations, $|\rho_P(f,g)|\le\eta$, then the one-sided hypothesis $\rho_P(f,g)\le\eta$ holds, so the same obstruction applies.

Approximate correlations are only blocked below the heavy-atom scale. If $\eta=\alpha-1/q(s)$, the lemma only gives $|\mathcal F_s|=O(q(s))$. Such a family can be unbounded. But this regime is useless for the clean weak-proper lower bound: wrong concepts then have positive correlation close to the constant $\alpha$, hence are themselves legal weak handles for any inverse-polynomial advantage once they can be found. The lemma therefore blocks hidden-gap-safe approximate orthogonality, not every finite approximate code.

The lemma is information-theoretic, not algorithmic. It shows that positively correlated wrong proper hypotheses must exist somewhere in a large family. It does not show that a polynomial-time learner can find one from samples. This is the main remaining loophole for a finite-encoded counterexample: allow weak handles to exist, but prove that finding any such handle is computationally hard or that every findable handle still decodes the hard witness.

### Size-Conditioned Blocks

Conditioning on a length or size block can evade the numerical bound only by changing the marginal being analyzed. For example, under the uniform marginal on a length-$n$ cube, the largest atom is $2^{-n}$, and Hadamard parities can be exactly orthogonal. That is the valid one-length parity-image model.

It does not refute this edge. The target is marginal-nonuniform, so using a separate marginal $P_n$ for each length lets the running-time polynomial and weak advantage depend on $P_n$, hence on the challenge length. A reduction no longer obtains one uniform polynomial-time inverter.

Packing the blocks into one fixed mixture

$$
P^\star=\sum_n \mu_n P_n
$$

does not preserve the one-length argument. Same-length concepts that agree off their active block have global correlation at least $1-\mu_n$, so they are extremely good weak handles. If the off-block labels are made image-dependent to cancel this agreement, the construction is no longer merely a length-local Hadamard code; it is asking for one global low-correlation code under $P^\star$, and the heavy-atom lemma applies. If the off-block labels are made seed-dependent instead, an inversion reduction given only $y=f(s)$ cannot simulate the labeled examples.

### Atoms Tending To Zero

There is no loophole from tail atoms tending to zero. Every single countable probability distribution still has a largest atom $\alpha>0$, even if all sufficiently late atoms are tiny. The obstruction uses only that one atom.

What can tend to zero is the largest atom after conditioning on a moving tail event or a moving length block. That again means the orthogonality is conditional or length-specific. The global weak PAC guarantee under the original fixed $P$ is not conditional on that block, and any block of mass $\mu_n\to 0$ dilutes the error gap by $\mu_n$ unless the construction supplies global balancing labels. Supplying those labels in a finite-encoded countable model returns to the same global Gram obstruction.

### Impact On Dense One-Way/Hadamard Repairs

This branch blocks more than the exact pure-Hadamard dream, but less than every possible dense cryptographic repair.

It blocks any finite-encoded repair whose soundness claim is:

> for each target image, every wrong proper image-code hypothesis has $P$-correlation at most negligible, nonpositive, or below the hidden weak scale.

That claim implies a large family with all wrong-pair correlations below $\alpha/2$ for the fixed marginal, contradicting the lemma.

It also undercuts polynomial dense-code repairs that leave inverse-polynomial residual correlations. Such residual correlations are not small enough for a hidden-gap marginal-nonuniform lower bound: the target may choose a weaker inverse-polynomial advantage, and a wrong codeword with residual positive correlation then satisfies the target without inverting.

The lemma does **not** rule out a genuinely computational repair. A separation could still exist if the construction proves that every efficiently findable positively correlated wrong hypothesis solves a hard search problem, or if all efficiently findable weak handles can be converted into a preimage even though nonfindable handles exist. I did not find such a theorem in the checked PCP, one-way-function, or coding sources.

### Branch Conclusion

The heavy-atom Gram obstruction is valid and reusable. It rules out finite-encoded, one-fixed-marginal, pure low-correlation geometry for unbounded binary proper families, including the straightforward all-length Hadamard/one-way-image repair. It leaves the atlas edge unresolved because it is only an obstruction to a counterexample route, not an efficient proper selector theorem.

Branch verdict: `unresolved`.
