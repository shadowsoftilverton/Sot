//Impact script for the active duration spell Manticore's Fury
#include "x2_inc_spellhook"
#include "engine"
#include "ave_inc_duration"
#include "spell_sneak_inc"

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
    int nDuration;
    if (nMetaMagic==METAMAGIC_EXTEND)
    nDuration=60;
    else
    nDuration=30;
    if(GetHasFeat(1386,oCaster)) nDuration=nDuration+30;
    StoreLevel(oCaster);
    int nDamage;
    if (nMetaMagic==METAMAGIC_MAXIMIZE)
    nDamage=8;
    else if(nMetaMagic==METAMAGIC_EMPOWER)
    nDamage=FloatToInt(d8(1)*1.5);
    else nDamage=d8(1);
    object oTarget=GetSpellTargetObject();
    effect eDur=EffectVisualEffect(VFX_DUR_AURA_BLUE_LIGHT);
    SetLocalInt(oCaster,"ave_dc",nDC);
    SetLocalInt(oCaster,"ave_duration",SPELL_MANT);
    SetLocalInt(oCaster,"ave_cl",nCasterLvl);
    SetLocalInt(oCaster,"ave_metamagic",nMetaMagic);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDur,oCaster,RoundsToSeconds(nDuration));
    IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);
    int iAveExpire=GetLocalInt(oCaster,"ave_expire");
    SetLocalInt(oCaster,"ave_expire",iAveExpire+1);
    DelayCommand(RoundsToSeconds(nDuration),DurationEnd(iAveExpire+1,oCaster));
    int iTouchHit=TouchAttackRanged(oTarget,TRUE);
    float fDuration=RoundsToSeconds(5);
    if(nMetaMagic==METAMAGIC_EXTEND) fDuration=fDuration*2;
    if(iTouchHit>0)
    {
        if(iTouchHit==2) nDamage=nDamage*2;
        nDamage=nDamage+getSneakDamage(oCaster,oTarget);
        if(!GetIsReactionTypeFriendly(oTarget))
        {
            if(MyResistSpell(oCaster, oTarget)==0)
            {
                effect eVFX=EffectVisualEffect(VFX_IMP_POISON_S);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eVFX,oTarget);
                effect eMyDamage=EffectDamage(nDamage,DAMAGE_TYPE_PIERCING);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eMyDamage,oTarget);
                if((0==FortitudeSave(oTarget,nDC,SAVING_THROW_TYPE_POISON)))
                {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAbilityDecrease(ABILITY_CONSTITUTION,2),oTarget,fDuration);
                }
            }
        }
    }
    //}
    //else SendMessageToPC(oCaster,"You can only have one active duration spell at a time!");
}
