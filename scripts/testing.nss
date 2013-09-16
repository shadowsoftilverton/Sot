#include "nw_i0_2q4luskan"


void main()
{
    object oTarget;

    // Get the creature who triggered this event.
    object oPC = GetPlaceableLastClickedBy();

    // Spawn "tt_plc_remrock1".
    oTarget = GetWaypointByTag("tt_wp_tunnelrock");
    DelayCommand(5.0, CreateObjectVoid(OBJECT_TYPE_PLACEABLE, "tt_plc_remrock1", GetLocation(oTarget)));
}
