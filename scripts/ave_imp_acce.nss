//Impact script for the active duration spell Accellerate Decay

#include "x2_inc_spellhook"
#include "engine"
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
        int nMetaMagic = GetMetaMagicFeat();
        DoGeneralOnCast(oCaster);
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
        SetLocalInt(oCaster,"ave_cl",nCasterLvl);
        SetLocalInt(oCaster,"ave_duration",SPELL_ACCE);
        SetLocalInt(oCaster,"ave_metamagic",nMetaMagic);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDur,oCaster,RoundsToSeconds(nDuration));
        IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);
        int iAveExpire=GetLocalInt(oCaster,"ave_expire");
        SetLocalInt(oCaster,"ave_expire",iAveExpire+1);
        DelayCommand(RoundsToSeconds(nDuration),DurationEnd(iAveExpire+1,oCaster));

        int nDamage;
        if (nMetaMagic==METAMAGIC_MAXIMIZE)
        nDamage=2*nCasterLvl;
        else if(nMetaMagic==METAMAGIC_EMPOWER)
        nDamage=FloatToInt(d2(nCasterLvl)*1.5);
        else nDamage=d2(nCasterLvl);
        effect eVis = EffectVisualEffect(VFX_IMP_HOLY_AID );
        effect eDamage;
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis,oTarget);
            if(MyResistSpell(oCaster, oTarget)==0)
            {
                if(!GetIsReactionTypeFriendly(oTarget))
                {
                    if(GetRacialType(oTarget)==RACIAL_TYPE_UNDEAD)
                    {
                        nDamage=GetReflexAdjustedDamage(nDamage,oTarget,nDC,SAVING_THROW_TYPE_POSITIVE,oCaster);
                        eDamage=EffectDamage(nDamage,DAMAGE_TYPE_POSITIVE);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget);
                    }
                }
            }
    //}
    //else SendMessageToPC(oCaster,"You can only have one active duration spell at a time!");
}
