#include "engine"

#include "nwnx_funcs"

#include "inc_conversation"

void main()
{
    object oPC = GetPCSpeaker();

    int nInput = StringToInt(GetConversationInput(oPC));

    SetSoundset(oPC, nInput);

    ResetConversationInput(oPC);
}
