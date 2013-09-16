//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Tilverton                                                 //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Heal Kit Script                                                      //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, September 8, 2011                             //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_switches"
#include "NW_I0_GENERIC"

const int BONUS = 0;

void ApplyHeal(object oTarget, effect eEffect) {
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget);
}

void main() {
    int nEvent = GetUserDefinedItemEventNumber();

    switch(nEvent){
        case X2_ITEM_EVENT_ACTIVATE:
        {
            object oPC = GetItemActivator();
            object oTarget = GetItemActivatedTarget();

            if(GetObjectType(oTarget) != OBJECT_TYPE_CREATURE) {
                SendMessageToPC(oPC, "This item can only be used on creatures.");
                return;
            }

            if(GetIsInCombat(oPC)) {
                SendMessageToPC(oPC, "Heal cannot be attempted while you're being attacked!");
                return;
            }

            if(GetIsInCombat(oTarget)) {
                SendMessageToPC(oPC, "Heal cannot be attempted while your target is being attacked!");
                return;
            }

            int nSkill = GetSkillRank(SKILL_HEAL, oPC);
            int nHeal = nSkill + d20() + BONUS;

            effect eHeal = EffectHeal(nHeal);
            effect eVis = EffectVisualEffect(VFX_IMP_HEALING_S);
            eHeal = EffectLinkEffects(eHeal, eVis);

            ApplyHeal(oTarget, eHeal);
        } break;
    }
}
