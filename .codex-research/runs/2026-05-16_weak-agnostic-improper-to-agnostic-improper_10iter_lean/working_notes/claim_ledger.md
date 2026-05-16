# Claim Ledger

## C001: Fixed-Slack Weak Access Is Locally Vacuous

- Status: accepted
- Source: iteration 1 solver/explorer/critic
- Claim: For signed labels and
  $\rho_C(D)=\sup_{c\in C}\mathbb E[c(X)Y]$, an `OPT + beta` weak agnostic
  learner only guarantees
  $$
  \mathbb E[hY]\ge \rho_C(D)-2\beta.
  $$
  Thus if $\rho_C(D)\le 2\beta$, a zero-correlation response is admissible in
  an oracle model allowing such dummy hypotheses. Equivalently, with
  $\beta=1/2-\gamma$, when `OPT_C(D) >= gamma`, the weak guarantee permits a
  random-level hypothesis.
- Dependencies: correlation/error identity; convention on whether dummy
  randomized or deterministic hypotheses are allowed.
- Notes: The deterministic binary case needs a precise dummy-output model; the
  admissibility condition is the inequality above, not literal zero correlation.

## C002: Naive Black-Box Agnostic Boosting Has an Additive Floor

- Status: accepted as obstruction, not a theorem about all algorithms
- Source: iteration 1 solver and critic
- Claim: Any proof that treats the source learner only as an additive
  correlation-optimization oracle inherits a floor at scale `2 beta`. Such a
  proof cannot by itself extract arbitrary `epsilon`-scale residual advantages.
- Dependencies: black-box oracle access; no additional residual-amplification
  lemma.
- Notes: This does not refute non-black-box conversions using representation,
  samples, or internal structure of the source learner.

## C003: Pure Weak-Oracle Barrier

- Status: plausible candidate theorem
- Source: idea_01 explorer and critic
- Claim: In a restricted model where the algorithm only observes weak-oracle
  replies, if all adaptive queries remain in the flat region
  $\rho_C(Q)\le 2\beta$, an adversarial valid oracle can return uninformative
  replies and the transcript need not contain `epsilon`-scale information.
- Dependencies: exact oracle model; admissible dummy hypotheses; no labeled
  sample access or other information channels.
- Notes: Likely useful as a formal limitation on generic reductions, but too
  weak to settle the atlas edge.

## C004: Black-Box Barrier Implies Represented PAC Separation

- Status: refuted / overclaim
- Source: iteration 1 critic
- Claim: A lower bound against adversarial valid weak-oracle transcripts would
  separate efficient weak agnostic improper PAC learning from efficient strong
  agnostic improper PAC learning.
- Reason Rejected: The atlas edge concerns represented classes with a single
  efficient distribution-free learner. A PAC learner may use labeled samples,
  the class representation, validation, or a non-black-box use of the weak
  learner. Transcript indistinguishability of one oracle interface is
  insufficient.

## C005: Multiplicative Or Scale-Sensitive Weak Correlation Would Likely Boost

- Status: conjectural / literature-dependent
- Source: iteration 1 solver
- Claim: If the source learner gave a multiplicative correlation guarantee,
  e.g. $\operatorname{corr}(h,Y)\ge \kappa \rho_C(D)$ whenever
  $\rho_C(D)>0$, then standard agnostic boosting or online convex optimization
  should yield strong agnostic improper learning with polynomial
  `1/epsilon` dependence.
- Dependencies: known agnostic boosting theorems; parameter audit needed.
- Notes: This is stronger than the atlas source assumption and should not be
  used as progress on the edge without checking exact literature hypotheses.
