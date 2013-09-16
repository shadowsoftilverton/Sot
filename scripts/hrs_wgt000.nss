#include "engine"

void main()
{
    object oPC = GetItemActivator();

    FloatingTextStringOnCreature("This horse has died.", oPC);
}
