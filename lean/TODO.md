# Lean Formalization TODO

Goal: formalize the proper-vs-improper separation for fixed-`k` term DNF without importing the Pitt-Valiant theorem as an axiom.

## Completed

- [x] Set up a Lake project with Mathlib and CSLib.
- [x] Define Boolean literals, terms, clauses, DNF, CNF, and evaluation.
- [x] Prove DNF-to-CNF semantic correctness.
- [x] Prove a DNF with at most `k` terms converts to CNF with clause width at most `k`.
- [x] Prove fixed-`k` DNF-to-CNF clause-count and total-literal polynomial size bounds.
- [x] Define abstract computational-learning implication wrappers.
- [x] Add a small no-shortcuts toy counterexample for plumbing tests.
- [x] Define finite labeled samples and consistency.
- [x] Package the fixed-`k` DNF target class with the generated `k`-CNF improper representation.
- [x] Define finite Boolean instance spaces and formula-size measures.
- [x] Define proper learning/search problems over samples.
- [x] Formalize Set Cover decision problem interface for other atlas edges.
- [x] Formalize graph-coloring decision problem interface for the Pitt-Valiant route.
- [x] Add generic many-one hardness-transfer theorem.
- [x] Add randomized polynomial-time and `RP`/`NP` interfaces compatible with CSLib or Mathlib.
- [x] Construct the Pitt-Valiant-style reduction from graph coloring to proper fixed-`k` DNF consistency.
- [x] Prove the final conditional theorem assuming `RP ≠ NP` and graph-coloring NP-hardness.
- [x] Add a CSLib-backed encoded decision-problem interface and encoded many-one reductions.
- [x] Add concrete bit encodings for indexed graph-coloring inputs.
- [x] Add concrete bit encodings for indexed fixed-`k` DNF consistency inputs.
- [x] Define concrete bit-level `P`, `NP`, and `RP` predicates using CSLib polynomial-time machines.
- [x] Prove `P ⊆ RP` and `RP ⊆ NP` for the concrete bit-level predicates.
- [x] Define the concrete bit-complexity landscape from the remaining `RP` many-one closure theorem.
- [x] Add verified unary/list decoders and graph vertex/edge/edge-list decoders.
- [x] Prove graph decoding is a left inverse of indexed graph encoding, with explicit edge-list fuel.
- [x] Add verified assignment/example/sample decoders for indexed DNF-consistency inputs.
- [x] Prove DNF-consistency input decoding is a left inverse of indexed target encoding, with explicit sample-list fuel.
- [x] Add length-fuel left-inverse decoders for both graph inputs and DNF-consistency target inputs.
- [x] Define the concrete graph-to-DNF bit-string transformer and prove it agrees with the mathematical reduction on valid encodings.
- [x] Prove the concrete graph-to-DNF bit-string transformer produces decodable target inputs on valid graph encodings.
- [x] Prove the reduction output sample length is exactly `n + |E|`.
- [x] Add named certificate interfaces for indexed graph coloring and indexed DNF consistency.
- [x] Prove certificates map through the indexed graph-to-DNF reduction in both directions.
- [x] Add verified encodings/decoders for vertex lists and color-class lists.
- [x] Prove the indexed graph-coloring to indexed fixed-`k` DNF consistency reduction.
- [x] Add a machine-level lifting theorem for the indexed reduction: a CSLib polynomial-time string implementation of the map yields an `EncodedManyOneReduction`.
- [x] Add Boolean graph-coloring certificate checking, encoded certificate decoding, and verifying-string soundness/completeness.
- [x] Prove graph-coloring certificates can be normalized and encoded with an explicit polynomial size bound in the vertex count and color budget.
- [x] Prove the concrete graph-to-DNF encoded map is suffix-preserving on valid graph encodings.
- [x] Add a suffix-preserving encoded-reduction interface and package the indexed graph-to-DNF map into it, conditional only on the CSLib polynomial-time proof for the string transformer.
- [x] Add normalized fixed-`k` DNF certificates with a polynomial encoded-size bound for arbitrary accepted indexed DNF-consistency inputs.
- [x] Add combined string verifiers for indexed graph coloring and indexed DNF consistency, with soundness, completeness, and certificate bounds in terms of input encoding length.
- [x] Package conditional concrete `NPVerifier`s for indexed graph coloring and indexed DNF consistency, assuming only CSLib polynomial-time proofs for the combined verifier strings.
- [x] Prove indexed DNF-consistency input encodings have a simple length bound from sample size, variable count, and budget.
- [x] Prove the concrete graph-to-DNF encoded reduction has polynomially bounded output length on valid source encodings, including suffix-preserving output-length control.
- [x] Replace indexed graph-to-DNF certificate transfers with explicit constructions instead of using choice.
- [x] Prove generic CSLib `PolyTimeComputable` functions, and hence encoded many-one reductions, have polynomially bounded output length.
- [x] Prove deterministic bit-level `P` is closed under a specific encoded many-one reduction when CSLib composition applies to the target decider.
- [x] Prove target combined-verifier acceptance after the graph-to-DNF string map is equivalent to source graph-coloring acceptance at the certificate-existence level.
- [x] Add monotone CSLib polynomial-time wrappers for computable functions, encoded many-one reductions, and deterministic deciders, with compiled identity/composition and deterministic `P` closure.
- [x] Prove a compiled `RP` closure theorem for suffix-preserving reductions with an exact compatible source random-length function.
- [x] Add monotone encoded and suffix-preserving graph-to-DNF lifting theorems, conditional on a monotone CSLib polynomial-time implementation of the concrete string transformer.
- [x] Add a monotone-reduction variant of the encoded conditional lower bound, eliminating the separate monotonicity parameter from that theorem.
- [x] Prove natural-coefficient polynomial evaluation is monotone and retime arbitrary CSLib polynomial-time computations by their polynomial bounds.
- [x] Add retimed composition for CSLib polynomial-time functions, encoded many-one reductions, encoded NP-hardness transfer, deterministic `P` closure, and compatible-random-length `RP` closure.
- [x] Add a retimed encoded conditional lower bound that no longer needs any separate monotonicity assumption on the graph-to-DNF encoded reduction.
- [x] Add a strengthened code-dependent `CodeRPDecider` interface and prove closure under suffix-preserving encoded reductions with polynomial random-length transport.
- [x] Prove right-inverse facts for successful unary and delimiter-list decoders: successful parsing reconstructs the original encoded prefix and returned suffix.
- [x] Lift successful-parser right-inverse facts to graph vertices, vertex lists, color-class lists, checked edges, and checked-edge lists.
- [x] Prove successful indexed-graph decoding reconstructs the graph encoding prefix and returned suffix.
- [x] Prove an all-input polynomial output-length bound for the concrete graph-to-DNF string transformer, including malformed strings.
- [x] Package `CodeRP` closure under suffix-preserving encoded reductions as a class-level theorem.
- [x] Lift successful-parser right-inverse facts to assignments, examples, samples, and indexed DNF-consistency inputs.

## Remaining

- [ ] Prove the graph-coloring source problem is NP-hard in the concrete bit-complexity model.
- [ ] Prove the graph-coloring to DNF-consistency map is an `EncodedManyOneReduction`, i.e. supply a CSLib polynomial-time string transformer for the encoded map.
- [ ] Decide whether to replace the length-based `RPDecider` landscape with the strengthened `CodeRPDecider` landscape, or prove an additional decoder/truncation theorem connecting the two.
- [ ] Develop enough CSLib single-tape list-processing machines to prove polynomial time for nontrivial parsers/encoders, not just identity and composition.
