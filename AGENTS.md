# Repository Guidelines

## Project Structure & Module Organization

This repo is now primarily a Markdown knowledge base for learning-theory notes, not a LaTeX-first document project. Treat `atlas/` as the main source of truth.

- `atlas/definitions/`: one Obsidian-friendly Markdown note per learning notion or graph node.
- `atlas/implications/`: one Markdown note per directed implication edge between definition nodes.
- `atlas/dashboards/`: Obsidian Dataview dashboards for querying the graph.
- `atlas/README.md`: conventions for the atlas schema and Obsidian setup.
- `references.bib`: shared bibliography keys used by atlas frontmatter and any legacy LaTeX.
- `main.tex`, `sections/`, `main.pdf`: legacy report material. Do not edit or compile these unless the user explicitly asks for LaTeX/PDF work.
- `scripts/`: helper tooling. Keep scripts small, explicit, and safe to rerun.

When adding knowledge to the implication graph, prefer creating or updating the corresponding Markdown file under `atlas/definitions/` or `atlas/implications/`. Keep graph metadata queryable in YAML frontmatter and put the explanatory mathematics in the Markdown body.

## Atlas File Conventions

Definition notes are graph nodes. They should use stable frontmatter fields such as:

- `type: definition`
- `id`
- `title`
- `domain`
- `model`
- `realizability`
- `properness`
- `strength`
- `distribution`
- `characterization_status`
- `characterization_ref_keys`
- `characterization_refs`

Implication notes are directed graph edges. They should use:

- `type: implication`
- `id`
- `source`
- `target`
- `source_note`
- `target_note`
- `status`
- `evidence`
- `assumptions`
- `witnesses`
- `ref_keys`
- `refs`
- `summary`

Use only these implication statuses unless the schema is intentionally changed:

- `status: "true"` for known implications.
- `status: "false"` for known non-implications or separations.
- `status: "open"` for unresolved edges.

Use `evidence` to distinguish the reason for a status, for example `trivial`, `theorem`, `conditional-theorem`, `counterexample`, `conditional-counterexample`, or `unknown`.

If a false edge depends on a complexity, cryptographic, or other conditional assumption, keep `status: "false"` and record the assumption in `assumptions`.

## Markdown Style & Naming

Use concise, source-grounded prose. Prefer short paragraphs over long blocks.

- File names: lowercase descriptive slugs, e.g. `efficient-realizable-proper-pac.md`.
- Markdown headings: Title Case for major sections.
- Obsidian links: use wiki links for local graph notes, e.g. `[[efficient-realizable-proper-pac|Efficient Realizable Proper PAC Learning]]`.
- Math: use Obsidian-compatible `$...$` and `$$...$$`.
- BibTeX keys: use stable keys such as `surnameYYYY` when practical, e.g. `pitt1988`.
- References: keep BibTeX entries centralized in `references.bib`; cite them from frontmatter with `ref_keys` or `characterization_ref_keys`, and include clickable Markdown references in the note body.

Avoid speculative theorem claims. When stating a result, cite a primary source and distinguish proved statements, conditional hardness, counterexamples, and open questions.

## Proof Writing Style

Prefer a top-down proof style.

- State the main goal precisely before giving any proof details.
- Break the proof into explicit subgoals or lemmas, and explain why proving them establishes the claim.
- For reductions, first specify the source instance and the target instance. In learning-theory reductions, this usually means naming the hypothesis class and the distribution or labeling rule before analyzing them.
- Only after the setup and proof plan are clear should you explain how each subgoal is proved.
- When possible, separate `construction`, `why the construction works`, and `conclusion` into distinct paragraphs or lemmas.
- For implication edges, make the verdict clear near the top: true, false, or open, including any assumptions.

The target audience is mathematically mature but not specialist. Write so that a strong third-year undergraduate can reconstruct the omitted steps from the sketch.

## Validation Commands

There is no full automated test suite. Before submitting atlas changes, run focused consistency checks.

Check that Markdown frontmatter parses:

```sh
ruby - <<'RUBY'
require 'psych'
Dir['atlas/**/*.md'].each do |f|
  s = File.read(f)
  next unless s.start_with?("---\n")
  Psych.safe_load(s.split("---\n", 3)[1], permitted_classes: [], aliases: false)
end
puts 'frontmatter YAML parses'
RUBY
```

Check that atlas citation keys exist in `references.bib`:

```sh
ruby - <<'RUBY'
require 'psych'
require 'set'
refs = File.read('references.bib').scan(/^@\w+\{([^,]+),/).flatten.to_set
missing = []
Dir['atlas/**/*.md'].each do |f|
  lines = File.readlines(f, chomp: true)
  lines.each_with_index do |line, i|
    next unless line =~ /^(ref_keys|characterization_ref_keys):\s*$/
    j = i + 1
    while j < lines.length && lines[j] =~ /^\s+-\s+(.+)$/
      key = $1.strip.delete('"')
      missing << [f, key] unless refs.include?(key)
      j += 1
    end
  end
end
if missing.empty?
  puts 'all ref_keys found in references.bib'
else
  missing.each { |f, k| puts "missing #{k} in #{f}" }
  exit 1
end
RUBY
```

Check that the directed implication graph is complete:

```sh
ruby - <<'RUBY'
require 'psych'
require 'set'
defs = Dir['atlas/definitions/*.md'].map do |f|
  Psych.safe_load(File.read(f).split("---\n", 3)[1], permitted_classes: [], aliases: false)['id']
end
edges = Dir['atlas/implications/*.md'].map do |f|
  fm = Psych.safe_load(File.read(f).split("---\n", 3)[1], permitted_classes: [], aliases: false)
  [fm['source'], fm['target']]
end.to_set
missing = []
defs.each { |s| defs.each { |t| missing << [s, t] if s != t && !edges.include?([s, t]) } }
if missing.empty?
  puts 'complete directed implication graph'
else
  missing.each { |s, t| puts "missing #{s} -> #{t}" }
  exit 1
end
RUBY
```

Count implication statuses:

```sh
ruby - <<'RUBY'
require 'psych'
counts = Hash.new(0)
Dir['atlas/implications/*.md'].each do |f|
  fm = Psych.safe_load(File.read(f).split("---\n", 3)[1], permitted_classes: [], aliases: false)
  counts[fm['status']] += 1
end
puts counts.sort.map { |k, v| "#{k}=#{v}" }.join(' ')
RUBY
```

Only run `make pdf`, `tectonic main.tex`, or other LaTeX build commands when the user explicitly asks to update the legacy PDF/report.

## Change Management

You may encounter a dirty worktree. Do not revert user changes unless explicitly requested. If changes are unrelated to the current task, leave them alone.

For graph updates:

- Keep edits scoped to the affected definition and implication notes.
- Preserve stable `id`, `source`, and `target` values unless intentionally migrating the schema.
- When adding a new definition node, add all corresponding implication edge notes or clearly document why the graph is intentionally incomplete.
- When changing an edge status, update the verdict, evidence, assumptions, witnesses, refs, and explanatory body together.
- Verify new theorem statements against the cited source.

## Commit & Pull Request Guidelines

Use simple imperative commit messages, such as:

- `Add marginal-nonuniform PAC nodes`
- `Resolve halfspace agnostic implication edges`
- `Refine properization open-edge notes`

Pull requests should include a short summary, the affected atlas nodes or edge families, any new references added, and which validation checks succeeded. Mention LaTeX/PDF status only if the report was intentionally changed.
