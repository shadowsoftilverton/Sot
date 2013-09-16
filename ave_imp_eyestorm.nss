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
        DoGeneralOnCast(oCaster);
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
        SetLocalInt(oCaster,"ave_duration",SPELL_EYESTORM);
        SetLocalInt(oCaster,"ave_cl",nCasterLvl);
        SetLocalInt(oCaster,"ave_metamagic",nMetaMagic);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDur,oCaster,RoundsToSeconds(nDuration));
        IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);
        int iAveExpire=GetLocalInt(oCaster,"ave_expire");
        SetLocalInt(oCaster,"ave_expire",iAveExpire+1);
        DelayCommand(RoundsToSeconds(nDuration),DurationEnd(iAveExpire+1,oCaster));

        location lLoc=GetLocation(oCaster);
        float fDur=6.0;
        float fDeafDur=12.0;
        if(nMetaMagic==METAMAGIC_EXTEND)
        {
            fDur=fDur*2;
            fDeafDur=fDeafDur*2;
        }
        effect eAOE=EffectVisualEffect(VFX_FNF_SOUND_BURST);
        object oVictim=GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lLoc);
        while(GetIsObjectValid(oVictim))
        {
            if(GetIsReactionTypeHostile(oVictim,oCaster))
            {
                if(MyResistSpell(oCaster, oVictim)==0)
                {
                    if(!ReflexSave(oVictim,nDC,SAVING_THROW_TYPE_SONIC,oCaster))
                    {
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectKnockdown(),oVictim,fDur);
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectDeaf(),oVictim,fDeafDur);
                    }
                    else
                    {
                        effect eDebuff=EffectSpellFailure(20);
                        eDebuff=EffectLinkEffects(eDebuff,EffectAttackDecrease(4));
                        ApplyEffectToObject(DURATION_TYPE_INSTANT,eDebuff,oVictim,fDur);
                    }
                }
            }
            oVictim = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lLoc);
        }
}
