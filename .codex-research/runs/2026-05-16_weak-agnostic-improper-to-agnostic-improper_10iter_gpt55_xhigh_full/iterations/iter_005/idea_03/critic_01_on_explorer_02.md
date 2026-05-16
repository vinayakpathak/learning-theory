## Summary

The explorer’s main diagnosis is sound: excess over a comparator identifies a hidden clean/noisy distinguisher, not automatically a public weak-learner query. The strongest surviving piece is the public-posterior lemma, which is essentially the existing L019 obstruction with a relabeling variant.

No positive hard-core low-`OPT` chunk lemma is established. The report is best treated as a useful obstruction memo, not as progress toward a fully polynomial booster.

## Issue List

1. **False claim / missing condition:**  
   The summary says if every public cell has comparator-noise posterior at least `gamma`, then no public filtering/relabeling can trigger the weak learner. With relabeling allowed, this is false. A cell with posterior `eta_G > 1-gamma` can be label-flipped so that `c` has error below `gamma`. The correct invariant is:
   $$
   \eta_G \in [\gamma,1-\gamma]
   $$
   on all public cells, or equivalently `min(eta_G,1-eta_G) >= gamma`.

2. **Plausible but incomplete:**  
   Lemma 1 is basically correct once `G` contains all variables used by the filter/relabeling and the query grammar is fixed. But it proves only that no public transformation makes this comparator `c` a low-noise witness. It does not rule out low `OPT_C` for public constants, artificial relabelings, empirical/spike queries, or other concepts.

3. **Missing assumption:**  
   Lemma 2 needs `A` to be `G`-measurable, `S_c=1[c(X)\ne Y]` to have marginal `eta`, and `G` to be a per-example public sigma-field. Then
   $$
   I(S_c;G)=\mathbb E_G \operatorname{kl}(\eta_G\|\eta)
   $$
   and convexity gives the claimed lower bound for a low-noise public event. Without these quantifiers, the statement can be misread as a transcript-level lower bound, which it is not.

4. **Fatal gap for the positive route:**  
   Finding a public query with `err_Q(c) <= gamma-kappa` only forces the weak learner to output something with query-label error at most `1/2-kappa`. It does not by itself show how to update the final classifier, obtain clean-conditional accuracy, or reduce original excess. A full booster/potential argument is still missing.

5. **Plausible but incomplete:**  
   The flat-posterior RCN stress test is directionally right, but it needs balance/smoothness assumptions. If `h` is merely “independent of hidden `f`,” then `err(h,Y)=1/2` requires `err(h,f)=1/2`. Also, public filters over a finite random target can have accidental correlation unless one imposes smoothness or works with high-probability random-target bounds.

6. **Unsupported citation:**  
   Impagliazzo and Klivans-Servedio support the general hard-core/boosting analogy, not the public-posterior lemmas here. The da Cunha-Høgsgaard-Paudice paper supports the near-miss boosting context, but not this proposed public-filter decomposition.

## Counterexamples Or Stress Tests

- **Relabeling high-noise cells:** If a public cell has `eta_G=0.95` and `gamma=0.1`, flipping labels gives comparator error `0.05`. So “posterior at least `gamma`” is not enough.

- **Weak edge not comparator edge:** On a query where `c` has error `gamma-kappa`, a weak output with error `1/2-kappa` can still be poorly correlated with `c` if its advantage concentrates on the noisy part. Triggering the weak learner is not yet a usable boosting step.

- **Public low-OPT loopholes:** The posterior obstruction says nothing about queries with low `OPT_C` because a public constant or public relabeling already witnesses them. This is exactly the O012/O004 issue from the ledger.

## Literature Or Known-Result Conflicts

No direct conflict found. The issue is overreach. Impagliazzo’s hard-core lemma and Klivans-Servedio’s boosting/hard-core connection concern hardness amplification and boosting distributions, not agnostic public-posterior query construction. The 2026 da Cunha-Høgsgaard-Paudice result is explicitly polynomial in sample size with other parameters fixed, matching the run’s existing “near miss, not atlas proof” status.

## What Survives The Critique

- The algebra
  $$
  \operatorname{err}(h,Y)-\operatorname{err}(c,Y)
  =\mathbb E[1_{h\ne c}cY]
  $$
  is correct and useful.

- Lemma 1 survives after replacing “at least `gamma`” by `eta_G in [gamma,1-gamma]` when relabeling is allowed.

- Lemma 2 survives as a per-example information diagnostic, not as a full oracle lower bound.

- The main conceptual takeaway survives: excess can live behind hidden clean-status information, so a public hard-core lemma must prove a public posterior tail, not just hidden separability.

## Recommended Next Checks

1. Restate Lemma 1 with exact query grammar and the invariant `min(eta_G,1-eta_G) >= gamma`.

2. Add a separate lemma proving when query-label advantage from the weak learner produces a useful update toward the original objective.

3. Test the proposed minimax/hard-core step against flat-posterior RCN with smooth filters and explicit transcript information budget.

4. Route low-`OPT` queries into cases: hidden-target, public-witness, empirical/spike, artificial relabeling, and other-concept witness.