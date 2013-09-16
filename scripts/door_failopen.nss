#include "engine"

void main()
{
    object oDoor = OBJECT_SELF;
    object oPC = GetLastUsedBy();

    // If we're not dealing with a PC, we're wasting our time.
    if(!GetIsPC(oPC)){
        return;
    }

    string sFeedback = GetLocalString(oDoor, "door_failopen_feedback");
    int iPublic = GetLocalInt(oDoor, "door_failopen_feedback_public");

    if(iPublic){
        SpeakString(sFeedback);
    } else {
        SendMessageToPC(oPC, sFeedback);
    }
}
