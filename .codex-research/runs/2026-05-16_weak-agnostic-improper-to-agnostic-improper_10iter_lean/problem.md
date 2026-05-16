# Fixed-Slack Weak Agnostic Improper PAC to Strong Agnostic Improper PAC

## Atlas Edge

Attack the open implication

$$
\text{Efficient Weak Agnostic Improper PAC Learning}
\Rightarrow
\text{Efficient Agnostic Improper PAC Learning}.
$$

In atlas IDs this is:

- source: `efficient-weak-agnostic-improper-pac`
- target: `efficient-agnostic-improper-pac`
- implication note: `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-agnostic-improper-pac.md`
- shared argument note: `atlas/arguments/agnostic-boosting-open.md`

## Source Guarantee

There is one distribution-free efficient learner `A` which, for every joint distribution
`D` over `X x {0,1}`, returns an arbitrary binary hypothesis `h` with

$$
\operatorname{err}_{D}(h)
\le
\operatorname{OPT}_{C}(D) + \beta
$$

for one fixed additive tolerance `beta < 1/2`. Runtime and sample complexity are
polynomial in the representation size, `log(1/delta)`, and in `1/(1/2-beta)` if
the weak tolerance is parameterized. The tolerance is fixed; it is not an
accuracy parameter that the learner may tune down to `epsilon`.

Equivalently, with labels in `{+-1}` and `beta = 1/2 - gamma`, the source gives a
fixed-slack correlation oracle:

$$
\operatorname{corr}(h,Y)
\ge
\sup_{c \in C} \operatorname{corr}(c,Y) - 2\beta .
$$

It is forced to return a hypothesis with nontrivial positive correlation only
when the queried distribution has `OPT_C < gamma`.

## Target Guarantee

Construct, refute, or conditionally characterize an efficient distribution-free
learner `B` which, for every `epsilon > 0`, returns an arbitrary binary
hypothesis `h` with

$$
\operatorname{err}_{D}(h)
\le
\operatorname{OPT}_{C}(D) + \epsilon
$$

in time and samples polynomial in the representation size, `1/epsilon`, and
`log(1/delta)`.

## Known State To Start From

The edge is currently marked `open`. Existing agnostic boosting results are close
but not enough under the atlas efficient-PAC interpretation:

- Accuracy-sensitive or tunable-slack boosters can drive the excess error to
  `epsilon`, but the atlas source supplies only one fixed additive slack.
- Fixed-slack residual-free boosters appear to accept the source semantically,
  but their generic implementation pays weak-sample or capacity parameters in
  the exponent. This is fixed-parameter/statistical evidence, not a
  representation-uniform polynomial-time proof.
- Halfspace, parity/LPN, code, CSP, PRF, and public-handle templates have so far
  failed to provide a separation: either the fixed-additive weak source is
  already hard, or the strong improper target becomes plausible via validation,
  voting, or public handles.

## Research Goals For This Run

Use 10 iterations to make real progress on one of the following:

1. A fully polynomial positive route, especially a clean-witness generation,
   hitting-set, compression, hard-core, or residual-forcing lemma that replaces
   exhaustive clean-subset enumeration.
2. A conditional theorem identifying an additional natural hypothesis under
   which the edge becomes true.
3. A serious negative route: a represented class with distribution-free
   `OPT + beta` weak improper learning for a fixed constant `beta < 1/2`, but
   hard `OPT + epsilon` improper learning under some distribution.
4. A sharper obstruction showing why one tempting positive or negative route
   cannot work.

Maintain a claim ledger. Do not promote a plausible route to a theorem unless
the proof is complete. If no solution is found, leave a useful final memo:
state the best candidate lemmas, the strongest failed attempts, and the next
most valuable experiment or literature check.
