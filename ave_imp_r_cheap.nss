#include "ave_inc_rogue"
#include "x2_inc_itemprop"

void main()
{
    object oPC=OBJECT_SELF;
    object oWeapon=GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
    if(IPGetIsRangedWeapon(oWeapon))
    {
       itemproperty iRanged=ItemPropertyUnlimitedAmmo(IP_CONST_UNLIMITEDAMMO_PLUS1);
       IPSafeAddItemProperty(oWeapon,iRanged,60.0);
    }
    else if(IPGetIsMeleeWeapon(oWeapon))
    {
       itemproperty iMelee=ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_DAZE,5);
       IPSafeAddItemProperty(oWeapon,iMelee,12.0);
    }
    else SendMessageToPC(oPC,"You must have a melee weapon or a ranged weapon equipped to use this ability!");
    GeneralCoolDown(CHEAP_SHOT,oPC,180.0);
}
