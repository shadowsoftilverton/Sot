#include "engine"

#include "inc_death"

const int BODY_ARRAY_INDEX = 2;

int StartingConditional()
{
    object oPC = GetPCSpeaker();

    object oItem = GetFirstItemInInventory(oPC);

    int nIndex = -1;

    while(GetIsObjectValid(oItem)){
        if(GetTag(oItem) == "itm_pc_body") nIndex++;

        if(nIndex == BODY_ARRAY_INDEX){
            SetCustomToken(8533, GetLocalString(oItem, BODY_VAR_NAME) + ".");

            return TRUE;
        }

        oItem = GetNextItemInInventory(oPC);
    }

    return FALSE;
}
