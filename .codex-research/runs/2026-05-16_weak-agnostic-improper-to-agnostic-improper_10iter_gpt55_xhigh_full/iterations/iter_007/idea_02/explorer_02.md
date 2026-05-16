## Summary

Through the oracle-model lens, idea_02 gives a real obstruction to deriving controlled `Range(A)`, VC, dual VC, stability, or compression from the fixed-slack weak guarantee alone.

The cleanest progress is a “rare-slice junk” construction: even for the trivial class of constants, one can build an efficient improper `OPT+beta` learner whose outputs encode arbitrary sample-dependent payloads on regions of tiny query mass. The weak guarantee is preserved, but the semantic output range can have arbitrarily large dual VC, and a variant gives large primal VC. This does not separate weak from strong learning, because constants are strongly learnable. It does refute any proof step that treats range control as a consequence of weak correctness.

## Concrete Progress

Consider domain points `(k,z)` with key `k in {0,1}^ell` and payload coordinate vector `z in {+-1}^D`. Let `C={+1,-1}` be the constant concepts.

A learner `A_junk`:

1. Uses samples to choose an empirical best constant `b`.
2. Draws a random key `R in {0,1}^ell`.
3. Encodes a sample-dependent payload index `i in [D]`.
4. Outputs
   $$
   h_{b,R,i}(k,z)=
   \begin{cases}
   z_i,& k=R,\\
   b,& k\ne R.
   \end{cases}
   $$

For any query distribution `Q`, if `mu_R = Q[k=R]`, then  
`E_R mu_R <= 2^{-ell}`. Hence
$$
Pr[mu_R>\tau]\le \frac{2^{-\ell}}{\tau}.
$$
Taking `ell >= log_2(2/(tau delta))`, with probability at least `1-delta/2` the junk slice has mass at most `tau`. If the empirical constant is within `alpha` of the best constant and `alpha+tau <= beta`, then
$$
err_Q(h_{b,R,i}) \le OPT_C(Q)+beta.
$$

So the learner is a valid fixed-slack improper weak learner.

But for a fixed key `R`, the range contains the functions `h_i(k,z)=z_i` on the slice `k=R`. The dual class shatters `{h_1,...,h_D}`: for every subset `S subseteq [D]`, choose `z^S_i=+1` iff `i in S`. Then evaluation at `(R,z^S)` realizes exactly `S`. Thus
$$
VC^*(Range(A_junk)) \ge D.
$$

A table-payload variant, where the hypothesis stores arbitrary labels on `D` slice points, gives primal `VC >= D` at the cost of a `D`-bit payload.

## Claims Or Lemmas

**Lemma 1: Rare-slice junk preserves fixed-slack weak learning.**  
If a valid weak output is modified only on a set of query marginal mass at most `tau`, its error increases by at most `tau`. A random key from a sufficiently large key space gives such a low-mass set with high probability for every fixed query distribution.

**Lemma 2: Range/dual-VC control is not implied by weak correctness.**  
The construction above is an efficient `OPT+beta` learner for constants, yet its semantic output range has dual VC at least `D`, where `D` is an arbitrary payload parameter within the learner’s runtime/output budget.

**Lemma 3: Validation cannot distinguish validation-irrelevant junk.**  
Fresh validation under the same distribution sees the rare slice with probability proportional to its mass. Payload variants with different `i` or different tables are therefore risk-indistinguishable unless validation or evaluation deliberately hits the rare key.

**Oracle-model version.**  
An ideal weak oracle can take any legal answer `g` and return a decorated answer equal to `g` on the current query distribution except on a fresh zero-mass or tiny-mass slice, where it encodes arbitrary payload. This preserves oracle legality while making global `Range(A)` pathological.

## Proof Attempts

The construction proves a limited no-free-regularization statement:

- It does prove: the atlas source guarantee alone gives no semantic capacity bound on the particular weak learner supplied as an oracle/subroutine.
- It does prove: DCHP-style assumptions on `H=Range(A)`, `VC(H)`, or `VC^*(H)` are genuine extra assumptions, not hidden consequences of `OPT+beta`.
- It does not prove: the atlas implication is false.
- It does not prove: the same class lacks another clean weak learner.

The oracle interpretation is strongest if returned hypotheses are black-box evaluation handles. Then a wrapper cannot parse away the payload; it can only discover it by evaluation, and polynomially many evaluations need not hit the rare key.

With explicit white-box hypothesis descriptions, the construction still inflates `Range(A)`, but a wrapper tailored to this learner could strip the junk. A general impossibility would need either obfuscation/representation assumptions or a formal black-box-handle model.

## Gaps And Risks

The construction uses a trivial class, so it is only a regularization obstruction, not a learning separation.

A positive proof of the atlas edge might avoid this by choosing or constructing a different controlled weak learner for the same class.

If the final boosting proof can quotient hypotheses by behavior on relevant query distributions, global VC inflation on rare slices may be harmless. That would require a distribution-dependent replacement for the DCHP global range assumptions.

The black-box oracle model must specify what a returned hypothesis handle reveals. If the handle exposes the key and payload as syntax, information-leakage accounting changes completely.

## Counterexamples Or Obstructions

This gives a concrete obstruction to any claim of the form:

> Every efficient fixed-slack weak learner can be assumed to have controlled range/dual VC after harmless preprocessing.

Not true without extra interface or regularity assumptions.

It also stress-tests validation-based pruning: all payload variants can have essentially identical noisy validation risk, so validation can select a good final classifier but cannot certify a small global `Range(A)`.

## Sources Consulted

No web sources consulted.

Local run files read: `problem.md`, `working_notes/canonical_summary.md`, `working_notes/claim_ledger.md`, `working_notes/lemma_bank.md`, `working_notes/failed_attempts.md`, `working_notes/counterexamples.md`, `working_notes/literature_map.md`, `working_notes/promising_directions.md`, `working_notes/iteration_summaries.md`, and `iterations/iter_007/idea_02/idea.md`.

## Recommended Next Steps

Formalize this as a restricted lemma: `RareSliceJunkLearner(beta,D,tau)` with exact sample, confidence, runtime, and VC/dual-VC parameters.

Then split the intended conclusion into three separate statements:

1. No semantic range bound follows from weak correctness.
2. No black-box-handle canonicalizer can remove invisible payloads.
3. This is not an atlas separation unless paired with a class where every useful weak oracle must be used black-box.

The most useful follow-up is to test whether the DCHP route can be rewritten using only behavior on the realized query distributions, avoiding global `Range(A)` and ignoring rare-slice junk.