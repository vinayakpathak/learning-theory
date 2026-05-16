# Counterexamples And Obstructions

## O001: Flat-Region Obstruction

When a queried distribution has $\rho_C(Q)\le 2\beta$, the fixed-slack weak
guarantee does not force any positive correlation. This blocks residual-based
boosting arguments unless they can manufacture a query with constant-scale
correlation.

## O002: Sample Visibility Of Epsilon-Mass Needles

Any lower bound hiding the relevant improvement on a set of mass
`Theta(epsilon)` must confront the fact that the target learner may draw
`poly(1/epsilon)` labeled samples. Such a set is not information-theoretically
invisible at the allowed sample scale.

## O003: Too-Small Needles Do Not Matter

If the hidden region has mass `o(epsilon)`, then failing to learn it contributes
only `o(epsilon)` to error and cannot by itself refute an `OPT + epsilon`
agnostic learner.

## O004: Improper Output Obstruction To Hidden-Concept Lower Bounds

Hiding the identity of the best concept is insufficient. The target learner may
output any binary predictor, so lower bounds must rule out regression,
averaging, validation, or other improper predictors that exploit the same
sample information without identifying a member of `C`.

## O005: Adaptive Reweighting Obstruction

A hidden-signal construction must be stable under all reweightings available to
the proposed booster. Otherwise the algorithm may concentrate on a region where
the hidden concept becomes high-correlation and escapes the fixed-slack flat
region.
