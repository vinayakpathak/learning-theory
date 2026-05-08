# Edge: efficient-agnostic-improper-pac -> efficient-weak-realizable-proper-pac

- depth: 1
- edge_file: atlas/implications/efficient-agnostic-improper-pac--implies--efficient-weak-realizable-proper-pac.md
- verdict: resolved-false
- confidence: high

## Context

The edge asks whether an efficient strong agnostic improper PAC learner for a class $\mathcal C$ forces an efficient weak realizable proper PAC learner for the same class. The current edge note leaves this open as a generic properization question and discusses fixed-$k$ DNF as a near miss.

The atlas now contains a sharper witness family: [[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]], with argument note [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]. That argument explicitly says the witness is not only weakly improperly realizably learnable, but efficiently agnostically learnable by an improper one-slice lookup-table ERM.

Relevant checked notes:

- `atlas/implications/efficient-agnostic-improper-pac--implies--efficient-weak-realizable-proper-pac.md`: currently `open`.
- `atlas/definitions/efficient-agnostic-improper-pac.md`: source allows arbitrary improper hypotheses and requires agnostic excess error.
- `atlas/definitions/efficient-weak-realizable-proper-pac.md`: target requires a proper $h \in \mathcal C$ with inverse-polynomial advantage over $1/2$ on every realizable distribution.
- `atlas/arguments/pcp-active-slice-weak-proper-hardness.md`: gives the conditional counterexample under $\mathrm{NP}\nsubseteq\mathrm{RP}$.
- `atlas/implications/efficient-weak-realizable-improper-pac--implies--efficient-weak-realizable-proper-pac.md`: already records the same witness as a false edge for the weaker improper-realizable source.
- `atlas/implications/efficient-agnostic-improper-pac--implies--efficient-weak-agnostic-proper-pac.md`: already uses the same witness for the stronger weak-agnostic proper target.

## Attempted Resolution

**Goal.** Separate efficient agnostic improper PAC learning from efficient weak realizable proper PAC learning.

**Witness.** Use the PCP active-slice lookup class. A perfect-completeness PCP with $O(\log n)$ random bits and soundness $s<1/2$ is fixed. Proper concepts are indexed by an NP instance $\varphi$ and proof string $\pi$. On input $(\psi,r)$, the concept evaluates the verifier $V(\varphi,\pi,r)$ if $\psi=\varphi$, and returns $0$ otherwise.

**Why the source holds.** For each size $n$, each active slice $\{(\varphi,r)\}$ has polynomial size because the verifier has logarithmic randomness. The improper comparison class used by the atlas argument consists of all one-slice lookup tables plus the all-zero function. Its logarithmic size is polynomial: choose the active slice, then choose labels on polynomially many random strings. Given a sample, only sampled slices can improve over all-zero, and the best table on a sampled slice is found by empirical majority on the observed random strings. Finite-class uniform convergence then gives an efficient agnostic improper PAC learner against the proper PCP class.

This is stronger than needed for the source node, since the source is exactly efficient agnostic improper PAC learning.

**Why the target fails.** Suppose an efficient weak realizable proper learner existed. On input $\varphi$, draw examples uniformly from the active slice $\{(\varphi,r)\}$ and label every example by $1$.

If $\varphi$ is satisfiable, perfect completeness gives a proof $\pi$ whose proper concept labels every point in the active slice by $1$, so the distribution is realizable. The weak proper learner must return a proper concept with error at most $1/2-\gamma$, hence a proof accepted on more than half of the verifier random strings.

If $\varphi$ is unsatisfiable, PCP soundness says every proof is accepted on at most an $s<1/2$ fraction of random strings. Since the active slice has polynomial size, the returned proper concept's acceptance can be estimated to sufficient accuracy, or enumerated exactly, in polynomial time. Taking the PCP soundness gap below $1/2$ and the learner's inverse-polynomial advantage gives an RP decision procedure for an NP-complete language. Under $\mathrm{NP}\nsubseteq\mathrm{RP}$, no such weak proper learner exists.

This resolves the edge as false under $\mathrm{NP}\nsubseteq\mathrm{RP}$.

## Proposed Atlas Update

Frontmatter:

```yaml
status: "false"
evidence: conditional-counterexample
result_origin: "unclear"
assumptions:
  - "NP not subset RP"
witnesses:
  - pcp-active-slice-lookup-class
witness_note: "[[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]]"
ref_keys:
  - blumer1989
  - hastad2005query
  - karp1972
refs:
  - "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
  - "[Håstad and Khot 2005](https://doi.org/10.4086/toc.2005.v001a007)"
  - "[Karp 1972](https://doi.org/10.1007/978-3-540-68279-0_8)"
summary: "False under NP not subset RP: the PCP active-slice lookup class is efficiently agnostically learnable improperly, but weak proper realizable learning would decide an NP-complete language."
family: pcp-active-slice-weak-proper-hardness
argument_note: "[[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]"
```

Replacement body sketch:

```markdown
# Efficient Agnostic Improper PAC Learning $\Rightarrow$ Efficient Weak Realizable Proper PAC Learning

## Verdict

`false`, under the assumption $\mathrm{NP}\nsubseteq\mathrm{RP}$.

The [[pcp-active-slice-lookup-class|PCP Active-Slice Lookup Class]] is efficiently agnostically learnable by an improper one-slice lookup-table ERM, but an efficient weak proper realizable learner would decide an NP-complete language with one-sided randomized error.

## Proof Status

**Goal.** Separate agnostic improper learning from weak realizable proper learning.

**Witness construction.** Use the PCP active-slice class from [[pcp-active-slice-weak-proper-hardness|PCP Active-Slice Weak Proper Hardness]]. A proper concept is indexed by an NP instance $\varphi$ and a proof $\pi$; on an example $(\psi,r)$ it runs the verifier on $(\varphi,\pi,r)$ if $\psi=\varphi$, and outputs $0$ otherwise.

**Why the source holds.** The verifier uses $O(\log n)$ random bits, so each active slice has polynomial size. The improper learner runs ERM over one-slice lookup tables and the all-zero hypothesis. Only sampled slices need be considered, and the best table on a sampled slice is obtained by empirical majority vote. Since this finite improper class contains all proper concepts and has polynomial logarithmic size, standard finite-class uniform convergence gives efficient agnostic improper learning.

**Why the target fails.** Given an instance $\varphi$, sample uniformly from its active slice and label every point by $1$. If $\varphi$ is satisfiable, perfect completeness makes this distribution realizable by a proper concept, so a weak proper learner returns a proof accepted on more than half the random strings. If $\varphi$ is unsatisfiable, every proof is accepted on at most an $s<1/2$ fraction. The active slice is polynomial size, so acceptance can be checked to distinguish the two cases in randomized polynomial time. Thus the target would imply $\mathrm{NP}\subseteq\mathrm{RP}$.
```

## Obstacles

No remaining obstacle for this edge. The existing open note's DNF near miss is superseded by the PCP active-slice witness because that witness satisfies the stronger source node.

One minor atlas-cleanup issue: `atlas/implications/efficient-weak-realizable-improper-pac--implies--efficient-weak-realizable-proper-pac.md` cites Karp with DOI `10.1007/978-1-4684-2001-2_9`, while the argument and witness notes cite `10.1007/978-3-540-68279-0_8`. This does not affect the verdict, but the atlas may want DOI consistency.

## Next Directions

- Update the assigned edge note to the PCP active-slice false witness.
- Optionally check whether other `properization-open` edges with source at least as strong as efficient agnostic improper PAC should be moved to the same witness family.
- Normalize the Karp DOI across the PCP active-slice notes if desired.

## References Checked

- Blumer, Ehrenfeucht, Haussler, and Warmuth, "Learnability and the Vapnik-Chervonenkis dimension," 1989.
- Håstad and Khot, "Query efficient PCPs with perfect completeness," 2005.
- Karp, "Reducibility among combinatorial problems," 1972.
- Existing atlas notes listed in the Context section above.
