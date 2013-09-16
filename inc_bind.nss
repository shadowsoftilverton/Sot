#include "engine"

#include "aps_include"
#include "inc_strings"

#include "inc_debug"


const string AREA_BIND_POINT = "area_bind_point";

//==============================================================================

// Jumps oPC to their bind point if it exists.
void JumpToBindPoint(object oPC);

// Only works on PCs, setting their bind point to oWaypoint.
void SetBindPoint(object oPC, object oWaypoint);

// If used on PCs, will return their bind point. If used on areas, will return
// the local bind point for the area.
object GetBindPoint(object oObj);

//==============================================================================

void JumpToBindPoint(object oPC){
    if(GetIsDM(oPC)) return;

    object oBind = GetBindPoint(oPC);

    if(!GetIsObjectValid(oBind)) oBind = GetWaypointByTag("bp_ARA_EST");

    AssignCommand(oPC, JumpToObject(oBind));
}

void SetBindPoint(object oPC, object oWaypoint){
    FloatingTextStringOnCreature("Your bind point is now: " + ColorString(GetName(GetArea(oWaypoint)), 55, 255, 55), oPC, FALSE);

    SetPersistentString(oPC, AREA_BIND_POINT, GetTag(oWaypoint));
}

object GetBindPoint(object oObj){
    string sTag;

    if(GetIsPC(oObj)){
        sTag = GetPersistentString(oObj, AREA_BIND_POINT);
    } else {
        sTag = GetLocalString(oObj, AREA_BIND_POINT);
    }

    SendMessageToDevelopers("GAME ENTRY: " + sTag);

    if(sTag == "bp_ARA_EST") return GetWaypointByTag("BP_ARA_FBEARD");

    if(sTag == "bp_ARA_NW") return GetWaypointByTag("BP_ARA_ELFSK");

    return GetWaypointByTag(sTag);
}
