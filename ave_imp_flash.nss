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
        object oTarget=GetSpellTargetObject();
        DoGeneralOnCast(oCaster);
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
        SetLocalInt(oCaster,"ave_duration",SPELL_FLASH);
        SetLocalInt(oCaster,"ave_cl",nCasterLvl);
        SetLocalInt(oCaster,"ave_metamagic",nMetaMagic);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDur,oCaster,RoundsToSeconds(nDuration));
        IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);
        int iAveExpire=GetLocalInt(oCaster,"ave_expire");
        SetLocalInt(oCaster,"ave_expire",iAveExpire+1);
        DelayCommand(RoundsToSeconds(nDuration),DurationEnd(iAveExpire+1,oCaster));

        effect eAOE=EffectVisualEffect(VFX_FNF_NATURES_BALANCE);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eAOE,lLoc);
        float fDur=6.0;
        if(nMetaMagic==METAMAGIC_EXTEND) fDur=fDur*2;
        effect eShield=EffectDamageResistance(DAMAGE_TYPE_COLD,10,10);
        eShield=EffectLinkEffects(eShield,EffectDamageResistance(DAMAGE_TYPE_FIRE,10,10));
        eShield=EffectLinkEffects(eShield,EffectDamageResistance(DAMAGE_TYPE_ACID,10,10));
        eShield=EffectLinkEffects(eShield,EffectDamageResistance(DAMAGE_TYPE_ELECTRICAL,10,10));
        eShield=EffectLinkEffects(eShield,EffectDamageResistance(DAMAGE_TYPE_SONIC,10,10));
        object oAlly=GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lLoc);
        while(GetIsObjectValid(oAlly))
        {
            if(!GetIsReactionTypeHostile(oAlly,oCaster))
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eShield,oAlly,fDur);
            }
            oAlly=GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lLoc);
        }
}
