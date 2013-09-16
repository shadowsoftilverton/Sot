#include "engine"

#include "nwnx_events"
#include "inc_conversation"
#include "uw_inc"

void main()
{
    object oPC      = GetPCSpeaker();
    object oTarget  = GetUtilityTarget(oPC);
    int nType   = GetObjectType(oTarget);

    string sInput = GetConversationInput(oPC);

    int i = 0;

    AddLine(oTarget, sInput);
}
