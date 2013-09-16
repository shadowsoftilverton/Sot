#include "engine"

#include "inc_appearance"
#include "inc_areas"

#include "inc_loot_names"
#include "inc_loot_props"

#include "inc_ilr"

#include "x3_inc_string"
#include "ave_inc_rogue"

#include "inc_debug"


//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
//:: Loot is generated from a template item with a varying appearance. This is
//:: done because randomizing appearance tends to create rubbish. The item then
//:: has properties applied to it, which also suggest descriptors for the name
//:: of the weapon as local variables.
//::
//:: Properties are randomized based entirely on item level. Item level ranges
//:: between 0 - 5, with 0 being mundane and 5 being the highest level. Right
//:: now there's no bias as your level progresses -- you can still have really
//:: terrible secondary properties, but at least a higher level character means
//:: you get more item properties (and most likely a better item!).
//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

const int DEBUG_LEVEL = 0;

//::////////////////////////////////////////////////////////////////////////:://
//:: CONSTANTS                                                              :://
//::////////////////////////////////////////////////////////////////////////:://

const string LOOT_STORAGE = "server_loot_storage";

// LOOT_DEFAULT_*

const int LOOT_DEFAULT_AMOUNT_MIN = 0;
const int LOOT_DEFAULT_AMOUNT_MAX = 3;

// LOOT_VAR_*

const string LOOT_VAR_RESET_TIME = "loot_reset_time";
const string LOOT_VAR_NO_SPAWN = "loot_no_spawn";

const string LOOT_VAR_LEVEL_MAX = "loot_level_max";
const string LOOT_VAR_LEVEL_MIN = "loot_level_min";

const string LOOT_VAR_CUSTOM_AMOUNT = "loot_custom_amount";

const string LOOT_VAR_AMOUNT_MAX = "loot_amount_max";
const string LOOT_VAR_AMOUNT_MIN = "loot_amount_min";

const string LOOT_VAR_CUSTOM_WEIGHT = "loot_custom_weight";

const string LOOT_VAR_WEIGHT_GOLD    = "loot_weight_gold";

const string LOOT_VAR_WEIGHT_MELEE   = "loot_weight_melee";
const string LOOT_VAR_WEIGHT_RANGED  = "loot_weight_ranged";
const string LOOT_VAR_WEIGHT_AMMO    = "loot_weight_ammo";

const string LOOT_VAR_WEIGHT_HELM    = "loot_weight_helm";
const string LOOT_VAR_WEIGHT_ARMOR   = "loot_weight_armor";
const string LOOT_VAR_WEIGHT_SHIELD  = "loot_weight_shield";

const string LOOT_VAR_WEIGHT_SCROLL  = "loot_weight_scroll";
const string LOOT_VAR_WEIGHT_GEM     = "loot_weight_gem";
const string LOOT_VAR_WEIGHT_POTION  = "loot_weight_potion";

const string LOOT_VAR_WEIGHT_WAND    = "loot_weight_wand";
const string LOOT_VAR_WEIGHT_ROD     = "loot_weight_rod";
const string LOOT_VAR_WEIGHT_STAFF   = "loot_weight_staff";

const string LOOT_VAR_WEIGHT_AMULET  = "loot_weight_amulet";
const string LOOT_VAR_WEIGHT_BELT    = "loot_weight_belt";
const string LOOT_VAR_WEIGHT_BOOTS   = "loot_weight_boots";
const string LOOT_VAR_WEIGHT_BRACERS = "loot_weight_bracers";
const string LOOT_VAR_WEIGHT_CLOAK   = "loot_weight_cloak";
const string LOOT_VAR_WEIGHT_RING    = "loot_weight_ring";
const string LOOT_VAR_WEIGHT_GLOVES  = "loot_weight_gloves";
const string LOOT_VAR_WEIGHT_TRAP    = "loot_weight_trap";
const string LOOT_VAR_WEIGHT_POISON  = "loot_weight_poison";
const string LOOT_VAR_WEIGHT_REAGENT = "loot_weight_reagent";

// LOOT_CHANCE_*
// ================
// Percentile chance any given type of loot appears. Remaining chance is chance
// for mundane equipment.

const int LOOT_CHANCE_CURSED      = 1;
const int LOOT_CHANCE_MAGIC       = 5;
const int LOOT_CHANCE_DAMAGED     = 10;
const int LOOT_CHANCE_EXCEPTIONAL = 10;

// The chance that the chest gets an item that's at the "max level" for the
// looter. So if a chest is marked +4 there'll only acutally be a 10% chance
// per item that it'll have a +4 item in it.
const int LOOT_CHANCE_MAX_LEVEL = 10;

// BP_*
// ================
// All of the relevant information on where base blueprints can be found.

const string BP_AMULET_NAME = "loot_amulet";

const string BP_BELT_NAME = "loot_belt";

const string BP_BOOTS_NAME = "loot_boots_";

const string BP_BRACERS_NAME = "loot_bracers";

const string BP_CLOAK_NAME = "loot_cloak";

const string BP_RING_NAME = "loot_ring";

const string BP_HELM_NAME = "loot_helm";

const string BP_GLOVES_NAME = "loot_gloves";

// BP_SHIELD_*
const string BP_SHIELD_S_NAME = "loot_shlds";

const string BP_SHIELD_L_NAME = "loot_shldl";

const string BP_SHIELD_T_NAME = "loot_shldt";

//::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

const string BP_ROD_NAME = "loot_rod_";
const int BP_ROD_COUNT = 0;

const string BP_STAFF_NAME = "loot_staff_";
const int BP_STAFF_COUNT = 0;

const string BP_WAND_NAME = "loot_wand_";
const int BP_WAND_COUNT = 0;

// BP_ARMOR_*
const string BP_ARMOR_0_NAME = "loot_arm0_";
const int BP_ARMOR_0_COUNT = 7;

const string BP_ARMOR_1_NAME = "loot_arm1_";
const int BP_ARMOR_1_COUNT = 0;

const string BP_ARMOR_2_NAME = "loot_arm2_";
const int BP_ARMOR_2_COUNT = 0;

const string BP_ARMOR_3_NAME = "loot_arm3_";
const int BP_ARMOR_3_COUNT = 0;

const string BP_ARMOR_4_NAME = "loot_arm4_";
const int BP_ARMOR_4_COUNT = 0;

const string BP_ARMOR_5_NAME = "loot_arm5_";
const int BP_ARMOR_5_COUNT = 0;

const string BP_ARMOR_6_NAME = "loot_arm6_";
const int BP_ARMOR_6_COUNT = 0;

const string BP_ARMOR_7_NAME = "loot_arm7_";
const int BP_ARMOR_7_COUNT = 0;

const string BP_ARMOR_8_NAME = "loot_arm8_";
const int BP_ARMOR_8_COUNT = 0;

// BP_MELEE_*
const string BP_MELEE_BASTARDSWORD_NAME = "loot_bswrd";
const string BP_MELEE_BATTLEAXE_NAME = "loot_baxe";
const string BP_MELEE_CLUB_NAME = "loot_club";
const string BP_MELEE_DAGGER_NAME = "loot_dagger";
const string BP_MELEE_DIREMACE_NAME = "loot_dmace";
const string BP_MELEE_DOUBLEAXE_NAME = "loot_daxe";
const string BP_MELEE_DWARVENWARAXE_NAME = "loot_dwaxe";
const string BP_MELEE_GREATAXE_NAME = "loot_gaxe";
const string BP_MELEE_GREATSWORD_NAME = "loot_gswrd";
const string BP_MELEE_HALBERD_NAME = "loot_hlbrd";
const string BP_MELEE_HANDAXE_NAME = "loot_haxe";
const string BP_MELEE_HEAVYFLAIL_NAME = "loot_hflail";
const string BP_MELEE_KAMA_NAME = "loot_kama";
const string BP_MELEE_KATANA_NAME = "loot_ktana";
const string BP_MELEE_KUKRI_NAME = "loot_kukri";
const string BP_MELEE_LIGHTFLAIL_NAME = "loot_lflail";
const string BP_MELEE_LIGHTHAMMER_NAME = "loot_lhmmr";
const string BP_MELEE_LIGHTMACE_NAME = "loot_lmace";
const string BP_MELEE_LONGSWORD_NAME = "loot_lswrd";
const string BP_MELEE_MORNINGSTAR_NAME = "loot_mstar";
const string BP_MELEE_QUARTERSTAFF_NAME = "loot_qstaff";
const string BP_MELEE_RAPIER_NAME = "loot_rapier";
const string BP_MELEE_SCIMITAR_NAME = "loot_scmtr";
const string BP_MELEE_SCYTHE_NAME = "loot_scythe";
const string BP_MELEE_SHORTSPEAR_NAME = "loot_spear";
const string BP_MELEE_SHORTSWORD_NAME = "loot_sswrd";
const string BP_MELEE_SICKLE_NAME = "loot_sickle";
const string BP_MELEE_TRIDENT_NAME = "loot_trdnt";
const string BP_MELEE_TWOBLADEDSWORD_NAME = "loot_tbswrd";
const string BP_MELEE_WARHAMMER_NAME = "loot_whmmr";
const string BP_MELEE_WHIP_NAME = "loot_whip";

// BP_RANGED_*
const string BP_RANGED_HEAVYCROSSBOW_NAME = "loot_hcbow";
const string BP_RANGED_LIGHTCROSSBOW_NAME = "loot_lcbow";
const string BP_RANGED_LONGBOW_NAME = "loot_lbow";
const string BP_RANGED_SHORTBOW_NAME = "loot_sbow";
const string BP_RANGED_SLING_NAME = "loot_sling";

// BP_AMMO_*
const string BP_AMMO_ARROW_NAME = "loot_arrow";
const string BP_AMMO_BOLT_NAME = "loot_bolt";
const string BP_AMMO_BULLET_NAME = "loot_bllt";
const string BP_AMMO_DART_NAME = "loot_dart";
const string BP_AMMO_SHURIKEN_NAME = "loot_shrkn";
const string BP_AMMO_THROWINGAXE_NAME = "loot_taxe";

// LOOT_WEIGHT_*
// ================
// These determine the weight each item has in terms of appearing within loot.
// These are NOT percentile chances.

const int LOOT_WEIGHT_GOLD    = 4;
const int LOOT_WEIGHT_MELEE   = 4;
const int LOOT_WEIGHT_RANGED  = 4;
const int LOOT_WEIGHT_AMMO    = 4;
const int LOOT_WEIGHT_ARMOR   = 4;
const int LOOT_WEIGHT_SHIELD  = 4;
const int LOOT_WEIGHT_SCROLL  = 8;
const int LOOT_WEIGHT_GEM     = 4;
const int LOOT_WEIGHT_POTION  = 4;
const int LOOT_WEIGHT_WAND    = 4;
const int LOOT_WEIGHT_ROD     = 4;
const int LOOT_WEIGHT_STAFF   = 4;
const int LOOT_WEIGHT_BRACERS = 4;
const int LOOT_WEIGHT_AMULET  = 4;
const int LOOT_WEIGHT_CLOAK   = 4;
const int LOOT_WEIGHT_RING    = 4;
const int LOOT_WEIGHT_BOOTS   = 4;
const int LOOT_WEIGHT_HELM    = 4;
const int LOOT_WEIGHT_BELT    = 4;
const int LOOT_WEIGHT_GLOVES  = 4;
const int LOOT_WEIGHT_TRAP    = 4;
const int LOOT_WEIGHT_POISON  = 4;
const int LOOT_WEIGHT_REAGENT = 4;

// MELEE_LOOT_WEIGHT_*

const int MELEE_LOOT_WEIGHT_BASTARDSWORD   = 8;
const int MELEE_LOOT_WEIGHT_BATTLEAXE      = 8;
const int MELEE_LOOT_WEIGHT_CLUB           = 8;
const int MELEE_LOOT_WEIGHT_DAGGER         = 8;
const int MELEE_LOOT_WEIGHT_DIREMACE       = 8;
const int MELEE_LOOT_WEIGHT_DOUBLEAXE      = 8;
const int MELEE_LOOT_WEIGHT_DWARVENWARAXE  = 8;
const int MELEE_LOOT_WEIGHT_GREATAXE       = 8;
const int MELEE_LOOT_WEIGHT_GREATSWORD     = 8;
const int MELEE_LOOT_WEIGHT_HALBERD        = 8;
const int MELEE_LOOT_WEIGHT_HANDAXE        = 8;
const int MELEE_LOOT_WEIGHT_HEAVYFLAIL     = 8;
const int MELEE_LOOT_WEIGHT_KAMA           = 8;
const int MELEE_LOOT_WEIGHT_KATANA         = 8;
const int MELEE_LOOT_WEIGHT_KUKRI          = 8;
const int MELEE_LOOT_WEIGHT_LIGHTFLAIL     = 8;
const int MELEE_LOOT_WEIGHT_LIGHTHAMMER    = 8;
const int MELEE_LOOT_WEIGHT_LIGHTMACE      = 8;
const int MELEE_LOOT_WEIGHT_LONGSWORD      = 8;
const int MELEE_LOOT_WEIGHT_MORNINGSTAR    = 8;
const int MELEE_LOOT_WEIGHT_QUARTERSTAFF   = 8;
const int MELEE_LOOT_WEIGHT_RAPIER         = 8;
const int MELEE_LOOT_WEIGHT_SCIMITAR       = 8;
const int MELEE_LOOT_WEIGHT_SCYTHE         = 8;
const int MELEE_LOOT_WEIGHT_SHORTSPEAR     = 8;
const int MELEE_LOOT_WEIGHT_SHORTSWORD     = 8;
const int MELEE_LOOT_WEIGHT_SICKLE         = 8;
const int MELEE_LOOT_WEIGHT_TRIDENT        = 8;
const int MELEE_LOOT_WEIGHT_TWOBLADEDSWORD = 8;
const int MELEE_LOOT_WEIGHT_WARHAMMER      = 8;
const int MELEE_LOOT_WEIGHT_WHIP           = 8;

// RANGED_LOOT_WEIGHT_*

const int RANGED_LOOT_WEIGHT_HEAVYCROSSBOW = 3;
const int RANGED_LOOT_WEIGHT_LIGHTCROSSBOW = 3;
const int RANGED_LOOT_WEIGHT_LONGBOW       = 3;
const int RANGED_LOOT_WEIGHT_SHORTBOW      = 3;
const int RANGED_LOOT_WEIGHT_SLING         = 3;

// AMMO_LOOT_WEIGHT_*

const int AMMO_LOOT_WEIGHT_ARROW       = 3;
const int AMMO_LOOT_WEIGHT_BOLT        = 3;
const int AMMO_LOOT_WEIGHT_BULLET      = 3;
const int AMMO_LOOT_WEIGHT_DART        = 3;
const int AMMO_LOOT_WEIGHT_SHURIKEN    = 3;
const int AMMO_LOOT_WEIGHT_THROWINGAXE = 3;

//::////////////////////////////////////////////////////////////////////////:://
//:: DECLARATION                                                            :://
//::////////////////////////////////////////////////////////////////////////:://

// Returns a temporary storage container to manipulate loot items in.
object GetTempStorage();

// Generates randomized loot.
// ===========================
// - oContainer: The container to place loot in.
// - nLevel: The character level to generate loot for.
void GenerateLoot(object oContainer, int nLevel, object oPC);

// Generates some gold.
// ===========================
// - nLevel: The level of loot to generate (between 0 and 5).
void LootCreateGold(object oContainer, int nLevel);

// Generate a melee weapon.
// ===========================
// - nLevel: The level of loot to generate (between 0 and 5).
void LootCreateMelee(object oContainer, int nLevel, int subForGold);

// Generate a ranged weapon.
// ===========================
// - nLevel: The level of loot to generate (between 0 and 5).
void LootCreateRanged(object oContainer, int nLevel, int subForGold);

// Generate ammunition.
// ===========================
// - nLevel: The level of loot to generate (between 0 and 5).
void LootCreateAmmo(object oContainer, int nLevel, int subForGold);

// Generate armor.
// ===========================
// - nLevel: The level of loot to generate (between 0 and 5).
void LootCreateArmor(object oContainer, int nLevel, int subForGold);

// Generate a shield.
// ===========================
// - nLevel: The level of loot to generate (between 0 and 5).
void LootCreateShield(object oContainer, int nLevel, int subForGold);

// Generate one or more scrolls.
// ===========================
// - nLevel: The level of loot to generate (between 0 and 5).
void LootCreateScroll(object oContainer, int nLevel);

// Generates some gems.
// ===========================
// - nLevel: The level of loot to generate (between 0 and 5).
void LootCreateGem(object oContainer, int nLevel);

// Generates one or more potions.
void LootCreatePotion(object oContainer, int nLevel);

// Generates a wand.
// ===========================
// - nLevel: The level of loot to generate (between 0 and 5).
void LootCreateWand(object oContainer, int nLevel);

// Generates a rod.
// ===========================
// - nLevel: The level of loot to generate (between 0 and 5).
void LootCreateRod(object oContainer, int nLevel);

// Generates a staff.
// ===========================
// - nLevel: The level of loot to generate (between 0 and 5).
void LootCreateStaff(object oContainer, int nLevel);

// Generates a pair of bracers.
// ===========================
// - nLevel: The level of loot to generate (between 0 and 5).
void LootCreateBracers(object oContainer, int nLevel, int subForGold);

// Generates an amulet.
// ===========================
// - nLevel: The level of loot to generate (between 0 and 5).
void LootCreateAmulet(object oContainer, int nLevel, int subForGold);

// Generates a cloak.
// ===========================
// - nLevel: The level of loot to generate (between 0 and 5).
void LootCreateCloak(object oContainer, int nLevel, int subForGold);

// Generates a ring.
// ===========================
// - nLevel: The level of loot to generate (between 0 and 5).
void LootCreateRing(object oContainer, int nLevel, int subForGold);

// Generates a pair of boots.
// ===========================
// - nLevel: The level of loot to generate (between 0 and 5).
void LootCreateBoots(object oContainer, int nLevel, int subForGold);

// Generates a helm.
// ===========================
// - nLevel: The level of loot to generate (between 0 and 5).
void LootCreateHelm(object oContainer, int nLevel, int subForGold);

// Generates a belt.
// ===========================
// - nLevel: The level of loot to generate (between 0 and 5).
void LootCreateBelt(object oContainer, int nLevel, int subForGold);

// Generates a pair of gloves.
// ===========================
// - nLevel: The level of loot to generate (between 0 and 5).
void LootCreateGloves(object oContainer, int nLevel, int subForGold);

// Generates a trap kit.
// ===========================
// - nLevel: The level of loot to generate (between 0 and 5).
void LootCreateTrap(object oContainer, int nLevel);

// Generates a poison vial.
// ===========================
// - nLevel: The level of loot to generate (between 0 and 5).
void LootCreatePoison(object oContainer, int nLevel);

//::////////////////////////////////////////////////////////////////////////:://
//:: IMPLEMENTATION                                                         :://
//::////////////////////////////////////////////////////////////////////////:://

object GetTempStorage(){
    return GetObjectByTag(LOOT_STORAGE);
}

void GenerateLoot(object oContainer, int nLevel, object oPC){
    // Abort spawning loot if we're in the respawn zone or if we're instanced
    // and have already been opened.
    if(GetLocalInt(oContainer, LOOT_VAR_NO_SPAWN)) return;

    object oArea = GetArea(oContainer);

    int nIsInstanced = GetIsDungeonInstance(oArea);
    int nIsRandomizedInstance = GetIsRandomizedInstance(oArea);
    int nIsAreaLootNullified = GetIsAreaLootNullified(oArea);

    //if(nIsAreaLootNullified) return;

    int nSelectOnce;

    int nAmount, nAmountMin, nAmountMax, nLevelMin, nLevelMax;

    if(nIsInstanced) {
        if(GetPersistentInt_instance(oArea, oContainer, LOOT_VAR_CUSTOM_AMOUNT)) {
            nAmountMin = GetPersistentInt_instance(oArea, oContainer, LOOT_VAR_AMOUNT_MIN);
            nAmountMax = GetPersistentInt_instance(oArea, oContainer, LOOT_VAR_AMOUNT_MAX);
            if(nAmountMax > LOOT_DEFAULT_AMOUNT_MAX) nAmountMax = LOOT_DEFAULT_AMOUNT_MAX; // Invictus 2012-06-05
        } else {
            nAmountMin = LOOT_DEFAULT_AMOUNT_MIN;
            nAmountMax = LOOT_DEFAULT_AMOUNT_MAX;
        }
    } else {
        if(GetLocalInt(oContainer, LOOT_VAR_CUSTOM_AMOUNT)){
            nAmountMin = GetLocalInt(oContainer, LOOT_VAR_AMOUNT_MIN);
            nAmountMax = GetLocalInt(oContainer, LOOT_VAR_AMOUNT_MAX);
            if(nAmountMax > LOOT_DEFAULT_AMOUNT_MAX) nAmountMax = LOOT_DEFAULT_AMOUNT_MAX; // Invictus 2012-06-05
        } else {
            nAmountMin = LOOT_DEFAULT_AMOUNT_MIN;
            nAmountMax = LOOT_DEFAULT_AMOUNT_MAX;
        }
    }

    nAmount = Random(nAmountMax - nAmountMin + 1) + nAmountMin;

    if(nAmount < 1) nAmount = 1;
    if(GetHasFeat(TREASURE_SCENT,oPC))
    {
        int nBonusOdds=GetLevelByClass(CLASS_TYPE_ROGUE,oPC)*2;
        if(nBonusOdds>25) nBonusOdds=25;
        if(Random(100)<nBonusOdds)
        {nAmount=nAmount+1;
        SendMessageToPC(oPC,"Your treasure scent allowed you to find additional hidden treasure!");}
    }

    if(nIsInstanced) {
        if(nIsRandomizedInstance) {
            nLevelMin = GetLocalInt(oArea, INST_LV_CR_MIN);
            nLevelMax = GetLocalInt(oArea, INST_LV_CR_MAX);
        } else {
            nLevelMin = GetPersistentInt_instance(oArea, oContainer, LOOT_VAR_LEVEL_MIN);
            nLevelMax = GetPersistentInt_instance(oArea, oContainer, LOOT_VAR_LEVEL_MAX);
        }
    } else {
        nLevelMin = GetLocalInt(oContainer, LOOT_VAR_LEVEL_MIN);
        nLevelMax = GetLocalInt(oContainer, LOOT_VAR_LEVEL_MAX);
    }

    if(nLevel < nLevelMin && nLevelMin != 0) nLevel = nLevelMin;
    if(nLevel > nLevelMax && nLevelMax != 0) nLevel = nLevelMax;

    if(nLevel <= 4)       nLevel = 1;
    else if(nLevel <= 8)  nLevel = 2;
    else if(nLevel <= 12) nLevel = 3;
    else if(nLevel <= 16) nLevel = 4;
    else if(nLevel <= 20) nLevel = 5;
    else if(nLevel <= 27) nLevel = 6;
    else if(nLevel <= 40) nLevel = 7;


    if(DEBUG_LEVEL > 0) SendMessageToPC(GetFirstPC(), "LOOT SYSTEM: Creating " + IntToString(nAmount) + " items.");

    for(nAmount; nAmount > 0; nAmount--){
        nSelectOnce = FALSE;

        int nGoldWeight, nMeleeWeight, nRangedWeight, nAmmoWeight, nArmorWeight,
            nShieldWeight, nScrollWeight, nGemWeight, nPotionWeight, nWandWeight,
            nRodWeight, nStaffWeight, nBracersWeight, nAmuletWeight, nCloakWeight,
            nRingWeight, nBootsWeight, nHelmWeight, nBeltWeight, nGlovesWeight,
            nTrapWeight, nPoisonWeight, nReagentWeight;

        int bCustomWeight;
        if(nIsInstanced) bCustomWeight = GetPersistentInt_instance(oArea, oContainer, LOOT_VAR_CUSTOM_WEIGHT);
        else bCustomWeight = GetLocalInt(oContainer, LOOT_VAR_CUSTOM_WEIGHT);

        if(bCustomWeight) {
            nGoldWeight     = (nIsInstanced)? GetPersistentInt_instance(oArea, oContainer, LOOT_VAR_WEIGHT_GOLD)    : GetLocalInt(oContainer, LOOT_VAR_WEIGHT_GOLD);
            nMeleeWeight    = (nIsInstanced)? GetPersistentInt_instance(oArea, oContainer, LOOT_VAR_WEIGHT_MELEE)   : GetLocalInt(oContainer, LOOT_VAR_WEIGHT_MELEE);
            nRangedWeight   = (nIsInstanced)? GetPersistentInt_instance(oArea, oContainer, LOOT_VAR_WEIGHT_RANGED)  : GetLocalInt(oContainer, LOOT_VAR_WEIGHT_RANGED);
            nAmmoWeight     = (nIsInstanced)? GetPersistentInt_instance(oArea, oContainer, LOOT_VAR_WEIGHT_AMMO)    : GetLocalInt(oContainer, LOOT_VAR_WEIGHT_AMMO);
            nArmorWeight    = (nIsInstanced)? GetPersistentInt_instance(oArea, oContainer, LOOT_VAR_WEIGHT_ARMOR)   : GetLocalInt(oContainer, LOOT_VAR_WEIGHT_ARMOR);
            nShieldWeight   = (nIsInstanced)? GetPersistentInt_instance(oArea, oContainer, LOOT_VAR_WEIGHT_SHIELD)  : GetLocalInt(oContainer, LOOT_VAR_WEIGHT_SHIELD);
            nScrollWeight   = (nIsInstanced)? GetPersistentInt_instance(oArea, oContainer, LOOT_VAR_WEIGHT_SCROLL)  : GetLocalInt(oContainer, LOOT_VAR_WEIGHT_SCROLL);
            nGemWeight      = (nIsInstanced)? GetPersistentInt_instance(oArea, oContainer, LOOT_VAR_WEIGHT_GEM)     : GetLocalInt(oContainer, LOOT_VAR_WEIGHT_GEM);
            nPotionWeight   = (nIsInstanced)? GetPersistentInt_instance(oArea, oContainer, LOOT_VAR_WEIGHT_POTION)  : GetLocalInt(oContainer, LOOT_VAR_WEIGHT_POTION);
            nWandWeight     = (nIsInstanced)? GetPersistentInt_instance(oArea, oContainer, LOOT_VAR_WEIGHT_WAND)    : GetLocalInt(oContainer, LOOT_VAR_WEIGHT_WAND);
            nRodWeight      = (nIsInstanced)? GetPersistentInt_instance(oArea, oContainer, LOOT_VAR_WEIGHT_ROD)     : GetLocalInt(oContainer, LOOT_VAR_WEIGHT_ROD);
            nStaffWeight    = (nIsInstanced)? GetPersistentInt_instance(oArea, oContainer, LOOT_VAR_WEIGHT_STAFF)   : GetLocalInt(oContainer, LOOT_VAR_WEIGHT_STAFF);
            nBracersWeight  = (nIsInstanced)? GetPersistentInt_instance(oArea, oContainer, LOOT_VAR_WEIGHT_BRACERS) : GetLocalInt(oContainer, LOOT_VAR_WEIGHT_BRACERS);
            nAmuletWeight   = (nIsInstanced)? GetPersistentInt_instance(oArea, oContainer, LOOT_VAR_WEIGHT_AMULET)  : GetLocalInt(oContainer, LOOT_VAR_WEIGHT_AMULET);
            nCloakWeight    = (nIsInstanced)? GetPersistentInt_instance(oArea, oContainer, LOOT_VAR_WEIGHT_CLOAK)   : GetLocalInt(oContainer, LOOT_VAR_WEIGHT_CLOAK);
            nRingWeight     = (nIsInstanced)? GetPersistentInt_instance(oArea, oContainer, LOOT_VAR_WEIGHT_RING)    : GetLocalInt(oContainer, LOOT_VAR_WEIGHT_RING);
            nBootsWeight    = (nIsInstanced)? GetPersistentInt_instance(oArea, oContainer, LOOT_VAR_WEIGHT_BOOTS)   : GetLocalInt(oContainer, LOOT_VAR_WEIGHT_BOOTS);
            nHelmWeight     = (nIsInstanced)? GetPersistentInt_instance(oArea, oContainer, LOOT_VAR_WEIGHT_HELM)    : GetLocalInt(oContainer, LOOT_VAR_WEIGHT_HELM);
            nBeltWeight     = (nIsInstanced)? GetPersistentInt_instance(oArea, oContainer, LOOT_VAR_WEIGHT_BELT)    : GetLocalInt(oContainer, LOOT_VAR_WEIGHT_BELT);
            nGlovesWeight   = (nIsInstanced)? GetPersistentInt_instance(oArea, oContainer, LOOT_VAR_WEIGHT_GLOVES)  : GetLocalInt(oContainer, LOOT_VAR_WEIGHT_GLOVES);
            nTrapWeight     = (nIsInstanced)? GetPersistentInt_instance(oArea, oContainer, LOOT_VAR_WEIGHT_TRAP)    : GetLocalInt(oContainer, LOOT_VAR_WEIGHT_TRAP);
            nPoisonWeight   = (nIsInstanced)? GetPersistentInt_instance(oArea, oContainer, LOOT_VAR_WEIGHT_POISON)  : GetLocalInt(oContainer, LOOT_VAR_WEIGHT_POISON);
            nReagentWeight  = (nIsInstanced)? GetPersistentInt_instance(oArea, oContainer, LOOT_VAR_WEIGHT_REAGENT) : GetLocalInt(oContainer, LOOT_VAR_WEIGHT_REAGENT);
        } else {
            nGoldWeight     = LOOT_WEIGHT_GOLD;
            nMeleeWeight    = LOOT_WEIGHT_MELEE;
            nRangedWeight   = LOOT_WEIGHT_RANGED;
            nAmmoWeight     = LOOT_WEIGHT_AMMO;
            nArmorWeight    = LOOT_WEIGHT_ARMOR;
            nShieldWeight   = LOOT_WEIGHT_SHIELD;
            nScrollWeight   = LOOT_WEIGHT_SCROLL;
            nGemWeight      = LOOT_WEIGHT_GEM;
            nPotionWeight   = LOOT_WEIGHT_POTION;
            nWandWeight     = LOOT_WEIGHT_WAND;
            nRodWeight      = LOOT_WEIGHT_ROD;
            nStaffWeight    = LOOT_WEIGHT_STAFF;
            nBracersWeight  = LOOT_WEIGHT_BRACERS;
            nAmuletWeight   = LOOT_WEIGHT_AMULET;
            nCloakWeight    = LOOT_WEIGHT_CLOAK;
            nRingWeight     = LOOT_WEIGHT_RING;
            nBootsWeight    = LOOT_WEIGHT_BOOTS;
            nHelmWeight     = LOOT_WEIGHT_HELM;
            nBeltWeight     = LOOT_WEIGHT_BELT;
            nGlovesWeight   = LOOT_WEIGHT_GLOVES;
            nTrapWeight     = LOOT_WEIGHT_TRAP;
            nPoisonWeight   = LOOT_WEIGHT_POISON;
            nReagentWeight  = LOOT_WEIGHT_REAGENT;
        }

        int nTotalWeight = nGoldWeight    + nMeleeWeight  + nRangedWeight
                         + nAmmoWeight    + nArmorWeight  + nShieldWeight
                         + nScrollWeight  + nGemWeight    + nPotionWeight
                         + nWandWeight    + nRodWeight    + nStaffWeight
                         + nBracersWeight + nAmuletWeight + nCloakWeight
                         + nRingWeight    + nBootsWeight  + nHelmWeight
                         + nBeltWeight    + nGlovesWeight + nTrapWeight
                         + nPoisonWeight  + nReagentWeight;

        int nRoll = Random(nTotalWeight);

        nRoll -= nReagentWeight;
        if(nRoll < 0 && !nSelectOnce){
        if(DEBUG_LEVEL > 0) SendMessageToPC(GetFirstPC(), "LOOT SYSTEM: Creating Crafting Reagent.");
            CreateReagent(nLevel, oContainer);
            nSelectOnce = TRUE;
        }

        nRoll -= nGoldWeight;
        if(nRoll < 0 && !nSelectOnce){
            if(DEBUG_LEVEL > 0) SendMessageToPC(GetFirstPC(), "LOOT SYSTEM: Creating Gold.");
            LootCreateGold(oContainer, nLevel);
            nSelectOnce = TRUE;
        }

        if(nLevel>6) nLevel=6;//For now, tier 7 gear is only available through crafting

        nRoll -= nMeleeWeight;
        if(nRoll < 0 && !nSelectOnce){
            if(DEBUG_LEVEL > 0) SendMessageToPC(GetFirstPC(), "LOOT SYSTEM: Creating Melee Weapon.");
            LootCreateMelee(oContainer, nLevel, TRUE);
            nSelectOnce = TRUE;
        }

        nRoll -= nRangedWeight;
        if(nRoll < 0 && !nSelectOnce){
            if(DEBUG_LEVEL > 0) SendMessageToPC(GetFirstPC(), "LOOT SYSTEM: Creating Ranged Weapon");
            LootCreateRanged(oContainer, nLevel, TRUE);
            nSelectOnce = TRUE;
        }

        nRoll -= nAmmoWeight;
        if(nRoll < 0 && !nSelectOnce){
            if(DEBUG_LEVEL > 0) SendMessageToPC(GetFirstPC(), "LOOT SYSTEM: Creating Ammo.");
            LootCreateAmmo(oContainer, nLevel, TRUE);
            nSelectOnce = TRUE;
        }

        nRoll -= nArmorWeight;
        if(nRoll < 0 && !nSelectOnce){
            if(DEBUG_LEVEL > 0) SendMessageToPC(GetFirstPC(), "LOOT SYSTEM: Creating Armor.");
            LootCreateArmor(oContainer, nLevel, TRUE);
            nSelectOnce = TRUE;
        }

        nRoll -= nShieldWeight;
        if(nRoll < 0 && !nSelectOnce){
            if(DEBUG_LEVEL > 0) SendMessageToPC(GetFirstPC(), "LOOT SYSTEM: Creating Shield.");
            LootCreateShield(oContainer, nLevel, TRUE);
            nSelectOnce = TRUE;
        }

        nRoll -= nScrollWeight;
        if(nRoll < 0 && !nSelectOnce){
            if(DEBUG_LEVEL > 0) SendMessageToPC(GetFirstPC(), "LOOT SYSTEM: Creating Scroll.");
            LootCreateScroll(oContainer, nLevel);
            nSelectOnce = TRUE;
        }

        nRoll -= nGemWeight;
        if(nRoll < 0 && !nSelectOnce){
            if(DEBUG_LEVEL > 0) SendMessageToPC(GetFirstPC(), "LOOT SYSTEM: Creating Gem.");
            LootCreateGem(oContainer, nLevel);
            nSelectOnce = TRUE;
        }

        nRoll -= nPotionWeight;
        if(nRoll < 0 && !nSelectOnce){
            if(DEBUG_LEVEL > 0) SendMessageToPC(GetFirstPC(), "LOOT SYSTEM: Creating Potion.");
            LootCreatePotion(oContainer, nLevel);
            nSelectOnce = TRUE;
        }

        nRoll -= nRodWeight;
        if(nRoll < 0 && !nSelectOnce){
            if(DEBUG_LEVEL > 0) SendMessageToPC(GetFirstPC(), "LOOT SYSTEM: Creating Rod.");
            LootCreateRod(oContainer, nLevel);
            nSelectOnce = TRUE;
        }

        nRoll -= nWandWeight;
        if(nRoll < 0 && !nSelectOnce){
            if(DEBUG_LEVEL > 0) SendMessageToPC(GetFirstPC(), "LOOT SYSTEM: Creating Wand.");
            LootCreateWand(oContainer, nLevel);
            nSelectOnce = TRUE;
        }

        nRoll -= nStaffWeight;
        if(nRoll < 0 && !nSelectOnce){
            if(DEBUG_LEVEL > 0) SendMessageToPC(GetFirstPC(), "LOOT SYSTEM: Creating Staff.");
            LootCreateStaff(oContainer, nLevel);
            nSelectOnce = TRUE;
        }

        nRoll -= nBracersWeight;
        if(nRoll < 0 && !nSelectOnce){
            if(DEBUG_LEVEL > 0) SendMessageToPC(GetFirstPC(), "LOOT SYSTEM: Creating Bracers.");
            LootCreateBracers(oContainer, nLevel, TRUE);
            nSelectOnce = TRUE;
        }

        nRoll -= nAmuletWeight;
        if(nRoll < 0 && !nSelectOnce){
            if(DEBUG_LEVEL > 0) SendMessageToPC(GetFirstPC(), "LOOT SYSTEM: Creating Amulet.");
            LootCreateAmulet(oContainer, nLevel, TRUE);
            nSelectOnce = TRUE;
        }

        nRoll -= nCloakWeight;
        if(nRoll < 0 && !nSelectOnce){
            if(DEBUG_LEVEL > 0) SendMessageToPC(GetFirstPC(), "LOOT SYSTEM: Creating Cloak.");
            LootCreateCloak(oContainer, nLevel, TRUE);
            nSelectOnce = TRUE;
        }

        nRoll -= nRingWeight;
        if(nRoll < 0 && !nSelectOnce){
            if(DEBUG_LEVEL > 0) SendMessageToPC(GetFirstPC(), "LOOT SYSTEM: Creating Ring.");
            LootCreateRing(oContainer, nLevel, TRUE);
            nSelectOnce = TRUE;
        }

        nRoll -= nBootsWeight;
        if(nRoll < 0 && !nSelectOnce){
            if(DEBUG_LEVEL > 0) SendMessageToPC(GetFirstPC(), "LOOT SYSTEM: Creating Boots.");
            LootCreateBoots(oContainer, nLevel, TRUE);
            nSelectOnce = TRUE;
        }

        nRoll -= nHelmWeight;
        if(nRoll < 0 && !nSelectOnce){
            if(DEBUG_LEVEL > 0) SendMessageToPC(GetFirstPC(), "LOOT SYSTEM: Creating Helm.");
            LootCreateHelm(oContainer, nLevel, TRUE);
            nSelectOnce = TRUE;
        }

        nRoll -= nBeltWeight;
        if(nRoll < 0 && !nSelectOnce){
            if(DEBUG_LEVEL > 0) SendMessageToPC(GetFirstPC(), "LOOT SYSTEM: Creating Belt.");
            LootCreateBelt(oContainer, nLevel, TRUE);
            nSelectOnce = TRUE;
        }

        nRoll -= nGlovesWeight;
        if(nRoll < 0 && !nSelectOnce) {
            if(DEBUG_LEVEL > 0) SendMessageToPC(GetFirstPC(), "LOOT SYSTEM: Creating Gloves.");
            LootCreateGloves(oContainer, nLevel, TRUE);
            nSelectOnce = TRUE;
        }

        nRoll -= nTrapWeight;
        if(nRoll < 0 && !nSelectOnce) {
            if(DEBUG_LEVEL > 0) SendMessageToPC(GetFirstPC(), "LOOT SYSTEM: Creating Trap.");
            LootCreateTrap(oContainer, nLevel);
            nSelectOnce = TRUE;
        }

        nRoll -= nPoisonWeight;
        if(nRoll < 0 && !nSelectOnce) {
            if(DEBUG_LEVEL > 0) SendMessageToPC(GetFirstPC(), "LOOT SYSTEM: Creating Poison.");
            LootCreatePoison(oContainer, nLevel);
            nSelectOnce = TRUE;
        }
    }
}

void ApplyLootName(object oItem){
    string sPrefix   = GetLocalString(oItem, NAME_PREFIX);
    string sMaterial = GetLocalString(oItem, NAME_MATERIAL);
    string sItem     = GetLocalString(oItem, NAME_ITEM);
    string sSuffix   = GetLocalString(oItem, NAME_SUFFIX);

    string sName = sPrefix + " " + sMaterial + " " + sItem + " " + sSuffix;
    string sColorName;

    //if(DEBUG_LEVEL > 0) SendMessageToPC(GetFirstPC(), "LOOT SYSTEM: Item named " + sName + ".");
    int iTier;
    iTier=GetLocalInt(oItem, "sys_ilr_tier");
//    switch(iTier)
//    {
//        case 0://red item
//            sColorName=StringToRGBString(sName, "700");
//            SendMessageToAllDMs("Red");
//            break;
//        case 1://Orange item
//            sColorName=StringToRGBString(sName, "730");
//            SendMessageToAllDMs("Orange");
//            break;
//        case 2://yellow item
//            sColorName=StringToRGBString(sName, "770");
//            SendMessageToAllDMs("Yellow");
//            break;
//        case 3://green item
//            sColorName=StringToRGBString(sName, "070");
//            SendMessageToAllDMs("Green");
//            break;
//        case 4://blue item
//            sColorName=StringToRGBString(sName, "007");
//            SendMessageToAllDMs("Blue");
//            break;
//        case 5://purple item
//            sColorName=StringToRGBString(sName, "636");
//            SendMessageToAllDMs("Purple");
//            break;
//    }
    SetName(oItem, sName);

    DeleteLocalString(oItem, NAME_PREFIX);
    DeleteLocalString(oItem, NAME_MATERIAL);
    DeleteLocalString(oItem, NAME_ITEM);
    DeleteLocalString(oItem, NAME_SUFFIX);
}

void LootCreateGold(object oContainer, int nLevel){
    int nGold = Random(nLevel*20 + 40);

    //int nGold = Random(ceil(pow(IntToFloat(nLevel), 2.0) + 200)) / 25;

    if(DEBUG_LEVEL > 0) SendMessageToPC(GetFirstPC(), "LOOT SYSTEM: Adding " + IntToString(nGold) + "gp.");

    CreateItemOnObject("NW_IT_GOLD001", oContainer, nGold);
}

// MELEE
// ===================
// Primary:
// + Atk Bonus
// + Enhancement Bonus*
//
// Secondary:
// + Damage
//
// Tertiary:
//

void LootCreateMelee(object oContainer, int nLevel, int subForGold){
    int nSelectOnce;

    object oItem;

    int nTotalWeight = MELEE_LOOT_WEIGHT_BASTARDSWORD + MELEE_LOOT_WEIGHT_BATTLEAXE +
                       MELEE_LOOT_WEIGHT_CLUB + MELEE_LOOT_WEIGHT_DAGGER +
                       MELEE_LOOT_WEIGHT_DIREMACE + MELEE_LOOT_WEIGHT_DOUBLEAXE +
                       MELEE_LOOT_WEIGHT_DWARVENWARAXE + MELEE_LOOT_WEIGHT_GREATAXE +
                       MELEE_LOOT_WEIGHT_GREATSWORD + MELEE_LOOT_WEIGHT_HALBERD +
                       MELEE_LOOT_WEIGHT_HANDAXE + MELEE_LOOT_WEIGHT_HEAVYFLAIL +
                       MELEE_LOOT_WEIGHT_KAMA + MELEE_LOOT_WEIGHT_KATANA +
                       MELEE_LOOT_WEIGHT_KUKRI + MELEE_LOOT_WEIGHT_LIGHTFLAIL +
                       MELEE_LOOT_WEIGHT_LIGHTHAMMER + MELEE_LOOT_WEIGHT_LIGHTMACE +
                       MELEE_LOOT_WEIGHT_LONGSWORD + MELEE_LOOT_WEIGHT_MORNINGSTAR +
                       MELEE_LOOT_WEIGHT_QUARTERSTAFF + MELEE_LOOT_WEIGHT_RAPIER +
                       MELEE_LOOT_WEIGHT_SCIMITAR + MELEE_LOOT_WEIGHT_SCYTHE +
                       MELEE_LOOT_WEIGHT_SHORTSPEAR + MELEE_LOOT_WEIGHT_SHORTSWORD +
                       MELEE_LOOT_WEIGHT_SICKLE + MELEE_LOOT_WEIGHT_TRIDENT +
                       MELEE_LOOT_WEIGHT_TWOBLADEDSWORD + MELEE_LOOT_WEIGHT_WARHAMMER +
                       MELEE_LOOT_WEIGHT_WHIP;

    int nSecondaries = Random(nLevel);
    if(nSecondaries>3) nSecondaries=3;
    int nRoll = Random(nTotalWeight);

    int nWood;

    nRoll -= MELEE_LOOT_WEIGHT_BASTARDSWORD;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_MELEE_BASTARDSWORD_NAME, GetTempStorage());

        SetItemNameType(oItem, "Bastard Sword");

        nSelectOnce = TRUE;
    }

    nRoll -= MELEE_LOOT_WEIGHT_BATTLEAXE;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_MELEE_BATTLEAXE_NAME, GetTempStorage());

        SetItemNameType(oItem, "Battleaxe");

        nSelectOnce = TRUE;
    }

    nRoll -= MELEE_LOOT_WEIGHT_CLUB;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_MELEE_CLUB_NAME, GetTempStorage());

        SetItemNameType(oItem, "Club");

        nSelectOnce = TRUE;
    }

    nRoll -= MELEE_LOOT_WEIGHT_DAGGER;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_MELEE_DAGGER_NAME, GetTempStorage());

        SetItemNameType(oItem, "Dagger");

        nSelectOnce = TRUE;
    }

    nRoll -= MELEE_LOOT_WEIGHT_DIREMACE;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_MELEE_DIREMACE_NAME, GetTempStorage());

        SetItemNameType(oItem, "Dire Mace");

        nSelectOnce = TRUE;
    }

    nRoll -= MELEE_LOOT_WEIGHT_DOUBLEAXE;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_MELEE_DOUBLEAXE_NAME, GetTempStorage());

        SetItemNameType(oItem, "Double Axe");

        nSelectOnce = TRUE;
    }

    nRoll -= MELEE_LOOT_WEIGHT_DWARVENWARAXE;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_MELEE_DWARVENWARAXE_NAME, GetTempStorage());

        SetItemNameType(oItem, "Dwarven Waraxe");

        nSelectOnce = TRUE;
    }

    nRoll -= MELEE_LOOT_WEIGHT_GREATAXE;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_MELEE_GREATAXE_NAME, GetTempStorage());

        SetItemNameType(oItem, "Greataxe");

        nSelectOnce = TRUE;
    }

    nRoll -= MELEE_LOOT_WEIGHT_GREATSWORD;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_MELEE_GREATSWORD_NAME, GetTempStorage());

        SetItemNameType(oItem, "Greatsword");

        nSelectOnce = TRUE;
    }

    nRoll -= MELEE_LOOT_WEIGHT_HALBERD;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_MELEE_HALBERD_NAME, GetTempStorage());

        SetItemNameType(oItem, "Halberd");

        nSelectOnce = TRUE;
    }

    nRoll -= MELEE_LOOT_WEIGHT_HANDAXE;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_MELEE_HANDAXE_NAME, GetTempStorage());

        SetItemNameType(oItem, "Handaxe");

        nSelectOnce = TRUE;
    }

    nRoll -= MELEE_LOOT_WEIGHT_HEAVYFLAIL;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_MELEE_HEAVYFLAIL_NAME, GetTempStorage());

        SetItemNameType(oItem, "Heavy Flail");

        nSelectOnce = TRUE;
    }

    nRoll -= MELEE_LOOT_WEIGHT_KAMA;
    if(nRoll < 0 && !nSelectOnce){
        SendMessageToDevelopers("LOOT SYSTEM: Spawning kama.");
        oItem = CreateItemOnObject(BP_MELEE_KAMA_NAME, GetTempStorage());

        SetItemNameType(oItem, "Kama");

        nSelectOnce = TRUE;
    }

    nRoll -= MELEE_LOOT_WEIGHT_KATANA;
    if(nRoll < 0 && !nSelectOnce){
        SendMessageToDevelopers("LOOT SYSTEM: Spawning katana.");
        oItem = CreateItemOnObject(BP_MELEE_KATANA_NAME, GetTempStorage());

        SetItemNameType(oItem, "Katana");

        nSelectOnce = TRUE;
    }

    nRoll -= MELEE_LOOT_WEIGHT_KUKRI;
    if(nRoll < 0 && !nSelectOnce){
        SendMessageToDevelopers("LOOT SYSTEM: Spawning kukri.");
        oItem = CreateItemOnObject(BP_MELEE_KUKRI_NAME, GetTempStorage());

        SetItemNameType(oItem, "Kukri");

        nSelectOnce = TRUE;
    }

    nRoll -= MELEE_LOOT_WEIGHT_LIGHTFLAIL;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_MELEE_LIGHTFLAIL_NAME, GetTempStorage());

        SetItemNameType(oItem, "Light Flail");

        nSelectOnce = TRUE;
    }

    nRoll -= MELEE_LOOT_WEIGHT_LIGHTHAMMER;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_MELEE_LIGHTHAMMER_NAME, GetTempStorage());

        SetItemNameType(oItem, "Light Hammer");

        nSelectOnce = TRUE;
    }

    nRoll -= MELEE_LOOT_WEIGHT_LIGHTMACE;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_MELEE_LIGHTMACE_NAME, GetTempStorage());

        SetItemNameType(oItem, "Light Mace");

        nSelectOnce = TRUE;
    }

    nRoll -= MELEE_LOOT_WEIGHT_LONGSWORD;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_MELEE_LONGSWORD_NAME, GetTempStorage());

        SetItemNameType(oItem, "Longsword");

        nSelectOnce = TRUE;
    }

    nRoll -= MELEE_LOOT_WEIGHT_MORNINGSTAR;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_MELEE_MORNINGSTAR_NAME, GetTempStorage());

        SetItemNameType(oItem, "Morningstar");

        nSelectOnce = TRUE;
    }

    nRoll -= MELEE_LOOT_WEIGHT_QUARTERSTAFF;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_MELEE_QUARTERSTAFF_NAME, GetTempStorage());

        SetItemNameType(oItem, "Quarterstaff");

        nSelectOnce = TRUE;
    }

    nRoll -= MELEE_LOOT_WEIGHT_RAPIER;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_MELEE_RAPIER_NAME, GetTempStorage());

        SetItemNameType(oItem, "Rapier");

        nSelectOnce = TRUE;
    }

    nRoll -= MELEE_LOOT_WEIGHT_SCIMITAR;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_MELEE_SCIMITAR_NAME, GetTempStorage());

        SetItemNameType(oItem, "Scimitar");

        nSelectOnce = TRUE;
    }

    nRoll -= MELEE_LOOT_WEIGHT_SCYTHE;
    if(nRoll < 0 && !nSelectOnce){
        SendMessageToDevelopers("LOOT SYSTEM: Spawning scythe.");
        oItem = CreateItemOnObject(BP_MELEE_SCYTHE_NAME, GetTempStorage());

        SetItemNameType(oItem, "Scythe");

        nSelectOnce = TRUE;
    }

    nRoll -= MELEE_LOOT_WEIGHT_SHORTSPEAR;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_MELEE_SHORTSPEAR_NAME, GetTempStorage());

        SetItemNameType(oItem, "Spear");

        nSelectOnce = TRUE;
    }

    nRoll -= MELEE_LOOT_WEIGHT_SHORTSWORD;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_MELEE_SHORTSWORD_NAME, GetTempStorage());

        SetItemNameType(oItem, "Shortsword");

        nSelectOnce = TRUE;
    }

    nRoll -= MELEE_LOOT_WEIGHT_SICKLE;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_MELEE_SICKLE_NAME, GetTempStorage());

        SetItemNameType(oItem, "Sickle");

        nSelectOnce = TRUE;
    }

    nRoll -= MELEE_LOOT_WEIGHT_TRIDENT;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_MELEE_TRIDENT_NAME, GetTempStorage());

        SetItemNameType(oItem, "Trident");

        nSelectOnce = TRUE;
    }

    nRoll -= MELEE_LOOT_WEIGHT_TWOBLADEDSWORD;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_MELEE_TWOBLADEDSWORD_NAME, GetTempStorage());

        SetItemNameType(oItem, "Two-Bladed Sword");

        nSelectOnce = TRUE;
    }

    nRoll -= MELEE_LOOT_WEIGHT_WARHAMMER;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_MELEE_WARHAMMER_NAME, GetTempStorage());

        SetItemNameType(oItem, "Warhammer");

        nSelectOnce = TRUE;
    }

    nRoll -= MELEE_LOOT_WEIGHT_WHIP;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_MELEE_WHIP_NAME, GetTempStorage());

        SetItemNameType(oItem, "Whip");

        nSelectOnce = TRUE;
    }

    AddMeleePropPrimary(oItem, nLevel, FALSE, nWood);

    for(nSecondaries; nSecondaries > 0; nSecondaries--){
        AddMeleePropSecondary(oItem, nLevel, FALSE);
    }

    CompileItemName(oItem);

    oItem = RandomizeItemAppearance(oItem);

    if(Random(100) < (nLevel * 15)) SetIdentified(oItem, FALSE);

    // Exchange propertyless items for a level-appropriate gold drop
    if(GetIsItemPropertyValid(GetFirstItemProperty(oItem))) {
        //SendMessageToAllDMs("Item spawned with tier: " + IntToString(GetLocalInt(oItem, "sys_ilr_tier")));
        object oCopiedItem = CopyItem(oItem, oContainer, TRUE);
        //SendMessageToAllDMs("Item copied with tier: " + IntToString(GetLocalInt(oCopiedItem, "sys_ilr_tier")));
    } else if(subForGold) {
        LootCreateGold(oContainer, nLevel);
    }

    DestroyObject(oItem);
}

// RANGED
// ===================
// Primary:
//
//
// Secondary:
//
//
// Tertiary:
//
void LootCreateRanged(object oContainer, int nLevel, int subForGold){
    int nSelectOnce;

    object oItem;

    int nSecondaries = Random(nLevel);
    if(nSecondaries>3) nSecondaries=3;

    int nTotalWeight = RANGED_LOOT_WEIGHT_HEAVYCROSSBOW + RANGED_LOOT_WEIGHT_LIGHTCROSSBOW +
                       RANGED_LOOT_WEIGHT_LONGBOW + RANGED_LOOT_WEIGHT_SHORTBOW +
                       RANGED_LOOT_WEIGHT_SLING;

    int nRoll = Random(nTotalWeight);

    nRoll -= RANGED_LOOT_WEIGHT_HEAVYCROSSBOW;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_RANGED_HEAVYCROSSBOW_NAME, GetTempStorage());

        SetItemNameType(oItem, "Heavy Crossbow");

        nSelectOnce = TRUE;
    }

    nRoll -= RANGED_LOOT_WEIGHT_LIGHTCROSSBOW;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_RANGED_LIGHTCROSSBOW_NAME, GetTempStorage());

        SetItemNameType(oItem, "Light Crossbow");

        nSelectOnce = TRUE;
    }

    nRoll -= RANGED_LOOT_WEIGHT_LONGBOW;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_RANGED_LONGBOW_NAME, GetTempStorage());

        SetItemNameType(oItem, "Longbow");

        nSelectOnce = TRUE;
    }

    nRoll -= RANGED_LOOT_WEIGHT_SHORTBOW;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_RANGED_SHORTBOW_NAME, GetTempStorage());

        SetItemNameType(oItem, "Shortbow");

        nSelectOnce = TRUE;
    }

    nRoll -= RANGED_LOOT_WEIGHT_SLING;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_RANGED_SLING_NAME, GetTempStorage());

        SetItemNameType(oItem, "Sling");

        nSelectOnce = TRUE;
    }

    AddRangedPropPrimary(oItem, nLevel, FALSE);

    for(nSecondaries; nSecondaries > 0; nSecondaries--){
        AddRangedPropSecondary(oItem, nLevel, FALSE);
    }

    CompileItemName(oItem);

    oItem = RandomizeItemAppearance(oItem);

    //SetIdentified(oItem, FALSE);

    // Exchange propertyless items for a level-appropriate gold drop
    if(GetIsItemPropertyValid(GetFirstItemProperty(oItem))) {
        //SendMessageToAllDMs("Item spawned with tier: " + IntToString(GetLocalInt(oItem, "sys_ilr_tier")));
        object oCopiedItem = CopyItem(oItem, oContainer, TRUE);
        //SendMessageToAllDMs("Item copied with tier: " + IntToString(GetLocalInt(oCopiedItem, "sys_ilr_tier")));
    } else if(subForGold) {
        LootCreateGold(oContainer, nLevel);
    }

    DestroyObject(oItem);
}

// AMMO
// ===================
// Primary:
//
//
// Secondary:
//
//
// Tertiary:
//
void LootCreateAmmo(object oContainer, int nLevel, int subForGold){
    int nSelectOnce;

    object oItem;

    int nSecondaries = Random(nLevel);
    if(nSecondaries>3) nSecondaries=3;
    int nTotalWeight = AMMO_LOOT_WEIGHT_ARROW + AMMO_LOOT_WEIGHT_BOLT +
                       AMMO_LOOT_WEIGHT_BULLET + AMMO_LOOT_WEIGHT_DART +
                       AMMO_LOOT_WEIGHT_SHURIKEN + AMMO_LOOT_WEIGHT_THROWINGAXE;

    int nStack = Random(70) + 30;
    int nRoll = Random(nTotalWeight);

    nRoll -= AMMO_LOOT_WEIGHT_ARROW;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_AMMO_ARROW_NAME, GetTempStorage(), nStack);

        SetItemNameType(oItem, "Arrow");

        nSelectOnce = TRUE;
    }

    nRoll -= AMMO_LOOT_WEIGHT_BOLT;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_AMMO_BOLT_NAME, GetTempStorage(), nStack);

        SetItemNameType(oItem, "Bolt");

        nSelectOnce = TRUE;
    }

    nRoll -= AMMO_LOOT_WEIGHT_BULLET;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_AMMO_BULLET_NAME, GetTempStorage(), nStack);

        SetItemNameType(oItem, "Bullet");

        nSelectOnce = TRUE;
    }

    nRoll -= AMMO_LOOT_WEIGHT_DART;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_AMMO_DART_NAME, GetTempStorage(), nStack);

        SetItemNameType(oItem, "Dart");

        nSelectOnce = TRUE;
    }

    nRoll -= AMMO_LOOT_WEIGHT_SHURIKEN;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_AMMO_SHURIKEN_NAME, GetTempStorage(), nStack);

        SetItemNameType(oItem, "Shuriken");

        nSelectOnce = TRUE;
    }

    nRoll -= AMMO_LOOT_WEIGHT_THROWINGAXE;
    if(nRoll < 0 && !nSelectOnce){
        oItem = CreateItemOnObject(BP_AMMO_THROWINGAXE_NAME, GetTempStorage(), nStack);

        SetItemNameType(oItem, "Throwing Axe");

        nSelectOnce = TRUE;
    }

    AddAmmoPropPrimary(oItem, nLevel, FALSE);

    for(nSecondaries; nSecondaries > 0; nSecondaries--){
        AddAmmoPropSecondary(oItem, nLevel, FALSE);
    }

    CompileItemName(oItem);

    oItem = RandomizeItemAppearance(oItem);

    //SetIdentified(oItem, FALSE);

    // Exchange propertyless items for a level-appropriate gold drop
    if(GetIsItemPropertyValid(GetFirstItemProperty(oItem))) {
        //SendMessageToAllDMs("Item spawned with tier: " + IntToString(GetLocalInt(oItem, "sys_ilr_tier")));
        object oCopiedItem = CopyItem(oItem, oContainer, TRUE);
        //SendMessageToAllDMs("Item copied with tier: " + IntToString(GetLocalInt(oCopiedItem, "sys_ilr_tier")));
    } else if(subForGold) {
        LootCreateGold(oContainer, nLevel);
    }

    DestroyObject(oItem);
}

// ARMORS
// ===================
// Primary:
//
//
// Secondary:
//
//
// Tertiary:
//
void LootCreateArmor(object oContainer, int nLevel, int subForGold){
    object oItem;

    string sCount;

    int nSecondaries = Random(nLevel);
    if(nSecondaries>2) nSecondaries=2;
    int nSelect = Random(9);

    switch(nSelect){
        case 0:
            sCount = IntToString(Random(BP_ARMOR_0_COUNT));

            oItem = CreateItemOnObject(BP_ARMOR_0_NAME + sCount, GetTempStorage());

            SetItemNameType(oItem, "Garments");
        break;

        case 1:
            sCount = IntToString(Random(BP_ARMOR_1_COUNT));

            oItem = CreateItemOnObject(BP_ARMOR_1_NAME + sCount, GetTempStorage());

            SetItemNameType(oItem, "Padded Armor");
        break;

        case 2:
            sCount = IntToString(Random(BP_ARMOR_2_COUNT));

            oItem = CreateItemOnObject(BP_ARMOR_2_NAME + sCount, GetTempStorage());

            SetItemNameType(oItem, "Armor");
        break;

        case 3:
            sCount = IntToString(Random(BP_ARMOR_3_COUNT));

            oItem = CreateItemOnObject(BP_ARMOR_3_NAME + sCount, GetTempStorage());

            SetItemNameType(oItem, "Studded Armor");
        break;

        case 4:
            sCount = IntToString(Random(BP_ARMOR_4_COUNT));

            oItem = CreateItemOnObject(BP_ARMOR_4_NAME + sCount, GetTempStorage());

            SetItemNameType(oItem, "Scale Mail");
        break;

        case 5:
            sCount = IntToString(Random(BP_ARMOR_5_COUNT));

            oItem = CreateItemOnObject(BP_ARMOR_5_NAME + sCount, GetTempStorage());

            SetItemNameType(oItem, "Chainmail");
        break;

        case 6:
            sCount = IntToString(Random(BP_ARMOR_6_COUNT));

            oItem = CreateItemOnObject(BP_ARMOR_6_NAME + sCount, GetTempStorage());

            SetItemNameType(oItem, "Banded Mail");
        break;

        case 7:
            sCount = IntToString(Random(BP_ARMOR_7_COUNT));

            oItem = CreateItemOnObject(BP_ARMOR_7_NAME + sCount, GetTempStorage());

            SetItemNameType(oItem, "Half Plate");
        break;

        case 8:
            sCount = IntToString(Random(BP_ARMOR_8_COUNT));

            oItem = CreateItemOnObject(BP_ARMOR_8_NAME + sCount, GetTempStorage());

            SetItemNameType(oItem, "Full Plate");
        break;
    }

    AddArmorPropPrimary(oItem, nLevel, FALSE);

    for(nSecondaries; nSecondaries > 0; nSecondaries--){
        AddArmorPropSecondary(oItem, nLevel, FALSE);
    }

    CompileItemName(oItem);

    //SetIdentified(oItem, FALSE);

    // Exchange propertyless items for a level-appropriate gold drop
    if(GetIsItemPropertyValid(GetFirstItemProperty(oItem))) {
        //SendMessageToAllDMs("Item spawned with tier: " + IntToString(GetLocalInt(oItem, "sys_ilr_tier")));
        object oCopiedItem = CopyItem(oItem, oContainer, TRUE);
        //SendMessageToAllDMs("Item copied with tier: " + IntToString(GetLocalInt(oCopiedItem, "sys_ilr_tier")));
    } else if(subForGold) {
        LootCreateGold(oContainer, nLevel);
    }

    DestroyObject(oItem);
}

// SHIELDS
// ===================
// Primary:
//
//
// Secondary:
//
//
// Tertiary:
//
void LootCreateShield(object oContainer, int nLevel, int subForGold){
    object oItem;
    string sCount;

    int nIsWood;

    int nSecondaries = Random(nLevel);
    int nTertiaries = Random(nLevel);
    if(nSecondaries>2) nSecondaries=2;
    int nSelect = Random(3);

    switch(nSelect){
        case 0:
            oItem = CreateItemOnObject(BP_SHIELD_S_NAME, GetTempStorage());

            nSelect = Random(31);

            if(nSelect > 17) nIsWood = TRUE;

            switch(nSelect){
                // METAL
                case 0:  nSelect = 14; break;
                case 1:  nSelect = 15; break;
                case 2:  nSelect = 16; break;
                case 3:  nSelect = 17; break;
                case 4:  nSelect = 18; break;
                case 5:  nSelect = 19; break;
                case 6:  nSelect = 24; break;
                case 7:  nSelect = 25; break;
                case 8:  nSelect = 51; break;
                case 9:  nSelect = 52; break;
                case 10: nSelect = 53; break;
                case 11: nSelect = 54; break;
                case 12: nSelect = 55; break;
                case 13: nSelect = 56; break;
                case 14: nSelect = 57; break;
                case 15: nSelect = 86; break;
                case 16: nSelect = 87; break;
                case 17: nSelect = 88; break;

                // WOOD
                case 18: nSelect = 11; break;
                case 19: nSelect = 12; break;
                case 20: nSelect = 13; break;
                case 21: nSelect = 21; break;
                case 22: nSelect = 22; break;
                case 23: nSelect = 23; break;
                case 24: nSelect = 31; break;
                case 25: nSelect = 32; break;
                case 26: nSelect = 33; break;
                case 27: nSelect = 41; break;
                case 28: nSelect = 42; break;
                case 29: nSelect = 43; break;
                case 30: nSelect = 59; break;
            }

            SetItemNameType(oItem, "Small Shield");
        break;

        case 1:
            oItem = CreateItemOnObject(BP_SHIELD_L_NAME, GetTempStorage());

            nSelect = Random(145);

            if(nSelect > 38) nIsWood = TRUE;

            switch(nSelect){
                case 0:  nSelect = 14;  break;
                case 1:  nSelect = 15;  break;
                case 2:  nSelect = 16;  break;
                case 3:  nSelect = 17;  break;
                case 4:  nSelect = 18;  break;
                case 5:  nSelect = 19;  break;
                case 6:  nSelect = 24;  break;
                case 7:  nSelect = 26;  break;
                case 8:  nSelect = 27;  break;
                case 9:  nSelect = 54;  break;
                case 10: nSelect = 56;  break;
                case 11: nSelect = 61;  break;
                case 12: nSelect = 62;  break;
                case 13: nSelect = 63;  break;
                case 14: nSelect = 64;  break;
                case 15: nSelect = 65;  break;
                case 16: nSelect = 66;  break;
                case 17: nSelect = 67;  break;
                case 18: nSelect = 68;  break;
                case 19: nSelect = 69;  break;
                case 20: nSelect = 70;  break;
                case 21: nSelect = 71;  break;
                case 22: nSelect = 72;  break;
                case 23: nSelect = 73;  break;
                case 24: nSelect = 74;  break;
                case 25: nSelect = 75;  break;
                case 26: nSelect = 86;  break;
                case 27: nSelect = 87;  break;
                case 28: nSelect = 88;  break;
                case 29: nSelect = 97;  break;
                case 30: nSelect = 98;  break;
                case 31: nSelect = 111; break;
                case 32: nSelect = 112; break;
                case 33: nSelect = 113; break;
                case 34: nSelect = 114; break;
                case 35: nSelect = 115; break;
                case 36: nSelect = 116; break;
                case 37: nSelect = 117; break;
                case 38: nSelect = 118; break;

                case 39: nSelect = 11;  break;
                case 40: nSelect = 12;  break;
                case 41: nSelect = 13;  break;
                case 42: nSelect = 21;  break;
                case 43: nSelect = 22;  break;
                case 44: nSelect = 23;  break;
                case 45: nSelect = 25;  break;
                case 46: nSelect = 28;  break;
                case 47: nSelect = 33;  break;
                case 48: nSelect = 41;  break;
                case 49: nSelect = 42;  break;
                case 50: nSelect = 43;  break;
                case 51: nSelect = 51;  break;
                case 52: nSelect = 52;  break;
                case 53: nSelect = 53;  break;
                case 54: nSelect = 55;  break;
                case 55: nSelect = 76;  break;
                case 56: nSelect = 77;  break;
                case 57: nSelect = 78;  break;
                case 58: nSelect = 79;  break;
                case 59: nSelect = 80;  break;
                case 60: nSelect = 81;  break;
                case 61: nSelect = 82;  break;
                case 62: nSelect = 83;  break;
                case 63: nSelect = 84;  break;
                case 64: nSelect = 85;  break;
                case 65: nSelect = 90;  break;
                case 66: nSelect = 91;  break;
                case 67: nSelect = 92;  break;
                case 68: nSelect = 93;  break;
                case 69: nSelect = 94;  break;
                case 70: nSelect = 95;  break;
                case 71: nSelect = 96;  break;
                case 72: nSelect = 100; break;
                case 73: nSelect = 101; break;
                case 74: nSelect = 102; break;
                case 75: nSelect = 103; break;
                case 76: nSelect = 104; break;
                case 77: nSelect = 119; break;
                case 78: nSelect = 121; break;
                case 79: nSelect = 122; break;
                case 80: nSelect = 123; break;
                case 81: nSelect = 124; break;
                case 82: nSelect = 125; break;
                case 83: nSelect = 126; break;
                case 84: nSelect = 127; break;
                case 85: nSelect = 128; break;
                case 86: nSelect = 129; break;
                case 87: nSelect = 141; break;
                case 88: nSelect = 142; break;
                case 89: nSelect = 143; break;
                case 90: nSelect = 144; break;
                case 91: nSelect = 145; break;
                case 92: nSelect = 146; break;
                case 93: nSelect = 147; break;
                case 94: nSelect = 148; break;
                case 95: nSelect = 149; break;
                case 96: nSelect = 151; break;
                case 97: nSelect = 152; break;
                case 98: nSelect = 153; break;
                case 99: nSelect = 154; break;
                case 100: nSelect = 155; break;
                case 101: nSelect = 156; break;
                case 102: nSelect = 157; break;
                case 103: nSelect = 158; break;
                case 104: nSelect = 159; break;
                case 105: nSelect = 160; break;
                case 106: nSelect = 161; break;
                case 107: nSelect = 162; break;
                case 108: nSelect = 163; break;
                case 109: nSelect = 164; break;
                case 110: nSelect = 165; break;
                case 111: nSelect = 166; break;
                case 112: nSelect = 167; break;
                case 113: nSelect = 168; break;
                case 114: nSelect = 169; break;
                case 115: nSelect = 170; break;
                case 116: nSelect = 171; break;
                case 117: nSelect = 172; break;
                case 118: nSelect = 173; break;
                case 119: nSelect = 174; break;
                case 120: nSelect = 175; break;
                case 121: nSelect = 176; break;
                case 122: nSelect = 177; break;
                case 123: nSelect = 178; break;
                case 124: nSelect = 179; break;
                case 125: nSelect = 180; break;
                case 126: nSelect = 181; break;
                case 127: nSelect = 182; break;
                case 128: nSelect = 183; break;
                case 129: nSelect = 184; break;
                case 130: nSelect = 185; break;
                case 131: nSelect = 186; break;
                case 132: nSelect = 187; break;
                case 133: nSelect = 188; break;
                case 134: nSelect = 189; break;
                case 135: nSelect = 190; break;
                case 136: nSelect = 191; break;
                case 137: nSelect = 192; break;
                case 138: nSelect = 193; break;
                case 139: nSelect = 194; break;
                case 140: nSelect = 195; break;
                case 141: nSelect = 196; break;
                case 142: nSelect = 197; break;
                case 143: nSelect = 198; break;
                case 144: nSelect = 199; break;
            }

            SetItemNameType(oItem, "Large Shield");
        break;

        case 2:
            oItem = CreateItemOnObject(BP_SHIELD_T_NAME, GetTempStorage());

            nSelect = Random(76);

            if(nSelect > 56) nIsWood = TRUE;

            switch(nSelect){
                case 0:  nSelect = 11;  break;
                case 1:  nSelect = 12;  break;
                case 2:  nSelect = 13;  break;
                case 3:  nSelect = 21;  break;
                case 4:  nSelect = 22;  break;
                case 5:  nSelect = 23;  break;
                case 6:  nSelect = 31;  break;
                case 7:  nSelect = 32;  break;
                case 8:  nSelect = 33;  break;
                case 9:  nSelect = 35;  break;
                case 10:  nSelect = 36;  break;
                case 11:  nSelect = 37;  break;
                case 12:  nSelect = 38;  break;
                case 13:  nSelect = 39;  break;
                case 14:  nSelect = 41;  break;
                case 15:  nSelect = 42;  break;
                case 16:  nSelect = 43;  break;
                case 17:  nSelect = 44;  break;
                case 18:  nSelect = 45;  break;
                case 19:  nSelect = 46;  break;
                case 20:  nSelect = 48;  break;
                case 21:  nSelect = 49;  break;
                case 22:  nSelect = 51;  break;
                case 23:  nSelect = 62;  break;
                case 24:  nSelect = 63;  break;
                case 25:  nSelect = 64;  break;
                case 26:  nSelect = 65;  break;
                case 27:  nSelect = 66;  break;
                case 28:  nSelect = 67;  break;
                case 29:  nSelect = 86;  break;
                case 30:  nSelect = 87;  break;
                case 31:  nSelect = 88;  break;
                case 32:  nSelect = 105;  break;
                case 33:  nSelect = 106;  break;
                case 34:  nSelect = 110;  break;
                case 35:  nSelect = 111;  break;
                case 36:  nSelect = 112;  break;
                case 37:  nSelect = 113;  break;
                case 38:  nSelect = 114;  break;
                case 39:  nSelect = 115;  break;
                case 40:  nSelect = 116;  break;
                case 41:  nSelect = 117;  break;
                case 42:  nSelect = 118;  break;
                case 43:  nSelect = 119;  break;
                case 44:  nSelect = 131;  break;
                case 45:  nSelect = 132;  break;
                case 46:  nSelect = 133;  break;
                case 47:  nSelect = 134;  break;
                case 48:  nSelect = 135;  break;
                case 49:  nSelect = 136;  break;
                case 50:  nSelect = 137;  break;
                case 51:  nSelect = 138;  break;
                case 52:  nSelect = 139;  break;
                case 53:  nSelect = 151;  break;
                case 54:  nSelect = 152;  break;
                case 55:  nSelect = 153;  break;
                case 56:  nSelect = 181;  break;

                case 57:  nSelect = 70;  break;
                case 58:  nSelect = 71;  break;
                case 59:  nSelect = 72;  break;
                case 60:  nSelect = 73;  break;
                case 61:  nSelect = 74;  break;
                case 62:  nSelect = 75;  break;
                case 63:  nSelect = 76;  break;
                case 64:  nSelect = 77;  break;
                case 65:  nSelect = 78;  break;
                case 66:  nSelect = 79;  break;
                case 67:  nSelect = 80;  break;
                case 68:  nSelect = 81;  break;
                case 69:  nSelect = 82;  break;
                case 70:  nSelect = 83;  break;
                case 71:  nSelect = 84;  break;
                case 72:  nSelect = 85;  break;
                case 73:  nSelect = 121;  break;
                case 74:  nSelect = 122;  break;
                case 75:  nSelect = 123;  break;
            }

            SetItemNameType(oItem, "Tower Shield");
        break;
    }

    object oDelete = oItem;
    oItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0, nSelect, TRUE);
    DestroyObject(oDelete);

    AddShieldPropPrimary(oItem, nLevel, nIsWood, FALSE);

    for(nSecondaries; nSecondaries > 0; nSecondaries--){
        AddShieldPropSecondary(oItem, nLevel, FALSE);
    }

    CompileItemName(oItem);

    //SetIdentified(oItem, FALSE);

    // Exchange propertyless items for a level-appropriate gold drop
    if(GetIsItemPropertyValid(GetFirstItemProperty(oItem))) {
        //SendMessageToAllDMs("Item spawned with tier: " + IntToString(GetLocalInt(oItem, "sys_ilr_tier")));
        object oCopiedItem = CopyItem(oItem, oContainer, TRUE);
        //SendMessageToAllDMs("Item copied with tier: " + IntToString(GetLocalInt(oCopiedItem, "sys_ilr_tier")));
    } else if(subForGold) {
        LootCreateGold(oContainer, nLevel);
    }

    DestroyObject(oItem);
}

// SCROLLS
// ===================
// Scrolls are all pre-made.
void LootCreateScroll(object oContainer, int nLevel){
    string sType;

    int iRoll;
    if(nLevel>6) nLevel=6;
    nLevel = Random(nLevel);

    // Max Cost: 300
    if (nLevel <= 2){
        iRoll = d100();
        switch (iRoll){
            case 1: sType = "x1_it_sparscr002";break;
            case 2: sType = "nw_it_sparscr107";break;
            case 3: sType = "x1_it_sparscr102";break;
            case 4: sType = "x1_it_spdvscr101";break;
            case 5: sType = "x2_it_spdvscr202";break;
            case 6: sType = "x2_it_spdvscr103";break;
            case 7: sType = "x2_it_spdvscr102";break;
            case 8: sType = "nw_it_sparscr211";break;
            case 9: sType = "x1_it_spdvscr202";break;
            case 10: sType = "nw_it_sparscr212";break;
            case 11: sType = "nw_it_sparscr112";break;
            case 12: sType = "x1_it_spdvscr107";break;
            case 13: sType = "nw_it_sparscr213";break;
            case 14: sType = "x2_it_sparscr207";break;
            case 15: sType = "nw_it_sparscr107";break;
            case 16: sType = "nw_it_spdvscr202";break;
            case 17: sType = "nw_it_sparscr217";break;
            case 18: sType = "x2_it_sparscr206";break;
            case 19: sType = "nw_it_sparscr110";break;
            case 20: sType = "x2_it_sparscr201";break;
            case 21: sType = "x1_it_spdvscr301";break;
            case 22: sType = "x2_it_spdvscr104";break;
            case 23: sType = "x2_it_spdvscr001";break;
            case 24: sType = "x2_it_spdvscr203";break;
            case 25: sType = "x2_it_spdvscr308";break;
            case 26: sType = "nw_it_sparscr206";break;
            case 27: sType = "nw_it_sparscr003";break;
            case 28: sType = "x2_it_spdvscr101";break;
            case 29: sType = "x2_it_sparscr202";break;
            case 30: sType = "x1_it_spdvscr102";break;
            case 31: sType = "x2_it_spdvscr105";break;
            case 32: sType = "nw_it_sparscr219";break;
            case 33: sType = "x1_it_sparscr003";break;
            case 34: sType = "nw_it_sparscr215";break;
            case 35: sType = "nw_it_sparscr101";break;
            case 36: sType = "x2_it_spdvscr106";break;
            case 37: sType = "x1_it_spdvscr103";break;
            case 38: sType = "x1_it_sparscr101";break;
            case 39: sType = "x1_it_sparscr101";break;
            case 40: sType = "x2_it_sparscr305";break;
            case 41: sType = "x1_it_spdvscr205";break;
            case 42: sType = "x2_it_sparscr205";break;
            case 43: sType = "x1_it_sparscr001";break;
            case 44: sType = "nw_it_sparscr220";break;
            case 45: sType = "x2_it_sparscr203";break;
            case 46: sType = "nw_it_sparscr208";break;
            case 47: sType = "nw_it_sparscr209";break;
            case 48: sType = "nw_it_sparscr103";break;
            case 49: sType = "x2_it_spdvscr204";break;
            case 50: sType = "nw_it_sparscr308";break;
            case 51: sType = "x2_it_sparscr101";break;
            case 52: sType = "x2_it_sparscr104";break;
            case 53: sType = "nw_it_sparscr106";break;
            case 54: sType = "x1_it_spdvscr104";break;
            case 55: sType = "x1_it_spdvscr001";break;
            case 56: sType = "x1_it_spdvscr201";break;
            case 57: sType = "nw_it_sparscr207";break;
            case 58: sType = "x2_it_sparscr102";break;
            case 59: sType = "nw_it_sparscr216";break;
            case 60: sType = "nw_it_sparscr218";break;
            case 61: sType = "nw_it_spdvscr201";break;
            case 62: sType = "nw_it_sparscr004";break;
            case 63: sType = "nw_it_sparscr104";break;
            case 64: sType = "x1_it_spdvscr106";break;
            case 65: sType = "nw_it_sparscr109";break;
            case 66: sType = "x2_it_sparscr105";break;
            case 67: sType = "nw_it_sparscr202";break;
            case 68: sType = "nw_it_sparscr113";break;
            case 69: sType = "x1_it_spdvscr203";break;
            case 70: sType = "nw_it_sparscr221";break;
            case 71: sType = "nw_it_sparscr102";break;
            case 72: sType = "x2_it_sparscral";break;
            case 73: sType = "nw_it_sparscr111";break;
            case 74: sType = "nw_it_sparscr002";break;
            case 75: sType = "x2_it_spdvscr107";break;
            case 76: sType = "x2_it_spdvscr205";break;
            case 77: sType = "nw_it_sparscr201";break;
            case 78: sType = "nw_it_sparscr001";break;
            case 79: sType = "x2_it_spdvscr108";break;
            case 80: sType = "nw_it_sparscr210";break;
            case 81: sType = "x2_it_sparscr103";break;
            case 82: sType = "x1_it_sparscr103";break;
            case 83: sType = "x1_it_spdvscr105";break;
            case 84: sType = "nw_it_spdvscr203";break;
            case 85: sType = "nw_it_sparscr108";break;
            case 86: sType = "nw_it_spdvscr204";break;
            case 87: sType = "x2_it_sparscr204";break;
            case 88: sType = "nw_it_sparscr105";break;
            case 89: sType = "nw_it_sparscr203";break;
            case 90: sType = "x1_it_sparscr202";break;
            case 91: sType = "x1_it_sparscr104";break;
            case 92: sType = "nw_it_sparscr214";break;
            case 93: sType = "x2_it_spdvscr002";break;
            case 94: sType = "nw_it_sparscr204";break;
            case 95: sType = "x1_it_sparscr002";break;
            case 96: sType = "nw_it_sparscr107";break;
            case 97: sType = "x1_it_sparscr102";break;
            case 98: sType = "x1_it_spdvscr101";break;
            case 99: sType = "x2_it_spdvscr202";break;
            case 100: sType = "x2_it_spdvscr103";break;
        }
    } else if (nLevel==3) { // Value 540 - 1621
        iRoll = d100();
        switch (iRoll){
            case 1: sType = "nw_it_sparscr509";break;
            case 2: sType = "x2_it_spdvscr508";break;
            case 3: sType = "x2_it_sparscr501";break;
            case 4: sType = "x2_it_spdvscr501";break;
            case 5: sType = "nw_it_sparscr414";break;
            case 6: sType = "x1_it_sparscr502";break;
            case 7: sType = "x2_it_spdvscr307";break;
            case 8: sType = "nw_it_sparscr405";break;
            case 9: sType = "x2_it_spdvscr504";break;
            case 10: sType = "nw_it_sparscr307";break;
            case 11: sType = "nw_it_sparscr502";break;
            case 12: sType = "nw_it_sparscr507";break;
            case 13: sType = "nw_it_sparscr406";break;
            case 14: sType = "nw_it_sparscr411";break;
            case 15: sType = "x2_it_spdvscr402";break;
            case 16: sType = "x2_it_spdvscr305";break;
            case 17: sType = "x2_it_spdvscr403";break;
            case 18: sType = "nw_it_sparscr501";break;
            case 19: sType = "nw_it_sparscr301";break;
            case 20: sType = "x1_it_sparscr301";break;
            case 21: sType = "x2_it_spdvscr404";break;
            case 22: sType = "x2_it_spdvscr309";break;
            case 23: sType = "nw_it_sparscr416";break;
            case 24: sType = "nw_it_sparscr503";break;
            case 25: sType = "nw_it_sparscr608";break;
            case 26: sType = "nw_it_sparscr418";break;
            case 27: sType = "x2_it_spdvscr509";break;
            case 28: sType = "nw_it_sparscr413";break;
            case 29: sType = "nw_it_sparscr504";break;
            case 30: sType = "nw_it_sparscr309";break;
            case 31: sType = "x1_it_sparscr501";break;
            case 32: sType = "nw_it_sparscr304";break;
            case 33: sType = "x1_it_spdvscr403";break;
            case 34: sType = "x2_it_spdvscr405";break;
            case 35: sType = "x2_it_spdvscr306";break;
            case 36: sType = "x2_it_sparscr701";break;
            case 37: sType = "nw_it_sparscr602";break;
            case 38: sType = "x1_it_spdvscr303";break;
            case 39: sType = "x2_it_sparscr304";break;
            case 40: sType = "nw_it_sparscr508";break;
            case 41: sType = "x1_it_sparscr303";break;
            case 42: sType = "x2_it_spdvscr406";break;
            case 43: sType = "nw_it_sparscr312";break;
            case 44: sType = "x2_it_spdvscr505";break;
            case 45: sType = "x2_it_spdvscr302";break;
            case 46: sType = "nw_it_sparscr505";break;
            case 47: sType = "x2_it_spdvscr401";break;
            case 48: sType = "nw_it_sparscr408";break;
            case 49: sType = "x1_it_spdvscr501";break;
            case 50: sType = "x2_it_spdvscr301";break;
            case 51: sType = "x1_it_spdvscr401";break;
            case 52: sType = "x1_it_spdvscr302";break;
            case 53: sType = "x2_it_spdvscr310";break;
            case 54: sType = "nw_it_sparscr314";break;
            case 55: sType = "x1_it_sparscr401";break;
            case 56: sType = "x2_it_sparscr303";break;
            case 57: sType = "x2_it_sparscr602";break;
            case 58: sType = "nw_it_sparscr511";break;
            case 59: sType = "nw_it_sparscr512";break;
            case 60: sType = "nw_it_sparscr417";break;
            case 61: sType = "nw_it_sparscr513";break;
            case 62: sType = "nw_it_sparscr310";break;
            case 63: sType = "nw_it_sparscr302";break;
            case 64: sType = "x2_it_sparscrmc";break;
            case 65: sType = "x2_it_spdvscr304";break;
            case 66: sType = "x1_it_spdvscr402";break;
            case 67: sType = "x2_it_sparscr301";break;
            case 68: sType = "x2_it_sparscr502";break;
            case 69: sType = "nw_it_sparscr506";break;
            case 70: sType = "nw_it_sparscr401";break;
            case 71: sType = "x2_it_spdvscr502";break;
            case 72: sType = "nw_it_sparscr315";break;
            case 73: sType = "x2_it_spdvscr311";break;
            case 74: sType = "nw_it_spdvscr402";break;
            case 75: sType = "x1_it_spdvscr502";break;
            case 76: sType = "nw_it_sparscr409";break;
            case 77: sType = "x2_it_spdvscr407";break;
            case 78: sType = "nw_it_sparscr415";break;
            case 79: sType = "x2_it_spdvscr312";break;
            case 80: sType = "x1_it_spdvscr305";break;
            case 81: sType = "nw_it_spdvscr501";break;
            case 82: sType = "nw_it_spdvscr301";break;
            case 83: sType = "nw_it_sparscr402";break;
            case 84: sType = "nw_it_spdvscr401";break;
            case 85: sType = "x2_it_sparscr302";break;
            case 86: sType = "nw_it_sparscr410";break;
            case 87: sType = "x2_it_spdvscr506";break;
            case 88: sType = "nw_it_sparscr313";break;
            case 89: sType = "x2_it_spdvscr507";break;
            case 90: sType = "x1_it_spdvscr304";break;
            case 91: sType = "nw_it_sparscr305";break;
            case 92: sType = "nw_it_sparscr403";break;
            case 93: sType = "nw_it_sparscr306";break;
            case 94: sType = "nw_it_sparscr404";break;
            case 95: sType = "nw_it_sparscr510";break;
            case 96: sType = "x2_it_sparscr902";break;
            case 97: sType = "nw_it_sparscr606";break;
            case 98: sType = "x2_it_spdvscr503";break;
            case 99: sType = "nw_it_sparscr407";break;
            case 100: sType = "x1_it_sparscr302";break;
        }
    } else if (nLevel==4){ // Value: 2400 - 3200
        iRoll = Random(98)+1;
        switch (iRoll){
            case 1: sType = "nw_it_sparscr603";break;
            case 2: sType = "x1_it_spdvscr701";break;
            case 3: sType = "x1_it_spdvscr601";break;
            case 4: sType = "x1_it_sparscr602";break;
            case 5: sType = "x1_it_sparscr701";break;
            case 6: sType = "x1_it_spdvscr701";break;
            //case 6: sType = "x2_it_spdvscr603";break; //Greater sanctuary removed from module
            case 7: sType = "nw_it_sparscr607";break;
            case 8: sType = "nw_it_sparscr610";break;
            case 9: sType = "nw_it_sparscr707";break;
            case 10: sType = "x1_it_spdvscr605";break;
            case 11: sType = "x1_it_spdvscr702";break;
            case 12: sType = "x2_it_spdvscr601";break;
            case 13: sType = "nw_it_sparscr704";break;
            case 14: sType = "x1_it_spdvscr703";break;
            case 15: sType = "x1_it_sparscr601";break;
            case 16: sType = "x1_it_spdvscr604";break;
            case 17: sType = "x2_it_sparscr503";break;
            case 18: sType = "nw_it_sparscr708";break;
            case 19: sType = "x1_it_spdvscr704";break;
            case 20: sType = "x1_it_sparscr605";break;
            case 21: sType = "nw_it_sparscr601";break;
            case 22: sType = "nw_it_spdvscr701";break;
            case 23: sType = "x1_it_spdvscr602";break;
            case 24: sType = "x2_it_spdvscr606";break;
            case 25: sType = "nw_it_sparscr612";break;
            case 26: sType = "nw_it_sparscr613";break;
            case 27: sType = "x2_it_spdvscr604";break;
            case 28: sType = "x2_it_spdvscr605";break;
            case 29: sType = "x1_it_sparscr603";break;
            case 30: sType = "nw_it_sparscr611";break;
            case 31: sType = "x1_it_spdvscr603";break;
            case 32: sType = "nw_it_sparscr604";break;
            case 33: sType = "nw_it_sparscr702";break;
            case 34: sType = "nw_it_sparscr706";break;
            case 35: sType = "nw_it_sparscr802";break;
            case 36: sType = "x2_it_spdvscr702";break;
            case 37: sType = "nw_it_spdvscr702";break;
            case 38: sType = "nw_it_sparscr609";break;
            case 39: sType = "x2_it_sparscr703";break;
            case 40: sType = "nw_it_sparscr701";break;
            case 41: sType = "x1_it_sparscr604";break;
            case 42: sType = "x2_it_spdvscr602";break;
            case 43: sType = "nw_it_sparscr605";break;
            case 44: sType = "nw_it_sparscr703";break;
            case 45: sType = "x2_it_spdvscr803";break;
            case 46: sType = "nw_it_sparscr614";break;
            case 47: sType = "nw_it_sparscr614";break;
            case 48: sType = "x2_it_sparscr601";break;
            case 49: sType = "x2_it_spdvscr701";break;
            case 50: sType = "nw_it_sparscr603";break;
            case 51: sType = "x1_it_spdvscr701";break;
            case 52: sType = "x1_it_spdvscr601";break;
            case 53: sType = "x1_it_sparscr602";break;
            case 54: sType = "x1_it_sparscr701";break;
            case 55: sType = "nw_it_sparscr603";break;
            //case 55: sType = "x2_it_spdvscr603";break; //Greater sanctuary removed from mod
            case 56: sType = "nw_it_sparscr607";break;
            case 57: sType = "nw_it_sparscr610";break;
            case 58: sType = "nw_it_sparscr707";break;
            case 59: sType = "x1_it_spdvscr605";break;
            case 60: sType = "x1_it_spdvscr702";break;
            case 61: sType = "x2_it_spdvscr601";break;
            case 62: sType = "nw_it_sparscr704";break;
            case 63: sType = "x1_it_spdvscr703";break;
            case 64: sType = "x1_it_sparscr601";break;
            case 65: sType = "x1_it_spdvscr604";break;
            case 66: sType = "x2_it_sparscr503";break;
            case 67: sType = "nw_it_sparscr708";break;
            case 68: sType = "x1_it_spdvscr704";break;
            case 69: sType = "x1_it_sparscr605";break;
            case 70: sType = "nw_it_sparscr601";break;
            case 71: sType = "nw_it_spdvscr701";break;
            case 72: sType = "x1_it_spdvscr602";break;
            case 73: sType = "x2_it_spdvscr606";break;
            case 74: sType = "nw_it_sparscr612";break;
            case 75: sType = "nw_it_sparscr613";break;
            case 76: sType = "x2_it_spdvscr604";break;
            case 77: sType = "x2_it_spdvscr605";break;
            case 78: sType = "x1_it_sparscr603";break;
            case 79: sType = "nw_it_sparscr611";break;
            case 80: sType = "x1_it_spdvscr603";break;
            case 81: sType = "nw_it_sparscr604";break;
            case 82: sType = "nw_it_sparscr702";break;
            case 83: sType = "nw_it_sparscr706";break;
            case 84: sType = "nw_it_sparscr802";break;
            case 85: sType = "x2_it_spdvscr702";break;
            case 86: sType = "nw_it_spdvscr702";break;
            case 87: sType = "nw_it_sparscr609";break;
            case 88: sType = "x2_it_sparscr703";break;
            case 89: sType = "nw_it_sparscr701";break;
            case 90: sType = "x1_it_sparscr604";break;
            case 91: sType = "x2_it_spdvscr602";break;
            case 92: sType = "nw_it_sparscr605";break;
            case 93: sType = "nw_it_sparscr703";break;
            case 94: sType = "x2_it_spdvscr803";break;
            case 95: sType = "nw_it_sparscr614";break;
            case 96: sType = "nw_it_sparscr614";break;
            case 97: sType = "x2_it_sparscr601";break;
            case 98: sType = "x2_it_spdvscr701";break;
        }
    }else if (nLevel==5){ // Value higher than 3200.
        iRoll = Random(40)+1;
        switch (iRoll){
            case 1: sType = "nw_it_sparscr806";break;
            case 2: sType = "x2_it_spdvscr804";break;
            case 3: sType = "x1_it_sparscr801";break;
            case 4: sType = "x1_it_sparscr901";break;
            case 5: sType = "x2_it_sparscr901";break;
            case 6: sType = "x2_it_sparscr801";break;
            case 7: sType = "x1_it_spdvscr803";break;
            case 8: sType = "x1_it_spdvscr804";break;
            case 9: sType = "nw_it_sparscr905";break;
            case 10: sType = "x2_it_spdvscr901";break;
            case 11: sType = "nw_it_sparscr908";break;
            case 12: sType = "nw_it_sparscr902";break;
            case 13: sType = "nw_it_sparscr803";break;
            case 14: sType = "nw_it_sparscr912";break;
            case 15: sType = "nw_it_sparscr809";break;
            case 16: sType = "x2_it_spdvscr902";break;
            case 17: sType = "nw_it_sparscr804";break;
            case 18: sType = "nw_it_sparscr807";break;
            case 19: sType = "nw_it_sparscr806";break;
            case 20: sType = "x2_it_spdvscr801";break;
            case 21: sType = "nw_it_sparscr906";break;
            case 22: sType = "nw_it_sparscr801";break;
            case 23: sType = "nw_it_sparscr901";break;
            case 24: sType = "x2_it_spdvscr802";break;
            case 25: sType = "nw_it_sparscr903";break;
            case 26: sType = "nw_it_sparscr808";break;
            case 27: sType = "nw_it_sparscr910";break;
            case 28: sType = "x2_it_spdvscr903";break;
            case 29: sType = "nw_it_sparscr904";break;
            case 30: sType = "nw_it_sparscr805";break;
            case 31: sType = "x1_it_spdvscr802";break;
            case 32: sType = "nw_it_sparscr911";break;
            case 33: sType = "x1_it_spdvscr901";break;
            case 34: sType = "nw_it_sparscr909";break;
            case 35: sType = "nw_it_sparscr907";break;
            case 36: sType = "x1_it_spdvscr801";break;
            case 37: sType = "nw_it_sparscr906";break;
            case 38: sType = "nw_it_sparscr808";break;
            case 39: sType = "x2_it_sparscr801";break;
            case 40: sType = "x2_it_spdvscr804";break;
        }
    }

    if(DEBUG_LEVEL > 0) SendMessageToPC(GetFirstPC(), "LOOT SYSTEM: Scroll blueprint is " + sType + ".");

    object oItem =  CreateItemOnObject(sType, oContainer, 1);

    //SetIdentified(oItem, FALSE);
}

// GEMS
// ===================
// Gems are all pre-made.
void LootCreateGem(object oContainer, int nLevel){
}

// POTIONS
// ===================
// Potions are all pre-made.
void LootCreatePotion(object oContainer, int nLevel){
    string sPotion;

    int nDice = Random(27);

    switch (nDice){
        case 0:  sPotion = "pot_cure_s001"; break;
        case 1:  sPotion = "pot_cure_c001"; break;
        case 2:  sPotion = "nw_it_mpotion008"; break;
        case 3:  sPotion = "nw_it_mpotion009"; break;
        case 4:  sPotion = "nw_it_mpotion020"; break;
        case 5:  sPotion = "nw_it_mpotion011"; break;
        case 6:  sPotion = "nw_it_mpotion001"; break;
        case 7:  sPotion = "nw_it_mpotion002"; break;
        case 8:  sPotion = "nw_it_mpotion003"; break;
        case 9:  sPotion = "pot_cure_l001"; break;
        case 10: sPotion = "nw_it_mpotion006"; break;
        case 11: sPotion = "nw_it_mpotion007"; break;
        case 12: sPotion = "nw_it_mpotion008"; break;
        case 13: sPotion = "nw_it_mpotion009"; break;
        case 14: sPotion = "nw_it_mpotion010"; break;
        case 15: sPotion = "nw_it_mpotion011"; break;
        case 16: sPotion = "nw_it_mpotion013"; break;
        case 17: sPotion = "nw_it_mpotion014"; break;
        case 18: sPotion = "nw_it_mpotion015"; break;
        case 19: sPotion = "nw_it_mpotion016"; break;
        case 20: sPotion = "nw_it_mpotion017"; break;
        case 21: sPotion = "nw_it_mpotion018"; break;
        case 22: sPotion = "pot_cure_m001"; break;
        case 23: sPotion = "nw_it_mpotion002"; break;
        case 24: sPotion = "x2_it_mpotion001"; break;

        case 25:
        if(Random(3)==1)
        sPotion = "ave_pot_restore";
        else sPotion = "nw_it_mpotion002";
        break;

        case 26:
        if(Random(3)==1)
        sPotion = "ave_pot_seeinvis";
        else sPotion = "nw_it_mpotion002";
        break;
    }

    CreateItemOnObject(sPotion, oContainer, Random(nLevel + 3));

    //SetIdentified(oItem, FALSE);
}

// WANDS
// ===================
// Primary:
//
//
// Secondary:
//
//
// Tertiary:
//
void LootCreateWand(object oContainer, int nLevel){
}

// RODS
// ===================
// Primary:
//
//
// Secondary:
//
//
// Tertiary:
//
void LootCreateRod(object oContainer, int nLevel){
}

// STAVES
// ===================
// Primary:
//
//
// Secondary:
//
//
// Tertiary:
//
void LootCreateStaff(object oContainer, int nLevel){
}

// AMULET
// ===================
// Primary:
//
//
// Secondary:
//
//
// Tertiary:
//
void LootCreateAmulet(object oContainer, int nLevel, int subForGold){
    object oItem;

    string sName;

    int nSecondaries = Random(nLevel);
    if(nSecondaries>3) nSecondaries=3;
    oItem = CreateItemOnObject(BP_AMULET_NAME, GetTempStorage());

    // Set our base name.
    SetItemNameType(oItem, "Amulet");

    // Throw on our primary.
    AddAmuletPropPrimary(oItem, nLevel, FALSE);

    // Throw on our secondary set, if any.
    for(nSecondaries; nSecondaries > 0; nSecondaries--){
        AddAmuletPropSecondary(oItem, nLevel, FALSE);
    }

    CompileItemName(oItem);

    oItem = RandomizeItemAppearance(oItem);

    //SetIdentified(oItem, FALSE);

    // Exchange propertyless items for a level-appropriate gold drop
    if(GetIsItemPropertyValid(GetFirstItemProperty(oItem))) {
        //SendMessageToAllDMs("Item spawned with tier: " + IntToString(GetLocalInt(oItem, "sys_ilr_tier")));
        object oCopiedItem = CopyItem(oItem, oContainer, TRUE);
        //SendMessageToAllDMs("Item copied with tier: " + IntToString(GetLocalInt(oCopiedItem, "sys_ilr_tier")));
    } else if(subForGold) {
        LootCreateGold(oContainer, nLevel);
    }

    DestroyObject(oItem);
}



// BELT
// ===================
// Primary:
//
//
// Secondary:
//
//
// Tertiary:
//
void LootCreateBelt(object oContainer, int nLevel, int subForGold){
    object oItem;

    string sName;

    int nSecondaries = Random(nLevel);
    if(nSecondaries>3) nSecondaries=3;
    oItem = CreateItemOnObject(BP_BELT_NAME, GetTempStorage());

    // Set our base name.
    SetItemNameType(oItem, "Belt");

    // Throw on our primary.
    AddBeltPropPrimary(oItem, nLevel, FALSE);

    // Throw on our secondary set, if any.
    for(nSecondaries; nSecondaries > 0; nSecondaries--){
        AddBeltPropSecondary(oItem, nLevel, FALSE);
    }

    CompileItemName(oItem);

    oItem = RandomizeItemAppearance(oItem);

    //SetIdentified(oItem, FALSE);

    // Exchange propertyless items for a level-appropriate gold drop
    if(GetIsItemPropertyValid(GetFirstItemProperty(oItem))) {
        //SendMessageToAllDMs("Item spawned with tier: " + IntToString(GetLocalInt(oItem, "sys_ilr_tier")));
        object oCopiedItem = CopyItem(oItem, oContainer, TRUE);
        //SendMessageToAllDMs("Item copied with tier: " + IntToString(GetLocalInt(oCopiedItem, "sys_ilr_tier")));
    } else if(subForGold) {
        LootCreateGold(oContainer, nLevel);
    }

    DestroyObject(oItem);
}

// BRACERS
// ===================
// Primary:
//
//
// Secondary:
//
//
// Tertiary:
//
void LootCreateBracers(object oContainer, int nLevel, int subForGold){
    object oItem;

    string sName;

    int nSecondaries = Random(nLevel);
    if(nSecondaries>3) nSecondaries=3;
    oItem = CreateItemOnObject(BP_BRACERS_NAME, GetTempStorage());

    // Set our base name.
    SetItemNameType(oItem, "Bracers");

    // Throw on our primary.
    AddBracersPropPrimary(oItem, nLevel, FALSE);

    // Throw on our secondary set, if any.
    for(nSecondaries; nSecondaries > 0; nSecondaries--){
        AddBracersPropSecondary(oItem, nLevel, FALSE);
    }

    CompileItemName(oItem);

    oItem = RandomizeItemAppearance(oItem);

    //SetIdentified(oItem, FALSE);

    // Exchange propertyless items for a level-appropriate gold drop
    if(GetIsItemPropertyValid(GetFirstItemProperty(oItem))) {
        //SendMessageToAllDMs("Item spawned with tier: " + IntToString(GetLocalInt(oItem, "sys_ilr_tier")));
        object oCopiedItem = CopyItem(oItem, oContainer, TRUE);
        //SendMessageToAllDMs("Item copied with tier: " + IntToString(GetLocalInt(oCopiedItem, "sys_ilr_tier")));
    } else if(subForGold) {
        LootCreateGold(oContainer, nLevel);
    }

    DestroyObject(oItem);
}

// CLOAK
// ===================
// Primary:
//
//
// Secondary:
//
//
// Tertiary:
//
void LootCreateCloak(object oContainer, int nLevel, int subForGold){
    object oItem;

    string sName;

    int nSecondaries = Random(nLevel);
    if(nSecondaries>3) nSecondaries=3;
    oItem = CreateItemOnObject(BP_CLOAK_NAME, GetTempStorage());

    // Set our base name.
    SetItemNameType(oItem, "Cloak");

    // Throw on our primary.
    AddCloakPropPrimary(oItem, nLevel, FALSE);

    // Throw on our secondary set, if any.
    for(nSecondaries; nSecondaries > 0; nSecondaries--){
        AddCloakPropSecondary(oItem, nLevel, FALSE);
    }

    CompileItemName(oItem);

    oItem = RandomizeItemAppearance(oItem);
    oItem = RandomizeItemColors(oItem);

    //SetIdentified(oItem, FALSE);

    // Exchange propertyless items for a level-appropriate gold drop
    if(GetIsItemPropertyValid(GetFirstItemProperty(oItem))) {
        //SendMessageToAllDMs("Item spawned with tier: " + IntToString(GetLocalInt(oItem, "sys_ilr_tier")));
        object oCopiedItem = CopyItem(oItem, oContainer, TRUE);
        //SendMessageToAllDMs("Item copied with tier: " + IntToString(GetLocalInt(oCopiedItem, "sys_ilr_tier")));
    } else if(subForGold) {
        LootCreateGold(oContainer, nLevel);
    }

    DestroyObject(oItem);
}

// RING
// ===================
// Primary:
// + N/A
//
// Secondary:
// + INT
// + WIS
// + CHA
// + Spell Levels
// + Saves
//
// Tertiary:
//
void LootCreateRing(object oContainer, int nLevel, int subForGold){
    object oItem;

    string sName;

    int nSecondaries = Random(nLevel);
    if(nSecondaries>3) nSecondaries=3;
    oItem = CreateItemOnObject(BP_RING_NAME, GetTempStorage());

    // Set our base name.
    SetItemNameType(oItem, "Ring");

    // Throw on our primary.
    AddRingPropPrimary(oItem, nLevel, FALSE);

    // Throw on our secondary set, if any.
    for(nSecondaries; nSecondaries > 0; nSecondaries--){
        AddRingPropSecondary(oItem, nLevel, FALSE);
    }

    CompileItemName(oItem);

    oItem = RandomizeItemAppearance(oItem);

    //SetIdentified(oItem, FALSE);

    // Exchange propertyless items for a level-appropriate gold drop
    if(GetIsItemPropertyValid(GetFirstItemProperty(oItem))) {
        //SendMessageToAllDMs("Item spawned with tier: " + IntToString(GetLocalInt(oItem, "sys_ilr_tier")));
        object oCopiedItem = CopyItem(oItem, oContainer, TRUE);
        //SendMessageToAllDMs("Item copied with tier: " + IntToString(GetLocalInt(oCopiedItem, "sys_ilr_tier")));
    } else if(subForGold) {
        LootCreateGold(oContainer, nLevel);
    }

    DestroyObject(oItem);
}

// BOOTS
// ===================
// Primary:
// + AC (Dodge)
//
// Secondary:
// + DEX
// + REF
//
// Tertiary:
//
void LootCreateBoots(object oContainer, int nLevel, int subForGold){
    object oItem;

    string sName;

    int nSecondaries = Random(nLevel);
    if(nSecondaries>3) nSecondaries=3;
    oItem = CreateItemOnObject(BP_BOOTS_NAME + IntToString(Random(8)), GetTempStorage());

    // Set our base name.
    SetItemNameType(oItem, "Boots");

    // Throw on our primary.
    AddBootsPropPrimary(oItem, nLevel, FALSE);

    // Throw on our secondary set, if any.
    for(nSecondaries; nSecondaries > 0; nSecondaries--){
        AddBootsPropSecondary(oItem, nLevel, FALSE);
    }

    CompileItemName(oItem);

    oItem = RandomizeItemAppearance(oItem);

    //SetIdentified(oItem, FALSE);

    // Exchange propertyless items for a level-appropriate gold drop
    if(GetIsItemPropertyValid(GetFirstItemProperty(oItem))) {
        //SendMessageToAllDMs("Item spawned with tier: " + IntToString(GetLocalInt(oItem, "sys_ilr_tier")));
        object oCopiedItem = CopyItem(oItem, oContainer, TRUE);
        //SendMessageToAllDMs("Item copied with tier: " + IntToString(GetLocalInt(oCopiedItem, "sys_ilr_tier")));
    } else if(subForGold) {
        LootCreateGold(oContainer, nLevel);
    }

    DestroyObject(oItem);
}

// HELMS
// ===================
// Primary:
// + AC (Deflection)
//
// Secondary:
// + AC vs Dmg Type
// + Saves
// + Dmg Immunity
// + Dmg Reduction
// + Dmg Resistance
//
// + WILL*
// + SR*
// + AC vs Race*
// + AC vs Align*
//
// Tertiary:
// + Weight Reduction
//
// + Darkvision*
// + Light*
void LootCreateHelm(object oContainer, int nLevel, int subForGold){
    object oItem;

    string sName;

    int nSecondaries = Random(nLevel);
    if(nSecondaries>2) nSecondaries=2;
    oItem = CreateItemOnObject(BP_HELM_NAME, GetTempStorage());

    // Set our base name.
    SetItemNameType(oItem, "Helm");

    // Throw on our primary.
    AddHelmPropPrimary(oItem, nLevel, FALSE);

    // Throw on our secondary set, if any.
    for(nSecondaries; nSecondaries > 0; nSecondaries--){
        AddHelmPropSecondary(oItem, nLevel, FALSE);
    }

    CompileItemName(oItem);

    oItem = RandomizeItemAppearance(oItem);
    oItem = RandomizeItemColors(oItem);

    //SetIdentified(oItem, FALSE);

    // Exchange propertyless items for a level-appropriate gold drop
    if(GetIsItemPropertyValid(GetFirstItemProperty(oItem))) {
        //SendMessageToAllDMs("Item spawned with tier: " + IntToString(GetLocalInt(oItem, "sys_ilr_tier")));
        object oCopiedItem = CopyItem(oItem, oContainer, TRUE);
        //SendMessageToAllDMs("Item copied with tier: " + IntToString(GetLocalInt(oCopiedItem, "sys_ilr_tier")));
    } else if(subForGold) {
        LootCreateGold(oContainer, nLevel);
    }

    DestroyObject(oItem);
}

// GLOVES
// ===================
// Primary:
//
//
// Secondary:
//
//
// Tertiary:
//
void LootCreateGloves(object oContainer, int nLevel, int subForGold){
    object oItem;

    string sName;

    int nSecondaries = Random(nLevel);
    if(nSecondaries>3) nSecondaries=3;
    oItem = CreateItemOnObject(BP_GLOVES_NAME, GetTempStorage());

    // Set our base name.
    SetItemNameType(oItem, "Gloves");

    // Throw on our primary.
    AddGlovesPropPrimary(oItem, nLevel, FALSE);

    // Throw on our secondary set, if any.
    for(nSecondaries; nSecondaries > 0; nSecondaries--){
        AddGlovesPropSecondary(oItem, nLevel, FALSE);
    }

    CompileItemName(oItem);

    oItem = RandomizeItemAppearance(oItem);

    //SetIdentified(oItem, FALSE);

    // Exchange propertyless items for a level-appropriate gold drop
    if(GetIsItemPropertyValid(GetFirstItemProperty(oItem))) {
        //SendMessageToAllDMs("Item spawned with tier: " + IntToString(GetLocalInt(oItem, "sys_ilr_tier")));
        object oCopiedItem = CopyItem(oItem, oContainer, TRUE);
        //SendMessageToAllDMs("Item copied with tier: " + IntToString(GetLocalInt(oCopiedItem, "sys_ilr_tier")));
    } else if(subForGold) {
        LootCreateGold(oContainer, nLevel);
    }

    DestroyObject(oItem);
}

// TRAP
// ===================
void LootCreateTrap(object oContainer, int nLevel) {
    string sTrap;
    int nDice;

    if(nLevel == 1) {
        nDice = Random(11);
        switch (nDice){
            case 0:  sTrap = "nw_it_trap001"; break;
            case 1:  sTrap = "nw_it_trap005"; break;
            case 2:  sTrap = "nw_it_trap009"; break;
            case 3:  sTrap = "nw_it_trap013"; break;
            case 4:  sTrap = "nw_it_trap017"; break;
            case 5:  sTrap = "nw_it_trap021"; break;
            case 6:  sTrap = "nw_it_trap025"; break;
            case 7:  sTrap = "nw_it_trap029"; break;
            case 8:  sTrap = "nw_it_trap041"; break;
            case 9:  sTrap = "nw_it_trap037"; break;
            case 10: sTrap = "nw_it_trap033"; break;
        }
    } else if(nLevel == 2) {
        nDice = Random(11);
        switch (nDice){
            case 0:  sTrap = "nw_it_trap002"; break;
            case 1:  sTrap = "nw_it_trap006"; break;
            case 2:  sTrap = "nw_it_trap010"; break;
            case 3:  sTrap = "nw_it_trap014"; break;
            case 4:  sTrap = "nw_it_trap018"; break;
            case 5:  sTrap = "nw_it_trap022"; break;
            case 6:  sTrap = "nw_it_trap026"; break;
            case 7:  sTrap = "nw_it_trap030"; break;
            case 8:  sTrap = "nw_it_trap042"; break;
            case 9:  sTrap = "nw_it_trap038"; break;
            case 10: sTrap = "nw_it_trap034"; break;
        }
    } else if(nLevel == 3) {
        nDice = Random(11);
        switch (nDice){
            case 0:  sTrap = "nw_it_trap003"; break;
            case 1:  sTrap = "nw_it_trap007"; break;
            case 2:  sTrap = "nw_it_trap011"; break;
            case 3:  sTrap = "nw_it_trap015"; break;
            case 4:  sTrap = "nw_it_trap019"; break;
            case 5:  sTrap = "nw_it_trap023"; break;
            case 6:  sTrap = "nw_it_trap027"; break;
            case 7:  sTrap = "nw_it_trap031"; break;
            case 8:  sTrap = "nw_it_trap043"; break;
            case 9:  sTrap = "nw_it_trap039"; break;
            case 10: sTrap = "nw_it_trap035"; break;
        }
    } else if(nLevel <= 5) {
        nDice = Random(11);
        switch (nDice){
            case 0:  sTrap = "nw_it_trap004"; break;
            case 1:  sTrap = "nw_it_trap008"; break;
            case 2:  sTrap = "nw_it_trap012"; break;
            case 3:  sTrap = "nw_it_trap016"; break;
            case 4:  sTrap = "nw_it_trap020"; break;
            case 5:  sTrap = "nw_it_trap024"; break;
            case 6:  sTrap = "nw_it_trap028"; break;
            case 7:  sTrap = "nw_it_trap032"; break;
            case 8:  sTrap = "nw_it_trap044"; break;
            case 9:  sTrap = "nw_it_trap040"; break;
            case 10: sTrap = "nw_it_trap036"; break;
        }
    } else if(nLevel <= 7) {
        nDice = Random(4);
        switch (nDice){
            case 0: sTrap = "x2_it_trap001"; break;
            case 1: sTrap = "x2_it_trap002"; break;
            case 2: sTrap = "x2_it_trap003"; break;
            case 3: sTrap = "x2_it_trap004"; break;
        }
    } else return;

    CreateItemOnObject(sTrap, oContainer, Random(3) + 1);
}

// POISON
// ===================
void LootCreatePoison(object oContainer, int nLevel) {
    string sPoison;
    int nDice;

    if(nLevel == 1) {
        nDice = Random(6);
        switch (nDice) {
            case 0: sPoison = "x2_it_poison014"; break;
            case 1: sPoison = "x2_it_poison015"; break;
            case 2: sPoison = "x2_it_poison013"; break;
            case 3: sPoison = "x2_it_poison008"; break;
            case 4: sPoison = "x2_it_poison009"; break;
            case 5: sPoison = "x2_it_poison007"; break;
        }
    } else if(nLevel == 2) {
        nDice = Random(3);
        switch (nDice) {
            case 0: sPoison = "x2_it_poison020"; break;
            case 1: sPoison = "x2_it_poison021"; break;
            case 2: sPoison = "x2_it_poison019"; break;
        }
    } else if(nLevel == 3) {
        nDice = Random(3);
        switch (nDice) {
            case 0: sPoison = "x2_it_poison026"; break;
            case 1: sPoison = "x2_it_poison027"; break;
            case 2: sPoison = "x2_it_poison025"; break;
        }
    } else if(nLevel == 4) {
        nDice = Random(3);
        switch (nDice) {
            case 0: sPoison = "x2_it_poison032"; break;
            case 1: sPoison = "x2_it_poison033"; break;
            case 2: sPoison = "x2_it_poison031"; break;
        }
    } else if(nLevel >= 5) {
        nDice = Random(3);
        switch (nDice) {
            case 0: sPoison = "x2_it_poison038"; break;
            case 1: sPoison = "x2_it_poison039"; break;
            case 2: sPoison = "x2_it_poison037"; break;
        }
    } else return;

    CreateItemOnObject(sPoison, oContainer, Random(4) + 1);
}
