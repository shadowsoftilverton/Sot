int StartingConditional()
{
    int iResult;

    iResult = (GetLocalInt(GetNearestObjectByTag("gamemaster"), "GameState") == 2);
    return iResult;
}
