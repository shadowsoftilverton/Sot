#include "engine"

//::///////////////////////////////////////////////
//:: NPC_SPAWN.NSS
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default On Spawn script


    2003-07-28: Georg Zoeller:

    If you set a ninteger on the creature named
    "X2_USERDEFINED_ONSPAWN_EVENTS"
    The creature will fire a pre and a post-spawn
    event on itself, depending on the value of that
    variable
    1 - Fire Userdefined Event 1510 (pre spawn)
    2 - Fire Userdefined Event 1511 (post spawn)
    3 - Fire both events

    2007-12-31: Deva Winblood
    Modified to look for X3_HORSE_OWNER_TAG and if
    it is defined look for an NPC with that tag
    nearby or in the module (checks near first).
    It will make that NPC this horse's master.

*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner, Georg Zoeller
//:: Created On: June 11/03
//:://////////////////////////////////////////////
//:: Modified By: Ashton Shapcott
//:: Modified On: Aug. 22, 2009
//:: - Added randomization support.
//::
//:: Modified By: Ashton Shapcott
//:: Modified On: Nov. 23, 2010
//:: - Cleaned up variables.

const int EVENT_USER_DEFINED_PRESPAWN = 1510;
const int EVENT_USER_DEFINED_POSTSPAWN = 1511;


#include "x2_inc_switches"
#include "inc_npc"

void main()
{
    object oSelf = OBJECT_SELF;

    // TILVERTON SCRIPTS

    // Randomly spawned NPCs may or may not appear inbetween server resets.
    int iSpawnFrequency = GetLocalInt(oSelf, "SPAWN_FREQUENCY");

    if(iSpawnFrequency != 0){
        int iRoll = d100();

        if(iRoll > iSpawnFrequency){
            SetIsDestroyable(TRUE);
            DestroyObject(oSelf);
        }
    }

    string sTag;
    object oNPC;

    // User defined OnSpawn event requested?
    int nSpecEvent = GetLocalInt(oSelf,"X2_USERDEFINED_ONSPAWN_EVENTS");


    // Pre Spawn Event requested
    if (nSpecEvent == 1  || nSpecEvent == 3  )
    {
    SignalEvent(oSelf,EventUserDefined(EVENT_USER_DEFINED_PRESPAWN ));
    }

    sTag=GetLocalString(oSelf,"X3_HORSE_OWNER_TAG");
    if (GetStringLength(sTag)>0)
    { // look for master
        oNPC=GetNearestObjectByTag(sTag);
        if (GetIsObjectValid(oNPC)&&GetObjectType(oNPC)==OBJECT_TYPE_CREATURE)
        { // master found
            AddHenchman(oNPC);
        } // master found
        else
        { // look in module
            oNPC=GetObjectByTag(sTag);
            if (GetIsObjectValid(oNPC)&&GetObjectType(oNPC)==OBJECT_TYPE_CREATURE)
            { // master found
                AddHenchman(oNPC);
            } // master found
            else
            { // master does not exist - remove X3_HORSE_OWNER_TAG
                DeleteLocalString(oSelf,"X3_HORSE_OWNER_TAG");
            } // master does not exist - remove X3_HORSE_OWNER_TAG
        } // look in module
    } // look for master

    /*  Fix for the new golems to reduce their number of attacks */

    int nNumber = GetLocalInt(oSelf,CREATURE_VAR_NUMBER_OF_ATTACKS);
    if (nNumber >0 )
    {
        SetBaseAttackBonus(nNumber);
    }

    // Execute default OnSpawn script.
    ExecuteScript("nw_c2_default9", oSelf);


    //Post Spawn event requeste
    if (nSpecEvent == 2 || nSpecEvent == 3)
    {
    SignalEvent(oSelf,EventUserDefined(EVENT_USER_DEFINED_POSTSPAWN));
    }

    // TILVERTON SCRIPTS

    // Variables to determine if things need to be randomized.
    int iRandomHead     = GetLocalInt(oSelf, "RANDOM_HEAD");
    int iRandomHair     = GetLocalInt(oSelf, "RANDOM_HAIR");
    int iRandomSkin     = GetLocalInt(oSelf, "RANDOM_SKIN");
    int iRandomTattoo   = GetLocalInt(oSelf, "RANDOM_TATTOO");
    int iRandomClothing = GetLocalInt(oSelf, "RANDOM_CLOTHING");

    //if(iRandomHead)     GiveRandomHead(oSelf);
    if(iRandomHair)     GiveRandomHair(oSelf);
    //if(iRandomSkin)     GiveRandomSkin(oSelf);
    //if(iRandomTattoo)   GiveRandomTattoo(oSelf);
    //if(iRandomClothing) GiveRandomClothing(oSelf);

    int iSpawnDead = GetLocalInt(oSelf, "SPAWN_DEAD");
    int iEmote     = GetLocalInt(oSelf, "EMOTE");

    // If we're intended to spawn dead, do so.
    if(iSpawnDead){
        // Causes the corpse to persist.
        SetIsDestroyable(FALSE, FALSE, FALSE);
        effect eDeath = EffectDeath(FALSE, FALSE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oSelf);
    } else {
        // If we aren't intended to be dead, do our emotes.
        switch(iEmote){
            // Sit on ground.
            case 1:
                AssignCommand(oSelf, PlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, 600000000.0));
            break;

            // Sit in chair.
            case 2:
            break;
        }
    }
}
