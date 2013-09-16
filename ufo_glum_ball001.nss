#include "engine"

void FireTubeLightning(object oTarget)
{
    effect eLight = EffectVisualEffect(73);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLight, oTarget, 0.7f);
}

void main()
{

}
