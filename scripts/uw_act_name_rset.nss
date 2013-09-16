#include "engine"

#include "uw_inc"
#include "inc_conversation"

void main()
{
    object oPC      = GetPCSpeaker();
    object oTarget  = GetUtilityTarget(oPC);

    SetName(oTarget);
}
