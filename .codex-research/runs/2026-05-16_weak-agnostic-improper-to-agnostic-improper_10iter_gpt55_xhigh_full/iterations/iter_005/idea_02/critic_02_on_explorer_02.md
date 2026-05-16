## Summary

The explorer found a useful restricted obstruction, but it should be recorded as a **proper-oracle, single-call support-function lemma**, not as a generic critique of the atlas implication. The main fatal gap is that the atlas source is **improper**: it may return arbitrary binary hypotheses, while the cap-separation criterion is stated only over `C`.

The Anchor Lock-In Lemma itself is algebraically sound under valid-query and proper-output assumptions. The broader “anchor doping cannot generically refine fixed slack” verdict is worth pursuing as a black-box obstruction, but needs a precise oracle game.

## Issue List

- **Fatal gap / false for atlas source: improper outputs.**  
  The criterion
  $$
  \sigma_C(z)-\sigma_{C_{\mathrm{bad}}(\epsilon)}(z)>\alpha
  $$
  only forces a **proper** response from `C` to be target-good. The source learner may output any binary hypothesis. A target-bad improper `h` can be legal even when every near-optimal concept in `C` is target-good.

- **Missing assumption: allowed query directions.**  
  The “support-function oracle” view is valid only for signed directions induced by sampleable query distributions, with bounded conditional label means and fixed normalization. Additive slack is not homogeneous, so arbitrary scaling or convex-geometric reweighting is not automatically implementable.

- **Plausible but incomplete: single-call criterion vs adaptive reductions.**  
  The cap-separation condition is exact for one proper weak call. To rule out anchor-doping algorithms, one needs a global adversarial oracle strategy for all adaptive queries the wrapper may ask, not just the line segment `z_lambda`.

- **False as a PAC-learning obstruction: validation may help.**  
  “Validation cannot help if the oracle never emits the good vertex” is true only for reductions whose candidate list comes from oracle outputs. For an explicit two-concept class, empirical validation over both concepts gives strong agnostic learning immediately.

- **Missing technical assumptions: suprema and strict gaps.**  
  The “iff” needs finite/compact `C`, or approximate maximizers and margin slack. If the bad-cap support supremum is not attained, “some target-bad concept is legal” needs an approximation argument.

- **Unsupported heuristic: finite differences of approximate support values.**  
  The value-refinement obstruction is plausible, but the weak learner is not a value oracle, and validation can estimate returned hypotheses’ original risks. A lower bound needs a formal transcript/oracle model.

## Counterexamples Or Stress Tests

- **Improper-output stress test.**  
  Let `X={1,2}` uniform and `C={c_+}` with `c_+=(+,+)`. Original target direction is `a=(1,1)`, so `OPT_C=0`. For query direction `z=(1,0)`, the bad set inside `C` is empty, so the `C`-cap criterion is vacuous. But the improper hypothesis `h=(+,-)` has the same `z` value as `c_+` and target value `0`, hence is target-bad for any `epsilon<1/2`. It is a legal weak output even with zero slack.

- **Two-vertex anchor lock-in.**  
  The explorer’s example with `C={c_good,c_bad}`, anchor favoring `c_bad`, and target gap `2epsilon < Delta <= alpha` correctly breaks line-segment homotopy. But if both vertices are explicit and evaluable, strong learning is trivial by validation. So this is a black-box candidate-generation obstruction, not a class separation.

- **Reweighting stress test.**  
  Any proposed escape by “amplifying” the target perturbation must show the resulting direction is a valid sampleable label distribution. Otherwise it hides an illegal rescaling of the correlation objective.

## Literature Or Known-Result Conflicts

No direct external citation conflict appears, since the explorer used only local files.

The report is consistent with the hard-band obstruction `C002`, but it conflicts with prior run cautions if promoted too far: `O013` warns that improper output ranges are uncontrolled, `C019/L005` show finite-list validation can remove final selection issues, and `C026/L022` rule out finite-domain toy examples as improper PAC separations.

## What Survives The Critique

The following is worth recording:

For finite or compact `C`, a **proper** single-call support oracle at valid direction `z` forces every legal concept output to be `epsilon`-target-good iff
$$
\sigma_C(z)-\sigma_{C_{\mathrm{bad}}(\epsilon)}(z)>\alpha.
$$

The Anchor Lock-In Lemma also survives: if a target-bad `c0` remains within `alpha` of optimal along every allowed anchor mixture, an adversarial proper oracle may keep returning it.

The diagnostic quantity
$$
M_{\mathcal Q}(\epsilon)=\sup_{z\in\mathcal Q}
(\sigma_C(z)-\sigma_{C_{\mathrm{bad}}(\epsilon)}(z))
$$
is useful, provided `\mathcal Q` is the actual allowed query family and the statement is labeled as a restricted black-box obstruction.

## Recommended Next Checks

1. Formalize query directions as normalized signed measures induced by sampleable distributions.

2. Split the result into a proper-oracle lemma and an improper-output caveat. For the improper case, replace `C_bad` by a bad set over the possible output class, or explicitly restrict the oracle.

3. Prove a multi-query version only after defining an adversarial oracle game and showing a single legal bad-response strategy across all adaptive queries.

4. Test whether anchors generated by earlier weak calls can create an `alpha`-separation without already encoding strong target information.

5. Record this as **worth pursuing**, not as an atlas-level theorem or separation.