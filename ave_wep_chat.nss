#include "ave_wep_inc"

void main()
{
    WepChat(OBJECT_SELF,OBJECT_INVALID,GetLocalObject(OBJECT_SELF,"ave_wep_my"),-1,GetPCChatMessage(),1);
}
