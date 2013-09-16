#include "ave_inc_rogue"

void main()
{
    object oPC=OBJECT_SELF;
    float fDur=RoundsToSeconds(10+GetAbilityModifier(ABILITY_INTELLIGENCE,oPC));
    effect eSpeed=EffectMovementSpeedIncrease(50);
    effect eFreedom=EffectImmunity(IMMUNITY_TYPE_MOVEMENT_SPEED_DECREASE);
    effect eLink=EffectLinkEffects(eSpeed,eFreedom);
    eFreedom=EffectImmunity(IMMUNITY_TYPE_SLOW);
    eLink=EffectLinkEffects(eLink,eFreedom);
    eFreedom=EffectImmunity(IMMUNITY_TYPE_PARALYSIS);
    eLink=EffectLinkEffects(eLink,eFreedom);
    eFreedom=EffectImmunity(IMMUNITY_TYPE_STUN);
    eLink=EffectLinkEffects(eLink,eFreedom);
    eFreedom=EffectImmunity(IMMUNITY_TYPE_ENTANGLE);
    eLink=EffectLinkEffects(eLink,eFreedom);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oPC,fDur);
    effect eVis=EffectVisualEffect(VFX_COM_BLOOD_REG_WIMP);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oPC);
    if(GetHasFeat(FEIGNED_RETREAT,oPC))
    {
        int iMag=GetLevelByClass(CLASS_TYPE_ROGUE,oPC)/5;
        effect eBoost=EffectAttackIncrease(iMag);
        eBoost=EffectLinkEffects(EffectDamageIncrease(DAMAGE_BONUS_6,DAMAGE_TYPE_BASE_WEAPON),eBoost);
        DelayCommand(fDur,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBoost,oPC,fDur));
        DelayCommand(fDur,ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oPC));
    }
    GeneralCoolDown(ANOTHER_DAY,oPC,600.0);
}
