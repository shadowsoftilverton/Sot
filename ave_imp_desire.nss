#include "engine"
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
        SetLocalInt(oCaster,"ave_cl",nCasterLvl);
        SetLocalInt(oCaster,"ave_duration",SPELL_DESIRE);
        SetLocalInt(oCaster,"ave_metamagic",nMetaMagic);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDur,oCaster,RoundsToSeconds(nDuration));
        IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);
        int iAveExpire=GetLocalInt(oCaster,"ave_expire");
        SetLocalInt(oCaster,"ave_expire",iAveExpire+1);
        DelayCommand(RoundsToSeconds(nDuration),DurationEnd(iAveExpire+1,oCaster));

        float fDur=6.0;
        if(nMetaMagic==METAMAGIC_EXTEND) fDur=12.0;
        if(GetHitDice(oTarget)>0&&GetHitDice(oTarget)<11)
        {
            if(!GetIsReactionTypeFriendly(oTarget))
               {
                    if(MyResistSpell(oCaster, oTarget)==0)
                    {
                        if(!WillSave(oTarget,nDC,SAVING_THROW_TYPE_SPELL,oCaster))
                        {
                            effect eDaze=EffectLinkEffects(EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED   ),EffectDazed());
                            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDaze,oTarget,fDur);
                        }
                    }
               }
        }
}
