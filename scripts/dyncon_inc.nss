#include "engine"

const string LV_CON_NODE = "dyncon_node_";

string GetDynamicNodeText(object oSpeaker, int nNode){
    return GetLocalString(oSpeaker, LV_CON_NODE + IntToString(nNode));
}

void SetDynamicNodeText(object oSpeaker, int nNode, string sText){
    SetLocalString(oSpeaker, LV_CON_NODE + IntToString(nNode), sText);
}

