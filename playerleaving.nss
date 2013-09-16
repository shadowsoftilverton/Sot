void main()
{
    object oPCLeaving = GetPCSpeaker();

    if (oPCLeaving == GetLocalObject(OBJECT_SELF, "oWhitePlayer"))
    {
        SetLocalInt(OBJECT_SELF, "nWhiteAssigned", 0);
        SetLocalObject(OBJECT_SELF, "oWhitePlayer", OBJECT_INVALID);
    }
    if (oPCLeaving == GetLocalObject(OBJECT_SELF, "oBlackPlayer"))
    {
        SetLocalInt(OBJECT_SELF, "nBlackAssigned", 0);
        SetLocalObject(OBJECT_SELF, "oBlackPlayer", OBJECT_INVALID);
    }

    SetLocalInt(OBJECT_SELF, "GameState", 2);
}
