int StartingConditional()
{
    int iResult;
    object oPC=GetPCSpeaker();
    iResult = !GetHasFeat(1319,oPC);
    return iResult;
}
