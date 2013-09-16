//Summon Themes
//By Hardcore UFO
//This script will check numerical suffix on the ResRef of an item with a Unique Power property.
//The Summon Theme will be set to the value of the suffix for the user.

#include "x2_inc_switches"

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();

    if(nEvent != X2_ITEM_EVENT_ACTIVATE) return;

    object oUser = GetItemActivator();
    object oItem = GetItemActivated();
    string sResRef = GetResRef(oItem);
    string sZero = GetSubString(sResRef, 9, 1);
    string sTheme;

    if(sZero == "0")
    {
        sTheme = GetSubString(sResRef, 10, 1);
    }

    else
    {
        sTheme = GetSubString(sResRef, 9, 2);
    }

    int nTheme = StringToInt(sTheme);

    if(GetLocalInt(oUser, "SummonTheme") != nTheme)
    {
        SetLocalInt(oUser, "SummonTheme", nTheme);
    }

    else if(GetLocalInt(oUser, "SummonTheme") == nTheme)
    {
        DeleteLocalInt(oUser, "SummonTheme");
    }
}
