/*#include "x2_i0_spells"
#include "x2_inc_spellhook"
#include "x2_inc_itemprop"
#include "engine"
#include "inc_nametag"
#include "inc_blades"
#include "inc_henchmen"



void ShelgarnWeaponBuff(object oWeapon, object oCaster);

void main()
{
    int nMetaMagic = GetMetaMagicFeat();
    int nCL = GetCasterLevel(OBJECT_SELF);
    effect eFlash = EffectVisualEffect(VFX_FNF_PWSTUN, FALSE);
    int nDuration = nCL;
    location lTarget = GetSpellTargetLocation();
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, OBJECT_SELF);
    string sNameTag = GenerateTagFromName(OBJECT_SELF);
    string sNewTag = "BLD_" + sNameTag;

    object oSummonWeapon;
    object oSummonCreature;
    int nBlades = GetNumBlades(OBJECT_SELF);
    int nLimit/*;

    if(GetHasFeat(400, OBJECT_SELF))       //GSF Trans
    {
        nLimit = 2;
    }

    else    nLimit*//* = 1;

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
        oSummonCreature = CreateObject(OBJECT_TYPE_CREATURE, "bladespell_01", lTarget, FALSE, sNewTag);
        oSummonWeapon = CopyItem(oWeapon, oSummonCreature);
        SetLocalObject(oSummonWeapon, "BladeOwner", OBJECT_SELF);
        SetLocalString(oSummonCreature, "BladeOwner", "BLD_WEP_" + sNameTag);

        ShelgarnWeaponBuff(oSummonWeapon, OBJECT_SELF);
        AddHenchman(OBJECT_SELF, oSummonCreature);
        DelayCommand(1.0f, AssignCommand(oSummonCreature, ActionEquipItem(oSummonWeapon, INVENTORY_SLOT_RIGHTHAND)));

        UnsummonBlade(oSummonCreature, TurnsToSeconds(nCL));

        nBlades ++;
    }

    //ReturnBlade(OBJECT_SELF, oWeapon, TurnsToSeconds(nCL));
    //DelayCommand(TurnsToSeconds(nCL), ActionCopyItem(oWeapon, OBJECT_SELF));
    //DestroyObject(oWeapon);

    object oBladeHolder = GetObjectByTag("BladeHolder");
    object oOwner = OBJECT_SELF;

    SetTag(oWeapon, "BLD_WEP_" + sNameTag);
    ActionGiveItem(oWeapon, oBladeHolder);
    DelayCommand(TurnsToSeconds(nCL), AssignCommand(oBladeHolder, ActionGiveItem(oWeapon, oOwner)));
}

void ShelgarnWeaponBuff(object oWeapon, object oCaster)
{
    IPRemoveAllItemProperties(oWeapon, DURATION_TYPE_PERMANENT);
    int nPower = GetAbilityModifier(MainAbility(oCaster), oCaster);
    if(GetHasFeat(172, oCaster))   nPower++;                //SF Trans
    if(GetHasFeat(400, oCaster))   nPower++;                //GSF
    if(GetHasFeat(617, oCaster))   nPower = nPower + 2;     //ESF

    if(!GetIsProficient(oWeapon, oCaster))  nPower = nPower - 4;
    if(nPower < 0)  nPower = 0;

    itemproperty iAttack = ItemPropertyAttackBonus(nPower / 4);

    if(nPower > 20) nPower = 20;
    itemproperty iArmor = ItemPropertyACBonus(nPower / 2);

    if(nPower > 12) nPower = 12;
    itemproperty iPower = ItemPropertyAbilityBonus(ABILITY_STRENGTH, nPower / 2);
    itemproperty iGusto = ItemPropertyAbilityBonus(ABILITY_CONSTITUTION, nPower / 2);

    IPSafeAddItemProperty(oWeapon, iAttack);
    IPSafeAddItemProperty(oWeapon, iArmor);
    IPSafeAddItemProperty(oWeapon, iPower);
    IPSafeAddItemProperty(oWeapon, iGusto);
}



//::///////////////////////////////////////////////
//:: Shelgarn's Persistent Blade
//:: X2_S0_PersBlde
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Summons a dagger to battle for the caster
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: Nov 26, 2002
//:://////////////////////////////////////////////
//:: Last Updated By: Georg Zoeller, Aug 2003

#include "x2_i0_spells"
#include "x2_inc_spellhook"

//Creates the weapon that the creature will be using.
void spellsCreateItemForSummoned(object oCaster, float fDuration)
{
    //Declare major variables
    int nStat = GetIsMagicStatBonus(oCaster) / 2;
    // GZ: Just in case...
    if (nStat >20)
    {
        nStat =20;
    }
    else if (nStat <1)
    {
        nStat = 1;
    }
    object oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED);
    object oWeapon;
    if (GetIsObjectValid(oSummon))
    {
        //Create item on the creature, epuip it and add properties.
        oWeapon = CreateItemOnObject("NW_WSWDG001", oSummon);
        // GZ: Fix for weapon being dropped when killed
        SetDroppableFlag(oWeapon,FALSE);
        AssignCommand(oSummon, ActionEquipItem(oWeapon, INVENTORY_SLOT_RIGHTHAND));
        // GZ: Check to prevent invalid item properties from being applies
        if (nStat>0)
        {
            AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyAttackBonus(nStat), oWeapon,fDuration);
        }
        AddItemProperty(DURATION_TYPE_TEMPORARY, ItemPropertyDamageReduction(IP_CONST_DAMAGEREDUCTION_1,5),oWeapon,fDuration);
    }
}


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
    int nDuration = GetCasterLevel(OBJECT_SELF)/2;
    if (nDuration <1)
    {
        nDuration = 1;
    }
    effect eSummon = EffectSummonCreature("X2_S_FAERIE001");
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
    //Make metamagic check for extend
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    //Apply the VFX impact and summon effect
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVis, GetSpellTargetLocation());
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), TurnsToSeconds(nDuration));

    object oSelf = OBJECT_SELF;
    DelayCommand(1.0, spellsCreateItemForSummoned(oSelf,TurnsToSeconds(nDuration)));
}
