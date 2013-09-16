#include "engine"

#include "inc_arrays"

#include "x3_inc_string"

#include "ave_crafting"

//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// CONSTANTS
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

// NAME_*
const string NAME_MATERIAL = "NAME_MATERIAL";
const string NAME_ITEM     = "NAME_ITEM";
const string NAME_PREFIX   = "NAME_PREFIX";
const string NAME_SUFFIX   = "NAME_SUFFIX";

// NAME_WEAPON_METAL_*
const string NAME_WEAPON_METAL_0 = "||Bronze";
const string NAME_WEAPON_METAL_1 = "||Iron";
const string NAME_WEAPON_METAL_2 = "||Steel";
const string NAME_WEAPON_METAL_3 = "||Hardened Steel";
const string NAME_WEAPON_METAL_4 = "||Truesteel";
const string NAME_WEAPON_METAL_5 = "||Mithril";
const string NAME_WEAPON_METAL_6 = "||Adamantine";

// NAME_WEAPON_WOOD_*
const string NAME_WEAPON_WOOD_0 = "||Oak";
const string NAME_WEAPON_WOOD_1 = "||Hickory";
const string NAME_WEAPON_WOOD_2 = "||Ash";
const string NAME_WEAPON_WOOD_3 = "||Shadowtop";
const string NAME_WEAPON_WOOD_4 = "||Snowwood";
const string NAME_WEAPON_WOOD_5 = "||Yew";
const string NAME_WEAPON_WOOD_6 = "||Ironwood";

// NAME_ARMOR_METAL_*
const string NAME_ARMOR_METAL_0 = "||Bronze";
const string NAME_ARMOR_METAL_1 = "||Iron";
const string NAME_ARMOR_METAL_2 = "||Steel|Dwarven";
const string NAME_ARMOR_METAL_3 = "||Hardened Steel";
const string NAME_ARMOR_METAL_4 = "||Truesteel";
const string NAME_ARMOR_METAL_5 = "||Mithril";
const string NAME_ARMOR_METAL_6 = "||Adamantine";

// NAME_ARMOR_LEATHER_*
const string NAME_ARMOR_LEATHER_0 = "||Rawhide";
const string NAME_ARMOR_LEATHER_1 = "||Leather";
const string NAME_ARMOR_LEATHER_2 = "||Hardhide";
const string NAME_ARMOR_LEATHER_3 = "||Treated Leather";
const string NAME_ARMOR_LEATHER_4 = "||Magical Hide";
const string NAME_ARMOR_LEATHER_5 = "||Magical Hide";
const string NAME_ARMOR_LEATHER_6 = "||Magical Hide";

// NAME_ARMOR_CLOTH_*
const string NAME_ARMOR_CLOTH_0 = "||Wool";
const string NAME_ARMOR_CLOTH_1 = "||Cotton";
const string NAME_ARMOR_CLOTH_2 = "||Silk";
const string NAME_ARMOR_CLOTH_3 = "||Suede";
const string NAME_ARMOR_CLOTH_4 = "||Stud Spangled";
const string NAME_ARMOR_CLOTH_5 = "||Magic Silk";
const string NAME_ARMOR_CLOTH_6 = "||Mithril Weave";

// NAME_AMULET_*
const string NAME_AMULET_0 = "||Wooden";
const string NAME_AMULET_1 = "||Glass";
const string NAME_AMULET_2 = "||Silver";
const string NAME_AMULET_3 = "||Topaz";
const string NAME_AMULET_4 = "||Ruby";
const string NAME_AMULET_5 = "||Obsidian";
const string NAME_AMULET_6 = "||Diamond";

//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// DECLARATION
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

// Compiles oItem's name; run at the end of the item's creation.
void CompileItemName(object oItem);

// Cleans up the local variables relating to item naming on oItem.
void DeleteItemNameVars(object oItem);

// Return the item's prefix.
string GetItemNamePrefix(object oItem);

// Returns the item's material name.
string GetItemNameMaterial(object oItem);

// Returns the item's type name.
string GetItemNameType(object oItem);

// Returns the item's suffix.
string GetItemNameSuffix(object oItem);

// Returns a random name for metal weaponry based on the specified level.
string GetRandomMetalWeaponName(int nLevel);

// Returns a random name for wood weaponry based on the specified level.
string GetRandomWoodWeaponName(int nLevel);

// Returns a random name for metal armor based on the specified level.
string GetRandomMetalArmorName(int nLevel);

// Returns a random name for wooden shields based on the specified level.
string GetRandomWoodShieldName(int nLevel);

// Returns a random name for leather armor based on the specified level.
string GetRandomLeatherArmorName(int nLevel);

// Returns a random name for cloth armor based on the specified level.
string GetRandomClothArmorName(int nLevel);

// Sets the item's name prefix.
void SetItemNamePrefix(object oItem, string sName);

// Sets the item's material name.
void SetItemNameMaterial(object oItem, string sName);

// Sets the item's type name.
void SetItemNameType(object oItem, string sName);

// Sets the item's name suffix.
void SetItemNameSuffix(object oItem, string sName);

// Adds an item descriptor automatically.
void AddItemDescriptor(object oItem, string sPrefix, string sSuffix);

//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
// IMPLEMENTATION
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

void CompileItemName(object oItem){
    // Grab the names.
    string sPrefix   = GetItemNamePrefix(oItem);
    string sMaterial = GetItemNameMaterial(oItem);
    string sItemName = GetItemNameType(oItem);
    string sSuffix   = GetItemNameSuffix(oItem);

    if(sPrefix != "")   sPrefix   = sPrefix + " ";
    if(sMaterial != "") sMaterial = sMaterial + " ";
    if(sSuffix != "")   sSuffix   = " " + sSuffix;
    string sName;
    int iTier =GetLocalInt(oItem, "sys_ilr_tier");
    string sLootColor=TierToColor(iTier);
    switch(iTier)
    {
    case 0://Grey item
        sName=StringToRGBString(sPrefix+sMaterial+sItemName+sSuffix, sLootColor);
    break;
    case 1://Blue item
        sName=StringToRGBString(sPrefix+sMaterial+sItemName+sSuffix, sLootColor);
    break;
    case 2://Teal item
        sName=StringToRGBString(sPrefix+sMaterial+sItemName+sSuffix, sLootColor);
    break;
    case 3://Green item
        sName=StringToRGBString(sPrefix+sMaterial+sItemName+sSuffix, sLootColor);
    break;
    case 4://Yellow item
        sName=StringToRGBString(sPrefix+sMaterial+sItemName+sSuffix, sLootColor);
    break;
    case 5://Orange item
        sName=StringToRGBString(sPrefix+sMaterial+sItemName+sSuffix, sLootColor);
    break;
    case 6://Red item
        sName=StringToRGBString(sPrefix+sMaterial+sItemName+sSuffix, sLootColor);
    break;
    case 7://Purple item
        sName=StringToRGBString(sPrefix+sMaterial+sItemName+sSuffix, sLootColor);
    break;
    }

    // Apply to the object.
    SetName(oItem, sName);

    // Delete the variables to reduce bloat.
    DeleteItemNameVars(oItem);
}

void DeleteItemNameVars(object oItem){
    DeleteLocalString(oItem, NAME_PREFIX);
    DeleteLocalString(oItem, NAME_MATERIAL);
    DeleteLocalString(oItem, NAME_ITEM);
    DeleteLocalString(oItem, NAME_SUFFIX);
}

string GetItemNamePrefix(object oItem){
    return GetLocalString(oItem, NAME_PREFIX);
}

string GetItemNameMaterial(object oItem){
    return GetLocalString(oItem, NAME_MATERIAL);
}

string GetItemNameType(object oItem){
    return GetLocalString(oItem, NAME_ITEM);
}

string GetItemNameSuffix(object oItem){
    return GetLocalString(oItem, NAME_SUFFIX);
}

string GetRandomMetalWeaponName(int nLevel){
    switch(nLevel){
        case 0: return GetRandomArrayElement(NAME_WEAPON_METAL_0);
        case 1: return GetRandomArrayElement(NAME_WEAPON_METAL_1);
        case 2: return GetRandomArrayElement(NAME_WEAPON_METAL_2);
        case 3: return GetRandomArrayElement(NAME_WEAPON_METAL_3);
        case 4: return GetRandomArrayElement(NAME_WEAPON_METAL_4);
        case 5: return GetRandomArrayElement(NAME_WEAPON_METAL_5);
        case 5: return GetRandomArrayElement(NAME_WEAPON_METAL_6);
    }

    return "";
}

string GetRandomWoodWeaponName(int nLevel){
    switch(nLevel){
        case 0: return GetRandomArrayElement(NAME_WEAPON_WOOD_0);
        case 1: return GetRandomArrayElement(NAME_WEAPON_WOOD_1);
        case 2: return GetRandomArrayElement(NAME_WEAPON_WOOD_2);
        case 3: return GetRandomArrayElement(NAME_WEAPON_WOOD_3);
        case 4: return GetRandomArrayElement(NAME_WEAPON_WOOD_4);
        case 5: return GetRandomArrayElement(NAME_WEAPON_WOOD_5);
        case 5: return GetRandomArrayElement(NAME_WEAPON_WOOD_6);
    }

    return "";
}

string GetRandomMetalArmorName(int nLevel){
    switch(nLevel){
        case 0: return GetRandomArrayElement(NAME_ARMOR_METAL_0);
        case 1: return GetRandomArrayElement(NAME_ARMOR_METAL_1);
        case 2: return GetRandomArrayElement(NAME_ARMOR_METAL_2);
        case 3: return GetRandomArrayElement(NAME_ARMOR_METAL_3);
        case 4: return GetRandomArrayElement(NAME_ARMOR_METAL_4);
        case 5: return GetRandomArrayElement(NAME_ARMOR_METAL_5);
        case 5: return GetRandomArrayElement(NAME_ARMOR_METAL_6);
    }

    return "";
}

string GetRandomWoodShieldName(int nLevel){
    return GetRandomWoodWeaponName(nLevel);
}

string GetRandomLeatherArmorName(int nLevel){
    switch(nLevel){
        case 0: return GetRandomArrayElement(NAME_ARMOR_LEATHER_0);
        case 1: return GetRandomArrayElement(NAME_ARMOR_LEATHER_1);
        case 2: return GetRandomArrayElement(NAME_ARMOR_LEATHER_2);
        case 3: return GetRandomArrayElement(NAME_ARMOR_LEATHER_3);
        case 4: return GetRandomArrayElement(NAME_ARMOR_LEATHER_4);
        case 5: return GetRandomArrayElement(NAME_ARMOR_LEATHER_5);
        case 5: return GetRandomArrayElement(NAME_ARMOR_LEATHER_6);
    }

    return "";
}

string GetRandomClothArmorName(int nLevel){
    switch(nLevel){
        case 0: return GetRandomArrayElement(NAME_ARMOR_CLOTH_0);
        case 1: return GetRandomArrayElement(NAME_ARMOR_CLOTH_1);
        case 2: return GetRandomArrayElement(NAME_ARMOR_CLOTH_2);
        case 3: return GetRandomArrayElement(NAME_ARMOR_CLOTH_3);
        case 4: return GetRandomArrayElement(NAME_ARMOR_CLOTH_4);
        case 5: return GetRandomArrayElement(NAME_ARMOR_CLOTH_5);
        case 5: return GetRandomArrayElement(NAME_ARMOR_CLOTH_6);
    }

    return "";
}

void SetItemNamePrefix(object oItem, string sName){
    SetLocalString(oItem, NAME_PREFIX, sName);
}

void SetItemNameMaterial(object oItem, string sName){
    SetLocalString(oItem, NAME_MATERIAL, sName);
}

void SetItemNameType(object oItem, string sName){
    SetLocalString(oItem, NAME_ITEM, sName);
}

void SetItemNameSuffix(object oItem, string sName){
    SetLocalString(oItem, NAME_SUFFIX, sName);
}

void AddItemDescriptor(object oItem, string sPrefix, string sSuffix){
    string sCurrPrefix = GetItemNamePrefix(oItem);
    string sCurrSuffix = GetItemNameSuffix(oItem);

    if(sCurrPrefix == "" && sCurrSuffix == ""){
        int nRoll = Random(2);

        if(nRoll) SetItemNamePrefix(oItem, sPrefix);
        else      SetItemNameSuffix(oItem, sSuffix);
    } else if(sCurrPrefix == ""){
        SetItemNamePrefix(oItem, sPrefix);
    } else if(sCurrSuffix == ""){
        SetItemNameSuffix(oItem, sSuffix);
    }
}

