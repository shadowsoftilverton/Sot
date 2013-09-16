#include "x2_inc_itemprop"

void main()
{
      object oPC = OBJECT_SELF;
      object oWeapon=GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
      itemproperty ipOnHit=ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER,1);
      IPSafeAddItemProperty(oWeapon, ipOnHit, RoundsToSeconds(1));
      oWeapon=GetItemInSlot(INVENTORY_SLOT_ARMS,oPC);
      IPSafeAddItemProperty(oWeapon, ipOnHit, RoundsToSeconds(1));
      oWeapon=GetItemInSlot(INVENTORY_SLOT_ARROWS,oPC);
      IPSafeAddItemProperty(oWeapon, ipOnHit, RoundsToSeconds(1));
      oWeapon=GetItemInSlot(INVENTORY_SLOT_BOLTS,oPC);
      IPSafeAddItemProperty(oWeapon, ipOnHit, RoundsToSeconds(1));
      oWeapon=GetItemInSlot(INVENTORY_SLOT_BULLETS,oPC);
      IPSafeAddItemProperty(oWeapon, ipOnHit, RoundsToSeconds(1));
      effect ABBoost=EffectAttackIncrease(2,ATTACK_BONUS_MISC);
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ABBoost,oPC,RoundsToSeconds(1));
      //DecrementRemainingFeatUses(oPC,1377);
      //DecrementRemainingFeatUses(oPC,1378);
}
