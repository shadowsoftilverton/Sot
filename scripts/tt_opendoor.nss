void main()
{
    object oTarget;
    effect eVFX;

    // If running the lowest AI, abort for performance reasons.
    if ( GetAILevel() == AI_LEVEL_VERY_LOW )
        return;

    // If busy with combat or conversation, skip this heartbeat.
    if ( IsInConversation(OBJECT_SELF)  ||  GetIsInCombat() )
        return;

    // Get the PC who will be referenced in this event.
    object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, OBJECT_SELF, 1,
                                    CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);

    // Only fire if a PC is seen.
    if ( OBJECT_INVALID == oPC )
        return;

    // If the local int is exactly 1.
    if ( GetLocalInt(OBJECT_SELF, "rune1") == 1 )
    {
        // Unlock "tt_puzzle".
//        oTarget = GetObjectByTag("tt_puzzle");
        SetLocked(oTarget, FALSE);

       eVFX = EffectVisualEffect(VFX_COM_BLOOD_REG_RED);
       oTarget = GetObjectByTag("tt_puzzle");
       ApplyEffectToObject(DURATION_TYPE_INSTANT, eVFX, oTarget);


}
}
