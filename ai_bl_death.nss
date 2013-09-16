#include "engine"
#include "inc_nametag"
#include "inc_blades"

void main()
{
    //object oOwner = GetLocalObject(OBJECT_SELF, "BladeOwner");
    //object oWeapon = GetObjectByTag("BLD_WEP_" + GenerateTagFromName(oOwner));
    //AssignCommand(GetObjectByTag("BladeHolder"), ActionGiveItem(oWeapon, oOwner));
    AssignCommand(GetObjectByTag("BladeHolder"), ReturnBlade(GetLocalString(OBJECT_SELF, "BladeOwner")));
}
