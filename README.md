# Learning Theory Atlas

This repo builds a reference document on learning models in learning theory and statistics, with an emphasis on:

- exact definitions
- implication and equivalence relationships
- separations and hardness barriers
- open gaps

The first implemented slice focuses on binary distribution-free PAC learning and, in particular, the distinction between:

- realizable vs agnostic PAC learning
- proper vs improper learners
- sample-efficient vs computationally efficient learnability

## Structure

- `atlas/`: Markdown source of truth for the learning-definition graph
- `html/`: generated static HTML export of `atlas/`
- `scripts/build-html-site.mjs`: HTML export generator
- `main.tex`: report entrypoint
- `sections/`: chapter content
- `references.bib`: bibliography
- `Makefile`: build entrypoints

## HTML Atlas Export

The static browser export is generated from the Markdown notes under `atlas/`.

Regenerate it after changing atlas notes, dashboards, or graph metadata:

```sh
npm install
npm run build:html
```

Open the generated site from:

```text
html/index.html
```

The export mirrors `atlas/**/*.md` to `html/atlas/**/*.html`, renders Obsidian-style math through MathJax, converts wiki links to local HTML links, and replaces Dataview dashboard blocks with static or client-side HTML tables.

## PDF Build

Preferred:

```sh
make pdf
```

This tries `latexmk` first and falls back to `tectonic`. The `Makefile` also checks `~/.local/bin`, which is useful when `tectonic` is installed as a user-local binary.

If Skim is installed, `make pdf` also refreshes `main.pdf` in Skim after a successful build. The repo ships a small AppleScript-backed helper for this so the PDF reloads without depending only on filesystem watching.

If you want to invoke a tool directly:

```sh
latexmk -pdf main.tex
```

or

```sh
tectonic main.tex
```

## Current status

The repository currently contains:

- a report skeleton
- a high-level atlas outline
- a first PAC chapter centered on when efficient realizable PAC learning and efficient agnostic PAC learning are equivalent
- a first-pass bibliography for the PAC chapter

The current PAC chapter is intentionally theorem-map oriented. It separates proved implications from conditional hardness and from cells that remain open or model-dependent.
