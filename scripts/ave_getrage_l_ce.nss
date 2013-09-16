int StartingConditional()
{
    int iResult;
    object oPC=GetPCSpeaker();
    int Prerequisite=1;
    iResult = (!GetHasFeat(1339,oPC))&&Prerequisite;
    return iResult;
}
