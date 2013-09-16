#include "engine"
#include "ave_inc_skills"

//Checks if the character is eligible for any virtual class skill
int StartingConditional()
{
    object oPC=GetPCSpeaker();
    if(GetUtilityTarget(oPC)==oPC) return(GetIsEligibleForAnySkill(oPC));
    return 0;
}
