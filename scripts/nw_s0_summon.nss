// =============================================================================
// File originally made by Hardcore UFO.
// Modified by Micteu. 2012 04 13
// =============================================================================

#include "x2_i0_spells"
#include "x2_inc_spellhook"
#include "inc_henchmen"
#include "nwnx_funcs"
#include "inc_nametag"
#include "inc_summons"
#include "engine"

void main()
{
    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    object oCaster = OBJECT_SELF;
    int nCL = GetCasterLevel(oCaster);
    int nLimit;
    int nFocus1 = GetHasFeat(166, oCaster); //If the caster has Spell Focus: Conjuration
    int nFocus2 = GetHasFeat(394, oCaster); //If the caster has Greater Spell Focus: Conjuration
    int nFocus3 = GetHasFeat(611, oCaster); //If the caster has Epic Spell Focus: Conjuration
    location lTarget = GetSpellTargetLocation();
    string sNewSum = "SMN_" + GenerateTagFromName(oCaster);
    int nSpellID = GetSpellId();
    string sSumID;

    // Exiting if the player has too many henchmen already.
    if(GetNumHenchmen(oCaster) >= GetMaxHenchmen())
    {
        SendMessageToPC(oCaster, "You may not have more than " + IntToString(GetMaxHenchmen()) + " creatures following you one time.");
        return;
    }


    // Setting first part of duration to be in turns.  More powerful summons
    // will have their duration reduced to rounds instead of turns.
    int iDuration = 2 * GetCasterLevel(oCaster);

    // Currently iDuration is only in seconds.
    if (GetMetaMagicFeat() == METAMAGIC_EXTEND)
    {
        iDuration = iDuration * 2;
    }

    float fDuration = TurnsToSeconds(iDuration);

    //Checks a local variable that determines the caster's summon limit based on feats.
    if(nFocus3 == 1)
    {
        nLimit = 4;
    }

    else if(nFocus2 == 1)
    {
        nLimit = 3;
    }

    else if(nFocus1 == 1)
    {
        nLimit = 2;
    }

    else
    {
        nLimit = 1;
    }

    // Exiting if the player has too many summons already.
    if(GetNumSummons(oCaster) >= nLimit)
    {
        SendMessageToPC(oCaster, "You may not have more than " + IntToString(nLimit) + " creatures summoned at one time.");
        return;
    }

    sSumID = DetermineSummonedCreature(nSpellID, lTarget, OBJECT_SELF);

    int nNameCount = GetLocalInt(oCaster, "SummonedCreature");
    string sNameCount = IntToString(nNameCount);
    sNewSum = sNewSum + sNameCount;
    object oLackey = CreateObject(OBJECT_TYPE_CREATURE, sSumID, lTarget, FALSE, sNewSum);

    // Augmenting the summon if applicable.
    if(GetHasFeat(1122, OBJECT_SELF) == TRUE)
    {
        string sConfirm = "IConfirmThisIsASummonedCreature";
        AugmentSummon(oLackey, OBJECT_SELF, sConfirm);
    }

    //Divine Proxy boost if applicable.
    if(GetHasFeat(1568, OBJECT_SELF) == TRUE)
    {
        HierophantAugmentSummon(oLackey, OBJECT_SELF);
    }

    ScaledBoostSummon(oLackey, OBJECT_SELF);

        AddHenchman(oCaster, oLackey);
        nNameCount ++;
        SetLocalInt(oCaster, "SummonedCreature", nNameCount);

    DoUnsummon(oLackey, fDuration);
}

