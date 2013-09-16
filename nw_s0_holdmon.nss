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

    if(GetHasFeat(396, OBJECT_SELF))    fInterval = 12.0f;   //GSF
    if(GetHasFeat(613, OBJECT_SELF))    fInterval = 18.0f;   //ESF

    if(!GetIsReactionTypeFriendly(oTarget))
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HOLD_MONSTER));

        if (!MyResistSpell(OBJECT_SELF, oTarget))
        {
            if (nMeta == METAMAGIC_EXTEND)
            {
                nDuration = nDuration * 2;
            }

            HoldCreature(oTarget, nDC, nDuration, fInterval);
        }
    }
}
