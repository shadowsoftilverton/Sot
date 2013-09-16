#include "engine"
#include "ave_inc_skills"

//Checks to see if the character is eligible for the bluff virtual class skill
int StartingConditional()
{
    object oPC=GetPCSpeaker();
    return(GetIsEligibleForSkill(oPC,SKILL_BLUFF));
}
