#include "engine"

#include "x2_inc_switches"

#include "aps_include"

#include "inc_strings"

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();

    if(nEvent == X2_ITEM_EVENT_ACTIVATE) {
        object oDM = GetItemActivator();
        object oTarget = GetItemActivatedTarget();

        if(!GetIsDM(oDM)){
            ErrorMessage(oDM, "This tool is only useable by Dungeon Masters.");

            return;
        }

        string sCD = GetPCPublicCDKey(oTarget);
        string sIP = GetPCIPAddress(oTarget);

        SetPersistentInt(GetModule(), sCD + "_BANNED", TRUE, 0, SQL_TABLE_ACCOUNTS);
        SetPersistentInt(GetModule(), sIP + "_BANNED", TRUE, 0, SQL_TABLE_ACCOUNTS);

        FloatingTextStringOnCreature("Banned: " + sCD + " " + sIP, oDM, FALSE);

        BootPC(oTarget);
    }
}
