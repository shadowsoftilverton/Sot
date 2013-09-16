#include "x2_inc_spellhook"
#include "engine"
#include "ave_inc_duration"
#include "inc_system"

void main()
{
    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
        object oCaster = OBJECT_SELF;
        DoGeneralOnCast(oCaster);
        int nCasterLvl = GetCasterLevel(oCaster);
        int nMetaMagic = GetMetaMagicFeat();
        int nDC=GetSpellSaveDC();
        object oTarget=GetSpellTargetObject();
        location lLoc=GetSpellTargetLocation();

        StoreLevel(oCaster);
        int nDuration;
        if (nMetaMagic==METAMAGIC_EXTEND)
        nDuration=60;
        else
        nDuration=30;
        if(GetHasFeat(1386,oCaster)) nDuration=nDuration+30;
        effect eDur=EffectVisualEffect(VFX_DUR_AURA_BLUE_LIGHT);
        SetLocalInt(oCaster,"ave_dc",nDC);
        SetLocalInt(oCaster,"ave_duration",SPELL_NEEDLE);
        SetLocalInt(oCaster,"ave_cl",nCasterLvl);
        SetLocalInt(oCaster,"ave_metamagic",nMetaMagic);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDur,oCaster,RoundsToSeconds(nDuration));
        IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);
        int iAveExpire=GetLocalInt(oCaster,"ave_expire");
        SetLocalInt(oCaster,"ave_expire",iAveExpire+1);
        DelayCommand(RoundsToSeconds(nDuration),DurationEnd(iAveExpire+1,oCaster));

    int nPhase=CheckNeedlePhase(oTarget);
    effect eDam;
    effect eDeBuff;
    float fDur=18.0;
    if(nMetaMagic==METAMAGIC_EXTEND) fDur=fDur*2;
    switch (nPhase)
    {
    case 0:
    if(nMetaMagic==METAMAGIC_MAXIMIZE) eDam=EffectDamage(6,DAMAGE_TYPE_NEGATIVE);
    else if(nMetaMagic==METAMAGIC_EMPOWER) eDam=EffectDamage(FloatToInt(d6(1)*1.5),DAMAGE_TYPE_NEGATIVE);
    else eDam=EffectDamage(d6(1),DAMAGE_TYPE_NEGATIVE);
    eDeBuff=EffectAbilityDecrease(ABILITY_STRENGTH,1);
    SetEffectSpellId(eDeBuff,SPELL_NEEDLE);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDeBuff,oTarget,fDur);
    break;
    case 1:
    if(nMetaMagic==METAMAGIC_MAXIMIZE) eDam=EffectDamage(6,DAMAGE_TYPE_NEGATIVE);
    else if(nMetaMagic==METAMAGIC_EMPOWER) eDam=EffectDamage(FloatToInt(d6(1)*1.5),DAMAGE_TYPE_NEGATIVE);
    else eDam=EffectDamage(d6(1),DAMAGE_TYPE_NEGATIVE);
    eDeBuff=EffectSavingThrowDecrease(SAVING_THROW_ALL,1);
    SetEffectSpellId(eDeBuff,SPELL_NEEDLE);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDeBuff,oTarget,fDur);
    break;
    case 2:
    if(nMetaMagic==METAMAGIC_MAXIMIZE) eDam=EffectDamage(10,DAMAGE_TYPE_NEGATIVE);
    else if(nMetaMagic==METAMAGIC_EMPOWER) eDam=EffectDamage(FloatToInt(d10(1)*1.5),DAMAGE_TYPE_NEGATIVE);
    else eDam=EffectDamage(d10(1),DAMAGE_TYPE_NEGATIVE);
    break;
    }
    effect eLink=EffectLinkEffects(eDam,EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE));
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eLink,oTarget);
}
