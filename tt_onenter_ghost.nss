void main()
{

    effect eVFX;


    eVFX = ExtraordinaryEffect(EffectVisualEffect(VFX_DUR_GHOST_TRANSPARENT));
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eVFX, OBJECT_SELF);
}


