// =============================================================================
// Horse Widget Script - Invictus, Oct. 31 2011
// Modified to pet widget script - Micteu, Apr. 04, 2012
//   Destroys or creates a pet.  This script will look at the resRef of the item
//   whose unique power was activated, and the script will determine what
//   creature is created based on that resRef.
// =============================================================================

#include "x2_inc_switches"
#include "inc_henchmen"

void main() {
    int nEvent = GetUserDefinedItemEventNumber();
    if(nEvent != X2_ITEM_EVENT_ACTIVATE) return;

    object oTarget = GetItemActivatedTarget();
    object oPC = GetItemActivator();
    // If the target is an existing pet, delete it.
    if(GetIsObjectValid(oTarget))
    {
        if(GetIsHenchmanOfPC(oPC, oTarget))
        {
            DestroyObject(oTarget);
        }
    }
    // Otherwise, make a pet.
    else
    {
        // Exiting if the player already has henchmen.
        if(GetNumHenchmenOfPC(oPC) >= GetMaxHenchmen())
        {
            SendMessageToPC(oPC, "You already have the maximum number of henchmen.");
            return;
        }
        // Setting variables to be filled based on the ResRef of the activated item.
        string sPetName; // The name visible to the PCs in-game.
        string sPetTag; // The tag on the pet once created.
        string sPetResRef; // The resRef of the pet to be created.
        // sWidgetResRef is the resRef of the widget activated.
        string sWidgetResRef = GetResRef(GetItemActivated());
        location lPet = GetItemActivatedTargetLocation();

        // The following set of if statements checks the ResRef and sets the name
        // and ResRef of the pet to match.
        if(sWidgetResRef == "mc2_pet_wgt001")
        {
            sPetName = "Parrot";
            sPetResRef = "mc2_parrot001";
        }
        else if(sWidgetResRef == "mc2_pet_wgt002")
        {
            sPetName = "Mutt";
            sPetResRef = "mc2_defaultdg001";
        }
        else if(sWidgetResRef == "mc2_pet_wgt003")
        {
            sPetName = "Black Cat";
            sPetResRef = "mc2_blackcat001";
        }
        else if(sWidgetResRef == "mc2_pet_wgt004")
        {
            sPetName = "Ferret";
            sPetResRef = "mc2_ferret001";
        }
        else if(sWidgetResRef == "mc2_pet_wgt005")
        {
            sPetName = "Pink Piglet";
            sPetResRef = "mc2_pig001";
        }
        else if(sWidgetResRef == "mc2_pet_wgt006")
        {
            sPetName = "Terrier Puppy";
            sPetResRef = "mc2_terrpuppy001";
        }
        else if(sWidgetResRef == "mc2_pet_wgt007")
        {
            sPetName = "White Kitten";
            sPetResRef = "mc2_whitekitt001";
        }
        else if(sWidgetResRef == "mc2_pet_wgt008")
        {
            sPetName = "Snake";
            sPetResRef = "mc2_snake";
        }
        else if(sWidgetResRef == "mc2_pet_wgt009")
        {
            sPetName = "Mouse";
            sPetResRef = "mc2_mouse";
        }
        else if(sWidgetResRef == "mc2_pet_wgt010")
        {
            sPetName = "Fox";
            sPetResRef = "mc2_fox";
        }
        else if(sWidgetResRef == "mc2_pet_wgt011")
        {
            sPetName = "Spider";
            sPetResRef = "mc2_spider";
        }
        else if(sWidgetResRef == "mc2_pet_wgt012")
        {
            sPetName = "Ocelot";
            sPetResRef = "mc2_ocelot";
        }
        else if(sWidgetResRef == "mc2_pet_wgt013")
        {
            sPetName = "Frog";
            sPetResRef = "mc2_frog";
        }
        else if(sWidgetResRef == "mc2_pet_wgt014")
        {
            sPetName = "Lizard";
            sPetResRef = "mc2_lizard";
        }
        else if(sWidgetResRef == "mc2_pet_wgt015")
        {
            sPetName = "Rabbit";
            sPetResRef = "mc2_rabbit";
        }
        else if(sWidgetResRef == "mc2_pet_wgt016")
        {
            sPetName = "Arctic Fox";
            sPetResRef = "mc2_whitefox001";
        }
        else if(sWidgetResRef == "mc2_pet_wgt017")
        {
            sPetName = "Fennec Fox";
            sPetResRef = "mc2_fennecfox";
        }
        else if(sWidgetResRef == "mc2_pet_wgt018")
        {
            sPetName = "Dalmatian";
            sPetResRef = "mc2_dalmatian";
        }
        else if(sWidgetResRef == "mc2_pet_wgt019")
        {
            sPetName = "Doberman";
            sPetResRef = "mc2_doberman";
        }
        else if(sWidgetResRef == "mc2_pet_wgt020")
        {
            sPetName = "Malamute";
            sPetResRef = "mc2_malamute";
        }
        else if(sWidgetResRef == "mc2_pet_wgt021")
        {
            sPetName = "Mastiff";
            sPetResRef = "mc2_mastiff";
        }
        else if(sWidgetResRef == "mc2_pet_wgt022")
        {
            sPetName = "Terrier";
            sPetResRef = "mc2_terrier";
        }
        else if(sWidgetResRef == "mc2_pet_wgt023")
        {
            sPetName = "Dalmatian Pup";
            sPetResRef = "mc2_dalmatianpup";
        }
        else if(sWidgetResRef == "mc2_pet_wgt024")
        {
            sPetName = "Doberman Pup";
            sPetResRef = "mc2_dobermanpup";
        }
        else if(sWidgetResRef == "mc2_pet_wgt025")
        {
            sPetName = "Malamute Pup";
            sPetResRef = "mc2_malamutepup";
        }
        else if(sWidgetResRef == "mc2_pet_wgt026")
        {
            sPetName = "Mastiff Pup";
            sPetResRef = "mc2_mastiffpup";
        }
        else if(sWidgetResRef == "mc2_pet_wgt027")
        {
            sPetName = "Blue Parrot";
            sPetResRef = "mc2_blueparrot";
        }
        else if(sWidgetResRef == "mc2_pet_wgt028")
        {
            sPetName = "Green Parrot";
            sPetResRef = "mc2_greenparrot";
        }
        else if(sWidgetResRef == "mc2_pet_wgt029")
        {
            sPetName = "Grey Parrot";
            sPetResRef = "mc2_greyparrot";
        }
        else if(sWidgetResRef == "mc2_pet_wgt030")
        {
            sPetName = "Cobra";
            sPetResRef = "mc2_cobra";
        }
        else
        {
            sPetName = "Mistake";
            sPetResRef = "nw_ochrejellysml";
        }

        // sPetTag will be the tag on the pet created by PetWidgetAction.
        sPetTag = "PET_" + GetName(oPC);

        object oPet = CreateObject(OBJECT_TYPE_CREATURE, sPetResRef, lPet, TRUE, sPetTag);
        SetName(oPet, GetName(oPC) + "'s " + sPetName);
        if(GetIsObjectValid(oPet))
        {
            AddHenchman(oPC, oPet);
        }
        else
        {
            AssignCommand(oPC, ActionSpeakString("Invalid Pet."));
        }
    }
}
