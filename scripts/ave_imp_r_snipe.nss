#include "ave_inc_rogue"
#include "x2_inc_itemprop"

void main()
{
    object oPC=OBJECT_SELF;
    float fDur;
    object oWeapon=GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
    if(IPGetIsRangedWeapon(oWeapon))
    {
        if(GetHasFeat(SNIPERS_EYE_3,oPC))
        {
            fDur=12.0;
        }
        else
        {
            fDur=6.0;
        }
    }
    else
    {
        SendMessageToPC(oPC,"This ability only functions while using a ranged weapon!");
        return;
    }

    itemproperty ipOnHit=ItemPropertyOnHitCastSpell(IP_CONST_ONHIT_CASTSPELL_ONHIT_UNIQUEPOWER,GetHitDice(oPC));
    IPSafeAddItemProperty(oWeapon,ipOnHit,fDur);

    if(GetHasFeat(SNIPERS_EYE_2,oPC)) GeneralCoolDown(SNIPERS_EYE,oPC,60.0);
    else GeneralCoolDown(SNIPERS_EYE,oPC,180.0);

    int nGender = GetGender(oPC);
    int nRace = GetAppearanceType(oPC);

    switch(nRace)
    {//-- this will make the races translate to proper advances on the fx constants.  trust me.
    case 0: nRace = 2; break;
    case 1: nRace = 4; break;
    case 2: nRace = 6; break;
    case 3: nRace = 8; break;
    case 4: nRace = 0; break;
    case 5: nRace = 10; break;
    default: nRace = 0; break;
    }
    effect eEyes1 = SupernaturalEffect(EffectVisualEffect(VFX_EYES_GREEN_HUMAN_MALE+nGender+nRace));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEyes1, oPC,fDur);

    effect eEyes2 = SupernaturalEffect(EffectVisualEffect(VFX_EYES_RED_FLAME_HUMAN_MALE+nGender+nRace));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEyes2, oPC,fDur);
}
