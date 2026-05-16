## Summary

The ghost-sample idea gives a clean *analysis lemma*, but not yet an algorithmic proof of the atlas implication. If a bag or final list is generated independently of a hidden clean ghost sample, then ordinary finite-class or VC uniform convergence transfers ghost-clean empirical performance to population performance on $D_c^+$. The obstruction is that DCHP-style generation usually proves empirical success on the same hidden clean sample used to choose the weak-call transcript, not on an independent ghost sample. Making the ghost sample usable appears to require either a population-valid clean generator, a stability/compression theorem, or exponential hidden-mask discovery.

## Concrete Progress

A useful decomposition is:

1. Draw a generation sample $S^{gen}$ from $D$ and generate a bag $B$ or final class $V(B)$ using only $S^{gen}$, weak-learner randomness, and public randomness.
2. Draw an independent ghost raw sample $S^{gh}$ from $D$.
3. For a fixed near-optimal comparator $c$, let
   $$
   S^{gh,+}=\{(X_i,Y_i)\in S^{gh}:Y_i=c(X_i)\}.
   $$
   Conditional on its size, $S^{gh,+}$ is iid from $D_c^+$ and independent of $B$.
4. If $V(B)$ contains a classifier with small empirical error on $S^{gh,+}$, then finite-class transfer proves existence of a classifier with small population error on $D_c^+$.

This isolates the missing step: prove that the generated bag has a good classifier on an independent hidden clean sample, without observing the ghost clean mask.

## Claims Or Lemmas

**Ghost Transfer Lemma.** Fix $c$ and let $P=D_c^+$. Let $T$ be any generation transcript independent of $m$ iid examples $Z_1,\dots,Z_m\sim P$. Let $V_T$ be a finite class fixed by $T$, with $|V_T|\le N$. Then with probability at least $1-\delta$ over the ghost sample,

$$
\forall v\in V_T,\quad
|\operatorname{err}_P(v,c)-\widehat{\operatorname{err}}_{gh}(v,c)|
\le
\sqrt{\frac{\log(2N/\delta)}{2m}}.
$$

Thus if some $v\in V_T$ has ghost-clean empirical error at most $\alpha$, then some $v\in V_T$ has population clean error at most $\alpha+\xi$ for $m=O((\log N+\log(1/\delta))/\xi^2)$.

**Raw Ghost Sample Version.** If the ghost sample is raw from $D$, and $p=\Pr[Y=c(X)]$, then $M=O((m+\log(1/\delta))/p)$ raw ghost examples give at least $m$ clean ghost examples with high probability. Since the interesting case has $p\ge 1/2$ up to endpoint handling, raw sample size is not the main obstruction.

**Mask-Discovery Cost.** If a procedure must explicitly find or certify $m$ all-clean ghost positions by mask-neutral guessing, then in the hidden-mask model the success probability of a menu of $L$ candidate subsets is at most $L p^m$. For $m=\Theta((\log N+\log(1/\delta))/\epsilon^2)$ and constant $p<1$, polynomial $L$ is insufficient. This is the exponential step.

## Proof Attempts

**Attempt 1: Pure ghost certification.** Generate $B$ from $S^{gen}$, keep $S^{gh,+}$ only for analysis, and apply the Ghost Transfer Lemma. This works only after proving that $V(B)$ has low empirical error on $S^{gh,+}$. Standard clean boosting gives low empirical error on the training clean sample used to build the transcript, not on an independent ghost sample.

**Attempt 2: Use generation clean success plus independence.** One might hope that if $V(B)$ fits $S^{gen,+}$, then it also fits $S^{gh,+}$. This is false without capacity, stability, compression, or independence from $S^{gen,+}$. A generated singleton classifier can memorize $S^{gen,+}$ and behave randomly off-sample.

**Attempt 3: Select using the ghost sample.** If the algorithm could evaluate clean error on $S^{gh,+}$, it could choose a good bag or vote and then transfer to population. But $S^{gh,+}$ is hidden. Enumerating candidate clean masks reintroduces the $p^{-m}$ or $2^m$ cost, where $m$ must scale like $1/\epsilon^2$ for certification.

## Gaps And Risks

The ghost sample solves only the statistical dependence problem after a ghost-good final class is already fixed. It does not explain how to produce or identify such a class.

The exact requirements for this route are strong:

- $B$ or $V(B)$ must be independent of the ghost examples, including their $X$ values.
- The final class must be polynomial-size, or there must be an efficient selector with its own generalization proof.
- Empirical clean success on the generation sample must transfer by some separate mechanism: VC/dual-VC, compression, stability, or population weak calls.
- If the ghost sample is used algorithmically, the clean mask must be discovered or bypassed; naive discovery is exponential.

## Counterexamples Or Obstructions

The memorizing-bag obstruction applies directly: a bag generated from hidden clean training data can fit that data perfectly and still have clean-population error near $1/2$.

The hidden-mask anti-hitting obstruction applies to algorithmic ghost selection. If clean positions are not publicly biased or certified, then finding a ghost clean certificate of size $m$ costs about $p^{-m}$.

The final sparse-majority selector remains separate. Even if ghost transfer proves some vote in $\operatorname{sign}(B^{(T)})$ is good, efficient selection over that class is not supplied by the ghost argument.

## Sources Consulted

No web search was used. I consulted the assigned local run files: `problem.md`, `working_notes/canonical_summary.md`, `working_notes/claim_ledger.md`, `working_notes/lemma_bank.md`, `working_notes/failed_attempts.md`, `working_notes/counterexamples.md`, `working_notes/literature_map.md`, `working_notes/promising_directions.md`, `working_notes/iteration_summaries.md`, and `iterations/iter_010/idea_01/idea.md`.

## Recommended Next Steps

Formalize the Ghost Transfer Lemma as a conditional positive primitive, but label it analysis-only.

Then try one of two sharper follow-ups:

1. Prove a stability/compression condition under which generation-sample clean success implies ghost-clean success.
2. Prove an explicit hidden-mask lower bound showing that any ghost-based selector without posterior-biased clean information needs $\exp(\Omega(1/\epsilon^2))$ mask search.

The most valuable proof-strategy refinement is to separate these two statements cleanly: ghost independence gives transfer, but mask discovery or stability must supply the missing empirical ghost guarantee.