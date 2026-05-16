## Verdict

SOLVED: no

Best progress: the problem reduces cleanly to generating usable low-noise “clean” weak-learner calls from a medium-noise agnostic distribution. I do not see a polynomial construction or a valid separation from the current notes.

## Candidate Solution Or Main Attempt

Write labels in $\{\pm1\}$ and set $\beta=1/2-\gamma$. The source guarantee is

$$
\operatorname{corr}(h,Y)\ge \rho_C(D)-(1-2\gamma),
\qquad
\rho_C(D)=\sup_{c\in C}\mathbb E[c(X)Y].
$$

So the weak learner is forced to give positive correlation only when $\operatorname{OPT}_C(D)<\gamma$.

The main positive attempt is to take an optimal comparator $c^\star$ with error $\eta$, decompose the distribution into a clean part of mass $1-2\eta$ where labels equal $c^\star$, and use the weak learner on that clean part. If a polynomial-time booster could produce a polynomial menu of candidate samplers containing such a clean call, then the fixed-slack weak learner would become useful.

The attempt fails at the clean-witness step: the clean component is hidden. A random weak-learner training batch of size $m_A$ lands entirely in the clean component with probability roughly $(1-2\eta)^{m_A}$, which is exponential in the weak learner’s sample complexity in the representation-uniform setting.

## Concrete Lemmas Or Reductions

**Correlation equivalence.** For $\{\pm1\}$ labels,

$$
\operatorname{err}(h)\le \operatorname{OPT}_C+\beta
$$

is equivalent to

$$
\mathbb E[hY]\ge \sup_{c\in C}\mathbb E[cY]-2\beta.
$$

Thus the fixed-additive source is an additive constant approximation to best correlation, not a tunable weak-correlation oracle.

**Clean-mixture lemma.** If $c$ has error $\eta\le 1/2$ under $D$, then

$$
D=(1-2\eta)D_{\mathrm{clean}}+2\eta D_{\mathrm{bal}},
$$

where $D_{\mathrm{clean}}$ is supported on examples labeled by $c$, and $c$ has error exactly $1/2$ on $D_{\mathrm{bal}}$. This shows that strong agnostic learning is morally about extracting the clean mass $1-2\eta$.

**Posterior-filter obstruction.** In homogeneous noise $Y=F(X)N$ with noise rate $\eta>\gamma$, suppose a current predictor $Z$ has correlation $r=\mathbb E[ZF]$. Conditioning on the event $Y=Z$ gives conditional noise

$$
\frac{\eta(1-r)}{1+r(1-2\eta)}.
$$

This is below $\gamma$ only if

$$
r>\frac{\eta-\gamma}{\eta+\gamma-2\eta\gamma}.
$$

So simple filtering cannot create a low-noise weak call unless the algorithm already has nontrivial comparator information.

**Conditional separation recipe.** A false edge would follow from a class $C$ with two properties: efficient distribution-free weak decoding whenever $\operatorname{OPT}_C<\tau$, but hardness of learning to $\eta+\varepsilon$ under random classification noise for some $\eta>\tau$. Under random noise,

$$
\operatorname{err}(h,Y)=\eta+(1-2\eta)\operatorname{err}(h,c^\star),
$$

so a strong agnostic learner would recover $c^\star$ to error $O(\varepsilon/(1-2\eta))$. The missing piece is an actual class satisfying the low-noise source while retaining moderate-noise hardness.

## Gaps And Failure Points

The clean-mixture decomposition is nonconstructive because it depends on $c^\star$ and hidden clean/noisy membership.

A hypothesis weakly good on a clean slice may be bad on the balanced residual, so one still needs a certified way to combine or localize its contribution.

The conditional separation recipe is only a template. Parity/LPN-style classes fail because low constant-noise learning is already hard; halfspace-style routes also fail the fixed-additive source.

## Counterexamples Or Obstructions

The hard band is

$$
\gamma \le \operatorname{OPT}_C(D) \le 1/2-\varepsilon.
$$

Above $1/2-\varepsilon$, random or constant prediction is enough. Below $\gamma$, the source is at least informative. In the band, the source may legally return a useless hypothesis on the original distribution.

The posterior threshold above is a concrete obstruction to “filter until clean” arguments: filtering by agreement only lowers noise after the algorithm already has correlation with the hidden comparator.

## Promising Ideas To Explore

Search for code-like classes with efficient low-radius weak weighted decoding but hard moderate-noise approximate decoding.

Look for extra assumptions on $A$ that make clean witnesses polynomial: SQ implementation, small sample compression, stability, or constant weak sample size.

Try to formalize a non-black-box use of the weak learner’s code; pure oracle access appears too weak in the medium-noise band.

## Notes For Critics

The lemmas above are elementary and should be checked independently, especially the quantifiers in the conditional separation recipe.

Nothing here proves the edge false. The obstruction is black-box and clean-witness based; a representation-specific positive proof could still bypass it.