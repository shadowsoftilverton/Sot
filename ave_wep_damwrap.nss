//Written by Ave (2013/05/02)
#include "engine"
void main()
{
    object oShooter=OBJECT_SELF;
    object oVictim=GetLocalObject(oShooter,"ave_d_odam");
    int iDamageAmount=GetLocalInt(oShooter,"ave_d_ndam");
    int iDamageType=GetLocalInt(oShooter,"ave_d_tdam");
    effect eDam=EffectDamage(iDamageAmount,iDamageType);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oVictim);
}
