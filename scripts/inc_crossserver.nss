//----------------------------------------------------------------------------//
// inc_crossserver
// Created By: Stephen "Invictus"
//----------------------------------------------------------------------------//

#include "engine"
#include "aps_include"
#include "inc_multiserver"
#include "inc_strings"
#include "inc_debug"

//----------------------------------------------------------------------------//

const int XSERV_TYPE_SHOUT = 0;
const int XSERV_TYPE_TELL  = 1;

const string XSERV_NAME_HUB = "SoT-Hub";
const string XSERV_NAME_DUNGEON = "SoT-Dungeon";

//----------------------------------------------------------------------------//

void WriteTellToBuffer(string sourceAccount, string sourceName, int sourceServer, string destAccount, string destName, int destServer, string message);
void WriteShoutToBuffer(string sourceAccount, string sourceName, int sourceServer, string message);
void ListAllPlayersLoggedIn(object oTarget);
int GetCurrentServer(object oPC);
//int GetCurrentServerByName(string sName);
int GetCurrentServerByAccount(string sAccount);
void SetCurrentServer(object oPC, int nServer);
void SendCrossTellsToPC(object oPC);
void SendCrossShoutsToPC(object oPC);
void RemoveFromLoggedInDatabase(object oPC);
void ResetLoggedInTable();
void ResetMessagesTable();

//----------------------------------------------------------------------------//

void WriteTellToBuffer(string sourceAccount, string sourceName, int sourceServer, string destAccount, string destName, int destServer, string message) {
    sourceAccount = SQLEncodeSpecialChars(sourceAccount);
    sourceName = SQLEncodeSpecialChars(sourceName);
    destAccount = SQLEncodeSpecialChars(destAccount);
    destName = SQLEncodeSpecialChars(destName);
    message = SQLEncodeSpecialChars(message);

    string sSQL = "INSERT INTO `" + SQL_TABLE_MESSAGES + "` (`type`,`source_account`,`source_character`,`source_server`,`dest_account`,`dest_character`,`dest_server`,`message`) VALUES " + "('" + IntToString(XSERV_TYPE_TELL) + "','" + sourceAccount + "','" + sourceName + "','" + IntToString(sourceServer) + "','" + destAccount + "'," + destName + "','" + IntToString(destServer) + "','" + message + "'" + ")";
    SendMessageToDevelopers("WriteTellToBuffer - sSQL: " + sSQL);
    SQLExecDirect(sSQL);
}

void WriteShoutToBuffer(string sourceAccount, string sourceName, int sourceServer, string message) {
    sourceAccount = SQLEncodeSpecialChars(sourceAccount);
    sourceName = SQLEncodeSpecialChars(sourceName);
    message = SQLEncodeSpecialChars(message);

    string sSQL = "INSERT INTO `" + SQL_TABLE_MESSAGES + "` (`type`,`source_account`,`source_character`,`source_server`,`dest_account`,`dest_character`,`dest_server`,`message`) VALUES " + "('" + IntToString(XSERV_TYPE_SHOUT) + "','" + sourceAccount + "','" + sourceName + "','" + IntToString(sourceServer) + "','" + "" + "'," + "" + "','" + IntToString(-1) + "','" + message + "'" + ")";
    SendMessageToDevelopers("WriteShoutToBuffer - sSQL: " + sSQL);
    SQLExecDirect(sSQL);
}

void ListAllPlayersLoggedIn(object oTarget) {
    string sSQL = "SELECT COUNT(*) FROM `" + SQL_TABLE_LOGGED_IN + "`";
    int numPlayers;
    int nIter;

    SQLExecDirect(sSQL);
    if(SQLFetch() == SQL_SUCCESS)
        numPlayers = StringToInt(SQLDecodeSpecialChars(SQLGetData(0)));

    SendMessageToDevelopers("ListAllPlayersLoggedIn - numPlayers: " + IntToString(numPlayers));

    SendMessageToPC(oTarget, ColorString("------------", 0, 255, 0));
    SendMessageToPC(oTarget, ColorString("Player List:", 0, 255, 0));
    SendMessageToPC(oTarget, ColorString("------------", 0, 255, 0));

    for(nIter = 0; nIter < numPlayers; nIter++) {
        sSQL = "SELECT * FROM `" + SQL_TABLE_LOGGED_IN + "` LIMIT " + IntToString(nIter) + ", 1";
        SQLExecDirect(sSQL);

        if(SQLFetch() == SQL_SUCCESS) {
            SendMessageToDevelopers("ListAllPlayersLoggedIn - SQLFetch() SUCCESS");
            SendMessageToPC(oTarget, ColorString(SQLGetData(0) + " - " + SQLGetData(1) + " - " + SQLGetData(2), 0, 255, 0));
        }
    }
}

int GetCurrentServer(object oPC) {
    string sSQL = "SELECT `server` FROM `" + SQL_TABLE_LOGGED_IN + "` WHERE `account`='" + SQLEncodeSpecialChars(GetPCPlayerName(oPC)) + "' AND `character`='" + SQLEncodeSpecialChars(GetName(oPC)) + "'";
    int nServer;

    SQLExecDirect(sSQL);
    if(SQLFetch() == SQL_SUCCESS)
        nServer = StringToInt(SQLDecodeSpecialChars(SQLGetData(0)));
    else
        return -1;

    return nServer;
}

/*int GetCurrentServerByName(string sName) {
    string sSQL = "SELECT
}*/

int GetCurrentServerByAccount(string sAccount) {
    string sSQL = "SELECT `server` FROM `" + SQL_TABLE_LOGGED_IN + "` WHERE `account`='" + SQLEncodeSpecialChars(sAccount) + "'";
    int nServer;

    SQLExecDirect(sSQL);
    if(SQLFetch() == SQL_SUCCESS)
        nServer = StringToInt(SQLDecodeSpecialChars(SQLGetData(0)));
    else
        return -1;

    return nServer;
}

void SetCurrentServer(object oPC, int nServer) {
    string sSQL = "SELECT `server` FROM " + SQL_TABLE_LOGGED_IN + " WHERE `account`='" + SQLEncodeSpecialChars(GetPCPlayerName(oPC)) + "' AND `character`='" + SQLEncodeSpecialChars(GetName(oPC)) + "'";
    SQLExecDirect(sSQL);

    if(SQLFetch() == SQL_SUCCESS) // row exists
        sSQL = "UPDATE `" + SQL_TABLE_LOGGED_IN + "` SET `server`='" + IntToString(nServer) + "' WHERE `account`='" + SQLEncodeSpecialChars(GetPCPlayerName(oPC)) + "' AND `character`='" + SQLEncodeSpecialChars(GetName(oPC)) + "'";
    else                          // row doesn't exist
        sSQL = "INSERT INTO `" + SQL_TABLE_LOGGED_IN + "` (`account`,`character`,`server`) VALUES" + "('" + SQLEncodeSpecialChars(GetPCPlayerName(oPC)) + "','" + SQLEncodeSpecialChars(GetName(oPC)) + "','" + IntToString(nServer) + "')";

    SQLExecDirect(sSQL);
}

void SendCrossTellsToPC(object oPC) {
    string sServerName;

    // Note - will not work for character-directed tells, just player directed tells. Could support both but that would entail multiple queries (slower).
    string sSQL = "SELECT * FROM `" + SQL_TABLE_MESSAGES + "` WHERE `type`='" + IntToString(XSERV_TYPE_TELL) + "' AND `dest_account`='" + SQLEncodeSpecialChars(GetPCPlayerName(oPC)) + "' AND `dest_server`='" + IntToString(GetCurrentServer(oPC)) + "'";

    SQLExecDirect(sSQL);
    while(SQLFetch() == SQL_SUCCESS) {
        switch(StringToInt(SQLDecodeSpecialChars(SQLGetData(3)))) {
            case INSTANCE_TYPE_HUB:     sServerName = XSERV_NAME_HUB; break;
            case INSTANCE_TYPE_DUNGEON: sServerName = XSERV_NAME_DUNGEON; break;
        }

        SendMessageToPC(oPC, ColorString("---", 0, 255, 0));
        SendMessageToPC(oPC, ColorString("[TELL]::" + sServerName + "::" + SQLDecodeSpecialChars(SQLGetData(1)) + "::" + SQLDecodeSpecialChars(SQLGetData(2)) + "::->::" + SQLDecodeSpecialChars(SQLGetData(4)) + "::", 0, 255, 0));
        SendMessageToPC(oPC, ColorString(SQLDecodeSpecialChars(SQLGetData(7)), 0, 255, 0));
        SendMessageToPC(oPC, ColorString("---", 0, 255, 0));
    }
}

void SendCrossShoutsToPC(object oPC) {
    string sServerName;
    string sSQL = "SELECT * FROM `" + SQL_TABLE_MESSAGES + "` WHERE `type`='" + IntToString(XSERV_TYPE_SHOUT) + "'";

    SQLExecDirect(sSQL);
    while(SQLFetch() == SQL_SUCCESS) {
        SendMessageToDevelopers("SendCrossShoutsToPC - SQL Data: " + SQLGetData(0) + " | " + SQLGetData(1) + " | " + SQLGetData(2) + " | " + SQLGetData(3) + " | " + SQLGetData(4) + " | " + SQLGetData(5) + " | " + SQLGetData(6) + " | " + SQLGetData(7));
        switch(StringToInt(SQLDecodeSpecialChars(SQLGetData(3)))) {
            case INSTANCE_TYPE_HUB:     sServerName = XSERV_NAME_HUB; break;
            case INSTANCE_TYPE_DUNGEON: sServerName = XSERV_NAME_DUNGEON; break;
        }

        SendMessageToPC(oPC, ColorString("---", 0, 255, 0));
        SendMessageToPC(oPC, ColorString("[SHOUT]::" + sServerName + "::" + SQLDecodeSpecialChars(SQLGetData(1)) + "::" + SQLDecodeSpecialChars(SQLGetData(2)) + "::", 0, 255, 0));
        SendMessageToPC(oPC, ColorString(SQLDecodeSpecialChars(SQLGetData(7)), 0, 255, 0));
        SendMessageToPC(oPC, ColorString("---", 0, 255, 0));
    }
}

void RemoveFromLoggedInDatabase(object oPC) {
    string sSQL = "DELETE FROM `" + SQL_TABLE_LOGGED_IN + "` WHERE `account`='" + SQLEncodeSpecialChars(GetPCPlayerName(oPC)) + "' AND `character`='" + SQLEncodeSpecialChars(GetName(oPC)) + "'";
    SQLExecDirect(sSQL);
}

void ResetLoggedInTable() {
    string sSQL = "TRUNCATE TABLE `" + SQL_TABLE_LOGGED_IN + "`";
    SQLExecDirect(sSQL);
}

void ResetMessagesTable() {
    string sSQL = "TRUNCATE TABLE `" + SQL_TABLE_MESSAGES + "`";
    SQLExecDirect(sSQL);
}
