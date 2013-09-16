//returns true if the current utility wand target is set to fixed-caster level mode

#include "engine"
#include "ave_cl_inc"

int StartingConditional()
{
    object oDM=GetPCSpeaker();
    object oTarget=GetUtilityTarget(oDM);
    int iResult=bGetIsFixedCL(oTarget);
    return iResult;
}
