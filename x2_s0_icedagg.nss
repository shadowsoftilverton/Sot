//::///////////////////////////////////////////////
//:: Ice Dagger
//:: X2_S0_IceDagg
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
// You create a dagger shapped piece of ice that
// flies toward the target and deals 1d4 points of
// cold damage per level (maximum od 5d4)
*/
//:://////////////////////////////////////////////
//:: Created By: Andrew Nobbs
//:: Created On: Nov 25 , 2002
//:://////////////////////////////////////////////
//:: Last Updated By: Andrew Nobbs, 02/06/2003

#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "spell_sneak_inc"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-07-07 by Georg Zoeller
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
    object oCaster = OBJECT_SELF;
    object oTarget = GetSpellTargetObject();
    int nCasterLvl = GetCasterLevel(oCaster);
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    float fDelay;
    effect eVis = EffectVisualEffect(VFX_IMP_FROST_S);
    effect eDam;
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
    //Limit Caster level for the purposes of damage
    if (nCasterLvl > 10)
    {
        nCasterLvl = 10;
    }
    if(!GetIsReactionTypeFriendly(oTarget))
    {
        int nSneakBonus = getSneakDamageRanged(OBJECT_SELF, oTarget);
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));
        //Get the distance between the explosion and the target to calculate delay
        fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
        if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
        {
            //Roll damage for each target
            nDamage = d4(nCasterLvl);
            //Resolve metamagic
            if (nMetaMagic == METAMAGIC_MAXIMIZE)
            {
                nDamage = 4 * nCasterLvl;
            }
            else if (nMetaMagic == METAMAGIC_EMPOWER)
            {
                nDamage = nDamage + nDamage / 2;
            }
            //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
            int nTouch=TouchAttackRanged(oTarget);
            //Set the damage effect
            eDam = EffectDamage(nDamage, DAMAGE_TYPE_COLD);
            if(nTouch > 0)
            {
                if(nTouch==2) nDamage=nDamage*2;
                nDamage=nDamage+getSneakDamage(oCaster,oTarget);
                // Apply effects to the currently selected target.
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                //This visual effect is applied to the target object not the location as above.  This visual effect
                //represents the flame that erupts on the target not on the ground.
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            }
        }
    }
}

