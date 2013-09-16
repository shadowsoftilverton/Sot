#include "engine"
#include "ave_inc_skills"

//Checks if the character is eligible for sense motive virtual class skill
int StartingConditional()
{
    object oPC=GetPCSpeaker();
    return(GetIsEligibleForSkill(oPC,SKILL_SENSE_MOTIVE));
}
