#include "engine"

#include "nwnx_events"

#include "dyncon_inc"

#include "zzdlg_tools_inc"

int StartingConditional()
{
    object oSpeaker = GetPCSpeaker();
    object oSelf = OBJECT_SELF;

    // Fetch our relevant data.
    int nNode = GetCurrentAbsoluteNodeID();

    // Fetch the text for our current node.
    string sText = GetDynamicNodeText(oSpeaker, nNode);

    // Set the text for the node in question.
    SetCurrentNodeText(sText);

    // Blank nodes are unappearing nodes.
    return sText != "";
}
