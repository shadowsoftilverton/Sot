//Written by Ave (2012/04/13)
#include "engine"
#include "x0_i0_position"

void main()
{
    object oPC=GetLastUsedBy();
    location lDestination=GetLocation(GetObjectByTag("ave_d_exterior"));
    AssignCommand(oPC,ActionJumpToLocation(lDestination));
}
