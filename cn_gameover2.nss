int StartingConditional()
{
    int iResult;

    iResult = (GetLocalInt(OBJECT_SELF, "GameState") == 3);
    return iResult;
}
