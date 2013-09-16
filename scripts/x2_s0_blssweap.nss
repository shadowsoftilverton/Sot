//Bless Weapon by Hardcore UFO
//Will apply properties to weapons depending on the type:
//Melee: +1 enhancement and divine damage vs. undead
//Ranged: +1 attack and +1 base damage type, and divine damage vs. undead
//Gloves: +1 attack and +1 bludgeoning damage, and divine damage vs. undead
//It will only apply to gloves if nothing is equipped in the weapon slot.
//The divine damage is 1d6 until level 16, then 2d4 after level 16.
//Can be empowered and maximized.
//Weapon glows a different color based on alignment.
//Lasts 1 turn per level.

#include "engine"
#include "nw_i0_spells"
#include "x2_i0_spells"
#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }

    //Alignment based glow type.
    object oTarget = GetSpellTargetObject();
    itemproperty iGlow;
    int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);

    if(nAlign = ALIGNMENT_GOOD)
    {
        iGlow = ItemPropertyVisualEffect(ITEM_VISUAL_HOLY);
    }

    else if(nAlign = ALIGNMENT_EVIL)
    {
        iGlow = ItemPropertyVisualEffect(ITEM_VISUAL_EVIL);
    }

    else if(nAlign = ALIGNMENT_NEUTRAL)
    {
        iGlow = ItemPropertyVisualEffect(ITEM_VISUAL_SONIC);
    }

    //Variables.
    effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nCL = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();

    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget);
    int nWeapon = GetBaseItemType(oWeapon);
    object oGloves = GetItemInSlot(INVENTORY_SLOT_ARMS, oTarget);
    int nGloves = GetBaseItemType(oGloves);

    //Baseline damage.
    itemproperty iDamage;
    int nDamage;

    if(nCL >= 1 && nCL <=16)
    {
        iDamage = ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD, IP_CONST_DAMAGETYPE_DIVINE, IP_CONST_DAMAGEBONUS_1d6); //Avg. 3.5
    }

    if(nCL >= 17)
    {
        iDamage = ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD, IP_CONST_DAMAGETYPE_DIVINE, IP_CONST_DAMAGEBONUS_2d6); //Avg. 7
    }

    //Metamagic conditions.
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
       nCL = nCL * 2;
    }

    if (nMetaMagic == METAMAGIC_EMPOWER)
    {
        if(nCL >= 1 && nCL <=16)
        {
            iDamage = ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD, IP_CONST_DAMAGETYPE_DIVINE, IP_CONST_DAMAGEBONUS_2d4); //Avg. 5
        }

        else if(nCL >= 17)
        {
            iDamage = ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD, IP_CONST_DAMAGETYPE_DIVINE, IP_CONST_DAMAGEBONUS_2d8); //Avg. 9
        }
    }

    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        if(nCL >= 1 && nCL <=16)
        {
            iDamage = ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD, IP_CONST_DAMAGETYPE_DIVINE, IP_CONST_DAMAGEBONUS_6);
        }

        else if(nCL >= 17)
        {
            iDamage = ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD, IP_CONST_DAMAGETYPE_DIVINE, 22);
        }
    }

    //Melee weapons.
    if(IPGetIsMeleeWeapon(oWeapon) == TRUE)
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oWeapon));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oWeapon), TurnsToSeconds(nCL));
        IPSafeAddItemProperty(oWeapon, ItemPropertyEnhancementBonus(1), TurnsToSeconds(nCL), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
        IPSafeAddItemProperty(oWeapon, iGlow, TurnsToSeconds(nCL), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
        IPSafeAddItemProperty(oWeapon, iDamage, TurnsToSeconds(nCL), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
    }

    //Ranged weapons.
    else if(IPGetIsRangedWeapon(oWeapon) == TRUE)
    {
        //Slings.
        if(nWeapon == BASE_ITEM_SLING)
        {
            object oBullet = GetItemInSlot(INVENTORY_SLOT_BULLETS, oTarget);

            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oWeapon), TurnsToSeconds(nCL));
            IPSafeAddItemProperty(oWeapon, ItemPropertyAttackBonus(1), TurnsToSeconds(nCL), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            IPSafeAddItemProperty(oWeapon, ItemPropertyDamageBonus(DAMAGE_TYPE_BLUDGEONING, 1), TurnsToSeconds(nCL), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            IPSafeAddItemProperty(oBullet, iGlow, TurnsToSeconds(nCL), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            IPSafeAddItemProperty(oWeapon, iDamage, TurnsToSeconds(nCL), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
        }

        //Throwing axes.
        else if(nWeapon == BASE_ITEM_THROWINGAXE)
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oWeapon), TurnsToSeconds(nCL));
            IPSafeAddItemProperty(oWeapon, ItemPropertyAttackBonus(1), TurnsToSeconds(nCL), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            IPSafeAddItemProperty(oWeapon, ItemPropertyDamageBonus(DAMAGE_TYPE_SLASHING, 1), TurnsToSeconds(nCL), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            IPSafeAddItemProperty(oWeapon, iGlow, TurnsToSeconds(nCL), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            IPSafeAddItemProperty(oWeapon, iDamage, TurnsToSeconds(nCL), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
        }

        //All other piercing ranged weapons (applies visuals to weapon, arrow, and bolt slots as a catch-all).
        else
        {
            object oArrow = GetItemInSlot(INVENTORY_SLOT_ARROWS, oTarget);
            object oBolt = GetItemInSlot(INVENTORY_SLOT_BOLTS, oTarget);

            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oWeapon));
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oWeapon), TurnsToSeconds(nCL));
            IPSafeAddItemProperty(oWeapon, ItemPropertyAttackBonus(1), TurnsToSeconds(nCL), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            IPSafeAddItemProperty(oWeapon, ItemPropertyDamageBonus(DAMAGE_TYPE_PIERCING, 1), TurnsToSeconds(nCL), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            IPSafeAddItemProperty(oBolt, iGlow, TurnsToSeconds(nCL), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            IPSafeAddItemProperty(oArrow, iGlow, TurnsToSeconds(nCL), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            IPSafeAddItemProperty(oWeapon, iGlow, TurnsToSeconds(nCL), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
            IPSafeAddItemProperty(oWeapon, iDamage, TurnsToSeconds(nCL), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
        }
    }

    //Gloves.
    else if(oWeapon == OBJECT_INVALID && nGloves == BASE_ITEM_GLOVES)
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oGloves));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oGloves), TurnsToSeconds(nCL));
        IPSafeAddItemProperty(oGloves, ItemPropertyAttackBonus(1), TurnsToSeconds(nCL), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
        IPSafeAddItemProperty(oGloves, ItemPropertyDamageBonus(DAMAGE_TYPE_BLUDGEONING, 1), TurnsToSeconds(nCL), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
        IPSafeAddItemProperty(oGloves, iDamage, TurnsToSeconds(nCL), X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
    }
}
