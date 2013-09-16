// =============================================================================
// Economy Rebalance Function
// Invictus - 10-22-11
// =============================================================================

#include "aps_include"
#include "nw_i0_plot"

void DoEconomyRebalance(object oPC) {
    int nGold = GetGold(oPC);

    if(!GetPersistentInt(oPC, "ECON_BAL")) {
        TakeGoldFromCreature(9 * (nGold / 10), oPC, TRUE);
        SendMessageToPC(oPC, "Server: gold in-inventory scaled for game economy.");
        SetPersistentInt(oPC, "ECON_BAL", 1);
    }
}

void DoHorseReplacement(object oPC)
{
    object oCycle = GetFirstItemInInventory(oPC);
    string sResRef;

    while(GetIsObjectValid(oCycle))
    {
        sResRef = GetResRef(oCycle);

         if(sResRef == "hrs_wgt_brn" ||
            sResRef == "hrs_wgt_sbrn" ||
            sResRef == "hrs_wgt_jst01" ||
            sResRef == "hrs_wgt_jst02" ||
            sResRef == "hrs_wgt_jst03" ||
            sResRef == "hrs_wgt_jst04" ||
            sResRef == "hrs_wgt_jst05" ||
            sResRef == "hrs_wgt_war01" ||
            sResRef == "hrs_wgt_war02" ||
            sResRef == "hrs_wgt_war03" ||
            sResRef == "hrs_wgt_war04" ||
            sResRef == "hrs_wgt_war05" ||
            sResRef == "hrs_wgt_war06")
        {
            DestroyObject(oCycle);
            GiveGoldToCreature(oPC, 1500);
            SendMessageToPC(oPC, "This horse widget is no longer supported and new horse widgets are now in place. You have received 1500 gold in exchange.");
        }

        oCycle = GetNextItemInInventory(oPC);
    }
}

void main() {
    object oPC = GetEnteringObject();

    DoHorseReplacement(oPC);

    //if(GetIsPC(oPC)) DoEconomyRebalance(oPC);
}
