#
# A memoir template for Computer Science
#
# Debian GNU/Linux
#

# Document
DOCUMENT = $(patsubst %.tex, %, $(wildcard *.tex))

# TeX
TEX      = lualatex
TEXFLAGS = --shell-escape

BIB      = biber
BIBFLAGS = --validate-datamodel

# Make
TIKZFLAGS = -j 2 -f $(DOCUMENT).makefile

build:
	$(MAKE) .tex
	$(MAKE) .tikz
	$(MAKE) .bib
	$(MAKE) .tex
	$(MAKE) .tex

.tex:
	$(TEX)  $(TEXFLAGS) $(DOCUMENT)

.tikz:
ifeq ($(wildcard $(DOCUMENT).makefile),)
else
	$(MAKE) $(TIKZFLAGS)
endif

.bib:
	$(BIB)  $(BIBFLAGS) $(DOCUMENT)

clean:
	$(RM) *.aux *.bbl *.bcf *.blg *.lof *.lol *.lot *.run.xml *.toc *.pdf
	$(RM) images/*
	$(RM) -r _minted-*
