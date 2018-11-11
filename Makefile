VERSION	= 1.0

CFLAGS	= -O2 -Wall -g
CC	= gcc
LDFLAGS	=
LD	= $(CC)
prefix	= /usr
libdir	= $(prefix)/lib

OBJS	= syncdir.o
LOBJS	= syncdir.lo

all:	libsyncdir.so libsyncdir.a

testsync: testsync.o libsyncdir.a
	$(LD) $(LDFLAGS) -o $@ $< libsyncdir.a

libsyncdir.so:	$(LOBJS)
	$(LD) $(LDFLAGS) -shared -Wl,-soname,libsyncdir.so \
		-o libsyncdir.so $(LOBJS)

syncdir.lo:	syncdir.c
	$(CC) $(CFLAGS) -fPIC -DPIC -o $@ -c $<
syncdir.o:	syncdir.c

libsyncdir.a:	$(OBJS)
	ar r libsyncdir.a $(OBJS)

install:	all
	install -m 755 libsyncdir.so $(libdir)
	install -m 644 libsyncdir.a $(libdir)

TARGET	= syncdir-$(VERSION)
FILES	= Makefile COPYING syncdir.c syncdir.spec testsync.c
distrib:
	mkdir $(TARGET)
	cp -a $(FILES) $(TARGET)
	tar -czf $(TARGET).tar.gz $(TARGET)
	$(RM) -r $(TARGET)

clean:
	$(RM) core *.o *.lo *.so *.a testsync $(TARGET).tar.gz

