#include "chessinc"

void main()
{
    if(GetLocalInt(OBJECT_SELF, "nPiece") == 6)
    {   SetLocalInt(OBJECT_SELF, "movingdir", 2);   }
    else
    {   SetLocalInt(OBJECT_SELF, "movingdir", 1);   }
    Move(1);
}

