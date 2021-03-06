/*
 *  Script generated by LS Script Generator, v.TK.0
 *
 *  For download info, please visit:
 *  http://nwvault.ign.com/View.php?view=Other.Detail&id=1502
 */
// Put this under "Actions Taken" in the conversation editor.


void main()
{
    object oSelf = OBJECT_SELF;
    object oTarget;
    object oSpawn;

    // Get the PC who is in this conversation.
    object oPC = GetPCSpeaker();

    // If the PC has the item "tt_item_rope".
    if ( GetItemPossessedBy(oPC, "tt_item_rope") != OBJECT_INVALID )
    {

        DestroyObject(GetObjectByTag("tt_item_rope"));
        // Spawn some placeables.

        oTarget = GetWaypointByTag("tt_wp_rope");
        oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "tt_plc_rope", GetLocation(oTarget));

        oTarget = GetWaypointByTag("tt_wp_stal");
        oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "sm_rock287", GetLocation(oTarget));


        // Destroy an object (not fully effective until this script ends).
        DelayCommand(2.0, DestroyObject(oSelf));
    }
    else
    {
        // Send a message to the player's chat window.
        SendMessageToPC(oPC, "You do not have a rope!");
    }
}


