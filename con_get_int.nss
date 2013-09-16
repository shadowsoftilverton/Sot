#include "engine"

#include "inc_conversation"

void main()
{
    object oPC = GetPCSpeaker();

    ListenForInput(oPC, TRUE, INPUT_TYPE_INT);
}
