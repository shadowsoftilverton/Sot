//Created by 420 for the CEP
//Set cloak number manually
//Based on script tlr_setitem.nss by Jake E. Fitch

//Get Spoken Body Part for CEP

#include "inc_conversation"

void main()
{
object oPC = GetPCSpeaker();
int iNewApp = StringToInt(GetConversationInput(oPC));

if (iNewApp < 1) iNewApp = 1;
if (iNewApp > 255) iNewApp = 255;

object oItem = GetItemInSlot(INVENTORY_SLOT_CLOAK);

object oNewItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0, iNewApp, TRUE);

DestroyObject(oItem);
SendMessageToPC(oPC, "New Appearance: " + IntToString(iNewApp) +" "+ Get2DAString("cloakmodel", "LABEL", iNewApp));

AssignCommand(OBJECT_SELF, ActionEquipItem(oNewItem, INVENTORY_SLOT_CLOAK));

ResetConversationInput(oPC);
}
