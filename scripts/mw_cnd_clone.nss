#include "engine"

#include "uw_inc"

int StartingConditional()
{
    object oDM  = OBJECT_SELF;
    object oTarget = GetUtilityTarget(oDM);

    int nType = GetObjectType(oTarget);

    return nType == OBJECT_TYPE_CREATURE ||
           nType == OBJECT_TYPE_ITEM;
}
