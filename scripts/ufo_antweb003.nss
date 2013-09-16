#include "engine"

void main()
{
    int nCount = 1;
    string sTrgTag = GetTag(OBJECT_SELF);
    string sTrgNum = GetStringRight(sTrgTag, 3); //This is the number of the encounter (001, 002, etc)
    string sWayTag = "ufo_plc_web" + sTrgNum;
    string sNewWeb = "ufo_ant_web" + sTrgNum;

    object oWeb = GetNearestObjectByTag(sNewWeb, OBJECT_SELF);

    while(nCount < 4)
    {
        DestroyObject(oWeb);
        nCount ++;
    }

    DeleteLocalInt(OBJECT_SELF, "IsFired");
}
