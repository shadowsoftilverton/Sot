#include "engine"

#include "inc_death"

void main(){
    object oPC = GetPCSpeaker();
    object oWaypoint = GetWaypointByTag("RES_TMP_ARATYM");

    ApplyRespawnPenalty(oPC);

    RevivePlayer(GetName(oPC), GetPCPlayerName(oPC), GetLocation(oWaypoint), GetMaxHitPoints(oPC));
}
