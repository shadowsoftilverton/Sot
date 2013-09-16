#include "engine"
//This is broken and not used.
void main()
{
    object oPC=OBJECT_SELF;
    SendMessageToPC(oPC,"Debug: ave_inv_act_get fired");
    object iPick=GetFirstObjectInShape(SHAPE_SPHERE,10.0,GetLocation(oPC),OBJECT_TYPE_ALL);
    if(GetIsObjectValid(iPick))
    {
        SendMessageToPC(oPC,"Debug: iPick is Valid");
    }
    float fDelay=0.0;
    while(GetIsObjectValid(iPick))
    {
        if(GetObjectType(iPick)==OBJECT_TYPE_ITEM)
        {
            SendMessageToPC(oPC,"Debug: iPick is an item!");
            DelayCommand(fDelay,AssignCommand(oPC,ActionPickUpItem(iPick)));
            fDelay=fDelay+6.0;
        }
        iPick=GetNextObjectInShape(SHAPE_SPHERE,10.0,GetLocation(oPC),OBJECT_TYPE_ALL);
    }
}
