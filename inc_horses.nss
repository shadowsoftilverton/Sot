//----------------------------------------------------------------------------//
// Invictus 2013-04-20
//----------------------------------------------------------------------------//

#include "engine"
#include "x2_inc_switches"
#include "inc_henchmen"
#include "inc_nametag"
#include "inc_equipment"
#include "x3_inc_horse"

void HorseWidgetRemovalCheck(object oPC)
{
    object oCycle = GetFirstItemInInventory(oPC);
    object oHorse = GetLocalObject(oCycle, "HorseActive");
    object oDesty;

    while(GetIsObjectValid(oCycle))
    {
        if(GetStringLeft(GetResRef(oCycle), 4) == "hrs_" && oHorse != OBJECT_INVALID)
        {
            oDesty = GetObjectByTag(GetTag(oHorse));

            if(oDesty == OBJECT_INVALID)
            {
                DestroyObject(oCycle);
                FloatingTextStringOnCreature("A horse of yours has died while you were gone.", oPC, FALSE);
            }
        }

        oCycle = GetNextItemInInventory(oPC);
    }
}

void HorseMountedWeaponSwitchOut(object oPC)
{
    effect eHorseEffect = GetFirstEffect(oPC);

    while(GetIsEffectValid(eHorseEffect))
    {
        if((GetEffectType(eHorseEffect) == EFFECT_TYPE_DAMAGE_INCREASE) &&
        (GetEffectSubType(eHorseEffect) == SUBTYPE_SUPERNATURAL) &&
        (GetEffectDurationType(eHorseEffect) == DURATION_TYPE_PERMANENT))
        {
            RemoveEffect(OBJECT_SELF, eHorseEffect);
        }

        else if((GetEffectType(eHorseEffect) == EFFECT_TYPE_ATTACK_INCREASE) &&
        (GetEffectSubType(eHorseEffect) == SUBTYPE_SUPERNATURAL) &&
        (GetEffectDurationType(eHorseEffect) == DURATION_TYPE_PERMANENT))
        {
            RemoveEffect(OBJECT_SELF, eHorseEffect);
        }

        else if((GetEffectType(eHorseEffect) == EFFECT_TRUETYPE_MODIFYNUMATTACKS) &&
        (GetEffectSubType(eHorseEffect) == SUBTYPE_SUPERNATURAL) &&
        (GetEffectDurationType(eHorseEffect) == DURATION_TYPE_PERMANENT))
        {
            RemoveEffect(OBJECT_SELF, eHorseEffect);
        }

        eHorseEffect = GetNextEffect(OBJECT_SELF);
    }
}

void HorseMountedWeaponSwitchIn(object oRider)
{
    int nRider = Std_GetSkillRank(SKILL_RIDE, oRider, FALSE);
    int nHorse = Std_GetSkillRank(SKILL_RIDE, HorseGetMyHorse(oRider), TRUE);
    int nBonus;

    if(GetHasFeat(1087, oRider) && nRider > nHorse)
    {
        nBonus = nRider / 5;
        if(nBonus < 1)  nBonus = 1;
    }

    //Damage Increases
    effect eDamage;
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oRider);
    int nWeapon = GetBaseItemType(oWeapon);
    int nWeight = GetWeight(oWeapon);
    float fWeight;
    float fBonus = IntToFloat(nBonus);

    //Weapon weight determines bonus multiplier (because size can't be gleaned, apparently).
    if(nWeight <= 20)
        fWeight = 1.5f;
    else if(nWeight >= 30 && nWeight <= 80)
        fWeight = 2.0f;
    else if(nWeight > 81)
        fWeight = 2.3f;

    if(nWeapon == BASE_ITEM_BASTARDSWORD
    || nWeapon == BASE_ITEM_BATTLEAXE
    || nWeapon == BASE_ITEM_DAGGER
    || nWeapon == BASE_ITEM_DOUBLEAXE
    || nWeapon == BASE_ITEM_DWARVENWARAXE
    || nWeapon == BASE_ITEM_GREATAXE
    || nWeapon == BASE_ITEM_GREATSWORD
    || nWeapon == BASE_ITEM_HALBERD
    || nWeapon == BASE_ITEM_HANDAXE
    || nWeapon == BASE_ITEM_KAMA
    || nWeapon == BASE_ITEM_KATANA
    || nWeapon == BASE_ITEM_KUKRI
    || nWeapon == BASE_ITEM_SCIMITAR
    || nWeapon == BASE_ITEM_SCYTHE
    || nWeapon == BASE_ITEM_SHORTSWORD
    || nWeapon == BASE_ITEM_SICKLE
    || nWeapon == BASE_ITEM_TWOBLADEDSWORD)
    {
        fBonus = fBonus * (fWeight - 1.0f);
        nBonus = FloatToInt(fBonus);

        eDamage = EffectDamageIncrease(nBonus, DAMAGE_TYPE_SLASHING);
        eDamage = SupernaturalEffect(eDamage);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDamage, oRider);
    }

    else if(nWeapon == BASE_ITEM_RAPIER
    || nWeapon == BASE_ITEM_SHORTSPEAR
    || nWeapon == BASE_ITEM_TRIDENT)
    {
        fBonus = fBonus * (fWeight - 1.0f);
        nBonus = FloatToInt(fBonus);

        eDamage = EffectDamageIncrease(nBonus, DAMAGE_TYPE_PIERCING);
        eDamage = SupernaturalEffect(eDamage);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDamage, oRider);
    }

    else if(nWeapon == BASE_ITEM_CLUB
    || nWeapon == BASE_ITEM_DIREMACE
    || nWeapon == BASE_ITEM_HEAVYFLAIL
    || nWeapon == BASE_ITEM_LIGHTFLAIL
    || nWeapon == BASE_ITEM_LIGHTHAMMER
    || nWeapon == BASE_ITEM_LIGHTMACE
    || nWeapon == BASE_ITEM_MAGICSTAFF
    || nWeapon == BASE_ITEM_MORNINGSTAR
    || nWeapon == BASE_ITEM_QUARTERSTAFF
    || nWeapon == BASE_ITEM_WARHAMMER
    || nWeapon == BASE_ITEM_WHIP)
    {
        fBonus = fBonus * (fWeight - 1.0f);
        nBonus = FloatToInt(fBonus);

        eDamage = EffectDamageIncrease(nBonus, DAMAGE_TYPE_BLUDGEONING);
        eDamage = SupernaturalEffect(eDamage);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDamage, oRider);
    }

    effect eAttack;
    effect eNumber;

    if(nWeapon == BASE_ITEM_DART
    || nWeapon == BASE_ITEM_HEAVYCROSSBOW
    || nWeapon == BASE_ITEM_LIGHTCROSSBOW
    || nWeapon == BASE_ITEM_LONGBOW
    || nWeapon == BASE_ITEM_SHORTBOW
    || nWeapon == BASE_ITEM_SHURIKEN
    || nWeapon == BASE_ITEM_THROWINGAXE)
    {
        nBonus = -2;

        if(GetHasFeat(1088, oRider) && nRider > nHorse)
        {
            nBonus = nRider / 7;
            eNumber = EffectModifyAttacks(1);
            eNumber = SupernaturalEffect(eNumber);
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eNumber, oRider);
        }

        eAttack = EffectAttackIncrease(nBonus);
        eAttack = SupernaturalEffect(eAttack);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eAttack, oRider);
    }
}
