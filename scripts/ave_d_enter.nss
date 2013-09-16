//Written by Ave (2012/04/13)
#include "engine"
#include "ave_d_inc"

int CheckIsFirstCombatEmpty()
{
    if(GetIsObjectValid(GetObjectByTag("ave_spirit"))) return FALSE;
    int i=0;
    while(i<MAX_CRITTERTYPES)
    {
        if(GetIsObjectValid(GetObjectByTag("ave_undead"+IntToString(i)))) return FALSE;
        i++;
    }
    return TRUE;
}

void main()
{
    if(GetIsPC(GetEnteringObject()));
    object oOrb=GetObjectByTag("ave_plc_orb");
    if(GetIsObjectValid(oOrb)&&GetLocalInt(oOrb,"ave_d_enc")==0)
    {
        SetLocalInt(oOrb,"ave_d_enc",1);
        float fBoomDelay=RoundsToSeconds(d3(2));
        DelayCommand(fBoomDelay,OrbBoom(oOrb));
    }
    if(GetIsObjectValid(oOrb)&&CheckIsFirstCombatEmpty())
    {
        location lSpawnLoc=GetLocation(GetObjectByTag("ave_way_orb"));
        DoSpiritSpawn(lSpawnLoc);
    }
}
