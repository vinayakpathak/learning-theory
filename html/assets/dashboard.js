(() => {
  if (!window.ATLAS_DATA) return;
  const data = window.ATLAS_DATA;
  const axisFields = data.axisFields;
  const axisLabels = data.axisLabels;
  const axisOptions = data.axisOptions;
  const statusOptions = [["", "Any"], ["open", "Open"], ["false", "False"], ["true", "True"]];
  const resultOriginOptions = [["", "Any"], ["known", "Known"], ["unclear", "Unclear"], ["new", "New"]];
  const defsById = new Map(data.definitions.map(def => [def.id, def]));
  const familyOptions = [["", "Any"], ...Array.from(new Set(data.edges.map(edge => edge.family).filter(Boolean))).sort().map(family => [family, family])];
  const normalize = value => String(value || "").toLowerCase();
  const textOf = value => Array.isArray(value) ? value.join(", ") : String(value || "");
  const blankAxes = () => Object.fromEntries(axisFields.map(axis => [axis, ""]));

  const edgeRows = data.edges.map(edge => ({
    edge,
    source: defsById.get(edge.source),
    target: defsById.get(edge.target)
  }));

  const makeSelect = (options, value) => {
    const select = document.createElement("select");
    for (const [optionValue, label] of options) {
      const option = document.createElement("option");
      option.value = optionValue;
      option.textContent = label;
      select.appendChild(option);
    }
    select.value = value || "";
    return select;
  };

  const makeLabeledControl = (labelText, control) => {
    const label = document.createElement("label");
    label.className = "atlas-edge-control";
    const span = document.createElement("span");
    span.textContent = labelText;
    label.append(span, control);
    return label;
  };

  const makeButton = (label, onClick) => {
    const button = document.createElement("button");
    button.type = "button";
    button.className = "atlas-edge-button";
    button.textContent = label;
    button.addEventListener("click", onClick);
    return button;
  };

  const appendCell = (row, value) => {
    const cell = document.createElement("td");
    if (value instanceof Node) cell.appendChild(value);
    else cell.textContent = value || "";
    row.appendChild(cell);
  };
  const makeLink = (href, label) => {
    const link = document.createElement("a");
    link.href = href;
    link.textContent = label;
    return link;
  };
  const makeStatusChip = status => {
    const chip = document.createElement("span");
    chip.className = "status-chip status-" + status;
    chip.textContent = status;
    return chip;
  };

  const makeTable = (headers, rows) => {
    const tableWrap = document.createElement("div");
    tableWrap.className = "table-wrap";
    const table = document.createElement("table");
    table.className = "atlas-table";
    const head = document.createElement("thead");
    const headRow = document.createElement("tr");
    for (const header of headers) {
      const cell = document.createElement("th");
      cell.textContent = header;
      headRow.appendChild(cell);
    }
    head.appendChild(headRow);
    table.appendChild(head);
    const body = document.createElement("tbody");
    for (const cells of rows) {
      const row = document.createElement("tr");
      for (const cell of cells) appendCell(row, cell);
      body.appendChild(row);
    }
    table.appendChild(body);
    tableWrap.appendChild(table);
    return tableWrap;
  };

  const matchesAxisSet = (definition, filters) =>
    definition && axisFields.every(axis => !filters[axis] || definition[axis] === filters[axis]);

  const matchesBoth = (source, target, filters) =>
    axisFields.every(axis =>
      !filters[axis] || (source && target && source[axis] === filters[axis] && target[axis] === filters[axis])
    );

  function initEdgeDashboard(root, config) {
    const fixedStatus = config.fixedStatus || "";
    const includeView = Boolean(config.includeView);
    const base = (root.dataset.root || ".").replace(/\/$/, "");
    const hrefFor = htmlPath => base === "." ? htmlPath : base + "/" + htmlPath;
    const defaultState = () => ({
      view: "edges",
      status: fixedStatus,
      resultOrigin: "",
      family: "",
      search: "",
      both: blankAxes(),
      source: blankAxes(),
      target: blankAxes()
    });
    const mergeState = stored => {
      const baseState = defaultState();
      if (!stored || typeof stored !== "object") return baseState;
      return {
        ...baseState,
        view: includeView && typeof stored.view === "string" ? stored.view : "edges",
        status: fixedStatus || (typeof stored.status === "string" ? stored.status : ""),
        resultOrigin: typeof stored.resultOrigin === "string" ? stored.resultOrigin : "",
        family: typeof stored.family === "string" ? stored.family : "",
        search: typeof stored.search === "string" ? stored.search : "",
        both: { ...baseState.both, ...(stored.both || {}) },
        source: { ...baseState.source, ...(stored.source || {}) },
        target: { ...baseState.target, ...(stored.target || {}) }
      };
    };
    const loadState = () => {
      try {
        return mergeState(JSON.parse(localStorage.getItem(config.storageKey)));
      } catch {
        return defaultState();
      }
    };
    const state = loadState();
    const axisControls = [];
    const result = document.createElement("div");
    result.className = "atlas-edge-results";
    let viewSelect;
    let searchInput;
    let statusSelect;
    let resultOriginSelect;
    let familySelect;

    const saveState = () => {
      try {
        localStorage.setItem(config.storageKey, JSON.stringify(state));
      } catch {
      }
    };
    const clearState = () => {
      const fresh = defaultState();
      state.view = fresh.view;
      state.status = fresh.status;
      state.resultOrigin = fresh.resultOrigin;
      state.family = fresh.family;
      state.search = fresh.search;
      state.both = fresh.both;
      state.source = fresh.source;
      state.target = fresh.target;
    };
    const syncControls = () => {
      if (viewSelect) viewSelect.value = state.view;
      searchInput.value = state.search;
      statusSelect.value = state.status;
      statusSelect.disabled = Boolean(fixedStatus);
      resultOriginSelect.value = state.resultOrigin;
      familySelect.value = state.family;
      for (const { scope, axis, control } of axisControls) control.value = state[scope][axis] || "";
    };
    const applyPreset = preset => {
      clearState();
      preset();
      syncControls();
      saveState();
      renderResults();
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
    if (includeView) {
      viewSelect = makeSelect([["edges", "Implication edges"], ["definitions", "Definitions"], ["families", "Edge families"]], state.view);
      viewSelect.addEventListener("change", () => {
        state.view = viewSelect.value;
        saveState();
        renderResults();
      });
      topbar.appendChild(makeLabeledControl("Table", viewSelect));
    }
    searchInput = document.createElement("input");
    searchInput.type = "search";
    searchInput.placeholder = "Search title, family, evidence, assumptions, summary";
    searchInput.value = state.search;
    searchInput.addEventListener("input", () => {
      state.search = searchInput.value;
      saveState();
      renderResults();
    });
    statusSelect = makeSelect(statusOptions, state.status);
    statusSelect.disabled = Boolean(fixedStatus);
    statusSelect.addEventListener("change", () => {
      state.status = statusSelect.value;
      saveState();
      renderResults();
    });
    resultOriginSelect = makeSelect(resultOriginOptions, state.resultOrigin);
    resultOriginSelect.addEventListener("change", () => {
      state.resultOrigin = resultOriginSelect.value;
      saveState();
      renderResults();
    });
    familySelect = makeSelect(familyOptions, state.family);
    familySelect.addEventListener("change", () => {
      state.family = familySelect.value;
      saveState();
      renderResults();
    });
    topbar.append(
      makeLabeledControl("Search", searchInput),
      makeLabeledControl("Status", statusSelect),
      makeLabeledControl("Result Origin", resultOriginSelect),
      makeLabeledControl("Family", familySelect)
    );
    const presets = document.createElement("div");
    presets.className = "atlas-edge-presets";
    presets.append(
      makeButton("Open", () => applyPreset(() => { state.status = "open"; })),
      makeButton("False", () => applyPreset(() => { state.status = "false"; })),
      makeButton("Agnostic endpoints", () => applyPreset(() => { state.both.realizability = "agnostic"; })),
      makeButton("Sample -> efficient weak", () => applyPreset(() => {
        state.source.resource = "sample-efficient";
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
      makeScopeSection("Both endpoints", "Require both the source and target to have the selected axis values.", "both"),
      makeScopeSection("Source", "Filter the left endpoint of the directed implication.", "source"),
      makeScopeSection("Target", "Filter the right endpoint of the directed implication.", "target")
    );
    controls.append(topbar, presets, scopeGrid);
    root.className = "atlas-edge-dashboard";
    root.append(controls, result);

    const activeFilterSummary = () => {
      const active = [];
      if (includeView && state.view !== "edges") active.push("table = " + state.view);
      if (state.status) active.push("status = " + state.status);
      if (state.resultOrigin) active.push("result_origin = " + state.resultOrigin);
      if (state.family) active.push("family = " + state.family);
      if (state.search.trim()) active.push("search = " + state.search.trim());
      for (const [label, filters] of [["both endpoints", state.both], ["source", state.source], ["target", state.target]]) {
        for (const axis of axisFields) {
          if (filters[axis]) active.push(label + " " + axis + " = " + filters[axis]);
        }
      }
      return active.length ? active.join("; ") : "none";
    };
    const filteredEdges = () => {
      const query = normalize(state.search.trim());
      return edgeRows
        .filter(({ edge, source, target }) => {
          if (state.status && edge.status !== state.status) return false;
          if (state.resultOrigin && edge.result_origin !== state.resultOrigin) return false;
          if (state.family && edge.family !== state.family) return false;
          if (!matchesBoth(source, target, state.both)) return false;
          if (!matchesAxisSet(source, state.source)) return false;
          if (!matchesAxisSet(target, state.target)) return false;
          if (!query) return true;
          return normalize([
            edge.sourceTitle,
            edge.targetTitle,
            edge.source,
            edge.target,
            edge.status,
            edge.family,
            edge.evidence,
            edge.result_origin,
            textOf(edge.assumptions),
            edge.summary
          ].join(" ")).includes(query);
        })
        .sort((a, b) => {
          const rank = { open: 0, false: 1, true: 2 };
          return (rank[a.edge.status] ?? 9) - (rank[b.edge.status] ?? 9)
            || String(a.edge.family || "").localeCompare(String(b.edge.family || ""))
            || (a.edge.sourceTitle + "-" + a.edge.targetTitle).localeCompare(b.edge.sourceTitle + "-" + b.edge.targetTitle);
        });
    };
    const filteredDefinitions = () => {
      const query = normalize(state.search.trim());
      return data.definitions
        .filter(def => matchesAxisSet(def, state.both))
        .filter(def => matchesAxisSet(def, state.source))
        .filter(def => !query || normalize([
          def.title,
          def.id,
          def.resource,
          def.distribution,
          def.strength,
          def.realizability,
          def.properness,
          def.characterization_status
        ].join(" ")).includes(query))
        .sort((a, b) => a.title.localeCompare(b.title));
    };
    const showKpis = matches => {
      const counts = matches.reduce((acc, { edge }) => {
        acc[edge.status] = (acc[edge.status] || 0) + 1;
        return acc;
      }, {});
      const kpis = document.createElement("div");
      kpis.className = "dashboard-kpis";
      for (const label of ["open", "false", "true"]) {
        const item = document.createElement("span");
        item.className = "dashboard-kpi";
        item.textContent = label + ": " + (counts[label] || 0);
        kpis.appendChild(item);
      }
      result.appendChild(kpis);
    };
    const renderEdges = matches => {
      const rows = matches.map(({ edge, source, target }) => [
        makeLink(hrefFor(source?.htmlPath || edge.htmlPath), edge.sourceTitle || edge.source),
        makeLink(hrefFor(target?.htmlPath || edge.htmlPath), edge.targetTitle || edge.target),
        makeStatusChip(edge.status),
        edge.family,
        edge.evidence,
        edge.result_origin,
        textOf(edge.assumptions),
        edge.summary,
        makeLink(hrefFor(edge.htmlPath), "note")
      ]);
      result.appendChild(makeTable(["Source", "Target", "Status", "Family", "Evidence", "Result Origin", "Assumptions", "Summary", "Edge"], rows));
    };
    const renderDefinitions = defs => {
      const rows = defs.map(def => [
        makeLink(hrefFor(def.htmlPath), def.title),
        def.resource,
        def.distribution,
        def.strength,
        def.realizability,
        def.properness,
        def.characterization_status
      ]);
      result.appendChild(makeTable(["Definition", "Resource", "Distribution", "Strength", "Realizability", "Properness", "Characterization"], rows));
    };
    const renderFamilies = matches => {
      const grouped = new Map();
      for (const row of matches) {
        const family = row.edge.family || "unclassified";
        if (!grouped.has(family)) grouped.set(family, []);
        grouped.get(family).push(row.edge);
      }
      const rows = Array.from(grouped.entries())
        .sort(([a], [b]) => a.localeCompare(b))
        .map(([family, edges]) => [
          family,
          String(edges.length),
          Array.from(new Set(edges.map(edge => edge.status))).join(", "),
          Array.from(new Set(edges.map(edge => edge.evidence))).join(", "),
          Array.from(new Set(edges.map(edge => edge.result_origin).filter(Boolean))).join(", ")
        ]);
      result.appendChild(makeTable(["Family", "Edges", "Statuses", "Evidence", "Result Origin"], rows));
    };
    function renderResults() {
      result.replaceChildren();
      const edgeMatches = filteredEdges();
      const summary = document.createElement("p");
      summary.className = "atlas-edge-summary";
      const noun = state.view === "definitions" ? "definition" : state.view === "families" ? "family" : "edge";
      const count = state.view === "definitions" ? filteredDefinitions().length : state.view === "families" ? new Set(edgeMatches.map(row => row.edge.family || "unclassified")).size : edgeMatches.length;
      summary.textContent = "Active filters: " + activeFilterSummary() + ". Showing " + count + " " + noun + (count === 1 ? "." : "s.");
      result.appendChild(summary);
      showKpis(edgeMatches);
      if (state.view === "definitions") {
        const defs = filteredDefinitions();
        if (!defs.length) {
          const empty = document.createElement("p");
          empty.textContent = "No definitions match these filters.";
          result.appendChild(empty);
          return;
        }
        renderDefinitions(defs);
        return;
      }
      if (state.view === "families") {
        if (!edgeMatches.length) {
          const empty = document.createElement("p");
          empty.textContent = "No edge families match these filters.";
          result.appendChild(empty);
          return;
        }
        renderFamilies(edgeMatches);
        return;
      }
      if (!edgeMatches.length) {
        const empty = document.createElement("p");
        empty.textContent = "No edges match these filters.";
        result.appendChild(empty);
        return;
      }
      renderEdges(edgeMatches);
    }
    syncControls();
    renderResults();
  }

  const configs = [
    {
      id: "atlas-all-edges-dashboard",
      storageKey: "learning-atlas/html/all-edges-dashboard/v2"
    },
    {
      id: "atlas-open-edges-dashboard",
      storageKey: "learning-atlas/html/open-edges-dashboard/v2",
      fixedStatus: "open"
    },
    {
      id: "atlas-binary-dashboard",
      storageKey: "learning-atlas/html/binary-dashboard/v2",
      includeView: true
    }
  ];
  for (const config of configs) {
    const root = document.getElementById(config.id);
    if (root) initEdgeDashboard(root, config);
  }
})();