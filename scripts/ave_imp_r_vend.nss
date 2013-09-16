#include "ave_inc_rogue"

void main()
{
    object oCaster=OBJECT_SELF;
    object oTarget=GetSpellTargetObject();
    int nDI=50;
    float fDuration=60.0;
    effect eAcid=EffectDamageImmunityDecrease(DAMAGE_TYPE_ACID,nDI);
    effect eBlunt=EffectDamageImmunityDecrease(DAMAGE_TYPE_BLUDGEONING,nDI);
    effect eLink=EffectLinkEffects(eAcid,eBlunt);
    effect eDI=EffectDamageImmunityDecrease(DAMAGE_TYPE_COLD,nDI);
    eLink=EffectLinkEffects(eDI,eLink);
    eDI=EffectDamageImmunityDecrease(DAMAGE_TYPE_DIVINE,nDI);
    eLink=EffectLinkEffects(eDI,eLink);
    eDI=EffectDamageImmunityDecrease(DAMAGE_TYPE_ELECTRICAL,nDI);
    eLink=EffectLinkEffects(eDI,eLink);
    eDI=EffectDamageImmunityDecrease(DAMAGE_TYPE_FIRE,nDI);
    eLink=EffectLinkEffects(eDI,eLink);
    eDI=EffectDamageImmunityDecrease(DAMAGE_TYPE_MAGICAL,nDI);
    eLink=EffectLinkEffects(eDI,eLink);
    eDI=EffectDamageImmunityDecrease(DAMAGE_TYPE_NEGATIVE,nDI);
    eLink=EffectLinkEffects(eDI,eLink);
    eDI=EffectDamageImmunityDecrease(DAMAGE_TYPE_PIERCING,nDI);
    eLink=EffectLinkEffects(eDI,eLink);
    eDI=EffectDamageImmunityDecrease(DAMAGE_TYPE_POSITIVE,nDI);
    eLink=EffectLinkEffects(eDI,eLink);
    eDI=EffectDamageImmunityDecrease(DAMAGE_TYPE_SLASHING,nDI);
    eLink=EffectLinkEffects(eDI,eLink);
    eDI=EffectDamageImmunityDecrease(DAMAGE_TYPE_SONIC,nDI);
    eLink=EffectLinkEffects(eDI,eLink);
    effect eVis=EffectVisualEffect(VFX_IMP_HEAD_EVIL);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oTarget,fDuration);
    GeneralCoolDown(VENDETTA,oCaster,fDuration);
}
