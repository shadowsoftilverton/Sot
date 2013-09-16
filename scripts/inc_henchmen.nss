// =============================================================================
// inc_henchmen: Invictus, Nov. 18, 2011
// Modified by Micteu Apr 9, 2012
//   Added GetNumHenchmen, GetNumPets, GetSummons, and GetNumHorses.
//   Added a bunch more functions.
//   Added documentation and definitions.
// =============================================================================

// =============================================================================
// DEFINITIONS.
// =============================================================================

// Checks if oPC is a PC, then returns the number of henchmen following oPC.
int GetNumHenchmenOfPC(object oPC);

// Returns the number of henchmen following oPC.
int GetNumHenchmen(object oPC);

// GetSpecificNumHenchmen looks for sType in the beginning of a henchman tag.
// Consider using GetNumPets, GetNumHorses, or GetNumSummons instead.
int GetSpecificNumHenchmen(object oPC, string sType);

// Returns the number of pets following oPC.
int GetNumPets(object oPC);

// Returns the number of horses following oPC.
int GetNumHorses(object oPC);

// Returns the number of summons following oPC.
int GetNumSummons(object oPC);

// Returns the number of blades following oPC.
int GetNumBlades(object oPC);

// Returns the number of undead following oPC.
int GetNumUndead(object oPC);

// Checks if oPC is a PC, then returns TRUE if oTarget is a henchman belonging
// to oPC.
int GetIsHenchmanOfPC(object oPC, object oTarget);

// Checks to make sure the henchman actually belongs to oPC, then destroys.
void DestroyHenchman(object oPC, object oTarget);

// Checks to see if oTarget is a certain type.
int GetIsHenchmanType(object oTarget, string sType);

// Checks to see if oTarget is a pet.
int GetIsPet(object oTarget);

// Checks to see if oTarget is a horse.
int GetIsHorse(object oTarget);

// Checks to see if oTarget is a summon.
int GetIsSummon(object oTarget);

// Checks to see if oTarget is a blade.
int GetIsBlade(object oTarget);

// Checks to see if oTarget is an undead.
int GetIsUndead(object oTarget);

// =============================================================================
// IMPLEMENTATION.
// =============================================================================

int GetNumHenchmenOfPC(object oPC) {
    if(!GetIsPC(oPC)) return -1;

    int nHenchmen = 0;

    int i;
    for(i = 0; i <= GetMaxHenchmen(); i++) {
        if(GetIsObjectValid(GetHenchman(oPC, i)))
            nHenchmen++;
    }
    return nHenchmen;
}

int GetNumHenchmen(object oPC) {
    int nHenchmen = 0;
    int i;
    for(i = 0; i <= GetMaxHenchmen(); i++) {
        if(GetIsObjectValid(GetHenchman(oPC, i)))
            nHenchmen++;
    }
    return nHenchmen;
}

// GetSpecificNumHenchmen looks for sType in the beginning of a henchman tag.
int GetSpecificNumHenchmen(object oPC, string sType)
{
    int nType = 0; // number of henchmen of this specific type.
    int i;
    int henchCount = GetNumHenchmen(oPC);
    string sHenchTag;
    // For every henchman oPC has, check if it is of the correct type.
    for(i = i; i <= henchCount; i++) {
        sHenchTag = GetTag(GetHenchman(oPC, i));
        // A henchman is considered a pet if the first four characters of its
        // tag match sType.
        if(GetSubString(sHenchTag, 0, 4) == sType)
        {
            // If yes, increment the pet count.
            nType++;
        }
    }
    return nType;
}

// Returns the number of pets following oPC.
int GetNumPets(object oPC){
    return GetSpecificNumHenchmen(oPC, "PET_");
}

// Returns the number of horses following oPC.
int GetNumHorses(object oPC){
    return GetSpecificNumHenchmen(oPC, "HRS_");
}

// Returns the number of summons following oPC.
int GetNumSummons(object oPC){
    return GetSpecificNumHenchmen(oPC, "SMN_");
}

// Returns the number of blades following oPC.
int GetNumBlades(object oPC){
    return GetSpecificNumHenchmen(oPC, "BLD_");
}

// Returns the number of undead following oPC.
int GetNumUndead(object oPC){
    return GetSpecificNumHenchmen(oPC, "UND_");
}

int GetIsHenchmanOfPC(object oPC, object oTarget) {
    if(!GetIsPC(oPC)) return -1;

    int i;
    object oHenchman;
    for(i = 0; i <= GetMaxHenchmen(); i++) {
        oHenchman = GetHenchman(oPC, i);

        if(GetIsObjectValid(oHenchman)) {
            if(oTarget == oHenchman)
                return TRUE;
        }
    }
    return FALSE;
}

// Checks to make sure the henchman actually belongs to oPC, then destroys.
void DestroyHenchman(object oPC, object oTarget)
{
    if(GetIsHenchmanOfPC(oPC, oTarget))
    {
        DestroyObject(oTarget);
    }
}

// Checks to see if oTarget is a certain type of henchman.
int GetIsHenchmanType(object oTarget, string sType)
{
    // Getting the prefix (first four characters) of oTarget's tag.
    string sTagPrefix = GetStringLeft(GetTag(oTarget), 4);
    if (sTagPrefix == sType)
    {
        return TRUE;
    }
    return FALSE;
}

// Checks to see if oTarget is a pet.
int GetIsPet(object oTarget){
    return GetIsHenchmanType(oTarget, "PET_");
}

// Checks to see if oTarget is a horse.
int GetIsHorse(object oTarget){
    return GetIsHenchmanType(oTarget, "HRS_");
}

// Checks to see if oTarget is a summon.
int GetIsSummon(object oTarget){
    return GetIsHenchmanType(oTarget, "SMN_");
}

// Checks to see if oTarget is a blade.
int GetIsBlade(object oTarget){
    return GetIsHenchmanType(oTarget, "BLD_");
}

// Checks to see if oTarget is an animated/created undead.
int GetIsUndead(object oTarget){
    return GetIsHenchmanType(oTarget, "UND_");
}
