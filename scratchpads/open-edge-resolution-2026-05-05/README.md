# Open Edge Resolution Run, 2026-05-05

Each worker owns exactly one edge scratchpad at:

```text
scratchpads/open-edge-resolution-2026-05-05/<edge-slug>/scratchpad.md
```

## Worker Protocol

1. Inspect the edge note, the source and target definition notes, and any linked argument or witness notes.
2. Try to resolve the implication as `true` or `false`.
3. Use source-grounded reasoning. Cite existing atlas notes and primary references when making theorem or hardness claims.
4. Edit only your assigned `scratchpad.md`; do not edit atlas files.
5. If resolved, include a proposed atlas update: status, evidence, assumptions, witnesses, refs, summary, and a replacement proof/body sketch.
6. If unresolved, include concrete obstacles and two to four next directions that a depth-child worker could pursue.

## Scratchpad Template

```markdown
# Edge: <source> -> <target>

- depth: <n>
- edge_file: atlas/implications/<slug>.md
- verdict: resolved-true | resolved-false | unresolved
- confidence: low | medium | high

## Context

## Attempted Resolution

## Proposed Atlas Update

## Obstacles

## Next Directions

## References Checked
```
