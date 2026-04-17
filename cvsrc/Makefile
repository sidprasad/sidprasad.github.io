.PHONY: all clean

BUILD  := build
OUTPUT := ../cv.pdf

all: $(OUTPUT)

$(OUTPUT): cv.tex | $(BUILD)
	latexmk -pdf -interaction=nonstopmode -halt-on-error -output-directory=$(BUILD) cv.tex
	cp $(BUILD)/cv.pdf $(OUTPUT)

$(BUILD):
	mkdir -p $(BUILD)

clean:
	rm -rf $(BUILD)
