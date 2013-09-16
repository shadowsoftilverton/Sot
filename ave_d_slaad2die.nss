#include "engine"
#include "ave_d_inc"

void main()
{
    object oDead=OBJECT_SELF;
    location lLoc=GetLocation(oDead);
    effect eVis=EffectVisualEffect(VFX_IMP_PDK_GENERIC_PULSE);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVis,lLoc);
    if(GetObjectByTag(SLAADPRINT1)==OBJECT_INVALID)
    {
        object oStone=GetObjectByTag(SLAAD_ROCK_PRINT);
        SetLocalInt(oStone,"ave_d_slaadgo",1);
    }
}
