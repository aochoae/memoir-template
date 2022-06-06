
# Document
DOCUMENT = book

# TeX
TEX      = lualatex
TEXFLAGS = --shell-escape

BIB      = biber
BIBFLAGS = --validate-datamodel

# Make
MKFLAGS  = -j 2 -f $(DOCUMENT).makefile

# Auxiliar files
AUXFILES = $(shell cat .hidden)

build:
	$(TEX)  $(TEXFLAGS) $(DOCUMENT)
	$(MAKE) $(MKFLAGS)
	$(BIB)  $(BIBFLAGS) $(DOCUMENT)
	$(TEX)  $(TEXFLAGS) $(DOCUMENT)
	$(TEX)  $(TEXFLAGS) $(DOCUMENT)

clean:
	$(RM) $(AUXFILES) images/*
	$(RM) -r _minted-book

