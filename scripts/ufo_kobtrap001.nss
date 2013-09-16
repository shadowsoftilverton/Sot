#include "x0_i0_spells"
#include "x2_inc_spellhook"
#include "engine"

void main()
{
        object oEnter = GetEnteringObject();
        string sEnter = GetResRef(oEnter);
        string sKobold = GetStringLeft(sEnter, 11);

        if(sKobold != "ufo_thk_kob")
        {
            effect eTangle = EffectEntangle();
            effect eSpark = EffectVisualEffect(VFX_COM_BLOOD_SPARK_MEDIUM);
            effect eSpike = EffectVisualEffect(VFX_DUR_CALTROPS);
            int nDamage = d6();
            effect eDamage = EffectDamage(nDamage, DAMAGE_TYPE_PIERCING, DAMAGE_POWER_NORMAL);
            location lTarget = GetLocation(oEnter);
            object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lTarget, TRUE, OBJECT_TYPE_CREATURE);

            PlaySound("as_cv_smithmet3");

            while(GetIsObjectValid(oTarget))
            {
                ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSpike, lTarget, 12.0f);
                FloatingTextStringOnCreature("Barbed wire springs at your legs!", oTarget);

                if(!MySavingThrow(SAVING_THROW_REFLEX, oTarget, 23))
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eSpark, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eTangle, oTarget, 12.0f);
                    PlaySound("as_na_twigsnap1");
                }

            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lTarget, TRUE, OBJECT_TYPE_CREATURE);
            }
        }
}
