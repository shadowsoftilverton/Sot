#include "spell_sneak_inc"
#include "x2_inc_itemprop"

void ave_impro_feathit(object oSpellTarget, object oSpellOrigin)
{
    if((!GetIsImmune(oSpellTarget,IMMUNITY_TYPE_SNEAK_ATTACK))&&(!GetIsImmune(oSpellTarget,IMMUNITY_TYPE_CRITICAL_HIT)))
    {
        int iMySneakDice=SneakAmount(oSpellOrigin);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(d6(iMySneakDice)), oSpellTarget);
        if(GetHasFeat(FEAT_CRIPPLING_STRIKE,oSpellOrigin))
        {
            effect eCripple=EffectAbilityDecrease(ABILITY_STRENGTH,2);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eCripple,oSpellTarget,RoundsToSeconds(600));
        }
        //object oItem=GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oSpellOrigin);
        //if (GetIsObjectValid(oItem))
        //{
            //IPRemoveMatchingItemProperties(oItem,IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER,DURATION_TYPE_TEMPORARY);
        //}
        //oItem=GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oSpellOrigin);
        //if (GetIsObjectValid(oItem))
        //{
            //IPRemoveMatchingItemProperties(oItem,IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER,DURATION_TYPE_TEMPORARY);
        //}
        //oItem=GetItemInSlot(INVENTORY_SLOT_ARMS, oSpellOrigin);
        //if (GetIsObjectValid(oItem))
        //{
            //IPRemoveMatchingItemProperties(oItem,IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER,DURATION_TYPE_TEMPORARY);
        //}
    }
}


