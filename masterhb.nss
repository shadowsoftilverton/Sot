void main()
{
    object oPlayer;
    int bWhiteLeft = FALSE;
    int bBlackLeft = FALSE;

    if(GetLocalInt(OBJECT_SELF, "nWhiteAssigned") == 1)
    {
        oPlayer = GetLocalObject(OBJECT_SELF, "oWhitePlayer");
        if (GetIsObjectValid(oPlayer))
        {
            if (GetArea(oPlayer) != GetArea(OBJECT_SELF))
            {
                ActionSpeakString("White Player has left the area. White is now unassigned.");
                bWhiteLeft = TRUE;
            }
        }
        else
        {
            ActionSpeakString("White Player can not be found. White is now unassigned.");
            bWhiteLeft = TRUE;
        }
    }

    if(GetLocalInt(OBJECT_SELF, "nBlackAssigned") == 1)
    {
        oPlayer = GetLocalObject(OBJECT_SELF, "oBlackPlayer");
        if (GetIsObjectValid(oPlayer))
        {
            if (GetArea(oPlayer) != GetArea(OBJECT_SELF))
            {
                ActionSpeakString("Black Player has left the area. Black is now unassigned.");
                bBlackLeft = TRUE;
            }
        }
        else
        {
            ActionSpeakString("Black Player can not be found. Black is now unassigned.");
            bBlackLeft = TRUE;
        }
    }

    if (bWhiteLeft)
    {
        SetLocalInt(OBJECT_SELF, "nWhiteAssigned", 0);
        SetLocalObject(OBJECT_SELF, "oWhiteAssigned", OBJECT_INVALID);
        if (GetLocalInt(OBJECT_SELF, "GameState") == 1) SetLocalInt(OBJECT_SELF, "GameState", 2);
    }

    if (bBlackLeft)
    {
        SetLocalInt(OBJECT_SELF, "nBlackAssigned", 0);
        SetLocalObject(OBJECT_SELF, "oBlackAssigned", OBJECT_INVALID);
        if (GetLocalInt(OBJECT_SELF, "GameState") == 1) SetLocalInt(OBJECT_SELF, "GameState", 2);
    }
}
