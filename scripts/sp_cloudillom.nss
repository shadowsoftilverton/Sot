//Cloud of Ill Omen
//By Hardcore UFO
//Will apply Damage Immunity: Physical, Spell Failure, and Save Penalty on a failed save.
//Cloud animation re-occurs at random intervals.

#include "engine"
#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "inc_spells"

void PlayCloudAnimation(object oTarget, float fDuration);

void main()
{
    int nCL = GetCasterLevel(OBJECT_SELF);
    int nMeta = GetMetaMagicFeat();
    object oTarget = GetSpellTargetObject();
    effect eSlash = EffectDamageImmunityDecrease(DAMAGE_TYPE_SLASHING, 5 + (nCL / 2));
    effect ePierc = EffectDamageImmunityDecrease(DAMAGE_TYPE_PIERCING, 5 + (nCL / 2));
    effect eBludg = EffectDamageImmunityDecrease(DAMAGE_TYPE_BLUDGEONING, 5 + (nCL / 2));
    effect eSaves = EffectSavingThrowDecrease(SAVING_THROW_ALL, nCL / 10, SAVING_THROW_TYPE_ALL);
    effect eFail = EffectSpellFailure(nCL * 5);
    effect eLink = EffectLinkEffects(eSlash, ePierc);
    eLink = EffectLinkEffects(eBludg, eLink);
    eLink = EffectLinkEffects(eSaves, eLink);
    eLink = EffectLinkEffects(eFail, eLink);

    float fDuration = RoundsToSeconds(nCL);
    if(nMeta == METAMAGIC_EXTEND)   fDuration = fDuration * 2;

    effect eVis = EffectVisualEffect(VFX_IMP_DOOM);
    float fDelay = GetDistanceBetween(OBJECT_SELF, oTarget) / 20;

    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, /* XXXXXXXXXXXXX */SPELL_FIREBALL));
    if(!MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC() + 2))
    {
        if(GetHasSpellEffect(134, oTarget)) RemoveSpellEffects(134, OBJECT_SELF, oTarget); //Premonition removal
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget));
        PlayCloudAnimation(oTarget, fDuration);
    }
}

void PlayCloudAnimation(object oTarget, float fDuration)
{
    effect eCloud = EffectVisualEffect(VFX_IMP_DOOM);
    int nInterval = d10();
    float fInterval = IntToFloat(nInterval);
    fDuration = fDuration + fInterval;

    if(fInterval <= fDuration && GetHasSpellEffect(/*THIS SPELL*/SPELL_FIREBALL, oTarget))
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eCloud, oTarget);

        DelayCommand(fInterval, PlayCloudAnimation(oTarget, fDuration));
    }
}
