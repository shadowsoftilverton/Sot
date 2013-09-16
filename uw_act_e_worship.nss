#include "engine"

#include "uw_inc"

void main()
{
    object oPC     = GetPCSpeaker();
    object oTarget = GetUtilityTarget(oPC);

    UtilityEmote(oTarget, ANIMATION_LOOPING_WORSHIP);
}
