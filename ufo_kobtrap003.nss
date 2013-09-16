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
            effect eKnock = EffectKnockdown();
            effect eChunk = EffectVisualEffect(VFX_COM_CHUNK_STONE_MEDIUM);
            int nDamage = d6(2);
            effect eDamage = EffectDamage(nDamage, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL);
            location lTarget = GetLocation(oEnter);
            object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lTarget, TRUE, OBJECT_TYPE_CREATURE);
            int nSTR = GetAbilityScore(oTarget, ABILITY_STRENGTH, FALSE);
            float fSTR = IntToFloat(nSTR);
            float fFree = 28.0f - fSTR;

            if(fFree < 3.0f)
            {
                fFree = 3.0f;
            }

            while(GetIsObjectValid(oTarget))
            {
                FloatingTextStringOnCreature("A pile of stones drops on you from above!", oTarget);
                PlaySound("as_na_rockcavsm2");

                if(!MySavingThrow(SAVING_THROW_REFLEX, oTarget, 25))
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnock, oTarget, fFree);
                    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eChunk, lTarget);
                }

            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lTarget, TRUE, OBJECT_TYPE_CREATURE);
            }
        }
}
