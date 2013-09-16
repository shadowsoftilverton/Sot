// zzdlg_item
//
// Copyright 2005-2006 by Greyhawk0
//
// An item's onActivation conversation starter. It uses the item's properties
// for parameters. This references a dialog script that is specified as an
// item's property.

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

// Note: OBJECT_SELF is neither the item nor the player!
void main()
{
    object oPlayer = GetItemActivator( );
    object oItem = GetItemActivated( );

    if ( GetIsPC(oPlayer) == FALSE || GetIsObjectValid(oItem) == FALSE ) return;

    // Get dialog script name from item.
    string sScript = GetLocalString( oItem, DLG_VARIABLE_SCRIPTNAME );
    if ( sScript == "" ) return;

    // Gets extra parameters from item.
    int iMakeprivate = GetLocalInt( oItem, DLG_VARIABLE_MAKEPRIVATE );
    int iNoHello = GetLocalInt( oItem, DLG_VARIABLE_NOHELLO );
    int iNoZoom = GetLocalInt( oItem, DLG_VARIABLE_NOZOOM );

    // Start the dialog between the item and the player
    _dlgStart( oPlayer, oItem, sScript, iMakeprivate, iNoHello, iNoZoom );
}
