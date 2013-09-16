#include "aps_include"
int StartingConditional()
{
    int iResult;
    object oPC=GetPCSpeaker();
    int Prerequisite=GetHasFeat(1343,oPC)&&(GetPersistentInt(oPC,"NUM_BONUS_RAGEFEATS")>1);
    iResult = (!GetHasFeat(1345,oPC))&&Prerequisite;
    return iResult;
}
