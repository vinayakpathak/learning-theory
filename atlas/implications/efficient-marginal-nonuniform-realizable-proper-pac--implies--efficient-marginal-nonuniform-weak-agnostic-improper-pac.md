---
type: implication
id: efficient-marginal-nonuniform-realizable-proper-pac__implies__efficient-marginal-nonuniform-weak-agnostic-improper-pac
source: efficient-marginal-nonuniform-realizable-proper-pac
target: efficient-marginal-nonuniform-weak-agnostic-improper-pac
source_note: "[[efficient-marginal-nonuniform-realizable-proper-pac|Efficient Marginal-Nonuniform Realizable Proper PAC Learning]]"
target_note: "[[efficient-marginal-nonuniform-weak-agnostic-improper-pac|Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning]]"
domain: binary-classification
model: pac
status: "true"
evidence: theorem
result_origin: "unclear"
assumptions: []
witnesses: []
ref_keys:
  - valiant1984
  - blumer1989
refs:
  - "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
summary: "True: a low-noise coupling robustifies the marginal-nonuniform realizable learner without changing the marginal."
family: low-noise-weak-agnostic-robustification
axis_delta:
  resource: same
  distribution: same
  strength: strong-to-weak
  realizability: realizable-to-agnostic
  properness: proper-to-improper
argument_note: "[[low-noise-weak-agnostic-robustification|Low-Noise Weak Agnostic Robustification]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Marginal-Nonuniform Realizable Proper PAC Learning $\Rightarrow$ Efficient Marginal-Nonuniform Weak Agnostic Improper PAC Learning

## Verdict

`true`, by a marginal-preserving low-noise robustification.

## Proof Status

**Goal.** Build a weak agnostic learner while keeping all marginal-dependent bounds attached to the original marginal $P$.

Fix $P$ and let $A$ be the marginal-nonuniform realizable proper learner. Run $A$ with constant accuracy and confidence, and let $m_P(s)$ be the resulting $P$-dependent polynomial sample/time bound. Set
$$
\alpha_P(s)=\min\{1/64,1/(64m_P(s))\},
\qquad
\beta_P(s)=1/2-\alpha_P(s).
$$

The weak agnostic learner includes the two constant classifiers, runs $A$ a logarithmic number of times on fresh agnostic samples, validates all returned hypotheses to constant accuracy, and outputs a returned hypothesis only if it beats the best constant by a fixed validation margin; otherwise it outputs the best constant.

If $\operatorname{OPT}_{\mathcal C}(\mathcal D)\ge \alpha_P(s)$, a constant classifier of error at most $1/2$ already satisfies
$$
1/2\le \operatorname{OPT}_{\mathcal C}(\mathcal D)+1/2-\alpha_P(s).
$$

If $\operatorname{OPT}_{\mathcal C}(\mathcal D)<\alpha_P(s)$, choose a near-optimal $c^\star\in\mathcal C$ with error $\eta<\alpha_P(s)$. Couple one run of $A$ on noisy examples $(X,Y)\sim\mathcal D$ with one run on realizable examples $(X,c^\star(X))$, using the same $P$-distributed instance sequence and the same internal randomness. Since $A$ inspects at most $m_P(s)$ examples in this invocation, the probability that any inspected label is corrupted is at most
$$
m_P(s)\eta<1/64.
$$
On the no-corruption event, the noisy transcript is exactly the realizable transcript under the original marginal $P$. The source guarantee therefore gives, with constant probability, a hypothesis $h$ with small $\operatorname{err}_P(h,c^\star)$, and then
$$
\operatorname{err}_{\mathcal D}(h)\le \eta+\operatorname{err}_P(h,c^\star)
$$
is bounded by an absolute constant below $1/2$. Repetition and validation find such a candidate with high probability, which is stronger than the required weak guarantee with tolerance $\beta_P(s)$.

The proof avoids the conditional-marginal obstruction. Although conditioning on clean labels would define a new marginal $Q\ll P$, the coupling argument never invokes the learner under $Q$; it uses only the original marginal-dependent polynomial $m_P$.

## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
