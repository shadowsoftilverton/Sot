#include "nwnx_funcs"

//returns TRUE if fCompare is between fMin and fMax
int bGetIsAngleBetween(float fMin,float fMax,float fCompare)
{
    while(fMin<-0.0) fMin=fMin+360.0;
    while(fMin>360.0) fMin=fMin-360.0;
    while(fMax<-0.0) fMax=fMax+360.0;
    while(fMax>360.0) fMax=fMax-360.0;
    if(fMax>fMin)
    {
        if(fCompare>fMin&fCompare<fMax) return TRUE;
        else return FALSE;
    }
    else
    {
        if(fCompare>fMin|fCompare<fMax) return TRUE;
    }
    return FALSE;
}

//int Get2DAInt(string s2da,string sColumn,int nRow)
//{
//    return StringToInt(Get2DAString(s2da,sColumn,nRow));
//}

int GetIsBoat(object oTest)
{
    //int iRow=1;
    //string sCheck=Get2DAString("shiphulls","BluePrint",iRow);
    //while(sCheck!="")
    //{
    //    if(GetResRef(oTest)==sCheck) return TRUE;
    //    iRow++;
    //    sCheck=Get2DAString("shiphulls","BluePrint",iRow);
    //}
    return FALSE;
}

float GetGravity(object oArea)
{
    return 9.8;
}

vector GetLocalVector(object oObject,string sVectorName)
{
    float fX=GetLocalFloat(oObject,sVectorName+"x");
    float fY=GetLocalFloat(oObject,sVectorName+"y");
    float fZ=GetLocalFloat(oObject,sVectorName+"z");
    return Vector(fX,fY,fZ);
}

void SetLocalVector(object oObject,string sVectorName, vector vNewValue)
{
    SetLocalFloat(oObject,sVectorName+"x",vNewValue.x);
    SetLocalFloat(oObject,sVectorName+"y",vNewValue.y);
    SetLocalFloat(oObject,sVectorName+"z",vNewValue.z);
}

float GetCollisionHeight(object oArea,vector vPos)//Placeholder for a wrapper to the windows port of GetGroundHeight nwnx function
{
    return GetGroundHeight(oArea,vPos);
}

void SetStationProperty(int iStation,object oShip,string sPropName,int iPropAmount)
{
    SetLocalInt(oShip,IntToString(iStation)+sPropName,iPropAmount);
}

int GetStationProperty(int iStation,object oShip,string sPropName)
{
    return GetLocalInt(oShip,IntToString(iStation)+sPropName);
}

float GetWeaponHeightOffSet()
{
    return 2.0;
}

float ArcCalc(vector vOrigin,vector vTarget,object oArea,float fLaunchVel, int bArc)
{
    float fYDist=vTarget.y-vOrigin.y;
    float fXDist=vTarget.x-vOrigin.x;
    float fDist=sqrt(fXDist*fXDist+fYDist*fYDist);
    vOrigin.z=vOrigin.z+GetWeaponHeightOffSet();
    vTarget.z=GetCollisionHeight(oArea,vTarget);
    float fHeight=vTarget.z-vOrigin.z;
    float fNumToRoot=(fLaunchVel*fLaunchVel*fLaunchVel*fLaunchVel)-GetGravity(oArea)*(GetGravity(oArea)*fDist*fDist+2*fHeight*fLaunchVel*fLaunchVel);
    if(fNumToRoot>0.0&fDist>0.0&GetGravity(oArea)>0.0)
    {
        float fRoot=sqrt(fNumToRoot);
        if(bArc==FALSE) fRoot=fRoot*-1;
        return atan((fLaunchVel*fLaunchVel+fRoot)/(GetGravity(oArea)*fDist));
    }
    return 0.0;
}

int GetMaxAngle(object oWeapon, int nStation, object oPlatform)
{
    int iAngle=GetStationProperty(nStation,oPlatform,"angle");
    int iRange=GetStationProperty(nStation,oPlatform,"SwivelRange")/2;
    //SendMessageToDevelopers("Min angle is "+IntToString(iAngle+iRange));
    return iAngle+iRange;
}

int GetMinAngle(object oWeapon, int nStation, object oPlatform)
{
    int iAngle=GetStationProperty(nStation,oPlatform,"angle");
    int iRange=GetStationProperty(nStation,oPlatform,"SwivelRange")/2;
    //SendMessageToDevelopers("Min angle is "+IntToString(iAngle-iRange));
    return iAngle-iRange;
}
