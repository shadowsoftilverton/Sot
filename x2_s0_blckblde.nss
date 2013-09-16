/*#include "x2_i0_spells"
#include "x2_inc_spellhook"
#include "x2_inc_itemprop"
#include "engine"
#include "inc_nametag"
#include "inc_blades"
#include "inc_henchmen"

void DisasterWeaponBuff(object oWeapon, object oCaster);

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

    if(GetHasFeat(617, OBJECT_SELF))       //GSF Trans
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
        oSummonCreature = CreateObject(OBJECT_TYPE_CREATURE, "bladespell_03", lTarget, FALSE, sNewTag);
        oSummonWeapon = CopyItem(oWeapon, oSummonCreature);
        DisasterWeaponBuff(oSummonWeapon, OBJECT_SELF);
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

void DisasterWeaponBuff(object oWeapon, object oCaster)
{
    int nPower = GetAbilityModifier(MainAbility(oCaster), oCaster);
    int nLevel = GetCasterLevel(oCaster);
    int nDamage;
    int nRedA;
    int nRedB;
    if(GetHasFeat(172, oCaster))   nPower = nPower + 2;     //SF Trans
    if(GetHasFeat(400, oCaster))   nPower = nPower + 3;     //GSF
    if(GetHasFeat(617, oCaster))   nPower = nPower + 4;     //ESF

    if(!GetIsProficient(oWeapon, oCaster))  nPower = nPower - 4;
    if(nPower < 0)  nPower = 0;

    if(nLevel > 24 && nLevel <= 28) nDamage = IP_CONST_DAMAGEBONUS_2d4;
    else if(nLevel >= 29)           nDamage = IP_CONST_DAMAGEBONUS_2d6;
    else                            nDamage = IP_CONST_DAMAGEBONUS_1d6;

    if(nLevel < 17)
    {nRedA = IP_CONST_DAMAGEREDUCTION_4;
    nRedB = IP_CONST_DAMAGESOAK_10_HP;}
    else if(nLevel >= 18 && nLevel <= 23)
    {nRedA = IP_CONST_DAMAGEREDUCTION_5;
    nRedB = IP_CONST_DAMAGESOAK_10_HP;}
    else if(nLevel >= 24 && nLevel <= 29)
    {nRedA = IP_CONST_DAMAGEREDUCTION_6;
    nRedB = IP_CONST_DAMAGESOAK_15_HP;}
    else if(nLevel == 30)
    {nRedA = IP_CONST_DAMAGEREDUCTION_7;
    nRedB = IP_CONST_DAMAGESOAK_15_HP;}

    itemproperty iDamage = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_MAGICAL, nDamage);
    itemproperty iRedux = ItemPropertyDamageReduction(nRedA, nRedB);
    itemproperty iAttack = ItemPropertyAttackBonus((nPower / 3) + 1);

    if(nPower > 20) nPower = 20;
    itemproperty iArmor = ItemPropertyACBonus(nPower);

    if(nPower > 12) nPower = 12;
    itemproperty iPower = ItemPropertyAbilityBonus(ABILITY_STRENGTH, nPower);
    itemproperty iQuick = ItemPropertyAbilityBonus(ABILITY_DEXTERITY, nPower);
    itemproperty iGusto = ItemPropertyAbilityBonus(ABILITY_CONSTITUTION, nPower);

    IPSafeAddItemProperty(oWeapon, iAttack);
    IPSafeAddItemProperty(oWeapon, iArmor);
    IPSafeAddItemProperty(oWeapon, iPower);
    IPSafeAddItemProperty(oWeapon, iGusto);
    IPSafeAddItemProperty(oWeapon, iRedux);
    IPSafeAddItemProperty(oWeapon, iDamage);
    IPSafeAddItemProperty(oWeapon, iQuick);
}

*/

//::///////////////////////////////////////////////
//:: Black Blade of Disaster
//:: X2_S0_BlckBlde
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Summons a greatsword to battle for the caster
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: Nov 26, 2002
//:://////////////////////////////////////////////
//:: Last Updated By: Georg Zoeller, July 28 - 2003


#include "x2_i0_spells"

//Creates the weapon that the creature will be using.
void spellsCreateItemForSummoned()
{
    //Declare major variables
    int nStat;

    // cast from scroll, we just assume +5 ability modifier
    if (GetSpellCastItem() != OBJECT_INVALID)
    {
        nStat = 5;
    }
     else
    {
        int nClass = GetLastSpellCastClass();
        int nLevel = GetLevelByClass(nClass);

        int nStat;

        int nCha =  GetAbilityModifier(ABILITY_CHARISMA,OBJECT_SELF);
        int nInt =  GetAbilityModifier(ABILITY_INTELLIGENCE,OBJECT_SELF);

        if (nClass == CLASS_TYPE_WIZARD)
        {
            nStat = nInt;
        }
        else
        {
            nStat = nCha;
        }

        if (nStat >20)
        {
            nStat =20;
        }

        if (nStat <1)
        {
           nStat = 0;
        }
    }

    object oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED);
    // Make the blade require concentration
    SetLocalInt(oSummon,"X2_L_CREATURE_NEEDS_CONCENTRATION",TRUE);
    SetPlotFlag (oSummon,TRUE);
    object oWeapon;
    //Create item on the creature, epuip it and add properties.
    oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oSummon);
    if (nStat > 0)
    {
        IPSetWeaponEnhancementBonus(oWeapon, nStat);
    }
    SetDroppableFlag(oWeapon, FALSE);
}

#include "x2_inc_spellhook"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-07-07 by Georg Zoeller
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
    effect eSummon = EffectSummonCreature("x2_s_bblade");
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
    //Make metamagic check for extend
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;//Duration is +100%
    }
    //Apply the VFX impact and summon effect
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, GetSpellTargetLocation());
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), RoundsToSeconds(nDuration));
    DelayCommand(1.5, spellsCreateItemForSummoned());
}

