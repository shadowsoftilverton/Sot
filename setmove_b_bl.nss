void main()
{
    if(GetLocalInt(OBJECT_SELF, "nPiece") > 0)
    {   SetLocalInt(OBJECT_SELF, "movingdir", 7);   }
    else
    {   SetLocalInt(OBJECT_SELF, "movingdir", 6);   }
    SetLocalInt(OBJECT_SELF, "movespaces", GetLocalInt(OBJECT_SELF, "move_bl"));
    SetLocalInt(OBJECT_SELF, "takespaces", GetLocalInt(OBJECT_SELF, "take_bl"));
}
