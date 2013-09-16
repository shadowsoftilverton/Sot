#include "engine"

// This script causes a unique behavior such that when fired it will destroy all
// objects with its host's tag, including its host. This will destroy stuff
// even if it's flagged as plot.
void main()
{
    string sTag = GetTag(OBJECT_SELF);

    int i = 0;

    object oObj = GetObjectByTag(sTag, i++);

    while(GetIsObjectValid(oObj)){
        SetPlotFlag(oObj, FALSE);

        DestroyObject(oObj);

        oObj = GetObjectByTag(sTag, i++);
    }
}
