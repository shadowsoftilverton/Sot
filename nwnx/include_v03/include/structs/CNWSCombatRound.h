#ifndef _NX_NWN_STRUCT_CNWSCOMBATROUND_
#define _NX_NWN_STRUCT_CNWSCOMBATROUND_
 
struct CNWSCombatRound_s
{
    CNWSCombatAttackData AttackData[50]; /* 0x0000 - 0x20CC*/
    uint16_t *SpecialAttack;
    int32_t SpecAttackList;
    uint8_t field_9;
    uint8_t field_10;
    uint8_t field_11;
    uint8_t field_12;
    uint16_t *SpecialAttackId;
    int32_t SpecAttackIdList;
    uint8_t field_21;
    uint8_t field_22;
    uint8_t field_23;
    uint8_t field_24;
    int16_t AttackID[2];
    uint8_t RoundStarted;             /* 0x20EC */
    uint8_t field_30;
    uint8_t field_31;
    uint8_t field_32;
    uint8_t SpellCastRound;           /* 0x20f0 */
    uint8_t field_34;
    uint8_t field_35;
    uint8_t field_36;
    uint32_t Timer;
    uint32_t RoundLength;
    uint32_t OverlapAmount;
    uint32_t BleedTimer;               /* 0x2100 */
    uint8_t RoundPaused;
    uint8_t field_54;
    uint8_t field_55;
    uint8_t field_56;
    uint32_t RoundPausedBy;
    uint32_t PauseTimer;
    uint8_t InfinitePause;
    uint8_t field_66;
    uint8_t field_67;
    uint8_t field_68;
    uint8_t CurrentAttack;             /* 0x2114 */
    uint8_t AttackGroup;
    uint8_t field_71;
    uint8_t field_72;
    uint8_t DeflectArrow;              /* 0x2118 */
    uint8_t field_74;
    uint8_t field_75;
    uint8_t field_76;
    uint8_t WeaponSucks;               /* 0x211c */
    uint8_t field_78;
    uint8_t field_79;
    uint8_t field_80;
    uint8_t EpicDodgeUsed;             /* 0x2120 */
    uint8_t field_82;
    uint8_t field_83;
    uint8_t field_84;
    uint32_t ParryIndex;               /* 0x2124 */
    uint32_t NumAOOs;                  /* 0x2128 */
    uint32_t NumCleaves;               /* 0x212C */
    uint32_t NumCircleKicks;           /* 0x2130 */
    uint32_t NewAttackTarget;
    uint32_t OnHandAttacks;            /* 0x2138 */
    uint32_t OffHandAttacks;           /* 0x213C */
    uint32_t OffHandTaken;             /* 0x2140 */
    uint32_t ExtraTaken;               /* 0x2144 */
    uint32_t AdditAttacks;             /* 0x2148 */
    uint32_t EffectAttacks;            /* 0x214C */
    uint8_t ParryActions;              /* 0x2150 */
    uint8_t field_130;                 /* 0x2151 */
    uint8_t field_131;                 /* 0x2152 */
    uint8_t field_132;                 /* 0x2153 */
    uint32_t DodgeTarget;              /* 0x2154 */ 
    uint32_t **SchedActionList;        /* 0x2158 */
    CNWSCreature *org_nwcreature;      /* 0x215C */
};

#endif
