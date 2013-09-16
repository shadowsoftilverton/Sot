#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Alter Self                                                           //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 16 2011                                  //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void main() {
    if(!X2PreSpellCastCode())
        return;

    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    float fDuration = 10 * 60.0 * nCasterLevel;
    int nMetaMagic = GetMetaMagicFeat();

    if(nMetaMagic == METAMAGIC_EXTEND)
        fDuration = fDuration * 2.0;

    SetLocalFloat(OBJECT_SELF, "wg_sp_altself_duration", fDuration);

    ActionStartConversation(OBJECT_SELF, "sp_altself_conv", TRUE, FALSE);
}
