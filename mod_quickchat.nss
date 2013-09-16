#include "engine"

#include "nwnx_events"

void main()
{
    object oPC = OBJECT_SELF;

    if(GetLocalInt(oPC, "QUICKCHAT_DISABLED")){
        FloatingTextStringOnCreature("You cannot use quick chat so frequently.",
                                     oPC, FALSE);
        BypassEvent();
        return;
    }

    SetLocalInt(oPC, "QUICKCHAT_DISABLED", TRUE);

    DelayCommand(3.0, DeleteLocalInt(oPC, "QUICKCHAT_DISABLED"));
}
