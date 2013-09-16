#include "engine"

#include "inc_debug"

//::////////////////////////////////////////////////////////////////////////:://
//:: UW_INC.NSS                                                             :://
//:: Silver Marches Script                                                  :://
//::////////////////////////////////////////////////////////////////////////:://
/*
    The basic include file for the Utility Wand.
*/
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By: Ashton Shapcott                                            :://
//:: Created On: Sept. 2, 2009                                              :://
//::////////////////////////////////////////////////////////////////////////:://
//:: Modified By: Ashton Shapcott                                           :://
//:: Modified On: Sept. 23, 2009                                            :://
//:: * Added function implementations.                                      :://
//::                                                                        :://
//:: Modified By: Ashton Shapcott                                           :://
//:: Modified On: Sept. 30, 2009                                            :://
//:: * Fixed some badly done code.                                          :://
//::                                                                        :://
//:: Modified By: Ashton Shapcott                                           :://
//:: Modified On: Nov. 12, 2010                                             :://
//:: * Added some wrappers (GetUtilityTarget, SetPuppet, GetPuppet).        :://
//::                                                                        :://
//:: Modified By: Ashton Shapcott                                           :://
//:: Modified On: Nov. 30, 2010                                             :://
//:: * Major documentation update.                                          :://
//:: * Functions streamlined.                                               :://
//:: * Major restructuring of Utility Wand resulted in several new funcs.   :://
//:: * ReturnActiveSpeaker renamed to GetUtilityActor and updated.          :://
//:: * ReportRoll renamed to UtilityRoll and had other significant changes. :://
//:: * There are no deprecated versions left; all UW code needs updates.    :://
//::////////////////////////////////////////////////////////////////////////:://

#include "aps_include"
#include "inc_strings"
#include "ave_inc_combat"
#include "inc_henchmen"

//::////////////////////////////////////////////////////////////////////////:://
//:: CONSTANTS                                                              :://
//::////////////////////////////////////////////////////////////////////////:://


//:: MISCELLANEOUS

const string UW_TOKEN           = "UW_";

//:: WAND MENUS
const string UW_MENU            = "uw_menu";
const string MW_MENU            = "mw_menu";


const float UW_ANIMATION_DURATION = 2419200.0;


//:: UW_FEEDBACK_*

const string UW_MSG_INVALID_INPUT      = "Invalid Input!";
const string UW_MSG_INVALID_TARGET     = "Invalid Target!";
const string UW_MSG_INVALID_COMMAND    = "Invalid Command!";
const string UW_MSG_INVALID_LANGUAGE   = "Invalid Language!";
const string UW_MSG_INVALID_PUPPET     = "You cannot use that as a puppet!";
const string UW_MSG_DM_EXCLUSIVE       = "That command is for DMs only!";

//:: UW_ROLL_TYPE_*

const int UW_ROLL_TYPE_INVALID      = -1;
const int UW_ROLL_TYPE_DICE         = 0;
const int UW_ROLL_TYPE_SKILL        = 1;
const int UW_ROLL_TYPE_SAVE         = 2;
const int UW_ROLL_TYPE_ABILITY      = 3;
const int UW_ROLL_TYPE_ATTACK       = 4;

//:: UW_CONTEXT_*
/*
const int UW_CONTEXT_INVALID  = -1;
const int UW_CONTEXT_BASE     = 0;
const int UW_CONTEXT_BODY     = 1;
const int UW_CONTEXT_BODY_ARM = 1001;
const int UW_CONTEXT_BODY_LEG = 1002;
const int UW_CONTEXT_WING     = 2;
const int UW_CONTEXT_TAIL     = 3;
const int UW_CONTEXT_COLOR    = 4;
const int UW_CONTEXT_         = 5; */

//::////////////////////////////////////////////////////////////////////////:://
//:: DECLARATION                                                            :://
//::////////////////////////////////////////////////////////////////////////:://

//:: GENERAL

object GetUtilityActor(object oPC);

// Performs nEmote (ANIMATION_*) on oPC.
void UtilityEmote(object oPC, int nEmote);

// Reports a roll for oPC based off of nType (UW_ROLL_TYPE_*) and nSubType. The
// respective nSubType constants are as follows:
// - UW_ROLL_TYPE_DICE: Number of sides
// - UW_ROLL_TYPE_SKILL: SKILL_*
// - UW_ROLL_TYPE_SAVE: SAVING_THROW_*
// - UW_ROLL_TYPE_ABILITY: ABILITY_*
void UtilityRoll(object oPC, int nType, int nSubType);

// Reports oItem's ILR to oReceiver. If oReceiver is unspecified, the item's
// possessor is informed instead.
void ReportILR(object oItem, object oReceiver=OBJECT_INVALID);

// Reports oTarget's experience to oReceiver. If oReceiver is unspecified,
// oTarget receives the information.
void ReportExperience(object oTarget, object oReceiver=OBJECT_INVALID);

// Cleans up local variables used for the Utility Wand on oPC.
void UtilityCleanUp(object oPC);

// Sends a properly formatted Utility Wand error message to oPC.
void SendUtilityErrorMessageToPC(object oPC, string sMessage);

//:: PUPPETEERING

// Sets oController to have puppet control of oPuppet.
void SetPuppet(object oController, object oPuppet);

// Returns oController's puppet.
// * Returns OBJECT_INVALID if oController has no puppet.
object GetPuppet(object oController);

// Removes oController's puppet.
void RemovePuppet(object oController);

// Returns TRUE if oController is currently controlling a puppet.
int GetIsPuppeteering(object oController);

//:: UW TARGET

// Sets oPC's Utility Wand target.
void SetUtilityTarget(object oPC, object oTarget);

// Returns oPC's Utility Wand target.
object GetUtilityTarget(object oPC);

//:: UW LOCATION

// Sets oPC's Utility Wand target location.
void SetUtilityLocation(object oPC, location lLoc);

// Returns the last location oPC's Utility Wand targeted.
location GetUtilityLocation(object oPC);

void CheckLap(object oLap);

int GetIsOwner(object oOwner, object oTarget);

// If oPC is currently in-game, they are sent to the AFK room. If oPC is AFK,
// they are sent in-game.
void DoAFK(object oPC);

// Creates a dynamic transition placeable at lLoc and, if necessary, pairs it
// with its twin.
void CreateDynamicTransition(object oDM, location lLoc);

// Returns a unique tag for the next dynamic transition.
string GetNextDynamicTransitionTag(object oDM);

//Unsummons henchmen.
void UnsummonAll(object oPC);

//Makes henchmen enter stealth.
void HenchmanEnterStealth(object oPC);

//Makes oHenchman move to lMoveTo as long as the former is the current UW object
//and the latter is the current UW location.
void HenchmanMoveToPoint(object oHenchman, location lMoveTo);

//::////////////////////////////////////////////////////////////////////////:://
//:: IMPLEMENTATION                                                         :://
//::////////////////////////////////////////////////////////////////////////:://

void CreateDynamicTransition(object oDM, location lLoc){
    string sTag = GetNextDynamicTransitionTag(oDM);

    object oTrans = CreateObject(OBJECT_TYPE_PLACEABLE, "fox_trans_dyn", lLoc, FALSE, sTag);

    SendMessageToDevelopers("Created transition with tag: " + GetTag(oTrans));

    string sPrevious = GetLocalString(oDM, "dm_trans_dyn_prev");

    // If we don't have a previous string, we need to set one.
    if(sPrevious == ""){
        SetLocalString(oDM, "dm_trans_dyn_prev", sTag);
    }
    // If we do have a previous tag, we need to connect the two.
    else {
        SendMessageToDevelopers("Connecting transitions.");

        SendMessageToDevelopers("Previous Tag: " + sPrevious);

        // Connect our new to the previous.
        SetLocalString(oTrans, "transition_tag", sPrevious);

        // Get the previous object.
        object oPrev = GetObjectByTag(sPrevious);

        // Connect the previous to the new.
        SetLocalString(oPrev, "transition_tag", sTag);

        SendMessageToDevelopers("Current Tag: " + sTag);

        // Delete the string to prevent unwanted linking.
        DeleteLocalString(oDM, "dm_trans_dyn_prev");
    }
}

string GetNextDynamicTransitionTag(object oDM){
    object oModule = GetModule();

    string sAccount = GetPCPlayerName(oDM);

    int i = GetLocalInt(oModule, sAccount + "_dm_trans_dyn_iter");

    SetLocalInt(oModule, sAccount + "_dm_trans_dyn_iter", i + 1);

    return sAccount + "_trans_dyn_" + IntToString(i);
}

object GetUtilityActor(object oPC){
    if(IsInConversation(oPC)) return GetUtilityTarget(oPC);

    if(GetIsPuppeteering(oPC)){
        object oPuppet = GetPuppet(oPC);
        if(!GetIsObjectValid(oPuppet)) RemovePuppet(oPC);
        return oPuppet;
    }

    return oPC;
}

void UtilityRoll(object oPC, int nType, int nSubType){
    string sType;

    int nRoll = d20();
    int nRank = -1;

    int bComplex;

    switch(nType){
        case UW_ROLL_TYPE_DICE:
            bComplex = FALSE;

            if(nSubType < 1) return;

            switch(nSubType){
                case   2: nRoll = d2();     break;
                case   3: nRoll = d3();     break;
                case   4: nRoll = d4();     break;
                case   6: nRoll = d6();     break;
                case   8: nRoll = d8();     break;
                case  10: nRoll = d10();    break;
                case  12: nRoll = d12();    break;
                case  20: nRoll = d20();    break;
                case 100: nRoll = d100();   break;

                // The number of sides can be anything. If it's not standard, go
                // ahead and generate randomly.
                default: nRoll = Random(nSubType) + 1;  break;
            }

            sType = "d" + IntToString(nSubType);
        break;

        case UW_ROLL_TYPE_SKILL:
            bComplex = TRUE;
            nRank = GetSkillRank(nSubType, oPC);
            sType = GetSkillName(nSubType);
        break;

        case UW_ROLL_TYPE_SAVE:
            bComplex = TRUE;
            switch (nSubType){
                case SAVING_THROW_FORT:
                    nRank = GetFortitudeSavingThrow(oPC);
                    sType = "Fortitude";
                break;
                case SAVING_THROW_REFLEX:
                    nRank = GetReflexSavingThrow(oPC);
                    sType = "Reflex";
                break;
                case SAVING_THROW_WILL:
                    nRank = GetWillSavingThrow(oPC);
                    sType = "Will";
                break;
            }
        break;

        case UW_ROLL_TYPE_ABILITY:
            bComplex = TRUE;
            nRank = GetAbilityModifier(nSubType, oPC);
            sType = GetAbilityName(nSubType);
        break;

        case UW_ROLL_TYPE_ATTACK:
            bComplex=TRUE;
            nRank=GetSpeakerAB();
            sType="Attack Roll";
        break;
    }

    if(!bComplex){
        string sResult = "<c2Í2>" + IntToString(nRoll) + "</c>";
        // If we're doing a basic dice roll (d4, d10, etc.), we don't need to
        // worry about our iRoll, as our iRank is the value of the dice roll.
        AssignCommand(oPC, SpeakString("[ " + GetName(oPC) + " rolls 1" +
            sType + ": " + sResult + " ]"));
    } else {
        // If we're dealing with a genuine check, however, we factor in iRoll
        // to act as our actual d20 dice roll, and iRank acts as the rank we
        // have in the skill, save, or ability modifier.
        string sRank = "<c2Í2>" + IntToString(nRank) + "</c>";
        string sRoll = "<c2Í2>" + IntToString(nRoll) + "</c>";
        string sResult = "<c2Í2>" + IntToString(nRank + nRoll) + "</c>";
        AssignCommand(oPC, SpeakString("[ " + GetName(oPC) + " rolls " +
            sType + ": " + sRoll + " + " + sRank + " = " + sResult + " ]"));
    }
}

void SetPuppet(object oController, object oPuppet){
    if(!GetIsObjectValid(oPuppet)){
        FloatingTextStringOnCreature("Not a valid puppet target.", oController, FALSE);
        return;
    }

    if(oController == oPuppet){
        RemovePuppet(oController);
        return;
    }

    SetLocalObject(oController, UW_TOKEN + "PUPPET", oPuppet);
    SetLocalInt(oController, UW_TOKEN + "PUPPETEERING", TRUE);
    SetLocalInt(oController, UW_TOKEN + "LISTEN", TRUE);

    string sName = ColorString(GetName(oPuppet), 55, 255, 55);

    FloatingTextStringOnCreature("Puppeteering: " + sName, oController, FALSE);
}

object GetPuppet(object oController){
    return GetLocalObject(oController, UW_TOKEN + "PUPPET");
}

void RemovePuppet(object oController){
    DeleteLocalObject(oController, UW_TOKEN + "PUPPET");
    DeleteLocalInt(oController, UW_TOKEN + "PUPPETEERING");
    DeleteLocalInt(oController, UW_TOKEN + "LISTEN");

    FloatingTextStringOnCreature("Your puppet has been removed.", oController, FALSE);
}

int GetIsPuppeteering(object oController){
    return GetLocalInt(oController, UW_TOKEN + "PUPPETEERING");
}

object GetUtilityTarget(object oPC){
    return GetLocalObject(oPC, UW_TOKEN + "TARGET");
}

location GetUtilityLocation(object oPC){
    return GetLocalLocation(oPC, UW_TOKEN + "LOCATION");
}

void SetUtilityTarget(object oPC, object oTarget){
    if(GetIsDM(oPC)){
        string sTarget = ColorString(GetName(oTarget), 55, 255, 55);
        SendMessageToPC(oPC, "UW Target: " + sTarget);
    }
    SetLocalObject(oPC, UW_TOKEN + "TARGET", oTarget);
}

void SetUtilityLocation(object oPC, location lLoc){
    SetLocalLocation(oPC, UW_TOKEN + "LOCATION", lLoc);
}

void UtilityEmote(object oPC, int nEmote){
    oPC = GetUtilityActor(oPC);
    AssignCommand(oPC, PlayAnimation(nEmote, 1.0, UW_ANIMATION_DURATION));
}

void CheckLap(object oLap){
    if(!GetIsObjectValid(GetSittingCreature(oLap))) DestroyObject(oLap);
    else DelayCommand(600.0, CheckLap(oLap));
}

void SendUtilityErrorMessageToPC(object oPC, string sMessage){
    FloatingTextStringOnCreature(ColorString(sMessage, 255, 55, 55), oPC, FALSE);
}

int GetIsOwner(object oOwner, object oTarget){
    int nType = GetObjectType(oTarget);

    if(GetIsDM(oTarget) && oOwner != oTarget) return FALSE;
    if(GetIsDM(oOwner))                       return TRUE;
    if(nType == OBJECT_TYPE_CREATURE)         return GetMaster(oTarget) == oOwner || oTarget == oOwner;
    if(nType == OBJECT_TYPE_ITEM)             return GetItemPossessor(oTarget) == oOwner;

    return FALSE;
}

void DoAFK(object oPC){
    string sArea = GetTag(GetArea(oPC));

    string sUnique = GetName(oPC) + GetPCPlayerName(oPC) + "_AFK_RETURN";

    if(sArea == "ooc_afk"){
        object oWaypoint = GetWaypointByTag(sUnique);

        if(!GetIsObjectValid(oWaypoint)) oWaypoint = GetWaypointByTag("wp_arabel_nw_bind");

        location lReturn = GetLocation(oWaypoint);
        AssignCommand(oPC, JumpToLocation(lReturn));
    } else {
        CreateObject(OBJECT_TYPE_WAYPOINT, "NW_WAYPOINT001", GetLocation(oPC), FALSE, sUnique);

        AssignCommand(oPC, JumpToObject(GetObjectByTag("WP_AFK_ENTRY")));
    }
}

void ReportILR(object oItem, object oReceiver=OBJECT_INVALID){
}

void ReportExperience(object oTarget, object oReceiver=OBJECT_INVALID){
}

void AddLine(object oItem, string sLine){
    string sCurrent = GetDescription(oItem);

    SetDescription(oItem, sCurrent + " " + sLine);
}

void AddParagraph(object oItem, string sParagraph){
    string sCurrent = GetDescription(oItem);

    SetDescription(oItem, sCurrent + "\n\n" + sParagraph);
}


//::////////////////////////////////////////////////////////////////////////:://
//:: HENCHMAN FUNCTIONS                                                     :://
//::////////////////////////////////////////////////////////////////////////:://

void UnsummonAll(object oPC)
{
    int nSummon = 1;
    object oSummon = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, nSummon);
    effect eUnsummon = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_2, FALSE);
    location lSummon;

    while(GetIsSummon(oSummon) == TRUE)
    {
        lSummon = GetLocation(oSummon);
        DestroyHenchman(oPC, oSummon);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eUnsummon, lSummon);

        nSummon ++;
        oSummon = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, nSummon);
    }
}

void HenchmanEnterStealth(object oPC)
{
    int nSummon = 1;
    object oSummon = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, nSummon);

    while(GetIsSummon(oSummon) == TRUE && GetActionMode(oSummon, ACTION_MODE_STEALTH) == FALSE)
    {
        SetActionMode(oSummon, ACTION_MODE_STEALTH, TRUE);

        nSummon ++;
        oSummon = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, nSummon);
    }
}

void HenchmanMoveToPoint(object oHenchman, location lMoveTo)
{
    int nRun;
    if(GetActionMode(oHenchman, ACTION_MODE_STEALTH) == TRUE)   nRun = FALSE;
    else nRun = TRUE;

    AssignCommand(oHenchman, ActionMoveToLocation(lMoveTo, nRun));
}

