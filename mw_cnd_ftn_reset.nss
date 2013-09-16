#include "engine"

#include "uw_inc"

int StartingConditional()
{
    object oDM  = OBJECT_SELF;
    object oTarget = GetUtilityTarget(oDM);

    return GetIsPC(oTarget);
}
