//Written by Ave (2012/04/13)
#include "engine"
#include "ave_d_inc"

void main()
{
    object oTarget=GetLocalObject(OBJECT_SELF,"ave_o_dest");
    object oOrb=GetObjectByTag("ave_plc_orb");
    if(GetIsObjectValid(oTarget)&&GetIsObjectValid(oOrb))
    AssignCommand(OBJECT_SELF,ActionMoveToObject(oTarget));
    else SpiritChooseCorpse(OBJECT_SELF,GetLocation(OBJECT_SELF));
}
