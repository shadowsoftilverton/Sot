#include "nwnx_structs"
#include "engine"

void main()
{
    object oKob=OBJECT_SELF;
    object oPC=GetLocalObject(oKob,"ave_kobcast");
    int nDC=GetLocalInt(oKob,"ave_kobdc");
    int nCL=GetLocalInt(oKob,"ave_koblevel");
    int nMetaMagic=GetLocalInt(oKob,"ave_kobmeta");
    location lLoc=GetLocation(oKob);
    effect eDam;
    int nDam;
    int iMyKobNum=GetLocalInt(oPC,"ave_kobnum")+1;
    SetLocalInt(oPC,"ave_kobnum",iMyKobNum);
    object oTempPlace=CreateObject(OBJECT_TYPE_PLACEABLE,"sm_arealight012",lLoc,FALSE,"ave_temp_kobdie"+IntToString(iMyKobNum));
    SetLocalInt(oTempPlace,"ave_kobdc",nDC);
    SetLocalInt(oTempPlace,"ave_koblevel",nCL);
    SetLocalInt(oTempPlace,"ave_kobmeta",nMetaMagic);
    ExecuteScript("ave_kob_explode",oPC);
    DestroyObject(oKob,0.25);
}
