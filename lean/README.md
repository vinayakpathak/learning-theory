# Lean Formalization

This directory is a Lake project for formalizing pieces of the learning-theory atlas.

## Build

```sh
cd lean
~/.elan/bin/lake build
```

The project is pinned to Lean `v4.30.0-rc2` and depends on Mathlib and CSLib at matching tags.

## Current State

The checked Lean code currently provides:

- Boolean formula syntax and evaluation for literals, terms, clauses, DNF, and CNF.
- A proved DNF-to-CNF conversion:
  - `DNF.eval_toCNF`: semantic equivalence under every assignment.
  - `DNF.toCNF_widthBounded_of_length_le`: a DNF with at most `k` terms converts to a CNF with clause width at most `k`.
  - `DNF.clauseCount_toCNF_le_of_length_le`: fixed-`k` clause-count polynomial bound.
  - `DNF.literalCount_toCNF_le_of_length_le`: fixed-`k` total-literal polynomial bound.
- Finite Boolean assignments and formula-size measures.
- Minimal complexity-class interfaces for decision problems, reductions, inclusions, and separation witnesses.
- A CSLib-backed encoded decision-problem interface:
  - `EncodedDecisionProblem`: typed inputs with a concrete string encoding.
  - `EncodedManyOneReduction`: many-one reductions carrying a CSLib `PolyTimeComputable` string map.
  - derived polynomial output-length bounds for CSLib `PolyTimeComputable` functions and encoded reductions.
  - `EncodedComplexityLandscape`: an encoded `P`/`NP`/`RP` interface.
- Concrete bit-level predicates `BitComplexity.P`, `BitComplexity.NP`, and `BitComplexity.RP` using CSLib polynomial-time machines.
- Concrete inclusions `BitComplexity.P_subset_RP` and `BitComplexity.RP_subset_NP`.
- A deterministic `P` transfer theorem for a specific encoded many-one reduction when CSLib composition applies to the target decider.
- A Set Cover decision-problem interface and generic many-one hardness-transfer theorem.
- A graph-coloring decision-problem interface.
- Indexed, bit-encoded graph-coloring inputs over vertices `Fin n`, with verified unary/list/vertex-list/color-class/edge decoders and graph decoder left-inverse theorem.
- Boolean graph-coloring certificate checking, encoded certificate decoding, and verifying-string theorems.
- Graph-coloring certificate normalization, with an explicit polynomial bound on normalized certificate encoding length in the vertex count and color budget.
- Combined string verifiers for indexed graph coloring and indexed DNF consistency, with certificate bounds stated as polynomials of the input encoding length.
- Conditional concrete `NPVerifier` packages for indexed graph coloring and indexed DNF consistency, requiring only CSLib polynomial-time proofs for the verifier string functions.
- Abstract computational-learning interfaces for the proper/improper implication graph.
- Representation-level binary classification interfaces.
- Finite labeled samples, consistency predicates, and proper/improper sample-search decision problems.
- A fixed-`k` DNF target class with a proved exact improper `k`-CNF representation.
- Indexed, bit-encoded fixed-`k` DNF consistency inputs over variables `Fin n`, with verified assignment/example/sample decoders and target decoder left-inverse theorem.
- Normalized fixed-`k` DNF certificates, with a proved polynomial bound on encoded certificate length in the variable count and term budget.
- A proved many-one reduction from graph coloring to proper fixed-`k` DNF consistency.
- A proved many-one reduction from indexed graph coloring to indexed proper fixed-`k` DNF consistency.
- A concrete graph-to-DNF bit-string transformer with a proof that it agrees with the mathematical reduction on valid encodings.
- A strengthened proof that the graph-to-DNF bit-string transformer preserves arbitrary trailing suffixes after valid graph encodings.
- A polynomial output-length bound for the graph-to-DNF bit-string transformer on valid source encodings, including the suffix-preserving case.
- Verifier-composition lemmas showing that target verifier acceptance after the graph-to-DNF string map soundly and completely reflects source graph-coloring acceptance.
- A machine-level lifting theorem: a CSLib polynomial-time implementation proof for that transformer yields an `EncodedManyOneReduction`.
- A suffix-preserving encoded-reduction interface, with the graph-to-DNF transformer packaged into that interface once its CSLib polynomial-time proof is supplied.
- Named certificate interfaces for indexed graph coloring and indexed DNF consistency, with explicit certificate transfer through the reduction.
- A reduction output-size theorem: the produced DNF-consistency sample has exactly `n + |E|` examples.
- A final conditional theorem: assuming graph coloring is NP-hard in a chosen landscape, `RP` is closed under many-one reductions, and `RP != NP`, proper fixed-`k` DNF consistency is not in `RP`.
- A compiled toy countermodel that tests the proper/improper plumbing.

The remaining nontrivial pieces are the concrete NP-hardness proof for indexed graph coloring, the CSLib polynomial-time proof for the encoded graph-to-DNF string map, and the CSLib machine construction needed for closure of concrete bit-level `RP` under encoded many-one reductions.
