#include "engine"
#include "inc_multiserver"
#include "inc_debug"

/**
* Attach this script to area transitions intended to portal PCs between
* server instances.
*
* Authored by Stephen "Invictus"
*
*/
void main() {
    object oSelf = OBJECT_SELF;
    object oPlayer = GetClickingObject();
    string oTargetWaypoint = GetLocalString(oSelf, "portal_dest");
    int nTargetType = GetLocalInt(oSelf, "portal_dest_type");
    string sServerHost;
    string sServerPort;

    // We don't care if non-PCs or non-DMs use the transition.
    if(!(GetIsPC(oPlayer) || GetIsDM(oPlayer))) return;

    SendMessageToDevelopers("PC " + GetName(oPlayer) + " attempting to portal from IP address " + GetPCIPAddress(oPlayer) + ".");

    if(GetSubString(GetPCIPAddress(oPlayer), 0, 3) == "192")
        sServerHost = "192.168.0.240";
    else
        sServerHost = "shadowsoftilverton.dyndns.org";

    switch(nTargetType) {
        case INSTANCE_TYPE_HUB:
            sServerPort = "5121";
            break;
        case INSTANCE_TYPE_DUNGEON:
            sServerPort = "5123";
            break;
    }

    ActivatePortal(oPlayer, sServerHost + ":" + sServerPort, "", oTargetWaypoint, TRUE);
}
