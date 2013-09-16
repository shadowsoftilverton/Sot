#include "engine"

//For the labyrinth dungeon by Ave. Teleports PCs to a random location from a number of options.

void main()
{
    object oPC=GetLastUsedBy();
    string sPort=IntToString(Random(6));
    location lTarget=GetLocation(GetObjectByTag("ave_d2_rand"+sPort));
    AssignCommand(oPC,JumpToLocation(lTarget));
}
