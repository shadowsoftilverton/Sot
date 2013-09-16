#include "ave_d2_inc"
#include "engine"

int StartingConditional()
{
    object oPC=GetPCSpeaker();
    return GetIsSkillSuccessful(oPC,SKILL_PERSUADE,22);
}
