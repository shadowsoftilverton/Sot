#include "engine"

#include "inc_conversation"

void main(){
    object oPC = GetPCSpeaker();

    string sInput = GetConversationInput(oPC);

    SetPortraitResRef(oPC, sInput);

    ResetConversationInput(oPC);
}
