int StartingConditional()
{
    int l_iResult;

    object oWhite = GetLocalObject(OBJECT_SELF, "oWhitePlayer");
    object oBlack = GetLocalObject(OBJECT_SELF, "oBlackPlayer");

    l_iResult = (GetLocalInt(OBJECT_SELF, "GameState") == 1 &&
                 (oWhite == GetPCSpeaker() ||
                 oBlack == GetPCSpeaker()) );
    return l_iResult;
}
