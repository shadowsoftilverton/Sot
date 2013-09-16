#include "engine"

#include "uw_inc"

int StartingConditional()
{
    object oPC      = GetPCSpeaker();
    object oTarget  = GetUtilityTarget(oPC);
    int nType   = GetObjectType(oTarget);

    return GetIsPC(oTarget) && (oTarget == oPC || GetIsDM(oPC));
}

