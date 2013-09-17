//===================================================
// (c) Invictus 2011
// ---
// Developed for use with the Shadows of Tilverton
// roleplaying server to enable additional two-weapon
// fighting feats and the Tempest class.
// ---
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
//===================================================

#include "NWNXCombat.h"

//========================
//Construction/Destruction
//========================

CNWNXCombat::CNWNXCombat() {
}

CNWNXCombat::~CNWNXCombat() {
}

char *CNWNXCombat::OnRequest(char *gameObject, char *Request, char *Parameters) {
	return NULL;
}

bool CNWNXCombat::OnCreate(gline *config, const char *LogDir) {
	char log[128];

	sprintf(log, "%s/nwnx_combat.txt", LogDir);

	if(!CNWNXBase::OnCreate(config, log))
		return false;

	nx_hook_function((void *) 0x080E1D50, (void *) Hook_CalculateOffHandAttacks, 5, NX_HOOK_DIRECT);
	
	return true;
}
