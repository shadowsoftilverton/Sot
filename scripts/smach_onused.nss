/*
Monster Slots
By Ray Miller
kaynekayne@bigfoot.com
*/
#include "smach_configure"
void main()
{
object oPC = GetLastUsedBy();
if(IsInConversation(OBJECT_SELF))
    {
    SendMessageToPC(oPC, "That machine is being played right now.");
    return;
    }
if(!GetLocalInt(OBJECT_SELF, "bConfigured"))
    {
    SetLocalInt(OBJECT_SELF, "bConfigured", TRUE);
    ConfigureSlotMachine();
    }
SetLocalInt(OBJECT_SELF, "bGameComplete", TRUE);
ActionStartConversation(GetLastUsedBy(), "", TRUE);
}
