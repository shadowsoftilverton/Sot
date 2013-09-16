#include "engine"
#include "nw_i0_spells"
#include "ave_inc_duration"
#include "x2_inc_spellhook"

void main()
{
   if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
    object oCaster = OBJECT_SELF;
    //if(GetLocalInt(oCaster,"ave_duration")==-1)
    //{

        int nCasterLvl = GetCasterLevel(oCaster);
        int nMetaMagic = GetMetaMagicFeat();
        int nDC=GetSpellSaveDC();
        DoGeneralOnCast(oCaster);
        object oTarget=GetSpellTargetObject();

        StoreLevel(oCaster);
        int nDuration;
        if (nMetaMagic==METAMAGIC_EXTEND)
        nDuration=60;
        else
        nDuration=30;
        if(GetHasFeat(1386,oCaster)) nDuration=nDuration+30;
        effect eDur=EffectVisualEffect(VFX_DUR_AURA_BLUE_LIGHT);
        SetLocalInt(oCaster,"ave_dc",nDC);
        SetLocalInt(oCaster,"ave_duration",SPELL_BREAK);
        SetLocalInt(oCaster,"ave_cl",nCasterLvl);
        SetLocalInt(oCaster,"ave_metamagic",nMetaMagic);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDur,oCaster,RoundsToSeconds(nDuration));
        IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);
        int iAveExpire=GetLocalInt(oCaster,"ave_expire");
        SetLocalInt(oCaster,"ave_expire",iAveExpire+1);
        DelayCommand(RoundsToSeconds(nDuration),DurationEnd(iAveExpire+1,oCaster));

        float fDur=36.0;
        if(nMetaMagic==METAMAGIC_EXTEND) fDur=fDur*2;
        effect eSavePen;
        effect eVis;
        if(GetHitDice(oTarget)>0)//If Target is a creature
        {
            if(!WillSave(oTarget,nDC,SAVING_THROW_TYPE_MIND_SPELLS,oCaster))
            {
                eSavePen=EffectSavingThrowDecrease(SAVING_THROW_ALL,3);
                eSavePen=EffectLinkEffects(eSavePen,EffectSpellResistanceDecrease(2));
                eVis=EffectVisualEffect(VFX_DUR_SANCTUARY);
                eSavePen=EffectLinkEffects(eSavePen,eVis);
                DoSingleBuffRemove(oTarget);
            }
            else
            {
                eSavePen=EffectSavingThrowDecrease(SAVING_THROW_ALL,1);
                eSavePen=EffectLinkEffects(eSavePen,EffectSpellResistanceDecrease(1));
                eVis=EffectVisualEffect(VFX_DUR_SANCTUARY);
                eSavePen=EffectLinkEffects(eVis,eSavePen);
            }
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSavePen,oTarget,fDur);
        }
}
