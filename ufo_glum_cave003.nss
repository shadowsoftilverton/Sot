#include "engine"

void main()
{
    int nFired = GetDamageDealtByType(DAMAGE_TYPE_FIRE);

    if(nFired > 0)
    {
        object oList = OBJECT_SELF;
        int nCooling = GetLocalInt(oList, "IsCooling");

        if(nCooling < 1)
        {
            location lBurst = GetLocation(oList);
            effect eBurst = EffectVisualEffect(VFX_FNF_FIREBALL);
            effect eTremb = EffectVisualEffect(286);
            effect eFire = EffectVisualEffect(VFX_IMP_FLAME_M);
            int nDamage = d4(4);
            float fSize = 10.0f;
            effect eDamage;

            ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eTremb, lBurst, 2.0f);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBurst, lBurst);
            SetLocalInt(oList, "IsCooling", 1);
            DelayCommand(12.0f, SetLocalInt(oList, "IsCooling", 0));

            object oCycle = GetFirstObjectInShape(SHAPE_SPHERE, fSize, lBurst, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_PLACEABLE);

            while(GetIsObjectValid(oCycle))
            {
                location lCycle = GetLocation(oCycle);
                float fDist;
                int nDC;

                if(fDist <= 4.0f)
                {
                    nDC = 21;
                }

                else if(fDist > 4.0f)
                {
                nDC = 17;
                }

                nDamage = GetReflexAdjustedDamage(nDamage, oCycle, nDC, SAVING_THROW_TYPE_FIRE);
                eDamage = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);

                if(nDamage > 0)
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oCycle);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oCycle);
                }

            oCycle = GetNextObjectInShape(SHAPE_SPHERE, fSize, lBurst, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_PLACEABLE);
            }
        }
    }
}
