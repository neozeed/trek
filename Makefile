#	@(#)Makefile	5.8 (Berkeley) 5/11/90

PROG=	trek

DESTDIR=/usr/bin/games
LIBDIR= $(DESTDIR)/lib
MANDIR= /usr/local/man/man6
AR=	ar
CC=     cc
# the following line includes '-cckr' to force old-style K&R compilation
CFLAGS= -O
LDFLAGS=-lm

SRCS=	abandon.c attack.c autover.c capture.c check_out.c checkcond.c \
	compkl.c computer.c damage.c damaged.c dcrept.c destruct.c \
	dock.c dumpgame.c dumpme.c dumpssradio.c events.c externs.c \
	getcodi.c getpar.c help.c impulse.c initquad.c kill.c klmove.c \
	lose.c lrscan.c main.c move.c nova.c out.c phaser.c play.c ram.c \
	ranf.c rest.c schedule.c score.c setup.c setwarp.c \
	shield.c snova.c srscan.c systemname.c torped.c utility.c \
	visual.c warp.c win.c cgetc.c

#  not all linkers can handle so many files, so I broke this down into 2 libraries

LIB1=	abandon.o attack.o autover.o capture.o check_out.o checkcond.o \
	compkl.o computer.o damage.o damaged.o dcrept.o destruct.o \
	dock.o dumpgame.o dumpme.o dumpssradio.o events.o externs.o \
	getcodi.o getpar.o help.o impulse.o initquad.o kill.o klmove.o
LIB2=	lose.o lrscan.o move.o nova.o out.o phaser.o play.o ram.o \
	ranf.o rest.o schedule.o score.o setup.o setwarp.o \
	shield.o snova.o srscan.o systemname.o torped.o utility.o \
	visual.o warp.o win.o cgetc.o

OBJS=	abandon.o attack.o autover.o capture.o check_out.o checkcond.o \
	compkl.o computer.o damage.o damaged.o dcrept.o destruct.o \
	dock.o dumpgame.o dumpme.o dumpssradio.o events.o externs.o \
	getcodi.o getpar.o help.o impulse.o initquad.o kill.o klmove.o \
	lose.o lrscan.o move.o nova.o out.o phaser.o play.o ram.o \
	ranf.o rest.o schedule.o score.o setup.o setwarp.o \
	shield.o snova.o srscan.o systemname.o torped.o utility.o \
	visual.o warp.o win.o cgetc.o

# INCS=	-I/usr/include/bsd
LIBS=	-lm -lbsd

all: ${PROG}

$(PROG):	main.o $(OBJS)
	$(CC) -o trek main.o $(OBJS) $(LDFLAGS)
#	qdos...
#	ld -o trek main.o $(OBJS) -lm -lgcc -lc -lgcc

lib1.a:	$(LIB1)
	ar cru lib1.a $(LIB1)
	ranlib lib1.a

lib2.a:	$(LIB2)
	ar cru lib2.a $(LIB2)
	ranlib lib2.a

trekl:	lib1.a lib2.a main.o
	$(CC) -o trekl main.o $(LIB1) $(LIB2) $(LDFLAGS)

$(LIB1) $(LIB2):	getpar.h trek.h
	$(CC) $(CFLAGS) $(INCS) -c $*.c -o $@

clean:
	del /f $(OBJS) main.o trek

