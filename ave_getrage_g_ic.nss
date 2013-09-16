#include "aps_include"
int StartingConditional()
{
    int iResult;
    object oPC=GetPCSpeaker();
    int Prerequisite=(GetPersistentInt(oPC,"NUM_BONUS_RAGEFEATS")>2)&&GetHasFeat(1330,oPC);
    iResult = (!GetHasFeat(1334,oPC))&&(!GetHasFeat(1335,oPC))&&(!GetHasFeat(1336,oPC))&&(!GetHasFeat(1337,oPC))&&Prerequisite;
    return iResult;
}
