#include "engine"

#include "uw_inc"

int StartingConditional()
{
    object oPC      = GetPCSpeaker();
    object oTarget  = GetUtilityTarget(oPC);
    int nType   = GetObjectType(oTarget);

    // An invalid target means we're targeting the ground.
    return nType == 0 && GetIsDM(oPC);
}

