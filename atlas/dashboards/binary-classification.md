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

This dashboard treats learning notions as nodes and implications as directed edges. It tracks efficient binary PAC notions from the report notes, including realizable/agnostic, proper/improper, strong/weak, and distribution-free versus marginal-nonuniform axes.

Dataview must be enabled in Obsidian for the tables below to render.

Formal definitions and proof sketches live in the individual notes and use Obsidian's `$...$` and `$$...$$` math syntax where helpful.

## Definitions

```dataview
TABLE title AS "Definition", model AS "Model", distribution AS "Distribution", realizability AS "Realizability", properness AS "Properness", strength AS "Strength", resource AS "Resource", characterization_status AS "Characterization", characterization AS "Characterization Note"
FROM "atlas/definitions"
WHERE type = "definition" AND domain = "binary-classification"
SORT model ASC, distribution ASC, strength ASC, realizability DESC, properness DESC
```

## Characterization Status

```dataview
TABLE title AS "Definition", characterization_status AS "Status", characterization_refs AS "Refs", characterization AS "Note"
FROM "atlas/definitions"
WHERE type = "definition" AND domain = "binary-classification"
SORT characterization_status ASC, title ASC
```

## Implication Matrix

```dataviewjs
const defs = dv.pages('"atlas/definitions"')
  .where(p => p.type === "definition" && p.domain === "binary-classification")
  .sort(p => `${p.distribution === "distribution-free" ? "0" : "1"}-${p.strength === "strong" ? "0" : "1"}-${p.realizability}-${p.properness}-${p.title}`)
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

## All Implications

```dataview
TABLE source_note AS "Source", target_note AS "Target", status AS "Status", evidence AS "Evidence", assumptions AS "Assumptions", witnesses AS "Witnesses", refs AS "Refs", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication" AND domain = "binary-classification"
SORT source ASC, target ASC
```

## Known True Implications

```dataview
TABLE source_note AS "Source", target_note AS "Target", evidence AS "Evidence", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication" AND domain = "binary-classification" AND status = "true"
SORT source ASC, target ASC
```

## Known False Implications

```dataview
TABLE source_note AS "Source", target_note AS "Target", evidence AS "Evidence", assumptions AS "Assumptions", witnesses AS "Witnesses", refs AS "Refs", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication" AND domain = "binary-classification" AND status = "false"
SORT assumptions ASC, source ASC, target ASC
```

## Open Implications

```dataview
TABLE source_note AS "Source", target_note AS "Target", refs AS "Refs", summary AS "Summary"
FROM "atlas/implications"
WHERE type = "implication" AND domain = "binary-classification" AND status = "open"
SORT source ASC, target ASC
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
