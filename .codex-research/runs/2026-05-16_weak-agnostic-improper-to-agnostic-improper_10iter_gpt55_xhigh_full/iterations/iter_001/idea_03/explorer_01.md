## Summary

The compression idea gives a clean conditional positive theorem, but only after tightening the condition. The right theorem is not “$k=O(\log \operatorname{poly}(1/\epsilon))$ implies efficient boosting” by naive enumeration; that gives quasi-polynomial time. A genuinely atlas-efficient conclusion follows if the weak learner has a polynomial-size clean-witness menu, with constant-size compression as the simplest sufficient case, plus manageable final vote selection.

The key observation is that the atlas source exactly fits the fixed-slack agnostic weak learner used by recent da Cunha et al. boosting work: in $\{\pm1\}$ labels,
\[
\operatorname{corr}(h,Y)\ge \sup_{c\in C}\operatorname{corr}(c,Y)-2\beta,
\]
so it is their weak learner with $\gamma_0=1$, $\epsilon_0=2\beta$, and boosting advantage
\[
\theta=(\gamma_0-\epsilon_0)/2=1/2-\beta.
\]

## Concrete Progress

A conditional theorem is available by plugging the atlas weak learner into the da Cunha-Hogsgaard-Paudice 2026 enumeration-based agnostic booster.

Let $H$ be the output/range class of the weak learner, with VC dimension $d$, dual VC dimension $d^*$, and efficient evaluation. Their algorithm builds a candidate menu by running the weak learner on all $m_0$-tuples from half of the sample, then validates signs of averages of
\[
T=O(\min\{d^*,\log n\}/\theta^2)
\]
candidate hypotheses. Their bound gives excess
\[
O\left(\sqrt{\operatorname{OPT}\frac{dT\log n+\log(1/\delta)}{n}}
+\frac{dT\log n+\log(1/\delta)}{n}\right),
\]
so $n=\widetilde O((dT+\log(1/\delta))/\epsilon^2)$ is enough for agnostic PAC accuracy.

Runtime is the bottleneck. Without compression, the candidate-generation cost is roughly $n^{m_0}$ and the final search is roughly $n^{O(m_0T)}$. With a compression/decompression scheme of size $k$, the same proof can replace $m_0$ by $k$ in the clean-witness enumeration, giving runtime of the form
\[
\operatorname{poly}(n,s)\cdot (n^k|\Sigma|)^{O(T)}
\]
where $\Sigma$ is side information.

Thus a simple sufficient condition for an atlas-efficient theorem, for fixed $\beta<1/2$, is:

- $k=O(1)$ clean compression, with polynomially many side-information strings;
- $d=\operatorname{poly}(s)$ for sample complexity;
- $T=O(1)$, for example $d^*=O(1)$, or a separate polynomial-time selector for the final vote;
- polynomial evaluation/decompression for generated hypotheses.

## Claims Or Lemmas

**Claim 1: atlas fixed-additive weak learning matches the da Cunha weak-oracle definition.**  
Proved. Setting $\gamma_0=1$ and $\epsilon_0=2\beta$ gives nontrivial advantage exactly when $\beta<1/2$.

**Claim 2: compression replaces weak-sample enumeration.**  
Conditional but straightforward. Suppose every output $A(S,r)$ on an $m_0$-sample can be represented as $\operatorname{Dec}(T,\sigma)$ where $T$ is a subsequence of at most $k$ training examples and $\sigma\in\Sigma$. For any clean finite distribution $D'$ supported on examples correctly labeled by a comparator $f\in C$, the weak guarantee implies there exists some compressed representation $(T,\sigma)$ with $T\subseteq S_f$ whose decoded hypothesis has error at most $1/2-\theta$ on $D'$. Enumerating all compressed representations from the observed sample therefore supplies the weak hypotheses needed in every simulated boosting round.

**Claim 3: logarithmic compression is not enough for polynomial time by enumeration.**  
Proved as an accounting obstruction. If $n=\operatorname{poly}(s,1/\epsilon)$ and $k=\Theta(\log(s/\epsilon))$, then $n^k=\exp(\Theta(\log^2(s/\epsilon)))$, not polynomial.

## Proof Attempts

The positive proof route is:

1. Fix a near-optimal comparator $f\in C$.
2. Let $D_f$ be the conditional distribution of $D$ on clean examples, where $Y=f(X)$.
3. For any final hypothesis $v$,
   \[
   \operatorname{err}_D(v)\le \operatorname{err}_D(f)
   +\Pr[Y=f(X)]\operatorname{err}_{D_f}(v).
   \]
4. On distributions supported on clean examples, the agnostic weak learner becomes a realizable weak learner with advantage $\theta=1/2-\beta$.
5. Compression enumeration supplies the weak hypotheses needed to simulate AdaBoost on the hidden clean sample.
6. A vote over the generated menu has low clean-slice error, hence low original excess error.
7. Held-out validation selects a near-best vote from the generated vote class.

This is a real proof template, but the polynomial-time conclusion depends on the enumeration and final selection being polynomial.

## Gaps And Risks

The idea file’s `k=O(log poly(1/epsilon))` condition is too weak for atlas efficiency under exhaustive enumeration.

Validation of individual weak hypotheses is not enough. A hypothesis useful on the hidden clean slice can look mediocre on the original noisy distribution. The validation step must select final votes/combinations, as in the da Cunha-style proof.

The output class $H$ matters. If $d^*$ grows with representation size, the final vote search has exponent depending on $d^*$ unless one assumes an additional polynomial-time selector.

If $\beta$ is treated as a parameter rather than a fixed constant, the known black-box runtime has exponents depending on $1/(1/2-\beta)^2$, so it is not automatically polynomial jointly in that parameter.

## Counterexamples Or Obstructions

Randomly sampling compressed subsets does not obviously replace enumeration. The simulated AdaBoost distributions are supported on the hidden clean sample and can concentrate on regions whose clean mass is tiny under any observable reweighting. Without knowing the comparator, a random tuple sampler may miss the needed clean tuple with exponentially small probability.

A bare sample-compression statement is also insufficient unless there is an efficient decompressor and a polynomially enumerable side-information set.

## Sources Consulted

Local: `problem.md`, assigned `idea_03/idea.md`, run working notes, and atlas notes on `agnostic-boosting-open`.

External:
- da Cunha, Hogsgaard, Paudice, “Sample-Near-Optimal Agnostic Boosting with Improved Running Time” (ALT 2026), https://arxiv.org/abs/2601.11265
- da Cunha, Hogsgaard, Paudice, Sun, “Revisiting Agnostic Boosting”, https://arxiv.org/abs/2503.09384
- Ghai and Singh, “Sample-Optimal Agnostic Boosting with Unlabeled Data”, https://proceedings.mlr.press/v267/ghai25a.html
- Kalai, Mansour, Verbin, “On Agnostic Boosting and Parity Learning”, https://doi.org/10.1145/1374376.1374466
- Feldman, “Distribution-Specific Agnostic Boosting”, https://arxiv.org/abs/0909.2927

## Recommended Next Steps

Formalize the strongest useful conditional theorem as “polynomial-size clean-witness menu” rather than “small compression” alone.

Then split into two subcases: constant-size compression gives a clean atlas-efficient theorem under small $d^*$ or selector assumptions; logarithmic compression gives only quasi-polynomial evidence unless a non-enumerative clean-witness sampler is found.