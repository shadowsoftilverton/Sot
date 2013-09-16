// zzdlg_zone
//
// Copyright 2005-2006 by Greyhawk0
//
//  A zone's onEnter conversation starter. It uses the zone's properties for
// parameters. This will reference the dialog script in variables.

// PARAMETERS (Variables belonging to the item)

// "dialog"
// Variable type: STRING
// Default: Does nothing if not defined.
// Description: Name of the script to use for this item. (Required)

// "makeprivate"
// Variable type: INT
// Default: Lets others hear the conversation.
// Description: 0 to let others hear conversation, 1 to not.

// "nohello"
// Variable type: INT
// Default: Doesn't play a hello.
// Description: 1 to play a hello, 0 to not play a hello.

// "nozoom"
// Variable type: INT
// Default: Zooms in on the player
// Description: 0 to zoom in on the player, 1 to not zoom.

#include "zzdlg_tools_inc"

void main()
{
    object oPlayer = GetEnteringObject( );
    object oZone = OBJECT_SELF;

    if ( GetIsPC(oPlayer) == FALSE || GetIsObjectValid(oZone) == FALSE ) return;

    // Get dialog script name from item.
    string sScript = GetLocalString( oZone, DLG_VARIABLE_SCRIPTNAME );
    if ( sScript == "" ) return;

    // Gets extra parameters from item.
    int iMakeprivate = GetLocalInt( oZone, DLG_VARIABLE_MAKEPRIVATE );
    int iNoHello = GetLocalInt( oZone, DLG_VARIABLE_NOHELLO );
    int iNoZoom = GetLocalInt( oZone, DLG_VARIABLE_NOZOOM );

    // Start the dialog between the zone and the player
    _dlgStart( oPlayer, oZone, sScript, iMakeprivate, iNoHello, iNoZoom );
}
