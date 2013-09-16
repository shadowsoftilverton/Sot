#include "engine"

void main()
{
    string sTrig = GetTag(OBJECT_SELF);
    string sNumb = GetStringRight(sTrig, 3);
    string sDoor = "ufo_grvd" + sNumb;
    object oDoor = GetObjectByTag(sNumb);

    if(oDoor == OBJECT_INVALID)
    {
        string sWP = "PLC_UFO_GROVE" + sNumb;
        object oWP = GetObjectByTag(sWP);
        location lWP = GetLocation(oWP);

        string sSpark = "ufo_grvs" + sNumb;

        CreateObject(OBJECT_TYPE_PLACEABLE, "plc_magiccyan", lWP, FALSE, sSpark);
        CreateObject(OBJECT_TYPE_PLACEABLE, sDoor, lWP, FALSE);
    }
}
