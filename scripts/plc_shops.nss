//Shop system by Hardcore UFO.
//In the OnDisturbed event of the shop placeables.

#include "engine"
#include "inc_nametag"
#include "aps_include"
#include "nw_i0_plot"

int GetNumberOfItems(object oInventory);

void main()
{
    //The placeable's tag, on creation, should be set to store_(creator's name).
    /*string sOwner = GetLocalString(OBJECT_SELF, "StoreOwner");
    object oOwner = GetFirstPC();
    string sNameTag = GenerateTagFromName(oOwner);
    while(sNameTag != sOwner)
    {
        oOwner = GetNextPC();
        sNameTag = GenerateTagFromName(oOwner);
    } */
    object oOwner = GetLocalObject(OBJECT_SELF, "StoreOwner");
    string sOwner = GenerateTagFromName(oOwner);

    string sName = GetName(oOwner, TRUE);

    //The script will create a Shopkeep NPC whom, on creation, should be given a tag equal to clerk_(creator's name).
    //This is only used for classier shop placeables that can go unmanned.
    object oClerk = GetObjectByTag("clerk_" + sOwner);
    object oUser = GetLastDisturbed();
    int nAction = GetInventoryDisturbType();
    object oItem = GetInventoryDisturbItem();
    string sItem = GetName(oItem, TRUE);
    string sItemTag = GenerateTagFromName(oItem);
    string sAccount = GetPCPlayerName(oOwner);
    int nCountRetrieve;
    string sRetrieve;

    //Database related variables.
    /*int nPurchasePrice = GetPersistentInt_player(sName, sAccount, "Price" + sItem, SQL_TABLE_OBJECTS);
    string sPurchaseName = GetPersistentString_player(sName, sAccount, "Name" + sItem, SQL_TABLE_OBJECTS);  */
    int nProfit = GetPersistentInt_player(sName, sAccount, "Profit", SQL_TABLE_OBJECTS);

    //If the one using the shop is the owner, let them take items back and set prices for items being added.
    if(oUser == oOwner)
    {
        int nCount = GetLocalInt(oOwner, "ShopItemCount");
        int nLimit;

        if(nAction == INVENTORY_DISTURB_TYPE_ADDED)
        {
            if(GetNumberOfItems(OBJECT_SELF) <= 20)      //////////////////////////////////////////////////
            {

            //If there is a clerk, he will do the talking to set prices. Otherwise items are simply added to
            //the inventory of the placeable and made undroppable.
            if(oClerk == OBJECT_INVALID)
            {
                SetPersistentObject_player(sName, sAccount, "ShopItem_" + IntToString(nCount), oItem, 0, SQL_TABLE_OBJECTS);
                SetPersistentInt_player(sName, sAccount, sItemTag, nCount, 0, SQL_TABLE_OBJECTS);
                //SetLocalString(oOwner, "LastItemAdded", sItem);
                SetLocalObject(oOwner, "LastItemAdded", oItem);
                SetLocalString(oItem, "Owner", sOwner);
                SetDroppableFlag(oItem, FALSE);
                nCount ++;
                SetLocalInt(oOwner, "ShopItemCount", nCount);
            }

            else
            {
                SetPersistentObject_player(sName, sAccount, "ShopItem_" + IntToString(nCount), oItem, 0, SQL_TABLE_OBJECTS);
                SetPersistentInt_player(sName, sAccount, sItemTag, nCount, 0, SQL_TABLE_OBJECTS);
                //SetLocalString(oOwner, "LastItemAdded", sItem);
                SetLocalObject(oOwner, "LastItemAdded", oItem);
                SetLocalString(oItem, "Owner", sOwner);
                SetDroppableFlag(oItem, FALSE);
                nCount ++;
                SetLocalInt(oOwner, "ShopItemCount", nCount);
                AssignCommand(oClerk, ActionStartConversation(oOwner, "plc_shpprice", TRUE, FALSE));
            }
            }
        }

        else if(nAction == INVENTORY_DISTURB_TYPE_REMOVED)
        {
            nCountRetrieve = GetPersistentInt_player(sName, sAccount, sItemTag, SQL_TABLE_OBJECTS);
            sRetrieve = "ShopItem_" + IntToString(nCountRetrieve);

            SetDroppableFlag(oItem, TRUE);
            DeleteLocalInt(oItem, "StorePrice");
            ActionGiveItem(oItem, oOwner);
            DeletePersistentVariable_player(sName, sAccount, sItemTag, SQL_TABLE_OBJECTS);
            DeletePersistentVariable_player(sName, sAccount, sRetrieve, SQL_TABLE_OBJECTS);
        }
    }

    //If the one using the shop is not the owner, they cannot place in new items and items they take out are
    //charged to them mased on the variables established when the owner placed them in.
    else if(oUser != oOwner)
    {
        if(nAction == INVENTORY_DISTURB_TYPE_ADDED)
        {
            ActionGiveItem(oItem, oUser);
            SendMessageToPC(oUser, "This is not your stall!");
        }

        else if(nAction == INVENTORY_DISTURB_TYPE_REMOVED)
        {
            if(oClerk == OBJECT_INVALID)
            {
                SendMessageToPC(oUser, "Purchases must be made through the stall owner.");
            }

            else
            {
                int nPrice = GetLocalInt(oItem, "Price");
                int nGold = GetGold(oUser);

                if(nPrice <= nGold)
                {
                    TakeGoldFromCreature(nPrice, oUser, TRUE);
                    SetDroppableFlag(oItem, TRUE);
                    ActionGiveItem(oItem, oUser);
                    nProfit = nProfit + nPrice;
                    SetLocalInt(OBJECT_SELF, "Profit", nProfit);
                    AssignCommand(oClerk, ActionSpeakString("Thank you for your purchase!", TALKVOLUME_TALK));

                    nCountRetrieve = GetPersistentInt_player(sName, sAccount, sItemTag, SQL_TABLE_OBJECTS);
                    sRetrieve = "ShopItem_" + IntToString(nCountRetrieve);

                    SetPersistentInt_player(sName, sAccount, "Profit", nProfit, 0, SQL_TABLE_OBJECTS);
                    DeletePersistentVariable_player(sName, sAccount, sItemTag, SQL_TABLE_OBJECTS);
                    DeletePersistentVariable_player(sName, sAccount, sRetrieve, SQL_TABLE_OBJECTS);
                }
            }
        }
    }
}

int GetNumberOfItems(object oInventory)
{
    int nNumber = 0;
    object oCycle = GetFirstItemInInventory(oInventory);

    while(GetIsObjectValid(oCycle))
    {
        nNumber ++;
        oCycle = GetNextItemInInventory(oInventory);
    }

    return nNumber;
}
