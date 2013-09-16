#include "engine"

//::///////////////////////////////////////////////
//:: Time Stop
//:: NW_S0_TimeStop.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    All persons in the Area are frozen in time
    except the caster.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    location lTarget = GetSpellTargetLocation();
    effect eVis = EffectVisualEffect(VFX_FNF_TIME_STOP);
    effect eParalyze = EffectCutsceneParalyze();
    effect eFreeze = EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION);
    effect eImmuneSpells = EffectSpellImmunity(SPELL_ALL_SPELLS);
    effect eImmuneSlashing = EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING, 100);
    effect eImmunePiercing = EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING, 100);
    effect eImmuneBludgeoning = EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING, 100);
    effect eImmuneAcid = EffectDamageImmunityIncrease(DAMAGE_TYPE_ACID, 100);
    effect eImmuneCold = EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD, 100);
    effect eImmuneElectrical = EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL, 100);
    effect eImmuneFire = EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE, 100);
    effect eImmuneMagical = EffectDamageImmunityIncrease(DAMAGE_TYPE_MAGICAL, 100);
    effect eImmuneNegative = EffectDamageImmunityIncrease(DAMAGE_TYPE_NEGATIVE, 100);
    effect eImmunePositive = EffectDamageImmunityIncrease(DAMAGE_TYPE_POSITIVE, 100);
    effect eImmuneSonic = EffectDamageImmunityIncrease(DAMAGE_TYPE_SONIC, 100);
    //effect eDur = EffectVisualEffect(VFX_DUR_SPELLTURNING);

    effect eLink = EffectLinkEffects(eParalyze, eFreeze);
    eLink = EffectLinkEffects(eLink, eImmuneSpells);
    eLink = EffectLinkEffects(eLink, eImmuneSlashing);
    eLink = EffectLinkEffects(eLink, eImmunePiercing);
    eLink = EffectLinkEffects(eLink, eImmuneBludgeoning);
    eLink = EffectLinkEffects(eLink, eImmuneAcid);
    eLink = EffectLinkEffects(eLink, eImmuneCold);
    eLink = EffectLinkEffects(eLink, eImmuneElectrical);
    eLink = EffectLinkEffects(eLink, eImmuneFire);
    eLink = EffectLinkEffects(eLink, eImmuneMagical);
    eLink = EffectLinkEffects(eLink, eImmuneNegative);
    eLink = EffectLinkEffects(eLink, eImmunePositive);
    eLink = EffectLinkEffects(eLink, eImmuneSonic);
    //eLink = EffectLinkEffects(eLink, eDur);

    eLink = ExtraordinaryEffect(eLink);

    int nRoll = 1 + d4();

    //Fire cast spell at event for the specified target
    SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_TIME_STOP, FALSE));

    object oArea = GetArea(OBJECT_SELF);

    object oTarget = GetFirstObjectInArea(oArea);

    while(GetIsObjectValid(oTarget)){
        int nType = GetObjectType(oTarget);

        if(oTarget != OBJECT_SELF && nType == OBJECT_TYPE_CREATURE){
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nRoll));
        }

        oTarget = GetNextObjectInArea(oArea);
    }

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lTarget);
}

