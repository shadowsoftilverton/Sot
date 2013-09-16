#include "engine"

void main()
{
    object oCycle = GetFirstInPersistentObject();
    effect eVis = EffectVisualEffect(VFX_FNF_PWSTUN);
    effect eEffect;
    int nProbab;
    int nEffect;

    while(GetIsObjectValid(oCycle))
    {
        if(GetStringLeft(GetTag(oCycle), 8) == "ufo_kuo_" || GetStringLeft(GetTag(oCycle), 8) == "ufo_hag_")  return;

        nProbab = d6();
        nEffect = d4();

        switch(nEffect);
        {
            case 1: eEffect = EffectStunned(); break;
            case 2: eEffect = EffectKnockdown(); break;
            case 3: eEffect = EffectBlindness(); break;
            case 4: eEffect = EffectConfused(); break;
        }

        if(nProbab > 4)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oCycle, 6.0f);
        }

        oCycle = GetNextInPersistentObject();
    }
}
