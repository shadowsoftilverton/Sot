#include "engine"

#include "uw_inc"

int StartingConditional()
{
    // CURRENTLY DISABLED
    return FALSE;

    object oPC      = GetPCSpeaker();
    object oTarget  = GetUtilityTarget(oPC);
    int nType   = GetObjectType(oTarget);

    return nType == OBJECT_TYPE_CREATURE && GetIsDM(oPC);
}
