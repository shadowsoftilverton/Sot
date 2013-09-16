#include "engine"
#include "uw_inc"
#include "ave_inv_inc"

void main()
{
    object oPC=GetPCSpeaker();
    object oTarget=GetUtilityTarget(oPC);
    if(GetObjectType(oTarget)==OBJECT_TYPE_ITEM)//Item target
    {
        if(GetIsContainer(oTarget))//Check if it is actually a container!
        {
    //        InitializeSort(oTarget,oPC);
        }
    }
    else if(oTarget==oPC)//Self target
    {
    //    InitializeSort(oTarget,oPC);
    }
    //else
    //if(oTarget==OBJECT_INVALID)//Ground target
    //{
        ExecuteScript("ave_inv_drop",oPC);
    //}
    //else SendMessageToPC(oPC,"Not a valid sort target! Must target the ground.");
}
