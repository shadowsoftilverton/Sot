#include "engine"

#include "inc_arrays"
#include "inc_encounter"

const string LV_IS_WAVE_ACTIVE = "wave_is_active";

const string LV_WAVE_DELAY = "wave_time_delay";
const string LV_WAVE_RANDOM = "wave_time_random";

const string LV_WAVE_INITIAL_DELAY = "wave_time_initial_delay";
const string LV_WAVE_INITIAL_RANDOM = "wave_time_initial_random";

// RANDOM or SEQUENTIAL
const string LV_WAVE_TYPE = "wave_type";

const string LV_WAVE_CLUSTER = "wave_cluster_";

const string LV_WAVE_COUNTER = "wave_counter";

const int WAVE_TYPE_RANDOM = 0;
const int WAVE_TYPE_SEQUENTIAL = 1;

void SetIsWaveActive(object oArea, int nActive){
    SetLocalInt(oArea, LV_IS_WAVE_ACTIVE, nActive);
}

int GetIsWaveActive(object oArea){
    return GetLocalInt(oArea, LV_IS_WAVE_ACTIVE);
}

void DeleteIsWaveActive(object oArea){
    DeleteLocalInt(oArea, LV_IS_WAVE_ACTIVE);
}

int GetWaveType(object oArea){
    return GetLocalInt(oArea, LV_WAVE_TYPE);
}

string GetWaveCluster(object oArea, int nCluster){
    return GetLocalString(oArea, LV_WAVE_CLUSTER + IntToString(nCluster));
}

void SetWaveCount(object oArea, int nCount){
    SetLocalInt(oArea, LV_WAVE_COUNTER, nCount);
}

int GetWaveCount(object oArea){
    return GetLocalInt(oArea, LV_WAVE_COUNTER);
}

void DeleteWaveCount(object oArea){
    DeleteLocalInt(oArea, LV_WAVE_COUNTER);
}

void IncrementWaveCount(object oArea){
    SetLocalInt(oArea, LV_WAVE_COUNTER, GetLocalInt(oArea, LV_WAVE_COUNTER) + 1);
}

float GetWaveDelay(object oArea){
    int nBase = GetLocalInt(oArea, LV_WAVE_DELAY);
    int nRandom = GetLocalInt(oArea, LV_WAVE_RANDOM);

    return IntToFloat(nBase + Random(nRandom));
}

float GetInitialWaveDelay(object oArea){
    int nBase = GetLocalInt(oArea, LV_WAVE_INITIAL_DELAY);
    int nRandom = GetLocalInt(oArea, LV_WAVE_INITIAL_RANDOM);

    return IntToFloat(nBase + Random(nRandom));
}

int GetPCsInArea(object oArea){
    int nReturn = 0;

    object oIter = GetFirstObjectInArea(oArea);

    while(GetIsObjectValid(oIter)){
        if(GetIsPC(oIter)) nReturn++;
        oIter = GetNextObjectInArea(oArea);
    }

    return nReturn;
}

void DoWaveSpawn(object oArea, float fDelay=0.0){
    if(!GetIsWaveActive(oArea)) return;

    // If there are no PCs in the area, break after resetting vars.
    if(GetPCsInArea(oArea) < 1){
        DeleteIsWaveActive(oArea);
        DeleteWaveCount(oArea);
        return;
    }

    int nType = GetWaveType(oArea);
    int nSelect = 0;

    int nMax = GetLVArraySize_string(oArea, LV_WAVE_CLUSTER);

    switch(nType){
        case WAVE_TYPE_RANDOM:
            nSelect = Random(nMax);
        break;

        case WAVE_TYPE_SEQUENTIAL:
            nSelect = GetWaveCount(oArea);

            if(nSelect >= nMax){
                nSelect = 0;
                SetWaveCount(oArea, 0);
            }
        break;
    }

    int i = 0;

    string sCluster = GetWaveCluster(oArea, nSelect);

    // Failsafe.
    if(sCluster == "") return;

    object oWaypoint = GetObjectByTag(sCluster, i++);

    location lLoc;
    object oSpawn;
    effect eVFX;
    int nSpawnChance;
    int nVFX;
    float fDur;

    while(GetIsObjectValid(oWaypoint)){
        if(!GetSpawnDisabled(oWaypoint) && GetIsSpawnHour(oWaypoint)){

            nSpawnChance = GetSpawnChance(oWaypoint);

            if(nSpawnChance >= d100() || nSpawnChance == 0){

                int nCount = 0;
                string sBlueprint = GetSpawnBlueprint(oWaypoint, nCount);

                lLoc = GetLocation(oWaypoint);

                while(sBlueprint != ""){
                    nCount += 1;

                    sBlueprint = GetSpawnBlueprint(oWaypoint, nCount);
                }

                int nRandom = Random(nCount);

                sBlueprint = GetSpawnBlueprint(oWaypoint, nRandom);

                CreateObject(OBJECT_TYPE_CREATURE, sBlueprint, lLoc, FALSE, SPAWN_TAG);

                if(GetIsSpawnVFXEnabled(oWaypoint)){
                    nVFX = GetSpawnVFXNumber(oWaypoint);
                    fDur = GetSpawnVFXDuration(oWaypoint);

                    effect eVFX = EffectVisualEffect(nVFX);

                    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eVFX, lLoc, fDur);
                }
            }
        }

        oWaypoint = GetObjectByTag(sCluster, i++);
    }

    // Recursive call.
    DoWaveSpawn(oArea, GetWaveDelay(oArea));
}


void main()
{
    object oSelf = OBJECT_SELF;
    object oPC = GetEnteringObject();

    // Break if we're not dealing with a PC.
    if(!GetIsPC(oPC) || GetIsDM(oPC)) return;

    // Break if we're already active.
    if(GetIsWaveActive(oSelf)) return;

    SetIsWaveActive(oSelf, TRUE);

    DoWaveSpawn(oSelf, GetInitialWaveDelay(oSelf));
}
