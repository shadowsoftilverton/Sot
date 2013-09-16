#include "engine"
#include "ave_inc_tables"
#include "inc_ilr"
#include "x3_inc_string"
#include "uw_inc"

void main()
{
    object oItem=GetUtilityTarget(GetPCSpeaker());
    int iTier=GetTierOfItem(oItem);
    string sColor=TierToColor(iTier);
    string sName = GetName(oItem);
    sName=StringToRGBString(sName,sColor);
    SetName(oItem,sName);
}
