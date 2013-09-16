//OnUsed script for bind placeables and Actions Taken script for bind conversations.
//This will set the bind point of the PC that does the using or speaking to the
//waypoint that has a tag identical to the string stored on the area.

#include "engine"
#include "inc_bind"

void main()
{
    int nBindObject = GetObjectType(OBJECT_SELF);
    object oPC;
    object oArea;
    string sTag;
    object oWP;

    if(nBindObject == OBJECT_TYPE_PLACEABLE)
    {
        oPC = GetLastUsedBy();

        if(GetIsDM(oPC)) return;

        oArea = GetArea(oPC);
        sTag = GetLocalString(oArea, "area_bind_point");
        oWP = GetWaypointByTag(sTag);

        SetBindPoint(oPC, oWP);
        return;
    }

    else if(nBindObject == OBJECT_TYPE_CREATURE)
    {
        oPC = GetPCSpeaker();

        if(GetIsDM(oPC)) return;

        oArea = GetArea(oPC);
        sTag = GetLocalString(oArea, "area_bind_point");
        oWP = GetWaypointByTag(sTag);

        SetBindPoint(oPC, oWP);
        return;
    }
}
