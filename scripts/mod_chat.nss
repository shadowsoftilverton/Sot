#include "engine"

#include "inc_conversation"
#include "inc_language"
#include "inc_strings"
#include "inc_xp"

#include "ave_wep_inc"
#include "uw_inc_vcmd"

void main()
{
    // We grab our speaker and our message.
    object oPC = GetPCChatSpeaker();
    string sMsg = GetPCChatMessage();
    int nVolume = GetPCChatVolume();

    if(nVolume != TALKVOLUME_SILENT_SHOUT && GetSubString(sMsg, 0, 1) != "/") SetIsIdle(oPC, FALSE);
    //SendMessageToPC(oPC,"Debug: Your message is "+GetSubString(sMsg,0,4));
    if(GetSubString(sMsg,0,4)=="/wep")
    {
        //SendMessageToPC(oPC,"Debug: entered conditional");
        WepChat(oPC,OBJECT_INVALID,GetLocalObject(oPC,"ave_wep_my"),1,sMsg,1);
        SetPCChatMessage();
        return;
    }
    // Look to see if were actively listening for input.
    if(GetLocalInt(oPC, "CON_INPUT_LISTENER")){
        SetConversationInput(oPC, sMsg);

        return;
    }

    if(ParseUtilityWandVoiceCommands(oPC, sMsg)) return;

    ProcessLanguageChat(oPC, sMsg, nVolume);
}
