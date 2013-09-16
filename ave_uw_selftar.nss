#include "engine"
#include "uw_inc"

int StartingConditional()
{
    object oTarget=GetUtilityTarget(GetPCSpeaker());
    if(oTarget==GetPCSpeaker()) return TRUE;
    return FALSE;
}
