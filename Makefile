# Makefile for strfile-ing and installing fortunes
# by Hector Escobedo

dat_files = davestrider.dat karkatvantas.dat
dat_found =
DESTDIR = /

all : $(dat_files)

davestrider.dat : davestrider
	strfile davestrider

karkatvantas.dat : karkatvantas
	strfile karkatvantas

install :
ifeq ($(findstring davestrider.dat,$(wildcard *.dat)),davestrider.dat)
	install -m 644 -D davestrider $(DESTDIR)usr/share/fortune/davestrider
	install -m 644 -D davestrider.dat $(DESTDIR)usr/share/fortune/davestrider.dat
dat_found = yes
endif
ifeq ($(findstring karkatvantas.dat,$(wildcard *.dat)),karkatvantas.dat)
	install -m 644 -D karkatvantas $(DESTDIR)usr/share/fortune/karkatvantas
	install -m 644 -D karkatvantas.dat $(DESTDIR)usr/share/fortune/karkatvantas.dat
dat_found = yes
endif
ifndef dat_found
	@echo "Nothing to install yet. Try 'make all' first."
endif

clean :
	rm $(dat_files)
