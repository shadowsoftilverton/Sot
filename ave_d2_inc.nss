#include "engine"

const int MAX_AVE_D2_HOURS=8;//Maximum number of ingame hours you can be in this dungeon. Four ingame hours=one real hour.

// PURPOSE: Returns the current absolute time expressed in minutes. Expects 15 minutes to the hour.
int GetTimeByMinute()
{
    int nTime=GetTimeMinute()+GetTimeHour()*15+GetCalendarDay()*15*24;
    int nYear=GetCalendarYear();
    if (nYear>20) nYear=nYear%20;
    nTime=nTime+GetCalendarMonth()*15*24*30+nYear*15*24*30*12;
    return nTime;
}

//Teleports oPC to the entrance of AveD2 (the labyrinth dungeon), if they are eligible
//otherwise recursively calls itself with a delay equal to their eligible time minus 1
//if they haven't even been to the dungeon it does nothing at all
void AveD2Leave(object oPC)
{
    string sName=GetName(oPC)+GetPCPlayerName(oPC);
    if(GetLocalInt(GetModule(),"ave_d2_timerbool"+sName)==1)
    {
        int iMaxTime=GetLocalInt(GetModule(),"ave_d2_timerstart"+sName)+(MAX_AVE_D2_HOURS*15);
        if(GetTimeByMinute()>iMaxTime)
        {
            string sArea=GetTag(GetArea(oPC));
            SetLocalInt(GetModule(),"ave_d2_timerbool"+sName,0);
            if(sArea=="ave_d2_excav"|sArea=="ave_d2_depths"|sArea=="ave_d2_entrance")
            {
                location lDest=GetLocation(GetObjectByTag("ave_d2_exitpoint"));
                effect eVis=EffectVisualEffect(99);
                ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVis,GetLocation(oPC));
                AssignCommand(oPC,ActionJumpToLocation(lDest));
            }
        }
        else
        {
            int iDelayMinutes=iMaxTime-GetTimeByMinute();
            float fDelaySeconds=iDelayMinutes/60.0;
            DelayCommand(fDelaySeconds+1.0,AveD2Leave(oPC));
        }
    }
}

//This initializes dungeon 2 (labyrinth)
void InitD2()
{
    object oStone=GetObjectByTag("ave_d2_slaadrock");
    if(GetIsObjectValid(oStone)) ExecuteScript("ave_d2_slaadeff",oStone);

    object oRedLever=GetObjectByTag("ave_d2_redlever");
    int nIndex=0;
    while(GetIsObjectValid(oRedLever))
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_GLOW_YELLOW),oRedLever);
        nIndex++;
        oRedLever=GetObjectByTag("ave_d2_redlever",nIndex);
    }

    object oGreenLever=GetObjectByTag("ave_d2_greenlever");
    nIndex=0;
    while(GetIsObjectValid(oGreenLever))
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_GLOW_GREEN),oGreenLever);
        nIndex++;
        oGreenLever=GetObjectByTag("ave_d2_greenlever",nIndex);
    }

    object oBlueLever=GetObjectByTag("ave_d2_bluelever");
    nIndex=0;
    while(GetIsObjectValid(oBlueLever))
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_GLOW_BLUE),oBlueLever);
        nIndex++;
        oBlueLever=GetObjectByTag("ave_d2_bluelever",nIndex);
    }

    object oBlueDoor=GetObjectByTag("ave_d2_bluedoor");
    nIndex=0;
    while(GetIsObjectValid(oBlueDoor))
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_GLOW_BLUE),oBlueDoor);
        nIndex++;
        oBlueDoor=GetObjectByTag("ave_d2_bluedoor",nIndex);
    }

    object oRedDoor=GetObjectByTag("ave_d2_reddoor");
    nIndex=0;
    while(GetIsObjectValid(oRedDoor))
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_GLOW_YELLOW),oRedDoor);
        nIndex++;
        oRedDoor=GetObjectByTag("ave_d2_reddoor",nIndex);
    }

    object oGreenDoor=GetObjectByTag("ave_d2_greendoor");
    nIndex=0;
    while(GetIsObjectValid(oGreenDoor))
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,EffectVisualEffect(VFX_DUR_GLOW_GREEN),oGreenDoor);
        nIndex++;
        oGreenDoor=GetObjectByTag("ave_d2_greendoor",nIndex);
    }

    object oAltar=GetObjectByTag("ave_d2_altar");
    ExecuteScript("ave_d2_altarloop",oAltar);
}

void DoGeneralDoorToggle(string sDoorTag)
{
    object oDoor=GetObjectByTag(sDoorTag);
    int iIsLocked;
    int nIndex=0;
    while(GetIsObjectValid(oDoor))
    {
        //SendMessageToPC(GetLastUsedBy(), "nIndex: " + IntToString(nIndex) + " oDoor: " + ObjectToString(oDoor));
        iIsLocked=GetLocked(oDoor);
        if(iIsLocked==FALSE)
        {
            AssignCommand(oDoor, ActionCloseDoor(oDoor));
            SetLocked(oDoor,TRUE);
        }
        else
        {
            SetLocked(oDoor,FALSE);
            AssignCommand(oDoor, ActionOpenDoor(oDoor));
        }
        nIndex=nIndex+1;
        oDoor=GetObjectByTag(sDoorTag,nIndex);
    }
}

int GetIsVargMechDisabled()
{
    object oMech=GetObjectByTag("ave_d2_vargmech");
    if(GetLocalInt(oMech,"ave_d2_mechactive")==0) return 0;
    else return 1;
}
