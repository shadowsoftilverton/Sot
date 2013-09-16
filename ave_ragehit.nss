#include "nw_i0_plot"
#include "engine"
#include "nw_i0_spells"

void vOnHitRageDefensePowers(object oSpellTarget, object oSpellOrigin)
{
     float fDuration=RoundsToSeconds(GetLevelByClass(CLASS_TYPE_BARBARIAN,oSpellOrigin));
     if(GetHasFeat(1321,oSpellOrigin))//Greater Spirit Totem
     {
        int nDC=(10+GetLevelByClass(CLASS_TYPE_BARBARIAN,oSpellOrigin)+GetWisdom(oSpellOrigin))/2;
        if(Random(2)==1)
        {
         if(WillSave(oSpellTarget,nDC,SAVING_THROW_TYPE_NEGATIVE,oSpellOrigin)==0)
         {
            effect eVis=EffectVisualEffect(VFX_IMP_SLOW);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oSpellTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSlow(), oSpellTarget, RoundsToSeconds(5));
         }
        }
     }
}

void vOnHitRageAttackPowers(object oSpellTarget, object oSpellOrigin)
{
     if(GetHasFeat(1341,oSpellOrigin))//Greater Celestial Totem
     {
        int nDC=(10+GetLevelByClass(CLASS_TYPE_BARBARIAN,oSpellOrigin)+GetCharisma(oSpellOrigin))/2;
        if(Random(2)==1)
        {
         if(ReflexSave(oSpellTarget,nDC,SAVING_THROW_TYPE_GOOD,oSpellOrigin)==0)
         {
            effect eVis=EffectVisualEffect(VFX_IMP_SUNSTRIKE);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oSpellTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBlindness(), oSpellTarget, RoundsToSeconds(1));
         }
        }
     }
     if(GetHasFeat(1346,oSpellOrigin))//Lesser Fiend Totem
     {
        if(Random(2)==1)
        {
        int nDC=(10+GetLevelByClass(CLASS_TYPE_BARBARIAN,oSpellOrigin)+GetIntelligence(oSpellOrigin))/2;
         if(FortitudeSave(oSpellTarget,nDC,SAVING_THROW_TYPE_EVIL,oSpellOrigin)==0)
         {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAbilityDecrease(ABILITY_CONSTITUTION, 2), oSpellTarget, RoundsToSeconds(5));
            if(GetHasFeat(1348,oSpellOrigin))//Greater Fiend Totem
            {
                if(FortitudeSave(oSpellTarget,nDC,SAVING_THROW_TYPE_EVIL,oSpellOrigin)==0)
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDazed(), oSpellTarget, RoundsToSeconds(1));
            }
         }
        }
     }
     if(GetHasFeat(1345))//No Escape!
     {
        if(Random(2)==1)
        {
            RemoveSpecificEffect(EFFECT_TYPE_MOVEMENT_SPEED_DECREASE,oSpellTarget);
            effect eMoveDebuff=SupernaturalEffect(EffectMovementSpeedDecrease(50));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eMoveDebuff,oSpellTarget,18.0);
        }
     }
}
