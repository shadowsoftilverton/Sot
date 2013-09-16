#include "engine"

//::///////////////////////////////////////////////
//:: Tensor's Transformation
//:: NW_S0_TensTrans.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
  Gives the caster the following bonuses:
  +1 Attack per 2 levels
  +4 Natural AC
  20 STR and DEX and CON
  1d6 Bonus HP per level
  +5 on Fortitude Saves
  -10 Intelligence
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 26, 2001
//:://////////////////////////////////////////////
//: Sep2002: losing hit-points won't get rid of the rest of the bonuses

#include "x2_inc_spellhook"

void main()
{


  //----------------------------------------------------------------------------
  // GZ, Nov 3, 2003
  // There is a serious problems with creatures turning into unstoppable killer
  // machines when affected by tensors transformation. NPC AI can't handle that
  // spell anyway, so I added this code to disable the use of Tensors by any
  // NPC.
  //----------------------------------------------------------------------------
  if (!GetIsPC(OBJECT_SELF))
    {
      WriteTimestampedLogEntry(GetName(OBJECT_SELF) + "[" + GetTag (OBJECT_SELF) +"] tried to cast Tensors Transformation. Bad! Remove that spell from the creature");
      return;
    }

  /*
    Spellcast Hook Code
    Added 2003-06-23 by GeorgZ
    If you want to make changes to all spells,
    check x2_inc_spellhook.nss to find out more
  */

  if (!X2PreSpellCastCode())
    {
      return;
    }

  // End of Spell Cast Hook


  //Declare major variables
  object oCaster = OBJECT_SELF;

  int nDuration = GetCasterLevel(oCaster);
  int nAttackIncrease = GetCharacterLevel(oCaster) - GetBaseAttackBonus(oCaster);

  int nMeta = GetMetaMagicFeat();

  if(nMeta == METAMAGIC_EXTEND){
    nDuration *= 2;
  }

  effect eStr = EffectAbilityIncrease(ABILITY_STRENGTH, 4);
  effect eDex = EffectAbilityIncrease(ABILITY_CONSTITUTION, 4);
  effect eCon = EffectAbilityIncrease(ABILITY_DEXTERITY, 4);
  effect eFort = EffectSavingThrowIncrease(SAVING_THROW_FORT, 5);
  effect eArmor = EffectACIncrease(3);
  effect eAttack = EffectAttackIncrease(nAttackIncrease);
  effect eArcaneFailure = EffectSpellFailure(100);
  effect eVisual = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

  effect eLink = EffectLinkEffects(eStr, eDex);

  eLink = EffectLinkEffects(eLink, eCon);
  eLink = EffectLinkEffects(eLink, eFort);
  eLink = EffectLinkEffects(eLink, eArmor);
  eLink = EffectLinkEffects(eLink, eAttack);
  eLink = EffectLinkEffects(eLink, eArcaneFailure);
  eLink = EffectLinkEffects(eLink, eVisual);

  effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);

  //Signal Spell Event
  SignalEvent(oCaster, EventSpellCastAt(oCaster, SPELL_TENSERS_TRANSFORMATION, FALSE));

  ClearAllActions(); // prevents an exploit
  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oCaster);
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oCaster, RoundsToSeconds(nDuration));
}
