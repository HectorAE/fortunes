# Makefile for generating and installing fortunes
# Supports both plain and m4 macro source files
# Written by Hector A Escobedo

## VARIABLES ##
# It's good hygiene to strip all variables to prevent weird errors.

# Compatibility and packaging special variables
DESTDIR = /
SHELL = /bin/sh

# Directory structure variables
SRCDIR = src
TOPICDIRS := $(strip $(addprefix $(SRCDIR)/, $(shell cd $(SRCDIR); for f in *;	\
do if [[ -d $$f ]]; then echo $$f; fi; done;)))

# All source files
SOURCES = $(strip $(filter-out $(TOPICDIRS), $(wildcard $(SRCDIR)/*) $(wildcard	\
$(SRCDIR)/*/*)))

# Existing source files
m4-sources := $(strip $(filter %.m4, $(SOURCES)))
plain-sources := $(strip $(filter-out %.m4 %.dat, $(SOURCES)))

# Targets to be built
plain-source-targets := $(strip $(patsubst %.m4, %, $(m4-sources)))
dat-targets := $(strip $(patsubst %, %.dat, $(plain-sources)	\
$(plain-source-targets)))

# Existing targets
plain-source-built = $(strip $(filter $(plain-source-targets), $(SOURCES)))
dat-built = $(strip $(filter %.dat, $(SOURCES)))
matching-built = $(strip $(filter $(patsubst %, %.dat, $(plain-sources)),	\
$(dat-built)) $(filter $(patsubst %.dat, %, $(dat-built)), $(plain-sources)))
matching-built-canonicalized = $(strip $(patsubst $(SRCDIR)/%, %,	\
$(matching-built)))

# User message variables
err-nothing-to-install = "Nothing to install yet. Try 'make all' first."

## RULES ##

.PHONY : all sources install clean clean-source-target clean-dat

# Target building rules

# Default, process macro sources and strfile all fortunes
all : sources $(dat-targets)

# Only process macro sources, do not strfile anything
sources : $(plain-source-targets)

# Automagical! Strfile anything to produce the target
%.dat : %
	strfile $<

# Run m4 on macro sources. Even more automagical (and terminal)
% :: %.m4
	m4 $< > $@

# File manipulation rules (don't need prerequisites)

# Install the fortune files to the regular place
install :
ifneq ($(matching-built),)
	cd $(SRCDIR); \
	for i in $(matching-built-canonicalized); do \
		install -m 644 -D $$i $(DESTDIR)usr/share/fortune/$$i; \
	done
else
	@echo $(err-nothing-to-install)
endif

# Delete all m4 processed source files
clean-source-target :
ifneq ($(plain-source-built),)
	rm $(plain-source-built)
endif

# Delete all .dat files
clean-dat :
ifneq ($(dat-built),)
	rm $(dat-built)
endif

# Delete all generated files
clean : clean-dat clean-source-target

# Special rules

# Clear and redefine the Make default suffixes
.SUFFIXES :
.SUFFIXES : .dat .m4
