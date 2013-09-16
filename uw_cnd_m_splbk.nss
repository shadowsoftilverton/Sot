#include "engine"

#include "inc_spellbook"

#include "uw_inc"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oTarget = GetUtilityTarget(oPC);

    return oPC == oTarget && GetHasUnlearnedSpells(oPC);
}
