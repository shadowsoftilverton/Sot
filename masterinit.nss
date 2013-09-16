void main()
{
    SetLocalInt(OBJECT_SELF, "GameState", 0);
    //SetListening(OBJECT_SELF, TRUE);
    //SetListenPattern(OBJECT_SELF, "keyword", 0);
    SetLocalInt(OBJECT_SELF, "nWhiteAssigned", 0);
    SetLocalInt(OBJECT_SELF, "nBlackAssigned", 0);
    SetLocalObject(OBJECT_SELF, "oWhitePlayer", OBJECT_INVALID);
    SetLocalObject(OBJECT_SELF, "oBlackPlayer", OBJECT_INVALID);
}
