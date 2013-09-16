void main()
{
    if(GetLocalInt(OBJECT_SELF, "nPiece") > 0)
    {   SetLocalInt(OBJECT_SELF, "movingdir", 8);   }
    else
    {   SetLocalInt(OBJECT_SELF, "movingdir", 5);   }
    SetLocalInt(OBJECT_SELF, "movespaces", GetLocalInt(OBJECT_SELF, "move_br"));
    SetLocalInt(OBJECT_SELF, "takespaces", GetLocalInt(OBJECT_SELF, "take_br"));
}
