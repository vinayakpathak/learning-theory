## Summary

The finite-bag idea gives a clean conditional route, but it does not by itself remove the runtime obstruction.

It does remove the need for a global `Range(A)` VC/dual-VC assumption in one specific sense: if a polynomial procedure actually generates a polynomial-size list of complete final classifiers, then fresh noisy validation can select from that list. The validation argument is finite-list and does not care about the global range of the improper weak learner.

The remaining runtime bottlenecks are still substantial:

1. generating the hidden-clean weak-call transcripts without `n^{m0}` enumeration;
2. producing a polynomial-size list of complete final classifiers, or having a polynomial final-vote selector;
3. proving that at least one generated final classifier has true, not merely empirical-hidden-clean, error `OPT + O(epsilon)`.

So the idea is best recorded as a sharper conditional theorem, not an atlas proof.

## Concrete Progress

A useful finite-bag formulation is:

Let `A` be the fixed-slack weak learner. Suppose there is a polynomial-time construction which, from noisy samples and oracle access to `A`, outputs a validation-independent list

$$
L=\{F_1,\dots,F_N\}
$$

of evaluable final classifiers with

$$
N \le \operatorname{poly}(s,1/\epsilon,\log(1/\delta)),
$$

and with probability at least `1-delta/2`, some `F_i` satisfies

$$
\operatorname{err}_D(F_i,Y)\le \operatorname{OPT}_C(D)+\epsilon/2.
$$

Then fresh validation with

$$
O((\log N+\log(1/\delta))/\epsilon^2)
$$

examples gives an efficient strong agnostic improper learner.

This bypasses global `VC(Range(A))` because selection is over the realized finite list. But it requires a polynomial list of complete final classifiers, not merely a finite base-hypothesis bag.

If the construction only produces a base bag `B` of size `M` and asks us to search over all `T`-wise votes, the selector cost is generally

$$
|B|^T = M^T.
$$

For `M=poly(s,1/epsilon)`, this is polynomial only when `T` is representation-uniformly constant, unless there is a separate polynomial optimizer. If `T=Theta(log(s/epsilon))`, it is already quasi-polynomial; if `T=poly(1/epsilon)`, it is super-polynomial.

## Claims Or Lemmas

**Lemma 1, finite final-list validation.**  
A fresh validation sample can replace global capacity assumptions only after a polynomial-size list of full classifiers has been generated. It cannot validate individual weak hypotheses in place of the final hidden-clean boosting trajectory.

**Lemma 2, adaptive weak calls need no global range if query sampling is solved.**  
If the algorithm can sample from the adaptive weak-call distributions `Q_1,...,Q_M`, then running `A` with confidence `delta/M` per call and union bounding gives valid weak guarantees for all realized calls, even when `Q_t` depends on previous outputs. This uses only the PAC guarantee of `A`, not `VC(Range(A))`.

**Conditional theorem, runtime-clean version.**  
The da Cunha-Hogsgaard-Paudice route would imply the atlas edge under these extra assumptions:

- hidden-clean adaptive weak-call distributions can be generated or hit in polynomial time;
- the number of weak calls is polynomial;
- each weak output is evaluable in polynomial time;
- the final stage outputs either one certified final vote or a polynomial list of final votes;
- fresh validation is used only on complete final classifiers.

This theorem is essentially the polynomial clean-witness menu route specialized to the da Cunha proof skeleton.

## Proof Attempts

The positive proof is straightforward under the above assumptions. Use the fixed-slack source as a da Cunha-style weak learner via the accepted correlation translation, e.g. `gamma0=1`, `epsilon0=2 beta`, so `theta=1/2-beta`. Run the assumed hidden-clean generator/selector to produce final classifiers. Then validate the finite list on fresh noisy samples and output the empirical best.

The attempt to use a finite base bag alone fails at runtime. A finite bag removes infinite-class language, but the class of all votes over the bag can still be computationally huge.

The attempt to randomly sample hidden-clean weak-call witnesses also fails unless the witness probability is inverse-polynomial. If a weak call needs `m0` clean examples and clean mass is `p`, blind sampling has probability about `p^{m0}` before adaptive weighting. For growing `m0`, this is not polynomial.

## Gaps And Risks

The phrase “finite bag” is ambiguous. A polynomial finite list of final classifiers is enough. A polynomial base bag plus an exponential vote class is not.

There is a circularity risk: the generated bag in the da Cunha proof depends on hidden clean samples for a near-optimal comparator. If those samples are found by exhaustive tuple enumeration, the original `n^{m0}` bottleneck remains.

Finite validation does not prove candidate existence. It only selects among candidates. The construction must separately prove that some generated final classifier has true error near `OPT`, not just empirical performance on a hidden clean slice.

This does not show the atlas edge. It states the exact extra primitive needed: polynomial hidden-clean transcript generation plus polynomial final selection.

## Counterexamples Or Obstructions

If `|B|=s^a` and `T=Theta(log s)`, then searching all votes costs

$$
(s^a)^{\Theta(\log s)}=\exp(\Theta(\log^2 s)),
$$

which is quasi-polynomial, not atlas-polynomial.

A weak hypothesis can be useful on the hidden clean slice but bad under original noisy validation. For clean mass `0.6`, clean-slice error `0.4`, and always-wrong behavior on the noisy slice, original error is

$$
0.6\cdot 0.4+0.4\cdot 1=0.64.
$$

So validating base hypotheses individually can discard hypotheses needed inside the hidden-clean trajectory.

## Sources Consulted

- Project files requested by the prompt: `problem.md`, `working_notes/*.md`, and `iterations/iter_003/idea_01/idea.md`.
- Prior local audit: `iterations/iter_002/idea_03/explorer_02.md` and its critic reports.
- da Cunha, Høgsgaard, Paudice, [Sample-Near-Optimal Agnostic Boosting with Improved Running Time](https://arxiv.org/abs/2601.11265), 2026.
- da Cunha, Høgsgaard, Paudice, Sun, [Revisiting Agnostic Boosting](https://arxiv.org/abs/2503.09384), 2025.

## Recommended Next Steps

Formalize the conditional theorem with two explicit black-box primitives: a polynomial hidden-clean transcript generator and a polynomial final-vote selector/list generator.

Then try to weaken the first primitive: instead of hitting every adaptive hidden-clean distribution, look for a smaller sufficient family of transcript distributions needed by the da Cunha proof.

Separately, audit finite-bag vote selection as a standalone computational problem: given an explicit bag `B`, when is ERM over `sign(B^T)` polynomial, and when is it hard?