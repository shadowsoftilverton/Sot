#include "engine"

//::///////////////////////////////////////////////
//:: Flame Lash
//:: NW_S0_FlmLash.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Creates a whip of fire that targets a single
    individual
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 21, 2001
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_sneak_inc"

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

    int iDamageType = GetLocalInt(OBJECT_SELF, "SPELL_ELEMENTAL_TYPE");

    if(GetLocalInt(OBJECT_SELF, "SPELL_ELEMENTAL_TYPE") == 0){
        iDamageType = DAMAGE_TYPE_FIRE;
    }

    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    if(nCasterLevel > 3)
    {
        nCasterLevel = (nCasterLevel-2)/2;
    }
    else
    {
        nCasterLevel = 0;
    }
    int nDamage = d8(2 + nCasterLevel);

    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        nDamage = 8 * (2 + nCasterLevel);//Damage is at max
    }
    else if (nMetaMagic == METAMAGIC_EMPOWER)
    {
        nDamage = nDamage + (nDamage/2); //Damage/Healing is +50%
    }
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
    effect eRay = EffectBeam(VFX_BEAM_FIRE_LASH, OBJECT_SELF, BODY_NODE_HAND);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eRay, oTarget, 1.7);
    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FLAME_LASH));
        if (!MyResistSpell(OBJECT_SELF, oTarget, 1.0))
        {
            int nTouch=TouchAttackRanged(oTarget);
            if(nTouch>0)
            {
                if(nTouch==2) nDamage=nDamage*2;
                nDamage=nDamage+getSneakDamage(OBJECT_SELF,oTarget);
                nDamage = GetReflexAdjustedDamage(nDamage, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_FIRE);
                effect eDam = EffectDamage(nDamage, iDamageType);
                if(nDamage > 0)
                {
                    //Apply the VFX impact and effects
                    DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                }
            }
        }
    }
}
