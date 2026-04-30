---
type: implication
id: efficient-realizable-improper-pac__implies__efficient-realizable-proper-pac
source: efficient-realizable-improper-pac
target: efficient-realizable-proper-pac
source_note: "[[efficient-realizable-improper-pac|Efficient Realizable Improper PAC Learning]]"
target_note: "[[efficient-realizable-proper-pac|Efficient Realizable Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "false"
evidence: conditional-counterexample
assumptions:
  - RP != NP
witnesses:
  - fixed-k-term-DNF
ref_keys:
  - valiant1984
  - pitt1988
  - haussler1990
refs:
  - "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
  - "[Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)"
  - "[Haussler et al. 1990](https://www.cis.upenn.edu/~mkearns/papers/models.pdf)"
summary: "Fixed-k-term DNF is improperly learnable via k-CNF, but proper realizable learning is hard unless RP = NP."
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Realizable Improper PAC Learning $\Rightarrow$ Efficient Realizable Proper PAC Learning

## Verdict

`false`, under the assumption $\mathrm{RP} \ne \mathrm{NP}$.

Pitt and Valiant show that fixed-$k$ term DNF has an efficient improper learner through $k$-CNF representations, while proper learning is hard unless $\mathrm{RP}=\mathrm{NP}$. Haussler, Kearns, Littlestone, and Warmuth relate the examples model to standard polynomial PAC learnability.

## Proof Sketch

**Goal.** Refute the universal implication, assuming $\mathrm{RP}\ne\mathrm{NP}$. It is enough to exhibit one representation class that is efficiently realizably learnable when the learner may change representation, but is not efficiently learnable when the learner must output the same representation.

**Syntax.** A DNF formula is an OR of terms, and each term is an AND of literals:

$$
F=T_1\vee\cdots\vee T_m,
\qquad
T_i=\ell_{i,1}\wedge\cdots\wedge \ell_{i,r_i}.
$$

A fixed-$k$ term DNF has at most $k$ terms, but each term may contain many literals. A $k$-CNF is different: it is an AND of clauses, each clause is an OR of literals, and each clause has at most $k$ literals. The letter $k$ bounds the number of DNF terms on one side and the width of CNF clauses on the other.

**Construction of the witness class.** Fix a constant $k\ge 2$ and let $\mathcal C_k$ be the class of Boolean functions represented by DNF formulas with at most $k$ terms. This is the class called $k$-term-DNF in Pitt and Valiant.

**Why the source property holds: convert to $k$-CNF.** Let

$$
F=T_1\vee\cdots\vee T_m,
\qquad m\le k,
$$

be a $k$-term DNF. Distributing OR over AND gives the equivalent CNF

$$
\bigwedge_{\ell_1\in T_1,\ldots,\ell_m\in T_m}
(\ell_1\vee\cdots\vee\ell_m).
$$

For $k=2$, this is just

$$
(a\wedge b)\vee(c\wedge d)
\equiv
(a\vee c)\wedge(a\vee d)\wedge(b\vee c)\wedge(b\vee d).
$$

The general formula is the same distributive identity. Each resulting clause chooses one literal from each DNF term, so each clause has $m\le k$ literals. If the original DNF has size $s$ and $k$ is fixed, the number of clauses is at most $s^k$, hence polynomial in the original representation size. Thus every fixed-$k$ term DNF has an equivalent polynomial-size $k$-CNF.

**The learner for $k$-CNF.** Valiant's fixed-width CNF learner is simple. For fixed $k$, enumerate every possible clause of width at most $k$; there are only polynomially many, about $O(n^k)$. Draw a polynomial number of positive examples. Output the conjunction of all candidate clauses that are satisfied by every sampled positive example.

If the true target is a $k$-CNF, every true target clause is satisfied by every positive example, so the output includes all target clauses and therefore has no false positives. A candidate clause that wrongly rejects a noticeable fraction of positive examples is very likely to be falsified by the sample and removed. A union bound over the polynomially many candidate clauses makes the false-negative probability small. This gives an efficient learner for $k$-CNF. Applied to the equivalent $k$-CNF above, it learns $\mathcal C_k$ while outputting a $k$-CNF rather than a $k$-term DNF. That is an efficient realizable improper learner.

**The model used by Pitt and Valiant.** Their "learning from examples" model is a realizable, distribution-free model with two example oracles. For a target formula $f$, the learner has a `POS` oracle drawing from an arbitrary distribution $D^+$ supported on satisfying assignments of $f$, and a `NEG` oracle drawing from an arbitrary distribution $D^-$ supported on falsifying assignments. A learner for a representation class $\mathcal F$ must, for every target $f\in\mathcal F$ and every such pair $D^+,D^-$, output a hypothesis whose false-negative mass under $D^+$ and false-positive mass under $D^-$ are both at most $\varepsilon$, with high probability and in time polynomial in the target size and $1/\varepsilon$. Proper learning means the output hypothesis must also lie in $\mathcal F$.

**Why proper learning is hard in that model.** Pitt and Valiant reduce the NP-complete problem $k$-NM-Colorability to proper learning of $k$-term DNF. An instance consists of a finite set $S=\{s_1,\dots,s_n\}$ and constraints $C_1,\dots,C_m\subseteq S$. The question is whether there is a coloring $\chi:S\to[k]$ such that no constraint is monochromatic.

From this instance, create variables $x_1,\dots,x_n$. The positive examples are the points $p_i$ with a single zero in coordinate $i$ and ones elsewhere. The negative examples are the points $q_C$ with zeros exactly on the coordinates belonging to the constraint $C$ and ones elsewhere. Put the uniform distribution on the positive examples and the uniform distribution on the negative examples.

The key claim is:

$$
\text{there is a consistent }k\text{-term DNF}
\quad\Longleftrightarrow\quad
(S,\{C_j\})\text{ is }k\text{-NM-colorable}.
$$

First suppose a valid coloring $\chi$ exists. For each color $r\in[k]$, define

$$
T_r=\bigwedge_{\chi(s_i)\ne r} x_i,
\qquad
F=T_1\vee\cdots\vee T_k.
$$

The positive point $p_i$ satisfies the term $T_{\chi(s_i)}$, because that term omits $x_i$ and every other variable in the term is $1$ on $p_i$. Now take a negative point $q_C$. If it satisfied some $T_r$, then every zero coordinate of $q_C$ would have to be omitted from $T_r$, which means every element of $C$ has color $r$. That would make $C$ monochromatic, contradicting the validity of the coloring. Hence $F$ is consistent with all constructed examples.

Conversely, suppose a $k$-term DNF is consistent with all constructed examples. Pitt and Valiant first normalize the terms so that they are monotone on this sample. The reason is that every positive point has exactly one zero. A term with two or more negative literals cannot satisfy any positive point, so it can be deleted. A term with exactly one negative literal $\neg x_i$ can only help cover the positive point $p_i$; it can be replaced by the monotone term $\bigwedge_{j\ne i}x_j$, which still covers $p_i$ and does not cover any negative point in the reduced instances, whose constraints have size at least two. After this normalization, every term contains only positive literals.

Now color $s_i$ by the first term that omits variable $x_i$. This is well-defined because the positive point $p_i$ must satisfy some monotone term, and a monotone term satisfied by $p_i$ cannot contain $x_i$. If some constraint $C$ were monochromatic with color $r$, then the corresponding negative point $q_C$ would satisfy term $T_r$: the variables from $C$ are omitted from that term, and all variables outside $C$ are set to $1$ in $q_C$. That contradicts consistency. Thus the formula determines a valid $k$-NM-coloring.

Now choose

$$
\varepsilon < \min\{1/n,1/m\}.
$$

Under the uniform distributions above, any hypothesis with error below $\varepsilon$ on both positive and negative examples must be perfectly consistent with every support point. Therefore, if a proper learner for $k$-term DNF existed, we could run it on these two distributions, verify the returned DNF on the finite support, and decide $k$-NM-Colorability in randomized polynomial time. Since $k$-NM-Colorability is NP-complete for every $k\ge2$, this would imply $\mathrm{RP}=\mathrm{NP}$.

**How this transfers to standard PAC learning.** The model above is not word-for-word the modern one-oracle PAC definition, but it is polynomially equivalent for the Boolean representation classes used here. Haussler, Kearns, Littlestone, and Warmuth prove equivalences among Valiant-style polynomial learnability models, including one-oracle and two-oracle variants, under standard regularity conditions such as polynomial evaluability of hypotheses. Fixed-$k$ term DNF and $k$-CNF satisfy these conditions.

Intuitively, the two directions are as follows. A standard PAC learner can be run on the mixture distribution $\frac12D^+ + \frac12D^-$ with labels attached; small total error under this mixture forces both conditional errors to be small after rescaling the accuracy. Conversely, a two-oracle learner can be simulated from ordinary labeled examples by conditioning on the observed label; if one label has tiny probability, mistakes on that side already contribute tiny total PAC error, and if it has non-tiny probability, rejection sampling supplies conditional examples with polynomial overhead. The Haussler-Kearns-Littlestone-Warmuth theorem is the formal version that tracks the parameters and halting conventions.

**Conclusion.** Fixed-$k$ term DNF is efficiently realizably learnable with improper $k$-CNF hypotheses, but it is not efficiently realizably learnable with proper fixed-$k$ term DNF hypotheses unless $\mathrm{RP}=\mathrm{NP}$. Therefore efficient realizable improper PAC learning does not imply efficient realizable proper PAC learning.

## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Pitt and Valiant 1988](https://doi.org/10.1145/48014.63140)
- [Haussler et al. 1990](https://www.cis.upenn.edu/~mkearns/papers/models.pdf)
