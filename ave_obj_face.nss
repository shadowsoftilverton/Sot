#include "ave_wep_inc"

void main()
{
    object oWep=OBJECT_SELF;
    int iFace=GetWeaponInt(oWep,1,"wep_rotate");
    SetFacing(IntToFloat(iFace)-90);//-90 because placeables are retarded
}
