#===================================================
# (c) Invictus 2011
# ---
# Developed for use with the Shadows of Tilverton
# roleplaying server. Other use is forbidden without
# the consent of the plugin author.
#===================================================

CC	 = gcc
CXX      = gcc
GPERF    = gperf
RM	 = /bin/rm
MV	 = /bin/mv
CP	 = /bin/cp
SED      = /bin/sed
INSTALL	 = /usr/bin/install -c

INCS	 = -I. -I.. -I../.. -I ../../include -I/usr/local/include
LIBS	 = -L/usr/local/lib -lm -lz
DEFS	 = -D_REENTRANT -D_THREAD_SAFE
CFLAGS   = -mtune=i386 -pipe -g -O2 -Wall -Werror $(DEFS) $(INCS)
CPPFLAGS = -mtune=i386 -pipe  -Wall -Werror $(DEFS) $(INCS)
LFLAGS   =  -w -fPIC -shared -rdynamic

OFILES  = \
    hooks/h_CalculateOffHandAttacks.o              \
    NWNXCombat.o                                   \
    plugin-combat.o

all: nwnx_combat.so

NWNXCombat.o: NWNXCombat.h

nwnx_combat.so: $(OFILES)
	$(CXX) $(LFLAGS) -o $@ $^ $(LIBS)

depend:
	$(CC) -MM $(CFLAGS) *.c > .depend

clean:
	$(RM) -f *.o */*.o *.so

distclean: clean
	$(RM) -f .depend
