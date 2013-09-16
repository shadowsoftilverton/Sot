#include "aps_include"
int StartingConditional()
{
    int iResult;
    object oPC=GetPCSpeaker();
    int Prerequisite=GetHasFeat(1347,oPC)&&(GetPersistentInt(oPC,"NUM_BONUS_RAGEFEATS")>0);
    iResult = (!GetHasFeat(1348,oPC))&&Prerequisite;
    return iResult;
}
