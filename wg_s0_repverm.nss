#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Repel Vermin                                                         //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 7, 2011                                  //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void main() {
    if(!X2PreSpellCastCode())
        return;

    location lCaster = GetLocation(OBJECT_SELF);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, FeetToMeters(100.0), lCaster);
    int nDC = GetSpellSaveDC();
    float fDuration = TurnsToSeconds(GetCasterLevel(OBJECT_SELF) * 2);
    effect eApply;

    while(GetIsObjectValid(oTarget)) {
        if(GetRacialType(oTarget) == RACIAL_TYPE_VERMIN && !MyResistSpell(OBJECT_SELF, oTarget)) {
            if(GetHitDice(oTarget) < GetCasterLevel(OBJECT_SELF) / 3) {
                eApply = EffectFrightened();
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eApply, oTarget, fDuration);
            } else if(!MySavingThrow(SAVING_THROW_WILL, oTarget, nDC)) {
                eApply = EffectDamage(d6() + d6());
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eApply, oTarget);
            }
        }

        oTarget = GetNextObjectInShape(SHAPE_SPHERE, FeetToMeters(100.0), lCaster);
    }
}
