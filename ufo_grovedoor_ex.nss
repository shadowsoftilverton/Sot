#include "engine"

void main()
{
    string sTrig = GetTag(OBJECT_SELF);
    string sNumb = GetStringRight(sTrig, 3);
    string sDoor = "ufo_grvd" + sNumb;
    string sSpark = "ufo_grvs" + sNumb;
    object oDoor = GetObjectByTag(sDoor);
    object oSpark = GetObjectByTag(sSpark);

    DestroyObject(oDoor);
    DestroyObject(oSpark);
}
