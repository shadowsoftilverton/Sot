// Name     : Avlis Persistence System include
// Purpose  : Various APS/NWNX2 related functions
// Authors  : Ingmar Stieger, Adam Colon, Josh Simon
// Modified : January 1st, 2005

// This file is licensed under the terms of the
// GNU GENERAL PUBLIC LICENSE (GPL) Version 2

/************************************/
/* Return codes                     */
/************************************/

const int SQL_ERROR = 0;
const int SQL_SUCCESS = 1;

/************************************/
/* SMS Constants                    */
/************************************/

const string SQL_TABLE_GENERAL    = "server_general";
const string SQL_TABLE_OBJECTS    = "server_objects";
const string SQL_TABLE_MAP_PINS   = "server_map_pins";
const string SQL_TABLE_ACCOUNTS   = "server_accounts";
const string SQL_TABLE_INSTANCES  = "server_instances";
const string SQL_TABLE_LOGGED_IN  = "server_logged_in";
const string SQL_TABLE_MESSAGES   = "server_messages";

/************************************/
/* Function prototypes              */
/************************************/

// Setup placeholders for ODBC requests and responses
void SQLInit();

// Execute statement in sSQL
void SQLExecDirect(string sSQL);

// Position cursor on next row of the resultset
// Call this before using SQLGetData().
// returns: SQL_SUCCESS if there is a row
//          SQL_ERROR if there are no more rows
int SQLFetch();

// * deprecated. Use SQLFetch instead.
// Position cursor on first row of the resultset and name it sResultSetName
// Call this before using SQLNextRow() and SQLGetData().
// returns: SQL_SUCCESS if result set is not empty
//          SQL_ERROR is result set is empty
int SQLFirstRow();

// * deprecated. Use SQLFetch instead.
// Position cursor on next row of the result set sResultSetName
// returns: SQL_SUCCESS if cursor could be advanced to next row
//          SQL_ERROR if there was no next row
int SQLNextRow();

// Return value of column iCol in the current row of result set sResultSetName
string SQLGetData(int iCol);

// Return a string value when given a location
string APSLocationToString(location lLocation);

// Return a location value when given the string form of the location
location APSStringToLocation(string sLocation);

// Return a string value when given a vector
string APSVectorToString(vector vVector);

// Return a vector value when given the string form of the vector
vector APSStringToVector(string sVector);

// Creates sTable in the database.
void CreateTable(string sTable);

// Set oObject's persistent string variable sVarName to sValue
// Optional parameters:
//   iExpiration: Number of days the persistent variable should be kept in database (default: 0=forever)
//   sTable: Name of the table where variable should be stored (default: pwdata)
void SetPersistentString(object oObject, string sVarName, string sValue, int iExpiration = 0, string sTable = SQL_TABLE_GENERAL);

// Set oObject's persistent integer variable sVarName to iValue
// Optional parameters:
//   iExpiration: Number of days the persistent variable should be kept in database (default: 0=forever)
//   sTable: Name of the table where variable should be stored (default: pwdata)
void SetPersistentInt(object oObject, string sVarName, int iValue, int iExpiration = 0, string sTable = SQL_TABLE_GENERAL);

// Set oObject's persistent float variable sVarName to fValue
// Optional parameters:
//   iExpiration: Number of days the persistent variable should be kept in database (default: 0=forever)
//   sTable: Name of the table where variable should be stored (default: pwdata)
void SetPersistentFloat(object oObject, string sVarName, float fValue, int iExpiration = 0, string sTable = SQL_TABLE_GENERAL);

// Set oObject's persistent location variable sVarName to lLocation
// Optional parameters:
//   iExpiration: Number of days the persistent variable should be kept in database (default: 0=forever)
//   sTable: Name of the table where variable should be stored (default: pwdata)
//   This function converts location to a string for storage in the database.
void SetPersistentLocation(object oObject, string sVarName, location lLocation, int iExpiration = 0, string sTable = SQL_TABLE_GENERAL);

// Set oObject's persistent vector variable sVarName to vVector
// Optional parameters:
//   iExpiration: Number of days the persistent variable should be kept in database (default: 0=forever)
//   sTable: Name of the table where variable should be stored (default: pwdata)
//   This function converts vector to a string for storage in the database.
void SetPersistentVector(object oObject, string sVarName, vector vVector, int iExpiration = 0, string sTable = SQL_TABLE_GENERAL);

// Set oObject's persistent object with sVarName to sValue
// Optional parameters:
//   iExpiration: Number of days the persistent variable should be kept in database (default: 0=forever)
//   sTable: Name of the table where variable should be stored (default: pwobjdata)
void SetPersistentObject(object oObject, string sVarName, object oObject2, int iExpiration = 0, string sTable = SQL_TABLE_OBJECTS);

// Get oObject's persistent string variable sVarName
// Optional parameters:
//   sTable: Name of the table where variable is stored (default: pwdata)
// * Return value on error: ""
string GetPersistentString(object oObject, string sVarName, string sTable = SQL_TABLE_GENERAL);

// Get oObject's persistent integer variable sVarName
// Optional parameters:
//   sTable: Name of the table where variable is stored (default: pwdata)
// * Return value on error: 0
int GetPersistentInt(object oObject, string sVarName, string sTable = SQL_TABLE_GENERAL);

// Get oObject's persistent float variable sVarName
// Optional parameters:
//   sTable: Name of the table where variable is stored (default: pwdata)
// * Return value on error: 0
float GetPersistentFloat(object oObject, string sVarName, string sTable = SQL_TABLE_GENERAL);

// Get oObject's persistent location variable sVarName
// Optional parameters:
//   sTable: Name of the table where variable is stored (default: pwdata)
// * Return value on error: 0
location GetPersistentLocation(object oObject, string sVarname, string sTable = SQL_TABLE_GENERAL);

// Get oObject's persistent vector variable sVarName
// Optional parameters:
//   sTable: Name of the table where variable is stored (default: pwdata)
// * Return value on error: 0
vector GetPersistentVector(object oObject, string sVarName, string sTable = SQL_TABLE_GENERAL);

// Get oObject's persistent object sVarName
// Optional parameters:
//   sTable: Name of the table where object is stored (default: pwobjdata)
// * Return value on error: 0
object GetPersistentObject(object oObject, string sVarName, object oOwner = OBJECT_INVALID, string sTable = SQL_TABLE_OBJECTS);

// Delete persistent variable sVarName stored on oObject
// Optional parameters:
//   sTable: Name of the table where variable is stored (default: pwdata)
void DeletePersistentVariable(object oObject, string sVarName, string sTable = SQL_TABLE_GENERAL);

// (private function) Replace special character ' with ~
string SQLEncodeSpecialChars(string sString);

// (private function)Replace special character ' with ~
string SQLDecodeSpecialChars(string sString);

//----------------------------------------------------------------------------//

// Sets a persistent variable for a player's character/account. For use when
// changing variables when someone is not logged in -- do NOT use this if you
// could otherwise use the standard functions.
void SetPersistentString_player(string sCharacter, string sAccount, string sVarName, string sValue, int iExpiration = 0, string sTable = SQL_TABLE_GENERAL);

// Sets a persistent variable for a player's character/account. For use when
// changing variables when someone is not logged in -- do NOT use this if you
// could otherwise use the standard functions.
void SetPersistentInt_player(string sCharacter, string sAccount, string sVarName, int iValue, int iExpiration = 0, string sTable = SQL_TABLE_GENERAL);

// Sets a persistent variable for a player's character/account. For use when
// changing variables when someone is not logged in -- do NOT use this if you
// could otherwise use the standard functions.
void SetPersistentFloat_player(string sCharacter, string sAccount, string sVarName, float fValue, int iExpiration = 0, string sTable = SQL_TABLE_GENERAL);

// Sets a persistent variable for a player's character/account. For use when
// changing variables when someone is not logged in -- do NOT use this if you
// could otherwise use the standard functions.
void SetPersistentLocation_player(string sCharacter, string sAccount, string sVarName, location lLocation, int iExpiration = 0, string sTable = SQL_TABLE_GENERAL);

// Sets a persistent variable for a player's character/account. For use when
// changing variables when someone is not logged in -- do NOT use this if you
// could otherwise use the standard functions.
void SetPersistentVector_player(string sCharacter, string sAccount, string sVarName, vector vVector, int iExpiration = 0, string sTable = SQL_TABLE_GENERAL);

// Sets a persistent variable for a player's character/account. For use when
// changing variables when someone is not logged in -- do NOT use this if you
// could otherwise use the standard functions.
void SetPersistentObject_player(string sCharacter, string sAccount, string sVarName, object oObject2, int iExpiration = 0, string sTable = SQL_TABLE_OBJECTS);

// Gets a persistent variable for a player's character/account. For use when
// changing variables when someone is not logged in -- do NOT use this if you
// could otherwise use the standard functions.
string GetPersistentString_player(string sCharacter, string sAccount, string sVarName, string sTable = SQL_TABLE_GENERAL);

// Gets a persistent variable for a player's character/account. For use when
// changing variables when someone is not logged in -- do NOT use this if you
// could otherwise use the standard functions.
int GetPersistentInt_player(string sCharacter, string sAccount, string sVarName, string sTable = SQL_TABLE_GENERAL);

// Gets a persistent variable for a player's character/account. For use when
// changing variables when someone is not logged in -- do NOT use this if you
// could otherwise use the standard functions.
float GetPersistentFloat_player(string sCharacter, string sAccount, string sVarName, string sTable = SQL_TABLE_GENERAL);

// Gets a persistent variable for a player's character/account. For use when
// changing variables when someone is not logged in -- do NOT use this if you
// could otherwise use the standard functions.
location GetPersistentLocation_player(string sCharacter, string sAccount, string sVarname, string sTable = SQL_TABLE_GENERAL);

// Gets a persistent variable for a player's character/account. For use when
// changing variables when someone is not logged in -- do NOT use this if you
// could otherwise use the standard functions.
vector GetPersistentVector_player(string sCharacter, string sAccount, string sVarName, string sTable = SQL_TABLE_GENERAL);

// Gets a persistent variable for a player's character/account. For use when
// changing variables when someone is not logged in -- do NOT use this if you
// could otherwise use the standard functions.
object GetPersistentObject_player(string sCharacter, string sAccount, string sVarName, object oOwner = OBJECT_INVALID, string sTable = SQL_TABLE_OBJECTS);

// Deletes a persistent variable for a player's character/account. For use when
// changing variables when someone is not logged in -- do NOT use this if you
// could otherwise use the standard functions.
void DeletePersistentVariable_player(string sCharacter, string sAccount, string sVarName, string sTable = SQL_TABLE_GENERAL);

//----------------------------------------------------------------------------//

void ClearInstanceTables();

void SetPersistentString_instance(object oArea, object oObject, string sVarName, string sValue, int iExpiration = 0, string sTable = SQL_TABLE_INSTANCES);

string GetPersistentString_instance(object oArea, object oObject, string sVarName, string sTable = SQL_TABLE_INSTANCES);

void SetPersistentInt_instance(object oArea, object oObject, string sVarName, int iValue, int iExpiration = 0, string sTable = SQL_TABLE_INSTANCES);

int GetPersistentInt_instance(object oArea, object oObject, string sVarName, string sTable = SQL_TABLE_INSTANCES);

void SetPersistentFloat_instance(object oArea, object oObject, string sVarName, float fValue, int iExpiration = 0, string sTable = SQL_TABLE_INSTANCES);

float GetPersistentFloat_instance(object oArea, object oObject, string sVarName, string sTable = SQL_TABLE_INSTANCES);

void SetPersistentLocation_instance(object oArea, object oObject, string sVarName, location lLocation, int iExpiration = 0, string sTable = SQL_TABLE_INSTANCES);

location GetPersistentLocation_instance(object oArea, object oObject, string sVarName, string sTable = SQL_TABLE_INSTANCES);

void SetPersistentVector_instance(object oArea, object oObject, string sVarName, vector vVector, int iExpiration = 0, string sTable = SQL_TABLE_INSTANCES);

vector GetPersistentVector_instance(object oArea, object oObject, string sVarName, string sTable = SQL_TABLE_INSTANCES);

void SetPersistentObject_instance(object oArea, object oObject, string sVarName, object oVarValue, int iExpiration = 0, string sTable = SQL_TABLE_INSTANCES);

object GetPersistentObject_instance(object oArea, object oObject, string sVarName, object oOwner = OBJECT_INVALID, string sTable = SQL_TABLE_INSTANCES);

void DeletePersistentVariable_instance(object oArea, object oObject, string sVarName, string sTable = SQL_TABLE_INSTANCES);

//----------------------------------------------------------------------------//

/************************************/
/* Implementation                   */
/************************************/

// Functions for initializing APS and working with result sets

void SQLInit()
{
    int i;

    // Placeholder for ODBC persistence
    string sMemory;

    for (i = 0; i < 8; i++)     // reserve 8*128 bytes
        sMemory +=
            "................................................................................................................................";

    SetLocalString(GetModule(), "NWNX!ODBC!SPACER", sMemory);
}

void SQLExecDirect(string sSQL)
{
    SetLocalString(GetModule(), "NWNX!ODBC!EXEC", sSQL);
}

int SQLFetch()
{
    string sRow;
    object oModule = GetModule();

    SetLocalString(oModule, "NWNX!ODBC!FETCH", GetLocalString(oModule, "NWNX!ODBC!SPACER"));
    sRow = GetLocalString(oModule, "NWNX!ODBC!FETCH");
    if (GetStringLength(sRow) > 0)
    {
        SetLocalString(oModule, "NWNX_ODBC_CurrentRow", sRow);
        return SQL_SUCCESS;
    }
    else
    {
        SetLocalString(oModule, "NWNX_ODBC_CurrentRow", "");
        return SQL_ERROR;
    }
}

// deprecated. use SQLFetch().
int SQLFirstRow()
{
    return SQLFetch();
}

// deprecated. use SQLFetch().
int SQLNextRow()
{
    return SQLFetch();
}

string SQLGetData(int iCol)
{
    int iPos;
    string sResultSet = GetLocalString(GetModule(), "NWNX_ODBC_CurrentRow");

    // find column in current row
    int iCount = 0;
    string sColValue = "";

    iPos = FindSubString(sResultSet, "¬");
    if ((iPos == -1) && (iCol == 1))
    {
        // only one column, return value immediately
        sColValue = sResultSet;
    }
    else if (iPos == -1)
    {
        // only one column but requested column > 1
        sColValue = "";
    }
    else
    {
        // loop through columns until found
        while (iCount != iCol)
        {
            iCount++;
            if (iCount == iCol)
                sColValue = GetStringLeft(sResultSet, iPos);
            else
            {
                sResultSet = GetStringRight(sResultSet, GetStringLength(sResultSet) - iPos - 1);
                iPos = FindSubString(sResultSet, "¬");
            }

            // special case: last column in row
            if (iPos == -1)
                iPos = GetStringLength(sResultSet);
        }
    }

    return sColValue;
}

// These functions deal with various data types. Ultimately, all information
// must be stored in the database as strings, and converted back to the proper
// form when retrieved.

string APSVectorToString(vector vVector)
{
    return "#POSITION_X#" + FloatToString(vVector.x) + "#POSITION_Y#" + FloatToString(vVector.y) +
        "#POSITION_Z#" + FloatToString(vVector.z) + "#END#";
}

vector APSStringToVector(string sVector)
{
    float fX, fY, fZ;
    int iPos, iCount;
    int iLen = GetStringLength(sVector);

    if (iLen > 0)
    {
        iPos = FindSubString(sVector, "#POSITION_X#") + 12;
        iCount = FindSubString(GetSubString(sVector, iPos, iLen - iPos), "#");
        fX = StringToFloat(GetSubString(sVector, iPos, iCount));

        iPos = FindSubString(sVector, "#POSITION_Y#") + 12;
        iCount = FindSubString(GetSubString(sVector, iPos, iLen - iPos), "#");
        fY = StringToFloat(GetSubString(sVector, iPos, iCount));

        iPos = FindSubString(sVector, "#POSITION_Z#") + 12;
        iCount = FindSubString(GetSubString(sVector, iPos, iLen - iPos), "#");
        fZ = StringToFloat(GetSubString(sVector, iPos, iCount));
    }

    return Vector(fX, fY, fZ);
}

string APSLocationToString(location lLocation)
{
    object oArea = GetAreaFromLocation(lLocation);
    vector vPosition = GetPositionFromLocation(lLocation);
    float fOrientation = GetFacingFromLocation(lLocation);
    string sReturnValue;

    if (GetIsObjectValid(oArea))
        sReturnValue =
            "#AREA#" + GetTag(oArea) + "#POSITION_X#" + FloatToString(vPosition.x) +
            "#POSITION_Y#" + FloatToString(vPosition.y) + "#POSITION_Z#" +
            FloatToString(vPosition.z) + "#ORIENTATION#" + FloatToString(fOrientation) + "#END#";

    return sReturnValue;
}

location APSStringToLocation(string sLocation)
{
    location lReturnValue;
    object oArea;
    vector vPosition;
    float fOrientation, fX, fY, fZ;

    int iPos, iCount;
    int iLen = GetStringLength(sLocation);

    if (iLen > 0)
    {
        iPos = FindSubString(sLocation, "#AREA#") + 6;
        iCount = FindSubString(GetSubString(sLocation, iPos, iLen - iPos), "#");
        oArea = GetObjectByTag(GetSubString(sLocation, iPos, iCount));

        iPos = FindSubString(sLocation, "#POSITION_X#") + 12;
        iCount = FindSubString(GetSubString(sLocation, iPos, iLen - iPos), "#");
        fX = StringToFloat(GetSubString(sLocation, iPos, iCount));

        iPos = FindSubString(sLocation, "#POSITION_Y#") + 12;
        iCount = FindSubString(GetSubString(sLocation, iPos, iLen - iPos), "#");
        fY = StringToFloat(GetSubString(sLocation, iPos, iCount));

        iPos = FindSubString(sLocation, "#POSITION_Z#") + 12;
        iCount = FindSubString(GetSubString(sLocation, iPos, iLen - iPos), "#");
        fZ = StringToFloat(GetSubString(sLocation, iPos, iCount));

        vPosition = Vector(fX, fY, fZ);

        iPos = FindSubString(sLocation, "#ORIENTATION#") + 13;
        iCount = FindSubString(GetSubString(sLocation, iPos, iLen - iPos), "#");
        fOrientation = StringToFloat(GetSubString(sLocation, iPos, iCount));

        lReturnValue = Location(oArea, vPosition, fOrientation);
    }

    return lReturnValue;
}

// Responsible for creating tables.

void CreateTable(string sTable){
    SQLExecDirect("CREATE TABLE " + sTable + " (" +
                  "player VARCHAR(64) default NULL," +
                  "tag VARCHAR(64) default NULL," +
                  "name VARCHAR(64) default NULL," +
                  "val TEXT," +
                  "expire SMALLINT UNSIGNED default NULL," +
                  "last TIMESTAMP default CURRENT_TIMESTAMP," +
                  "CONSTRAINT idx PRIMARY KEY (player,tag,name))");
}

void CreateInstanceTable(string sTable = SQL_TABLE_INSTANCES) {
    SQLExecDirect("CREATE TABLE " + sTable + " (" +
                  "area VARCHAR(64) default NULL," +
                  "tag VARCHAR(64) default NULL," +
                  "localname VARCHAR(64) default NULL," +
                  "val TEXT," +
                  "expire SMALLINT UNSIGNED default NULL," +
                  "last TIMESTAMP default CURRENT_TIMESTAMP," +
                  "CONSTRAINT idx PRIMARY KEY (area,tag,localname))");
}

// These functions are responsible for transporting the various data types back
// and forth to the database.

void SetPersistentString(object oObject, string sVarName, string sValue, int iExpiration =
                         0, string sTable = SQL_TABLE_GENERAL)
{
    string sPlayer;
    string sTag;

    if (GetIsPC(oObject))
    {
        sPlayer = SQLEncodeSpecialChars(GetPCPlayerName(oObject));
        sTag = SQLEncodeSpecialChars(GetName(oObject));
    }
    else if(GetLocalString(oObject, "PC_ACCOUNT") != "")
    {
        sPlayer = SQLEncodeSpecialChars(GetLocalString(oObject, "PC_ACCOUNT"));
        sTag = SQLEncodeSpecialChars(GetName(oObject));
    }
    else
    {
        sPlayer = "~";
        sTag = GetTag(oObject);
    }

    sVarName = SQLEncodeSpecialChars(sVarName);
    sValue = SQLEncodeSpecialChars(sValue);

    string sSQL = "SELECT player FROM " + sTable + " WHERE player='" + sPlayer +
        "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS)
    {
        // row exists
        sSQL = "UPDATE " + sTable + " SET val='" + sValue +
            "',expire=" + IntToString(iExpiration) + " WHERE player='" + sPlayer +
            "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
        SQLExecDirect(sSQL);
    }
    else
    {
        // row doesn't exist
        sSQL = "INSERT INTO " + sTable + " (player,tag,name,val,expire) VALUES" +
            "('" + sPlayer + "','" + sTag + "','" + sVarName + "','" +
            sValue + "'," + IntToString(iExpiration) + ")";
        SQLExecDirect(sSQL);
    }
}

string GetPersistentString(object oObject, string sVarName, string sTable = SQL_TABLE_GENERAL)
{
    string sPlayer;
    string sTag;

    if (GetIsPC(oObject))
    {
        sPlayer = SQLEncodeSpecialChars(GetPCPlayerName(oObject));
        sTag = SQLEncodeSpecialChars(GetName(oObject));
    }
    else if(GetLocalString(oObject, "PC_PLAYER_NAME") != "")
    {
        sPlayer = SQLEncodeSpecialChars(GetLocalString(oObject, "PC_PLAYER_NAME"));
        sTag = SQLEncodeSpecialChars(GetName(oObject));
    }
    else
    {
        sPlayer = "~";
        sTag = GetTag(oObject);
    }

    sVarName = SQLEncodeSpecialChars(sVarName);

    string sSQL = "SELECT val FROM " + sTable + " WHERE player='" + sPlayer +
        "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS)
        return SQLDecodeSpecialChars(SQLGetData(1));
    else
    {
        return "";
        // If you want to convert your existing persistent data to APS, this
        // would be the place to do it. The requested variable was not found
        // in the database, you should
        // 1) query it's value using your existing persistence functions
        // 2) save the value to the database using SetPersistentString()
        // 3) return the string value here.
    }
}

void SetPersistentInt(object oObject, string sVarName, int iValue, int iExpiration =
                      0, string sTable = SQL_TABLE_GENERAL)
{
    SetPersistentString(oObject, sVarName, IntToString(iValue), iExpiration, sTable);
}

int GetPersistentInt(object oObject, string sVarName, string sTable = SQL_TABLE_GENERAL)
{
    string sPlayer;
    string sTag;
    object oModule;

    if (GetIsPC(oObject))
    {
        sPlayer = SQLEncodeSpecialChars(GetPCPlayerName(oObject));
        sTag = SQLEncodeSpecialChars(GetName(oObject));
    }
    else if(GetLocalString(oObject, "PC_PLAYER_NAME") != "")
    {
        sPlayer = SQLEncodeSpecialChars(GetLocalString(oObject, "PC_PLAYER_NAME"));
        sTag = SQLEncodeSpecialChars(GetName(oObject));
    }
    else
    {
        sPlayer = "~";
        sTag = GetTag(oObject);
    }

    sVarName = SQLEncodeSpecialChars(sVarName);

    string sSQL = "SELECT val FROM " + sTable + " WHERE player='" + sPlayer +
        "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
    SQLExecDirect(sSQL);

    oModule = GetModule();
    SetLocalString(oModule, "NWNX!ODBC!FETCH", "-2147483647");
    return StringToInt(GetLocalString(oModule, "NWNX!ODBC!FETCH"));
}

void SetPersistentFloat(object oObject, string sVarName, float fValue, int iExpiration =
                        0, string sTable = SQL_TABLE_GENERAL)
{
    SetPersistentString(oObject, sVarName, FloatToString(fValue), iExpiration, sTable);
}

float GetPersistentFloat(object oObject, string sVarName, string sTable = SQL_TABLE_GENERAL)
{
    string sPlayer;
    string sTag;
    object oModule;

    if (GetIsPC(oObject))
    {
        sPlayer = SQLEncodeSpecialChars(GetPCPlayerName(oObject));
        sTag = SQLEncodeSpecialChars(GetName(oObject));
    }
    else if(GetLocalString(oObject, "PC_PLAYER_NAME") != "")
    {
        sPlayer = SQLEncodeSpecialChars(GetLocalString(oObject, "PC_PLAYER_NAME"));
        sTag = SQLEncodeSpecialChars(GetName(oObject));
    }
    else
    {
        sPlayer = "~";
        sTag = GetTag(oObject);
    }

    sVarName = SQLEncodeSpecialChars(sVarName);

    string sSQL = "SELECT val FROM " + sTable + " WHERE player='" + sPlayer +
        "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
    SQLExecDirect(sSQL);

    oModule = GetModule();
    SetLocalString(oModule, "NWNX!ODBC!FETCH", "-340282306073709650000000000000000000000.000000000");
    return StringToFloat(GetLocalString(oModule, "NWNX!ODBC!FETCH"));
}

void SetPersistentLocation(object oObject, string sVarName, location lLocation, int iExpiration =
                           0, string sTable = SQL_TABLE_GENERAL)
{
    SetPersistentString(oObject, sVarName, APSLocationToString(lLocation), iExpiration, sTable);
}

location GetPersistentLocation(object oObject, string sVarName, string sTable = SQL_TABLE_GENERAL)
{
    return APSStringToLocation(GetPersistentString(oObject, sVarName, sTable));
}

void SetPersistentVector(object oObject, string sVarName, vector vVector, int iExpiration =
                         0, string sTable = SQL_TABLE_GENERAL)
{
    SetPersistentString(oObject, sVarName, APSVectorToString(vVector), iExpiration, sTable);
}

vector GetPersistentVector(object oObject, string sVarName, string sTable = SQL_TABLE_GENERAL)
{
    return APSStringToVector(GetPersistentString(oObject, sVarName, sTable));
}

void SetPersistentObject(object oOwner, string sVarName, object oObject, int iExpiration =
                         0, string sTable = SQL_TABLE_OBJECTS)
{
    string sPlayer;
    string sTag;

    if (GetIsPC(oOwner))
    {
        sPlayer = SQLEncodeSpecialChars(GetPCPlayerName(oOwner));
        sTag = SQLEncodeSpecialChars(GetName(oOwner));
    }
    else if(GetLocalString(oObject, "PC_PLAYER_NAME") != "")
    {
        sPlayer = SQLEncodeSpecialChars(GetLocalString(oObject, "PC_PLAYER_NAME"));
        sTag = SQLEncodeSpecialChars(GetName(oObject));
    }
    else
    {
        sPlayer = "~";
        sTag = GetTag(oOwner);
    }
    sVarName = SQLEncodeSpecialChars(sVarName);

    string sSQL = "SELECT player FROM " + sTable + " WHERE player='" + sPlayer +
        "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS)
    {
        // row exists
        sSQL = "UPDATE " + sTable + " SET val=%s,expire=" + IntToString(iExpiration) +
            " WHERE player='" + sPlayer + "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
        SetLocalString(GetModule(), "NWNX!ODBC!SETSCORCOSQL", sSQL);
        StoreCampaignObject ("NWNX", "-", oObject);
    }
    else
    {
        // row doesn't exist
        sSQL = "INSERT INTO " + sTable + " (player,tag,name,val,expire) VALUES" +
            "('" + sPlayer + "','" + sTag + "','" + sVarName + "',%s," + IntToString(iExpiration) + ")";
        SetLocalString(GetModule(), "NWNX!ODBC!SETSCORCOSQL", sSQL);
        StoreCampaignObject ("NWNX", "-", oObject);
    }
}

object GetPersistentObject(object oObject, string sVarName, object oOwner = OBJECT_INVALID, string sTable = SQL_TABLE_OBJECTS)
{
    string sPlayer;
    string sTag;
    object oModule;

    if (GetIsPC(oObject))
    {
        sPlayer = SQLEncodeSpecialChars(GetPCPlayerName(oObject));
        sTag = SQLEncodeSpecialChars(GetName(oObject));
    }
    else if(GetLocalString(oObject, "PC_PLAYER_NAME") != "")
    {
        sPlayer = SQLEncodeSpecialChars(GetLocalString(oObject, "PC_PLAYER_NAME"));
        sTag = SQLEncodeSpecialChars(GetName(oObject));
    }
    else
    {
        sPlayer = "~";
        sTag = GetTag(oObject);
    }
    sVarName = SQLEncodeSpecialChars(sVarName);

    string sSQL = "SELECT val FROM " + sTable + " WHERE player='" + sPlayer +
        "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
    SetLocalString(GetModule(), "NWNX!ODBC!SETSCORCOSQL", sSQL);

    if (!GetIsObjectValid(oOwner))
        oOwner = oObject;
    return RetrieveCampaignObject ("NWNX", "-", GetLocation(oOwner), oOwner);
}

void DeletePersistentVariable(object oObject, string sVarName, string sTable = SQL_TABLE_GENERAL)
{
    string sPlayer;
    string sTag;

    if (GetIsPC(oObject))
    {
        sPlayer = SQLEncodeSpecialChars(GetPCPlayerName(oObject));
        sTag = SQLEncodeSpecialChars(GetName(oObject));
    }
    else if(GetLocalString(oObject, "PC_PLAYER_NAME") != "")
    {
        sPlayer = SQLEncodeSpecialChars(GetLocalString(oObject, "PC_PLAYER_NAME"));
        sTag = SQLEncodeSpecialChars(GetName(oObject));
    }
    else
    {
        sPlayer = "~";
        sTag = GetTag(oObject);
    }

    sVarName = SQLEncodeSpecialChars(sVarName);
    string sSQL = "DELETE FROM " + sTable + " WHERE player='" + sPlayer +
        "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
    SQLExecDirect(sSQL);
}

// Problems can arise with SQL commands if variables or values have single quotes
// in their names. These functions are a replace these quote with the tilde character

string SQLEncodeSpecialChars(string sString)
{
    if (FindSubString(sString, "'") == -1)      // not found
        return sString;

    int i;
    string sReturn = "";
    string sChar;

    // Loop over every character and replace special characters
    for (i = 0; i < GetStringLength(sString); i++)
    {
        sChar = GetSubString(sString, i, 1);
        if (sChar == "'")
            sReturn += "~";
        else
            sReturn += sChar;
    }
    return sReturn;
}

string SQLDecodeSpecialChars(string sString)
{
    if (FindSubString(sString, "~") == -1)      // not found
        return sString;

    int i;
    string sReturn = "";
    string sChar;

    // Loop over every character and replace special characters
    for (i = 0; i < GetStringLength(sString); i++)
    {
        sChar = GetSubString(sString, i, 1);
        if (sChar == "~")
            sReturn += "'";
        else
            sReturn += sChar;
    }
    return sReturn;
}

//----------------------------------------------------------------------------//

void SetPersistentString_player(string sCharacter, string sAccount, string sVarName, string sValue, int iExpiration = 0, string sTable = SQL_TABLE_GENERAL)
{
    string sPlayer = SQLEncodeSpecialChars(sAccount);
    string sTag = SQLEncodeSpecialChars(sCharacter);

    sVarName = SQLEncodeSpecialChars(sVarName);
    sValue = SQLEncodeSpecialChars(sValue);

    string sSQL = "SELECT player FROM " + sTable + " WHERE player='" + sPlayer +
        "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS)
    {
        // row exists
        sSQL = "UPDATE " + sTable + " SET val='" + sValue +
            "',expire=" + IntToString(iExpiration) + " WHERE player='" + sPlayer +
            "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
        SQLExecDirect(sSQL);
    }
    else
    {
        // row doesn't exist
        sSQL = "INSERT INTO " + sTable + " (player,tag,name,val,expire) VALUES" +
            "('" + sPlayer + "','" + sTag + "','" + sVarName + "','" +
            sValue + "'," + IntToString(iExpiration) + ")";
        SQLExecDirect(sSQL);
    }
}

string GetPersistentString_player(string sCharacter, string sAccount, string sVarName, string sTable = SQL_TABLE_GENERAL)
{
    string sPlayer = SQLEncodeSpecialChars(sAccount);
    string sTag = SQLEncodeSpecialChars(sCharacter);

    sVarName = SQLEncodeSpecialChars(sVarName);

    string sSQL = "SELECT val FROM " + sTable + " WHERE player='" + sPlayer +
        "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS)
        return SQLDecodeSpecialChars(SQLGetData(1));
    else
    {
        return "";
        // If you want to convert your existing persistent data to APS, this
        // would be the place to do it. The requested variable was not found
        // in the database, you should
        // 1) query it's value using your existing persistence functions
        // 2) save the value to the database using SetPersistentString()
        // 3) return the string value here.
    }
}

void SetPersistentInt_player(string sCharacter, string sAccount, string sVarName, int iValue, int iExpiration =
                      0, string sTable = SQL_TABLE_GENERAL)
{
    SetPersistentString_player(sCharacter, sAccount, sVarName, IntToString(iValue), iExpiration, sTable);
}

int GetPersistentInt_player(string sCharacter, string sAccount, string sVarName, string sTable = SQL_TABLE_GENERAL)
{
    string sPlayer = SQLEncodeSpecialChars(sAccount);
    string sTag = SQLEncodeSpecialChars(sCharacter);
    object oModule;

    sVarName = SQLEncodeSpecialChars(sVarName);

    string sSQL = "SELECT val FROM " + sTable + " WHERE player='" + sPlayer +
        "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
    SQLExecDirect(sSQL);

    oModule = GetModule();
    SetLocalString(oModule, "NWNX!ODBC!FETCH", "-2147483647");
    return StringToInt(GetLocalString(oModule, "NWNX!ODBC!FETCH"));
}

void SetPersistentFloat_player(string sCharacter, string sAccount, string sVarName, float fValue, int iExpiration =
                        0, string sTable = SQL_TABLE_GENERAL)
{
    SetPersistentString_player(sCharacter, sAccount, sVarName, FloatToString(fValue), iExpiration, sTable);
}

float GetPersistentFloat_player(string sCharacter, string sAccount, string sVarName, string sTable = SQL_TABLE_GENERAL)
{
    string sPlayer = SQLEncodeSpecialChars(sAccount);
    string sTag = SQLEncodeSpecialChars(sCharacter);
    object oModule;

    sVarName = SQLEncodeSpecialChars(sVarName);

    string sSQL = "SELECT val FROM " + sTable + " WHERE player='" + sPlayer +
        "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
    SQLExecDirect(sSQL);

    oModule = GetModule();
    SetLocalString(oModule, "NWNX!ODBC!FETCH", "-340282306073709650000000000000000000000.000000000");
    return StringToFloat(GetLocalString(oModule, "NWNX!ODBC!FETCH"));
}

void SetPersistentLocation_player(string sCharacter, string sAccount, string sVarName, location lLocation, int iExpiration =
                           0, string sTable = SQL_TABLE_GENERAL)
{
    SetPersistentString_player(sCharacter, sAccount, sVarName, APSLocationToString(lLocation), iExpiration, sTable);
}

location GetPersistentLocation_player(string sCharacter, string sAccount, string sVarName, string sTable = SQL_TABLE_GENERAL)
{
    return APSStringToLocation(GetPersistentString_player(sCharacter, sAccount, sVarName, sTable));
}

void SetPersistentVector_player(string sCharacter, string sAccount, string sVarName, vector vVector, int iExpiration =
                         0, string sTable = SQL_TABLE_GENERAL)
{
    SetPersistentString_player(sCharacter, sAccount, sVarName, APSVectorToString(vVector), iExpiration, sTable);
}

vector GetPersistentVector_player(string sCharacter, string sAccount, string sVarName, string sTable = SQL_TABLE_GENERAL)
{
    return APSStringToVector(GetPersistentString_player(sCharacter, sAccount, sVarName, sTable));
}

void SetPersistentObject_player(string sCharacter, string sAccount, string sVarName, object oObject, int iExpiration =
                         0, string sTable = SQL_TABLE_OBJECTS)
{
    string sPlayer = SQLEncodeSpecialChars(sAccount);
    string sTag = SQLEncodeSpecialChars(sCharacter);

    sVarName = SQLEncodeSpecialChars(sVarName);

    string sSQL = "SELECT player FROM " + sTable + " WHERE player='" + sPlayer +
        "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS)
    {
        // row exists
        sSQL = "UPDATE " + sTable + " SET val=%s,expire=" + IntToString(iExpiration) +
            " WHERE player='" + sPlayer + "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
        SetLocalString(GetModule(), "NWNX!ODBC!SETSCORCOSQL", sSQL);
        StoreCampaignObject ("NWNX", "-", oObject);
    }
    else
    {
        // row doesn't exist
        sSQL = "INSERT INTO " + sTable + " (player,tag,name,val,expire) VALUES" +
            "('" + sPlayer + "','" + sTag + "','" + sVarName + "',%s," + IntToString(iExpiration) + ")";
        SetLocalString(GetModule(), "NWNX!ODBC!SETSCORCOSQL", sSQL);
        StoreCampaignObject ("NWNX", "-", oObject);
    }
}

object GetPersistentObject_player(string sCharacter, string sAccount, string sVarName, object oOwner = OBJECT_INVALID, string sTable = SQL_TABLE_OBJECTS)
{
    string sPlayer = SQLEncodeSpecialChars(sAccount);
    string sTag = SQLEncodeSpecialChars(sCharacter);

    object oModule;

    sVarName = SQLEncodeSpecialChars(sVarName);

    string sSQL = "SELECT val FROM " + sTable + " WHERE player='" + sPlayer +
        "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
    SetLocalString(GetModule(), "NWNX!ODBC!SETSCORCOSQL", sSQL);

    return RetrieveCampaignObject ("NWNX", "-", GetLocation(oOwner), oOwner);
}

void DeletePersistentVariable_player(string sCharacter, string sAccount, string sVarName, string sTable = SQL_TABLE_GENERAL)
{
    string sPlayer = SQLEncodeSpecialChars(sAccount);
    string sTag = SQLEncodeSpecialChars(sCharacter);

    sVarName = SQLEncodeSpecialChars(sVarName);
    string sSQL = "DELETE FROM " + sTable + " WHERE player='" + sPlayer +
        "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
    SQLExecDirect(sSQL);
}

void ClearPersistentVariables_player(string sCharacter, string sAccount, string sTable = SQL_TABLE_GENERAL) {
    string sPlayer = SQLEncodeSpecialChars(sAccount);
    string sTag = SQLEncodeSpecialChars(sCharacter);

    string sSQL = "DELETE FROM " + sTable + " WHERE player='" + sPlayer + "' AND tag='" + sTag + "'";
    SQLExecDirect(sSQL);
}

//----------------------------------------------------------------------------//

void ClearInstanceTables() {
    string sSQL = "TRUNCATE TABLE " + SQL_TABLE_INSTANCES;
    SQLExecDirect(sSQL);
}

void SetPersistentString_instance(object oArea, object oObject, string sVarName, string sValue, int iExpiration = 0, string sTable = SQL_TABLE_INSTANCES) {
    string sAreaResRef = SQLEncodeSpecialChars(GetResRef(oArea));
    string sObjectTag = SQLEncodeSpecialChars(GetTag(oObject));

    sVarName = SQLEncodeSpecialChars(sVarName);
    sValue = SQLEncodeSpecialChars(sValue);

    string sSQL = "SELECT area FROM " + sTable + " WHERE area='" + sAreaResRef + "' AND tag='" + sObjectTag + "' AND localname='" + sVarName + "'";
    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS) {
        // row exists
        sSQL = "UPDATE " + sTable + " SET val='" + sValue + "',expire=" + IntToString(iExpiration) + " WHERE area='" + sAreaResRef + "' AND tag='" + sObjectTag + "' AND localname='" + sVarName + "'";
        SQLExecDirect(sSQL);
    } else {
        // row doesn't exist
        sSQL = "INSERT INTO " + sTable + " (area,tag,localname,val,expire) VALUES" + "('" + sAreaResRef + "','" + sObjectTag + "','" + sVarName + "','" + sValue + "'," + IntToString(iExpiration) + ")";
        SQLExecDirect(sSQL);
    }
}

string GetPersistentString_instance(object oArea, object oObject, string sVarName, string sTable = SQL_TABLE_INSTANCES) {
    string sAreaResRef = SQLEncodeSpecialChars(GetResRef(oArea));
    string sObjectTag = SQLEncodeSpecialChars(GetTag(oObject));

    sVarName = SQLEncodeSpecialChars(sVarName);

    string sSQL = "SELECT val FROM " + sTable + " WHERE area='" + sAreaResRef + "' AND tag='" + sObjectTag + "' AND localname='" + sVarName + "'";
    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS)
        return SQLDecodeSpecialChars(SQLGetData(1));
    else
        return "";
}

void SetPersistentInt_instance(object oArea, object oObject, string sVarName, int iValue, int iExpiration = 0, string sTable = SQL_TABLE_INSTANCES) {
    SetPersistentString_instance(oArea, oObject, sVarName, IntToString(iValue), iExpiration, sTable);
}

int GetPersistentInt_instance(object oArea, object oObject, string sVarName, string sTable = SQL_TABLE_INSTANCES) {
    string sAreaResRef = SQLEncodeSpecialChars(GetResRef(oArea));
    string sObjectTag = SQLEncodeSpecialChars(GetTag(oObject));
    object oModule;

    sVarName = SQLEncodeSpecialChars(sVarName);

    string sSQL = "SELECT val FROM " + sTable + " WHERE area='" + sAreaResRef + "' AND tag='" + sObjectTag + "' AND localname='" + sVarName + "'";
    SQLExecDirect(sSQL);

    oModule = GetModule();
    SetLocalString(oModule, "NWNX!ODBC!FETCH", "-2147483647");
    return StringToInt(GetLocalString(oModule, "NWNX!ODBC!FETCH"));
}

void SetPersistentFloat_instance(object oArea, object oObject, string sVarName, float fValue, int iExpiration = 0, string sTable = SQL_TABLE_INSTANCES) {
    SetPersistentString_instance(oArea, oObject, sVarName, FloatToString(fValue), iExpiration, sTable);
}

float GetPersistentFloat_instance(object oArea, object oObject, string sVarName, string sTable = SQL_TABLE_INSTANCES) {
    string sAreaResRef = SQLEncodeSpecialChars(GetResRef(oArea));
    string sObjectTag = SQLEncodeSpecialChars(GetTag(oObject));
    object oModule;

    sVarName = SQLEncodeSpecialChars(sVarName);

    string sSQL = "SELECT val FROM " + sTable + " WHERE area='" + sAreaResRef + "' AND tag='" + sObjectTag + "' AND localname='" + sVarName + "'";
    SQLExecDirect(sSQL);

    oModule = GetModule();
    SetLocalString(oModule, "NWNX!ODBC!FETCH", "-340282306073709650000000000000000000000.000000000");
    return StringToFloat(GetLocalString(oModule, "NWNX!ODBC!FETCH"));
}

void SetPersistentLocation_instance(object oArea, object oObject, string sVarName, location lLocation, int iExpiration = 0, string sTable = SQL_TABLE_INSTANCES) {
    SetPersistentString_instance(oArea, oObject, sVarName, APSLocationToString(lLocation), iExpiration, sTable);
}

location GetPersistentLocation_instance(object oArea, object oObject, string sVarName, string sTable = SQL_TABLE_INSTANCES) {
    return APSStringToLocation(GetPersistentString_instance(oArea, oObject, sVarName, sTable));
}

void SetPersistentVector_instance(object oArea, object oObject, string sVarName, vector vVector, int iExpiration = 0, string sTable = SQL_TABLE_INSTANCES) {
    SetPersistentString_instance(oArea, oObject, sVarName, APSVectorToString(vVector), iExpiration, sTable);
}

vector GetPersistentVector_instance(object oArea, object oObject, string sVarName, string sTable = SQL_TABLE_INSTANCES) {
    return APSStringToVector(GetPersistentString_instance(oArea, oObject, sVarName, sTable));
}

void SetPersistentObject_instance(object oArea, object oObject, string sVarName, object oVarValue, int iExpiration = 0, string sTable = SQL_TABLE_INSTANCES) {
    string sAreaResRef = SQLEncodeSpecialChars(GetResRef(oArea));
    string sObjectTag = SQLEncodeSpecialChars(GetTag(oObject));

    sVarName = SQLEncodeSpecialChars(sVarName);

    string sSQL = "SELECT player FROM " + sTable + " WHERE area='" + sAreaResRef + "' AND tag='" + sObjectTag + "' AND localname='" + sVarName + "'";
    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS) {
        // row exists
        sSQL = "UPDATE " + sTable + " SET val=%s,expire=" + IntToString(iExpiration) + " WHERE area='" + sAreaResRef + "' AND tag='" + sObjectTag + "' AND localname='" + sVarName + "'";
        SetLocalString(GetModule(), "NWNX!ODBC!SETSCORCOSQL", sSQL);
        StoreCampaignObject ("NWNX", "-", oVarValue);
    } else {
        // row doesn't exist
        sSQL = "INSERT INTO " + sTable + " (area,tag,localname,val,expire) VALUES" + "('" + sAreaResRef + "','" + sObjectTag + "','" + sVarName + "',%s," + IntToString(iExpiration) + ")";
        SetLocalString(GetModule(), "NWNX!ODBC!SETSCORCOSQL", sSQL);
        StoreCampaignObject ("NWNX", "-", oVarValue);
    }
}

object GetPersistentObject_instance(object oArea, object oObject, string sVarName, object oOwner = OBJECT_INVALID, string sTable = SQL_TABLE_INSTANCES) {
    string sAreaResRef = SQLEncodeSpecialChars(GetResRef(oArea));
    string sObjectTag = SQLEncodeSpecialChars(GetTag(oObject));
    object oModule;

    sVarName = SQLEncodeSpecialChars(sVarName);

    string sSQL = "SELECT val FROM " + sTable + " WHERE area='" + sAreaResRef + "' AND tag='" + sObjectTag + "' AND localname='" + sVarName + "'";
    SetLocalString(GetModule(), "NWNX!ODBC!SETSCORCOSQL", sSQL);

    if (!GetIsObjectValid(oOwner))
        oOwner = oObject;
    return RetrieveCampaignObject ("NWNX", "-", GetLocation(oOwner), oOwner);
}

void DeletePersistentVariable_instance(object oArea, object oObject, string sVarName, string sTable = SQL_TABLE_INSTANCES) {
    string sAreaResRef = SQLEncodeSpecialChars(GetResRef(oArea));
    string sObjectTag = SQLEncodeSpecialChars(GetTag(oObject));

    sVarName = SQLEncodeSpecialChars(sVarName);
    string sSQL = "DELETE FROM " + sTable + " WHERE area='" + sAreaResRef + "' AND tag='" + sObjectTag + "' AND localname='" + sVarName + "'";
    SQLExecDirect(sSQL);
}

//----------------------------------------------------------------------------//


