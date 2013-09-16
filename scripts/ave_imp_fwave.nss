//Impact script for the active duration spell Frost Wave

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
        DoGeneralOnCast(oCaster);

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
        SetLocalInt(oCaster,"ave_duration",SPELL_FWAVE);
        SetLocalInt(oCaster,"ave_cl",nCasterLvl);
        SetLocalInt(oCaster,"ave_metamagic",nMetaMagic);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDur,oCaster,RoundsToSeconds(nDuration));
        IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);
        int iAveExpire=GetLocalInt(oCaster,"ave_expire");
    SetLocalInt(oCaster,"ave_expire",iAveExpire+1);
    DelayCommand(RoundsToSeconds(nDuration),DurationEnd(iAveExpire+1,oCaster));

        int nDamage;
        if (nMetaMagic==METAMAGIC_MAXIMIZE)
        nDamage=3*nCasterLvl;
        else if(nMetaMagic==METAMAGIC_EMPOWER)
        nDamage=FloatToInt(d3(nCasterLvl)*1.5);
        else nDamage=d3(nCasterLvl);
        location lLoc = GetSpellTargetLocation();
        effect eExplode = EffectVisualEffect(VFX_FNF_MYSTICAL_EXPLOSION);
        effect eVis = EffectVisualEffect(VFX_IMP_FROST_L);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eExplode, lLoc);
        oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lLoc);
        effect eDamage;
        while (GetIsObjectValid(oTarget))
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis,oTarget);
            if(MyResistSpell(oCaster, oTarget)==0)
            {
                if(!GetIsReactionTypeFriendly(oTarget))
                {
                    if(!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC, SAVING_THROW_TYPE_COLD))
                    {
                        eDamage=EffectDamage(nDamage,DAMAGE_TYPE_COLD);
                    }
                    else eDamage=EffectDamage(nDamage/2,DAMAGE_TYPE_COLD);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oTarget);
                }
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lLoc);
        }
    //}
    //else SendMessageToPC(oCaster,"You can only have one active duration spell at a time!");
}
