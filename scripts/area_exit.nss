#include "engine"

//::///////////////////////////////////////////////
//:: AREA_EXIT.NSS
//:: Silver Marches Script
//:://////////////////////////////////////////////
/*
    Generic area exit code.
*/
//:://////////////////////////////////////////////
//:: Created By: Ashton Shapcott
//:: Created On: Oct. 20, 2010
//:://////////////////////////////////////////////

#include "inc_areas"
#include "inc_encounter"

#include "inc_logs"
#include "inc_ovl_spawn"
#include "inc_debug"

void DoDespawn(object oArea){
    if(GetPCCountInArea(oArea) < 1){
        object oTemp = GetFirstObjectInArea(oArea);

        WriteLog("Clearing area <" + GetName(oArea) + "> of spawns.", LOG_TYPE_AREA, "ENCOUNTERS");

        while(GetIsObjectValid(oTemp)){
            if(GetTag(oTemp) == SPAWN_TAG) DestroyObject(oTemp);

            oTemp = GetNextObjectInArea(oArea);
        }
    }
}

void CheckForDespawn(object oPC, object oArea){
    int nPCCount = GetPCCountInArea(oArea);
    int nSpawnCount = GetSpawnCountInArea(oArea);

    if(nPCCount < 1 && nSpawnCount > 0){
        DelayCommand(300.0, DoDespawn(oArea));
    }
}

int GetIsPlayerLoggedIn(object oPlayer) {
    return GetPCPlayerName(oPlayer) != "";
}

void DoCheckPlayerDestination(object oArea, object oPC) {
    // The player is no longer logged in. We've sprung a leak, matey!
    if(!GetIsPlayerLoggedIn(oPC)){
        SendMessageToDevelopers("Player has logged off.");

        return;
    } else if(!GetIsObjectValid(GetArea(oPC))){
        DelayCommand(6.0, DoCheckPlayerDestination(oArea, oPC));

        SendMessageToDevelopers("Player has not arrived at their destination yet. Checking again.");
    } else {
        string sInstance = GetInstanceArray(oArea);

        int nCount = GetPCCountInInstance(sInstance);

        SendMessageToDevelopers("Assessing instance <" + sInstance + "> for deletion.");
        SendMessageToDevelopers("Found <" + IntToString(nCount) + "> players in instance.");

        if(nCount == 0){
            SendMessageToDevelopers("Deleting instance.");

            DestroyDungeonInstance(sInstance);
        }
    }
}

void main() {
    // Declare variables.
    object oPC = GetExitingObject();
    object oArea = OBJECT_SELF;

    int bIsDungeonInstance = GetIsDungeonInstance(oArea);
    int bIsDMInstance = GetLocalInt(oArea, AREA_LV_IS_INSTANCED);
    int bMarkedForDeletion = GetLocalInt(oArea, AREA_LV_MARK_DELETION);

    effect eCycle;
    if(GetLocalInt(oArea, "FluidDynamic") > 0)
    {
        eCycle = GetFirstEffect(oPC);
        while(GetIsEffectValid(eCycle))
        {
            if(GetEffectCreator(eCycle) == oArea)
            {
                RemoveEffect(oPC, eCycle);
            }

            eCycle = GetNextEffect(oPC);
        }
    }

    if(bIsDungeonInstance) {
        SendMessageToDevelopers("<" + GetName(oPC) + "> has left an instance area.");

        // Brute force time. We check that the PC is logged in (hasn't crashed in
        // their transition) and whether or not they're in a valid area. If they've
        // logged out we do nothing, because for all we know they were remaining
        // within the instance. If they're within a valid area we can then check
        // the instance's player count and destroy it if necessary.
        //
        // Right now this can leak because if a PC crashes while they're trying to
        // leave the instance and they're the last individual in the instance the
        // instance will never collapse, but for now this is the best I've come up
        // with. Furthermore, crashes aren't so common that this should cripple the
        // server, but it can be revised later by someone with a clearer head if
        // need be.
        if(GetIsPC(oPC)) DelayCommand(6.0, DoCheckPlayerDestination(oArea, oPC));
    } else {

        if(bIsDMInstance && bMarkedForDeletion && GetPCCountInArea(oArea, TRUE) < 1){
            DelayCommand(0.0, DestroyArea(oArea));
        }

        DelayCommand(6.0, CheckForDespawn(oPC, oArea));

        /*
        // Removes arcane spell failure.
        effect eEffect = GetFirstEffect(oPC);
        while(GetIsEffectValid(eEffect)){
            // Remove any arcane spell failure effects we find.
            if(GetEffectType(eEffect) == EFFECT_TYPE_SPELL_FAILURE){
                RemoveEffect(oPC, eEffect);
            }

            // Continue to look through the list of effects.
            eEffect = GetNextEffect(oPC);
        }*/

        DoDespawnOverlandEncounters(oPC, oArea);
    }
}
