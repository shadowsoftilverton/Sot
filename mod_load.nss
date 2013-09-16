#include "engine"

//::///////////////////////////////////////////////
//:: Example XP2 OnLoad Script
//:: x2_mod_def_load
//:: (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Put into: OnModuleLoad Event

    This example script demonstrates how to tweak the
    behavior of several subsystems in your module.

    For more information, please check x2_inc_switches
    which holds definitions for several variables that
    can be set on modules, creatures, doors or waypoints
    to change the default behavior of Bioware scripts.

    Warning:
    Using some of these switches may change your games
    balancing and may introduce bugs or instabilities. We
    recommend that you only use these switches if you
    know what you are doing. Consider these features
    unsupported!

    Please do NOT report any bugs you experience while
    these switches have been changed from their default
    positions.

    Make sure you visit the forums at nwn.bioware.com
    to find out more about these scripts.

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-07-16
//:://////////////////////////////////////////////
//:: Modified By: Ashton Shapcott
//:: Modified On: Oct. 2, 2010
//:://////////////////////////////////////////////
//:: Modified By: Stephen "Invictus"
//:: Modified On: Oct. 28, 2011
//:://////////////////////////////////////////////

#include "x2_inc_switches"
#include "x2_inc_restsys"

#include "aps_include"
#include "nwnx_dmactions"
#include "nwnx_events"
#include "nwnx_weapons"
#include "nwnx_system"
#include "nwnx_defenses"
#include "nwnx_chat"

#include "inc_logs"
#include "inc_save"
#include "inc_spellbook"
#include "inc_world"
#include "inc_xp"
#include "inc_areas"
#include "inc_crossserver"
#include "ave_inc_rogue"
#include "ave_d2_inc"

void InitializeBiowareSwitches(){
    // * Setting the switch below will enable a seperate Use Magic Device Skillcheck for
    // * rogues when playing on Hardcore+ difficulty. This only applies to scrolls
    SetModuleSwitch (MODULE_SWITCH_ENABLE_UMD_SCROLLS, TRUE);

    // * Activating the switch below will make AOE spells hurt neutral NPCS by default
    // SetModuleSwitch (MODULE_SWITCH_AOE_HURT_NEUTRAL_NPCS, TRUE);

   // * AI: Activating the switch below will make the creaures using the WalkWaypoint function
   // * able to walk across areas
   SetModuleSwitch (MODULE_SWITCH_ENABLE_CROSSAREA_WALKWAYPOINTS, TRUE);

   // * Spells: Activating the switch below will make the Glyph of Warding spell behave differently:
   // * The visual glyph will disappear after 6 seconds, making them impossible to spot
   // SetModuleSwitch (MODULE_SWITCH_ENABLE_INVISIBLE_GLYPH_OF_WARDING, TRUE);

   // * Craft Feats: Want 50 charges on a newly created wand? We found this unbalancing,
   // * but since it is described this way in the book, here is the switch to get it back...
   // SetModuleSwitch (MODULE_SWITCH_ENABLE_CRAFT_WAND_50_CHARGES, TRUE);

   // * Craft Feats: Use this to disable Item Creation Feats if you do not want
   // * them in your module
   // SetModuleSwitch (MODULE_SWITCH_DISABLE_ITEM_CREATION_FEATS, TRUE);

   // * Palemaster: Deathless master touch in PnP only affects creatures up to a certain size.
   // * We do not support this check for balancing reasons, but you can still activate it...
   // SetModuleSwitch (MODULE_SWITCH_SPELL_CORERULES_DMASTERTOUCH, TRUE);

   // * Epic Spellcasting: Some Epic spells feed on the liveforce of the caster. However this
   // * did not fit into NWNs spell system and was confusing, so we took it out...
   // SetModuleSwitch (MODULE_SWITCH_EPIC_SPELLS_HURT_CASTER, TRUE);

   // * Epic Spellcasting: Some Epic spells feed on the liveforce of the caster. However this
   // * did not fit into NWNs spell system and was confusing, so we took it out...
   // SetModuleSwitch (MODULE_SWITCH_RESTRICT_USE_POISON_TO_FEAT, TRUE);

    // * Spellcasting: Some people don't like caster's abusing expertise to raise their AC
    // * Uncommenting this line will drop expertise mode whenever a spell is cast by a player
    SetModuleSwitch (MODULE_VAR_AI_STOP_EXPERTISE_ABUSE, TRUE);

    // * Item Event Scripts: The game's default event scripts allow routing of all item related events
    // * into a single file, based on the tag of that item. If an item's tag is "test", it will fire a
    // * script called "test" when an item based event (equip, unequip, acquire, unacquire, activate,...)
    // * is triggered. Check "x2_it_example.nss" for an example.
    // * This feature is disabled by default.
   SetModuleSwitch (MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS, TRUE);
}

void DoSetCustomMonkWeapons()
{
    SetWeaponIsMonkWeapon(BASE_ITEM_KATANA,15);
    SetWeaponIsMonkWeapon(BASE_ITEM_QUARTERSTAFF,10);
    SetWeaponIsMonkWeapon(BASE_ITEM_SHURIKEN,5);
}

void InitializeNWNX(){
    //Init NWNX2
    SetLocalString(GetModule(), "NWNX!INIT", "1");
    GetLocalObject(GetModule(), "NWNX!INIT");

    // APS //

    SQLInit();

    // Chat //
    NWNXChat_Init();

    // DM Actions
    SetDMActionScript(DM_ACTION_CREATE_ITEM_ON_AREA,    "dm_act_crtonarea");
    SetDMActionScript(DM_ACTION_CREATE_ITEM_ON_OBJECT,  "dm_act_crtonobj");
    SetDMActionScript(DM_ACTION_CREATE_PLACEABLE,       "dm_act_crtplc");
    SetDMActionScript(DM_ACTION_GIVE_GOLD,              "dm_act_give_gold");
    SetDMActionScript(DM_ACTION_GIVE_LEVEL,             "dm_act_give_lvl");
    SetDMActionScript(DM_ACTION_GIVE_XP,                "dm_act_give_xp");
    SetDMActionScript(DM_ACTION_HEAL_CREATURE,          "dm_act_heal");
    SetDMActionScript(DM_ACTION_MESSAGE_TYPE,           "dm_act_msg_type");
    SetDMActionScript(DM_ACTION_REST_CREATURE,          "dm_act_rest");
    SetDMActionScript(DM_ACTION_RUNSCRIPT,              "dm_act_runscript");
    SetDMActionScript(DM_ACTION_SPAWN_CREATURE,         "dm_act_spawn");
    SetDMActionScript(DM_ACTION_TOGGLE_IMMORTALITY,     "dm_act_immort");
    SetDMActionScript(DM_ACTION_TOGGLE_INVULNERABILITY, "dm_act_invuln");

    // NWNX EVENTS //

    SetGlobalEventHandler(EVENT_TYPE_ATTACK,           "mod_attack");
    SetGlobalEventHandler(EVENT_TYPE_CAST_SPELL,       "mod_castspell");
    SetGlobalEventHandler(EVENT_TYPE_EXAMINE,          "mod_examine");
    SetGlobalEventHandler(EVENT_TYPE_PICKPOCKET,       "mod_pickpocket");
    SetGlobalEventHandler(EVENT_TYPE_POSSESS_FAMILIAR, "mod_possfam");
    SetGlobalEventHandler(EVENT_TYPE_QUICKCHAT,        "mod_quickchat");
    SetGlobalEventHandler(EVENT_TYPE_SAVE_CHAR,        "mod_savechar");
    SetGlobalEventHandler(EVENT_TYPE_TOGGLE_MODE,      "mod_togglemode");
    SetGlobalEventHandler(EVENT_TYPE_TOGGLE_PAUSE,     "mod_togglepause");
    //SetGlobalEventHandler(EVENT_TYPE_USE_FEAT,         "mod_usefeat");
    SetGlobalEventHandler(EVENT_TYPE_USE_ITEM,         "mod_useitem");
    //SetGlobalEventHandler(EVENT_TYPE_USE_SKILL,        "mod_useskill");

    // NWNX WEAPONS //

    DoSetCustomMonkWeapons();

    SetWeaponOption(NWNX_WEAPONS_OPT_POWCRIT_CONF_BONUS,2);
    SetWeaponOption(NWNX_WEAPONS_OPT_SUPCRIT_CONF_BONUS,4);
    SetWeaponOption(NWNX_WEAPONS_OPT_GRTFOCUS_AB_BONUS,2);
    SetWeaponOption(NWNX_WEAPONS_OPT_DEVCRIT_DISABLE_ALL,1);
    SetWeaponOption(NWNX_WEAPONS_OPT_DEVCRIT_MULT_BONUS,1);
    SetWeaponOption(NWNX_WEAPONS_OPT_DEVCRIT_MULT_STACK,1);
    SetWeaponOption(NWNX_WEAPONS_OPT_OVERCRIT_RANGE_BONUS,1);
    SetWeaponOption(NWNX_WEAPONS_OPT_OVERCRIT_RANGE_STACK,1);
    SetWeaponAbilityFeat(BASE_ITEM_SHORTSWORD,ABILITY_INTELLIGENCE,CANNY_CUTTER);
    SetWeaponAbilityFeat(BASE_ITEM_DAGGER,ABILITY_INTELLIGENCE,CANNY_CUTTER);
    SetWeaponAbilityFeat(BASE_ITEM_DART,ABILITY_INTELLIGENCE,CANNY_CUTTER);

    SetDefenseOption(NWNX_DEFENSES_OPT_SNEAKATT_IGNORE_CRIT_IMM,TRUE);

    int i, nHasWepFeats, nFeat;

    for(i=0;i<255;i++){
        string sHasWepFeats = Get2DAString("baseitem_feats", "HasWepFeat", i);

        if(sHasWepFeats=="1"){
            // Weapon Focus
            nFeat = Get2DAInt("baseitem_feats", "WepFocus", i);
            //if(nFeat != -1) SetWeaponFocusFeat(i, nFeat);
            //else WriteTimestampedLogEntry("MODULE :: LOAD :: ERROR: Weapon Feat Associations Error - Weapon Focus.");

            // Improved Weapon Focus
            nFeat = Get2DAInt("baseitem_feats", "ImpWepFocus", i);
            //if(nFeat!=-1)

            // Greater Weapon Focus
            nFeat = StringToInt(Get2DAString("baseitem_feats", "GrWepFocus", i));
            if(nFeat != -1) SetWeaponGreaterFocusFeat(i, nFeat);
            else WriteTimestampedLogEntry("MODULE :: LOAD :: ERROR: Weapon Feat Associations Error - Greater Weapon Focus.");

            // Epic Weapon Focus
            nFeat = Get2DAInt("baseitem_feats", "EpWepFocus", i);
            //if(nFeat!=-1)

            // Weapon Specialization
            nFeat = Get2DAInt("baseitem_feats", "WepSpec", i);
            //if(nFeat!=-1)

            // Improved Weapon Specialization
            nFeat = Get2DAInt("baseitem_feats", "ImpWepSpec", i);
            //if(nFeat!=-1)

            // Greater Weapon Specialization
            nFeat = Get2DAInt("baseitem_feats", "GrWepSpec", i);
            //if(nFeat!=-1)

            // Epic Weapon Specialization
            nFeat = Get2DAInt("baseitem_feats", "EpWepSpec", i);
            //if(nFeat!=-1)

            // Power Critical
            nFeat = StringToInt(Get2DAString("baseitem_feats", "PowCrit", i));
            if(nFeat != 0) SetWeaponPowerCriticalFeat(i, nFeat);
            else WriteTimestampedLogEntry("MODULE :: LOAD :: ERROR: Weapon Feat Associations Error - Power Critical.");

            // Improved Power Critical
            nFeat = StringToInt(Get2DAString("baseitem_feats", "ImpPowCrit", i));
            SetWeaponSuperiorCriticalFeat(i, nFeat);
            //if(nFeat != -1)

            // Greater Power Critical
            nFeat = Get2DAInt("baseitem_feats", "GrPowerCrit", i);
            //if(nFeat!=-1)

            // Epic Power Critical
            nFeat = Get2DAInt("baseitem_feats", "EpPowerCrit", i);
            //if(nFeat!=-1)

        }
    }
}

void main()
{
    WriteLog("Initializing server state.", LOG_TYPE_MODULE);

    // Handles the default Bioware switches.
    InitializeBiowareSwitches();

    // Initializes NWNX.
    InitializeNWNX();

    // Resets necessary database tables
    ResetLoggedInTable();
    ResetMessagesTable();

    // Initializes server-specific systems.
    InitializeWeather();
    InitializeTime();
    InitializeSaveSystem();
    InitializeInstancing();

    AutoFaery();

    int nOldTMI = GetTMILimit();
    int nNewTMI = nOldTMI * 4;

    WriteLog("Switching TMI from " + IntToString(nOldTMI/1024) + "KB to " + IntToString(nNewTMI/1024) + "KB.", LOG_TYPE_MODULE);

    SetTMILimit(nNewTMI);
    SetMaxHenchmen(10);

    // Sets the XP gain to 0.
    SetModuleXPScale(0);

    DelayCommand(0.0, CacheSpellbooks());

    WriteLog("Initialization complete.", LOG_TYPE_MODULE);

    SetModuleOverrideSpellscript("mod_castspell");
    InitD2();//Initializes the labyrinth dungeon (ave_d2)
}
