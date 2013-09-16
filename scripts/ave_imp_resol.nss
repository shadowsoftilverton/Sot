//Impact script for the active duration spell Resolute Legion
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
    DoGeneralOnCast(oCaster);
    //if(GetLocalInt(oCaster,"ave_duration")==-1)
    //{
    int nCasterLvl = GetCasterLevel(oCaster);
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration;
    if (nMetaMagic==METAMAGIC_EXTEND)
    nDuration=60;
    else
    nDuration=30;
    if(GetHasFeat(1386,oCaster)) nDuration=nDuration+30;
    object oTarget=GetSpellTargetObject();
    effect eDur=EffectVisualEffect(VFX_DUR_AURA_BLUE_LIGHT);
    StoreLevel(oCaster);
    SetLocalInt(oCaster,"ave_duration",SPELL_RESOL);
    SetLocalInt(oCaster,"ave_cl",nCasterLvl);
    SetLocalInt(oCaster,"ave_metamagic",nMetaMagic);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDur,oCaster,RoundsToSeconds(nDuration));
    IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);
    int iAveExpire=GetLocalInt(oCaster,"ave_expire");
    SetLocalInt(oCaster,"ave_expire",iAveExpire+1);
    DelayCommand(RoundsToSeconds(nDuration),DurationEnd(iAveExpire+1,oCaster));
    effect eVFX=EffectVisualEffect(VFX_IMP_GLOBE_USE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eVFX,oTarget);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eVFX,oCaster);
    float fDur=6.0;
    if(nMetaMagic==METAMAGIC_EXTEND) fDur=fDur*2;
            effect eMyDR=EffectDamageReduction(10,DAMAGE_POWER_PLUS_THREE);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eMyDR,oTarget,fDur);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eMyDR,oCaster,fDur);
    //}
    //else SendMessageToPC(oCaster,"You can only have one active duration spell at a time!");
}
