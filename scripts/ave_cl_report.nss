//Reports the current caster level of a character in fixed-mode to the DM that used the utility wand

#include "engine"
#include "ave_cl_inc"

void main()
{
    object oDM=GetPCSpeaker();
    object oTarget=GetUtilityTarget(oDM);
    DoCasterLevelReport(oDM,oTarget);
}
