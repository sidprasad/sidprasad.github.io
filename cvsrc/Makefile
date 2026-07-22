.PHONY: all clean

TYPST    ?= typst
OUTPUT   := ../cv.pdf
SOURCE   := cv.typ
DATA     := ../_data/cv.yml ../_data/publications.yml
FONT_DIR := $(dir $(shell kpsewhich XCharter-Roman.otf 2>/dev/null))
FONT_ARG := $(if $(FONT_DIR),--font-path $(FONT_DIR),)
PDF_STANDARD := ua-1

all: $(OUTPUT)

$(OUTPUT): $(SOURCE) $(DATA)
	$(TYPST) compile --root .. $(FONT_ARG) --pdf-standard $(PDF_STANDARD) $(SOURCE) $(OUTPUT)

clean:
	rm -f $(OUTPUT)
