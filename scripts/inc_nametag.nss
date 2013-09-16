#include "engine"

string GenerateTagFromName(object oPC)
{
    string sPC = GetName(oPC, TRUE);
    string sChecker = GetSubString(sPC, 1, 1);
    string sParser;
    int iCounter = 0;
    while(sChecker != "")
    {
        sChecker = GetSubString(sPC,iCounter, 1);
        if(sChecker != " ")
        {
            sParser = sParser + sChecker;
        }

        iCounter++;
    }

    return sParser;
}
