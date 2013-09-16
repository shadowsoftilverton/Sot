///////////////////////////////////
//Made by: Charles Adams
//xezol@xezol.com
//////////////////////////////////

//Clears a series of local integers from 1 to iMax from object oObject
//sPre and sSuf are text strings that go before and after the int in the intname
void ClearSeries(int iMax,string sPre,string sSuf,object oObject)
{
    int iCount=1;
    while(iCount<iMax+1)
    {
        DeleteLocalInt(oObject,sPre+IntToString(iCount)+sSuf);
        iCount=iCount+1;
    }
}

void main()
{
int ixRed = GetLocalInt(OBJECT_SELF,"iRed");
ixRed = 0;
SetLocalInt(OBJECT_SELF,"iRed", ixRed);

int ixBlack = GetLocalInt(OBJECT_SELF,"iBlack");
ixBlack = 0;
SetLocalInt(OBJECT_SELF,"iBlack", ixBlack);

int ixHigh = GetLocalInt(OBJECT_SELF,"iHigh");
ixHigh = 0;
SetLocalInt(OBJECT_SELF,"iHigh", ixHigh);

int ixLow = GetLocalInt(OBJECT_SELF,"iLow");
ixLow = 0;
SetLocalInt(OBJECT_SELF,"iLow", ixLow);

int ixEven = GetLocalInt(OBJECT_SELF,"iEven");
ixEven = 0;
SetLocalInt(OBJECT_SELF,"iEven", ixEven);

int ixOdd = GetLocalInt(OBJECT_SELF,"iOdd");
ixOdd = 0;
SetLocalInt(OBJECT_SELF,"iOdd", ixOdd);

ClearSeries(3,"iDoz","",OBJECT_SELF);
ClearSeries(3,"iCol","",OBJECT_SELF);
ClearSeries(36,"i","su",OBJECT_SELF);
ClearSeries(11,"iLine","",OBJECT_SELF);
ClearSeries(12,"iStreet","",OBJECT_SELF);
}
