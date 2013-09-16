#include "nw_i0_spells"
#include "ave_inc_rogue"

void main()
{
    object oPC=OBJECT_SELF;
    effect eVis = EffectVisualEffect(VFX_DUR_SPELLTURNING);
    effect eVisDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    float fDuration=18.0;
    int nAbsorb = d4() + GetLevelByClass(CLASS_TYPE_ROGUE,oPC)/5;

    effect eAbsob = EffectSpellLevelAbsorption(9, nAbsorb);
    effect eLink = EffectLinkEffects(eVis, eAbsob);
    eLink = EffectLinkEffects(eLink, eVisDur);
    RemoveEffectsFromSpell(oPC, GetSpellId());
    RemoveEffectsFromSpell(oPC, SPELL_GREATER_SPELL_MANTLE);
    RemoveEffectsFromSpell(oPC, SPELL_SPELL_MANTLE);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, fDuration);
    GeneralCoolDown(SLY_SPELLDODGER,oPC,180.0);
}
