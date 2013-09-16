//::////////////////////////////////////////////////////////////////////////:://
//:: EVENT TYPES                                                            :://
//::////////////////////////////////////////////////////////////////////////:://

const int EVENT_TYPE_ALL                = 0;

// SaveChar
//    - OBJECT_SELF        = Character saved
const int EVENT_TYPE_SAVE_CHAR          = 1;

// PickPocket (can be blocked from script)
//    - OBJECT_SELF        = Thief
//    - GetEventTarget()   = Victim
const int EVENT_TYPE_PICKPOCKET         = 2;

// Attack
//    - OBJECT_SELF        = Attacker
//    - GetEventTarget()   = Target
const int EVENT_TYPE_ATTACK             = 3;

// UseItem (can be blocked from script)
//    - OBJECT_SELF        = Item user
//    - GetEventTarget()   = Item target
//    - GetEventItem()     = Item used
//    - GetEventPosition() = Target position (as a vector)
const int EVENT_TYPE_USE_ITEM           = 4;

// QuickChat (can be blocked from script)
//    - OBJECT_SELF        = Talker
//    - GetEventSubType()  = QuickChat ID
const int EVENT_TYPE_QUICKCHAT          = 5;

// Examine (can be blocked from script except OnExamineItem)
//    - OBJECT_SELF        = Examiner
//    - GetEventTarget()   = Thing to be examined
const int EVENT_TYPE_EXAMINE            = 6;

// UseSkill (can be blocked from script)
//    - OBJECT_SELF        = Skill user
//    - GetEventSubType()  = Skill ID (SKILL_*)
//    - GetEventTarget()   = Skill target
//    - GetEventPosition() = Skill target position (as a vector)
//    - GetEventItem()     = Item associated with the skill
const int EVENT_TYPE_USE_SKILL          = 7;

// UseFeat (can be blocked from script)
//    - OBJECT_SELF        = Feat user
//    - GetEventSubType()  = Feat ID (FEAT_*)
//    - GetEventTarget()   = Feat target
//    - GetEventPosition() = Feat target position (as a vector)
const int EVENT_TYPE_USE_FEAT           = 8;

// ToggleMode (can be blocked from script)
//    - OBJECT_SELF        = Creature toggling
//    - GetEventSubType()  = Action mode toggled (ACTION_MODE_*)
const int EVENT_TYPE_TOGGLE_MODE        = 9;

// CastSpell (can be blocked from script)
//    - OBJECT_SELF        = Spell user
//    - GetEventSubType()  = Spell ID (SPELL_*) - mask with '& 0xFFFF'
//    - GetEventTarget()   = Spell target
//    - GetEventPosition() = Spell target position (as a vector)
const int EVENT_TYPE_CAST_SPELL         = 10;

// TogglePause (can be blocked from script)
//    - GetEventSubType()  = Pause state
const int EVENT_TYPE_TOGGLE_PAUSE       = 11;

// PossessFamiliar (can be blocked from script)
//    - OBJECT_SELF        = Player character
const int EVENT_TYPE_POSSESS_FAMILIAR   = 12;

// ValidateCharacter (can be overriden by script)
//    - OBJECT_SELF        = Player character
//    * BypassEvent()      = Override default ELC check
//    * SetReturnValue()   = Return value to override
//                           0 - valid character
//                           <any number> - StrRef (TLK string) of the error
//                                          message (the character won't be
//                                          able to enter)
const int EVENT_TYPE_VALIDATE_CHARACTER = 13;

//::////////////////////////////////////////////////////////////////////////:://
//:: NODE TYPES                                                             :://
//::////////////////////////////////////////////////////////////////////////:://

const int NODE_TYPE_STARTING_NODE = 0;
const int NODE_TYPE_ENTRY_NODE    = 1;
const int NODE_TYPE_REPLY_NODE    = 2;

//::////////////////////////////////////////////////////////////////////////:://
//:: LANGUAGES                                                              :://
//::////////////////////////////////////////////////////////////////////////:://

const int LANGUAGE_ENGLISH              = 0;
const int LANGUAGE_FRENCH               = 1;
const int LANGUAGE_GERMAN               = 2;
const int LANGUAGE_ITALIAN              = 3;
const int LANGUAGE_SPANISH              = 4;
const int LANGUAGE_POLISH               = 5;
const int LANGUAGE_KOREAN               = 128;
const int LANGUAGE_CHINESE_TRADITIONAL  = 129;
const int LANGUAGE_CHINESE_SIMPLIFIED   = 130;
const int LANGUAGE_JAPANESE             = 131;

//::////////////////////////////////////////////////////////////////////////:://
//:: DECLARATION                                                            :://
//::////////////////////////////////////////////////////////////////////////:://

// Returns the EVENT_TYPE_* constant of the event.
int GetEventType();

// Returns the event subtype.
// - EVENT_TYPE_QUICKCHAT: VOICE_CHAT_*
// - EVENT_TYPE_USE_SKILL: SKILL_*
// - EVENT_TYPE_USE_FEAT: FEAT_*
// - EVENT_TYPE_TOGGLE_MODE: ACTION_MODE_*
// - EVENT_TYPE_CAST_SPELL: SPELL_*
// - EVENT_TYPE_TOGGLE_PAUSE: Pause state.
int GetEventSubType();

// Returns the target of the event.
// - EVENT_TYPE_ATTACK: Clicked object
// - EVENT_TYPE_CAST_SPELL: Spell target
// - EVENT_TYPE_EXAMINE: Object to examine
// - EVENT_TYPE_PICKPOCKET: Victim
// - EVENT_TYPE_USE_FEAT: Feat target
// - EVENT_TYPE_USE_ITEM: Item target
// - EVENT_TYPE_USE_SKILL: Skill target
object GetEventTarget();

// Returns the item involved in an event.
// - EVENT_TYPE_USE_ITEM: Item being used
// - EVENT_TYPE_USE_SKILL: Item associated with skill
object GetEventItem();

// Returns the vector position of the event target location.
// - EVENT_TYPE_CAST_SPELL: Target vector
// - EVENT_TYPE_USE_FEAT: Target vector
// - EVENT_TYPE_USE_ITEM: Target vector
// - EVENT_TYPE_USE_SKILL: Target vector
vector GetEventPosition();

// Bypasses an event entirely. Only these events can be bypassed:
// - EVENT_TYPE_CAST_SPELL
// - EVENT_TYPE_EXAMINE (Except on items)
// - EVENT_TYPE_PICKPOCKET
// - EVENT_TYPE_POSSESS_FAMILIAR
// - EVENT_TYPE_QUICKCHAT
// - EVENT_TYPE_TOGGLE_MODE
// - EVENT_TYPE_TOGGLE_PAUSE
// - EVENT_TYPE_USE_FEAT
// - EVENT_TYPE_USE_ITEM
// - EVENT_TYPE_USE_SKILL
// - EVENT_TYPE_VALIDATE_CHARACTER
void BypassEvent();

void SetReturnValue(int nRetVal);
void SetGlobalEventHandler(int nEventID, string sHandler);

// Returns the NODE_TYPE_* of the current node.
int GetCurrentNodeType();

// Returns the node ID of the current node.
int GetCurrentNodeID();

// Returns the absolute node ID of the current node.
int GetCurrentAbsoluteNodeID();

// Returns the text of the current node.
string GetCurrentNodeText(int nLangID = LANGUAGE_ENGLISH, int nGender = GENDER_MALE);

// Sets the text of the current node.
void SetCurrentNodeText(string sText, int nLangID = LANGUAGE_ENGLISH, int nGender = GENDER_MALE);

// Returns the node ID of the PC speaker's selected node.
int GetSelectedNodeID();

// Returns the absolute node ID of the PC speaker's selected node.
int GetSelectedAbsoluteNodeID();

// Returns the text of the PC speaker's selected node.
string GetSelectedNodeText(int nLangID = LANGUAGE_ENGLISH, int nGender = GENDER_MALE);

int GetEventType()
{
    SetLocalString(GetModule(), "NWNX!EVENTS!GET_EVENT_ID", "      ");
    return StringToInt(GetLocalString(GetModule(), "NWNX!EVENTS!GET_EVENT_ID"));
}

int GetEventSubType()
{
    SetLocalString(GetModule(), "NWNX!EVENTS!GET_EVENT_SUBID", "      ");
    return StringToInt(GetLocalString(GetModule(), "NWNX!EVENTS!GET_EVENT_SUBID"));
}

object GetEventTarget()
{
    return GetLocalObject(GetModule(), "NWNX!EVENTS!TARGET");
}

// DEPRECATED
// For backwards compatibility only - use GetEventTarget instead
object GetActionTarget()
{
    return GetEventTarget();
}

object GetEventItem()
{
    return GetLocalObject(GetModule(), "NWNX!EVENTS!ITEM");
}

vector GetEventPosition()
{
    SetLocalString(GetModule(), "NWNX!EVENTS!GET_EVENT_POSITION", "                                              ");
    string sVector = GetLocalString(GetModule(), "NWNX!EVENTS!GET_EVENT_POSITION");
    float x, y, z;

    //Get X
    int nPos = FindSubString(sVector, "¬");
    if(nPos == -1) return Vector();
    x = StringToFloat(GetStringLeft(sVector, nPos));
    sVector = GetStringRight(sVector, GetStringLength(sVector) - nPos - 1);

    //Get Y
    nPos = FindSubString(sVector, "¬");
    if(nPos == -1) return Vector();
    y = StringToFloat(GetStringLeft(sVector, nPos));
    sVector = GetStringRight(sVector, GetStringLength(sVector) - nPos - 1);

    //Get Z
    nPos = FindSubString(sVector, "¬");
    if(nPos == -1)
    {
        z = StringToFloat(sVector);
    }
    else return Vector();
    return Vector(x, y, z);
}

void BypassEvent()
{
    SetLocalString(GetModule(), "NWNX!EVENTS!BYPASS", "1");
}

void SetReturnValue(int nRetVal)
{
    SetLocalString(GetModule(), "NWNX!EVENTS!RETURN", IntToString(nRetVal));
}

void SetGlobalEventHandler(int nEventID, string sHandler)
{
    if (sHandler == "")
        sHandler = "-";

    string sKey = "NWNX!EVENTS!SET_EVENT_HANDLER_" + IntToString(nEventID);
    SetLocalString(GetModule(), sKey, sHandler);
    DeleteLocalString(GetModule(), sKey);
}

int GetCurrentNodeType()
{
    SetLocalString(GetModule(), "NWNX!EVENTS!GET_NODE_TYPE", "      ");
    return StringToInt(GetLocalString(GetModule(), "NWNX!EVENTS!GET_NODE_TYPE"));
}

int GetCurrentNodeID()
{
    SetLocalString(GetModule(), "NWNX!EVENTS!GET_NODE_ID", "      ");
    return StringToInt(GetLocalString(GetModule(), "NWNX!EVENTS!GET_NODE_ID"));
}

int GetCurrentAbsoluteNodeID()
{
    SetLocalString(GetModule(), "NWNX!EVENTS!GET_ABSOLUTE_NODE_ID", "      ");
    return StringToInt(GetLocalString(GetModule(), "NWNX!EVENTS!GET_ABSOLUTE_NODE_ID"));
}

int GetSelectedNodeID()
{
    SetLocalString(GetModule(), "NWNX!EVENTS!GET_SELECTED_NODE_ID", "      ");
    return StringToInt(GetLocalString(GetModule(), "NWNX!EVENTS!GET_SELECTED_NODE_ID"));
}

int GetSelectedAbsoluteNodeID()
{
    SetLocalString(GetModule(), "NWNX!EVENTS!GET_SELECTED_ABSOLUTE_NODE_ID", "      ");
    return StringToInt(GetLocalString(GetModule(), "NWNX!EVENTS!GET_SELECTED_ABSOLUTE_NODE_ID"));
}

string GetSelectedNodeText(int nLangID, int nGender)
{
    if (nGender != GENDER_FEMALE) nGender = GENDER_MALE;
    SetLocalString(GetModule(), "NWNX!EVENTS!GET_SELECTED_NODE_TEXT", IntToString(nLangID*2 + nGender));
    return GetLocalString(GetModule(), "NWNX!EVENTS!GET_SELECTED_NODE_TEXT");
}

string GetCurrentNodeText(int nLangID, int nGender)
{
    if (nGender != GENDER_FEMALE) nGender = GENDER_MALE;
    SetLocalString(GetModule(), "NWNX!EVENTS!GET_NODE_TEXT", IntToString(nLangID*2 + nGender));
    return GetLocalString(GetModule(), "NWNX!EVENTS!GET_NODE_TEXT");
}

void SetCurrentNodeText(string sText, int nLangID, int nGender)
{
    if (nGender != GENDER_FEMALE) nGender = GENDER_MALE;
    SetLocalString(GetModule(), "NWNX!EVENTS!SET_NODE_TEXT", IntToString(nLangID*2 + nGender)+"¬"+sText);
}
