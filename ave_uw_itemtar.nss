#include "engine"
#include "uw_inc"

int StartingConditional()
{
    object oTarget=GetUtilityTarget(GetPCSpeaker());
    if(GetObjectType(oTarget)==OBJECT_TYPE_ITEM) return TRUE;
    return FALSE;
}
