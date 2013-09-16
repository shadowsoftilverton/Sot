void main()
{
    object oDM = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();

    if(!GetIsDM(oDM)){
        string sName = GetName(oDM);
        string sAcc = GetPCPlayerName(oDM);
        string sKey = GetPCPublicCDKey(oDM);
        string sIP = GetPCIPAddress(oDM);

        SendMessageToPC(oDM, "This tool is for dungeon master usage only. Your " +
            "usage has been logged.");
        SendMessageToAllDMs(sName + " (" + sAcc + ") attempted to use the " +
            "Diagnostic Tool illegally.");
        WriteTimestampedLogEntry("PLAYER :: ERROR :: " + sName + " (" + sAcc +
            ") (" + sKey + ") (" + sIP + ") attempted to use the Diagnostic Tool " +
            "illegally.");
    }
      /*
    AssignCommand(oPC, ActionStartConversation(oPC, "uw_on_self", TRUE, FALSE));
    SetLocalObject(oPC, "DIAGNOSTIC_TARGET", oPC);

    if(oPC == oTarget){
        AssignCommand(oPC, ActionStartConversation(oPC, "uw_on_self", TRUE, FALSE));
        SetLocalObject(oPC, "UW_TARGET", oPC);
    } else {
        if (GetObjectType(oTarget) == OBJECT_TYPE_ITEM){
            AssignCommand(oPC, ActionStartConversation(oPC, "uw_on_item", TRUE, FALSE));
            SetLocalObject(oPC, "UW_TARGET", oTarget);
        } else if (GetObjectType(oTarget) == OBJECT_TYPE_CREATURE){
            AssignCommand(oPC, ActionStartConversation(oPC, "uw_on_creature", TRUE, FALSE));
            SetLocalObject(oPC, "UW_TARGET", oTarget);
        } else {
            SendMessageToPC(oPC, "This object is not a valid target for the " +
                "Utility Wand.");
        }
    }
    */
}
