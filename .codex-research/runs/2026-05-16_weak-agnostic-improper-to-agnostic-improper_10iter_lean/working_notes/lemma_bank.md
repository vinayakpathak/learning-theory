# Lemma Bank

## L001: Error-Correlation Translation

For signed labels $Y\in\{\pm1\}$ and binary concepts $c:X\to\{\pm1\}$,
$$
\operatorname{err}_D(c)=\frac{1-\mathbb E[c(X)Y]}{2}.
$$
Therefore
$$
\operatorname{OPT}_C(D)=\frac{1-\rho_C(D)}{2},
\qquad
\rho_C(D)=\sup_{c\in C}\mathbb E[c(X)Y].
$$

## L002: Fixed-Slack Flat Region

Let a weak agnostic learner satisfy
$$
\operatorname{err}_D(h)\le \operatorname{OPT}_C(D)+\beta.
$$
In correlation form this is
$$
\mathbb E[hY]\ge \rho_C(D)-2\beta.
$$
Consequently, in any query distribution with $\rho_C(D)\le 2\beta$, an
uninformative zero-correlation answer is valid whenever the oracle model permits
such an answer. In the original error notation, if $\beta=1/2-\gamma$, then
`OPT_C(D) >= gamma` permits error `1/2`.

Use: formal obstruction to residual boosting with fixed additive slack.

Qualification: for deterministic binary hypotheses, existence of an exactly
zero-correlation dummy is not automatic for every distribution; the lemma should
be stated in terms of the admissibility inequality or with randomized/rich
dummy outputs.

## L003: Needed Residual-Amplification Primitive

Candidate lemma, currently open/refuted in simple forms: if a current predictor
has excess error more than $\epsilon$, produce in polynomial time a distribution
or finite list of distributions on which some $c\in C$ has correlation exceeding
`2 beta + poly(epsilon)`, so a fixed-slack weak learner must return useful
information.

Known obstruction: simple reweighting does not by itself amplify arbitrarily
small residual correlations past the fixed constant threshold.
