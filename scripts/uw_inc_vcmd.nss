#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: INC_VCMD.NSS                                                           :://
//:: Silver Marches Script                                                  :://
//::////////////////////////////////////////////////////////////////////////:://
/*
    Processes voice commands given by the server's
    clients.
*/
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By: Ashton Shapcott                                            :://
//:: Created On: Sept. 21, 2008                                             :://
//::////////////////////////////////////////////////////////////////////////:://
//:: Modified By: Ashton Shapcott                                           :://
//:: Modified On: Jan. 2, 2009                                              :://
//:: * Meddled with delimiters for better functionality.                    :://
//::                                                                        :://
//:: Modified By: Ashton Shapcott                                           :://
//:: Modified On: Nov. 4, 2010                                              :://
//:: * Added "save" base command.                                           :://
//:: * Added several entries to "roll" command.                             :://
//:: * Blanked out "lore" and "taunt" under "roll" command.                 :://
//:: * Renamed to inc_vcmd.nss.                                             :://
//:: * Renamed constants to be more consistent.                             :://
//::                                                                        :://
//:: Modified By: Ashton Shapcott                                           :://
//:: Modified On: Nov. 28, 2010                                             :://
//:: * Significant cleanup and removal of junk/confusing code.              :://
//:: * Work with active listener scripts to support general puppeteering.   :://
//:: * Work with local variables to switch to new, less risky names.        :://
//:: * Added new puppeteering selections (DOMINATED/TARGET).                :://
//::                                                                        :://
//:: Modified By: Ashton Shapcott                                           :://
//:: Modified On: Nov. 30, 2010                                             :://
//:: * Added additional emotes (point, thoughtful, cower, cross arms,       :://
//::   crouch, lay side).                                                   :://
//:: * Emotes are now routed through uw_inc instead of being contained in   :://
//::   separate scripts. This is part of the restructuring of the Utility   :://
//::   wand.                                                                :://
//::////////////////////////////////////////////////////////////////////////:://

#include "x3_inc_skin"

#include "inc_areas"
#include "inc_bind"
#include "inc_iss"
#include "inc_language"
#include "inc_save"
#include "inc_strings"
#include "inc_xp"
#include "inc_classes"
#include "inc_camp"
#include "inc_touching"
#include "inc_henchmen"
#include "inc_crossserver"
#include "inc_strings"
#include "inc_debug"

#include "uw_inc"

//::////////////////////////////////////////////////////////////////////////:://
//:: BASE COMMANDS                                                          :://
//::////////////////////////////////////////////////////////////////////////:://

const string VCMD_OPTION_FLAG = "-";

const string VCMD_ACTIVATOR = "/";
const string MAIN_DELIMITER = " ";

const string VCMD_DELIMITER = "/";

const string VCMD_MENU       = "m/menu";
const string VCMD_EMOTE      = "e/emote";
const string VCMD_ROLL       = "r/roll";
const string VCMD_SPEAKER    = "spk/speak";
const string VCMD_PUPPET     = "pup/puppet";
const string VCMD_SAVE       = "save";
const string VCMD_PASSWORD   = "pw/password";
const string VCMD_ASSOCIATE  = "associate";
const string VCMD_REDEEM     = "redeem";
const string VCMD_ACCOUNT    = "account";
const string VCMD_DAMAGEME   = "damageme";
const string VCMD_KILLME     = "killme";
const string VCMD_BIND       = "bind";
const string VCMD_PAUSE      = "pause";
const string VCMD_FIND       = "find";
const string VCMD_OBSCURE    = "obs/obscure";
const string VCMD_WILDSHAPE  = "ws/wildshape";
const string VCMD_CAMP       = "camp";
const string VCMD_TOUCH      = "touch";
const string VCMD_AREA       = "area";
const string VCMD_PATH       = "path";
const string VCMD_HENCH      = "summon/hench/sm";
const string VCMD_CROSSTELL  = "ct/crosstell";
const string VCMD_CROSSTELLP = "ctp/crosstellplayer";
const string VCMD_CROSSSHOUT = "cs/crossshout";
const string VCMD_PLAYERLIST = "pl/playerlist/list";

//::////////////////////////////////////////////////////////////////////////:://
//:: EMOTES                                                                 :://
//::////////////////////////////////////////////////////////////////////////:://

const string E_TABLE_DELIMITER = "/";

const string E_TABLE_STOP          = "stop/stand";
const string E_TABLE_SIT           = "sit";
const string E_TABLE_SPASM         = "spasm";
const string E_TABLE_STEAL         = "steal";
const string E_TABLE_WORSHIP       = "worship";
const string E_TABLE_PRAY          = "pray/meditate/kneel";
//const string E_TABLE_SMOKE         = "smoke";
const string E_TABLE_DODGE_SIDE    = "dodge";
const string E_TABLE_DODGE_DUCK    = "duck";
const string E_TABLE_DRUNK         = "sway/drunk";
const string E_TABLE_LAY_FRONT     = "front/prone/lay front/dead front";
const string E_TABLE_LAY_BACK      = "back/lay/lay back/dead back";
const string E_TABLE_CONJURE1      = "conjure/conjure mid/conjure 1";
const string E_TABLE_CONJURE2      = "conjure 2/conjure high";
const string E_TABLE_FORCEFUL      = "forceful/shout/yell";
const string E_TABLE_PLEAD         = "plead/beg/grovel";
const string E_TABLE_CROUCH        = "crouch/bend over/squat";
const string E_TABLE_LOOKFAR       = "shield eyes/look far/look";
//const string E_TABLE_TURNHEAD      = "turn head/left right";
const string E_TABLE_DANCE1        = "dance 1/victory 1/vict 1";
const string E_TABLE_DANCE2        = "dance 2/victory 2/vict 1";
const string E_TABLE_DANCE3        = "dance 3/victory 3/vict 3";
//const string E_TABLE_RANDOM_W      = "random walk/random";
const string E_TABLE_GET_MID       = "get mid/pick lock/open";
const string E_TABLE_GET_LOW       = "get low/pick up";
const string E_TABLE_SALUTE        = "salute";
const string E_TABLE_BOW           = "bow/curtsey";
const string E_TABLE_POINT         = "point/onward";
const string E_TABLE_THOUGHTFUL    = "thoughtful/look thoughtful/contemplative";
const string E_TABLE_COWER         = "cower/hold head";
const string E_TABLE_CROSS_ARMS    = "cross arms/cross";
const string E_TABLE_BECKON        = "beckon/gesture";
const string E_TABLE_LAY_SIDE      = "lay side/side";

//::////////////////////////////////////////////////////////////////////////:://
//:: ROLLS                                                                  :://
//::////////////////////////////////////////////////////////////////////////:://

const string R_TABLE_DELIMITER = "/";

//:: BASIC ROLLS

const string R_TABLE_D2    = "d2";
const string R_TABLE_D3    = "d3";
const string R_TABLE_D4    = "d4";
const string R_TABLE_D6    = "d6";
const string R_TABLE_D8    = "d8";
const string R_TABLE_D10   = "d10";
const string R_TABLE_D12   = "d12";
const string R_TABLE_D20   = "d20";
const string R_TABLE_D100  = "d100";

//:: STANDARD SKILLS

const string R_TABLE_EMPATHY           = "animal empathy/empathy";
const string R_TABLE_APPRAISE          = "appraise";
const string R_TABLE_BLUFF             = "bluff";
const string R_TABLE_CONCENTRATION     = "concentration/conc";
const string R_TABLE_DISABLE_TRAP      = "disable trap/disarm trap/disable/disarm";
const string R_TABLE_DISCIPLINE        = "discipline/disc";
const string R_TABLE_HEAL              = "heal";
const string R_TABLE_HIDE              = "hide";
const string R_TABLE_INTIMIDATE        = "intimidate/initm";
const string R_TABLE_LISTEN            = "listen";
//const string R_TABLE_LORE              = "lore";
const string R_TABLE_MOVE_SILENTLY     = "move silently/move silent/ms/sneak";
const string R_TABLE_OPEN_LOCK         = "open lock/open/pick lock/pick";
const string R_TABLE_PARRY             = "parry";
const string R_TABLE_PERFORM           = "perform";
const string R_TABLE_PERSUADE          = "persuade/diplomacy";
const string R_TABLE_PICKPOCKET        = "pickpocket/pick pocket/sleight of hand/sleight/sleight hand";
const string R_TABLE_SEARCH            = "search";
const string R_TABLE_SET_TRAP          = "set trap/use trap/set";
const string R_TABLE_SPELLCRAFT        = "spellcraft";
const string R_TABLE_SPOT              = "spot";
const string R_TABLE_TAUNT             = "taunt";
const string R_TABLE_TUMBLE            = "tumble";
const string R_TABLE_UMD               = "use magic device/use magic/use device/umd";
const string R_TABLE_RIDE              = "ride";
const string R_TABLE_C_ARMOR           = "craft armor/armor/craft armour/armour";
const string R_TABLE_C_WEAPON          = "craft weapon/weapon";
const string R_TABLE_C_TRAP            = "craft trap";

//:: NON-STANDARD SKILLS

const string R_TABLE_DECIPHER_SCRIPT       = "decipher script/decipher/read script/script";
const string R_TABLE_DISGUISE              = "disguise/disg";
const string R_TABLE_ESCAPE_ARTIST         = "escape artist/escape";
const string R_TABLE_FORGERY               = "forgery";
const string R_TABLE_GATHER_INFORMATION    = "gather information/gather info/information";
const string R_TABLE_K_ARCANA              = "knowledge arcana/arcana";
const string R_TABLE_K_DUNGEONEERING       = "knowledge dungeoneering/dungeoneering/knowledge dungeons/dungeons/knowledge dungeon/dungeon";
const string R_TABLE_K_ENGINEERING         = "knowledge engineering/engineering/knowledge architecture/architecture";
const string R_TABLE_K_GEOGRAPHY           = "knowledge geography/geography";
const string R_TABLE_K_HISTORY             = "knowledge history/history";
const string R_TABLE_K_LOCAL               = "knowledge local/local";
const string R_TABLE_K_NATURE              = "knowledge nature/nature";
const string R_TABLE_K_NOBILITY            = "knowledge nobility/knowledge royalty/knowledge noble/knowledge royal/royalty/nobility/royal/noble";
const string R_TABLE_K_PLANAR              = "knowledge planar/planar knowledge/planar/knowledge planes/planes knowledge/planes";
const string R_TABLE_K_RELIGION            = "knowledge religion/religion";
const string R_TABLE_SENSE_MOTIVE          = "sense motive/motive/sense";
const string R_TABLE_SURVIVAL              = "survival/surv";
const string R_TABLE_PROFESSION            = "profession/prof";
const string R_TABLE_ATHLETICS             = "athletics/althetic/ath/climb/jump/swim";

//:: SAVES

const string R_TABLE_FORTITUDE = "fortitude/fort";
const string R_TABLE_REFLEX    = "reflex/ref";
const string R_TABLE_WILL      = "will";

//:: ATTRIBUTES

const string R_TABLE_STR = "strength/str";
const string R_TABLE_DEX = "dexterity/dex";
const string R_TABLE_CON = "constitution/con";
const string R_TABLE_INT = "intelligence/int";
const string R_TABLE_WIS = "wisdom/wis";
const string R_TABLE_CHA = "charisma/cha";

//:: ASSOCIATE

const string ASSOC_DELIMITER = "/";

const string ASSOC_CDKEY = "cd key/cd/key";

//::////////////////////////////////////////////////////////////////////////:://
//:: SPEAK                                                                  :://
//::////////////////////////////////////////////////////////////////////////:://

const string SPK_DELIMITER = "/";

const string SPK_L_COMMON       = "common";
const string SPK_L_DROW_SIGN    = "drow sign";
const string SPK_L_UNDERCOMMON  = "undercommon";
const string SPK_L_AQUAN        = "aquan";
const string SPK_L_AURAN        = "auran";
const string SPK_L_GIANT        = "giant";
const string SPK_L_GNOLL        = "gnoll";
const string SPK_L_INGAN        = "ingan";
const string SPK_L_SYLVAN       = "sylvan";
const string SPK_L_TERRAN       = "terran";
const string SPK_L_TREANT       = "treant";
const string SPK_L_ALGARONDAN   = "algarondan";
const string SPK_L_ALZHEDO      = "alzhedo";
const string SPK_L_CHESSENTAN   = "chessentan";
const string SPK_L_CHONDATHAN   = "chondathan";
const string SPK_L_CHULTAN      = "chultan";
const string SPK_L_DAMARAN      = "damaran";
const string SPK_L_DAMBRATHAN   = "dambrathan";
const string SPK_L_DURPARI      = "durpari";
const string SPK_L_HALADRIM     = "haladrim";
const string SPK_L_HALRUAAN     = "halruaan";
const string SPK_L_ILLUSKAN     = "illuskan";
const string SPK_L_IMASKAR      = "imaskar";
const string SPK_L_LANTANESE    = "lantanese";
const string SPK_L_MIDANI       = "midani";
const string SPK_L_MULHORANDI   = "mulhorandi";
const string SPK_L_NEXALAN      = "nexalan";
const string SPK_L_OILLUSK      = "oillusk/oilusk";
const string SPK_L_RASHEMI      = "rashemi";
const string SPK_L_RAUMVIRA     = "raumvira/ramuvira";
const string SPK_L_SERUSAN      = "serusan";
const string SPK_L_SHAARAN      = "shaaran/sharan";
const string SPK_L_SHOU         = "shou";
const string SPK_L_TALFIRIC     = "talfiric/talrific";
const string SPK_L_TASHALAN     = "tashalan";
const string SPK_L_TUIGAN       = "tuigan";
const string SPK_L_TURMIC       = "turmic";
const string SPK_L_ULUIK        = "uluik";
const string SPK_L_UNTHERIC     = "untheric";
const string SPK_L_VAASAN       = "vaasan/vasan";
const string SPK_L_DRUIDIC      = "druidic/druid";
const string SPK_L_ASSASSIN     = "assassin";
const string SPK_L_TROLL        = "troll";
const string SPK_L_THRIKEEN     = "thrikeen/thri keen/thri-keen";
const string SPK_L_GRIMLOCK     = "grimlock";
const string SPK_L_KUOTOAN      = "kuotoan/kuo toan/kuo-toan";
const string SPK_L_MINOTAUR     = "minotaur";
const string SPK_L_RAKSHASA     = "rakshasa";
const string SPK_L_STINGER      = "stinger";
const string SPK_L_LIZARDMAN    = "lizardman/lizard";
const string SPK_L_ILLITHID     = "illithid/ilithid/mind flayer/mindflayer";
const string SPK_L_HOBGOBLIN    = "hobgoblin";
const string SPK_L_DUERGAR      = "duergar";
const string SPK_L_BUGBEAR      = "bugbear";
const string SPK_L_GITHZERAI    = "githzerai";
const string SPK_L_KORRED       = "korred";
const string SPK_L_SAHAGUIN     = "sahaguin/shaguin";
const string SPK_L_YAUNTI       = "yaunti/yaun ti/yauni-ti";
const string SPK_L_PIXIE        = "pixie";
const string SPK_L_HENGEYOKAI   = "hengeyokai";
const string SPK_L_SVIRFNEBLIN  = "svirfneblin";
const string SPK_L_HIGH_SHOU    = "high shou/highshou";
const string SPK_L_AVERIAL      = "averial/avarial";
const string SPK_L_KOBOLD       = "kobold";
const string SPK_L_OGRE         = "ogre";
const string SPK_L_DROW         = "drow";
const string SPK_L_INFERNAL     = "infernal/devilish/devil";
const string SPK_L_ABYSSAL      = "abyssal/demonic/demon";
const string SPK_L_CELESTIAL    = "celestial";
const string SPK_L_GOBLIN       = "goblin/goblinoid";
const string SPK_L_DRACONIC     = "draconic/dragon";
const string SPK_L_DWARVEN      = "dwarven/dwarfen/dwarf";
const string SPK_L_ELVEN        = "elven/elvish/elf";
const string SPK_L_GNOMISH      = "gnomish/gnome";
const string SPK_L_HALFLING     = "halfling/hin/hinnish/hinish";
const string SPK_L_ORCISH       = "orcish/orc";
const string SPK_L_CANT         = "cant";

//::////////////////////////////////////////////////////////////////////////:://
//:: PUPPETEERING                                                           :://
//::////////////////////////////////////////////////////////////////////////:://

const string PUPPET_DELIMITER = "/";

const string PUPPET_SELF        = "self/me";
const string PUPPET_FAMILIAR    = "familiar/fam/f";
const string PUPPET_COMPANION   = "animal companion/companion/ac";
const string PUPPET_SUMMON      = "summon/sum/s";
const string PUPPET_DOMINATED   = "dominated/dom/d";
const string PUPPET_TARGET      = "target/t";

//::////////////////////////////////////////////////////////////////////////:://
//:: INSTANCING                                                             :://
//::////////////////////////////////////////////////////////////////////////:://

const string AREA_TABLE_DELIMITER = "/";

const string AREA_TABLE_COPY         = "copy/create";
const string AREA_TABLE_DESTROY      = "destroy/delete";
const string AREA_TABLE_DESTROY_ALL  = "destroyall/deleteall";
const string AREA_TABLE_RENAME       = "rename";

//::////////////////////////////////////////////////////////////////////////:://
//:: HENCHMEN                                                               :://
//::////////////////////////////////////////////////////////////////////////:://

const string HENCH_UNSUMMON        = "uns/unsummon";
const string HENCH_STEALTH         = "hid/hide";
const string HENCH_MOVE            = "mov/move";

//::////////////////////////////////////////////////////////////////////////:://
//:: DECLARATION                                                            :://
//::////////////////////////////////////////////////////////////////////////:://

// **PRIVATE FUNCTION**
// Parses sMsg with sDelimiter, returning the subcommand.
//
// For example, if sMsg = "run x" and sDelimiter is " ", then "x" would be
// returned.
string ParseSubCommand(string sMsg, string sDelimiter = VCMD_DELIMITER);

// **PRIVATE FUNCTION**
// Parses sMsg with sDelimiter, returning the main command.
//
// For example, if sMsg = "run x" and sDelimiter is " ", then "run" would be
// returned.
string ParseCommand(string sMsg, string sDelimiter = VCMD_DELIMITER);

// **PRIVATE FUNCTION**
// Returns TRUE if sMsg is an acceptable command according to sCmdList using
// sDelimiter.
int GetIsCommand(string sMsg, string sCmdList, string sDelimiter = VCMD_DELIMITER);

// **PRIVATE FUNCTION**
// Wrapper for emote commands.
void DoEmoteVoiceCommand(object oPC, string sMsg);

// **PRIVATE FUNCTION**
// Wrapper for language commands.
void DoLanguageVoiceCommand(object oPC, string sMsg);

// **PRIVATE FUNCTION**
// Wrapper for menu commands.
void DoMenuVoiceCommand(object oPC, string sMsg);

// **PRIVATE FUNCTION**
// Wrapper for roll commands.
void DoRollVoiceCommand(object oPC, string sMsg);

// **PRIVATE FUNCTION**
// Wrapper for save commands.
void DoSaveVoiceCommand(object oPC, string sMsg);

// **PRIVATE FUNCTION**
// Wrapper for speaker commands.
void DoSpeakerVoiceCommand(object oPC, string sMsg);

// Parses sMsg for commands, taking appropriate action on oPC if necessary.
int ParseUtilityWandVoiceCommands(object oPC, string sMsg);

// Returns if sMsg is flagged as a command option.
int GetIsCommandOption(string sMsg, string sOptionFlag = VCMD_OPTION_FLAG);

//Does things with Henchmen.
void DoHenchmanCommand(object oPC, string sMsg);

// Cross-server commands
//void DoCrossTellCommand(object oPC, string sMsg);
void DoCrossTellPlayerCommand(object oPC, string sMsg);
void DoCrossShoutCommand(object oPC, string sMsg);
void DoPlayerListCommand(object oPC, string sMsg);

//::////////////////////////////////////////////////////////////////////////:://
//:: IMPLEMENTATION                                                         :://
//::////////////////////////////////////////////////////////////////////////:://

int GetIsCommandOption(string sMsg, string sOptionFlag = VCMD_OPTION_FLAG){
    return GetStringLeft(sMsg, 1) == sOptionFlag;
}

string ParseSubCommand(string sMsg, string sDelimiter = VCMD_DELIMITER){
    int iCount = FindSubString(sMsg, sDelimiter);

    if(iCount == -1) return "";

    int iLength = GetStringLength(sMsg);

    sMsg = GetStringRight(sMsg, iLength - (iCount + 1));

    return sMsg;
}

string ParseCommand(string sMsg, string sDelimiter = VCMD_DELIMITER){
    int iCount = FindSubString(sMsg, sDelimiter);

    if(iCount == -1) return sMsg;

    sMsg = GetStringLeft(sMsg, iCount);

    return sMsg;
}

int GetIsCommand(string sMsg, string sCmdList, string sDelimiter = VCMD_DELIMITER){
    string sCmd = ParseCommand(sCmdList, sDelimiter);
    sCmdList = ParseSubCommand(sCmdList, sDelimiter);

    if(sCmdList == sCmd){
        return sMsg == sCmd;
    }

    return sMsg == sCmd || GetIsCommand(sMsg, sCmdList, sDelimiter);
}

void DoEmoteVoiceCommand(object oPC, string sMsg){
    sMsg = ParseSubCommand(sMsg, MAIN_DELIMITER);

         if(GetIsCommand(sMsg, E_TABLE_STOP, E_TABLE_DELIMITER))        UtilityEmote(oPC, -1);
    else if(GetIsCommand(sMsg, E_TABLE_SIT, E_TABLE_DELIMITER))         UtilityEmote(oPC, ANIMATION_LOOPING_SIT_CROSS);
    else if(GetIsCommand(sMsg, E_TABLE_SPASM, E_TABLE_DELIMITER))       UtilityEmote(oPC, ANIMATION_LOOPING_SPASM);
    else if(GetIsCommand(sMsg, E_TABLE_STEAL, E_TABLE_DELIMITER))       UtilityEmote(oPC, ANIMATION_FIREFORGET_STEAL);
    else if(GetIsCommand(sMsg, E_TABLE_WORSHIP, E_TABLE_DELIMITER))     UtilityEmote(oPC, ANIMATION_LOOPING_WORSHIP);
    else if(GetIsCommand(sMsg, E_TABLE_PRAY, E_TABLE_DELIMITER))        UtilityEmote(oPC, ANIMATION_LOOPING_MEDITATE);
    else if(GetIsCommand(sMsg, E_TABLE_DODGE_SIDE, E_TABLE_DELIMITER))  UtilityEmote(oPC, ANIMATION_FIREFORGET_DODGE_SIDE);
    else if(GetIsCommand(sMsg, E_TABLE_DODGE_DUCK, E_TABLE_DELIMITER))  UtilityEmote(oPC, ANIMATION_FIREFORGET_DODGE_DUCK);
    else if(GetIsCommand(sMsg, E_TABLE_DRUNK, E_TABLE_DELIMITER))       UtilityEmote(oPC, ANIMATION_LOOPING_PAUSE_DRUNK);
    else if(GetIsCommand(sMsg, E_TABLE_LAY_FRONT, E_TABLE_DELIMITER))   UtilityEmote(oPC, ANIMATION_LOOPING_DEAD_FRONT);
    else if(GetIsCommand(sMsg, E_TABLE_LAY_BACK, E_TABLE_DELIMITER))    UtilityEmote(oPC, ANIMATION_LOOPING_DEAD_BACK);
    else if(GetIsCommand(sMsg, E_TABLE_CONJURE1, E_TABLE_DELIMITER))    UtilityEmote(oPC, ANIMATION_LOOPING_CONJURE1);
    else if(GetIsCommand(sMsg, E_TABLE_CONJURE2, E_TABLE_DELIMITER))    UtilityEmote(oPC, ANIMATION_LOOPING_CONJURE2);
    else if(GetIsCommand(sMsg, E_TABLE_FORCEFUL, E_TABLE_DELIMITER))    UtilityEmote(oPC, ANIMATION_LOOPING_TALK_FORCEFUL);
    else if(GetIsCommand(sMsg, E_TABLE_PLEAD, E_TABLE_DELIMITER))       UtilityEmote(oPC, ANIMATION_LOOPING_TALK_PLEADING);
//    else if(GetIsCommand(sMsg, E_TABLE_CROUCH, E_TABLE_DELIMITER))      UtilityEmote(oPC, );
    else if(GetIsCommand(sMsg, E_TABLE_LOOKFAR, E_TABLE_DELIMITER))     UtilityEmote(oPC, ANIMATION_LOOPING_LOOK_FAR);
    else if(GetIsCommand(sMsg, E_TABLE_DANCE1, E_TABLE_DELIMITER))      UtilityEmote(oPC, ANIMATION_FIREFORGET_VICTORY1);
    else if(GetIsCommand(sMsg, E_TABLE_DANCE2, E_TABLE_DELIMITER))      UtilityEmote(oPC, ANIMATION_FIREFORGET_VICTORY2);
    else if(GetIsCommand(sMsg, E_TABLE_DANCE3, E_TABLE_DELIMITER))      UtilityEmote(oPC, ANIMATION_FIREFORGET_VICTORY3);
    else if(GetIsCommand(sMsg, E_TABLE_GET_LOW, E_TABLE_DELIMITER))     UtilityEmote(oPC, ANIMATION_LOOPING_GET_LOW);
    else if(GetIsCommand(sMsg, E_TABLE_GET_MID, E_TABLE_DELIMITER))     UtilityEmote(oPC, ANIMATION_LOOPING_GET_MID);
    else if(GetIsCommand(sMsg, E_TABLE_SALUTE, E_TABLE_DELIMITER))      UtilityEmote(oPC, ANIMATION_FIREFORGET_SALUTE);
    else if(GetIsCommand(sMsg, E_TABLE_BOW, E_TABLE_DELIMITER))         UtilityEmote(oPC, ANIMATION_FIREFORGET_BOW);
//    else if(GetIsCommand(sMsg, E_TABLE_POINT, E_TABLE_DELIMITER))       UtilityEmote(oPC, );
//    else if(GetIsCommand(sMsg, E_TABLE_THOUGHTFUL, E_TABLE_DELIMITER))  UtilityEmote(oPC, );
//    else if(GetIsCommand(sMsg, E_TABLE_CROSS_ARMS, E_TABLE_DELIMITER))  UtilityEmote(oPC, );
//    else if(GetIsCommand(sMsg, E_TABLE_BECKON, E_TABLE_DELIMITER))      UtilityEmote(oPC, );
//    else if(GetIsCommand(sMsg, E_TABLE_LAY_SIDE, E_TABLE_DELIMITER))    UtilityEmote(oPC, );
    else SendUtilityErrorMessageToPC(oPC, UW_MSG_INVALID_COMMAND);
}

void DoMenuVoiceCommand(object oPC, string sMsg){
    SetUtilityTarget(oPC, oPC);

    DelayCommand(0.0, AssignCommand(oPC, ActionStartConversation(oPC, UW_MENU, TRUE, FALSE)));
}

void DoRollVoiceCommand(object oPC, string sMsg){
    sMsg = ParseSubCommand(sMsg, MAIN_DELIMITER);

    // ** NORMAL DICE

    if(GetIsCommand(sMsg, R_TABLE_D2, R_TABLE_DELIMITER))           UtilityRoll(oPC, UW_ROLL_TYPE_DICE, 2);
    else if(GetIsCommand(sMsg, R_TABLE_D3, R_TABLE_DELIMITER))      UtilityRoll(oPC, UW_ROLL_TYPE_DICE, 3);
    else if(GetIsCommand(sMsg, R_TABLE_D4, R_TABLE_DELIMITER))      UtilityRoll(oPC, UW_ROLL_TYPE_DICE, 4);
    else if(GetIsCommand(sMsg, R_TABLE_D6, R_TABLE_DELIMITER))      UtilityRoll(oPC, UW_ROLL_TYPE_DICE, 6);
    else if(GetIsCommand(sMsg, R_TABLE_D8, R_TABLE_DELIMITER))      UtilityRoll(oPC, UW_ROLL_TYPE_DICE, 8);
    else if(GetIsCommand(sMsg, R_TABLE_D10, R_TABLE_DELIMITER))     UtilityRoll(oPC, UW_ROLL_TYPE_DICE, 10);
    else if(GetIsCommand(sMsg, R_TABLE_D12, R_TABLE_DELIMITER))     UtilityRoll(oPC, UW_ROLL_TYPE_DICE, 12);
    else if(GetIsCommand(sMsg, R_TABLE_D20, R_TABLE_DELIMITER))     UtilityRoll(oPC, UW_ROLL_TYPE_DICE, 20);
    else if(GetIsCommand(sMsg, R_TABLE_D100, R_TABLE_DELIMITER))    UtilityRoll(oPC, UW_ROLL_TYPE_DICE, 100);
    else

    // ** STANDARD SKILLS

    if(GetIsCommand(sMsg, R_TABLE_EMPATHY, R_TABLE_DELIMITER))                  UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_ANIMAL_EMPATHY);
    else if(GetIsCommand(sMsg, R_TABLE_APPRAISE, R_TABLE_DELIMITER))            UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_APPRAISE);
    else if(GetIsCommand(sMsg, R_TABLE_BLUFF, R_TABLE_DELIMITER))               UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_BLUFF);
    else if(GetIsCommand(sMsg, R_TABLE_CONCENTRATION, R_TABLE_DELIMITER))       UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_CONCENTRATION);
    else if(GetIsCommand(sMsg, R_TABLE_C_ARMOR, R_TABLE_DELIMITER))             UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_CRAFT_ARMOR);
    else if(GetIsCommand(sMsg, R_TABLE_C_TRAP, R_TABLE_DELIMITER))              UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_CRAFT_TRAP);
    else if(GetIsCommand(sMsg, R_TABLE_C_WEAPON, R_TABLE_DELIMITER))            UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_CRAFT_WEAPON);
    else if(GetIsCommand(sMsg, R_TABLE_DISABLE_TRAP, R_TABLE_DELIMITER))        UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_DISABLE_TRAP);
    else if(GetIsCommand(sMsg, R_TABLE_DISCIPLINE, R_TABLE_DELIMITER))          UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_DISCIPLINE);
    else if(GetIsCommand(sMsg, R_TABLE_DISGUISE, R_TABLE_DELIMITER))            UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_DISGUISE);
    else if(GetIsCommand(sMsg, R_TABLE_ESCAPE_ARTIST, R_TABLE_DELIMITER))       UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_ESCAPE_ARTIST);
    else if(GetIsCommand(sMsg, R_TABLE_FORGERY, R_TABLE_DELIMITER))             UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_FORGERY);
    else if(GetIsCommand(sMsg, R_TABLE_GATHER_INFORMATION, R_TABLE_DELIMITER))  UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_GATHER_INFORMATION);
    else if(GetIsCommand(sMsg, R_TABLE_HEAL, R_TABLE_DELIMITER))                UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_HEAL);
    else if(GetIsCommand(sMsg, R_TABLE_HIDE, R_TABLE_DELIMITER))                UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_HIDE);
    else if(GetIsCommand(sMsg, R_TABLE_INTIMIDATE, R_TABLE_DELIMITER))          UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_INTIMIDATE);
    else if(GetIsCommand(sMsg, R_TABLE_K_ARCANA, R_TABLE_DELIMITER))            UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_K_ARCANA);
    else if(GetIsCommand(sMsg, R_TABLE_K_DUNGEONEERING, R_TABLE_DELIMITER))     UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_K_DUNGEONEERING);
    else if(GetIsCommand(sMsg, R_TABLE_K_ENGINEERING, R_TABLE_DELIMITER))       UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_K_ENGINEERING);
    else if(GetIsCommand(sMsg, R_TABLE_K_GEOGRAPHY, R_TABLE_DELIMITER))         UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_K_GEOGRAPHY);
    else if(GetIsCommand(sMsg, R_TABLE_K_HISTORY, R_TABLE_DELIMITER))           UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_K_HISTORY);
    else if(GetIsCommand(sMsg, R_TABLE_K_LOCAL, R_TABLE_DELIMITER))             UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_K_LOCAL);
    else if(GetIsCommand(sMsg, R_TABLE_K_NATURE, R_TABLE_DELIMITER))            UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_K_NATURE);
    else if(GetIsCommand(sMsg, R_TABLE_K_NOBILITY, R_TABLE_DELIMITER))          UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_K_NOBILITY);
    else if(GetIsCommand(sMsg, R_TABLE_K_PLANAR, R_TABLE_DELIMITER))            UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_K_PLANES);
    else if(GetIsCommand(sMsg, R_TABLE_K_RELIGION, R_TABLE_DELIMITER))          UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_K_RELIGION);
    else if(GetIsCommand(sMsg, R_TABLE_LISTEN, R_TABLE_DELIMITER))              UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_LISTEN);
    // else if(GetIsCommand(sMsg, R_TABLE_LORE, R_TABLE_DELIMITER))               UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_LORE);
    else if(GetIsCommand(sMsg, R_TABLE_MOVE_SILENTLY, R_TABLE_DELIMITER))       UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_MOVE_SILENTLY);
    else if(GetIsCommand(sMsg, R_TABLE_OPEN_LOCK, R_TABLE_DELIMITER))           UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_OPEN_LOCK);
    else if(GetIsCommand(sMsg, R_TABLE_PARRY, R_TABLE_DELIMITER))               UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_PARRY);
    else if(GetIsCommand(sMsg, R_TABLE_PERFORM, R_TABLE_DELIMITER))             UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_PERFORM);
    else if(GetIsCommand(sMsg, R_TABLE_PERSUADE, R_TABLE_DELIMITER))            UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_PERSUADE);
    else if(GetIsCommand(sMsg, R_TABLE_PICKPOCKET, R_TABLE_DELIMITER))          UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_PICK_POCKET);
    else if(GetIsCommand(sMsg, R_TABLE_RIDE, R_TABLE_DELIMITER))                UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_RIDE);
    else if(GetIsCommand(sMsg, R_TABLE_SEARCH, R_TABLE_DELIMITER))              UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_SEARCH);
    else if(GetIsCommand(sMsg, R_TABLE_SENSE_MOTIVE, R_TABLE_DELIMITER))        UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_SENSE_MOTIVE);
    else if(GetIsCommand(sMsg, R_TABLE_SET_TRAP, R_TABLE_DELIMITER))            UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_SET_TRAP);
    else if(GetIsCommand(sMsg, R_TABLE_SPELLCRAFT, R_TABLE_DELIMITER))          UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_SPELLCRAFT);
    else if(GetIsCommand(sMsg, R_TABLE_SPOT, R_TABLE_DELIMITER))                UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_SPOT);
    else if(GetIsCommand(sMsg, R_TABLE_SURVIVAL, R_TABLE_DELIMITER))            UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_SURVIVAL);
    else if(GetIsCommand(sMsg, R_TABLE_TAUNT, R_TABLE_DELIMITER))               UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_TAUNT);
    else if(GetIsCommand(sMsg, R_TABLE_TUMBLE, R_TABLE_DELIMITER))              UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_TUMBLE);
    else if(GetIsCommand(sMsg, R_TABLE_UMD, R_TABLE_DELIMITER))                 UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_USE_MAGIC_DEVICE);
    else if(GetIsCommand(sMsg, R_TABLE_PROFESSION, R_TABLE_DELIMITER))          UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_PROFESSION);
    else if(GetIsCommand(sMsg, R_TABLE_ATHLETICS, R_TABLE_DELIMITER))           UtilityRoll(oPC, UW_ROLL_TYPE_SKILL, SKILL_ATHLETICS);
    else

    // *** SAVES

    if(GetIsCommand(sMsg, R_TABLE_FORTITUDE, R_TABLE_DELIMITER))   UtilityRoll(oPC, UW_ROLL_TYPE_SAVE, SAVING_THROW_FORT);
    else if(GetIsCommand(sMsg, R_TABLE_REFLEX, R_TABLE_DELIMITER)) UtilityRoll(oPC, UW_ROLL_TYPE_SAVE, SAVING_THROW_REFLEX);
    else if(GetIsCommand(sMsg, R_TABLE_WILL, R_TABLE_DELIMITER))   UtilityRoll(oPC, UW_ROLL_TYPE_SAVE, SAVING_THROW_WILL);
    else

    // ** STATS

    if(GetIsCommand(sMsg, R_TABLE_STR, R_TABLE_DELIMITER))      UtilityRoll(oPC, UW_ROLL_TYPE_ABILITY, ABILITY_STRENGTH);
    else if(GetIsCommand(sMsg, R_TABLE_DEX, R_TABLE_DELIMITER)) UtilityRoll(oPC, UW_ROLL_TYPE_ABILITY, ABILITY_DEXTERITY);
    else if(GetIsCommand(sMsg, R_TABLE_CON, R_TABLE_DELIMITER)) UtilityRoll(oPC, UW_ROLL_TYPE_ABILITY, ABILITY_CONSTITUTION);
    else if(GetIsCommand(sMsg, R_TABLE_INT, R_TABLE_DELIMITER)) UtilityRoll(oPC, UW_ROLL_TYPE_ABILITY, ABILITY_INTELLIGENCE);
    else if(GetIsCommand(sMsg, R_TABLE_WIS, R_TABLE_DELIMITER)) UtilityRoll(oPC, UW_ROLL_TYPE_ABILITY, ABILITY_WISDOM);
    else if(GetIsCommand(sMsg, R_TABLE_CHA, R_TABLE_DELIMITER)) UtilityRoll(oPC, UW_ROLL_TYPE_ABILITY, ABILITY_CHARISMA);
    else SendUtilityErrorMessageToPC(oPC, UW_MSG_INVALID_COMMAND);
}

void DoSaveVoiceCommand(object oPC, string sMsg){
    SaveCharacter(oPC);
    FloatingTextStringOnCreature("Your character was saved successfully.", oPC, FALSE);
}

void DoSpeakerVoiceCommand(object oPC, string sMsg){
    sMsg = ParseSubCommand(sMsg, MAIN_DELIMITER);

    // Grab our chat, if any, before it's discarded.
    string sChat = ParseSubCommand(sMsg, MAIN_DELIMITER);
    sMsg = ParseCommand(sMsg, MAIN_DELIMITER);

    if(GetIsCommand(sMsg, SPK_L_COMMON, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_COMMON)) {
            SendMessageToPC(oPC, "You cannot speak common!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_COMMON)       : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_COMMON);
    } else if(GetIsCommand(sMsg, SPK_L_ABYSSAL, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_ABYSSAL)) {
            SendMessageToPC(oPC, "You cannot speak Abyssal!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_ABYSSAL)      : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_ABYSSAL);
    } else if(GetIsCommand(sMsg, SPK_L_ALGARONDAN, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_ALGARONDAN)) {
            SendMessageToPC(oPC, "You cannot speak Aglarondan!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_ALGARONDAN)   : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_ALGARONDAN);
    } else if(GetIsCommand(sMsg, SPK_L_ALZHEDO, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_ALZHEDO)) {
            SendMessageToPC(oPC, "You cannot speak Alzhedo!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_ALZHEDO)      : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_ALZHEDO);
    } else if(GetIsCommand(sMsg, SPK_L_AQUAN, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_AQUAN)) {
            SendMessageToPC(oPC, "You cannot speak Aquan!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_AQUAN)        : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_AQUAN);
    } else if(GetIsCommand(sMsg, SPK_L_ASSASSIN, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_ASSASSIN)) {
            SendMessageToPC(oPC, "You cannot speak Assassin's cant!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_ASSASSIN)     : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_ASSASSIN);
    } else if(GetIsCommand(sMsg, SPK_L_AURAN, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_AURAN)) {
            SendMessageToPC(oPC, "You cannot speak Auran!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_AURAN)        : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_AURAN);
    } else if(GetIsCommand(sMsg, SPK_L_AVERIAL, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_AVERIAL)) {
            SendMessageToPC(oPC, "You cannot speak Avarial!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_AVERIAL)      : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_AVERIAL);
    } else if(GetIsCommand(sMsg, SPK_L_BUGBEAR, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_BUGBEAR)) {
            SendMessageToPC(oPC, "You cannot speak Bugbear!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_BUGBEAR)      : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_BUGBEAR);
    } else if(GetIsCommand(sMsg, SPK_L_CANT, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_CANT)) {
            SendMessageToPC(oPC, "You cannot speak cant!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_CANT)         : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_CANT);
    } else if(GetIsCommand(sMsg, SPK_L_CELESTIAL, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_CELESTIAL)) {
            SendMessageToPC(oPC, "You cannot speak Celestial!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_CELESTIAL)    : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_CELESTIAL);
    } else if(GetIsCommand(sMsg, SPK_L_CHESSENTAN, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_CHESSENTAN)) {
            SendMessageToPC(oPC, "You cannot speak Chessentan!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_CHESSENTAN)   : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_CHESSENTAN);
    } else if(GetIsCommand(sMsg, SPK_L_CHONDATHAN, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_CHONDATHAN)) {
            SendMessageToPC(oPC, "You cannot speak Chondathan!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_CHONDATHAN)   : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_CHONDATHAN);
    } else if(GetIsCommand(sMsg, SPK_L_CHULTAN, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_CHULTAN)) {
            SendMessageToPC(oPC, "You cannot speak Chultan!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_CHULTAN)      : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_CHULTAN);
    } else if(GetIsCommand(sMsg, SPK_L_DAMARAN, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_DAMARAN)) {
            SendMessageToPC(oPC, "You cannot speak Damaran!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_DAMARAN)      : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_DAMARAN);
    } else if(GetIsCommand(sMsg, SPK_L_DAMBRATHAN, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_DAMBRATHAN)) {
            SendMessageToPC(oPC, "You cannot speak Dambrathan!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_DAMBRATHAN)   : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_DAMBRATHAN);
    } else if(GetIsCommand(sMsg, SPK_L_DRACONIC, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_DRACONIC)) {
            SendMessageToPC(oPC, "You cannot speak Draconic!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_DRACONIC)     : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_DRACONIC);
    } else if(GetIsCommand(sMsg, SPK_L_DROW, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_DROW)) {
            SendMessageToPC(oPC, "You cannot speak Drow!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_DROW)         : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_DROW);
    } else if(GetIsCommand(sMsg, SPK_L_DROW_SIGN, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_DROW_SIGN)) {
            SendMessageToPC(oPC, "You cannot speak Drow sign language!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_DROW_SIGN)    : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_DROW_SIGN);
    } else if(GetIsCommand(sMsg, SPK_L_DRUIDIC, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_DRUIDIC)) {
            SendMessageToPC(oPC, "You cannot speak Druidic!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_DRUIDIC)      : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_DRUIDIC);
    } else if(GetIsCommand(sMsg, SPK_L_DUERGAR, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_DUERGAR)) {
            SendMessageToPC(oPC, "You cannot speak Duergar!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_DUERGAR)      : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_DUERGAR);
    } else if(GetIsCommand(sMsg, SPK_L_DURPARI, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_DURPARI)) {
            SendMessageToPC(oPC, "You cannot speak Durpari!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_DURPARI)      : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_DURPARI);
    } else if(GetIsCommand(sMsg, SPK_L_DWARVEN, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_DWARVEN)) {
            SendMessageToPC(oPC, "You cannot speak Dwarven!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_DWARVEN)      : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_DWARVEN);
    } else if(GetIsCommand(sMsg, SPK_L_ELVEN, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_ELVEN)) {
            SendMessageToPC(oPC, "You cannot speak Elven!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_ELVEN)        : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_ELVEN);
    } else if(GetIsCommand(sMsg, SPK_L_GIANT, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_GIANT)) {
            SendMessageToPC(oPC, "You cannot speak Giant!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_GIANT)        : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_GIANT);
    } else if(GetIsCommand(sMsg, SPK_L_GITHZERAI, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_GITHZERAI)) {
            SendMessageToPC(oPC, "You cannot speak Githzerai!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_GITHZERAI)    : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_GITHZERAI);
    } else if(GetIsCommand(sMsg, SPK_L_GNOLL, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_GNOLL)) {
            SendMessageToPC(oPC, "You cannot speak Gnoll!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_GNOLL)        : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_GNOLL);
    } else if(GetIsCommand(sMsg, SPK_L_GNOMISH, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_GNOMISH)) {
            SendMessageToPC(oPC, "You cannot speak Gnomish!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_GNOMISH)      : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_GNOMISH);
    } else if(GetIsCommand(sMsg, SPK_L_GOBLIN, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_GOBLIN)) {
            SendMessageToPC(oPC, "You cannot speak Goblin!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_GOBLIN)       : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_GOBLIN);
    } else if(GetIsCommand(sMsg, SPK_L_GRIMLOCK, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_GRIMLOCK)) {
            SendMessageToPC(oPC, "You cannot speak Grimlock!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_GRIMLOCK)     : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_GRIMLOCK);
    } else if(GetIsCommand(sMsg, SPK_L_HALADRIM, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_HALARDRIM)) {
            SendMessageToPC(oPC, "You cannot speak Haladrim!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_HALARDRIM)    : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_HALARDRIM);
    }
    else if(GetIsCommand(sMsg, SPK_L_HALFLING, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_HALFLING)) {
            SendMessageToPC(oPC, "You cannot speak Halfling!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_HALFLING)     : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_HALFLING);
    } else if(GetIsCommand(sMsg, SPK_L_HALRUAAN, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_HALRUAAN)) {
            SendMessageToPC(oPC, "You cannot speak Halruaan!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_HALRUAAN)     : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_HALRUAAN);
    } else if(GetIsCommand(sMsg, SPK_L_HENGEYOKAI, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_HENGEYOKAI)) {
            SendMessageToPC(oPC, "You cannot speak Hengeyokai!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_HENGEYOKAI)   : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_HENGEYOKAI);
    } else if(GetIsCommand(sMsg, SPK_L_HIGH_SHOU, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_HIGH_SHOU)) {
            SendMessageToPC(oPC, "You cannot speak High Shou!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_HIGH_SHOU)    : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_HIGH_SHOU);
    } else if(GetIsCommand(sMsg, SPK_L_HOBGOBLIN, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_HOBGOBLIN)) {
            SendMessageToPC(oPC, "You cannot speak Hobgoblin!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_HOBGOBLIN)    : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_HOBGOBLIN);
    } else if(GetIsCommand(sMsg, SPK_L_ILLITHID, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_ILLITHID)) {
            SendMessageToPC(oPC, "You cannot speak Illithid!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_ILLITHID)     : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_ILLITHID);
    } else if(GetIsCommand(sMsg, SPK_L_ILLUSKAN, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_ILLUSKAN)) {
            SendMessageToPC(oPC, "You cannot speak Illuskan!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_ILLUSKAN)     : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_ILLUSKAN);
    } else if(GetIsCommand(sMsg, SPK_L_IMASKAR, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_IMASKAR)) {
            SendMessageToPC(oPC, "You cannot speak Imaskar!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_IMASKAR)      : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_IMASKAR);
    } else if(GetIsCommand(sMsg, SPK_L_INFERNAL, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_INFERNAL)) {
            SendMessageToPC(oPC, "You cannot speak Infernal!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_INFERNAL)     : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_INFERNAL);
    } else if(GetIsCommand(sMsg, SPK_L_INGAN, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_IGNAN)) {
            SendMessageToPC(oPC, "You cannot speak Ingan!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_IGNAN)        : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_IGNAN);
    } else if(GetIsCommand(sMsg, SPK_L_KOBOLD, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_KOBOLD)) {
            SendMessageToPC(oPC, "You cannot speak Kobold!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_KOBOLD)       : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_KOBOLD);
    } else if(GetIsCommand(sMsg, SPK_L_KORRED, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_KORRED)) {
            SendMessageToPC(oPC, "You cannot speak Korred!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_KORRED)       : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_KORRED);
    } else if(GetIsCommand(sMsg, SPK_L_KUOTOAN, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_KUOTOAN)) {
            SendMessageToPC(oPC, "You cannot speak Kuo Toan!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_KUOTOAN)      : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_KUOTOAN);
    } else if(GetIsCommand(sMsg, SPK_L_LANTANESE, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_LANTANESE)) {
            SendMessageToPC(oPC, "You cannot speak Lantanese!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_LANTANESE)    : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_LANTANESE);
    } else if(GetIsCommand(sMsg, SPK_L_LIZARDMAN, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_LIZARDMAN)) {
            SendMessageToPC(oPC, "You cannot speak Lizardfolk!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_LIZARDMAN)    : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_LIZARDMAN);
    } else if(GetIsCommand(sMsg, SPK_L_MIDANI, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_MIDANI)) {
            SendMessageToPC(oPC, "You cannot speak Midani!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_MIDANI)       : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_MIDANI);
    } else if(GetIsCommand(sMsg, SPK_L_MINOTAUR, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_MINOTAUR)) {
            SendMessageToPC(oPC, "You cannot speak Minotaur!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_MINOTAUR)     : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_MINOTAUR);
    } else if(GetIsCommand(sMsg, SPK_L_MULHORANDI, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_MULHORANDI)) {
            SendMessageToPC(oPC, "You cannot speak Mulhorandi!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_MULHORANDI)   : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_MULHORANDI);
    } else if(GetIsCommand(sMsg, SPK_L_NEXALAN, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_NEXALAN)) {
            SendMessageToPC(oPC, "You cannot speak Nexalan!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_NEXALAN)      : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_NEXALAN);
    } else if(GetIsCommand(sMsg, SPK_L_OGRE, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_OGRE)) {
            SendMessageToPC(oPC, "You cannot speak Ogre!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_OGRE)         : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_OGRE);
    } else if(GetIsCommand(sMsg, SPK_L_OILLUSK, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_OILLUSK)) {
            SendMessageToPC(oPC, "You cannot speak Oillusk!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_OILLUSK)      : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_OILLUSK);
    } else if(GetIsCommand(sMsg, SPK_L_ORCISH, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_ORCISH)) {
            SendMessageToPC(oPC, "You cannot speak Orcish!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_ORCISH)       : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_ORCISH);
    } else if(GetIsCommand(sMsg, SPK_L_PIXIE, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_PIXIE)) {
            SendMessageToPC(oPC, "You cannot speak Pixie!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_PIXIE)        : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_PIXIE);
    } else if(GetIsCommand(sMsg, SPK_L_RAKSHASA, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_RAKSHASA)) {
            SendMessageToPC(oPC, "You cannot speak Rakshasa!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_RAKSHASA)     : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_RAKSHASA);
    } else if(GetIsCommand(sMsg, SPK_L_RASHEMI, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_RASHEMI)) {
            SendMessageToPC(oPC, "You cannot speak Rashemi!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_RASHEMI)      : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_RASHEMI);
    } else if(GetIsCommand(sMsg, SPK_L_RAUMVIRA, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_RAUMVIRA)) {
            SendMessageToPC(oPC, "You cannot speak Raumvira!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_RAUMVIRA)     : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_RAUMVIRA);
    } else if(GetIsCommand(sMsg, SPK_L_SAHAGUIN, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_SAHAGUIN)) {
            SendMessageToPC(oPC, "You cannot speak Sahaguin!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_SAHAGUIN)     : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_SAHAGUIN);
    } else if(GetIsCommand(sMsg, SPK_L_SERUSAN, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_SERUSAN)) {
            SendMessageToPC(oPC, "You cannot speak Serusan!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_SERUSAN)      : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_SERUSAN);
    } else if(GetIsCommand(sMsg, SPK_L_SHAARAN, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_SHAARAN)) {
            SendMessageToPC(oPC, "You cannot speak Shaaran!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_SHAARAN)      : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_SHAARAN);
    } else if(GetIsCommand(sMsg, SPK_L_SHOU, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_SHOU)) {
            SendMessageToPC(oPC, "You cannot speak Shou!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_SHOU)         : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_SHOU);
    } else if(GetIsCommand(sMsg, SPK_L_STINGER, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_STINGER)) {
            SendMessageToPC(oPC, "You cannot speak Stinger!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_STINGER)      : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_STINGER);
    } else if(GetIsCommand(sMsg, SPK_L_SVIRFNEBLIN, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_SVIRFNEBLIN)) {
            SendMessageToPC(oPC, "You cannot speak Svirfneblin!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_SVIRFNEBLIN)  : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_SVIRFNEBLIN);
    } else if(GetIsCommand(sMsg, SPK_L_SYLVAN, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_SYLVAN)) {
            SendMessageToPC(oPC, "You cannot speak Sylvan!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_SYLVAN)       : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_SYLVAN);
    } else if(GetIsCommand(sMsg, SPK_L_TALFIRIC, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_TALFIRIC)) {
            SendMessageToPC(oPC, "You cannot speak Talfiric!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_TALFIRIC)     : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_TALFIRIC);
    } else if(GetIsCommand(sMsg, SPK_L_TASHALAN, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_TASHALAN)) {
            SendMessageToPC(oPC, "You cannot speak Tashalan!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_TASHALAN)     : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_TASHALAN);
    } else if(GetIsCommand(sMsg, SPK_L_TERRAN, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_TERRAN)) {
            SendMessageToPC(oPC, "You cannot speak Terran!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_TERRAN)       : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_TERRAN);
    } else if(GetIsCommand(sMsg, SPK_L_THRIKEEN, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_THRIKREEN)) {
            SendMessageToPC(oPC, "You cannot speak Thri-keen!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_THRIKREEN)    : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_THRIKREEN);
    } else if(GetIsCommand(sMsg, SPK_L_TREANT, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_TREANT)) {
            SendMessageToPC(oPC, "You cannot speak Treant!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_TREANT)       : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_TREANT);
    } else if(GetIsCommand(sMsg, SPK_L_TROLL, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_TROLL)) {
            SendMessageToPC(oPC, "You cannot speak Troll!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_TROLL)        : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_TROLL);
    } else if(GetIsCommand(sMsg, SPK_L_TUIGAN, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_TUIGAN)) {
            SendMessageToPC(oPC, "You cannot speak Tuigan!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_TUIGAN)       : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_TUIGAN);
    } else if(GetIsCommand(sMsg, SPK_L_TURMIC, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_TURMIC)) {
            SendMessageToPC(oPC, "You cannot speak Turmic!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_TURMIC)       : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_TURMIC);
    } else if(GetIsCommand(sMsg, SPK_L_ULUIK, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_ULUIK)) {
            SendMessageToPC(oPC, "You cannot speak Uluik!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_ULUIK)        : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_ULUIK);
    } else if(GetIsCommand(sMsg, SPK_L_UNDERCOMMON, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_UNDERCOMMON)) {
            SendMessageToPC(oPC, "You cannot speak Undercommon!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_UNDERCOMMON)  : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_UNDERCOMMON);
    } else if(GetIsCommand(sMsg, SPK_L_UNTHERIC, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_UNTHERIC)) {
            SendMessageToPC(oPC, "You cannot speak Untheric!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_UNTHERIC)     : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_UNTHERIC);
    } else if(GetIsCommand(sMsg, SPK_L_VAASAN, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_VAASAN)) {
            SendMessageToPC(oPC, "You cannot speak Vaasan!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_VAASAN)       : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_VAASAN);
    } else if(GetIsCommand(sMsg, SPK_L_YAUNTI, SPK_DELIMITER)) {
        if(!GetHasFeat(FEAT_LANGUAGE_YUANTI)) {
            SendMessageToPC(oPC, "You cannot speak Yuan-Ti!");
            return;
        }

        sChat == "" ? SetActiveLanguage(oPC, LANGUAGE_YUANTI)       : ProcessLanguageChat(oPC, sChat, GetPCChatVolume(), LANGUAGE_YUANTI);
    } else SendUtilityErrorMessageToPC(oPC, UW_MSG_INVALID_LANGUAGE);
}

void DoPuppetVoiceCommand(object oPC, string sMsg){
    object oPuppet;

    // Strikes off our intial command.
    sMsg = ParseSubCommand(sMsg, MAIN_DELIMITER);


    // Grab the text if we're trying to do a one-liner.
    string sChat = ParseSubCommand(sMsg, MAIN_DELIMITER);
    // Grab the actual command.
    sMsg = ParseCommand(sMsg, MAIN_DELIMITER);

    if(GetIsCommand(sMsg, PUPPET_SELF, PUPPET_DELIMITER))           oPuppet = oPC;
    else if(GetIsCommand(sMsg, PUPPET_FAMILIAR, PUPPET_DELIMITER))  oPuppet = GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC);
    else if(GetIsCommand(sMsg, PUPPET_COMPANION, PUPPET_DELIMITER)) oPuppet = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC);
    else if(GetIsCommand(sMsg, PUPPET_SUMMON, PUPPET_DELIMITER))    oPuppet = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC);
    else if(GetIsCommand(sMsg, PUPPET_DOMINATED, PUPPET_DELIMITER)) oPuppet = GetAssociate(ASSOCIATE_TYPE_DOMINATED, oPC);
    else if(GetIsCommand(sMsg, PUPPET_TARGET, PUPPET_DELIMITER))    oPuppet = GetUtilityTarget(oPC);

    SendMessageToPC(oPC, "Command for Puppet: " + sMsg);
    SendMessageToPC(oPC, "Chat for Puppet: " + sChat);

    // Subcommand will parse back the same text if there's no more subcommands.
    // This checks that we're dealing with additional input, not a repeat.
    if(sChat != "") AssignCommand(oPuppet, SpeakString(sChat));
    // Otherwise act as normal.
    else if(GetIsObjectValid(oPuppet)) SetPuppet(oPC, oPuppet);
    // If our puppet is invalid, say so.
    else SendUtilityErrorMessageToPC(oPC, UW_MSG_INVALID_PUPPET);
}

void DoPasswordVoiceCommand(object oPC, string sMsg){
    string sAccount = GetPCPlayerName(oPC);
    string sPassword = GetISSPassword(oPC);

    sMsg = ParseSubCommand(sMsg, MAIN_DELIMITER);

    if(!GetIsISSVerified(oPC)){
        if(sMsg == sPassword){
            SetIsISSVerified(oPC, TRUE);

            DelayCommand(1.0, AssignCommand(oPC, SKIN_SupportEquipSkin(SKIN_SupportGetSkin(oPC))));

            SendMessageToPC(oPC, ISS_MSG_SUCCESS);
        } else {
            SendUtilityErrorMessageToPC(oPC, ISS_MSG_FAILURE);
        }
    } else if(GetIsISSEnabled(oPC)) {
        string sOldPassword = ParseCommand(sMsg, " ");
        string sNewPassword = ParseSubCommand(sMsg, " ");

        if(GetStringLength(sNewPassword) < 6){
            SendUtilityErrorMessageToPC(oPC, ISS_MSG_TOO_SHORT);

            return;
        }

        if(sOldPassword == sPassword){
            SetISSPassword(oPC, sNewPassword);

            SendMessageToPC(oPC, ISS_MSG_CHANGE_PASSWORD);
        } else if(sOldPassword == "") {
            SendUtilityErrorMessageToPC(oPC, ISS_MSG_WRONG_SYNTAX);
        } else {
            SendUtilityErrorMessageToPC(oPC, ISS_MSG_FAILURE);
        }
    } else {
        if(GetStringLength(sMsg) < 6){
            SendUtilityErrorMessageToPC(oPC, ISS_MSG_TOO_SHORT);

            return;
        }

        SetIsISSEnabled(oPC, TRUE);

        SetISSPassword(oPC, sMsg);

        SendMessageToPC(oPC, ISS_MSG_ISS_ENABLED);
    }
}

// Currently UNUSED.
void DoAssociateVoiceCommand(object oPC, string sMsg){
    sMsg = ParseSubCommand(sMsg, MAIN_DELIMITER);

    if(GetIsCommand(sMsg, ASSOC_CDKEY, ASSOC_DELIMITER)){
        SetISSKey(oPC);

        DelayCommand(0.1, FloatingTextStringOnCreature("Your CD key has been associated with this account.", oPC, FALSE));
        DelayCommand(5.1, FloatingTextStringOnCreature("If you had a previously associated CD key, it has been replaced.", oPC, FALSE));
    }
}

void DoRedeemVoiceCommand(object oPC, string sMsg){
    sMsg = ParseSubCommand(sMsg, MAIN_DELIMITER);

    int nRedeemXP = StringToInt(sMsg);
    int nAccountXP = GetAccountXP(oPC);

    int nCurrentCap = GetPersistentInt(oPC, "FAERY_AWARD");

    if(nAccountXP < 1){
        SendUtilityErrorMessageToPC(oPC, "You have no account experience to redeem.");

        return;
    }

    if((nRedeemXP == 0 && sMsg != "0") || (nRedeemXP < 0)){
        SendUtilityErrorMessageToPC(oPC, "You must enter an integer value greater than 0 to redeem.");

        return;
    }

    if(nRedeemXP > nAccountXP){
        nRedeemXP = nAccountXP;
    }

    //if(nCurrentCap + nRedeemXP > FAERY_CAP - nCurrentCap)
    if(nRedeemXP+nCurrentCap > FAERY_CAP)
    {
        nRedeemXP = FAERY_CAP - nCurrentCap;

        ModifyXPCap(oPC, nRedeemXP);

        ModifyAccountXP(oPC, -nRedeemXP);

        SetPersistentInt_player(GetName(oPC),GetPCPlayerName(oPC), "FAERY_AWARD", nRedeemXP + GetPersistentInt_player(GetName(oPC),GetPCPlayerName(oPC),"FAERY_AWARD"));

        SendMessageToPC(oPC, "You have redeemed " + IntToString(nRedeemXP) + "XP, bringing your character's cap to its maximum for this time period.");
    } else {
        ModifyXPCap(oPC, nRedeemXP);

        ModifyAccountXP(oPC, -nRedeemXP);

        SetPersistentInt_player(GetName(oPC),GetPCPlayerName(oPC), "FAERY_AWARD", nRedeemXP + GetPersistentInt_player(GetName(oPC),GetPCPlayerName(oPC),"FAERY_AWARD"));

        SendMessageToPC(oPC, "You have redeemed " + IntToString(nRedeemXP) + "XP towards your character's cap.");
    }
}

void DoAccountVoiceCommand(object oPC, string sMsg){
    SendMessageToPC(oPC, "Combat Soft Cap: " + IntToString(GetXP(oPC)) + "/" + IntToString(GetXPCap(oPC)+ GetRoleplayXP(oPC)));
    SendMessageToPC(oPC, "Daily Faery Gains: " + IntToString(GetRoleplayXPDaily(oPC)/FAERY_RP_AWARD) + "/" + IntToString(FAERY_RP_CAP_DAILY/FAERY_RP_AWARD));
    SendMessageToPC(oPC, "Weekly Faery Gains: " + IntToString(GetRoleplayXPWeekly(oPC)/FAERY_RP_AWARD) + "/" + IntToString(FAERY_RP_CAP_WEEKLY/FAERY_RP_AWARD));
    SendMessageToPC(oPC, "Weekly Combat Softcap Gains: " + IntToString(GetPersistentInt_player(GetName(oPC),GetPCPlayerName(oPC), "FAERY_AWARD")/FAERY_AWARD)+"/" + IntToString(FAERY_CAP/FAERY_AWARD));
    SendMessageToPC(oPC, "Account XP: " + IntToString(GetAccountXP(oPC)));
}

void DoDamageMeVoiceCommand(object oPC, string sMsg){
    sMsg = ParseSubCommand(sMsg, MAIN_DELIMITER);

    int nDamage = StringToInt(sMsg);

    if(nDamage < 1){
        SendUtilityErrorMessageToPC(oPC, UW_MSG_INVALID_INPUT);
    } else {
        effect eDamage = EffectDamage(nDamage);

        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
    }
}

void DoKillMeVoiceCommand(object oPC, string sMsg){
    effect eDeath = EffectDeath();

    eDeath = SupernaturalEffect(eDeath);

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oPC);
}

void DoBindVoiceCommand(object oPC, string sMsg){
    object oBind = GetBindPoint(GetArea(oPC));

    if(!GetIsObjectValid(oBind)){
        SendUtilityErrorMessageToPC(oPC, "This area does not have a bind point.");
        return;
    }

    SetBindPoint(oPC, oBind);
}

void DoFindVoiceCommand(object oPC, string sMsg) {
    object oCharacter = GetFirstPC();

    while(GetIsObjectValid(oCharacter)) {
        if(!GetPersistentInt(oCharacter, "PC_OBSCURED"))
            SendMessageToPC(oPC, GetName(oCharacter) + " - " + GetName(GetArea(oCharacter)));

        oCharacter = GetNextPC();
    }
}

void DoObscureVoiceCommand(object oPC, string sMsg) {
    if(!GetPersistentInt(oPC, "PC_OBSCURED")) {
        SetPersistentInt(oPC, "PC_OBSCURED", 1);
        SendMessageToPC(oPC, "You are now obscured.");
    } else if(GetPersistentInt(oPC, "PC_OBSCURED")) {
        SetPersistentInt(oPC, "PC_OBSCURED", 0);
        SendMessageToPC(oPC, "You are no longer obscured.");
    }
}

void DoCampVoiceCommand(object oPC, string sMsg) {
    if(GetIsAreaInterior(GetArea(oPC))) {
        SendMessageToPC(oPC, "You cannot camp in an interior area.");
        return;
    }

    if(GetStringLeft(GetTag(GetArea(oPC)), 4) == "ooc_") {
        SendMessageToPC(oPC, "You cannot camp in an out-of-character area.");
        return;
    }

    if(GetPersistentInt(oPC, "SYS_CAMP_DELAY") > 0) {
        SendMessageToPC(oPC, "You cannot attempt to camp more than once every ten minutes!");
        return;
    }

    if(GetIsSkillSuccessful(oPC, SKILL_SURVIVAL, 10) && GetLocalInt(oPC, "Unrestable") != 1) {
        object cfire = CreateObject(OBJECT_TYPE_PLACEABLE, "_campfire", GetLocation(oPC));
        DelayCommand(1200.0, DestroyObject(cfire));
        SendMessageToPC(oPC, "You successfully set up camp!");
    } else {
        SendMessageToPC(oPC, "You fail to set up camp here!");
    }

    SetPersistentInt(oPC, "SYS_CAMP_DELAY", 10);
    SetLocalInt(oPC, "sys_camp_attempted", 1);
    DelayCommand(60.0, DoCampTimer(oPC));
}

void DoWildshapeVoiceCommand(object oPC, string sMsg) {
    sMsg = ParseSubCommand(sMsg, MAIN_DELIMITER);

    if(sMsg == "" || sMsg == "help") {
        SendMessageToPC(oPC, "--------------------------------------");
        SendMessageToPC(oPC, "------------Wildshape Forms-----------");
        SendMessageToPC(oPC, "form name - HD required - +str/dex/con");
        SendMessageToPC(oPC, "command syntax: /wildshape formname");
        SendMessageToPC(oPC, "--------------------------------------");
        SendMessageToPC(oPC, "base -> shift out of wildshape");
        SendMessageToPC(oPC, "black-bear      - 12 - 6/2/4");
        SendMessageToPC(oPC, "gray-wolf       - 12 - 4/6/2");
        SendMessageToPC(oPC, "tiger           - 12 - 4/2/6");
        SendMessageToPC(oPC, "lion            - 12 - 6/4/2");
        SendMessageToPC(oPC, "lion-maneless   - 12 - 6/4/2");
        SendMessageToPC(oPC, "cheetah         - 12 - 2/6/4");
        SendMessageToPC(oPC, "panther         - 12 - 4/6/2");
        SendMessageToPC(oPC, "jaguar          - 12 - 6/4/2");
        SendMessageToPC(oPC, "leopard         - 12 - 4/6/2");
        SendMessageToPC(oPC, "crocodile       - 12 - 6/2/4");
        SendMessageToPC(oPC, "shark           - 12 - 6/4/2");
        SendMessageToPC(oPC, "eagle           - 12 - 2/6/4");
        SendMessageToPC(oPC, "husky           -  8 - 2/0/4");
        SendMessageToPC(oPC, "malamute        -  8 - 2/0/4");
        SendMessageToPC(oPC, "mastiff         -  8 - 4/0/2");
        SendMessageToPC(oPC, "dalmatian       -  8 - 0/4/2");
        SendMessageToPC(oPC, "doberman        -  8 - 2/0/4");
        SendMessageToPC(oPC, "lab             -  8 - 2/0/4");
        SendMessageToPC(oPC, "viper           -  8 - 2/4/0");
        SendMessageToPC(oPC, "wolverine       -  8 - 4/0/2");
        SendMessageToPC(oPC, "spotted-hyena   -  8 - 0/4/2");
        SendMessageToPC(oPC, "striped-hyena   -  8 - 0/4/2");
        SendMessageToPC(oPC, "camel           -  8 - 0/2/4");
        SendMessageToPC(oPC, "brown-horse     -  8 - 0/4/2");
        SendMessageToPC(oPC, "bison           -  8 - 4/0/2");
        SendMessageToPC(oPC, "hawk            -  8 - 0/4/2");
        SendMessageToPC(oPC, "bat             -  4 - 0/2/0");
        SendMessageToPC(oPC, "fruit-bat       -  4 - 0/2/0");
        SendMessageToPC(oPC, "rat             -  4 - 0/0/2");
        SendMessageToPC(oPC, "rabbit          -  4 - 2/0/0");
        SendMessageToPC(oPC, "black-white-cat -  4 - 0/2/0");
        SendMessageToPC(oPC, "black-cat       -  4 - 0/2/0");
        SendMessageToPC(oPC, "terrier         -  4 - 2/0/0");
        SendMessageToPC(oPC, "badger          -  4 - 0/0/2");
        SendMessageToPC(oPC, "boar            -  4 - 2/0/0");
        SendMessageToPC(oPC, "raven           -  4 - 0/0/2");
        SendMessageToPC(oPC, "barn-owl        -  4 - 0/0/2");
        return;
    }
    if(sMsg == "base") {
        DoEndDruidPolymorph(oPC);
        return;
    }

    int iForm = DoTranslateNameToForm(sMsg);

    if(iForm == DRUID_FORM_NULL) {
        SendMessageToPC(oPC, "Invalid form specified.");
        return;
    }

    DoDruidPolymorph(oPC, iForm);
}

void DoTouchVoiceCommand(object oPC, string sMsg) {
    sMsg = ParseSubCommand(sMsg, MAIN_DELIMITER);

    if(sMsg == "enable") EnableTouching(oPC);
    else if(sMsg == "disable") DisableTouching(oPC);
    else SendMessageToPC(oPC, "Invalid command syntax. Options are enable/disable.");
}

void DoPauseVoiceCommand(object oPC, string sMsg){
    if(!GetIsDM(oPC)){
        SendUtilityErrorMessageToPC(oPC, UW_MSG_DM_EXCLUSIVE);
        return;
    }

    object oArea = GetArea(oPC);

    SetIsAreaPaused(oArea, !GetIsAreaPaused(oArea));

    if(GetIsAreaPaused(oArea)) FloatingTextStringOnCreature("Area paused.", oPC, FALSE);
    else                       FloatingTextStringOnCreature("Area unpaused.", oPC, FALSE);
}

void DoAreaVoiceCommand(object oPC, string sMsg){
    if(!GetIsDM(oPC)){
        SendUtilityErrorMessageToPC(oPC, UW_MSG_DM_EXCLUSIVE);
        return;
    }

    sMsg = ParseSubCommand(sMsg, MAIN_DELIMITER);

    // Snatch the new name.
    string sName = ParseSubCommand(sMsg, MAIN_DELIMITER);

    sMsg = ParseCommand(sMsg, MAIN_DELIMITER);

    object oArea = GetArea(oPC);

         if(GetIsCommand(sMsg, AREA_TABLE_COPY,        AREA_TABLE_DELIMITER)) CreateDMAreaInstance(oPC, oArea, sName);
    else if(GetIsCommand(sMsg, AREA_TABLE_DESTROY,     AREA_TABLE_DELIMITER)) DestroyDMAreaInstance(oPC, oArea);
    else if(GetIsCommand(sMsg, AREA_TABLE_DESTROY_ALL, AREA_TABLE_DELIMITER)) DestroyAllDMAreaInstances(oPC);
    else if(GetIsCommand(sMsg, AREA_TABLE_RENAME,      AREA_TABLE_DELIMITER)){

        SetAreaName(oArea, sName);

        FloatingTextStringOnCreature("Area renamed to: " + sName, oPC, FALSE);
    }
}

void DoPathVoiceCommand(object oPC, string sMsg){
    if(!GetIsDM(oPC)){
        SendUtilityErrorMessageToPC(oPC, UW_MSG_DM_EXCLUSIVE);
        return;
    }

    CreateDynamicTransition(oPC, GetLocation(oPC));
}

void DoHenchmanCommand(object oPC, string sMsg) {
    sMsg = ParseSubCommand(sMsg, MAIN_DELIMITER);

         if(GetIsCommand(sMsg, HENCH_UNSUMMON,     MAIN_DELIMITER))    UnsummonAll(oPC);
    else if(GetIsCommand(sMsg, HENCH_STEALTH,      MAIN_DELIMITER))    HenchmanEnterStealth(oPC);
    else if(GetIsCommand(sMsg, HENCH_MOVE,         MAIN_DELIMITER))    HenchmanMoveToPoint(GetUtilityTarget(oPC), GetUtilityLocation(oPC));
}

/*

// NOTE - This function WILL NOT work due to name collisions across different
//        Gamespy accounts. Commented out in the event of a fix at a latter date,
//        but for now should NOT be used.

void DoCrossTellCommand(object oPC, string sMsg) {
    sMsg = ParseSubCommand(sMsg, MAIN_DELIMITER);

    int iCount = FindSubString(sMsg, MAIN_DELIMITER);
    if(iCount == -1) {
        SendMessageToPC(oPC, "Malformatted command: syntax /ct targetname message");
        return;
    }
    int iLength = GetStringLength(sMsg);
    sMsg = GetStringRight(sMsg, iLength - (iCount + 1));

    string sTargetName = GetSubString(sMsg, 0, iCount);
    string sTellMsg = GetSubString(sMsg, iCount + 1, iLength);

    int nPCCurrentServer = GetCurrentServer(oPC);
    int nTargetCurrentServer = GetCurrentServerByName(sTargetName);

    if(nPCCurrentServer < 0) {
        SendMessageToDevelopers("Error accessing PC login database table.");
        return;
    }

    if(nTargetCurrentServer < 0) {
        SendMessageToPC(oPC, "The target player is not logged in on any instance.");
        return;
    }

    WriteTellToBuffer(GetPCPlayerName(oPC), GetName(oPC), GetCurrentServer(oPC), "", sTargetName, GetCurrentServerByName(sTargetName), sTellMsg);
}*/

void DoCrossTellPlayerCommand(object oPC, string sMsg) {
    sMsg = ParseSubCommand(sMsg, MAIN_DELIMITER);

    string sTargetAccountName;
    string sTellMsg;

    if(sMsg == "") sTargetAccountName = GetLocalString(oPC, "SYS_XSERV_TELL_TARGET");

    int iCount = FindSubString(sMsg, MAIN_DELIMITER);
    if(iCount == -1) {
        SendMessageToPC(oPC, "Malformatted command: syntax /ctp targetaccount message");
        return;
    }
    int iLength = GetStringLength(sMsg);
    sMsg = GetStringRight(sMsg, iLength - (iCount + 1));

    sTargetAccountName = GetSubString(sMsg, 0, iCount);
    SendMessageToDevelopers("DoCrossTellPlayerCommand - Target Account: " + sTargetAccountName);
    sTellMsg = GetSubString(sMsg, iCount + 1, iLength);
    SendMessageToDevelopers("DoCrossTellPlayerCommand - Message Contents: " + sTellMsg);

    int nPCCurrentServer = GetCurrentServer(oPC);
    int nTargetCurrentServer = GetCurrentServerByAccount(sTargetAccountName);

    if(nPCCurrentServer < 0) {
        SendMessageToDevelopers("Error accessing PC login database table.");
        return;
    }

    if(nTargetCurrentServer < 0) {
        SendMessageToPC(oPC, "The target player is not logged in on any instance.");
        return;
    }

    WriteTellToBuffer(GetPCPlayerName(oPC), GetName(oPC), nPCCurrentServer, sTargetAccountName, "", nTargetCurrentServer, sTellMsg);
    SendMessageToPC(oPC, ColorString("---", 0, 255, 0));
    SendMessageToPC(oPC, ColorString("[TELL]::" + GetPCPlayerName(oPC) + "::" + GetName(oPC) + "::->::" + sTargetAccountName + "::", 0, 255, 0));
    SendMessageToPC(oPC, ColorString(sTellMsg, 0, 255, 0));
    SendMessageToPC(oPC, ColorString("---", 0, 255, 0));

    SetLocalString(oPC, "SYS_XSERV_TELL_TARGET", sTargetAccountName);
}

void DoCrossShoutCommand(object oPC, string sMsg) {
    sMsg = ParseSubCommand(sMsg, MAIN_DELIMITER);

    if(!GetIsDM(oPC)) {
        SendMessageToPC(oPC, "Only Dungeon Masters may access the shout functionality.");
        return;
    }

    WriteShoutToBuffer(GetPCPlayerName(oPC), GetName(oPC), GetCurrentServer(oPC), sMsg);
}

void DoPlayerListCommand(object oPC, string sMsg) {
    ListAllPlayersLoggedIn(oPC);
}

int ParseUtilityWandVoiceCommands(object oPC, string sMsg){

    // ********************************************************************** //
    //                              ISS HANDLER                               //
    // ********************************************************************** //

    if(!GetIsISSVerified(oPC) && !GetIsDMPossessed(oPC)){
        SetPCChatMessage();

        sMsg = GetStringRight(sMsg, GetStringLength(sMsg) - 1);
        string sCmd = ParseCommand(sMsg, MAIN_DELIMITER);

        if(GetIsCommand(sCmd, VCMD_PASSWORD)) DoPasswordVoiceCommand(oPC, sMsg);
        // Error message.
        else SendUtilityErrorMessageToPC(oPC, ISS_MSG_CHAT);

        return TRUE;
    }

    // ********************************************************************** //
    //                        PASSIVE LISTENER COMMANDS                       //
    // ********************************************************************** //

    if(GetStringLeft(sMsg, 1) == VCMD_ACTIVATOR){
        SetPCChatMessage();

        sMsg = GetStringRight(sMsg, GetStringLength(sMsg) - 1);
        string sCmd = ParseCommand(sMsg, MAIN_DELIMITER);

        if(GetIsCommand(sCmd, VCMD_MENU))            DoMenuVoiceCommand(oPC, sMsg);
        else if(GetIsCommand(sCmd, VCMD_EMOTE))      DoEmoteVoiceCommand(oPC, sMsg);
        else if(GetIsCommand(sCmd, VCMD_ROLL))       DoRollVoiceCommand(oPC, sMsg);
        else if(GetIsCommand(sCmd, VCMD_SAVE))       DoSaveVoiceCommand(oPC, sMsg);
        else if(GetIsCommand(sCmd, VCMD_SPEAKER))    DoSpeakerVoiceCommand(oPC, sMsg);
        else if(GetIsCommand(sCmd, VCMD_PUPPET))     DoPuppetVoiceCommand(oPC, sMsg);
        else if(GetIsCommand(sCmd, VCMD_PASSWORD))   DoPasswordVoiceCommand(oPC, sMsg);
        else if(GetIsCommand(sCmd, VCMD_REDEEM))     DoRedeemVoiceCommand(oPC, sMsg);
        else if(GetIsCommand(sCmd, VCMD_ACCOUNT))    DoAccountVoiceCommand(oPC, sMsg);
        else if(GetIsCommand(sCmd, VCMD_DAMAGEME))   DoDamageMeVoiceCommand(oPC, sMsg);
        else if(GetIsCommand(sCmd, VCMD_KILLME))     DoKillMeVoiceCommand(oPC, sMsg);
        else if(GetIsCommand(sCmd, VCMD_BIND))       DoBindVoiceCommand(oPC, sMsg);
        else if(GetIsCommand(sCmd, VCMD_FIND))       DoFindVoiceCommand(oPC, sMsg);
        else if(GetIsCommand(sCmd, VCMD_OBSCURE))    DoObscureVoiceCommand(oPC, sMsg);
        else if(GetIsCommand(sCmd, VCMD_WILDSHAPE))  DoWildshapeVoiceCommand(oPC, sMsg);
        else if(GetIsCommand(sCmd, VCMD_CAMP))       DoCampVoiceCommand(oPC, sMsg);
        else if(GetIsCommand(sCmd, VCMD_TOUCH))      DoTouchVoiceCommand(oPC, sMsg);
        else if(GetIsCommand(sCmd, VCMD_HENCH))      DoHenchmanCommand(oPC, sMsg);
        //else if(GetIsCommand(sCmd, VCMD_CROSSTELL))  DoCrossTellCommand(oPC, sMsg);
        else if(GetIsCommand(sCmd, VCMD_CROSSTELLP)) DoCrossTellPlayerCommand(oPC, sMsg);
        else if(GetIsCommand(sCmd, VCMD_CROSSSHOUT)) DoCrossShoutCommand(oPC, sMsg);
        else if(GetIsCommand(sCmd, VCMD_PLAYERLIST)) DoPlayerListCommand(oPC, sMsg);
        // DM Exclusive Commands
        else if(GetIsCommand(sCmd, VCMD_PAUSE))      DoPauseVoiceCommand(oPC, sMsg);
        else if(GetIsCommand(sCmd, VCMD_AREA))       DoAreaVoiceCommand(oPC, sMsg);
        else if(GetIsCommand(sCmd, VCMD_PATH))       DoPathVoiceCommand(oPC, sMsg);
        //else if(GetIsCommand(sCmd, VCMD_ASSOCIATE)) DoAssociateVoiceCommand(oPC, sMsg);
        // Error message.
        else SendUtilityErrorMessageToPC(oPC, UW_MSG_INVALID_COMMAND);

        return TRUE;
    } else

    // ********************************************************************** //
    //                         ACTIVE LISTENER COMMANDS                       //
    // ********************************************************************** //

    if (GetLocalInt(oPC, "UW_LISTEN")){
        if(GetLocalInt(oPC, "UW_PUPPETEERING")){
            SetPCChatMessage();

            object oTarget = GetPuppet(oPC);

            if(!GetIsObjectValid(oTarget)){
                RemovePuppet(oPC);
                return TRUE;
            }

            AssignCommand(oTarget, SpeakString(sMsg, GetPCChatVolume()));

            return TRUE;
        }
    }

    return FALSE;
}
