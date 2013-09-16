//::///////////////////////////////////////////////
//:: User Defined OnHitCastSpell code
//:: x2_s3_onhitcast
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This file can hold your module specific
    OnHitCastSpell definitions

    How to use:
    - Add the Item Property OnHitCastSpell: UniquePower (OnHit)
    - Add code to this spellscript (see below)

   WARNING!
   This item property can be a major performance hog when used
   extensively in a multi player module. Especially in higher
   levels, with each player having multiple attacks, having numerous
   of OnHitCastSpell items in your module this can be a problem.

   It is always a good idea to keep any code in this script as
   optimized as possible.


*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-07-22
//:://////////////////////////////////////////////

#include "x2_inc_switches"
#include "ave_ragehit"
#include "ave_impro_hit"
#include "ave_inc_rogue"
#include "ave_inc_combat"
#include "inc_modalfeats"

void main()
{

   object oItem;        // The item casting triggering this spellscript
   object oSpellTarget; // On a weapon: The one being hit. On an armor: The one hitting the armor
   object oSpellOrigin; // On a weapon: The one wielding the weapon. On an armor: The one wearing an armor

   // fill the variables
   oSpellOrigin = OBJECT_SELF;
   oSpellTarget = GetSpellTargetObject();
   oItem        =  GetSpellCastItem();

   if (GetIsObjectValid(oItem))
   //SendMessageToPC(oSpellOrigin,"Debug: You have triggered an onhit event");
   {
    if(GetHasFeat(1539)||GetHasFeat(1538)||GetHasFeat(1541))
    {//Precise shot, greater precise shot, dirty fighting
        //SendMessageToPC(oSpellOrigin,"Debug: You have triggered a rear attack feat");
        DoRearAttackFeats(oSpellOrigin,oSpellTarget);
    }
    if(GetHasFeat(1540))//Shot on the run
    {
        //SendMessageToPC(oSpellOrigin,"Debug: You have triggered shot on the run");
        DoShotOnRun(oSpellOrigin,oSpellTarget);
    }
    if(GetHasFeatEffect(FEAT_BARBARIAN_RAGE,oSpellOrigin))
    {
        if(GetBaseItemType(oItem)!=BASE_ITEM_ARMOR)
        {
            vOnHitRageAttackPowers(oSpellTarget,oSpellOrigin);
        }
        else
        {
            vOnHitRageDefensePowers(oSpellTarget,oSpellOrigin);
        }
    }

    if(GetHasFeatEffect(1377,oSpellOrigin)|GetHasFeatEffect(1378,oSpellOrigin))
    {
        ave_impro_feathit(oSpellTarget,oSpellOrigin);
    }
    if(GetHasFeatEffect(SNIPERS_EYE,oSpellOrigin))
    {
        SnipeHit(oSpellTarget,oSpellOrigin);
    }

    int iMany=ManyShotActive(oSpellOrigin,0);
    if(iMany>0)
    {
        int iExtra=iMany-1129;
        int iDam;
        effect eDam;
        int iNumDice=1;
        while(iExtra>0)
        {
            iExtra=iExtra-1;
            if(GetHasFeat(1543,oSpellOrigin))//Greater ManyShot
            iNumDice=2;
            if(GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oSpellOrigin))==BASE_ITEM_SHURIKEN)
            iDam=d8(iNumDice);
            else if(GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oSpellOrigin))==BASE_ITEM_SMALLSHIELD)
            iDam=d8(iNumDice);
            else if(GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oSpellOrigin))==BASE_ITEM_LARGESHIELD)
            iDam=0;
            else if(GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oSpellOrigin))==BASE_ITEM_TOWERSHIELD)
            iDam=0;
            else iDam=d10(iNumDice);
            eDam=EffectDamage(iDam,GetWeaponDamageType(oItem),GetWeaponEnhance(oItem));
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oSpellTarget);
            SendMessageToPC(oSpellOrigin,"arrows remaining: "+IntToString(iExtra));
        }
        return;
    }

    if(WhirlwindAttackActive(oSpellOrigin))
    {
        DoWhirlDamage(oSpellTarget,oSpellOrigin);
        return;
    }
     // * Generic Item Script Execution Code
     // * If MODULE_SWITCH_EXECUTE_TAGBASED_SCRIPTS is set to TRUE on the module,
     // * it will execute a script that has the same name as the item's tag
     // * inside this script you can manage scripts for all events by checking against
     // * GetUserDefinedItemEventNumber(). See x2_it_example.nss
     if (GetModuleSwitchValue(MODULE_SWITCH_ENABLE_TAGBASED_SCRIPTS) == TRUE)
     {
        SetUserDefinedItemEventNumber(X2_ITEM_EVENT_ONHITCAST);
        int nRet =   ExecuteScriptAndReturnInt(GetUserDefinedItemEventScriptName(oItem),OBJECT_SELF);
        if (nRet == X2_EXECUTE_SCRIPT_END)
        {
           return;
        }
     }
   }
}
