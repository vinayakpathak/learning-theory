## Summary

The information-theoretic version of `idea_02` is promising as a restricted public-filter barrier. I got a clean algebraic identity and a plausible formal lemma:

A target-preserving public filter can reduce RCN noise from `eta` below the weak threshold `gamma` only if the filter already contains a public soft predictor with nontrivial correlation with the hidden comparator. In a random-comparator model, producing such a filter with inverse-polynomial target mass requires mutual information about the comparator on the order of that mass times the domain size.

This is still an oracle/toy-model barrier, not an atlas separation.

## Concrete Progress

Work in the RCN model on `[N]`:

$$
Y = F(X)\xi,\qquad \Pr[\xi=-1]=\eta,\qquad \gamma<\eta<1/2,
$$

with hidden random comparator `F in {+-1}^N`.

Let a transcript `T` choose a public filter

$$
W_T(x,y)\in[0,1]
$$

that reweights target examples but does not relabel them. Define

$$
a_+(x)=W_T(x,+1),\quad a_-(x)=W_T(x,-1),
$$

$$
c(x)=a_+(x)+a_-(x),\quad d(x)=a_+(x)-a_-(x),
$$

$$
S=\frac1N\sum_x c(x),\qquad
R=\frac{1}{NS}\sum_x F(x)d(x).
$$

Then the conditional noise after filtering is exactly

$$
\eta_W
=
\Pr[\xi=-1\mid \text{accepted}]
=
\frac{\eta(1-R)}{1+(1-2\eta)R}.
$$

Therefore

$$
\eta_W<\gamma
\quad\Longleftrightarrow\quad
R>
\tau(\eta,\gamma)
:=
\frac{\eta-\gamma}{\eta+\gamma-2\eta\gamma}.
$$

This strictly generalizes the agreement-filter calculation `W=1[Y=Z(X)]`, where `R=E[ZF]`.

## Claims Or Lemmas

**Lemma 1: Soft Public-Filter Identity.**  
The formula above is proved algebraically for every target-preserving filter `W_T`.

**Lemma 2: Mutual-Information Public-Filter Barrier.**  
Let `B=I(F;T)` in nats. Suppose the filter has target acceptance probability at least `alpha` and conditional noise below `gamma`. Then, in the random-comparator model,

$$
\Pr[\text{such a filter exists at transcript }T]
\le
\frac{4(B+\ln 2)}{\tau(\eta,\gamma)^2\alpha N}.
$$

So a constant-probability inverse-polynomial-mass low-noise public filter forces

$$
I(F;T)=\Omega(\tau^2\alpha N).
$$

For `alpha >= 1/poly` and `N` much larger than the transcript information budget, public filtering cannot cross the fixed weak threshold.

**Lemma 3: Information Accounting.**  
`M` ordinary RCN samples leak at most

$$
M(\ln 2-h(\eta))
$$

nats about `F`, plus whatever information is contained in oracle responses. If dummy oracle answers leak only `O(1)` bits each, then polynomial samples and polynomial dummy calls do not suffice to build a broad low-noise public filter on a sufficiently large random domain.

## Proof Attempts

The proof of Lemma 2 uses a change-of-measure argument.

Under an independent coupling where `F` is independent of `T`, for any fixed smooth filter with mass at least `alpha`, the quantity

$$
R=\sum_x \mu_T(x)m_T(x)F(x)
$$

is a weighted Rademacher average with weights bounded by `O(1/(alpha N))`. Hoeffding gives

$$
\Pr[R\ge\tau]\le \exp(-\tau^2\alpha N/4).
$$

The true joint law of `(F,T)` differs from the independent coupling by KL divergence `I(F;T)`. The standard binary event KL inequality transfers the small independent probability to

$$
p\le 4(B+\ln2)/(\tau^2\alpha N).
$$

This handles adaptivity because `T` can be the entire prior transcript.

## Gaps And Risks

This only covers target-preserving public filters. Artificial relabeling queries are outside the lemma.

The model is random-code/all-functions-like, so it is not an efficient represented class separation.

If oracle hypotheses encode many hidden bits in their representation, that information is charged in `I(F;T)`. A lower bound must explicitly bound oracle-output leakage.

The bound weakens when `eta-gamma` is tiny because `tau` goes to zero.

## Counterexamples Or Obstructions

Point-mass and empirical-support queries evade the theorem by having tiny target mass or huge smoothness.

Public relabeling can create `OPT=0` for a known public witness, without revealing `F`.

Heavy-atom target distributions defeat the large-domain intuition: memorized samples may cover real mass.

Structured classes are not covered; adaptive majority/sign responses can act like statistical queries.

## Sources Consulted

No web search used.

Local sources: `problem.md`, assigned `iterations/iter_002/idea_02/idea.md`, all requested `working_notes/*.md`, and prior `iterations/iter_001/idea_02` explorer/critic reports.

## Recommended Next Steps

Record Lemma 1 as a clean generalization of the agreement-filter obstruction.

State a restricted oracle theorem with parameters `N, M, q, alpha, eta, gamma` and an explicit oracle-output information budget.

Classify weak-oracle queries into target-preserving filters, public relabelings, and spiky/empirical queries; only the first is controlled by this lemma.