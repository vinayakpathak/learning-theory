import fs from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";
import matter from "gray-matter";
import MarkdownIt from "markdown-it";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT = path.resolve(__dirname, "..");
const ATLAS_DIR = path.join(ROOT, "atlas");
const HTML_DIR = path.join(ROOT, "html");

const axisFields = ["resource", "distribution", "strength", "realizability", "properness"];
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

const sortRanks = {
  resource: { "computationally-efficient": 0, "sample-efficient": 1 },
  distribution: { "distribution-free": 0, "marginal-nonuniform": 1 },
  strength: { strong: 0, weak: 1 },
  realizability: { agnostic: 0, realizable: 1 },
  properness: { proper: 0, improper: 1 },
  status: { open: 0, false: 1, true: 2 }
};

let notes = [];
let notesById = new Map();
let notesByLinkKey = new Map();
let definitions = [];
let implications = [];
let argumentsById = new Map();
let witnessesById = new Map();
let definitionsById = new Map();
let implicationsByPair = new Map();

const md = new MarkdownIt({
  html: true,
  linkify: true,
  typographer: false
});

const defaultHeadingOpen =
  md.renderer.rules.heading_open ??
  ((tokens, idx, options, env, self) => self.renderToken(tokens, idx, options));

md.renderer.rules.heading_open = (tokens, idx, options, env, self) => {
  const inline = tokens[idx + 1];
  const text = inline?.type === "inline" ? inline.content : "";
  const counts = env.slugCounts ?? new Map();
  env.slugCounts = counts;
  const base = slugify(text) || "section";
  const seen = counts.get(base) ?? 0;
  counts.set(base, seen + 1);
  tokens[idx].attrSet("id", seen ? `${base}-${seen + 1}` : base);
  return defaultHeadingOpen(tokens, idx, options, env, self);
};

function toPosix(value) {
  return value.split(path.sep).join(path.posix.sep);
}

function escapeHtml(value) {
  return String(value ?? "").replace(/[&<>"']/g, char => ({
    "&": "&amp;",
    "<": "&lt;",
    ">": "&gt;",
    '"': "&quot;",
    "'": "&#39;"
  })[char]);
}

function escapeAttr(value) {
  return escapeHtml(value);
}

function slugify(value) {
  return String(value ?? "")
    .toLowerCase()
    .replace(/<[^>]+>/g, "")
    .replace(/\\[a-zA-Z]+/g, "")
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "");
}

function titleFromSlug(slug) {
  return slug
    .split("-")
    .filter(Boolean)
    .map(part => part.charAt(0).toUpperCase() + part.slice(1))
    .join(" ");
}

function linkKey(value) {
  return String(value ?? "")
    .trim()
    .replace(/^atlas\//, "")
    .replace(/\.md$/, "")
    .toLowerCase();
}

function addLinkKey(key, note) {
  if (!key) return;
  const normalized = linkKey(key);
  if (!normalized || notesByLinkKey.has(normalized)) return;
  notesByLinkKey.set(normalized, note);
}

function resolveNote(target) {
  const clean = String(target ?? "").trim().replace(/\\/g, "/");
  const withoutAnchor = clean.split("#", 1)[0];
  if (!withoutAnchor) return null;
  return notesByLinkKey.get(linkKey(withoutAnchor)) ?? null;
}

function relativeHref(fromHtmlPath, targetHtmlPath) {
  const fromDir = path.posix.dirname(fromHtmlPath);
  const rel = path.posix.relative(fromDir, targetHtmlPath);
  return rel || path.posix.basename(targetHtmlPath);
}

function rootPrefix(fromHtmlPath) {
  const rel = path.posix.relative(path.posix.dirname(fromHtmlPath), ".");
  return rel || ".";
}

function escapeMarkdownLinkLabel(value) {
  return String(value ?? "").replace(/([\\\]])/g, "\\$1");
}

function replaceWikiLinks(markdown, fromNote) {
  return String(markdown ?? "").replace(/(!?)\[\[([^\]\n]+)\]\]/g, (match, bang, inner) => {
    const parts = inner.split("|");
    const targetPart = parts.shift()?.trim() ?? "";
    const label = (parts.length ? parts.join("|") : targetPart.split("#").pop() || targetPart).trim();
    const [target, heading] = targetPart.split("#");
    const note = resolveNote(target);
    if (!note) return escapeMarkdownLinkLabel(label || targetPart);

    const anchor = heading ? `#${slugify(heading)}` : "";
    const href = `${relativeHref(fromNote.htmlPath, note.htmlPath)}${anchor}`.replace(/\)/g, "%29");
    return `${bang}[${escapeMarkdownLinkLabel(label || note.title)}](${href})`;
  });
}

function renderMarkdown(markdown, fromNote) {
  return md.render(replaceWikiLinks(markdown, fromNote), {
    fromNote,
    slugCounts: new Map()
  });
}

function renderInline(value, fromNote) {
  return md.renderInline(replaceWikiLinks(String(value ?? ""), fromNote), { fromNote });
}

function asArray(value) {
  if (value === null || value === undefined) return [];
  return Array.isArray(value) ? value : [value];
}

function renderCellValue(value, fromNote) {
  if (value === null || value === undefined || value === "") return "";
  if (Array.isArray(value)) return value.map(item => renderCellValue(item, fromNote)).filter(Boolean).join(", ");
  if (typeof value === "object") return `<code>${escapeHtml(JSON.stringify(value))}</code>`;
  return renderInline(value, fromNote);
}

function noteLink(note, label, fromNote) {
  if (!note) return renderInline(label ?? "", fromNote);
  return `<a href="${escapeAttr(relativeHref(fromNote.htmlPath, note.htmlPath))}">${renderInline(label ?? note.title, fromNote)}</a>`;
}

function noteLinkById(id, label, fromNote) {
  return noteLink(notesById.get(id) ?? definitionsById.get(id), label ?? id, fromNote);
}

function implicationNote(edge) {
  return notesById.get(edge.id) ?? implicationsByPair.get(`${edge.source}=>${edge.target}`)?._note ?? null;
}

function edgeNoteLink(edge, label, fromNote) {
  return noteLink(implicationNote(edge), label, fromNote);
}

function statusChip(status) {
  return `<span class="status-chip status-${escapeAttr(status)}">${escapeHtml(status)}</span>`;
}

function tableHtml(headers, rows, options = {}) {
  const className = options.className ?? "atlas-table";
  if (!rows.length) return `<p class="empty-state">${escapeHtml(options.empty ?? "No rows.")}</p>`;
  return [
    `<div class="table-wrap">`,
    `<table class="${escapeAttr(className)}">`,
    `<thead><tr>${headers.map(header => `<th>${escapeHtml(header)}</th>`).join("")}</tr></thead>`,
    `<tbody>`,
    rows.map(row => `<tr>${row.map(cell => `<td>${cell ?? ""}</td>`).join("")}</tr>`).join("\n"),
    `</tbody>`,
    `</table>`,
    `</div>`
  ].join("\n");
}

function compareBy(...selectors) {
  return (a, b) => {
    for (const selector of selectors) {
      const av = selector(a);
      const bv = selector(b);
      const result = String(av ?? "").localeCompare(String(bv ?? ""));
      if (result) return result;
    }
    return 0;
  };
}

function compareRanked(axis, a, b) {
  const ranks = sortRanks[axis] ?? {};
  const av = ranks[a?.[axis]] ?? 99;
  const bv = ranks[b?.[axis]] ?? 99;
  return av - bv || String(a?.[axis] ?? "").localeCompare(String(b?.[axis] ?? ""));
}

function unique(values) {
  return [...new Set(values.filter(value => value !== null && value !== undefined && value !== ""))];
}

function definitionSort(a, b) {
  return String(a.model ?? "").localeCompare(String(b.model ?? ""))
    || compareRanked("resource", a, b)
    || compareRanked("distribution", a, b)
    || compareRanked("strength", a, b)
    || -compareRanked("realizability", a, b)
    || -compareRanked("properness", a, b)
    || String(a.title ?? "").localeCompare(String(b.title ?? ""));
}

function auditDefinitionSort(a, b) {
  return compareRanked("resource", a, b)
    || compareRanked("distribution", a, b)
    || compareRanked("strength", a, b)
    || String(a.realizability ?? "").localeCompare(String(b.realizability ?? ""))
    || String(a.properness ?? "").localeCompare(String(b.properness ?? ""))
    || String(a.title ?? "").localeCompare(String(b.title ?? ""));
}

function edgeSort(a, b) {
  return String(a.family ?? "").localeCompare(String(b.family ?? ""))
    || String(a.source ?? "").localeCompare(String(b.source ?? ""))
    || String(a.target ?? "").localeCompare(String(b.target ?? ""));
}

async function walkMarkdown(dir) {
  const entries = await fs.readdir(dir, { withFileTypes: true });
  const files = [];
  for (const entry of entries) {
    const fullPath = path.join(dir, entry.name);
    if (entry.isDirectory()) files.push(...await walkMarkdown(fullPath));
    else if (entry.isFile() && entry.name.endsWith(".md")) files.push(fullPath);
  }
  return files.sort();
}

async function loadNotes() {
  const files = await walkMarkdown(ATLAS_DIR);
  notes = await Promise.all(files.map(async absolutePath => {
    const raw = await fs.readFile(absolutePath, "utf8");
    const parsed = matter(raw);
    const sourcePath = toPosix(path.relative(ROOT, absolutePath));
    const atlasRelPath = sourcePath.replace(/^atlas\//, "");
    const slug = path.posix.basename(atlasRelPath, ".md");
    const htmlPath = sourcePath.replace(/\.md$/, ".html");
    const heading = parsed.content.match(/^#\s+(.+)$/m)?.[1];
    const id = parsed.data.id ?? slug;
    const title = parsed.data.title ?? heading ?? titleFromSlug(slug);
    return {
      sourcePath,
      atlasRelPath,
      relNoExt: atlasRelPath.replace(/\.md$/, ""),
      slug,
      htmlPath,
      id,
      title,
      type: parsed.data.type,
      domain: parsed.data.domain,
      fm: parsed.data,
      body: parsed.content
    };
  }));

  notesById = new Map();
  notesByLinkKey = new Map();
  for (const note of notes) {
    if (note.id) {
      notesById.set(note.id, note);
      addLinkKey(note.id, note);
    }
    addLinkKey(note.relNoExt, note);
    addLinkKey(note.slug, note);
    addLinkKey(note.sourcePath, note);
  }

  definitions = notes.filter(note => note.type === "definition").map(note => ({ ...note.fm, _note: note }));
  implications = notes.filter(note => note.type === "implication").map(note => ({ ...note.fm, _note: note }));
  definitionsById = new Map(definitions.map(def => [def.id, def]));
  implicationsByPair = new Map(implications.map(edge => [`${edge.source}=>${edge.target}`, edge]));
  argumentsById = new Map(notes.filter(note => note.type === "argument").map(note => [note.id, note]));
  witnessesById = new Map(notes.filter(note => note.type === "witness").map(note => [note.id, note]));
}

function renderDefinitionDataview(note, code) {
  const sourceMatch = code.match(/source\s*=\s*"([^"]+)"/);
  const targetMatch = code.match(/target\s*=\s*"([^"]+)"/);
  if (sourceMatch) {
    const source = sourceMatch[1];
    const rows = implications
      .filter(edge => edge.source === source)
      .sort(compareBy(edge => edge.target))
      .map(edge => [
        renderCellValue(edge.target_note ?? edge.target, note),
        statusChip(edge.status),
        renderCellValue(edge.evidence, note),
        renderCellValue(edge.assumptions, note),
        renderCellValue(edge.summary, note)
      ]);
    return tableHtml(["Target", "Status", "Evidence", "Assumptions", "Summary"], rows);
  }
  if (targetMatch) {
    const target = targetMatch[1];
    const rows = implications
      .filter(edge => edge.target === target)
      .sort(compareBy(edge => edge.source))
      .map(edge => [
        renderCellValue(edge.source_note ?? edge.source, note),
        statusChip(edge.status),
        renderCellValue(edge.evidence, note),
        renderCellValue(edge.assumptions, note),
        renderCellValue(edge.summary, note)
      ]);
    return tableHtml(["Source", "Status", "Evidence", "Assumptions", "Summary"], rows);
  }
  return `<p class="notice">This Dataview query is not rendered in the static export.</p>`;
}

function renderImmediateRelaxations(fromNote) {
  const rows = implications
    .filter(edge => edge.domain === "binary-classification" && edge.family === "monotone-relaxation")
    .map(edge => ({
      edge,
      changes: Object.entries(edge.axis_delta ?? {}).filter(([, value]) => value !== "same")
    }))
    .filter(row => row.changes.length === 1)
    .sort((a, b) => `${a.changes[0][0]}-${a.edge.source}`.localeCompare(`${b.changes[0][0]}-${b.edge.source}`))
    .map(({ edge, changes }) => [
      renderCellValue(changes[0][0], fromNote),
      renderCellValue(edge.source_note, fromNote),
      renderCellValue(edge.target_note, fromNote),
      renderCellValue(changes[0][1], fromNote),
      edgeNoteLink(edge, "note", fromNote)
    ]);
  return tableHtml(["Axis", "Source", "Target", "Delta", "Edge"], rows);
}

function renderImplicationFamilies(fromNote) {
  const grouped = new Map();
  for (const edge of implications.filter(edge => edge.domain === "binary-classification")) {
    const family = edge.family ?? "unclassified";
    if (!grouped.has(family)) grouped.set(family, []);
    grouped.get(family).push(edge);
  }
  const rows = [...grouped.entries()]
    .sort(([a], [b]) => a.localeCompare(b))
    .map(([family, familyEdges]) => {
      const argument = argumentsById.get(family);
      return [
        argument ? noteLink(argument, argument.title, fromNote) : renderCellValue(family, fromNote),
        renderCellValue(unique(familyEdges.map(edge => edge.status)).join(", "), fromNote),
        renderCellValue(familyEdges.length, fromNote),
        renderCellValue(unique(familyEdges.map(edge => edge.evidence)).join(", "), fromNote),
        renderCellValue(unique(familyEdges.map(edge => edge.result_origin)).join(", "), fromNote),
        renderCellValue(familyEdges[0]?.argument_note, fromNote)
      ];
    });
  return tableHtml(["Family", "Status", "Edges", "Evidence", "Result Origin", "Argument"], rows);
}

function renderWitnessCoverage(fromNote) {
  const grouped = new Map();
  for (const edge of implications.filter(edge => edge.domain === "binary-classification" && edge.status === "false")) {
    for (const witness of asArray(edge.witnesses)) {
      if (!grouped.has(witness)) grouped.set(witness, []);
      grouped.get(witness).push(edge);
    }
  }
  const rows = [...grouped.entries()]
    .sort(([a], [b]) => a.localeCompare(b))
    .map(([witness, witnessEdges]) => {
      const page = witnessesById.get(witness);
      return [
        page ? noteLink(page, page.title, fromNote) : renderCellValue(witness, fromNote),
        renderCellValue(witnessEdges.length, fromNote),
        renderCellValue(unique(witnessEdges.flatMap(edge => asArray(edge.assumptions))).join(", "), fromNote),
        renderCellValue(unique(witnessEdges.map(edge => edge.family)).join(", "), fromNote)
      ];
    });
  return tableHtml(["Witness", "False Edges", "Assumptions", "Families"], rows);
}

function renderOpenQuestionsByObstruction(fromNote) {
  const grouped = new Map();
  for (const edge of implications.filter(edge => edge.domain === "binary-classification" && edge.status === "open")) {
    const family = edge.family ?? "unclassified";
    if (!grouped.has(family)) grouped.set(family, []);
    grouped.get(family).push(edge);
  }
  const rows = [...grouped.entries()]
    .sort(([, a], [, b]) => b.length - a.length)
    .map(([family, familyEdges]) => [
      renderCellValue(family, fromNote),
      renderCellValue(familyEdges.length, fromNote),
      renderCellValue(familyEdges[0]?.argument_note, fromNote),
      renderCellValue(familyEdges[0]?.refs, fromNote)
    ]);
  return tableHtml(["Family", "Open Edges", "Argument", "Representative Refs"], rows);
}

function renderDefinitionsTable(fromNote) {
  const rows = [...definitions]
    .filter(def => def.domain === "binary-classification")
    .sort(definitionSort)
    .map(def => [
      noteLink(def._note, def.title, fromNote),
      renderCellValue(def.model, fromNote),
      renderCellValue(def.resource, fromNote),
      renderCellValue(def.distribution, fromNote),
      renderCellValue(def.realizability, fromNote),
      renderCellValue(def.properness, fromNote),
      renderCellValue(def.strength, fromNote),
      renderCellValue(def.characterization_status, fromNote),
      renderCellValue(def.characterization, fromNote)
    ]);
  return tableHtml([
    "Definition",
    "Model",
    "Resource",
    "Distribution",
    "Realizability",
    "Properness",
    "Strength",
    "Characterization",
    "Characterization Note"
  ], rows);
}

function renderCharacterizationStatus(fromNote) {
  const rows = [...definitions]
    .filter(def => def.domain === "binary-classification")
    .sort(compareBy(def => def.characterization_status, def => def.title))
    .map(def => [
      noteLink(def._note, def.title, fromNote),
      renderCellValue(def.characterization_status, fromNote),
      renderCellValue(def.characterization_refs, fromNote),
      renderCellValue(def.characterization, fromNote)
    ]);
  return tableHtml(["Definition", "Status", "Refs", "Note"], rows);
}

function renderImplicationsTable(fromNote, filter = {}) {
  const rows = implications
    .filter(edge => edge.domain === "binary-classification")
    .filter(edge => !filter.status || edge.status === filter.status)
    .sort((a, b) => {
      if (filter.status === "false") {
        return String(a.family ?? "").localeCompare(String(b.family ?? ""))
          || renderCellValue(a.assumptions, fromNote).localeCompare(renderCellValue(b.assumptions, fromNote))
          || String(a.source ?? "").localeCompare(String(b.source ?? ""))
          || String(a.target ?? "").localeCompare(String(b.target ?? ""));
      }
      return edgeSort(a, b);
    })
    .map(edge => {
      const common = [
        renderCellValue(edge.source_note, fromNote),
        renderCellValue(edge.target_note, fromNote)
      ];
      if (filter.status === "true") {
        return [
          ...common,
          renderCellValue(edge.family, fromNote),
          renderCellValue(edge.evidence, fromNote),
          renderCellValue(edge.result_origin, fromNote),
          renderCellValue(edge.argument_note, fromNote),
          renderCellValue(edge.summary, fromNote)
        ];
      }
      if (filter.status === "false") {
        return [
          ...common,
          renderCellValue(edge.family, fromNote),
          renderCellValue(edge.evidence, fromNote),
          renderCellValue(edge.result_origin, fromNote),
          renderCellValue(edge.assumptions, fromNote),
          renderCellValue(edge.witness_note, fromNote),
          renderCellValue(edge.argument_note, fromNote),
          renderCellValue(edge.refs, fromNote),
          renderCellValue(edge.summary, fromNote)
        ];
      }
      if (filter.status === "open") {
        return [
          ...common,
          renderCellValue(edge.family, fromNote),
          renderCellValue(edge.argument_note, fromNote),
          renderCellValue(edge.refs, fromNote),
          renderCellValue(edge.summary, fromNote)
        ];
      }
      return [
        ...common,
        statusChip(edge.status),
        renderCellValue(edge.family, fromNote),
        renderCellValue(edge.evidence, fromNote),
        renderCellValue(edge.result_origin, fromNote),
        renderCellValue(edge.assumptions, fromNote),
        renderCellValue(edge.witness_note, fromNote),
        renderCellValue(edge.argument_note, fromNote),
        renderCellValue(edge.summary, fromNote)
      ];
    });

  if (filter.status === "true") {
    return tableHtml(["Source", "Target", "Family", "Evidence", "Result Origin", "Argument", "Summary"], rows);
  }
  if (filter.status === "false") {
    return tableHtml(["Source", "Target", "Family", "Evidence", "Result Origin", "Assumptions", "Witness", "Argument", "Refs", "Summary"], rows);
  }
  if (filter.status === "open") {
    return tableHtml(["Source", "Target", "Family", "Argument", "Refs", "Summary"], rows);
  }
  return tableHtml(["Source", "Target", "Status", "Family", "Evidence", "Result Origin", "Assumptions", "Witness", "Argument", "Summary"], rows);
}

function renderAuditMatrix(fromNote) {
  const defs = [...definitions]
    .filter(def => def.domain === "binary-classification")
    .sort(auditDefinitionSort);

  const headers = ["Source / Target", ...defs.map(def => def.title)];
  const rows = defs.map(source => [
    noteLink(source._note, source.title, fromNote),
    ...defs.map(target => {
      if (source.id === target.id) return "same";
      const edge = implicationsByPair.get(`${source.id}=>${target.id}`);
      if (!edge) return "missing";
      const assumptions = asArray(edge.assumptions).length ? ` (${asArray(edge.assumptions).join(", ")})` : "";
      return edgeNoteLink(edge, `${edge.status}${assumptions}`, fromNote);
    })
  ]);
  return tableHtml(headers, rows, { className: "atlas-table audit-matrix" });
}

function renderOpenEdgesDashboard(fromNote) {
  return `<div id="atlas-open-edges-dashboard" data-root="${escapeAttr(rootPrefix(fromNote.htmlPath))}"></div>`;
}

function renderAllEdgesDashboard(fromNote) {
  return `<div id="atlas-all-edges-dashboard" data-root="${escapeAttr(rootPrefix(fromNote.htmlPath))}"></div>`;
}

function renderBinaryDashboard(fromNote) {
  return `<div id="atlas-binary-dashboard" data-root="${escapeAttr(rootPrefix(fromNote.htmlPath))}"></div>`;
}

function renderMulticlassDashboard(fromNote) {
  return `<div id="atlas-multiclass-dashboard" data-root="${escapeAttr(rootPrefix(fromNote.htmlPath))}"></div>`;
}

function renderBinaryDashboardBlock(fromNote, code) {
  if (code.includes('family === "monotone-relaxation"')) return renderImmediateRelaxations(fromNote);
  if (code.includes("argumentsById")) return renderImplicationFamilies(fromNote);
  if (code.includes("witnessesById")) return renderWitnessCoverage(fromNote);
  if (code.includes("GROUP BY family")) return renderOpenQuestionsByObstruction(fromNote);
  if (code.includes("edgeByPair")) return renderAuditMatrix(fromNote);
  if (code.includes('status = "true"')) return renderImplicationsTable(fromNote, { status: "true" });
  if (code.includes('status = "false"')) return renderImplicationsTable(fromNote, { status: "false" });
  if (code.includes('status = "open"')) return renderImplicationsTable(fromNote, { status: "open" });
  if (code.includes('characterization_status AS "Status"')) return renderCharacterizationStatus(fromNote);
  if (code.includes('FROM "atlas/definitions"')) return renderDefinitionsTable(fromNote);
  if (code.includes('FROM "atlas/implications"')) return renderImplicationsTable(fromNote);
  return `<p class="notice">This Dataview query is not rendered in the static export.</p>`;
}

function replaceDataviewBlocks(note, body) {
  return body.replace(/```dataview(js)?\n([\s\S]*?)```/g, (_match, _kind, code) => {
    if (note.type === "definition") return renderDefinitionDataview(note, code);
    if (note.id === "binary-classification-dashboard") return renderBinaryDashboardBlock(note, code);
    if (note.id === "open-edges-dashboard") return renderOpenEdgesDashboard(note);
    if (note.id === "all-edges-dashboard") return renderAllEdgesDashboard(note);
    return `<p class="notice">This Dataview query is not rendered in the static export.</p>`;
  });
}

function frontmatterPanel(note) {
  const rows = Object.entries(note.fm).map(([key, value]) => [
    `<dt>${escapeHtml(key)}</dt>`,
    `<dd>${renderCellValue(value, note)}</dd>`
  ].join("\n"));
  return [
    `<details class="metadata-panel">`,
    `<summary>Frontmatter</summary>`,
    `<dl>${rows.join("\n")}</dl>`,
    `</details>`
  ].join("\n");
}

function pageChrome(note, contentHtml) {
  const cssHref = relativeHref(note.htmlPath, "assets/site.css");
  const dataHref = relativeHref(note.htmlPath, "assets/atlas-data.js");
  const dashboardHref = relativeHref(note.htmlPath, "assets/dashboard.js");
  const homeHref = relativeHref(note.htmlPath, "index.html");
  const readme = resolveNote("README");
  const binary = resolveNote("dashboards/binary-classification");
  const multiclass = resolveNote("multiclass/dashboards/multiclass-classification");
  const allEdges = resolveNote("dashboards/all-edges");
  const openEdges = resolveNote("dashboards/open-edges");
  const dashboardScripts = note.type === "dashboard"
    ? `\n<script defer src="${escapeAttr(dataHref)}"></script>\n<script defer src="${escapeAttr(dashboardHref)}"></script>`
    : "";
  return `<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>${escapeHtml(note.title)} - Learning Atlas</title>
  <link rel="stylesheet" href="${escapeAttr(cssHref)}">
  <script>
    window.MathJax = {
      tex: {
        inlineMath: [["$", "$"], ["\\\\(", "\\\\)"]],
        displayMath: [["$$", "$$"], ["\\\\[", "\\\\]"]],
        processEscapes: true
      },
      svg: { fontCache: "global" }
    };
  </script>
  <script defer src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-svg.js"></script>${dashboardScripts}
</head>
<body class="type-${escapeAttr(note.type ?? "note")} section-${escapeAttr(note.atlasRelPath.split("/")[0] ?? "atlas")}">
  <header class="site-header">
    <a class="brand" href="${escapeAttr(homeHref)}">Learning Atlas HTML</a>
    <nav>
      ${readme ? noteLink(readme, "Atlas README", note) : ""}
      ${binary ? noteLink(binary, "Binary Dashboard", note) : ""}
      ${multiclass ? noteLink(multiclass, "Multiclass Dashboard", note) : ""}
      ${allEdges ? noteLink(allEdges, "All Edges", note) : ""}
      ${openEdges ? noteLink(openEdges, "Open Edges", note) : ""}
    </nav>
  </header>
  <main class="page">
    <p class="breadcrumb">${escapeHtml(note.sourcePath)}</p>
    ${note.type === "dashboard" ? "" : frontmatterPanel(note)}
    <article class="content">
${contentHtml}
    </article>
  </main>
</body>
</html>
`;
}

function renderNotePage(note) {
  if (note.id === "all-edges-dashboard") {
    return pageChrome(note, renderMarkdown(`# ${note.title}\n\n${renderAllEdgesDashboard(note)}`, note));
  }
  if (note.id === "open-edges-dashboard") {
    return pageChrome(note, renderMarkdown(`# ${note.title}\n\n${renderOpenEdgesDashboard(note)}`, note));
  }
  if (note.id === "binary-classification-dashboard") {
    const body = [
      `# ${note.title}`,
      "",
      "Use the controls below to explore learning notions and directed implication edges. The tables update immediately as filters change.",
      "",
      renderBinaryDashboard(note)
    ].join("\n");
    return pageChrome(note, renderMarkdown(body, note));
  }
  if (note.id === "multiclass-classification-dashboard") {
    const body = [
      `# ${note.title}`,
      "",
      "Use the controls below to explore finite-label multiclass notions and directed implication edges. The tables update immediately as filters change.",
      "",
      renderMulticlassDashboard(note)
    ].join("\n");
    return pageChrome(note, renderMarkdown(body, note));
  }
  const body = replaceDataviewBlocks(note, note.body);
  return pageChrome(note, renderMarkdown(body, note));
}

function dataForDashboard() {
  return {
    counts: {
      notes: notes.length,
      definitions: definitions.length,
      implications: implications.length
    },
    axisFields,
    axisLabels,
    axisOptions,
    definitions: definitions.map(def => ({
      id: def.id,
      title: def.title,
      htmlPath: def._note.htmlPath,
      domain: def.domain,
      resource: def.resource,
      distribution: def.distribution,
      strength: def.strength,
      realizability: def.realizability,
      properness: def.properness,
      model: def.model,
      characterization_status: def.characterization_status
    })),
    edges: implications.map(edge => ({
      id: edge.id,
      source: edge.source,
      target: edge.target,
      sourceTitle: definitionsById.get(edge.source)?.title ?? edge.source,
      targetTitle: definitionsById.get(edge.target)?.title ?? edge.target,
      domain: edge.domain,
      status: edge.status,
      evidence: edge.evidence,
      result_origin: edge.result_origin ?? "",
      assumptions: asArray(edge.assumptions),
      family: edge.family,
      summary: edge.summary,
      htmlPath: edge._note.htmlPath
    }))
  };
}

function siteCss() {
  return `:root {
  color-scheme: light;
  --bg: #f7f7f4;
  --paper: #ffffff;
  --paper-soft: #f0f3f7;
  --ink: #202124;
  --muted: #667085;
  --line: #d9dee7;
  --link: #1c5d99;
  --link-hover: #0b3f6f;
  --true: #236c45;
  --false: #a64242;
  --open: #9a6218;
  --code-bg: #eef1f5;
}

* {
  box-sizing: border-box;
}

body {
  margin: 0;
  background: var(--bg);
  color: var(--ink);
  font-family: ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
  line-height: 1.6;
}

a {
  color: var(--link);
  text-decoration-thickness: 0.08em;
  text-underline-offset: 0.16em;
}

a:hover {
  color: var(--link-hover);
}

.site-header {
  align-items: center;
  background: var(--paper);
  border-bottom: 1px solid var(--line);
  display: flex;
  gap: 1rem;
  justify-content: space-between;
  padding: 0.7rem max(1rem, calc((100vw - 1180px) / 2));
  position: sticky;
  top: 0;
  z-index: 10;
}

.brand {
  color: var(--ink);
  font-weight: 750;
  text-decoration: none;
}

.site-header nav {
  display: flex;
  flex-wrap: wrap;
  gap: 0.75rem;
  justify-content: flex-end;
}

.page {
  margin: 0 auto;
  max-width: 1120px;
  padding: 1.2rem 1rem 4rem;
}

.type-dashboard .page {
  max-width: 1440px;
}

.breadcrumb {
  color: var(--muted);
  font-size: 0.82rem;
  margin: 0 0 0.7rem;
}

.content {
  background: var(--paper);
  border: 1px solid var(--line);
  padding: clamp(1rem, 2.4vw, 2rem);
}

.content h1,
.content h2,
.content h3 {
  line-height: 1.25;
  margin-top: 1.7em;
}

.content h1:first-child {
  margin-top: 0;
}

.content p,
.content li {
  max-width: 82ch;
}

.content code,
.metadata-panel code {
  background: var(--code-bg);
  border-radius: 4px;
  padding: 0.08rem 0.28rem;
}

.content pre {
  background: #17202a;
  color: #f4f7fb;
  overflow-x: auto;
  padding: 1rem;
}

.metadata-panel {
  background: var(--paper);
  border: 1px solid var(--line);
  margin-bottom: 1rem;
  padding: 0.75rem 1rem;
}

.metadata-panel summary {
  cursor: pointer;
  font-weight: 700;
}

.metadata-panel dl {
  display: grid;
  gap: 0.35rem 1rem;
  grid-template-columns: minmax(8rem, 0.32fr) 1fr;
  margin: 0.75rem 0 0;
}

.metadata-panel dt {
  color: var(--muted);
  font-weight: 700;
}

.metadata-panel dd {
  margin: 0;
  min-width: 0;
}

.table-wrap {
  border: 1px solid var(--line);
  margin: 1rem 0;
  overflow-x: auto;
}

.atlas-table {
  background: var(--paper);
  border-collapse: collapse;
  font-size: 0.9rem;
  min-width: 100%;
}

.atlas-table th,
.atlas-table td {
  border-bottom: 1px solid var(--line);
  padding: 0.5rem 0.6rem;
  text-align: left;
  vertical-align: top;
}

.atlas-table th {
  background: var(--paper-soft);
  color: #384152;
  font-size: 0.78rem;
  letter-spacing: 0;
  position: sticky;
  top: 3.15rem;
  z-index: 2;
}

.audit-matrix {
  font-size: 0.76rem;
}

.audit-matrix th,
.audit-matrix td {
  white-space: nowrap;
}

.status-chip {
  border-radius: 999px;
  display: inline-block;
  font-size: 0.75rem;
  font-weight: 750;
  line-height: 1.4;
  padding: 0.08rem 0.48rem;
}

.status-true {
  background: rgba(35, 108, 69, 0.14);
  color: var(--true);
}

.status-false {
  background: rgba(166, 66, 66, 0.14);
  color: var(--false);
}

.status-open {
  background: rgba(154, 98, 24, 0.16);
  color: var(--open);
}

.notice,
.empty-state,
.dashboard-summary {
  color: var(--muted);
}

.index-grid {
  display: grid;
  gap: 1rem;
  grid-template-columns: repeat(auto-fit, minmax(16rem, 1fr));
}

.index-card {
  background: var(--paper);
  border: 1px solid var(--line);
  padding: 1rem;
}

.index-card h2 {
  margin-top: 0;
}

.atlas-edge-dashboard {
  display: grid;
  gap: 1rem;
}

.atlas-edge-panel {
  background: var(--paper-soft);
  border: 1px solid var(--line);
  padding: 1rem;
}

.atlas-edge-topbar {
  align-items: end;
  display: grid;
  gap: 0.75rem;
  grid-template-columns: repeat(auto-fit, minmax(11rem, 1fr));
}

.atlas-edge-scope-grid {
  display: grid;
  gap: 0.9rem;
  margin-top: 0.9rem;
}

.atlas-edge-scope {
  display: grid;
  gap: 0.45rem;
}

.atlas-edge-scope-title {
  font-size: 0.95rem;
  margin: 0;
}

.atlas-edge-scope-note,
.atlas-edge-control span,
.atlas-edge-check span {
  color: var(--muted);
  font-size: 0.82rem;
  font-weight: 650;
}

.atlas-edge-axis-grid {
  display: grid;
  gap: 0.55rem;
  grid-template-columns: repeat(auto-fit, minmax(11rem, 1fr));
}

.atlas-edge-control {
  display: grid;
  gap: 0.25rem;
}

.atlas-edge-control input,
.atlas-edge-control select,
.atlas-edge-button {
  min-height: 2.15rem;
}

.atlas-edge-control input,
.atlas-edge-control select {
  border: 1px solid var(--line);
  border-radius: 4px;
  padding: 0.25rem 0.45rem;
}

.atlas-edge-control select:disabled {
  background: #e6e9ef;
  color: var(--muted);
}

.atlas-edge-check {
  align-items: center;
  display: flex;
  gap: 0.45rem;
  min-height: 2.15rem;
}

.atlas-edge-presets {
  display: flex;
  flex-wrap: wrap;
  gap: 0.45rem;
  margin-top: 0.75rem;
}

.atlas-edge-button {
  background: var(--paper);
  border: 1px solid var(--line);
  border-radius: 4px;
  color: var(--ink);
  cursor: pointer;
  padding: 0 0.7rem;
}

.atlas-edge-summary {
  margin: 0.2rem 0 0.5rem;
}

.dashboard-kpis {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
  margin: 0.25rem 0 0.75rem;
}

.dashboard-kpi {
  background: var(--paper-soft);
  border: 1px solid var(--line);
  border-radius: 4px;
  color: #384152;
  font-size: 0.85rem;
  font-weight: 700;
  padding: 0.25rem 0.5rem;
}

@media (max-width: 760px) {
  .site-header,
  .atlas-edge-topbar,
  .metadata-panel dl {
    grid-template-columns: 1fr;
  }

  .site-header {
    align-items: flex-start;
    display: grid;
  }

  .content {
    padding: 1rem;
  }
}
`;
}

function dashboardJs() {
  return `(() => {
  if (!window.ATLAS_DATA) return;
  const data = window.ATLAS_DATA;
  const axisFields = data.axisFields;
  const axisLabels = data.axisLabels;
  const axisOptions = data.axisOptions;
  const statusOptions = [["", "Any"], ["open", "Open"], ["false", "False"], ["true", "True"]];
  const resultOriginOptions = [["", "Any"], ["known", "Known"], ["unclear", "Unclear"], ["new", "New"]];
  const allDefsById = new Map(data.definitions.map(def => [def.id, def]));
  const normalize = value => String(value || "").toLowerCase();
  const textOf = value => Array.isArray(value) ? value.join(", ") : String(value || "");
  const blankAxes = () => Object.fromEntries(axisFields.map(axis => [axis, ""]));

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
    const domain = config.domain || "";
    const scopedDefinitions = data.definitions.filter(def => !domain || def.domain === domain);
    const defsById = domain
      ? new Map(scopedDefinitions.map(def => [def.id, def]))
      : allDefsById;
    const scopedEdges = data.edges.filter(edge => !domain || edge.domain === domain);
    const familyOptions = [["", "Any"], ...Array.from(new Set(scopedEdges.map(edge => edge.family).filter(Boolean))).sort().map(family => [family, family])];
    const edgeRows = scopedEdges.map(edge => ({
      edge,
      source: defsById.get(edge.source),
      target: defsById.get(edge.target)
    }));
    const base = (root.dataset.root || ".").replace(/\\/$/, "");
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
      return scopedDefinitions
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
      domain: "binary-classification",
      includeView: true
    },
    {
      id: "atlas-multiclass-dashboard",
      storageKey: "learning-atlas/html/multiclass-dashboard/v1",
      domain: "multiclass-classification",
      includeView: true
    }
  ];
  for (const config of configs) {
    const root = document.getElementById(config.id);
    if (root) initEdgeDashboard(root, config);
  }
})();`;
}

function indexPage() {
  const fakeNote = { htmlPath: "index.html", title: "Learning Atlas HTML", fm: {} };
  const dashboardNotes = [
    resolveNote("dashboards/binary-classification"),
    resolveNote("multiclass/dashboards/multiclass-classification"),
    resolveNote("dashboards/all-edges"),
    resolveNote("dashboards/open-edges")
  ].filter(Boolean);
  const statusCounts = implications.reduce((acc, edge) => {
    acc[edge.status] = (acc[edge.status] ?? 0) + 1;
    return acc;
  }, {});
  const sectionCounts = notes.reduce((acc, note) => {
    const section = note.atlasRelPath.split("/")[0] ?? "atlas";
    acc[section] = (acc[section] ?? 0) + 1;
    return acc;
  }, {});
  const cards = [
    ...dashboardNotes.map(note => `<section class="index-card"><h2>${noteLink(note, note.title, fakeNote)}</h2><p>${escapeHtml(note.sourcePath)}</p></section>`),
    `<section class="index-card"><h2>Atlas Export</h2><p>${notes.length} HTML pages generated from atlas Markdown.</p><p>${definitions.length} definitions, ${implications.length} implications.</p></section>`,
    `<section class="index-card"><h2>Implication Statuses</h2><p>${Object.entries(statusCounts).sort().map(([key, value]) => `${escapeHtml(key)}=${escapeHtml(value)}`).join(" ")}</p></section>`,
    `<section class="index-card"><h2>Sections</h2><p>${Object.entries(sectionCounts).sort().map(([key, value]) => `${escapeHtml(key)}=${escapeHtml(value)}`).join(" ")}</p></section>`
  ].join("\n");
  return `<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Learning Atlas HTML</title>
  <link rel="stylesheet" href="assets/site.css">
</head>
<body>
  <header class="site-header">
    <a class="brand" href="index.html">Learning Atlas HTML</a>
    <nav>${dashboardNotes.map(note => noteLink(note, note.title.replace(" Dashboard", ""), fakeNote)).join("")}</nav>
  </header>
  <main class="page">
    <article class="content">
      <h1>Learning Atlas HTML</h1>
      <p>Static browser export generated from the atlas Markdown source.</p>
      <div class="index-grid">
        ${cards}
      </div>
    </article>
  </main>
</body>
</html>
`;
}

async function writeText(relativePath, text) {
  const absolutePath = path.join(HTML_DIR, relativePath);
  await fs.mkdir(path.dirname(absolutePath), { recursive: true });
  await fs.writeFile(absolutePath, text, "utf8");
}

async function writeSite() {
  await fs.rm(HTML_DIR, { recursive: true, force: true });
  await writeText("assets/site.css", siteCss());
  await writeText("assets/dashboard.js", dashboardJs());
  await writeText("assets/atlas-data.js", `window.ATLAS_DATA = ${JSON.stringify(dataForDashboard())};\n`);
  await writeText("index.html", indexPage());
  for (const note of notes) {
    await writeText(note.htmlPath, renderNotePage(note));
  }
}

await loadNotes();
await writeSite();
console.log(`Generated ${notes.length} atlas HTML pages in ${path.relative(ROOT, HTML_DIR)}/`);
