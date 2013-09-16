#include "engine"

void main()
{
    object oEnter = GetEnteringObject();
    int nRace = GetRacialType(oEnter);
    int nClass = GetLevelByClass(CLASS_TYPE_PALEMASTER, oEnter);

    //Checks if the entering object is an Undead, Aberration, Construct, or Palemaster.
    if(nRace == 24 || nRace == 7 || nRace == 10 || nClass >= 1)
    {
        effect eCurse = EffectCurse(4, 4, 6, 6, 4, 6);
        effect eSpell = EffectSpellResistanceDecrease(12);
        effect eFail = EffectSpellFailure(100, SPELL_SCHOOL_NECROMANCY);

        eCurse = SupernaturalEffect(eCurse);
        eSpell = SupernaturalEffect(eSpell);
        eFail = SupernaturalEffect(eFail);

        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCurse, oEnter);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSpell, oEnter);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFail, oEnter);

        SendMessageToPC(oEnter, "Something strikes a profound weakness into you.");
    }
}
