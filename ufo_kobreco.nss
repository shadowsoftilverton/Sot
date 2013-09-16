#include "engine"

void main()
{
    object oAttack = GetLastAttacker();
    int nAC = GetAC(oAttack);
    int nRoll = d10();
    int nRecoil;
    effect eDamage = EffectDamage(nRoll, DAMAGE_TYPE_PIERCING, DAMAGE_POWER_NORMAL);

    if(nAC <= 14)
    {
        nRecoil = 2;
    }

    if(nAC >= 15 || nAC <= 18)
    {
        nRecoil = 4;
    }

    if(nAC >= 19 || nAC <= 22)
    {
        nRecoil = 6;
    }

    if(nAC >= 23 || nAC <= 26)
    {
        nRecoil = 8;
    }

    if(nAC >= 27)
    {
        nRecoil = 10;
    }

    if(nRoll >= nRecoil)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oAttack);
    }
}
