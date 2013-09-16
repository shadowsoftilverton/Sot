#include "engine"

void main()
{
    int nTrigger = GetLocalInt(OBJECT_SELF, "Triggered");
    object oPC = GetEnteringObject();

    if(nTrigger == 0)
    {
        object oWP1 = GetObjectByTag("PLC_KOBBAR001");
        object oWP2 = GetObjectByTag("PLC_KOBBAR002");
        object oWP3 = GetObjectByTag("PLC_KOBBAR003");
        object oWP4 = GetObjectByTag("PLC_KOBBAR004");
        object oWP5 = GetObjectByTag("PLC_KOBBAR005");
        object oWP6 = GetObjectByTag("PLC_KOBBAR006");
        object oWP7 = GetObjectByTag("PLC_KOBBAR007");
        object oWP8 = GetObjectByTag("PLC_KOBBAR008");
        location lWP1 = GetLocation(oWP1);
        location lWP2 = GetLocation(oWP2);
        location lWP3 = GetLocation(oWP3);
        location lWP4 = GetLocation(oWP4);
        location lWP5 = GetLocation(oWP5);
        location lWP6 = GetLocation(oWP6);
        location lWP7 = GetLocation(oWP7);
        location lWP8 = GetLocation(oWP8);

        CreateObject(OBJECT_TYPE_PLACEABLE, "ufo_kobbar", lWP1, FALSE, "KobBarrier1");
        CreateObject(OBJECT_TYPE_PLACEABLE, "ufo_kobbar", lWP2, FALSE, "KobBarrier2");
        CreateObject(OBJECT_TYPE_PLACEABLE, "ufo_kobbar", lWP3, FALSE, "KobBarrier3");
        CreateObject(OBJECT_TYPE_PLACEABLE, "ufo_kobbar", lWP4, FALSE, "KobBarrier4");
        CreateObject(OBJECT_TYPE_PLACEABLE, "ufo_kobbar", lWP5, FALSE, "KobBarrier5");
        CreateObject(OBJECT_TYPE_PLACEABLE, "ufo_kobbar", lWP6, FALSE, "KobBarrier6");
        CreateObject(OBJECT_TYPE_PLACEABLE, "ufo_kobbar", lWP7, FALSE, "KobBarrier7");
        CreateObject(OBJECT_TYPE_PLACEABLE, "ufo_kobbar", lWP8, FALSE, "KobBarrier8");

        SetLocalInt(oPC, "BTEKobold01", 1);
        SetLocalInt(OBJECT_SELF, "Triggered", 1);
        DelayCommand(1800.0f, DeleteLocalInt(OBJECT_SELF, "Triggered"));
    }
}
