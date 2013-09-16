//Impact script for the active duration spell True Casting

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
        DoGeneralOnCast(oCaster);
        int nMetaMagic = GetMetaMagicFeat();
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
        SetLocalInt(oCaster,"ave_duration",SPELL_TRUEC);
        SetLocalInt(oCaster,"ave_cl",nCasterLvl);
        SetLocalInt(oCaster,"ave_metamagic",nMetaMagic);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDur,oCaster,RoundsToSeconds(nDuration));
        IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);
        int iAveExpire=GetLocalInt(oCaster,"ave_expire");
    SetLocalInt(oCaster,"ave_expire",iAveExpire+1);
    DelayCommand(RoundsToSeconds(nDuration),DurationEnd(iAveExpire+1,oCaster));

        location lLoc = GetSpellTargetLocation();
        effect eExplode = EffectVisualEffect(VFX_IMP_PULSE_NEGATIVE);
        effect eVis = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
        effect eSlowVis=EffectVisualEffect(VFX_IMP_SLOW);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eExplode, lLoc);
        oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lLoc);
        while (GetIsObjectValid(oTarget))
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis,oTarget);
            if(MyResistSpell(oCaster, oTarget)==0)
            {
                if(!GetIsReactionTypeFriendly(oTarget))
                {
                    effect eEffect;
                    int iPhase=CheckTrueCastingPhase(oTarget);
                    int iSaveType;
                    float feDur=RoundsToSeconds(6);
                    if (nMetaMagic==METAMAGIC_EXTEND) feDur=feDur*2;
                    effect eSaveDebuff=EffectSavingThrowDecrease(SAVING_THROW_ALL,1);
                    switch(iPhase)
                    {
                    case 2:
                        iSaveType=SAVING_THROW_FORT;
                        eEffect=EffectDeath();
                        if(0==(MySavingThrow(iSaveType,oTarget,nDC,SAVING_THROW_TYPE_SPELL,oCaster)))
                        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,oTarget);
                        else ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSaveDebuff,oTarget,feDur);
                        break;
                    case 1:
                        iSaveType=SAVING_THROW_WILL;
                        eEffect=EffectFrightened();
                        SetEffectSpellId(eEffect,SPELL_TRUEC);
                        if(0==(MySavingThrow(iSaveType,oTarget,nDC,SAVING_THROW_TYPE_SPELL,oCaster)))
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eEffect,oTarget,feDur);
                        else ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSaveDebuff,oTarget,feDur);
                        break;
                    case 0:
                        iSaveType=SAVING_THROW_REFLEX;
                        eEffect=EffectSlow();
                        SetEffectSpellId(eEffect,SPELL_TRUEC);
                        if(0==(MySavingThrow(iSaveType,oTarget,nDC,SAVING_THROW_TYPE_SPELL,oCaster)))
                        {ApplyEffectToObject(DURATION_TYPE_INSTANT,eSlowVis,oTarget);
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eEffect,oTarget,feDur);}
                        else ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSaveDebuff,oTarget,feDur);
                        break;
                    }
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lLoc);
        }
    //}
    //else SendMessageToPC(oCaster,"You can only have one active duration spell at a time!");
}
