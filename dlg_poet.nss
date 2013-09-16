// dlg_poet
//
// Copyright 2005-2006 by Greyhawk0
//

// Friendly reminder:
//
// OBJECT_SELF == NPC talking with
// dlgGetPlayer() == Player that is talking

#include "zzdlg_main_inc"

const string POET_RESPONSE_LIST = "poet_response";
const string POET_CONTINUE_CHAIN_LIST = "poet_continue_chain";

const string PAGE_MAIN = "main_page"; // Only one page used here.

// Temporary Player data names.
const string PD_POEM_TYPE = "poet_pd_poem_type";

const int POEM_MARYLAMB = 1;

// Prototypes for my own functions.
void myOnMainPageInit( );
void myOnMainPageSelect( );
void myKillPlayer( );
void mySetupPoemList( );
void myCleanUp( );

// Now defining all functions required by dlg_wrapper.

// Create the page
void OnInit( )
{
    dlgChangeLabelNext( "Next page" );
    dlgChangeLabelPrevious( "Previous page" );
    dlgActivateEndResponse( "Goodbye" );
    dlgChangePage( PAGE_MAIN );
    dlgSetFarewell("Perhaps another time then? Good day!");
    ActionPlayAnimation( ANIMATION_FIREFORGET_GREETING );
}

// Create the page
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
    // Reset button insults
    myKillPlayer( );
}

void OnAbort( string sPage )
{
    if ( dlgGetCurrentContinuePage() >= 0 ) // Mid poem?
    {
        myKillPlayer( );
    }
    myCleanUp( );
}

void OnEnd( string sPage )
{
    myCleanUp( );
    ActionPlayAnimation( ANIMATION_FIREFORGET_GREETING );
}

void OnContinue( string sPage, int iContinuePage )
{
    switch ( dlgGetPlayerDataInt( PD_POEM_TYPE ) )
    {
    case POEM_MARYLAMB:
        // Mary had a little lamb events. We change the reset message to spice
        //  things up.
        switch ( iContinuePage )
        {
        case -1: // Done with chain AND last page
            TakeGoldFromCreature( 1, dlgGetSpeakingPC(), TRUE );
            dlgClearContinueList( POET_CONTINUE_CHAIN_LIST );
            dlgDeactivateResetResponse( );
            dlgActivateEndResponse( "Goodbye" );
            break;
        case 1: // First page
            dlgDeactivateEndResponse( );
            break;
        case 2: // 2nd
            dlgActivateResetResponse( "I've had enough of this, good day!" );
            break;
        case 3: // 3rd
            dlgActivateResetResponse( "Booooring! Learn to recite poetry!" );
            break;
        case 4: // 4th
            dlgActivateResetResponse( "Finally finished, took you long enough!" );
            break;
        }
        break;
    }
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
    dlgSetPrompt( "What poem would you like to hear? 1 GP per recital!" );

    mySetupPoemList( );
}

void myOnMainPageSelect( )
{
    if ( dlgIsSelectionEqualToName( "Mary had a little lamb" ) )
    {
        dlgSetPlayerDataInt( PD_POEM_TYPE, POEM_MARYLAMB );

        dlgAddContinueChainMsg( POET_CONTINUE_CHAIN_LIST,
            "Mary had a little lamb,\nlittle lamb,\nlittle lamb.\n"+
            "Mary had a little lamb,\nIts fleece was white as snow." );

        dlgAddContinueChainMsg( POET_CONTINUE_CHAIN_LIST,
            "Everywhere that Mary went,\nMary went,\nMary went.\n"+
            "Everywhere that Mary went,\nThe lamb was sure to go." );

        dlgAddContinueChainMsg( POET_CONTINUE_CHAIN_LIST,
            "It followed her to school one day,\nschool one day,\n"+
            "school one day.\nIt followed her to school one day,\nWhich was against the rules." );

        dlgAddContinueChainMsg( POET_CONTINUE_CHAIN_LIST,
            "It made the children laugh and play,\nlaugh and play,\n"+
            "laugh and play.\nIt made the children laugh and play,\nTo see a lamb at school." );

        dlgAddContinueChainMsg( POET_CONTINUE_CHAIN_LIST,
            "I hope you enjoyed it! Would you like to hear another? 1 gold piece per poem!" );

        dlgSetupContinueChain( POET_CONTINUE_CHAIN_LIST );
    }
}
// MAIN PAGE PAGE END

// My go crazy and kill the player script
void myKillPlayer( )
{
    SetIsTemporaryEnemy( dlgGetSpeakingPC( ), OBJECT_SELF );
    dlgSetFarewell("");
    dlgEndDialog( );
    DelayCommand( 2.0f, AssignCommand( OBJECT_SELF, ActionAttack( dlgGetSpeakingPC( ) ) ) );
    SpeakString( "You will pay for that!" );
}

void mySetupPoemList( )
{
    dlgAddResponseTalk( POET_RESPONSE_LIST, "Mary had a little lamb" );
}

void myCleanUp( )
{
    dlgClearResponseList( POET_RESPONSE_LIST );
    dlgClearContinueList( POET_CONTINUE_CHAIN_LIST );
    dlgClearPlayerDataInt( PD_POEM_TYPE );
}
