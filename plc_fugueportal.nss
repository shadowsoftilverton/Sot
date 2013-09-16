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
void main()
{
    object oSelf = OBJECT_SELF;
    object oPlayer = GetLastUsedBy();
    string oTargetWaypoint = "wp_fugue_hub_anchor";
    string sServerHost;
    string sServerPort = "5121";

    // We don't care if non-PCs or non-DMs use the transition.
    if(!(GetIsPC(oPlayer) || GetIsDM(oPlayer))) return;

    if(GetSubString(GetPCIPAddress(oPlayer), 0, 3) == "192")
        sServerHost = "192.168.1.1";
    else
        sServerHost = "shadowsoftilverton.dyndns.org";

    ActivatePortal(oPlayer, sServerHost + ":" + sServerPort, "", oTargetWaypoint, TRUE);
}
