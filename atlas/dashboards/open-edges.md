---
type: dashboard
id: open-edges-dashboard
title: Open Edges Dashboard
domain: binary-classification
filter_resource: samples
filter_distribution: distribution-free
filter_strength:
filter_realizability: agnostic
filter_properness:
tags:
  - atlas/dashboard
  - learning/binary-classification
---

# Open Edges Dashboard

This dashboard lists implication edges whose status is `open`.

Dataview must be enabled in Obsidian for the table below to render. To filter the table, set any of the `filter_*` fields in this note's frontmatter. Leave a field as `null` to ignore that axis.

Supported values are:

- `filter_resource`: `computationally-efficient`, `sample-efficient`, or aliases `computational`, `efficient`, `sample`, `samples`
- `filter_distribution`: `distribution-free`, `marginal-nonuniform`
- `filter_strength`: `strong`, `weak`
- `filter_realizability`: `agnostic`, `realizable`
- `filter_properness`: `proper`, `improper`

## Open Edges

```dataviewjs
const axisFields = [
  "resource",
  "distribution",
  "strength",
  "realizability",
  "properness"
];

const aliases = {
  resource: {
    computational: "computationally-efficient",
    efficient: "computationally-efficient",
    sample: "sample-efficient",
    samples: "sample-efficient"
  }
};

const normalize = (axis, value) => {
  if (value === null || value === undefined || value === "" || value === "all") return null;
  const raw = String(value).trim();
  return aliases[axis]?.[raw] ?? raw;
};

const current = dv.current();
const filters = Object.fromEntries(
  axisFields
    .map(axis => [axis, normalize(axis, current[`filter_${axis}`])])
    .filter(([, value]) => value)
);

const defsById = new Map(
  dv.pages('"atlas/definitions"')
    .where(p => p.type === "definition" && p.domain === "binary-classification")
    .array()
    .map(p => [p.id, p])
);

const edgeMatches = edge => {
  const source = defsById.get(edge.source);
  const target = defsById.get(edge.target);
  if (!source || !target) return false;

  return Object.entries(filters).every(([axis, value]) =>
    source[axis] === value && target[axis] === value
  );
};

const openEdges = dv.pages('"atlas/implications"')
  .where(p => p.type === "implication" && p.domain === "binary-classification" && p.status === "open")
  .where(edgeMatches)
  .sort(p => `${p.family}-${p.source}-${p.target}`)
  .array();

const active = Object.entries(filters).map(([axis, value]) => `${axis} = ${value}`).join(", ");
dv.paragraph(active ? `Active filters: ${active}` : "Active filters: none");

dv.table(
  ["Source", "Target", "Family", "Argument", "Refs", "Summary"],
  openEdges.map(edge => [
    edge.source_note,
    edge.target_note,
    edge.family,
    edge.argument_note,
    edge.refs,
    edge.summary
  ])
);
```
