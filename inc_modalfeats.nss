#include "x2_inc_itemprop"
#include "inc_system"
#include "nwnx_structs"

// Constants for Power Attack
const int SPELL_POWERATTACK_BASE = 1040;
const int SPELL_POWERATTACK_1    = 1041;
const int SPELL_POWERATTACK_2    = 1042;
const int SPELL_POWERATTACK_3    = 1043;
const int SPELL_POWERATTACK_4    = 1044;
const int SPELL_POWERATTACK_5    = 1045;

const int SPELL_IMP_POWERATTACK_BASE = 1050;
const int SPELL_IMP_POWERATTACK_1    = 1051;
const int SPELL_IMP_POWERATTACK_2    = 1052;
const int SPELL_IMP_POWERATTACK_3    = 1053;
const int SPELL_IMP_POWERATTACK_4    = 1054;
const int SPELL_IMP_POWERATTACK_5    = 1055;

// Constants for Expertise
const int SPELL_EXPERTISE_BASE = 1020;
const int SPELL_EXPERTISE_1    = 1021;
const int SPELL_EXPERTISE_2    = 1022;
const int SPELL_EXPERTISE_3    = 1023;
const int SPELL_EXPERTISE_4    = 1024;
const int SPELL_EXPERTISE_5    = 1025;

const int SPELL_IMP_EXPERTISE_BASE = 1030;
const int SPELL_IMP_EXPERTISE_1    = 1031;
const int SPELL_IMP_EXPERTISE_2    = 1032;
const int SPELL_IMP_EXPERTISE_3    = 1033;
const int SPELL_IMP_EXPERTISE_4    = 1034;
const int SPELL_IMP_EXPERTISE_5    = 1035;

// Constants for Focused Attack
const int SPELL_FOCUSEDATTACK_BASE = 1060;
const int SPELL_FOCUSEDATTACK_1    = 1061;
const int SPELL_FOCUSEDATTACK_2    = 1062;
const int SPELL_FOCUSEDATTACK_3    = 1063;
const int SPELL_FOCUSEDATTACK_4    = 1064;
const int SPELL_FOCUSEDATTACK_5    = 1065;

const int SPELL_IMP_FOCUSEDATTACK_BASE = 1070;
const int SPELL_IMP_FOCUSEDATTACK_1    = 1071;
const int SPELL_IMP_FOCUSEDATTACK_2    = 1072;
const int SPELL_IMP_FOCUSEDATTACK_3    = 1073;
const int SPELL_IMP_FOCUSEDATTACK_4    = 1074;
const int SPELL_IMP_FOCUSEDATTACK_5    = 1075;

// Constants for Defensive Stance
const int SPELL_DEFENSIVE_STANCE = 1376;

int PowerAttackActive(object oTarget);
void RemovePowerAttackEffect(object oTarget);

int ExpertiseActive(object oTarget);
void ActivateExpertiseEffect(object oTarget, int nSpell);
void RemoveExpertiseEffect(object oTarget);

int FocusedAttackActive(object oTarget);
void ActivateFocusedAttackEffect(object oTarget, int nSpell);
void RemoveFocusedAttackEffect(object oTarget);

void DoDeactivateModalFeats(object oTarget);

int ManyShotActive(object oTarget, int iBool=1)
{
    effect eLoop = GetFirstEffect(oTarget);
    while(GetIsEffectValid(eLoop)) {
        if(GetEffectSpellId(eLoop) == 1131 ||
           GetEffectSpellId(eLoop) == 1132 ||
           GetEffectSpellId(eLoop) == 1133 ||
           GetEffectSpellId(eLoop) == 1134 ||
           GetEffectSpellId(eLoop) == 1135 ){
           if(iBool==1) return 1;
           else return GetEffectSpellId(eLoop);
        }
        eLoop = GetNextEffect(oTarget);
    }
    return 0;
}

void RemoveManyShotEffect(object oTarget)
{
    effect eLoop = GetFirstEffect(oTarget);
    while(GetIsEffectValid(eLoop)) {
        if(GetEffectSpellId(eLoop) == 1131 ||
           GetEffectSpellId(eLoop) == 1132 ||
           GetEffectSpellId(eLoop) == 1133 ||
           GetEffectSpellId(eLoop) == 1134 ||
           GetEffectSpellId(eLoop) == 1135 ){
           Std_RemoveEffect(oTarget, eLoop);
           SendMessageToPC(oTarget,"Manyshot Deactivated");
        }
        eLoop = GetNextEffect(oTarget);
    }
}

void ActivateManyShotAttack(object oTarget)
{
    object oShooter=OBJECT_SELF;
    object oWep=GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oShooter);
    RemoveManyShotEffect(oShooter);
    if(IPGetIsRangedWeapon(oWep))
    {
        int iExtra=GetSpellId()-1129;
        int iPenalty=iExtra*2;
        if(GetHasFeat(1543,oShooter))//Greater ManyShot
        {
            iPenalty=iPenalty;
        }
        itemproperty IPMany=ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER,GetHitDice(oShooter));
        IPMany=SystemItemProperty(IPMany);
        if(IPGetIsRangedWeapon(oWep))
        {
            IPSafeAddItemProperty(oWep,IPMany);//Adding it to the bow didn't seem to work except for thrown...
            IPSafeAddItemProperty(GetItemInSlot(INVENTORY_SLOT_ARROWS,oShooter),IPMany);//So we'll try adding it to the arrows, instead.
            IPSafeAddItemProperty(GetItemInSlot(INVENTORY_SLOT_BOLTS,oShooter),IPMany);//So we'll try adding it to the bolts, instead.
            IPSafeAddItemProperty(GetItemInSlot(INVENTORY_SLOT_BULLETS,oShooter),IPMany);//So we'll try adding it to the bullets, instead.
            SendMessageToPC(oShooter,"Manyshot "+IntToString(iExtra)+" arrows activated");
        }
        effect eMany=SystemEffect(EffectAttackDecrease(iPenalty));
        SetEffectSpellId(eMany,GetSpellId());
        eMany=ExtraordinaryEffect(eMany);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,eMany,oShooter);
    }
    else SendMessageToPC(oShooter,"This feat only works with a ranged weapon in your main hand");
}

int WhirlwindAttackActive(object oTarget)
{
    effect eLoop = GetFirstEffect(oTarget);
    while(GetIsEffectValid(eLoop))
    {
        if(GetEffectSpellId(eLoop)==561)
        return 1;
        eLoop=GetNextEffect(oTarget);
    }
    return 0;
}

void RemoveWhirlwindAttackEffect(object oTarget)
{
    effect eLoop = GetFirstEffect(oTarget);
    while(GetIsEffectValid(eLoop))
    {
        if(GetEffectSpellId(eLoop)==561)
        Std_RemoveEffect(oTarget,eLoop);
        eLoop=GetNextEffect(oTarget);
    }
    SendMessageToPC(oTarget,"Whirlwind attack deactivated");
}

void ActivateWhirlwindAttack(object oTarget)
{
    object oTwirlyWhirly=OBJECT_SELF;
    object oWep=GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oTwirlyWhirly);
    if(!GetIsObjectValid(oWep)) oWep=GetItemInSlot(INVENTORY_SLOT_ARMS,oTwirlyWhirly);
    RemoveWhirlwindAttackEffect(oTwirlyWhirly);
    if((!GetIsObjectValid(oWep))|GetWeaponRanged(oWep))
    {
        SendMessageToPC(oTwirlyWhirly,"You must have a melee weapon or a glove equipped to use this feat.");
        return;
    }
    int iPenalty=4;
    if(GetHasFeat(645,oTwirlyWhirly))//Greater Whirlwind
    {
        iPenalty=2;
    }
    itemproperty IPWhirl=ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER,GetHitDice(oTwirlyWhirly));
    IPWhirl=SystemItemProperty(IPWhirl);
    AddItemProperty(DURATION_TYPE_PERMANENT,IPWhirl,oWep);
    effect eWhirl=SystemEffect(EffectDamageDecrease(iPenalty));
    SetEffectSpellId(eWhirl,561);
    eWhirl=ExtraordinaryEffect(eWhirl);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,eWhirl,oTwirlyWhirly);
    SendMessageToPC(oTarget,"Whirlwind attack activated");
}

// Power Attack Specific Functions
int PowerAttackActive(object oTarget) {
    effect eLoop = GetFirstEffect(oTarget);

    while(GetIsEffectValid(eLoop)) {
        if(GetEffectSpellId(eLoop) == SPELL_POWERATTACK_1 ||
           GetEffectSpellId(eLoop) == SPELL_POWERATTACK_2 ||
           GetEffectSpellId(eLoop) == SPELL_POWERATTACK_3 ||
           GetEffectSpellId(eLoop) == SPELL_POWERATTACK_4 ||
           GetEffectSpellId(eLoop) == SPELL_POWERATTACK_5 ||
           GetEffectSpellId(eLoop) == SPELL_IMP_POWERATTACK_1 ||
           GetEffectSpellId(eLoop) == SPELL_IMP_POWERATTACK_2 ||
           GetEffectSpellId(eLoop) == SPELL_IMP_POWERATTACK_3 ||
           GetEffectSpellId(eLoop) == SPELL_IMP_POWERATTACK_4 ||
           GetEffectSpellId(eLoop) == SPELL_IMP_POWERATTACK_5) {
               return 1;
        }

        eLoop = GetNextEffect(oTarget);
    }

    return 0;
}

void RemovePowerAttackEffect(object oTarget) {
    effect eLoop = GetFirstEffect(oTarget);

    while(GetIsEffectValid(eLoop)) {
        if(GetEffectSpellId(eLoop) == SPELL_POWERATTACK_1 ||
           GetEffectSpellId(eLoop) == SPELL_POWERATTACK_2 ||
           GetEffectSpellId(eLoop) == SPELL_POWERATTACK_3 ||
           GetEffectSpellId(eLoop) == SPELL_POWERATTACK_4 ||
           GetEffectSpellId(eLoop) == SPELL_POWERATTACK_5 ||
           GetEffectSpellId(eLoop) == SPELL_IMP_POWERATTACK_1 ||
           GetEffectSpellId(eLoop) == SPELL_IMP_POWERATTACK_2 ||
           GetEffectSpellId(eLoop) == SPELL_IMP_POWERATTACK_3 ||
           GetEffectSpellId(eLoop) == SPELL_IMP_POWERATTACK_4 ||
           GetEffectSpellId(eLoop) == SPELL_IMP_POWERATTACK_5) {
               Std_RemoveEffect(oTarget, eLoop);
        }

        eLoop = GetNextEffect(oTarget);
    }

    FloatingTextStringOnCreature("*Power Attack Deactivated*", oTarget, FALSE);
}

// Expertise specific functions
int ExpertiseActive(object oTarget) {
    effect eLoop = GetFirstEffect(oTarget);

    while(GetIsEffectValid(eLoop)) {
        if(GetEffectSpellId(eLoop) == SPELL_EXPERTISE_1 ||
           GetEffectSpellId(eLoop) == SPELL_EXPERTISE_2 ||
           GetEffectSpellId(eLoop) == SPELL_EXPERTISE_3 ||
           GetEffectSpellId(eLoop) == SPELL_EXPERTISE_4 ||
           GetEffectSpellId(eLoop) == SPELL_EXPERTISE_5 ||
           GetEffectSpellId(eLoop) == SPELL_IMP_EXPERTISE_1 ||
           GetEffectSpellId(eLoop) == SPELL_IMP_EXPERTISE_2 ||
           GetEffectSpellId(eLoop) == SPELL_IMP_EXPERTISE_3 ||
           GetEffectSpellId(eLoop) == SPELL_IMP_EXPERTISE_4 ||
           GetEffectSpellId(eLoop) == SPELL_IMP_EXPERTISE_5) {
               return 1;
        }

        eLoop = GetNextEffect(oTarget);
    }

    return 0;
}

void ActivateExpertiseEffect(object oTarget, int nSpell) {
    FloatingTextStringOnCreature("*Expertise Activated*", oTarget, FALSE);

    int iExpertiseMagnitude;

    if(nSpell == SPELL_EXPERTISE_1) iExpertiseMagnitude = 1;
    else if(nSpell == SPELL_EXPERTISE_2) iExpertiseMagnitude = 2;
    else if(nSpell == SPELL_EXPERTISE_3) iExpertiseMagnitude = 3;
    else if(nSpell == SPELL_EXPERTISE_4) iExpertiseMagnitude = 4;
    else if(nSpell == SPELL_EXPERTISE_5) iExpertiseMagnitude = 5;
    else if(nSpell == SPELL_IMP_EXPERTISE_1) iExpertiseMagnitude = 6;
    else if(nSpell == SPELL_IMP_EXPERTISE_2) iExpertiseMagnitude = 7;
    else if(nSpell == SPELL_IMP_EXPERTISE_3) iExpertiseMagnitude = 8;
    else if(nSpell == SPELL_IMP_EXPERTISE_4) iExpertiseMagnitude = 9;
    else if(nSpell == SPELL_IMP_EXPERTISE_5) iExpertiseMagnitude = 10;

    effect eACMod = EffectACIncrease(iExpertiseMagnitude, AC_DODGE_BONUS);
    effect eABMod = EffectAttackDecrease(iExpertiseMagnitude);
    effect eLink = EffectLinkEffects(eACMod, eABMod);
    eLink = SupernaturalEffect(eLink);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget);
}

void RemoveExpertiseEffect(object oTarget) {
    effect eLoop = GetFirstEffect(oTarget);

    while(GetIsEffectValid(eLoop)) {
        if(GetEffectSpellId(eLoop) == SPELL_EXPERTISE_1 ||
           GetEffectSpellId(eLoop) == SPELL_EXPERTISE_2 ||
           GetEffectSpellId(eLoop) == SPELL_EXPERTISE_3 ||
           GetEffectSpellId(eLoop) == SPELL_EXPERTISE_4 ||
           GetEffectSpellId(eLoop) == SPELL_EXPERTISE_5 ||
           GetEffectSpellId(eLoop) == SPELL_IMP_EXPERTISE_1 ||
           GetEffectSpellId(eLoop) == SPELL_IMP_EXPERTISE_2 ||
           GetEffectSpellId(eLoop) == SPELL_IMP_EXPERTISE_3 ||
           GetEffectSpellId(eLoop) == SPELL_IMP_EXPERTISE_4 ||
           GetEffectSpellId(eLoop) == SPELL_IMP_EXPERTISE_5) {
               Std_RemoveEffect(oTarget, eLoop);
        }

        eLoop = GetNextEffect(oTarget);
    }

    FloatingTextStringOnCreature("*Expertise Deactivated*", oTarget, FALSE);
}

// Focused Attack specific functions
int FocusedAttackActive(object oTarget) {
    effect eLoop = GetFirstEffect(oTarget);

    while(GetIsEffectValid(eLoop)) {
        if(GetEffectSpellId(eLoop) == SPELL_FOCUSEDATTACK_1 ||
           GetEffectSpellId(eLoop) == SPELL_FOCUSEDATTACK_2 ||
           GetEffectSpellId(eLoop) == SPELL_FOCUSEDATTACK_3 ||
           GetEffectSpellId(eLoop) == SPELL_FOCUSEDATTACK_4 ||
           GetEffectSpellId(eLoop) == SPELL_FOCUSEDATTACK_5 ||
           GetEffectSpellId(eLoop) == SPELL_IMP_FOCUSEDATTACK_1 ||
           GetEffectSpellId(eLoop) == SPELL_IMP_FOCUSEDATTACK_2 ||
           GetEffectSpellId(eLoop) == SPELL_IMP_FOCUSEDATTACK_3 ||
           GetEffectSpellId(eLoop) == SPELL_IMP_FOCUSEDATTACK_4 ||
           GetEffectSpellId(eLoop) == SPELL_IMP_FOCUSEDATTACK_5) {
               return 1;
         }

         eLoop = GetNextEffect(oTarget);
    }

    return 0;
}

void ActivateFocusedAttackEffect(object oTarget, int nSpell) {
    FloatingTextStringOnCreature("*Focused Attack Activated*", oTarget, FALSE);

    int iFocusedAttackMagnitude;

    if(nSpell == SPELL_FOCUSEDATTACK_1) iFocusedAttackMagnitude = 1;
    else if(nSpell == SPELL_FOCUSEDATTACK_2) iFocusedAttackMagnitude = 2;
    else if(nSpell == SPELL_FOCUSEDATTACK_3) iFocusedAttackMagnitude = 3;
    else if(nSpell == SPELL_FOCUSEDATTACK_4) iFocusedAttackMagnitude = 4;
    else if(nSpell == SPELL_FOCUSEDATTACK_5) iFocusedAttackMagnitude = 5;
    else if(nSpell == SPELL_IMP_FOCUSEDATTACK_1) iFocusedAttackMagnitude = 6;
    else if(nSpell == SPELL_IMP_FOCUSEDATTACK_2) iFocusedAttackMagnitude = 7;
    else if(nSpell == SPELL_IMP_FOCUSEDATTACK_3) iFocusedAttackMagnitude = 8;
    else if(nSpell == SPELL_IMP_FOCUSEDATTACK_4) iFocusedAttackMagnitude = 9;
    else if(nSpell == SPELL_IMP_FOCUSEDATTACK_5) iFocusedAttackMagnitude = 10;

    effect eABMod = EffectAttackIncrease(iFocusedAttackMagnitude);
    effect eACMod = EffectACDecrease(iFocusedAttackMagnitude, AC_DODGE_BONUS);
    effect eLink = EffectLinkEffects(eABMod, eACMod);
    eLink = SupernaturalEffect(eLink);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget);
}

void RemoveFocusedAttackEffect(object oTarget) {
    effect eLoop = GetFirstEffect(oTarget);

    while(GetIsEffectValid(eLoop)) {
        if(GetEffectSpellId(eLoop) == SPELL_FOCUSEDATTACK_1 ||
           GetEffectSpellId(eLoop) == SPELL_FOCUSEDATTACK_2 ||
           GetEffectSpellId(eLoop) == SPELL_FOCUSEDATTACK_3 ||
           GetEffectSpellId(eLoop) == SPELL_FOCUSEDATTACK_4 ||
           GetEffectSpellId(eLoop) == SPELL_FOCUSEDATTACK_5 ||
           GetEffectSpellId(eLoop) == SPELL_IMP_FOCUSEDATTACK_1 ||
           GetEffectSpellId(eLoop) == SPELL_IMP_FOCUSEDATTACK_2 ||
           GetEffectSpellId(eLoop) == SPELL_IMP_FOCUSEDATTACK_3 ||
           GetEffectSpellId(eLoop) == SPELL_IMP_FOCUSEDATTACK_4 ||
           GetEffectSpellId(eLoop) == SPELL_IMP_FOCUSEDATTACK_5) {
               Std_RemoveEffect(oTarget, eLoop);
         }

         eLoop = GetNextEffect(oTarget);
    }

    FloatingTextStringOnCreature("*Focused Attack Deactivated*", oTarget, FALSE);
}

// Defensive Stance specific functions
int DefensiveStanceActive(object oTarget) {
    effect eLoop = GetFirstEffect(oTarget);

    while(GetIsEffectValid(eLoop)) {
        if(GetEffectSpellId(eLoop) == SPELL_DEFENSIVE_STANCE)
            return 1;

        eLoop = GetNextEffect(oTarget);
    }

    return 0;
}

void ActivateDefensiveStanceEffect(object oTarget) {
    FloatingTextStringOnCreature("*Defensive Stance Activated*", oTarget, FALSE);

    effect eStrMod = EffectAbilityIncrease(ABILITY_STRENGTH, 2);
    effect eConMod = EffectAbilityIncrease(ABILITY_CONSTITUTION, 4);
    effect eSaveBonus = EffectSavingThrowIncrease(SAVING_THROW_ALL, 2);
    effect eDodgeBonus = EffectACIncrease(4);
    effect eLink = EffectLinkEffects(eStrMod, eConMod);
    eLink = EffectLinkEffects(eLink, eSaveBonus);
    eLink = EffectLinkEffects(eLink, eDodgeBonus);
    eLink = SupernaturalEffect(eLink);

    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget);
}

void RemoveDefensiveStanceEffect(object oTarget) {
    effect eLoop = GetFirstEffect(oTarget);

    while(GetIsEffectValid(eLoop)) {
        if(GetEffectSpellId(eLoop) == SPELL_DEFENSIVE_STANCE)
            Std_RemoveEffect(oTarget, eLoop);

        eLoop = GetNextEffect(oTarget);
    }

    FloatingTextStringOnCreature("*Defensive Stance Deactivated*", oTarget, FALSE);
}

// Deactivate modal feats if they are active
void DoDeactivateModalFeats(object oTarget) {
    if(GetLocalInt(oTarget,"ave_retainmodalfeats")!=1)
    {
        if(PowerAttackActive(oTarget))   RemovePowerAttackEffect(oTarget);
        if(ExpertiseActive(oTarget))     RemoveExpertiseEffect(oTarget);
        if(FocusedAttackActive(oTarget)) RemoveFocusedAttackEffect(oTarget);
    }
}
