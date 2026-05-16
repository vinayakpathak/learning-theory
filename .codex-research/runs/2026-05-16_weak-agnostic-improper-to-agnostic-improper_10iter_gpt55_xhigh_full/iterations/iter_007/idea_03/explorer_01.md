## Summary

I found no passing candidate construction. The closest explicit candidate is log-arity signed XOR / Max-k-LIN with `k = ceil(log n)`: it has a superpolynomial descriptor domain and a plausible strong-side noisy-prediction hardness story, but its weak side is already a low-noise noisy-parity/LPN-type task. That makes it a bad separation candidate.

The main progress is a sharper construction checklist: ordinary approximation algorithms only help before the descriptor domain is made succinct; after succinctization, either table learning returns, or the weak approximator becomes the missing hard object.

## Concrete Progress

Candidate tested:

Let `k = ceil(log n)`, `X = [n]^k`, and for each assignment `sigma in {+-1}^n` define

$$
c_\sigma(i_1,\ldots,i_k)=\prod_{j=1}^k \sigma_{i_j}.
$$

Labels `Y` are the signed RHS, not part of `x`. Then `|X| = n^k = exp(Theta(log^2 n))`, so the simple finite-domain table learner no longer applies in polynomial time in `n`.

This candidate passes the domain-size and RHS-separation tests. But if `D` is low-noise RCN around some `c_sigma` with noise `eta < gamma = 1/2 - beta`, then `OPT_C(D) <= eta`, and the fixed weak guarantee forces

$$
err(h) \le eta + beta < 1/2.
$$

So the weak learner must predict noisy log-arity XOR with nontrivial advantage. That is essentially the weak/noisy parity task, not an available signed-CSP approximation algorithm.

I also tested biased OR / Max-k-SAT and succinct Max-Cut variants. OR-type predicates are easy in all-positive form because public constants or random assignments already do well, but arbitrary signed labels destroy that easy approximation. Max-Cut has a real explicit approximation algorithm, but making the vertex domain succinct either makes the SDP superpolynomial or changes the benchmark to circuit-constrained cuts, for which the weak approximator is again missing.

## Claims Or Lemmas

**Claim 1: Log-arity XOR is not a viable weak-side construction.**  
A fixed-slack weak learner for the log-arity XOR class would solve low-noise distribution-free noisy XOR prediction with constant advantage whenever `eta < gamma`. This is exactly the kind of task one would normally want to assume hard.

**Claim 2: Unconstrained CSP approximation does not survive succinctization for free.**  
If the CSP has `N = poly(s)` variables and constant arity, the descriptor domain is polynomial and improper table learning kills the strong-side hardness. If `N` is superpolynomial in `s`, then an explicit CSP approximation algorithm over all variables is not polynomial in `s`. If assignments are restricted to succinct functions or circuits, the explicit CSP approximator no longer optimizes the relevant class.

**Claim 3: Refutation-based weak-side evidence is dangerous.**  
A refutation algorithm strong and tunable enough to give arbitrary small correlation thresholds tends, via learning-vs-refutation frameworks, to imply agnostic learning rather than just fixed-slack weak learning. A useful separation candidate would need only constant-threshold weak approximation while preserving hardness of `OPT + epsilon` prediction.

## Proof Attempts

For signed XOR, the proof attempt was direct: formulate the class, check `|X|` is superpolynomial, then test the weak guarantee on RCN. The contradiction is not formal impossibility, but it shows the candidate’s weak learner is as hard as the intended strong-side noisy-prediction problem at lower noise.

For OR / Max-k-SAT, I tried to use the random-assignment approximation. This only works for all-positive labels. Once negative labels are legitimate examples, the objective becomes a signed weighted CSP with both satisfaction and falsification demands, and the public-bias advantage disappears.

For Max-Cut, I tried to import the Goemans-Williamson approximation. It works for explicit finite graphs, but that is exactly the regime where the edge-domain table learner applies. Circuit/succinct vertices avoid table learning but also remove the known polynomial weak approximator.

## Gaps And Risks

I have not ruled out all succinct signed-CSP predicates. A predicate with a genuine distribution-free constant-factor signed approximator, but hard moderate-noise improper prediction, would still instantiate the template.

The strong-side hardness must be sample-access improper prediction hardness, not assignment recovery, refutation, or explicit-instance approximation hardness.

The refutation-to-learning parameter tradeoff needs a theorem-level audit before turning Claim 3 into a formal obstruction.

## Counterexamples Or Obstructions

- Fixed-arity explicit CSPs: polynomial descriptor domain, so improper table learning applies.
- RHS/sign exposed in `x`: an improper predictor can read the label.
- All-positive CSP labels: public constant `h=1` is trivial.
- XOR/parity predicates: good strong-hardness story, but weak side is already noisy parity.
- Max-Cut: good explicit approximation, but no free succinct distribution-free version.

## Sources Consulted

- Run notes: `problem.md` and all requested `working_notes/*.md`.
- Kothari and Livni, [Agnostic Learning by Refuting](https://arxiv.org/abs/1709.03871).
- Daniely, Linial, and Shalev-Shwartz, [From Average Case Complexity to Improper Learning Complexity](https://arxiv.org/abs/1311.2272).
- Vadhan, [On Learning vs. Refutation](https://proceedings.mlr.press/v65/vadhan17a.html).
- Allen, O'Donnell, and Witmer, [How to Refute a Random CSP](https://arxiv.org/abs/1505.04383).
- Goemans and Williamson, [Improved Approximation Algorithms for Maximum Cut and Satisfiability Problems Using Semidefinite Programming](https://research.ibm.com/publications/improved-approximation-algorithms-for-maximum-cut-and-satisflability-problems-using-semidefinite-programming).

## Recommended Next Steps

1. Record the “succinctization dilemma” as a candidate obstruction if critics agree.
2. If continuing this route, look for bounded-distance decodable code/CSP families with distribution-free weighted low-noise decoding.
3. Audit Kothari-Livni parameters: determine exactly when a constant-threshold refuter gives only weak learning versus full `OPT + epsilon` agnostic learning.
4. Avoid XOR and all-positive OR as primary candidates unless the weak-side algorithm is independently supplied.