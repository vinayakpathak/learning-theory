## Summary

The compression idea gives a clean conditional route, but not yet a proof of the atlas edge. The strongest usable reduction is: if we can generate a polynomial-size observable candidate list containing one hypothesis that learns a near-optimal comparator on its hidden clean conditional distribution, then ordinary held-out validation gives agnostic learning.

The gap is candidate generation. “A uses k examples” or “A has compression size k” is only enough if it yields a small **strong clean witness**, not just one weak clean call.

## Concrete Progress

For any comparator $c$, define the clean conditional distribution
$$
D_c^+ := D \mid [Y=c(X)].
$$

For any binary hypothesis $h$,
$$
\operatorname{err}_D(h,Y)-\operatorname{err}_D(c,Y)
=
\Pr[h\ne c,\,Y=c]-\Pr[h\ne c,\,Y\ne c]
\le
\Pr_{D_c^+}[h\ne c].
$$

So learning $c$ to error $\alpha$ on $D_c^+$ implies agnostic excess at most $\alpha$ over $c$ on the original noisy distribution.

This turns the problem into a clean-witness generation problem: produce a polynomial list containing some $h$ with small $D_{c^*}^+$-error for a near-optimal $c^*$, then validate on fresh noisy examples.

## Claims Or Lemmas

**Lemma 1, proved:** Clean-conditional learning suffices.  
If $\operatorname{err}_D(c)\le \operatorname{OPT}_C(D)+\tau$ and $\operatorname{err}_{D_c^+}(h,c)\le \alpha$, then
$$
\operatorname{err}_D(h,Y)\le \operatorname{OPT}_C(D)+\tau+\alpha.
$$

**Lemma 2, conditional:** Random clean witness theorem.  
Suppose there is an efficient reconstruction map $R$ such that, for every clean realizable distribution $(X,c(X))$, a random $K$-tuple of clean examples plus short advice/randomness produces $h$ with clean error $\le \epsilon/4$ with probability at least $q$, where $2^K/q$ is polynomial in $s,1/\epsilon,\log(1/\delta)$. Then the desired agnostic learner exists.

Reason: sample many $K$-tuples from the noisy distribution, run $R$ on each, include constants, and validate. If $\operatorname{OPT}\le 1/2-O(\epsilon)$, a near-optimal comparator has clean mass at least about $1/2$; an all-clean successful tuple appears with probability at least $2^{-K}q$. If $\operatorname{OPT}$ is near $1/2$, constants already achieve the target up to $O(\epsilon)$.

## Proof Attempts

The direct enumeration plan works existentially: enumerate outputs of $A$ on all clean $k$-subsets, then standard realizable boosting would imply that votes over these outputs can fit the hidden clean sample.

The algorithmic problem is selection. The clean subset is hidden, and validation against noisy labels certifies only final risk, not whether a base hypothesis is useful for clean boosting.

A stronger route avoids this by assuming the whole strong clean learner has a small random witness of size $K=O(\log \operatorname{poly}(1/\epsilon))$. Then random candidate generation plus validation is genuinely polynomial.

## Gaps And Risks

Small weak-call size is not enough. A weak call gives only $\beta$ clean error; strong clean error needs aggregation.

If boosting uses $T=\Theta(\log(1/\epsilon))$ weak calls, the witness size is roughly $K=kT$. Thus $k=O(\log(1/\epsilon))$ gives $K=O(\log^2(1/\epsilon))$, which is quasi-polynomial for clean-tuple search.

Ordinary sample compression is also not enough unless the compression subset can be found or sampled. Exhaustively enumerating $K$-subsets from a sample costs $N^K$, polynomial only for constant $K$.

Adaptive reweighting is dangerous: booster weights may concentrate on regions where the hidden comparator is mostly corrupted, making all-clean weighted batches exponentially unlikely.

## Counterexamples Or Obstructions

A hidden clean sample may contain a good boosted transcript, while every observable greedy step against noisy labels looks unhelpful or harmful. Validation solves final selection from a polynomial list, but not search over exponentially many votes.

There is also a semantic mismatch between “compression subset exists” and “random tuple succeeds.” The former supports exhaustive enumeration; the latter supports polynomial random sampling. The idea needs the latter, or a new hitting-set lemma.

## Sources Consulted

Read the assigned run files: [problem.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/problem.md), [working_notes/](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/working_notes), and [idea.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/iterations/iter_001/idea_03/idea.md).

Also consulted atlas context: [agnostic-boosting-open.md](/Users/vinayakpathak/learning-theory/atlas/arguments/agnostic-boosting-open.md) and [the implication note](/Users/vinayakpathak/learning-theory/atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-agnostic-improper-pac.md).

External background: [Schapire 1990](https://www.schapire.net/papers/strengthofweak.pdf), [Freund and Schapire 1997](https://dblp.uni-trier.de/rec/journals/jcss/FreundS97.html), [Floyd and Warmuth 1995](https://mwarmuth.bitbucket.io/pubs/J30.pdf).

## Recommended Next Steps

Record the clean-conditional lemma; it is a real reusable reduction.

Refine idea_03 into two separate hypotheses: “random clean witness” and “enumerable compression witness.” The first can give a polynomial theorem for $K=O(\log \operatorname{poly})$; the second only gives polynomial time for constant $K$ unless a hitting-set/sampler is added.

Try to prove or refute that a Schapire-style clean booster has a random clean witness of total size $O(\log(1/\epsilon))$ under the fixed-slack source. That is the sharp next bottleneck.