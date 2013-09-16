//Written by Ave (2012/04/13)
#include "engine"
#include "ave_d_inc"

void main()
{
    location lDead=GetLocation(OBJECT_SELF);
    DoSpiritSpawn(lDead);
    //ExecuteScript("x2_def_ondeath",OBJECT_SELF);
}
