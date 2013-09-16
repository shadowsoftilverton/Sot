#include "engine"

#include "uw_inc"

void main()
{
    object oPC      = GetPCSpeaker();
    object oTarget  = GetUtilityTarget(oPC);

    SetPuppet(oPC, oTarget);
}
