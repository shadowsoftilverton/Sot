#include "engine"

#include "inc_save"

const string REVIVAL_WAYPOINT_TAG = "RES_TMP_ARATYM";
const string REVIVAL_WAYPOINT_TAG_TEMPUS = "inv_mod_waypoint_revival_tempus";

const string RESREF_BODY_MALE   = "ITM_BODY_MALE";
const string RESREF_BODY_FEMALE = "ITM_BODY_FEMALE";

const string BODY_VAR_GENDER  = "BODY_PC_GENDER";
const string BODY_VAR_NAME    = "BODY_PC_NAME";
const string BODY_VAR_ACCOUNT = "BODY_PC_ACCOUNT";

const string BODY_VAR_MODEL   = "BODY_PC_MODEL";

const string PC_VAR_IS_DEAD        = "PC_IS_DEAD";
const string PC_VAR_DEATH_LOCATION = "PC_DEATH_LOCATION";
const string PC_VAR_DEATH_SERVER   = "PC_DEATH_SERVER";

const string AREA_FUGUE = "world_fugue";

object GetPCFromPlayerName(string sCharacter, string sAccount);

void CleanupPlayerBodies(string sCharacter, string sAccount);

string GetUniqueBodyTag(object oPC);

void CreatePlayerBodyPlaceable(object oPC, location lLoc);

void ApplyRespawnPenalty(object oDead);

void RevivePlayer(string sCharacter, string sAccount, location lLoc, int nHP=-1);

void SetIsPersistentDead(object oP, int nValue);

int GetIsPersistentDead(object oP);

void SetPersistentDeathLocation(object oP, location lValue);

location GetPersistentDeathLocation(object oPC);

void SetIsPersistentDead_player(string sCharacter, string sAccount, int nValue);

int GetIsPersistentDead_player(string sCharacter, string sAccount);

void SetPersistentDeathLocation_player(string sCharacter, string sAccount, location lValue);

location GetPersistentDeathLocation_player(string sCharacter, string sAccount);

void CleanRevivedCorpses(object oPC);

void CleanRevivedCorpses(object oPC){
    object oItem = GetFirstItemInInventory(oPC);

    while(GetIsObjectValid(oItem)){
        if(GetTag(oItem) == "itm_pc_body"){
            string sCharacter = GetLocalString(oItem, BODY_VAR_NAME);
            string sAccount   = GetLocalString(oItem, BODY_VAR_ACCOUNT);

            if(GetPersistentInt_player(sCharacter, sAccount, PC_VAR_IS_DEAD) != 1){
                DestroyObject(oItem);

                DelayCommand(0.0, FloatingTextStringOnCreature(sCharacter + " has been revived.", oPC, FALSE));
                DelayCommand(3.0, FloatingTextStringOnCreature("Their body has been removed from your inventory.", oPC, FALSE));
            }
        }

        oItem = GetNextItemInInventory(oPC);
    }
}

void SetIsPersistentDead(object oPC, int nValue){
    SetPersistentInt(oPC, PC_VAR_IS_DEAD, nValue);
}

int GetIsPersistentDead(object oPC){
    return GetPersistentInt(oPC, PC_VAR_IS_DEAD);
}

void SetPersistentDeathLocation(object oPC, location lValue){
    SetPersistentLocation(oPC, PC_VAR_DEATH_LOCATION, lValue);
}

location GetPersistentDeathLocation(object oPC){
    return GetPersistentLocation(oPC, PC_VAR_DEATH_LOCATION);
}

void SetPersistentDeathServer(object oPC, int nServerType) {
    SetPersistentInt(oPC, PC_VAR_DEATH_SERVER, nServerType);
}

int GetPersistentDeathServer(object oPC) {
    return GetPersistentInt(oPC, PC_VAR_DEATH_SERVER);
}

void SetIsPersistentDead_player(string sCharacter, string sAccount, int nValue){
    SetPersistentInt_player(sCharacter, sAccount, PC_VAR_IS_DEAD, nValue);
}

int GetIsPersistentDead_player(string sCharacter, string sAccount){
    return GetPersistentInt_player(sCharacter, sAccount, PC_VAR_IS_DEAD);
}

void SetPersistentDeathLocation_player(string sCharacter, string sAccount, location lValue){
    SetPersistentLocation_player(sCharacter, sAccount, PC_VAR_DEATH_LOCATION, lValue);
}

location GetPersistentDeathLocation_player(string sCharacter, string sAccount){
    return GetPersistentLocation_player(sCharacter, sAccount, PC_VAR_DEATH_LOCATION);
}

// * Applies an XP and GP penalty
// * to the player respawning
void ApplyRespawnPenalty(object oDead)
{
    int nXP = GetXP(oDead);
    int nHD = GetHitDice(oDead);
    int nPenalty = 50 * nHD;
    // * You can not lose a level with this respawning
    int nMin = ((nHD * (nHD - 1)) / 2) * 1000;

    int nNewXP = nXP - nPenalty;
    if (nNewXP < nMin)
       nNewXP = nMin;
    SetXP(oDead, nNewXP);
    int nGoldToTake =    FloatToInt(0.25 * GetGold(oDead));
    // * a cap of 10 000gp taken from you
    if (nGoldToTake > 10000)
    {
        nGoldToTake = 10000;
    }
    AssignCommand(oDead, TakeGoldFromCreature(nGoldToTake, oDead, TRUE));
    DelayCommand(4.0, FloatingTextStrRefOnCreature(58299, oDead, FALSE));
    DelayCommand(4.8, FloatingTextStrRefOnCreature(58300, oDead, FALSE));
}

void RevivePlayer(string sCharacter, string sAccount, location lLoc, int nHP){
    object oPC = GetPCFromPlayerName(sCharacter, sAccount);

    if(GetIsObjectValid(oPC)){
        // This handles if the character is logged on.
        if(nHP < 0) nHP = GetMaxHitPoints(oPC);
        AssignCommand(oPC, JumpToLocation(lLoc));
        SetCurrentHitPoints(oPC, nHP);
        SetIsPersistentDead(oPC, FALSE);
    } else {
        // This handles if the character isn't logged on.
        SetIsPersistentDead_player(sCharacter, sAccount, -1);
        SetPersistentDeathLocation_player(sCharacter, sAccount, lLoc);
    }

    CleanupPlayerBodies(sCharacter, sAccount);
}

void CreatePlayerBodyPlaceable(object oPC, location lLoc){
    // Spawn our dummy corpse and placeable.
    object oBody = CopyObject(oPC, lLoc, OBJECT_INVALID, "plc_pc_body");
    object oPlc  = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_pc_body", lLoc, FALSE);

    SetName(oPlc, GetName(oPC) + "'s Body");

    // Assign the dummy to linger as a corpse, then kill him.
    AssignCommand(oBody, SetIsDestroyable(FALSE, TRUE, FALSE));
    effect eDeath = EffectDeath();
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oBody);

    // Cleanup on the body requires vars.
    SetLocalString(oBody, BODY_VAR_NAME,    GetName(oPC));
    SetLocalString(oBody, BODY_VAR_ACCOUNT, GetPCPlayerName(oPC));

    // Setup our relevant variables.
    SetLocalInt(oPlc, BODY_VAR_GENDER,  GetGender(oPC));
    SetLocalString(oPlc, BODY_VAR_NAME,    GetName(oPC));
    SetLocalString(oPlc, BODY_VAR_ACCOUNT, GetPCPlayerName(oPC));

    // Reference our dummy model for later cleanup.
    SetLocalObject(oPlc, BODY_VAR_MODEL, oBody);
}

void CleanupPlayerBodies(string sCharacter, string sAccount){
    string sTag = "plc_pc_body";

    int i = 0;

    object oBody = GetObjectByTag(sTag, i);

    while(GetIsObjectValid(oBody)){
        if(GetLocalString(oBody, BODY_VAR_NAME)    == sCharacter &&
           GetLocalString(oBody, BODY_VAR_ACCOUNT) == sAccount){
            ExecuteScript("gen_destroy_self", oBody);
        }

        oBody = GetObjectByTag(sTag, ++i);
    }

    sTag = "itm_pc_body";

    i = 0;

    oBody = GetObjectByTag(sTag, i);

    while(GetIsObjectValid(oBody)){
        if(GetLocalString(oBody, BODY_VAR_NAME)    == sCharacter &&
           GetLocalString(oBody, BODY_VAR_ACCOUNT) == sAccount){
            object oPossessor = GetItemPossessor(oBody);

            if(GetIsPC(oPossessor)){
                DelayCommand(0.0, FloatingTextStringOnCreature(sCharacter + " has been revived.", oPossessor, FALSE));
                DelayCommand(3.0, FloatingTextStringOnCreature("Their body has been removed from your inventory.", oPossessor, FALSE));
            }

            ExecuteScript("gen_destroy_self", oBody);
        }

        oBody = GetObjectByTag(sTag, ++i);
    }
}

object GetPCFromPlayerName(string sCharacter, string sAccount){
    object oPC = GetFirstPC();

    while(GetIsObjectValid(oPC)){
        if(GetName(oPC) == sCharacter && GetPCPlayerName(oPC) == sAccount){
            return oPC;
        }

        oPC = GetNextPC();
    }

    return OBJECT_INVALID;
}

void DoRevivalConvAction(int nBody){
    object oPC = GetPCSpeaker();
    string sWaypoint = GetLocalString(OBJECT_SELF, "RaiseWaypoint");
    int nGold = GetGold(oPC);
    int nCost = GetLocalInt(OBJECT_SELF, "RaiseCost");

    // Failsafe.
    if(sWaypoint == "") sWaypoint = REVIVAL_WAYPOINT_TAG;

    if(nCost == 0) nCost = 750;

    object oItem = GetFirstItemInInventory(oPC);

    int nIndex = -1;

    while(GetIsObjectValid(oItem)){
        if(GetTag(oItem) == "itm_pc_body") nIndex++;

        if(nIndex == nBody){
            nCost += 100 * (GetHitDice(GetPCFromPlayerName(GetLocalString(oItem, BODY_VAR_NAME), GetLocalString(oItem, BODY_VAR_ACCOUNT))) / 2);

            if(nGold < nCost)
            {
                SendMessageToPC(oPC, "I'm sorry but we need " + IntToString(nCost) + "gold to perform this service.");
                return;
            }

            object oWaypoint = GetWaypointByTag(sWaypoint);

            RevivePlayer(GetLocalString(oItem, BODY_VAR_NAME), GetLocalString(oItem, BODY_VAR_ACCOUNT), GetLocation(oWaypoint));

            TakeGoldFromCreature(nCost, oPC, TRUE);

            return;
        }

        oItem = GetNextItemInInventory(oPC);
    }
}
