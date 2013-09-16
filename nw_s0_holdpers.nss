#include "engine"
#include "NW_I0_SPELLS"
#include "x2_inc_spellhook"
#include "inc_hold"

void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }

    object oTarget = GetSpellTargetObject();
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    int nMeta = GetMetaMagicFeat();
    int nDuration = nCasterLvl;
    int nDC = GetSpellSaveDC();
    float fInterval = 6.0f;

    if(GetHasFeat(396, OBJECT_SELF))    fInterval = 12.0f;    //GSF

    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HOLD_PERSON));
        //Make sure the target is a humanoid
        if (GetIsPlayableRacialType(oTarget) ||
            GetRacialType(oTarget) == RACIAL_TYPE_HUMANOID_GOBLINOID ||
            GetRacialType(oTarget) == RACIAL_TYPE_HUMANOID_MONSTROUS ||
            GetRacialType(oTarget) == RACIAL_TYPE_HUMANOID_ORC ||
            GetRacialType(oTarget) == RACIAL_TYPE_HUMANOID_REPTILIAN)
        {
            //Make SR Check
            if (!MyResistSpell(OBJECT_SELF, oTarget))
            {
                // Make metamagic extend check.
                if (nMeta == METAMAGIC_EXTEND)
                {
                    nDuration = nDuration * 2;
                }

                // Begin making will saves.
                HoldCreature(oTarget, nDC, nDuration, fInterval);
            }
        }
    }
}
