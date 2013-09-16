//OnHeartbeat script for beholder creatures' antimgic eye while opened.
//By Hardcore UFO.

//Each round:
//If there is no enemy in range, nothing will happen.
//If there is at least one enemy in range, the cone will apply spell failure and strip 1d2 effects from the enemy.

#include "engine"
#include "x0_i0_spells"

void BeholdNoMagic(object oTarget);

void main()
{
    object oNearOrExit = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1);

    if(GetDistanceToObject(oNearOrExit) > 15.0f)
    {
        return;
    }

    else
    {
        float fSelf = GetFacing(OBJECT_SELF);
        vector vSelf = GetPosition(OBJECT_SELF);
        object oArea = GetArea(OBJECT_SELF);

        float fNewX = vSelf.x + 15.0f * cos(fSelf);
        float fNewY = vSelf.y + 15.0f * sin(fSelf);

        vector vNew = Vector(fNewX, fNewY, vSelf.z);
        location lNew = Location(oArea, vNew, fSelf);

        effect eAntiMag = EffectSpellFailure(100);

        object oMagless = GetFirstObjectInShape(SHAPE_SPELLCONE, 15.0, lNew, TRUE, OBJECT_TYPE_CREATURE);

        while(GetIsObjectValid(oMagless))
        {
            BeholdNoMagic(oMagless);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAntiMag, oMagless, 6.0f);

            oMagless = GetNextObjectInShape(SHAPE_SPELLCONE, 15.0, lNew, TRUE, OBJECT_TYPE_CREATURE);
        }
    }
}

void BeholdNoMagic(object oTarget)
{
    int nLimit = d2();
    int nCount = 1;
    effect eEff = GetFirstEffect(oTarget);


    while(nCount < nLimit)
    {
        if(GetEffectSubType(eEff) == SUBTYPE_MAGICAL)
        {
            if (GetEffectType(eEff) != EFFECT_TYPE_DISAPPEARAPPEAR && GetEffectType(eEff) != EFFECT_TYPE_SPELL_FAILURE)
            {
                RemoveEffect(oTarget, eEff);
                nCount ++;
            }
        }

        eEff = GetNextEffect(oTarget);
    }
}
