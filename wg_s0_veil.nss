#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Veil                                                                 //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 19 2011                                  //:://
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

    SetLocalFloat(OBJECT_SELF, "wg_sp_veil_duration", fDuration);

    ActionStartConversation(OBJECT_SELF, "sp_veil_conv", TRUE, FALSE);
}
