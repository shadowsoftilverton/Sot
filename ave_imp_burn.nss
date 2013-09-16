//Impact script for the active duration spell Burning Ambition

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
        SetLocalInt(oCaster,"ave_duration",SPELL_BURN);
        SetLocalInt(oCaster,"ave_cl",nCasterLvl);
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
        effect eExplode = EffectVisualEffect(VFX_IMP_PULSE_FIRE);
        effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
        effect eVisAura=EffectVisualEffect(VFX_DUR_ELEMENTAL_SHIELD);
        effect eVuln=EffectDamageImmunityDecrease(DAMAGE_TYPE_FIRE,50);
        effect eShield=EffectDamageShield(nCasterLvl-1,DAMAGE_BONUS_1,DAMAGE_TYPE_FIRE);
        float ShortDur=RoundsToSeconds(1);
        if(nMetaMagic==METAMAGIC_EXTEND) ShortDur=ShortDur*2;
        eShield=EffectLinkEffects(eShield,eVisAura);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVuln,oCaster,ShortDur);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eShield,oCaster,ShortDur);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVuln,oTarget,ShortDur);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eShield,oTarget,ShortDur);
        effect eDamage;
        location lLoc;
        if(GetHitDice(oTarget)>0)//If the target is a creature
        {
            lLoc = GetSpellTargetLocation();
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eExplode, lLoc);
            object oVictim = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lLoc);
            while (GetIsObjectValid(oVictim))
            {
                if(!(oVictim==oTarget))
                {
                if(MyResistSpell(oCaster, oTarget)==0)
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis,oVictim);
                    if(!GetIsReactionTypeFriendly(oTarget))
                    {
                        nDamage=GetReflexAdjustedDamage(nDamage,oVictim,nDC,SAVING_THROW_TYPE_FIRE,oCaster);
                        eDamage=EffectDamage(nDamage,DAMAGE_TYPE_FIRE);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oVictim);
                    }
                }
                }
                oVictim = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lLoc);
            }
        }
        lLoc=GetLocation(oCaster);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eExplode, lLoc);
            object oVictim = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lLoc);
            while (GetIsObjectValid(oVictim))
            {
                if(!(oVictim==oCaster))
                {
                    if(MyResistSpell(oCaster, oTarget)==0)
                    {
                        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis,oVictim);
                        if(!GetIsReactionTypeFriendly(oTarget))
                        {
                            nDamage=GetReflexAdjustedDamage(nDamage,oVictim,nDC,SAVING_THROW_TYPE_FIRE,oCaster);
                            eDamage=EffectDamage(nDamage,DAMAGE_TYPE_FIRE);
                            ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oVictim);
                        }
                    }
                }
                oVictim = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lLoc);
            }
   //}

    //else SendMessageToPC(oCaster,"You can only have one active duration spell at a time!");
}
