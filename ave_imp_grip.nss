#include "x2_inc_spellhook"
#include "engine"
#include "ave_inc_duration"
#include "inc_system"

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
        SetLocalInt(oCaster,"ave_duration",SPELL_GRIP);
        SetLocalInt(oCaster,"ave_cl",nCasterLvl);
        SetLocalInt(oCaster,"ave_metamagic",nMetaMagic);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDur,oCaster,RoundsToSeconds(nDuration));
        IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);
        int iAveExpire=GetLocalInt(oCaster,"ave_expire");
        SetLocalInt(oCaster,"ave_expire",iAveExpire+1);
        DelayCommand(RoundsToSeconds(nDuration),DurationEnd(iAveExpire+1,oCaster));

        effect eExplode=EffectVisualEffect(VFX_FNF_HOWL_ODD);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eExplode, lLoc);
        oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lLoc);
        float fDur=6.0;
        if(nMetaMagic==METAMAGIC_EXTEND) fDur=fDur*2;
        effect eFear;
        while (GetIsObjectValid(oTarget))
        {
            if(MyResistSpell(oCaster, oTarget)==0)
            {
                if(!GetIsReactionTypeFriendly(oTarget))
                {
                    if(!MySavingThrow(SAVING_THROW_WILL,oTarget,nDC,SAVING_THROW_TYPE_FEAR))
                    {
                        eFear=EffectFrightened();
                        eFear=EffectLinkEffects(eFear,EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR));
                    }
                    else
                    {
                        eFear=EffectAttackDecrease(4);
                        eFear=EffectLinkEffects(eFear,EffectSavingThrowDecrease(SAVING_THROW_ALL,4));
                        eFear=EffectLinkEffects(eFear,EffectDamageDecrease(4));
                        eFear=EffectLinkEffects(eFear,EffectSkillDecrease(SKILL_ALL_SKILLS,4));
                    }
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eFear,oTarget,fDur);
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lLoc);
        }
}
