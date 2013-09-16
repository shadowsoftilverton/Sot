#include "engine"

#include "inc_areas"
#include "inc_debug"

int GetIsPlayerLoggedIn(object oPlayer){
    return GetPCPlayerName(oPlayer) != "";
}

void DoCheckPlayerDestination(object oArea, object oPC){
    // The player is no longer logged in. We've sprung a leak, matey!
    if(!GetIsPlayerLoggedIn(oPC)){
        SendMessageToDevelopers("Player has logged off.");

        return;
    } else if(!GetIsObjectValid(GetArea(oPC))){
        DelayCommand(6.0, DoCheckPlayerDestination(oArea, oPC));

        SendMessageToDevelopers("Player has not arrived at their destination yet. Checking again.");
    } else {
        string sInstance = GetInstanceArray(oArea);

        int nCount = GetPCCountInInstance(sInstance);

        SendMessageToDevelopers("Assessing instance <" + sInstance + "> for deletion.");
        SendMessageToDevelopers("Found <" + IntToString(nCount) + "> players in instance.");

        if(nCount == 0){
            SendMessageToDevelopers("Deleting instance.");

            DestroyDungeonInstance(sInstance);
        }
    }
}

void main()
{
    object oArea = OBJECT_SELF;
    object oCreature = GetExitingObject();

    SendMessageToDevelopers("<" + GetName(oCreature) + "> has left an instance area.");

    // Brute force time. We check that the PC is logged in (hasn't crashed in
    // their transition) and whether or not they're in a valid area. If they've
    // logged out we do nothing, because for all we know they were remaining
    // within the instance. If they're within a valid area we can then check
    // the instance's player count and destroy it if necessary.
    //
    // Right now this can leak because if a PC crashes while they're trying to
    // leave the instance and they're the last individual in the instance the
    // instance will never collapse, but for now this is the best I've come up
    // with. Furthermore, crashes aren't so common that this should cripple the
    // server, but it can be revised later by someone with a clearer head if
    // need be.
    if(GetIsPC(oCreature)) DelayCommand(6.0, DoCheckPlayerDestination(oArea, oCreature));
}
