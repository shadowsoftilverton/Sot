#include "engine"

#include "x2_inc_switches"

#include "uw_inc"

void main()
{
    object oDM  = OBJECT_SELF;
    object oTarget = GetUtilityTarget(oDM);

    if(!GetIsDM(oDM)) SendUtilityErrorMessageToPC(oDM, UW_MSG_DM_EXCLUSIVE);

    int nType = GetObjectType(oTarget);

    switch(nType){
        case OBJECT_TYPE_ITEM:
            CopyItem(oTarget, oDM);
        break;

        case OBJECT_TYPE_CREATURE:
        {
            location loc = GetLocation(GetWaypointByTag("zdm_clone_storage"));

            CopyObject(oTarget, loc, OBJECT_INVALID, "dm_spawn");
        }
        break;

        default: SendUtilityErrorMessageToPC(oDM, UW_MSG_INVALID_TARGET); break;
    }
}
