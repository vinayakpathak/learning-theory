## Summary

The assigned public-filter idea has a clean oracle-lower-bound core. For random classification noise with rate `eta > gamma`, any target-preserving public filter lowers the conditional noise below `gamma` only if the filter’s label-asymmetric part already has nontrivial correlation with the hidden target `f`.

This gives a plausible restricted black-box barrier: a fixed-slack weak oracle can stay uninformative on all smooth public filters until the wrapper has already extracted target correlation by some other means. This is not an atlas separation, because it excludes point masses, empirical queries, arbitrary relabeling, and representation issues.

## Concrete Progress

Consider `Y=f(X)N`, where `N in {+-1}`, `Pr[N=-1]=eta`, and `eta > gamma = 1/2 - beta`.

A public target-preserving filter is a nonnegative weight
`W(x,y)`. The query distribution is the original noisy distribution reweighted by `W`, with labels still equal to `Y`.

Write

$$
W(x,y)=a(x)+b(x)y,\qquad
a(x)=\frac{W(x,+1)+W(x,-1)}2,\quad
b(x)=\frac{W(x,+1)-W(x,-1)}2.
$$

Then `|b| <= a`. Let

$$
A=\mathbb E[a(X)],\qquad B=\mathbb E[b(X)f(X)],\qquad r=B/A.
$$

The conditional noise of `f` under the filtered query is exactly

$$
\eta_W
=
\frac{\eta(A-B)}{A+(1-2\eta)B}
=
\frac{\eta(1-r)}{1+(1-2\eta)r}.
$$

Therefore

$$
\eta_W<\gamma
\quad\Longleftrightarrow\quad
r>
\tau_{\eta,\gamma}
:=
\frac{\eta-\gamma}{\eta+\gamma-2\eta\gamma}.
$$

This strictly generalizes the existing agreement-filter obstruction L007: for `W=1[Y=g(X)]`, one has `r=E[g f]`.

## Claims Or Lemmas

**Lemma 1, proved: exact public-filter threshold.**  
For every nonzero target-preserving filter `W`, lowering the noise below `gamma` is equivalent to producing normalized correlation

$$
\frac{\mathbb E[b(X)f(X)]}{\mathbb E[a(X)]}>\tau_{\eta,\gamma}.
$$

So a low-noise filter is not a free residual-forcing operation; it is already a weak predictor of `f` under the filter’s symmetric mass.

**Lemma 2, proved for fixed smooth filters against a random target.**  
Let `X=[N]` uniform and `f` be uniformly random in `{+-1}^N`. If a fixed filter satisfies `0 <= a(x) <= L` and `A=E[a] >= mu`, then

$$
\Pr_f[\eta_W<\gamma]
\le
\exp\left(-\Omega\left(\tau_{\eta,\gamma}^2\mu N/L\right)\right).
$$

Reason: `r=sum_i c_i f_i` with coefficients `c_i=b_i/(NA)` and

$$
\sum_i c_i^2 \le \frac{L}{NA}.
$$

Hoeffding gives the stated tail bound.

**Lemma 3, proved as an information reduction.**  
Let `T` be any transcript and let `W_T` be the filter selected from it. If for every fixed transcript value the independent-target success probability is at most `p`, then

$$
I(f;T)\ge \mathrm{kl}(\Pr[\eta_{W_T}<\gamma]\;\|\;p).
$$

Thus producing a low-noise smooth public filter with constant probability requires

$$
I(f;T)=\Omega(\tau_{\eta,\gamma}^2\mu N/L)
$$

in the random-target toy model.

**Candidate restricted oracle theorem, not proved as an atlas result.**  
In a finite-domain model where queries must be smooth target-preserving public filters, and the weak oracle returns only constants or public certificates unless a hidden low-noise filter is produced, any polynomial-query wrapper needs transcript information of order `Omega(mu N/L)` before it can force a useful weak call.

## Proof Attempts

The main proof route is now fairly sharp.

1. Algebraically reduce every public filter to its symmetric part `a` and label-asymmetric part `b`.

2. Show that the filtered noise depends on `f` only through `B=E[b f]`.

3. Convert `eta_W < gamma` into the threshold correlation condition `r > tau_{eta,gamma}`.

4. For random `f`, show fixed smooth filters almost never satisfy this condition.

5. For adaptive filters, use mutual information: if the actual transcript can select a successful filter much more often than an independent transcript, the transcript must already contain information about `f`.

The proof becomes an oracle lower bound only after adding an adversarial weak oracle policy. In hard-band queries with `OPT >= gamma`, the oracle can return a majority constant. If low `OPT` is caused by a public hypothesis or artificial public relabeling, it can return that public witness. Only hidden low-noise queries are dangerous, and Lemmas 1-3 say these require prior target information in the smooth-filter model.

## Gaps And Risks

The result is restricted. It does not handle arbitrary query distributions, point masses, empirical-support distributions, or arbitrary relabeling.

Conditional noise of the true `f` is not the same as `OPT_C`. Another concept `c in C` may fit the filtered query even when `f` does not. The lower-bound model needs a “public certificate” rule or a random-code/no-other-witness condition.

Majority constants can leak one bit per hard-band query. This is manageable in an information budget, but it must be included.

The random all-functions target model is not an efficiently represented concept-class separation. It is useful for a black-box barrier, not for resolving the atlas edge.

## Counterexamples Or Obstructions

Point-mass queries break any unrestricted statement. After seeing `(x,y)`, a wrapper can query the point mass at `x`; the query may have low noise but negligible global target mass.

Artificial relabeling also breaks broad formulations. If the wrapper labels by a public `g`, the query can have low `OPT` for public reasons, and a valid oracle can return `g` without revealing `f`.

Heavy-atom or small-support marginals defeat the smoothness intuition. If the target distribution has only polynomial support, memorized labels may generalize.

## Sources Consulted

- Local run files: `problem.md`, all listed `working_notes/*.md`, and `iterations/iter_002/idea_02/idea.md`.
- Michael J. Kearns, “Efficient Noise-Tolerant Learning from Statistical Queries,” JACM 1998: https://homepages.math.uic.edu/~lreyzin/papers/kearns98.pdf
- Avrim Blum, Merrick Furst, Jeffrey Jackson, Michael Kearns, Yishay Mansour, Steven Rudich, “Weakly Learning DNF and Characterizing Statistical Query Learning Using Fourier Analysis,” STOC 1994: https://research.duq.edu/mathcs/_jackson/dnfsq.pdf and https://doi.org/10.1145/195058.195147

## Recommended Next Steps

Record Lemma 1 as a new lemma-bank item. It is a clean strengthening of L007.

Next, formalize a restricted oracle model with parameters `(N, eta, gamma, mu, L, q, M)` and an explicit minimal-information oracle policy.

Then prove the adaptive information lower bound with samples included: ordinary noisy samples contribute at most about `M(1-H_2(eta))` bits about a random target, plus the controlled leakage from majority-constant oracle answers.