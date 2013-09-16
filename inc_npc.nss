//::///////////////////////////////////////////////
//:: INC_NPC.NSS
//:: Silver Marches File
//:://////////////////////////////////////////////
/*
    Provides additional functionality for NPCs of
    any type. Results are largely cosmetic; any
    changes to the NPC in terms of combat ability
    should be placed within inc_enemies.nss, which deals
    with hostile NPCs.
*/
//:://////////////////////////////////////////////
//:: Created By: Ashton Shapcott
//:: Created On: Oct. 28, 2010
//:://////////////////////////////////////////////

// Sets oNPC to have a random head.
//
// If local variables RANDOM_HEAD_* are defined on the given NPC, it will pick
// from that list (list must be numbered from 1 onward, i.e. RANDOM_HEAD_1,
// RANDOM_HEAD_2, ..., RANDOM_HEAD_100). Otherwise the script automatically
// picks from a list of "acceptable" heads for the given race/gender. All local
// variables must be integers.
void GiveRandomHead(object oNPC);

// Sets oNPC to have a random hair color.
//
// There are 6 different hair color variables you can assign weights to in order
// to obtain a specific appearance, each prefixed by WEIGHT_HAIR_*. The colors
// available are: BROWN, RED, BLONDE, WHITE, GRAY, and BLACK. The higher the
// weight for any given color the more likely it will appear. If none of these
// variables are specified the script will assign a default weight to each color.
void GiveRandomHair(object oNPC);

// Sets oNPC to have a random skin color.
//
// If local variables RANDOM_SKIN_* are defined on the given NPC, it will pick
// from that list (list must be numbered from 1 onward, i.e. RANDOM_SKIN_1,
// RANDOM_SKIN_2, ..., RANDOM_SKIN_100). Otherwise the script automatically
// picks from a list of "acceptable" skin colors for the given race/gender. All
// local variables must be integers.
void GiveRandomSkin(object oNPC);

// Sets oNPC to have random tattoo colors.
//
// If local variables RANDOM_TATTOO_* are defined on the given NPC, it will pick
// from that list (list must be numbered from 1 onward, i.e. RANDOM_TATTOO_1,
// RANDOM_TATTOO_2, ..., RANDOM_TATTOO_100). Otherwise the script randomly picks
// any one of the given tattoo colors on the palette. All local variables must
// be integers.
void GiveRandomTattoo(object oNPC);

// Gives oNPC a random set of clothing.
//
// If local variables RANDOM_CLOTHING_* are defined on the given NPC, it will pick
// from that list (list must be numbered from 1 onward, i.e. RANDOM_CLOTHING_1,
// RANDOM_CLOTHING_2, ..., RANDOM_CLOTHING_100). Otherwise the script automatically
// picks from a list of "acceptable" clothing (commoner clothing) based on race/gender.
// All local variables must be integers.
void GiveRandomClothing(object oNPC);

void GiveRandomHead(object oNPC){
    int iRace = GetRacialType(oNPC);
    int iGender = GetGender(oNPC);
    int iHead;

    // Check if there's a custom list. First checks to make sure the first node
    // has a value, then increases iCounter as needed. This is to ensure that
    // a confused builder doesn't put in only one value thinking they need
    // random heads enabled to get random hair colors.
    int iCounter = 1;

    if(GetLocalInt(oNPC, "RANDOM_HEAD_" + IntToString(iCounter)) > 0){
        // Check out how big the list is.
        while (GetLocalInt(oNPC, "RANDOM_HEAD_" + IntToString(iCounter)) > 0){
            iCounter++;
        }

        // Smack on a value.
        iHead = GetLocalInt(oNPC, "RANDOM_HEAD_" + IntToString(Random(iCounter) + 1));
    } else {
        //iHead = GenerateRandomHead(iRace, iGender);
    }

    SetCreatureBodyPart(CREATURE_PART_HEAD, iHead, oNPC);
}

// Note: This one is really messy because I really couldn't figure out a better
// solution. Kudos if you do!
void GiveRandomHair(object oNPC){
    int iRace = GetRacialType(oNPC);
    int iGender = GetGender(oNPC);
    int iHair = -1;

    int iBrown      = GetLocalInt(oNPC, "WEIGHT_HAIR_BROWN");
    int iRed        = GetLocalInt(oNPC, "WEIGHT_HAIR_RED");
    int iBlonde     = GetLocalInt(oNPC, "WEIGHT_HAIR_BLONDE");
    int iWhite      = GetLocalInt(oNPC, "WEIGHT_HAIR_WHITE");
    int iGray       = GetLocalInt(oNPC, "WEIGHT_HAIR_GRAY");
    int iBlack      = GetLocalInt(oNPC, "WEIGHT_HAIR_BLACK");

    int iTotal = iBrown + iRed + iBlonde + iWhite + iGray + iBlack;

    if(iTotal == 0){
        iBrown  = 10;
        iRed    = 5;
        iBlonde = 5;
        iWhite  = 10;
        iGray   = 10;
        iBlack  = 60;

        iTotal  = iBrown + iRed + iBlonde + iWhite + iGray + iBlack;
    }

    int iRandom = Random(iTotal) + 1;

    int iCap = iBrown;

    int iSelect;

    if(iRandom < iCap && iHair == -1){
        iSelect = Random(8);

        switch(iSelect){
            case 0: iHair = 0;  break;
            case 1: iHair = 1;  break;
            case 2: iHair = 2;  break;
            case 3: iHair = 3;  break;
            case 4: iHair = 12; break;
            case 5: iHair = 13; break;
            case 6: iHair = 14; break;
            case 7: iHair = 15; break;
        }
    }

    iCap += iRed;

    if(iRandom < iCap && iHair == -1){
        iSelect = Random(4);

        switch(iSelect){
            case 0: iHair = 4;  break;
            case 1: iHair = 5;  break;
            case 2: iHair = 6;  break;
            case 3: iHair = 7;  break;
        }
    }

    iCap += iBlonde;

    if(iRandom < iCap && iHair == -1){
        iSelect = Random(4);

        switch(iSelect){
            case 0: iHair = 8;  break;
            case 1: iHair = 9;  break;
            case 2: iHair = 10; break;
            case 3: iHair = 11; break;
        }
    }

    iCap += iWhite;

    if(iRandom < iCap && iHair == -1){
        iSelect = Random(2);

        switch(iSelect){
            case 0: iHair = 16; break;
            case 1: iHair = 17; break;
        }
    }

    iCap += iGray;

    if(iRandom < iCap && iHair == -1){
        iSelect = Random(2);

        switch(iSelect){
            case 0: iHair = 18; break;
            case 1: iHair = 19; break;
        }
    }

    iCap += iBlack;

    if(iRandom < iCap && iHair == -1){
        iSelect = Random(4);

        switch(iSelect){
            case 0: iHair = 20; break;
            case 1: iHair = 21; break;
            case 2: iHair = 22; break;
            case 3: iHair = 23; break;
        }
    }

    SetColor(oNPC, COLOR_CHANNEL_HAIR, iHair);
}
