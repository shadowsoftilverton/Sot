#ifndef _NX_NWN_STRUCT_CNWSCOMBATATTACKDATA_
#define _NX_NWN_STRUCT_CNWSCOMBATATTACKDATA_

struct CNWSCombatAttackData_s {
    uint8_t AttackGroup;              /* 0000 */
    uint8_t field_01;                 /* 0001 */
    uint16_t AnimationLength;         /* 0002 */
    uint32_t ReactObject;             /* 0004 */
    uint16_t ReaxnDelay;              /* 0008 */
    uint16_t ReaxnAnimation;          /* 000A */
    uint16_t ReaxnAnimLength;         /* 000C */
    uint8_t ToHitRoll;                /* 000E */
    uint8_t ThreatRoll;               /* 000F */
    uint32_t ToHitMod;                /* 0010 */
    uint8_t MissedBy;                 /* 0014 */
    uint8_t field_15;                 /* 0015 */
    uint16_t Damage_Bludgeoning;      /* 0016 */
    uint16_t Damage_Piercing;         /* 0018 */
    uint16_t Damage_Slashing;         /* 001A */
    uint16_t Damage_Magical;          /* 001C */
    uint16_t Damage_Acid;             /* 001E */
    uint16_t Damage_cold;             /* 0020 */
    uint16_t Damage_Divine;           /* 0022 */
    uint16_t Damage_Electrical;       /* 0024 */
    uint16_t Damage_Fire;             /* 0026 */
    uint16_t Damage_Negative;         /* 0028 */
    uint16_t Damage_Positive;         /* 002A */
    uint16_t Damage_Sonic;            /* 002C */
    uint16_t BaseDamage;              /* 002E */
    uint8_t WeaponAttackType;         /* 0030 */
    uint8_t AttackMode;               /* 0031 */
    uint8_t Concealment;              /* 0032 */
    uint8_t field_33;                 /* 0033 */
    uint32_t RangedAttack;            /* 0034 */
    uint32_t SneakAttack;             /* 0038 */
    uint32_t field_3C;                /* 003C */
    uint32_t KillingBlow;             /* 0040 */
    uint32_t CoupDeGrace;             /* 0044 */
    uint32_t CriticalThreat;          /* 0048 */
    uint32_t AttackDeflected;         /* 004C */
    uint8_t AttackResult;             /* 0050 */
    uint8_t field_51;                 /* 0051 */
    uint16_t AttackType;              /* 0052 */
    uint16_t field_54;                /* 0054 */
    uint16_t field_56;                /* 0056 */
    float RangedTargetX;              /* 0058 */
    float RangedTargetY;              /* 005C */
    float RangedTargetZ;              /* 0060 */
    uint32_t AmmoItem;                /* 0064 */
    CExoString AttackDebugText;
    CExoString DamageDebugText;
    uint32_t field_78;
    uint32_t field_7C_a12;
    uint32_t field_80;
    uint32_t field_84;
    uint32_t field_88_a12;
    uint32_t field_8C;
    uint32_t field_90;
    uint32_t field_94_a12;
    uint32_t field_98;
    uint32_t field_9C;
    uint32_t field_A0_a12;
    uint32_t field_A4;
};

#endif
