---
type: dashboard
id: multiclass-classification-dashboard
title: Multiclass Classification Dashboard
domain: multiclass-classification
tags:
- atlas/dashboard
- learning/multiclass-classification
---

# Multiclass Classification Dashboard

This dashboard treats finite-label multiclass learning notions as nodes and implications as directed edges. It mirrors the binary atlas axes while keeping the multiclass graph in its own folder.

Dataview must be enabled in Obsidian for the tables below to render.

## Definitions

```dataview
TABLE title AS "Definition", resource AS "Resource", distribution AS "Distribution", realizability AS "Realizability", properness AS "Properness", strength AS "Strength", characterization_status AS "Characterization"
FROM "atlas/multiclass/definitions"
WHERE type = "definition" AND domain = "multiclass-classification"
SORT resource ASC, distribution ASC, strength ASC, realizability DESC, properness DESC
```

## All Implications

```dataview
TABLE source_note AS "Source", target_note AS "Target", status AS "Status", family AS "Family", evidence AS "Evidence", result_origin AS "Result Origin", assumptions AS "Assumptions", witness_note AS "Witness", argument_note AS "Argument", summary AS "Summary"
FROM "atlas/multiclass/implications"
WHERE type = "implication" AND domain = "multiclass-classification"
SORT family ASC, source ASC, target ASC
```

## Open Implications

```dataview
TABLE source_note AS "Source", target_note AS "Target", family AS "Family", argument_note AS "Argument", refs AS "Refs", summary AS "Summary"
FROM "atlas/multiclass/implications"
WHERE type = "implication" AND domain = "multiclass-classification" AND status = "open"
SORT family ASC, source ASC, target ASC
```
