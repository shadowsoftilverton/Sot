#include "engine"

//::///////////////////////////////////////////////
//:: Elemental Shield
//:: NW_S0_FireShld.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Caster gains 50% cold and fire immunity.  Also anyone
    who strikes the caster with melee attacks takes
    1d6 + 1 per caster level in damage.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:://////////////////////////////////////////////
//:: Created On: Aug 28, 2003, GZ: Fixed stacking issue
#include "x2_inc_spellhook"
#include "x0_i0_spells"
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
    int iShieldType;
    if(GetLocalInt(OBJECT_SELF, "SPELL_ELEMENTAL_TYPE") == 0){
        if(GetSpellId()==849) iShieldType=DAMAGE_TYPE_FIRE;
        else iShieldType=DAMAGE_TYPE_COLD;
    }
    if(GetSpellId()==849) iShieldType=DAMAGE_TYPE_COLD;
    else iShieldType=DAMAGE_TYPE_FIRE;

    //Declare major variables
    effect eVis = EffectVisualEffect(VFX_DUR_ELEMENTAL_SHIELD);
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    object oTarget = OBJECT_SELF;
    int nDamage=DAMAGE_BONUS_1d6;
    if (nMetaMagic==METAMAGIC_EMPOWER)
    {
        nDamage==DAMAGE_BONUS_1d8;
    }
    if (nMetaMagic==METAMAGIC_MAXIMIZE)
    {
        nDamage==DAMAGE_BONUS_6;
    }
    effect eShield = EffectDamageShield(0, nDamage, iDamageType);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eCold = EffectDamageImmunityIncrease(iShieldType, 50);

    //Link effects
    effect eLink = EffectLinkEffects(eShield, eCold);
    eLink = EffectLinkEffects(eLink, eDur);
    eLink = EffectLinkEffects(eLink, eVis);

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_ELEMENTAL_SHIELD, FALSE));

    //  *GZ: No longer stack this spell
    if (GetHasSpellEffect(849,oTarget))
    {
         RemoveSpellEffects(849, OBJECT_SELF, oTarget);
    }

    if (GetHasSpellEffect(850,oTarget))
    {
         RemoveSpellEffects(850, OBJECT_SELF, oTarget);
    }

    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
}

