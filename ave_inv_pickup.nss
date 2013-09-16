#include "engine"
//This is broken and not used.
void main()
{
    object oPC=GetPCSpeaker();
    SendMessageToPC(oPC,"Debug: ave_inv_pickup fired");
    ExecuteScript("ave_inv_act_get",oPC);//To make oPC into OBJECT_SELF
}
