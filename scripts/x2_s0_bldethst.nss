//Blade Thirst by Hardcore UFO
//Will apply scaling enhancement bonus to melee weapons.
//When dual weilding this will apply to both weapons.
//Will apply scaling attack bonus and damage to ranged weapons.
//Will work on all weapons and gloves.
//Will also add keen and OnHit wounding to the weapon.
//Gloves are targeted if nothing is equipped in the main hand.
//Lasts 1 turn per level.

#include "nw_i0_spells"
#include "x2_i0_spells"
#include "x2_inc_spellhook"
#include "engine"

void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }

    effect eVis = EffectVisualEffect(VFX_IMP_WALLSPIKE);
    effect eFlame = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    eVis = EffectLinkEffects(eFlame, eVis);
    int nCL = GetCasterLevel(OBJECT_SELF);
    object oTarget = OBJECT_SELF;
    int nMetaMagic = GetMetaMagicFeat();
    int nPower = nCL / 4;

    if(nPower > 5)
    {
        nPower = 5;
    }

    //int nWIS = GetAbilityScore(oTarget, ABILITY_WISDOM, FALSE);
    //int nCD = 10 + (nCL / 2) + nWIS;

    //Metamagic conditions
    if(nMetaMagic == METAMAGIC_EXTEND)
    {
        nCL = nCL * 2;
    }

    //Weapon definition.
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget);
    int nWeapon = GetBaseItemType(oWeapon);
    object oGloves = GetItemInSlot(INVENTORY_SLOT_ARMS, oTarget);
    int nGloves = GetBaseItemType(oGloves);

    float fDuration = TurnsToSeconds(nCL);
    itemproperty iBleed = ItemPropertyOnHitProps(IP_CONST_ONHIT_WOUNDING, IP_CONST_ONHIT_SAVEDC_26, nPower);

    //Melee weapon equipped: Enhancement bonus
    if(IPGetIsMeleeWeapon(oWeapon) == TRUE)
    {
        object oWeppin = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oTarget);

        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oWeapon));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oWeapon), fDuration);
        IPSafeAddItemProperty(oWeapon, ItemPropertyEnhancementBonus(nPower), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
        IPSafeAddItemProperty(oWeapon, ItemPropertyKeen(), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
        IPSafeAddItemProperty(oWeapon, iBleed, fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);

        if(IPGetIsMeleeWeapon(oWeppin) == TRUE)
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oWeppin));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oWeppin), fDuration);
            IPSafeAddItemProperty(oWeppin, ItemPropertyEnhancementBonus(nPower), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            IPSafeAddItemProperty(oWeppin, ItemPropertyKeen(), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            IPSafeAddItemProperty(oWeppin, iBleed, fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
        }
    }

    //Ranged weapon equipped: Attack and damage bonus
    else if(IPGetIsRangedWeapon(oWeapon) == TRUE)
    {
        //Sling: Bludgeoning
        if(nWeapon == BASE_ITEM_SLING)
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oWeapon), fDuration);
            IPSafeAddItemProperty(oWeapon, ItemPropertyAttackBonus(nPower), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            IPSafeAddItemProperty(oWeapon, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING, nPower), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            IPSafeAddItemProperty(oWeapon, ItemPropertyKeen(), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            IPSafeAddItemProperty(oWeapon, iBleed, fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
        }

        //Throwing Axe: Slashing
        else if(nWeapon == BASE_ITEM_THROWINGAXE)
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oWeapon), fDuration);
            IPSafeAddItemProperty(oWeapon, ItemPropertyAttackBonus(nPower), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            IPSafeAddItemProperty(oWeapon, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SLASHING, nPower), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            IPSafeAddItemProperty(oWeapon, ItemPropertyKeen(), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            IPSafeAddItemProperty(oWeapon, iBleed, fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
        }

        //Other ranged weapons: Piercing
        else
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oWeapon), fDuration);
            IPSafeAddItemProperty(oWeapon, ItemPropertyAttackBonus(nPower), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            IPSafeAddItemProperty(oWeapon, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING, nPower), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            IPSafeAddItemProperty(oWeapon, ItemPropertyKeen(), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            IPSafeAddItemProperty(oWeapon, iBleed, fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
        }
    }

    //No weapon but gloves equipped: Attack and damage bonus
    else if(oWeapon == OBJECT_INVALID && nGloves == BASE_ITEM_GLOVES)
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oGloves));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oGloves), fDuration);
        IPSafeAddItemProperty(oGloves, ItemPropertyAttackBonus(nPower), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
        IPSafeAddItemProperty(oGloves, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING, nPower), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
        IPSafeAddItemProperty(oGloves, ItemPropertyKeen(), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
        IPSafeAddItemProperty(oWeapon, iBleed, fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
    }
}
