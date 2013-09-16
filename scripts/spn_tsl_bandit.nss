/*
    Bandit Camp Spawn Trigger
    by Hardcore UFO
*/

#include "engine"

void OutlawFullSpawn(object oWaypoint);

void OutlawGuardSpawn(object oWaypoint);

void main()
{
    object oEnter = GetEnteringObject();

    if(!GetIsPC(oEnter) && !GetIsDMPossessed(oEnter))  {return;}

    int nTrig = GetLocalInt(OBJECT_SELF, "IsTriggered");
    object oWP1 = GetObjectByTag("TSL_OUTLAW001");
    object oWP2 = GetObjectByTag("TSL_OUTLAW002");

    //First triggering, do a complete spawn-in.
    if(nTrig == 0)
    {
        SetLocalInt(OBJECT_SELF, "IsTriggered", 1);
        OutlawFullSpawn(oWP1);
        OutlawGuardSpawn(oWP2);
        DelayCommand(HoursToSeconds(3), DeleteLocalInt(OBJECT_SELF, "IsTriggered"));
    }
}

void OutlawFullSpawn(object oWaypoint)
{
    int nCycle;
    int nRandom;
    string sPrint;
    oWaypoint = GetObjectByTag("TSL_OUTLAW001", nCycle);

    while(GetIsObjectValid(oWaypoint))
    {
        nRandom = d8();

        switch(nRandom)
        {
            case 1:
                sPrint = "tsl_ban_hum001";
                break;

            case 2:
                sPrint = "tsl_ban_hum002";
                break;

            case 3:
                sPrint = "tsl_ban_hum003";
                break;

            case 4:
                sPrint = "tsl_ban_orc001";
                break;

            case 5:
                sPrint = "tsl_ban_orc002";
                break;

            case 6:
                sPrint = "tsl_ban_gob001";
                break;

            case 7:
                sPrint = "tsl_ban_gob001";
                break;

            case 8:
                sPrint = "tsl_ban_ogr001";
                break;

            default:
                sPrint = "tsl_ban_hum001";
                break;

        }

        if(GetLocalInt(oWaypoint, "OutlawActive") == 0)
        {
            CreateObject(OBJECT_TYPE_CREATURE, sPrint, GetLocation(oWaypoint));
            SetLocalInt(oWaypoint, "OutlawActive", 1);
        }

        nCycle ++;
        oWaypoint = GetObjectByTag("TSL_OUTLAW001", nCycle);
    }
}

void OutlawGuardSpawn(object oWaypoint)
{
    int nCycle;
    oWaypoint = GetObjectByTag("TSL_OUTLAW002", nCycle);

    while(GetIsObjectValid(oWaypoint))
    {
        if(GetLocalInt(oWaypoint, "OutlawActive") == 0)
        {
            CreateObject(OBJECT_TYPE_CREATURE, "tsl_ban_grd001", GetLocation(oWaypoint));
            SetLocalInt(oWaypoint, "OutlawActive", 1);
        }

        nCycle ++;
        oWaypoint = GetObjectByTag("TSL_OUTLAW002", nCycle);
    }
}






