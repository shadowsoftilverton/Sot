#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Shout                                                                //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 19, 2011                                 //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

int GetIsSilenced(object oTarget) {
    effect eLoop = GetFirstEffect(oTarget);

    while(GetIsEffectValid(eLoop)) {
        if(GetEffectType(eLoop) == EFFECT_TYPE_SILENCE)
            return TRUE;

        eLoop = GetNextEffect(oTarget);
    }

    return FALSE;
}

void main() {
    if(!X2PreSpellCastCode())
        return;

    object oTarget = OBJECT_SELF;
    location lTarget = GetLocation(oTarget);
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = d4();
    float fDelay;
    int nDamage = d6(5);

    if(nMetaMagic == METAMAGIC_EMPOWER)
        nDamage = nDamage + (nDamage / 2);
    else if(nMetaMagic == METAMAGIC_MAXIMIZE)
        nDamage = 30;

    effect eVis = EffectVisualEffect(VFX_FNF_HOWL_MIND);
    effect eImpact = EffectVisualEffect(VFX_IMP_DOOM);
    effect eDamage = EffectDamage(nDamage, DAMAGE_TYPE_SONIC);
    effect eStun = EffectStunned();

    //Apply Visual Effect
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lTarget);

    if(GetIsSilenced(oTarget))
        return;

    //Get the first target in the radius around the caster
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lTarget);
    while(GetIsObjectValid(oTarget))
    {
        if(!GetIsReactionTypeFriendly(oTarget) && !GetFactionEqual(oTarget))
        {
            fDelay = GetRandomDelay(0.4, 1.1);
            //Fire spell cast at event for target
            SignalEvent(oTarget, EventSpellCastAt(oTarget, GetSpellId(), TRUE));
            //Apply VFX impact and bonus effects
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oTarget));
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eStun, oTarget, RoundsToSeconds(nDuration)));
        }
        //Get the next target in the specified area around the caster
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lTarget);
    }
}
