#include "engine"
#include "ave_d2_inc"

void main()
{
    object oLever=OBJECT_SELF;
    //if(oLever==GetLastUsedBy()) return;
    AssignCommand(oLever, ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    AssignCommand(oLever, ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
    DoGeneralDoorToggle("ave_d2_greendoor");
}
