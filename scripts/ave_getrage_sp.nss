int StartingConditional()
{
    int iResult;
    object oPC=GetPCSpeaker();
    int Prerequisite=GetHasFeat(1319,oPC);
    iResult = (!GetHasFeat(1320,oPC))&&Prerequisite;
    return iResult;
}
