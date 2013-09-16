#include "engine"

//Create Undead
//By Invictus
//Based on scripts by Hardcore UFO
//Will summon a variety of undead depending on caster level.

#include "x2_i0_spells"
#include "x2_inc_spellhook"
#include "inc_henchmen"
#include "nwnx_funcs"
#include "inc_nametag"
#include "inc_summons"
#include "inc_undead"

void main() {
    if (!X2PreSpellCastCode()) return;

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
    if(GetNumHenchmen(oCaster) >= GetMaxHenchmen()) {
        SendMessageToPC(oCaster, "You may not have more than " + IntToString(GetMaxHenchmen()) + " creatures following you one time.");
        return;
    }

    float fDuration = HoursToSeconds(nDuration);
    if(GetMetaMagicFeat() == METAMAGIC_EXTEND) fDuration = fDuration * 2;

    nLimit = DetermineUndeadLimit(oCaster, nThresh);

    // Exiting if the player has too many summons already.
    if(GetNumSummons(oCaster) >= nLimit) {
        SendMessageToPC(oCaster, "You may not have more than " + IntToString(nLimit) + " creatures summoned at one time.");
        return;
    }

    sSumID = DetermineUndeadCreature(nSpellID, lTarget, OBJECT_SELF);

    int nNameCount = GetLocalInt(oCaster, "SummonedCreature");
    string sNameCount = IntToString(nNameCount);
    sNewSum = sNewSum + sNameCount;
    object oLackey = CreateObject(OBJECT_TYPE_CREATURE, sSumID, lTarget, FALSE, sNewSum);

    // Corpse crafter, etc.
    if(GetHasFeat(1640, OBJECT_SELF))
        ApplyCorpseCrafterBonuses(oLackey, OBJECT_SELF);
    if(GetHasFeat(1641, OBJECT_SELF))
        ApplyBolsterResistanceBonuses(oLackey, OBJECT_SELF);
    if(GetHasFeat(1642, OBJECT_SELF))
        ApplyDeadlyChillBonuses(oLackey, OBJECT_SELF);
    if(GetHasFeat(1643, OBJECT_SELF))
        ApplyDestructionRetributionBonuses(oLackey, OBJECT_SELF);
    if(GetHasFeat(1644, OBJECT_SELF))
        ApplyHardenedFleshBonuses(oLackey, OBJECT_SELF);
    if(GetHasFeat(1645, OBJECT_SELF))
        ApplyNimbleBonesBonuses(oLackey, OBJECT_SELF);

    ScaledBoostSummon(oLackey, OBJECT_SELF);

    AddHenchman(oCaster, oLackey);
    nNameCount++;
    SetLocalInt(oCaster, "SummonedCreature", nNameCount);

    DoUnsummon(oLackey, fDuration);
}
