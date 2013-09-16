#include "engine"

//::///////////////////////////////////////////////
//:: Default On Enter for Module
//:: x3_mod_def_enter
//:: Copyright (c) 2008 Bioware Corp.
//:://////////////////////////////////////////////
/*
     This script adds the horse menus to the PCs.
*/
//:://////////////////////////////////////////////
//:: Created By: Deva B. Winblood
//:: Created On: Dec 30th, 2007
//:: Last Update: April 21th, 2008
//:://////////////////////////////////////////////

#include "ave_inc_duration"
#include "nw_i0_spells"
#include "x3_inc_horse"
#include "x2_inc_itemprop"
#include "inc_arrays"
#include "inc_classes"
#include "inc_death"
#include "inc_save"
#include "inc_mod"
#include "inc_map_pins"
#include "inc_spellbook"
#include "inc_iss"
#include "inc_xp"
#include "inc_ilr"
#include "inc_barbarian"
#include "inc_camp"
#include "inc_touching"
#include "inc_crossserver"
#include "nwnx_funcs"
#include "ave_inc_rogue"
#include "nwnx_structs"
#include "nwnx_chat"
#include "x3_inc_skin"
#include "ave_inc_hier"
#include "ave_inc_event"
#include "ave_d2_inc"
#include "inc_horses"

void GiveBardRangerSkills(object oPC);

// Bioware standard horse system.
void DoHorseSystem(object oPC){
    // HORSE SYSTEM

    if ((GetIsPC(oPC)||GetIsDM(oPC))&&!GetHasFeat(FEAT_HORSE_MENU,oPC))
    { // add horse menu
        HorseAddHorseMenu(oPC);
        if (GetLocalInt(GetModule(),"X3_ENABLE_MOUNT_DB"))
        { // restore PC horse status from database
            DelayCommand(2.0,HorseReloadFromDatabase(oPC,X3_HORSE_DATABASE));
        } // restore PC horse status from database
    } // add horse menu
    if (GetIsPC(oPC))
    { // more details
        // restore appearance in case you export your character in mounted form, etc.
        if (!GetSkinInt(oPC,"bX3_IS_MOUNTED")) HorseIfNotDefaultAppearanceChange(oPC);
        // pre-cache horse animations for player as attaching a tail to the model
        HorsePreloadAnimations(oPC);
        DelayCommand(3.0,HorseRestoreHenchmenLocations(oPC));
    } // more details
}

// Stores any necessary local data on the player.
void DoDataStorage(object oPC){
    string sAccount = GetPCPlayerName(oPC);
    string sCDKey   = GetPCPublicCDKey(oPC);

    SetLocalString(oPC, "PC_ACCOUNT", sAccount);
    SetLocalString(oPC, "PC_CD_KEY", sCDKey);
}

// For any journal entries that need to be handled.
void DoJournalEntries(object oPC){
    AddJournalQuestEntry("jr_servinfo", 1, oPC);
    AddJournalQuestEntry("jr_servrules", 1, oPC);
    AddJournalQuestEntry("jr_utilitywand", 1, oPC);
}

// Does banning.
void DoBanAutoRemove(object oPC){
    string sCD = GetPCPublicCDKey(oPC);
    string sIP = GetPCIPAddress(oPC);

    if(GetPersistentInt(GetModule(), sCD + "_BANNED", SQL_TABLE_ACCOUNTS) ||
       GetPersistentInt(GetModule(), sIP + "_BANNED", SQL_TABLE_ACCOUNTS))
    {
        BootPC(oPC);
    }
}

// Function to handle the merging of TWF and Ambidexterity
void DoConfigureDualWieldFeat(object oPC) {
    if(!GetIsPC(oPC) || GetIsDM(oPC)) return;

    if(GetPersistentInt(oPC, "DUAL_WIELD_CONFIGURED")) return;

    if(GetKnowsFeat(FEAT_AMBIDEXTERITY, oPC)) {
        if(GetKnowsFeat(FEAT_TWO_WEAPON_FIGHTING, oPC)) {
            // Inform the PC to get a Leto
            SendMessageToPC(oPC, "The Ambidexterity and Two Weapon Fighting feats have been linked on SoT."    +
                                 "If you take one, you are given the other automatically after re-logging."    +
                                 "As your PC has both of these feats, please post a Leto request on the"       +
                                 "forum to have an additional, appropriate feat of your choice added for free.");
        } else {
            AddKnownFeat(oPC, FEAT_TWO_WEAPON_FIGHTING);

            SetPersistentInt(oPC, "DUAL_WIELD_CONFIGURED", 1);
        }
    } else if(GetKnowsFeat(FEAT_TWO_WEAPON_FIGHTING, oPC)) {
        if(GetKnowsFeat(FEAT_AMBIDEXTERITY, oPC)) {
            // Inform the PC to get a Leto
            SendMessageToPC(oPC, "The Ambidexterity and Two Weapon Fighting feats have been linked on SoT."    +
                                 "If you take one, you are given the other automatically after re-logging."    +
                                 "As your PC has both of these feats, please post a Leto request on the"       +
                                 "forum to have an additional, appropriate feat of your choice added for free.");
        } else {
            AddKnownFeat(oPC, FEAT_AMBIDEXTERITY);

            SetPersistentInt(oPC, "DUAL_WIELD_CONFIGURED", 1);
        }
    }
}

// Function that sets the ILR variable of all items in a PC's inventory
// to the tier corresponding to the PC's current level.
void DoSetExistingILR(object oPC) {
    if(!GetIsPC(oPC) || GetIsDM(oPC)) return;

    if(GetPersistentInt(oPC, "ILR_SETUP_DONE")) return;

    object oItem = GetFirstItemInInventory(oPC);

    while(GetIsObjectValid(oItem)) {
        DoAddOwnerLevelToItem(oItem, oPC);

        oItem = GetNextItemInInventory(oPC);
    }

    SetPersistentInt(oPC, "ILR_SETUP_DONE", 1);
}

void TutorTimerIncrement(string sName, string sPlayerName)
{
    int nDelay=GetPersistentInt_player(sName,sPlayerName,"ave_tutor_delay");
    if(nDelay<TUTOR_DELAY_COUNT)
    {
        SetPersistentInt_player(sName,sPlayerName,"ave_tutor_delay",nDelay+1);
    }
    DelayCommand(TurnsToSeconds(TUTOR_DELAY_MINUTES),TutorTimerIncrement(sName,sPlayerName));
}

void CheckAndGiveCasterFeats(object oPC)
{
    if(GetLevelByClass(CLASS_TYPE_WIZARD, oPC)>0)
    {
        //SetPersistentInt(oPC,"ave_tutor_delay",0);
        if(GetLocalInt(GetModule(),"avetimerstarted"+GetPCPublicCDKey(oPC)+GetName(oPC))==0)
        {
            DelayCommand(TurnsToSeconds(TUTOR_DELAY_MINUTES),TutorTimerIncrement(GetName(oPC),GetPCPlayerName(oPC)));
            SetLocalInt(GetModule(),"avetimerstarted"+GetPCPublicCDKey(oPC)+GetName(oPC),1);
        }
        //if((0==GetHasFeat(1384,oPC))||(0==GetHasFeat(1385,oPC)))
        //{
            AddKnownFeat(oPC,1384,2);
            AddKnownFeat(oPC,1385,2);
            SendMessageToPC(oPC,"You have been given the new tutoring feats. "+
            "These feats are available to all wizards and intended to replace "+
            "scribing as a means for wizards to exchange spells.");
        //}
    }
    int iCasterTotal=GetLevelByClass(CLASS_TYPE_WIZARD, oPC)+
    GetLevelByClass(CLASS_TYPE_SORCERER, oPC)+GetLevelByClass(CLASS_TYPE_BARD, oPC)+
    GetLevelByClass(CLASS_TYPE_DRUID, oPC)+GetLevelByClass(CLASS_TYPE_CLERIC, oPC)+
    GetLevelByClass(CLASS_TYPE_RANGER, oPC)+GetLevelByClass(CLASS_TYPE_PALADIN, oPC);
    if(iCasterTotal>0)
    {
        if((0==GetHasFeat(1383,oPC)))
        {
           AddKnownFeat(oPC,1383,2);
           SendMessageToPC(oPC,"You have been given the new active duration "+
           "radial menu option. This is used in conjunction with active "+
           "duration spells - simply cast a designated active duration spell " +
           "once (if a spell is active duration, it will be noted in the " +
           "spell description), then use this radial menu option to repeat " +
           "the casting.");
        }
    }
}

void CheckBardRangerSkills(object oPC)
{
   int iMyFirstClass=GetClassByPosition(1,oPC);
   if(iMyFirstClass==CLASS_TYPE_RANGER||iMyFirstClass==CLASS_TYPE_BARD)
   {
    if((GetPersistentInt(oPC,"skillbr")==0))
    {
        SetPersistentInt(oPC,"skillbr",1);
        SendMessageToPC(oPC,"Your level 1 bard or ranger skills have not been set...");
        DelayCommand(8.0,GiveBardRangerSkills(oPC));
    }
   }
}

void GiveBardRangerSkills(object oPC)
{
    if((GetPersistentInt(oPC,"skillbr")==1))
    {
       SendMessageToPC(oPC,"You have given 8 skill points to spend on your next level up.");
       SetPersistentInt(oPC,"skillbr",2);
       ModifyPCSkillPoints(oPC,8);
    }
}

void DoForecastTimer(object oPC)
{
    SetLocalInt(oPC,"ave_hasforecast",1);
    DelayCommand(HoursToSeconds(1),SetLocalInt(oPC,"ave_hasforecast",0));
}

void main()
{
    object oPC = GetEnteringObject();
    if(GetIsDM(oPC)&GetPCPlayerName(oPC)=="Theavenger") CreateItemOnObject("catapult001",oPC);

    NWNXChat_PCEnter(oPC);
    SetCurrentServer(oPC, GetLocalInt(GetModule(), "SYS_INSTANCE_TYPE"));

    CheckBardRangerSkills(oPC);

    CheckAndGiveCasterFeats(oPC);

    DecrementRemainingFeatUses(oPC,ACTIVE_DURATION_FEAT);
    SetLocalInt(oPC,"ave_duration",-1);
    SetLocalInt(oPC,"ave_demonstrate",0);

    // Auto-boots banned PCs.
    DoBanAutoRemove(oPC);
    DoCheckAndRemindBonusRageFeats(oPC);//Checks for bonus rage feats, and nags the player to select one
    DoHorseSystem(oPC);
    EnableTouching(oPC);
    DoDataStorage(oPC);
    DoJournalEntries(oPC);

    ReconfigureFeats(oPC, FALSE);
    ReconfigureSkills(oPC, FALSE);

    EnablePrestigeClasses(oPC);

    //GetMapPinsFromDB(oPC);

    DoCheckDruidPolymorph(oPC);
    DoCheckBarbarianRage(oPC);

    DoISSVerification(oPC);

    AddPersistentSpellsToSpellbook(oPC);

    RestorePersistentHitPoints(oPC);

    DoStartingXPAdjustments(oPC);

    DoConfigureDualWieldFeat(oPC);

    DoSetExistingILR(oPC);

    SaveCharacter(oPC);

    CleanRevivedCorpses(oPC);

    DoCampTimer(oPC);
    DoCampRestTimer(oPC);

    DoForecastTimer(oPC);

    DoRogueStuff(oPC);

    if(GetLevelByClass(50,oPC)>0) DoHierophantPassives(oPC);

    if(GetHasFeat(1382,oPC)) DoEpicSelfConceal(oPC);

    if(GetLevelByClass(CLASS_TYPE_BARD,oPC)>1) DoBardWeaponProf(oPC);

    DoFeatHPBonus(oPC);

    DoMiscFeatBonuses(oPC);

    if(GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE,oPC)>1) DoBloodlineDisciple(oPC);

    ClearPermanentFeatProperties(oPC);
    ApplyPermanentFeatProperties(oPC);

 //   HorseWidgetRemovalCheck(oPC); //If active horse is dead, destroy widget.

    AveD2Leave(oPC);//Checks to see if oPC needs to be teleported out of AveD2 (labyrinth dungeon)
}
