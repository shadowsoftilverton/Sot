#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Fire Seeds                                                           //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 16, 2011                                 //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void main() {
    if(!X2PreSpellCastCode())
        return;

    object oTarget = GetSpellTargetObject();
    location lTarget = GetSpellTargetLocation();
    int nTouch = TouchAttackRanged(oTarget);
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();

    if(nCasterLevel > 20) nCasterLevel = 20;

    int nDamage = d6(nCasterLevel);

    if(nMetaMagic == METAMAGIC_EMPOWER)
        nDamage = nDamage + nDamage / 2;
    else if(nMetaMagic == METAMAGIC_MAXIMIZE)
        nDamage *= 6;

    effect eExplode = EffectVisualEffect(VFX_FNF_FIREBALL);
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    effect eDamage = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);

    if(nTouch) {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
    }

    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_SMALL, lTarget);

    while(GetIsObjectValid(oTarget)) {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FIRESEEDS));

        nDamage = nCasterLevel;

        if(nMetaMagic == METAMAGIC_EMPOWER)
            nDamage = nDamage + nDamage / 2;
        else if(nMetaMagic == METAMAGIC_MAXIMIZE)
            nDamage *= 6;

        nDamage = GetReflexAdjustedDamage(nDamage, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_FIRE);
        eDamage = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);

        if(nDamage > 0) {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }

        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_SMALL, lTarget);
    }
}
