int StartingConditional()
{
    int l_iResult;

    int nWhiteAssigned = GetLocalInt(OBJECT_SELF, "nWhiteAssigned");
    int nBlackAssigned = GetLocalInt(OBJECT_SELF, "nBlackAssigned");

    l_iResult = FALSE;
    if (GetLocalInt(OBJECT_SELF, "GameState") == 0 || GetLocalInt(OBJECT_SELF, "GameState") == 2)
    {
        if (nWhiteAssigned == 1 && (GetLocalObject(OBJECT_SELF, "oWhitePlayer") == GetPCSpeaker())) l_iResult = TRUE;
        if (nBlackAssigned == 1 && (GetLocalObject(OBJECT_SELF, "oBlackPlayer") == GetPCSpeaker())) l_iResult = TRUE;
    }
    return l_iResult;
}
