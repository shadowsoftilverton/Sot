//Impact script for the active duration spell Mad God's Rage

#include "x2_inc_spellhook"

#include "ave_inc_duration"

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
        DoGeneralOnCast(oCaster);
        int nMetaMagic = GetMetaMagicFeat();
        int nDC=GetSpellSaveDC();

        StoreLevel(oCaster);
        int nDuration;
        if (nMetaMagic==METAMAGIC_EXTEND)
        nDuration=60;
        else
        nDuration=30;
        if(GetHasFeat(1386,oCaster)) nDuration=nDuration+30;
        object oTarget=GetSpellTargetObject();
        effect eDur=EffectVisualEffect(VFX_DUR_AURA_BLUE_LIGHT);
        SetLocalInt(oCaster,"ave_dc",nDC);
        SetLocalInt(oCaster,"ave_duration",SPELL_MADGOD);
        SetLocalInt(oCaster,"ave_cl",nCasterLvl);
        SetLocalInt(oCaster,"ave_metamagic",nMetaMagic);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDur,oCaster,RoundsToSeconds(nDuration));
        IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);
        int iAveExpire=GetLocalInt(oCaster,"ave_expire");
    SetLocalInt(oCaster,"ave_expire",iAveExpire+1);
    DelayCommand(RoundsToSeconds(nDuration),DurationEnd(iAveExpire+1,oCaster));

        int nDamage;
        if (nMetaMagic==METAMAGIC_MAXIMIZE)
        nDamage=4*nCasterLvl;
        else if(nMetaMagic==METAMAGIC_EMPOWER)
        nDamage=FloatToInt(d4(nCasterLvl)*1.5);
        else nDamage=d4(nCasterLvl);
        effect eVis = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
        effect eDamage;
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis,oTarget);
            if(MyResistSpell(oCaster, oTarget)==0)
            {
                if(!GetIsReactionTypeFriendly(oTarget))
                {
                        int nNewDamage=GetReflexAdjustedDamage(nDamage,oTarget,nDC,SAVING_THROW_TYPE_ELECTRICITY,oCaster);
                        if(nNewDamage==nDamage)
                        {   if(0==(MySavingThrow(SAVING_THROW_WILL,oTarget,nDC,SAVING_THROW_TYPE_ELECTRICITY)))
                            {
                                effect eConfuse=EffectConfused();
                                effect eConfuseVis=EffectVisualEffect(VFX_IMP_CONFUSION_S);
                                ApplyEffectToObject(DURATION_TYPE_INSTANT,eConfuseVis,oTarget);
                                float fConfuseDuration=RoundsToSeconds(1);
                                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eConfuse,oTarget,fConfuseDuration);
                            }
                        }
                        eDamage=EffectDamage(nDamage,DAMAGE_TYPE_ELECTRICAL);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget);
                }
            }
    //}
    //else SendMessageToPC(oCaster,"You can only have one active duration spell at a time!");
}
