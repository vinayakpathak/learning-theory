---
type: dashboard
id: all-edges-dashboard
title: All Edges Dashboard
domain: binary-classification
tags:
  - atlas/dashboard
  - learning/binary-classification
---

# All Edges Dashboard

Use the controls below to inspect directed implication edges. The dashboard remembers your selections locally in Obsidian.

```dataviewjs
const STORAGE_KEY = "learning-atlas/all-edges-dashboard/v1";
const axisFields = [
  "resource",
  "distribution",
  "strength",
  "realizability",
  "properness"
];

const axisLabels = {
  resource: "Resource",
  distribution: "Distribution",
  strength: "Strength",
  realizability: "Realizability",
  properness: "Properness"
};

const axisOptions = {
  resource: [
    ["", "Any"],
    ["computationally-efficient", "Computationally efficient"],
    ["sample-efficient", "Sample efficient"]
  ],
  distribution: [
    ["", "Any"],
    ["distribution-free", "Distribution-free"],
    ["marginal-nonuniform", "Marginal-nonuniform"]
  ],
  strength: [
    ["", "Any"],
    ["strong", "Strong"],
    ["weak", "Weak"]
  ],
  realizability: [
    ["", "Any"],
    ["agnostic", "Agnostic"],
    ["realizable", "Realizable"]
  ],
  properness: [
    ["", "Any"],
    ["proper", "Proper"],
    ["improper", "Improper"]
  ]
};

const statusOptions = [
  ["", "Any"],
  ["open", "Open"],
  ["false", "False"],
  ["true", "True"]
];

const blankAxes = () => Object.fromEntries(axisFields.map(axis => [axis, ""]));
const defaultState = () => ({
  openOnly: false,
  status: "",
  search: "",
  both: blankAxes(),
  source: blankAxes(),
  target: blankAxes()
});

const mergeState = stored => {
  const base = defaultState();
  if (!stored || typeof stored !== "object") return base;
  return {
    ...base,
    openOnly: Boolean(stored.openOnly),
    status: typeof stored.status === "string" ? stored.status : "",
    search: typeof stored.search === "string" ? stored.search : "",
    both: { ...base.both, ...(stored.both ?? {}) },
    source: { ...base.source, ...(stored.source ?? {}) },
    target: { ...base.target, ...(stored.target ?? {}) }
  };
};

const loadState = () => {
  try {
    return mergeState(JSON.parse(localStorage.getItem(STORAGE_KEY)));
  } catch {
    return defaultState();
  }
};

const saveState = () => {
  try {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(state));
  } catch {
  }
};

const asArray = value => {
  if (value === null || value === undefined) return [];
  if (Array.isArray(value)) return value;
  if (typeof value.array === "function") return value.array();
  return [value];
};

const textOf = value => asArray(value).join(", ");

const normalize = value => String(value ?? "").toLowerCase();

const defsById = new Map(
  dv.pages('"atlas/definitions"')
    .where(p => p.type === "definition" && p.domain === "binary-classification")
    .array()
    .map(p => [p.id, p])
);

const allEdges = dv.pages('"atlas/implications"')
  .where(p => p.type === "implication" && p.domain === "binary-classification")
  .array()
  .map(edge => ({
    edge,
    source: defsById.get(edge.source),
    target: defsById.get(edge.target)
  }));

const state = loadState();
const root = dv.el("div", "", { cls: "atlas-edge-dashboard" });
const result = document.createElement("div");
result.className = "atlas-edge-results";
const axisControls = [];
let openOnlyInput;
let statusSelect;
let searchInput;

const style = document.createElement("style");
style.textContent = `
.atlas-edge-dashboard {
  display: grid;
  gap: 1rem;
}
.atlas-edge-panel {
  border: 1px solid var(--background-modifier-border);
  border-radius: 8px;
  padding: 0.9rem;
  background: var(--background-secondary);
}
.atlas-edge-topbar {
  display: grid;
  grid-template-columns: minmax(12rem, 1fr) minmax(10rem, 0.75fr) auto;
  gap: 0.75rem;
  align-items: end;
}
.atlas-edge-scope-grid {
  display: grid;
  gap: 0.85rem;
  margin-top: 0.85rem;
}
.atlas-edge-scope {
  display: grid;
  gap: 0.45rem;
}
.atlas-edge-scope-title {
  margin: 0;
  font-size: 0.9rem;
  font-weight: 700;
}
.atlas-edge-scope-note {
  color: var(--text-muted);
  font-size: 0.82rem;
}
.atlas-edge-axis-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(11rem, 1fr));
  gap: 0.55rem;
}
.atlas-edge-control {
  display: grid;
  gap: 0.25rem;
}
.atlas-edge-control span,
.atlas-edge-check span {
  color: var(--text-muted);
  font-size: 0.78rem;
  font-weight: 600;
}
.atlas-edge-control input,
.atlas-edge-control select,
.atlas-edge-button {
  min-height: 2rem;
}
.atlas-edge-check {
  display: flex;
  gap: 0.45rem;
  align-items: center;
  min-height: 2rem;
}
.atlas-edge-presets {
  display: flex;
  flex-wrap: wrap;
  gap: 0.45rem;
  margin-top: 0.75rem;
}
.atlas-edge-button {
  border: 1px solid var(--background-modifier-border);
  border-radius: 6px;
  background: var(--background-primary);
  color: var(--text-normal);
  padding: 0 0.7rem;
}
.atlas-edge-summary {
  margin: 0.2rem 0 0.5rem;
}
.atlas-edge-table-wrap {
  overflow-x: auto;
}
.atlas-edge-table {
  width: 100%;
  border-collapse: collapse;
  font-size: 0.88rem;
}
.atlas-edge-table th,
.atlas-edge-table td {
  border-bottom: 1px solid var(--background-modifier-border);
  padding: 0.45rem 0.5rem;
  text-align: left;
  vertical-align: top;
}
.atlas-edge-table th {
  color: var(--text-muted);
  font-size: 0.78rem;
  text-transform: uppercase;
}
.atlas-edge-status {
  border-radius: 999px;
  display: inline-block;
  font-size: 0.75rem;
  font-weight: 700;
  padding: 0.1rem 0.45rem;
}
.atlas-edge-status-open {
  background: rgba(214, 146, 40, 0.16);
  color: var(--text-warning);
}
.atlas-edge-status-false {
  background: rgba(200, 60, 60, 0.14);
  color: var(--text-error);
}
.atlas-edge-status-true {
  background: rgba(60, 150, 90, 0.14);
  color: var(--text-success);
}
@media (max-width: 760px) {
  .atlas-edge-topbar {
    grid-template-columns: 1fr;
  }
}
`;
root.appendChild(style);

const makeSelect = (options, value) => {
  const select = document.createElement("select");
  for (const [optionValue, label] of options) {
    const option = document.createElement("option");
    option.value = optionValue;
    option.textContent = label;
    select.appendChild(option);
  }
  select.value = value ?? "";
  return select;
};

const makeLabeledControl = (labelText, control) => {
  const label = document.createElement("label");
  label.className = "atlas-edge-control";
  const labelSpan = document.createElement("span");
  labelSpan.textContent = labelText;
  label.append(labelSpan, control);
  return label;
};

const clearState = () => {
  const fresh = defaultState();
  state.openOnly = fresh.openOnly;
  state.status = fresh.status;
  state.search = fresh.search;
  state.both = fresh.both;
  state.source = fresh.source;
  state.target = fresh.target;
};

const syncControls = () => {
  openOnlyInput.checked = state.openOnly;
  statusSelect.value = state.status;
  statusSelect.disabled = state.openOnly;
  searchInput.value = state.search;
  for (const { scope, axis, control } of axisControls) {
    control.value = state[scope][axis] ?? "";
  }
};

const applyPreset = preset => {
  clearState();
  preset();
  syncControls();
  saveState();
  renderResults();
};

const makeButton = (label, onClick) => {
  const button = document.createElement("button");
  button.type = "button";
  button.className = "atlas-edge-button";
  button.textContent = label;
  button.addEventListener("click", onClick);
  return button;
};

const makeScopeSection = (title, note, scope) => {
  const section = document.createElement("section");
  section.className = "atlas-edge-scope";

  const heading = document.createElement("h3");
  heading.className = "atlas-edge-scope-title";
  heading.textContent = title;

  const help = document.createElement("div");
  help.className = "atlas-edge-scope-note";
  help.textContent = note;

  const grid = document.createElement("div");
  grid.className = "atlas-edge-axis-grid";

  for (const axis of axisFields) {
    const select = makeSelect(axisOptions[axis], state[scope][axis]);
    select.addEventListener("change", () => {
      state[scope][axis] = select.value;
      saveState();
      renderResults();
    });
    axisControls.push({ scope, axis, control: select });
    grid.appendChild(makeLabeledControl(axisLabels[axis], select));
  }

  section.append(heading, help, grid);
  return section;
};

const controls = document.createElement("div");
controls.className = "atlas-edge-panel";

const topbar = document.createElement("div");
topbar.className = "atlas-edge-topbar";

searchInput = document.createElement("input");
searchInput.type = "search";
searchInput.placeholder = "Search source, target, family, evidence, origin, summary";
searchInput.value = state.search;
searchInput.addEventListener("input", () => {
  state.search = searchInput.value;
  saveState();
  renderResults();
});

statusSelect = makeSelect(statusOptions, state.status);
statusSelect.disabled = state.openOnly;
statusSelect.addEventListener("change", () => {
  state.status = statusSelect.value;
  saveState();
  renderResults();
});

openOnlyInput = document.createElement("input");
openOnlyInput.type = "checkbox";
openOnlyInput.checked = state.openOnly;
openOnlyInput.addEventListener("change", () => {
  state.openOnly = openOnlyInput.checked;
  statusSelect.disabled = state.openOnly;
  saveState();
  renderResults();
});

const openOnlyLabel = document.createElement("label");
openOnlyLabel.className = "atlas-edge-check";
const openOnlyText = document.createElement("span");
openOnlyText.textContent = "Open only";
openOnlyLabel.append(openOnlyInput, openOnlyText);

topbar.append(
  makeLabeledControl("Search", searchInput),
  makeLabeledControl("Status", statusSelect),
  openOnlyLabel
);

const presets = document.createElement("div");
presets.className = "atlas-edge-presets";
presets.append(
  makeButton("Open edges", () => applyPreset(() => {
    state.openOnly = true;
  })),
  makeButton("Agnostic -> agnostic", () => applyPreset(() => {
    state.both.realizability = "agnostic";
  })),
  makeButton("Sample agnostic -> efficient weak", () => applyPreset(() => {
    state.source.resource = "sample-efficient";
    state.source.realizability = "agnostic";
    state.target.resource = "computationally-efficient";
    state.target.strength = "weak";
  })),
  makeButton("Reset", () => {
    clearState();
    syncControls();
    saveState();
    renderResults();
  })
);

const scopeGrid = document.createElement("div");
scopeGrid.className = "atlas-edge-scope-grid";
scopeGrid.append(
  makeScopeSection("Both endpoints", "Applies the same axis requirement to the source and target.", "both"),
  makeScopeSection("Source", "Filters the left endpoint of the directed edge.", "source"),
  makeScopeSection("Target", "Filters the right endpoint of the directed edge.", "target")
);

controls.append(topbar, presets, scopeGrid);
root.append(controls, result);

const matchesAxisSet = (definition, filters) =>
  definition && axisFields.every(axis => !filters[axis] || definition[axis] === filters[axis]);

const matchesBoth = (source, target) =>
  axisFields.every(axis =>
    !state.both[axis]
    || (source && target && source[axis] === state.both[axis] && target[axis] === state.both[axis])
  );

const makeLink = (path, label) => {
  const link = document.createElement("a");
  link.href = path;
  link.className = "internal-link";
  link.textContent = label ?? path;
  link.addEventListener("click", event => {
    if (typeof app === "undefined" || !app.workspace?.openLinkText) return;
    event.preventDefault();
    app.workspace.openLinkText(path, dv.current().file.path, event.metaKey || event.ctrlKey);
  });
  return link;
};

const appendCell = (row, value) => {
  const cell = document.createElement("td");
  if (value instanceof Node) cell.appendChild(value);
  else cell.textContent = value ?? "";
  row.appendChild(cell);
};

const statusChip = status => {
  const chip = document.createElement("span");
  chip.className = `atlas-edge-status atlas-edge-status-${status}`;
  chip.textContent = status;
  return chip;
};

const activeFilterSummary = () => {
  const active = [];
  if (state.openOnly) active.push("open only");
  else if (state.status) active.push(`status = ${state.status}`);
  if (state.search.trim()) active.push(`search = ${state.search.trim()}`);

  for (const [label, filters] of [
    ["both endpoints", state.both],
    ["source", state.source],
    ["target", state.target]
  ]) {
    for (const axis of axisFields) {
      if (filters[axis]) active.push(`${label} ${axis} = ${filters[axis]}`);
    }
  }

  return active.length ? active.join("; ") : "none";
};

function filteredEdges() {
  const query = normalize(state.search.trim());

  return allEdges
    .filter(({ edge, source, target }) => {
      if (state.openOnly && edge.status !== "open") return false;
      if (!state.openOnly && state.status && edge.status !== state.status) return false;
      if (!matchesBoth(source, target)) return false;
      if (!matchesAxisSet(source, state.source)) return false;
      if (!matchesAxisSet(target, state.target)) return false;

      if (!query) return true;
      const haystack = normalize([
        source?.title,
        target?.title,
        edge.source,
        edge.target,
        edge.status,
        edge.family,
        edge.evidence,
        edge.result_origin,
        textOf(edge.assumptions),
        edge.summary
      ].join(" "));
      return haystack.includes(query);
    })
    .sort((a, b) => {
      const rank = { open: 0, false: 1, true: 2 };
      return (rank[a.edge.status] ?? 9) - (rank[b.edge.status] ?? 9)
        || `${a.source?.title ?? a.edge.source}-${a.target?.title ?? a.edge.target}`
          .localeCompare(`${b.source?.title ?? b.edge.source}-${b.target?.title ?? b.edge.target}`);
    });
}

function renderResults() {
  result.replaceChildren();

  const rows = filteredEdges();
  const counts = rows.reduce((acc, { edge }) => {
    acc[edge.status] = (acc[edge.status] ?? 0) + 1;
    return acc;
  }, {});
  const countSummary = ["open", "false", "true"]
    .filter(status => counts[status])
    .map(status => `${status}: ${counts[status]}`)
    .join(", ");

  const summary = document.createElement("p");
  summary.className = "atlas-edge-summary";
  summary.textContent = `Active filters: ${activeFilterSummary()}. Showing ${rows.length} edge${rows.length === 1 ? "" : "s"}${countSummary ? ` (${countSummary})` : ""}.`;
  result.appendChild(summary);

  if (!rows.length) {
    const empty = document.createElement("p");
    empty.textContent = "No edges match these filters.";
    result.appendChild(empty);
    return;
  }

  const tableWrap = document.createElement("div");
  tableWrap.className = "atlas-edge-table-wrap";

  const table = document.createElement("table");
  table.className = "atlas-edge-table";

  const head = document.createElement("thead");
  const headRow = document.createElement("tr");
  for (const header of ["Source", "Target", "Status", "Family", "Evidence", "Result Origin", "Assumptions", "Summary", "Edge"]) {
    const cell = document.createElement("th");
    cell.textContent = header;
    headRow.appendChild(cell);
  }
  head.appendChild(headRow);
  table.appendChild(head);

  const body = document.createElement("tbody");
  for (const { edge, source, target } of rows) {
    const row = document.createElement("tr");
    appendCell(row, makeLink(source?.file.path ?? edge.source, source?.title ?? edge.source));
    appendCell(row, makeLink(target?.file.path ?? edge.target, target?.title ?? edge.target));
    appendCell(row, statusChip(edge.status));
    appendCell(row, edge.family);
    appendCell(row, edge.evidence);
    appendCell(row, edge.result_origin);
    appendCell(row, textOf(edge.assumptions));
    appendCell(row, edge.summary);
    appendCell(row, makeLink(edge.file.path, "note"));
    body.appendChild(row);
  }
  table.appendChild(body);
  tableWrap.appendChild(table);
  result.appendChild(tableWrap);
}

syncControls();
renderResults();
```
