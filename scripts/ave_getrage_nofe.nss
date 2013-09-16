#include "aps_include"
int StartingConditional()
{
    int iResult;
    object oPC=GetPCSpeaker();
    int Prerequisite=(GetPersistentInt(oPC,"NUM_BONUS_RAGEFEATS")>1);
    iResult = (!GetHasFeat(1338,oPC))&&Prerequisite;
    return iResult;
}
