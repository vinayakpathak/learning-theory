# Open Edge Resolution Scratchpad

Edge: `efficient-weak-agnostic-improper-pac -> efficient-weak-agnostic-proper-pac`

## Research Log

## Sources Checked

## Proof Or Counterexample Attempts

## Verdict

## Follow-Up Directions

## Depth-1 Entry - 2026-05-05

### Verdict

Resolved `false`, conditional on $\mathrm{NP}\nsubseteq\mathrm{RP}$.

The PCP active-slice lookup class gives a counterexample. It is efficiently agnostically learnable by an improper one-slice lookup-table ERM, but an efficient weak agnostic proper learner for the same class would decide an NP-complete language with one-sided randomized error.

### Definitions Used

- Source: `atlas/definitions/efficient-weak-agnostic-improper-pac.md`.
  A distribution-free polynomial-time learner may output hypotheses outside $\mathcal C$ and must achieve
  $$
  \operatorname{err}_{\mathcal D}(h)
  \le
  \inf_{c\in\mathcal C}\operatorname{err}_{\mathcal D}(c)+\beta
  $$
  for a weak additive tolerance $\beta<1/2$.
- Target: `atlas/definitions/efficient-weak-agnostic-proper-pac.md`.
  The same weak agnostic guarantee is required, but the output must lie in $\mathcal C$.
- Edge note: `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-weak-agnostic-proper-pac.md`.
  Current atlas status is `open`, evidence `unknown`, family `properization-open`.

### Sources Checked

Local atlas notes checked:

- `atlas/definitions/efficient-weak-agnostic-improper-pac.md`
- `atlas/definitions/efficient-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-weak-agnostic-improper-pac--implies--efficient-weak-agnostic-proper-pac.md`
- `atlas/implications/efficient-weak-realizable-improper-pac--implies--efficient-weak-realizable-proper-pac.md`
- `atlas/arguments/properization-open.md`
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`
- `atlas/witnesses/pcp-active-slice-lookup-class.md`
- `atlas/witnesses/clause-satisfaction-lookup-class.md`
- `atlas/witnesses/fixed-k-term-DNF.md`

Primary web sources checked:

- Ben-David, Long, and Mansour, *Agnostic Boosting*, DOI page / author-uploaded abstract via ResearchGate: https://doi.org/10.1007/3-540-44581-1_33 and https://www.researchgate.net/publication/2373407_Agnostic_Boosting. The checked abstract states the $\beta$-weak agnostic condition $\operatorname{err}(h)\le \operatorname{err}(F)+\beta$.
- Håstad and Khot, *Query Efficient PCPs with Perfect Completeness*, Theory of Computing page: https://theoryofcomputing.org/articles/v001a007/. The abstract states logarithmic randomness, perfect completeness, and soundness at most $2^{-k^2}+\epsilon$, so choosing constant $k,\epsilon$ gives soundness $s<1/2$.
- Karp, *Reducibility among Combinatorial Problems*, Springer DOI page: https://doi.org/10.1007/978-1-4684-2001-2_9. Used only for the standard NP-completeness/RP consequence.

### Theorem Route

I found no positive theorem route. A generic theorem would need a polynomial-time projection from an improper hypothesis, or from samples plus an improper hypothesis, back into $\mathcal C$ while preserving weak agnostic excess error. The finite-sample route only gives existence of a good proper empirical minimizer; it does not make proper ERM over $\mathcal C$ efficient. Agnostic boosting results combine weak hypotheses into improper predictors and therefore do not solve the proper-output requirement.

### Counterexample Route

Use the PCP active-slice class from the neighboring weak-realizable separation, but strengthen the source proof from realizable improper learning to agnostic improper learning.

Fix a perfect-completeness PCP verifier for an NP-complete language with $O(\log n)$ random bits and soundness $s<1/2$. For an instance $\varphi$ and proof $\pi$, define a proper concept

$$
h_{\varphi,\pi}(\psi,r)=
\begin{cases}
V(\varphi,\pi,r) & \text{if } \psi=\varphi,\\
0 & \text{otherwise.}
\end{cases}
$$

The domain consists of pairs $(\psi,r)$, and the proper representation is $(\varphi,\pi)$. Evaluation is polynomial-time by comparing $\psi$ to $\varphi$ and then running the verifier on the matching slice.

**Why the source holds.** Let $\mathcal F_n$ be the improper class of all hypotheses that choose one instance slice $\psi$ of length $n$, use an arbitrary Boolean lookup table on the polynomial-size random-string set $R_\psi$, and output $0$ off that slice, together with the all-zero hypothesis. Then $\mathcal C_n\subseteq\mathcal F_n$ and

$$
\log |\mathcal F_n|
\le
O(n)+|R_\psi|
=\operatorname{poly}(n),
$$

because the PCP has logarithmic randomness.

There is a polynomial-time ERM over $\mathcal F_n$ on a sample: only sampled slices can improve empirical error over the all-zero hypothesis, there are at most $m$ such slices, and for each sampled slice the best improper table is obtained by empirical majority vote for each sampled random string, with arbitrary defaults on unseen random strings. Finite-class uniform convergence gives, for polynomial $m$,

$$
\operatorname{err}_{\mathcal D}(\hat f)
\le
\inf_{f\in\mathcal F_n}\operatorname{err}_{\mathcal D}(f)+\varepsilon
\le
\inf_{c\in\mathcal C_n}\operatorname{err}_{\mathcal D}(c)+\varepsilon.
$$

Thus the witness is efficiently strong agnostic improper PAC learnable, hence satisfies `efficient-weak-agnostic-improper-pac`.

**Why the target fails.** Suppose an efficient weak agnostic proper learner exists for this class, with tolerance $\beta(n)<1/2$ and inverse-polynomial gap $\gamma(n)=1/2-\beta(n)$, or with fixed constant $\beta<1/2$ as a special case.

Given an NP instance $\varphi$, sample uniformly from the active slice $\{(\varphi,r):r\in R_\varphi\}$ and label every example by $1$.

- If $\varphi$ is satisfiable, perfect completeness gives a proof $\pi^\star$ whose proper concept has error $0$. The proper weak agnostic learner must return, with its success probability, some proper $h_{\varphi,\pi}$ with error at most $\beta(n)$, i.e. verifier acceptance at least $1-\beta(n)=1/2+\gamma(n)>1/2$.
- If $\varphi$ is unsatisfiable, every proper hypothesis with the matching slice has verifier acceptance at most $s<1/2$, and every wrong-slice proper hypothesis has acceptance $0$ on this distribution.

Since $|R_\varphi|=\operatorname{poly}(|\varphi|)$, the reduction can enumerate all verifier random strings and compute the returned proper hypothesis's acceptance exactly. Accept iff this acceptance exceeds $1/2$. YES instances are accepted with the learner's success probability; NO instances are never accepted. This puts the NP-complete language in $\mathrm{RP}$.

Therefore, under $\mathrm{NP}\nsubseteq\mathrm{RP}$, the target node fails for a class satisfying the source node.

### Concrete Obstruction

The previous open-edge obstruction was that known properization hardness examples either required strong accuracy or did not satisfy the weak agnostic improper source. The active-slice construction removes both issues:

- the PCP soundness gap is already around the weak threshold $1/2$, so the target's weak proper guarantee is enough;
- the enlarged improper one-slice table class gives polynomial-time agnostic ERM against $\mathcal C$, so the source is satisfied directly.

No generic properization theorem can hold unless $\mathrm{NP}\subseteq\mathrm{RP}$.

### Atlas-Ready Proof And Metadata Changes

Atlas-ready verdict:

`efficient-weak-agnostic-improper-pac -> efficient-weak-agnostic-proper-pac` is `false`, under $\mathrm{NP}\nsubseteq\mathrm{RP}$.

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
  - bendavid2001
  - hastad2005query
  - karp1972
refs:
  - "[Ben-David et al. 2001](https://doi.org/10.1007/3-540-44581-1_33)"
  - "[Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)"
  - "[Karp 1972](https://doi.org/10.1007/978-1-4684-2001-2_9)"
summary: "The PCP active-slice lookup class is efficiently weak agnostic improperly learnable, but weak agnostic proper learning would put NP in RP."
family: pcp-active-slice-weak-proper-hardness
argument_note: "[[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]"
```

Atlas-ready body sketch:

> Use a perfect-completeness logarithmic-randomness PCP with soundness $s<1/2$. Proper hypotheses encode an instance/proof pair and are nonzero only on that instance's active verifier-randomness slice. The class is agnostically learnable improperly by ERM over the finite class of one-slice lookup tables, whose log-size is polynomial because each active slice has polynomial size. If a weak agnostic proper learner existed, run it on the all-positive uniform distribution over the active slice of an input instance. Perfect completeness forces acceptance above $1/2$ on satisfiable instances, while soundness keeps every proper hypothesis below $1/2$ on unsatisfiable instances. Enumerating the polynomially many random strings gives an RP algorithm for an NP-complete language.

### Promising Next Directions

- Update the neighboring edge `efficient-weak-agnostic-improper-pac -> efficient-weak-realizable-proper-pac` as well; the same witness and proof refute it once the agnostic improper source proof above is recorded.
- Strengthen `atlas/arguments/pcp-active-slice-weak-proper-hardness.md` to mention the one-slice-table ERM proof of weak agnostic improper learnability, not only realizable improper memorization.
- Recheck all `properization-open` edges whose target is weak proper and whose source can be satisfied by the same one-slice-table agnostic ERM witness.
