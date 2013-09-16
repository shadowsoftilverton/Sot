//Written by Ave (2012/04/13)
#include "engine"
#include "ave_d_inc"

const float RESPAWN_DELAY=1800.0;//Thirty minute delay on respawns

void SlaadInit()
{
    //Delete all old slaadi
    int nCount=0;
    object oSlaad=GetObjectByTag(SLAADPRINT1,nCount);
    while(GetIsObjectValid(oSlaad))
    {
        DestroyObject(oSlaad);
        nCount++;
        oSlaad=GetObjectByTag(SLAADPRINT1,nCount);
    }

    nCount=0;
    oSlaad=GetObjectByTag(SLAADPRINT2,nCount);
    while(GetIsObjectValid(oSlaad))
    {
        DestroyObject(oSlaad);
        nCount++;
        oSlaad=GetObjectByTag(SLAADPRINT2,nCount);
    }
    //Make new slaadi
    nCount=0;
    object oWayPoint=GetObjectByTag(SLAAD_WAYPOINT,nCount);
    while(GetIsObjectValid(oWayPoint))
    {
        nCount++;
        oWayPoint=GetObjectByTag(SLAAD_WAYPOINT,nCount);
        CreateObject(OBJECT_TYPE_CREATURE,SLAADPRINT1,GetLocation(oWayPoint));
    }
    //Start making the slaadi invulnerable to random things
    object oStone=GetObjectByTag(SLAAD_ROCK_PRINT);
    SetLocalInt(oStone,"ave_d_slaadgo",0);
    DoSlaadEff(oStone,1);
}

void main()
{
    object oOrb=GetObjectByTag("ave_plc_orb");
    object oLever=OBJECT_SELF;
    object oExitDoor=GetObjectByTag("ave_d_exit");
    object oDeeperDoor=GetObjectByTag("ave_d_confirmdoor");
    object oExitDoor2=GetObjectByTag("ave_d_enter");
    int iIsLocked=GetLocked(oDeeperDoor);
    switch(iIsLocked)
    {
    case 1:
        AssignCommand(oLever, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
        SetLocked(oDeeperDoor,FALSE);
        AssignCommand(oDeeperDoor, ActionOpenDoor(oDeeperDoor));
        AssignCommand(oExitDoor, ActionCloseDoor(oExitDoor));
        SetLocked(oExitDoor,TRUE);
        AssignCommand(oExitDoor2, ActionCloseDoor(oExitDoor2));
        SetLocked(oExitDoor2,TRUE);
    break;

    case 0:
        AssignCommand(oLever, ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
        SetLocked(oExitDoor,FALSE);
        AssignCommand(oExitDoor, ActionOpenDoor(oExitDoor));
        SetLocked(oExitDoor2,FALSE);
        AssignCommand(oExitDoor2, ActionOpenDoor(oExitDoor2));
        AssignCommand(oDeeperDoor, ActionCloseDoor(oDeeperDoor));
        SetLocked(oDeeperDoor,TRUE);
    break;
    }

    if(GetLocalInt(oLever,"ave_d_openloop")==0)
    {
        object oDoor=GetObjectByTag("ave_d_door2");
        SetLocked(oDoor, FALSE);
        AssignCommand(oDoor, ActionCloseDoor(oDoor));
        SetLocked(oDoor, TRUE);
        SetLocalInt(oLever,"ave_d_openloop",1);
        DelayCommand(RESPAWN_DELAY,ExecuteScript("ave_d_reopen",oLever));
        int i;
        if(GetIsObjectValid(oOrb)==0)
        {
            location lOrbLoc=GetLocation(GetObjectByTag("ave_way_orb"));
            CreateObject(OBJECT_TYPE_PLACEABLE,"ave_orb",lOrbLoc);
        }
        object oBloodMage=GetObjectByTag("ave_d_warlock");
        if(!GetIsObjectValid(oBloodMage))
        {
            object oSkel=GetObjectByTag("ave_skelmage");
            DestroyObject(oSkel);
            object oBloodWayPoint=GetObjectByTag("ave_warlock");
            CreateObject(OBJECT_TYPE_CREATURE,"ave_d_warlock",GetLocation(oBloodWayPoint));
        }
        location lLoc;
        while(i<MAX_HEAPS)
        {
            i++;
            if(!GetIsObjectValid(GetObjectByTag("ave_plc_corpse"+IntToString(i))))
            {
                lLoc=GetLocation(GetObjectByTag("ave_corpseheap"+IntToString(i)));
                CreateObject(OBJECT_TYPE_PLACEABLE,"ave_corpsehea00"+IntToString(i),lLoc,FALSE,"ave_plc_corpse"+IntToString(i));
            }
        }
        i=0;
        while(i<MAX_CRITTERTYPES)
        {
            DestroyObject(GetObjectByTag("ave_undead"+IntToString(i)));
            i++;
        }
        DestroyObject(GetObjectByTag("ave_superspirit"));
        object oSpirit=GetObjectByTag("ave_spirit");
        SetPlotFlag(oSpirit,FALSE);
        DestroyObject(oSpirit);
        object oPort=GetObjectByTag("ave_d_outport");
        DestroyObject(oPort);
        //location lSpawnLoc=GetLocation(GetObjectByTag("ave_way_orb"));
        //DoSpiritSpawn(lSpawnLoc);
        SlaadInit();
    }
}
