# Makefile for strfile-ing and installing fortunes
# Written by Hector A Escobedo

# VARIABLES

# Compatibility and packaging special variables
DESTDIR = /
SHELL = /bin/sh

# User message variables
err-nothing-to-clean = "Nothing to clean."
err-nothing-to-install = "Nothing to install yet. Try 'make all' first."

# Sources variables
all-source := $(strip $(filter-out %.dat, $(wildcard */*)))
all-source-homestuck := $(strip $(filter homestuck/%, $(all-source)))

# Targets variables
all-dat := $(strip $(patsubst %, %.dat, $(all-source)))
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
# All source and .dat files that match
all-matching-built = $(strip $(all-source-built)	\
$(all-dat-built-matching-source))

# RULES

# Target building rules

# Default, strfile all fortunes
all : $(all-dat)

# Only the homestuck directory
all-homestuck: $(all-dat-homestuck)

# Automagical! Strfile anything to produce the target
%.dat : %
	strfile $<

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

# Delete all .dat files
clean :
ifneq ($(all-dat-built),)
	rm $(all-dat-built)
else
	@echo $(err-nothing-to-clean)
endif

# Delete all .dat files in the homestuck directory
clean-homestuck:
ifneq ($(all-dat-built-homestuck),)
	rm $(all-dat-built-homestuck)
else
	@echo $(err-nothing-to-clean)
endif

# Special rules

# Clear and redefine the Make default suffixes
.SUFFIXES :
.SUFFIXES : .dat
