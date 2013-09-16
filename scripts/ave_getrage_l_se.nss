#include "aps_include"
int StartingConditional()
{
    int iResult;
    object oPC=GetPCSpeaker();
    int Prerequsite=(GetPersistentInt(oPC,"NUM_BONUS_RAGEFEATS")>0);
    iResult = (!GetHasFeat(1322,oPC))&&Prerequsite;
    return iResult;
}
