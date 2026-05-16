## Summary

The explorer’s narrow conclusion is mostly sound for KMV/Feldman threshold-style boosters and Kalai-Kanade/Ghai-Singh potential-style boosters: the fixed-additive oracle does not directly instantiate those theorems to get efficient `OPT + epsilon` learning.

But the report is incomplete in an important way. It misses the newer residual-free/statistical agnostic boosting route, especially da Cunha et al., “Revisiting Agnostic Boosting” (arXiv:2503.09384). Their weak condition is essentially

$$
\operatorname{Corr}(W(D)) \ge \gamma \sup_{f\in F}\operatorname{Corr}(f,D)-\epsilon_0,
$$

and the fixed-$\beta$ source fits it with $(\gamma,\epsilon_0)=(1,2\beta)$, since $2\beta<1$. Their theorem then gives strong agnostic learning statistically, but the algorithm is explicitly not computationally efficient and uses exhaustive clean-label enumeration. So this does not settle the efficient atlas edge, but it does refute the explorer’s blanket claim that strong agnostic boosters necessarily need vanishing additive slack.

## Issue List

- **Missing assumption / literature gap:** The audit omits residual-free boosters that accept constant slack statistically. This is already hinted in `problem.md`, and the 2025 “Revisiting Agnostic Boosting” result makes it explicit. Fatal for the broad literature-audit claim; not fatal for the efficient-edge conclusion.

- **False claim, too broad:** “Most strong agnostic boosters need a weak learner that extracts a positive fraction of whatever residual correlation remains” is true for KK/Ghai-style potential boosters, but false as a general statement after the 2025 result. Exhaustive clean-labeling avoids small residual correlations by creating realizable subproblems.

- **Plausible but incomplete:** Lemma 2’s algebra is fine for the raw unmodified oracle, but if a wrapper validates/flips hypotheses, the exact lower bound on the required additive slack changes by constants. The robust conclusion is only that KK/Ghai-style instantiations retain $\Omega(\beta)$ slack, not necessarily the exact $\epsilon_0\ge 2\beta$ statement in every wrapper model.

- **Unsupported / underdeveloped:** The “capacity issue” for arbitrary improper outputs may be weaker than stated. If hypotheses are finite bit-string representations output in polynomial time, the class of possible weak outputs has log-cardinality bounded by output length, hence potentially polynomial. The real generic barrier may be runtime enumeration, not VC/log-cardinality.

- **Plausible but incomplete:** The legal-oracle obstruction is useful, but it is not a black-box impossibility theorem. One must specify allowed transformations. Exhaustive clean-label enumeration can bypass the “small residual $M_D$” obstruction.

## Counterexamples Or Stress Tests

- **Tiny-edge distribution:** Let $C=\{c\}$ and generate labels with $\mathbb E[c(X)Y]=\eta$, where $0<\eta\le 2\beta$. Then $\operatorname{OPT}_C=(1-\eta)/2$, and an oracle returning a zero-correlation hypothesis has error $1/2\le \operatorname{OPT}_C+\beta$. Thus fixed-$\beta$ learning gives no KMV weak advantage when $\alpha\le\beta$, and no KK/Ghai multiplicative weak learner with vanishing slack.

- **Clean-labeling stress test:** On the same distribution, if one somehow queries the oracle on samples relabeled by the best $c$, then $\sup_C \operatorname{Corr}=1$, and the fixed-$\beta$ learner must return correlation at least $1-2\beta>0$. This shows the obstruction is not information-theoretic; the hard part is efficiently finding or generating clean witness labels.

- **Bad legal oracle:** An oracle that returns zero correlation whenever $M_D\le 2\beta$ and useful hypotheses only above that threshold can stall ordinary residual boosters. This is a good black-box barrier candidate, but only for a restricted booster model.

## Literature Or Known-Result Conflicts

- KMV 2008 supports the explorer’s Lemma 1: an $(\alpha,\gamma)$ weak learner yields only `OPT + alpha + epsilon`, and fixed $\beta$ gives this only for $\alpha>\beta`. Source: [KMV PDF](https://www.microsoft.com/en-us/research/wp-content/uploads/2016/11/2008-On_Agnostic_Boosting-and_Parity_Learning.pdf).

- Kalai-Kanade 2009 supports the multiplicative-correlation mismatch for that theorem family: the final correlation gap contains an $\epsilon_0/\gamma$ term. Source: [NeurIPS paper](https://papers.neurips.cc/paper_files/paper/2009/file/13f9896df61279c928f19721878fac41-Paper.pdf).

- Feldman 2010 gives the KMV-style distribution-specific result, but also records the older fixed-$\beta$ guarantee of roughly $\Delta/(1-2\beta)+\epsilon$, not additive optimality. Source: [Feldman PDF](https://www.cs.cmu.edu/~odonnell/hits09/feldman-agnostic-boosting.pdf).

- The major omitted conflict is da Cunha et al. 2025: any nontrivial $(\gamma,\epsilon_0)$ weak learner with $\gamma>\epsilon_0$ can be statistically boosted, but their method is not computationally efficient. Source: [arXiv:2503.09384](https://arxiv.org/abs/2503.09384).

## What Survives The Critique

The efficient atlas edge should remain open.

The explorer correctly identifies why straightforward KMV/Feldman and KK/Ghai-Singh instantiations do not prove efficient `OPT + epsilon` learning from fixed $\beta$.

The most valuable surviving obstruction is: standard efficient residual boosters cannot rely on the fixed-$\beta$ oracle once residual best correlation drops below $2\beta$.

## Recommended Next Checks

1. Audit da Cunha et al. 2025 carefully and record: fixed-$\beta$ source instantiates their weak learner with $(1,2\beta)$; sample complexity is polynomial if output-class complexity is polynomial; runtime is exponential because of clean-label enumeration.

2. Isolate the exact exponential step: enumeration of all labelings of a sample to include the unknown best-classifier labeling.

3. Reframe the positive route as an efficient clean-witness generation problem: can one replace exhaustive label enumeration by a hitting set, compression scheme, or weak-oracle-driven candidate generator?

4. Formalize the legal-oracle obstruction only after specifying the allowed black-box interface. Without such restrictions, residual-free statistical boosting bypasses it.