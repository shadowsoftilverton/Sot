#include "engine"

#include "uw_inc"

int StartingConditional()
{
    object oPC      = GetPCSpeaker();
    object oTarget  = GetUtilityTarget(oPC);
    int nType   = GetObjectType(oTarget);

    return GetIsDM(oPC) && (nType == OBJECT_TYPE_CREATURE ||nType == OBJECT_TYPE_ITEM || nType == OBJECT_TYPE_DOOR || nType == OBJECT_TYPE_PLACEABLE) ||
           GetIsOwner(oPC, oTarget) && nType == OBJECT_TYPE_ITEM;
}
