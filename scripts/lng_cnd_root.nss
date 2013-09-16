#include "engine"

#include "nwnx_funcs"
#include "inc_language"

int StartingConditional()
{
    object oPC = GetPCSpeaker();

    string sFeedback;

    int nSkillPoints    = GetPCSkillPoints(oPC);
    int nFreeLanguages  = GetFreeGeneralLanguages(oPC);
    int nFreeRegionals  = GetFreeRegionalLanguages(oPC);

    int bIsBard         = GetLevelByClass(CLASS_TYPE_BARD, oPC) > 0;

    // We need at least one skill point as a bard, two skill points as a non-
    // bard, one free language, or one free regional to actually do anything
    // in terms of language selection... otherwise the language system will
    // tell us we can't really pick anything.
    if((bIsBard && nSkillPoints < 1 || !bIsBard && nSkillPoints < 2) &&
       nFreeLanguages < 1 && nFreeRegionals < 1){
        sFeedback = "You do not have any skill points or free languages to " +
                    "spend on learning additional languages. You need at least " +
                    "2 skill points (1 if you have a level in bard) to learn " +
                    "additional languages.";
    } else {
        sFeedback = "Please select the language you want to learn. You have: " +
                    "\n\n" +
                    "Skill Points: " + IntToString(nSkillPoints) +
                    "\n" +
                    "Free Languages: " + IntToString(nFreeLanguages) +
                    "\n" +
                    "Free Regionals: " + IntToString(nFreeRegionals);
    }

    SetCustomToken(29500, sFeedback);

    return TRUE;
}
