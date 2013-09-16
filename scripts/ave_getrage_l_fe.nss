#include "aps_include"
int StartingConditional()
{
    int iResult;
    object oPC=GetPCSpeaker();
    int Prerequisite=1;
    iResult = (!GetHasFeat(1346,oPC))&&Prerequisite;
    return iResult;
}
