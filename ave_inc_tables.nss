#include "engine"

//Gets the spellbook class abbreviation for spells.2da from a class constant
//Returns "Innate" if nConstant is not a valid spellcasting class.
string GetSpellTableFromClassConstant(int nConstant)
{
    switch(nConstant)
    {
    case CLASS_TYPE_WIZARD: case CLASS_TYPE_SORCERER: return "Wiz_Sorc";
    case CLASS_TYPE_BARD: return "Bard";
    case CLASS_TYPE_DRUID: return "Druid";
    case CLASS_TYPE_CLERIC: return "Cleric";
    case CLASS_TYPE_RANGER: return "Ranger";
    case CLASS_TYPE_PALADIN: return "Paladin";
    }
    return "Innate";
}

//Takes a value from 1 to 20 and returns an equivilant DAMAGE_BONUS value.
//Valid inputs are 1-20. Return value on error: DAMAGE_BONUS_1
int GetDamageConstFromDamageAmount(int nAmount)
{
    if(nAmount==1) return DAMAGE_BONUS_1;
    if(nAmount==2) return DAMAGE_BONUS_2;
    if(nAmount==3) return DAMAGE_BONUS_3;
    if(nAmount==4) return DAMAGE_BONUS_4;
    if(nAmount==5) return DAMAGE_BONUS_5;
    if(nAmount==6) return DAMAGE_BONUS_6;
    if(nAmount==7) return DAMAGE_BONUS_7;
    if(nAmount==8) return DAMAGE_BONUS_8;
    if(nAmount==9) return DAMAGE_BONUS_9;
    if(nAmount==10) return DAMAGE_BONUS_10;
    if(nAmount==11) return DAMAGE_BONUS_11;
    if(nAmount==12) return DAMAGE_BONUS_12;
    if(nAmount==13) return DAMAGE_BONUS_13;
    if(nAmount==14) return DAMAGE_BONUS_14;
    if(nAmount==15) return DAMAGE_BONUS_15;
    if(nAmount==16) return DAMAGE_BONUS_16;
    if(nAmount==17) return DAMAGE_BONUS_17;
    if(nAmount==18) return DAMAGE_BONUS_18;
    if(nAmount==19) return DAMAGE_BONUS_19;
    if(nAmount==20) return DAMAGE_BONUS_20;
    else return DAMAGE_BONUS_1;
}

//Get Damage from IP_CONST_DAMAGEBONUS.
int GetDamageFromDamageBonusConst(int iConst)
{
    switch(iConst)
    {
        case IP_CONST_DAMAGEBONUS_1: return 1;
        case IP_CONST_DAMAGEBONUS_2: return 2;
        case IP_CONST_DAMAGEBONUS_3: return 3;
        case IP_CONST_DAMAGEBONUS_4: return 4;
        case IP_CONST_DAMAGEBONUS_5: return 5;
        case IP_CONST_DAMAGEBONUS_6: return 6;
        case IP_CONST_DAMAGEBONUS_7: return 7;
        case IP_CONST_DAMAGEBONUS_8: return 8;
        case IP_CONST_DAMAGEBONUS_9: return 9;
        case IP_CONST_DAMAGEBONUS_10: return 10;
        case IP_CONST_DAMAGEBONUS_11: return 11;
        case IP_CONST_DAMAGEBONUS_12: return 12;
        case IP_CONST_DAMAGEBONUS_13: return 13;
        case IP_CONST_DAMAGEBONUS_14: return 14;
        case IP_CONST_DAMAGEBONUS_15: return 15;
        case IP_CONST_DAMAGEBONUS_16: return 16;
        case IP_CONST_DAMAGEBONUS_17: return 17;
        case IP_CONST_DAMAGEBONUS_18: return 18;
        case IP_CONST_DAMAGEBONUS_19: return 19;
        case IP_CONST_DAMAGEBONUS_20: return 20;
        case IP_CONST_DAMAGEBONUS_1d4: return d4(1);
        case IP_CONST_DAMAGEBONUS_2d4: return d4(2);
        case IP_CONST_DAMAGEBONUS_3d4: return d4(3);
        case IP_CONST_DAMAGEBONUS_4d4: return d4(4);
        case IP_CONST_DAMAGEBONUS_5d4: return d4(5);
        case IP_CONST_DAMAGEBONUS_6d4: return d4(6);
        case IP_CONST_DAMAGEBONUS_7d4: return d4(7);
        case IP_CONST_DAMAGEBONUS_8d4: return d4(8);
        case IP_CONST_DAMAGEBONUS_9d4: return d4(9);
        case IP_CONST_DAMAGEBONUS_10d4: return d4(10);
        case IP_CONST_DAMAGEBONUS_11d4: return d4(11);
        case IP_CONST_DAMAGEBONUS_12d4: return d4(12);
        case IP_CONST_DAMAGEBONUS_13d4: return d4(13);
        case IP_CONST_DAMAGEBONUS_14d4: return d4(14);
        case IP_CONST_DAMAGEBONUS_15d4: return d4(15);
        case IP_CONST_DAMAGEBONUS_16d4: return d4(16);
        case IP_CONST_DAMAGEBONUS_17d4: return d4(17);
        case IP_CONST_DAMAGEBONUS_18d4: return d4(18);
        case IP_CONST_DAMAGEBONUS_19d4: return d4(19);
        case IP_CONST_DAMAGEBONUS_20d4: return d4(20);
        case IP_CONST_DAMAGEBONUS_1d6: return d6(1);
        case IP_CONST_DAMAGEBONUS_2d6: return d6(2);
        case IP_CONST_DAMAGEBONUS_3d6: return d6(3);
        case IP_CONST_DAMAGEBONUS_4d6: return d6(4);
        case IP_CONST_DAMAGEBONUS_5d6: return d6(5);
        case IP_CONST_DAMAGEBONUS_6d6: return d6(6);
        case IP_CONST_DAMAGEBONUS_7d6: return d6(7);
        case IP_CONST_DAMAGEBONUS_8d6: return d6(8);
        case IP_CONST_DAMAGEBONUS_9d6: return d6(9);
        case IP_CONST_DAMAGEBONUS_10d6: return d6(10);
        case IP_CONST_DAMAGEBONUS_11d6: return d6(11);
        case IP_CONST_DAMAGEBONUS_12d6: return d6(12);
        case IP_CONST_DAMAGEBONUS_13d6: return d6(13);
        case IP_CONST_DAMAGEBONUS_14d6: return d6(14);
        case IP_CONST_DAMAGEBONUS_15d6: return d6(15);
        case IP_CONST_DAMAGEBONUS_16d6: return d6(16);
        case IP_CONST_DAMAGEBONUS_17d6: return d6(17);
        case IP_CONST_DAMAGEBONUS_18d6: return d6(18);
        case IP_CONST_DAMAGEBONUS_19d6: return d6(19);
        case IP_CONST_DAMAGEBONUS_20d6: return d6(20);
        case IP_CONST_DAMAGEBONUS_1d8: return d8(1);
        case IP_CONST_DAMAGEBONUS_2d8: return d8(2);
        case IP_CONST_DAMAGEBONUS_3d8: return d8(3);
        case IP_CONST_DAMAGEBONUS_4d8: return d8(4);
        case IP_CONST_DAMAGEBONUS_5d8: return d8(5);
        case IP_CONST_DAMAGEBONUS_6d8: return d8(6);
        case IP_CONST_DAMAGEBONUS_7d8: return d8(7);
        case IP_CONST_DAMAGEBONUS_8d8: return d8(8);
        case IP_CONST_DAMAGEBONUS_9d8: return d8(9);
        case IP_CONST_DAMAGEBONUS_10d8: return d8(10);
        case IP_CONST_DAMAGEBONUS_11d8: return d8(11);
        case IP_CONST_DAMAGEBONUS_12d8: return d8(12);
        case IP_CONST_DAMAGEBONUS_13d8: return d8(13);
        case IP_CONST_DAMAGEBONUS_14d8: return d8(14);
        case IP_CONST_DAMAGEBONUS_15d8: return d8(15);
        case IP_CONST_DAMAGEBONUS_16d8: return d8(16);
        case IP_CONST_DAMAGEBONUS_17d8: return d8(17);
        case IP_CONST_DAMAGEBONUS_18d8: return d8(18);
        case IP_CONST_DAMAGEBONUS_19d8: return d8(19);
        case IP_CONST_DAMAGEBONUS_20d8: return d8(20);
        case IP_CONST_DAMAGEBONUS_1d10: return d10(1);
        case IP_CONST_DAMAGEBONUS_2d10: return d10(2);
        case IP_CONST_DAMAGEBONUS_3d10: return d10(3);
        case IP_CONST_DAMAGEBONUS_4d10: return d10(4);
        case IP_CONST_DAMAGEBONUS_5d10: return d10(5);
        case IP_CONST_DAMAGEBONUS_6d10: return d10(6);
        case IP_CONST_DAMAGEBONUS_7d10: return d10(7);
        case IP_CONST_DAMAGEBONUS_8d10: return d10(8);
        case IP_CONST_DAMAGEBONUS_9d10: return d10(9);
        case IP_CONST_DAMAGEBONUS_10d10: return d10(10);
        case IP_CONST_DAMAGEBONUS_11d10: return d10(11);
        case IP_CONST_DAMAGEBONUS_12d10: return d10(12);
        case IP_CONST_DAMAGEBONUS_13d10: return d10(13);
        case IP_CONST_DAMAGEBONUS_14d10: return d10(14);
        case IP_CONST_DAMAGEBONUS_15d10: return d10(15);
        case IP_CONST_DAMAGEBONUS_16d10: return d10(16);
        case IP_CONST_DAMAGEBONUS_17d10: return d10(17);
        case IP_CONST_DAMAGEBONUS_18d10: return d10(18);
        case IP_CONST_DAMAGEBONUS_19d10: return d10(19);
        case IP_CONST_DAMAGEBONUS_20d10: return d10(20);
        case IP_CONST_DAMAGEBONUS_1d12: return d12(1);
        case IP_CONST_DAMAGEBONUS_2d12: return d12(2);
        case IP_CONST_DAMAGEBONUS_3d12: return d12(3);
        case IP_CONST_DAMAGEBONUS_4d12: return d12(4);
        case IP_CONST_DAMAGEBONUS_5d12: return d12(5);
        case IP_CONST_DAMAGEBONUS_6d12: return d12(6);
        case IP_CONST_DAMAGEBONUS_7d12: return d12(7);
        case IP_CONST_DAMAGEBONUS_8d12: return d12(8);
        case IP_CONST_DAMAGEBONUS_9d12: return d12(9);
        case IP_CONST_DAMAGEBONUS_10d12: return d12(10);
        case IP_CONST_DAMAGEBONUS_11d12: return d12(11);
        case IP_CONST_DAMAGEBONUS_12d12: return d12(12);
        case IP_CONST_DAMAGEBONUS_13d12: return d12(13);
        case IP_CONST_DAMAGEBONUS_14d12: return d12(14);
        case IP_CONST_DAMAGEBONUS_15d12: return d12(15);
        case IP_CONST_DAMAGEBONUS_16d12: return d12(16);
        case IP_CONST_DAMAGEBONUS_17d12: return d12(17);
        case IP_CONST_DAMAGEBONUS_18d12: return d12(18);
        case IP_CONST_DAMAGEBONUS_19d12: return d12(19);
        case IP_CONST_DAMAGEBONUS_20d12: return d12(20);
        //Interestingly, 1d20 and 2d20 don't exist in our haks.
        case IP_CONST_DAMAGEBONUS_3d20: return d20(3);
        case IP_CONST_DAMAGEBONUS_4d20: return d20(4);
        case IP_CONST_DAMAGEBONUS_5d20: return d20(5);
        case IP_CONST_DAMAGEBONUS_6d20: return d20(6);
        case IP_CONST_DAMAGEBONUS_7d20: return d20(7);
        case IP_CONST_DAMAGEBONUS_8d20: return d20(8);
        case IP_CONST_DAMAGEBONUS_9d20: return d20(9);
        case IP_CONST_DAMAGEBONUS_10d20: return d20(10);
        case IP_CONST_DAMAGEBONUS_11d20: return d20(11);
        case IP_CONST_DAMAGEBONUS_12d20: return d20(12);
        case IP_CONST_DAMAGEBONUS_13d20: return d20(13);
        case IP_CONST_DAMAGEBONUS_14d20: return d20(14);
        case IP_CONST_DAMAGEBONUS_15d20: return d20(15);
        case IP_CONST_DAMAGEBONUS_16d20: return d20(16);
        case IP_CONST_DAMAGEBONUS_17d20: return d20(17);
        case IP_CONST_DAMAGEBONUS_18d20: return d20(18);
        case IP_CONST_DAMAGEBONUS_19d20: return d20(19);
        case IP_CONST_DAMAGEBONUS_20d20: return d20(20);
    }
    return 0;
}

int GetNonMonkUnarmedBaseDamage(object oAtt)
{
    int iSize=GetCreatureSize(oAtt);
    if (iSize==CREATURE_SIZE_SMALL) return d2(1);
    return d3(1);
}

//Get Monk Unarmed Damage
int GetMonkUnarmedBaseDamage(object oMonk)
{
    int iSize=GetCreatureSize(oMonk);
    if(iSize==CREATURE_SIZE_SMALL)
    {
        if(GetLevelByClass(CLASS_TYPE_MONK,oMonk)>15) return d6(2);
        else if(GetLevelByClass(CLASS_TYPE_MONK,oMonk)>11) return d10(1);
        else if(GetLevelByClass(CLASS_TYPE_MONK,oMonk)>7) return d8(1);
        else if(GetLevelByClass(CLASS_TYPE_MONK,oMonk)>3) return d6(1);
        else return d4(1);
    }
    else if(iSize==CREATURE_SIZE_MEDIUM)
    {
        if(GetLevelByClass(CLASS_TYPE_MONK,oMonk)>15) return d20(1);
        else if(GetLevelByClass(CLASS_TYPE_MONK,oMonk)>11) return d12(1);
        else if(GetLevelByClass(CLASS_TYPE_MONK,oMonk)>7) return d10(1);
        else if(GetLevelByClass(CLASS_TYPE_MONK,oMonk)>3) return d8(1);
        else return d6(1);
    }
    return 0;
}

//Returns a spell school from a one-letter abbreviation
int GetSpellSchoolIntFromAbbreviation(string sAbbreviate)
{
    if(sAbbreviate=="A") return SPELL_SCHOOL_ABJURATION;
    if(sAbbreviate=="C") return SPELL_SCHOOL_CONJURATION;
    if(sAbbreviate=="D") return SPELL_SCHOOL_DIVINATION;
    if(sAbbreviate=="E") return SPELL_SCHOOL_ENCHANTMENT;
    if(sAbbreviate=="V") return SPELL_SCHOOL_EVOCATION;
    if(sAbbreviate=="I") return SPELL_SCHOOL_ILLUSION;
    if(sAbbreviate=="N") return SPELL_SCHOOL_NECROMANCY;
    if(sAbbreviate=="T") return SPELL_SCHOOL_TRANSMUTATION;
    return SPELL_SCHOOL_GENERAL;
}

//Rolls nDice dice, each with nFaces faces
int GetGeneralDiceRoll(int nDice,int nFaces)
{
    int iTot=0;
    while(nDice>0)
    {
        iTot=iTot+Random(nFaces)+1;
        nDice=nDice-1;
    }
    return iTot;
}

int GetItemSlotFromAmmoBaseType(int iAmmoType)
{
    switch(iAmmoType)
    {
        case 1: return INVENTORY_SLOT_ARROWS;
        case 2: return INVENTORY_SLOT_BOLTS;
        case 3: return INVENTORY_SLOT_BULLETS;
    }
    return -1;
}

string CraftingBaseItemTo2daColumn(int BaseItemType)
{
    switch(BaseItemType)
    {
        case BASE_ITEM_AMULET: return "16_Misc";
        case BASE_ITEM_ARMOR: return "6_Arm_Shld";
        case BASE_ITEM_ARROW: return "5_Ammo";
        case BASE_ITEM_BASTARDSWORD: return "0_Melee";
        case BASE_ITEM_BATTLEAXE: return "0_Melee";
        case BASE_ITEM_BELT: return "16_Misc";
        case BASE_ITEM_BOLT: return "5_Ammo";
        case BASE_ITEM_BOOTS: return "16_Misc";
        case BASE_ITEM_BRACER: return "16_Misc";
        case BASE_ITEM_BULLET: return "5_Ammo";
        case BASE_ITEM_CLOAK: return "16_Misc";
        case BASE_ITEM_CLUB: return "0_Melee";
        case BASE_ITEM_DAGGER: return "0_Melee";
        case BASE_ITEM_DART: return "2_Thrown";
        case BASE_ITEM_DIREMACE: return "0_Melee";
        case BASE_ITEM_DOUBLEAXE: return "0_Melee";
        case BASE_ITEM_DWARVENWARAXE: return "0_Melee";
        case BASE_ITEM_GLOVES: return "21_Glove";
        case BASE_ITEM_GREATAXE: return "0_Melee";
        case BASE_ITEM_GREATSWORD: return "0_Melee";
        case BASE_ITEM_HALBERD: return "0_Melee";
        case BASE_ITEM_HANDAXE: return "0_Melee";
        case BASE_ITEM_HEAVYCROSSBOW: return "1_Ranged";
        case BASE_ITEM_HEAVYFLAIL: return "0_Melee";
        case BASE_ITEM_HELMET: return "7_Helm";
        case BASE_ITEM_KAMA: return "0_Melee";
        case BASE_ITEM_KATANA: return "0_Melee";
        case BASE_ITEM_KUKRI: return "0_Melee";
        case BASE_ITEM_LARGESHIELD: return "6_Arm_Shld";
        case BASE_ITEM_LIGHTCROSSBOW: return "1_Ranged";
        case BASE_ITEM_LIGHTFLAIL: return "0_Melee";
        case BASE_ITEM_LIGHTHAMMER: return "0_Melee";
        case BASE_ITEM_LIGHTMACE: return "0_Melee";
        case BASE_ITEM_LONGBOW: return "1_Ranged";
        case BASE_ITEM_LONGSWORD: return "0_Melee";
        case BASE_ITEM_MAGICSTAFF: return "3_Staves";
        case BASE_ITEM_MORNINGSTAR: return "0_Melee";
        case BASE_ITEM_QUARTERSTAFF: return "0_Melee";
        case BASE_ITEM_RAPIER: return "0_Melee";
        case BASE_ITEM_RING: return "16_Misc";
        case BASE_ITEM_SCIMITAR: return "0_Melee";
        case BASE_ITEM_SCYTHE: return "0_Melee";
        case BASE_ITEM_SHORTBOW: return "1_Ranged";
        case BASE_ITEM_SHORTSPEAR: return "0_Melee";
        case BASE_ITEM_SHORTSWORD: return "0_Melee";
        case BASE_ITEM_SHURIKEN: return "2_Thrown";
        case BASE_ITEM_SICKLE: return "0_Melee";
        case BASE_ITEM_SLING: return "1_Ranged";
        case BASE_ITEM_SMALLSHIELD: return "6_Arm_Shld";
        case BASE_ITEM_THROWINGAXE: return "2_Thrown";
        case BASE_ITEM_TOWERSHIELD: return "6_Arm_Shld";
        case BASE_ITEM_TRIDENT: return "0_Melee";
        case BASE_ITEM_TWOBLADEDSWORD: return "0_Melee";
        case BASE_ITEM_WARHAMMER: return "0_Melee";
        case BASE_ITEM_WHIP: return "0_Melee";
        case 301: return "0_Melee";//heavy pick
        case 302: return "0_Melee";//light pick
        case 303: return "0_Melee";//sai
        case 304: return "0_Melee";//nunchaku
        case 305: return "0_Melee";//falchoin
        case 308: return "0_Melee";//sap
        case 309: return "0_Melee";//assassin dagger
        case 310: return "0_Melee";//katar
        case 317: return "0_Melee";//heavy mace
        case 318: return "0_Melee";//maul
        case 322: return "0_Melee";//goad
        case 323: return "0_Melee";//wind fire wheel
        case 324: return "0_Melee";//maug double sword
    }
    return "17_No_Props";
}

//Returns TRUE if oTracker has nType as a favored enemy
int FECheck(object oTracker, int nType)
{
    switch(nType)
    {
        case RACIAL_TYPE_ABERRATION:
            return GetHasFeat(FEAT_FAVORED_ENEMY_ABERRATION, oTracker);
        case RACIAL_TYPE_ANIMAL:
            return GetHasFeat(FEAT_FAVORED_ENEMY_ANIMAL, oTracker);
        case RACIAL_TYPE_BEAST:
            return GetHasFeat(FEAT_FAVORED_ENEMY_BEAST, oTracker);
        case RACIAL_TYPE_CONSTRUCT:
            return GetHasFeat(FEAT_FAVORED_ENEMY_CONSTRUCT, oTracker);
        case RACIAL_TYPE_DRAGON:
            return GetHasFeat(FEAT_FAVORED_ENEMY_DRAGON, oTracker);
        case RACIAL_TYPE_DWARF:
            return GetHasFeat(FEAT_FAVORED_ENEMY_DWARF, oTracker);
        case RACIAL_TYPE_ELEMENTAL:
            return GetHasFeat(FEAT_FAVORED_ENEMY_ELEMENTAL, oTracker);
        case RACIAL_TYPE_ELF:
            return GetHasFeat(FEAT_FAVORED_ENEMY_ELF, oTracker);
        case RACIAL_TYPE_FEY:
            return GetHasFeat(FEAT_FAVORED_ENEMY_FEY, oTracker);
        case RACIAL_TYPE_GIANT:
            return GetHasFeat(FEAT_FAVORED_ENEMY_GIANT, oTracker);
        case RACIAL_TYPE_GNOME:
            return GetHasFeat(FEAT_FAVORED_ENEMY_GNOME, oTracker);
        case RACIAL_TYPE_HALFELF:
            return GetHasFeat(FEAT_FAVORED_ENEMY_HALFELF, oTracker);
        case RACIAL_TYPE_HALFLING:
            return GetHasFeat(FEAT_FAVORED_ENEMY_HALFLING, oTracker);
        case RACIAL_TYPE_HALFORC:
            return GetHasFeat(FEAT_FAVORED_ENEMY_HALFORC, oTracker);
        case RACIAL_TYPE_HUMAN:
            return GetHasFeat(FEAT_FAVORED_ENEMY_HUMAN, oTracker);
        case RACIAL_TYPE_HUMANOID_GOBLINOID:
            return GetHasFeat(FEAT_FAVORED_ENEMY_GOBLINOID, oTracker);
        case RACIAL_TYPE_HUMANOID_MONSTROUS:
            return GetHasFeat(FEAT_FAVORED_ENEMY_MONSTROUS, oTracker);
        case RACIAL_TYPE_HUMANOID_ORC:
            return GetHasFeat(FEAT_FAVORED_ENEMY_ORC, oTracker);
        case RACIAL_TYPE_HUMANOID_REPTILIAN:
            return GetHasFeat(FEAT_FAVORED_ENEMY_REPTILIAN, oTracker);
        case RACIAL_TYPE_MAGICAL_BEAST:
            return GetHasFeat(FEAT_FAVORED_ENEMY_MAGICAL_BEAST, oTracker);
        /*case RACIAL_TYPE_OOZE:
            return GetHasFeat(FEAT_FAVORED_ENEMY_ABERRATION, oTracker);*/
        case RACIAL_TYPE_OUTSIDER:
            return GetHasFeat(FEAT_FAVORED_ENEMY_OUTSIDER, oTracker);
        case RACIAL_TYPE_SHAPECHANGER:
            return GetHasFeat(FEAT_FAVORED_ENEMY_SHAPECHANGER, oTracker);
        case RACIAL_TYPE_UNDEAD:
            return GetHasFeat(FEAT_FAVORED_ENEMY_UNDEAD, oTracker);
        case RACIAL_TYPE_VERMIN:
            return GetHasFeat(FEAT_FAVORED_ENEMY_VERMIN, oTracker);
    }
    return 0;
}

string TierToColor(int nTier)
{
    switch(nTier)
    {
    case 0://Grey item
        return "666";
    case 1://Blue item
        return "307";
    case 2://Teal item
        return "175";
    case 3://Green item
        return "040";
    case 4://Yellow item
        return "770";
    case 5://Orange item
        return "521";
    case 6://Red item
        return "704";
    case 7://Black Item
        return "333";
    }
    return "777";
}
