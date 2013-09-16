#include "engine"

void main()
{
    if (GetIsNight() && GetLocalInt(OBJECT_SELF, "lightme") == 0)
    {
        SetLocalInt(OBJECT_SELF, "lightme", 1);
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        effect light = EffectVisualEffect(VFX_DUR_LIGHT_ORANGE_20);
        //effect light = EffectVisualEffect( VFX_DUR_LIGHT_BLUE_5 );

        ApplyEffectToObject(DURATION_TYPE_PERMANENT, light, OBJECT_SELF, 6.0);
        RecomputeStaticLighting(GetArea(OBJECT_SELF));
    }
    else if(GetIsDay() && GetLocalInt(OBJECT_SELF,"lightme") == 1) {
        SetLocalInt(OBJECT_SELF, "lightme", 0);
        effect eLoop;
        object oGlowingThing = OBJECT_SELF;
        eLoop = GetFirstEffect(oGlowingThing);

        while(GetIsEffectValid(eLoop)) {
            int iType = GetEffectType(eLoop);

            if(iType == EFFECT_TYPE_VISUALEFFECT) {
                RemoveEffect(oGlowingThing, eLoop);
                PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
            }

            eLoop = GetNextEffect(oGlowingThing);
        }

        RecomputeStaticLighting(GetArea(oGlowingThing));
    }
}

