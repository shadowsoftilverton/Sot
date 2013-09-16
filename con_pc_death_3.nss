#include "engine"
#include "inc_bind"
#include "inc_death"
#include "aps_include"

void main()
{
    object oPC = GetPCSpeaker();
    object oWaypoint = GetBindPoint(oPC);

    ApplyRespawnPenalty(oPC);

    RevivePlayer(GetName(oPC), GetPCPlayerName(oPC), GetLocation(oWaypoint), GetMaxHitPoints(oPC));
}
