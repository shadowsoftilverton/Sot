// zzdlg_ghostspeak
//
// Copyright 2005-2006 by Greyhawk0
//
//  This is an internal event to cause a recently created ghost to talk to the
// player.

#include "zzdlg_tools_inc"

void main()
{
    object oPlayer = GetLocalObject(OBJECT_SELF, DLG_GHOSTTALKER);
    object oNPC = OBJECT_SELF;

    if ( GetIsPC(oPlayer) == FALSE || GetIsObjectValid(oNPC) == FALSE ) return;

    SetCommandable(TRUE, oPlayer);
    DeleteLocalObject(OBJECT_SELF, DLG_GHOSTTALKER);
    ClearAllActions();

    // Get dialog script name from npc.
    string sScript = GetLocalString( oNPC, DLG_VARIABLE_SCRIPTNAME );
    if ( sScript == "" ) return;

    // Gets extra parameters from npc.
    int iMakeprivate = GetLocalInt( oNPC, DLG_VARIABLE_MAKEPRIVATE );
    int iNoHello = GetLocalInt( oNPC, DLG_VARIABLE_NOHELLO );
    int iNoZoom = GetLocalInt( oNPC, DLG_VARIABLE_NOZOOM );

//    RemoveEffect(oNPC, EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY));
    // Start the dialog between the npc and the player
    _dlgStart( oPlayer, oNPC, sScript, iMakeprivate, iNoHello, iNoZoom );
//    ApplyEffectToObject( DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY), oNPC);
}
