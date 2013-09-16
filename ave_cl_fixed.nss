//Sets caster level to fixed. Default fixed caster level is 10

#include "engine"
#include "ave_cl_inc"

void main()
{
    object oDM=GetPCSpeaker();
    object oTarget=GetUtilityTarget(oDM);
    FixCL(oDM,oTarget);
}
