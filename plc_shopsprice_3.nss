//To be fired on the conversation node of the clerk's conversation that lets the owner
//of the store retrieve profits from the unmanned shop.

#include "engine"
#include "aps_include"

void main()
{
    object oOwner = GetPCSpeaker();
    string sName = GetName(oOwner, TRUE);
    string sAccount = GetPCPlayerName(oOwner);
    int nProfit = GetPersistentInt_player(sName, sAccount, "Profit", SQL_TABLE_OBJECTS);
    int nProceeds = nProfit - (nProfit / 10);

    GiveGoldToCreature(oOwner, nProceeds);
    DeletePersistentVariable_player(sName, sAccount, "Profit", SQL_TABLE_OBJECTS);
}
