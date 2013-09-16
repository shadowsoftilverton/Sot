//Gate
//By Hardcore UFO
//Will summon a planar Henchman for 2 rounds per level (defined in inc_summons).
//There is a 2-10% chance the summon will be universally hostile.

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
        return;
    }

    object oCaster = OBJECT_SELF;
    int nCL = GetCasterLevel(oCaster);
    int nDuration = nCL * 2;
    int nLimit;
    location lTarget = GetSpellTargetLocation();

    string sNewSum = "SMN_" + GenerateTagFromName(oCaster);
    int nSpellID = GetSpellId();
    string sSumID;
    int nThresh = 10;

    // Exiting if the player has too many henchmen already.
    if(GetNumHenchmen(oCaster) >= GetMaxHenchmen())
    {
        SendMessageToPC(oCaster, "You may not have more than " + IntToString(GetMaxHenchmen()) + " creatures following you one time.");
        return;
    }

    float fDuration = RoundsToSeconds(nDuration);

    // Currently iDuration is only in seconds.
    if(GetMetaMagicFeat() == METAMAGIC_EXTEND)
    {
        fDuration = fDuration * 2;
    }

    nLimit = DetermineSummonLimit(oCaster, nThresh);

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
        nThresh = nThresh - 2;
    }

    //Divine Proxy boost if applicable.
    if(GetHasFeat(1568, OBJECT_SELF) == TRUE)
    {
        HierophantAugmentSummon(oLackey, OBJECT_SELF);
    }

    ScaledBoostSummon(oLackey, OBJECT_SELF);

    int nAwol = d100();

    //The summon has a 2-10% chance of being hostile to its summoner.
    if(nAwol > nThresh)
    {
        AddHenchman(oCaster, oLackey);
        nNameCount ++;
        SetLocalInt(oCaster, "SummonedCreature", nNameCount);
    }

    else
    {
        nNameCount ++;
        SetLocalInt(oCaster, "SummonedCreature", nNameCount);
        RampageAlignmentCheck(oLackey, "You should know better than to disrupt our affairs for yours. Good bye.");
    }

    DoUnsummon(oLackey, fDuration);
}

