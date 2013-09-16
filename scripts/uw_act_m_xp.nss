#include "engine"

#include "inc_strings"
#include "inc_xp"

#include "uw_inc"

void main()
{
    string sToken;

    object oPC      = GetPCSpeaker();
    object oTarget  = GetUtilityTarget(oPC);

    int nType   = GetObjectType(oTarget);

    if(oTarget == oPC){
        sToken = "Your current XP totals are:\n\n";
    } else {
        sToken = ColorString(GetName(oTarget), 55, 255, 55) + "'s XP totals " +
                 "are:\n\n";
    }

    sToken += "Current XP: " + ColorString(IntToString(GetXP(oTarget)), 55, 255, 55) + "\n";
    sToken += "Soft Cap: " + ColorString(IntToString(GetXPCap(oTarget)), 55, 255, 55);

    SetCustomToken(7111, sToken);
}



