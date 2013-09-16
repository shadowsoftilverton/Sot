#include "engine"

#include "nwnx_events"

void main()
{
    FloatingTextStringOnCreature("You must roleplay pickpocketing.", OBJECT_SELF, FALSE);
    BypassEvent();
}
