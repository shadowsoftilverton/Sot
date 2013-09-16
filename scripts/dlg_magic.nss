// dlg_magic
//
// Copyright 2005-2006 by Greyhawk0
//

// Friendly reminder:
//
// OBJECT_SELF == NPC talking with
// dlgGetPlayer() == Player that is talking

#include "zzdlg_main_inc"

const string POET_RESPONSE_LIST = "poet_response";

const string PAGE_MAIN = "main_page"; // Only one page used here.

// Prototypes for my own functions.
void myOnMainPageInit( );
void myOnMainPageSelect( );
void myCleanUp( );

// Now defining all functions required by dlg_wrapper.

// Create the page
void OnInit( )
{
    dlgChangeLabelNext( "Next page" );
    dlgChangeLabelPrevious( "Previous page" );
    dlgActivateEndResponse( "Do nothing" );
    dlgChangePage( PAGE_MAIN );
    dlgActivatePreservePageNumberOnSelection();
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
    dlgSetPrompt( "What effect would you like to see?" );

    dlgAddResponseAction( POET_RESPONSE_LIST, "Summon Lightning" );
    dlgAddResponseAction( POET_RESPONSE_LIST, "Summon Fire" );
    dlgAddResponseAction( POET_RESPONSE_LIST, "Summon Frost" );
    dlgAddResponseAction( POET_RESPONSE_LIST, "Summon Poison" );
    dlgAddResponseAction( POET_RESPONSE_LIST, "Summon Tornado" );
    dlgAddResponseAction( POET_RESPONSE_LIST, "Summon Holy" );
    dlgAddResponseAction( POET_RESPONSE_LIST, "Summon Sigularity" );
    dlgAddResponseAction( POET_RESPONSE_LIST, "Summon Meteor Swarm" );
}

void myOnMainPageSelect( )
{
    SendMessageToPC(dlgGetSpeakingPC(), dlgGetSelectionName());

    if (dlgGetSelectionName()=="Summon Lightning")
    {
        effect sfx = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
        location loc = GetLocation(GetObjectByTag("NW_WAYPOINT001"));
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, sfx, loc);
    }
    else if (dlgGetSelectionName()=="Summon Fire")
    {
        effect sfx = EffectVisualEffect(VFX_IMP_FLAME_M);
        location loc = GetLocation(GetObjectByTag("NW_WAYPOINT001"));
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, sfx, loc);
    }
    else if (dlgGetSelectionName()=="Summon Frost")
    {
        effect sfx = EffectVisualEffect(VFX_IMP_FROST_L);
        location loc = GetLocation(GetObjectByTag("NW_WAYPOINT001"));
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, sfx, loc);
    }
    else if (dlgGetSelectionName()=="Summon Poison")
    {
        effect sfx = EffectVisualEffect(VFX_IMP_POISON_L);
        location loc = GetLocation(GetObjectByTag("NW_WAYPOINT001"));
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, sfx, loc);
    }
    else if (dlgGetSelectionName()=="Summon Acid")
    {
        effect sfx = EffectVisualEffect(VFX_IMP_ACID_L);
        location loc = GetLocation(GetObjectByTag("NW_WAYPOINT001"));
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, sfx, loc);
    }
    else if (dlgGetSelectionName()=="Summon Tornado")
    {
        effect sfx = EffectVisualEffect(VFX_IMP_TORNADO);
        location loc = GetLocation(GetObjectByTag("NW_WAYPOINT001"));
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, sfx, loc);
    }
    else if (dlgGetSelectionName()=="Summon Holy")
    {
        effect sfx = EffectVisualEffect(VFX_FNF_STRIKE_HOLY);
        location loc = GetLocation(GetObjectByTag("NW_WAYPOINT001"));
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, sfx, loc);
    }
    else if (dlgGetSelectionName()=="Summon Sigularity")
    {
        effect sfx = EffectVisualEffect(VFX_FNF_IMPLOSION);
        location loc = GetLocation(GetObjectByTag("NW_WAYPOINT001"));
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, sfx, loc);
    }
    else if (dlgGetSelectionName()=="Summon Meteor Swarm")
    {
        effect sfx = EffectVisualEffect(VFX_FNF_METEOR_SWARM);
        location loc = GetLocation(GetObjectByTag("NW_WAYPOINT001"));
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, sfx, loc);
    }
}

// MAIN PAGE PAGE END

void myCleanUp( )
{
    dlgClearResponseList( POET_RESPONSE_LIST );
}


