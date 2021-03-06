//Darkfire by Hardcore UFO
//Will apply scaling fire damage based on level to a weapon as a temporary property.
//Will remove existing Darkfire and Elemental Weapon effects on the weapon.
//Will work on all weapons and gloves.
//Gloves are targeted if nothing is equipped in the main hand.
//Can be empowered and maximized.
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

    effect eVis = EffectVisualEffect(VFX_IMP_PULSE_NEGATIVE);
    effect eFlame = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    itemproperty iGlow = ItemPropertyVisualEffect(ITEM_VISUAL_EVIL);
    eVis = EffectLinkEffects(eFlame, eVis);
    int nCL = GetCasterLevel(OBJECT_SELF);
    object oTarget = GetSpellTargetObject();
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    int nDamage2;

    if(nCL > 0 && nCL <= 5)
    {
        nDamage = IP_CONST_DAMAGEBONUS_2;
        nDamage2 = IP_CONST_DAMAGEBONUS_1;
    }

    else if(nCL >= 6 && nCL <= 10)
    {
        nDamage = IP_CONST_DAMAGEBONUS_1d4;
        nDamage2 = IP_CONST_DAMAGEBONUS_1;
    }

    else if(nCL >= 11 && nCL <= 15)
    {
        nDamage = IP_CONST_DAMAGEBONUS_1d4;
        nDamage2 = IP_CONST_DAMAGEBONUS_2;
    }

    else if(nCL >= 16 && nCL <= 20)
    {
        nDamage = IP_CONST_DAMAGEBONUS_1d4;
        nDamage2 = IP_CONST_DAMAGEBONUS_1d4;
    }

    else if(nCL >= 21 && nCL <=25)
    {
        nDamage = IP_CONST_DAMAGEBONUS_1d6;
        nDamage2 = IP_CONST_DAMAGEBONUS_1d4;
    }
    else if(nCL >=26)
    {
        nDamage = IP_CONST_DAMAGEBONUS_1d6;
        nDamage2 = IP_CONST_DAMAGEBONUS_1d6;
    }

    //Metamagic conditions

    if(nMetaMagic == METAMAGIC_EMPOWER)
        {
            if(nCL > 0 && nCL <= 5)
        {
            nDamage = IP_CONST_DAMAGEBONUS_1d4;
            nDamage2 = IP_CONST_DAMAGEBONUS_1;
        }

        else if(nCL >= 6 && nCL <= 10)
        {
            nDamage = IP_CONST_DAMAGEBONUS_1d6;
            nDamage2 = IP_CONST_DAMAGEBONUS_1;
        }

        else if(nCL >= 11 && nCL <= 15)
        {
            nDamage = IP_CONST_DAMAGEBONUS_1d6;
            nDamage2 = IP_CONST_DAMAGEBONUS_2;
        }

        else if(nCL >= 16 && nCL <= 20)
        {
            nDamage = IP_CONST_DAMAGEBONUS_1d6;
            nDamage2 = IP_CONST_DAMAGEBONUS_1d6;
        }

        else if(nCL >= 21 && nCL <=25)
        {
            nDamage = IP_CONST_DAMAGEBONUS_1d8;
            nDamage2 = IP_CONST_DAMAGEBONUS_1d6;
        }
        else if(nCL >=26)
        {
            nDamage = IP_CONST_DAMAGEBONUS_1d8;
            nDamage2 = IP_CONST_DAMAGEBONUS_1d8;
        }
    }

    else if(nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        if(nCL > 0 && nCL <= 5)
        {
            nDamage = IP_CONST_DAMAGEBONUS_2;
            nDamage2 = IP_CONST_DAMAGEBONUS_1;
        }

        else if(nCL >= 6 && nCL <= 10)
        {
            nDamage = IP_CONST_DAMAGEBONUS_4;
            nDamage2 = IP_CONST_DAMAGEBONUS_1;
        }

        else if(nCL >= 11 && nCL <= 15)
        {
            nDamage = IP_CONST_DAMAGEBONUS_4;
            nDamage2 = IP_CONST_DAMAGEBONUS_2;
        }

        else if(nCL >= 16 && nCL <= 20)
        {
            nDamage = IP_CONST_DAMAGEBONUS_4;
            nDamage2 = IP_CONST_DAMAGEBONUS_4;
        }

        else if(nCL >= 21 && nCL <=25)
        {
            nDamage = IP_CONST_DAMAGEBONUS_6;
            nDamage2 = IP_CONST_DAMAGEBONUS_4;
        }
        else if(nCL >=26)
        {
            nDamage = IP_CONST_DAMAGEBONUS_6;
            nDamage2 = IP_CONST_DAMAGEBONUS_6;
        }
    }

    else if(nMetaMagic == METAMAGIC_EXTEND)
    {
        nCL = nCL * 2;
    }

    //Weapon definition.
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget);
    int nWeapon = GetBaseItemType(oWeapon);
    object oGloves = GetItemInSlot(INVENTORY_SLOT_ARMS, oTarget);
    int nGloves = GetBaseItemType(oGloves);

    itemproperty iDamage = ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_COLD, nDamage);
    itemproperty iDamage2= ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_NEGATIVE, nDamage2);

    //Spell conflict definition.
    //Will check for Elemental Weapon and Darkfire and remove existing effects.
    if(GetHasSpellEffect(852, oWeapon) == TRUE
    || GetHasSpellEffect(853, oWeapon) == TRUE
    || GetHasSpellEffect(854, oWeapon) == TRUE
    || GetHasSpellEffect(855, oWeapon) == TRUE
    || GetHasSpellEffect(548, oWeapon) == TRUE
    || GetHasSpellEffect(999, oWeapon) == TRUE
    || GetHasSpellEffect(998, oWeapon) == TRUE)
    {
        RemoveSpellEffects(852, OBJECT_SELF, oWeapon);
        RemoveSpellEffects(853, OBJECT_SELF, oWeapon);
        RemoveSpellEffects(854, OBJECT_SELF, oWeapon);
        RemoveSpellEffects(855, OBJECT_SELF, oWeapon);
        RemoveSpellEffects(548, OBJECT_SELF, oWeapon);
        RemoveSpellEffects(999, OBJECT_SELF, oWeapon);
        RemoveSpellEffects(998, OBJECT_SELF, oWeapon);
    }

    if(GetHasSpellEffect(852, oGloves) == TRUE
    || GetHasSpellEffect(853, oGloves) == TRUE
    || GetHasSpellEffect(854, oGloves) == TRUE
    || GetHasSpellEffect(855, oGloves) == TRUE
    || GetHasSpellEffect(548, oGloves) == TRUE
    || GetHasSpellEffect(999, oGloves) == TRUE
    || GetHasSpellEffect(998, oGloves) == TRUE)
    {
        RemoveSpellEffects(852, OBJECT_SELF, oGloves);
        RemoveSpellEffects(853, OBJECT_SELF, oGloves);
        RemoveSpellEffects(854, OBJECT_SELF, oGloves);
        RemoveSpellEffects(855, OBJECT_SELF, oGloves);
        RemoveSpellEffects(548, OBJECT_SELF, oGloves);
        RemoveSpellEffects(999, OBJECT_SELF, oGloves);
        RemoveSpellEffects(998, OBJECT_SELF, oGloves);
    }

    //Melee weapons.
    if(IPGetIsMeleeWeapon(oWeapon) == TRUE)
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oWeapon));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oWeapon), TurnsToSeconds(nCL));
        IPSafeAddItemProperty(oWeapon, iGlow, TurnsToSeconds(nCL), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
        IPSafeAddItemProperty(oWeapon, iDamage, TurnsToSeconds(nCL), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
        IPSafeAddItemProperty(oWeapon, iDamage2, TurnsToSeconds(nCL), X2_IP_ADDPROP_POLICY_IGNORE_EXISTING, FALSE, TRUE);
    }

    //Ranged weapons. Applies visual to Arrow, Bolt, Bullet, and Weapon slots as a catch-all.
    //Will fail to fire if there is no ammunition equipped for the type of weapon equipped.
    else if(IPGetIsRangedWeapon(oWeapon) == TRUE)
    {
        object oArrow = GetItemInSlot(INVENTORY_SLOT_ARROWS, oTarget);
        object oBolt = GetItemInSlot(INVENTORY_SLOT_BOLTS, oTarget);
        object oBullet = GetItemInSlot(INVENTORY_SLOT_BULLETS, oTarget);

        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oWeapon));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oWeapon), TurnsToSeconds(nCL));
        IPSafeAddItemProperty(oBolt, iGlow, TurnsToSeconds(nCL), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
        IPSafeAddItemProperty(oArrow, iGlow, TurnsToSeconds(nCL), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
        IPSafeAddItemProperty(oBullet, iGlow, TurnsToSeconds(nCL), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
        IPSafeAddItemProperty(oWeapon, iGlow, TurnsToSeconds(nCL), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
        IPSafeAddItemProperty(oWeapon, iDamage, TurnsToSeconds(nCL), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
        IPSafeAddItemProperty(oWeapon, iDamage2, TurnsToSeconds(nCL), X2_IP_ADDPROP_POLICY_IGNORE_EXISTING, FALSE, TRUE);
    }

    //Gloves.
    else if(oWeapon == OBJECT_INVALID && nGloves == BASE_ITEM_GLOVES)
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oGloves));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oGloves), TurnsToSeconds(nCL));
        IPSafeAddItemProperty(oGloves, iDamage, TurnsToSeconds(nCL), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
        IPSafeAddItemProperty(oGloves, iDamage2, TurnsToSeconds(nCL), X2_IP_ADDPROP_POLICY_IGNORE_EXISTING, FALSE, TRUE);
    }
}
