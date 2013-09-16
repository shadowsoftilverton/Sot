#include "chessinc"

void main()
{
    if(GetLocalInt(OBJECT_SELF, "nPiece") == 6)
    {   SetLocalInt(OBJECT_SELF, "movingdir", 1);   }
    else
    {   SetLocalInt(OBJECT_SELF, "movingdir", 2);   }
    Move(1);
}

