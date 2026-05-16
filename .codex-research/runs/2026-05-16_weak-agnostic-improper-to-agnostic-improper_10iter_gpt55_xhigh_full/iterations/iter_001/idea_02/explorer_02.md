## Summary

I found a plausible **black-box oracle barrier**, not an atlas-level counterexample. The strongest version is: in the hard band $\gamma \le \eta < 1/2$, an adversarial fixed-slack weak oracle can legally return no useful signal unless the wrapper has already constructed a genuinely low-noise query distribution. That low-noise query seems to require prior information about the hidden comparator or hidden clean component.

This does **not** refute the implication, because a real learner may use representation-specific structure or inspect the code of the weak learner.

## Concrete Progress

Set $\beta = 1/2-\gamma$ and choose $\eta \in (\gamma,1/2)$ with target $\varepsilon < (1-2\eta)/4$.

For random classification noise around a hidden comparator $f$,

$$
Y = f(X)N,\qquad \Pr[N=-1]=\eta,
$$

the target distribution has $\operatorname{OPT}_C=\eta$, so the weak oracle may be silent. But strong agnostic learning to $\eta+\varepsilon$ requires

$$
\operatorname{err}_X(h,f) \le \frac{\varepsilon}{1-2\eta}.
$$

Thus, for constant $\eta<1/2$, the strong learner must substantially recover $f$.

A valid adversarial weak oracle can behave as follows:

- If a query $Q$ has $\operatorname{OPT}_C(Q)\ge\gamma$, return a majority constant. This is valid and gives no comparator information.
- If $Q$ is concentrated on observed examples, return a memorizer or Bayes classifier on that support and arbitrary/random behavior elsewhere. Improperness makes this valid, but it does not generalize.
- Only if the wrapper constructs a broad query with $\operatorname{OPT}_C(Q)<\gamma$ is the oracle forced to reveal useful global information.

## Claims Or Lemmas

**Hard-Band Silence Lemma.**  
If $\operatorname{OPT}_C(Q)\ge\gamma$, then a majority constant hypothesis satisfies the fixed-slack weak guarantee.

**RCN Recovery Lemma.**  
For $Y=f(X)N$ with noise rate $\eta<1/2$,

$$
\operatorname{err}_D(h,Y)=\eta+(1-2\eta)\operatorname{err}_X(h,f).
$$

So achieving $\operatorname{OPT}_C(D)+\varepsilon=\eta+\varepsilon$ forces recovery of $f$ to error $\varepsilon/(1-2\eta)$.

**Candidate Smooth-Query Barrier.**  
For a random-code class $C=\{f_s\}$ and hidden $f_s$, any adaptive query distribution with large effective support and no prior correlation with $f_s$ should still satisfy $\operatorname{OPT}_C(Q)\ge\gamma$ with high probability. Proving this likely needs a concentration/union-bound argument over adaptive transcripts.

**Candidate Spike-Query Uselessness Lemma.**  
If a low-noise query is supported on only polynomially many observed points, an improper oracle can answer with a hypothesis that is correct only there and random elsewhere. Under a huge uniform target domain, such answers add negligible global correlation with $f_s$.

## Proof Attempts

For the hard-band lemma, write $\rho^*(Q)=\sup_{c\in C}\mathbb E[c(X)Y]$. The weak guarantee is

$$
\mathbb E[hY]\ge \rho^*(Q)-(1-2\gamma).
$$

If $\operatorname{OPT}_C(Q)\ge\gamma$, then $\rho^*(Q)\le 1-2\gamma$, so the right side is nonpositive. A majority constant has nonnegative correlation with $Y$, hence is valid.

For the hidden-comparator construction, use a random or pseudorandom family of balanced functions over a very large domain. Samples from $D_f^\eta$ reveal $f$ only on seen points, and with no repeats they give no global information. Broad reweightings remain in the noise band $\eta\ge\gamma$ unless the algorithm already has correlation with $f$.

The clean-component view is equivalent: $D=(1-2\eta)D_{\mathrm{clean}}+2\eta D_{\mathrm{bal}}$. To make $\operatorname{OPT}<\gamma$, a wrapper must enrich clean mass above $1-2\gamma$. Filters based only on uncorrelated predictors cannot do this.

## Gaps And Risks

The barrier needs a precise black-box model: what query distributions may the wrapper submit, and how are oracle hypotheses represented/evaluated?

The random-code construction is not an efficient source-positive concept class. It supports an oracle lower bound, not a true separation.

Adaptive concentration over query distributions is still unproved. The proof must handle queries depending on previous oracle answers.

A representation-aware learner might bypass the oracle barrier entirely by exploiting structure in $C$ or the code of $A$.

## Counterexamples Or Obstructions

A naive “wait for a clean weak-learner sample” route fails: if the weak learner needs $m_A$ examples, the chance all are from the clean component is roughly $(1-2\eta)^{m_A}$, exponential when $m_A$ grows.

A public hidden subset is not hard enough; the learner can condition on it. The clean component must be latent, as in random classification noise, or pseudorandomly hidden.

Taking $C$ to be all functions is too rich: empirical queries always have $\operatorname{OPT}=0$. A random-code-style class is better because broad unrelated labelings are not fit well, while small-support overfitting remains non-generalizing.

## Sources Consulted

No web search used.

Local files consulted: `problem.md`, `iterations/iter_001/idea_02/idea.md`, `iterations/iter_001/solver_attempt.md`, `inputs/efficient-weak-agnostic-improper-pac-implies-efficient-agnos.md`, `inputs/agnostic-boosting-open.md`, and the requested working notes.

## Recommended Next Steps

Formalize the black-box wrapper model and prove the smooth-query/spike-query dichotomy for a random-code oracle.

Then test whether any real class can instantiate the same gap: efficient weak learning below noise $\gamma$, but hard learning under noise $\eta>\gamma$. Current notes suggest parity/LPN, PRF, code, and halfspace routes all fail one side of that requirement.