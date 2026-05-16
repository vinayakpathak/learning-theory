---
type: argument
id: multiclass-low-noise-weak-agnostic-robustification
title: Multiclass Low-Noise Weak Agnostic Robustification
domain: multiclass-classification
model: pac
status: open
evidence: unknown
ref_keys:
- valiant1984
- blumer1989
refs:
- "[Valiant 1984](https://doi.org/10.1145/1968.1972)"
- "[Blumer et al. 1989](https://doi.org/10.1145/76359.76371)"
tags:
- atlas/argument
- learning/multiclass-classification
---

# Multiclass Low-Noise Weak Agnostic Robustification

## Verdict

`open`, with evidence `unknown`.

The binary low-noise robustification does not transfer as a theorem to finite-label multiclass classes with the weak convention used here. In the binary proof, a high-noise branch can fall back to one of two constants, because one constant has error at most $1/2$. For $k\ge 3$ labels, the best constant can have error $1-1/k$, which may exceed the majority weak threshold $1/2$.

The low-noise branch still suggests a route, but the middle- and high-noise cases need a genuine multiclass neutralizer or another selector that attains $\operatorname{OPT}+\beta$ for some fixed $\beta<1/2$. The atlas therefore leaves these edges open rather than importing the binary proof.

## Scope

The multiclass atlas is finite-label and separate from the binary atlas. The embedding observations here are used only to transfer lower-bound examples into the multiclass type; they do not create implication edges between binary and multiclass nodes.


## References

- [Valiant 1984](https://doi.org/10.1145/1968.1972)
- [Blumer et al. 1989](https://doi.org/10.1145/76359.76371)
