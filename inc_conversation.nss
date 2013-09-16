#include "engine"

#include "uw_inc"

//::////////////////////////////////////////////////////////////////////////:://
//:: CONSTANTS                                                              :://
//::////////////////////////////////////////////////////////////////////////:://

const string FEEDBACK_INVALID_INPUT    = "Invalid Input!";
const string FEEDBACK_EXPECTED_INTEGER = "Integer value expected.";

const string INPUT_INVALID = "__INVALID INPUT__";

const int INPUT_TYPE_INVALID = -1;
const int INPUT_TYPE_ANY     = 0;
const int INPUT_TYPE_STRING  = 1;
const int INPUT_TYPE_INT     = 2;

//::////////////////////////////////////////////////////////////////////////:://
//:: DECLARATION                                                            :://
//::////////////////////////////////////////////////////////////////////////:://

// Resets variables relating to conversation input.
void ResetConversationInput(object oPC);

// Sets listening for oPC. If nType (INPUT_TYPE_*) is specified, a certain type
// of data will be listened for.
void ListenForInput(object oPC, int bListen, int nType=INPUT_TYPE_ANY);

// Gets the last input oPC made.
string GetConversationInput(object oPC);

// Returns if the last input oPC made is valid.
int GetIsConversationInputValid(object oPC);

// Helper function.
void DoConversationActionGoto(string sNumber);

//::////////////////////////////////////////////////////////////////////////:://
//:: IMPLEMENTATION                                                         :://
//::////////////////////////////////////////////////////////////////////////:://

void ResetConversationInput(object oPC){
    DeleteLocalInt(oPC, "CON_INPUT_LISTENER");
    DeleteLocalInt(oPC, "CON_INPUT_TYPE");
    DeleteLocalInt(oPC, "CON_INPUT");
}

void ListenForInput(object oPC, int bListen, int nType=INPUT_TYPE_ANY){
    SetLocalInt(oPC, "CON_INPUT_LISTENER", bListen);
    SetLocalInt(oPC, "CON_INPUT_TYPE", nType);
}

string GetConversationInput(object oPC){
    return GetLocalString(oPC, "CON_INPUT");
}

int GetIsConversationInputValid(object oPC){
    return GetLocalString(oPC, "CON_INPUT") != INPUT_INVALID;
}

int GetConversationInputType(object oPC){
    return GetLocalInt(oPC, "CON_INPUT_TYPE");
}

void SetConversationInput(object oPC, string sInput){
    if(GetConversationInputType(oPC) == INPUT_TYPE_INT){
        int nTest = StringToInt(sInput);

        if(nTest == 0 && sInput != "0"){
            SetLocalString(oPC, "CON_INPUT", INPUT_INVALID);

            ErrorMessage(oPC, "Invalid Input!");

            return;
        }
    }

    SetLocalString(oPC, "CON_INPUT", sInput);
    SetPCChatMessage();

    SendMessageToPC(oPC, "Input: " + ColorString(sInput, 55, 255, 55));
}

void DoConversationActionGoto(string sNumber){
    object oPC = GetPCSpeaker();
    object oSelf = OBJECT_SELF;
    object oDestination = GetWaypointByTag(GetLocalString(oSelf, "con_goto_wp_" + sNumber));

    int nCost = GetLocalInt(oSelf, "con_goto_cost_" + sNumber);

    TakeGoldFromCreature(nCost, oPC, TRUE);

    AssignCommand(oPC, JumpToObject(oDestination));
}

int DoConversationConditionalGoto(string sNumber){
    object oPC = GetPCSpeaker();
    object oSelf = OBJECT_SELF;

    int nCost = GetLocalInt(oSelf, "con_goto_cost_" + sNumber);

    return GetGold(oPC) > nCost;
}
