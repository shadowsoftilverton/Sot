#===================================================
# (c) Invictus 2011
# ---
# Developed for use with the Shadows of Tilverton
# roleplaying server to enable additional two-weapon
# fighting feats and the Tempest class.
# ---
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
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
