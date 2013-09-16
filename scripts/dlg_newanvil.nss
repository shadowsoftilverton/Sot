// dlg_newanvil
//
// Copyright 2005-2006 by Greyhawk0
//

// Friendly reminder:
//
// OBJECT_SELF == NPC talking with
// dlgGetPlayer() == Player that is talking

#include "zzdlg_main_inc"

const string RESPONSE_PAGE = "anvil_responses";

const string INVENTORY = "player_inventory_anvil";
const string OBJECT_SELECTED = "object_to_be_";

const string PAGE_MAIN = "main_page";
const string PAGE_METHOD = "method_page";


// Prototypes
void MainPageInit( );
void MainPageSelect( );

void MethodPageInit( );
void MethodPageSelect( );

void myCleanUp();

void OnInit( )
{
    dlgChangeLabelNext( "Next page");
    dlgChangeLabelPrevious( "Previous page");
    dlgChangePage( PAGE_MAIN );
}

// Create the page
void OnPageInit( string sPage )
{
    DeleteList( RESPONSE_PAGE, dlgGetSpeakingPC() );

    // PAGE INITIALIZATIONS START
    if( sPage == PAGE_MAIN ) MainPageInit( );
    else if( sPage == PAGE_METHOD ) MethodPageInit( );
    // PAGE INITIALIZATIONS END

    dlgSetActiveResponseList( RESPONSE_PAGE );
}

// Handles any selection.
void OnSelection( string sPage )
{
    if ( sPage == PAGE_MAIN ) MainPageSelect( );
    else if( sPage == PAGE_METHOD ) MethodPageSelect( );
}

// Reset
void OnReset( string sPage )
{
    dlgChangePage( PAGE_MAIN );
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

// Message handler
void main()
{
    dlgOnMessage();
}

// Specific scripting starts here

// MAIN PAGE START
void MainPageInit( )
{
    dlgSetPrompt( "You approach the anvil, select an item to manipulate." );

    DeleteList( INVENTORY, dlgGetSpeakingPC() );

    object oItem;
    int i;
    for ( i = 0; i < NUM_INVENTORY_SLOTS; i++ )
    {
        oItem = GetItemInSlot( i, dlgGetSpeakingPC() );
        if ( oItem != OBJECT_INVALID )
        {
            AddObjectElement( oItem, INVENTORY, dlgGetSpeakingPC() );
            dlgAddResponseAction( RESPONSE_PAGE, GetName( oItem ) );
        }
    }

    oItem = GetFirstItemInInventory( dlgGetSpeakingPC() );
    while ( oItem != OBJECT_INVALID )
    {
        AddObjectElement( oItem, INVENTORY, dlgGetSpeakingPC() );
        dlgAddResponseAction( RESPONSE_PAGE, GetName( oItem ) );
        oItem = GetNextItemInInventory( dlgGetSpeakingPC() );
    }

    dlgDeactivateResetResponse( );
    dlgActivateEndResponse( "Leave anvil" );
}

void MainPageSelect( )
{
    object oItem = GetObjectElement( dlgGetSelectionIndex( ), INVENTORY, dlgGetSpeakingPC() );
    if ( oItem != OBJECT_INVALID )
    {
        dlgSetPlayerDataObject( OBJECT_SELECTED, oItem );
        dlgChangePage( PAGE_METHOD );
    }
}
// MAIN PAGE END

// METHOD PAGE START
void MethodPageInit( )
{
    dlgSetPrompt( "What should I do with this?" );

    dlgAddResponseAction( RESPONSE_PAGE, "Destroy it!" );
    dlgAddResponseAction( RESPONSE_PAGE, "Clone it!" );

    dlgDeactivateResetResponse( );
    dlgActivateEndResponse( "Leave anvil" );
}

void MethodPageSelect( )
{
    object oItem = dlgGetPlayerDataObject( OBJECT_SELECTED );
    if ( oItem != OBJECT_INVALID )
    {
        if ( dlgIsSelectionEqualToName( "Destroy it!" ) )
        {
            SpeakString( GetName(oItem) + " has been destroyed!" );
            DestroyObject( oItem );
        }
        if ( dlgIsSelectionEqualToName( "Clone it!" ) )
        {
            SpeakString( GetName(oItem) + " has been cloned!" );
            CopyItem( oItem, dlgGetSpeakingPC(), TRUE );
        }
    }
    dlgEndDialog( );
}
// METHOD PAGE END

void myCleanUp()
{
    DeleteList( RESPONSE_PAGE, dlgGetSpeakingPC() );
    DeleteList( INVENTORY, dlgGetSpeakingPC() );
    dlgClearPlayerDataObject( OBJECT_SELECTED );
}

