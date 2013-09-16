#include "aps_include"
int StartingConditional()
{
    int iResult;
    object oPC=GetPCSpeaker();
    int Prerequisite=GetHasFeat(408,oPC)&&GetHasFeat(1340,oPC)&&(GetPersistentInt(oPC,"NUM_BONUS_RAGEFEATS")>1);
    iResult = (!GetHasFeat(1341,oPC))&&Prerequisite;
    return iResult;
}
