# Makefile for generating and installing fortunes
# Supports both plain and m4 macro source files
# Written by Hector A Escobedo

# VARIABLES
# It's good hygiene to strip all variables to prevent weird errors.

# Compatibility and packaging special variables
DESTDIR = /
SHELL = /bin/sh

# User message variables
err-nothing-to-install = "Nothing to install yet. Try 'make all' first."

# Macro source variables
all-m4-source := $(strip $(filter %.m4, $(wildcard */*)))
all-m4-source-homestuck := $(strip $(filter homestuck/%, $(all-m4-source)))

# Sources variables
all-source := $(strip $(filter-out %.m4 %.dat, $(wildcard */*)))
all-source-homestuck := $(strip $(filter homestuck/%, $(all-source)))

# Sources that must be processed first
all-source-target := $(strip $(patsubst %.m4, %, $(all-m4-source)))
all-source-target-homestuck := $(strip $(filter homestuck/%,	\
$(all-source-target)))

# .dat target variables
all-dat := $(strip $(patsubst %, %.dat, $(all-source) $(all-source-target)))
all-dat-homestuck := $(strip $(filter homestuck/%, $(all-dat)))

# "What have we already built" variables to help with install
all-dat-built = $(strip $(wildcard */*.dat))
all-dat-built-homestuck = $(strip $(filter homestuck/%, $(all-dat-built)))

# Source files for which a .dat has been built
all-source-built = $(strip $(filter $(patsubst %.dat, %,	\
$(all-dat-built)), $(all-source)))

# .dat files for which a source exists (they may be accidentally deleted)
all-dat-built-matching-source = $(strip $(filter $(patsubst %, %.dat,	\
$(all-source-built)), $(all-dat-built)))

# Source files that have been processed by m4
all-source-target-built = $(strip $(filter $(patsubst %.m4, %,	\
$(all-m4-source)), $(all-source)))
all-source-target-built-homestuck = $(strip $(filter homestuck/%,	\
$(all-source-target-built)))

# All source and .dat files that match
all-matching-built = $(strip $(all-source-built)	\
$(all-dat-built-matching-source))

# RULES

# Target building rules

# Default, strfile all fortunes
all : $(all-source-target) $(all-dat)

# Only the ./homestuck directory
all-homestuck : $(all-source-target-homestuck) $(all-dat-homestuck)

# Only process macro sources, do not strfile anything
sources : $(all-source-target)

# Only the ./homestuck directory
sources-homestuck : $(all-source-target-homestuck)

# Automagical! Strfile anything to produce the target
%.dat : %
	strfile $<

# Run m4 on macro sources. Even more automagical (and terminal)
% :: %.m4
	m4 $< > $@

# File manipulation rules (don't need prerequisites)

# Install the fortune files to the regular place
install :
ifneq ($(all-matching-built),)
	@for i in $(all-matching-built); do \
		install -m 644 -D $$i $(DESTDIR)usr/share/fortune/$$i; \
	done
else
	@echo $(err-nothing-to-install)
endif

# Delete all m4 processed source files
clean-source-target :
ifneq ($(all-source-target-built),)
	rm $(all-source-target-built)
endif

# Delete all .dat files
clean-dat :
ifneq ($(all-dat-built),)
	rm $(all-dat-built)
endif

# Delete all generated files
clean : clean-dat clean-source-target

# Delete all m4 processed source files in ./homestuck
clean-source-target-homestuck :
ifneq ($(all-source-target-built-homestuck),)
	rm $(all-source-target-built-homestuck)
endif

# Delete all .dat files in ./homestuck
clean-dat-homestuck :
ifneq ($(all-dat-built-homestuck),)
	rm $(all-dat-built-homestuck)
endif

# Delete all generated files in ./homestuck
clean-homestuck : clean-dat-homestuck clean-source-target-homestuck

# Special rules

# Clear and redefine the Make default suffixes
.SUFFIXES :
.SUFFIXES : .dat .m4
