#include "engine"

#include "inc_iss"
#include "inc_strings"

// Sends a message to the major members of the development staff. Add people to
// the roster as necessary.
void SendMessageToDevelopers(string sMessage);

// Kind of a hidden vanity function but whatever. Less bitching from DMs amirite?
void SendMessageToDevelopers(string sMessage){
    object oPC = GetFirstPC();

    while(GetIsObjectValid(oPC)){
        string sName = GetPCPlayerName(oPC);

        if(sName == "Foxtrot" ||
           sName == "Invictus"){
            if(GetIsISSVerified(oPC)){
                SendMessageToPC(oPC, ColorString(sMessage, 255, 140, 0));
            }
        }

        oPC = GetNextPC();
    }
}
