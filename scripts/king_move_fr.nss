#include "chessinc"

void main()
{
    if(GetLocalInt(OBJECT_SELF, "nPiece") == 6)
    {   SetLocalInt(OBJECT_SELF, "movingdir", 6);   }
    else
    {   SetLocalInt(OBJECT_SELF, "movingdir", 7);   }
    Move(1);
}

