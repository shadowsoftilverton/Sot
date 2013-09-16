//Horse widget script by Hardcore UFO.
//The widget's Tag should be the name of this script.
//The widget's ResRef should be the same as the horse it summons.

#include "x2_inc_switches"
#include "inc_henchmen"
#include "inc_nametag"
#include "engine"

void HorseWidgetActivate(object oPC, location lTarget, string sHorseResRef, object oWidget);

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();
    if(nEvent != X2_ITEM_EVENT_ACTIVATE) return;

    object oPC = GetItemActivator();
    object oItem = GetItemActivated();
    location lTarget = GetItemActivatedTargetLocation();
    string sResRef = GetResRef(oItem);
    object oTarget = GetItemActivatedTarget();

    if(GetIsHorse(oTarget) && GetLocalObject(oTarget, "HorseOwner") == oPC)
    {
        DestroyObject(oTarget);
        DeleteLocalObject(oPC, "HorseActive");
    }

    HorseWidgetActivate(oPC, lTarget, sResRef, oItem);
}

void HorseWidgetActivate(object oPC, location lTarget, string sHorseResRef, object oWidget)
{
    // Exiting if the player already has henchmen.
    if(GetNumHenchmenOfPC(oPC) >= GetMaxHenchmen())
    {
        SendMessageToPC(oPC, "You already have the maximum number of henchmen.");
        return;
    }

    else if(GetNumHorses(oPC) > 0 || GetLocalObject(oPC, "HorseActive") != OBJECT_INVALID)
    {
        SendMessageToPC(oPC, "You already have a horse.");
        return;
    }

    else if(GetIsAreaInterior(GetArea(oPC)))
    {
        SendMessageToPC(oPC, "Either the horse wouldn't be allowed in here, or he would have a hard time walking. Try outside.");
        return;
    }

    else if(GetLocalInt(oPC, "HorseParking") < 1)
    {
        SendMessageToPC(oPC, "Please go to a horse safe zone to summon your horse, where presumably it would be kept.");
        return;
    }

    string sHorseTag = "HRS_" + GenerateTagFromName(oPC);
    //location lHorse = GetItemActivatedTargetLocation();

    object oHorse = CreateObject(OBJECT_TYPE_CREATURE, sHorseResRef, /*lHorse*/lTarget, TRUE, sHorseTag);
    SetName(oHorse, GetName(oPC) + "'s Horse");
    SetLocalObject(oHorse, "HorseOwner", oPC);
    SetLocalInt(oHorse, "bX3_IS_MOUNT", 1);

    if(GetIsObjectValid(oHorse))
    {
        AddHenchman(oPC, oHorse);

        SetLocalString(oHorse, "X3_HORSE_PREMOUNT_SCRIPT", "hrs_prem001");
        SetLocalString(oHorse, "X3_HORSE_POSTDISMOUNT_SCRIPT", "hrs_pstd001");
        SetLocalObject(oPC, "HorseWidget", oWidget);
        SetLocalObject(oPC, "HorseActive", oHorse);
        SetLocalObject(oWidget, "HorseActive", oHorse);
    }

    else
        FloatingTextStringOnCreature("Invalid Horse.", oPC, TRUE);
}
