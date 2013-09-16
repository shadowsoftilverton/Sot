#include "ave_wep_util"
#include "engine"
#include "nw_i0_spells"

const float fFrame=0.05;

//Deploys the weapon held in oItem and also sets oPC's affinity to that weapon. If weapon is already deployed, removes weapon
void DeployWeapon(object oPC,object oItem)
{
    string sType=GetLocalString(oItem,"weptype");
    SendMessageToPC(oPC,"Debug: Catapult Deployed!");
    object oCreated=CreateObject(OBJECT_TYPE_PLACEABLE,sType,GetItemActivatedTargetLocation(),TRUE);
    DelayCommand(1.0,SetLocalObject(oItem,"ave_wep_child",oCreated));
    DelayCommand(1.0,SetLocalObject(oCreated,"ave_wep_user",oPC));
    DelayCommand(1.0,SetLocalObject(oPC,"ave_wep_my",oCreated));
    DelayCommand(1.0,SetLocalFloat(oCreated,"launchvelocity",GetLocalFloat(oItem,"launchvelocity")));
}

/*
void ApplyDamageToShip(object oShip, int nDamage, int iDamageType,int iKillVfx)
{
    int iRudderWeight;
    int iHullWeight;
    int iCrewWeight;
    int iOarWeight;
    int iSailWeight;
    int iKeelWeight;
    if(iDamageType==DAMAGE_TYPE_FIRE)
    {
        iCrewWeight=10;
        iSailWeight=10;
        iHullWeight=10;
        iOarWeight=4;
        iRudderWeight=2;
        iKeelWeight=2;
    }
    if(Random(4)==1)
    {
        //Damage the crew
    }
    else
    {
        int iStation=PickRandomStation(oShip);
        DoDamageToStation(oShip,iStation,nDamage,iKillVfx);
    }
}
*/

void WepHit(location lHit,int iSustainVFX,int iMaxDamageDice,float AreaSize,object oShooter,int bFriendly,int nDamageType,int nSaveType, string sAmmo,int nDC)
{
    effect eDam;
    object oVictim=GetFirstObjectInShape(SHAPE_SPHERE,AreaSize,lHit,FALSE,OBJECT_TYPE_CREATURE|OBJECT_TYPE_PLACEABLE|OBJECT_TYPE_DOOR);
    float fPercent;
    int iDamage;
    while(GetIsObjectValid(oVictim))
    {
        fPercent=(AreaSize-GetDistanceBetweenLocations(GetLocation(oVictim),lHit))/AreaSize;
        iDamage=FloatToInt(IntToFloat(d10(iMaxDamageDice))*fPercent);
        //if(GetIsBoat(oVictim))
        //{
            //ApplyDamageToShip(oVictim,iDamage,DAMAGE_TYPE_FIRE,iSustainVFX);
        //}
        //else
        //{
            //eDam=EffectDamage(iDamage,DAMAGE_TYPE_FIRE);
            iDamage=GetReflexAdjustedDamage(iDamage,oVictim,nDC,nSaveType,oShooter);
            SetLocalObject(oShooter,"ave_d_odam",oVictim);
            SetLocalInt(oShooter,"ave_d_ndam",iDamage);
            SetLocalInt(oShooter,"ave_d_tdam",nDamageType);
            if(sAmmo=="tox")
            {
                if(MySavingThrow(SAVING_THROW_WILL,oVictim,nDC,nSaveType))
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED),EffectConfused()),oVictim,RoundsToSeconds(d6(3)));
                if(MySavingThrow(SAVING_THROW_FORT,oVictim,nDC,nSaveType))
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE),EffectSlow()),oVictim,RoundsToSeconds(d6(3)));
            }
            else if(bFriendly==TRUE|GetIsReactionTypeHostile(oShooter,oVictim)) ExecuteScript("ave_wep_damwrap",oShooter);
            //ApplyEffectToObject(DURATION_TYPE_INSTANT,eDam,oVictim);
        //}
        oVictim=GetNextObjectInShape(SHAPE_SPHERE,AreaSize,lHit,FALSE,OBJECT_TYPE_CREATURE);
    }
}

void WeaponIteration(object oPC,float fZSpeed,float fYSpeed,float fXSpeed,string sAmmo, int iAmmoVFX,object oArea,vector vPos,float fFrame,int iHitVFX, float fLaunchHeight);

void WeaponIteration(object oPC,float fZSpeed,float fYSpeed,float fXSpeed,string sAmmo, int iAmmoVFX,object oArea,vector vPos,float fFrame,int iHitVFX, float fLaunchHeight)
{
    float fSkyHeight=1000000.0;//Failesafe against negative gravity - the projectile will eventually "hit the sky" so that its trajectory isn't calculated forever
    float fGravityStrength=GetGravity(oArea);
    float fZSpeedNew=fZSpeed-(fGravityStrength*fFrame);
    //SendMessageToPC(oPC,"Debug: your projectile is at "+FloatToString(vPos.x,18,0)+","+FloatToString(vPos.y,18,0)+","+FloatToString(vPos.z,18,0)+".");
    //SendMessageToPC(oPC,"Debug: your projectile speed is "+FloatToString(fXSpeed,18,0)+","+FloatToString(fYSpeed,18,0)+","+FloatToString(fZSpeedNew,18,0)+".");
    vector vNew=Vector(vPos.x+fXSpeed*fFrame,vPos.y+fYSpeed*fFrame,vPos.z+fZSpeed*fFrame);
    if(vNew.z<GetCollisionHeight(oArea,vNew)+0.1|vNew.z>fSkyHeight)
    {
        SendMessageToPC(oPC,"Your projectile hit!");
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(iHitVFX),Location(oArea,vNew,IntToFloat(Random(360))));
        int nDrop=FloatToInt(fLaunchHeight-vNew.z);
        int nDC=32+nDrop;//Higher ground gives higher DC
        if(sAmmo=="incin") WepHit(Location(oArea,vNew,IntToFloat(Random(360))),iAmmoVFX,20+nDrop,8.0,oPC,TRUE,DAMAGE_TYPE_FIRE,SAVING_THROW_TYPE_FIRE,sAmmo,nDC);
        else if(sAmmo=="shock") WepHit(Location(oArea,vNew,IntToFloat(Random(360))),iAmmoVFX,15+nDrop,8.0,oPC,FALSE,DAMAGE_TYPE_ELECTRICAL,SAVING_THROW_TYPE_ELECTRICITY,sAmmo,nDC);
        else if(sAmmo=="tox") WepHit(Location(oArea,vNew,IntToFloat(Random(360))),iAmmoVFX,0,8.0,oPC,FALSE,DAMAGE_TYPE_ACID,SAVING_THROW_TYPE_POISON,sAmmo,nDC);
    }
    else
    {
        DelayCommand(fFrame,WeaponIteration(oPC,fZSpeedNew,fYSpeed,fXSpeed,sAmmo,iAmmoVFX,oArea,vNew,fFrame,iHitVFX,fLaunchHeight));
        DelayCommand(fFrame,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(iAmmoVFX),Location(oArea,vNew,IntToFloat(Random(360)))));
    }
}

void FireWeapon(object oPC,object oWeapon,float fVelocity,string sAmmo,float fDirection,float fAngle,vector vLaunchVector)
{
    //float fFrame=0.05;//Time between weapon ticks
    object oArea=GetArea(oWeapon);
    vector vPos=GetPosition(oWeapon);
    vPos.z=vPos.z+GetWeaponHeightOffSet();//Projectile originates above ground height when fired from weapon
    float fGroundSpeed=cos(fAngle)*fVelocity;
    float fZSpeed=sin(fAngle)*fVelocity+vLaunchVector.z*fFrame/0.01;
    float fXSpeed=fGroundSpeed*cos(fDirection)+vLaunchVector.x*fFrame/0.01;
    float fYSpeed=fGroundSpeed*sin(fDirection)+vLaunchVector.y*fFrame/0.01;
    int VFXfly;
    int VFXhit;
    if(sAmmo=="tox")
    {
        VFXfly=VFX_FNF_GAS_EXPLOSION_ACID;
        VFXhit=VFX_FNF_NATURES_BALANCE;
    }
    else
    {
        if(sAmmo=="cryo")
        {
            VFXfly=VFX_COM_HIT_FROST;
            VFXhit=VFX_FNF_MYSTICAL_EXPLOSION;
        }
        else
        {
            if(sAmmo=="shock")
            {
                VFXfly=VFX_FNF_GAS_EXPLOSION_MIND;
                VFXhit=VFX_FNF_DISPEL_GREATER;
            }
            else
            {
                VFXfly=VFX_FNF_GAS_EXPLOSION_FIRE;
                VFXhit=VFX_FNF_FIREBALL;
            }
        }
    }
    DelayCommand(fFrame,WeaponIteration(oPC,fZSpeed,fYSpeed,fXSpeed,sAmmo,VFXfly,oArea,vPos,fFrame,VFXhit,vPos.z+GetWeaponHeightOffSet()));
}

void SetWeaponInt(object oWeapon, int nStation, string sName, int iValue)
{
    if(nStation!=-1)//Means we are on a platform
    {
        SetStationProperty(nStation,oWeapon,sName,iValue);
    }
    else
    {
        SetLocalInt(oWeapon,sName,iValue);
    }
}

int GetWeaponInt(object oWeapon, int nStation, string sName)
{
    int iReturn;
    if(nStation!=-1)//Means we are on a platform
    {
        iReturn=GetStationProperty(nStation,oWeapon,sName);
    }
    else
    {
        iReturn=GetLocalInt(oWeapon,sName);
    }
    return iReturn;
}

int bGetIsWeaponBusy(object oWeapon,object oPC)
{
    //if(GetLocalInt(oWeapon,"wep_rotating")==TRUE)
    //{
    //    SendMessageToPC(oPC,"Weapon is busy. Currently at "+IntToString(FloatToInt(GetFacingX(oWeapon)))+" and rotating toward "+IntToString(GetLocalInt(oWeapon,"wep_rot_seek")));
    //    return TRUE;
    //}
    //if(GetLocalInt(oWeapon,"wep_angling")==TRUE)
    //{
    //    SendMessageToPC(oPC,"Weapon is busy. Currently at "+IntToString(GetLocalInt(oWeapon,"wep_angle_true"))+" and arcing toward "+IntToString(GetLocalInt(oWeapon,"wep_angle_seek")));
    //    return TRUE;
    //}
    //if(GetLocalInt(oWeapon,"wep_angling")==TRUE)
    //{
    //    SendMessageToPC(oPC,"Weapon is busy. Currently reloading ammo");
    //    return TRUE;
    //}
    return FALSE;
}

int WepChat(object oPC,object oPlatform,object oWeapon,int nStation,string sMessage,int nCharOffset)
{
    if(GetDistanceBetween(oPC,oWeapon)>5.0|GetArea(oPC)!=GetArea(oWeapon))
    {
        SendMessageToPC(oPC,"You are too far away to use this weapon. Try moving closer first.");
        return 0;
    }
    string sSecondaryCommand=GetSubString(sMessage,4+nCharOffset,4);
    //SendMessageToPC(oPC,"Debug: entered conditional - secondary command is "+sSecondaryCommand);
    if(sSecondaryCommand=="?")
    {
        SendMessageToPC(oPC,"'/wep ?' - help");
        SendMessageToPC(oPC,"'/wep rot 60' - set weapon rotation to 60 degrees (with respect to due East)");
        SendMessageToPC(oPC,"'/wep arc -5' - set weapon arc to 5 degrees (down from vertical)");
        SendMessageToPC(oPC,"'/wep rot 270' - set weapon rotation to 270 degrees (with respect to due East)");
        SendMessageToPC(oPC,"'/wep arc 60' - set weapon arc to 60 degrees (up from vertical)");
        SendMessageToPC(oPC,"'/wep load incin' - reload weapon with incindiary ammo");
        SendMessageToPC(oPC,"'/wep load shock' - reload weapon with shock ammo (less damage, but no friendly fire)");
        SendMessageToPC(oPC,"'/wep load tox' - reload weapon with toxic ammo (saving throw vs. confusion and slow)");
        SendMessageToPC(oPC,"'/wep fire' - fire weapon");
    }
    if(GetIsObjectValid(oWeapon)==FALSE)
    {
        SendMessageToPC(oPC,"You do not have a valid ballistic weapon deployed.");
    }
    if((GetDistanceBetween(oWeapon,oPC)>5.0&nStation==-1)|GetArea(oPC)!=GetArea(oWeapon))
    {
        SendMessageToPC(oPC,"You are not close enough to your ballistic weapon. Try getting closer before you use it.");
        return FALSE;
    }
    if(sSecondaryCommand=="aim ")
    {
        string sTarget=GetSubString(sMessage,8+nCharOffset,GetStringLength(sMessage)-(8+nCharOffset));
        object oTarget=GetObjectByTag(sTarget);
        if(oTarget==OBJECT_INVALID|GetArea(oTarget)!=GetArea(oWeapon))
        {
            SendMessageToPC(oPC,"Target not found.");
            return FALSE;
        }
        else
        {
            vector vWep=GetPosition(oWeapon);
            vector vTarget=GetPosition(oTarget);
            float fVelocity=IntToFloat(GetWeaponInt(oWeapon,nStation,"launchvelocity"));
            object oArea=GetArea(oWeapon);
            float fAngleNeeded=VectorToAngle(vTarget-vWep);
            if(bGetIsAngleBetween(IntToFloat(GetMinAngle(oWeapon,nStation,oPlatform)),IntToFloat(GetMaxAngle(oWeapon,nStation,oPlatform)),fAngleNeeded-GetFacing(oPlatform)))
            //if(FloatToInt(fAngleNeeded-GetFacing(oPlatform))<GetMaxAngle(oWeapon,nStation,oPlatform)&FloatToInt(fAngleNeeded-GetFacing(oPlatform))>GetMinAngle(oWeapon,nStation,oPlatform))
            {
                SendMessageToPC(oPC,"The target is outside of the firing arc of your weapon. Wait until the weapon is facing the target, or choose another target.");
                //SendMessageToDevelopers("Attempted aiming of a weapon against a target not in firing arc.");
            }
            float fArcNeeded=ArcCalc(vWep,vTarget,oArea,fVelocity,FALSE);//Boolean should be true for some weapons and false for others.
            if(fArcNeeded==0.0)
            {
                SendMessageToPC(oPC,"No valid trajectory to target could be found. The target is probably out of range, or you are trying to aim at yourself.");
                return FALSE;
            }
            SetWeaponInt(oWeapon,nStation,"wep_rotate",FloatToInt(fAngleNeeded-GetFacing(oPlatform)));
            SendMessageToPC(oPC,"Setting weapon rotation to "+IntToString(FloatToInt(fAngleNeeded)));
            SetWeaponInt(oWeapon,nStation,"wep_arc",FloatToInt(fArcNeeded));
            SendMessageToPC(oPC,"Setting weapon arc to "+IntToString(FloatToInt(fArcNeeded)));
        }
    }
    if(sSecondaryCommand=="rot ")
    {
        string sRotDegree=GetSubString(sMessage,8+nCharOffset,3);
        int iRot=StringToInt(sRotDegree);
        if(iRot<0|iRot>359)
        {
            SendMessageToPC(oPC,"Invalid rotation. You must aim between 0 and 359 degrees.");
        }
        int iMaxAngle=GetMaxAngle(oWeapon,nStation,oPlatform);
        int iMinAngle=GetMinAngle(oWeapon,nStation,oPlatform);
        if(!iMaxAngle-iMinAngle>360)
        {//This might work. Untested. Has to be weird because degrees loop at 360.
            if(iMaxAngle>360) iMaxAngle=iMaxAngle-360;
            if(iMinAngle<0) iMinAngle=iMinAngle+360;
            if(iMinAngle>iMaxAngle)
            {
                if(iRot>GetMaxAngle(oWeapon,nStation,oPlatform)&iRot<GetMinAngle(oWeapon,nStation,oPlatform))
                SendMessageToPC(oPC,"That angle is outside the firing arcs of this weapon. Choose a value between "+IntToString(GetMinAngle(oWeapon,nStation,oPlatform))+" and "+IntToString(GetMaxAngle(oWeapon,nStation,oPlatform)));
            }
            else if(iRot>GetMaxAngle(oWeapon,nStation,oPlatform)|iRot<GetMinAngle(oWeapon,nStation,oPlatform))
            {
                SendMessageToPC(oPC,"That angle is outside the firing arcs of this weapon. Choose a value between "+IntToString(GetMinAngle(oWeapon,nStation,oPlatform))+" and "+IntToString(GetMaxAngle(oWeapon,nStation,oPlatform)));
            }
        }
        if(bGetIsWeaponBusy(oWeapon,oPC)==FALSE)
        {
            SendMessageToPC(oPC,"Setting weapon rotation to "+IntToString(iRot));
            SetWeaponInt(oWeapon,nStation,"wep_rotate",iRot);
            if(oPlatform==OBJECT_INVALID)
            {
                ExecuteScript("ave_obj_face",oWeapon);
            }
        }
    }
    if(sSecondaryCommand=="arc ")
    {
        string sAngDegree=GetSubString(sMessage,8+nCharOffset,3);
        int iAng=StringToInt(sAngDegree);
        if(iAng>89|iAng<-44)
        {
            SendMessageToPC(oPC,"Invalid arc. You must aim between -44 and 89 degrees.");
        }
        else if(bGetIsWeaponBusy(oWeapon,oPC)==FALSE)
        {
            SendMessageToPC(oPC,"Setting weapon arc to "+IntToString(iAng));
            SetWeaponInt(oWeapon,nStation,"wep_arc",iAng);
        }
    }
    if(sSecondaryCommand=="load")
    {
        if(GetWeaponInt(oWeapon,nStation,"wep_loaded")>0) SendMessageToPC(oPC,"This weapon is already loaded.");
        else //if(bGetIsWeaponBusy(oWeapon,oPC)==FALSE)
        {
            string sAmmoType=GetSubString(sMessage,9+nCharOffset,5);
            if(sAmmoType=="") sAmmoType="default";
            float fLoadTime=5.0;
            SendMessageToPC(oPC,"Loading weapon. This takes "+FloatToString(fLoadTime,2,0)+" seconds.");
            SetWeaponInt(oWeapon,nStation,"wep_loading",1);
            DelayCommand(fLoadTime,SetWeaponInt(oWeapon,nStation,"wep_loading",0));
            if(sAmmoType=="tox")
            DelayCommand(fLoadTime,SetWeaponInt(oWeapon,nStation,"wep_loaded",3));
            if(sAmmoType=="shock")
            DelayCommand(fLoadTime,SetWeaponInt(oWeapon,nStation,"wep_loaded",2));
            else
            DelayCommand(fLoadTime,SetWeaponInt(oWeapon,nStation,"wep_loaded",1));
            DelayCommand(fLoadTime,SendMessageToPC(oPC,"Weapon loaded."));
            //DelayCommand(fLoadTime,SendMessageToDevelopers("Weapon loaded."));
            if(nStation==-1) AssignCommand(oWeapon,PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE,0.12));
            //SendMessageToDevelopers("Debug: Someone loaded a weapon.");
        }
    }
    if(sSecondaryCommand=="fire")
    {
        //if(bGetIsWeaponBusy(oWeapon,oPC)==FALSE)
        //{
            if(GetWeaponInt(oWeapon,nStation,"wep_loaded")==0)
            {
                SendMessageToPC(oPC,"Load the weapon first.");
                //SendMessageToDevelopers("Debug: Someone attempted to fire a weapon without loading it first.");
                return FALSE;
            }
            else
            {
                if(GetWeaponInt(oWeapon,nStation,"launchvelocity")<1) SetWeaponInt(oWeapon,nStation,"launchvelocity",25);//Failsafe
                if(nStation==-1) AssignCommand(oWeapon,PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
                string sAmmoShoot;
                if(GetWeaponInt(oWeapon,nStation,"wep_loaded")==3) sAmmoShoot="tox";
                else if(GetWeaponInt(oWeapon,nStation,"wep_loaded")==2) sAmmoShoot="shock";
                else if(GetWeaponInt(oWeapon,nStation,"wep_loaded")==1) sAmmoShoot="incin";
                FireWeapon(oPC,oWeapon,IntToFloat(GetWeaponInt(oWeapon,nStation,"launchvelocity")),sAmmoShoot,IntToFloat(GetWeaponInt(oWeapon,nStation,"wep_rotate"))+GetFacing(oPlatform),IntToFloat(GetWeaponInt(oWeapon,nStation,"wep_arc")),GetLocalVector(oPlatform,"hull_motion"));//Right now set to always be cryo
                SetWeaponInt(oWeapon,nStation,"wep_loaded",0);
                SendMessageToPC(oPC,"FIRING WEAPON! Using "+sAmmoShoot+".");
                //SendMessageToDevelopers("FIRING WEAPON!");
            }
        //}
    }
    return TRUE;
}
