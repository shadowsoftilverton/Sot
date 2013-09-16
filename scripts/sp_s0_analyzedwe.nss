#include "engine"

#include "x2_inc_spellhook"

void main()
{
    if (!X2PreSpellCastCode()) return;

    object oCaster = OBJECT_SELF;
    int iDuration = GetCasterLevel(oCaster);

    // This is handled in the mod_examine code; if the variable is TRUE, then we
    // identify anything we examine.
    SetLocalInt(oCaster, "ANALYZE_DWEOMER", TRUE);

    DelayCommand(RoundsToSeconds(iDuration), DeleteLocalInt(oCaster, "ANALYZE_DWEOMER"));
}
