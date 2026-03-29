# Repository Guidelines

## Project Structure & Module Organization

This repo is a LaTeX document project, not an application codebase.

- `main.tex`: top-level report entrypoint
- `sections/`: chapter files such as `pac.tex` and `statistics.tex`
- `references.bib`: shared bibliography
- `scripts/`: helper tooling; currently `refresh_skim.sh`
- `main.pdf`: generated output; treat it as a build artifact

Add new content as a focused section file in `sections/` and include it from `main.tex`. Keep bibliography updates centralized in `references.bib`.

## Build, Test, and Development Commands

- `make pdf`: compile `main.tex` using `latexmk` or `tectonic`
- `make clean`: remove TeX build artifacts
- `tectonic main.tex`: direct one-off compile if you do not want the Makefile

`make pdf` is the main validation step. In this repo, “testing” currently means producing a clean, readable PDF with resolved citations and expected section ordering.

## Coding Style & Naming Conventions

Use concise, source-grounded prose. Prefer short paragraphs over long blocks.

- File names: lowercase with descriptive names, e.g. `open-problems.tex`
- Headings: Title Case in LaTeX section commands
- BibTeX keys: `surnameYYYY` when practical, e.g. `pitt1988`
- Scripts: keep them small, executable, and explicit about shell assumptions

Avoid speculative theorem claims. When stating a result, cite a primary source and distinguish proved statements from open questions or conditional hardness.

## Testing Guidelines

There is no separate automated test suite yet.

Before submitting changes:

- run `make pdf`
- check that the PDF builds successfully
- scan for broken citations, missing references, or obvious formatting regressions
- verify new theorem statements against the cited source

## Commit & Pull Request Guidelines

There is no existing commit history yet, so use simple imperative commit messages such as:

- `Add proper vs improper PAC separation example`
- `Refine PAC bibliography`

Pull requests should include a short summary, the affected sections, any new references added, and note whether `make pdf` succeeded. Include a screenshot only if the visual layout change is important to review.
