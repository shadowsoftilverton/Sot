#include "engine"
#include "ave_inc_skills"

//Checks if the character is eligible for gather information virtual class skill
int StartingConditional()
{
    object oPC=GetPCSpeaker();
    return(GetIsEligibleForSkill(oPC,SKILL_GATHER_INFORMATION));
}
