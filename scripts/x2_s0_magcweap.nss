#include "nw_i0_spells"
#include "x2_i0_spells"
#include "x2_inc_spellhook"
#include "x2_inc_itemprop"
#include "engine"

void main()
{

    if(!X2PreSpellCastCode())
    {
        return;
    }

    object oTarget = GetSpellTargetObject();
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oTarget);
    object oGloves = GetItemInSlot(INVENTORY_SLOT_ARMS, oTarget);
    int nGloves = GetBaseItemType(oGloves);
    effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nPower = nCasterLevel / 4;
    int nMetaMagic = GetMetaMagicFeat();

    //if(nPower > 4)
    //{
        nPower = 1;
    //}

    if(nMetaMagic == METAMAGIC_EXTEND)
    {
        nCasterLevel = nCasterLevel * 2;
    }

    float fDuration = HoursToSeconds(nCasterLevel);

    if(GetIsObjectValid(oWeapon) == TRUE)
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oWeapon));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oWeapon), HoursToSeconds(nCasterLevel));
        IPSafeAddItemProperty(oWeapon, ItemPropertyEnhancementBonus(nPower), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
    }

    else if(GetIsObjectValid(oWeapon) != TRUE && nGloves == BASE_ITEM_GLOVES)
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, GetItemPossessor(oGloves));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDur, GetItemPossessor(oGloves), HoursToSeconds(nCasterLevel));
        IPSafeAddItemProperty(oGloves, ItemPropertyEnhancementBonus(nPower), fDuration, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING, FALSE, TRUE);
    }
}
