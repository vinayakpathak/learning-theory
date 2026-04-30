# Learning Atlas Obsidian Notes

This directory is the queryable source of truth for the learning-definition graph. It is intentionally separate from the LaTeX report for now.

## Structure

- `definitions/`: one note per learning notion.
- `implications/`: one note per ordered implication between notions.
- `dashboards/`: Obsidian dashboard notes that query the graph with Dataview.

## Conventions

Definition notes are graph nodes. They use `type: definition` and must have a stable `id`.

Definition notes may also carry queryable axes such as `realizability`, `properness`, `strength`, and `distribution`. In the binary PAC dashboard, existing nodes without `weak` in their id are the strong learning notions. Marginal-nonuniform nodes use `distribution: marginal-nonuniform` and allow the polynomial PAC bounds to depend on the instance marginal distribution.

Implication notes are graph edges. They use `type: implication`, a `source` id, a `target` id, and a quoted `status`.

References use two fields when a note needs citations:

- `ref_keys` or `characterization_ref_keys`: stable BibTeX keys for scripts and cross-checking.
- `refs` or `characterization_refs`: clickable Markdown links for Obsidian display.

Example:

```yaml
ref_keys:
  - kearns1994
refs:
  - "[Kearns et al. 1994](https://doi.org/10.1023/A:1022615600103)"
```

Also include a normal Markdown `## References` section in note bodies when a note cites papers, so the links are clickable even outside Dataview tables.

Use these status values:

- `status: "true"` for known implications.
- `status: "false"` for known non-implications or separations.
- `status: "open"` for unresolved edges.

Use `evidence` to explain why the status is known:

- `trivial`
- `theorem`
- `conditional-theorem`
- `counterexample`
- `conditional-counterexample`
- `unknown`

If a false edge depends on a complexity or cryptographic assumption, keep `status: "false"` and record the assumption in `assumptions`.

Do not duplicate incoming or outgoing edge lists inside definition frontmatter. Query them from `implications/` instead.

Use Obsidian math syntax in note bodies when writing formal definitions or proof sketches:

- Inline math: `$h \in \mathcal C$`
- Display math:

```text
$$
\operatorname{err}_D(h,c) \le \varepsilon
$$
```

Keep frontmatter values plain and query-friendly. Put rendered mathematical notation in the Markdown body rather than in YAML fields.

## Obsidian Setup

Install and enable the Dataview plugin to render the dashboard tables. The main dashboard is:

- [[dashboards/binary-classification|Binary Classification Dashboard]]
