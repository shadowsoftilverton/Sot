//Impact script for the active duration spell persistent shock
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
    int nMetaMagic = GetMetaMagicFeat();
    int nDC=GetSpellSaveDC();
    int nDuration;
    if (nMetaMagic==METAMAGIC_EXTEND)
    nDuration=60;
    else
    nDuration=30;
    if(GetHasFeat(1386,oCaster)) nDuration=nDuration+30;
    int nDamage;
    if (nMetaMagic==METAMAGIC_MAXIMIZE)
    nDamage=12;
    else if(nMetaMagic==METAMAGIC_EMPOWER)
    nDamage=FloatToInt(d4(3)*1.5);
    else nDamage=d4(3);
    object oTarget=GetSpellTargetObject();
    effect eDur=EffectVisualEffect(VFX_DUR_AURA_BLUE_LIGHT);
    StoreLevel(oCaster);
    SetLocalInt(oCaster,"ave_dc",nDC);
    SetLocalInt(oCaster,"ave_duration",SPELL_PSHOCK);
    SetLocalInt(oCaster,"ave_cl",nCasterLvl);
    SetLocalInt(oCaster,"ave_metamagic",nMetaMagic);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDur,oCaster,RoundsToSeconds(nDuration));
    IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);
    int iAveExpire=GetLocalInt(oCaster,"ave_expire");
    SetLocalInt(oCaster,"ave_expire",iAveExpire+1);
    DelayCommand(RoundsToSeconds(nDuration),DurationEnd(iAveExpire+1,oCaster));
    effect eVFX=EffectVisualEffect(VFX_IMP_LIGHTNING_S);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eVFX,oTarget);
    if(MyResistSpell(oCaster, oTarget)==0)
    {
        if(!GetIsReactionTypeFriendly(oTarget))
        {
            nDamage=GetReflexAdjustedDamage(nDamage,oTarget,nDC,SAVING_THROW_TYPE_ELECTRICITY,oCaster);
            effect eMyDamage=EffectDamage(nDamage,DAMAGE_TYPE_ELECTRICAL);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eMyDamage,oTarget);
        }
    }
    //}
   //else SendMessageToPC(oCaster,"You can only have one active duration spell at a time!");
}
