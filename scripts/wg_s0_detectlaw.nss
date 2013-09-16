#include "engine"

//::////////////////////////////////////////////////////////////////////////:://
//:: Shadows of Westgate                                                  //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Detect Law                                                           //:://
//::////////////////////////////////////////////////////////////////////////:://
//:: Created By Nightshade, June 7, 2011                                  //:://
//::////////////////////////////////////////////////////////////////////////:://

#include "x2_inc_spellhook"

void main() {
    if(!X2PreSpellCastCode())
        return;

    location lCaster = GetLocation(OBJECT_SELF);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, 18.3, lCaster, TRUE);
    object oMisTarget;
    int nAxis;
    int nCtTargetAlign;

    SendMessageToPC(OBJECT_SELF, "You begin to concentrate on the area around you.");
    ActionWait(1.0);

    // Round 1

    while(GetIsObjectValid(oTarget)) {
        if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE) {
            nAxis = GetAlignmentLawChaos(oTarget);

            if(!GetHasSpellEffect(SPELL_UNDETECTABLE_ALIGNMENT, oTarget) && !GetHasSpellEffect(SPELL_NONDETECTION, oTarget)) {
                if(GetHasSpellEffect(SPELL_MISDIRECTION, oTarget)) {
                    oMisTarget = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oTarget);

                    if(oMisTarget == OBJECT_INVALID || oMisTarget == OBJECT_SELF)
                        oMisTarget = oTarget;

                    nAxis = GetAlignmentLawChaos(oMisTarget);
                }

                if(nAxis == ALIGNMENT_LAWFUL)
                    nCtTargetAlign++;
            }
        }

        oTarget = GetNextObjectInShape(SHAPE_SPHERE, 18.3, lCaster, TRUE);
    }

    if(nCtTargetAlign > 0)
        SendMessageToPC(OBJECT_SELF, "You sense the presence of law.");
    else {
        SendMessageToPC(OBJECT_SELF, "You sense no law nearby.");
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

    while(GetIsObjectValid(oTarget)) {
        if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE) {
            nAxis = GetAlignmentLawChaos(oTarget);

            if(!GetHasSpellEffect(SPELL_UNDETECTABLE_ALIGNMENT, oTarget) && !GetHasSpellEffect(SPELL_NONDETECTION, oTarget)) {
                if(GetHasSpellEffect(SPELL_MISDIRECTION, oTarget)) {
                    oMisTarget = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oTarget);

                    if(oMisTarget == OBJECT_INVALID || oMisTarget == OBJECT_SELF)
                        oMisTarget = oTarget;

                    nAxis = GetAlignmentLawChaos(oMisTarget);
                } else
                    oMisTarget = oTarget;

                if(nAxis == ALIGNMENT_LAWFUL) {
                    iPow = abs(GetHitDice(oMisTarget) / 5);

                    if(GetLevelByClass(CLASS_TYPE_UNDEAD, oMisTarget) > 0 ||
                       GetLevelByClass(CLASS_TYPE_ELEMENTAL, oMisTarget) > 0)
                        iPow = abs(GetHitDice(oMisTarget) / 2);

                    if(GetLevelByClass(CLASS_TYPE_OUTSIDER, oMisTarget) > 0 ||
                       GetLevelByClass(CLASS_TYPE_BLACKGUARD, oMisTarget) > 0 ||
                       GetLevelByClass(CLASS_TYPE_PALADIN, oMisTarget) > 0 ||
                       GetLevelByClass(CLASS_TYPE_CLERIC, oMisTarget) > 0)
                        iPow = abs(GetHitDice(oMisTarget));
                }

                if(iPow > nMxAura) nMxAura = iPow;
            }
        }

        oTarget = GetNextObjectInShape(SHAPE_SPHERE, 18.3, lCaster, TRUE);
    }

    if(nMxAura > 0) {
        sAuraMsg = IntToString(nCtTargetAlign) + " aura(s) are sensed in this area. The strength of the strongest aura is ";

        if(nMxAura < 2) sAuraMsg += "faint.";
        else if(nMxAura < 5) sAuraMsg += "moderate.";
        else if(nMxAura < 11) sAuraMsg += "strong.";
        else sAuraMsg += "overpowering.";

        SendMessageToPC(OBJECT_SELF, sAuraMsg);

        if(nMxAura > GetHitDice(OBJECT_SELF) * 2 && nMxAura > 10 && GetAlignmentLawChaos(OBJECT_SELF) == ALIGNMENT_CHAOTIC) {
            SendMessageToPC(OBJECT_SELF, "You are left reeling and stunned by the overwhelming law here!");
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
        if(GetObjectType(oTarget) == OBJECT_TYPE_CREATURE) {
            nAxis = GetAlignmentLawChaos(oTarget);

            if(!GetHasSpellEffect(SPELL_UNDETECTABLE_ALIGNMENT, oTarget) && !GetHasSpellEffect(SPELL_NONDETECTION, oTarget)) {
                if(GetHasSpellEffect(SPELL_MISDIRECTION, oTarget)) {
                    oMisTarget = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oTarget);

                    if(oMisTarget == OBJECT_INVALID || oMisTarget == OBJECT_SELF)
                        oMisTarget = oTarget;

                    nAxis = GetAlignmentLawChaos(oMisTarget);
                } else
                    oMisTarget = oTarget;

                if(nAxis == ALIGNMENT_LAWFUL) {
                    iPow = abs(GetHitDice(oMisTarget) / 5);

                    if(GetLevelByClass(CLASS_TYPE_UNDEAD, oMisTarget) > 0 ||
                       GetLevelByClass(CLASS_TYPE_ELEMENTAL, oMisTarget) > 0)
                        iPow = abs(GetHitDice(oMisTarget) / 2);

                    if(GetLevelByClass(CLASS_TYPE_OUTSIDER, oMisTarget) > 0 ||
                       GetLevelByClass(CLASS_TYPE_BLACKGUARD, oMisTarget) > 0 ||
                       GetLevelByClass(CLASS_TYPE_PALADIN, oMisTarget) > 0 ||
                       GetLevelByClass(CLASS_TYPE_CLERIC, oMisTarget) > 0)
                        iPow = abs(GetHitDice(oMisTarget));
                }

                sAuraMsg = "";

                if(iPow < 2) sAuraMsg += "faintly";
                else if(iPow < 5) sAuraMsg += "moderately";
                else if(iPow < 11) sAuraMsg += "strongly";
                else sAuraMsg += "overwhelmingly";

                SendMessageToPC(OBJECT_SELF, GetName(oMisTarget) + " is " + sAuraMsg + " law.");
            }
        }

        oTarget = GetNextObjectInShape(SHAPE_SPHERE, 18.3, lCaster, TRUE);
    }
}
