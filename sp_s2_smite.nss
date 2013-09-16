//----------------------------------------------------------------------------//
//Smite Infidel
//----------------------------------------------------------------------------//
//Originally authored by Ave
//Re-written for clarity and debugged by Stephen "Invictus"
//----------------------------------------------------------------------------//

#include "engine"
#include "NW_I0_SPELLS"
#include "x2_inc_itemprop"
#include "nw_i0_plot"

void PurgeLingeringSmiteProperty(object oPC, object oWeapon, itemproperty ip) {
    int iType = GetItemPropertyType(ip);
    int iSubType = GetItemPropertySubType(ip);

    IPRemoveMatchingItemProperties(oWeapon, iType, DURATION_TYPE_TEMPORARY, iSubType);
}

void ApplySmitePropertiesToWeapon(object oWeapon, object oPC) {
    float fDuration = 7.0f + (IntToFloat(GetCharisma(oPC)) / 2);
    int iGoodEvil=GetAlignmentGoodEvil(oPC);
    int iLawChaos=GetAlignmentLawChaos(oPC);
    int nDamageType1;
    int nDamageType2;
    int nAlignGroup1;
    int nAlignGroup2;
    int nAlign1;
    int nAlign2;
    int nAlign3;
    int nAlign4;
    int nAlign5;
    int nAlign6;
    int nDamage;
    int nLevel = GetLevelByClass(CLASS_TYPE_PALADIN, oPC) + GetLevelByClass(CLASS_TYPE_DIVINECHAMPION, oPC);

    if(GetHasFeat(1564, oPC))                       //Crusader
        nLevel = nLevel + GetLevelByClass(50, oPC); //Heirophant

    effect eBuff = EffectAttackIncrease(GetAbilityModifier(ABILITY_CHARISMA, oPC) / 2);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBuff, oPC, fDuration);

    if(GetHasFeat(1573, oPC)) { //Epic Crusader
        if(nLevel > 29) {
            if(GetHasFeat(FEAT_EPIC_GREAT_SMITING_2, oPC))
                nDamage = IP_CONST_DAMAGEBONUS_8d12;
            else if(GetHasFeat(FEAT_EPIC_GREAT_SMITING_1, oPC))
                nDamage = IP_CONST_DAMAGEBONUS_6d12;
            else
                nDamage = IP_CONST_DAMAGEBONUS_4d12;
        } else if(nLevel > 19) {
            if(GetHasFeat(FEAT_EPIC_GREAT_SMITING_2, oPC))
                nDamage = IP_CONST_DAMAGEBONUS_7d12;
            else if(GetHasFeat(FEAT_EPIC_GREAT_SMITING_1, oPC))
                nDamage = IP_CONST_DAMAGEBONUS_5d12;
            else
                nDamage = IP_CONST_DAMAGEBONUS_3d12;
        } else if(nLevel > 9) {
            nDamage = IP_CONST_DAMAGEBONUS_2d12;
        } else {
            nDamage = IP_CONST_DAMAGEBONUS_1d12;
        }
    } else {
        if(nLevel > 29) {
            if(GetHasFeat(FEAT_EPIC_GREAT_SMITING_2, oPC))
                nDamage = IP_CONST_DAMAGEBONUS_8d6;
            else if(GetHasFeat(FEAT_EPIC_GREAT_SMITING_1, oPC))
                nDamage = IP_CONST_DAMAGEBONUS_6d6;
            else
                nDamage = IP_CONST_DAMAGEBONUS_4d6;
        } else if(nLevel > 19) {
            if(GetHasFeat(FEAT_EPIC_GREAT_SMITING_2, oPC))
                nDamage = IP_CONST_DAMAGEBONUS_7d6;
            else if(GetHasFeat(FEAT_EPIC_GREAT_SMITING_1, oPC))
                nDamage = IP_CONST_DAMAGEBONUS_5d6;
            else
                nDamage = IP_CONST_DAMAGEBONUS_3d6;
        } else if(nLevel > 9) {
            nDamage = IP_CONST_DAMAGEBONUS_2d6;
        } else {
            nDamage = IP_CONST_DAMAGEBONUS_1d6;
        }
    }

    effect eVis;
    switch(iGoodEvil) {
        case ALIGNMENT_GOOD:
            nDamageType1 = IP_CONST_DAMAGETYPE_POSITIVE;

            nAlignGroup1 = IP_CONST_ALIGNMENTGROUP_NEUTRAL;
            nAlignGroup2 = IP_CONST_ALIGNMENTGROUP_EVIL;
            break;
        case ALIGNMENT_NEUTRAL:
            nDamageType1 = IP_CONST_DAMAGETYPE_POSITIVE;

            nAlignGroup1 = IP_CONST_ALIGNMENTGROUP_EVIL;
            nAlignGroup2 = IP_CONST_ALIGNMENTGROUP_GOOD;
            break;
        case ALIGNMENT_EVIL:
            nDamageType1 = IP_CONST_DAMAGETYPE_POSITIVE;

            nAlignGroup1 = IP_CONST_ALIGNMENTGROUP_NEUTRAL;
            nAlignGroup2 = IP_CONST_ALIGNMENTGROUP_GOOD;
            break;
    }

    switch(iLawChaos) {
        case ALIGNMENT_LAWFUL:
            nDamageType2 = IP_CONST_DAMAGETYPE_MAGICAL;

            nAlign1 = IP_CONST_ALIGNMENT_CE;
            nAlign2 = IP_CONST_ALIGNMENT_CN;
            nAlign3 = IP_CONST_ALIGNMENT_CG;
            nAlign4 = IP_CONST_ALIGNMENT_NG;
            nAlign5 = IP_CONST_ALIGNMENT_TN;
            nAlign6 = IP_CONST_ALIGNMENT_NE;
            break;
        case ALIGNMENT_NEUTRAL:
            nDamageType2 = IP_CONST_DAMAGETYPE_MAGICAL;

            nAlign1 = IP_CONST_ALIGNMENT_LE;
            nAlign2 = IP_CONST_ALIGNMENT_LN;
            nAlign3 = IP_CONST_ALIGNMENT_LG;
            nAlign4 = IP_CONST_ALIGNMENT_CG;
            nAlign5 = IP_CONST_ALIGNMENT_CN;
            nAlign6 = IP_CONST_ALIGNMENT_CE;
            break;
        case ALIGNMENT_CHAOTIC:
            nDamageType2 = IP_CONST_DAMAGETYPE_MAGICAL;

            nAlign1 = IP_CONST_ALIGNMENT_LE;
            nAlign2 = IP_CONST_ALIGNMENT_LN;
            nAlign3 = IP_CONST_ALIGNMENT_LG;
            nAlign4 = IP_CONST_ALIGNMENT_NG;
            nAlign5 = IP_CONST_ALIGNMENT_TN;
            nAlign6 = IP_CONST_ALIGNMENT_NE;
            break;
    }

    eVis = EffectVisualEffect(VFX_IMP_KNOCK);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);

    itemproperty ip0, ip1, ip2, ip3, ip4, ip5, ip6, ip7;

    ip0 = ItemPropertyDamageBonusVsAlign(nAlignGroup1, nDamageType1, nDamage);
    ip1 = ItemPropertyDamageBonusVsAlign(nAlignGroup2, nDamageType1, nDamage);
    ip2 = ItemPropertyDamageBonusVsSAlign(nAlign1, nDamageType2, nDamage);
    ip3 = ItemPropertyDamageBonusVsSAlign(nAlign2, nDamageType2, nDamage);
    ip4 = ItemPropertyDamageBonusVsSAlign(nAlign3, nDamageType2, nDamage);
    ip5 = ItemPropertyDamageBonusVsSAlign(nAlign4, nDamageType2, nDamage);
    ip6 = ItemPropertyDamageBonusVsSAlign(nAlign5, nDamageType2, nDamage);
    ip7 = ItemPropertyDamageBonusVsSAlign(nAlign6, nDamageType2, nDamage);

    IPSafeAddItemProperty(oWeapon, ip0, fDuration);
    IPSafeAddItemProperty(oWeapon, ip1, fDuration);
    IPSafeAddItemProperty(oWeapon, ip2, fDuration);
    IPSafeAddItemProperty(oWeapon, ip3, fDuration);
    IPSafeAddItemProperty(oWeapon, ip4, fDuration);
    IPSafeAddItemProperty(oWeapon, ip5, fDuration);
    IPSafeAddItemProperty(oWeapon, ip6, fDuration);
    IPSafeAddItemProperty(oWeapon, ip7, fDuration);

    DelayCommand(fDuration + 0.2f, PurgeLingeringSmiteProperty(oPC, oWeapon, ip0));
    DelayCommand(fDuration + 0.2f, PurgeLingeringSmiteProperty(oPC, oWeapon, ip1));
    DelayCommand(fDuration + 0.2f, PurgeLingeringSmiteProperty(oPC, oWeapon, ip2));
    DelayCommand(fDuration + 0.2f, PurgeLingeringSmiteProperty(oPC, oWeapon, ip3));
    DelayCommand(fDuration + 0.2f, PurgeLingeringSmiteProperty(oPC, oWeapon, ip4));
    DelayCommand(fDuration + 0.2f, PurgeLingeringSmiteProperty(oPC, oWeapon, ip5));
    DelayCommand(fDuration + 0.2f, PurgeLingeringSmiteProperty(oPC, oWeapon, ip6));
    DelayCommand(fDuration + 0.2f, PurgeLingeringSmiteProperty(oPC, oWeapon, ip7));
}

void main() {
    object oCaster = OBJECT_SELF;
    object oRightWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oCaster);
    object oLeftWeapon = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oCaster);
    object oGlove = GetItemInSlot(INVENTORY_SLOT_ARMS, oCaster);

    if(GetIsObjectValid(oRightWeapon) && (IPGetIsMeleeWeapon(oRightWeapon) || IPGetIsRangedWeapon(oRightWeapon))) {
        ApplySmitePropertiesToWeapon(oRightWeapon, oCaster);

        if(GetIsObjectValid(oLeftWeapon) && IPGetIsMeleeWeapon(oLeftWeapon)) ApplySmitePropertiesToWeapon(oLeftWeapon, oCaster);
    } else if(GetIsObjectValid(oGlove)) {
        ApplySmitePropertiesToWeapon(oGlove,oCaster);
    }
}
