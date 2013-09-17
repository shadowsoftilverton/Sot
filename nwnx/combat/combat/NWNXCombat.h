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

#ifndef NWNX_COMBAT_H
#define NWNX_COMBAT_H

#include "NWNXLib.h"

#ifdef __cplusplus
extern "C" {
#endif

int Hook_CalculateOffHandAttacks(CNWSCombatRound *round);

#ifdef __cplusplus
}

#include "NWNXBase.h"

class CNWNXCombat:public CNWNXBase {
	public:
		CNWNXCombat();
		virtual ~CNWNXCombat();

		bool OnCreate(gline *nwnxConfig, const char *LogDir = NULL);
		char *OnRequest(char *gameObject, char *Request, char *Parameters);
		//bool OnRelease();
};
#endif

#endif
