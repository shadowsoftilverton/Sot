void main()
{
    SetLocalInt(OBJECT_SELF, "nWhiteAssigned", 1);
    SetLocalObject(OBJECT_SELF, "oWhitePlayer", GetPCSpeaker());
    SetLocalInt(OBJECT_SELF, "nBlackAssigned", 1);
    SetLocalObject(OBJECT_SELF, "oBlackPlayer", GetPCSpeaker());
}
