void main()
{
    if(GetLocalInt(OBJECT_SELF, "nPiece") > 0)
    {
        SetLocalInt(OBJECT_SELF, "movingdir", 4);
    }
    else
    {
        SetLocalInt(OBJECT_SELF, "movingdir", 3);
    }
    SetLocalInt(OBJECT_SELF, "movespaces", GetLocalInt(OBJECT_SELF, "moveright"));
    SetLocalInt(OBJECT_SELF, "takespaces", GetLocalInt(OBJECT_SELF, "takeright"));
}
