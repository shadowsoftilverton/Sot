//returns true if the character is in wild mode

#include "engine"
#include "ave_cl_inc"

int StartingConditional()
{
    object oDM=GetPCSpeaker();
    object oTarget=GetUtilityTarget(oDM);
    int IsWild=bGetIsWildMagic(oTarget);
    if(IsWild==0) return TRUE;
    return FALSE;
}
