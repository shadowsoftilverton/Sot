// dlg_twins
//
// Copyright 2005-2006 by Greyhawk0
//

// Friendly reminder:
//
// OBJECT_SELF == NPC talking with
// dlgGetPlayer() == Player that is talking

#include "zzdlg_main_inc"
#include "zzdlg_tokens_inc"

const string POET_RESPONSE_LIST = "poet_response";

const string PAGE_MAIN = "main_page"; // Only one page used here.

// Prototypes for my own functions.
void myOnMainPageInit( );
void myOnMainPageSelect( );
void myCleanUp( );

// Now defining all functions required by dlg_wrapper.

// Called on dialog initialization!
void OnInit( )
{
    // Setup automated responses for this script .
    dlgChangeLabelNext( "Next page" );
    dlgChangeLabelPrevious( "Previous page" );
    dlgActivateEndResponse( "Goodbye" );
    dlgDeactivateResetResponse();
    dlgDeactivatePreservePageNumberOnSelection();

    dlgChangePage( PAGE_MAIN );

    // Wave hello!
    AssignCommand( dlgGetGhostPossessor(), ActionPlayAnimation( ANIMATION_FIREFORGET_GREETING ) );

    dlgSetFarewell( "It was nice talking to you, have a good " + dlgTokenQuarterDay() );
}

// Called on page initialization. (passes page name)
void OnPageInit( string sPage )
{
    DeleteList( POET_RESPONSE_LIST, dlgGetSpeakingPC() );

    if ( sPage == PAGE_MAIN ) myOnMainPageInit( );

    dlgSetActiveResponseList( POET_RESPONSE_LIST );
}

void OnSelection( string sPage )
{
    if ( sPage == PAGE_MAIN ) myOnMainPageSelect( );
}

void OnReset( string sPage )
{
}

void OnAbort( string sPage )
{
    myCleanUp( );
}

void OnEnd( string sPage )
{
    myCleanUp( );
}

void OnContinue( string sPage, int iContinuePage )
{
}

// Let dlg_wrapper tell us which event fired. (Required)
void main()
{
    dlgOnMessage();
}

// My own functions for this poet.

// MAIN PAGE START
void myOnMainPageInit( )
{
    dlgSetPrompt( "Hello, good "+dlgTokenQuarterDay()+"!" );

    if (GetName(OBJECT_SELF) == "Girl") dlgAddResponseAction(POET_RESPONSE_LIST, "Switch to boy");
    if (GetName(OBJECT_SELF) == "Boy") dlgAddResponseAction(POET_RESPONSE_LIST, "Switch to girl");
}

void myOnMainPageSelect( )
{
    if ( dlgGetSelectionName() == "Switch to boy" )
    {
        dlgChangeSpeakeeByTag("NW_MALEKID01");
    }
    else if ( dlgGetSelectionName() == "Switch to girl" )
    {
        dlgChangeSpeakeeByTag("NW_FEMALEKID01");
    }
}
// MAIN PAGE PAGE END

void myCleanUp( )
{
}
