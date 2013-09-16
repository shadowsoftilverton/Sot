#include "engine"

#include "aps_include"
#include "nwnx_spells"

#include "inc_arrays"

// This is the highest 2da entry that the caching will search for. ALL HIGHER
// ENTRIES WILL BE COMPLETELY IGNORED.
const int MAX_RANGE = 1000;

const string SPELLBOOK_BARD_  = "spellbook_bard_";
const string SPELLBOOK_BARD_0 = "spellbook_bard_0";
const string SPELLBOOK_BARD_1 = "spellbook_bard_1";
const string SPELLBOOK_BARD_2 = "spellbook_bard_2";
const string SPELLBOOK_BARD_3 = "spellbook_bard_3";
const string SPELLBOOK_BARD_4 = "spellbook_bard_4";
const string SPELLBOOK_BARD_5 = "spellbook_bard_5";
const string SPELLBOOK_BARD_6 = "spellbook_bard_6";

const string SPELLBOOK_WIZSORC_  = "spellbook_wizsorc_";
const string SPELLBOOK_WIZSORC_0 = "spellbook_wizsorc_0";
const string SPELLBOOK_WIZSORC_1 = "spellbook_wizsorc_1";
const string SPELLBOOK_WIZSORC_2 = "spellbook_wizsorc_2";
const string SPELLBOOK_WIZSORC_3 = "spellbook_wizsorc_3";
const string SPELLBOOK_WIZSORC_4 = "spellbook_wizsorc_4";
const string SPELLBOOK_WIZSORC_5 = "spellbook_wizsorc_5";
const string SPELLBOOK_WIZSORC_6 = "spellbook_wizsorc_6";
const string SPELLBOOK_WIZSORC_7 = "spellbook_wizsorc_7";
const string SPELLBOOK_WIZSORC_8 = "spellbook_wizsorc_8";
const string SPELLBOOK_WIZSORC_9 = "spellbook_wizsorc_9";

const string SPELL_TABLE_BARD_0 = "spell_table_bard_0";
const string SPELL_TABLE_BARD_1 = "spell_table_bard_1";
const string SPELL_TABLE_BARD_2 = "spell_table_bard_2";
const string SPELL_TABLE_BARD_3 = "spell_table_bard_3";
const string SPELL_TABLE_BARD_4 = "spell_table_bard_4";
const string SPELL_TABLE_BARD_5 = "spell_table_bard_5";
const string SPELL_TABLE_BARD_6 = "spell_table_bard_6";

const string SPELL_TABLE_WIZSORC_0 = "spell_table_wizsorc_0";
const string SPELL_TABLE_WIZSORC_1 = "spell_table_wizsorc_1";
const string SPELL_TABLE_WIZSORC_2 = "spell_table_wizsorc_2";
const string SPELL_TABLE_WIZSORC_3 = "spell_table_wizsorc_3";
const string SPELL_TABLE_WIZSORC_4 = "spell_table_wizsorc_4";
const string SPELL_TABLE_WIZSORC_5 = "spell_table_wizsorc_5";
const string SPELL_TABLE_WIZSORC_6 = "spell_table_wizsorc_6";
const string SPELL_TABLE_WIZSORC_7 = "spell_table_wizsorc_7";
const string SPELL_TABLE_WIZSORC_8 = "spell_table_wizsorc_8";
const string SPELL_TABLE_WIZSORC_9 = "spell_table_wizsorc_9";

const int TUTOR_DELAY_MINUTES = 5;
const int TUTOR_DELAY_COUNT = 6;

// Returns the number of unlearned spells oPC has at nSpellLevel. Will not return
// negative values, even if oPC has more spells at a given level than they should.
int GetUnlearnedSpells(object oPC, int nClass, int nSpellLevel);

// Caches spellbooks at the beginning of the module.
void CacheSpellbooks();

// Initializes NWNX spellbook functionality, to be run on the OnLoad event of
// the module.
void InitializeCustomSpellbooks();

// Returns if oPC has any unlearned spells for nClass. If nClass is -1 then this
// will return if any of the PC's classes have unlearned spells.
int GetHasUnlearnedSpells(object oPC, int nClass=-1);

// Returns an array with all the spell book entries for nClass of nLevel. On
// errors, returns a blank string.
string GetSpellsBySpellLevel(int nClass, int nLevel);

// Adds any persistent spells oPC has to their spellbook. To be used when they
// log in.
void AddPersistentSpellsToSpellbook(object oPC);

// Adds nSpell to oPC's persistent spellbook at nLevel.
void AddPersistentSpell(object oPC, int nClass, int nLevel, int nSpell);

// Gets all the persistent spells for oPC from nLevel and returns them in an
// array.
string GetPersistentSpells(object oPC, int nClass, int nLevel);

// Removes nSpell from oPC's persistent spellbook.
void RemovePersistentSpell(object oPC, int nClass, int nLevel, int nSpell);

// Returns the caster's actual spellcasting level. Will return strange values
// if used on non-caster class.
int GetEffectiveCasterLevel(object oPC, int nClass);

// ** PRIVATE FUNCTION **
// Returns the appropriate variable name for the nClass/nLevel combo.
string GetSpellbookVariableName(int nClass, int nLevel);

//Applies the new bonus spells known of RDD
int GetRDDBoostSpells(int nLevel, int nClass, object oPC);

//Gets whether they are a sorc/rdd or a bard/rdd, returns the first-level class if they are an rdd with bard AND sorc levels
int GetRDDType(object oPC);

int GetEffectiveCasterLevel(object oPC, int nClass){
    int nLevel = GetLevelByClass(nClass, oPC);

    switch(nClass){
        case CLASS_TYPE_BARD:
        case CLASS_TYPE_SORCERER:
        case CLASS_TYPE_WIZARD:
            nLevel += GetLevelByClass(CLASS_TYPE_ARCHMAGE, oPC);
            nLevel += GetLevelByClass(CLASS_TYPE_MYSTIC_THEURGE, oPC);
            nLevel += GetLevelByClass(CLASS_TYPE_ELDRITCH_KNIGHT, oPC);
            nLevel += (GetLevelByClass(CLASS_TYPE_PALE_MASTER, oPC)+1)/2;
            nLevel += GetLevelByClass(56,oPC);//Arcane Trickster
        break;

        case CLASS_TYPE_RANGER:
        case CLASS_TYPE_DRUID:
        case CLASS_TYPE_CLERIC:
        case CLASS_TYPE_PALADIN:
            nLevel += GetLevelByClass(CLASS_TYPE_MYSTIC_THEURGE, oPC);
        break;
    }

    return nLevel;
}

string GetSpellbookVariableName(int nClass, int nLevel){
    switch(nClass){
        case CLASS_TYPE_BARD:     return SPELLBOOK_BARD_ + IntToString(nLevel);
        case CLASS_TYPE_SORCERER: return SPELLBOOK_WIZSORC_ + IntToString(nLevel);
    }

    return "";
}

void AddPersistentSpellsToSpellbook(object oPC){
    int i;

    for(i = 1; i<=3; i++){
        int nClass = GetClassByPosition(i, oPC);

        int j;

        switch(nClass){
            case CLASS_TYPE_BARD:
                for(j = 0; j <= 6; j++){
                    string sSpells = GetPersistentSpells(oPC, nClass, j);

                    int k;

                    for(k = 0; k < GetArraySize(sSpells); k++){
                        int nSpell = StringToInt(GetArrayElement(sSpells, k));
                        AddKnownSpell(oPC, nClass, j, nSpell);
                    }
                }
            break;

            case CLASS_TYPE_SORCERER:
                for(j = 0; j <= 9; j++){
                    string sSpells = GetPersistentSpells(oPC, nClass, j);

                    int k;

                    for(k = 0; k < GetArraySize(sSpells); k++){
                        int nSpell = StringToInt(GetArrayElement(sSpells, k));

                        AddKnownSpell(oPC, nClass, j, nSpell);
                    }
                }
            break;
        }
    }
}

void AddPersistentSpell(object oPC, int nClass, int nLevel, int nSpell){
    string sArray = GetPersistentSpells(oPC, nClass, nLevel);
    string sTable = GetSpellbookVariableName(nClass, nLevel);

    if(sArray == "") sArray = Array();

    sArray = AddArrayElement(sArray, IntToString(nSpell));

    AddKnownSpell(oPC, nClass, nLevel, nSpell);

    SetPersistentString(oPC, sTable, sArray);
}

string GetPersistentSpells(object oPC, int nClass, int nLevel){
    return GetPersistentString(oPC, GetSpellbookVariableName(nClass, nLevel));
}

void RemovePersistentSpell(object oPC, int nClass, int nLevel, int nSpell){
    string sArray = GetPersistentSpells(oPC, nClass, nLevel);
    string sTable = GetSpellbookVariableName(nClass, nLevel);
    string sSpell = IntToString(nSpell);

    int i;

    for(i = 0; i < GetArraySize(sArray); i++){
        if(GetArrayElement(sArray, i) == sSpell) sArray = RemoveArrayElement(sArray, i);
    }

    RemoveKnownSpell(oPC, nClass, nLevel, nSpell);

    SetPersistentString(oPC, sArray, sTable);
}

int GetRDDType(object oPC)
{
    if(GetLevelByClass(CLASS_TYPE_BARD,oPC)>0&&GetLevelByClass(CLASS_TYPE_SORCERER,oPC)==0) return CLASS_TYPE_BARD;
    else if(GetLevelByClass(CLASS_TYPE_BARD,oPC)==0&&GetLevelByClass(CLASS_TYPE_SORCERER,oPC)>0) return CLASS_TYPE_SORCERER;
    else if(GetLevelByClass(CLASS_TYPE_BARD,oPC)>0&&GetLevelByClass(CLASS_TYPE_SORCERER,oPC)>0) return GetClassByPosition(1,oPC);
    else return -1;//-1 Indicates an error
}

int GetRDDBoostSpells(int nSpellLevel, int nClass, object oPC)
{
    int RDDLevel=GetLevelByClass(37,oPC);//Red Dragon Disciple
    int iClass=GetRDDType(oPC);
    if(iClass==nClass)
    {
        int nBonus;
        switch(nSpellLevel)
        {
            case 1:
            if(RDDLevel==1) return 1;
            else if(RDDLevel>1) return 2;
            break;
            case 2:
            if(RDDLevel==3) return 1;
            else if(RDDLevel>3) return 2;
            break;
            case 3:
            if(RDDLevel==5) return 1;
            else if(RDDLevel>5) return 2;
            break;
            case 4:
            if(RDDLevel==7) return 1;
            else if(RDDLevel>7) return 2;
            break;
            case 5:
            if(RDDLevel==9) return 1;
            else if(RDDLevel>9) return 2;
            break;
            case 6://Level 6 spells, bard get 3 bonus if level 13+
            if(RDDLevel==11) return 1;
            else if(RDDLevel>12&&nClass==CLASS_TYPE_BARD) return 3;
            else if(RDDLevel>11) return 2;
            break;
            case 7://Level 7 spells, sorc get one bonus if level 13+
            if(RDDLevel>12&&nClass==CLASS_TYPE_SORCERER) return 1;
            break;
        }
    }
    return 0;
}

string GetSpellsBySpellLevel(int nClass, int nLevel){
    switch(nClass){
        case CLASS_TYPE_BARD:
            switch(nLevel){
                case 0: return GetLocalString(GetModule(), SPELL_TABLE_BARD_0); break;
                case 1: return GetLocalString(GetModule(), SPELL_TABLE_BARD_1); break;
                case 2: return GetLocalString(GetModule(), SPELL_TABLE_BARD_2); break;
                case 3: return GetLocalString(GetModule(), SPELL_TABLE_BARD_3); break;
                case 4: return GetLocalString(GetModule(), SPELL_TABLE_BARD_4); break;
                case 5: return GetLocalString(GetModule(), SPELL_TABLE_BARD_5); break;
                case 6: return GetLocalString(GetModule(), SPELL_TABLE_BARD_6); break;
            }
        break;

        case CLASS_TYPE_SORCERER:
            switch(nLevel){
                case 0: return GetLocalString(GetModule(), SPELL_TABLE_WIZSORC_0); break;
                case 1: return GetLocalString(GetModule(), SPELL_TABLE_WIZSORC_1); break;
                case 2: return GetLocalString(GetModule(), SPELL_TABLE_WIZSORC_2); break;
                case 3: return GetLocalString(GetModule(), SPELL_TABLE_WIZSORC_3); break;
                case 4: return GetLocalString(GetModule(), SPELL_TABLE_WIZSORC_4); break;
                case 5: return GetLocalString(GetModule(), SPELL_TABLE_WIZSORC_5); break;
                case 6: return GetLocalString(GetModule(), SPELL_TABLE_WIZSORC_6); break;
                case 7: return GetLocalString(GetModule(), SPELL_TABLE_WIZSORC_7); break;
                case 8: return GetLocalString(GetModule(), SPELL_TABLE_WIZSORC_8); break;
                case 9: return GetLocalString(GetModule(), SPELL_TABLE_WIZSORC_9); break;
            }
        break;
    }

    return "";
}

int GetHasUnlearnedSpells(object oPC, int nClass=-1){
    if(GetLevelByClass(nClass, oPC) < 1 && nClass != -1) return FALSE;

    switch(nClass){
        case -1:
            return GetHasUnlearnedSpells(oPC, GetClassByPosition(1, oPC)) ||
                   GetHasUnlearnedSpells(oPC, GetClassByPosition(2, oPC)) ||
                   GetHasUnlearnedSpells(oPC, GetClassByPosition(3, oPC));
        break;

        case CLASS_TYPE_BARD:
        case CLASS_TYPE_SORCERER:
            int i;
            int nRemaining = 0;

            for(i = 0; i < 10; i++){
                nRemaining += GetUnlearnedSpells(oPC, nClass, i);
            }
            return nRemaining > 0;
        break;
    }

    return FALSE;
}

int GetUnlearnedSpells(object oPC, int nClass, int nSpellLevel){
    if(GetLevelByClass(nClass, oPC) < 1) return 0;

    string s2da;


    switch(nClass){
        case CLASS_TYPE_BARD:
            if(nSpellLevel > 6) return 0;
            s2da = "cls_spkn_bard";
        break;

        case CLASS_TYPE_SORCERER:
            if(nSpellLevel > 9) return 0;
            s2da = "cls_spkn_sorc";
        break;
    }

    int nShouldKnow = Get2DAInt(s2da, "SpellLevel" + IntToString(nSpellLevel), GetEffectiveCasterLevel(oPC, nClass) - 1);

    nShouldKnow=nShouldKnow+GetRDDBoostSpells(nSpellLevel,nClass,oPC);//RDD bonus spells known

    if(nShouldKnow == -1) nShouldKnow = 0;

    int nReturn = nShouldKnow - GetTotalKnownSpells(oPC, nClass, nSpellLevel);

    return nReturn > 0 ? nReturn : 0;
}

void CacheSpellbooks(){
    int i = 0;

    int nBard, nWizSorc;

    string aBard0 = Array(), aBard1 = Array(), aBard2 = Array(),
           aBard3 = Array(), aBard4 = Array(), aBard5 = Array(),
           aBard6 = Array();

    string aWizSorc0 = Array(), aWizSorc1 = Array(), aWizSorc2 = Array(),
           aWizSorc3 = Array(), aWizSorc4 = Array(), aWizSorc5 = Array(),
           aWizSorc6 = Array(), aWizSorc7 = Array(), aWizSorc8 = Array(),
           aWizSorc9 = Array();

    string sLabel = Get2DAString("spells", "Label", i);

    while(sLabel != "END_OF_2DA" && i <= MAX_RANGE){
        nBard    = Get2DAInt("spells", "Bard", i);
        nWizSorc = Get2DAInt("spells", "Wiz_Sorc", i);

        switch(nBard){
            case 0: aBard0 = AddArrayElement(aBard0, IntToString(i)); break;
            case 1: aBard1 = AddArrayElement(aBard1, IntToString(i)); break;
            case 2: aBard2 = AddArrayElement(aBard2, IntToString(i)); break;
            case 3: aBard3 = AddArrayElement(aBard3, IntToString(i)); break;
            case 4: aBard4 = AddArrayElement(aBard4, IntToString(i)); break;
            case 5: aBard5 = AddArrayElement(aBard5, IntToString(i)); break;
            case 6: aBard6 = AddArrayElement(aBard6, IntToString(i)); break;
        }

        switch(nWizSorc){
            case 0: aWizSorc0 = AddArrayElement(aWizSorc0, IntToString(i)); break;
            case 1: aWizSorc1 = AddArrayElement(aWizSorc1, IntToString(i)); break;
            case 2: aWizSorc2 = AddArrayElement(aWizSorc2, IntToString(i)); break;
            case 3: aWizSorc3 = AddArrayElement(aWizSorc3, IntToString(i)); break;
            case 4: aWizSorc4 = AddArrayElement(aWizSorc4, IntToString(i)); break;
            case 5: aWizSorc5 = AddArrayElement(aWizSorc5, IntToString(i)); break;
            case 6: aWizSorc6 = AddArrayElement(aWizSorc6, IntToString(i)); break;
            case 7: aWizSorc7 = AddArrayElement(aWizSorc7, IntToString(i)); break;
            case 8: aWizSorc8 = AddArrayElement(aWizSorc8, IntToString(i)); break;
            case 9: aWizSorc9 = AddArrayElement(aWizSorc9, IntToString(i)); break;
        }

        sLabel = Get2DAString("spells", "Label", ++i);
    }

    object oMod = GetModule();

    SetLocalString(oMod, SPELL_TABLE_BARD_0, aBard0);
    SetLocalString(oMod, SPELL_TABLE_BARD_1, aBard1);
    SetLocalString(oMod, SPELL_TABLE_BARD_2, aBard2);
    SetLocalString(oMod, SPELL_TABLE_BARD_3, aBard3);
    SetLocalString(oMod, SPELL_TABLE_BARD_4, aBard4);
    SetLocalString(oMod, SPELL_TABLE_BARD_5, aBard5);
    SetLocalString(oMod, SPELL_TABLE_BARD_6, aBard6);

    SetLocalString(oMod, SPELL_TABLE_WIZSORC_0, aWizSorc0);
    SetLocalString(oMod, SPELL_TABLE_WIZSORC_1, aWizSorc1);
    SetLocalString(oMod, SPELL_TABLE_WIZSORC_2, aWizSorc2);
    SetLocalString(oMod, SPELL_TABLE_WIZSORC_3, aWizSorc3);
    SetLocalString(oMod, SPELL_TABLE_WIZSORC_4, aWizSorc4);
    SetLocalString(oMod, SPELL_TABLE_WIZSORC_5, aWizSorc5);
    SetLocalString(oMod, SPELL_TABLE_WIZSORC_6, aWizSorc6);
    SetLocalString(oMod, SPELL_TABLE_WIZSORC_7, aWizSorc7);
    SetLocalString(oMod, SPELL_TABLE_WIZSORC_8, aWizSorc8);
    SetLocalString(oMod, SPELL_TABLE_WIZSORC_9, aWizSorc9);
}

void InitializeCustomSpellbooks(){
    SetClassCasterAbility(CLASS_TYPE_ASSASSIN, ABILITY_INTELLIGENCE);
}
