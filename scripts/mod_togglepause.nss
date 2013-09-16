#include "engine"

#include "nwnx_events"

void main()
{

    object oDM = OBJECT_SELF;
    object oMod = GetModule();

    FloatingTextStringOnCreature("Module pause is disabled.", oDM, FALSE);
    DelayCommand(0.5, FloatingTextStringOnCreature("Use area pause commands.", oDM, FALSE));

    BypassEvent();
}
