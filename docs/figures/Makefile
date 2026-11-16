# Each NAME.py prints NAME.svg; svg.py is the shared helper.
PYTHON = python3
FIGURES = $(patsubst %.py,%.svg,$(filter-out svg.py,$(wildcard *.py)))

all: $(FIGURES)

%.svg: %.py svg.py
	$(PYTHON) -B $*.py > $@

clean:
	rm -f $(FIGURES)

.PHONY: all clean
