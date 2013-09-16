//Boosts the caster level of a fixed-level character by 10

#include "engine"
#include "ave_cl_inc"

void main()
{
    object oDM=GetPCSpeaker();
    object oTarget=GetUtilityTarget(oDM);
    DoBoost(10,oDM,oTarget);
}
