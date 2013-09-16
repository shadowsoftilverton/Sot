#include "aps_include"
int StartingConditional()
{
    int iResult;
    object oPC=GetPCSpeaker();
    int Prerequisite=GetHasFeat(1342,oPC);
    iResult = (!GetHasFeat(1343,oPC))&&Prerequisite;
    return iResult;
}
