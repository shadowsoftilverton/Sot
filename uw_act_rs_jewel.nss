#include "engine"

#include "uw_inc"

void main()
{
    object oPC     = GetPCSpeaker();
    object oTarget = GetUtilityTarget(oPC);

    UtilityRoll(oTarget, UW_ROLL_TYPE_SKILL, 47);//Craft jewelry
}
