//To be fired on the conversation node of plc_shpprice where the NPC should start listening for
//a price input.

#include "inc_conversation"
#include "engine"

void main()
{
    object oPC = GetPCSpeaker();
    ListenForInput(oPC, TRUE, INPUT_TYPE_ANY);
}
