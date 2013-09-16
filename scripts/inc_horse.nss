// =============================================================================
// inc_horse: Invictus, Nov. 1, 2011
// Modified by Micteu Apr. 5, 2012.
//   Will now check how many henchmen a PC has and exit if more than zero.
// =============================================================================

#include "x2_inc_switches"
#include "inc_henchmen"
#include "inc_nametag"

void HorseWidgetAction(object oPC, object oTarget, string sHorseName, string sHorseTag, string sHorseResref);

void HorseWidgetAction(object oPC, object oTarget, string sHorseName, string sHorseTag, string sHorseResref) {
    location lPC = GetLocation(oPC);

    if(GetIsObjectValid(oTarget)) {
        if(GetIsHenchmanOfPC(oPC, oTarget))
            DestroyObject(oTarget);
    } else {
        // Exiting if the player already has henchmen.
        if(GetNumHenchmenOfPC(oPC) >= GetMaxHenchmen())
        {
            SendMessageToPC(oPC, "You already have the maximum number of henchmen.");
            return;
        }
        string sHorseTag = "HRS_" + GenerateTagFromName(oPC);
        location lHorse = GetItemActivatedTargetLocation();
        object oHorse = CreateObject(OBJECT_TYPE_CREATURE, sHorseResref, lHorse, TRUE, sHorseTag);
        SetName(oHorse, GetName(oPC) + "'s Horse");

        if(GetIsObjectValid(oHorse))
            AddHenchman(oPC, oHorse);
        else
            AssignCommand(oPC, ActionSpeakString("Invalid Horse."));
    }
}
