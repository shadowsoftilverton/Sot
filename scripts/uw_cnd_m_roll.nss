#include "engine"

#include "uw_inc"

int StartingConditional()
{
    object oPC      = GetPCSpeaker();
    object oTarget  = GetUtilityTarget(oPC);
    int nType   = GetObjectType(oTarget);

    return GetIsOwner(oPC, oTarget) &&
          (nType == OBJECT_TYPE_CREATURE ||
           nType == OBJECT_TYPE_PLACEABLE ||
           nType == OBJECT_TYPE_DOOR ||
           (nType == OBJECT_TYPE_ITEM && GetItemPossessor(oTarget) == OBJECT_INVALID));
}
