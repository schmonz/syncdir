VERSION	= 1.0

CFLAGS	?= -O2 -Wall -g
CC	?= gcc
LDFLAGS	?=
LD	?= $(CC)
prefix	= $(PREFIX)
libdir	= $(prefix)/lib

LOBJS	= syncdir.lo wrappers.lo

LIBTOOL	= libtool --tag=CC

all:	libsyncdir.la

.SUFFIXES: .lo
.c.lo:
	$(LIBTOOL) --mode=compile $(CC) $(CFLAGS) -c -o $@ $<

testsync: testsync.lo libsyncdir.la
	$(LIBTOOL) --mode=link $(CC) $(LDFLAGS) -o $@ testsync.lo libsyncdir.la

libsyncdir.la: wrappers.h libtool-version-info $(LOBJS)
	$(LIBTOOL) --mode=link $(CC) $(LDFLAGS) -o $@ $(LOBJS) -version-info `cat libtool-version-info` -rpath $(libdir)

libtool-version-info:
	echo $(VERSION) | awk -F. '{ printf "%d:%d:0", $$1, $$2 }' > $@

wrappers.c: trysyscall.c
	if $(CC) $(CFLAGS) -Wall -Werror -c trysyscall.c >/dev/null 2>&1; then cp syscall.c $@; else cp dlsym.c $@; fi

wrappers.h: wrappers.c
	if [ -f trysyscall.o ]; then cp syscall.h $@; else cp dlsym.h $@; fi

syncdir.lo: wrappers.h

install:	all
	$(LIBTOOL) --mode=install $(BSD_INSTALL_LIB) libsyncdir.la $(DESTDIR)$(libdir)

TARGET	= syncdir-$(VERSION)
FILES	= Makefile COPYING syncdir.c syncdir.spec testsync.c
distrib:
	mkdir $(TARGET)
	cp -a $(FILES) $(TARGET)
	tar -czf $(TARGET).tar.gz $(TARGET)
	$(RM) -r $(TARGET)

clean:
	$(RM) core *.o *.lo *.la *.so *.a testsync $(TARGET).tar.gz
	$(RM) libtool-version-info wrappers.c wrappers.h
	$(RM) -r .libs
