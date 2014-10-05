# Makefile for strfile-ing and installing fortunes
# by Hector A Escobedo

# VARIABLES

# Compatibility and packaging special variables
DESTDIR = /
SHELL = /bin/sh

# Targets variables
all-dat := $(strip $(patsubst %, %.dat, $(filter-out %.dat, $(wildcard */*))))
all-dat-homestuck := $(strip $(filter homestuck/%, $(all-dat)))

# RULES

all : $(all-dat)

all-homestuck: $(all-dat-homestuck)

# Automagical!
%.dat : %
	strfile $^

# install :
# ifneq ($(strip $(wildcard */*.dat)),)
# ifeq ($(findstring homestuck/davestrider.dat,$(wildcard homestuck/*.dat)),homestuck/davestrider.dat)
# 	install -m 644 -D homestuck/davestrider $(DESTDIR)usr/share/fortune/homestuck/davestrider
# 	install -m 644 -D homestuck/davestrider.dat $(DESTDIR)usr/share/fortune/homestuck/davestrider.dat
# endif
# ifeq ($(findstring homestuck/karkatvantas.dat,$(wildcard homestuck/*.dat)),homestuck/karkatvantas.dat)
# 	install -m 644 -D homestuck/karkatvantas $(DESTDIR)usr/share/fortune/homestuck/karkatvantas
# 	install -m 644 -D homestuck/karkatvantas.dat $(DESTDIR)usr/share/fortune/homestuck/karkatvantas.dat
# endif
# else
# 	@echo "Nothing to install yet. Try 'make all' first."
# endif

clean :
	rm $(all-dat)

clean-homestuck:
	rm $(all-dat-homestuck)

# Special rules

# Clear and redefine the suffixes rules
.SUFFIXES :
.SUFFIXES : .dat
