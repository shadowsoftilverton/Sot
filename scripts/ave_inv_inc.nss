#include "engine"
#include "ave_inc_rogue"
#include "aps_include"

//Pings oPC's database. Returns TRUE if database is functioning, FALSE if there is a database malfunction.
//Recommended for functions that use the database.
int PingDataBase(object oPC)
{
    SetPersistentInt(oPC,"ave_database_ping",1);
    if(GetPersistentInt(oPC,"ave_database_ping")==1)
    {
        DeletePersistentVariable(oPC,"ave_database_ping");
        return TRUE;
    }
    SendMessageToPC(oPC,"Warning! Database Error!");
    return FALSE;
}

int GetIsContainer(object oItem)
{
    int iType=GetBaseItemType(oItem);
    string iContain=Get2DAString("baseitems","Container",iType);
    return StringToInt(iContain);
}

void DoSetNotLoot(object oItem)
{
    if(GetLocalInt(oItem,"ave_inv_notloot")==0) SetLocalInt(oItem,"ave_inv_notloot",1);
    if(GetIsStackableItem(oItem))
    {
        SetLocalInt(oItem,"ave_inv_notlootsize",GetItemStackSize(oItem));
    }
}

void DitchItem(object oItem,object oPC,float fDelay)
{
    location lCenter=GetLocation(oPC);
    vector vPos=GetPositionFromLocation(lCenter);
    vPos.x=vPos.x+(IntToFloat(Random(50))/10.0)-2;
    vPos.y=vPos.y+(IntToFloat(Random(50))/10.0)-2;
    float fFace=IntToFloat(Random(360));
    location lDest=Location(GetAreaFromLocation(lCenter),vPos,fFace);
    DelayCommand(fDelay,AssignCommand(oPC,ActionMoveToLocation(lDest,TRUE)));
    DelayCommand(fDelay+3.0,AssignCommand(oPC,ActionPutDownItem(oItem)));
}
