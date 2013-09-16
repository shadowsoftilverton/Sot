void main()
{
    if(GetLocalInt(OBJECT_SELF, "nPiece") > 0)
    {   SetLocalInt(OBJECT_SELF, "movingdir", 6);   }
    else
    {   SetLocalInt(OBJECT_SELF, "movingdir", 7);   }
    SetLocalInt(OBJECT_SELF, "movespaces", GetLocalInt(OBJECT_SELF, "move_fr"));
    SetLocalInt(OBJECT_SELF, "takespaces", GetLocalInt(OBJECT_SELF, "take_fr"));
}
