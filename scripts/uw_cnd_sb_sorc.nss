#include "engine"

#include "inc_spellbook"

#include "uw_inc"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oTarget = GetUtilityTarget(oPC);

    if(oPC == oTarget){
        return GetHasUnlearnedSpells(oPC, CLASS_TYPE_SORCERER);
    }

    return FALSE;
}
