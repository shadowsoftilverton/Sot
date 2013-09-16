#include "engine"

#include "inc_strings"

#include "uw_inc"

void main()
{
    object oDM = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    location lLoc = GetSpellTargetLocation();

    // Limits non-DMs from causing damage if they happen to accidentally get the
    // feat.
    if(!GetIsDM(oDM)) SendUtilityErrorMessageToPC(oDM, UW_MSG_DM_EXCLUSIVE);

    if(!GetIsObjectValid(oTarget)){
        oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 1.5, lLoc, FALSE, OBJECT_TYPE_ALL);

        // If we're targeting the ground, cycle through until we find a non-PC or run out of targets.
        while((GetIsPC(oTarget) || GetObjectType(oTarget) == OBJECT_TYPE_WAYPOINT) && GetIsObjectValid(oTarget)){
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, 1.5, lLoc, FALSE, OBJECT_TYPE_ALL);
        }
    }

    if(GetIsPC(oTarget)){
        FloatingTextStringOnCreature("PCs cannot be destroyed.", oDM, FALSE);
        return;
    }

    if(GetIsObjectValid(oTarget)){
        string sName = GetName(oTarget);

        SetPlotFlag(oTarget, FALSE);
        SetImmortal(oTarget, FALSE);
        ExecuteScript("as_destroyable", oTarget);
        DestroyObject(oTarget);

        FloatingTextStringOnCreature("Destroyed: " + ColorString(sName, 55, 255, 55), oDM, FALSE);
    } else {
        FloatingTextStringOnCreature("No object found.", oDM, FALSE);
    }
}
