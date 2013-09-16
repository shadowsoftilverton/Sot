#include "engine"

//::///////////////////////////////////////////////
//:: Legend Lore
//:: NW_S0_Lore.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Gives the caster a boost to Lore skill of 10
    plus 1 / 2 caster levels.  Lasts for 1 Turn per
    caster level.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 22, 2001
//:://////////////////////////////////////////////
//:: 2003-10-29: GZ: Corrected spell target object
//::             so potions work wit henchmen now

#include "x2_inc_spellhook"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_MAGICAL_VISION);

    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_LEGEND_LORE, FALSE));
    //Apply linked and VFX effects
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);

    effect eBuff=EffectSkillIncrease(SKILL_LORE,GetCasterLevel(OBJECT_SELF)/3);
    eBuff=EffectLinkEffects(eBuff,EffectSkillIncrease(SKILL_K_HISTORY,GetCasterLevel(OBJECT_SELF)/3));
    eBuff=EffectLinkEffects(eBuff,EffectSkillIncrease(SKILL_K_RELIGION,GetCasterLevel(OBJECT_SELF)/3));
    float fDur=RoundsToSeconds(GetCasterLevel(OBJECT_SELF));
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eBuff,OBJECT_SELF,fDur);

    SendMessageToAllDMs(GetName(OBJECT_SELF) + " casts Legend Lore.");
}

