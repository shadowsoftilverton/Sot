//Cloud of Ill Omen
//By Hardcore UFO
//Will damage original target and apply random effects (fort save)
//Will radiate fire damage in a blast around the target (reflex save)

#include "engine"
#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "inc_spells"

void main()
{

    if (!X2PreSpellCastCode())
    {
        return;
    }

    object oCaster = OBJECT_SELF;
    int nCasterLvl = GetCasterLevel(oCaster);
    int nMetaMagic = GetMetaMagicFeat();
    int nDamage;
    float fDelay;
    effect eExplode = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_FIRE);
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    effect eDam;
    object oCastee = GetSpellTargetObject();
    location lTarget = GetLocation(oCastee);
    //Determining the negative effects caused by the detonation
    effect eOne;
    effect eTwo;
    int nRoll = d3();
    int nSeco = nRoll + 1;
    int nAbil;
    switch(nRoll)
    {
        case 1: eOne = EffectACDecrease(3); break;
        case 2: eOne = EffectAttackDecrease(3); break;
        case 3:
            nRoll = d3();
            switch(nRoll)
            {
                case 1: nAbil = ABILITY_CONSTITUTION; break;
                case 2: nAbil = ABILITY_DEXTERITY; break;
                case 3: nAbil = ABILITY_STRENGTH; break;
            }
            eOne = EffectAbilityDecrease(nAbil, 5); break;
    }

    switch(nSeco)
    {
        case 2: eTwo = EffectMovementSpeedDecrease(20); break;
        case 3: eTwo = EffectAbilityDecrease(nAbil, 5); break;
        case 4: eTwo = EffectAttackDecrease(3); break;
    }

    if(!MySavingThrow(SAVING_THROW_FORT, oCastee, GetSpellSaveDC()));
    {
    //Initial blast, targeted object only
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eExplode, lTarget);
    nDamage = d6(nCasterLvl);
    eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
    if(nDamage > 0)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oCastee);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oCastee);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eOne, oCastee, TurnsToSeconds(nCasterLvl));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eTwo, oCastee, TurnsToSeconds(nCasterLvl));
    }

    //Radial blast, for objects around the target
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    while (GetIsObjectValid(oTarget))
    {
        if(oTarget == oCastee)
        {
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
        }

        if (spellsIsTarget(oTarget, SPELL_TARGET_STANDARDHOSTILE, OBJECT_SELF))
        {
            if((GetSpellId() == 341) || GetSpellId() == 58)//Change to new spell ID
            {
                SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FIREBALL/* XXXXXXXXXXXXX */));
                fDelay = GetDistanceBetweenLocations(lTarget, GetLocation(oTarget))/20;
                if (!MyResistSpell(OBJECT_SELF, oTarget, fDelay))
                {
                    nDamage = d6(nCasterLvl / 2);

                    nDamage = GetReflexAdjustedDamage(nDamage, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_FIRE);
                    eDam = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
                    if(nDamage > 0)
                    {
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));
                        DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    }
                 }
             }
        }

       oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
    }
}
