#include "ave_inc_combat"
#include "ave_inc_duration"
#include "inc_equipment"
#include "inc_modalfeats"

//Returns 1 if oAtt has valid ammo for his equipped range weapon
int AmmoCheck(object oAtt)
{
    int iType=GetBaseItemType(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oAtt));
    int iAmmoSlot=GetAmmoSlotFromRangedWeaponType(iType);
    object oAmmo=GetItemInSlot(iAmmoSlot,oAtt);
    if(GetIsObjectValid(oAmmo))
    {
        if(GetItemStackSize(oAmmo)>1)
        {
            SetItemStackSize(oAmmo,GetItemStackSize(oAmmo)-1);
        }
        else
        {
            DestroyObject(oAmmo);
        }
        return 1;
    }
    else
    {
        return 0;
    }
}

void main()
{
    if(ManyShotActive(OBJECT_SELF,1)==0) ActivateManyShotAttack(OBJECT_SELF);
    else RemoveManyShotEffect(OBJECT_SELF);
}

void OldManyShotNoLongerUsed()
{
    object oShooter=OBJECT_SELF;
    object oWep=GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oShooter);
    if(!GetIsBow(oWep))
    {
        SendMessageToPC(oShooter,"This ability only works with bows.");
        return;
    }
    int iExtra=GetSpellId()-1129;
    //SendMessageToPC(oShooter,"Debug: You selected "+IntToString(iExtra)+ " additional arrows using spellId "+IntToString(GetSpellId()));
    object oHit=GetSpellTargetObject();
    DoGeneralOnCast(oShooter);
    /* Play random battle cry */
    int nSwitch = d10();
    switch (nSwitch)
    {
        case 1: PlayVoiceChat(VOICE_CHAT_BATTLECRY1); break;
        case 2: PlayVoiceChat(VOICE_CHAT_BATTLECRY2); break;
        case 3: PlayVoiceChat(VOICE_CHAT_BATTLECRY3); break;
    }
    int iAB=GetBaseAttackBonus(oShooter);
    int iGreat=GetHasFeat(1543,oShooter);//Greater ManyShot
    int nBasePen=iExtra+1;
    int nCumPen=0;
    float fDelay=0.5;
    int iHit;
    int iThisPen;
    effect eHit=EffectVisualEffect(357,FALSE);//Normal arrow impact
    effect eMiss=EffectVisualEffect(367,TRUE);//Miss arrow impact
    while(iAB>nCumPen)
    {
        if(AmmoCheck(oShooter)==0)
        {
            SendMessageToPC(oShooter,"No ammo!");
            return;
        }
        fDelay=fDelay+0.1;
        iThisPen=-1*(nBasePen+nCumPen);
        if(iGreat) iThisPen=iThisPen/2;
        //SendMessageToPC(oShooter,"Debug: This penalty is "+IntToString(iThisPen));
        iHit=DoScriptedAttack(oShooter,oHit,iThisPen,FALSE,TRUE,TRUE,FALSE);
        if(iHit>0)
        {
            DelayCommand(fDelay,DoScriptedDamage(oShooter,oHit,iHit,FALSE));
            DelayCommand(fDelay-0.5,ApplyEffectToObject(DURATION_TYPE_INSTANT,eHit,oHit));
        }
        else DelayCommand(fDelay-0.5,ApplyEffectToObject(DURATION_TYPE_INSTANT,eMiss,oHit));
        nCumPen=nCumPen+5;
    }
    nCumPen=0;

    while(iExtra>0)
    {
        if(AmmoCheck(oShooter)==0)
        {
            SendMessageToPC(oShooter,"No ammo!");
            return;
        }
        fDelay=fDelay+0.1;
        iThisPen=-1*(nBasePen+nCumPen);
        if(iGreat) iThisPen=iThisPen/2;
        //SendMessageToPC(oShooter,"Debug: This penalty is "+IntToString(iThisPen));
        iHit=DoScriptedAttack(oShooter,oHit,iThisPen,FALSE,TRUE,TRUE,FALSE);
        if(iHit>0)
        {
            DelayCommand(fDelay,DoScriptedDamage(oShooter,oHit,iHit,FALSE));
            DelayCommand(fDelay-0.5,ApplyEffectToObject(DURATION_TYPE_INSTANT,eHit,oHit));
        }
        else DelayCommand(fDelay-0.5,ApplyEffectToObject(DURATION_TYPE_INSTANT,eMiss,oHit));
        nCumPen=nCumPen+5;
        iExtra=iExtra-1;
    }
}
