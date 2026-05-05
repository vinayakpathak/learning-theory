# Open Edge Resolution Scratchpad

Edge: `efficient-agnostic-improper-pac -> efficient-weak-agnostic-proper-pac`

## Research Log

## Sources Checked

## Proof Or Counterexample Attempts

## Verdict

## Follow-Up Directions

## Depth-1 Entry - 2026-05-05

### Verdict

Resolved `false`, conditional on $\mathrm{NP}\nsubseteq\mathrm{RP}$.

The PCP active-slice lookup class gives a counterexample. It is efficiently strong agnostic PAC learnable with improper hypotheses, but an efficient weak agnostic proper learner for the same class would decide an NP-complete language with one-sided randomized error.

### Definitions Used

- Source: `atlas/definitions/efficient-agnostic-improper-pac.md`.
  The learner is distribution-free and polynomial-time, may output hypotheses outside $\mathcal C$, and for every requested $\varepsilon>0$ must achieve
  $$
  \operatorname{err}_{\mathcal D}(h)
  \le
  \inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\varepsilon.
  $$
- Target: `atlas/definitions/efficient-weak-agnostic-proper-pac.md`.
  The learner is distribution-free and polynomial-time, must output $h\in\mathcal C$, and only needs the fixed weak additive guarantee
  $$
  \operatorname{err}_{\mathcal D}(h)
  \le
  \inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta
  $$
  for some $\beta<1/2$.
- Edge note: `atlas/implications/efficient-agnostic-improper-pac--implies--efficient-weak-agnostic-proper-pac.md`.
  Current atlas status is `open`, evidence `unknown`, family `properization-open`.

### Sources Checked

Local atlas notes checked:

- `atlas/definitions/efficient-agnostic-improper-pac.md`
- `atlas/definitions/efficient-weak-agnostic-proper-pac.md`
- `atlas/definitions/efficient-weak-agnostic-improper-pac.md`
- `atlas/implications/efficient-agnostic-improper-pac--implies--efficient-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-weak-agnostic-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/agnostic-boosting-open.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/arguments/clause-satisfaction-proper-hardness.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/witnesses/clause-satisfaction-lookup-class.md`
- `atlas/witnesses/fixed-k-term-DNF.md`
- `references.bib`

Primary web sources checked:

- Ben-David, Long, and Mansour, *Agnostic Boosting*, DOI/metadata page: https://doi.org/10.1007/3-540-44581-1_33, with abstract text also visible at https://cris.tau.ac.il/en/publications/agnostic-boosting/. Used for the atlas weak agnostic convention $\operatorname{err}(h)\le \operatorname{er}_P(F)+\beta$.
- Håstad and Khot, *Query Efficient PCPs with Perfect Completeness*, Theory of Computing page: https://theoryofcomputing.org/articles/v001a007/. The page states logarithmic randomness, perfect completeness, and soundness at most $2^{-k^2}+\epsilon$.
- Karp, *Reducibility among Combinatorial Problems*, Springer DOI page: https://doi.org/10.1007/978-1-4684-2001-2_9. Used for the standard NP-completeness/RP consequence.
- Blumer, Ehrenfeucht, Haussler, and Warmuth, *Learnability and the Vapnik-Chervonenkis Dimension*, DOI metadata: https://doi.org/10.1145/76359.76371. Used only for the standard finite-class/uniform-convergence PAC route.
- Kearns, Schapire, and Sellie, *Toward Efficient Agnostic Learning*, DOI/metadata page: https://doi.org/10.1023/A:1022615600103. Used for the agnostic-learning framing.

### Theorem Route

I found no positive theorem route. The source learner can be run with a constant accuracy parameter and therefore already gives a weak agnostic guarantee if improper outputs are allowed. The missing operation is a polynomial-time projection or search procedure that returns a comparably good member of $\mathcal C$.

The checked boosting references do not supply that operation. Agnostic boosting combines weak hypotheses into stronger predictors, typically improper aggregate predictors. Finite-class sample theory only says that a good proper empirical minimizer exists when the class has small enough complexity; it does not make ERM over the proper representation class computationally efficient.

### Counterexample Route

Use the PCP active-slice class and strengthen its source property from weak/realizable improper learnability to strong/agnostic improper learnability.

Fix a perfect-completeness PCP verifier $V$ for an NP-complete language. On length-$n$ instances, $V$ uses $q(n)=O(\log n)$ random bits, has perfect completeness, and has soundness $s<1/2$ after choosing fixed PCP parameters. For an instance $\varphi$ and proof $\pi$, define a proper concept

$$
h_{\varphi,\pi}(\psi,r)=
\begin{cases}
V(\varphi,\pi,r) & \text{if } \psi=\varphi,\\
0 & \text{otherwise.}
\end{cases}
$$

The proper representation is $(\varphi,\pi)$. Evaluation is polynomial-time: compare $\psi$ to $\varphi$, and if they match, run the verifier on randomness $r$.

**Why the source holds.** For each length $n$, let $\mathcal F_n$ be the improper class consisting of all hypotheses that choose one instance slice $\psi\in\{0,1\}^n$, use an arbitrary Boolean lookup table on the verifier randomness set $\{0,1\}^{q(n)}$, and output $0$ off that slice, together with the all-zero hypothesis. Then $\mathcal C_n\subseteq\mathcal F_n$, and

$$
\log |\mathcal F_n|
\le n + 2^{q(n)} + O(1)
= \operatorname{poly}(n),
$$

because $q(n)=O(\log n)$.

There is a polynomial-time ERM over $\mathcal F_n$ on a sample of size $m$. Only sampled slices can improve empirical error over the all-zero hypothesis; an unsampled slice has the same empirical predictions as the all-zero hypothesis. For each sampled slice, the best lookup table is obtained by majority vote on each sampled randomness string, with arbitrary defaults on unseen randomness strings. Thus the algorithm checks at most $m$ slices and writes a polynomial-size table.

By finite-class agnostic uniform convergence, with polynomially many samples this ERM returns $\hat f\in\mathcal F_n$ satisfying

$$
\operatorname{err}_{\mathcal D}(\hat f)
\le
\inf_{f\in\mathcal F_n}\operatorname{err}_{\mathcal D}(f)+\varepsilon
\le
\inf_{c\in\mathcal C_n}\operatorname{err}_{\mathcal D}(c)+\varepsilon.
$$

So the class satisfies `efficient-agnostic-improper-pac`, not merely the weak improper source.

**Why the target fails.** Suppose an efficient weak agnostic proper learner exists for this class, with tolerance $\beta<1/2$. Given an NP instance $\varphi$, draw examples uniformly from the active slice $\{(\varphi,r):r\in\{0,1\}^{q(n)}\}$ and label every example by $1$.

If $\varphi$ is satisfiable, perfect completeness gives a proof $\pi^\star$ whose proper concept has error $0$ on this distribution. The weak agnostic proper learner must therefore return, with its success probability, a proper hypothesis with error at most $\beta$, equivalently acceptance at least $1-\beta>1/2$ on the $\varphi$ slice.

If $\varphi$ is unsatisfiable, every matching-slice proper hypothesis has verifier acceptance at most $s<1/2$, and every wrong-slice proper hypothesis has acceptance $0$ on the active-slice distribution. Since the verifier randomness set has polynomial size, the reduction can enumerate all random strings and compute the returned proper hypothesis's acceptance exactly. Accept iff this acceptance is greater than $1/2$. YES instances are accepted with the learner's success probability; NO instances are never accepted. Hence the learner would put an NP-complete language in $\mathrm{RP}$.

Therefore, assuming $\mathrm{NP}\nsubseteq\mathrm{RP}$, the target node fails for a class satisfying the source node.

### Concrete Obstruction

The old obstruction was that standard improper/proper separations either refuted only strong proper targets or did not prove the agnostic improper source. The active-slice construction avoids both problems.

The PCP soundness gap is already below the weak threshold $1/2$, so a weak proper learner is enough to distinguish satisfiable from unsatisfiable instances. Separately, enlarging the improper learner to one-slice lookup tables makes agnostic ERM computationally feasible because the logarithmic PCP randomness keeps each lookup table polynomial-size and the logarithm of the improper class size polynomial.

Thus a generic strong-agnostic-improper to weak-agnostic-proper conversion would collapse $\mathrm{NP}$ into $\mathrm{RP}$.

### Atlas-Ready Proof And Metadata Changes

Atlas-ready verdict:

`efficient-agnostic-improper-pac -> efficient-weak-agnostic-proper-pac` is `false`, under $\mathrm{NP}\nsubseteq\mathrm{RP}$.

Suggested frontmatter changes for the implication note:

```yaml
status: "false"
evidence: conditional-counterexample
assumptions:
  - "NP not subset RP"
witnesses:
  - pcp-active-slice-lookup-class
witness_note: "[[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]]"
ref_keys:
  - blumer1989
  - bendavid2001
  - hastad2005query
  - karp1972
refs:
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
  - "[Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)"
  - "[Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)"
  - "[Karp 1972](https://doi.org/10.1007/978-1-4684-2001-2_9)"
summary: "The PCP active-slice lookup class is efficiently agnostically improperly learnable, but weak agnostic proper learning would put NP in RP."
family: pcp-active-slice-weak-proper-hardness
argument_note: "[[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]"
```

Atlas-ready body sketch:

> Use a perfect-completeness logarithmic-randomness PCP with soundness $s<1/2$. Proper hypotheses encode an instance/proof pair and are zero except on that instance's active verifier-randomness slice. The class is strongly agnostically learnable improperly by ERM over the finite class of one-slice lookup tables, whose log-size is polynomial because each active slice has polynomial size. If a weak agnostic proper learner existed, run it on the all-positive uniform distribution over the active slice of an input instance. Perfect completeness forces returned proper acceptance above $1/2$ on satisfiable instances, while soundness keeps every proper hypothesis at acceptance below $1/2$ on unsatisfiable instances. Enumerating the polynomially many random strings gives an RP algorithm for an NP-complete language.

### Promising Next Directions

- Update `atlas/arguments/pcp-active-slice-weak-proper-hardness.md` to record the stronger one-slice-table agnostic improper ERM proof, not only realizable improper memorization.
- Update both weak and strong agnostic improper-to-weak proper implication notes using the same witness after reviewing the dirty atlas changes already present.
- Recheck all remaining `properization-open` edges whose source is at least as strong as distribution-free agnostic improper learning and whose target is weak proper; this witness may resolve more of them.
