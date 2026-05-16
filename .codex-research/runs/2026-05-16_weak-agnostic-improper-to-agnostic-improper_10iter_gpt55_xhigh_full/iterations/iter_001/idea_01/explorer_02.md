## Summary

Quantifier check outcome: the standard agnostic boosting theorems I checked do not settle the atlas edge from a fixed-additive weak agnostic improper learner to a strong agnostic improper learner.

The core mismatch is this. The source oracle with fixed $\beta<1/2$ guarantees

$$
\operatorname{corr}(A(D),Y)\ge M_D-2\beta,
\qquad
M_D=\sup_{c\in C}\operatorname{corr}(c,Y).
$$

So it is only forced to return positive correlation when $M_D>2\beta$, equivalently when $\operatorname{OPT}_C(D)<(1-2\beta)/2$. Most strong agnostic boosters need a weak learner that extracts a positive fraction of whatever residual correlation remains, even when that correlation is arbitrarily small.

## Concrete Progress

The fixed-additive source implies an $(\alpha,\gamma)$-weak agnostic learner only in the restricted range $\alpha>\beta$:

$$
\operatorname{OPT}_C(D)\le \frac12-\alpha
\implies
\operatorname{err}(A(D))\le \frac12-(\alpha-\beta).
$$

Thus $A$ is $(\alpha,\alpha-\beta)$-weak for $\alpha>\beta$. Applying Kalai-Mansour-Verbin/Feldman style boosting then gives at best

$$
\operatorname{err}(h)\le \operatorname{OPT}_C(D)+\alpha+\epsilon,
$$

with $\alpha>\beta$, so this cannot yield $\operatorname{OPT}+\epsilon$ for $\epsilon<\beta$.

For Kalai-Kanade/Ghai-Singh style multiplicative-correlation weak learning, the required condition is essentially

$$
\operatorname{corr}(h,Y)\ge \gamma M_D-\epsilon_0.
$$

The fixed-additive guarantee implies this uniformly only if $\epsilon_0\ge 2\beta$. The final booster loss contains an $\epsilon_0/\gamma$-type term, so this again leaves constant excess on the order of $\beta$.

## Claims Or Lemmas

**Lemma 1.** A fixed $\beta$-optimal agnostic learner gives KMV-style weak learning only above threshold $\alpha>\beta$.

Proof sketch: if $\operatorname{OPT}\le 1/2-\alpha$, then

$$
\operatorname{err}(A)\le \operatorname{OPT}+\beta
\le \frac12-(\alpha-\beta).
$$

For $\alpha\le\beta$, this need not be better than random guessing.

**Lemma 2.** The fixed-additive correlation guarantee does not imply a useful Kalai-Kanade multiplicative weak learner with vanishing slack.

Let $\tau=2\beta$. To derive

$$
M-\tau\ge \gamma M-\epsilon_0
$$

for all $M\in[0,1]$, one needs $\epsilon_0\ge\tau$. Therefore the theorem cannot be instantiated with $\epsilon_0=o(1)$ unless $\beta=o(1)$.

**Claim 3.** The Ben-David-Long-Mansour fixed-$\beta$ notion is close to the source oracle, but its known boosting conclusions are weaker than $\operatorname{OPT}+\epsilon$.

The cited summaries give guarantees such as $\max\{c_1(\beta)\operatorname{OPT}^{c_2(\beta)},\epsilon\}$ or multiplicative-in-$\operatorname{OPT}$ bounds, not additive optimal agnostic learning for fixed $\beta>0$.

## Proof Attempts

Attempted direct KMV/Feldman instantiation: fails because the booster needs $\alpha$ to be the desired final excess scale. The source only gives positive weak advantage when $\alpha>\beta$.

Attempted Kalai-Kanade instantiation: fails because the source guarantee is additive in correlation, not multiplicative. For small residual $M_D$, the oracle may legally provide no useful correlation.

Attempted “distribution-specific relabeling removes the issue”: not enough. The source is distribution-free, so it can handle the relabeled distributions, but the relabeled residual problems may have small best correlation, exactly where the fixed-additive guarantee becomes vacuous.

## Gaps And Risks

This does not prove the atlas edge false. It only rules out a straightforward application of the standard black-box boosting theorems checked here.

A nonstandard positive proof would need a residual-forcing transformation: from a small residual correlation gap of size $O(\epsilon)$, create an oracle query on which some $c\in C$ has error below the fixed threshold where $A$ must return positive advantage.

There is also a representation/capacity issue in newer sample-efficient boosters: they often measure complexity of a base class $B$ of weak hypotheses. The source oracle is improper and arbitrary, so $B$ may not have a clean uniform VC/log-cardinality bound unless extra representation assumptions are added.

## Counterexamples Or Obstructions

The main obstruction is a legal-oracle behavior obstruction. On any query distribution with $M_D\le 2\beta$, the guarantee allows the oracle to return a hypothesis with zero or even negative correlation. Standard agnostic boosters need progress on residual distributions where $M_D$ can be arbitrarily small but still above the target precision.

Equivalently, if $\beta=1/2-\gamma_0$, the source is forced to be useful only when $\operatorname{OPT}_C(D)<\gamma_0$, while strong agnostic boosting needs usefulness whenever $\operatorname{OPT}_C(D)\le 1/2-\alpha$ for arbitrarily small $\alpha$.

## Sources Consulted

- [problem.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/problem.md)
- [idea.md](/Users/vinayakpathak/learning-theory/.codex-research/runs/2026-05-16_weak-agnostic-improper-to-agnostic-improper_10iter_gpt55_xhigh_full/iterations/iter_001/idea_01/idea.md)
- Shai Ben-David, Philip M. Long, Yishay Mansour, [“Agnostic Boosting”](https://doi.org/10.1007/3-540-44581-1_33), COLT 2001.
- Adam Tauman Kalai, Yishay Mansour, Elad Verbin, [“On Agnostic Boosting and Parity Learning”](https://www.microsoft.com/en-us/research/wp-content/uploads/2016/11/2008-On_Agnostic_Boosting-and_Parity_Learning.pdf), STOC 2008.
- Adam Tauman Kalai, Varun Kanade, [“Potential-Based Agnostic Boosting”](https://papers.neurips.cc/paper/3676-potential-based-agnostic-boosting.pdf), NeurIPS 2009.
- Vitaly Feldman, [“Distribution-Specific Agnostic Boosting”](https://arxiv.org/abs/0909.2927), ICS 2010.
- Udaya Ghai, Karan Singh, [“Sample-Efficient Agnostic Boosting”](https://arxiv.org/abs/2410.23632), NeurIPS 2024.

## Recommended Next Steps

1. Audit Gavinsky’s lower bound carefully: determine whether it gives a formal black-box barrier for fixed-$\beta$ optimal agnostic learners.
2. Try to formalize the legal-oracle obstruction as a black-box impossibility statement.
3. Search for a residual-forcing lemma that converts small residual advantage into a low-OPT query distribution where the fixed-slack oracle becomes useful.
4. Keep this edge marked open unless such a residual-forcing lemma or a non-black-box class-specific argument is found.