//::////////////////////////////////////////////////////////////////////////:://
//:: ENGINE.NSS                                                             :://
//:: Silver Marches Script                                                  :://
//::////////////////////////////////////////////////////////////////////////:://
/*
    Core include file that handles module-wide funcs. Also contains the override
    versions of several nwscript.nss functions, essentially modifying otherwise
    core functions.

    Every file in the module, with the exception of engine.nss and nwscript.nss
    and NWNX files should have an include for this. This means every single file
    that will run, not merely the custom ones. To avoid putting a large download
    tithe on the client, everything should be put in the override of the server.

    Universal constants don't go in here. They can be safely added to the
    nwscript.nss.
*/
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By: Ashton Shapcott                                            :://
//:: Created On: Nov. 1, 2010                                               :://
//::////////////////////////////////////////////////////////////////////////:://
//:: Modified By: Ashton Shapcott                                           :://
//:: Modified On: Nov. 30, 2010                                             :://
//:: * Documentation updates.:://

#include "nwnx_funcs"
#include "nwnx_structs"
#include "nwnx_defenses"
#include "nwnx_weapons"

const int IP_CONST_DAMAGEBONUS_11=21;
const int IP_CONST_DAMAGEBONUS_12=22;
const int IP_CONST_DAMAGEBONUS_13=23;
const int IP_CONST_DAMAGEBONUS_14=24;
const int IP_CONST_DAMAGEBONUS_15=25;
const int IP_CONST_DAMAGEBONUS_16=26;
const int IP_CONST_DAMAGEBONUS_17=27;
const int IP_CONST_DAMAGEBONUS_18=28;
const int IP_CONST_DAMAGEBONUS_19=29;
const int IP_CONST_DAMAGEBONUS_20=30;
const int IP_CONST_DAMAGEBONUS_3d4=31;
const int IP_CONST_DAMAGEBONUS_4d4=32;
const int IP_CONST_DAMAGEBONUS_5d4=33;
const int IP_CONST_DAMAGEBONUS_6d4=34;
const int IP_CONST_DAMAGEBONUS_7d4=35;
const int IP_CONST_DAMAGEBONUS_8d4=36;
const int IP_CONST_DAMAGEBONUS_9d4=37;
const int IP_CONST_DAMAGEBONUS_10d4=38;
const int IP_CONST_DAMAGEBONUS_3d6=39;
const int IP_CONST_DAMAGEBONUS_4d6=40;
const int IP_CONST_DAMAGEBONUS_5d6=41;
const int IP_CONST_DAMAGEBONUS_6d6=42;
const int IP_CONST_DAMAGEBONUS_7d6=43;
const int IP_CONST_DAMAGEBONUS_8d6=44;
const int IP_CONST_DAMAGEBONUS_9d6=45;
const int IP_CONST_DAMAGEBONUS_10d6=46;
const int IP_CONST_DAMAGEBONUS_11d6=47;
const int IP_CONST_DAMAGEBONUS_12d6=48;
const int IP_CONST_DAMAGEBONUS_13d6=49;
const int IP_CONST_DAMAGEBONUS_14d6=50;
const int IP_CONST_DAMAGEBONUS_15d6=51;
const int IP_CONST_DAMAGEBONUS_3d8=52;
const int IP_CONST_DAMAGEBONUS_4d8=53;
const int IP_CONST_DAMAGEBONUS_5d8=54;
const int IP_CONST_DAMAGEBONUS_6d8=55;
const int IP_CONST_DAMAGEBONUS_7d8=56;
const int IP_CONST_DAMAGEBONUS_8d8=57;
const int IP_CONST_DAMAGEBONUS_9d8=58;
const int IP_CONST_DAMAGEBONUS_10d8=59;
const int IP_CONST_DAMAGEBONUS_11d8=60;
const int IP_CONST_DAMAGEBONUS_12d8=61;
const int IP_CONST_DAMAGEBONUS_13d8=62;
const int IP_CONST_DAMAGEBONUS_14d8=63;
const int IP_CONST_DAMAGEBONUS_15d8=64;
const int IP_CONST_DAMAGEBONUS_3d10=65;
const int IP_CONST_DAMAGEBONUS_4d10=66;
const int IP_CONST_DAMAGEBONUS_5d10=67;
const int IP_CONST_DAMAGEBONUS_6d10=68;
const int IP_CONST_DAMAGEBONUS_7d10=69;
const int IP_CONST_DAMAGEBONUS_8d10=70;
const int IP_CONST_DAMAGEBONUS_9d10=71;
const int IP_CONST_DAMAGEBONUS_10d10=72;
const int IP_CONST_DAMAGEBONUS_11d10=73;
const int IP_CONST_DAMAGEBONUS_12d10=74;
const int IP_CONST_DAMAGEBONUS_13d10=75;
const int IP_CONST_DAMAGEBONUS_14d10=76;
const int IP_CONST_DAMAGEBONUS_15d10=77;
const int IP_CONST_DAMAGEBONUS_3d12=78;
const int IP_CONST_DAMAGEBONUS_4d12=79;
const int IP_CONST_DAMAGEBONUS_5d12=80;
const int IP_CONST_DAMAGEBONUS_6d12=81;
const int IP_CONST_DAMAGEBONUS_7d12=82;
const int IP_CONST_DAMAGEBONUS_8d12=83;
const int IP_CONST_DAMAGEBONUS_9d12=84;
const int IP_CONST_DAMAGEBONUS_10d12=85;
const int IP_CONST_DAMAGEBONUS_3d20=86;
const int IP_CONST_DAMAGEBONUS_4d20=87;
const int IP_CONST_DAMAGEBONUS_5d20=88;
const int IP_CONST_DAMAGEBONUS_6d20=89;
const int IP_CONST_DAMAGEBONUS_7d20=90;
const int IP_CONST_DAMAGEBONUS_8d20=91;
const int IP_CONST_DAMAGEBONUS_9d20=92;
const int IP_CONST_DAMAGEBONUS_10d20=93;
const int IP_CONST_DAMAGEBONUS_11d20=94;
const int IP_CONST_DAMAGEBONUS_12d20=95;
const int IP_CONST_DAMAGEBONUS_13d20=96;
const int IP_CONST_DAMAGEBONUS_14d20=97;
const int IP_CONST_DAMAGEBONUS_15d20=98;
const int IP_CONST_DAMAGEBONUS_16d20=99;
const int IP_CONST_DAMAGEBONUS_17d20=100;
const int IP_CONST_DAMAGEBONUS_18d20=101;
const int IP_CONST_DAMAGEBONUS_19d20=102;
const int IP_CONST_DAMAGEBONUS_20d20=103;
//More d20's here, all the way up to 40d20, which we will never use.
const int IP_CONST_DAMAGEBONUS_11d12=124;
const int IP_CONST_DAMAGEBONUS_12d12=125;
const int IP_CONST_DAMAGEBONUS_13d12=126;
const int IP_CONST_DAMAGEBONUS_14d12=127;
const int IP_CONST_DAMAGEBONUS_15d12=128;
const int IP_CONST_DAMAGEBONUS_16d12=129;
const int IP_CONST_DAMAGEBONUS_17d12=130;
const int IP_CONST_DAMAGEBONUS_18d12=131;
const int IP_CONST_DAMAGEBONUS_19d12=132;
const int IP_CONST_DAMAGEBONUS_20d12=133;
const int IP_CONST_DAMAGEBONUS_11d4=134;
const int IP_CONST_DAMAGEBONUS_12d4=135;
const int IP_CONST_DAMAGEBONUS_13d4=136;
const int IP_CONST_DAMAGEBONUS_14d4=137;
const int IP_CONST_DAMAGEBONUS_15d4=138;
const int IP_CONST_DAMAGEBONUS_16d4=139;
const int IP_CONST_DAMAGEBONUS_17d4=140;
const int IP_CONST_DAMAGEBONUS_18d4=141;
const int IP_CONST_DAMAGEBONUS_19d4=142;
const int IP_CONST_DAMAGEBONUS_20d4=143;
const int IP_CONST_DAMAGEBONUS_16d6=144;
const int IP_CONST_DAMAGEBONUS_17d6=145;
const int IP_CONST_DAMAGEBONUS_18d6=146;
const int IP_CONST_DAMAGEBONUS_19d6=147;
const int IP_CONST_DAMAGEBONUS_20d6=148;
const int IP_CONST_DAMAGEBONUS_16d8=149;
const int IP_CONST_DAMAGEBONUS_17d8=150;
const int IP_CONST_DAMAGEBONUS_18d8=151;
const int IP_CONST_DAMAGEBONUS_19d8=152;
const int IP_CONST_DAMAGEBONUS_20d8=153;
const int IP_CONST_DAMAGEBONUS_16d10=154;
const int IP_CONST_DAMAGEBONUS_17d10=155;
const int IP_CONST_DAMAGEBONUS_18d10=156;
const int IP_CONST_DAMAGEBONUS_19d10=157;
const int IP_CONST_DAMAGEBONUS_20d10=158;

const int SKILL_CRAFT_ACCESSORY=46;
const int SKILL_CRAFT_JEWELRY=47;
const int VFX_DUR_MIRROR_IMAGE=0;

//::////////////////////////////////////////////////////////////////////////:://
//:: DECLARATION                                                            :://
//::////////////////////////////////////////////////////////////////////////:://

// Gets the ceiling of fValue as an integer.
int ceil(float fValue);

// Gets the floor of the fValue as an integer.
int floor(float fValue);

// Returns the closest value to fValue as an integer.
int round(float fValue);

// Returns the greater of nA and nB.
int max(int nA, int nB);

// Returns the smaller of nA and nB.
int min(int nA, int nB);

// Returns the greater of fA and fB.
float fmax(float fA, float fB);

// Returns the smaller of fA and fB.
float fmin(float fA, float fB);

// Gets a value from a 2DA file on the server and returns it as an int.
// avoid using this function in loops
// - s2DA: the name of the 2da file, 16 chars max
// - sColumn: the name of the column in the 2da
// - nRow: the row in the 2da
// * returns -1 if file, row, or column not found
int Get2DAInt(string s2DA, string sColumn, int nRow);

// Get if oPC has the appropriate feats to use oItem. Items that do not require
// feats normally (i.e. amulets, bracers, etc.) will return TRUE.
int GetIsProficient(object oItem, object oPC=OBJECT_SELF);

// Returns a skill's name from the tlk table.
string GetSkillName(int nSkill);

// Returns nClass's name from the tlk table.
string GetClassName(int nClass);

// Returns true if 1d20 roll + skill rank is greater than or equal to difficulty
// - oTarget: the creature using the skill
// - nSkill: the skill being used
// - nDifficulty: Difficulty class of skill
// - bStraight: If TRUE, makes the comparison without a roll. Straight comparisons
//              do not provide feedback to the player.
int GetIsSkillSuccessful(object oTarget, int nSkill, int nDifficulty, int bStraight = FALSE);//Prototype commented out due to compile errors

// Get the number of ranks that oTarget has in nSkill.
// - nSkill: SKILL_*
// - oTarget
// - nBaseSkillRank: if set to true returns the number of base skill ranks the target
//                   has (i.e. not including any bonuses from ability scores, feats, etc).
// * Returns -1 if oTarget doesn't have nSkill.
// * Returns 0 if nSkill is untrained.
int GetSkillRank(int nSkill, object oTarget=OBJECT_SELF, int nBaseSkillRank=FALSE);

// Get the level at which this creature cast its last spell (or spell-like ability)
// * Return value on error, or if oCreature has not yet cast a spell: 0;
int GetCasterLevel(object oCreature);

// Returns the spell school of the last spell called.
int GetSpellSchool();

// Get the DC to save against for a spell (10 + spell level + relevant ability
// bonus).  This can be called by a creature or by an Area of Effect object.
int GetSpellSaveDC();

// Do a Fortitude Save check for the given DC
// - oCreature
// - nDC: Difficulty check
// - nSaveType: SAVING_THROW_TYPE_*
// - oSaveVersus
// Returns: 0 if the saving throw roll failed
// Returns: 1 if the saving throw roll succeeded
// Returns: 2 if the target was immune to the save type specified
// Note: If used within an Area of Effect Object Script (On Enter, OnExit, OnHeartbeat), you MUST pass
// GetAreaOfEffectCreator() into oSaveVersus!!
int FortitudeSave(object oCreature, int nDC, int nSaveType=SAVING_THROW_TYPE_NONE, object oSaveVersus=OBJECT_SELF);

// Does a Reflex Save check for the given DC
// - oCreature
// - nDC: Difficulty check
// - nSaveType: SAVING_THROW_TYPE_*
// - oSaveVersus
// Returns: 0 if the saving throw roll failed
// Returns: 1 if the saving throw roll succeeded
// Returns: 2 if the target was immune to the save type specified
// Note: If used within an Area of Effect Object Script (On Enter, OnExit, OnHeartbeat), you MUST pass
// GetAreaOfEffectCreator() into oSaveVersus!!
int ReflexSave(object oCreature, int nDC, int nSaveType=SAVING_THROW_TYPE_NONE, object oSaveVersus=OBJECT_SELF);

// Does a Will Save check for the given DC
// - oCreature
// - nDC: Difficulty check
// - nSaveType: SAVING_THROW_TYPE_*
// - oSaveVersus
// Returns: 0 if the saving throw roll failed
// Returns: 1 if the saving throw roll succeeded
// Returns: 2 if the target was immune to the save type specified
// Note: If used within an Area of Effect Object Script (On Enter, OnExit, OnHeartbeat), you MUST pass
// GetAreaOfEffectCreator() into oSaveVersus!!
int WillSave(object oCreature, int nDC, int nSaveType=SAVING_THROW_TYPE_NONE, object oSaveVersus=OBJECT_SELF);

// Gets the name of nFeat.
string GetFeatName(int nFeat);

// Gets the name of nAbility.
// * Returns "" on error.
string GetAbilityName(int nAbility);

// Gets the base armor class of oItem, providing it's a shield or armor.
// Returns -1 on error.
int GetBaseACValue(object oItem);

// Remove eEffect from oCreature.
// * No return value
void RemoveEffect(object oCreature, effect eEffect);

// removes an item property from the specified item
void RemoveItemProperty(object oItem, itemproperty ipProperty);

// Gets oItem's AC value.
int GetItemACBase(object oItem);

// Returns the character with sName on sAccount, or OBJECT_INVALID if there is
// no match.
object GetPCByKey(string sName, string sAccount);

// Jump all the playerrs in oMember's location within fRadius of oMember to lLoc.
void JumpPartyToLocation(object oMember, location lLoc, float fRadius = 30.0);

//::////////////////////////////////////////////////////////////////////////:://
//:: IMPLEMENTATION                                                         :://
//::////////////////////////////////////////////////////////////////////////:://

int ceil(float fValue){
    // Truncates the decimal then checks if the difference between the value
    // and its floor is greater than 0.
    return floor(fValue) + 1;
    if((fValue - IntToFloat(FloatToInt(fValue))) > 0.0) return FloatToInt(fValue + 1);
    else                                                return FloatToInt(fValue);
}

int floor(float fValue){
    return FloatToInt(fValue);
}

int round(float fValue){
    return FloatToInt(fValue + 0.5);
}

int max(int nA, int nB){
    if(nA > nB) return nA;
    else        return nB;
}

int min(int nA, int nB){
    if(nA < nB) return nA;
    else        return nB;
}

float fmax(float fA, float fB){
    if(fA > fB) return fA;
    else        return fB;
}

float fmin(float fA, float fB){
    if(fA < fB) return fA;
    else        return fB;
}

int Get2DAInt(string s2DA, string sColumn, int nRow){
    string sEntry = Get2DAString(s2DA, sColumn, nRow);

    if(sEntry == "") return -1;

    return StringToInt(sEntry);
}

int GetIsProficient(object oItem, object oPC=OBJECT_SELF){
    int nBaseItem = GetBaseItemType(oItem);

    int nNeedsProf = Get2DAInt("baseitem_feats", "HasProf", nBaseItem);

    int bReturn;
    int i;


    if(nNeedsProf){
        for(i = 0; i < 5; i++){
            string s = IntToString(i);
            int nFeat = Get2DAInt("baseitem_feats", "ProfFeat" + s, nBaseItem);
            if(GetHasFeat(nFeat, oPC)) return TRUE;
        }

        return FALSE;
    }

    // Defaults to TRUE.
    return TRUE;
}

string GetSkillName(int nSkill){
    int nTlk = StringToInt(Get2DAString("skills", "name", nSkill));
    return GetStringByStrRef(nTlk);
}

string GetClassName(int nClass){
    int nTlk = StringToInt(Get2DAString("classes", "name", nClass));
    return GetStringByStrRef(nTlk);
}

int GetIsSkillSuccessful(object oTarget, int nSkill, int nDifficulty, int bStraight = FALSE)
{
    // Skills made before Ride get full support in terms of feats, so no need to
    // modify their check.
    // if(nSkill < SKILL_RIDE) return Std_GetIsSkillSuccessful(oTarget, nSkill, nDifficulty);

    int nRank = GetSkillRank(nSkill, oTarget);

    if(bStraight) return nRank >= nDifficulty;

    int nRoll = d20();
    int nResult = nRank + nRoll;
    int nSuccess = nResult >= nDifficulty;

    string sRank;
    if(nRank < 0) sRank = " - " + IntToString(abs(nRank));
    else sRank = " + " + IntToString(nRank);

    string sRoll = IntToString(nRoll);
    string sResult = IntToString(nResult);
    string sName = COLOR_NAME + GetName(oTarget) + COLOR_END;
    string sSkill = GetSkillName(nSkill);
    string sDifficulty = IntToString(nDifficulty);
    string sReport;

    if(nSuccess) sReport = "*success*";
    else         sReport = "*failure*";

    string sFloating = COLOR_WHITE + sSkill + ": " + sReport + COLOR_END;
    string sFeedback = sName + COLOR_SKILL_CHECK + " : " + sSkill + " : "
        + sReport + " : " + "(" + sRoll + sRank + " = " + sResult
        + " vs. DC " + sDifficulty + ")" + COLOR_END;

    //FloatingTextStringOnCreature(sFloating, oTarget, FALSE);
    SendMessageToPC(oTarget, sFeedback);

    return nSuccess;
}

int GetSkillRank(int nSkill, object oTarget=OBJECT_SELF, int nBaseSkillRank=FALSE){
    // If we're looking for base skill ranks, the standard function will give
    // us correct results.
    if(nBaseSkillRank) return Std_GetSkillRank(nSkill, oTarget, nBaseSkillRank);

    // Every skill made before the Ride skill has feats for their skill focuses
    // that work just fine. We only need to worry about the custom skills having
    // inaccurate values.
    if(nSkill < SKILL_RIDE) return Std_GetSkillRank(nSkill, oTarget, nBaseSkillRank);

    // Snag our rank. This should be accurate, save for the feat modifiers will
    // be missing.
    int nRank = Std_GetSkillRank(nSkill, oTarget);

    int nLoreModifier = 0;

    nLoreModifier += GetLevelByClass(CLASS_TYPE_BARD, oTarget)/2;
    nLoreModifier += GetLevelByClass(CLASS_TYPE_HARPER, oTarget)/2;

    switch(nSkill){
        case SKILL_K_ARCANA:
            if(GetHasFeat(FEAT_SKILL_FOCUS_K_ARCANA, oTarget)) nRank += 3;
            if(GetHasFeat(FEAT_EPIC_SKILL_FOCUS_K_ARCANA, oTarget)) nRank += 10;
        break;
        case SKILL_K_NOBILITY:
            if(GetHasFeat(FEAT_SKILL_FOCUS_K_NOBILITY, oTarget)) nRank += 3;
            if(GetHasFeat(FEAT_EPIC_SKILL_FOCUS_K_NOBILITY, oTarget)) nRank += 10;

            if(GetHasFeat(FEAT_BARDIC_KNOWLEDGE, oTarget)) nRank += nLoreModifier;
        break;
        case SKILL_K_LOCAL:
            if(GetHasFeat(FEAT_SKILL_FOCUS_K_LOCAL, oTarget)) nRank += 3;
            if(GetHasFeat(FEAT_EPIC_SKILL_FOCUS_K_LOCAL, oTarget)) nRank += 10;

            if(GetHasFeat(FEAT_BARDIC_KNOWLEDGE, oTarget)) nRank += nLoreModifier;
        break;
        case SKILL_GATHER_INFORMATION:
            if(GetHasFeat(FEAT_SKILL_FOCUS_GATHER_INFORMATION, oTarget)) nRank += 3;
            if(GetHasFeat(FEAT_EPIC_SKILL_FOCUS_GATHER_INFORMATION, oTarget)) nRank += 10;

            if(GetHasFeat(FEAT_BARDIC_KNOWLEDGE, oTarget)) nRank += nLoreModifier;
        break;
        case SKILL_SENSE_MOTIVE:
            if(GetHasFeat(FEAT_SKILL_FOCUS_SENSE_MOTIVE, oTarget)) nRank += 3;
            if(GetHasFeat(FEAT_EPIC_SKILL_FOCUS_SENSE_MOTIVE, oTarget)) nRank += 10;
        break;
        case SKILL_DISGUISE:
            if(GetHasFeat(FEAT_SKILL_FOCUS_DISGUISE, oTarget)) nRank += 3;
            if(GetHasFeat(FEAT_EPIC_SKILL_FOCUS_DISGUISE, oTarget)) nRank += 10;
        break;
        case SKILL_FORGERY:
            if(GetHasFeat(FEAT_SKILL_FOCUS_FORGERY, oTarget)) nRank += 3;
            if(GetHasFeat(FEAT_EPIC_SKILL_FOCUS_FORGERY, oTarget)) nRank += 10;
        break;
        case SKILL_ESCAPE_ARTIST:
            if(GetHasFeat(FEAT_SKILL_FOCUS_ESCAPE_ARTIST, oTarget)) nRank += 3;
            if(GetHasFeat(FEAT_EPIC_SKILL_FOCUS_ESCAPE_ARTIST, oTarget)) nRank += 10;
        break;
        case SKILL_DECIPHER_SCRIPT:
            if(GetHasFeat(FEAT_SKILL_FOCUS_DECIPHER_SCRIPT, oTarget)) nRank += 3;
            if(GetHasFeat(FEAT_EPIC_SKILL_FOCUS_DECIPHER_SCRIPT, oTarget)) nRank += 10;
        break;
        case SKILL_K_ENGINEERING:
            if(GetHasFeat(FEAT_SKILL_FOCUS_K_ENGINEERING, oTarget)) nRank += 3;
            if(GetHasFeat(FEAT_EPIC_SKILL_FOCUS_K_ENGINEERING, oTarget)) nRank += 10;
        break;
        case SKILL_K_DUNGEONEERING:
            if(GetHasFeat(FEAT_SKILL_FOCUS_K_DUNGEONEERING, oTarget)) nRank += 3;
            if(GetHasFeat(FEAT_EPIC_SKILL_FOCUS_K_DUNGEONEERING, oTarget)) nRank += 10;
        break;
        case SKILL_K_GEOGRAPHY:
            if(GetHasFeat(FEAT_SKILL_FOCUS_K_GEOGRAPHY, oTarget)) nRank += 3;
            if(GetHasFeat(FEAT_EPIC_SKILL_FOCUS_K_GEOGRAPHY, oTarget)) nRank += 10;

            if(GetHasFeat(FEAT_BARDIC_KNOWLEDGE, oTarget)) nRank += nLoreModifier;
        break;
        case SKILL_K_HISTORY:
            if(GetHasFeat(FEAT_SKILL_FOCUS_K_HISTORY, oTarget)) nRank += 3;
            if(GetHasFeat(FEAT_EPIC_SKILL_FOCUS_K_HISTORY, oTarget)) nRank += 10;

            if(GetHasFeat(FEAT_BARDIC_KNOWLEDGE, oTarget)) nRank += nLoreModifier;
        break;
        case SKILL_K_NATURE:
            if(GetHasFeat(FEAT_SKILL_FOCUS_K_NATURE, oTarget)) nRank += 3;
            if(GetHasFeat(FEAT_EPIC_SKILL_FOCUS_K_NATURE, oTarget)) nRank += 10;
        break;
        case SKILL_K_RELIGION:
            if(GetHasFeat(FEAT_SKILL_FOCUS_K_RELIGION, oTarget)) nRank += 3;
            if(GetHasFeat(FEAT_EPIC_SKILL_FOCUS_K_RELIGION, oTarget)) nRank += 10;
        break;
        case SKILL_K_PLANES:
            if(GetHasFeat(FEAT_SKILL_FOCUS_K_PLANES, oTarget)) nRank += 3;
            if(GetHasFeat(FEAT_EPIC_SKILL_FOCUS_K_PLANES, oTarget)) nRank += 10;
        break;
        case SKILL_SURVIVAL:
            if(GetHasFeat(FEAT_SKILL_FOCUS_SURVIVAL, oTarget)) nRank += 3;
            if(GetHasFeat(FEAT_EPIC_SKILL_FOCUS_SURVIVAL, oTarget)) nRank += 10;
        break;
        case SKILL_CRAFT_ACCESSORY:
            if(GetHasFeat(1396, oTarget)) nRank += 3;
            if(GetHasFeat(1398, oTarget)) nRank += 10;
        break;
        case SKILL_CRAFT_JEWELRY:
            if(GetHasFeat(1395, oTarget)) nRank += 3;
            if(GetHasFeat(1397, oTarget)) nRank += 10;
        break;
    }

    return nRank;
}

//Returns true if the target is in wild magic mode, otherwise returns false
int bGetIsWildMagic(object oTarget)
{
    if(GetLocalInt(oTarget,"ave_cl_wild")==1) return TRUE;
    return FALSE;
}

//Returns true if the target is in fixed-caster-level mode, otherwise returns false
int bGetIsFixedCL(object oTarget)
{
    if(GetLocalInt(oTarget,"ave_cl_boolfix")==1) return TRUE;
    return FALSE;
}

//Returns the caster level of the PC in nClass. If nClass is -1, uses bioware
//code to get base caster level. This function should never return a value less
//than 1 as it will cause strange spell bugs if it does.
int GetCasterLevelByClass(object oCreature, int nClass)
{
    if(bGetIsFixedCL(oCreature))
    {
        int iFix=GetLocalInt(oCreature,"ave_cl_fixnum");
        if(iFix<1) iFix=1;//This shouldn't ever be possible, but just as a safety...
        SendMessageToPC(oCreature, "Caster Level: " + IntToString(iFix));
        return iFix;
    }

    int nLevel;

    if(nClass==-1)
    {
        nLevel=Std_GetCasterLevel(oCreature);
        nClass=GetLastSpellCastClass();
        //SendMessageToPC(oPC,"Casting a spell as class type "+IntToString(nClass));
    }
    else nLevel=GetLevelByClass(nClass,oCreature);

    if(GetLocalInt(oCreature,"ave_hierset")==1)
    {
        nClass=GetLocalInt(oCreature,"ave_hiercls");
        nLevel=GetLocalInt(oCreature,"ave_hierlev");
    }

    if(nClass == CLASS_TYPE_WIZARD || nClass == CLASS_TYPE_SORCERER
    || nClass == CLASS_TYPE_BARD){
        nLevel += GetLevelByClass(CLASS_TYPE_ARCHMAGE, oCreature);
        nLevel += GetLevelByClass(CLASS_TYPE_MYSTIC_THEURGE, oCreature);
        nLevel += GetLevelByClass(CLASS_TYPE_ELDRITCH_KNIGHT, oCreature);
        nLevel += (GetLevelByClass(CLASS_TYPE_PALE_MASTER, oCreature)+1)/2;
        nLevel += GetLevelByClass(56, oCreature);

        // This needs to be done here because of things like spell power, which
        // can actually increase your caster level beyond your character level.
        switch(nClass){
            case CLASS_TYPE_WIZARD:
                if(GetHasFeat(FEAT_PRACTICED_SPELLCASTER_WIZARD, oCreature))
                    nLevel += 4;
            break;

            case CLASS_TYPE_SORCERER:
                if(GetHasFeat(FEAT_PRACTICED_SPELLCASTER_SORCERER, oCreature))
                    nLevel += 4;

            break;

            case CLASS_TYPE_BARD:
                if(GetHasFeat(FEAT_PRACTICED_SPELLCASTER_BARD, oCreature))
                    nLevel += 4;
            break;
        }

        // If our caster level exceeds our character level, set it back down.
        if(nLevel > GetHitDice(oCreature)) nLevel = GetHitDice(oCreature);

        // The whole point of the Spell Power feats is to breach the character
        // level cap on caster level, so they ignore the above check.
        if(GetHasFeat(FEAT_SPELL_POWER_5, oCreature)) nLevel += 5;
        else if(GetHasFeat(FEAT_SPELL_POWER_4, oCreature)) nLevel += 4;
        else if(GetHasFeat(FEAT_SPELL_POWER_3, oCreature)) nLevel += 3;
        else if(GetHasFeat(FEAT_SPELL_POWER_2, oCreature)) nLevel += 2;
        else if(GetHasFeat(FEAT_SPELL_POWER_1, oCreature)) nLevel += 1;
    } else if(nClass == CLASS_TYPE_CLERIC || nClass == CLASS_TYPE_DRUID
           || nClass == CLASS_TYPE_PALADIN || nClass == CLASS_TYPE_RANGER){
        nLevel += GetLevelByClass(CLASS_TYPE_MYSTIC_THEURGE, oCreature);
        nLevel += GetLevelByClass(50,oCreature);
        // This needs to be done here because of things like spell power, which
        // can actually increase your caster level beyond your character level.
        switch(nClass){
            case CLASS_TYPE_CLERIC:
                if(GetHasFeat(FEAT_PRACTICED_SPELLCASTER_CLERIC, oCreature))
                    nLevel += 4;
            break;

            case CLASS_TYPE_DRUID:
                if(GetHasFeat(FEAT_PRACTICED_SPELLCASTER_DRUID, oCreature))
                    nLevel += 4;

            break;

            case CLASS_TYPE_PALADIN:
                if(GetHasFeat(FEAT_PRACTICED_SPELLCASTER_PALADIN, oCreature))
                    nLevel += 4;
            break;

            case CLASS_TYPE_RANGER:
                if(GetHasFeat(FEAT_PRACTICED_SPELLCASTER_RANGER, oCreature))
                    nLevel += 4;
            break;
        }

        // If our caster level exceeds our character level, set it back down.
        if(nLevel > GetHitDice(oCreature)) nLevel = GetHitDice(oCreature);
        // The whole point of the Spell Power feats is to breach the character
        // level cap on caster level, so they ignore the above check.
        if(GetHasFeat(1562, oCreature)) nLevel += 5;
        else if(GetHasFeat(1561, oCreature)) nLevel += 4;
        else if(GetHasFeat(1560, oCreature)) nLevel += 3;
        else if(GetHasFeat(1559, oCreature)) nLevel += 2;
        else if(GetHasFeat(1558, oCreature)) nLevel += 1;
    }

    if(bGetIsWildMagic(oCreature))
    {
        if(d10()>4)
        {
            nLevel=nLevel+d8()+Random(8);
        }
        else nLevel=nLevel-(Random(8)+Random(8));
    }
    if(nLevel<1) nLevel=1;
    SendMessageToPC(oCreature, "Caster Level: " + IntToString(nLevel));

    return nLevel;
}

int GetCasterLevel(object oCreature){
    int nLevel=GetCasterLevelByClass(oCreature,-1);
    return nLevel;
}

int GetSpellSchool(){
    string sSchool = Get2DAString("spells", "School", GetSpellId());

    if(sSchool == "A") return SPELL_SCHOOL_ABJURATION;
    if(sSchool == "C") return SPELL_SCHOOL_CONJURATION;
    if(sSchool == "D") return SPELL_SCHOOL_DIVINATION;
    if(sSchool == "E") return SPELL_SCHOOL_ENCHANTMENT;
    if(sSchool == "V") return SPELL_SCHOOL_EVOCATION;
    if(sSchool == "I") return SPELL_SCHOOL_ILLUSION;
    if(sSchool == "N") return SPELL_SCHOOL_NECROMANCY;
    if(sSchool == "T") return SPELL_SCHOOL_TRANSMUTATION;

    return SPELL_SCHOOL_GENERAL;
}

int GetSpellSaveDC(){
    object oCaster = GetAreaOfEffectCreator();

    if(oCaster == OBJECT_INVALID){
        oCaster = OBJECT_SELF;
    }

    int nDC = Std_GetSpellSaveDC();
    int nSchool = GetSpellSchool();
    if(GetLevelByClass(CLASS_TYPE_WIZARD,oCaster)==GetHitDice(oCaster)&&GetWizardSpecialization(oCaster)==nSchool) nDC++;
    switch(nSchool){
        case SPELL_SCHOOL_ABJURATION:
            if(GetHasFeat(FEAT_EPIC_SPELL_FOCUS_ABJURATION, oCaster))
                nDC -= 3;
            else if(GetHasFeat(FEAT_GREATER_SPELL_FOCUS_ABJURATION, oCaster))
                nDC -= 2;
            else if(GetHasFeat(FEAT_SPELL_FOCUS_ABJURATION, oCaster))
                nDC -= 1;
        break;

        case SPELL_SCHOOL_CONJURATION:
            if(GetHasFeat(FEAT_EPIC_SPELL_FOCUS_CONJURATION, oCaster))
                nDC -= 3;
            else if(GetHasFeat(FEAT_GREATER_SPELL_FOCUS_CONJURATION, oCaster))
                nDC -= 2;
            else if(GetHasFeat(FEAT_SPELL_FOCUS_CONJURATION, oCaster))
                nDC -= 1;
        break;

        case SPELL_SCHOOL_DIVINATION:
            if(GetHasFeat(FEAT_EPIC_SPELL_FOCUS_DIVINATION, oCaster))
                nDC -= 3;
            else if(GetHasFeat(FEAT_GREATER_SPELL_FOCUS_DIVINATION, oCaster))
                nDC -= 2;
            else if(GetHasFeat(FEAT_SPELL_FOCUS_DIVINATION, oCaster))
                nDC -= 1;
        break;

        case SPELL_SCHOOL_ENCHANTMENT:
            if(GetHasFeat(FEAT_EPIC_SPELL_FOCUS_ENCHANTMENT, oCaster))
                nDC -= 3;
            else if(GetHasFeat(FEAT_GREATER_SPELL_FOCUS_ENCHANTMENT, oCaster))
                nDC -= 2;
            else if(GetHasFeat(FEAT_SPELL_FOCUS_ENCHANTMENT, oCaster))
                nDC -= 1;
        break;

        case SPELL_SCHOOL_EVOCATION:
            if(GetHasFeat(FEAT_EPIC_SPELL_FOCUS_EVOCATION, oCaster))
                nDC -= 3;
            else if(GetHasFeat(FEAT_GREATER_SPELL_FOCUS_EVOCATION, oCaster))
                nDC -= 2;
            else if(GetHasFeat(FEAT_SPELL_FOCUS_EVOCATION, oCaster))
                nDC -= 1;
        break;

        case SPELL_SCHOOL_ILLUSION:
            if(GetHasFeat(FEAT_EPIC_SPELL_FOCUS_ILLUSION, oCaster))
                nDC -= 3;
            else if(GetHasFeat(FEAT_GREATER_SPELL_FOCUS_ILLUSION, oCaster))
                nDC -= 2;
            else if(GetHasFeat(FEAT_SPELL_FOCUS_ILLUSION, oCaster))
                nDC -= 1;
        break;

        case SPELL_SCHOOL_NECROMANCY:
            if(GetHasFeat(FEAT_EPIC_SPELL_FOCUS_NECROMANCY, oCaster))
                nDC -= 3;
            else if(GetHasFeat(FEAT_GREATER_SPELL_FOCUS_NECROMANCY, oCaster))
                nDC -= 2;
            else if(GetHasFeat(FEAT_SPELL_FOCUS_NECROMANCY, oCaster))
                nDC -= 1;
        break;

        case SPELL_SCHOOL_TRANSMUTATION:
            if(GetHasFeat(FEAT_EPIC_SPELL_FOCUS_TRANSMUTATION, oCaster))
                nDC -= 3;
            else if(GetHasFeat(FEAT_GREATER_SPELL_FOCUS_TRANSMUTATION, oCaster))
                nDC -= 2;
            else if(GetHasFeat(FEAT_SPELL_FOCUS_TRANSMUTATION, oCaster))
                nDC -= 1;
        break;
    }

    return nDC;
}

// Do a Fortitude Save check for the given DC
// - oCreature
// - nDC: Difficulty check
// - nSaveType: SAVING_THROW_TYPE_*
// - oSaveVersus
// Returns: 3 if the saving throw critical failed.
// Returns: 0 if the saving throw roll failed
// Returns: 1 if the saving throw roll succeeded
// Returns: 2 if the target was immune to the save type specified
// Note: If used within an Area of Effect Object Script (On Enter, OnExit, OnHeartbeat), you MUST pass
// GetAreaOfEffectCreator() into oSaveVersus!!
int FortitudeSave(object oCreature, int nDC, int nSaveType=SAVING_THROW_TYPE_NONE, object oSaveVersus=OBJECT_SELF){
    int nSave = Std_FortitudeSave(oCreature, nDC, nSaveType, oSaveVersus);

    return nSave;
}

// Does a Reflex Save check for the given DC
// - oCreature
// - nDC: Difficulty check
// - nSaveType: SAVING_THROW_TYPE_*
// - oSaveVersus
// Returns: 3 if the saving throw critical failed.
// Returns: 0 if the saving throw roll failed
// Returns: 1 if the saving throw roll succeeded
// Returns: 2 if the target was immune to the save type specified
// Note: If used within an Area of Effect Object Script (On Enter, OnExit, OnHeartbeat), you MUST pass
// GetAreaOfEffectCreator() into oSaveVersus!!
int ReflexSave(object oCreature, int nDC, int nSaveType=SAVING_THROW_TYPE_NONE, object oSaveVersus=OBJECT_SELF){
    int nSave = Std_ReflexSave(oCreature, nDC, nSaveType, oSaveVersus);

    return nSave;
}

// Does a Will Save check for the given DC
// - oCreature
// - nDC: Difficulty check
// - nSaveType: SAVING_THROW_TYPE_*
// - oSaveVersus
// Returns: 3 if the saving throw critical failed.
// Returns: 0 if the saving throw roll failed
// Returns: 1 if the saving throw roll succeeded
// Returns: 2 if the target was immune to the save type specified
// Note: If used within an Area of Effect Object Script (On Enter, OnExit, OnHeartbeat), you MUST pass
// GetAreaOfEffectCreator() into oSaveVersus!!
int WillSave(object oCreature, int nDC, int nSaveType=SAVING_THROW_TYPE_NONE, object oSaveVersus=OBJECT_SELF){
    int nSave = Std_WillSave(oCreature, nDC, nSaveType, oSaveVersus);

    return nSave;
}

string GetFeatName(int nFeat){
    int nName = Get2DAInt("feat", "FEAT", nFeat);
    return GetStringByStrRef(nName);
}

string GetAbilityName(int nAbility){
    switch(nAbility){
        case ABILITY_CHARISMA:      return "Charisma";
        case ABILITY_CONSTITUTION:  return "Constitution";
        case ABILITY_DEXTERITY:     return "Dexterity";
        case ABILITY_INTELLIGENCE:  return "Intelligence";
        case ABILITY_STRENGTH:      return "Strength";
        case ABILITY_WISDOM:        return "Wisdom";
    }

    return "";
}

int GetBaseACValue(object oItem){
    return Get2DAInt("parts_chest", "ACBONUS", GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL, ITEM_APPR_ARMOR_MODEL_TORSO));
}

void RemoveEffect(object oCreature, effect eEffect){
    int nID = GetEffectSpellId(eEffect);

    if(nID < 1000 || nID > 1500) Std_RemoveEffect(oCreature, eEffect);
}

void RemoveItemProperty(object oItem, itemproperty ipProperty){
    int nID = GetItemPropertySpellId(ipProperty);

    if(nID < 1000 || nID > 1500) Std_RemoveItemProperty(oItem, ipProperty);
}

void trace(string sString){
    //SendMessageToPC(GetFirstPC(), sString);
}

int GetItemACBase(object oItem){
    if (!GetIsObjectValid(oItem))
        return 0;

    switch (GetBaseItemType(oItem)) {
        case BASE_ITEM_SMALLSHIELD: return 1;
        case BASE_ITEM_LARGESHIELD: return 2;
        case BASE_ITEM_TOWERSHIELD: return 4;
        case BASE_ITEM_ARMOR: break;
        default: return 0;
    }

    int bID = GetIdentified(oItem);

    SetIdentified(oItem, FALSE);

    int nBaseAC = 0;

    switch (GetGoldPieceValue(oItem)) {
        case 5:    nBaseAC = 1; break;  // Padded
        case 10:   nBaseAC = 2; break;  // Leather
        case 15:   nBaseAC = 3; break;  // Studded Leather / Hide
        case 100:  nBaseAC = 4; break;  // Chain Shirt / Scale Mail
        case 150:  nBaseAC = 5; break;  // Chainmail / Breastplate
        case 200:  nBaseAC = 6; break;  // Splint Mail / Banded Mail
        case 600:  nBaseAC = 7; break;  // Half Plate
        case 1500: nBaseAC = 8; break;  // Full Plate
    }

    SetIdentified(oItem, bID);

    return nBaseAC;
}

object GetPCByName(string sName, string sAccount){
    object oIter = GetFirstPC();

    while(GetIsObjectValid(oIter)){
        // If we've matched the account either they're playing the character or
        // not.
        if(GetPCPlayerName(oIter) == sAccount){
            if(GetName(oIter) == sName){
                return oIter;
            } else {
                return OBJECT_INVALID;
            }
        }

        oIter = GetNextPC();
    }

    return OBJECT_INVALID;
}

void JumpPartyToLocation(object oMember, location lLoc, float fRadius = 30.0) {
    object oParty = GetFirstFactionMember(oMember);

    while(GetIsObjectValid(oParty)){
        if(GetArea(oParty) == GetArea(oMember) && GetDistanceBetween(oParty, oMember) < fRadius) {
            AssignCommand(oParty, ClearAllActions(TRUE));
            AssignCommand(oParty, JumpToLocation(lLoc));
        }

        oParty = GetNextFactionMember(oMember);
    }
}

int TouchAttackRanged(object oTarget, int bDisplayFeedback=TRUE)
{
    object oToucher=OBJECT_SELF;
    int iDefense=GetACByType(oTarget,AC_TOUCH_BASE);
    int iRoll=d20();
    int iBonus=GetBaseAttackBonus(oToucher)+GetAbilityModifier(ABILITY_DEXTERITY,oToucher);
    //Heirophant judgment bonuses
    if(GetHasFeat(1575,oToucher)&&GetItemInSlot(INVENTORY_SLOT_RIGHTHAND)==OBJECT_INVALID&&GetItemInSlot(INVENTORY_SLOT_LEFTHAND)==OBJECT_INVALID)
    iBonus=iBonus+20;
    else if(GetHasFeat(1554,oToucher)&&GetItemInSlot(INVENTORY_SLOT_RIGHTHAND)==OBJECT_INVALID&&GetItemInSlot(INVENTORY_SLOT_LEFTHAND)==OBJECT_INVALID)
    iBonus=iBonus+8;
    if(GetHasFeat(1548,oToucher))
    iBonus=iBonus+1;
    int iSum;
    if(bDisplayFeedback)
    iSum=iRoll+iBonus;

    if(iRoll==20||(iRoll==19&&GetHasFeat(1547,oToucher)))
    {
        SendMessageToPC(oToucher,"Ranged Touch Attack: "+IntToString(iRoll)+" + "+IntToString(iBonus)+" = "+IntToString(iSum)+" Critical Threat!");
        iRoll=d20();
        //Power Critical feats
        if(GetHasFeat(1545,oToucher))
        iBonus=iBonus+2;
        if(GetHasFeat(1546,oToucher))
        iBonus=iBonus+2;

        if(iRoll+iBonus>=iDefense)
        {
            SendMessageToPC(oToucher,"Ranged Touch Attack: "+IntToString(iRoll)+" + "+IntToString(iBonus)+" = "+IntToString(iSum)+" confirmed critical!");
            SendMessageToPC(oTarget,"Ranged Touch Attack: "+IntToString(iRoll)+" + "+IntToString(iBonus)+" = "+IntToString(iSum)+" confirmed critical!");
            return 2;
        }
        else
        {
            SendMessageToPC(oToucher,"Ranged Touch Attack: "+IntToString(iRoll)+" + "+IntToString(iBonus)+" = "+IntToString(iSum)+" unconfirmed critical!");
            SendMessageToPC(oTarget,"Ranged Touch Attack: "+IntToString(iRoll)+" + "+IntToString(iBonus)+" = "+IntToString(iSum)+" hit!");
            return 1;
        }
    }

    if(iSum>=iDefense)
    {
        SendMessageToPC(oToucher,"Ranged Touch Attack: "+IntToString(iRoll)+" + "+IntToString(iBonus)+" = "+IntToString(iSum)+" hit!");
        SendMessageToPC(oTarget,"Ranged Touch Attack: "+IntToString(iRoll)+" + "+IntToString(iBonus)+" = "+IntToString(iSum)+" hit!");
        return 1;
    }
    SendMessageToPC(oToucher,"Ranged Touch Attack: "+IntToString(iRoll)+" + "+IntToString(iBonus)+" = "+IntToString(iSum)+" miss!");
    SendMessageToPC(oTarget,"Ranged Touch Attack: "+IntToString(iRoll)+" + "+IntToString(iBonus)+" = "+IntToString(iSum)+" miss!");
    return 0;
}

int TouchAttackMelee(object oTarget, int bDisplayFeedback=TRUE)
{
    object oToucher=OBJECT_SELF;
    int iDefense=GetACByType(oTarget,AC_TOUCH_BASE);
    int iRoll=d20();
    int iBonus=GetBaseAttackBonus(oToucher)+GetAbilityModifier(ABILITY_STRENGTH,oToucher);
    //Heirophant judgment bonuses
    if(GetHasFeat(1575,oToucher)&&GetItemInSlot(INVENTORY_SLOT_RIGHTHAND)==OBJECT_INVALID&&GetItemInSlot(INVENTORY_SLOT_LEFTHAND)==OBJECT_INVALID)
    iBonus=iBonus+20;
    else if(GetHasFeat(1554,oToucher)&&GetItemInSlot(INVENTORY_SLOT_RIGHTHAND)==OBJECT_INVALID&&GetItemInSlot(INVENTORY_SLOT_LEFTHAND)==OBJECT_INVALID)
    iBonus=iBonus+8;
    if(GetHasFeat(1548,oToucher))
    iBonus=iBonus+1;
    int iSum;
    if(bDisplayFeedback)
    iSum=iRoll+iBonus;

    if(iRoll==20||(iRoll==19&&GetHasFeat(1547,oToucher)))
    {
        SendMessageToPC(oToucher,"Melee Touch Attack: "+IntToString(iRoll)+" + "+IntToString(iBonus)+" = "+IntToString(iSum)+" Critical Threat!");
        iRoll=d20();
        //Power Critical feats
        if(GetHasFeat(1545,oToucher))
        iBonus=iBonus+GetWeaponOption(NWNX_WEAPONS_OPT_OVERCRIT_CONF_BONUS);
        if(GetHasFeat(1546,oToucher))
        iBonus=iBonus+GetWeaponOption(NWNX_WEAPONS_OPT_POWCRIT_CONF_BONUS);

        if(iRoll+iBonus>=iDefense)
        {
            SendMessageToPC(oToucher,"Melee Touch Attack: "+IntToString(iRoll)+" + "+IntToString(iBonus)+" = "+IntToString(iSum)+" confirmed critical!");
            SendMessageToPC(oTarget,"Melee Touch Attack: "+IntToString(iRoll)+" + "+IntToString(iBonus)+" = "+IntToString(iSum)+" confirmed critical!");
            return 2;
        }
        else
        {
            SendMessageToPC(oToucher,"Melee Touch Attack: "+IntToString(iRoll)+" + "+IntToString(iBonus)+" = "+IntToString(iSum)+" unconfirmed critical!");
            SendMessageToPC(oTarget,"Melee Touch Attack: "+IntToString(iRoll)+" + "+IntToString(iBonus)+" = "+IntToString(iSum)+" hit!");
            return 1;
        }
    }

    if(iSum>=iDefense)
    {
        SendMessageToPC(oToucher,"Melee Touch Attack: "+IntToString(iRoll)+" + "+IntToString(iBonus)+" = "+IntToString(iSum)+" hit!");
        SendMessageToPC(oTarget,"Melee Touch Attack: "+IntToString(iRoll)+" + "+IntToString(iBonus)+" = "+IntToString(iSum)+" hit!");
        return 1;
    }
    SendMessageToPC(oToucher,"Melee Touch Attack: "+IntToString(iRoll)+" + "+IntToString(iBonus)+" = "+IntToString(iSum)+" miss!");
    SendMessageToPC(oTarget,"Melee Touch Attack: "+IntToString(iRoll)+" + "+IntToString(iBonus)+" = "+IntToString(iSum)+" miss!");
    return 0;
}
