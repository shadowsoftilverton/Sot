#include "engine"

//::///////////////////////////////////////////////
//:: INC_EQUIPMENT.NSS
//:: Silver Marches Script
//:://////////////////////////////////////////////
/*
    Has a lot of convenience functions related to
    equipment. Mostly here to maintain cleanliness.
*/
//:://////////////////////////////////////////////
//:: Created By: Ashton Shapcott
//:: Created On: Oct. 30, 2010
//:://////////////////////////////////////////////

#include "x2_inc_itemprop"

#include "inc_system"
#include "inc_mod"

#include "ave_inc_rogue"

#include "nwnx_structs"


// Equivalent to CREATURE_SIZE_*, but less confusing in scripts.
const int WEAPON_SIZE_INVALID = 0;
const int WEAPON_SIZE_TINY = 1;
const int WEAPON_SIZE_SMALL = 2;
const int WEAPON_SIZE_MEDIUM = 3;
const int WEAPON_SIZE_LARGE = 4;
const int WEAPON_SIZE_HUGE = 5;

int FEAT_EPIC_ARMOR_FOCUS_LIGHT= 1388;
int FEAT_EPIC_ARMOR_FOCUS_MEDIUM=1389;
int FEAT_EPIC_ARMOR_FOCUS_HEAVY=1390;

int FEAT_PARAGON_ARMOR_FOCUS_LIGHT=1391;
int FEAT_PARAGON_ARMOR_FOCUS_MEDIUM=1392;
int FEAT_PARAGON_ARMOR_FOCUS_HEAVY=1393;

/*int FEAT_ARMOR_FOCUS_LIGHT  = 1308;
int FEAT_ARMOR_FOCUS_MEDIUM = 1309;
int FEAT_ARMOR_FOCUS_HEAVY  = 1310;

int FEAT_IMPROVED_ARMOR_FOCUS_LIGHT  = 1311;
int FEAT_IMPROVED_ARMOR_FOCUS_MEDIUM = 1312;
int FEAT_IMPROVED_ARMOR_FOCUS_HEAVY  = 1313;

int FEAT_GREATER_ARMOR_FOCUS_LIGHT  = 1314;
int FEAT_GREATER_ARMOR_FOCUS_MEDIUM = 1315;
int FEAT_GREATER_ARMOR_FOCUS_HEAVY  = 1316;*/

// The duration of a 30-day period in seconds (2,592,000) plus a random number
// between 1.0 and 1.999... in order to seed the system with a value that is
// extremely unlikely to come up in spell scripts (most are in increments of
// 6.0 but, even avoiding that, most must be even... and even avoiding that most
// are actually a whole number).
const float DURATION_VALUE_SYSTEM = 2592001.21494;

// ** DOCUMENTATION ** //

// Does adjustments based on all equipped items and all non-specific modifiers.
void DoResetEquipAdjustments(object oPC);

// Does adjustments not related to specific pieces of equipment.
void DoGeneralEquipAdjustments(object oPC);

// Does adjustments for equipping items automatically.
void DoEquipAdjustments(object oPC, object oItem);

// Does adjustments for unequipping items automatically.
void DoUnequipAdjustments(object oPC, object oItem);

// Broadcasts an emote signifying that an item has been changed.
// Useful to DMs to monitor item-swapping in events.
void DoBroadcastItemEquip(object oPC, object oItem);

// Checks if oCreature can use the one-handed weapon oWeapon in two hands. Will
// return FALSE if it is too small or if it must be wielded in two-hands to be
// used.
int GetIsOptionalTwoHandable(object oWeapon, object oCreature=OBJECT_SELF);

// Returns TRUE if oCreature has their offhand free.
int GetIsOffHandFree(object oCreature=OBJECT_SELF);

// Returns TRUE if oCreature has a melee weapon in each hand.
int GetIsDualWielding(object oCreature=OBJECT_SELF);

// Returns TRUE if oItem is a weapon.
int GetIsWeapon(object oItem);

// Returns TRUE if oItem is a double weapon.
int GetIsDoubleWeapon(object oItem);

// Get the size (WEAPON_SIZE_*) of oWeapon.
int GetWeaponSize(object oWeapon);

// Get the weapon damage type (WEAPON_DAMAGE_TYPE_*) of oWeapon.
int GetWeaponDamageType(object oWeapon);

// Returns the armor check penalty of the given item. For items without armor
// check penalties, this function will return 0.
//
// NOTE: This is returned as a positive value.
int GetArmorCheckPenalty(object oItem);

// Convenience method. Returns TRUE if oItem is a shield.
int GetIsShield(object oItem);

// Returns the non-proficient usage penalty for the given item.
//
// NOTE: This is returned as a positive value.
int GetNonProficientPenalty(object oItem, object oPC);

//Returns whether the character has a mainhand item or not
int GetIsMainHandFree(object oCreature);

//Applies bonuses for the hidden weapons feats
void DoGiveHiddenWeaponBonus(object oCreature);

//Returns true if the PC has 10 or fewer levels in non-DD classes.
int GetIsDedicatedDefender(object oPC);

// ** SCRIPTS ** //

void DoResetEquipAdjustments(object oPC){
    object oItem;

    int i;

    for(i = 0; i <= 13; i++){
        oItem = GetItemInSlot(i, oPC);

        DoUnequipAdjustments(oPC, oItem);
        DoEquipAdjustments(oPC, oItem);
    }

    DoGeneralEquipAdjustments(oPC);
}

void ApplyEquipLock(object oPC)
{
    //Note: the use of the CutsceneParalyze effect for this lock
    //      prevents ILR from working. Commented this functionality
    //      out until a better solution is found.

    //effect eLock = SystemEffect(EffectCutsceneParalyze());
    //ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLock, oPC);
}

void RemoveEquipLock(object oPC)
{
    //effect eTemp = GetFirstEffect(oPC);
    //while(GetIsEffectValid(eTemp))
    //{
    //    if(GetEffectType(eTemp) == EFFECT_TYPE_CUTSCENE_PARALYZE) RemoveSystemEffect(oPC, eTemp);
    //    eTemp = GetNextEffect(oPC);
    //}
}

int GetIsDedicatedDefender(object oPC)
{
    int iTotal=GetHitDice(oPC);
    int iDefend=GetLevelByClass(CLASS_TYPE_DWARVEN_DEFENDER,oPC);
    if(iDefend+11>iTotal) return 1;
    return 0;
}

//Returns true if oWep is a longbow or shortbow
int GetIsBow(object oWep)
{
    int iType=GetBaseItemType(oWep);
    if(iType==BASE_ITEM_LONGBOW||iType==BASE_ITEM_SHORTBOW) return 1;
    return 0;
}

void DoGeneralEquipAdjustments(object oPC){
    effect e = GetFirstEffect(oPC);
    object oGlove = GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);
    object oOnHand  = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    object oOffHand = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
    object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
    int nPenalty;
    int nParryBonus;
    effect eParryBonusAC;
    while(GetIsEffectValid(e)){
        if(GetEffectType(e) != EFFECT_TYPE_CUTSCENE_PARALYZE) RemoveSystemEffect(oPC, e);

        e = GetNextEffect(oPC);
    }

    if(GetHasFeat(1539,oPC)||GetHasFeat(1538,oPC)||GetHasFeat(1541,oPC)||GetHasFeat(1540,oPC))
    {//This handles shot on the run, precise shot, and dirty fighting
        itemproperty IPSmack=ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER,GetHitDice(oPC));
        IPSmack=SystemItemProperty(IPSmack);
        if(IPGetIsRangedWeapon(oOnHand))//Everything but dirty fighting only works on ranged weapons
        {
            IPSafeAddItemProperty(oOnHand,IPSmack);//Adding it to the weapon didn't seem to work except for thrown...
            IPSafeAddItemProperty(GetItemInSlot(INVENTORY_SLOT_ARROWS,oPC),IPSmack);//So we'll try adding it to the arrows, instead.
            IPSafeAddItemProperty(GetItemInSlot(INVENTORY_SLOT_BOLTS,oPC),IPSmack);//So we'll try adding it to the arrows, instead.
            IPSafeAddItemProperty(GetItemInSlot(INVENTORY_SLOT_BULLETS,oPC),IPSmack);//So we'll try adding it to the arrows, instead.
        }
        else if(GetHasFeat(1541,oPC))//Dirty fighting works on all weapons
        {
            if(GetIsWeapon(oOffHand)) IPSafeAddItemProperty(oOffHand,IPSmack);
            if(GetIsWeapon(oOnHand)) IPSafeAddItemProperty(oOnHand,IPSmack);
            else if(GetIsObjectValid(oGlove)) IPSafeAddItemProperty(oGlove,IPSmack);
        }
    }

    // Handle the parry skill granting an AC bonus.
    eParryBonusAC = GetFirstEffect(oPC);
    while(GetIsEffectValid(eParryBonusAC)) {
        if(GetEffectSpellId(eParryBonusAC) == PARRY_BONUS_SPELL_ID) Std_RemoveEffect(oPC, eParryBonusAC);

        eParryBonusAC = GetNextEffect(oPC);
    }

    nParryBonus = 0;

    if(GetIsDualWielding(oPC)) {
        if(GetHasFeat(FEAT_IMPROVED_PARRY, oPC) || ((GetWeaponSize(oOnHand) < GetCreatureSize(oPC) || GetBaseItemType(oOnHand) == BASE_ITEM_RAPIER) && (GetWeaponSize(oOffHand) < GetCreatureSize(oPC) || GetBaseItemType(oOnHand) == BASE_ITEM_RAPIER))) // both light weapons
            nParryBonus += GetSkillRank(SKILL_PARRY, oPC, TRUE) / 5;
        else
            nParryBonus += GetSkillRank(SKILL_PARRY, oPC, TRUE) / 10;
    } else if(GetIsObjectValid(oOnHand) && (GetWeaponSize(oOnHand) < GetCreatureSize(oPC) || GetBaseItemType(oOnHand) == BASE_ITEM_RAPIER)) { // On-hand only, light
        nParryBonus += GetSkillRank(SKILL_PARRY, oPC, TRUE) / 5;
    } else if(!GetIsObjectValid(oOnHand) && !GetIsObjectValid(oOffHand)) { // Unarmed - counts as a light weapon
        nParryBonus += GetSkillRank(SKILL_PARRY, oPC, TRUE) / 5;
    } else { // Wielding weapon/weapons that isn't/aren't light
        if(GetHasFeat(FEAT_IMPROVED_PARRY, oPC))
            nParryBonus += GetSkillRank(SKILL_PARRY, oPC, TRUE) / 5;
        else
            nParryBonus += GetSkillRank(SKILL_PARRY, oPC, TRUE) / 10;
    }

    // Additional code for polearms - we're just going to wrap this into the Parry code since it should stack.
    if(GetBaseItemType(oOnHand) == BASE_ITEM_SHORTSPEAR || GetBaseItemType(oOffHand) == BASE_ITEM_HALBERD) {
        if(GetHasFeat(FEAT_POLEARM_DEFENSE, oPC))
            nParryBonus += 2;
        else
            nParryBonus += 1;
    }

    eParryBonusAC = EffectACIncrease(nParryBonus, AC_SHIELD_ENCHANTMENT_BONUS);
    eParryBonusAC = SupernaturalEffect(eParryBonusAC);
    SetEffectSpellId(eParryBonusAC, PARRY_BONUS_SPELL_ID);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eParryBonusAC, oPC);

    if(GetHasFeat(1555,oPC)) SetLocalInt(oPC,"ave_hier_cel",0);
    SetACNaturalBase(oPC, 0);

    if(GetIsDualWielding(oPC)){
        int nBonus;

             if(GetHasFeat(FEAT_GREATER_TWO_WEAPON_DEFENSE, oPC))   nBonus = 3;
        else if(GetHasFeat(FEAT_IMPROVED_TWO_WEAPON_DEFENSE, oPC))  nBonus = 2;
        else if(GetHasFeat(FEAT_TWO_WEAPON_DEFENSE, oPC))           nBonus = 1;

        ModifyACNaturalBase(oPC, nBonus);
    }
    if(GetBaseItemType(oOffHand) == BASE_ITEM_SMALLSHIELD)
    {
        if(!GetHasFeat(FEAT_SHIELD_PROFICIENCY,oPC))
        {
            SendMessageToPC(oPC, "You receive a penalty to attack when equipping a small shield without proficiency.");
            nPenalty=1;
            effect ePenalty = SystemEffect(EffectAttackDecrease(nPenalty));
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePenalty, oPC);
        }
        if(GetHasFeat(BUCKLER_TRICKSTER,oPC))
        {
            ModifyACNaturalBase(oPC,GetLevelByClass(CLASS_TYPE_ROGUE,oPC)/6);
        }
    }
    if(GetBaseItemType(oOffHand)==BASE_ITEM_LARGESHIELD)
    {
        if(!GetHasFeat(FEAT_SHIELD_PROFICIENCY,oPC))
        {
            SendMessageToPC(oPC, "You receive a penalty to attack when equipping a large shield without proficiency.");
            nPenalty=3;
            effect ePenalty = SystemEffect(EffectAttackDecrease(nPenalty));
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePenalty, oPC);
        }
    }

    if(GetBaseItemType(oOffHand) == BASE_ITEM_TOWERSHIELD){
        if(GetHasFeat(FEAT_GREATER_TOWER_SHIELD_PROFICIENCY, oPC)) {
            ModifyACNaturalBase(oPC, 3);
        } else if(GetHasFeat(FEAT_IMPROVED_TOWER_SHIELD_PROFICIENCY, oPC)) {
            ModifyACNaturalBase(oPC, 2);
            nPenalty = 1;
            effect ePenalty = SystemEffect(EffectAttackDecrease(nPenalty));
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePenalty, oPC);
        } else if(GetHasFeat(FEAT_TOWER_SHIELD_PROFICIENCY, oPC)) {
            ModifyACNaturalBase(oPC, 1);
            nPenalty = 2;
            effect ePenalty = SystemEffect(EffectAttackDecrease(nPenalty));
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePenalty, oPC);
        } else {
            SendMessageToPC(oPC, "You receive a penalty to attack when equipping a tower shield without proficiency.");
            nPenalty=10;
            effect ePenalty = SystemEffect(EffectAttackDecrease(nPenalty));
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, ePenalty, oPC);
        }
    }

    if(GetIsObjectValid(oArmor)) {
        int nResistance = 0;

        switch(GetItemACBase(oArmor)) {
            case 1: case 2: case 3:
                SendMessageToPC(oPC,"You are wearing light armor");
                if(GetHasFeat(LIGHT_ARMOR_TRICKSTER,oPC))
                {
                    SendMessageToPC(oPC,"You are a light armor trickster in light armor and are rogue level "+IntToString(GetLevelByClass(CLASS_TYPE_ROGUE,oPC)));
                    ModifyACNaturalBase(oPC,GetLevelByClass(CLASS_TYPE_ROGUE,oPC)/6);
                }
            case 0:
                if(GetHasFeat(FEAT_PARAGON_ARMOR_FOCUS_LIGHT, oPC)){
                    ModifyACNaturalBase(oPC, 8);
                    nResistance = 10;
                }else if(GetHasFeat(FEAT_EPIC_ARMOR_FOCUS_LIGHT, oPC)){
                    ModifyACNaturalBase(oPC, 5);
                    nResistance = 8;
                } else if(GetHasFeat(FEAT_GREATER_ARMOR_FOCUS_LIGHT, oPC)) {
                    ModifyACNaturalBase(oPC, 3);
                    nResistance = 6;
                } else if(GetHasFeat(FEAT_IMPROVED_ARMOR_FOCUS_LIGHT, oPC)) {
                    ModifyACNaturalBase(oPC, 2);
                    nResistance = 4;
                } else if(GetHasFeat(FEAT_ARMOR_FOCUS_LIGHT, oPC)) {
                    ModifyACNaturalBase(oPC, 1);
                    nResistance = 2;
                }
                //SendMessageToPC(oPC,"Debug: You equipped light armor");
                if(GetHasFeat(1555,oPC)) //Celebrant
                {
                    if(!GetHasFeat(260,oPC))//Celebrant but not monk AC bonus
                    {
                        if(!GetHasFeatEffect(FEAT_DIVINE_SHIELD,oPC))
                        {
                            int iMyMod=GetAbilityModifier(ABILITY_CHARISMA,oPC);
                            //SendMessageToPC(oPC,"Celebrant enhancing AC by "+IntToString(iMyMod));
                            ModifyACNaturalBase(oPC,iMyMod);
                            SetLocalInt(oPC,"ave_hier_cel",1);
                        }
                    }
                }
                break;
            case 4: case 5:
                if(GetHasFeat(FEAT_PARAGON_ARMOR_FOCUS_MEDIUM, oPC)){
                    ModifyACNaturalBase(oPC, 8);
                    nResistance = 10;
                }else if(GetHasFeat(FEAT_EPIC_ARMOR_FOCUS_MEDIUM, oPC)){
                    ModifyACNaturalBase(oPC, 5);
                    nResistance = 8;
                } else if(GetHasFeat(FEAT_GREATER_ARMOR_FOCUS_MEDIUM, oPC)) {
                    ModifyACNaturalBase(oPC, 3);
                    nResistance = 6;
                } else if(GetHasFeat(FEAT_IMPROVED_ARMOR_FOCUS_MEDIUM, oPC)) {
                    ModifyACNaturalBase(oPC, 2);
                    nResistance = 4;
                } else if(GetHasFeat(FEAT_ARMOR_FOCUS_MEDIUM, oPC)) {
                    ModifyACNaturalBase(oPC, 1);
                    nResistance = 2;
                }
                break;
            case 6: case 7: case 8:
                if(GetHasFeat(FEAT_PARAGON_ARMOR_FOCUS_HEAVY, oPC)){
                    ModifyACNaturalBase(oPC, 8);
                    nResistance = 10;
                }else if(GetHasFeat(FEAT_EPIC_ARMOR_FOCUS_HEAVY, oPC)){
                    ModifyACNaturalBase(oPC, 5);
                    nResistance = 8;
                } else if(GetHasFeat(FEAT_GREATER_ARMOR_FOCUS_HEAVY, oPC)) {
                    ModifyACNaturalBase(oPC, 3);
                    nResistance = 6;
                } else if(GetHasFeat(FEAT_IMPROVED_ARMOR_FOCUS_HEAVY, oPC)) {
                    ModifyACNaturalBase(oPC, 2);
                    nResistance = 4;
                } else if(GetHasFeat(FEAT_ARMOR_FOCUS_HEAVY, oPC)) {
                    ModifyACNaturalBase(oPC, 1);
                    nResistance = 2;
                }
                break;
            default: break;
        }

        if(GetIsDedicatedDefender(oPC))
        {
            if(GetHasFeat(494,oPC)) nResistance=nResistance+6;
            else if(GetHasFeat(493,oPC)) nResistance=nResistance+4;
            else if(GetHasFeat(492,oPC)) nResistance=nResistance+2;
        }

        if(nResistance > 0) {
            effect eLink = EffectDamageResistance(DAMAGE_TYPE_SLASHING, nResistance);
            eLink = EffectLinkEffects(eLink, EffectDamageResistance(DAMAGE_TYPE_PIERCING, nResistance));
            eLink = EffectLinkEffects(eLink, EffectDamageResistance(DAMAGE_TYPE_BLUDGEONING, nResistance));

            ApplyEffectToObject(DURATION_TYPE_PERMANENT, SystemEffect(eLink), oPC);
        }
    }

        if(GetHasFeat(HIDDEN_WEAPONS,oPC)||GetHasFeat(HIDDEN_WEAPONS_2,oPC))
        {
            if(GetIsMainHandFree(oPC))
            {
                if(GetIsOffHandFree(oPC))
                {
                    DoGiveHiddenWeaponBonus(oPC);
                }
            }
        }

    if(GetIsOptionalTwoHandable(oOnHand, oPC) && !GetIsObjectValid(oOffHand) && IPGetIsMeleeWeapon(oOnHand)){
        int nBonus = GetAbilityModifier(ABILITY_STRENGTH, oPC)/2;
        int nType = GetWeaponDamageType(oOnHand);

        if(nBonus < 1) return;

        if(nBonus > 5) nBonus += 10;

        switch(nType){
            case WEAPON_DAMAGE_TYPE_BLUDGEONING:            nType = DAMAGE_TYPE_BLUDGEONING;    break;
            case WEAPON_DAMAGE_TYPE_BLUDGEONING_PIERCING:   nType = DAMAGE_TYPE_BLUDGEONING;    break;
            case WEAPON_DAMAGE_TYPE_PIERCING:               nType = DAMAGE_TYPE_PIERCING;       break;
            case WEAPON_DAMAGE_TYPE_PIERCING_SLASHING:      nType = DAMAGE_TYPE_PIERCING;       break;
            case WEAPON_DAMAGE_TYPE_SLASHING:               nType = DAMAGE_TYPE_SLASHING;       break;
            default:                                        nType = DAMAGE_TYPE_BLUDGEONING;    break;
        }

        effect eBonus = SystemEffect(EffectDamageIncrease(nBonus, nType));

        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eBonus, oPC);
    }

    // Account for how equipment might modify Exemplar saves.
    ClearDivineGraceFeatProperties(oPC);
    ApplyDivineGraceFeatProperties(oPC);
}

//Determines whether a bard PC is eligible for
int GetIsCasterBard(object oPC)
{
    if(GetLevelByClass(CLASS_TYPE_BARD, oPC)==0) return FALSE;
    if(GetCasterLevelByClass(oPC,CLASS_TYPE_BARD)*3+GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE)>GetHitDice(oPC))
    {
        return TRUE;
    }
    return FALSE;
}

void DoEquipAdjustments(object oPC, object oItem){
    if(!GetIsProficient(oItem, oPC) && GetIsWeapon(oItem)){
        itemproperty ipNonProficient = SystemItemProperty(ItemPropertyAttackPenalty(4));

        IPSafeAddItemProperty(oItem, ipNonProficient, DURATION_VALUE_SYSTEM, X2_IP_ADDPROP_POLICY_IGNORE_EXISTING);
    }

    if(GetIsCasterBard(oPC) & GetBaseItemType(oItem) == BASE_ITEM_ARMOR)
    {
        itemproperty ipASF;

        int nASF = -1;

        int nAC = GetItemACBase(oItem);

        switch(nAC)
        {
            case 1: nASF = IP_CONST_ARCANE_SPELL_FAILURE_MINUS_5_PERCENT;  break;
            case 2: nASF = IP_CONST_ARCANE_SPELL_FAILURE_MINUS_10_PERCENT; break;
            case 3: case 4: nASF = IP_CONST_ARCANE_SPELL_FAILURE_MINUS_20_PERCENT; break;
        }

        if(nASF > 0)
        {
            ipASF = SystemItemProperty(ItemPropertyArcaneSpellFailure(nASF));

            IPSafeAddItemProperty(oItem, ipASF, DURATION_VALUE_SYSTEM, X2_IP_ADDPROP_POLICY_IGNORE_EXISTING);
        }
    }

    if(GetIsCasterBard(oPC) && GetBaseItemType(oItem) == BASE_ITEM_SMALLSHIELD)
    {
        int nShieldASF = IP_CONST_ARCANE_SPELL_FAILURE_MINUS_5_PERCENT;
        itemproperty ipShieldASF = SystemItemProperty(ItemPropertyArcaneSpellFailure(nShieldASF));
        IPSafeAddItemProperty(oItem, ipShieldASF, DURATION_VALUE_SYSTEM, X2_IP_ADDPROP_POLICY_IGNORE_EXISTING);
    }

    DelayCommand(0.0, DoGeneralEquipAdjustments(oPC));
}

void DoUnequipAdjustments(object oPC, object oItem){
    itemproperty ip = GetFirstItemProperty(oItem);

    while(GetIsItemPropertyValid(ip)){
        RemoveSystemItemProperty(oItem, ip);

        ip = GetNextItemProperty(oItem);
    }

    DelayCommand(0.0, DoGeneralEquipAdjustments(oPC));
}

void DoBroadcastItemEquip(object oPC, object oItem) {
    if(!GetLocalInt(oPC, "sys_equip_broadcast")) return;

    int iType = GetBaseItemType(oItem);

    switch(iType) {
        case BASE_ITEM_AMULET:
            FloatingTextStringOnCreature("*Equips an amulet.*", oPC, FALSE);
        case BASE_ITEM_ARMOR:
            FloatingTextStringOnCreature("*Equips armor/clothing.*", oPC, FALSE);
        case BASE_ITEM_ARROW:
            FloatingTextStringOnCreature("*Equips arrows.*", oPC, FALSE);
        case BASE_ITEM_BELT:
            FloatingTextStringOnCreature("*Equips a belt.*", oPC, FALSE);
        case BASE_ITEM_BOLT:
            FloatingTextStringOnCreature("*Equips crossbow bolts.*", oPC, FALSE);
        case BASE_ITEM_BOOTS:
            FloatingTextStringOnCreature("*Equips boots.*", oPC, FALSE);
        case BASE_ITEM_BRACER:
            FloatingTextStringOnCreature("*Equips bracers.*", oPC, FALSE);
        case BASE_ITEM_BULLET:
            FloatingTextStringOnCreature("*Equips sling bullets.*", oPC, FALSE);
        case BASE_ITEM_CLOAK:
            FloatingTextStringOnCreature("*Equips a cloak.*", oPC, FALSE);
        case BASE_ITEM_GLOVES:
            FloatingTextStringOnCreature("*Equips gloves.*", oPC, FALSE);
        case BASE_ITEM_RING:
            FloatingTextStringOnCreature("*Equips a ring.*", oPC, FALSE);
        case BASE_ITEM_HELMET:
            FloatingTextStringOnCreature("*Equips a helm/hood.*", oPC, FALSE);
        default: break;
    }
}

int GetIsOptionalTwoHandable(object oWeapon, object oCreature=OBJECT_SELF){
    if(GetBaseItemType(oWeapon) == BASE_ITEM_WHIP) return FALSE;
    if(GetBaseItemType(oWeapon) == BASE_ITEM_RAPIER) return FALSE;

    if(GetCreatureSize(oCreature) == GetWeaponSize(oWeapon)) return TRUE;

    return FALSE;
}

int GetIsOffHandFree(object oCreature){
    object oOffHand = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oCreature);
    if(GetIsObjectValid(oOffHand)) return 0;
    return 1;
}

int GetIsMainHandFree(object oCreature)
{
    object oMainHand=GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oCreature);
    if(GetIsObjectValid(oMainHand)) return 0;
    return 1;
}

void DoGiveHiddenWeaponBonus(object oCreature)
{
    effect eEffect;
    effect eEffect2;
    if(GetHasFeat(HIDDEN_WEAPONS_2))
    {
        if(!GetHasFeat(FEAT_IMPROVED_UNARMED_STRIKE,oCreature))
        {AddKnownFeat(oCreature,FEAT_IMPROVED_UNARMED_STRIKE,GetHitDice(oCreature));}

        if(!GetHasFeat(FEAT_STUNNING_FIST,oCreature))
        {AddKnownFeat(oCreature,FEAT_STUNNING_FIST,GetHitDice(oCreature));}

        eEffect=EffectDamageIncrease(DAMAGE_BONUS_2d8,DAMAGE_TYPE_PIERCING);
        eEffect2=EffectAttackIncrease(4);
    }
    else
    {
        if(!GetHasFeat(FEAT_IMPROVED_UNARMED_STRIKE,oCreature))
        {AddKnownFeat(oCreature,FEAT_IMPROVED_UNARMED_STRIKE,GetHitDice(oCreature));}

        eEffect=EffectDamageIncrease(DAMAGE_BONUS_1d8,DAMAGE_TYPE_PIERCING);
        eEffect2=EffectAttackIncrease(2);
    }
    effect eLink=EffectLinkEffects(eEffect,eEffect2);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,SystemEffect(eLink),oCreature);
}

int GetIsDualWielding(object oCreature){
    object oOnHand = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oCreature);
    object oOffHand = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oCreature);

    if(!GetIsObjectValid(oOnHand)) return FALSE;
    if(!GetIsObjectValid(oOffHand) && !GetIsDoubleWeapon(oOnHand)) return FALSE;
    if(!IPGetIsMeleeWeapon(oOnHand)) return FALSE;
    if(!IPGetIsMeleeWeapon(oOffHand) && !GetIsDoubleWeapon(oOnHand)) return FALSE;

    return TRUE;
}

int GetIsWeapon(object oItem){
    return IPGetIsMeleeWeapon(oItem) || IPGetIsRangedWeapon(oItem);
}

int GetIsDoubleWeapon(object oItem) {
    int iType = GetBaseItemType(oItem);

    return iType == BASE_ITEM_TWOBLADEDSWORD || iType == BASE_ITEM_DIREMACE || iType == BASE_ITEM_DOUBLEAXE || iType==BASE_ITEM_QUARTERSTAFF;
}

int GetWeaponSize(object oWeapon){
    string sSize = Get2DAString("baseitems", "WeaponSize", GetBaseItemType(oWeapon));
    return StringToInt(sSize);
}

int GetWeaponDamageType(object oWeapon){
    string sType = Get2DAString("baseitems", "WeaponType", GetBaseItemType(oWeapon));
    return StringToInt(sType);
}

int GetArmorCheckPenalty(object oItem){
    int iType = GetBaseItemType(oItem);

    if(iType == BASE_ITEM_SMALLSHIELD
    || iType == BASE_ITEM_LARGESHIELD
    || iType == BASE_ITEM_TOWERSHIELD){
        string sPenalty = Get2DAString("baseitems", "ArmorCheckPen", GetBaseItemType(oItem));
        return -StringToInt(sPenalty);
    } else if(iType == BASE_ITEM_ARMOR){
        string sPenalty = Get2DAString("armor", "ACCHECK", GetItemACValue(oItem));
        return -StringToInt(sPenalty);
    }

    // Defaults to zero, since no other items have an armor check penalty.
    return 0;
}

int GetIsShield(object oItem){
    int nType = GetBaseItemType(oItem);

    if(nType == BASE_ITEM_SMALLSHIELD) return TRUE;
    if(nType == BASE_ITEM_LARGESHIELD) return TRUE;
    if(nType == BASE_ITEM_TOWERSHIELD) return TRUE;

    return FALSE;
}

int GetNonProficientPenalty(object oItem, object oPC){
    if(!GetIsObjectValid(oItem)){
        return 0;
    }

    int iType = GetBaseItemType(oItem);

    if(GetIsWeapon(oItem)){
       return 4;
    } else if(iType == BASE_ITEM_SMALLSHIELD || iType == BASE_ITEM_LARGESHIELD
           || iType == BASE_ITEM_TOWERSHIELD || iType == BASE_ITEM_ARMOR){
       return GetArmorCheckPenalty(oItem);
    }

    return 0;
}
