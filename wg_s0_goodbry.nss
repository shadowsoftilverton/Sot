#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Goodberry                                                            //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 13, 2011                                 //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void main() {
    if(!X2PreSpellCastCode())
        return;

    int nBerries = d4() + d4();

    CreateItemOnObject("wg_sp_goodbry", OBJECT_SELF, nBerries);
    SendMessageToPC(OBJECT_SELF, IntToString(nBerries) + " goodberries have been created.");
}
