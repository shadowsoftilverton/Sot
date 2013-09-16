#include "engine"
#include "aps_include"

void main()
{
    object oOwner = GetPCSpeaker();
    string sName = GetName(oOwner, TRUE);
    string sAccount = GetPCPlayerName(oOwner);
    int nProfit = GetPersistentInt_player(sName, sAccount, "Profit", SQL_TABLE_OBJECTS);
    string sProfit = IntToString(nProfit);
    int nProceeds = nProfit - (nProfit / 10);
    string sProceeds = IntToString(nProceeds);


    SpeakString("We've sold for " + sProfit + " so far, boss. After my cut that makes " + sProceeds + " lions.", TALKVOLUME_WHISPER);
}
