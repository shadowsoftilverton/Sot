#include "engine"
#include "inc_henchmen"
#include "inc_equipment"
#include "inc_save"
#include "nwnx_reset"
#include "nwnx_chat"
#include "inc_multiserver"
#include "inc_crossserver"

void main()
{
    object oPC = GetExitingObject();
    NWNXChat_PCExit(oPC);
    RemoveFromLoggedInDatabase(oPC);
    SaveCharacter(oPC);

    SavePersistentHitPoints(oPC);

    object oItem;

    int i;

    for(i = 0; i <= 13; i++){
        oItem = GetItemInSlot(i, oPC);

        DoUnequipAdjustments(oPC, oItem);
    }

    //Removing custom summons.
    int nSummon = 1;
    object oSummon = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, nSummon);
    effect eUnsummon = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_2, FALSE);
    location lSummon;

    while(GetIsSummon(oSummon) == TRUE)
    {
        lSummon = GetLocation(oSummon);
        DestroyHenchman(oPC, oSummon);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eUnsummon, lSummon);

        nSummon ++;
        oSummon = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, nSummon);
    }

    // Check to see if we are the dungeon instance and whether anyone is logged in
    // If not, reset server
    if((GetLocalInt(GetModule(), "SYS_INSTANCE_TYPE") == INSTANCE_TYPE_DUNGEON) && !GetIsObjectValid(GetFirstPC())) RestartServer();
}
