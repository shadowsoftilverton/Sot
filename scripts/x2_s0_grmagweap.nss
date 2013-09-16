#include "nw_i0_spells"
#include "x2_i0_spells"
#include "x2_inc_spellhook"
#include "x2_inc_itemprop"
#include "engine"

void main()
{

    if(!X2PreSpellCastCode())
    {
        return;
    }

    object oTarget = GetSpellTargetObject();
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget);
    object oGloves = GetItemInSlot(INVENTORY_SLOT_ARMS, oTarget);
    int nWeapon = GetBaseItemType(oWeapon);
    int nGloves = GetBaseItemType(oGloves);
    effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nPower = nCasterLevel / 4;
    int nMetaMagic = GetMetaMagicFeat();

    if(nPower > 5)
    {
        nPower = 5;
    }

    if(nMetaMagic == METAMAGIC_EXTEND)
    {
        nCasterLevel = nCasterLevel * 2;
    }

    float fDuration = HoursToSeconds(nCasterLevel);

    //Melee weapon equipped: Enhancement bonus
    if(IPGetIsMeleeWeapon(oWeapon) == TRUE)
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oWeapon));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oWeapon), HoursToSeconds(nCasterLevel));
        IPSafeAddItemProperty(oWeapon, ItemPropertyEnhancementBonus(nPower), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
    }

    //Ranged weapon equipped: Attack and damage bonus
    else if(IPGetIsRangedWeapon(oWeapon) == TRUE)
    {
        //Sling: Bludgeoning
        if(nWeapon == BASE_ITEM_SLING)
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oWeapon), HoursToSeconds(nCasterLevel));
            IPSafeAddItemProperty(oWeapon, ItemPropertyAttackBonus(nPower), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            IPSafeAddItemProperty(oWeapon, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING, nPower), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
        }

        //Throwing Axe: Slashing
        else if(nWeapon == BASE_ITEM_THROWINGAXE)
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oWeapon), HoursToSeconds(nCasterLevel));
            IPSafeAddItemProperty(oWeapon, ItemPropertyAttackBonus(nPower), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            IPSafeAddItemProperty(oWeapon, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SLASHING, nPower), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
        }

        //Other ranged weapons: Piercing
        else
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oWeapon), HoursToSeconds(nCasterLevel));
            IPSafeAddItemProperty(oWeapon, ItemPropertyAttackBonus(nPower), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            IPSafeAddItemProperty(oWeapon, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING, nPower), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
        }
    }

    //No weapon but gloves equipped: Attack and damage bonus
    else if(oWeapon == OBJECT_INVALID && nGloves == BASE_ITEM_GLOVES)
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oGloves));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oGloves), HoursToSeconds(nCasterLevel));
        IPSafeAddItemProperty(oGloves, ItemPropertyAttackBonus(nPower), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
        IPSafeAddItemProperty(oGloves, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING, nPower), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
    }
}
