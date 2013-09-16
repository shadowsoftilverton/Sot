#include "engine"

#include "x2_inc_itemprop"

#include "inc_loot_names"
#include "inc_ilr"

//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// DECLARATION
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

int RandomizeLevel(int nLevel);

// ACCESSORIES

void AddAmuletPropPrimary(object oItem, int nLevel, int nMagical);
void AddAmuletPropSecondary(object oItem, int nLevel, int nMagical);

void AddBeltPropPrimary(object oItem, int nLevel, int nMagical);
void AddBeltPropSecondary(object oItem, int nLevel, int nMagical);

void AddBootsPropPrimary(object oItem, int nLevel, int nMagical);
void AddBootsPropSecondary(object oItem, int nLevel, int nMagical);

void AddBracersPropPrimary(object oItem, int nLevel, int nMagical);
void AddBracersPropSecondary(object oItem, int nLevel, int nMagical);

void AddGlovesPropPrimary(object oItem, int nLevel, int nMagical);
void AddGlovesPropSecondary(object oItem, int nLevel, int nMagical);

void AddCloakPropPrimary(object oItem, int nLevel, int nMagical);
void AddCloakPropSecondary(object oItem, int nLevel, int nMagical);

void AddRingPropPrimary(object oItem, int nLevel, int nMagical);
void AddRingPropSecondary(object oItem, int nLevel, int nMagical);

// AMMO

void AddAmmoPropPrimary(object oItem, int nLevel, int nMagical);
void AddAmmoPropSecondary(object oItem, int nLevel, int nMagical);

// ARMOR

void AddHelmPropPrimary(object oItem, int nLevel, int nMagical);
void AddHelmPropSecondary(object oItem, int nLevel, int nMagical);

void AddArmorPropPrimary(object oItem, int nLevel, int nMagical);
void AddArmorPropSecondary(object oItem, int nLevel, int nMagical);

void AddShieldPropPrimary(object oItem, int nLevel, int nWood, int nMagical);
void AddShieldPropSecondary(object oItem, int nLevel, int nMagical);

// WEAPONS

void AddMeleePropPrimary(object oItem, int nLevel, int nMagical, int nWood=FALSE);
void AddMeleePropSecondary(object oItem, int nLevel, int nMagical);

void AddRangedPropPrimary(object oItem, int nLevel, int nMagical);
void AddRangedPropSecondary(object oItem, int nLevel, int nMagical);

//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

// Generates a random Ability Bonus property.
// ===========================
// - nLevel: The item's enhancement level, between 1 - 5.
// - nAbility: The ability to be enhanced. Will pick random ability if not set.
void AddRandomAbilityBonus(object oItem, int nLevel, int nAbility=-1);

void AddRandomACBonus(object oItem, int nLevel);

void AddRandomACBonusVsAlign(object oItem, int nLevel, int nAlign=-1);

void AddRandomACBonusVsDmgType(object oItem, int nLevel, int nType=-1);

void AddRandomACBonusVsRace(object oItem, int nLevel, int nRace=-1);

void AddRandomAttackBonus(object oItem, int nLevel);

void AddRandomAttackBonusVsAlign(object oItem, int nLevel, int nAlign=-1);

void AddRandomAttackBonusVsRace(object oItem, int nLevel, int nRace=-1);

void AddRandomAttackPenalty(object oItem, int nLevel);

void AddRandomBonusLevelSpell(object oItem, int nLevel, int nClass=-1);

void AddRandomBonusSavingThrow(object oItem, int nLevel, int nSave=-1);

void AddRandomBonusSavingThrowVsX(object oItem, int nLevel, int nType=-1);

void AddRandomBonusSpellResistance(object oItem, int nLevel);

void AddRandomContainerReducedWeight(object oItem, int nLevel);

void AddRandomDamageBonus(object oItem, int nLevel, int nType=-1);

void AddRandomDamageBonusVsAlign(object oItem, int nLevel, int nType=-1, int nAlign=-1);

void AddRandomDamageBonusVsRace(object oItem, int nLevel, int nType=-1, int nRace=-1);

void AddRandomDamageImmunity(object oItem, int nLevel, int nType=-1);

void AddRandomDamagePenalty(object oItem, int nLevel);

void AddRandomDamageReduction(object oItem, int nLevel);

void AddRandomDamageResistance(object oItem, int nLevel, int nType=-1);

void AddRandomDamageVulnerability(object oItem, int nLevel, int nType=-1);

void AddRandomDecreaseAbility(object oItem, int nLevel, int nAbility=-1);

void AddRandomDecreaseAC(object oItem, int nLevel);

void AddRandomEnhancementBonus(object oItem, int nLevel);

void AddRandomEnhancementBonusVsAlign(object oItem, int nLevel, int nAlign=-1);

void AddRandomEnhancementBonusVsRace(object oItem, int nLevel, int nRace=-1);

void AddRandomEnhancementPenalty(object oItem, int nLevel);

void AddRandomExtraMeleeDamageType(object oItem);

void AddRandomExtraRangeDamageType(object oItem);

void AddRandomMighty(object oItem, int nLevel);

// Generates a random Light property.
// ===========================
// - nLevel: The item's enhancement level, between 1 - 5.
void AddRandomLight(object oItem, int nLevel);

void AddRandomLimitUseByAlign(object oItem);

void AddRandomLimitUseByClass(object oItem);

void AddRandomLimitUseByRace(object oItem);

void AddRandomMassiveCritical(object oItem, int nLevel);

void AddRandomMaxRangeStrengthMod(object oItem, int nLevel);

void AddRandomReducedSavingThrow(object oItem, int nLevel, int nSave=-1);

void AddRandomReducedSavingThrowVsX(object oItem, int nLevel, int nType=-1);

void AddRandomRegeneration(object oItem, int nLevel);

void AddRandomSkillBonus(object oItem, int nLevel);

void AddRandomUnlimitedAmmo(object oItem, int nLevel, int nType=-1);

void AddRandomVampiricRegeneration(object oItem, int nLevel);

void AddRandomWeightIncrease(object oItem, int nLevel);

void AddRandomKeen(object oItem);

// Generates a random Weight Reduction property.
// ===========================
// - nLevel: The item's enhancement level, between 1 - 5.
void AddRandomWeightReduction(object oItem, int nLevel);

// Generates a random OnHit property appropriate to
// the level range of the item
// ===========================
// - nLevel: The item's enhancement level, between 1 - 5.
void AddRandomOnHit(object oItem, int nLevel);

//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

int GetRandomAbility();

int GetRandomAlignment();

int GetRandomClass();

int GetRandomDamageType(int nPhysicalOnly=FALSE);

int GetRandomRace(int nPlayableOnly=FALSE);

int GetRandomSave();

int GetRandomSaveVs();

//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// IMPLEMENTATION
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

//Adjusts loot quality to center around the current tier and occasionally
//veer into adjacent tiers.
//Edit by Invictus - cap at nLevel-1 and nLevel+1
//Previously: Gaussian distribution centered around nLevel.
//Edited by Hardcore UFO: changed iterances in functions to not include (nLevel-1)+1;
//+1 from the limit set in the specific property is now rarer (8.3%).
int AveRandomizeLevel(int nLevel) {
    int nRandom = Random(12);

    switch(nRandom) {
        case 0: case 1: nLevel--; break;
        case 2: case 3:
        case 4: case 5:
        case 6: case 7:
        case 8: case 9:
        case 10: break;
        case 11: nLevel++; break;
        default: break;
    }

    return nLevel;
}

int RandomizeLevel(int nLevel){
    nLevel = nLevel - 1;

    int nRoll = d100();

         if(nRoll > 80) nLevel += 1;
    else if(nRoll < 20) nLevel -= 1;

    if(nLevel < 0) nLevel = 0;

    return nLevel;
}

// ACCESSORIES
void AddAmuletPropPrimary(object oItem, int nLevel, int nMagical){
}

const int AMULET_NUM_SECONDARIES = 9;
const int AMULET_NUM_SECONDARIES_MAGICAL = 7;

void AddAmuletPropSecondary(object oItem, int nLevel, int nMagical){
    int nSelect = AMULET_NUM_SECONDARIES;
    if(nMagical) nSelect += AMULET_NUM_SECONDARIES_MAGICAL;

    nSelect = Random(nSelect);

    switch(nSelect){
        case 0:  AddRandomBonusSavingThrow(oItem, nLevel);       break;
        case 1:  AddRandomBonusSavingThrowVsX(oItem, nLevel);    break;
        case 2:  AddRandomACBonusVsDmgType(oItem, nLevel);       break;
        case 3:  /*AddRandomWeightReduction(oItem, nLevel); */       break;
        case 4:  AddRandomAbilityBonus(oItem, nLevel);           break;
        case 5:  AddRandomBonusLevelSpell(oItem, nLevel);        break;
        case 6:  AddRandomACBonus(oItem, nLevel);                break;
        case 7:  AddRandomRegeneration(oItem, nLevel);           break;
        case 8:  AddRandomSkillBonus(oItem, nLevel);             break;

        case 9:  AddRandomDamageImmunity(oItem, nLevel);         break;
        case 10: AddRandomDamageReduction(oItem, nLevel);        break;
        case 11: AddRandomDamageResistance(oItem, nLevel);       break;
        case 12: /*AddRandomACBonusVsAlign(oItem, nLevel); */        break;
        case 13: /*AddRandomACBonusVsRace(oItem, nLevel); */         break;
        case 14: AddRandomBonusSpellResistance(oItem, nLevel);   break;
        case 15: AddRandomLight(oItem, nLevel);                  break;
    }
}

void AddBeltPropPrimary(object oItem, int nLevel, int nMagical){
}

const int BELT_NUM_SECONDARIES = 9;
const int BELT_NUM_SECONDARIES_MAGICAL = 7;

void AddBeltPropSecondary(object oItem, int nLevel, int nMagical){
    int nSelect = BELT_NUM_SECONDARIES;
    if(nMagical) nSelect += BELT_NUM_SECONDARIES_MAGICAL;

    nSelect = Random(nSelect);

    switch(nSelect){
        case 0:  AddRandomBonusSavingThrow(oItem, nLevel);       break;
        case 1:  AddRandomBonusSavingThrowVsX(oItem, nLevel);    break;
        case 2:  AddRandomACBonusVsDmgType(oItem, nLevel);       break;
        case 3:  /*AddRandomWeightReduction(oItem, nLevel);*/        break;
        case 4:  AddRandomAbilityBonus(oItem, nLevel);           break;
        case 5:  AddRandomBonusLevelSpell(oItem, nLevel);        break;
        case 6:  AddRandomACBonus(oItem, nLevel);                break;
        case 7:  AddRandomRegeneration(oItem, nLevel);           break;
        case 8:  /*AddRandomSkillBonus(oItem, nLevel); */            break;

        case 9:  AddRandomDamageImmunity(oItem, nLevel);         break;
        case 10: AddRandomDamageReduction(oItem, nLevel);        break;
        case 11: AddRandomDamageResistance(oItem, nLevel);       break;
        case 12: /*AddRandomACBonusVsAlign(oItem, nLevel);*/         break;
        case 13: /*AddRandomACBonusVsRace(oItem, nLevel);*/          break;
        case 14: AddRandomBonusSpellResistance(oItem, nLevel);   break;
        case 15: AddRandomLight(oItem, nLevel);                  break;
    }
}

void AddBootsPropPrimary(object oItem, int nLevel, int nMagical){
}

const int BOOTS_NUM_SECONDARIES = 9;
const int BOOTS_NUM_SECONDARIES_MAGICAL = 7;

void AddBootsPropSecondary(object oItem, int nLevel, int nMagical){
    int nSelect = BOOTS_NUM_SECONDARIES;
    if(nMagical) nSelect += BOOTS_NUM_SECONDARIES_MAGICAL;

    nSelect = Random(nSelect);

    switch(nSelect){
        case 0:  AddRandomBonusSavingThrow(oItem, nLevel);       break;
        case 1:  AddRandomBonusSavingThrowVsX(oItem, nLevel);    break;
        case 2:  AddRandomACBonusVsDmgType(oItem, nLevel);       break;
        case 3:  /*AddRandomWeightReduction(oItem, nLevel);*/        break;
        case 4:  AddRandomAbilityBonus(oItem, nLevel);           break;
        case 5:  AddRandomBonusLevelSpell(oItem, nLevel);        break;
        case 6:  AddRandomACBonus(oItem, nLevel);                break;
        case 7:  AddRandomRegeneration(oItem, nLevel);           break;
        case 8:  /*AddRandomSkillBonus(oItem, nLevel); */            break;

        case 9:  AddRandomDamageImmunity(oItem, nLevel);         break;
        case 10: AddRandomDamageReduction(oItem, nLevel);        break;
        case 11: AddRandomDamageResistance(oItem, nLevel);       break;
        case 12: /*AddRandomACBonusVsAlign(oItem, nLevel); */        break;
        case 13: /*AddRandomACBonusVsRace(oItem, nLevel); */         break;
        case 14: AddRandomBonusSpellResistance(oItem, nLevel);   break;
        case 15: AddRandomLight(oItem, nLevel);                  break;
    }
}

void AddBracersPropPrimary(object oItem, int nLevel, int nMagical){
}

const int BRACERS_NUM_SECONDARIES = 9;
const int BRACERS_NUM_SECONDARIES_MAGICAL = 7;

void AddBracersPropSecondary(object oItem, int nLevel, int nMagical) {
    int nSelect = BRACERS_NUM_SECONDARIES;
    if(nMagical) nSelect += BRACERS_NUM_SECONDARIES_MAGICAL;

    nSelect = Random(nSelect);

    switch(nSelect){
        case 0:  AddRandomBonusSavingThrow(oItem, nLevel);       break;
        case 1:  AddRandomBonusSavingThrowVsX(oItem, nLevel);    break;
        case 2:  AddRandomACBonusVsDmgType(oItem, nLevel);       break;
        case 3:  /*AddRandomWeightReduction(oItem, nLevel);*/        break;
        case 4:  AddRandomAbilityBonus(oItem, nLevel);           break;
        case 5:  AddRandomBonusLevelSpell(oItem, nLevel);        break;
        case 6:  AddRandomACBonus(oItem, nLevel);                break;
        case 7:  AddRandomRegeneration(oItem, nLevel);           break;
        case 8:  AddRandomSkillBonus(oItem, nLevel);             break;

        case 9:  AddRandomDamageImmunity(oItem, nLevel);         break;
        case 10: AddRandomDamageReduction(oItem, nLevel);        break;
        case 11: AddRandomDamageResistance(oItem, nLevel);       break;
        case 12: /*AddRandomACBonusVsAlign(oItem, nLevel); */        break;
        case 13: /*AddRandomACBonusVsRace(oItem, nLevel);  */        break;
        case 14: AddRandomBonusSpellResistance(oItem, nLevel);   break;
        case 15: AddRandomLight(oItem, nLevel);                  break;
    }
}

void AddGlovesPropPrimary(object oItem, int nLevel, int nMagical){
}

const int GLOVES_NUM_SECONDARIES = 12;
const int GLOVES_NUM_SECONDARIES_MAGICAL = 7;

void AddGlovesPropSecondary(object oItem, int nLevel, int nMagical) {
    int nSelect = GLOVES_NUM_SECONDARIES;
    if(nMagical) nSelect += GLOVES_NUM_SECONDARIES_MAGICAL;

    nSelect = Random(nSelect);

    switch(nSelect){
        case 0:  AddRandomBonusSavingThrow(oItem, nLevel);       break;
        case 1:  AddRandomBonusSavingThrowVsX(oItem, nLevel);    break;
        case 2:  /*AddRandomACBonusVsDmgType(oItem, nLevel); */      break;
        case 3:  /*AddRandomWeightReduction(oItem, nLevel); */       break;
        case 4:  AddRandomAbilityBonus(oItem, nLevel);           break;
        case 5:  AddRandomBonusLevelSpell(oItem, nLevel);        break;
        case 6:  AddRandomACBonus(oItem, nLevel);                break;
        case 7:  AddRandomRegeneration(oItem, nLevel);           break;
        case 8:  AddRandomAttackBonus(oItem, nLevel);            break;
        case 9:  AddRandomDamageBonus(oItem, nLevel);            break;
        case 10: AddRandomOnHit(oItem, nLevel);                  break;
        case 11: AddRandomSkillBonus(oItem, nLevel);             break;

        case 12: AddRandomDamageImmunity(oItem, nLevel);         break;
        case 13: AddRandomDamageReduction(oItem, nLevel);        break;
        case 14: AddRandomDamageResistance(oItem, nLevel);       break;
        case 15: /*AddRandomACBonusVsAlign(oItem, nLevel); */        break;
        case 16: /*AddRandomACBonusVsRace(oItem, nLevel);  */        break;
        case 17: AddRandomBonusSpellResistance(oItem, nLevel);   break;
        case 18: AddRandomLight(oItem, nLevel);                  break;
    }
}

void AddCloakPropPrimary(object oItem, int nLevel, int nMagical){
}

const int CLOAK_NUM_SECONDARIES = 9;
const int CLOAK_NUM_SECONDARIES_MAGICAL = 7;

void AddCloakPropSecondary(object oItem, int nLevel, int nMagical){
    int nSelect = CLOAK_NUM_SECONDARIES;
    if(nMagical) nSelect += CLOAK_NUM_SECONDARIES_MAGICAL;

    nSelect = Random(nSelect);

    switch(nSelect){
        case 0:  AddRandomBonusSavingThrow(oItem, nLevel);       break;
        case 1:  AddRandomBonusSavingThrowVsX(oItem, nLevel);    break;
        case 2:  AddRandomACBonusVsDmgType(oItem, nLevel);       break;
        case 3:  /*AddRandomWeightReduction(oItem, nLevel); */       break;
        case 4:  AddRandomAbilityBonus(oItem, nLevel);           break;
        case 5:  AddRandomBonusLevelSpell(oItem, nLevel);        break;
        case 6:  AddRandomACBonus(oItem, nLevel);                break;
        case 7:  AddRandomRegeneration(oItem, nLevel);           break;
        case 8:  /*AddRandomSkillBonus(oItem, nLevel); */            break;

        case 9:  AddRandomDamageImmunity(oItem, nLevel);         break;
        case 10: AddRandomDamageReduction(oItem, nLevel);        break;
        case 11: AddRandomDamageResistance(oItem, nLevel);       break;
        case 12: /*AddRandomACBonusVsAlign(oItem, nLevel); */        break;
        case 13: /*AddRandomACBonusVsRace(oItem, nLevel); */         break;
        case 14: AddRandomBonusSpellResistance(oItem, nLevel);   break;
        case 15: AddRandomLight(oItem, nLevel);                  break;
    }
}

void AddRingPropPrimary(object oItem, int nLevel, int nMagical){
}

const int RING_NUM_SECONDARIES = 9;
const int RING_NUM_SECONDARIES_MAGICAL = 7;

void AddRingPropSecondary(object oItem, int nLevel, int nMagical){
    int nSelect = RING_NUM_SECONDARIES;
    if(nMagical) nSelect += RING_NUM_SECONDARIES_MAGICAL;

    nSelect = Random(nSelect);

    switch(nSelect){
        case 0:  AddRandomBonusSavingThrow(oItem, nLevel);       break;
        case 1:  AddRandomBonusSavingThrowVsX(oItem, nLevel);    break;
        case 2:  AddRandomACBonusVsDmgType(oItem, nLevel);       break;
        case 3:  /*AddRandomWeightReduction(oItem, nLevel);*/        break;
        case 4:  AddRandomAbilityBonus(oItem, nLevel);           break;
        case 5:  AddRandomBonusLevelSpell(oItem, nLevel);        break;
        case 6:  AddRandomACBonus(oItem, nLevel);                break;
        case 7:  AddRandomRegeneration(oItem, nLevel);           break;
        case 8:  AddRandomSkillBonus(oItem, nLevel);             break;

        case 9:  AddRandomDamageImmunity(oItem, nLevel);         break;
        case 10: AddRandomDamageReduction(oItem, nLevel);        break;
        case 11: AddRandomDamageResistance(oItem, nLevel);       break;
        case 12: /*AddRandomACBonusVsAlign(oItem, nLevel); */        break;
        case 13: /*AddRandomACBonusVsRace(oItem, nLevel); */         break;
        case 14: AddRandomBonusSpellResistance(oItem, nLevel);   break;
        case 15: AddRandomLight(oItem, nLevel);                  break;
    }
}

// AMMO
void AddAmmoPropPrimary(object oItem, int nLevel, int nMagical){
    nLevel = AveRandomizeLevel(nLevel);

    SetItemNameMaterial(oItem, GetRandomMetalWeaponName(nLevel));

    if(nLevel > 0) {
        IPSafeAddItemProperty(oItem, ItemPropertyAttackBonus(nLevel));
        DoAddILRtoItem(oItem, nLevel);
    }
}

const int AMMO_NUM_SECONDARIES = 3;
const int AMMO_NUM_SECONDARIES_MAGICAL = 4;

void AddAmmoPropSecondary(object oItem, int nLevel, int nMagical){
    int nSelect = AMMO_NUM_SECONDARIES;
    if(nMagical) nSelect += AMMO_NUM_SECONDARIES_MAGICAL;

    nSelect = Random(nSelect);

    switch(nSelect){
        case 0: AddRandomDamageBonus(oItem, nLevel);            break;
        case 1: AddRandomExtraRangeDamageType(oItem);           break;
        case 2: AddRandomOnHit(oItem, nLevel);                  break;

        case 3: AddRandomAttackBonusVsAlign(oItem, nLevel);     break;
        case 4: AddRandomAttackBonusVsRace(oItem, nLevel);      break;
        case 5: AddRandomDamageBonusVsAlign(oItem, nLevel);     break;
        case 6: AddRandomDamageBonusVsRace(oItem, nLevel);      break;
    }
}

// ARMOR
void AddArmorPropPrimary(object oItem, int nLevel, int nMagical){

    if(nLevel > 3) nLevel = 3;
    nLevel = AveRandomizeLevel(nLevel);
    if(nLevel > 0) {
        IPSafeAddItemProperty(oItem, ItemPropertyACBonus(nLevel));
        DoAddILRtoItem(oItem, nLevel);
    }

    if(GetBaseACValue(oItem) == 0){
        SetItemNameMaterial(oItem, GetRandomClothArmorName(nLevel));
    } else if(GetBaseACValue(oItem) < 4){
        SetItemNameMaterial(oItem, GetRandomLeatherArmorName(nLevel));
    } else{
        SetItemNameMaterial(oItem, GetRandomMetalArmorName(nLevel));
    }
}

const int ARMOR_NUM_SECONDARIES = 8;
const int ARMOR_NUM_SECONDARIES_MAGICAL = 6;

void AddArmorPropSecondary(object oItem, int nLevel, int nMagical) {
    int nSelect = ARMOR_NUM_SECONDARIES;
    if(nMagical) nSelect += ARMOR_NUM_SECONDARIES_MAGICAL;

    nSelect = Random(nSelect);

    switch(nSelect) {
        case 0:  AddRandomBonusSavingThrow(oItem, nLevel);       break;
        case 1:  AddRandomBonusSavingThrowVsX(oItem, nLevel);    break;
        case 2:  AddRandomACBonusVsDmgType(oItem, nLevel);       break;
        case 3:  AddRandomRegeneration(oItem, nLevel);           break;
        case 4:  AddRandomBonusSpellResistance(oItem, nLevel);   break;
        case 5:  AddRandomWeightReduction(oItem, nLevel);        break;
        case 6:  AddRandomAbilityBonus(oItem, nLevel);           break;
        case 7:  AddRandomSkillBonus(oItem, nLevel);             break;

        case 8:  AddRandomDamageImmunity(oItem, nLevel);         break;
        case 9:  AddRandomDamageReduction(oItem, nLevel);        break;
        case 10: AddRandomDamageResistance(oItem, nLevel);       break;
        case 11: AddRandomACBonusVsAlign(oItem, nLevel);         break;
        case 12: AddRandomACBonusVsRace(oItem, nLevel);          break;
        case 13: AddRandomLight(oItem, nLevel);                  break;
    }
}

//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// HELM
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

void AddHelmPropPrimary(object oItem, int nLevel, int nMagical){

    if(nLevel > 3) nLevel = 3;
    nLevel = AveRandomizeLevel(nLevel);
    if(nLevel > 0) {
        IPSafeAddItemProperty(oItem, ItemPropertyACBonus(nLevel));
        DoAddILRtoItem(oItem, nLevel);
    }

    SetItemNameMaterial(oItem, GetRandomMetalArmorName(nLevel));
}

const int HELM_NUM_SECONDARIES = 7;
const int HELM_NUM_SECONDARIES_MAGICAL = 7;

void AddHelmPropSecondary(object oItem, int nLevel, int nMagical){
    int nSelect = HELM_NUM_SECONDARIES;
    if(nMagical) nSelect += HELM_NUM_SECONDARIES_MAGICAL;

    nSelect = Random(nSelect);

    switch(nSelect) {
        case 0:  AddRandomBonusSavingThrow(oItem, nLevel);       break;
        case 1:  AddRandomBonusSavingThrowVsX(oItem, nLevel);    break;
        case 2:  AddRandomACBonusVsDmgType(oItem, nLevel);       break;
        case 3:  AddRandomRegeneration(oItem, nLevel);           break;
        case 4:  AddRandomBonusSpellResistance(oItem, nLevel);   break;
        case 5:  AddRandomAbilityBonus(oItem, nLevel);           break;
        case 6:  /*AddRandomSkillBonus(oItem, nLevel); */            break;

        case 7:  AddRandomDamageImmunity(oItem, nLevel);         break;
        case 8:  AddRandomDamageReduction(oItem, nLevel);        break;
        case 9:  AddRandomDamageResistance(oItem, nLevel);       break;
        case 10: AddRandomWeightReduction(oItem, nLevel);        break;
        case 11: AddRandomACBonusVsAlign(oItem, nLevel);         break;
        case 12: AddRandomACBonusVsRace(oItem, nLevel);          break;
        case 13: AddRandomLight(oItem, nLevel);                  break;
    }
}

//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

// MELEE
void AddMeleePropPrimary(object oItem, int nLevel, int nMagical, int nWood=FALSE) {
    nLevel = AveRandomizeLevel(nLevel);

    if(nLevel > 0) {
        IPSafeAddItemProperty(oItem, ItemPropertyAttackBonus(nLevel));
        DoAddILRtoItem(oItem, nLevel);
    }

    SetItemNameMaterial(oItem, GetRandomMetalWeaponName(nLevel));
}

const int MELEE_NUM_SECONDARIES = 23;
const int MELEE_NUM_SECONDARIES_MAGICAL = 8;

void AddMeleePropSecondary(object oItem, int nLevel, int nMagical){
    int nSelect = MELEE_NUM_SECONDARIES;
    if(nMagical) nSelect += MELEE_NUM_SECONDARIES_MAGICAL;

    nSelect = Random(nSelect);

    switch(nSelect){
        case 0:  case 1:  case 2:  case 3: case 4: case 5:  AddRandomDamageBonus(oItem, nLevel); break;
        case 6:  case 7:  case 8:  AddRandomMassiveCritical(oItem, nLevel); break;
        case 9:  case 10: case 11: AddRandomKeen(oItem); break;
        case 12: case 13: AddRandomVampiricRegeneration(oItem, nLevel); break;
        case 14: AddRandomAbilityBonus(oItem, nLevel); break;
        case 15: AddRandomACBonus(oItem, nLevel); break;
        case 16: /*AddRandomACBonusVsDmgType(oItem, nLevel);*/ break;
        case 17: /*AddRandomAttackBonusVsAlign(oItem, nLevel);*/ break;
        case 18: /*AddRandomAttackBonusVsRace(oItem, nLevel);*/ break;
        case 19: AddRandomBonusSpellResistance(oItem, nLevel); break;
        case 20: AddRandomExtraMeleeDamageType(oItem); break;
        case 21: /*AddRandomWeightReduction(oItem, nLevel);*/ break;
        case 22: AddRandomOnHit(oItem, nLevel); break;

        case 23: AddRandomDamageImmunity(oItem, nLevel); break;
        case 24: AddRandomDamageReduction(oItem, nLevel); break;
        case 25: AddRandomDamageResistance(oItem, nLevel); break;
        case 26: AddRandomACBonusVsAlign(oItem, nLevel); break;
        case 27: AddRandomACBonusVsRace(oItem, nLevel); break;
        case 28: AddRandomDamageBonusVsAlign(oItem, nLevel); break;
        case 29: AddRandomDamageBonusVsRace(oItem, nLevel); break;
        case 30: AddRandomLight(oItem, nLevel); break;
    }
}

// RANGED
void AddRangedPropPrimary(object oItem, int nLevel, int nMagical){
    nLevel = AveRandomizeLevel(nLevel);

    if(nLevel > 0) {
        IPSafeAddItemProperty(oItem, ItemPropertyAttackBonus(nLevel));
        DoAddILRtoItem(oItem, nLevel);
    }

    SetItemNameMaterial(oItem, GetRandomWoodWeaponName(nLevel));
}

const int RANGED_NUM_SECONDARIES = 25;
const int RANGED_NUM_SECONDARIES_MAGICAL = 8;

void AddRangedPropSecondary(object oItem, int nLevel, int nMagical){
    int nSelect = RANGED_NUM_SECONDARIES;
    if(nMagical) nSelect += RANGED_NUM_SECONDARIES_MAGICAL;

    nSelect = Random(nSelect);

    switch(nSelect){
        case 0:  case 1:  case 2:  case 3: case 4: case 5:  AddRandomDamageBonus(oItem, nLevel); break;
        case 6:  case 7:  case 8:  AddRandomMassiveCritical(oItem, nLevel); break;
        case 9:  case 10: case 11: AddRandomKeen(oItem); break;
        case 12: case 13: AddRandomVampiricRegeneration(oItem, nLevel); break;
        case 14: AddRandomAbilityBonus(oItem, nLevel); break;
        case 15: AddRandomACBonus(oItem, nLevel); break;
        case 16: /*AddRandomACBonusVsDmgType(oItem, nLevel);*/ break;
        case 17: /*AddRandomAttackBonusVsAlign(oItem, nLevel);*/ break;
        case 18: /*AddRandomAttackBonusVsRace(oItem, nLevel);*/ break;
        case 19: AddRandomBonusSpellResistance(oItem, nLevel); break;
        case 20: AddRandomExtraRangeDamageType(oItem); break;
        case 21: /*AddRandomWeightReduction(oItem, nLevel);*/ break;
        case 22: AddRandomOnHit(oItem, nLevel); break;
        case 23: case 24: AddRandomMighty(oItem, nLevel); break;

        case 25: AddRandomDamageImmunity(oItem, nLevel); break;
        case 26: AddRandomDamageReduction(oItem, nLevel); break;
        case 27: AddRandomDamageResistance(oItem, nLevel); break;
        case 28: AddRandomACBonusVsAlign(oItem, nLevel); break;
        case 29: AddRandomACBonusVsRace(oItem, nLevel); break;
        case 30: AddRandomDamageBonusVsAlign(oItem, nLevel); break;
        case 31: AddRandomDamageBonusVsRace(oItem, nLevel); break;
        case 32: AddRandomLight(oItem, nLevel); break;
    }
}

// SHIELD
void AddShieldPropPrimary(object oItem, int nLevel, int nWood, int nMagical){

    if(nLevel > 3) nLevel = 3;
    nLevel = AveRandomizeLevel(nLevel);
    if(nLevel > 0) {
        IPSafeAddItemProperty(oItem, ItemPropertyACBonus(nLevel));
        DoAddILRtoItem(oItem, nLevel);
    }

    if(nWood) SetItemNameMaterial(oItem, GetRandomWoodShieldName(nLevel));
    else      SetItemNameMaterial(oItem, GetRandomMetalArmorName(nLevel));
}

const int SHIELD_NUM_SECONDARIES = 5;
const int SHIELD_NUM_SECONDARIES_MAGICAL = 8;

void AddShieldPropSecondary(object oItem, int nLevel, int nMagical){
    int nSelect = SHIELD_NUM_SECONDARIES;
    if(nMagical) nSelect += SHIELD_NUM_SECONDARIES_MAGICAL;

    nSelect = Random(nSelect);

    switch(nSelect){
        case 0:  AddRandomBonusSavingThrow(oItem, nLevel);       break;
        case 1:  AddRandomBonusSavingThrowVsX(oItem, nLevel);    break;
        case 2:  AddRandomACBonusVsDmgType(oItem, nLevel);       break;
        case 3:  AddRandomWeightReduction(oItem, nLevel);        break;
        case 4:  /*AddRandomSkillBonus(oItem, nLevel); */            break;

        case 5:  AddRandomDamageImmunity(oItem, nLevel);         break;
        case 6:  AddRandomDamageReduction(oItem, nLevel);        break;
        case 7:  AddRandomDamageResistance(oItem, nLevel);       break;
        case 8:  /*AddRandomACBonusVsAlign(oItem, nLevel); */        break;
        case 9:  /*AddRandomACBonusVsRace(oItem, nLevel);*/          break;
        case 10: AddRandomBonusSpellResistance(oItem, nLevel);   break;
        case 11: AddRandomRegeneration(oItem, nLevel);           break;
        case 12: AddRandomLight(oItem, nLevel);                  break;
    }
}

//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

void AddRandomAbilityBonus(object oItem, int nLevel, int nAbility=-1){
    if(nAbility == -1) nAbility = GetRandomAbility();
    if(nLevel > 4) nLevel = 4;

    nLevel = AveRandomizeLevel(nLevel);

    itemproperty ip = ItemPropertyAbilityBonus(nAbility, nLevel);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    switch(nAbility){
        case IP_CONST_ABILITY_STR:
            switch(nLevel){
                case 1: AddItemDescriptor(oItem, "Hill Giant's", "of Lesser Might"); break;
                case 2: AddItemDescriptor(oItem, "Frost Giant's", "of Might"); break;
                case 3: AddItemDescriptor(oItem, "Cloud Giant's", "of Greater Might"); break;
                case 4: AddItemDescriptor(oItem, "Storm Giant's", "of Overwhelming Strength"); break;
                case 5: AddItemDescriptor(oItem, "Titan's", "of Incredible Might"); break;
            }
        break;

        case IP_CONST_ABILITY_DEX:
            switch(nLevel){
                case 1: AddItemDescriptor(oItem, "Dextrous", "of Lesser Agility"); break;
                case 2: AddItemDescriptor(oItem, "Agile", "of Agility"); break;
                case 3: AddItemDescriptor(oItem, "Acrobat's", "of Greater Agility"); break;
                case 4: AddItemDescriptor(oItem, "Cat's", "of Incredible Speed"); break;
                case 5: AddItemDescriptor(oItem, "Monkey's", "of Complete Prowess"); break;
            }
        break;

        case IP_CONST_ABILITY_CON:
            switch(nLevel){
                case 1: AddItemDescriptor(oItem, "Rugged", "of Lesser Endurance"); break;
                case 2: AddItemDescriptor(oItem, "Stout", "of Endurance"); break;
                case 3: AddItemDescriptor(oItem, "Staunch", "of Greater Endurance"); break;
                case 4: AddItemDescriptor(oItem, "Solid", "of Amazing Tenacity"); break;
                case 5: AddItemDescriptor(oItem, "Vital", "of the Mountains"); break;
            }
        break;

        case IP_CONST_ABILITY_WIS:
            switch(nLevel){
                case 1: AddItemDescriptor(oItem, "Sensible", "of Lesser Wisdom"); break;
                case 2: AddItemDescriptor(oItem, "Wiseman's", "of Wisdom"); break;
                case 3: AddItemDescriptor(oItem, "Sage's", "of Greater Wisdom"); break;
                case 4: AddItemDescriptor(oItem, "Seer's", "of the Seer"); break;
                case 5: AddItemDescriptor(oItem, "Unraveling", "of Deep Instinct"); break;
            }
        break;

        case IP_CONST_ABILITY_INT:
            switch(nLevel){
                case 1: AddItemDescriptor(oItem, "Smart", "of Lesser Intellect"); break;
                case 2: AddItemDescriptor(oItem, "Student's", "of Intellect"); break;
                case 3: AddItemDescriptor(oItem, "Academic's", "of Greater Intellect"); break;
                case 4: AddItemDescriptor(oItem, "Scholar's", "of the Scholar"); break;
                case 5: AddItemDescriptor(oItem, "Cerebral", "of Ingenuity"); break;
            }
        break;

        case IP_CONST_ABILITY_CHA:
            switch(nLevel){
                case 1: AddItemDescriptor(oItem, "Charming", "of Lesser Grace"); break;
                case 2: AddItemDescriptor(oItem, "Alluring", "of Grace"); break;
                case 3: AddItemDescriptor(oItem, "Bewitching", "of Greater Grace"); break;
                case 4: AddItemDescriptor(oItem, "Speaker's", "of the Speaker"); break;
                case 5: AddItemDescriptor(oItem, "Magnanimous", "of Powerful Presence"); break;
            }
        break;
    }

    IPSafeAddItemProperty(oItem, ip);
    DoAddILRtoItem(oItem, nLevel);
    //SendMessageToAllDMs("AddRandomAbilityBonus terminated with nLevel of " + IntToString(nLevel) + ".");
}

void AddRandomACBonus(object oItem, int nLevel){
    if(nLevel > 3) nLevel = 3; // Max AC bonus at +3

    nLevel = AveRandomizeLevel(nLevel);

    itemproperty ip = ItemPropertyACBonus(nLevel);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    switch(nLevel){
        case 1: AddItemDescriptor(oItem, "Shielding", "of Lesser Defense"); break;
        case 2: AddItemDescriptor(oItem, "Soldier's", "of Defense"); break;
        case 3: AddItemDescriptor(oItem, "Protector's", "of Greater Defense"); break;
        case 4: AddItemDescriptor(oItem, "Defender's", "of Perfect Defense"); break;
        //case 5: AddItemDescriptor(oItem, "Guardian's", "of the Aegis"); break;
    }

    IPSafeAddItemProperty(oItem, ip);
    DoAddILRtoItem(oItem, nLevel);
    //SendMessageToAllDMs("AddRandomACBonus terminated with nLevel of " + IntToString(nLevel) + ".");
}

void AddRandomACBonusVsAlign(object oItem, int nLevel, int nAlign=-1){
    if(nAlign == -1) nAlign = GetRandomAlignment();

    if(nLevel > 3) nLevel = 3; // Max AC bonus at +3
    nLevel = AveRandomizeLevel(nLevel);

    itemproperty ip = ItemPropertyACBonusVsAlign(nAlign, nLevel);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    string sAlignName;

    switch(nAlign){
        case IP_CONST_ALIGNMENTGROUP_CHAOTIC: sAlignName = "Chaos";   break;
        case IP_CONST_ALIGNMENTGROUP_EVIL:    sAlignName = "Evil";    break;
        case IP_CONST_ALIGNMENTGROUP_GOOD:    sAlignName = "Good";    break;
        case IP_CONST_ALIGNMENTGROUP_LAWFUL:  sAlignName = "Law";     break;
        case IP_CONST_ALIGNMENTGROUP_NEUTRAL: sAlignName = "Balance"; break;
    }

    switch(nLevel){
        case 1: AddItemDescriptor(oItem, "Lesser " + sAlignName + " Warding", "of Lesser Defense Against " + sAlignName); break;
        case 2: AddItemDescriptor(oItem, sAlignName + " Warding", "of Defense Against " + sAlignName); break;
        case 3: AddItemDescriptor(oItem, "Greater " + sAlignName + " Warding", "of Greater Defense Against " + sAlignName); break;
        //case 4: AddItemDescriptor(oItem, "Perfect " + sAlignName + " Warding", "of Perfect Defense Against " + sAlignName); break;
        //case 5: AddItemDescriptor(oItem, sAlignName + "'s Bane", "of " + sAlignName + "'s Bane"); break;
    }

    IPSafeAddItemProperty(oItem, ip);
    DoAddILRtoItem(oItem, nLevel);
    //SendMessageToAllDMs("AddRandomACBonusVsAlign terminated with nLevel of " + IntToString(nLevel) + ".");
}

void AddRandomACBonusVsDmgType(object oItem, int nLevel, int nType=-1){
    if(nType == -1) nType = GetRandomDamageType(TRUE);

    if(nLevel > 4) nLevel = 4;
    nLevel = AveRandomizeLevel(nLevel);

    itemproperty ip = ItemPropertyACBonusVsDmgType(nType, nLevel);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    switch(nType){
        case IP_CONST_DAMAGETYPE_SLASHING:
             switch(nLevel){
                case 1: AddItemDescriptor(oItem, "Bladeparry", "of Sword Parrying"); break;
                case 2: AddItemDescriptor(oItem, "Bladeblock", "of Sword Blocking"); break;
                case 3: AddItemDescriptor(oItem, "Bladeshield", "of Sword Shielding"); break;
                case 4: AddItemDescriptor(oItem, "Bladeturning", "of Sword Turning"); break;
                case 5: AddItemDescriptor(oItem, "Bladebreaker", "of Sword Breaking"); break;
            }
        break;

        case IP_CONST_DAMAGETYPE_PIERCING:
             switch(nLevel){
                case 1: AddItemDescriptor(oItem, "Spearparry", "of Spear Parrying"); break;
                case 2: AddItemDescriptor(oItem, "Spearblock", "of Spear Blocking"); break;
                case 3: AddItemDescriptor(oItem, "Spearshield", "of Spear Shielding"); break;
                case 4: AddItemDescriptor(oItem, "Spearturning", "of Spear Turning"); break;
                case 5: AddItemDescriptor(oItem, "Spearbreaker", "of Spear Breaking"); break;
            }
        break;

        case IP_CONST_DAMAGETYPE_BLUDGEONING:
             switch(nLevel){
                case 1: AddItemDescriptor(oItem, "Maceparry", "of Mace Parrying"); break;
                case 2: AddItemDescriptor(oItem, "Maceblock", "of Mace Blocking"); break;
                case 3: AddItemDescriptor(oItem, "Maceshielding", "of Mace Shielding"); break;
                case 4: AddItemDescriptor(oItem, "Maceturning", "of Mace Turning"); break;
                case 5: AddItemDescriptor(oItem, "Macebreaker", "of Mace Breaking"); break;
            }
        break;
    }

    IPSafeAddItemProperty(oItem, ip);
    DoAddILRtoItem(oItem, nLevel - 1);
    //SendMessageToAllDMs("AddRandomACBonusVsDmgType terminated with nLevel of " + IntToString(nLevel) + ".");
}

void AddRandomACBonusVsRace(object oItem, int nLevel, int nRace=-1){
    if(nRace == -1) nRace = GetRandomRace();

    if(nLevel > 3) nLevel = 3;
    nLevel = AveRandomizeLevel(nLevel);

    itemproperty ip = ItemPropertyACBonusVsRace(nRace, nLevel);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    IPSafeAddItemProperty(oItem, ip);
    DoAddILRtoItem(oItem, nLevel);
    //SendMessageToAllDMs("AddRandomACBonusVsRace terminated with nLevel of " + IntToString(nLevel) + ".");
}

void AddRandomAttackBonus(object oItem, int nLevel){
    nLevel = AveRandomizeLevel(nLevel);

    itemproperty ip = ItemPropertyAttackBonus(nLevel);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    switch(nLevel){
        case 1: AddItemDescriptor(oItem, "Mastercraft", "of Deftness"); break;
        case 2: AddItemDescriptor(oItem, "Novice's", "of the Novice"); break;
        case 3: AddItemDescriptor(oItem, "Journeyman's", "of the Journeyman"); break;
        case 4: AddItemDescriptor(oItem, "Expert's", "of the Expert"); break;
        case 5: AddItemDescriptor(oItem, "Master's", "of the Master"); break;
        case 6: AddItemDescriptor(oItem, "Deft", "of the Student"); break;
    }

    IPSafeAddItemProperty(oItem, ip);
    DoAddILRtoItem(oItem, nLevel);
    //SendMessageToAllDMs("AddRandomAttackBonus terminated with nLevel of " + IntToString(nLevel) + ".");
}

void AddRandomAttackBonusVsAlign(object oItem, int nLevel, int nAlign=-1){
    if(nAlign == -1) nAlign = GetRandomAlignment();

    nLevel = AveRandomizeLevel(nLevel);

    itemproperty ip = ItemPropertyAttackBonusVsAlign(nAlign, nLevel);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    switch(nAlign){
        case IP_CONST_ALIGNMENTGROUP_CHAOTIC: AddItemDescriptor(oItem, "Chaosbane", "of Law"); break;
        case IP_CONST_ALIGNMENTGROUP_EVIL:    AddItemDescriptor(oItem, "Avenger's", "of Good"); break;
        case IP_CONST_ALIGNMENTGROUP_GOOD:    AddItemDescriptor(oItem, "Blackguard's", "of Evil"); break;
        case IP_CONST_ALIGNMENTGROUP_LAWFUL:  AddItemDescriptor(oItem, "Lawbreaker", "of Chaos"); break;
        case IP_CONST_ALIGNMENTGROUP_NEUTRAL: AddItemDescriptor(oItem, "Balancebreaker", "of Beliefs"); break;
    }

    IPSafeAddItemProperty(oItem, ip);
    DoAddILRtoItem(oItem, nLevel);
    //SendMessageToAllDMs("AddRandomAttackBonusVsAlign terminated with nLevel of " + IntToString(nLevel) + ".");
}

void AddRandomAttackBonusVsRace(object oItem, int nLevel, int nRace=-1){
    if(nRace == -1) nRace = GetRandomRace();

    nLevel = AveRandomizeLevel(nLevel);

    itemproperty ip = ItemPropertyAttackBonusVsRace(nRace, nLevel);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    IPSafeAddItemProperty(oItem, ip);
    DoAddILRtoItem(oItem, nLevel);
    //SendMessageToAllDMs("AddRandomAttackBonusVsRace terminated with nLevel of " + IntToString(nLevel) + ".");
}

void AddRandomAttackPenalty(object oItem, int nLevel){
    if(nLevel > 5) nLevel = 5;

    nLevel = AveRandomizeLevel(nLevel);

    itemproperty ip = ItemPropertyAttackPenalty(nLevel);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    IPSafeAddItemProperty(oItem, ip);
    //SendMessageToAllDMs("AddRandomAttackPenalty terminated with nLevel of " + IntToString(nLevel) + ".");
}

void AddRandomBonusLevelSpell(object oItem, int nLevel, int nClass=-1){
    int nCount = Random(nLevel) + 2;

    if(nCount > 3) nCount = 3; // Invictus - maximum number of spellslots is 3

    if(nClass == -1){
        int i = Random(7);

        switch(i){
            case 0:
                nClass = IP_CONST_CLASS_BARD;
                AddItemDescriptor(oItem, "Bard's", "of the Bard");
            break;

            case 1:
                nClass = IP_CONST_CLASS_CLERIC;
                AddItemDescriptor(oItem, "Cleric's", "of the Cleric");
            break;

            case 2:
                nClass = IP_CONST_CLASS_DRUID;
                AddItemDescriptor(oItem, "Druid's", "of the Druid");
            break;

            case 3:
                nClass = IP_CONST_CLASS_PALADIN;
                AddItemDescriptor(oItem, "Paladin's", "of the Paladin");
            break;

            case 4:
                nClass = IP_CONST_CLASS_RANGER;
                AddItemDescriptor(oItem, "Ranger's", "of the Ranger");
            break;

            case 5:
                nClass = IP_CONST_CLASS_SORCERER;
                AddItemDescriptor(oItem, "Sorcerer's", "of the Sorcerer");
            break;

            case 6:
                nClass = IP_CONST_CLASS_WIZARD;
                AddItemDescriptor(oItem, "Wizard's", "of the Wizard");
            break;
        }
    }

    itemproperty ip;

    for(nCount; nCount > 0; nCount--){
        int nSpellLevel;

        switch(nClass){
            case IP_CONST_CLASS_PALADIN:
            case IP_CONST_CLASS_RANGER:
                if(nLevel < 1) return;
                if(nLevel > 3) nLevel = 3;

                nSpellLevel = AveRandomizeLevel(nLevel)+1;
                DoAddILRtoItem(oItem, nSpellLevel + 1);
            break;

            case IP_CONST_CLASS_BARD:
                nSpellLevel = AveRandomizeLevel(FloatToInt(nLevel * 1.4)+1);
                if(nSpellLevel>6) nSpellLevel=6;
            break;

            case IP_CONST_CLASS_CLERIC:
            case IP_CONST_CLASS_DRUID:
                nSpellLevel = AveRandomizeLevel(FloatToInt(nLevel * 1.5)+1);
                if(nSpellLevel>9) nSpellLevel=9;
                DoAddILRtoItem(oItem, GetTierByLevel(nSpellLevel * 2 - 1));
            break;
            case IP_CONST_CLASS_SORCERER:
            case IP_CONST_CLASS_WIZARD:
                nSpellLevel = AveRandomizeLevel(FloatToInt(nLevel * 1.5)+1);
                if(nSpellLevel>9) nSpellLevel=9;
            break;
        }

        ip = ItemPropertyBonusLevelSpell(nClass, nSpellLevel);
        IPSafeAddItemProperty(oItem, ip);
        //SendMessageToAllDMs("AddRandomBonusLevelSpell terminated with nSpellLevel of " + IntToString(nSpellLevel) + ".");
        //SendMessageToAllDMs("AddRandomBonusLevelSpell terminated with nLevel of " + IntToString(nLevel) + ".");
    }
}

void AddRandomBonusSavingThrow(object oItem, int nLevel, int nSave=-1){
    itemproperty ip;

    if(nSave == -1) nSave = Random(4);

    nLevel = AveRandomizeLevel((nLevel / 6)+1);
    if(nLevel<1) nLevel=1;
    if(nSave == 0){
        ip = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_UNIVERSAL, nLevel);

        if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

        switch(nLevel){
            case 1: AddItemDescriptor(oItem, "Lesser Warding", "of Lesser Warding");
            IPSafeAddItemProperty(oItem, ip);
            DoAddILRtoItem(oItem, nLevel + 1);
            break;
            case 2: AddItemDescriptor(oItem, "Warding", "of Warding");
            IPSafeAddItemProperty(oItem, ip);
            DoAddILRtoItem(oItem, nLevel + 2);
            break;
        }
    } else {
        ip = ItemPropertyBonusSavingThrow(nSave, nLevel + 1);

        if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

        switch(nSave){
            case IP_CONST_SAVEBASETYPE_FORTITUDE:
                switch(nLevel){
                    case 1: AddItemDescriptor(oItem, "Survivor's", "of Lesser Fortitude"); break;
                    case 2: AddItemDescriptor(oItem, "Stout", "of Fortitude"); break;
                    case 3: AddItemDescriptor(oItem, "Resolute", "of Greater Fortitude"); break;
                    //case 4: AddItemDescriptor(oItem, "Courageous", "of Perfect Fortitude"); break;
                    //case 5: AddItemDescriptor(oItem, "Deathless", "of the Deathless"); break;
                }

                IPSafeAddItemProperty(oItem, ip);
                DoAddILRtoItem(oItem, nLevel);
            break;

            case IP_CONST_SAVEBASETYPE_REFLEX:
                switch(nLevel){
                    case 1: AddItemDescriptor(oItem, "Elusive", "of Lesser Evasion"); break;
                    case 2: AddItemDescriptor(oItem, "Acrobat's", "of Evasion"); break;
                    case 3: AddItemDescriptor(oItem, "Trickster's", "of Greater Evasion"); break;
                    //case 4: AddItemDescriptor(oItem, "Trapspringer's", "of Perfect Evasion"); break;
                    //case 5: AddItemDescriptor(oItem, "Rogue's", "of the Rogue"); break;
                }
                IPSafeAddItemProperty(oItem, ip);
                DoAddILRtoItem(oItem, nLevel);
            break;

            case IP_CONST_SAVEBASETYPE_WILL:
                switch(nLevel){
                    case 1: AddItemDescriptor(oItem, "Disciplined", "of Lesser Will"); break;
                    case 2: AddItemDescriptor(oItem, "Mindlock", "of Will"); break;
                    case 3: AddItemDescriptor(oItem, "Mindshield", "of Greater Will"); break;
                    //case 4: AddItemDescriptor(oItem, "Mindwall", "of Perfect Will"); break;
                    //case 5: AddItemDescriptor(oItem, "Psion's", "of the Psion"); break;
                }
                IPSafeAddItemProperty(oItem, ip);
                DoAddILRtoItem(oItem, nLevel);
            break;
        }
    }

    //IPSafeAddItemProperty(oItem, ip);
    //DoAddILRtoItem(oItem, nLevel);
    //SendMessageToAllDMs("AddRandomBonusSavingThrow terminated with nLevel of " + IntToString(nLevel) + ".");
}

void AddRandomBonusSavingThrowVsX(object oItem, int nLevel, int nType=-1){
    if(nType == -1) nType = GetRandomSaveVs();

    nLevel = AveRandomizeLevel(nLevel/2);
    if(nLevel<1) nLevel=1;
    itemproperty ip = ItemPropertyBonusSavingThrowVsX(nType, nLevel);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    switch(nType){
        case IP_CONST_SAVEVS_ACID:          AddItemDescriptor(oItem, "Neutralizing", "of Neutralizing"); break;
        case IP_CONST_SAVEVS_COLD:          AddItemDescriptor(oItem, "Insulating", "of Warmth"); break;
        case IP_CONST_SAVEVS_DEATH:         AddItemDescriptor(oItem, "Undying", "of Undying"); break;
        case IP_CONST_SAVEVS_DISEASE:       AddItemDescriptor(oItem, "Healer's", "of the Healer"); break;
        case IP_CONST_SAVEVS_DIVINE:        AddItemDescriptor(oItem, "Earthly", "of Serenity"); break;
        case IP_CONST_SAVEVS_ELECTRICAL:    AddItemDescriptor(oItem, "Grounding", "of Grounding"); break;
        case IP_CONST_SAVEVS_FEAR:          AddItemDescriptor(oItem, "Fearless", "of Fearlessness"); break;
        case IP_CONST_SAVEVS_FIRE:          AddItemDescriptor(oItem, "Cooling", "of Cooling"); break;
        case IP_CONST_SAVEVS_MINDAFFECTING: AddItemDescriptor(oItem, "Mindblock", "of Clarity"); break;
        case IP_CONST_SAVEVS_NEGATIVE:      AddItemDescriptor(oItem, "Lifeblood", "of Lifeblood"); break;
        case IP_CONST_SAVEVS_POISON:        AddItemDescriptor(oItem, "Purifying", "of Purifying"); break;
        case IP_CONST_SAVEVS_POSITIVE:      AddItemDescriptor(oItem, "Regulating", "of Regulation"); break;
        case IP_CONST_SAVEVS_SONIC:         AddItemDescriptor(oItem, "Quieting", "of Quieting"); break;
    }

    IPSafeAddItemProperty(oItem, ip);
    DoAddILRtoItem(oItem, nLevel - 2);
    //SendMessageToAllDMs("AddRandomBonusSavingThrowVsX terminated with nLevel of " + IntToString(nLevel) + ".");
}

void AddRandomBonusSpellResistance(object oItem, int nLevel){
    nLevel = AveRandomizeLevel(nLevel*2)-1;
    if(nLevel>10) nLevel=10;
    itemproperty ip = ItemPropertyBonusSpellResistance(nLevel);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    switch(nLevel){
        case 0: case 1: case 2:  AddItemDescriptor(oItem, "Magic Resistant", "of Magic Resistance"); break;
        case 3: case 4:  AddItemDescriptor(oItem, "Magic Shielding", "of Magic Shielding"); break;
        case 5: case 6:  AddItemDescriptor(oItem, "Magic Breaking", "of Magic Breaking"); break;
        case 7: case 8:  AddItemDescriptor(oItem, "Magekiller's", "of the Magekiller"); break;
        case 9: case 10: AddItemDescriptor(oItem, "Anti-Magic", "of Anti-Magic"); break;
    }

    IPSafeAddItemProperty(oItem, ip);
    DoAddILRtoItem(oItem, nLevel / 2);
    //SendMessageToAllDMs("AddRandomBonusSpellResistance terminated with nTier of " + IntToString(nLevel / 2) + ".");
}

void AddRandomMighty(object oItem, int nLevel)
{
    nLevel=AveRandomizeLevel(nLevel)+1;
    itemproperty ip = ItemPropertyMaxRangeStrengthMod(nLevel);
    if(IPGetItemHasProperty(oItem,ip,DURATION_TYPE_PERMANENT)) return;
    switch(nLevel)
    {
    case 1: AddItemDescriptor(oItem,"Amnian", "of The Dales"); break;
    case 2: AddItemDescriptor(oItem,"Cormyrean", "of Strength"); break;
    case 3: AddItemDescriptor(oItem,"Chessentan", "of The Wood Elves"); break;
    case 4: AddItemDescriptor(oItem,"Kara-turan", "of Might"); break;
    case 5: AddItemDescriptor(oItem,"Turmish", "of The Nomads"); break;
    case 6: AddItemDescriptor(oItem,"Tuigan", "of Power"); break;
    }
    IPSafeAddItemProperty(oItem, ip);
    DoAddILRtoItem(oItem, nLevel - 1);
}

void AddRandomContainerReducedWeight(object oItem, int nLevel){
    nLevel = AveRandomizeLevel(nLevel);

    itemproperty ip = ItemPropertyContainerReducedWeight(nLevel);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    IPSafeAddItemProperty(oItem, ip);
    DoAddILRtoItem(oItem, nLevel);
    //SendMessageToAllDMs("AddRandomContainerReducedWeight terminated with nLevel of " + IntToString(nLevel) + ".");
}

void AddRandomDamageBonus(object oItem, int nLevel, int nType=-1){
    int nRoll;
    int nLevelILR;

    switch(nLevel){
        case 6: nRoll = AveRandomizeLevel(11);break;
        case 5: nRoll = AveRandomizeLevel(8); break;
        case 4: nRoll = AveRandomizeLevel(6); break;
        case 3: nRoll = AveRandomizeLevel(4); break;
        case 2: nRoll = AveRandomizeLevel(2); break;
        case 1: nRoll = 1;    break;
    }

    switch(nRoll){
        case 1: nLevel = IP_CONST_DAMAGEBONUS_1;   nLevelILR = 1; break;
        case 2: nLevel = IP_CONST_DAMAGEBONUS_2;   nLevelILR = 2; break;
        case 3: nLevel = IP_CONST_DAMAGEBONUS_1d4; nLevelILR = 2; break;
        case 4: nLevel = IP_CONST_DAMAGEBONUS_3;   nLevelILR = 3; break;
        case 5: nLevel = IP_CONST_DAMAGEBONUS_1d6; nLevelILR = 3; break;
        case 6: nLevel = IP_CONST_DAMAGEBONUS_4;   nLevelILR = 4; break;
        case 7: nLevel = IP_CONST_DAMAGEBONUS_1d8; nLevelILR = 4; break;
        case 8: nLevel = IP_CONST_DAMAGEBONUS_5;   nLevelILR = 5; break;
        case 9: nLevel = IP_CONST_DAMAGEBONUS_1d10;nLevelILR = 5; break;
        case 10: nLevel = IP_CONST_DAMAGEBONUS_6;   nLevelILR = 6; break;
        case 11: nLevel = IP_CONST_DAMAGEBONUS_1d12;nLevelILR = 6; break;
    }

    DoAddILRtoItem(oItem, nLevelILR);

    if(nType == -1){
        nType = Random(12);

        if(nType > 2) nType += 2;
    }

    itemproperty ip = ItemPropertyDamageBonus(nType, nLevel);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT, TRUE)) return;

    switch(nType){
        case IP_CONST_DAMAGETYPE_SLASHING:
            switch(nLevel){
                case 1: case 2: AddItemDescriptor(oItem, "Cutter's", "of Cutting"); break;
                case 3: case 4: AddItemDescriptor(oItem, "Slicing", "of Slicing"); break;
                case 5: case 6: AddItemDescriptor(oItem, "Razor Sharp", "of "); break;
                case 7: case 8: AddItemDescriptor(oItem, "Sundering", "of Sundering"); break;
            }
        break;

        case IP_CONST_DAMAGETYPE_PIERCING:
            switch(nLevel){
                case 1: case 2: AddItemDescriptor(oItem, "Piercing", "of Piercing"); break;
                case 3: case 4: AddItemDescriptor(oItem, "Spiked", "of Spikes"); break;
                case 5: case 6: AddItemDescriptor(oItem, "Barbed", "of Barbs"); break;
                case 7: case 8: AddItemDescriptor(oItem, "Impaling", "of Impaling"); break;
            }
        break;

        case IP_CONST_DAMAGETYPE_BLUDGEONING:
            switch(nLevel){
                case 1: case 2: AddItemDescriptor(oItem, "Blunted", "of Pounding"); break;
                case 3: case 4: AddItemDescriptor(oItem, "Battering", "of Battering"); break;
                case 5: case 6: AddItemDescriptor(oItem, "Impacting", "of Impacting"); break;
                case 7: case 8: AddItemDescriptor(oItem, "Concussing", "of Concussing"); break;
            }
        break;

        case IP_CONST_DAMAGETYPE_ACID:
            switch(nLevel){
                case 1: case 2: AddItemDescriptor(oItem, "Biting", "of Biting"); break;
                case 3: case 4: AddItemDescriptor(oItem, "Acrid", "of Acidity"); break;
                case 5: case 6: AddItemDescriptor(oItem, "Acidic", "of Dissolving"); break;
                case 7: case 8: AddItemDescriptor(oItem, "Caustic", "of Corrosion"); break;
            }
        break;

        case IP_CONST_DAMAGETYPE_COLD:
            switch(nLevel){
                case 1: case 2: AddItemDescriptor(oItem, "Chilled", "of Chilling"); break;
                case 3: case 4: AddItemDescriptor(oItem, "Numbing", "of Numbing"); break;
                case 5: case 6: AddItemDescriptor(oItem, "Freezing", "of Freezing"); break;
                case 7: case 8: AddItemDescriptor(oItem, "Arctic", "of the Winter"); break;
            }
        break;

        case IP_CONST_DAMAGETYPE_DIVINE:
            switch(nLevel){
                case 1: case 2: AddItemDescriptor(oItem, "Blessed", "of the Priest"); break;
                case 3: case 4: AddItemDescriptor(oItem, "Annointed", "of the Church"); break;
                case 5: case 6: AddItemDescriptor(oItem, "Holy", "of the Faith"); break;
                case 7: case 8: AddItemDescriptor(oItem, "Divine", "of the Gods"); break;
            }
        break;

        case IP_CONST_DAMAGETYPE_ELECTRICAL:
            switch(nLevel){
                case 1: case 2: AddItemDescriptor(oItem, "Crackling", "of Jolting"); break;
                case 3: case 4: AddItemDescriptor(oItem, "Shocking", "of Shocking"); break;
                case 5: case 6: AddItemDescriptor(oItem, "Arcing", "of Lightning"); break;
                case 7: case 8: AddItemDescriptor(oItem, "Shocking", "of Storms"); break;
            }
        break;

        case IP_CONST_DAMAGETYPE_FIRE:
            switch(nLevel){
                case 1: case 2: AddItemDescriptor(oItem, "Flaring", "of Flares"); break;
                case 3: case 4: AddItemDescriptor(oItem, "Burning", "of Burning"); break;
                case 5: case 6: AddItemDescriptor(oItem, "Flaming", "of Flames"); break;
                case 7: case 8: AddItemDescriptor(oItem, "Hellfire", "of Hellfire"); break;
            }
        break;

        case IP_CONST_DAMAGETYPE_MAGICAL:
            switch(nLevel){
                case 1: case 2: AddItemDescriptor(oItem, "Mage's", "of the Magi"); break;
                case 3: case 4: AddItemDescriptor(oItem, "Arcane", "of Arcana"); break;
                case 5: case 6: AddItemDescriptor(oItem, "Magefire", "of Magefire"); break;
                case 7: case 8: AddItemDescriptor(oItem, "Spellfire", "of Spellfire"); break;
            }
        break;

        case IP_CONST_DAMAGETYPE_NEGATIVE:
            switch(nLevel){
                case 1: case 2: AddItemDescriptor(oItem, "Sapping", "of Sapping"); break;
                case 3: case 4: AddItemDescriptor(oItem, "Lifedrain", "of Lifedraining"); break;
                case 5: case 6: AddItemDescriptor(oItem, "Lifebane", "of Lifebane"); break;
                case 7: case 8: AddItemDescriptor(oItem, "Lifebreaker", "of Lifebreaking"); break;
            }
        break;

        case IP_CONST_DAMAGETYPE_POSITIVE:
            switch(nLevel){
                case 1: case 2: AddItemDescriptor(oItem, "", ""); break;
                case 3: case 4: AddItemDescriptor(oItem, "", ""); break;
                case 5: case 6: AddItemDescriptor(oItem, "", ""); break;
                case 7: case 8: AddItemDescriptor(oItem, "", ""); break;
            }
        break;

        case IP_CONST_DAMAGETYPE_SONIC:
            switch(nLevel){
                case 1: case 2: AddItemDescriptor(oItem, "Singing", "of Song"); break;
                case 3: case 4: AddItemDescriptor(oItem, "Screaming", "of Screaming"); break;
                case 5: case 6: AddItemDescriptor(oItem, "Thundering", "of Thundering"); break;
                case 7: case 8: AddItemDescriptor(oItem, "Deafening", "of Deafening"); break;
            }
        break;
    }

    IPSafeAddItemProperty(oItem, ip);
    //SendMessageToAllDMs("AddRandomDamageBonus terminated with nLevelILR of " + IntToString(nLevelILR) + ".");
    //SendMessageToAllDMs("AddRandomDamageBonus terminated with nLevel of " + IntToString(nLevel) + ".");
}

void AddRandomDamageBonusVsAlign(object oItem, int nLevel, int nType=-1, int nAlign=-1){
    int nRoll;
    int nLevelILR;

    switch(nLevel){
        case 6: nRoll = AveRandomizeLevel(12);break;
        case 5: nRoll = AveRandomizeLevel(10);break;
        case 4: nRoll = AveRandomizeLevel(8); break;
        case 3: nRoll = AveRandomizeLevel(6); break;
        case 2: nRoll = AveRandomizeLevel(4); break;
        case 1: nRoll = AveRandomizeLevel(2); break;
    }

    switch(nRoll){
        case 1: nLevel = IP_CONST_DAMAGEBONUS_1;   nLevelILR = 1; break;
        case 2: nLevel = IP_CONST_DAMAGEBONUS_2;   nLevelILR = 1; break;
        case 3: nLevel = IP_CONST_DAMAGEBONUS_1d4; nLevelILR = 2; break;
        case 4: nLevel = IP_CONST_DAMAGEBONUS_3;   nLevelILR = 2; break;
        case 5: nLevel = IP_CONST_DAMAGEBONUS_1d6; nLevelILR = 3; break;
        case 6: nLevel = IP_CONST_DAMAGEBONUS_4;   nLevelILR = 3; break;
        case 7: nLevel = IP_CONST_DAMAGEBONUS_1d8; nLevelILR = 4; break;
        case 8: nLevel = IP_CONST_DAMAGEBONUS_5;   nLevelILR = 4; break;
        case 9: nLevel = IP_CONST_DAMAGEBONUS_1d10;nLevelILR = 5; break;
        case 10: nLevel = IP_CONST_DAMAGEBONUS_6;   nLevelILR = 5; break;
        case 11: nLevel = IP_CONST_DAMAGEBONUS_1d12;nLevelILR= 6; break;
        case 12: nLevel = IP_CONST_DAMAGEBONUS_7;  nLevelILR = 6; break;
    }

    DoAddILRtoItem(oItem, nLevelILR);

    if(nType == -1) nType = GetRandomDamageType();

    if(nAlign == -1) nAlign = GetRandomAlignment();

    itemproperty ip = ItemPropertyDamageBonusVsAlign(nAlign, nType, nLevel);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    switch(nAlign){
        case IP_CONST_ALIGNMENTGROUP_CHAOTIC: AddItemDescriptor(oItem, "Chaosbane", "of Law"); break;
        case IP_CONST_ALIGNMENTGROUP_EVIL:    AddItemDescriptor(oItem, "Avenger's", "of Good"); break;
        case IP_CONST_ALIGNMENTGROUP_GOOD:    AddItemDescriptor(oItem, "Blackguard's", "of Evil"); break;
        case IP_CONST_ALIGNMENTGROUP_LAWFUL:  AddItemDescriptor(oItem, "Lawbreaker", "of Chaos"); break;
        case IP_CONST_ALIGNMENTGROUP_NEUTRAL: AddItemDescriptor(oItem, "Balancebreaker", "of Beliefs"); break;
    }

    IPSafeAddItemProperty(oItem, ip);
    //SendMessageToAllDMs("AddRandomDamageBonusVsAlign terminated with nLevelILR of " + IntToString(nLevelILR) + ".");
    //SendMessageToAllDMs("AddRandomDamageBonusVsAlign terminated with nLevel of " + IntToString(nLevel) + ".");
}

void AddRandomDamageBonusVsRace(object oItem, int nLevel, int nType=-1, int nRace=-1){
    int nRoll;
    int nLevelILR;

    switch(nLevel){
        case 6: nRoll = AveRandomizeLevel(12);break;
        case 5: nRoll = AveRandomizeLevel(10);break;
        case 4: nRoll = AveRandomizeLevel(8); break;
        case 3: nRoll = AveRandomizeLevel(6); break;
        case 2: nRoll = AveRandomizeLevel(4); break;
        case 1: nRoll = AveRandomizeLevel(2); break;
    }

    switch(nRoll){
        case 1: nLevel = IP_CONST_DAMAGEBONUS_1;   nLevelILR = 1; break;
        case 2: nLevel = IP_CONST_DAMAGEBONUS_2;   nLevelILR = 1; break;
        case 3: nLevel = IP_CONST_DAMAGEBONUS_1d4; nLevelILR = 2; break;
        case 4: nLevel = IP_CONST_DAMAGEBONUS_3;   nLevelILR = 2; break;
        case 5: nLevel = IP_CONST_DAMAGEBONUS_1d6; nLevelILR = 3; break;
        case 6: nLevel = IP_CONST_DAMAGEBONUS_4;   nLevelILR = 3; break;
        case 7: nLevel = IP_CONST_DAMAGEBONUS_1d8; nLevelILR = 4; break;
        case 8: nLevel = IP_CONST_DAMAGEBONUS_5;   nLevelILR = 4; break;
        case 9: nLevel = IP_CONST_DAMAGEBONUS_1d10;nLevelILR = 5; break;
        case 10: nLevel = IP_CONST_DAMAGEBONUS_6;   nLevelILR = 5; break;
        case 11: nLevel = IP_CONST_DAMAGEBONUS_1d12;nLevelILR= 6; break;
        case 12: nLevel = IP_CONST_DAMAGEBONUS_7;  nLevelILR = 6; break;
    }

    DoAddILRtoItem(oItem, nLevelILR);

    if(nType == -1) nType = GetRandomDamageType();

    if(nRace == -1) nRace = GetRandomRace();

    itemproperty ip = ItemPropertyDamageBonusVsRace(nRace, nType, nLevel);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    IPSafeAddItemProperty(oItem, ip);
    //SendMessageToAllDMs("AddRandomDamageBonusVsRace terminated with nLevelILR of " + IntToString(nLevelILR) + ".");
    //SendMessageToAllDMs("AddRandomDamageBonusVsRace terminated with nLevel of " + IntToString(nLevel) + ".");
}

void AddRandomDamageImmunity(object oItem, int nLevel, int nType=-1){
    nLevel = AveRandomizeLevel(nLevel/2);

    if(nType == -1) nType = GetRandomDamageType();

    itemproperty ip = ItemPropertyDamageImmunity(nType, nLevel);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    switch(nType){
        case IP_CONST_DAMAGETYPE_SLASHING:    AddItemDescriptor(oItem, "Armored", "of Armor"); break;
        case IP_CONST_DAMAGETYPE_PIERCING:    AddItemDescriptor(oItem, "Deflecting", "of Deflection"); break;
        case IP_CONST_DAMAGETYPE_BLUDGEONING: AddItemDescriptor(oItem, "Padded", "of Padding"); break;

        case IP_CONST_DAMAGETYPE_ACID:        AddItemDescriptor(oItem, "Neutralizing", "of Neutralizing"); break;
        case IP_CONST_DAMAGETYPE_COLD:        AddItemDescriptor(oItem, "Insulating", "of Warmth"); break;
        case IP_CONST_DAMAGETYPE_DIVINE:      AddItemDescriptor(oItem, "Earthly", "of Serenity"); break;
        case IP_CONST_DAMAGETYPE_ELECTRICAL:  AddItemDescriptor(oItem, "Grounding", "of Grounding"); break;
        case IP_CONST_DAMAGETYPE_FIRE:        AddItemDescriptor(oItem, "Cooling", "of Cooling"); break;
        case IP_CONST_DAMAGETYPE_MAGICAL:     AddItemDescriptor(oItem, "Arcane Defender", "of Arcane Defense"); break;
        case IP_CONST_DAMAGETYPE_NEGATIVE:    AddItemDescriptor(oItem, "Lifeblood", "of Lifeblood"); break;
        case IP_CONST_DAMAGETYPE_POSITIVE:    AddItemDescriptor(oItem, "Regulating", "of Regulation"); break;
        case IP_CONST_DAMAGETYPE_SONIC:       AddItemDescriptor(oItem, "Quieting", "of Quieting"); break;
    }

    IPSafeAddItemProperty(oItem, ip);
    //SendMessageToAllDMs("AddRandomDamageBonusVsAlign terminated with nLevel of " + IntToString(nLevel) + ".");
}

void AddRandomDamagePenalty(object oItem, int nLevel){
    nLevel = AveRandomizeLevel(nLevel);

    itemproperty ip = ItemPropertyDamagePenalty(nLevel);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    IPSafeAddItemProperty(oItem, ip);
    //SendMessageToAllDMs("AddRandomDamagePenalty terminated with nLevel of " + IntToString(nLevel) + ".");
}

void AddRandomDamageReduction(object oItem, int nLevel){
    nLevel = AveRandomizeLevel(nLevel);

    int nReduction = d2();

    itemproperty ip = ItemPropertyDamageReduction(nLevel, nReduction);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT, TRUE)) return;

    switch(nLevel){
        case 0: AddItemDescriptor(oItem, "Sturdy", "of Sturdiness"); break;
        case 1: AddItemDescriptor(oItem, "Resilient", "of Resilience"); break;
        case 2: AddItemDescriptor(oItem, "Unyielding", "of the Adamant"); break;
        case 3: AddItemDescriptor(oItem, "Impenetrable", "of Impenetrability"); break;
        case 4: AddItemDescriptor(oItem, "Invulnerable", "of Invulnerability"); break;
    }

    IPSafeAddItemProperty(oItem, ip);
}

void AddRandomDamageResistance(object oItem, int nLevel, int nType=-1){
    nLevel = AveRandomizeLevel(nLevel/2);

    if(nType == -1) nType = GetRandomDamageType();

    itemproperty ip = ItemPropertyDamageResistance(nType, nLevel);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    switch(nType){
        case IP_CONST_DAMAGETYPE_SLASHING:    AddItemDescriptor(oItem, "Armored", "of Armor"); break;
        case IP_CONST_DAMAGETYPE_PIERCING:    AddItemDescriptor(oItem, "Deflecting", "of Deflection"); break;
        case IP_CONST_DAMAGETYPE_BLUDGEONING: AddItemDescriptor(oItem, "Padded", "of Padding"); break;

        case IP_CONST_DAMAGETYPE_ACID:        AddItemDescriptor(oItem, "Neutralizing", "of Neutralizing"); break;
        case IP_CONST_DAMAGETYPE_COLD:        AddItemDescriptor(oItem, "Insulating", "of Warmth"); break;
        case IP_CONST_DAMAGETYPE_DIVINE:      AddItemDescriptor(oItem, "Earthly", "of Serenity"); break;
        case IP_CONST_DAMAGETYPE_ELECTRICAL:  AddItemDescriptor(oItem, "Grounding", "of Grounding"); break;
        case IP_CONST_DAMAGETYPE_FIRE:        AddItemDescriptor(oItem, "Cooling", "of Cooling"); break;
        case IP_CONST_DAMAGETYPE_MAGICAL:     AddItemDescriptor(oItem, "Arcane Defender", "of Arcane Defense"); break;
        case IP_CONST_DAMAGETYPE_NEGATIVE:    AddItemDescriptor(oItem, "Lifeblood", "of Lifeblood"); break;
        case IP_CONST_DAMAGETYPE_POSITIVE:    AddItemDescriptor(oItem, "Regulating", "of Regulation"); break;
        case IP_CONST_DAMAGETYPE_SONIC:       AddItemDescriptor(oItem, "Quieting", "of Quieting"); break;
    }

    IPSafeAddItemProperty(oItem, ip);
}

void AddRandomDamageVulnerability(object oItem, int nLevel, int nType=-1){
    nLevel = AveRandomizeLevel(floor(nLevel * 1.4));

    if(nType == -1) nType = GetRandomDamageType();

    itemproperty ip = ItemPropertyDamageVulnerability(nType, nLevel);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    IPSafeAddItemProperty(oItem, ip);
}

void AddRandomDecreaseAbility(object oItem, int nLevel, int nAbility=-1){
    nLevel = AveRandomizeLevel(nLevel);

    if(nAbility == -1) nAbility = GetRandomAbility();

    itemproperty ip = ItemPropertyDecreaseAbility(nAbility, nLevel);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    IPSafeAddItemProperty(oItem, ip);
}

void AddRandomDecreaseAC(object oItem, int nLevel){
    nLevel = AveRandomizeLevel(nLevel);

    itemproperty ip = ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_DODGE, nLevel);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    IPSafeAddItemProperty(oItem, ip);
}

void AddRandomEnhancementBonus(object oItem, int nLevel){
    nLevel = AveRandomizeLevel(nLevel);

    itemproperty ip = ItemPropertyEnhancementBonus(nLevel);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    switch(nLevel){
        case 1: AddItemDescriptor(oItem, "Enhanced", ""); break;
        case 2: AddItemDescriptor(oItem, "Bewitched", ""); break;
        case 3: AddItemDescriptor(oItem, "Enchanted", ""); break;
        case 4: AddItemDescriptor(oItem, "Ensorcelled", ""); break;
        case 5: AddItemDescriptor(oItem, "Eldritch", ""); break;
    }

    IPSafeAddItemProperty(oItem, ip);
    DoAddILRtoItem(oItem, nLevel);
}

void AddRandomEnhancementBonusVsAlign(object oItem, int nLevel, int nAlign=-1){
    nLevel = AveRandomizeLevel(nLevel);

    if(nAlign < 0) nAlign = GetRandomAlignment();

    itemproperty ip = ItemPropertyEnhancementBonusVsAlign(nAlign, nLevel);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    switch(nAlign){
        case IP_CONST_ALIGNMENTGROUP_CHAOTIC: AddItemDescriptor(oItem, "Chaosbane", "of Law"); break;
        case IP_CONST_ALIGNMENTGROUP_EVIL:    AddItemDescriptor(oItem, "Avenger's", "of Good"); break;
        case IP_CONST_ALIGNMENTGROUP_GOOD:    AddItemDescriptor(oItem, "Blackguard's", "of Evil"); break;
        case IP_CONST_ALIGNMENTGROUP_LAWFUL:  AddItemDescriptor(oItem, "Lawbreaker", "of Chaos"); break;
        case IP_CONST_ALIGNMENTGROUP_NEUTRAL: AddItemDescriptor(oItem, "Balancebreaker", "of Beliefs"); break;
    }

    IPSafeAddItemProperty(oItem, ip);
    DoAddILRtoItem(oItem, nLevel);
}

void AddRandomEnhancementBonusVsRace(object oItem, int nLevel, int nRace=-1){
    nLevel = AveRandomizeLevel(nLevel);

    if(nRace < 0) nRace = GetRandomRace();

    itemproperty ip = ItemPropertyEnhancementBonusVsRace(nRace, nLevel);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    IPSafeAddItemProperty(oItem, ip);
    DoAddILRtoItem(oItem, nLevel);
}

void AddRandomEnhancementPenalty(object oItem, int nLevel){
    nLevel = AveRandomizeLevel(nLevel);

    itemproperty ip = ItemPropertyEnhancementPenalty(nLevel);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    IPSafeAddItemProperty(oItem, ip);
}

void AddRandomExtraMeleeDamageType(object oItem){
    int nType = GetRandomDamageType(TRUE);

    itemproperty ip = ItemPropertyExtraMeleeDamageType(nType);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    switch(nType){
        case IP_CONST_DAMAGETYPE_SLASHING: AddItemDescriptor(oItem, "Bladed", "of Blades"); break;
        case IP_CONST_DAMAGETYPE_PIERCING: AddItemDescriptor(oItem, "Spiked", "of Piercing"); break;
        case IP_CONST_DAMAGETYPE_BLUDGEONING: AddItemDescriptor(oItem, "Blunted", "of Impacting"); break;
    }

    IPSafeAddItemProperty(oItem, ip);
}

void AddRandomExtraRangeDamageType(object oItem){
    int nType = GetRandomDamageType(TRUE);

    itemproperty ip = ItemPropertyExtraRangeDamageType(nType);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    switch(nType){
        case IP_CONST_DAMAGETYPE_SLASHING: AddItemDescriptor(oItem, "Slicing", "of Slicing"); break;
        case IP_CONST_DAMAGETYPE_PIERCING: AddItemDescriptor(oItem, "Barbed", "of Piercing"); break;
        case IP_CONST_DAMAGETYPE_BLUDGEONING: AddItemDescriptor(oItem, "Blunted", "of Impacting"); break;
    }

    IPSafeAddItemProperty(oItem, ip);
}

void AddRandomLight(object oItem, int nLevel){
    if(nLevel > 4) nLevel = 4;

    int nBrightness = AveRandomizeLevel(nLevel);
    int nColor = Random(7);

    itemproperty ip = ItemPropertyLight(nBrightness, nColor);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    AddItemDescriptor(oItem, "Glowing", "of Brightness");

    IPSafeAddItemProperty(oItem, ip);
}

void AddRandomLimitUseByAlign(object oItem){
    int nAlign = GetRandomAlignment();

    itemproperty ip = ItemPropertyLimitUseByAlign(nAlign);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    switch(nAlign){
        case IP_CONST_ALIGNMENTGROUP_CHAOTIC: AddItemDescriptor(oItem, "Rebel's", "of Chaos"); break;
        case IP_CONST_ALIGNMENTGROUP_EVIL:    AddItemDescriptor(oItem, "Dark", "of Evil"); break;
        case IP_CONST_ALIGNMENTGROUP_GOOD:    AddItemDescriptor(oItem, "Angel's", "of Good"); break;
        case IP_CONST_ALIGNMENTGROUP_LAWFUL:  AddItemDescriptor(oItem, "Lawman's", "of Law"); break;
        case IP_CONST_ALIGNMENTGROUP_NEUTRAL: AddItemDescriptor(oItem, "Even-Handed", "of Balance"); break;
    }

    IPSafeAddItemProperty(oItem, ip);
}

void AddRandomLimitUseByClass(object oItem){
    int nClass = GetRandomClass();

    itemproperty ip = ItemPropertyLimitUseByClass(nClass);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    switch(nClass){
        case IP_CONST_CLASS_BARBARIAN: AddItemDescriptor(oItem, "Barbarian's", "of the Barbarian"); break;
        case IP_CONST_CLASS_BARD:      AddItemDescriptor(oItem, "Bard's", "of the Bard"); break;
        case IP_CONST_CLASS_CLERIC:    AddItemDescriptor(oItem, "Cleric's", "of the Cleric"); break;
        case IP_CONST_CLASS_DRUID:     AddItemDescriptor(oItem, "Druid's", "of the Druid"); break;
        case IP_CONST_CLASS_FIGHTER:   AddItemDescriptor(oItem, "Fighter's", "of the Fighter"); break;
        case IP_CONST_CLASS_MONK:      AddItemDescriptor(oItem, "Monk's", "of the Monk"); break;
        case IP_CONST_CLASS_PALADIN:   AddItemDescriptor(oItem, "Paladin's", "of the Paladin"); break;
        case IP_CONST_CLASS_RANGER:    AddItemDescriptor(oItem, "Ranger's", "of the Ranger"); break;
        case IP_CONST_CLASS_ROGUE:     AddItemDescriptor(oItem, "Rogue's", "of the Rogue"); break;
        case IP_CONST_CLASS_SORCERER:  AddItemDescriptor(oItem, "Sorcerer's", "of the Sorcerer"); break;
        case IP_CONST_CLASS_WIZARD:    AddItemDescriptor(oItem, "Wizard's", "of the Wizard"); break;
    }

    IPSafeAddItemProperty(oItem, ip);
}

void AddRandomLimitUseByRace(object oItem){
    itemproperty ip = ItemPropertyLimitUseByRace(GetRandomRace(TRUE));

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    IPSafeAddItemProperty(oItem, ip);
}

void AddRandomMassiveCritical(object oItem, int nLevel){
    int nRoll;
    int nLevelILR;

    switch(nLevel){
        case 6: nRoll = AveRandomizeLevel(18)+1; break;
        case 5: nRoll = AveRandomizeLevel(16) + 1; break;
        case 4: nRoll = AveRandomizeLevel(14) + 1; break;
        case 3: nRoll = AveRandomizeLevel(10) + 1; break;
        case 2: nRoll = AveRandomizeLevel(8) + 1; break;
        case 1: nRoll = Random(4) + 1;  break;
    }

    switch(nRoll){
        case 1:  nLevel = IP_CONST_DAMAGEBONUS_1;    nLevelILR = 1; break;
        case 2:  nLevel = IP_CONST_DAMAGEBONUS_2;    nLevelILR = 1; break;
        case 3:  nLevel = IP_CONST_DAMAGEBONUS_1d4;  nLevelILR = 1; break;
        case 4:  nLevel = IP_CONST_DAMAGEBONUS_3;    nLevelILR = 1; break;
        case 5:  nLevel = IP_CONST_DAMAGEBONUS_1d6;  nLevelILR = 1; break;
        case 6:  nLevel = IP_CONST_DAMAGEBONUS_4;    nLevelILR = 2; break;
        case 7:  nLevel = IP_CONST_DAMAGEBONUS_1d8;  nLevelILR = 2; break;
        case 8:  nLevel = IP_CONST_DAMAGEBONUS_5;    nLevelILR = 2; break;
        case 9:  nLevel = IP_CONST_DAMAGEBONUS_2d4;  nLevelILR = 2; break;
        case 10: nLevel = IP_CONST_DAMAGEBONUS_1d10; nLevelILR = 3; break;
        case 11: nLevel = IP_CONST_DAMAGEBONUS_6;    nLevelILR = 3; break;
        case 12: nLevel = IP_CONST_DAMAGEBONUS_1d12; nLevelILR = 4; break;
        case 13: nLevel = IP_CONST_DAMAGEBONUS_7;    nLevelILR = 4; break;
        case 14: nLevel = IP_CONST_DAMAGEBONUS_2d6;  nLevelILR = 4; break;
        case 15: nLevel = IP_CONST_DAMAGEBONUS_8;    nLevelILR = 4; break;
        case 16: nLevel = IP_CONST_DAMAGEBONUS_2d8;  nLevelILR = 5; break;
        case 17: nLevel = IP_CONST_DAMAGEBONUS_9;    nLevelILR = 5; break;
        case 18: nLevel = IP_CONST_DAMAGEBONUS_10;   nLevelILR = 6; break;
        case 19: nLevel = IP_CONST_DAMAGEBONUS_4d4;  nLevelILR = 6; break;
    }

    itemproperty ip = ItemPropertyMassiveCritical(nLevel);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    switch(nRoll){
        case 1:  case 2:  case 3:  case 4:  AddItemDescriptor(oItem, "Bloody", "of Bleeding"); break;
        case 5:  case 6:  case 7:  case 8:  AddItemDescriptor(oItem, "Murderer's", "of Murder"); break;
        case 9:  case 10: case 11: case 12: AddItemDescriptor(oItem, "Devastating", "of Devastation"); break;
        case 13: case 14: case 15: case 16: AddItemDescriptor(oItem, "Vorpal", "of Slaying"); break;
    }

    IPSafeAddItemProperty(oItem, ip);
    //SendMessageToAllDMs("AddRandomDamageBonusVsAlign terminated with nLevelILR of " + IntToString(nLevelILR) + ".");
    //SendMessageToAllDMs("AddRandomDamageBonusVsAlign terminated with nLevel of " + IntToString(nLevel) + ".");
}

void AddRandomMaxRangeStrengthMod(object oItem, int nLevel){
    nLevel = AveRandomizeLevel(nLevel * 2) + 1;

    itemproperty ip = ItemPropertyMaxRangeStrengthMod(nLevel);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    IPSafeAddItemProperty(oItem, ip);
    //SendMessageToAllDMs("AddRandomMaxRangeStrengthMod terminated with nLevel of " + IntToString(nLevel) + ".");
}

void AddRandomReducedSavingThrow(object oItem, int nLevel, int nSave=-1){
    nLevel = AveRandomizeLevel(nLevel) + 1;

    if(nSave == -1) nSave = GetRandomSave();

    itemproperty ip = ItemPropertyReducedSavingThrow(nSave, nLevel);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    IPSafeAddItemProperty(oItem, ip);
}

void AddRandomReducedSavingThrowVsX(object oItem, int nLevel, int nType=-1){
    nLevel = AveRandomizeLevel(nLevel) + 1;

    if(nType == -1) nType = GetRandomSaveVs();

    itemproperty ip = ItemPropertyReducedSavingThrowVsX(nType, nLevel);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    IPSafeAddItemProperty(oItem, ip);
}

void AddRandomRegeneration(object oItem, int nLevel){
    nLevel = AveRandomizeLevel(nLevel / 6) + 1;

    itemproperty ip = ItemPropertyRegeneration(nLevel);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    switch(nLevel){
        case 1: AddItemDescriptor(oItem, "Healing", "of Healing");
                IPSafeAddItemProperty(oItem, ip);
                DoAddILRtoItem(oItem, nLevel + 1);
        break;
        case 2: AddItemDescriptor(oItem, "Regenerative", "of Regeneration");
                IPSafeAddItemProperty(oItem, ip);
                DoAddILRtoItem(oItem, nLevel + 2);
        break;
    }

    //IPSafeAddItemProperty(oItem, ip);
    //DoAddILRtoItem(oItem, nLevel);
    //SendMessageToAllDMs("AddRandomRegeneration terminated with nLevel of " + IntToString(nLevel) + ".");
}

const int NUM_SKILLS = 46;

void AddRandomSkillBonus(object oItem, int nLevel) {
    nLevel = Random(nLevel) + 1;

    int nRoll;
    int nBase = GetBaseItemType(oItem);
    if(nBase == BASE_ITEM_AMULET) nRoll = d2(2);
    else nRoll = d2();

    if(nLevel < 2) return;

    int nSkill = Random(NUM_SKILLS);

    if(nSkill == 8 || nSkill == 5) {
        itemproperty ip_ms = ItemPropertySkillBonus(8, nRoll);
        itemproperty ip_hide = ItemPropertySkillBonus(5, nRoll);
        itemproperty ip_stealth = ItemPropertySkillBonus(48, nRoll);

        if(IPGetItemHasProperty(oItem, ip_ms, DURATION_TYPE_PERMANENT)) return;
        if(IPGetItemHasProperty(oItem, ip_hide, DURATION_TYPE_PERMANENT)) return;
        if(IPGetItemHasProperty(oItem, ip_stealth, DURATION_TYPE_PERMANENT)) return;

        AddItemDescriptor(oItem, "Stealthy", "of Stealth");

        IPSafeAddItemProperty(oItem, ip_ms);
        IPSafeAddItemProperty(oItem, ip_hide);
        IPSafeAddItemProperty(oItem, ip_stealth);
        DoAddILRtoItem(oItem, 1);

        return;
    }

    if(nSkill == 6 || nSkill == 17) {
        itemproperty ip_spot = ItemPropertySkillBonus(17, nRoll);
        itemproperty ip_listen = ItemPropertySkillBonus(6, nRoll);
        itemproperty ip_perception = ItemPropertySkillBonus(49, nRoll);

        if(IPGetItemHasProperty(oItem, ip_spot, DURATION_TYPE_PERMANENT)) return;
        if(IPGetItemHasProperty(oItem, ip_listen, DURATION_TYPE_PERMANENT)) return;
        if(IPGetItemHasProperty(oItem, ip_perception, DURATION_TYPE_PERMANENT)) return;

        AddItemDescriptor(oItem, "Perceptive", "of Perception");

        IPSafeAddItemProperty(oItem, ip_spot);
        IPSafeAddItemProperty(oItem, ip_listen);
        IPSafeAddItemProperty(oItem, ip_perception);
        DoAddILRtoItem(oItem, 1);

        return;
    }

    itemproperty ip = ItemPropertySkillBonus(nSkill, nRoll);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    switch(nSkill) {
        case  0: AddItemDescriptor(oItem, "Empathic", "of Empathy"); break;
        case  1: AddItemDescriptor(oItem, "Focusing", "of Concentration"); break;
        case  2: AddItemDescriptor(oItem, "Trapspringers", "of Trapspringing"); break;
        case  3: AddItemDescriptor(oItem, "Disciplined", "of Discipline"); break;
        case  4: AddItemDescriptor(oItem, "Healers", "of Healing"); break;
        //case  5: AddItemDescriptor(oItem, "Stealthy", "of Stealth"); break;
        //case  6: AddItemDescriptor(oItem, "Listeners", "of Keen Hearing"); break;
        case  7: AddItemDescriptor(oItem, "Arcanists", "of Arcane Lore"); break;
        //case  8: AddItemDescriptor(oItem, "Sneaky", "of Silent Steps"); break;
        case  9: AddItemDescriptor(oItem, "Lockpicks", "of Lockpicking"); break;
        case 10: AddItemDescriptor(oItem, "Parrying", "of Parrying"); break;
        case 11: AddItemDescriptor(oItem, "Performers", "of Performance"); break;
        case 12: AddItemDescriptor(oItem, "Diplomats", "of Diplomacy"); break;
        case 13: AddItemDescriptor(oItem, "Cutpurses'", "of Purse-snatching"); break;
        case 14: AddItemDescriptor(oItem, "Inspectors", "of Searching"); break;
        case 15: AddItemDescriptor(oItem, "Trapsmiths", "of Snare-setting"); break;
        case 16: AddItemDescriptor(oItem, "Spellweavers", "of Spellcraft"); break;
        //case 17: AddItemDescriptor(oItem, "Sentries", "of Spotting"); break;
        case 18: AddItemDescriptor(oItem, "Knife-tongued", "of Taunting"); break;
        case 19: AddItemDescriptor(oItem, "Dweomerists", "of Magic-tinkering"); break;
        case 20: AddItemDescriptor(oItem, "Appraisers", "of Merchantry"); break;
        case 21: AddItemDescriptor(oItem, "Acrobatic", "of Acrobatics"); break;
        case 22: AddItemDescriptor(oItem, "Trapsmiths", "of Trapsmithing"); break;
        case 23: AddItemDescriptor(oItem, "Liars", "of Lies"); break;
        case 24: AddItemDescriptor(oItem, "Intimidating", "of Intimidation"); break;
        case 25: AddItemDescriptor(oItem, "Armorers", "of Armor-smithing"); break;
        case 26: AddItemDescriptor(oItem, "Weaponforgers", "of Weapon-smithing"); break;
        case 27: AddItemDescriptor(oItem, "Horsemans", "of Riding"); break;
        case 28: AddItemDescriptor(oItem, "Professionals", "of Tradecraft"); break;
        //case 29: AddItemDescriptor(oItem, "Socialites", "of Society"); break;
        //case 30: AddItemDescriptor(oItem, "Guides", "of Guiding"); break;
        case 31: AddItemDescriptor(oItem, "Informants", "of Information"); break;
        case 32: AddItemDescriptor(oItem, "Interrogators", "of Interrogation"); break;
        case 33: AddItemDescriptor(oItem, "Imposters", "of Masquerading"); break;
        case 34: AddItemDescriptor(oItem, "Forgers", "of Forgery"); break;
        case 35: AddItemDescriptor(oItem, "Escapists", "of Escape"); break;
        case 36: AddItemDescriptor(oItem, "Linguists", "of Linguistics"); break;
        case 37: AddItemDescriptor(oItem, "Engineers", "of Engineering"); break;
        //case 38: AddItemDescriptor(oItem, "Adventurers", "of Adventuring"); break;
        //case 39: AddItemDescriptor(oItem, "Cartographers", "of Path-mapping"); break;
        //case 40: AddItemDescriptor(oItem, "Historians", "of History"); break;
        //case 41: AddItemDescriptor(oItem, "Naturalists", "of Natural Lore"); break;
        case 42: AddItemDescriptor(oItem, "Religious", "of Religion"); break;
        //case 43: AddItemDescriptor(oItem, "Portalists", "of Dimensionality"); break;
        case 44: AddItemDescriptor(oItem, "Survivalists", "of Survival"); break;
        case 45: AddItemDescriptor(oItem, "Athletes", "of Athleticism"); break;
        default: break;
    }

    IPSafeAddItemProperty(oItem, ip);
    DoAddILRtoItem(oItem, 1);
    //SendMessageToAllDMs("AddRandomSkillBonus terminated with nLevel of " + IntToString(nLevel) + ".");
}

void AddRandomUnlimitedAmmo(object oItem, int nLevel, int nType=-1){
    int nRoll;
    int nLevelILR;

    switch(nLevel){
        case 1: nRoll = AveRandomizeLevel(1);
        case 2: nRoll = AveRandomizeLevel(2);
        case 3: nRoll = AveRandomizeLevel(3);
        case 4: nRoll = AveRandomizeLevel(4);
        case 5: nRoll = AveRandomizeLevel(8);
        case 6: nRoll = AveRandomizeLevel(9);
    }

    switch(nRoll){
        case 0: nLevel = IP_CONST_UNLIMITEDAMMO_BASIC;    nLevelILR = 1; break;
        case 1: nLevel = IP_CONST_UNLIMITEDAMMO_PLUS1;    nLevelILR = 1; break;
        case 2: nLevel = IP_CONST_UNLIMITEDAMMO_PLUS2;    nLevelILR = 2; break;
        case 3: nLevel = IP_CONST_UNLIMITEDAMMO_PLUS3;    nLevelILR = 3; break;
        case 4: nLevel = IP_CONST_UNLIMITEDAMMO_PLUS4;    nLevelILR = 4; break;
        case 5: nLevel = IP_CONST_UNLIMITEDAMMO_PLUS5;    nLevelILR = 5; break;
        case 6: nLevel = IP_CONST_UNLIMITEDAMMO_1D6COLD;  nLevelILR = 5; break;
        case 7: nLevel = IP_CONST_UNLIMITEDAMMO_1D6FIRE;  nLevelILR = 5; break;
        case 8: nLevel = IP_CONST_UNLIMITEDAMMO_1D6LIGHT; nLevelILR = 5; break;
        case 9: nLevel = IP_CONST_UNLIMITEDAMMO_PLUS5;    nLevelILR = 5; break;//Plus six unlimited ammo doesn't exist?
    }

    itemproperty ip = ItemPropertyUnlimitedAmmo(nLevel);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    IPSafeAddItemProperty(oItem, ip);
    DoAddILRtoItem(oItem, nLevelILR);
    //SendMessageToAllDMs("AddRandomUnlimitedAmmo terminated with nLevelILR of " + IntToString(nLevelILR) + ".");
    //SendMessageToAllDMs("AddRandomUnlimitedAmmo terminated with nLevel of " + IntToString(nLevel) + ".");
}

void AddRandomVampiricRegeneration(object oItem, int nLevel){
    nLevel = AveRandomizeLevel(nLevel-1) + 1;

    itemproperty ip = ItemPropertyVampiricRegeneration(nLevel * 2);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    AddItemDescriptor(oItem, "Vampire's", "of the Vampire");

    IPSafeAddItemProperty(oItem, ip);
    DoAddILRtoItem(oItem, nLevel - 1);
    //SendMessageToAllDMs("AddRandomVampiricRegeneration terminated with nLevel of " + IntToString(nLevel) + ".");
}

void AddRandomWeightIncrease(object oItem, int nLevel){
    nLevel = AveRandomizeLevel(nLevel + 1);

    itemproperty ip = ItemPropertyWeightIncrease(nLevel);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    IPSafeAddItemProperty(oItem, ip);
}

void AddRandomWeightReduction(object oItem, int nLevel){
    int nSubSelect = Random(nLevel) + 1;

    itemproperty ip = ItemPropertyWeightReduction(nSubSelect);

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    AddItemDescriptor(oItem, "Lightweight", "of Mobility");

    IPSafeAddItemProperty(oItem, ip);
}

void AddRandomKeen(object oItem){
    itemproperty ip = ItemPropertyKeen();

    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;

    AddItemDescriptor(oItem, "Keen", "of Slaying");

    IPSafeAddItemProperty(oItem, ip);
}

const int NUM_ONHIT_PROPS = 19;
const int NUM_DISEASES = 17;
const int NUM_POISONS = 6;
const int NUM_ABILITIES = 6;
const int NUM_DURATION_TYPES = 5;
int GetDiseaseName(int nRoll)
{
    int sDisease;
    switch (nRoll)
    {
        case 0:
            sDisease = DISEASE_BLINDING_SICKNESS;
        break;
        case 1:
            sDisease = DISEASE_CACKLE_FEVER;
        break;
        case 2:
            sDisease = DISEASE_DEVIL_CHILLS;
        break;
        case 3:
            sDisease = DISEASE_DEMON_FEVER;
        break;
        case 4:
            sDisease = DISEASE_FILTH_FEVER;
        break;
        case 5:
            sDisease = DISEASE_MINDFIRE;
        break;
        case 6:
            sDisease = DISEASE_MUMMY_ROT;
        break;
        case 7:
            sDisease = DISEASE_RED_ACHE;
        break;
        case 8:
            sDisease = DISEASE_SHAKES;
        break;
        case 9:
            sDisease = DISEASE_SLIMY_DOOM;
        break;
        case 10:
            sDisease = DISEASE_RED_SLAAD_EGGS;
        break;
        case 11:
            sDisease = DISEASE_GHOUL_ROT;
        break;
        case 12:
            sDisease = DISEASE_ZOMBIE_CREEP;
        break;
        case 13:
            sDisease = DISEASE_DREAD_BLISTERS;
        break;
        case 14:
            sDisease = DISEASE_BURROW_MAGGOTS;
        break;
        case 15:
            sDisease = DISEASE_SOLDIER_SHAKES;
        break;
        case 16:
            sDisease = DISEASE_VERMIN_MADNESS;
        break;
    }
    return sDisease;
}

int GetDurationType(int nRoll)
{
    int iDurationTypes;
    switch (nRoll)
    {
        case 0:
            iDurationTypes=IP_CONST_ONHIT_DURATION_5_PERCENT_5_ROUNDS;
        break;
        case 1:
            iDurationTypes=IP_CONST_ONHIT_DURATION_10_PERCENT_4_ROUNDS;
        break;
        case 2:
            iDurationTypes=IP_CONST_ONHIT_DURATION_25_PERCENT_3_ROUNDS;
        break;
        case 3:
            iDurationTypes=IP_CONST_ONHIT_DURATION_50_PERCENT_2_ROUNDS;
        break;
        case 4:
            iDurationTypes=IP_CONST_ONHIT_DURATION_75_PERCENT_1_ROUND;
        break;
    }
    return iDurationTypes;
}


void AddRandomOnHit(object oItem, int nLevel) {
    nLevel = AveRandomizeLevel(nLevel);
    int nRoll = Random(NUM_ONHIT_PROPS);

    itemproperty ip;

    switch(nLevel) {
        case 0: break;
        case 1: break;
        case 2:
            switch(nRoll) {
                case  0: // Doom
                    nRoll=Random(NUM_DURATION_TYPES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_DOOM,IP_CONST_ONHIT_SAVEDC_20,GetDurationType(nRoll));
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Doomed", "of Doom");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case  1: // Disease
                    nRoll = Random(NUM_DISEASES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_DISEASE, IP_CONST_ONHIT_SAVEDC_20,GetDiseaseName(nRoll));
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Diseased", "of Disease");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case  2: // Deafness
                    nRoll=Random(NUM_DURATION_TYPES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_DEAFNESS, IP_CONST_ONHIT_SAVEDC_20,GetDurationType(nRoll));
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Deafening", "of Deafness");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case  3: // Poison
                    nRoll = Random(NUM_POISONS);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_18, nRoll);
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Poisoned", "of Venom");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case  4: // Bestow Curse
                    ip = ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_BESTOW_CURSE, 14);
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Accursed", "of Hexing");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case  5: // Ability Drain
                    nRoll = Random(NUM_ABILITIES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON,IP_CONST_ONHIT_SAVEDC_18, nRoll);
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Draining", "of Draining");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case  6: // Wounding
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_WOUNDING, IP_CONST_ONHIT_SAVEDC_18);
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Bloodletting", "of Wounding");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case  7: // Slow
                    nRoll=Random(NUM_DURATION_TYPES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_SLOW, IP_CONST_ONHIT_SAVEDC_18, GetDurationType(nRoll));
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Slowing", "of Slowing");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case  8: // Level Drain
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_LEVELDRAIN, IP_CONST_ONHIT_SAVEDC_18);
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Draining", "of Draining");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case  9: // Lesser Dispel
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_LESSERDISPEL, IP_CONST_ONHIT_SAVEDC_18);
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Ward-stripping", "of Ward-stripping");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case 10: // Daze
                    nRoll=Random(NUM_DURATION_TYPES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_DAZE, IP_CONST_ONHIT_SAVEDC_16, GetDurationType(nRoll));
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Dazing", "of Dazing");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case 11: // Confusion
                    nRoll=Random(NUM_DURATION_TYPES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_CONFUSION, IP_CONST_ONHIT_SAVEDC_16, GetDurationType(nRoll));
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Mind-addling", "of Madness");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case 12: // Fear
                    nRoll=Random(NUM_DURATION_TYPES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_FEAR, IP_CONST_ONHIT_SAVEDC_16, GetDurationType(nRoll));
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Fearsome", "of Terror");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case 13: // Silence
                    nRoll=Random(NUM_DURATION_TYPES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_SILENCE, IP_CONST_ONHIT_SAVEDC_16, GetDurationType(nRoll));
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Silencing", "of Silence");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case 14: // Dispel Magic
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_DISPELMAGIC, IP_CONST_ONHIT_SAVEDC_16);
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Spell-breaking", "of Spell-breaking");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case 15: // Vorpal
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_VORPAL, IP_CONST_ONHIT_SAVEDC_16);
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Vorpal", "of Life-severing");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case 16: // Stun
                    break;
                case 17: // Hold
                    break;
                case 18: // Greater Dispel
                    break;
            }
            break;
        case 3:
            switch(nRoll) {
                case  0: // Doom
                    nRoll=Random(NUM_DURATION_TYPES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_DOOM, IP_CONST_ONHIT_SAVEDC_24, GetDurationType(nRoll));
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Doomed", "of Doom");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case  1: // Disease
                    nRoll = Random(NUM_DISEASES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_DISEASE, IP_CONST_ONHIT_SAVEDC_24, GetDiseaseName(nRoll));
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Diseased", "of Disease");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case  2: // Deafness
                    nRoll=Random(NUM_DURATION_TYPES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_DEAFNESS, IP_CONST_ONHIT_SAVEDC_24, GetDurationType(nRoll));
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Deafening", "of Deafness");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case  3: // Poison
                    nRoll = Random(NUM_POISONS);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_DISEASE, IP_CONST_ONHIT_SAVEDC_22, nRoll);
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Poisoned", "of Venom");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case  4: // Bestow Curse
                    ip = ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_BESTOW_CURSE, 18);
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Accursed", "of Hexing");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case  5: // Ability Drain
                    nRoll = Random(NUM_ABILITIES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON, IP_CONST_ONHIT_SAVEDC_22, nRoll);
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Draining", "of Draining");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case  6: // Wounding
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_WOUNDING, IP_CONST_ONHIT_SAVEDC_22);
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Bloodletting", "of Wounding");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case  7: // Slow
                    nRoll=Random(NUM_DURATION_TYPES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_SLOW, IP_CONST_ONHIT_SAVEDC_20, GetDurationType(nRoll));
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Slowing", "of Slowing");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case  8: // Level Drain
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_LEVELDRAIN, IP_CONST_ONHIT_SAVEDC_20);
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Draining", "of Draining");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case  9: // Lesser Dispel
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_LESSERDISPEL, IP_CONST_ONHIT_SAVEDC_20);
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Ward-stripping", "of Ward-stripping");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case 10: // Daze
                    nRoll=Random(NUM_DURATION_TYPES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_DAZE, IP_CONST_ONHIT_SAVEDC_20, GetDurationType(nRoll));
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Dazing", "of Dazing");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case 11: // Confusion
                    nRoll=Random(NUM_DURATION_TYPES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_CONFUSION, IP_CONST_ONHIT_SAVEDC_18, GetDurationType(nRoll));
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Mind-addling", "of Madness");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case 12: // Fear
                    nRoll=Random(NUM_DURATION_TYPES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_FEAR, IP_CONST_ONHIT_SAVEDC_18, GetDurationType(nRoll));
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Fearsome", "of Terror");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case 13: // Silence
                    nRoll=Random(NUM_DURATION_TYPES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_SILENCE, IP_CONST_ONHIT_SAVEDC_18, GetDurationType(nRoll));
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Silencing", "of Silence");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case 14: // Dispel Magic
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_DISPELMAGIC, IP_CONST_ONHIT_SAVEDC_18);
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Spell-breaking", "of Spell-breaking");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case 15: // Vorpal
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_VORPAL, IP_CONST_ONHIT_SAVEDC_18);
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Vorpal", "of Life-severing");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case 16: // Stun
                    nRoll=Random(NUM_DURATION_TYPES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_STUN, IP_CONST_ONHIT_SAVEDC_14, GetDurationType(nRoll));
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Stunning", "of Stunning");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case 17: // Hold
                    nRoll=Random(NUM_DURATION_TYPES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_HOLD, IP_CONST_ONHIT_SAVEDC_14, GetDurationType(nRoll));
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Paralyzing", "of Holding");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case 18: // Greater Dispel
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_GREATERDISPEL, IP_CONST_ONHIT_SAVEDC_14);
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Magic-rending", "of Magic-rending");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
            }
            break;
        case 4:
            switch(nRoll) {
                case  0: // Doom
                    nRoll=Random(NUM_DURATION_TYPES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_DOOM, IP_CONST_ONHIT_SAVEDC_26, GetDurationType(nRoll));
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Doomed", "of Doom");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case  1: // Disease
                    nRoll = Random(NUM_DISEASES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_DISEASE, IP_CONST_ONHIT_SAVEDC_26, GetDiseaseName(nRoll));
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Diseased", "of Disease");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case  2: // Deafness
                    nRoll=Random(NUM_DURATION_TYPES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_DEAFNESS, IP_CONST_ONHIT_SAVEDC_26, GetDurationType(nRoll));
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Deafening", "of Deafness");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case  3: // Poison
                    nRoll = Random(NUM_POISONS);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_DISEASE, IP_CONST_ONHIT_SAVEDC_24, nRoll);
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Poisoned", "of Venom");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case  4: // Bestow Curse
                    ip = ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_BESTOW_CURSE, 20);
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Accursed", "of Hexing");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case  5: // Ability Drain
                    nRoll = Random(NUM_ABILITIES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON, IP_CONST_ONHIT_SAVEDC_24, nRoll);
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Draining", "of Draining");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case  6: // Wounding
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_WOUNDING, IP_CONST_ONHIT_SAVEDC_24);
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Bloodletting", "of Wounding");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case  7: // Slow
                    nRoll=Random(NUM_DURATION_TYPES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_SLOW, IP_CONST_ONHIT_SAVEDC_24, GetDurationType(nRoll));
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Slowing", "of Slowing");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case  8: // Level Drain
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_LEVELDRAIN, IP_CONST_ONHIT_SAVEDC_24);
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Draining", "of Draining");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case  9: // Lesser Dispel
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_LESSERDISPEL, IP_CONST_ONHIT_SAVEDC_24);
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Ward-stripping", "of Ward-stripping");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case 10: // Daze
                    nRoll=Random(NUM_DURATION_TYPES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_DAZE, IP_CONST_ONHIT_SAVEDC_20, GetDurationType(nRoll));
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Dazing", "of Dazing");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case 11: // Confusion
                    nRoll=Random(NUM_DURATION_TYPES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_CONFUSION,IP_CONST_ONHIT_SAVEDC_20, GetDurationType(nRoll));
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Mind-addling", "of Madness");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case 12: // Fear
                    nRoll=Random(NUM_DURATION_TYPES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_FEAR, IP_CONST_ONHIT_SAVEDC_20, GetDurationType(nRoll));
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Fearsome", "of Terror");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case 13: // Silence
                    nRoll=Random(NUM_DURATION_TYPES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_SILENCE, IP_CONST_ONHIT_SAVEDC_20, GetDurationType(nRoll));
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Silencing", "of Silence");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case 14: // Dispel Magic
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_DISPELMAGIC, IP_CONST_ONHIT_SAVEDC_20);
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Spell-breaking", "of Spell-breaking");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case 15: // Vorpal
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_VORPAL, IP_CONST_ONHIT_SAVEDC_20);
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Vorpal", "of Life-severing");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case 16: // Stun
                    nRoll=Random(NUM_DURATION_TYPES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_STUN, IP_CONST_ONHIT_SAVEDC_16, GetDurationType(nRoll));
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Stunning", "of Stunning");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case 17: // Hold
                    nRoll=Random(NUM_DURATION_TYPES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_HOLD, IP_CONST_ONHIT_SAVEDC_16, GetDurationType(nRoll));
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Paralyzing", "of Holding");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case 18: // Greater Dispel
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_GREATERDISPEL, IP_CONST_ONHIT_SAVEDC_16);
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Magic-rending", "of Magic-rending");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
            }
            break;
        case 5:
            switch(nRoll) {
                case  0: // Doom
                    break;
                case  1: // Disease
                    break;
                case  2: // Deafness
                    break;
                case  3: // Poison
                    nRoll = Random(NUM_POISONS);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_DISEASE, IP_CONST_ONHIT_SAVEDC_26, nRoll);
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Poisoned", "of Venom");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case  4: // Bestow Curse
                    ip = ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_BESTOW_CURSE, 24);
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Accursed", "of Hexing");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case  5: // Ability Drain
                    nRoll = Random(NUM_ABILITIES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_ITEMPOISON, IP_CONST_ONHIT_SAVEDC_26, nRoll);
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Draining", "of Draining");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case  6: // Wounding
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_WOUNDING, IP_CONST_ONHIT_SAVEDC_26);
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Bloodletting", "of Wounding");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case  7: // Slow
                    nRoll=Random(NUM_DURATION_TYPES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_SLOW, IP_CONST_ONHIT_SAVEDC_26, GetDurationType(nRoll));
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Slowing", "of Slowing");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case  8: // Level Drain
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_LEVELDRAIN, IP_CONST_ONHIT_SAVEDC_26);
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Draining", "of Draining");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case  9: // Lesser Dispel
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_LESSERDISPEL, IP_CONST_ONHIT_SAVEDC_26);
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Ward-stripping", "of Ward-stripping");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case 10: // Daze
                    nRoll=Random(NUM_DURATION_TYPES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_DAZE, IP_CONST_ONHIT_SAVEDC_22, GetDurationType(nRoll));
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Dazing", "of Dazing");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case 11: // Confusion
                    nRoll=Random(NUM_DURATION_TYPES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_CONFUSION, IP_CONST_ONHIT_SAVEDC_22, GetDurationType(nRoll));
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Mind-addling", "of Madness");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case 12: // Fear
                    nRoll=Random(NUM_DURATION_TYPES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_FEAR, IP_CONST_ONHIT_SAVEDC_22, GetDurationType(nRoll));
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Fearsome", "of Terror");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case 13: // Silence
                    nRoll=Random(NUM_DURATION_TYPES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_SILENCE, IP_CONST_ONHIT_SAVEDC_22, GetDurationType(nRoll));
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Silencing", "of Silence");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case 14: // Dispel Magic
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_DISPELMAGIC, IP_CONST_ONHIT_SAVEDC_22);
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Spell-breaking", "of Spell-breaking");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case 15: // Vorpal
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_VORPAL, IP_CONST_ONHIT_SAVEDC_22);
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Vorpal", "of Life-severing");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case 16: // Stun
                    nRoll=Random(NUM_DURATION_TYPES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_STUN, IP_CONST_ONHIT_SAVEDC_18, GetDurationType(nRoll));
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Stunning", "of Stunning");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case 17: // Hold
                    nRoll=Random(NUM_DURATION_TYPES);
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_HOLD, IP_CONST_ONHIT_SAVEDC_18, GetDurationType(nRoll));
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Paralyzing", "of Holding");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
                case 18: // Greater Dispel
                    ip = ItemPropertyOnHitProps(IP_CONST_ONHIT_GREATERDISPEL, IP_CONST_ONHIT_SAVEDC_18);
                    if(IPGetItemHasProperty(oItem, ip, DURATION_TYPE_PERMANENT)) return;
                    AddItemDescriptor(oItem, "Magic-rending", "of Magic-rending");
                    IPSafeAddItemProperty(oItem, ip);
                    break;
            }
            break;
        default: break;
    }

    DoAddILRtoItem(oItem, nLevel);
    //SendMessageToAllDMs("AddRandomOnHit terminated with nLevel of " + IntToString(nLevel) + ".");
}

//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

int GetRandomAbility(){
    return Random(6);
}

int GetRandomAlignment(){
    return Random(5) + 1;
}

int GetRandomClass(){
    return Random(11);
}

int GetRandomDamageType(int nPhysicalOnly=FALSE){
    if(nPhysicalOnly) return Random(3);

    int nType = Random(11);
    if(nType > 2) nType += 2;

    return nType;
}

int GetRandomRace(int nPlayableOnly=FALSE){
    if(nPlayableOnly) return Random(7);

    return Random(26);
}

int GetRandomSave(){
    return Random(3);
}

int GetRandomSaveVs(){
    return Random(15) + 1;
}
