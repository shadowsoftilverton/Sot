#include "engine"

#include "ew_inc"

void main()
{
        object oPC = GetPCSpeaker();

        location lTarget = GetLocalLocation(oPC, "EW_LOCATION");

        EncounterWandSpawn(lTarget, 10);
}
