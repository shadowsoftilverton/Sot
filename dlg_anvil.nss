// dlg_anvil
//
// Copyright 2005-2006 by Greyhawk0
//

// Friendly reminder:
//
// OBJECT_SELF == NPC talking with
// dlgGetPlayer() == Player that is talking

#include "zzdlg_main_inc"

const string RESPONSE_PAGE = "anvil_responses";

const string PAGE_MAIN = "main_page";
const string PAGE_INSTRUCTIONS = "instructions_page";
const string PAGE_WEAPONTYPE = "weapontype_page";
const string PAGE_ARMORTYPE = "armortype_page";
const string PAGE_MATERIALTYPE = "materialtype_page";

const string INSTRUCTIONS_SUBPAGE = "instructionsSubpage";

// Prototypes
void MainPageInit( );
void MainPageSelect( );
void InstructionInit( );
void InstructionSelect( );
void ArmorTypePageInit( );
void ArmorTypePageSelect( );
void WeaponTypePageInit( );
void WeaponTypePageSelect( );
void MaterialTypePageInit( );
void MaterialTypePageSelect( );

void OnInit( )
{
    dlgChangeLabelNext( "Next page");
    dlgChangeLabelPrevious( "Previous page");
    dlgChangePage( PAGE_MAIN );
    dlgActivatePreservePageNumberOnSelection( );
}

// Create the page
void OnPageInit( string sPage )
{
    DeleteList( RESPONSE_PAGE, dlgGetSpeakingPC() );

    // PAGE INITIALIZATIONS START
    if( sPage == PAGE_MAIN ) MainPageInit( );
    else if (sPage == PAGE_INSTRUCTIONS ) InstructionInit( );
    else if( sPage == PAGE_ARMORTYPE ) ArmorTypePageInit( );
    else if( sPage == PAGE_WEAPONTYPE ) WeaponTypePageInit( );
    // PAGE INITIALIZATIONS END

    dlgSetActiveResponseList( RESPONSE_PAGE );
}

// Handles any selection.
void OnSelection( string sPage )
{
    if ( sPage == PAGE_MAIN ) MainPageSelect( );
    else if ( sPage == PAGE_INSTRUCTIONS ) InstructionSelect( );
    else if ( sPage == PAGE_ARMORTYPE ) ArmorTypePageSelect( );
    else if ( sPage == PAGE_WEAPONTYPE ) WeaponTypePageSelect( );
}

// Reset
void OnReset( string sPage )
{
    if ( sPage == PAGE_INSTRUCTIONS )
    {
        dlgClearPlayerDataInt( INSTRUCTIONS_SUBPAGE );
    }

    dlgChangePage( PAGE_MAIN );
    dlgResetPageNumber( );
}

void OnAbort( string sPage )
{
    DeleteList( RESPONSE_PAGE, dlgGetSpeakingPC() );
    dlgClearPlayerDataInt( INSTRUCTIONS_SUBPAGE );
}
void OnEnd( string sPage )
{
    DeleteList( RESPONSE_PAGE, dlgGetSpeakingPC() );
    dlgClearPlayerDataInt( INSTRUCTIONS_SUBPAGE );
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
    dlgSetPrompt( "You approach the anvil..." );

    dlgAddResponseAction( RESPONSE_PAGE, "View Instructions" );
    dlgAddResponseAction( RESPONSE_PAGE, "Create Armor" );
    dlgAddResponseAction( RESPONSE_PAGE, "Create Weapon" );

    dlgDeactivateResetResponse( );
    dlgActivateEndResponse( "Leave anvil" );
}

void MainPageSelect( )
{
    if ( dlgIsSelectionEqualToName( "View Instructions" ) )
    {
        dlgChangePage( PAGE_INSTRUCTIONS );
    }
    else if ( dlgIsSelectionEqualToName( "Create Armor" ) )
    {
        dlgChangePage( PAGE_ARMORTYPE );
    }
    else if ( dlgIsSelectionEqualToName( "Create Weapon" ) )
    {
        dlgChangePage( PAGE_WEAPONTYPE );
    }
}
// MAIN PAGE PAGE END

// INSTRUCTIONS PAGE START
void InstructionInit( )
{
    int option = dlgGetPlayerDataInt( INSTRUCTIONS_SUBPAGE );
    switch (option)
    {
    case 0:
        dlgSetPrompt( "Please select a topic from below.");
        break;
    case 1:
        dlgSetPrompt(
        "You can make several types of objects at an anvil. You can make metal"+
        " armor such as: platemail, chainmail, and ringmail. You can make"+
        " metal weapons such as: swords, axes, knives, and scimitars. Also,"+
        " you can make tools such as: shovels, picks, smithing hammers, and"+
        " arrowheads to make arrows.");
        break;
    case 2:
        dlgSetPrompt(
        "You need a smithy hammer in your primary hand with nothing in the"+
        " secondary slot, like a shield or a second weapon, and several metal"+
        " ignots of the same type. In addition, you must be trained in"+
        " armorcrafting, weaponcrafting, toolcrafting, or metal crafting to"+
        " use an anvil. Also some other types of objects can be added during"+
        " while crafting.");
        break;
    }

    dlgAddResponseAction( RESPONSE_PAGE, "What can I make on an anvil?" );
    dlgAddResponseAction( RESPONSE_PAGE, "What do I need to use this?" );

    dlgActivateResetResponse( "Exit Instructions" );
    dlgActivateEndResponse( "Leave anvil" );
}

void InstructionSelect()
{
    // Only way out is to use "Reset".
    dlgSetPlayerDataInt( INSTRUCTIONS_SUBPAGE, ( dlgGetSelectionIndex() + 1 ) );
}

// INSTRUCTIONS PAGE END

// ARMOR TYPE PAGE START
void ArmorTypePageInit( )
{
    dlgSetPrompt( "Which type of armor do you wish to create?" );

    dlgAddResponseAction( RESPONSE_PAGE, "Chainmail" );

    dlgActivateResetResponse( "Abort creation" );
    dlgActivateEndResponse( "Leave anvil" );
}
void ArmorTypePageSelect( )
{
}

// ARMOR TYPE PAGE END

// WEAPON TYPE PAGE START

void WeaponTypePageInit( )
{
    dlgSetPrompt( "Which type of weapon do you wish to create?" );

    dlgAddResponseAction( RESPONSE_PAGE, "Bastard sword" );
    dlgAddResponseAction( RESPONSE_PAGE, "Battle axe" );
    dlgAddResponseAction( RESPONSE_PAGE, "Dagger" );
    dlgAddResponseAction( RESPONSE_PAGE, "Dire mace" );
    dlgAddResponseAction( RESPONSE_PAGE, "Double axe" );
    dlgAddResponseAction( RESPONSE_PAGE, "Greataxe" );
    dlgAddResponseAction( RESPONSE_PAGE, "Greatsword" );
    dlgAddResponseAction( RESPONSE_PAGE, "Halberd" );
    dlgAddResponseAction( RESPONSE_PAGE, "Handaxe" );
    dlgAddResponseAction( RESPONSE_PAGE, "Heavy flail" );
    dlgAddResponseAction( RESPONSE_PAGE, "Kama" );
    dlgAddResponseAction( RESPONSE_PAGE, "Katana" );
    dlgAddResponseAction( RESPONSE_PAGE, "Kukri" );
    dlgAddResponseAction( RESPONSE_PAGE, "Light flail" );
    dlgAddResponseAction( RESPONSE_PAGE, "Light hammer" );
    dlgAddResponseAction( RESPONSE_PAGE, "Longsword" );
    dlgAddResponseAction( RESPONSE_PAGE, "Mace" );
    dlgAddResponseAction( RESPONSE_PAGE, "Morningstar" );
    dlgAddResponseAction( RESPONSE_PAGE, "Rapier" );
    dlgAddResponseAction( RESPONSE_PAGE, "Scimitar" );
    dlgAddResponseAction( RESPONSE_PAGE, "Scythe" );
    dlgAddResponseAction( RESPONSE_PAGE, "Shuriken" );
    dlgAddResponseAction( RESPONSE_PAGE, "Spear" );
    dlgAddResponseAction( RESPONSE_PAGE, "Shortsword" );
    dlgAddResponseAction( RESPONSE_PAGE, "Sickle" );
    dlgAddResponseAction( RESPONSE_PAGE, "Throwing axes" );
    dlgAddResponseAction( RESPONSE_PAGE, "Two-bladed sword" );
    dlgAddResponseAction( RESPONSE_PAGE, "Waraxe" );
    dlgAddResponseAction( RESPONSE_PAGE, "Warhammer" );

    dlgActivateResetResponse( "Abort creation" );
    dlgActivateEndResponse( "Leave anvil" );
}
void WeaponTypePageSelect( )
{
}

// WEAPON TYPE PAGE END

void MaterialTypePageInit( )
{
}
void MaterialTypePageSelect( )
{
}

