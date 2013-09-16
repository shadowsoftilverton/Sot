#include "x2_inc_switches"
#include "inc_nametag"
#include "engine"
#include "aps_include"
#include "nw_i0_plot"

void PlayerShopAction(object oPC, object oTarget, location lTarget, string sShopName, string sShopTag, string sShopResref, int nType);

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    if(nEvent != X2_ITEM_EVENT_ACTIVATE) return;
    object oPC = GetItemActivator();

    object oTarget = GetItemActivatedTarget();
    object oWidget = GetItemActivated();
    string sWidget = GetResRef(oWidget);
    location lTarget = GetItemActivatedTargetLocation();
    string sResRef = GetResRef(GetItemActivated());
    int nType = StringToInt(GetStringRight(sResRef, 1));

    string sPC = GetName(oPC, TRUE);
    string sTag = GenerateTagFromName(oPC);
    string sNewTag = "store_" + sTag;

    int nActive = GetLocalInt(oPC, "ShopActive");

    PlayerShopAction(oPC, oTarget, lTarget, "Store", sNewTag, "shop_plc", nType);
}

void PlayerShopAction(object oPC, object oTarget, location lTarget, string sShopName, string sShopTag, string sShopResref, int nType) {
    location lPC = GetLocation(oPC);
    string sNameTag = GenerateTagFromName(oPC);
    string sStoreTag = "store_" + sNameTag;
    string sResRef = GetResRef(GetItemActivated());
    string sAccount = GetPCPlayerName(oPC);

    //If targeted on an active shop owned by the player, destroy it after returning contained items.
    if(GetIsObjectValid(oTarget))
    {
        if(GetTag(oTarget) == sStoreTag)
        {
            object oReturn = GetFirstItemInInventory(oTarget);

            while(GetIsObjectValid(oReturn))
            {
                ActionGiveItem(oReturn, oPC);
                oReturn = GetNextItemInInventory(oTarget);
            }

            DestroyObject(oTarget);
            DestroyObject(GetObjectByTag("clerk" + sNameTag));
            DeleteLocalInt(oPC, "ShopActive");
        }
    }

    else
    {
        if(GetLocalInt(oPC, "ShopActive") != 1 && GetLocalInt(oPC, "ShopAllowedArea") == 1)
        {
            //location lShop = GetItemActivatedTargetLocation();
            object oShop = CreateObject(OBJECT_TYPE_PLACEABLE, sShopResref, lTarget, FALSE, sStoreTag);
            int nCount = 0;
            object oItems;

            //If it's a "fancy" shop whose ResRef ends in 2, add the clerk.
            //if(GetStringRight(sResRef, 1) == "2")
            if(nType == 2)
            {
                object oClerk = CreateObject(OBJECT_TYPE_CREATURE, "shop_npc", lTarget, FALSE, "clerk_" + sNameTag);;
                SetLocalObject(oClerk, "ClerkOwner", oPC);
            }

            SetName(oShop, GetName(oPC) + "'s " + sShopName);
            //SetLocalString(oShop, "StoreOwner", sNameTag);
            SetLocalObject(oShop, "StoreOwner", oPC);
            SetLocalInt(oPC, "ShopActive", 1);

            while(nCount <= 19)
            {
                oItems = GetPersistentObject_player(GetName(oPC), sAccount, "ShopItem_" + IntToString(nCount), OBJECT_INVALID, SQL_TABLE_OBJECTS);
                CopyItem(oItems, GetItemActivated());
                DeletePersistentVariable_player(GetName(oPC), sAccount, "ShopItem_" + IntToString(nCount), SQL_TABLE_OBJECTS);
                nCount ++;
            }
        }
    }
}
