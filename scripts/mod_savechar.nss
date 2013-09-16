#include "engine"

#include "nwnx_events"
#include "inc_save"

void main()
{
    object oPC = GetEventTarget();
    SaveCharacter(oPC);
}
