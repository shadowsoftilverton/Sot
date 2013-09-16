// dlg_music
//
// Copyright 2005-2006 by Greyhawk0
//

// Friendly reminder:
//
// OBJECT_SELF == NPC talking with
// dlgGetPlayer() == Player that is talking

#include "zzdlg_main_inc"

const string RESPONSE_PAGE = "music_responses";

const string PAGE_MAIN = "main_page";

// Prototypes
void MainPageInit( );
void MainPageSelect( );

void OnInit()
{
    dlgChangeLabelNext( "Next page" );
    dlgChangeLabelPrevious( "Previous page" );
    dlgChangePage( PAGE_MAIN );
}

void OnPageInit( string sPage )
{
    DeleteList( RESPONSE_PAGE, dlgGetSpeakingPC() );


    // Only one page to worry about.
    MainPageInit( );

    dlgSetActiveResponseList( RESPONSE_PAGE );
}

void OnSelection( string sPage )
{
    // Only one page to worry about.
    MainPageSelect( );
}

void OnReset( string sPage )
{
}
void OnAbort( string sPage )
{
    DeleteList( RESPONSE_PAGE, dlgGetSpeakingPC() );
}

void OnEnd( string sPage )
{
    DeleteList( RESPONSE_PAGE, dlgGetSpeakingPC() );
}

void OnContinue( string sPage, int iContinuePage )
{
}
// Message handler
void main()
{
    dlgOnMessage();
}

// Specific scripting starts here

// MAIN PAGE START
void MainPageInit( )
{
    dlgSetPrompt( "Pick a music track!" );

    int i;
    for (i = 0; i < 50; i++)
    {
        dlgAddResponseAction(  RESPONSE_PAGE, ( "Track " + IntToString( i ) ));
    }

    dlgActivatePreservePageNumberOnSelection( );
    dlgActivateEndResponse( "No change" );
}

void MainPageSelect( )
{
    MusicBackgroundChangeDay( GetArea( dlgGetSpeakingPC() ), dlgGetSelectionIndex() );
    MusicBackgroundChangeNight( GetArea( dlgGetSpeakingPC() ), dlgGetSelectionIndex() );
}
// MAIN PAGE PAGE END


