/*
    OnSpawn for outlaws.
    By Hardcore UFO
    Sets their return location for after threats.
*/

#include "engine"

void main()
{
    string sSwitch = GetResRef(OBJECT_SELF);
    string sTag;

    if(sSwitch == "tsl_ban_grd001") {sTag = "TSL_OUTLAW002";}
    else sTag = "TSL_OUTLAW001";

    object oWP = GetNearestObjectByTag(sTag, OBJECT_SELF, 1);
    SetLocalObject(OBJECT_SELF, "OutlawSpawnPoint", oWP);
    SetLocalInt(oWP, "OutlawActive", 1);

    ExecuteScript("nw_c2_default9", OBJECT_SELF);
}
