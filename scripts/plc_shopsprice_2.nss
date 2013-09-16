//To be fired on the conversation node of plc_shpprice that asks the price of an item to be set.

#include "inc_conversation"
#include "engine"
#include "aps_include"
#include "inc_nametag"

int GetStringIsIntegerNumber(string sString);

object CycleItems(object oItem, object oStore, string sItem);

void main()
{
    object oOwner = GetPCSpeaker();
    string sInput = GetConversationInput(oOwner);
    string sOwner = GenerateTagFromName(oOwner);
    object oStore = GetObjectByTag("store_" + sOwner);
    object oClerk = GetObjectByTag("clerk_" + sOwner);
    //string sItem = GetLocalString(oOwner, "LastItemAdded");
    object oItem = GetLocalObject(oOwner, "LastItemAdded");
    string sAccount = GetPCPlayerName(oOwner);

    //object oItem = CycleItems(oItem, oStore, sItem);

    int nPrice = StringToInt(sInput);
    string sName = GetName(oItem, TRUE);

    if(GetStringIsIntegerNumber(sInput) == TRUE)
    {
        //If the spoken text is an integer, store the value and the original name in the database and change its name
        //to the price value so shoppers can view it.
        SetPersistentInt_player(sOwner, sAccount, "Price" + sName, nPrice, 0, SQL_TABLE_OBJECTS);
        SetPersistentString_player(sOwner, sAccount, "Name" + sName, sName, 0, SQL_TABLE_OBJECTS);
        SetName(oItem, sInput);
        SetLocalInt(oItem, "Price", StringToInt(sInput));
    }
}


int GetStringIsIntegerNumber(string sString)
{
    int nString=StringToInt(sString);

//any value other than 0 means the string is just an integer number
    if (nString!=0) return TRUE;

//Check if the string representation of nString is the same as sString.
//If it is, this will have happened:
//"0" converted to 0, converted back to "0"
//An example of 0 produced by an error:
//"bob" converted to 0, converted to "0". "bob" != "0"
    string sCompare=IntToString(nString);

    return sCompare == sString;
}

object CycleItems(object oItem, object oStore, string sItem)
{
    while(GetIsObjectValid(oItem))
    {
        if(GetName(oItem) != sItem)
        {
            oItem = GetNextItemInInventory(oStore);
        }
    }

    return oItem;
}
