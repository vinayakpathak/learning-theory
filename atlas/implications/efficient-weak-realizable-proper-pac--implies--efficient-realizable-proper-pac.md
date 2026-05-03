---
type: implication
id: efficient-weak-realizable-proper-pac__implies__efficient-realizable-proper-pac
source: efficient-weak-realizable-proper-pac
target: efficient-realizable-proper-pac
source_note: "[[efficient-weak-realizable-proper-pac|Efficient Weak Realizable Proper PAC Learning]]"
target_note: "[[efficient-realizable-proper-pac|Efficient Realizable Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "false"
evidence: conditional-counterexample
assumptions:
  - "RP != NP"
witnesses:
  - "fixed-k-term-DNF"
ref_keys:
  - schapire1990
  - pitt1988
  - haussler1990
refs:
  - "[Schapire 1990](https://doi.org/10.1023/A:1022648800760)"
  - "[Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)"
  - "[Haussler et al. 1990](https://www.cis.upenn.edu/~mkearns/papers/models.pdf)"
summary: "Fixed-k-term DNF is weakly properly learnable, but strong proper realizable learning is hard unless RP = NP."
family: fixed-k-term-dnf-proper-boosting-separation
axis_delta:
  resource: same
  distribution: same
  strength: weak-to-strong
  realizability: same
  properness: same
argument_note: "[[fixed-k-term-dnf-proper-boosting-separation|Fixed-k-Term DNF Proper Boosting Separation]]"
witness_note: "[[fixed-k-term-DNF|Fixed-k-Term DNF]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Realizable Proper PAC Learning $\Rightarrow$ Efficient Realizable Proper PAC Learning

## Verdict

`false`, under the assumption $\mathrm{RP}\ne\mathrm{NP}$.

Fixed-$k$ term DNF satisfies the weak realizable proper source, but the requested strong proper target would give an efficient proper learner for fixed-$k$ term DNF, contradicting Pitt and Valiant unless $\mathrm{RP}=\mathrm{NP}$.

## Counterexample

**Goal.** Refute the universal implication by one representation class. The witness is the class $\mathcal C_k$ of Boolean functions represented by DNF formulas with at most $k$ terms, for a fixed $k\ge 2$.

**Why the source property holds.** Schapire observes that fixed-$k$ term DNF is weakly learnable using proper hypotheses. The candidate family is small: constants together with all disjunctions of at most $k$ literals. Such a disjunction is itself a $k$-term DNF, since each literal can be viewed as a one-literal term.

For a realizable distribution with target $c\in\mathcal C_k$, Schapire's argument first handles the case where one label has noticeably more than half the mass by outputting the corresponding constant. Otherwise, write the target DNF as a $k$-CNF using the distributive conversion recorded in the fixed-DNF separation note. That $k$-CNF has only polynomially many clauses for fixed $k$. Since every positive point satisfies every clause, and the negative mass is not tiny, an averaging argument gives a clause, equivalently a disjunction of at most $k$ literals, that keeps all positives correct and rejects an inverse-polynomial fraction of the negatives. Thus some proper candidate has error at most $1/2-\gamma(n)$ for an inverse-polynomial $\gamma(n)>0$.

The same finite-candidate argument also gives weak agnostic proper learning. Let $\eta=\operatorname{opt}_{\mathcal C_k}$ under an arbitrary labeled distribution, and choose $c\in\mathcal C_k$ with error $\eta$ up to an arbitrarily small slack. Applying the realizable argument to the marginal distribution labeled by $c$ gives a proper candidate $h$ with

$$
\Pr[h(X)\ne c(X)]\le 1/2-\gamma(n).
$$

By the triangle inequality for zero-one loss,

$$
\Pr[h(X)\ne Y]
\le
\Pr[h(X)\ne c(X)]+\Pr[c(X)\ne Y]
\le
\eta+1/2-\gamma(n).
$$

Empirical risk minimization over the polynomial-size candidate family, with accuracy slack at most $\gamma(n)/2$, therefore outputs a proper hypothesis with error at most

$$
\operatorname{opt}_{\mathcal C_k}+1/2-\gamma(n)/2.
$$

This is the atlas weak agnostic proper guarantee, and it also witnesses weak agnostic improper learning by ignoring the properness constraint. Restricting to realizable distributions gives weak realizable proper learning.

**Why the target property fails.** Pitt and Valiant rule out efficient strong realizable proper learning for this class unless $\mathrm{RP}=\mathrm{NP}$. The hardness is stated in their learning-from-examples model; Haussler, Kearns, Littlestone, and Warmuth give the polynomial equivalence with the standard PAC variants used here for these Boolean representation classes.

**Conclusion.** Fixed-$k$ term DNF satisfies the source node but not the target node under $\mathrm{RP}\ne\mathrm{NP}$. Therefore this implication is false under that assumption.

## References

- [Schapire 1990](https://doi.org/10.1023/A:1022648800760)
- [Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)
- [Haussler et al. 1990](https://www.cis.upenn.edu/~mkearns/papers/models.pdf)
