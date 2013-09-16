void main()
{
    if(GetLocalInt(OBJECT_SELF, "nPiece") > 0)
    {
        SetLocalInt(OBJECT_SELF, "movingdir", 2);
    }
    else
    {
        SetLocalInt(OBJECT_SELF, "movingdir", 1);
    }
    SetLocalInt(OBJECT_SELF, "movespaces", GetLocalInt(OBJECT_SELF, "movebackward"));
    SetLocalInt(OBJECT_SELF, "takespaces", GetLocalInt(OBJECT_SELF, "takebackward"));
}
