LOCAL_BIN := $(HOME)/.local/bin
PDF_TOOL := $(shell PATH="$(LOCAL_BIN):$$PATH"; if command -v latexmk >/dev/null 2>&1; then echo latexmk; elif command -v tectonic >/dev/null 2>&1; then echo tectonic; else echo none; fi)
PDF_PATH := $(abspath main.pdf)

.PHONY: pdf refresh-skim clean

pdf:
ifeq ($(PDF_TOOL),latexmk)
	PATH="$(LOCAL_BIN):$$PATH" latexmk -pdf main.tex
else ifeq ($(PDF_TOOL),tectonic)
	PATH="$(LOCAL_BIN):$$PATH" tectonic main.tex
else
	@echo "No TeX build tool found. Install latexmk or tectonic."
	@exit 1
endif
	@$(MAKE) refresh-skim

refresh-skim:
	@./scripts/refresh_skim.sh "$(PDF_PATH)"

clean:
	rm -f *.aux *.bbl *.bcf *.blg *.fdb_latexmk *.fls *.lof *.log *.lot *.out *.pdf *.run.xml *.synctex.gz *.toc
