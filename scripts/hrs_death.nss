/*
    Horse death script
    by Hardcore UFO
    Will remove the Horse Active variable on the owner.
    Will change the tag of the widget so it triggers a different script.
*/

#include "engine"

void main()
{
    DeleteLocalObject(GetLocalObject(OBJECT_SELF, "HorseOwner"), "HorseActive");
    SetTag(GetLocalObject(GetLocalObject(OBJECT_SELF, "HorseOwner"), "HorseWidget"), "hrs_wgt000");
}
