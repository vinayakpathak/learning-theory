---
type: implication
id: efficient-weak-realizable-proper-pac__implies__efficient-agnostic-proper-pac
source: efficient-weak-realizable-proper-pac
target: efficient-agnostic-proper-pac
source_note: "[[efficient-weak-realizable-proper-pac|Efficient Weak Realizable Proper PAC Learning]]"
target_note: "[[efficient-agnostic-proper-pac|Efficient Agnostic Proper PAC Learning]]"
domain: binary-classification
model: pac
status: "false"
evidence: conditional-counterexample
assumptions:
  - RP != NP
witnesses:
  - conjunctions
ref_keys:
  - valiant1984
  - kearns1994
refs:
  - "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
  - "[Kearns et al. 1994](https://doi.org/10.1023/A:1022615600103)"
summary: "Conjunctions are weakly realizably properly learnable, but strong proper agnostic learning is hard unless RP = NP."
family: conjunction-agnostic-hardness
axis_delta:
  resource: same
  distribution: same
  strength: weak-to-strong
  realizability: realizable-to-agnostic
  properness: same
argument_note: "[[conjunction-agnostic-hardness|Conjunction Agnostic Hardness]]"
witness_note: "[[conjunctions|Conjunctions]]"
tags:
  - atlas/implication
  - learning/binary-classification
---

# Efficient Weak Realizable Proper PAC Learning $\Rightarrow$ Efficient Agnostic Proper PAC Learning

## Verdict

`false`, under RP != NP.

Conjunctions are weakly realizably properly learnable, but strong proper agnostic learning is hard unless RP = NP.

## Proof Sketch

**Goal.** Refute the implication under $\mathrm{RP}\ne\mathrm{NP}$.

**Construction.** Use conjunctions. The classical realizable proper learner for conjunctions is already strong, hence also weak.

**Why the target fails.** Kearns, Schapire, and Sellie show that efficient proper agnostic learning of conjunctions would yield a randomized polynomial-time algorithm for minimum set cover.

**Conclusion.** The source node holds for conjunctions, while the target node fails unless $\mathrm{RP}=\mathrm{NP}$.

## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Kearns et al. 1994](https://doi.org/10.1023/A:1022615600103)
