#include "aps_include"
int StartingConditional()
{
    int iResult;
    object oPC=GetPCSpeaker();
    int Prerequisite=GetHasFeat(1320,oPC)&&(GetPersistentInt(oPC,"NUM_BONUS_RAGEFEATS")>0);
    iResult = (!GetHasFeat(1321,oPC))&&Prerequisite;
    return iResult;
}
