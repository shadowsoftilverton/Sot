#include "engine"

#include "aps_include"
#include "inc_logs"

void main()
{
    int i = 0;

    string sTable;

    object oPC = GetLastUsedBy();
    object oSelf = OBJECT_SELF;

    if(GetTag(oSelf) != "plc_database" || GetObjectType(oSelf) == OBJECT_TYPE_PLACEABLE){
        SendMessageToPC(oPC, "This attempt to modify the database has been logged!");
        WriteLog("Player " + GetPCInfoString(oPC) + " attempted to modify the database using plc_database!", LOG_TYPE_DATABASE);
    }


    for(i = 0; i < 4; i++){
        switch(i){
            case 0: sTable = SQL_TABLE_ACCOUNTS; break;
            case 1: sTable = SQL_TABLE_GENERAL;  break;
            case 2: sTable = SQL_TABLE_MAP_PINS; break;
            case 3: sTable = SQL_TABLE_OBJECTS;  break;
        }

        SendMessageToPC(oPC, "Attempting to create " + sTable + ".");

        CreateTable(sTable);

        SendMessageToPC(oPC, "Testing " + sTable + ".");

        SetPersistentInt(oPC, "test", 1, 0, sTable);

        if(GetPersistentInt(oPC, "test", sTable) == 1){
            SendMessageToPC(oPC, "Table " + sTable + " was successfully initialized!");
            DeletePersistentVariable(oPC, "test", sTable);
        } else {
            SendMessageToPC(oPC, "Table " + sTable + " failed to initialize.\n");
        }
    }

    SendMessageToPC(oPC, "Initialization complete!");
}
