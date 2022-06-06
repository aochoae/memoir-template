#
# A memoir template for Computer Science
#
# Debian GNU/Linux
#

# Document
DOCUMENT = book

# TeX
TEX      = lualatex
TEXFLAGS = --shell-escape

BIB      = biber
BIBFLAGS = --validate-datamodel

# Make
TIKZFLAGS = -j 2 -f $(DOCUMENT).makefile

build:
	$(TEX)  $(TEXFLAGS) $(DOCUMENT)
	$(MAKE) .tikz
	$(BIB)  $(BIBFLAGS) $(DOCUMENT)
	$(TEX)  $(TEXFLAGS) $(DOCUMENT)
	$(TEX)  $(TEXFLAGS) $(DOCUMENT)

.tikz:
ifeq ($(wildcard $(DOCUMENT).makefile),)
else
	$(MAKE) $(TIKZFLAGS)
endif

clean:
	$(RM) *.aux *.bbl *.bcf *.blg *.lof *.lot *.run.xml *.toc *.pdf
	$(RM) images/*
	$(RM) -r _minted-*
