#include "engine"

#include "inc_debug"

//::///////////////////////////////////////////////
//:: INC_AREAS.nss
//:: Silver Marches Script
//:://////////////////////////////////////////////
/*
    Handles functions related to areas and triggers.
*/
//:://////////////////////////////////////////////
//:: Created By: Ashton Shapcott
//:: Created On: Oct. 31, 2010
//:://////////////////////////////////////////////
//:: Instancing Prototype: Ashton Shapcott
//:: Production Instancing: Stephen "Invictus"
//:://////////////////////////////////////////////

#include "nwnx_areas"

#include "inc_arrays"
#include "inc_encounter"
#include "inc_iss"
#include "inc_strings"
#include "inc_instances"
#include "inc_encounter"

#include "inst_inc_library"

const string AREA_PAUSED = "area_paused";

// Dev Access LVs begin.

const string INST_LV_AREA_TYPE = "nInstAreaType";
const string INST_LV_CREATURE_TYPE = "nInstCreatureType";

const string INST_LV_STD_AREA_ARRAY = "sInstStandardAreas";
const string INST_LV_CAP_AREA_ARRAY = "sInstCappedAreas";

const string INST_LV_CREATURE_ARRAY = "sInstCreatures";

const string INST_LV_EXIT_ARRAY = "sInstExits";

const string INST_LV_SIZE_MAX = "nInstSizeMax";
const string INST_LV_SIZE_MIN = "nInstSizeMin";

const string INST_LV_CR_MAX = "nInstMaxCR";
const string INST_LV_CR_MIN = "nInstMinCR";

const string INST_LV_INSTANCE_ARRAY = "nInstArray";

const string INST_LV_IS_DUNGEON_INSTANCE = "nIsDungeonInstance";

const string INST_LV_IS_RANDOMIZED = "nIsRandomizedInstance";

const string INST_LV_MAXLEVEL = "nInstMaxLevelForLoot";

// Dev Access LVs end.

const string LV_DOORWAY_IS_EXIT = "nDoorwayIsInstanceExit";

const string AREA_LV_IS_INSTANCED = "area_is_instanced";
const string AREA_LV_INSTANCED_BY = "area_instanced_by";
const string AREA_LV_MARK_DELETION = "area_mark_deletion";

const string AREA_LV_TRANS_POINTER = "area_lv_trans_pointer";

const string TAG_TRANS_ENTRANCE = "obj_trans_entrance";
const string TAG_TRANS_EXIT     = "obj_trans_exit";

const string TAG_TRANS_WP_ENTRANCE = "wp_trans_entrance";
const string TAG_TRANS_WP_EXIT = "wp_trans_exit";

const string LV_DOORWAY_WAYPOINT = "instance_door_waypoint";

const string LV_INSTANCE_NUMBER = "fox_instance_number";
const string LV_INSTANCE_COUNTER = "module_instance_counter";

const string LV_INSTANCE_LOOT_NULLIFIED = "area_loot_nullified";

const string TAG_CONTAINER_BASE = "obj_loot_container";

const string TAG_ENCOUNTER_TRIGGER_BASE = "obj_trg_encounter";

const string TAG_ENCOUNTER_BASE = "wp_encounter";

// Returns if oArea has been paused.
int GetIsAreaPaused(object oArea);

// Pauses or unpauses oArea.
void SetIsAreaPaused(object oArea, int nPause);

// Checks if the area is subject to global effects, such as weather.
int GetIsGlobalArea(object oArea);

// Checks to see if oArea is a natural exterior.
int GetIsAreaNaturalExterior(object oArea);

// Checks to see if oArea is a natural interior.
int GetIsAreaNaturalInterior(object oArea);

// Checks to see if oArea is a dungeon.
int GetIsAreaDungeon(object oArea);

// Returns the number of  PCs in oArea.
int GetPCCountInArea(object oArea, int bIncludeDMs=FALSE);

// Applies an area pause effect to oCreature.
void ApplyAreaPauseEffect(object oCreature);

// Removes an area pause effect from oCreature.
void RemoveAreaPauseEffect(object oCreature);

// Returns the number of encounter spawns in oArea.
int GetSpawnCountInArea(object oArea);

// Copies the given area.
void CreateDMAreaInstance(object oDM, object oArea, string sNewName="");

// Destroys the given instance, provided it is an instance.
void DestroyDMAreaInstance(object oDM, object oArea);

// Destroys all instances created by oDM.
void DestroyAllDMAreaInstances(object oDM);

// For use with instance entryway doors to retrieve their associated waypoint
object GetInstanceTransitionWaypoint(object oDoor);

// Algorithmically generates and instantiates a dungeon
void CreateRandomizedDungeonInstance(object oPC, object oDoor);

// Instantiates a statically-built dungeon
void CreateStaticDungeonInstance(object oPC, object oDoor);

// Creates a new instance linked to oDoor with nSize areas of nDungeonType with
// nCreatureType inside.
void CreateDungeonInstance(object oPC, object oDoor);

// Initializes the database associates with areas that can be instanced.
// Called in mod_load
void InitializeInstancing();

void PersistLootContainersInArea(object oArea); // Helper of InitializeInstancing()

// Gets the creatures associated with oArea. Can also be called on the instance
// entrance.
string GetAreaCreatureArray(object oArea);

// Sets the creatures associated with oArea.
void SetAreaCreatureArray(object oArea, string sArray);

// Returns the number of PCs in the areas indicated by the string-based array
// sInstance.
int GetPCCountInInstance(string sInstance);

// Gets the string array of all areas in oArea's instance. Returns an empty
// string if oArea isn't an instance.
string GetInstanceArray(object oArea);

// Sets the instance array for oArea with the string-based array sInstance.
void SetInstanceArray(object oArea, string sInstance);

// Returns the number of party members in oArea, or oMember's current area if
// the area isn't specified.
int GetNumberPartyMembersInArea(object oMember, object oArea=OBJECT_INVALID);

int GetIsDungeonInstance(object oArea);

void SetIsDungeonInstance(object oArea, int nIsInstance);

int GetIsRandomizedInstance(object oArea);

void SetIsRandomizedInstance(object oArea, int nIsRandomized);

int GetMaxLevelForLootToSpawn(object oArea);

void SetMaxLevelForLootToSpawn(object oArea, int nMaxLevelForLootToSpawn);

int GetIsAreaLootNullified(object oArea);

void SetIsAreaLootNullified(object oArea, int bIsAreaLootNullified);

void DoInstanceLootAdjustments(object oArea, object oCreature);

int GetIsDungeonInstance(object oArea){
    return GetLocalInt(oArea, INST_LV_IS_DUNGEON_INSTANCE);
}

void SetIsDungeonInstance(object oArea, int nIsInstance){
    SetLocalInt(oArea, INST_LV_IS_DUNGEON_INSTANCE, nIsInstance);
}

int GetIsRandomizedInstance(object oArea) {
    return GetLocalInt(oArea, INST_LV_IS_RANDOMIZED);
}

void SetIsRandomizedInstance(object oArea, int nIsRandomized) {
    SetLocalInt(oArea, INST_LV_IS_RANDOMIZED, nIsRandomized);
}

int GetMaxLevelForLootToSpawn(object oArea) {
    return GetLocalInt(oArea, INST_LV_MAXLEVEL);
}

void SetMaxLevelForLootToSpawn(object oArea, int nMaxLevelForLootToSpawn) {
    SetLocalInt(oArea, INST_LV_MAXLEVEL, nMaxLevelForLootToSpawn);
}

int GetIsAreaLootNullified(object oArea) {
    return GetLocalInt(oArea, LV_INSTANCE_LOOT_NULLIFIED);
}

void SetIsAreaLootNullified(object oArea, int bIsAreaLootNullified) {
    SetLocalInt(oArea, LV_INSTANCE_LOOT_NULLIFIED, bIsAreaLootNullified);
}

void DoInstanceLootAdjustments(object oArea, object oCreature) {
    if(GetIsPC(oCreature) && GetHitDice(oCreature) > GetMaxLevelForLootToSpawn(oArea)) {
        SetIsAreaLootNullified(oArea, TRUE);
    }
}

int GetNumberPartyMembersInArea(object oMember, object oArea=OBJECT_INVALID){
    int nCount = 0;

    if(!GetIsObjectValid(oArea)) GetArea(oMember);

    oMember = GetFirstFactionMember(oMember);

    while(GetIsObjectValid(oMember)){
        if(GetArea(oMember) == oArea) nCount++;

        oMember = GetNextFactionMember(oMember);
    }

    return nCount;
}

int GetNextInstanceNumber(){
    object oMod = GetModule();

    int nNext = GetLocalInt(oMod, LV_INSTANCE_COUNTER) + 1;

    SetLocalInt(oMod, LV_INSTANCE_COUNTER, nNext);

    return nNext;
}

void SetInstanceNumber(object oObj, int nNumber){
    SetLocalInt(oObj, LV_INSTANCE_NUMBER, nNumber);
}

int GetInstanceNumber(object oObj){
    return GetLocalInt(oObj, LV_INSTANCE_NUMBER);
}

object GetInstanceTransitionWaypoint(object oDoor){
    return GetObjectByTag(GetLocalString(oDoor, LV_DOORWAY_WAYPOINT));
}

string GetAreaCreatureArray(object oArea){
    return GetLocalString(oArea, INST_LV_CREATURE_ARRAY);
}

void SetAreaCreatureArray(object oArea, string sArray){
    SetLocalString(oArea, INST_LV_CREATURE_ARRAY, sArray);
}

string GetInstanceArray(object oArea){
    return GetLocalString(oArea, INST_LV_INSTANCE_ARRAY);
}

void SetInstanceArray(object oArea, string sInstance){
    SetLocalString(oArea, INST_LV_INSTANCE_ARRAY, sInstance);
}

void CreateRandomizedDungeonInstance(object oPC, object oDoor) {
    // Our throw-away integer.
    int i;

    int nInstanceSizeMax = GetLocalInt(oDoor, INST_LV_SIZE_MAX);
    int nInstanceSizeMin = GetLocalInt(oDoor, INST_LV_SIZE_MIN);
    int nSize = Random(nInstanceSizeMax + 1 - nInstanceSizeMin) + nInstanceSizeMin;

    int nAreaType = GetLocalInt(oDoor, INST_LV_AREA_TYPE);
    int nCreatureType = GetLocalInt(oDoor, INST_LV_CREATURE_TYPE);

    string sAreaStdArray = GetLocalString(oDoor, INST_LV_STD_AREA_ARRAY);
    string sAreaCapArray = GetLocalString(oDoor, INST_LV_CAP_AREA_ARRAY);
    string sCreatureArray = GetAreaCreatureArray(oDoor);
    string sExitArray = GetLocalString(oDoor, INST_LV_EXIT_ARRAY);
    object oExit = (sExitArray == "")? OBJECT_INVALID : GetObjectByTag(GetArrayElement(sExitArray, 0));

    int nMinCR = GetLocalInt(oDoor, INST_LV_CR_MIN);
    int nMaxCR = GetLocalInt(oDoor, INST_LV_CR_MAX);
    int nMaxLevelForLootToSpawn = GetLocalInt(oDoor, INST_LV_MAXLEVEL);

    // Our arrays for holding the resrefs we want to work with.
    string sStdAreas, sCapAreas, sTempStdAreas, sTempCapAreas;

    // The array that points to all the instance areas.
    string sInstanceArray = Array();

    sStdAreas = (sAreaStdArray != "")? sAreaStdArray : GetStandardAreaLibrary(nAreaType);
    sCapAreas = (sAreaCapArray != "")? sAreaCapArray : GetCappedAreaLibrary(nAreaType);
    if(sCreatureArray == "") sCreatureArray = GetCreatureLibrary(nCreatureType);

    sTempStdAreas = sStdAreas;
    sTempCapAreas = sCapAreas;

    object oPrevArea;
    for(i = 0; i < nSize; i++) {
        string sResRef;

        // Check that we haven't ran out of our library areas.
        if(GetArraySize(sTempStdAreas) < 1) sTempStdAreas = sStdAreas;
        if(GetArraySize(sTempCapAreas) < 1) sTempCapAreas = sCapAreas;

        // STANDARD AREAS
        if(i < nSize - 1) {
            int nRandom = Random(GetArraySize(sTempStdAreas));
            sResRef = GetArrayElement(sTempStdAreas, nRandom);
            sTempStdAreas = RemoveArrayElement(sTempStdAreas, nRandom); // Prevent duplicates
        }
        // CAP AREAS
        else {
            int nRandom = Random(GetArraySize(sTempCapAreas));
            sResRef = GetArrayElement(sTempCapAreas, nRandom);
        }

        object oArea = CreateArea(sResRef);

        // Grab its mem addy.
        string sPointer = ObjectToString(oArea);

        // Stick it in the array.
        sInstanceArray = AddArrayElement(sInstanceArray, sPointer);

        SetAreaName(oArea, GetName(oArea) + " - Instance - " + sPointer);

        // We need to link this area to the last area.
        object oIter = GetFirstObjectInArea(oArea);
        object oPrevIter;
        while(GetIsObjectValid(oIter)) {
            // Set our entryway to point back to the exit waypoint of the last
            // area.
            if(GetSubString(GetTag(oIter), 0, GetStringLength(TAG_TRANS_ENTRANCE)) == TAG_TRANS_ENTRANCE) {
                if(i == 0) {
                    SetLocalObject(oIter, AREA_LV_TRANS_POINTER, GetInstanceTransitionWaypoint(oDoor)); // this waypoint, which is outside the instance, has a unique tag
                    SetLocalInt(oIter, LV_DOORWAY_IS_EXIT, TRUE);
                } else {
                    // Search the last area for an exit waypoint that matches
                    // the transition number of this entrance
                    int oTransNumber = StringToInt(GetSubString(GetTag(oIter), GetStringLength(TAG_TRANS_ENTRANCE) + 1, GetStringLength(GetTag(oIter))));

                    object oIter2 = GetFirstObjectInArea(oPrevArea);
                    while(GetIsObjectValid(oIter2)) {
                        if(GetSubString(GetTag(oIter2), 0, GetStringLength(TAG_TRANS_WP_EXIT)) == TAG_TRANS_WP_EXIT) {
                            int oPrevTransNumber = StringToInt(GetSubString(GetTag(oIter2), GetStringLength(TAG_TRANS_WP_EXIT) + 1, GetStringLength(GetTag(oIter2))));

                            if(oPrevTransNumber == oTransNumber) {
                                SetLocalObject(oIter, AREA_LV_TRANS_POINTER, oIter2);
                            }
                        }

                        oIter2 = GetNextObjectInArea(oPrevArea);
                    }
                }
            } else

            // Set the previous exit to point to our entry waypoint.
            if(GetSubString(GetTag(oIter), 0, GetStringLength(TAG_TRANS_WP_ENTRANCE)) == TAG_TRANS_WP_ENTRANCE) {
                if(i == 0) JumpPartyToLocation(oPC, GetLocation(oIter));
                else {
                    int oTransNumber = StringToInt(GetSubString(GetTag(oIter), GetStringLength(TAG_TRANS_WP_ENTRANCE) + 1, GetStringLength(GetTag(oIter))));

                    object oIter2 = GetFirstObjectInArea(oPrevArea);
                    while(GetIsObjectValid(oIter2)) {
                        if(GetSubString(GetTag(oIter2), 0, GetStringLength(TAG_TRANS_EXIT)) == TAG_TRANS_EXIT) {
                            int oPrevTransNumber = StringToInt(GetSubString(GetTag(oIter2), GetStringLength(TAG_TRANS_EXIT) + 1, GetStringLength(GetTag(oIter2))));

                            if(oPrevTransNumber == oTransNumber) {
                                SetLocalObject(oIter2, AREA_LV_TRANS_POINTER, oIter);
                            }
                        }

                        oIter2 = GetNextObjectInArea(oPrevArea);
                    }
                }
            } else

            if(GetSubString(GetTag(oIter), 0, GetStringLength(TAG_TRANS_EXIT)) == TAG_TRANS_EXIT) {
                if(i == nSize - 1 && GetIsObjectValid(oExit)) {
                    SetLocalObject(oIter, AREA_LV_TRANS_POINTER, GetInstanceTransitionWaypoint(oDoor)); // this waypoint, which is outside the instance, has a unique tag
                    SetLocalInt(oIter, LV_DOORWAY_IS_EXIT, TRUE);
                }
            } else

            if(GetSubString(GetTag(oIter), 0, GetStringLength(TAG_TRANS_WP_EXIT)) == TAG_TRANS_WP_EXIT) {
                if(i == nSize - 1 && GetIsObjectValid(oExit)) {
                    // UNIQUE EXIT AREA BEHAVIOR
                    //
                    // This can be modified to link the exterior to this waypoint
                    // if so desired to switch the behavior of instancing.
                }
            } else

            // Begin spawning monsters
            if(GetSubString(GetTag(oIter), 0, GetStringLength(TAG_ENCOUNTER_BASE)) == TAG_ENCOUNTER_BASE) {
                if(oIter != oPrevIter) { // Workaround because apparently, and only when dealing with encounter waypoints, GetNextObjectInArea does not actually get the next object in area - so we otherwise end up with duplicate spawns on the same waypoint.
                    DoInstanceCreatureSpawn(oArea, oIter);
                }
            }

            oPrevIter = oIter;
            oIter = GetNextObjectInArea(oArea);
        }

        // Store the previous area before we move on.
        oPrevArea = oArea;

        SetIsDungeonInstance(oArea, TRUE);
        SetIsRandomizedInstance(oArea, TRUE);
        SetMaxLevelForLootToSpawn(oArea, nMaxLevelForLootToSpawn);
    }

    nSize = GetArraySize(sInstanceArray);

    for(i=0; i<nSize; i++){
        object oArea = StringToObject(GetArrayElement(sInstanceArray, i));

        SetInstanceArray(oArea, sInstanceArray);
    }
}

void CreateStaticDungeonInstance(object oPC, object oDoor) {
    SendMessageToDevelopers("Entering CreateStaticDungeonInstance.");
    int i;
    string sAreaStdArray = GetLocalString(oDoor, INST_LV_STD_AREA_ARRAY);
    int nSize = GetArraySize(sAreaStdArray);
    string sInstanceArray = Array();
    string sExitArray = GetLocalString(oDoor, INST_LV_EXIT_ARRAY);
    object oExit = (sExitArray == "")? OBJECT_INVALID : GetObjectByTag(GetArrayElement(sExitArray, 0));
    int nMaxLevelForLootToSpawn = GetLocalInt(oDoor, INST_LV_MAXLEVEL);

    object oPrevArea;

    for(i = 0; i < nSize; i++) {
        object oTempTrans, oTempWp;
        string sResRef = GetArrayElement(sAreaStdArray, i);
        object oArea = CreateArea(sResRef);

        SendMessageToDevelopers("Created instance area #" + IntToString(i));

        // Grab its mem addy.
        string sPointer = ObjectToString(oArea);

        // Stick it in the array.
        sInstanceArray = AddArrayElement(sInstanceArray, sPointer);

        SetAreaName(oArea, GetName(oArea) + " - Instance - " + sPointer);

        // We need to link this area to the last area.
        object oIter = GetFirstObjectInArea(oArea);
        object oPrevIter;
        while(GetIsObjectValid(oIter)) {
            // Set our entryway to point back to the exit waypoint of the last
            // area.
            if(GetSubString(GetTag(oIter), 0, GetStringLength(TAG_TRANS_ENTRANCE)) == TAG_TRANS_ENTRANCE) {
                if(i == 0) {
                    SetLocalObject(oIter, AREA_LV_TRANS_POINTER, GetInstanceTransitionWaypoint(oDoor)); // this waypoint, which is outside the instance, has a unique tag
                    SetLocalInt(oIter, LV_DOORWAY_IS_EXIT, TRUE);
                } else {
                    // Search the last area for an exit waypoint that matches
                    // the transition number of this entrance
                    int oTransNumber = StringToInt(GetSubString(GetTag(oIter), GetStringLength(TAG_TRANS_ENTRANCE) + 1, GetStringLength(GetTag(oIter))));
                    SendMessageToDevelopers("Entrance back-linking to exit.");
                    SendMessageToDevelopers("oTransNumber: " + IntToString(oTransNumber));

                    object oIter2 = GetFirstObjectInArea(oPrevArea);
                    while(GetIsObjectValid(oIter2)) {
                        if(GetSubString(GetTag(oIter2), 0, GetStringLength(TAG_TRANS_WP_EXIT)) == TAG_TRANS_WP_EXIT) {
                            int oPrevTransNumber = StringToInt(GetSubString(GetTag(oIter2), GetStringLength(TAG_TRANS_WP_EXIT) + 1, GetStringLength(GetTag(oIter2))));

                            if(oPrevTransNumber == oTransNumber) {
                                SendMessageToDevelopers("oPrevTransNumber: " + IntToString(oPrevTransNumber));
                                SetLocalObject(oIter, AREA_LV_TRANS_POINTER, oIter2);
                            }
                        }

                        oIter2 = GetNextObjectInArea(oPrevArea);
                    }
                }
            } else

            // Set the previous exit to point to our entry waypoint.
            if(GetSubString(GetTag(oIter), 0, GetStringLength(TAG_TRANS_WP_ENTRANCE)) == TAG_TRANS_WP_ENTRANCE) {
                if(i == 0) JumpPartyToLocation(oPC, GetLocation(oIter));
                else {
                    int oTransNumber = StringToInt(GetSubString(GetTag(oIter), GetStringLength(TAG_TRANS_WP_ENTRANCE) + 1, GetStringLength(GetTag(oIter))));
                    SendMessageToDevelopers("Entrance waypoint back-linking to exit.");
                    SendMessageToDevelopers("oTransNumber: " + IntToString(oTransNumber));

                    object oIter2 = GetFirstObjectInArea(oPrevArea);
                    while(GetIsObjectValid(oIter2)) {
                        if(GetSubString(GetTag(oIter2), 0, GetStringLength(TAG_TRANS_EXIT)) == TAG_TRANS_EXIT) {
                            int oPrevTransNumber = StringToInt(GetSubString(GetTag(oIter2), GetStringLength(TAG_TRANS_EXIT) + 1, GetStringLength(GetTag(oIter2))));

                            if(oPrevTransNumber == oTransNumber) {
                                SendMessageToDevelopers("oPrevTransNumber: " + IntToString(oPrevTransNumber));
                                SetLocalObject(oIter2, AREA_LV_TRANS_POINTER, oIter);
                            }
                        }

                        oIter2 = GetNextObjectInArea(oPrevArea);
                    }
                }
            } else

            if(GetSubString(GetTag(oIter), 0, GetStringLength(TAG_TRANS_EXIT)) == TAG_TRANS_EXIT) {
                if(i == nSize - 1 && GetIsObjectValid(oExit)) {
                    SetLocalObject(oIter, AREA_LV_TRANS_POINTER, GetInstanceTransitionWaypoint(oDoor)); // this waypoint, which is outside the instance, has a unique tag
                    SetLocalInt(oIter, LV_DOORWAY_IS_EXIT, TRUE);
                }
            } else

            if(GetSubString(GetTag(oIter), 0, GetStringLength(TAG_TRANS_WP_EXIT)) == TAG_TRANS_WP_EXIT) {
                if(i == nSize - 1 && GetIsObjectValid(oExit)) {
                    // UNIQUE EXIT AREA BEHAVIOR
                    //
                    // This can be modified to link the exterior to this waypoint
                    // if so desired to switch the behavior of instancing.
                }
            } else

            // Begin spawning monsters
            if(GetSubString(GetTag(oIter), 0, GetStringLength(TAG_ENCOUNTER_BASE)) == TAG_ENCOUNTER_BASE) {
                if(oIter != oPrevIter) { // Workaround because apparently, and only when dealing with encounter waypoints, GetNextObjectInArea does not actually get the next object in area - so we otherwise end up with duplicate spawns on the same waypoint.
                    DoInstanceCreatureSpawn(oArea, oIter);
                }
            }

            oPrevIter = oIter;
            oIter = GetNextObjectInArea(oArea);
        }

        // Store the previous area before we move on.
        oPrevArea = oArea;

        SetIsDungeonInstance(oArea, TRUE);
        SetIsRandomizedInstance(oArea, FALSE);
        SetMaxLevelForLootToSpawn(oArea, nMaxLevelForLootToSpawn);
    }

    // Instance array must be set on every area in the instance so that
    // area_exit functions properly.
    nSize = GetArraySize(sInstanceArray);

    for(i = 0; i < nSize; i++) {
        object oArea = StringToObject(GetArrayElement(sInstanceArray, i));

        SetInstanceArray(oArea, sInstanceArray);
    }
}

void CreateDungeonInstance(object oPC, object oDoor) {
    int bRandomized = GetLocalInt(oDoor, INST_LV_IS_RANDOMIZED);

    if(bRandomized) CreateRandomizedDungeonInstance(oPC, oDoor);
    else CreateStaticDungeonInstance(oPC, oDoor);
}

void PersistLootContainersInArea(object oArea) {
    object oIter = GetFirstObjectInArea(oArea);

    while(GetIsObjectValid(oIter)) {
        if(GetSubString(GetTag(oIter), 0, GetStringLength(TAG_CONTAINER_BASE)) == TAG_CONTAINER_BASE) {
            SetPersistentInt_instance(oArea, oIter, "loot_custom_level",   GetLocalInt(oIter, "loot_custom_level"));
            SetPersistentInt_instance(oArea, oIter, "loot_level_max",      GetLocalInt(oIter, "loot_level_max"));
            SetPersistentInt_instance(oArea, oIter, "loot_level_min",      GetLocalInt(oIter, "loot_level_min"));

            SetPersistentInt_instance(oArea, oIter, "loot_custom_amount",  GetLocalInt(oIter, "loot_custom_amount"));
            SetPersistentInt_instance(oArea, oIter, "loot_amount_max",     GetLocalInt(oIter, "loot_amount_max"));
            SetPersistentInt_instance(oArea, oIter, "loot_amount_min",     GetLocalInt(oIter, "loot_amount_min"));

            SetPersistentInt_instance(oArea, oIter, "loot_reset_time",     GetLocalInt(oIter, "loot_reset_time"));

            SetPersistentInt_instance(oArea, oIter, "loot_custom_weight",  GetLocalInt(oIter, "loot_custom_weight"));
            SetPersistentInt_instance(oArea, oIter, "loot_weight_gold",    GetLocalInt(oIter, "loot_weight_gold"));
            SetPersistentInt_instance(oArea, oIter, "loot_weight_melee",   GetLocalInt(oIter, "loot_weight_melee"));
            SetPersistentInt_instance(oArea, oIter, "loot_weight_ranged",  GetLocalInt(oIter, "loot_weight_ranged"));
            SetPersistentInt_instance(oArea, oIter, "loot_weight_ammo",    GetLocalInt(oIter, "loot_weight_ammo"));
            SetPersistentInt_instance(oArea, oIter, "loot_weight_helm",    GetLocalInt(oIter, "loot_weight_helm"));
            SetPersistentInt_instance(oArea, oIter, "loot_weight_armor",   GetLocalInt(oIter, "loot_weight_armor"));
            SetPersistentInt_instance(oArea, oIter, "loot_weight_shield",  GetLocalInt(oIter, "loot_weight_shield"));
            SetPersistentInt_instance(oArea, oIter, "loot_weight_scroll",  GetLocalInt(oIter, "loot_weight_scroll"));
            SetPersistentInt_instance(oArea, oIter, "loot_weight_gem",     GetLocalInt(oIter, "loot_weight_gem"));
            SetPersistentInt_instance(oArea, oIter, "loot_weight_potion",  GetLocalInt(oIter, "loot_weight_potion"));
            SetPersistentInt_instance(oArea, oIter, "loot_weight_wand",    GetLocalInt(oIter, "loot_weight_wand"));
            SetPersistentInt_instance(oArea, oIter, "loot_weight_rod",     GetLocalInt(oIter, "loot_weight_rod"));
            SetPersistentInt_instance(oArea, oIter, "loot_weight_staff",   GetLocalInt(oIter, "loot_weight_staff"));
            SetPersistentInt_instance(oArea, oIter, "loot_weight_amulet",  GetLocalInt(oIter, "loot_weight_amulet"));
            SetPersistentInt_instance(oArea, oIter, "loot_weight_belt",    GetLocalInt(oIter, "loot_weight_belt"));
            SetPersistentInt_instance(oArea, oIter, "loot_weight_boots",   GetLocalInt(oIter, "loot_weight_boots"));
            SetPersistentInt_instance(oArea, oIter, "loot_weight_bracers", GetLocalInt(oIter, "loot_weight_bracers"));
            SetPersistentInt_instance(oArea, oIter, "loot_weight_cloak",   GetLocalInt(oIter, "loot_weight_cloak"));
            SetPersistentInt_instance(oArea, oIter, "loot_weight_ring",    GetLocalInt(oIter, "loot_weight_ring"));
            SetPersistentInt_instance(oArea, oIter, "loot_weight_reagent", GetLocalInt(oIter, "loot_weight_reagent"));
        }

        oIter = GetNextObjectInArea(oArea);
    }
}

void PersistEncounterWaypointsInArea(object oArea) {
    object oIter = GetFirstObjectInArea(oArea);

    while(GetIsObjectValid(oIter)) {
        if(GetSubString(GetTag(oIter), 0, GetStringLength(TAG_ENCOUNTER_BASE)) == TAG_ENCOUNTER_BASE) {
            // Cycle through all spawn blueprints...
            int nCount = 0;
            string sBlueprint = GetSpawnBlueprint(oIter, nCount);
            while(sBlueprint != "") {
                SetPersistentString_instance(oArea, oIter, CREATURE_BP + IntToString(nCount), sBlueprint);
                nCount += 1;
                sBlueprint = GetSpawnBlueprint(oIter, nCount);
            }

            // Other spawn-related variables

            SetPersistentFloat_instance(oArea, oIter, RESET_TIME, GetLocalFloat(oIter, RESET_TIME));
            SetPersistentInt_instance(oArea, oIter, SPAWN_CHANCE, GetSpawnChance(oIter));
            SetPersistentInt_instance(oArea, oIter, SPAWN_MAX_HOUR, GetSpawnMaxHour(oIter));
            SetPersistentInt_instance(oArea, oIter, SPAWN_MIN_HOUR, GetSpawnMinHour(oIter));
            SetPersistentInt_instance(oArea, oIter, SPAWN_VFX_ENABLED, GetIsSpawnVFXEnabled(oIter));
            SetPersistentInt_instance(oArea, oIter, SPAWN_VFX_NUM, GetSpawnVFXNumber(oIter));
            SetPersistentFloat_instance(oArea, oIter, SPAWN_VFX_DUR, GetSpawnVFXDuration(oIter));
        }

        oIter = GetNextObjectInArea(oArea);
    }
}

void InitializeInstancing() {
    object oArea;
    object oIter;
    float fDelay = 0.0;
    float fInc = 6.0;

    // Clear existing instancing table(s)
    // This accounts for changes to dungeons in-between server
    // resets.

    ClearInstanceTables();

    // Begin loading dungeon data.
    // Note that DelayCommand MUST be employed so that MySQL is not overwhelmed
    // by too many queries/second - results in not storing all data.

    // INSTANCE_DNG_0000
    // Along the Sword River - Goblin Lair


    /*oArea = GetObjectByTag(TAG_INSTANCE_DNG_0000_000);
    DelayCommand(fDelay, PersistLootContainersInArea(oArea));
    DelayCommand(fDelay, PersistEncounterWaypointsInArea(oArea));
    fDelay += fInc;

    oArea = GetObjectByTag(TAG_INSTANCE_DNG_0000_001);
    DelayCommand(fDelay, PersistLootContainersInArea(oArea));
    DelayCommand(fDelay, PersistEncounterWaypointsInArea(oArea));
    fDelay += fInc;

    oArea = GetObjectByTag(TAG_INSTANCE_DNG_0000_002);
    DelayCommand(fDelay, PersistLootContainersInArea(oArea));
    DelayCommand(fDelay, PersistEncounterWaypointsInArea(oArea));
    fDelay += fInc;*/

    //Cultist dungeon

    /*oArea = GetObjectByTag(TAG_INSTANCE_DNG_0001_000);
    DelayCommand(fDelay, PersistLootContainersInArea(oArea));
    DelayCommand(fDelay, PersistEncounterWaypointsInArea(oArea));
    fDelay += fInc;

    oArea = GetObjectByTag(TAG_INSTANCE_DNG_0001_001);
    DelayCommand(fDelay, PersistLootContainersInArea(oArea));
    DelayCommand(fDelay, PersistEncounterWaypointsInArea(oArea));
    fDelay += fInc;

    oArea = GetObjectByTag(TAG_INSTANCE_DNG_0001_002);
    DelayCommand(fDelay, PersistLootContainersInArea(oArea));
    DelayCommand(fDelay, PersistEncounterWaypointsInArea(oArea));
    fDelay += fInc;*/

    //Water Snakes

    /*oArea = GetObjectByTag(TAG_INSTANCE_DNG_0002_000);
    DelayCommand(fDelay, PersistLootContainersInArea(oArea));
    DelayCommand(fDelay, PersistEncounterWaypointsInArea(oArea));
    fDelay += fInc;*/

    //Abandoned home

    /*oArea = GetObjectByTag(TAG_INSTANCE_DNG_0003_000);
    DelayCommand(fDelay, PersistLootContainersInArea(oArea));
    DelayCommand(fDelay, PersistEncounterWaypointsInArea(oArea));
    fDelay += fInc;

    oArea = GetObjectByTag(TAG_INSTANCE_DNG_0003_001);
    DelayCommand(fDelay, PersistLootContainersInArea(oArea));
    DelayCommand(fDelay, PersistEncounterWaypointsInArea(oArea));
    fDelay += fInc;

    oArea = GetObjectByTag(TAG_INSTANCE_DNG_0003_002);
    DelayCommand(fDelay, PersistLootContainersInArea(oArea));
    DelayCommand(fDelay, PersistEncounterWaypointsInArea(oArea));
    fDelay += fInc;*/

    // Fire Giant Caverns

    oArea = GetObjectByTag(TAG_INSTANCE_DNG_0005_000);
    DelayCommand(fDelay, PersistLootContainersInArea(oArea));
    DelayCommand(fDelay, PersistEncounterWaypointsInArea(oArea));
    fDelay += fInc;

    oArea = GetObjectByTag(TAG_INSTANCE_DNG_0005_001);
    DelayCommand(fDelay, PersistLootContainersInArea(oArea));
    DelayCommand(fDelay, PersistEncounterWaypointsInArea(oArea));
    fDelay += fInc;

    oArea = GetObjectByTag(TAG_INSTANCE_DNG_0005_002);
    DelayCommand(fDelay, PersistLootContainersInArea(oArea));
    DelayCommand(fDelay, PersistEncounterWaypointsInArea(oArea));
    fDelay += fInc;

    oArea = GetObjectByTag(TAG_INSTANCE_DNG_0005_003);
    DelayCommand(fDelay, PersistLootContainersInArea(oArea));
    DelayCommand(fDelay, PersistEncounterWaypointsInArea(oArea));
    fDelay += fInc;

    // Chapel of Stilled Voices

    oArea = GetObjectByTag(TAG_INSTANCE_DNG_0004_000);
    DelayCommand(fDelay, PersistLootContainersInArea(oArea));
    DelayCommand(fDelay, PersistEncounterWaypointsInArea(oArea));
    fDelay += fInc;

    oArea = GetObjectByTag(TAG_INSTANCE_DNG_0004_001);
    DelayCommand(fDelay, PersistLootContainersInArea(oArea));
    DelayCommand(fDelay, PersistEncounterWaypointsInArea(oArea));
    fDelay += fInc;
}

int GetPCCountInInstance(string sInstance){
    int i;

    int nSize = GetArraySize(sInstance);

    int nCount = 0;

    for(i=0; i<nSize; i++){
        object oArea = StringToObject(GetArrayElement(sInstance, i));

        nCount += GetPCCountInArea(oArea, TRUE);
    }

    return nCount;
}

void DestroyDungeonInstance(string sInstance){
    int i;

    int nSize = GetArraySize(sInstance);

    for(i=0; i<nSize; i++){
        object oArea = StringToObject(GetArrayElement(sInstance, i));

        DestroyArea(oArea);
    }
}

int IsAreaInstanceOccupied(string sInstance){
    int i;

    string sAreas = GetArrayElement(sInstance, 0);

    int iNumAreas = GetArraySize(sAreas);

    for(i = 0; i < iNumAreas; i++){
        string sTag = GetArrayElement(sAreas, i);

        object oArea = GetObjectByTag(sTag);

        if(GetPCCountInArea(oArea)) return TRUE;
    }

    return FALSE;
}

void CreateDMAreaInstance(object oDM, object oArea, string sNewName=""){
    string sResRef = GetResRef(oArea);

    object oCopy = CreateArea(sResRef);

    if(sNewName != "") SetAreaName(oCopy, "[Instance] - " + sNewName);
    else               SetAreaName(oCopy, "[Instance] - " + GetName(oArea));

    SetLocalInt(oCopy, AREA_LV_IS_INSTANCED, TRUE);
    SetLocalString(oCopy, AREA_LV_INSTANCED_BY, GetPCPlayerName(oDM));


    FloatingTextStringOnCreature("Created: " + GetName(oCopy), oDM, FALSE);
}

void DestroyDMAreaInstance(object oDM, object oArea){
    if(GetLocalInt(oArea, AREA_LV_IS_INSTANCED)){
        SendMessageToPC(oDM, "There are " + IntToString(GetPCCountInArea(oArea, TRUE)) + " players in the area.");

        if(GetPCCountInArea(oArea, TRUE) < 1){
            FloatingTextStringOnCreature("Destroying: " + GetName(oArea), oDM, FALSE);

            DestroyArea(oArea);
        } else {
            FloatingTextStringOnCreature("Marking " + GetName(oArea) + " for destruction.", oDM, FALSE);

            SetLocalInt(oArea, AREA_LV_MARK_DELETION, TRUE);
        }
    } else {
        FloatingTextStringOnCreature("Cannot destroy " + GetName(oArea) + " as it is not an instance.", oDM, FALSE);
    }
}

void DestroyAllDMAreaInstances(object oDM){
    object oArea = GetFirstArea();
    string sAccount = GetPCPlayerName(oDM);

    string sToDelete = Array();

    while(GetIsObjectValid(oArea)){
        if(GetLocalString(oArea, AREA_LV_INSTANCED_BY) == sAccount){
            sToDelete = AddArrayElement(sToDelete, ObjectToString(oArea));
        }

        oArea = GetNextArea();
    }

    int i;

    for(i = 0; i < GetArraySize(sToDelete); i++){
        object oDelete = StringToObject(GetArrayElement(sToDelete, i));

        DestroyDMAreaInstance(oDM, oDelete);
    }
}

int GetSpawnCountInArea(object oArea){
    int nReturn = 0;

    object oTemp = GetFirstObjectInArea(oArea);

    while(GetIsObjectValid(oTemp)){
        if(GetTag(oTemp) == SPAWN_TAG) nReturn++;

        oTemp = GetNextObjectInArea(oArea);
    }

    return nReturn;
}

int GetPCCountInArea(object oArea, int bIncludeDMs=FALSE){
    int nReturn = 0;

    object oPC = GetFirstPC();

    while(GetIsObjectValid(oPC)){
        if(oArea == GetArea(oPC) && (!GetIsDM(oPC) || bIncludeDMs)) nReturn++;

        oPC = GetNextPC();
    }

    return nReturn;
}

void ApplyAreaPauseEffect(object oCreature){
    effect eParalyze = SupernaturalEffect(EffectCutsceneParalyze());
    effect eVisual   = SupernaturalEffect(EffectVisualEffect(VFX_DUR_FREEZE_ANIMATION));

    if(GetPlotFlag(oCreature)){
        SetLocalInt(oCreature, "AREA_PAUSE_INVULNERABLE_FLAG", TRUE);
        SetPlotFlag(oCreature, FALSE);
    }

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eParalyze, oCreature);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVisual, oCreature);
}

void RemoveAreaPauseEffect(object oCreature){
    effect eEffect = GetFirstEffect(oCreature);

    while(GetIsEffectValid(eEffect)){
        if(((GetEffectType(eEffect) == EFFECT_TYPE_CUTSCENE_PARALYZE && GetIsISSVerified(oCreature))
        ||   GetEffectType(eEffect) == EFFECT_TYPE_VISUALEFFECT)
        &&   GetEffectSubType(eEffect) == SUBTYPE_SUPERNATURAL){
            RemoveEffect(oCreature, eEffect);
        }

        eEffect = GetNextEffect(oCreature);
    }

    if(GetLocalInt(oCreature, "AREA_PAUSE_INVULNERABLE_FLAG")){
        SetPlotFlag(oCreature, TRUE);
        DeleteLocalInt(oCreature, "AREA_PAUSE_INVULNERABLE_FLAG");
    }
}

int GetIsAreaPaused(object oArea){
    return GetLocalInt(oArea, AREA_PAUSED);
}

void SetIsAreaPaused(object oArea, int nPaused){
    object oCreature = GetFirstObjectInArea(oArea);

    if(nPaused){
        while(GetIsObjectValid(oCreature)){
            if(GetObjectType(oCreature) == OBJECT_TYPE_CREATURE){
                ApplyAreaPauseEffect(oCreature);

                if(GetIsPC(oCreature)){
                    FloatingTextStringOnCreature("This area has been paused.", oCreature, FALSE);
                }
            }

            oCreature = GetNextObjectInArea(oArea);
        }
    } else {
        while(GetIsObjectValid(oCreature)){
            if(GetObjectType(oCreature) == OBJECT_TYPE_CREATURE){
                RemoveAreaPauseEffect(oCreature);

                if(GetIsPC(oCreature)){
                    FloatingTextStringOnCreature("This area has been unpaused.", oCreature, FALSE);
                }
            }

            oCreature = GetNextObjectInArea(oArea);
        }
    }

    SetLocalInt(oArea, AREA_PAUSED, nPaused);
}

int GetIsGlobalArea(object oArea){
    string sTag = GetTag(oArea);

    if(GetStringBeginsWith(sTag, "zdm_")) return FALSE;
    if(GetStringBeginsWith(sTag, "ooc_")) return FALSE;

    if(GetLocalInt(oArea, "AREA_IS_NOT_GLOBAL")) return FALSE;

    return TRUE;
}

int GetIsAreaNaturalExterior(object oArea){
    string sTag = GetTag(oArea);

    int bReturn = GetIsAreaNatural(oArea) &&
                  !GetIsAreaInterior(oArea);

    return bReturn;
}

int GetIsAreaDungeon(object oArea){
    string sTag = GetTag(oArea);

    int bReturn = !GetIsAreaAboveGround(oArea) &&
                  !GetStringBeginsWith(sTag, "snu_");      // Sundabar Undercity

    return bReturn;
}
