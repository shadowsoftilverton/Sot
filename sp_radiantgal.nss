//Radiant Gale
//By Hardcore UFO
//Will periodically send lightning bolts out from the caster.


#include "engine"
#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "inc_spells"

void DoRadiantGale(object oCaster, int nLevel, int nLimit, float fDuration);

void main()
{
    int nCL = GetCasterLevel(OBJECT_SELF);
    int nLimit = d2(nCL / 3);
    int nBolts;
    int nMeta = GetMetaMagicFeat();
    float fDuration = RoundsToSeconds(nCL);
    location lCaster = GetLocation(OBJECT_SELF);
    effect eGlow = EffectVisualEffect(VFX_DUR_IOUNSTONE_BLUE);

    if(nMeta == METAMAGIC_EXTEND)   fDuration = fDuration * 2;

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eGlow, OBJECT_SELF);
    DoRadiantGale(OBJECT_SELF, nCL, nLimit, fDuration);
}

void DoRadiantGale(object oCaster, int nLevel, int nLimit, float fDuration)
{
    location lCaster = GetLocation(oCaster);
    effect eLight = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
    effect eBolt = EffectVisualEffect(VFX_BEAM_SILENT_LIGHTNING, TRUE);
    effect eDamage;
    object oTarget;
    int nDamage;
    int nBolts;
    int nInterval = d3(4);
    float fInterval = IntToFloat(nInterval);

    fDuration = fDuration + fInterval;

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eLight, oCaster);

    if(fInterval <= fDuration && GetHasSpellEffect(/* XXXXXXXXXX */ SPELL_FIREBALL, oCaster))
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, /* XXXXXXXXXXXXX */SPELL_FIREBALL));

        while(nBolts < nLimit)
        {
            oTarget = GetRandomObjectByType(OBJECT_TYPE_CREATURE, 8.33f);

            if(!MyResistSpell(oCaster, oTarget))
            {
                nDamage = GetReflexAdjustedDamage(d6(nLevel), oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_ELECTRICITY);
                eDamage = EffectDamage(nDamage, DAMAGE_TYPE_ELECTRICAL);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBolt, oTarget, 1.3f);
            }

            nBolts ++;
        }

        DelayCommand(fInterval, DoRadiantGale(oCaster, nLevel, nLimit, fDuration));
    }
}
