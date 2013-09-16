#include "engine"
#include "ave_inc_align"
#include "ave_inc_hier"
#include "x2_inc_spellhook"
#include "ave_inc_duration"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }


// End of Spell Cast Hook

    object oPC=OBJECT_SELF;
    DoGeneralOnCast(oPC);
    int nSpellID = GetSpellId();

    int nLevel=990-nSpellID;
    int nClass=Hier_GetClass(oPC);

    int nCheckSpell;

    switch(nLevel)
    {
    case 0: nCheckSpell=431;
    break;
    case 1: nCheckSpell=432;
    break;
    case 2: nCheckSpell=433;
    break;
    case 3: nCheckSpell=434;
    break;
    case 4: nCheckSpell=435;
    break;
    }
    int nCL=HierFeat_GetCasterLevel(oPC);
    int nDC=HierFeat_GetSpellSaveDC(oPC,nLevel);
    int nMetaMagic=DoCheckForKnownSpell(nCheckSpell,oPC,nClass,nLevel);

    if(nMetaMagic==-5)
    {
        SendMessageToPC(oPC,"You do not have any uses or preparations for this spell!");
        return;
    }
    SendMessageToPC(oPC,"You have a use or preparation for this spell!");

    if(GetHasFeat(1553))
    {
        StoreLevel(oPC);
        int nDuration;
        if (nMetaMagic==METAMAGIC_EXTEND)
        nDuration=60;
        else
        nDuration=30;
        if(GetHasFeat(1386,oPC)) nDuration=nDuration+30;
        effect eDur=EffectVisualEffect(VFX_DUR_AURA_BLUE_LIGHT);
        SetLocalInt(oPC,"ave_dc",nDC);
        SetLocalInt(oPC,"ave_cl",nCL);
        SetLocalInt(oPC,"ave_duration",nSpellID);
        SetLocalInt(oPC,"ave_metamagic",nMetaMagic);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDur,oPC,RoundsToSeconds(nDuration));
        IncrementRemainingFeatUses(oPC,ACTIVE_DURATION_FEAT);
        int iAveExpire=GetLocalInt(oPC,"ave_expire");
        SetLocalInt(oPC,"ave_expire",iAveExpire+1);
        DelayCommand(RoundsToSeconds(nDuration),DurationEnd(iAveExpire+1,oPC));
    }


    switch (nSpellID)
    {
/*Minor*/     case 990: DoRangedInflict(nDC,nMetaMagic,4, 0, 4, VFX_IMP_SUNSTRIKE, VFX_IMP_HEAD_HEAL, nSpellID); break;
/*Light*/     case 989: DoRangedInflict(nDC,nMetaMagic,d8(1), 5, 8, VFX_IMP_SUNSTRIKE, VFX_IMP_HEAD_HEAL, nSpellID); break;
/*Moderate*/  case 988: DoRangedInflict(nDC,nMetaMagic,d8(2), 10, 16, VFX_IMP_SUNSTRIKE, VFX_IMP_HEAD_HEAL, nSpellID); break;
/*Serious*/   case 987: DoRangedInflict(nDC,nMetaMagic,d8(3), 15, 24,VFX_IMP_SUNSTRIKE, VFX_IMP_HEAD_HEAL, nSpellID); break;
/*Critical*/  case 986: DoRangedInflict(nDC,nMetaMagic,d8(4), 20, 32, VFX_IMP_SUNSTRIKE, VFX_IMP_HEAD_HEAL, nSpellID); break;

    }
}
