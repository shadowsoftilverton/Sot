#include "engine"
#include "x2_inc_spellhook"
#include "inc_system"
#include "ave_inc_duration"

//Impact script for the active duration spell Air to Flame
void main()
{
    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
        object oCaster = OBJECT_SELF;
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
        SetLocalInt(oCaster,"ave_cl",nCasterLvl);
        SetLocalInt(oCaster,"ave_duration",SPELL_AIRFLAME);
        SetLocalInt(oCaster,"ave_metamagic",nMetaMagic);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDur,oCaster,RoundsToSeconds(nDuration));
        IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);
        int iAveExpire=GetLocalInt(oCaster,"ave_expire");
        SetLocalInt(oCaster,"ave_expire",iAveExpire+1);
        DelayCommand(RoundsToSeconds(nDuration),DurationEnd(iAveExpire+1,oCaster));

        int nDamage;
        effect eDamage;
        if (nMetaMagic==METAMAGIC_MAXIMIZE)
        nDamage=3*nCasterLvl;
        else if(nMetaMagic==METAMAGIC_EMPOWER)
        nDamage=FloatToInt(d3(nCasterLvl)*1.5);
        else nDamage=d3(nCasterLvl);
        SpamVFX(lLoc,EffectVisualEffect(VFX_IMP_PULSE_FIRE),16,4,7);
        effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
        effect eFire = EffectVisualEffect(VFX_DUR_INFERNO_CHEST);
        float fDur=10.0;
        if(nMetaMagic==METAMAGIC_EXTEND) fDur=fDur*2;
        float fDelay;
        object oVictim = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lLoc);
        while(GetIsObjectValid(oVictim))
        {
            if(MyResistSpell(oCaster, oTarget)==0)
            {
                fDelay=Random(5)*0.1;
                if(!GetIsReactionTypeFriendly(oTarget))
                {
                    int nAdjustedDamage=GetReflexAdjustedDamage(nDamage,oVictim,nDC,SAVING_THROW_TYPE_FIRE,oCaster);
                    if(nAdjustedDamage==nDamage)
                    {
                        if(GetHasSpellEffect(1137,oVictim))
                        DoChokeCheck(oVictim,nDC,nMetaMagic);
                        SetEffectSpellId(eFire,1137);//Air to Flame
                        DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eFire,oVictim,fDur));
                    }
                    eDamage=EffectDamage(nAdjustedDamage,DAMAGE_TYPE_FIRE);
                    DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT,eDamage,oVictim));
                }
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis,oVictim);
            }
            oVictim=GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lLoc);
        }
}
