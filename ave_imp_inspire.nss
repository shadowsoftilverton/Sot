#include "engine"
#include "x2_inc_spellhook"

#include "ave_inc_duration"

//Impact script for the active duration spell Hero's Inspiration
void main()
{
    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
        object oCaster = OBJECT_SELF;
        DoGeneralOnCast(oCaster);
        int nCasterLvl = GetCasterLevel(oCaster);
        int nMetaMagic = GetMetaMagicFeat();
        int nDC=GetSpellSaveDC();
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
        SetLocalInt(oCaster,"ave_duration",SPELL_INSPIRE);
        SetLocalInt(oCaster,"ave_cl",nCasterLvl);
        SetLocalInt(oCaster,"ave_metamagic",nMetaMagic);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDur,oCaster,RoundsToSeconds(nDuration));
        IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);
        int iAveExpire=GetLocalInt(oCaster,"ave_expire");
        SetLocalInt(oCaster,"ave_expire",iAveExpire+1);
        DelayCommand(RoundsToSeconds(nDuration),DurationEnd(iAveExpire+1,oCaster));

        float fDur=12.0;
        if (nMetaMagic==METAMAGIC_EXTEND) fDur=fDur*2;
        object oAlly = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lLoc);
        effect eBuff=EffectVisualEffect(VFX_DUR_AURA_CYAN);
        eBuff=EffectLinkEffects(eBuff,EffectAttackIncrease(2));
        eBuff=EffectLinkEffects(eBuff,EffectSkillIncrease(SKILL_ALL_SKILLS,2));
        eBuff=EffectLinkEffects(eBuff,EffectSavingThrowIncrease(SAVING_THROW_ALL,2));
        if (nMetaMagic==METAMAGIC_EXTEND) fDur=fDur*2;
        while (GetIsObjectValid(oAlly))
        {
            if(!GetIsReactionTypeHostile(oAlly,oCaster))
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBuff,oAlly,fDur);
            }
            oAlly=GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lLoc);
        }
}
