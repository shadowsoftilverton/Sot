void main()
{
    if(GetLocalInt(OBJECT_SELF, "nPiece") > 0)
    {
        SetLocalInt(OBJECT_SELF, "movingdir", 3);
    }
    else
    {
        SetLocalInt(OBJECT_SELF, "movingdir", 4);
    }
    SetLocalInt(OBJECT_SELF, "movespaces", GetLocalInt(OBJECT_SELF, "moveleft"));
    SetLocalInt(OBJECT_SELF, "takespaces", GetLocalInt(OBJECT_SELF, "takeleft"));
}
