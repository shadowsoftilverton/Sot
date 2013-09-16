#include "engine"
#include "aps_include"

const string WAYPOINT_TAG = "wp";
const string CREATURE_BP = "bp_";

const string RESET_TIME = "reset_time";

const string SPAWN_DISABLED = "spawn_disabled";

const string SPAWN_TAG = "encounter_spawn";

const string SPAWN_CHANCE = "spawn_chance";

const string SPAWN_MAX_HOUR = "max_hour";
const string SPAWN_MIN_HOUR = "min_hour";

const string SPAWN_VFX_ENABLED = "vfx_enabled";
const string SPAWN_VFX_NUM = "vfx_num";
const string SPAWN_VFX_DUR = "vfx_dur";

int GetIsSpawnVFXEnabled(object oWaypoint){
    return GetLocalInt(oWaypoint, SPAWN_VFX_ENABLED);
}

int GetIsSpawnVFXEnabled_instance(object oArea, object oWaypoint) {
    return GetPersistentInt_instance(oArea, oWaypoint, SPAWN_VFX_ENABLED);
}

int GetSpawnVFXNumber(object oWaypoint){
    return GetLocalInt(oWaypoint, SPAWN_VFX_NUM);
}

int GetSpawnVFXNumber_instance(object oArea, object oWaypoint) {
    return GetPersistentInt_instance(oArea, oWaypoint, SPAWN_VFX_NUM);
}

float GetSpawnVFXDuration(object oWaypoint){
    return GetLocalFloat(oWaypoint, SPAWN_VFX_DUR);
}

float GetSpawnVFXDuration_instance(object oArea, object oWaypoint) {
    return GetPersistentFloat_instance(oArea, oWaypoint, SPAWN_VFX_DUR);
}

string GetWaypointTag(object oTrigger){
    return GetLocalString(oTrigger, WAYPOINT_TAG);
}

string GetWaypointTag_instance(object oArea, object oTrigger) {
    return GetPersistentString_instance(oArea, oTrigger, WAYPOINT_TAG);
}

void SetSpawnDisabled(object oWaypoint, int nBool){
    SetLocalInt(oWaypoint, SPAWN_DISABLED, nBool);
}

void SetSpawnDisabled_instance(object oArea, object oWaypoint, int nBool) {
    SetPersistentInt_instance(oArea, oWaypoint, SPAWN_DISABLED, nBool);
}

int GetSpawnDisabled(object oWaypoint){
    return GetLocalInt(oWaypoint, SPAWN_DISABLED);
}

int GetSpawnDisabled_instance(object oArea, object oWaypoint) {
    return GetPersistentInt_instance(oArea, oWaypoint, SPAWN_DISABLED);
}

int GetSpawnChance(object oWaypoint){
    return GetLocalInt(oWaypoint, SPAWN_CHANCE);
}

int GetSpawnChance_instance(object oArea, object oWaypoint) {
    return GetPersistentInt_instance(oArea, oWaypoint, SPAWN_CHANCE);
}

string GetSpawnBlueprint(object oWaypoint, int nIndex){
    return GetLocalString(oWaypoint, CREATURE_BP + IntToString(nIndex));
}

string GetSpawnBlueprint_instance(object oArea, object oWaypoint, int nIndex) {
    return GetPersistentString_instance(oArea, oWaypoint, CREATURE_BP + IntToString(nIndex));
}

int GetSpawnMaxHour(object oWaypoint){
    return GetLocalInt(oWaypoint, SPAWN_MAX_HOUR);
}

int GetSpawnMaxHour_instance(object oArea, object oWaypoint) {
    return GetPersistentInt_instance(oArea, oWaypoint, SPAWN_MAX_HOUR);
}

int GetSpawnMinHour(object oWaypoint){
    return GetLocalInt(oWaypoint, SPAWN_MIN_HOUR);
}

int GetSpawnMinHour_instance(object oArea, object oWaypoint) {
    return GetPersistentInt_instance(oArea, oWaypoint, SPAWN_MIN_HOUR);
}

int GetIsSpawnHour(object oWaypoint){
    int nHour = GetTimeHour();
    int nMax = GetSpawnMaxHour(oWaypoint);
    int nMin = GetSpawnMinHour(oWaypoint);

    if(nMax == 0 && nMin == 0) return TRUE;

    if(nMax > nMin) return nHour >= GetSpawnMinHour(oWaypoint) && nHour < GetSpawnMaxHour(oWaypoint);
    if(nMax < nMin) return nHour >= GetSpawnMinHour(oWaypoint) || nHour < GetSpawnMaxHour(oWaypoint);

    return TRUE;
}

int GetIsSpawnHour_instance(object oArea, object oWaypoint) {
    int nHour = GetTimeHour();
    int nMax = GetSpawnMaxHour_instance(oArea, oWaypoint);
    int nMin = GetSpawnMinHour_instance(oArea, oWaypoint);

    if(nMax == 0 && nMin == 0) return TRUE;

    if(nMax > nMin) return nHour >= GetSpawnMinHour_instance(oArea, oWaypoint) && nHour < GetSpawnMaxHour_instance(oArea, oWaypoint);
    if(nMax < nMin) return nHour >= GetSpawnMinHour_instance(oArea, oWaypoint) || nHour < GetSpawnMaxHour_instance(oArea, oWaypoint);

    return TRUE;
}

void DoInstanceCreatureSpawn(object oArea, object oWaypoint) {
    int nSpawnChance;
    location lLoc = GetLocation(oWaypoint);
    //SendMessageToDevelopers("DoInstanceCreatureSpawn: < " + GetTag(oWaypoint) + ">.");
    //SendMessageToDevelopers("DoInstanceCreatureSpawn: <" + GetName(oArea) + "> <" + GetTag(oWaypoint) + ">.");

    if(GetIsSpawnHour_instance(oArea, oWaypoint)) {
        nSpawnChance = GetSpawnChance_instance(oArea, oWaypoint);

        if(nSpawnChance >= d100() || nSpawnChance == 0) {
            int nCount = 0;
            string sBlueprint = GetSpawnBlueprint_instance(oArea, oWaypoint, nCount);
            while(sBlueprint != "") {
                nCount += 1;

                sBlueprint = GetSpawnBlueprint_instance(oArea, oWaypoint, nCount);
            }

            int nRandom = Random(nCount);

            sBlueprint = GetSpawnBlueprint_instance(oArea, oWaypoint, nRandom);
            //SendMessageToDevelopers("Spawning: <" + sBlueprint + "> at <" + GetTag(oWaypoint) + "> in <" + GetName(oArea) + ">.");
            CreateObject(OBJECT_TYPE_CREATURE, sBlueprint, lLoc, FALSE, SPAWN_TAG);

            if(GetIsSpawnVFXEnabled_instance(oArea, oWaypoint)) {
                int nVFX = GetSpawnVFXNumber_instance(oArea, oWaypoint);
                float fDur = GetSpawnVFXDuration_instance(oArea, oWaypoint);

                effect eVFX = EffectVisualEffect(nVFX);

                ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVFX, lLoc, fDur);
            }
        }
    }
}
