#include "chessinc"

void main()
{
    if(GetLocalInt(OBJECT_SELF, "nPiece") == 6)
    {   SetLocalInt(OBJECT_SELF, "movingdir", 5);   }
    else
    {   SetLocalInt(OBJECT_SELF, "movingdir", 8);   }
    Move(1);
}

