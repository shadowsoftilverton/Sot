//Impact script for the active duration spell Confounding Presence

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
        object oTarget=GetSpellTargetObject();

        StoreLevel(oCaster);
        int nDuration;
        if (nMetaMagic==METAMAGIC_EXTEND)
        nDuration=60;
        else
        nDuration=30;
        if(GetHasFeat(1386,oCaster)) nDuration=nDuration+30;
        effect eDur=EffectVisualEffect(VFX_DUR_AURA_BLUE_LIGHT);
        SetLocalInt(oCaster,"ave_duration",SPELL_CONFP);
        SetLocalInt(oCaster,"ave_metamagic",nMetaMagic);
        SetLocalInt(oCaster,"ave_cl",nCasterLvl);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDur,oCaster,RoundsToSeconds(nDuration));
        IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);
        int iAveExpire=GetLocalInt(oCaster,"ave_expire");
    SetLocalInt(oCaster,"ave_expire",iAveExpire+1);
    DelayCommand(RoundsToSeconds(nDuration),DurationEnd(iAveExpire+1,oCaster));
        location lLoc = GetSpellTargetLocation();
        effect eExplode = EffectVisualEffect(VFX_IMP_DUST_EXPLOSION);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eExplode, lLoc);
        float fDur=RoundsToSeconds(1);
        if(nMetaMagic==METAMAGIC_EXTEND) fDur=fDur*2;
        oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lLoc);
        while (GetIsObjectValid(oTarget))
        {
            if(!GetIsReactionTypeHostile(oTarget,oCaster))
            {
                effect eInvis=EffectInvisibility(INVISIBILITY_TYPE_NORMAL);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eInvis,oTarget,fDur);
            }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_HUGE, lLoc);
        }
    //}
    //else SendMessageToPC(oCaster,"You can only have one active duration spell at a time!");
}
