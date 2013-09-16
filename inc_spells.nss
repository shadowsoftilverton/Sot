#include "engine"

//::///////////////////////////////////////////////
//:: INC_SPELLS.NSS
//:: Silver Marches File
//:://////////////////////////////////////////////
/*
    Include file that handles common spell functions
    for the new custom spells.
*/
//:://////////////////////////////////////////////
//:: Created By: Ashton Shapcott
//:: Created On: Oct. 29, 2010
//:://////////////////////////////////////////////

#include "x0_i0_spells"
#include "nwnx_funcs"

//****************************************************************************//
//                                DEFINITION                                  //                                  //
//****************************************************************************//

// Gets the proper damage type for spells for oCreature.
// - nStandard: The damage the spell normally applies.
int GetSpellDamageType(object oCreature, int nStandard);

//****************************************************************************//
//                              IMPLEMENTATION                                //                                  //
//****************************************************************************//

int GetSpellDamageType(object oCreature, int nStandard){
    int nDamageType = GetLocalInt(OBJECT_SELF, "SPELL_ELEMENTAL_TYPE");

    if(nDamageType == 0) nDamageType = nStandard;

    return nStandard;
}

void DoCustomMissileStorm(int nD6Dice, int nCap, int nSpell, int nMIRV = VFX_IMP_MIRV, int nVIS = VFX_IMP_MAGBLUE, int nDAMAGETYPE = DAMAGE_TYPE_MAGICAL, int nONEHIT = FALSE, int nReflexSave = FALSE)
{
    object oTarget = OBJECT_INVALID;
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
//    int nDamage = 0;
    int nMetaMagic = GetMetaMagicFeat();
    int nCnt = 1;
    effect eMissile = EffectVisualEffect(nMIRV);
    effect eVis = EffectVisualEffect(nVIS);
    float fDist = 0.0;
    float fDelay = 0.0;
    float fDelay2, fTime;
    location lTarget = GetSpellTargetLocation(); // missile spread centered around caster
    int nMissiles = nCasterLvl;

    if (nMissiles > nCap)
    {
        nMissiles = nCap;
    }

        /* New Algorithm
            1. Count # of targets
            2. Determine number of missiles
            3. First target gets a missile and all Excess missiles
            4. Rest of targets (max nMissiles) get one missile
       */
    int nEnemies = 0;

    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget) )
    {
        // * caster cannot be harmed by this spell
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) && (oTarget != OBJECT_SELF))
        {
            // GZ: You can only fire missiles on visible targets
            // If the firing object is a placeable (such as a projectile trap),
            // we skip the line of sight check as placeables can't "see" things.
            if ( ( GetObjectType(OBJECT_SELF) == OBJECT_TYPE_PLACEABLE ) ||
                   GetObjectSeen(oTarget,OBJECT_SELF))
            {
                nEnemies++;
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lTarget, TRUE, OBJECT_TYPE_CREATURE);
     }

     if (nEnemies == 0) return; // * Exit if no enemies to hit
     int nExtraMissiles = nMissiles / nEnemies;

     // April 2003
     // * if more enemies than missiles, need to make sure that at least
     // * one missile will hit each of the enemies
     if (nExtraMissiles <= 0)
     {
        nExtraMissiles = 1;
     }

     // by default the Remainder will be 0 (if more than enough enemies for all the missiles)
     int nRemainder = 0;

     if (nExtraMissiles >0)
        nRemainder = nMissiles % nEnemies;

     if (nEnemies > nMissiles)
        nEnemies = nMissiles;

     // ** SILVER MARCHES
     // Custom code to balance the Isaac's series of missile storms. Limits the
     // number of missiles striking an individual to half the caster's relevant
     // leve.
     if (nExtraMissiles > (nCasterLvl/2)){
        nExtraMissiles = nCasterLvl/2;
        nRemainder = 0;
    }

    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    //Cycle through the targets within the spell shape until an invalid object is captured.
    while (GetIsObjectValid(oTarget) && nCnt <= nEnemies)
    {
        // * caster cannot be harmed by this spell
        if (spellsIsTarget(oTarget, SPELL_TARGET_SELECTIVEHOSTILE, OBJECT_SELF) &&
           (oTarget != OBJECT_SELF) &&
           (( GetObjectType(OBJECT_SELF) == OBJECT_TYPE_PLACEABLE ) ||
           (GetObjectSeen(oTarget,OBJECT_SELF))))
        {
                //Fire cast spell at event for the specified target
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpell));

                // * recalculate appropriate distances
                fDist = GetDistanceBetween(OBJECT_SELF, oTarget);
                fDelay = fDist/(3.0 * log(fDist) + 2.0);

                // Firebrand.
                // It means that once the target has taken damage this round from the
                // spell it won't take subsequent damage
                if (nONEHIT == TRUE)
                {
                    nExtraMissiles = 1;
                    nRemainder = 0;
                }

                int i = 0;
                //--------------------------------------------------------------
                // GZ: Moved SR check out of loop to have 1 check per target
                //     not one check per missile, which would rip spell mantels
                //     apart
                //--------------------------------------------------------------
                if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
                {
                    for (i=1; i <= nExtraMissiles + nRemainder; i++)
                    {
                        //Roll damage
                        int nDam = d6(nD6Dice);
                        //Enter Metamagic conditions
                        if (nMetaMagic == METAMAGIC_MAXIMIZE)
                        {
                             nDam = nD6Dice*6;//Damage is at max
                        }
                        if (nMetaMagic == METAMAGIC_EMPOWER)
                        {
                              nDam = nDam + nDam/2; //Damage/Healing is +50%
                        }
                        // Jan. 29, 2004 - Jonathan Epp
                        // Reflex save was not being calculated for Firebrand
                        if(nReflexSave)
                        {
                            if ( nDAMAGETYPE == DAMAGE_TYPE_ELECTRICAL )
                            {
                                nDam = GetReflexAdjustedDamage(nDam, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_ELECTRICITY);
                            }
                            else if ( nDAMAGETYPE == DAMAGE_TYPE_FIRE )
                            {
                                nDam = GetReflexAdjustedDamage(nDam, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_FIRE);
                            }
                        }

                        fTime = fDelay;
                        fDelay2 += 0.1;
                        fTime += fDelay2;

                        //Set damage effect
                        effect eDam = EffectDamage(nDam, nDAMAGETYPE);
                        //Apply the MIRV and damage effect
                        DelayCommand(fTime, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget));
                        DelayCommand(fDelay2, ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget));
                        DelayCommand(fTime, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                    }
                } // for
                else
                {  // * apply a dummy visual effect
                 ApplyEffectToObject(DURATION_TYPE_INSTANT, eMissile, oTarget);
                }
                nCnt++;// * increment count of missiles fired
                nRemainder = 0;
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_GARGANTUAN, lTarget, TRUE, OBJECT_TYPE_CREATURE);
    }
}
