#include "engine"

#include "nwnx_funcs"

void PrintBasicInformation(object oRecipient, object oTarget){
    SendMessageToPC(oRecipient, " --> Basic Information");
    SendMessageToPC(oRecipient, "");
    SendMessageToPC(oRecipient, "True Name: " + GetName(oTarget, TRUE));
    SendMessageToPC(oRecipient, "Tag: " + GetTag(oTarget));
    SendMessageToPC(oRecipient, "ResRef: " + GetResRef(oTarget));

    if(GetIsPC(oTarget)) SendMessageToPC(oRecipient, "Account: " + GetPCPlayerName(oTarget));
    if(GetIsPC(oTarget)) SendMessageToPC(oRecipient, "CD Key: " + GetPCPublicCDKey(oTarget));
    if(GetIsPC(oTarget)) SendMessageToPC(oRecipient, "IP Add: " + GetPCIPAddress(oTarget));
}

void PrintAllLocalVariables(object oRecipient, object oTarget){
    struct LocalVariable lv = GetFirstLocalVariable(oTarget);
    string content, name, index;

    SendMessageToPC(oRecipient, " --> Local Variables");
    SendMessageToPC(oRecipient, "");

    while(GetIsVariableValid(lv)){
        content = ObjectToString(lv.obj);
        name = lv.name;
        index = IntToString(lv.pos);

        SendMessageToPC(oRecipient, index + ": " + name + " - " + content);

        lv = GetNextLocalVariable(lv);
    }
}

void main()
{
    object oDM = GetPCSpeaker();
    object oTarget = GetLocalObject(oDM, "DIA_TARGET");

    SendMessageToPC(oDM, "----> Diagnostics for " + GetName(oTarget));
    SendMessageToPC(oDM, "");
    PrintBasicInformation(oDM, oTarget);
    SendMessageToPC(oDM, "");
    PrintAllLocalVariables(oDM, oTarget);
    SendMessageToPC(oDM, "");
}
