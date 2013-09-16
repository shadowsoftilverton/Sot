//OnUsed script of the shop clerk used for PC shops. It determines if the conversation
//starter is its creator/owner or not and fires the appropriate dialog.

#include "inc_nametag"
#include "engine"

void main()
{
    /*string sTag = GetTag(OBJECT_SELF);
    int nTag = GetStringLength(sTag);
    int nOwner = nTag - 7;
    //string sOwner = GetSubString(sTag, 6, nOwner);
    string sOwner = GetStringRight(sTag, nOwner);
    */

    object oSpeaker = GetPCSpeaker();
    //string sSpeaker = GenerateTagFromName(oSpeaker);


    //if(sSpeaker == sOwner)
    if(oSpeaker == GetLocalObject(OBJECT_SELF, "ClerkOwner"))
    {
        ActionStartConversation(oSpeaker, "shop_owner", TRUE, FALSE);
    }

    else
    {
        ActionStartConversation(oSpeaker, "shop_cstmr", FALSE, TRUE);
    }
}
