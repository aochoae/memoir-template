#
# A memoir template for Computer Science
#
# Debian GNU/Linux
#

# Document
DOCUMENT = $(patsubst %.tex, %, $(wildcard *.tex))

# TeX
UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S), Darwin)
	TEX = /Library/TeX/texbin/lualatex
else
	TEX = lualatex
endif

TEXFLAGS = --shell-escape

# Bibliography
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
