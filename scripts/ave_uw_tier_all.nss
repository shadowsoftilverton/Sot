#include "engine"
#include "uw_inc"
#include "inc_ilr"
#include "x3_inc_string"

void main()
{
    int iTier;
    string sColor;
    string sName;
    object oItem=GetFirstItemInInventory(GetPCSpeaker());
    while(GetIsObjectValid(oItem))
    {
        iTier=GetTierOfItem(oItem);
        sColor=TierToColor(iTier);
        sName = GetName(oItem);
        sName=StringToRGBString(sName,sColor);
        SetName(oItem,sName);
        oItem=GetNextItemInInventory(GetPCSpeaker());
    }
}
