// Creates a dynamic transition placeable at lLoc and, if necessary, pairs it
// with its twin.
void CreateDynamicTransition(object oDM, location lLoc);

// Returns a unique tag for the next dynamic transition.
string GetNextDynamicTransitionTag(object oDM);

void CreateDynamicTransition(object oDM, location lLoc){
    string sTag = GetNextDynamicTransitionTag(oDM);

    object oTrans = CreateObject(OBJECT_TYPE_PLACEABLE, "fox_trans_dyn", lLoc, FALSE, sTag);

    SendMessageToDevelopers("Created transition with tag: " + GetTag(oTrans));

    string sPrevious = GetLocalString(oDM, "dm_trans_dyn_prev");

    // If we don't have a previous string, we need to set one.
    if(sPrevious == ""){
        SetLocalString(oDM, "dm_trans_dyn_prev", sTag);
    }
    // If we do have a previous tag, we need to connect the two.
    else {
        SendMessageToDevelopers("Connecting transitions.");

        SendMessageToDevelopers("Previous Tag: " + sPrevious);

        // Connect our new to the previous.
        SetLocalString(oTrans, "transition_tag", sPrevious);

        // Get the previous object.
        object oPrev = GetObjectByTag(sPrevious);

        // Connect the previous to the new.
        SetLocalString(oPrev, "transition_tag", sTag);

        SendMessageToDevelopers("Current Tag: " + sTag);

        // Delete the string to prevent unwanted linking.
        DeleteLocalString(oDM, "dm_trans_dyn_prev");
    }
}

string GetNextDynamicTransitionTag(object oDM){
    object oModule = GetModule();

    string sAccount = GetPCPlayerName(oDM);

    int i = GetLocalInt(oModule, sAccount + "_dm_trans_dyn_iter");

    SetLocalInt(oModule, sAccount + "_dm_trans_dyn_iter", i + 1);

    return sAccount + "_trans_dyn_" + IntToString(i);
}
