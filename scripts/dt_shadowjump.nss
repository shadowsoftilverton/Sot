#include "engine"

void main()
{
    object oItem = GetItemActivated();
    object oUser = GetItemActivator();
    location lTargetLoc = GetItemActivatedTargetLocation();
    location lUserLoc = GetLocation(oUser);;
        if (lUserLoc != lTargetLoc)
            {
            ApplyEffectAtLocation (DURATION_TYPE_INSTANT, EffectVisualEffect (VFX_DUR_PROT_SHADOW_ARMOR), lUserLoc);
            ApplyEffectAtLocation (DURATION_TYPE_INSTANT, EffectVisualEffect (VFX_DUR_PROT_SHADOW_ARMOR), lTargetLoc);
            AssignCommand(oUser, ActionJumpToLocation(lTargetLoc));
            }
}
