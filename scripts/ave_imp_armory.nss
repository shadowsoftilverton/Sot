#include "x2_inc_spellhook"
#include "engine"
#include "ave_inc_duration"
//Impact script for the active duration spell Shelgarn's Persistent Armory

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
        SetLocalInt(oCaster,"ave_duration",SPELL_ARMORY);
        SetLocalInt(oCaster,"ave_cl",nCasterLvl);
        SetLocalInt(oCaster,"ave_metamagic",nMetaMagic);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDur,oCaster,RoundsToSeconds(nDuration));
        IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);
        int iAveExpire=GetLocalInt(oCaster,"ave_expire");
        SetLocalInt(oCaster,"ave_expire",iAveExpire+1);
        DelayCommand(RoundsToSeconds(nDuration),DurationEnd(iAveExpire+1,oCaster));

        object oSummon=GetAssociate(ASSOCIATE_TYPE_SUMMONED,oCaster);
        if(GetIsObjectValid(oSummon))
        {
            location lLoc=GetLocation(oSummon);
            effect eFrost=EffectVisualEffect(VFX_IMP_FROST_L);
            object oVictim=GetFirstObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_MEDIUM,lLoc);
            int nDamage;
            effect eDam;
            while(GetIsObjectValid(oVictim))
            {
                nDamage=d3(3);
                if(nMetaMagic==METAMAGIC_MAXIMIZE) nDamage=9;
                if(nMetaMagic==METAMAGIC_EMPOWER) nDamage=FloatToInt(d3(3)*1.5);
                nDamage=GetReflexAdjustedDamage(nDamage,oTarget,nDC,SAVING_THROW_TYPE_COLD,oCaster);
                eDam=EffectDamage(nDamage,DAMAGE_TYPE_COLD);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oVictim);
                oVictim=GetNextObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_MEDIUM,lLoc);
            }
        }
        else
        {
            float fDur=18.0;
            if (nMetaMagic==METAMAGIC_EXTEND) fDur=fDur*2;
            effect eSummon = EffectSummonCreature("X2_S_FAERIE001");
            effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, GetSpellTargetLocation());
            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), fDur);
            object oSelf = OBJECT_SELF;
            DelayCommand(1.0, CreateArmoryItem(oSelf,fDur));
        }
}
