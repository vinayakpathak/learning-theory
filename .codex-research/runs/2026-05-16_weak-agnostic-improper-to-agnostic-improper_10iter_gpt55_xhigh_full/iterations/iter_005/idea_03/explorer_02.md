## Summary

The hard-core-lemma route does not yet give a positive proof. The useful progress is a sharper diagnosis: excess over a comparator creates a **hidden** clean/noisy distinguisher, but a fixed-slack weak learner needs a **publicly sampleable** query where some near-optimal comparator has error below `gamma`.

The right hard-core object appears to be the public posterior clean/noise profile. If every public cell still has comparator-noise posterior at least `gamma`, then no public filtering/relabeling step can trigger the fixed weak learner, even if the current classifier is far above `OPT_C`.

## Concrete Progress

For labels in `{-1,+1}`, fix a comparator `c` and write `Z=c(X)Y`, so `Z=+1` means `c` is correct. For any classifier `h`,

$$
\operatorname{err}(h,Y)-\operatorname{err}(c,Y)
=
\mathbb E[1_{h\ne c} Z].
$$

Thus positive excess says the hidden set `{h != c}` is biased toward clean examples. But `{h != c}` is not public, and even on that hidden set the comparator noise is

$$
\Pr[Z=-1\mid h\ne c]
=
\frac12-\frac{\Delta}{2\Pr[h\ne c]},
\qquad
\Delta=\operatorname{err}(h)-\operatorname{err}(c).
$$

This is below `gamma` only if `Delta/Pr[h != c] > 1-2 gamma`. Small excess does not imply that.

A low-OPT chunk would help: if a public query `Q` satisfies `err_Q(c) <= gamma-kappa`, then `OPT_C(Q) <= gamma-kappa`, and the fixed source returns a hypothesis of error at most `1/2-kappa`. The missing step is public construction of such a query with `kappa >= 1/poly`.

## Claims Or Lemmas

**Lemma 1: Public-Posterior Hard-Core Characterization.**

Let `G` denote the public information allowed to define a query, and let

$$
\eta_G=\Pr[c(X)\ne Y\mid G].
$$

For any nonnegative `G`-measurable filter `W` and `G`-measurable sign relabeling `Y'=S Y`, `S in {+-1}`,

$$
\operatorname{err}_{W,S}(c)
=
\frac{\mathbb E\left[
W\left(\eta_G 1_{S=1}+(1-\eta_G)1_{S=-1}\right)
\right]}{\mathbb E[W]}.
$$

So, without relabeling, a low-noise public chunk exists exactly when the public posterior has a low `eta_G` tail. With relabeling, one also gets chunks from high `eta_G` tails by flipping labels. If `eta_G in [gamma,1-gamma]` on all public cells, no public filter/relabeling can make `c` a below-`gamma` witness.

**Lemma 2: Information Cost Of A Low-Noise Public Chunk.**

In a hidden-target model with global comparator noise `eta > gamma`, if a public accept event `A` of mass `mu` has

$$
\Pr[c(X)\ne Y\mid A]\le \gamma' < \eta,
$$

then

$$
I(S_c;G)\ge \mu\, \mathrm{kl}(\gamma'\|\eta),
\qquad S_c=1[c(X)\ne Y].
$$

This is just data processing plus the binary KL decomposition. It says a target-useful low-noise chunk requires public information about clean status.

## Proof Attempts

The standard hard-core/dense-model move tries to use positive excess to separate the clean component from the noisy component. The separating test obtained from the algebra is `1_{h != c}`, which depends on the hidden comparator. That is exactly the non-public object.

A minimax over public filters only succeeds if the public filter family already distinguishes the clean indicator. Otherwise the dual certificate is a hard core: the clean/noisy indicator is pseudorandom to public filters, and no low-`OPT` target-useful query appears.

Richer public filters do not automatically fix this. Spike, empirical, or artificial-relabeling queries may have low `OPT_C` for public reasons, but they need not carry useful mass about the near-optimal comparator.

## Gaps And Risks

The posterior lemmas are restricted-model diagnostics, not atlas separations. They depend on a formal notion of public information, mass/smoothness, and how oracle outputs are charged.

Low comparator noise implies low `OPT_C`, but low `OPT_C` need not imply low comparator noise; public constants, public relabelings, and other concepts remain separate cases.

The information lower bound can be weak for inverse-polynomial mass chunks. The stronger random-target/smooth-filter barriers from the notes are still needed for real lower-bound pressure.

## Counterexamples Or Obstructions

Flat-posterior RCN blocks the naive hard-core claim. Take `Y=f(X)N_eta` with `gamma < eta < 1/2`, and let the current public classifier `h` be independent of the hidden `f`. Then

$$
\operatorname{err}(f,Y)=\eta,\qquad \operatorname{err}(h,Y)=1/2,
$$

so the excess is `1/2-eta`, which can be larger than the target `epsilon`. But if the public transcript has not learned information about `f`, every target-preserving public filter still has comparator noise `eta > gamma`. No fixed-slack weak call is forced to be useful.

This is the hard-core obstruction in its cleanest form: the residual error is real, but it lives behind hidden clean-status information.

## Sources Consulted

Local run files: `problem.md`, `working_notes/canonical_summary.md`, `claim_ledger.md`, `lemma_bank.md`, `failed_attempts.md`, `counterexamples.md`, `literature_map.md`, `promising_directions.md`, `iteration_summaries.md`, and `iterations/iter_005/idea_03/idea.md`.

External background: Russell Impagliazzo, ["Hard-Core Distributions for Somewhat Hard Problems"](https://dblp.uni-trier.de/rec/conf/focs/Impagliazzo95.html); Adam Klivans and Rocco Servedio, ["Boosting and Hard-Core Sets"](https://www.cs.columbia.edu/~rocco/Public/focs99.pdf); da Cunha, Høgsgaard, and Paudice, ["Sample-Near-Optimal Agnostic Boosting with Improved Running Time"](https://arxiv.org/abs/2601.11265).

## Recommended Next Steps

Formalize Lemma 1 as a “public posterior hard-core lemma” with mass and relabeling variants.

Require any positive version of idea_03 to prove that excess creates a public posterior tail `eta_G <= gamma - poly(epsilon)`. Test it first against flat-posterior RCN.

For the barrier direction, combine this posterior lemma with the existing smooth public-filter information theorem and explicitly route public-witness, spike, empirical, and other-concept low-`OPT` queries.