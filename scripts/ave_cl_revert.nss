//reverts caster level calculations to default

#include "engine"
#include "ave_cl_inc"

void main()
{
    object oDM=GetPCSpeaker();
    object oTarget=GetUtilityTarget(oDM);
    DoCLRevert(oDM,oTarget);
}
