#include "chessinc"

void main()
{
    if(GetLocalInt(OBJECT_SELF, "nPiece") == 6)
    {   SetLocalInt(OBJECT_SELF, "movingdir", 4);   }
    else
    {   SetLocalInt(OBJECT_SELF, "movingdir", 3);   }
    Move(1);
}

