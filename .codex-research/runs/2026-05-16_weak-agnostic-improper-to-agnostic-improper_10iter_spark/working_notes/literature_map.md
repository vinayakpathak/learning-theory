# Literature Map

## Iteration-10 map

- No new primary theorem was pinned in iter_010 that fully instantiates `err_D(h) ≤ OPT_C(D)+β` (fixed additive slack, `{0,1}` outputs, distribution-free, efficient) to an exact `OPT+ε` theorem in this model.

- The Route-D matrix is now explicitly the gating task: theorem IDs, contracts, normalization, output requirements, and dependence on `(β, ε, δ, n)` for:
  - KMV08
  - Feldman distribution-specific agnostic boosting
  - potential-based fixed-weak variants

- The same unresolved literature-gap remains:
  - which entries can accept fixed-offset `{0,1}` weak oracles without additional confidence/margin signals;
  - which entries can guarantee final `OPT+ε` rather than `OPT+α+ε` under atlas semantics.

- Negative/precision branch remains conditional and un-mapped:
  - identify SQ/precision lower bounds exactly matching fixed-slack `0/1` oracles and wrapper/adaptivity constraints before any formal Route-C claim.

- Immediate next bibliographic actions:
  1. extract theorem numbers and exact statements for each candidate route-D item,
  2. resolve oracle-interface compatibility line by line,
  3. attach stable keys in `references.bib` only after parameter/assumption confirmation.
