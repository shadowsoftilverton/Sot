//Impact script for the active duration spell Litany of Vengeance

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
        DoGeneralOnCast(oCaster);
        int nMetaMagic = GetMetaMagicFeat();
        int nDC=GetSpellSaveDC();
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
        SetLocalInt(oCaster,"ave_duration",SPELL_LITAN);
        SetLocalInt(oCaster,"ave_cl",nCasterLvl);
        SetLocalInt(oCaster,"ave_metamagic",nMetaMagic);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDur,oCaster,RoundsToSeconds(nDuration));
        IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);
        int iAveExpire=GetLocalInt(oCaster,"ave_expire");
    SetLocalInt(oCaster,"ave_expire",iAveExpire+1);
    DelayCommand(RoundsToSeconds(nDuration),DurationEnd(iAveExpire+1,oCaster));
        float fShortDur=RoundsToSeconds(2);
        if (nMetaMagic==METAMAGIC_EXTEND) fShortDur=fShortDur*2;
        int nDamage;
        effect eVis = EffectVisualEffect(VFX_IMP_GOOD_HELP);
        if(MyResistSpell(oCaster, oTarget)==0)
            {
                if(!GetIsReactionTypeFriendly(oTarget))
                {
                    if(nMetaMagic==METAMAGIC_EMPOWER)
                    nDamage=FloatToInt(d8(1)*1.5);
                    else if(nMetaMagic==METAMAGIC_MAXIMIZE)
                    nDamage=8;
                    else nDamage=d8(1);
                    effect MyACDebuff=EffectACDecrease(nDamage);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,MyACDebuff,oTarget,fShortDur);
                }
            }
    //}
    //else SendMessageToPC(oCaster,"You can only have one active duration spell at a time!");
}
