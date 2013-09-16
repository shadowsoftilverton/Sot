#include "x0_i0_spells"
#include "x2_inc_spellhook"
//#include "engine"

void main()
{
        object oEnter = GetEnteringObject();
        string sEnter = GetResRef(oEnter);
        string sKobold = GetStringLeft(sEnter, 11);

        if(sKobold != "ufo_thk_kob")
        {
            effect eBlind = EffectBlindness();
            effect eCloud = EffectVisualEffect(VFX_IMP_DUST_EXPLOSION);
            effect eBurst = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
            location lTarget = GetLocation(oEnter);
            object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lTarget, TRUE, OBJECT_TYPE_CREATURE);

            PlaySound("as_cv_smithmet3");

            while(GetIsObjectValid(oTarget))
            {
                ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eCloud, lTarget);
                ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eBurst, lTarget);
                FloatingTextStringOnCreature("Irritating dust billows and engulfs you!", oTarget);

                if(!MySavingThrow(SAVING_THROW_FORT, oTarget, 20))
                {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBlind, oTarget, 12.0f);
                    PlaySound("as_cv_smithwatr2");
                }

            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lTarget, TRUE, OBJECT_TYPE_CREATURE);
            }
        }
}
