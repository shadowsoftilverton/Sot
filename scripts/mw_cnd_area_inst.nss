#include "engine"

#include "uw_inc"

int StartingConditional()
{
    object oDM  = OBJECT_SELF;
    object oTarget = GetUtilityTarget(oDM);

    // An invalid object means we're targetting the ground.
    return !GetIsObjectValid(oTarget);
}

