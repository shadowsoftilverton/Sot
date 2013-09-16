#include "aps_include"
int StartingConditional()
{
    int iResult;
    object oPC = GetPCSpeaker();
    int EligibleFor=GetLevelByClass(CLASS_TYPE_BARBARIAN,oPC)/6;
    iResult=(EligibleFor>GetPersistentInt(oPC,"NUM_BONUS_RAGEFEATS"));
    return iResult;
}
