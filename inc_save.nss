#include "engine"

#include "aps_include"

#include "inc_map_pins"

// The save interval of the module (in minutes).
const int MOD_SAVE_INTERVAL = 5;

// Initializes the module's save system, which does things like saving the time,
// weather, and most importantly characters.
int InitializeSaveSystem();

// Saves the module. If nRecursive is TRUE, it will go into a recursive loop.
// Do NOT set nRecursive to TRUE outside of the InitializeSaveSystem() function.
void SaveModule(int nRecursive = FALSE);

void SaveAllCharacters();

void SaveCharacter(object oPC);

void SaveWeather();

int InitializeSaveSystem(){
    object oModule = GetModule();

    // If we've already initialized, break off.
    if(GetLocalInt(oModule, "MOD_SAVE_SYSTEM_INTIAILIZED")) return FALSE;

    SetLocalInt(oModule, "MOD_SAVE_SYSTEM_INITALIZED", TRUE);

    SaveModule(TRUE);

    return TRUE;
}

void SaveModule(int nRecursive = FALSE){
    SaveAllCharacters();
    SaveWeather();

    // Our pseudo-heartbeat, which runs every five minutes to store what's
    // happening in the module.
    if(nRecursive) DelayCommand(TurnsToSeconds(MOD_SAVE_INTERVAL), SaveModule(TRUE));
}

void SaveAllCharacters(){
    object oPC = GetFirstPC();

    while(GetIsObjectValid(oPC)){
        SaveCharacter(oPC);
        oPC = GetNextPC();
    }
}

void SetPersistentHitPointsEnabled(object oPC){
    SetPersistentInt(oPC, "PC_HIT_POINTS_ENABLED", TRUE);
}

int GetPersistentHitPointsEnabled(object oPC){
    return GetPersistentInt(oPC, "PC_HIT_POINTS_ENABLED");
}

void SavePersistentHitPoints(object oPC){
    SetPersistentHitPointsEnabled(oPC);

    SetPersistentInt(oPC, "PC_LAST_HIT_POINTS", GetCurrentHitPoints(oPC));
}

int GetPersistentHitPoints(object oPC){
    if(GetPersistentHitPointsEnabled(oPC)) return GetPersistentInt(oPC, "PC_LAST_HIT_POINTS");

    return GetMaxHitPoints(oPC);
}

void RestorePersistentHitPoints(object oPC){
    SetCurrentHitPoints(oPC, GetPersistentHitPoints(oPC));
}

void SaveCharacter(object oPC){
    ExportSingleCharacter(oPC);
    SavePersistentHitPoints(oPC);
    SaveMapPinsToDB(oPC);
}

void SaveWeather(){

}
