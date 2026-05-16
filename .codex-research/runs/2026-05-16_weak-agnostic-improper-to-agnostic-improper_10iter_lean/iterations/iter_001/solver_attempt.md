## Verdict

SOLVED: no

## Candidate Solution Or Main Attempt

A direct positive proof via generic agnostic boosting seems blocked by the fixed additive slack. In correlation form, the weak learner supplies, for every queried distribution,

$$
\operatorname{corr}(h,Y) \ge \sup_{c\in C}\operatorname{corr}(c,Y)-2\beta.
$$

Let $\alpha=2\beta$. This is an additive approximate linear-optimization oracle over $C$. Generic boosting or convex optimization over $\operatorname{conv}(C)$ can use such an oracle, but the usual convergence target is only within an additive $\alpha$ floor of the best linear objective unless some extra structure removes the floor.

The key issue is that strong agnostic learning needs to exploit arbitrarily small positive correlations, on the order of $\epsilon$, while the source learner is allowed to be completely uninformative whenever

$$
\sup_{c\in C}\operatorname{corr}(c,Y)\le \alpha.
$$

Equivalently, when $\operatorname{OPT}_C(D)\ge 1/2-\beta$, the weak guarantee permits outputting a hypothesis with essentially no useful correlation. But strong agnostic learning still has to distinguish, for every $\epsilon>0$, between best error $1/2-\epsilon$ and $1/2$, and output a hypothesis matching that $\epsilon$-scale advantage.

Thus the most natural boosting route cannot be made into a proof without an additional lemma that converts fixed additive weak advantage into access to small residual correlations.

## Concrete Lemmas Or Reductions

### Lemma 1: Fixed Additive Weak Learning Gives No Forced Edge Near Noise

Let $\gamma=1/2-\beta$, so $\beta=1/2-\gamma$. If a queried distribution $D$ satisfies

$$
\operatorname{OPT}_C(D)\ge \gamma,
$$

then the weak learner guarantee allows a hypothesis of error $1/2$.

Indeed,

$$
1/2 \le \operatorname{OPT}_C(D)+\beta
$$

is equivalent to

$$
\operatorname{OPT}_C(D)\ge 1/2-\beta=\gamma.
$$

So on all distributions where the best concept has error at least $\gamma$, the weak learner may legally return a useless random-level hypothesis.

This is the central obstruction: strong agnostic learning is precisely about improving over $1/2$ by arbitrarily small amounts.

### Lemma 2: Additive Linear-Optimization Oracles Have an Accuracy Floor

Consider any boosting-style method that queries the weak learner only through distributions inducing linear objectives

$$
c \mapsto \mathbb{E}[w(X,Y)c(X)Y].
$$

The learner returns $h$ satisfying an additive approximation guarantee to the best such objective, but with additive loss $\alpha=2\beta$.

For generic convex optimization over $\operatorname{conv}(C)$, such an oracle is insufficient to optimize below additive scale $\alpha$ without extra assumptions. Frank-Wolfe, multiplicative weights, and residual-gradient interpretations all inherit this issue: when the remaining residual correlation is below $\alpha$, the oracle may return an uncorrelated hypothesis.

This is not yet a separation for learning, but it rules out the most naive black-box boosting proof.

### Lemma 3: A Conditional Positive Route

If the source assumption were strengthened from fixed additive weak agnostic learning to a scale-sensitive or multiplicative correlation guarantee, for example

$$
\operatorname{corr}(h,Y)
\ge \kappa \cdot \sup_{c\in C}\operatorname{corr}(c,Y)
$$

for some fixed $\kappa>0$ whenever the supremum is positive, then standard agnostic boosting / online convex optimization machinery should yield strong agnostic improper learning in time polynomial in $1/\epsilon$.

This conditional statement is plausible and matches known agnostic boosting intuitions, but it is stronger than the atlas source assumption.

## Gaps And Failure Points

The direct proof fails at the residual stage. Boosting needs a weak hypothesis correlated with the current residual whenever the current ensemble is still more than $\epsilon$ worse than the best concept. But the fixed-slack learner only guarantees useful output when the best residual correlation exceeds a constant threshold depending on $\beta$.

A possible proof would need a new amplification lemma of the form:

> If there exists any $c\in C$ with small positive residual correlation $\rho$, then by transforming the distribution or labels one can create a new legal binary learning problem on which some concept in $C$ has correlation larger than $2\beta+\Omega(\rho)$.

I do not see such a transformation under the distribution-free PAC interface. Simple reweighting preserves the scale problem; label randomization can encode costs but does not amplify tiny correlations without also increasing variance or changing the comparison class.

## Counterexamples Or Obstructions

A black-box oracle obstruction is strong:

An adversarial valid weak learner may return an uninformative hypothesis on every query for which

$$
\sup_{c\in C}\operatorname{corr}(c,Y)\le 2\beta.
$$

Therefore, any proof that treats the weak learner only as this oracle cannot recover $\epsilon$-scale advantages for $\epsilon \ll \beta$.

This is not a full computational separation, because a strong learner could use the representation of $C$ and the sample directly, rather than only calling the weak learner. But it shows that the implication cannot follow from generic oracle boosting alone.

Candidate separation shape:

Find a represented class $C$ where detecting large advantage over random is easy, but detecting arbitrarily small advantage is hard. The weak learner only needs to act nontrivially above a constant advantage threshold, while the strong agnostic learner must recover inverse-polynomial advantage. This resembles hardness-of-weak-correlation detection, planted structure, SQ lower bounds, LPN/parity noise, or cryptographic PRF distinctions. Existing templates are delicate because realizable or high-advantage cases still force the weak learner to work.

## Promising Ideas To Explore

1. Formalize a black-box lower bound: construct an oracle weak learner satisfying the fixed additive guarantee such that any polynomial-query booster fails to achieve excess error below $\Omega(\beta)$ on some abstract correlation instance.

2. Search for a class with a real “large-correlation easy, small-correlation hard” gap. The right object may be a distributional/SQ hardness construction rather than parity or halfspaces directly.

3. Look for a residual-amplification lemma. The missing ingredient would turn small residual advantage into constant advantage without requiring enumeration over clean subsets or hypotheses.

4. Investigate whether extra assumptions make the edge true: finite VC plus efficient empirical risk minimization over a compressed candidate list, margin/real-valued weak hypotheses, cost-sensitive weak access, or a tunable weak tolerance.

## Notes For Critics

The negative discussion is only a black-box obstruction, not a separation for represented PAC learning.

The conditional positive statement relies on standard agnostic boosting intuition but is not the source assumption. It should not be recorded as solving the atlas implication.

The main useful takeaway is precise: fixed additive weak agnostic learning gives no required information once $\operatorname{OPT}_C(D)\ge 1/2-\beta$, while strong agnostic learning needs to exploit advantages arbitrarily close to zero.