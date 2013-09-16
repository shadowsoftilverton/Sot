#include "X0_I0_SPELLS"
#include "engine"

void main()
{
    object oDoor = OBJECT_SELF;
    object oPC = GetLastAttacker(oDoor);
    object oWeap = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    int nBlud = GetDamageDealtByType(DAMAGE_TYPE_BLUDGEONING);
    effect eHeal = EffectHeal(500);

    if(oWeap == OBJECT_INVALID)
    {
        ActionOpenDoor(oDoor);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oDoor);
        DelayCommand(180.0f, ActionCloseDoor(oDoor));
    }

    else
    {
        int nDamage;
        effect eStun = EffectStunned();
        effect eVis = EffectVisualEffect(VFX_IMP_SONIC);
        effect eFNF = EffectVisualEffect(VFX_FNF_SOUND_BURST);
        effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);

        effect eLink = EffectLinkEffects(eStun, eMind);
        eLink = EffectLinkEffects(eLink, eDur);

        effect eDam;
        location lLoc = GetLocation(oPC);

        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFNF, lLoc);

        oPC = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lLoc);

        while (GetIsObjectValid(oPC))
        {
            SignalEvent(oPC, EventSpellCastAt(OBJECT_SELF, SPELL_SOUND_BURST));
            nDamage = d8();

            if(!MySavingThrow(SAVING_THROW_WILL, oPC, 17, SAVING_THROW_TYPE_SONIC))
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oPC, RoundsToSeconds(2));
            }

            eDam = EffectDamage(nDamage, DAMAGE_TYPE_SONIC);

            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oPC);
            DelayCommand(0.01, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oPC));

            oPC = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_MEDIUM, lLoc);
        }

        ActionOpenDoor(oDoor);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oDoor);
    }
}
