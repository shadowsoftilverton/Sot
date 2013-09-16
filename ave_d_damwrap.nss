//Written by Ave (2012/04/13)
#include "engine"
void main()
{
    object oArea=GetArea(OBJECT_SELF);
    object oVictim=GetLocalObject(oArea,"ave_d_odam");
    int iDamageAmount=GetLocalInt(oArea,"ave_d_ndam");
    int iDamageType=GetLocalInt(oArea,"ave_d_tdam");
    effect eDam=EffectDamage(iDamageAmount,iDamageType);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oVictim);
}
