#include "engine"

#include "X0_I0_PARTYWIDE"

#include "aps_include"

#include "inc_save"

// CONSTANTS

// The amount of XP to award per faery.
const int FAERY_AWARD = 10;

// The low range time interval (in seconds) between faeries.
const float FAERY_INTERVAL = 70.0;

// The weekly cap on softcap XP award.
const int FAERY_CAP = 11500;

const int ACCOUNT_XP_CAP = 12000;

// The cap on roleplay faerie reward.
const int FAERY_RP_CAP_WEEKLY = 4150;

const int FAERY_RP_CAP_DAILY = 1000;

const int FAERY_RP_AWARD = 10;

// Maximum party size for XP award bonuses.
const int PARTY_SIZE_MAX = 5;

// The percentage each member increases XP gain by.
const float PARTY_ADJUSTMENT = 0.10;

// The XP Cap given at character creation
const int STARTING_XP_CAP = 28000;

// This is a bit of icing XP given once, on login,
// to older characters who didn't get the new
// starting cap. 12-27-2011.
const int XP_CAP_BONUS_OLD_PC = 10000;

// DECLARATION

// Sets oPC's XP cap to nXP.
void SetXPCap(object oPC, int nXP);

// Returns oPC's XP cap.
int GetXPCap(object oPC);

// Increases oPC's XP cap. If bModifyXP is true, oPC's XP will receive an
// absolute adjustment of nXP (it will ignore ECL/cap adjustments).
void ModifyXPCap(object oPC, int nXP, int bModifyXP=FALSE);

// Awards oPartyMember's party with XP for killing oCreature. All party members
// must be within fRange.
void GiveKillXP(object oPartyMember, object oCreature, float fRange=90.0);

// Gives oPC an ECL/Cap adjust amount of XP.
int GiveAdjustedXP(object oPC, int nXP);

// Checks if oPC is idle.
int GetIsIdle(object oPC);

// Sets if oPC is idle.
void SetIsIdle(object oPC, int nIdleness);

// Begins an auto-faery routine on oPC.
void AutoFaery();

// PRIVATE FUNCTION
// Do not run this from outside inc_xp.
void DoAutoFaery();

// Adjusts the XP due to the alterations in starting XP_CAP made on 12-27-2011
void DoStartingXPAdjustments(object oPC);

// For RP faery system 12-27-2011
void ModifyRoleplayXP(object oPC, int nXP);

// IMPLEMENTATION

object GetFamiliarMaster(object oPC)//Returns the master if is possessed familiar, otherwise no change
{
    if(GetAssociateType(oPC)==ASSOCIATE_TYPE_FAMILIAR)
    {
        object MyMaster=GetMaster(oPC);
        return MyMaster;
    }
    else
    {
        return oPC;
    }
}

void SetXPCap(object oPC, int nXP){
    oPC=GetFamiliarMaster(oPC);
    SetPersistentInt_player(GetName(oPC),GetPCPlayerName(oPC), "XP_CAP", nXP);
}

int GetXPCap(object oPC)
{
    oPC=GetFamiliarMaster(oPC);
    return GetPersistentInt_player(GetName(oPC),GetPCPlayerName(oPC), "XP_CAP");
}

void ModifyXPCap(object oPC, int nXP, int bModifyXP=FALSE){
    int nNew = GetXPCap(oPC) + nXP;

    if(bModifyXP) GiveXPToCreature(oPC, nXP);

    SetXPCap((oPC), nNew);

    SendMessageToPC(oPC, "Softcap Faery: combat soft cap +" + IntToString(FAERY_RP_AWARD));
}

void SetAccountXP(object oPC, int nXP){
    object oMod = GetModule();

    string sAccount = GetPCPlayerName(oPC);

    SetPersistentInt(oMod, "XP_ACCOUNT_" + sAccount, nXP);
}

int GetAccountXP(object oPC){
    object oMod = GetModule();

    string sAccount = GetPCPlayerName(oPC);

    return GetPersistentInt(oMod, "XP_ACCOUNT_" + sAccount);
}

void ModifyAccountXP(object oPC, int nXP){
    int nNew = GetAccountXP(oPC) + nXP;

    SetAccountXP(oPC, nNew);
}

void SetRoleplayXP(object oPC, int nXP) {
    SetPersistentInt_player(GetName(oPC),GetPCPlayerName(oPC), "RP_AWARD_TOTAL", nXP);
}

int GetRoleplayXP(object oPC) {
    return GetPersistentInt_player(GetName(oPC),GetPCPlayerName(oPC), "RP_AWARD_TOTAL");
}

int GetRoleplayXPDaily(object oPC) {
    return GetPersistentInt_player(GetName(oPC),GetPCPlayerName(oPC), "RP_AWARD_DAILY");
}

int GetRoleplayXPWeekly(object oPC) {
    return GetPersistentInt_player(GetName(oPC),GetPCPlayerName(oPC), "RP_AWARD_WEEKLY");
}

void GiveKillXP(object oKiller, object oCreature, float fRange=90.0){
    if(!GetIsObjectValid(oKiller) || GetIsDM(oKiller)) return;

    if(GetIsPC(GetTrapCreator(oKiller))) oKiller = GetTrapCreator(oKiller);

    // The party's HD for purposes of XP calculation.
    int nPartyHD = FloatToInt((GetHitDice(GetFactionStrongestMember(oKiller, TRUE)) * 0.75) + (GetHitDice(GetFactionWeakestMember(oKiller, TRUE)) * 0.25));

    int nPartySize = GetNumberPartyMembers(oKiller);

    if(nPartySize > PARTY_SIZE_MAX) nPartySize = PARTY_SIZE_MAX;

    float fAdjustment = 1 + (nPartySize * PARTY_ADJUSTMENT);

    int nAward = FloatToInt(pow((GetChallengeRating(oCreature) + 4) / nPartyHD, 2.0) * 50.0 * fAdjustment);

    if(nAward > 125) nAward = 125;

    object oPartyMember = GetFirstFactionMember(oKiller, TRUE);

    while(GetIsObjectValid(oPartyMember))
    {
        //Summons and pets do not count. - 30/05/2012 Hardcore UFO
        if(GetDistanceBetween(oKiller, oPartyMember) < fRange && GetArea(oPartyMember) == GetArea(oKiller)
        && GetStringLeft(GetTag(oPartyMember), 4) != "SMN_" && GetStringLeft(GetTag(oPartyMember), 4) != "PET_")
        {
            if(GetHitDice(oPartyMember) - GetHitDice(oCreature) < 8)
            {
                GiveAdjustedXP(oPartyMember, nAward);
            }
        }

        oPartyMember = GetNextFactionMember(oPartyMember, TRUE);
    }
}

int GiveAdjustedXP(object oPC, int nAward){
    int nXP = GetXP(oPC) - GetRoleplayXP(oPC); // We don't factor the RP faery into combat - 12-27-2011 - Invictus
    int nCap = GetXPCap(oPC);
    float fAdjustment;

    // When a player goes over their cap the adjustment has no limit.
    if(nXP > nCap){
        fAdjustment = 1 + (abs(nXP - nCap) * abs(nXP - nCap))/3000000.0;
        nAward = FloatToInt(nAward / fAdjustment);
    } else if(nXP < nCap){
        fAdjustment = 1 + sqrt(IntToFloat(abs(nXP - nCap)))/80.0;

        //if(fAdjustment > 2.00) fAdjustment = 2.00;//Removed the cap on softcap bonus 3/15/2012

        nAward = FloatToInt(nAward * fAdjustment);
    }

    if(nAward < 1) nAward = 1;

    GiveXPToCreature(oPC, nAward);
    return nAward;
}

void ModifyRoleplayXP(object oPC, int nXP) {
    int nNew = GetRoleplayXP(oPC) + nXP;
    SetRoleplayXP(oPC, nNew);
    SendMessageToPC(oPC, "XP faery: " + IntToString(FAERY_AWARD) + " combat softcap, and...");
    if (GetPersistentInt_player(GetName(oPC),GetPCPlayerName(oPC), "XP_CAP")>50)
    {//This is part of the familiar fix: for whatever reason getting and setting variables on a possessed creature is hard, so instead we just disable faeries when the familiar is possessed
        nXP=GiveAdjustedXP(oPC, nXP);//Changed to incorporate the softcap in faeries 3/16/2012
        //nNew = GetRoleplayXP(oPC) + nXP;
        //SetRoleplayXP(oPC, nNew);
    }
}

int GetIsIdle(object oPC){
    // The FAERY_IDLE is our developer accessible toggle. We also check to see
    // if the character has moved since their last faery. Furthermore, anyone
    // within the out-of-character areas is considered idle no matter what.
    return (GetLocalInt(oPC, "FAERY_IDLE") &&
           GetLocalLocation(oPC, "FAERY_IDLE_LOCATION") == GetLocation(oPC)) ||
           GetTag(GetArea(oPC)) == "LOCATION_INVALID";
}

void SetIsIdle(object oPC, int nIdleness){
    SetLocalInt(oPC, "FAERY_IDLE", nIdleness);
}

void AutoFaery(){
    DelayCommand(FAERY_INTERVAL, DoAutoFaery());
}

void DoAutoFaery(){
    object oPC = GetFirstPC();

    int nDailyAward;
    int nWeeklyAward;

    while(GetIsObjectValid(oPC)){
        if(!GetIsDM(oPC)){
            if(GetStringLeft(GetTag(GetArea(oPC)), 4) != "ooc_"){
                nWeeklyAward = GetPersistentInt_player(GetName(oPC),GetPCPlayerName(oPC), "FAERY_AWARD");

                // Check we're below our daily cap and that we're not idling.
                if(nWeeklyAward < FAERY_CAP && !GetIsIdle(oPC)){
                    // Awards XP to the DM's account or the player's character.
                    ModifyXPCap((oPC), FAERY_AWARD);

                    // Updates their allowance.
                    SetPersistentInt_player(GetName(oPC),GetPCPlayerName(oPC), "FAERY_AWARD", nWeeklyAward + FAERY_AWARD);

                    SavePersistentHitPoints((oPC));
                }

                // RP XP Faery. Invictus 12-27-2011

                nDailyAward = GetPersistentInt_player(GetName(oPC),GetPCPlayerName(oPC), "RP_AWARD_DAILY");
                nWeeklyAward = GetPersistentInt_player(GetName(oPC),GetPCPlayerName(oPC), "RP_AWARD_WEEKLY");

                if(nDailyAward < FAERY_RP_CAP_DAILY && nWeeklyAward < FAERY_RP_CAP_WEEKLY && !GetIsIdle(oPC)) {
                    ModifyRoleplayXP(oPC, FAERY_RP_AWARD);

                    SetPersistentInt_player(GetName(oPC),GetPCPlayerName(oPC), "RP_AWARD_DAILY", nDailyAward + FAERY_RP_AWARD);
                    SetPersistentInt_player(GetName(oPC),GetPCPlayerName(oPC), "RP_AWARD_WEEKLY", nWeeklyAward + FAERY_RP_AWARD);

                    SavePersistentHitPoints(oPC);
                }
            }
        } else {
            if(GetAccountXP((oPC)) < ACCOUNT_XP_CAP && !GetIsIdle(oPC)){
                ModifyAccountXP((oPC), FAERY_AWARD);
            }
        }

        // Begin idle checking again.
        SetIsIdle(oPC, TRUE);

        // Store a local to check for idleness.
        SetLocalLocation((oPC), "FAERY_IDLE_LOCATION", GetLocation((oPC)));

        oPC = GetNextPC();
    }

    ExportAllCharacters();

    DelayCommand(FAERY_INTERVAL, DoAutoFaery());
}

void DoStartingXPAdjustments(object oPC) {

    if(GetPersistentInt_player(GetName(oPC),GetPCPlayerName(oPC), "XP_CAP_ADJUSTED")) return;

    if(GetXPCap(oPC) == 0) {
        // Do nothing but say they've been adjusted, as they have not gone through character creation
    } else if(GetXPCap(oPC) + XP_CAP_BONUS_OLD_PC < STARTING_XP_CAP) {
        SetXPCap(oPC, STARTING_XP_CAP);
    } else {
        ModifyXPCap(oPC, XP_CAP_BONUS_OLD_PC);
    }

    SetPersistentInt_player(GetName(oPC),GetPCPlayerName(oPC), "XP_CAP_ADJUSTED", 1);
}
