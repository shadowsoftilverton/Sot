void main()
{
    object oCaster = OBJECT_SELF;
    location lTargetLoc = GetSpellTargetLocation();
    location lCasterLoc = GetLocation(oCaster);
        if (lCasterLoc != lTargetLoc)
            {
            ApplyEffectAtLocation (DURATION_TYPE_INSTANT, EffectVisualEffect (VFX_IMP_DEATH_WARD), lCasterLoc);
            ApplyEffectAtLocation (DURATION_TYPE_INSTANT, EffectVisualEffect (VFX_IMP_DEATH_WARD), lTargetLoc);
            AssignCommand(oCaster, ActionJumpToLocation(lTargetLoc));
            }
}
