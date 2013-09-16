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
        SetLocalInt(oCaster,"ave_duration",SPELL_KOBOLD);
        SetLocalInt(oCaster,"ave_cl",nCasterLvl);
        SetLocalInt(oCaster,"ave_metamagic",nMetaMagic);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDur,oCaster,RoundsToSeconds(nDuration));
        IncrementRemainingFeatUses(oCaster,ACTIVE_DURATION_FEAT);
        int iAveExpire=GetLocalInt(oCaster,"ave_expire");
        SetLocalInt(oCaster,"ave_expire",iAveExpire+1);
        DelayCommand(RoundsToSeconds(nDuration),DurationEnd(iAveExpire+1,oCaster));

        string sBluePrint="ave_kobold_"+IntToString(Random(NUM_KOBOLD_TYPES));
        object oKobold=CreateObject(OBJECT_TYPE_CREATURE,sBluePrint,lLoc,TRUE,"ave_kobold");
        DelayCommand(0.0,ClearInventory(oKobold));
        SetLocalInt(oKobold,"ave_koblevel",nCasterLvl);
        SetLocalInt(oKobold,"ave_kobdc",nDC);
        SetLocalObject(oKobold,"ave_kobcast",oCaster);
        SetLocalInt(oKobold,"ave_kobmeta",nMetaMagic);
        float fKobDie=30.0;
        if(nMetaMagic==METAMAGIC_EXTEND) fKobDie=fKobDie*2;
        DelayCommand(fKobDie,ExecuteScript("ave_kob_die",oKobold));
}
