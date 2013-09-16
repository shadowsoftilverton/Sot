#include "engine"
#include "x0_i0_anims"
#include "nw_i0_generic"

void HideInPlainSight(object oHider)
{
    SetActionMode(oHider, ACTION_MODE_STEALTH, TRUE);
    UseStealthMode();
}

void RunHideAndStrike(object oHider, object oHidee)
{
    int nRoll = d4();
    float fHideTimer = RoundsToSeconds(nRoll);

    //If the caller is in melee range of the damager, run 5 meters away and enter stealth before attacking again.
    if((GetDistanceToObject(oHidee) < 1.5f) && (GetLocalInt(oHider, "HideInPlainSightTimer") != 1))
    {
        SetLocalInt(oHider, "HideInPlainSightTimer", 1);
        ActionMoveAwayFromObject(oHidee, TRUE, 5.0f);
        DelayCommand(1.0f, HideInPlainSight(oHider));
        DelayCommand(1.2f, ActionAttack(oHidee));
        DelayCommand(fHideTimer, DeleteLocalInt(oHider, "HideInPlainSightTimer"));
    }
}

void JumpToDistantEnemy(object oJumper, object oTarget)
{
    object oTargetVictim = GetLastPerceived();

    if(GetDistanceToObject(oTargetVictim) > 10.0)
    {
        if(d8() > 5)
        {
            ClearAllActions();
            effect eVis1 = EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_GREASE);
            effect eVis2 = EffectVisualEffect(VFX_IMP_MAGBLUE);
            effect eVis = EffectLinkEffects(eVis1, eVis2);
            effect eFadeOut = EffectEthereal();

            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oJumper);

            ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1, 1.0f, 0.5);
            DelayCommand(0.3, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oJumper)));
            DelayCommand(0.4, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eFadeOut, oJumper));
            DelayCommand(0.5, ActionJumpToObject(oTargetVictim));
        }
    }
}

void JumpToWeakestEnemy(object oTarget)
{
    object oTargetVictim = GetFactionMostDamagedMember(oTarget);
    if((GetDistanceToObject(oTargetVictim) > 4.0) && (GetObjectSeen(oTargetVictim) == TRUE))
    {
        ClearAllActions();
        effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);

        DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF));
        DelayCommand(0.3,ActionJumpToObject(oTargetVictim));
        DelayCommand(0.5,ActionAttack(oTargetVictim));
    }
}

void AttemptMagicalDetection(object oDetector)
{
    if(GetHasSpell(SPELL_TRUE_SEEING, oDetector))
    {
        ActionCastSpellAtObject(SPELL_TRUE_SEEING, oDetector);
    }

    if(GetHasSpell(SPELL_SEE_INVISIBILITY, oDetector))
    {
        ActionCastSpellAtObject(SPELL_SEE_INVISIBILITY, oDetector);
    }

    if(GetHasSpell(SPELL_INVISIBILITY_PURGE, oDetector))
    {
        ActionCastSpellAtObject(SPELL_INVISIBILITY_PURGE, oDetector);
    }

    if(GetHasSpell(SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE, oDetector))
    {
        ActionCastSpellAtObject(SPELL_CLAIRAUDIENCE_AND_CLAIRVOYANCE, oDetector);
    }

    if(GetHasSpell(SPELL_AMPLIFY, oDetector))
    {
        ActionCastSpellAtObject(SPELL_AMPLIFY, oDetector);
    }
}

