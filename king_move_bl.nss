#include "chessinc"

void main()
{
    if(GetLocalInt(OBJECT_SELF, "nPiece") == 6)
    {   SetLocalInt(OBJECT_SELF, "movingdir", 7);   }
    else
    {   SetLocalInt(OBJECT_SELF, "movingdir", 6);   }
    Move(1);
}

