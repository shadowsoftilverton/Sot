//Constants for Power Attack
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

//Constants for Expertise
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

//Power Attack Specific Functions
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

//Expertise specific functions
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
