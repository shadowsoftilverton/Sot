#include "engine"
#include "aps_include"
#include "inc_appearance"

//:==========================================================================://
//: Druid/Shifter Wildshape System                                           ://
//:==========================================================================://

// Level type constants
const int COMPOSITE_LEVELS = 0;
const int DRUID_LEVELS = 1;
const int SHIFTER_LEVELS = 2;

// Levels required for druid/shifter forms
const int ELEMENTAL_TIER_LEVEL = 29;
const int TOP_TIER_LEVEL = 19;
const int MID_TIER_LEVEL = 11;
const int LOW_TIER_LEVEL = 5;

// Levels required for shifter-exclusive forms
const int HUMANOID_FORMS_LEVEL = 1;

// Stat spread constants
const int ELEMENTAL_TIER_HIGHSTAT = 8;
const int ELEMENTAL_TIER_MIDSTAT = 6;
const int ELEMENTAL_TIER_LOWSTAT = 4;

const int TOP_TIER_HIGHSTAT = 6;
const int TOP_TIER_MIDSTAT = 4;
const int TOP_TIER_LOWSTAT = 2;

const int MID_TIER_HIGHSTAT = 4;
const int MID_TIER_MIDSTAT = 2;
const int MID_TIER_LOWSTAT = 0;

const int LOW_TIER_HIGHSTAT = 2;
const int LOW_TIER_MIDSTAT = 0;
const int LOW_TIER_LOWSTAT = 0;

// Form indexes
const int DRUID_FORM_NULL = 0;
const int DRUID_FORM_BLACKBEAR = 1;
const int DRUID_FORM_GRAYWOLF = 2;
const int DRUID_FORM_TIGER = 3;
const int DRUID_FORM_LION_MANE = 4;
const int DRUID_FORM_LION_MANELESS = 5;
const int DRUID_FORM_CHEETAH = 6;
const int DRUID_FORM_PANTHER = 7;
const int DRUID_FORM_JAGUAR = 8;
const int DRUID_FORM_LEOPARD = 9;
const int DRUID_FORM_CROCODILE = 10;
const int DRUID_FORM_SHARK = 11;
const int DRUID_FORM_EAGLE = 12;
const int DRUID_FORM_DOG_HUSKY = 13;
const int DRUID_FORM_DOG_MALAMUTE = 14;
const int DRUID_FORM_DOG_MASTIFF = 15;
const int DRUID_FORM_DOG_DALMATIAN = 16;
const int DRUID_FORM_DOG_DOBERMAN = 17;
const int DRUID_FORM_DOG_LAB = 18;
const int DRUID_FORM_SNAKE_VIPER = 19;
const int DRUID_FORM_WOLVERINE = 20;
const int DRUID_FORM_HYENA_SPOTTED = 21;
const int DRUID_FORM_HYENA_STRIPED = 22;
const int DRUID_FORM_CAMEL = 23;
const int DRUID_FORM_HORSE_BROWN = 24;
const int DRUID_FORM_BISON = 25;
const int DRUID_FORM_HAWK = 26;
const int DRUID_FORM_BAT = 27;
const int DRUID_FORM_BAT_FRUIT = 28;
const int DRUID_FORM_RAT = 29;
const int DRUID_FORM_RABBIT = 30;
const int DRUID_FORM_CAT_BLACKWHITE = 31;
const int DRUID_FORM_CAT_BLACK = 32;
const int DRUID_FORM_CAT_WHITE = 33;
const int DRUID_FORM_DOG_TERRIER = 34;
const int DRUID_FORM_BADGER = 35;
const int DRUID_FORM_BOAR = 36;
const int DRUID_FORM_RAVEN = 37;
const int DRUID_FORM_OWL_BARN = 38;
const int DRUID_FORM_ELF = 39;
const int DRUID_FORM_HALFELF = 40;
const int DRUID_FORM_HALFLING = 41;
const int DRUID_FORM_HALFORC = 42;
const int DRUID_FORM_HUMAN = 43;
const int DRUID_FORM_GNOME = 44;
const int DRUID_FORM_DWARF = 45;

//==============================================================================

int DoTranslateNameToForm(string sFormName);

void SendLevelRequiredMessageToPC(object oPC, int nLevel, int iType);

void DoRecoverWildshape(object oPC); // Called in mod_rest

void DoDruidPolymorph(object oPC, int iForm);

// If oCreature is a druid in a polymorphed shape, this undoes the appearance
// change and effects.
void DoEndDruidPolymorph(object oPC);

// Checks if oPC still had the druidic polymorph effects when they relog.
void DoCheckDruidPolymorph(object oPC);

//==============================================================================

int DoTranslateNameToForm(string sFormName) {
         if(sFormName == "black-bear")      return DRUID_FORM_BLACKBEAR;
    else if(sFormName == "gray-wolf")       return DRUID_FORM_GRAYWOLF;
    else if(sFormName == "tiger")           return DRUID_FORM_TIGER;
    else if(sFormName == "lion")            return DRUID_FORM_LION_MANE;
    else if(sFormName == "lion-maneless")   return DRUID_FORM_LION_MANELESS;
    else if(sFormName == "cheetah")         return DRUID_FORM_CHEETAH;
    else if(sFormName == "panther")         return DRUID_FORM_PANTHER;
    else if(sFormName == "jaguar")          return DRUID_FORM_JAGUAR;
    else if(sFormName == "leopard")         return DRUID_FORM_LEOPARD;
    else if(sFormName == "crocodile")       return DRUID_FORM_CROCODILE;
    else if(sFormName == "shark")           return DRUID_FORM_SHARK;
    else if(sFormName == "eagle")           return DRUID_FORM_EAGLE;
    else if(sFormName == "husky")           return DRUID_FORM_DOG_HUSKY;
    else if(sFormName == "malamute")        return DRUID_FORM_DOG_MALAMUTE;
    else if(sFormName == "mastiff")         return DRUID_FORM_DOG_MASTIFF;
    else if(sFormName == "dalmatian")       return DRUID_FORM_DOG_DALMATIAN;
    else if(sFormName == "doberman")        return DRUID_FORM_DOG_DOBERMAN;
    else if(sFormName == "lab")             return DRUID_FORM_DOG_LAB;
    else if(sFormName == "viper")           return DRUID_FORM_SNAKE_VIPER;
    else if(sFormName == "wolverine")       return DRUID_FORM_WOLVERINE;
    else if(sFormName == "spotted-hyena")   return DRUID_FORM_HYENA_SPOTTED;
    else if(sFormName == "striped-hyena")   return DRUID_FORM_HYENA_STRIPED;
    else if(sFormName == "camel")           return DRUID_FORM_CAMEL;
    else if(sFormName == "brown-horse")     return DRUID_FORM_HORSE_BROWN;
    else if(sFormName == "bison")           return DRUID_FORM_BISON;
    else if(sFormName == "hawk")            return DRUID_FORM_HAWK;
    else if(sFormName == "bat")             return DRUID_FORM_BAT;
    else if(sFormName == "fruit-bat")       return DRUID_FORM_BAT_FRUIT;
    else if(sFormName == "rat")             return DRUID_FORM_RAT;
    else if(sFormName == "rabbit")          return DRUID_FORM_RABBIT;
    else if(sFormName == "black-white-cat") return DRUID_FORM_CAT_BLACKWHITE;
    else if(sFormName == "black-cat")       return DRUID_FORM_CAT_BLACK;
    else if(sFormName == "white-cat")       return DRUID_FORM_CAT_WHITE;
    else if(sFormName == "terrier")         return DRUID_FORM_DOG_TERRIER;
    else if(sFormName == "badger")          return DRUID_FORM_BADGER;
    else if(sFormName == "boar")            return DRUID_FORM_BOAR;
    else if(sFormName == "raven")           return DRUID_FORM_RAVEN;
    else if(sFormName == "barn-owl")        return DRUID_FORM_OWL_BARN;
    else if(sFormName == "elf")             return DRUID_FORM_ELF;
    else if(sFormName == "half-elf")        return DRUID_FORM_HALFELF;
    else if(sFormName == "halfling")        return DRUID_FORM_HALFLING;
    else if(sFormName == "half-orc")        return DRUID_FORM_HALFORC;
    else if(sFormName == "human")           return DRUID_FORM_HUMAN;
    else if(sFormName == "gnome")           return DRUID_FORM_GNOME;
    else if(sFormName == "dwarf")           return DRUID_FORM_DWARF;
    else                                    return DRUID_FORM_NULL;
}

void SendLevelRequiredMessageToPC(object oPC, int nLevel, int iType) {
    switch(iType) {
        case COMPOSITE_LEVELS:
            SendMessageToPC(oPC, "You must have " + IntToString(nLevel) + " druid and/or shifter levels before assuming this form.");
            break;
        case DRUID_LEVELS:
            SendMessageToPC(oPC, "You must have " + IntToString(nLevel) + " druid levels before assuming this form.");
            break;
        case SHIFTER_LEVELS:
            SendMessageToPC(oPC, "You must have " + IntToString(nLevel) + " shifter levels before assuming this form.");
            break;
        default: break;
    }
}

void DoRecoverWildshape(object oPC) {
    int nDruidLevels = GetLevelByClass(CLASS_TYPE_DRUID, oPC);
    int nShifterLevels = GetLevelByClass(CLASS_TYPE_SHIFTER, oPC);
    int nCompositeLevels = nDruidLevels + nShifterLevels;

         if(nCompositeLevels >= 20) SetPersistentInt(oPC, "DRUID_POLY_USES", 9);
    else if(nCompositeLevels >= 18) SetPersistentInt(oPC, "DRUID_POLY_USES", 8);
    else if(nCompositeLevels >= 16) SetPersistentInt(oPC, "DRUID_POLY_USES", 7);
    else if(nCompositeLevels >= 14) SetPersistentInt(oPC, "DRUID_POLY_USES", 6);
    else if(nCompositeLevels >= 12) SetPersistentInt(oPC, "DRUID_POLY_USES", 5);
    else if(nCompositeLevels >= 10) SetPersistentInt(oPC, "DRUID_POLY_USES", 4);
    else if(nCompositeLevels >=  8) SetPersistentInt(oPC, "DRUID_POLY_USES", 3);
    else if(nCompositeLevels >=  6) SetPersistentInt(oPC, "DRUID_POLY_USES", 2);
    else if(nCompositeLevels >=  4) SetPersistentInt(oPC, "DRUID_POLY_USES", 1);
}

void DoDruidPolymorph(object oPC, int iForm) {
    if(GetPersistentInt(oPC, "DRUID_POLY_FORM") != DRUID_FORM_NULL) {
        SendMessageToPC(oPC, "You cannot polymorph while polymorphed!");
        return;
    }

    if(GetPersistentInt(oPC, "DRUID_POLY_USES") == 0) {
        SendMessageToPC(oPC, "You cannot polymorph any further without resting.");
        return;
    }

    int nDruidLevels = GetLevelByClass(CLASS_TYPE_DRUID, oPC);
    int nShifterLevels = GetLevelByClass(CLASS_TYPE_SHIFTER, oPC);
    int nCompositeLevels = nDruidLevels + nShifterLevels;

    if(GetHasFeat(1563,oPC)) nCompositeLevels=nCompositeLevels+GetLevelByClass(50,oPC);//Hierophant power of nature

    int iRacialStrMod = 0;
    int iRacialDexMod = 0;
    int iRacialConMod = 0;

    switch(GetRacialType(oPC)) {
        case RACIAL_TYPE_ELF:
            iRacialDexMod =  2;
            iRacialConMod = -2;
            //if(GetSubRace(oPC)=="Wood Elf")
            //{
            //    iRacialStrMod=2;
            //}
            //else if(GetSubRace(oPC)=="Sun Elf")
            //{
            //    iRacialDexMod=0;
            //}
            //else if(GetSubRace(oPC)=="Wild Elf")
            //{
            //    iRacialConMod=0;
            //}
            break;
        case RACIAL_TYPE_DWARF:
            iRacialConMod =  2;
            //if(GetSubRace(oPC)=="Gold Dwarf")
            //{
            //    iRacialDexMod=-2;
            //}
            break;
        case RACIAL_TYPE_HALFLING:
            iRacialStrMod = -2;
            iRacialDexMod =  2;
            break;
        case RACIAL_TYPE_GNOME:
            iRacialStrMod = -2;
            iRacialConMod =  2;
            break;
        case RACIAL_TYPE_HALFORC:
            iRacialStrMod =  2;
            break;
        case RACIAL_TYPE_HUMAN:
        case RACIAL_TYPE_HALFELF:
        default: break;
    }

    switch(iForm) {
        case DRUID_FORM_BLACKBEAR:
            if(nCompositeLevels < TOP_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, TOP_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + TOP_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + TOP_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + TOP_TIER_MIDSTAT);
            SetCreatureAppearanceType(oPC, 12);
            break;
        case DRUID_FORM_GRAYWOLF:
            if(nCompositeLevels < TOP_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, TOP_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + TOP_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + TOP_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + TOP_TIER_LOWSTAT);
            SetCreatureAppearanceType(oPC, 181);
            break;
        case DRUID_FORM_TIGER:
            if(nCompositeLevels < TOP_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, TOP_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + TOP_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + TOP_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + TOP_TIER_HIGHSTAT);
            SetCreatureAppearanceType(oPC, 918);
            break;
        case DRUID_FORM_LION_MANE:
            if(nCompositeLevels < TOP_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, TOP_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + TOP_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + TOP_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + TOP_TIER_LOWSTAT);
            SetCreatureAppearanceType(oPC, 3439);
            break;
        case DRUID_FORM_LION_MANELESS:
            if(nCompositeLevels < TOP_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, TOP_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + TOP_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + TOP_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + TOP_TIER_LOWSTAT);
            SetCreatureAppearanceType(oPC, 97);
            break;
        case DRUID_FORM_CHEETAH:
            if(nCompositeLevels < TOP_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, TOP_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + TOP_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + TOP_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + TOP_TIER_MIDSTAT);
            SetCreatureAppearanceType(oPC, 1940);
            break;
        case DRUID_FORM_PANTHER:
            if(nCompositeLevels < TOP_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, TOP_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + TOP_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + TOP_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + TOP_TIER_LOWSTAT);
            SetCreatureAppearanceType(oPC, 202);
            break;
        case DRUID_FORM_JAGUAR:
            if(nCompositeLevels < TOP_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, TOP_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + TOP_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + TOP_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + TOP_TIER_LOWSTAT);
            SetCreatureAppearanceType(oPC, 98);
            break;
        case DRUID_FORM_LEOPARD:
            if(nCompositeLevels < TOP_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, TOP_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + TOP_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + TOP_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + TOP_TIER_LOWSTAT);
            SetCreatureAppearanceType(oPC, 93);
            break;
        case DRUID_FORM_CROCODILE:
            if(nCompositeLevels < TOP_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, TOP_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + TOP_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + TOP_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + TOP_TIER_MIDSTAT);
            SetCreatureAppearanceType(oPC, 3171);
            break;
        case DRUID_FORM_SHARK:
            if(nCompositeLevels < TOP_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, TOP_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + TOP_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + TOP_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + TOP_TIER_HIGHSTAT);
            SetCreatureAppearanceType(oPC, 1880);
            break;
        case DRUID_FORM_EAGLE:
            if(nCompositeLevels < TOP_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, TOP_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + TOP_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + TOP_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + TOP_TIER_MIDSTAT);
            SetCreatureAppearanceType(oPC, 1275);
            break;
        case DRUID_FORM_DOG_HUSKY:
            if(nCompositeLevels < MID_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, MID_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + MID_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + MID_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + MID_TIER_HIGHSTAT);
            SetCreatureAppearanceType(oPC, 1394);
            break;
        case DRUID_FORM_DOG_MALAMUTE:
            if(nCompositeLevels < MID_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, MID_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + MID_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + MID_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + MID_TIER_HIGHSTAT);
            SetCreatureAppearanceType(oPC, 1395);
            break;
        case DRUID_FORM_DOG_MASTIFF:
            if(nCompositeLevels < MID_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, MID_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + MID_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + MID_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + MID_TIER_MIDSTAT);
            SetCreatureAppearanceType(oPC, 1396);
            break;
        case DRUID_FORM_DOG_DALMATIAN:
            if(nCompositeLevels < MID_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, MID_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + MID_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + MID_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + MID_TIER_MIDSTAT);
            SetCreatureAppearanceType(oPC, 1392);
            break;
        case DRUID_FORM_DOG_DOBERMAN:
            if(nCompositeLevels < MID_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, MID_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + MID_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + MID_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + MID_TIER_HIGHSTAT);
            SetCreatureAppearanceType(oPC, 1393);
            break;
        case DRUID_FORM_DOG_LAB:
            if(nCompositeLevels < MID_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, MID_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + MID_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + MID_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + MID_TIER_HIGHSTAT);
            SetCreatureAppearanceType(oPC, 1398);
            break;
        case DRUID_FORM_SNAKE_VIPER:
            if(nCompositeLevels < MID_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, MID_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + MID_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + MID_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + MID_TIER_LOWSTAT);
            SetCreatureAppearanceType(oPC, 1226);
            break;
        case DRUID_FORM_WOLVERINE:
            if(nCompositeLevels < MID_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, MID_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + MID_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + MID_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + MID_TIER_MIDSTAT);
            SetCreatureAppearanceType(oPC, 1337);
            break;
        case DRUID_FORM_HYENA_SPOTTED:
            if(nCompositeLevels < MID_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, MID_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + MID_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + MID_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + MID_TIER_MIDSTAT);
            SetCreatureAppearanceType(oPC, 1326);
            break;
        case DRUID_FORM_HYENA_STRIPED:
            if(nCompositeLevels < MID_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, MID_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + MID_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + MID_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + MID_TIER_MIDSTAT);
            SetCreatureAppearanceType(oPC, 1327);
            break;
        case DRUID_FORM_CAMEL:
            if(nCompositeLevels < MID_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, MID_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + MID_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + MID_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + MID_TIER_HIGHSTAT);
            SetCreatureAppearanceType(oPC, 1865);
            break;
        case DRUID_FORM_HORSE_BROWN:
            if(nCompositeLevels < MID_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, MID_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + MID_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + MID_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + MID_TIER_MIDSTAT);
            SetCreatureAppearanceType(oPC, 1858);
            break;
        case DRUID_FORM_BISON:
            if(nCompositeLevels < MID_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, MID_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + MID_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + MID_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + MID_TIER_MIDSTAT);
            SetCreatureAppearanceType(oPC, 1015);
            break;
        case DRUID_FORM_HAWK:
            if(nCompositeLevels < MID_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, MID_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + MID_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + MID_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + MID_TIER_MIDSTAT);
            SetCreatureAppearanceType(oPC, 144);
            break;
        case DRUID_FORM_BAT:
            if(nCompositeLevels < MID_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, MID_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + MID_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + MID_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + MID_TIER_MIDSTAT);
            SetCreatureAppearanceType(oPC, 1893);
            break;
        case DRUID_FORM_BAT_FRUIT:
            if(nCompositeLevels < LOW_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, LOW_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + LOW_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + LOW_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + LOW_TIER_MIDSTAT);
            SetCreatureAppearanceType(oPC, 1892);
            break;
        case DRUID_FORM_RAT:
            if(nCompositeLevels < LOW_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, LOW_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + LOW_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + LOW_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + LOW_TIER_HIGHSTAT);
            SetCreatureAppearanceType(oPC, 2505);
            break;
        case DRUID_FORM_RABBIT:
            if(nCompositeLevels < LOW_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, LOW_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + LOW_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + LOW_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + LOW_TIER_LOWSTAT);
            SetCreatureAppearanceType(oPC, 3237);
            break;
        case DRUID_FORM_CAT_BLACKWHITE:
            if(nCompositeLevels < LOW_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, LOW_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + LOW_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + LOW_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + LOW_TIER_LOWSTAT);
            SetCreatureAppearanceType(oPC, 1407);
            break;
        case DRUID_FORM_CAT_BLACK:
            if(nCompositeLevels < LOW_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, LOW_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + LOW_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + LOW_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + LOW_TIER_LOWSTAT);
            SetCreatureAppearanceType(oPC, 1406);
            break;
        case DRUID_FORM_CAT_WHITE:
            if(nCompositeLevels < LOW_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, LOW_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + LOW_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + LOW_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + LOW_TIER_LOWSTAT);
            SetCreatureAppearanceType(oPC, 1409);
            break;
        case DRUID_FORM_DOG_TERRIER:
            if(nCompositeLevels < LOW_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, LOW_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + LOW_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + LOW_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + LOW_TIER_MIDSTAT);
            SetCreatureAppearanceType(oPC, 1397);
            break;
        case DRUID_FORM_BADGER:
            if(nCompositeLevels < LOW_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, LOW_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + LOW_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + LOW_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + LOW_TIER_HIGHSTAT);
            SetCreatureAppearanceType(oPC, 8);
            break;
        case DRUID_FORM_BOAR:
            if(nCompositeLevels < LOW_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, LOW_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + LOW_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + LOW_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + LOW_TIER_MIDSTAT);
            SetCreatureAppearanceType(oPC, 21);
            break;
        case DRUID_FORM_RAVEN:
            if(nCompositeLevels < LOW_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, LOW_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + LOW_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + LOW_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + LOW_TIER_HIGHSTAT);
            SetCreatureAppearanceType(oPC, 145);
            break;
        case DRUID_FORM_OWL_BARN:
            if(nCompositeLevels < LOW_TIER_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, LOW_TIER_LEVEL, COMPOSITE_LEVELS);
                return;
            }

            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod + LOW_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod + LOW_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE) - iRacialConMod + LOW_TIER_MIDSTAT);
            SetCreatureAppearanceType(oPC, 1949);
            break;
        case DRUID_FORM_ELF:
            if(nShifterLevels < HUMANOID_FORMS_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, HUMANOID_FORMS_LEVEL, SHIFTER_LEVELS);
                return;
            }

            SetCreatureAppearanceType(oPC, 1);
            break;
        case DRUID_FORM_HALFELF:
            if(nShifterLevels < HUMANOID_FORMS_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, HUMANOID_FORMS_LEVEL, SHIFTER_LEVELS);
                return;
            }

            SetCreatureAppearanceType(oPC, 4);
            break;
        case DRUID_FORM_HALFLING:
            if(nShifterLevels < HUMANOID_FORMS_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, HUMANOID_FORMS_LEVEL, SHIFTER_LEVELS);
                return;
            }

            SetCreatureAppearanceType(oPC, 3);
            break;
        case DRUID_FORM_HALFORC:
            if(nShifterLevels < HUMANOID_FORMS_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, HUMANOID_FORMS_LEVEL, SHIFTER_LEVELS);
                return;
            }

            SetCreatureAppearanceType(oPC, 5);
            break;
        case DRUID_FORM_HUMAN:
            if(nShifterLevels < HUMANOID_FORMS_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, HUMANOID_FORMS_LEVEL, SHIFTER_LEVELS);
                return;
            }

            SetCreatureAppearanceType(oPC, 6);
            break;
        case DRUID_FORM_GNOME:
            if(nShifterLevels < HUMANOID_FORMS_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, HUMANOID_FORMS_LEVEL, SHIFTER_LEVELS);
                return;
            }

            SetCreatureAppearanceType(oPC, 2);
            break;
        case DRUID_FORM_DWARF:
            if(nShifterLevels < HUMANOID_FORMS_LEVEL) {
                SendLevelRequiredMessageToPC(oPC, HUMANOID_FORMS_LEVEL, SHIFTER_LEVELS);
                return;
            }

            SetCreatureAppearanceType(oPC, 0);
            break;
        case DRUID_FORM_NULL: break;
        default: break;
    }

    SetPersistentInt(oPC, "DRUID_POLY_FORM", iForm);
    SetPersistentInt(oPC, "DRUID_POLY_USES", GetPersistentInt(oPC, "DRUID_POLY_USES") - 1);
    DelayCommand(HoursToSeconds(nCompositeLevels), DoEndDruidPolymorph(oPC));
}

void DoEndDruidPolymorph(object oPC) {
    int iForm = GetPersistentInt(oPC, "DRUID_POLY_FORM");

    if(iForm == DRUID_FORM_NULL) return;

    if(GetIsPC(oPC) && GetHasNonStandardAppearance(oPC)) SetCreatureAppearanceType(oPC, GetRacialType(oPC));

    int iRacialStrMod = 0;
    int iRacialDexMod = 0;
    int iRacialConMod = 0;

    switch(GetRacialType(oPC)) {
        case RACIAL_TYPE_ELF:
            iRacialDexMod =  2;
            iRacialConMod = -2;
            break;
        case RACIAL_TYPE_DWARF:
            iRacialConMod =  2;
            break;
        case RACIAL_TYPE_HALFLING:
            iRacialStrMod = -2;
            iRacialDexMod =  2;
            break;
        case RACIAL_TYPE_GNOME:
            iRacialStrMod = -2;
            iRacialConMod =  2;
            break;
        case RACIAL_TYPE_HALFORC:
            iRacialStrMod =  2;
            break;
        case RACIAL_TYPE_HUMAN:
        case RACIAL_TYPE_HALFELF:
        default: break;
    }

    switch(iForm) {
        case DRUID_FORM_BLACKBEAR:
            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod - TOP_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod - TOP_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE)  - iRacialConMod - TOP_TIER_MIDSTAT);
            break;
        case DRUID_FORM_GRAYWOLF:
            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod - TOP_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod - TOP_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE)  - iRacialConMod - TOP_TIER_LOWSTAT);
            break;
        case DRUID_FORM_TIGER:
            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod - TOP_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod - TOP_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE)  - iRacialConMod - TOP_TIER_HIGHSTAT);
            break;
        case DRUID_FORM_LION_MANE:
        case DRUID_FORM_LION_MANELESS:
            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod - TOP_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod - TOP_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE)  - iRacialConMod - TOP_TIER_LOWSTAT);
            break;
        case DRUID_FORM_CHEETAH:
            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod - TOP_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod - TOP_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE)  - iRacialConMod - TOP_TIER_MIDSTAT);
            break;
        case DRUID_FORM_PANTHER:
            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod - TOP_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod - TOP_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE)  - iRacialConMod - TOP_TIER_LOWSTAT);
            break;
        case DRUID_FORM_JAGUAR:
            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod - TOP_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod - TOP_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE)  - iRacialConMod - TOP_TIER_LOWSTAT);
            break;
        case DRUID_FORM_LEOPARD:
            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod - TOP_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod - TOP_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE)  - iRacialConMod - TOP_TIER_LOWSTAT);
            break;
        case DRUID_FORM_CROCODILE:
            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod - TOP_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod - TOP_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE)  - iRacialConMod - TOP_TIER_MIDSTAT);
            break;
        case DRUID_FORM_SHARK:
            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod - TOP_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod - TOP_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE)  - iRacialConMod - TOP_TIER_HIGHSTAT);
            break;
        case DRUID_FORM_EAGLE:
            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod - TOP_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod - TOP_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE)  - iRacialConMod - TOP_TIER_MIDSTAT);
            break;
        case DRUID_FORM_DOG_HUSKY:
        case DRUID_FORM_DOG_MALAMUTE:
            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod - MID_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod - MID_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE)  - iRacialConMod - MID_TIER_HIGHSTAT);
            break;
        case DRUID_FORM_DOG_MASTIFF:
            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod - MID_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod - MID_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE)  - iRacialConMod - MID_TIER_MIDSTAT);
            break;
        case DRUID_FORM_DOG_DALMATIAN:
            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod - MID_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod - MID_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE)  - iRacialConMod - MID_TIER_MIDSTAT);
            break;
        case DRUID_FORM_DOG_DOBERMAN:
        case DRUID_FORM_DOG_LAB:
            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod - MID_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod - MID_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE)  - iRacialConMod - MID_TIER_HIGHSTAT);
            break;
        case DRUID_FORM_SNAKE_VIPER:
            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod - MID_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod - MID_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE)  - iRacialConMod - MID_TIER_LOWSTAT);
            break;
        case DRUID_FORM_WOLVERINE:
            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod - MID_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod - MID_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE)  - iRacialConMod - MID_TIER_MIDSTAT);
            break;
        case DRUID_FORM_HYENA_SPOTTED:
        case DRUID_FORM_HYENA_STRIPED:
            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod - MID_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod - MID_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE)  - iRacialConMod - MID_TIER_MIDSTAT);
            break;
        case DRUID_FORM_CAMEL:
            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod - MID_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod - MID_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE)  - iRacialConMod - MID_TIER_HIGHSTAT);
            break;
        case DRUID_FORM_HORSE_BROWN:
            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod - MID_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod - MID_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE)  - iRacialConMod - MID_TIER_MIDSTAT);
            break;
        case DRUID_FORM_BISON:
            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod - MID_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod - MID_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE)  - iRacialConMod - MID_TIER_MIDSTAT);
            break;
        case DRUID_FORM_HAWK:
            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod - MID_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod - MID_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE)  - iRacialConMod - MID_TIER_MIDSTAT);
            break;
        case DRUID_FORM_BAT:
        case DRUID_FORM_BAT_FRUIT:
            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod - LOW_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod - LOW_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE)  - iRacialConMod - LOW_TIER_MIDSTAT);
            break;
        case DRUID_FORM_RAT:
            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod - LOW_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod - LOW_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE)  - iRacialConMod - LOW_TIER_HIGHSTAT);
            break;
        case DRUID_FORM_RABBIT:
            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod - LOW_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod - LOW_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE)  - iRacialConMod - LOW_TIER_LOWSTAT);
            break;
        case DRUID_FORM_CAT_BLACKWHITE:
        case DRUID_FORM_CAT_BLACK:
        case DRUID_FORM_CAT_WHITE:
            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod - LOW_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod - LOW_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE)  - iRacialConMod - LOW_TIER_LOWSTAT);
            break;
        case DRUID_FORM_DOG_TERRIER:
            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod - LOW_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod - LOW_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE)  - iRacialConMod - LOW_TIER_MIDSTAT);
            break;
        case DRUID_FORM_BADGER:
            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod - LOW_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod - LOW_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE)  - iRacialConMod - LOW_TIER_HIGHSTAT);
            break;
        case DRUID_FORM_BOAR:
            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod - LOW_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod - LOW_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE)  - iRacialConMod - LOW_TIER_MIDSTAT);
            break;
        case DRUID_FORM_RAVEN:
            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod - LOW_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod - LOW_TIER_MIDSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE)  - iRacialConMod - LOW_TIER_HIGHSTAT);
            break;
        case DRUID_FORM_OWL_BARN:
            SetAbilityScore(oPC, ABILITY_STRENGTH, GetAbilityScore(oPC, ABILITY_STRENGTH, TRUE) - iRacialStrMod - LOW_TIER_LOWSTAT);
            SetAbilityScore(oPC, ABILITY_DEXTERITY, GetAbilityScore(oPC, ABILITY_DEXTERITY, TRUE) - iRacialDexMod - LOW_TIER_HIGHSTAT);
            SetAbilityScore(oPC, ABILITY_CONSTITUTION, GetAbilityScore(oPC, ABILITY_CONSTITUTION, TRUE)  - iRacialConMod - LOW_TIER_MIDSTAT);
            break;
        case DRUID_FORM_ELF: break;
        case DRUID_FORM_HALFELF: break;
        case DRUID_FORM_HALFLING: break;
        case DRUID_FORM_HALFORC: break;
        case DRUID_FORM_HUMAN: break;
        case DRUID_FORM_GNOME: break;
        case DRUID_FORM_DWARF: break;
        case DRUID_FORM_NULL: break;
        default: break;
    }

    SetPersistentInt(oPC, "DRUID_POLY_FORM", DRUID_FORM_NULL);
}

void DoCheckDruidPolymorph(object oPC) {
    if(GetLevelByClass(CLASS_TYPE_DRUID, oPC) < 1) return;

    if(GetPersistentInt(oPC, "DRUID_POLY_FORM") != DRUID_FORM_NULL) DoEndDruidPolymorph(oPC);
}
