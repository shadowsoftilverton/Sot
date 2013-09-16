#include "engine"

//::///////////////////////////////////////////////
//:: Melf's Acid Arrow
//:: MelfsAcidArrow.nss
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
/*
    An acidic arrow springs from the caster's hands
    and does 3d6 acid damage to the target.  For
    every 3 levels the caster has the target takes an
    additional 1d6 per round.
*/
/////////////////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Aidan Scanlan
//:: Created On: 01/09/01
//:://////////////////////////////////////////////
//:: Rewritten: Georg Zoeller, Oct 29, 2003
//:: Now uses VFX to track its own duration, cutting
//:: down the impact on the CPU to 1/6th
//:://////////////////////////////////////////////

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "x2_i0_spells"
#include "inc_spells"
#include "spell_sneak_inc"

void RunImpact(object oTarget, object oCaster, int nMetamagic, int iDamageType=DAMAGE_TYPE_ACID);

void main()
{
    object oTarget = GetSpellTargetObject();

    //--------------------------------------------------------------------------
    // Spellcast Hook Code
    // Added 2003-06-20 by Georg
    // If you want to make changes to all spells, check x2_inc_spellhook.nss to
    // find out more
    //--------------------------------------------------------------------------
    if (!X2PreSpellCastCode())
    {
        return;
    }
    // End of Spell Cast Hook

    // Silver marches damage type hook.
    int iDamageType = GetSpellDamageType(OBJECT_SELF, DAMAGE_TYPE_ACID);

    //--------------------------------------------------------------------------
    // This spell no longer stacks. If there is one of that type, thats ok
    //--------------------------------------------------------------------------
    if (GetHasSpellEffect(GetSpellId(),oTarget))
    {
        FloatingTextStrRefOnCreature(100775,OBJECT_SELF,FALSE);
        return;
    }

    //--------------------------------------------------------------------------
    // Calculate the duration
    //--------------------------------------------------------------------------
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = (GetCasterLevel(OBJECT_SELF)/3);

    if (nMetaMagic == METAMAGIC_EXTEND)
    {
       nDuration = nDuration * 2;
    }

    if (nDuration < 1)
    {
        nDuration = 1;
    }


    //--------------------------------------------------------------------------
    // Setup VFX
    //--------------------------------------------------------------------------
    effect eVis      = EffectVisualEffect(VFX_IMP_ACID_L);

    if(iDamageType == DAMAGE_TYPE_FIRE) eVis = EffectVisualEffect(VFX_IMP_FLAME_M);
    if(iDamageType == DAMAGE_TYPE_COLD) eVis = EffectVisualEffect(VFX_IMP_FROST_L);
    if(iDamageType == DAMAGE_TYPE_ELECTRICAL) eVis = EffectVisualEffect(VFX_IMP_LIGHTNING_M);

    effect eDur      = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eArrow = EffectVisualEffect(245);


    //--------------------------------------------------------------------------
    // Set the VFX to be non dispelable, because the acid is not magic
    //--------------------------------------------------------------------------
    eDur = ExtraordinaryEffect(eDur);
     // * Dec 2003- added the reaction check back i
    if (GetIsReactionTypeFriendly(oTarget) == FALSE)
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId()));

        float fDist = GetDistanceToObject(oTarget);
        float fDelay = (fDist/25.0);//(3.0 * log(fDist) + 2.0);
        int nTouch=TouchAttackRanged(oTarget);

        if(MyResistSpell(OBJECT_SELF, oTarget) == FALSE&&nTouch>0)
        {
            //----------------------------------------------------------------------
            // Do the initial 3d6 points of damage
            //----------------------------------------------------------------------
            int nDamage = MaximizeOrEmpower(6,3,nMetaMagic);
            if(nTouch==2) nDamage=nDamage*2;
            nDamage=nDamage+getSneakDamage(OBJECT_SELF,oTarget);
            effect eDam = EffectDamage(nDamage, iDamageType);

            DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget));

            //----------------------------------------------------------------------
            // Apply the VFX that is used to track the spells duration
            //----------------------------------------------------------------------
            DelayCommand(fDelay,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDur,oTarget,RoundsToSeconds(nDuration)));
            object oSelf = OBJECT_SELF; // because OBJECT_SELF is a function
            DelayCommand(6.0f,RunImpact(oTarget, oSelf,nMetaMagic,iDamageType));
        }
        else
        {
            //----------------------------------------------------------------------
            // Indicate Failure
            //----------------------------------------------------------------------
            effect eSmoke = EffectVisualEffect(VFX_IMP_REFLEX_SAVE_THROW_USE);
            DelayCommand(fDelay+0.1f,ApplyEffectToObject(DURATION_TYPE_INSTANT,eSmoke,oTarget));
        }
    }
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eArrow, oTarget);

}


void RunImpact(object oTarget, object oCaster, int nMetaMagic, int iDamageType=DAMAGE_TYPE_ACID)
{
    //--------------------------------------------------------------------------
    // Check if the spell has expired (check also removes effects)
    //--------------------------------------------------------------------------
    if (GZGetDelayedSpellEffectsExpired(SPELL_MELFS_ACID_ARROW,oTarget,oCaster))
    {
        return;
    }

    if (GetIsDead(oTarget) == FALSE)
    {
        //----------------------------------------------------------------------
        // Calculate Damage
        //----------------------------------------------------------------------
        int nDamage = MaximizeOrEmpower(4,2,nMetaMagic);
        effect eDam = EffectDamage(nDamage, iDamageType);
        effect eVis      = EffectVisualEffect(VFX_IMP_ACID_S);

        if(iDamageType == DAMAGE_TYPE_FIRE) eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
        if(iDamageType == DAMAGE_TYPE_COLD) eVis = EffectVisualEffect(VFX_IMP_FROST_S);
        if(iDamageType == DAMAGE_TYPE_ELECTRICAL) eVis = EffectVisualEffect(VFX_IMP_LIGHTNING_S);

        eDam = EffectLinkEffects(eVis,eDam); // flare up
        ApplyEffectToObject (DURATION_TYPE_INSTANT,eDam,oTarget);
        DelayCommand(6.0f,RunImpact(oTarget,oCaster,nMetaMagic));
    }
}

