## Summary

The explorer correctly breaks the most direct residual-forcing attempts: high-loss weighting, mistake-set filtering, and simple agreement filtering do not turn “current excess over $c$” into a query where $c$ has error below $\gamma$.

The strongest surviving critique is that the explorer has not proved the broad residual-forcing strategy false. It has proved several important no-go tests and identified the right missing invariant: an observable query must concentrate on regions where the hidden comparator is already predictably cleaner than the ambient hard-band noise.

## Issue List

1. **Broad refutation is not proved.**  
   Classification: **plausible but incomplete**.  
   The report shows failure of natural residual queries, but not of all observable kernels using $X$, labels, current hypotheses, confidence, weak-call transcripts, or class structure. The conclusion “broad residual-forcing lemma looks false” is reasonable as a research judgment, not a theorem.

2. **Lemma 2 needs a formal information model.**  
   Classification: **missing assumption**.  
   “Posterior Bayes error of $c$” is ambiguous in distribution-free PAC with a fixed unknown comparator. Is this posterior over a random target prior, conditional label noise $\Pr[Y\ne c(X)\mid O]$, or algorithmic uncertainty about $c(X)$? These are different. The statement becomes almost tautological if interpreted as conditional $c$-error over cells, but then it does not itself prove that excess cannot create a good cell.

3. **Relabeling is under-specified.**  
   Classification: **missing assumption**.  
   For rejection queries with original labels, the relevant quantity is $\Pr[Y\ne c\mid \text{kept}]$. For relabeled queries, it is $\Pr[\widetilde Y\ne c\mid \text{kept}]$. Lemma 2 must quantify over allowed relabeling kernels and define posterior concentration relative to the new label, not just to $Y=c(X)$.

4. **RCN obstruction uses global correlation, but local buckets can defeat it.**  
   Classification: **plausible but incomplete**.  
   The agreement-filter formula is correct under independent random classification noise. But global $r=\mathbb E[Zf]=0$ does not rule out observable cells with high local correlation. A predictor could be positively correlated with $f$ on one visible region and negatively correlated on another, canceling globally. The obstruction needs a local condition: every allowable observable bucket has $r_B$ below the threshold.

5. **Loss-weight residual failure is sound but should include explicit parameters.**  
   Classification: **worth pursuing**.  
   The algebra is correct, but the lemma would be stronger with a concrete four-cell counterexample showing excess $\Delta\ge\epsilon$ while the residual query has $c$-error arbitrarily above $\gamma$.

6. **Descent remains a separate unsolved step.**  
   Classification: **fatal gap for a positive route, not for the critique**.  
   Even if an observable low-noise query is found, a weak hypothesis on that query may mimic a public label, overfit a spike, or improve only a negligible-mass region. The explorer correctly flags this, but any warm-start theorem must prove a potential decrease on the original distribution.

## Counterexamples Or Stress Tests

**Four-cell residual stress test.**  
Let $\gamma=0.1$, $\eta=0.2$, and choose cells by whether $c$ and current $g$ are correct:

- $A=\{c\text{ correct}, g\text{ wrong}\}$ has mass $0.05$.
- $B=\{c\text{ wrong}, g\text{ correct}\}$ has mass $0$.
- $C=\{c\text{ wrong}, g\text{ wrong}\}$ has mass $0.20$.
- $D=\{c\text{ correct}, g\text{ correct}\}$ has mass $0.75$.

Then $\operatorname{err}(c)=0.20$, $\operatorname{err}(g)=0.25$, so $g$ has excess $0.05$ over $c$. But on the mistake/loss residual $M=\{g\ne Y\}=A\cup C$,

$$
\operatorname{err}_{D|M}(c)=\frac{0.20}{0.25}=0.8>\gamma.
$$

So excess does not force the loss residual to be low-noise relative to $c$.

**RCN agreement threshold.**  
For $\eta=0.25$ and $\gamma=0.1$, the explorer’s threshold is

$$
r>\frac{\eta-\gamma}{\eta+\gamma-2\eta\gamma}
=\frac{0.15}{0.30}=0.5.
$$

At $r=0$, the current predictor has excess $1/2-\eta=0.25$ over $f$, but agreement/disagreement conditioning based only on $(Y,Z)$ leaves noise $\eta=0.25>\gamma$.

**Local-correlation cancellation.**  
Partition $X$ into two observable halves. Let $Z=f$ on one half and $Z=-f$ on the other. Globally $r=0$, but on the first half $r_B=1$, and agreement filtering creates a clean or nearly clean query. Thus any RCN no-go must bound local observable correlations, not merely global correlation.

**Public relabeling stress test.**  
If a wrapper creates query labels from a public hypothesis $g$, then the weak learner may return $g$ because the query has low $\operatorname{OPT}$ for public reasons. This can satisfy the weak guarantee while revealing no information about the hidden near-optimal comparator. This attacks the descent lemma, not just the forcing lemma.

## Literature Or Known-Result Conflicts

No direct conflict with the local literature map. The explorer’s conclusions are consistent with the recorded hard-band obstruction, the posterior/filtering warning L007, and the failure of direct KMV/Feldman or efficient correlation-boosting instantiations.

The main caution is rhetorical: this should not be recorded as a known lower bound against residual-free agnostic boosting. It is an in-run obstruction for a family of observable residual constructions.

## What Survives The Critique

The high-loss and mistake-set residual constructions are genuinely broken.

The RCN agreement-filter calculation is useful and should be kept as a warm-start threshold.

The forcing/descent split is important: low query noise alone is not enough unless the weak answer can be converted into original-risk improvement.

A warm-start theorem remains plausible: if an observable bucket has enough mass and local posterior cleanliness below $\gamma$, a weak call on that bucket may be useful.

## Recommended Next Checks

1. Formalize the allowed observable query kernel: inputs, access to $X,Y$, current randomized predictor, relabeling, rejection probability, and minimum query mass.

2. Prove a finite-partition no-go lemma: if every allowed cell/action has conditional $c$-error at least $\gamma$, then every mixture query also has $c$-error at least $\gamma$.

3. Upgrade the RCN obstruction from global $r$ to local $r_B$ over all observable buckets generated by a bounded transcript.

4. Separately test descent: assuming a bucket with local $r_B$ above threshold, can the weak output be combined with the current predictor to decrease original risk by inverse-polynomial mass?

5. Check whether da Cunha-style residual-free boosters already avoid this obstruction by enumerating hidden clean witnesses rather than forcing an observable residual.