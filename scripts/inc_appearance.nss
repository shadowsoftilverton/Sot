#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: DECLARATION                                                            :://
//::////////////////////////////////////////////////////////////////////////:://

// Returns TRUE if oCreature has a dynamic model. This is applicable for both
// creatures and items.
int GetIsDynamicModel(object oTarget);

// Increments oCreature's base model.
void NextAppearanceType(object oCreature);

// Decrements oCreature's base model.
void PrevAppearanceType(object oCreature);

// Increments nPart (CREATURE_PART_*) on oCreature.
void NextCreatureBodyPart(object oCreature, int nPart);

// Decrements nPart (CREATURE_PART_*) on oCreature.
void PrevCreatureBodyPart(object oCreature, int nPart);

// Increments nChannel (COLOR_CHANNEL_*) on oCreature.
void NextColor(object oObject, int nChannel);

// Decrements nChannel (COLOR_CHANNEL_*) on oCreature.
void PrevColor(object oObject, int nChannel);

// Increments the tail type of oCreature.
void NextCreatureTailType(object oCreature);

// Decrements the tail type of oCreature.
void PrevCreatureTailType(object oCreature);

// Increments the wing type of oCreature.
void NextCreatureWingType(object oCreature);

// Decrements the wing type of oCreature.
void PrevCreatureWingType(object oCreature);

// Returns a random cloth/leather color which is appropriate for randomized
// objects.
int GetRandomClothColor();

// Returns a random metal color which is appropriate for randomized objects.
int GetRandomMetalColor();

// For certain items, it will randomize its appearance and return the new
// version.
object RandomizeItemAppearance(object oItem);

// For armor, cloak, or helm oItem, randomizes its colors and returns the new
// version.
object RandomizeItemColors(object oItem);

int GetHasNonStandardAppearance(object oPC);

//::////////////////////////////////////////////////////////////////////////:://
//:: IMPLEMENTATION                                                         :://
//::////////////////////////////////////////////////////////////////////////:://

int GetIsDynamicModel(object oTarget){
    int nType = GetObjectType(oTarget);

    switch(nType){
        case OBJECT_TYPE_ITEM:
            return TRUE;
        break;

        case OBJECT_TYPE_CREATURE:
            int nAppearanceType = GetAppearanceType(oTarget);
            return nAppearanceType >= 0 && nAppearanceType <= 6; // BASE RACES
        break;
    }

    return FALSE;
}

void NextAppearanceType(object oCreature){
    SetCreatureAppearanceType(oCreature, GetAppearanceType(oCreature) + 1);
}

void PrevAppearanceType(object oCreature){
    SetCreatureAppearanceType(oCreature, GetAppearanceType(oCreature) - 1);
}

void NextCreatureBodyPart(object oCreature, int nPart){
    SetCreatureBodyPart(nPart, GetCreatureBodyPart(nPart, oCreature) + 1, oCreature);
}

void PrevCreatureBodyPart(object oCreature, int nPart){
    SetCreatureBodyPart(nPart, GetCreatureBodyPart(nPart, oCreature) - 1, oCreature);
}

void NextColor(object oObject, int nChannel){
    SetColor(oObject, nChannel, GetColor(oObject, nChannel) + 1);
}

void PrevColor(object oObject, int nChannel){
    SetColor(oObject, nChannel, GetColor(oObject, nChannel) - 1);
}

void NextCreatureTailType(object oCreature){
    SetCreatureTailType(GetCreatureTailType(oCreature) + 1, oCreature);
}

void PrevCreatureTailType(object oCreature){
    SetCreatureTailType(GetCreatureTailType(oCreature) - 1, oCreature);
}

void NextCreatureWingType(object oCreature){
    SetCreatureWingType(GetCreatureWingType(oCreature) + 1, oCreature);
}

void PrevCreatureWingType(object oCreature){
    SetCreatureWingType(GetCreatureWingType(oCreature) - 1, oCreature);
}

int GetRandomClothColor(){
    int iReturn = Random(112);

    // 0 - 55
    if(iReturn > 55)  iReturn += 45;
    // 100 - 143
    if(iReturn > 143) iReturn += 4;
    // 148 - 159

    return iReturn;
}

int GetRandomMetalColor(){
    int iReturn = Random(40);

    // 0 - 25
    if(iReturn > 25) iReturn += 6;
    // 32 - 35
    if(iReturn > 35) iReturn += 2;
    // 38 - 43
    if(iReturn > 43) iReturn += 2;
    // 46 - 59

    return iReturn;
}

object RandomizeItemAppearance(object oItem){
    object oDelete;

    int nType = GetBaseItemType(oItem);

    int nModel;

    int nTop = 1;
    int nMiddle = 1;
    int nBottom = 1;

    int nRange = 0;

    switch(nType){
        case BASE_ITEM_AMULET:
            nModel = ITEM_APPR_TYPE_SIMPLE_MODEL;

            nTop = Random(121) + 1;

            // 1 - 26
            if(nTop > 26) nTop += 1;
            // 28 - 80
            if(nTop > 80) nTop += 48;
            // 129 - 132
            if(nTop > 132) nTop += 24;
            // 157 - 164
            if(nTop > 164) nTop += 61;
            // 226 - 255
        break;

        case BASE_ITEM_BELT:
            nModel = ITEM_APPR_TYPE_SIMPLE_MODEL;

            nTop = Random(113) + 1;

            // 1 - 9
            if(nTop > 9) nTop += 41;
            // 51 - 58
            if(nTop > 58) nTop += 7;
            // 66 - 68
            if(nTop > 68) nTop += 41;
            // 110 - 111
            if(nTop > 111) nTop += 8;
            // 120 - 173
            if(nTop > 173) nTop += 45;
            // 219 - 255
        break;

        case BASE_ITEM_BRACER:
            nModel = ITEM_APPR_TYPE_SIMPLE_MODEL;

            nTop = Random(78) + 1;

            // 1 - 12
            if(nTop > 12) nTop += 38;
            // 51 - 60
            if(nTop > 60) nTop += 52;
            // 113 - 116
            if(nTop > 116) nTop += 10;
            // 127 - 178
        break;

        case BASE_ITEM_CLOAK:
            nModel = ITEM_APPR_TYPE_SIMPLE_MODEL;

            nTop = Random(10) + 1;
        break;

        case BASE_ITEM_HELMET:
            nModel = ITEM_APPR_TYPE_SIMPLE_MODEL;

            nTop = Random(30) + 1;

            // 1 - 10
            if(nTop > 10) nTop += 1;
            // 12 - 25
            if(nTop > 25) nTop += 1;
            // 27 - 32
        break;

        case BASE_ITEM_RING:
            nModel = ITEM_APPR_TYPE_SIMPLE_MODEL;

            nTop = Random(216) + 1;

            // 1 - 130
            if(nTop > 130) nTop += 7;
            // 138 - 141
            if(nTop > 141) nTop += 15;
            // 157 - 238
        break;

        case BASE_ITEM_GLOVES:
            nModel = ITEM_APPR_TYPE_SIMPLE_MODEL;

            nTop = Random(114) + 1;

            // 1 - 11
            if(nTop > 11) nTop += 49;
            // 51 - 62
            if(nTop > 62) nTop +=  34;
            // 97 - 112
            if(nTop > 112) nTop += 12;
            // 125 - 199
        break;

        case BASE_ITEM_ARROW:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 3;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_BASTARDSWORD:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 7;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_BATTLEAXE:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 6;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_BOLT:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 3;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_BULLET:
            nModel = ITEM_APPR_TYPE_SIMPLE_MODEL;

            nTop = (Random(16) + 1) * 10 + d8();
        break;

        case BASE_ITEM_CLUB:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 4;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_DAGGER:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 6;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_DART:
            nModel = ITEM_APPR_TYPE_SIMPLE_MODEL;

            nTop = (Random(4) + 1) * 10 + d8();
        break;

        case BASE_ITEM_DIREMACE:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 4;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_DOUBLEAXE:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 3;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_DWARVENWARAXE:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 6;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_GREATAXE:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 4;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_GREATSWORD:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 3;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_HALBERD:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 4;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_HANDAXE:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 4;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_HEAVYCROSSBOW:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 4;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_HEAVYFLAIL:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 4;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_KAMA:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 1;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_KATANA:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 4;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_KUKRI:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 1;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_LIGHTCROSSBOW:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 4;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_LIGHTFLAIL:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 4;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_LIGHTHAMMER:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 4;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_LIGHTMACE:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 4;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_LONGBOW:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 8;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_LONGSWORD:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 8;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_MORNINGSTAR:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 4;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_QUARTERSTAFF:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 4;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_RAPIER:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 4;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_SCIMITAR:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 5;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_SCYTHE:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 3;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_SHORTBOW:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 6;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_SHORTSPEAR:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 4;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_SHORTSWORD:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 6;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_SHURIKEN:
            nModel = ITEM_APPR_TYPE_SIMPLE_MODEL;

            nTop = (Random(6) + 1) * 10 + d8();
        break;

        case BASE_ITEM_SICKLE:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 1;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_SLING:
            nModel = ITEM_APPR_TYPE_SIMPLE_MODEL;

            nTop = (Random(4) + 1) * 10 + d4();
        break;

        case BASE_ITEM_THROWINGAXE:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 4;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_TRIDENT:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 4;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_TWOBLADEDSWORD:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 3;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_WARHAMMER:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 6;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;

        case BASE_ITEM_WHIP:
            nModel = ITEM_APPR_TYPE_WEAPON_MODEL;

            nRange = 1;

            nTop = Random(nRange) + 1;
            nMiddle = Random(nRange) + 1;
            nBottom = Random(nRange) + 1;
        break;
    }

    switch(nModel){
        case ITEM_APPR_TYPE_SIMPLE_MODEL:
            oDelete = oItem;
            oItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0, nTop, TRUE);
            DestroyObject(oDelete);
        break;

        case ITEM_APPR_TYPE_WEAPON_MODEL:
            oDelete = oItem;
            oItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_WEAPON_MODEL, ITEM_APPR_WEAPON_MODEL_TOP, nTop, TRUE);
            DestroyObject(oDelete);

            oDelete = oItem;
            oItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_WEAPON_MODEL, ITEM_APPR_WEAPON_MODEL_MIDDLE, nMiddle, TRUE);
            DestroyObject(oDelete);

            oDelete = oItem;
            oItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_WEAPON_MODEL, ITEM_APPR_WEAPON_MODEL_BOTTOM, nBottom, TRUE);
            DestroyObject(oDelete);

            oDelete = oItem;
            oItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_WEAPON_MODEL, ITEM_APPR_WEAPON_COLOR_TOP, d4(), TRUE);
            DestroyObject(oDelete);

            oDelete = oItem;
            oItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_WEAPON_MODEL, ITEM_APPR_WEAPON_COLOR_MIDDLE, d4(), TRUE);
            DestroyObject(oDelete);

            oDelete = oItem;
            oItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_WEAPON_MODEL, ITEM_APPR_WEAPON_COLOR_BOTTOM, d4(), TRUE);
            DestroyObject(oDelete);
        break;
    }

    return oItem;
}

object RandomizeItemColors(object oItem){
    object oDelete;

    oDelete = oItem;
    oItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_CLOTH1, GetRandomClothColor(), TRUE);
    DestroyObject(oDelete);

    oDelete = oItem;
    oItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_CLOTH2, GetRandomClothColor(), TRUE);
    DestroyObject(oDelete);

    oDelete = oItem;
    oItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_LEATHER1, GetRandomClothColor(), TRUE);
    DestroyObject(oDelete);

    oDelete = oItem;
    oItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_LEATHER2, GetRandomClothColor(), TRUE);
    DestroyObject(oDelete);

    oDelete = oItem;
    oItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_METAL1, GetRandomMetalColor(), TRUE);
    DestroyObject(oDelete);

    oDelete = oItem;
    oItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_METAL2, GetRandomMetalColor(), TRUE);
    DestroyObject(oDelete);

    return oItem;
}

int GetHasNonStandardAppearance(object oPC) {
    int iType = GetAppearanceType(oPC);

    return(iType != APPEARANCE_TYPE_HUMAN    &&
           iType != APPEARANCE_TYPE_ELF      &&
           iType != APPEARANCE_TYPE_HALF_ORC &&
           iType != APPEARANCE_TYPE_HALF_ELF &&
           iType != APPEARANCE_TYPE_HALFLING &&
           iType != APPEARANCE_TYPE_GNOME    &&
           iType != APPEARANCE_TYPE_DWARF);
}
