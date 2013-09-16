#include "engine"

#include "x2_inc_itemprop"
#include "inc_modalfeats"

/*  2011 - 11 - 09 - JJ
    Rewrite to utilize the IPGetDamageBonusConstantFromNumber() function*/

int GetWeaponDamageType(object oItem) {
    int nBT = GetBaseItemType(oItem);
    int nWeapon = StringToInt(Get2DAString("baseitems", "WeaponType", nBT));
    return nWeapon;
}

int GetWeaponSize(object oItem) {
    int nBT = GetBaseItemType(oItem);
    int nSize = StringToInt(Get2DAString("baseitems", "WeaponSize", nBT));
    return nSize;
}

void main()
{
    int nSpell = GetSpellId();
    object oTarget = GetSpellTargetObject();

    if(PowerAttackActive(oTarget)) {
       RemovePowerAttackEffect(oTarget);
    } else {
        FloatingTextStringOnCreature("*Power Attack Activated*", oTarget, FALSE);

        object oMainHandWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
        object oOffHandWeapon = GetItemInSlot(INVENTORY_SLOT_LEFTHAND);

        if(oMainHandWeapon != OBJECT_INVALID && IPGetIsRangedWeapon(oMainHandWeapon))
            return;

        int iPowerAttackMagnitude;

        if(nSpell == SPELL_POWERATTACK_1) iPowerAttackMagnitude = 1;
        else if(nSpell == SPELL_POWERATTACK_2) iPowerAttackMagnitude = 2;
        else if(nSpell == SPELL_POWERATTACK_3) iPowerAttackMagnitude = 3;
        else if(nSpell == SPELL_POWERATTACK_4) iPowerAttackMagnitude = 4;
        else if(nSpell == SPELL_POWERATTACK_5) iPowerAttackMagnitude = 5;
        else if(nSpell == SPELL_IMP_POWERATTACK_1) iPowerAttackMagnitude = 6;
        else if(nSpell == SPELL_IMP_POWERATTACK_2) iPowerAttackMagnitude = 7;
        else if(nSpell == SPELL_IMP_POWERATTACK_3) iPowerAttackMagnitude = 8;
        else if(nSpell == SPELL_IMP_POWERATTACK_4) iPowerAttackMagnitude = 9;
        else if(nSpell == SPELL_IMP_POWERATTACK_5) iPowerAttackMagnitude = 10;

        //11-09-2011 - JJ - Moved attack penalty prior to damage voodoo
        int iPenalty = iPowerAttackMagnitude;
        effect eAttackPenalty = EffectAttackDecrease(iPenalty);

        effect eDamageBonus;

        if((GetWeaponSize(oMainHandWeapon) > GetCreatureSize(oTarget)) || (GetWeaponSize(oMainHandWeapon) == GetCreatureSize(oTarget) && oOffHandWeapon == OBJECT_INVALID))
            iPowerAttackMagnitude *= 2;

        //Get the appropriate constant
        iPowerAttackMagnitude = IPGetDamageBonusConstantFromNumber(iPowerAttackMagnitude);

        if(oMainHandWeapon == OBJECT_INVALID || GetWeaponDamageType(oMainHandWeapon) == WEAPON_DAMAGE_TYPE_BLUDGEONING || GetWeaponDamageType(oMainHandWeapon) == WEAPON_DAMAGE_TYPE_BLUDGEONING_PIERCING)
            eDamageBonus = EffectDamageIncrease(iPowerAttackMagnitude, DAMAGE_TYPE_BLUDGEONING);
        else if(GetWeaponDamageType(oMainHandWeapon) == WEAPON_DAMAGE_TYPE_PIERCING)
            eDamageBonus = EffectDamageIncrease(iPowerAttackMagnitude, DAMAGE_TYPE_PIERCING);
        else if(GetWeaponDamageType(oMainHandWeapon) == WEAPON_DAMAGE_TYPE_SLASHING || GetWeaponDamageType(oMainHandWeapon) == WEAPON_DAMAGE_TYPE_PIERCING_SLASHING)
            eDamageBonus = EffectDamageIncrease(iPowerAttackMagnitude, DAMAGE_TYPE_SLASHING);

        effect eLink = EffectLinkEffects(eDamageBonus, eAttackPenalty);
        eLink = SupernaturalEffect(eLink);

        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget);
    }
}
