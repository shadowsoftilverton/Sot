//CRP MASTER CONTROL FILE - v2.08
/****************************************************************

This is the master control file for the C.R.A.P. Base Module
Read the comments for each control line and adjust as needed.

****************************************************************/


// Debug Messages:  set to 0 to deactivate; set to 1 to activate
const int CRP_DEBUG = 0;

//--- JUMP CONTROL ---
//Controls whether players are allowed or disallowed from jumping by 'default'.
//Set to 0 to make jumping disallowed by default - Set to 1 to allow by default.
//Use the Toggle Jumping Trigger to change the player's jump state.
//If you allow jumping by default, a player inside a jumping toggle trigger will
//be disallowed from jumping.  If you disallow by default, a player inside a
//toggle trigger will be allowed to jump.
const int CRP_ALLOW_JUMPING_BY_DEFAULT = 0;

// --- COIN CONTROL ---
// You can opt to use either the boring default gold system that's part of the
// Bioware engine OR you can use the more immersive crp coin system that
// includes support for various coin types, such as gold, silver, and copper
// Set to 0 to disable crp coins.
const int CRP_USE_COINS = 0;

// --- GEMSTONE CONTROL ---
// You can opt to allow random treausure generating scripts to create either
// the default Bioware gems OR you can have those same treasure generation
// systems randomly populate treasure drops with the more PnP friendly crp gems.
// Set to 0 to disable crp gems.
const int CRP_USE_GEMS = 0;

// --- BREAKABLE ITEM CONTROL ---
//If left at the default value of 1, fragile items (like potions) have a chance
//of breaking if you smash the container they are in.  Set to 0 to
//disable breakable item checks.
const int CRP_USE_BREAKABLE_ITEMS = 0;

// --- DEATH, DYING, & RESPAWN CONTROLS ---
//If set to 1, all non-plot items will be "dropped" into a corpse placeable when
//a player pushes the respawn button.  Set to 0 to deactivate item drops.
const int CRP_DROP_ITEMS_ON_DEATH = 0;
//The xp penalty for respawning
const int CRP_XP_LOSS_ON_DEATH = 25;
//how many seconds between 1hp bleed intervals
const float CRP_NORMAL_BLEED_DELAY = 18.0f;
//how many seconds between the accelerated (not in a party) bleed intervals
const float CRP_FAST_BLEED_DELAY = 1.5f;
//the grace period that a player has, in levels, before the full death rules kick in
const int CRP_DDR_GRACE_LEVELS = 3;

// --- RACIAL MOVEMENT RATES & ARMOR ENCUMBRANCE CONTROLS ---
//Set to 1 to completely disable racial movement rates
const int CRP_DISABLE_RACIAL_MOVEMENT = 0;
//The following 3 settings will allow you to fine tune racial movement rates
//to your preferences - They are not used if racial movement is disabled.
//The % movement penalty for Halfling, Dwarves, and Gnomes
const int SML_CREATURE_MOVEPEN = 20;
//The % heavy armor encumbrance penalty for Humans, Elves, Halfelves, and Halforcs
const int MDM_CREATURE_ARMORPEN = 20;
//The % heavy armor encumbrance movement penalty for Halflings, Dwarves, and Gnomes
const int SML_CREATURE_ARMORPEN = 15;
//Enable/Disable Racial Jumping Distance Modifiers
//I strongly recommend NOT disabling this when large pits need to be crossed by
//halflings or other small races.  The animation is scaled by the game engine
//to the model size and therefore makes the animations "off" distance-wise when
//appearing to jump a pit.  The PC will "land" in the pit but actually make the
//jump.
const int CRP_DISABLE_RACIAL_JUMPING = 0;

// --- LISTENING CONTROLS ---
const int OUTDOOR_LISTENING = 1;

// --- RESTING CONTROLS ---
//Set to 1 to use crp advanced resting rules, disable by setting to 0
const int CRP_USE_RESTING_RULES = 1;
// The number of game hours that must pass between player rests.
const int REST_WAIT = 4;
//If controlled resting is enabled, players will ONLY be able to rest inside of
//'Allowed Resting Triggers' which you draw.  Set to 1 to enable controlled
//resting
const int CRP_CONTROLLED_RESTING_ONLY = 0;

// --- TORCH LIFE CONTROLS ---
// TORCH_LIFESPAN: change this value to (lifespan in realtime minutes * 3) + 1
//                 default value of 61 means 20 minutes.
const int TORCH_LIFESPAN = 61;
// WANT_DIMMING: change to FALSE if you don't want dimming effect @ 60 sec. remaining
const int WANT_DIMMING = TRUE;

// --- WEATHER CONTROLS ---
//For snowy areas, PRECIPITATION should be set to WEATHER_SNOW.
//Otherwise, use the value WEATHER_RAIN.
const int PRECIPITATION = WEATHER_RAIN;
//The % chance of precipitation.  Change to suit your needs.
const int CHANCE_OF_PRECIPITATION = 10;




// --- Don't change anything below this line ---

const string COIN_PLATINUM = "crpi_coin_pp";
const string COIN_GOLD = "crpi_coin_gp";
const string COIN_ELECTRUM = "crpi_coin_ep";
const string COIN_SILVER = "crpi_coin_sp";
const string COIN_COPPER = "crpi_coin_cp";

const int VALUE_PLATINUM = 500;
const int VALUE_GOLD = 100;
const int VALUE_ELECTRUM = 50;
const int VALUE_SILVER = 10;
const int VALUE_COPPER = 1;

const int BASE_ITEM_COIN = 203;

const int ANIMATION_JUMP = ANIMATION_LOOPING_CUSTOM5;
const int ANIMATION_REST = ANIMATION_LOOPING_CUSTOM10;
const int ANIMATION_SPIKE_LOW = ANIMATION_LOOPING_CUSTOM4;
const int ANIMATION_LISTEN = ANIMATION_LOOPING_CUSTOM1;
