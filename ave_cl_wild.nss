//Toggles caster level calculations to WILD (+1d10 or -1d10)

#include "engine"
#include "ave_cl_inc"

void main()
{
    object oDM=GetPCSpeaker();
    object oTarget=GetUtilityTarget(oDM);
    DoToggleWildMode(oDM,oTarget);
}
