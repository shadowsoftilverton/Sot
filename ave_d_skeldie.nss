//Written by Ave (2012/04/13)
#include "engine"
void main()
{
    object oStatue=GetObjectByTag("ave_plc_statue");
    location lLoc=GetLocation(GetObjectByTag("ave_warlock"));
    object oOutPort=CreateObject(OBJECT_TYPE_PLACEABLE,"ave_d_outport",lLoc);
    ExecuteScript("ave_d_finalvfx",oOutPort);
    //DestroyObject(oOutPort,120.0);
    SetLocalInt(oStatue,"ave_immune",0);
    effect eDie=EffectVisualEffect(VFX_FNF_WAIL_O_BANSHEES);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eDie,GetLocation(OBJECT_SELF));
}
