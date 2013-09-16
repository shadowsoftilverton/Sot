/*#include "x2_i0_spells"
#include "x2_inc_spellhook"
#include "x2_inc_itemprop"
#include "engine"
#include "inc_nametag"
#include "inc_blades"
#include "inc_henchmen"

void MordekainenWeaponBuff(object oWeapon, object oCaster);

void main()
{
    int nMetaMagic = GetMetaMagicFeat();
    int nCL = GetCasterLevel(OBJECT_SELF);
    effect eFlash = EffectVisualEffect(VFX_FNF_PWSTUN, FALSE);
    int nDuration = nCL;
    location lTarget = GetSpellTargetLocation();
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, OBJECT_SELF);
    string sNewTag = "BLD_" + GenerateTagFromName(OBJECT_SELF);

    object oSummonWeapon;
    object oSummonCreature;
    int nBlades = GetNumBlades(OBJECT_SELF);
    int nLimit;

    if(GetHasFeat(400, OBJECT_SELF))       //GSF Trans
    {
        nLimit = 2;
    }

    else    nLimit = 1;

    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2;
    }

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFlash, lTarget);

    if(nBlades >= nLimit)
    {
        FloatingTextStringOnCreature("You are already animating a weapon!", OBJECT_SELF, FALSE);
        return;
    }

    if(GetWeaponRanged(oWeapon))
    {
        FloatingTextStringOnCreature("You cannot animate ranged weapons!", OBJECT_SELF, FALSE);
        nLimit = 0;
        return;
    }

    while(nBlades < nLimit)
    {
        oSummonCreature = CreateObject(OBJECT_TYPE_CREATURE, "bladespell_02", lTarget, FALSE, sNewTag);
        oSummonWeapon = CopyItem(oWeapon, oSummonCreature);
        MordekainenWeaponBuff(oSummonWeapon, OBJECT_SELF);
        AddHenchman(OBJECT_SELF, oSummonCreature);
        DelayCommand(1.0f, AssignCommand(oSummonCreature, ActionEquipItem(oSummonWeapon, INVENTORY_SLOT_RIGHTHAND)));

        UnsummonBlade(oSummonCreature, TurnsToSeconds(nCL));

        nBlades ++;
    }

    //ReturnBlade(OBJECT_SELF, oWeapon, TurnsToSeconds(nCL));
    //DelayCommand(TurnsToSeconds(nCL), ActionCopyItem(oWeapon, OBJECT_SELF));
    //DestroyObject(oWeapon);

    object oBladeHolder = GetObjectByTag("BladeHolder");
    ActionGiveItem(oWeapon, oBladeHolder);
    DelayCommand(TurnsToSeconds(nCL), ActionTakeItem(oWeapon, oBladeHolder));
}

void MordekainenWeaponBuff(object oWeapon, object oCaster)
{
    int nPower = GetAbilityModifier(MainAbility(oCaster), oCaster);
    int nLevel = GetCasterLevel(oCaster);
    int nRedA;
    int nRedB;
    if(GetHasFeat(172, oCaster))   nPower = nPower + 1;     //SF Trans
    if(GetHasFeat(400, oCaster))   nPower = nPower + 2;     //GSF
    if(GetHasFeat(617, oCaster))   nPower = nPower + 3;     //ESF

    if(!GetIsProficient(oWeapon, oCaster))  nPower = nPower - 4;
    if(nPower < 0)  nPower = 0;

    if(nLevel < 13)
    {nRedA = IP_CONST_DAMAGEREDUCTION_3;
    nRedB = IP_CONST_DAMAGESOAK_10_HP;}
    else if(nLevel >= 13 && nLevel <= 20)
    {nRedA = IP_CONST_DAMAGEREDUCTION_5;
    nRedB = IP_CONST_DAMAGESOAK_10_HP;}
    else if(nLevel >= 21 && nLevel <= 26)
    {nRedA = IP_CONST_DAMAGEREDUCTION_5;
    nRedB = IP_CONST_DAMAGESOAK_15_HP;}
    else if(nLevel >= 27)
    {nRedA = IP_CONST_DAMAGEREDUCTION_6;
    nRedB = IP_CONST_DAMAGESOAK_15_HP;}


    itemproperty iRedux = ItemPropertyDamageReduction(nRedA, nRedB);
    itemproperty iAttack = ItemPropertyAttackBonus(nPower / 3);

    if(nPower > 20) nPower = 20;
    itemproperty iArmor = ItemPropertyACBonus(nPower);

    if(nPower > 12) nPower = 12;
    if(nPower < 2)  nPower = 2;
    itemproperty iPower = ItemPropertyAbilityBonus(ABILITY_STRENGTH, nPower - 2);
    itemproperty iGusto = ItemPropertyAbilityBonus(ABILITY_CONSTITUTION, nPower - 2);

    IPSafeAddItemProperty(oWeapon, iAttack);
    IPSafeAddItemProperty(oWeapon, iArmor);
    IPSafeAddItemProperty(oWeapon, iPower);
    IPSafeAddItemProperty(oWeapon, iGusto);
    IPSafeAddItemProperty(oWeapon, iRedux);
}

*/

//::///////////////////////////////////////////////
//:: Mordenkainen's Sword
//:: NW_S0_MordSwrd.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Summons a Helmed Horror to battle for the caster
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 29, 2001
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = GetCasterLevel(OBJECT_SELF);
    effect eSummon = EffectSummonCreature("NW_S_HelmHorr");
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
    //Make metamagic check for extend
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    //Apply the VFX impact and summon effect
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, GetSpellTargetLocation());
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), TurnsToSeconds(nDuration));
}

