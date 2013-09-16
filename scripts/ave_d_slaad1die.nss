#include "ave_d_inc"
#include "engine"
void main()
{
    object oDead=OBJECT_SELF;
    location lLoc=GetLocation(oDead);
    effect eVis=EffectVisualEffect(VFX_IMP_UNSUMMON);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVis,lLoc);
    CreateObject(OBJECT_TYPE_CREATURE,SLAADPRINT2,lLoc);
}
