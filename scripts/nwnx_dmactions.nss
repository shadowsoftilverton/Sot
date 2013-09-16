const int DM_ACTION_MESSAGE_TYPE           =  1;
const int DM_ACTION_GIVE_XP                =  2;
const int DM_ACTION_GIVE_LEVEL             =  3;
const int DM_ACTION_GIVE_GOLD              =  4;
const int DM_ACTION_CREATE_ITEM_ON_OBJECT  =  5;
const int DM_ACTION_CREATE_ITEM_ON_AREA    =  6;
const int DM_ACTION_HEAL_CREATURE          =  7;
const int DM_ACTION_REST_CREATURE          =  8;
const int DM_ACTION_RUNSCRIPT              =  9;
const int DM_ACTION_CREATE_PLACEABLE       = 10;
const int DM_ACTION_SPAWN_CREATURE         = 11;
const int DM_ACTION_TOGGLE_INVULNERABILITY = 12;
const int DM_ACTION_TOGGLE_IMMORTALITY     = 13;

/*
36 - invur
46 - send event enter
47 - send event exit
*/

const int DM_MSG_FORCE_REST = 37;
const int DM_MSG_GOTO = 34;
const int DM_MSG_POSSESS = 35;
const int DM_MSG_POSSESS_DM = 41;
const int DM_MSG_TOGGLE_AI = 43;
const int DM_MSG_TOGGLE_LOCK = 44;
const int DM_MSG_KILL = 33;
const int DM_MSG_HEAL = 32;
const int DM_MSG_JUMP_TO_POINT = 80;
const int DM_MSG_ALIGN_TO_GOOD = 140;
const int DM_MSG_ALIGN_TO_EVIL = 141;
const int DM_MSG_ALIGN_TO_LAW = 142;
const int DM_MSG_ALIGN_TO_CHAOS = 143;
const int DM_MSG_JUMP_ALL_PLAYERS = 131;
const int DM_MSG_MODIFY_STATS = 132;
const int DM_MSG_SET_VAR = 134;
const int DM_MSG_GET_VAR = 133;
const int DM_MSG_DUMP_VARS = 139;
const int DM_MSG_SET_TIME = 135;
const int DM_MSG_APPEAR = 48;
const int DM_MSG_DISAPPEAR = 49;
const int DM_MSG_CHANGE_DIFFICULTY = 17;
const int DM_MSG_FIND_BY_TAG = 3;
const int DM_MSG_FIND_NEXT = 39;
const int DM_MSG_GET_OBJECTS_LIST = 1;
const int DM_MSG_IMMORTAL = 50;

// Set script name called on specified action
void SetDMActionScript(int nAction, string sScript);

// Get ID of DM Action
int GetDMActionID();

// Get int param of DM Action
int GetDMActionIntParam(int bSecond=FALSE);

// Get string param of DM Action
string GetDMActionStringParam();

// Get target object of DM Action
object GetDMActionTarget(int bSecond=FALSE);

// Get target position of DM Action
vector GetDMActionPosition();

// Get total targets number in multiselection
int GetDMActionTargetsCount();

// Get current target number in multiselection.
int GetDMActionTargetsCurrent();

void SetDMActionScript(int nAction, string sScript) {
    SetLocalString(OBJECT_SELF, "NWNX!DMACTIONS!SET_ACTION_SCRIPT", IntToString(nAction)+":"+sScript);
    DeleteLocalString(OBJECT_SELF, "NWNX!DMACTIONS!SET_ACTION_SCRIPT");
}

int GetDMActionID() {
    SetLocalString(OBJECT_SELF, "NWNX!DMACTIONS!GETACTIONID", "                ");
    string sAction = GetLocalString(OBJECT_SELF, "NWNX!DMACTIONS!GETACTIONID");
    DeleteLocalString(OBJECT_SELF, "NWNX!DMACTIONS!GETACTIONID");
    return StringToInt(sAction);
}

void PreventDMAction() {
    SetLocalString(OBJECT_SELF, "NWNX!DMACTIONS!PREVENT", "1");
    DeleteLocalString(OBJECT_SELF, "NWNX!DMACTIONS!PREVENT");
}

int GetDMActionIntParam(int bSecond=FALSE) {
    string sNth = bSecond?"2":"1";
    SetLocalString(OBJECT_SELF, "NWNX!DMACTIONS!GETPARAM_"+sNth, "                ");
    string sVal = GetLocalString(OBJECT_SELF, "NWNX!DMACTIONS!GETPARAM_"+sNth);
    DeleteLocalString(OBJECT_SELF, "NWNX!DMACTIONS!GETPARAM_"+sNth);
    return StringToInt(sVal);
}

string GetDMActionStringParam() {
    SetLocalString(OBJECT_SELF, "NWNX!DMACTIONS!GETSTRPARAM1", "                                ");
    string sVal = GetLocalString(OBJECT_SELF, "NWNX!DMACTIONS!GETSTRPARAM1");
    DeleteLocalString(OBJECT_SELF, "NWNX!DMACTIONS!GETSTRPARAM1");
    return sVal;
}

object GetDMActionTarget(int bSecond=FALSE) {
    string sNth = bSecond?"2":"1";
    return GetLocalObject(OBJECT_SELF, "NWNX!DMACTIONS!TARGET_"+sNth);
}

vector GetDMActionPosition() {
    SetLocalString(OBJECT_SELF, "NWNX!DMACTIONS!GETPOS", "                                              ");
    string sVector = GetLocalString(OBJECT_SELF, "NWNX!DMACTIONS!GETPOS");
    DeleteLocalString(OBJECT_SELF, "NWNX!DMACTIONS!GETPOS");
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
    if(nPos == -1) {
        z = StringToFloat(sVector);
    } else return Vector();

    return Vector(x, y, z);
}

int GetDMActionTargetsCount() {
    SetLocalString(OBJECT_SELF, "NWNX!DMACTIONS!GETTARGETSCOUNT", "                ");
    string sVal = GetLocalString(OBJECT_SELF, "NWNX!DMACTIONS!GETTARGETSCOUNT");
    DeleteLocalString(OBJECT_SELF, "NWNX!DMACTIONS!GETTARGETSCOUNT");
    return StringToInt(sVal);
}

int GetDMActionTargetsCurrent() {
    SetLocalString(OBJECT_SELF, "NWNX!DMACTIONS!GETTARGETSCURRENT", "                ");
    string sVal = GetLocalString(OBJECT_SELF, "NWNX!DMACTIONS!GETTARGETSCURRENT");
    DeleteLocalString(OBJECT_SELF, "NWNX!DMACTIONS!GETTARGETSCURRENT");
    return StringToInt(sVal);
}

