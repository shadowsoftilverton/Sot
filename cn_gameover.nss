int StartingConditional()
{
    int iResult;

    iResult = (GetLocalInt(GetNearestObjectByTag("gamemaster"), "GameState") == 3);
    return iResult;
}
