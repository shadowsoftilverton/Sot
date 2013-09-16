//==============================================================================
// plc_web_dam:
//     Script for the OnDamaged event of a web. If the PC has a torch equipped
//     or their current weapon deals fire damage, then apply a combust VFX and
//     destroy the placeable.
//
// Written by Invictus for Shadows of Tilverton, August 31, 2011
//==============================================================================

void main() {
    object oDamager = GetLastDamager();
    object oOffHandItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oDamager);
    effect eCombust = EffectVisualEffect(498);

    if(GetDamageDealtByType(DAMAGE_TYPE_FIRE) > 0 ||
       GetBaseItemType(oOffHandItem) == BASE_ITEM_TORCH) {
           ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCombust, OBJECT_SELF, 6.0);
           DestroyObject(OBJECT_SELF, 6.0);
    } else
        SendMessageToPC(oDamager, "This web appears vulnerable to flame; perhaps a torch or a weapon enchantment.");
}
