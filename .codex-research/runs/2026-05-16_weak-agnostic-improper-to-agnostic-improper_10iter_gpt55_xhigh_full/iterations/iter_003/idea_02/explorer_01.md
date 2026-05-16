## Summary

The cleanest proof strategy for `idea_02` is to stop thinking about enumerating da Cunha-style weak-call samples one call at a time. The right abstraction is a **global clean-transcript reconstruction lemma**: if a complete final classifier can be reconstructed from a total of only `K` hidden-clean examples plus `b` advice/random bits, and if

\[
2^K 2^b / q = \operatorname{poly}(s,1/\epsilon,\log(1/\delta)),
\]

then raw noisy tuple sampling plus held-out validation gives the desired agnostic learner.

This gives a useful conditional positive route, but it also sharpens the obstruction: ordinary per-call logarithmic compression is not enough. If boosting needs \(T=\Theta(\log(1/\epsilon))\) weak calls and each call needs \(k=\Theta(\log(s/\epsilon))\) clean witness examples, the total witness size is \(K=kT=\Theta(\log^2(s/\epsilon))\), which only gives quasi-polynomial discovery.

## Concrete Progress

A plausible de-enumeration theorem should target the following global property.

Let \(c\) be a near-optimal comparator and let

\[
D_c^+ = D \mid [Y=c(X)]
\]

be the hidden clean conditional distribution. Suppose there is an evaluable reconstruction map

\[
\operatorname{Rec}: ((X\times\{\pm1\})^K, \{0,1\}^b) \to \{\pm1\}^X
\]

such that, for \(S\sim (D_c^+)^K\) and uniform advice \(R\in\{0,1\}^b\),

\[
\Pr_{S,R}\left[
\operatorname{err}_{D_c^+}(\operatorname{Rec}(S,R),c)\le \alpha
\right]\ge q.
\]

Then a wrapper can sample many raw \(K\)-tuples from \(D\), run `Rec` on each tuple and each advice string, and validate the resulting final hypotheses on fresh noisy data. If one sampled tuple is entirely clean and reconstructs a good classifier, the clean-conditional lemma gives

\[
\operatorname{err}_D(h,Y)\le \operatorname{err}_D(c,Y)+\alpha.
\]

Since a nontrivial case has \(\Pr[Y=c(X)]\ge 1/2\), the all-clean penalty is at worst \(2^{-K}\). Thus the candidate-list size and tuple count are polynomial exactly when the displayed \(2^K2^b/q\) quantity is polynomial.

The important refinement is that `Rec` must reconstruct a **complete final classifier**, not merely an individual weak hypothesis. Noisy validation can select final classifiers; it cannot reliably select intermediate weak hypotheses that are useful only on the clean slice.

## Claims Or Lemmas

**Lemma 1: Global Clean Transcript Menu Lemma.**

Assume the reconstruction property above with parameters \(K,b,q,\alpha\). If

\[
2^K2^b/q \le \operatorname{poly}(s,1/\epsilon,\log(1/\delta))
\]

and `Rec` is polynomial-time evaluable, then the hidden clean-transcript enumeration can be replaced by a polynomial candidate menu. Held-out validation over that menu yields error at most

\[
\operatorname{OPT}_C(D)+\tau+\alpha+O(\epsilon),
\]

where \(c\) is a comparator with \(\operatorname{err}_D(c)\le \operatorname{OPT}_C(D)+\tau\).

Status: proof-sketch solid; essentially a sharpened version of the existing random-clean-witness route.

**Lemma 2: Per-Call Logarithmic Compression Is Insufficient For This Route.**

If a boosting transcript requires \(T=\Theta(\log(1/\epsilon))\) adaptive weak calls and each weak call requires \(k=\Theta(\log(s/\epsilon))\) fresh clean witness examples, then blind clean-tuple discovery costs

\[
2^{kT}=\exp(\Theta(\log^2(s/\epsilon))),
\]

before advice and success-probability factors. This is quasi-polynomial, not atlas-polynomial.

Status: accepted accounting obstruction.

**Lemma 3: Constant Per-Round Success Is The Relevant Sequential Alternative.**

A sequential sampler that chooses one branch per weak round can avoid explicit \(B^T\) branching only if the probability of producing an acceptable weak object at each hidden-clean step is bounded below by a constant, or at least high enough that the product over \(T\) rounds remains inverse-polynomial. An inverse-polynomial per-round success probability gives quasi-polynomial or worse success after \(T=\Theta(\log(1/\epsilon))\) rounds.

Status: proof strategy observation; needs formalization for any concrete booster.

## Proof Attempts

The positive proof route should be organized top-down as follows.

1. Prove the global clean-transcript menu lemma independently of da Cunha-style details.

2. Instantiate `Rec` using a full clean boosting transcript, not individual weak hypotheses. This avoids the known obstruction that clean-useful weak hypotheses may have poor original noisy risk.

3. Seek one of the following sufficient mechanisms:

- **Global compression:** the final vote or final classifier is determined by \(K=O(\log(s/\epsilon))\) total clean examples plus \(O(\log(s/\epsilon))\) advice bits.

- **Large-basin stability:** under the ideal clean transcript distribution, the set of successful transcripts has measure \(q\ge 1/\operatorname{poly}\), and the number of genuinely clean-label-dependent examples in the transcript is only \(O(\log \operatorname{poly})\).

- **Canonical bounded randomness:** the weak learner can be replaced by a canonical implementation whose random/advice seed space is polynomial and whose output remains weak for all adaptive clean queries generated by the booster.

The third route is the riskiest: making the seed family uniform over adaptive query distributions may require a finite query class or capacity bound, which is close to the da Cunha dual-VC bottleneck already identified.

## Gaps And Risks

The main gap is that none of the natural assumptions follows from the atlas source guarantee. An efficient improper fixed-slack learner may use polynomially many samples, unstable tie-breaking, or a huge output range.

The proof strategy must avoid a common false shortcut: existential sample compression does not imply inverse-polynomial random discovery. A compression set may exist inside a clean sample without being likely to appear as a fresh random tuple in a useful form.

Branching over candidate weak hypotheses is also dangerous. If each of \(T\) rounds has polynomially many candidate weak outputs and only one path is good, the final list has size \(\operatorname{poly}^T\), typically quasi-polynomial. Some path-selection or final-selector structure is needed.

## Counterexamples Or Obstructions

A toy anti-hitting-set example is the random-target finite-domain model.

Let \(X=[N]\), let \(f\) be iid random over \(\{\pm1\}^N\), and let the clean distribution be uniform over \((x,f(x))\). Any reconstruction procedure using only \(K\) clean examples has expected error roughly

\[
1/2 - K/(2N)
\]

against a random \(f\), because outside the observed points the labels are independent of the transcript. Thus achieving error \(1/2-\Omega(1)\) requires \(K=\Omega(N)\).

A weak learner with \(m=\Theta(N)\) clean examples could memorize enough of \(f\), but a raw noisy \(m\)-tuple is entirely clean with probability about \(2^{-m}\) in the hard regime. This is not an atlas separation: if \(N\) is the representation size, direct memorization may still be polynomial. But it is a useful lower-bound example against any proof skeleton that hopes arbitrary clean transcripts have small random witnesses.

## Sources Consulted

- Local run notes: `problem.md`, `working_notes/canonical_summary.md`, `claim_ledger.md`, `lemma_bank.md`, `failed_attempts.md`, `counterexamples.md`, `literature_map.md`, `promising_directions.md`, `iteration_summaries.md`, and `iterations/iter_003/idea_02/idea.md`.
- Arthur da Cunha, Mikael Møller Høgsgaard, Andrea Paudice, **“Sample-Near-Optimal Agnostic Boosting with Improved Running Time”**, arXiv:2601.11265: https://arxiv.org/abs/2601.11265
- Arthur da Cunha, Mikael Møller Høgsgaard, Andrea Paudice, Yuxin Sun, **“Revisiting Agnostic Boosting”**, arXiv:2503.09384: https://arxiv.org/abs/2503.09384
- Sally Floyd and Manfred Warmuth, **“Sample Compression, Learnability, and the Vapnik-Chervonenkis Dimension”**: https://mwarmuth.bitbucket.io/pubs/J30.pdf

## Recommended Next Steps

Formalize the global clean-transcript menu lemma as a reusable conditional theorem.

Then test candidate de-enumeration assumptions against the \(K=kT\) accounting. Any proposal with \(k=\Theta(\log(s/\epsilon))\) per weak call should be treated as quasi-polynomial unless it gives a global compression, path selection, or constant-success sequential sampler.

Finally, develop the random-target finite-domain obstruction into a clean “anti-hitting-set for proof skeletons” lemma, explicitly labeled as non-atlas and not a represented-class separation.