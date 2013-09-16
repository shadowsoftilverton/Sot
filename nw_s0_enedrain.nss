//::///////////////////////////////////////////////
//:: Energy Drain
//:: NW_S0_EneDrain.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Target loses 2d4 levels.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:://////////////////////////////////////////////
#include "engine"
#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_sneak_inc"

void main()
{

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    effect eVis = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
    object oTarget = GetSpellTargetObject();
    int nMetaMagic = GetMetaMagicFeat();
    int nDrain = d4(2);
    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        nDrain = 8;//Damage is at max
    }
    else if (nMetaMagic == METAMAGIC_EMPOWER)
    {
        nDrain = nDrain + (nDrain/2); //Damage/Healing is +50%
    }
    effect eDrain = EffectNegativeLevel(nDrain);
    eDrain = SupernaturalEffect(eDrain);
    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_ENERGY_DRAIN));
        if(!MyResistSpell(OBJECT_SELF, oTarget))
        {
            int nTouch=TouchAttackRanged(oTarget);
            if(nTouch>0)
            {
                if(nTouch==2) nDrain=nDrain*2;
                int nDamage=getSneakDamage(OBJECT_SELF,oTarget);
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDrain, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                //Apply sneak bonus
                if(nDamage>0)
                {
                    effect eDam = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                }
            }
        }
    }
}

