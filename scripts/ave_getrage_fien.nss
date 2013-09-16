#include "aps_include"
int StartingConditional()
{
    int iResult;
    object oPC=GetPCSpeaker();
    int Prerequisite=GetHasFeat(1346,oPC);
    iResult = (!GetHasFeat(1347,oPC))&&Prerequisite;
    return iResult;
}
