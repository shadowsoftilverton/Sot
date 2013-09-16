int StartingConditional()
{
    int iResult;

    iResult = (GetLocalInt(OBJECT_SELF, "GameState")==2);
    return iResult;
}
