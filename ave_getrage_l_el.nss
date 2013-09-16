int StartingConditional()
{
    int iResult;
    object oPC=GetPCSpeaker();
    int Prerequisite=GetLevelByClass(0,oPC)>1;
    iResult = (!GetHasFeat(1326,oPC))&&(!GetHasFeat(1327,oPC))&&(!GetHasFeat(1328,oPC))&&(!GetHasFeat(1329,oPC));
    return iResult;
}
