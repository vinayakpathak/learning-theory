## Summary

The explorer’s core local claim is essentially correct: for a fixed public finite partition, arbitrary public filtering and sign relabeling can only lower comparator error by selecting a cell whose comparator posterior is already low or high. Positive excess of `g` over `c` does not force such a cell.

The report should not be read as a weak-to-strong lower bound. It is a one-step public-residual obstruction, mostly a finite-cell version of the existing public-posterior lemma L019/C023. Its main value is diagnostic: residual-forcing proofs need an assumption that creates low posterior cells, not just excess risk.

## Issue List

1. **Missing assumption: comparator error is not `OPT_C`.**  
   The minimax calculation is about the fixed comparator `c`. A weak call is triggered by `OPT_C` on the constructed query. If constants, complements, public hypotheses, or other concepts in `C` fit the relabeled query, then `OPT_C` may be low even though comparator error is above `gamma`. The explorer notes this, but any oracle-barrier use needs an explicit singleton/no-other-witness/public-certificate routing assumption.

2. **Plausible but incomplete: fixed public partition.**  
   The lemma is valid only relative to the current public sigma-field/cell partition. An algorithm that later creates a refined public feature correlated with `c` can break the flat-posterior invariant. So the result does not rule out adaptive strategies that first manufacture lower-posterior cells.

3. **Minor imprecision: `a_i` should be a conditional probability unless cells are refined.**  
   The identity
   $$
   \operatorname{err}(g)-\operatorname{err}(c)=\sum_i p_i(a_i-\eta_i)
   $$
   is exact with `a_i = Pr[g(X) != Y | i]`. It is an indicator only after refining the partition by `(Y,g(X))`. This is repairable and not fatal.

4. **Plausible but incomplete: arbitrary concentration ignores mass/sampleability.**  
   The minimax value `min_i min{eta_i,1-eta_i}` assumes filters can concentrate on any positive-mass cell. That is fine for a pure information obstruction when all cells are bad, but a realistic residual model should track minimum mass, smoothness, and sampling cost.

5. **Worth pursuing, but not new as stated.**  
   The cleanest statement is the existing public-posterior obstruction in finite form:
   $$
   \inf_{W,S}\frac{E[W(\eta_G 1_{S=1}+(1-\eta_G)1_{S=-1})]}{E[W]}
   =
   \operatorname{ess\,inf}\min\{\eta_G,1-\eta_G\}.
   $$
   This is worth recording, but should be linked to L019/C023 rather than presented as an independent route.

## Counterexamples Or Stress Tests

- **Public-witness stress test:** let `C` contain constants. Filtering on `Y=+1` can make a constant concept achieve `OPT_C=0`, even if the hidden comparator posterior remains `eta > gamma`. The weak oracle may legally return the public constant, giving no useful information about `c`.

- **Hidden-refinement stress test:** one public cell may have posterior `eta=0.2`, but internally contain a subregion with posterior `0` and another with higher posterior. The finite-cell lemma blocks only filters measurable with respect to the coarse public partition; it says nothing once the transcript learns the subregion.

- **Flat-posterior counterexample survives.**  
  The explorer’s construction with all observable cells having `eta_i=0.2` and `err(g)=0.3` is consistent with deterministic `g,c` under stochastic labels. It correctly refutes “excess implies low-noise observable residual” for `gamma<0.2`.

## Literature Or Known-Result Conflicts

No direct conflict. The result is aligned with the ledger’s L019/C023 public-posterior filtering lower bound and with the four-cell obstruction O010.

No unsupported external citation issue appears; the explorer used no web or paper citations. The main citation hygiene point is internal: classify this as an in-run finite/sigma-field lemma, not as a known boosting lower bound.

## What Survives The Critique

The minimax lemma survives after replacing indicator `a_i` by conditional mistake rate or explicitly refining by `(Y,g(X))`.

The flat-posterior family is a valid counterexample to one-step public residual forcing from excess alone.

The useful takeaway is sharp: residual methods need a mechanism that changes the public posterior of `c` on some cell. Excess risk by itself is too weak.

## Recommended Next Checks

1. Rewrite the lemma in sigma-field form using conditional posterior  
   `eta_G = Pr[c(X) != Y | G]`, with `G` the current public transcript.

2. State explicitly that the query class is limited to `G`-measurable weights `W >= 0` and sign relabelings `S in {+-1}`.

3. Add a warning that translating comparator-error lower bounds into weak-oracle silence requires singleton/no-other-witness or public-certificate routing assumptions.

4. If pursuing a positive variant, add structural constraints linking `Pr[g != Y | i]` and `eta_i`; without such constraints the LP is already solved negatively by the flat-posterior example.