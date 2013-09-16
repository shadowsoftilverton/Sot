#include "aps_include"
int StartingConditional()
{
    int iResult;
    object oPC=GetPCSpeaker();
    int Prerequisite=(GetPersistentInt(oPC,"NUM_BONUS_RAGEFEATS")>1)&&GetHasFeat(1329,oPC);
    iResult = (!GetHasFeat(1330,oPC))&&(!GetHasFeat(1331,oPC))&&(!GetHasFeat(1332,oPC))&&(!GetHasFeat(1333,oPC))&&Prerequisite;
    return iResult;
}
