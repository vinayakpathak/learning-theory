## Summary

The idea succeeds as a **black-box counterexample to free range regularization**: fixed-slack `OPT + beta` validity alone does not imply any useful bound on `Range(A)`, `VC(Range(A))`, `VC*(Range(A))`, stability, or compression of the supplied weak learner.

The cleanest construction is a “holdout-gated junk” transformation. Even for the trivial concept class of constants, one can build a valid weak learner whose outputs contain arbitrary high-complexity behavior on a query-small region. This does **not** separate weak from strong agnostic learning, because the underlying class may be strongly learnable by ignoring the pathological learner. It only blocks reductions that need to derive controlled range/capacity from an arbitrary source learner `A`.

## Concrete Progress

Let `C={-1,+1}` over a domain

$$
X = R \times \{\pm 1\}^d,
$$

where `R` is a large tag set. Fix `beta>0`, say leave margin `alpha=beta/4`.

Construct learner `A^junk`:

1. Split the query sample into a baseline part and a holdout part.
2. Use the baseline part to learn the better constant to excess at most `alpha`.
3. Choose a tag `r in R` and a junk function `phi` on `{+-1}^d`, for example a coordinate projection `z_i`.
4. If the holdout sample contains no point with tag `r`, output

   $$
   h(r',z)=
   \begin{cases}
   \phi(z), & r'=r,\\
   h_0(r',z), & r'\ne r,
   \end{cases}
   $$

   otherwise output the clean baseline `h_0`.

For any fixed query distribution `Q`, conditional on the chosen tag `r`, if `Q[tag=r] > alpha`, the holdout misses that tag with probability at most `exp(-alpha m)`. Thus, with high probability, whenever junk is inserted its query mass is at most `alpha`, so the error only increases by `alpha`.

Therefore `A^junk` remains an efficient `OPT_C + beta` weak learner.

But its range contains, for a fixed tag `r`, the coordinate functions

$$
z \mapsto z_1,\dots,z_d
$$

on the `r`-block. Hence the dual class can shatter `d` hypotheses using points indexed by all sign patterns in `{+-1}^d`. So

$$
VC^*(Range(A^junk)) \ge d.
$$

If instead the junk family contains arbitrary labelings of a polynomial-size set inside the tag block, then the primal VC dimension of the range is polynomially large as well.

## Claims Or Lemmas

**Lemma 1: Holdout-Gated Junk Preserves Weak Validity.**  
If `A_0` is an `OPT_C + beta/2` learner and `A^junk` modifies `A_0` only on a holdout-certified region of query mass at most `beta/2`, then `A^junk` is an `OPT_C + beta` learner.

**Lemma 2: Fixed-Slack Validity Does Not Bound Output Capacity.**  
There exist efficient valid weak learners for even trivial classes whose output range has arbitrarily large primal VC or dual VC, limited only by the allowed polynomial output description size.

**Lemma 3: Query Validation Cannot Canonicalize Off-Query Behavior.**  
Behavior on a region of zero or tiny mass under the current query distribution is statistically invisible to that query’s samples. Any canonicalizer that overwrites such behavior is adding an extra convention, not deriving it from the weak guarantee.

## Proof Attempts

The main proof is the holdout argument above. It is robust because it does not rely on knowing `Q`; it validates only the realized tag chosen for junk insertion.

The attempted stronger claim would be:

> Such junk defeats every generic wrapper.

That is not proved and is probably false as stated. A wrapper using only a polynomial list of complete final classifiers plus fresh validation may ignore global `Range(A)`. Also, for the constants class, a wrapper can simply ignore `A^junk` and learn the better constant directly.

So the valid conclusion is narrower: this construction refutes “free regularization of the supplied source learner,” not the atlas implication.

## Gaps And Risks

This is not a class separation. The same class can have a perfectly controlled learner.

The construction attacks black-box reductions that are handed an arbitrary learner `A`. It does not rule out proving the implication by first constructing a new controlled weak learner from the class representation.

If a proof only needs realized adaptive calls plus fresh query samples, global `Range(A)` may be irrelevant. The obstruction matters specifically for DCHP-style uses of `H=Range(A)`, `VC(H)`, `VC*(H)`, or exhaustive final vote search.

A white-box wrapper might syntactically strip the junk if the transformation is transparent. A formal impossibility would need an oracle or obfuscation-style model.

## Counterexamples Or Obstructions

The strongest obstruction found is:

> Even for `C={constants}`, a valid weak learner can have high-capacity irrelevant output behavior on query-small blocks.

This blocks any claim that controlled range, compression, stability, or dual-VC bounds follow from the semantic `OPT+beta` guarantee alone.

A useful stress test: point-exception junk gives large primal VC but only logarithmic dual VC. To force large dual VC, use tag-block coordinate projections rather than singleton memorization.

Counterexample to overclaiming: because constants are strongly learnable, this pathology cannot be used as a negative example for the atlas edge itself.

## Sources Consulted

No web search used. Consulted the required project-local files, especially:

- `problem.md`
- `working_notes/canonical_summary.md`
- `working_notes/claim_ledger.md`
- `working_notes/lemma_bank.md`
- `working_notes/failed_attempts.md`
- `working_notes/counterexamples.md`
- `working_notes/literature_map.md`
- `working_notes/promising_directions.md`
- `working_notes/iteration_summaries.md`
- `iterations/iter_007/idea_02/idea.md`

## Recommended Next Steps

Formalize the holdout-gated junk lemma as a restricted “no-free-regularization” result.

Then test it directly against the exact DCHP assumptions: identify whether their proof needs `Range(A)` over all possible outputs, high-probability outputs, or only realized bags. That distinction determines how much damage the construction actually does.

A useful next explorer lens would be an oracle-model version: define wrappers that access `A` only through samples and evaluation of returned hypotheses, then prove they cannot distinguish useful off-support behavior from junk without extra assumptions.