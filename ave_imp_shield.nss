#include "x2_inc_spellhook"
#include "engine"
#include "ave_inc_duration"
//Impact script for the active duration spell Persistent SpellShield

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
        int nDC=GetSpellSaveDC();
        object oTarget=GetSpellTargetObject();

        StoreLevel(oCaster);
        int nMetaMagic = GetMetaMagicFeat();
        int nDuration;
        if (nMetaMagic==METAMAGIC_EXTEND)
        nDuration=60;
        else
        nDuration=30;
        if(GetHasFeat(1386,oCaster)) nDuration=nDuration+30;
        effect eDur=EffectVisualEffect(VFX_DUR_AURA_BLUE_LIGHT);
        SetLocalInt(oCaster,"ave_dc",nDC);
        SetLocalInt(oCaster,"ave_duration",SPELL_ACTIVE_SHIELD);
        SetLocalInt(oCaster,"ave_cl",nCasterLvl);
        SetLocalInt(oCaster,"ave_metamagic",nMetaMagic);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDur,oCaster,RoundsToSeconds(nDuration));
        IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);
        int iAveExpire=GetLocalInt(oCaster,"ave_expire");
        SetLocalInt(oCaster,"ave_expire",iAveExpire+1);
        DelayCommand(RoundsToSeconds(nDuration),DurationEnd(iAveExpire+1,oCaster));

        effect eHit = EffectVisualEffect(VFX_IMP_SPELL_MANTLE_USE);
        effect eVFX = EffectVisualEffect(VFX_DUR_SPELLTURNING);
        float fDur=6.0;
        if (nMetaMagic==METAMAGIC_EXTEND) fDur=fDur*2;
        effect eLink=EffectLinkEffects(eVFX,EffectSpellLevelAbsorption(9,1));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oCaster,fDur);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eHit,oCaster);
        if(oCaster!=oTarget)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oTarget,fDur);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eHit,oTarget);
        }
}
