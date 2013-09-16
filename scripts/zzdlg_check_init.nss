// zzdlg_check_init
//
// Original filename under Z-Dialog: zdlg_check_init
// Copyright (c) 2004 Paul Speed - BSD licensed.
//  NWN Tools - http://nwntools.sf.net/
//
// Additions and changes from original copyright (c) 2005-2006 Greyhawk0

#include "zzdlg_tools_inc"

int StartingConditional()
{
    object oSpeaker = _dlgGetPcSpeaker();

    // Check to see if the conversation is done.
    int iState = GetLocalInt( oSpeaker, DLG_STATE );

    // This code is to show a final farewell, and have an "End Dialog" option like the normal conversations.
    if ( iState == DLG_STATE_ENDED )
    {
        string sFarewellMessage = GetLocalString( oSpeaker, DLG_FAREWELL );
        if (sFarewellMessage=="") return ( FALSE ); // Normal behavior.

        // This sets everything up for the final farewell and end dialog.
        SetLocalString( oSpeaker, DLG_PROMPT, sFarewellMessage );
        SetLocalString( oSpeaker, DLG_PAGE_NAME, "" );
        SetLocalString( oSpeaker, DLG_RESPONSE_LIST, "" );
        SetLocalInt( oSpeaker, DLG_HAS_END, FALSE );
        SetLocalInt( oSpeaker, DLG_HAS_RESET, FALSE );
    }

    // Initialize the page and possibly the entire conversation
    if ( iState != DLG_STATE_ENDED )
    {
        _dlgInitializePage( oSpeaker );
    }

    // Just for continue chains.
    _SetupContinueChainedPrompt( oSpeaker );

    // Initialize the values from the dialog configuration
    SetCustomToken( DLG_BASE_TOKEN, GetLocalString( oSpeaker, DLG_PROMPT ) );

    return TRUE;
}
