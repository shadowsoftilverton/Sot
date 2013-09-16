#include "nw_i0_generic"
#include "NW_I0_SPELLS"
#include "engine"

void main()
{

    object oTarget = GetSpellTargetObject();
    effect eImpact = EffectVisualEffect(VFX_IMP_BIGBYS_FORCEFUL_HAND);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
    int nHitDice = GetHitDice(OBJECT_SELF);
    int nDamage = d4(nHitDice);
    int nDC = nHitDice + GetAbilityScore(OBJECT_SELF, ABILITY_STRENGTH);
    effect eDamage;
    ActionCastFakeSpellAtObject(SPELL_BIGBYS_FORCEFUL_HAND, oTarget);

    if(!MySavingThrow(SAVING_THROW_REFLEX, oTarget, nDC, SAVING_THROW_TYPE_NONE))
    {
        effect eKnock = EffectKnockdown();
        int nDur = d6(1) + 2;
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnock, oTarget, IntToFloat(nDur));
        eDamage = EffectDamage(nDamage, DAMAGE_TYPE_BLUDGEONING);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
    }

    else // half damage and no knockdown
    {
        nDamage /= 2;
        eDamage = EffectDamage(nDamage, DAMAGE_TYPE_BLUDGEONING);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget);
    }
}
