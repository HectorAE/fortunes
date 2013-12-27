# Makefile for strfile-ing and installing fortunes
# by Hector Escobedo

homestuck_dat_files = homestuck/davestrider.dat homestuck/karkatvantas.dat
dat_files = $(homestuck_dat_files)
DESTDIR = /

all : $(dat_files)

all-homestuck: $(homestuck_dat_files)

homestuck/davestrider.dat : homestuck/davestrider
	strfile homestuck/davestrider

homestuck/karkatvantas.dat : homestuck/karkatvantas
	strfile homestuck/karkatvantas

install :
ifneq ($(strip $(wildcard */*.dat)),)
ifeq ($(findstring homestuck/davestrider.dat,$(wildcard homestuck/*.dat)),homestuck/davestrider.dat)
	install -m 644 -D homestuck/davestrider $(DESTDIR)usr/share/fortune/homestuck/davestrider
	install -m 644 -D homestuck/davestrider.dat $(DESTDIR)usr/share/fortune/homestuck/davestrider.dat
endif
ifeq ($(findstring homestuck/karkatvantas.dat,$(wildcard homestuck/*.dat)),homestuck/karkatvantas.dat)
	install -m 644 -D homestuck/karkatvantas $(DESTDIR)usr/share/fortune/homestuck/karkatvantas
	install -m 644 -D homestuck/karkatvantas.dat $(DESTDIR)usr/share/fortune/homestuck/karkatvantas.dat
endif
else
	@echo "Nothing to install yet. Try 'make all' first."
endif

clean :
	rm $(dat_files)

clean-homestuck:
	rm $(homestuck_dat_files)
