# Makefile for strfile-ing and installing fortunes
# by Hector Escobedo

dat_files = davestrider.dat

all : $(dat_files)

davestrider.dat : davestrider
	strfile davestrider

install :
ifeq ($(findstring davestrider.dat,$(wildcard *.dat)),davestrider.dat)
	install -m 644 davestrider /usr/share/fortune/davestrider
	install -m 644 davestrider.dat /usr/share/fortune/davestrider.dat
else
	@echo "Nothing to install yet. Try 'make all' first."
endif

clean :
	rm $(dat_files)
