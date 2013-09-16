#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Detect Undead                                                        //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 7, 2011                                  //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void main() {
    if(!X2PreSpellCastCode())
        return;

    location lCaster = GetLocation(OBJECT_SELF);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 18.3, lCaster, TRUE);
    int nRace;
    int nCounter;

    SendMessageToPC(OBJECT_SELF, "You begin to concentrate on the area around you.");
    ActionWait(1.0);

    // Round 1

    while(GetIsObjectValid(oTarget)) {
        if(GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
            nCounter++;

        oTarget = GetNextObjectInShape(SHAPE_SPHERE, 18.3, lCaster, TRUE);
    }

    if(nCounter > 0)
        SendMessageToPC(OBJECT_SELF, "You sense the presence of undead.");
    else {
        SendMessageToPC(OBJECT_SELF, "You sense no undead nearby.");
        return;
    }

    ActionWait(6.0);

    if(GetLocation(OBJECT_SELF) != lCaster) {
        SendMessageToPC(OBJECT_SELF, "Your concentration has broken, ending the spell.");
        return;
    }

    // Round 2

    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 18.3, lCaster, TRUE);
    int nMxAura = 1;
    int iPow = 0;
    string sAuraMsg;
    nCounter = 0;

    while(GetIsObjectValid(oTarget)) {
        if(GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD) {
            iPow = GetHitDice(oTarget);
            nCounter++;

            if(iPow > nMxAura) nMxAura = iPow;
        }

        oTarget = GetNextObjectInShape(SHAPE_SPHERE, 18.3, lCaster, TRUE);
    }

    if(nMxAura > 0) {
        sAuraMsg = IntToString(nCounter) + " aura(s) are sensed in this area. The strength of the strongest aura is ";

        if(nMxAura < 2) sAuraMsg += "faint.";
        else if(nMxAura < 5) sAuraMsg += "moderate.";
        else if(nMxAura < 11) sAuraMsg += "strong.";
        else sAuraMsg += "overpowering.";

        SendMessageToPC(OBJECT_SELF, sAuraMsg);

        if(nMxAura > GetHitDice(OBJECT_SELF) * 2 && nMxAura > 10 && GetAlignmentGoodEvil(OBJECT_SELF) == ALIGNMENT_GOOD) {
            SendMessageToPC(OBJECT_SELF, "You are left reeling and stunned by the overwhelming presence of undeath!");
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectStunned(), OBJECT_SELF, 6.0);
        }
    }

    ActionWait(6.0);

    if(GetLocation(OBJECT_SELF) != lCaster) {
        SendMessageToPC(OBJECT_SELF, "Your concentration has broken, ending the spell.");
        return;
    }

    // Round 3

    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 18.3, lCaster, TRUE);

    while(GetIsObjectValid(oTarget)) {
        if(GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
            iPow = GetHitDice(oTarget);

        sAuraMsg = "";

        if(iPow < 2) sAuraMsg += "faint";
        else if(iPow < 5) sAuraMsg += "moderate";
        else if(iPow < 11) sAuraMsg += "strong";
        else sAuraMsg += "overpowering";

        SendMessageToPC(OBJECT_SELF, GetName(oTarget) + " has a " + sAuraMsg + " aura of undeath.");

        oTarget = GetNextObjectInShape(SHAPE_SPHERE, 18.3, lCaster, TRUE);
    }
}
