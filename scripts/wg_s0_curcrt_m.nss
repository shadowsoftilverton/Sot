#include "engine"

//: Mass Cure Critical Wounds. 4d8 + CL healing to all allies in radius
//: and 4d8 + CL positive damage to all undead
//: Aazonis


#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
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
  object oTarget;
  int nCasterLvl = GetCasterLevel(OBJECT_SELF);
  int nDamagen, nModify, nHP;
  int nMetaMagic = GetMetaMagicFeat();
  effect eKill;
  effect eHeal;
  effect eVis = EffectVisualEffect(VFX_IMP_SUNSTRIKE);
  effect eVis2 = EffectVisualEffect(VFX_IMP_HEALING_M);
  effect eImpact = EffectVisualEffect(VFX_FNF_LOS_HOLY_20);
  float fDelay;
  //Limit caster level
  if (nCasterLvl > 20)
  {
    nCasterLvl = 20;
  }
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());
    //Get first target in shape
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation());
    while (GetIsObjectValid(oTarget))
    {
        fDelay = GetRandomDelay();
        //Check if racial type is undead
        if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD )
        {
            if(!GetIsReactionTypeFriendly(oTarget))
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HEALING_CIRCLE));
                //Make SR check
                if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
                {
                    nModify = d8(4) + nCasterLvl;
                    //Make metamagic check
                    if (nMetaMagic == METAMAGIC_MAXIMIZE)
                    {
                        nModify = 32 + nCasterLvl;
                    }
                    if (nMetaMagic == METAMAGIC_EMPOWER)
                    {
                        nModify = nModify + (nModify/2); //Damage/Healing is +50%
                    }

                    //Make Fort save
                    if (MySavingThrow(SAVING_THROW_FORT, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_NONE, OBJECT_SELF, fDelay))
                    {
                        nModify /= 2;
                    }

                    //Set damage effect
                    eKill = EffectDamage(nModify, DAMAGE_TYPE_POSITIVE);
                    //Apply damage effect and VFX impact
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eKill, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                }
            }
        }
        else
        {
            // * May 2003: Heal Neutrals as well
            if(!GetIsReactionTypeHostile(oTarget) || GetFactionEqual(oTarget))
            {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HEALING_CIRCLE, FALSE));
                nHP = d8(4) + nCasterLvl;
                //Enter Metamagic conditions
                if (nMetaMagic == METAMAGIC_MAXIMIZE)
                {
                    nHP = 32 + nCasterLvl;//Damage is at max
                }
                if (nMetaMagic == METAMAGIC_EMPOWER)
                {
                    nHP = nHP + (nHP/2); //Damage/Healing is +50%
                }
                //Set healing effect
                eHeal = EffectHeal(nHP);
                //Apply heal effect and VFX impact
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget));
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget));
            }
        }
        //Get next target in the shape
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, GetSpellTargetLocation());
    }
}
