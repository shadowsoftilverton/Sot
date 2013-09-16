int StartingConditional()
{
    int l_iResult;

    l_iResult = ( GetLocalInt(OBJECT_SELF, "GameState") == 0
              && (GetLocalInt(OBJECT_SELF, "nWhiteAssigned") == 0 ||
                  GetLocalInt(OBJECT_SELF, "nBlackAssigned") == 0) );

    return l_iResult;
}

