#include "engine"

#include "nwnx_structs"

// Flags eEffect as a system effect. It will not be removed normally by
// RemoveEffect -- RemoveSystemEffect must be used.
effect SystemEffect(effect eEffect);

// Removes system effects.
// - oCreature: The creature to remove the effect from.
// - eEffect: The effect to remove.
// - nOnlySystem: If FALSE, non-system effects will also be removed.
void RemoveSystemEffect(object oCreature, effect eEffect, int nOnlySystem=TRUE);

// Flags oProperty as a system item property. It will not be removed normally by
// RemoveItemProperty --- RemoveSystemItemProperty must be used.
itemproperty SystemItemProperty(itemproperty ip);

// Removes system item properties.
// - oItem: The item to remove the property from.
// - ip: The item property to remove.
// - nOnlySystem: If FALSE, non-system properties will also be removed.
void RemoveSystemItemProperty(object oItem, itemproperty ip, int nOnlySystem=TRUE);

effect SystemEffect(effect eEffect){
    eEffect = SupernaturalEffect(eEffect);

    SetEffectSpellId(eEffect, SPELL_SYSTEM);

    return eEffect;
}

void RemoveSystemEffect(object oCreature, effect eEffect, int nOnlySystem=TRUE){
    if(GetEffectSpellId(eEffect) == SPELL_SYSTEM || !nOnlySystem) Std_RemoveEffect(oCreature, eEffect);
}

itemproperty SystemItemProperty(itemproperty ip){
    SetItemPropertySpellId(ip, SPELL_SYSTEM);

    return ip;
}

void RemoveSystemItemProperty(object oItem, itemproperty ip, int nOnlySystem=TRUE){
    if(GetItemPropertySpellId(ip) == SPELL_SYSTEM || !nOnlySystem) Std_RemoveItemProperty(oItem, ip);
}
