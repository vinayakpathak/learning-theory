---
type: dashboard
id: binary-classification-dashboard
title: Binary Classification Dashboard
domain: binary-classification
tags:
  - atlas/dashboard
  - learning/binary-classification
---

# Binary Classification Dashboard

This dashboard treats learning notions as nodes and implications as directed edges. It tracks binary PAC notions from the report notes, including computationally efficient versus sample-efficient, realizable/agnostic, proper/improper, strong/weak, and distribution-free versus marginal-nonuniform axes.

Dataview must be enabled in Obsidian for the tables below to render.

Formal definitions and proof sketches live in the individual notes and use Obsidian's `$...$` and `$$...$$` math syntax where helpful.

## Axis-Generated Immediate Relaxations

```dataviewjs
const edges = dv.pages('"atlas/implications"')
  .where(p => p.type === "implication" && p.domain === "binary-classification" && p.family === "monotone-relaxation")
  .array();

const changes = edge => Object.entries(edge.axis_delta ?? {})
  .filter(([_, value]) => value !== "same");

const immediate = edges
  .map(edge => ({ edge, changes: changes(edge) }))
  .filter(row => row.changes.length === 1)
  .sort((a, b) => `${a.changes[0][0]}-${a.edge.source}`.localeCompare(`${b.changes[0][0]}-${b.edge.source}`));

dv.table(
  ["Axis", "Source", "Target", "Delta", "Edge"],
  immediate.map(({ edge, changes }) => [
    changes[0][0],
    edge.source_note,
    edge.target_note,
    changes[0][1],
    edge.file.link
  ])
);
```

## Implication Families

```dataviewjs
const edges = dv.pages('"atlas/implications"')
  .where(p => p.type === "implication" && p.domain === "binary-classification")
  .array();

const argumentsById = new Map(
  dv.pages('"atlas/arguments"')
    .where(p => p.type === "argument" && p.domain === "binary-classification")
    .array()
    .map(p => [p.id, p])
);

const grouped = new Map();
for (const edge of edges) {
  const family = edge.family ?? "unclassified";
  if (!grouped.has(family)) grouped.set(family, []);
  grouped.get(family).push(edge);
}

dv.table(
  ["Family", "Status", "Edges", "Evidence", "Argument"],
  Array.from(grouped.entries())
    .sort(([a], [b]) => a.localeCompare(b))
    .map(([family, familyEdges]) => {
      const argument = argumentsById.get(family);
      const statuses = [...new Set(familyEdges.map(e => e.status))].join(", ");
      const evidence = [...new Set(familyEdges.map(e => e.evidence))].join(", ");
      return [
        argument ? argument.file.link : family,
        statuses,
        familyEdges.length,
        evidence,
        familyEdges[0].argument_note
      ];
    })
);
```

## Witness Coverage

```dataviewjs
const falseEdges = dv.pages('"atlas/implications"')
  .where(p => p.type === "implication" && p.domain === "binary-classification" && p.status === "false")
  .array();

const witnessesById = new Map(
  dv.pages('"atlas/witnesses"')
    .where(p => p.type === "witness" && p.domain === "binary-classification")
    .array()
    .map(p => [p.id, p])
);

const grouped = new Map();
for (const edge of falseEdges) {
  for (const witness of edge.witnesses ?? []) {
    if (!grouped.has(witness)) grouped.set(witness, []);
    grouped.get(witness).push(edge);
  }
}

dv.table(
  ["Witness", "False Edges", "Assumptions", "Families"],
  Array.from(grouped.entries())
    .sort(([a], [b]) => a.localeCompare(b))
    .map(([witness, witnessEdges]) => {
      const page = witnessesById.get(witness);
      const assumptions = [...new Set(witnessEdges.flatMap(e => e.assumptions ?? []))].join(", ");
      const families = [...new Set(witnessEdges.map(e => e.family))].join(", ");
      return [page ? page.file.link : witness, witnessEdges.length, assumptions, families];
    })
);
```

## Open Questions by Obstruction

```dataview
TABLE length(rows) AS "Open Edges", rows.argument_note[0] AS "Argument", rows.refs[0] AS "Representative Refs"
FROM "atlas/implications"
WHERE type = "implication" AND domain = "binary-classification" AND status = "open"
GROUP BY family
SORT length(rows) DESC
```

## Definitions

```dataview
TABLE title AS "Definition", model AS "Model", resource AS "Resource", distribution AS "Distribution", realizability AS "Realizability", properness AS "Properness", strength AS "Strength", characterization_status AS "Characterization", characterization AS "Characterization Note"
FROM "atlas/definitions"
WHERE type = "definition" AND domain = "binary-classification"
SORT model ASC, resource ASC, distribution ASC, strength ASC, realizability DESC, properness DESC
```

## Characterization Status

```dataview
TABLE title AS "Definition", characterization_status AS "Status", characterization_refs AS "Refs", characterization AS "Note"
FROM "atlas/definitions"
WHERE type = "definition" AND domain = "binary-classification"
SORT characterization_status ASC, title ASC
```

## All Implications

```dataview
TABLE source_note AS "Source", target_note AS "Target", status AS "Status", family AS "Family", evidence AS "Evidence", assumptions AS "Assumptions", witness_note AS "Witness", argument_note AS "Argument", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication" AND domain = "binary-classification"
SORT family ASC, source ASC, target ASC
```

## Audit Matrix

```dataviewjs
const defs = dv.pages('"atlas/definitions"')
  .where(p => p.type === "definition" && p.domain === "binary-classification")
  .sort(p => `${p.resource === "computationally-efficient" ? "0" : "1"}-${p.distribution === "distribution-free" ? "0" : "1"}-${p.strength === "strong" ? "0" : "1"}-${p.realizability}-${p.properness}-${p.title}`)
  .array();

const edges = dv.pages('"atlas/implications"')
  .where(p => p.type === "implication" && p.domain === "binary-classification")
  .array();

const edgeByPair = new Map();
for (const edge of edges) {
  edgeByPair.set(`${edge.source}=>${edge.target}`, edge);
}

const statusLabel = edge => {
  if (!edge) return "missing";
  const assumptions = edge.assumptions && edge.assumptions.length
    ? ` (${edge.assumptions.join(", ")})`
    : "";
  return dv.fileLink(edge.file.path, false, `${edge.status}${assumptions}`);
};

dv.table(
  ["Source / Target", ...defs.map(d => d.file.link)],
  defs.map(source => [
    source.file.link,
    ...defs.map(target => source.id === target.id
      ? "same"
      : statusLabel(edgeByPair.get(`${source.id}=>${target.id}`)))
  ])
);
```

## Known True Implications

```dataview
TABLE source_note AS "Source", target_note AS "Target", family AS "Family", evidence AS "Evidence", argument_note AS "Argument", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication" AND domain = "binary-classification" AND status = "true"
SORT family ASC, source ASC, target ASC
```

## Known False Implications

```dataview
TABLE source_note AS "Source", target_note AS "Target", family AS "Family", evidence AS "Evidence", assumptions AS "Assumptions", witness_note AS "Witness", argument_note AS "Argument", refs AS "Refs", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication" AND domain = "binary-classification" AND status = "false"
SORT family ASC, assumptions ASC, source ASC, target ASC
```

## Open Implications

```dataview
TABLE source_note AS "Source", target_note AS "Target", family AS "Family", argument_note AS "Argument", refs AS "Refs", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication" AND domain = "binary-classification" AND status = "open"
SORT family ASC, source ASC, target ASC
```

## Query A Specific Edge

Change the `source` and `target` values below to inspect a particular ordered implication.

```dataview
TABLE source_note AS "Source", target_note AS "Target", status AS "Status", evidence AS "Evidence", assumptions AS "Assumptions", witnesses AS "Witnesses", refs AS "Refs", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication"
  AND source = "efficient-realizable-proper-pac"
  AND target = "efficient-agnostic-improper-pac"
```
