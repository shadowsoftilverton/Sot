#include "engine"

#include "uw_inc"

void main()
{
    object oPC       = GetPCSpeaker();
    location lTarget = GetUtilityLocation(oPC);

    if(!GetIsDM(oPC)){
        SendUtilityErrorMessageToPC(oPC, UW_MSG_DM_EXCLUSIVE);

        return;
    }

    CreateDynamicTransition(oPC, lTarget);
}

