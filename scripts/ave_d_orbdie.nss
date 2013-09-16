//Written by Ave (2012/04/13)
#include "engine"
void main()
{
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_GREATER_RUIN),OBJECT_SELF);
    object oDoor=GetObjectByTag("ave_d_door2");
    SetLocked(oDoor, FALSE);
}
