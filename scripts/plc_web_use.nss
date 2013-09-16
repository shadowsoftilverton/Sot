void main() {
    object oDamager = GetLastUsedBy();
    object oOffHandItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oDamager);
    effect eCombust = EffectVisualEffect(498);

    if(GetBaseItemType(oOffHandItem) == BASE_ITEM_TORCH) {
           ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCombust, OBJECT_SELF, 6.0);
           DestroyObject(OBJECT_SELF, 6.0);
    } else
        SendMessageToPC(oDamager, "This web appears vulnerable to flame; perhaps a torch or a weapon enchantment.");
}
