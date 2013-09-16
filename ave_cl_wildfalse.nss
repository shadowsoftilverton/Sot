//returns true if the character is NOT in wild mode

#include "engine"
#include "ave_cl_inc"

int StartingConditional()
{
    object oDM=GetPCSpeaker();
    object oTarget=GetUtilityTarget(oDM);
    int IsWild=bGetIsWildMagic(oTarget);
    if(IsWild==1) return TRUE;
    return FALSE;
}
