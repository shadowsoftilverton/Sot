#include "engine"

#include "inc_iss"

void main()
{
    object oDM = GetExitingObject();

    if(!GetIsDM(oDM)) return;

    if(!GetIsISSVerified(oDM) || !GetIsISSEnabled(oDM)){
        AssignCommand(oDM, JumpToObject(GetWaypointByTag("wp_dm_holding")));

        FloatingTextStringOnCreature("You must be ISS verified and enabled before entering the module!", oDM, FALSE);
    }
}
