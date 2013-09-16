#include "engine"
//Written by Ave (2012/04/13)

void main()
{
    effect eVis=EffectVisualEffect(VFX_BEAM_BLACK);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis,GetLocalObject(OBJECT_SELF,"ave_o_monst"),2.0);
}
