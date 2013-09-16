//::////////////////////////////////////////////////////////////////////////:://
//:: CONSTANTS                                                              :://
//::////////////////////////////////////////////////////////////////////////:://

const string LOG_TYPE_DEFAULT  = "GENERAL";
const string LOG_TYPE_ERROR    = "ERROR";
const string LOG_TYPE_MODULE   = "MODULE";
const string LOG_TYPE_AREA     = "AREA";
const string LOG_TYPE_PC       = "PLAYER";
const string LOG_TYPE_DM       = "DUNGEON MASTER";
const string LOG_TYPE_DATABASE = "DATABASE";

//::////////////////////////////////////////////////////////////////////////:://
//:: DECLARATION                                                            :://
//::////////////////////////////////////////////////////////////////////////:://

// Returns a string of formatted information giving a player's name, account,
// and public CD key.
string GetPCInfoString(object oPC);

// Writes a standard format log entry.
void WriteLog(string sEntry, string sType=LOG_TYPE_DEFAULT, string sSubType="");

//::////////////////////////////////////////////////////////////////////////:://
//:: IMPLEMENTATION                                                         :://
//::////////////////////////////////////////////////////////////////////////:://

string GetPCInfoString(object oPC){
    string sName    = GetName(oPC);
    string sAccount = GetPCPlayerName(oPC);
    string sKey     = GetPCPublicCDKey(oPC);

    return sName + " (" + sAccount + ")(" + sKey + ")";
}

void WriteLog(string sEntry, string sType=LOG_TYPE_DEFAULT, string sSubType=""){
    sType    = GetStringUpperCase(sType);
    sSubType = GetStringUpperCase(sSubType);

    string sLog = sType + " :: ";

    if(sSubType != "") sLog += sSubType + " :: ";

    sLog += sEntry;

    WriteTimestampedLogEntry(sLog);
}
