//::///////////////////////////////////////////////
//:: [Raise Dead]
//:: [NW_S0_RaisDead.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Brings a character back to life with 1 HP.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 31, 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 11, 2001
//:: VFX Pass By: Preston W, On: June 22, 2001

// Jasperre:
// - To make this operate effectivly, the AI that is, the PC speaks silently
// when they are raised, to let NPC's get them :-P
// This is not required, but is a simple addition.
// - It also adds NPC re-targeting to get them back into combat.

//Modified by Hardcore UFO
//Makes a Knowledge: Religion check and uses gold to simulate the used diamond.

#include "x2_inc_spellhook"

#include "inc_death"
#include "engine"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

    if(GetResRef(GetArea(OBJECT_SELF)) == "world_fugue")
    {
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eRaise = EffectResurrection();
    effect eVis = EffectVisualEffect(VFX_IMP_RAISE_DEAD);
    int nSkill = Std_GetSkillRank(42, OBJECT_SELF, FALSE);
    int nLevel = GetHitDice(oTarget);
    int nBonusC = GetLevelByClass(CLASS_TYPE_CLERIC, OBJECT_SELF);
    int nBonusD = GetLevelByClass(CLASS_TYPE_DRUID, OBJECT_SELF);
    int nBonusE = GetLevelByClass(CLASS_TYPE_PALADIN, OBJECT_SELF) / 2;
    int nBonusP = GetLevelByClass(CLASS_TYPE_PALE_MASTER, OBJECT_SELF) / 2;
    int nBonusT = GetLevelByClass(CLASS_TYPE_MYSTIC_THEURGE, OBJECT_SELF) / 2;
    int nDC = 10 + (nLevel / 2);
    int nRoll = d20();
    int nBoni = nSkill + nBonusC + nBonusD + nBonusE + nBonusP + nBonusT;
    int nAttempt = nBoni + nRoll;

    string sRoll = IntToString(nRoll) + " + " + IntToString(nBoni) + " = " + IntToString(nAttempt) + " vs. DC " + IntToString(nDC);
    int nGold = GetGold(OBJECT_SELF);
    int nCost = 100 * nLevel / 2;
    object oPayer = OBJECT_SELF;

    if(nCost > 1000)
    {
        nCost = 1000;
    }

    if(GetIsDM(OBJECT_SELF) || GetIsDMPossessed(OBJECT_SELF))
    {
        nCost = 0;
    }

    if(nGold < nCost)
    {
        nGold = GetGold(oTarget);

        if(nGold < nCost)
        {
            SendMessageToPC(OBJECT_SELF, "You do not have the gold needed for the components of this ritual.");
            return;
        }

        oPayer = oTarget;
    }

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_RAISE_DEAD, FALSE));
    SendMessageToPC(OBJECT_SELF, sRoll);

    if(GetIsDead(oTarget))
    {
        if(nAttempt < nDC)
        {
            SendMessageToPC(OBJECT_SELF, "The ritual fails and the body remains as it was.");
            TakeGold(nCost, oPayer, TRUE);
            return;
        }

        else
        {
            //Apply raise dead effect and VFX impact
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oTarget));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eRaise, oTarget);
            TakeGold(nCost, oPayer, TRUE);

            if(GetIsPC(oTarget)) SetIsPersistentDead(oTarget, 0);

            // Jasperre's additions...
            AssignCommand(oTarget, SpeakString("I AM ALIVE!", TALKVOLUME_SILENT_TALK));
            if(!GetIsPC(oTarget) && !GetIsDMPossessed(oTarget))
            {
                // Default AI script
                ExecuteScript("nw_c2_default3", oTarget);
            }
        }
    }
}

