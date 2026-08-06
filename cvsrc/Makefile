.PHONY: all cv resume microsoft clean

TYPST    ?= typst
CV_OUTPUT := ../cv.pdf
CV_SOURCE := cv.typ
RESUME_OUTPUT := ../resume.pdf
RESUME_SOURCE := resume.typ
MICROSOFT_OUTPUT := ../tmp/resume-microsoft.pdf
DATA     := ../_data/cv.yml ../_data/publications.yml
FONT_DIR := $(dir $(shell kpsewhich XCharter-Roman.otf 2>/dev/null))
FONT_ARG := $(if $(FONT_DIR),--font-path $(FONT_DIR),)
PDF_STANDARD := ua-1

all: cv resume

cv: $(CV_OUTPUT)

resume: $(RESUME_OUTPUT)

# Application-specific cut of the resume. Written to ../tmp so it is not
# published with the site.
microsoft: $(MICROSOFT_OUTPUT)

$(CV_OUTPUT): $(CV_SOURCE) $(DATA)
	$(TYPST) compile --root .. $(FONT_ARG) --pdf-standard $(PDF_STANDARD) $(CV_SOURCE) $(CV_OUTPUT)

$(RESUME_OUTPUT): $(RESUME_SOURCE) $(DATA)
	$(TYPST) compile --root .. $(FONT_ARG) --pdf-standard $(PDF_STANDARD) $(RESUME_SOURCE) $(RESUME_OUTPUT)

$(MICROSOFT_OUTPUT): $(RESUME_SOURCE) $(DATA)
	@mkdir -p $(dir $@)
	$(TYPST) compile --root .. $(FONT_ARG) --input variant=microsoft --pdf-standard $(PDF_STANDARD) $(RESUME_SOURCE) $@

clean:
	rm -f $(CV_OUTPUT) $(RESUME_OUTPUT) $(MICROSOFT_OUTPUT)
