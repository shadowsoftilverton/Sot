#include "engine"

void main()
{
    object oPC = GetEnteringObject();
    object oLeft = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);

    if(GetBaseItemType(oLeft) == BASE_ITEM_TORCH && GetItemHasItemProperty(oLeft, ITEM_PROPERTY_LIGHT))
    {
        effect eBurst = EffectVisualEffect(498);
        effect eDamage;
        int nDamage = d8();

        if(nDamage > 0)
        {
            location lPC = GetLocation(oPC);
            string sName = GetName(oPC);
            string sMess = sName + " drops his torch as it erupts in flame!";

            nDamage = GetReflexAdjustedDamage(nDamage, oPC, 18, SAVING_THROW_TYPE_FIRE);
            eDamage = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);

            if(nDamage > 0)
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBurst, oPC, 3.0f);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
                FloatingTextStringOnCreature(sMess, oPC, FALSE);

                CopyObject(oLeft, lPC);
                DestroyObject(oLeft);
            }

            else
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBurst, oPC, 3.0f);
                FloatingTextStringOnCreature(sMess, oPC, FALSE);

                CopyObject(oLeft, lPC);
                DestroyObject(oLeft);
            }
        }
    }
}
