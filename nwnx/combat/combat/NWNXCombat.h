//===================================================
// (c) Invictus 2011
// ---
// Developed for use with the Shadows of Tilverton
// roleplaying server. Other use is forbidden without
// the consent of the plugin author.
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
