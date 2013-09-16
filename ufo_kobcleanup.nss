#include "engine"

void main()
{
    object oPC = GetEnteringObject();
    string sState = GetTag(OBJECT_SELF);

    if(GetIsPC(oPC))
    {
            int nState = GetLocalInt(oPC, "BTEKobold01");

            if(nState = 1)
            {
                DeleteLocalInt(oPC, "BTEKobold01");

                object oWP1 = GetObjectByTag("PLC_KOBBAR001");
                object oWP2 = GetObjectByTag("PLC_KOBBAR002");
                object oWP3 = GetObjectByTag("PLC_KOBBAR003");
                object oWP4 = GetObjectByTag("PLC_KOBBAR004");
                object oWP5 = GetObjectByTag("PLC_KOBBAR005");
                object oWP6 = GetObjectByTag("PLC_KOBBAR006");
                object oWP7 = GetObjectByTag("PLC_KOBBAR007");
                object oWP8 = GetObjectByTag("PLC_KOBBAR008");
                object oBar1 = GetNearestObjectByTag("KobBarrier1", oWP1);
                object oBar2 = GetNearestObjectByTag("KobBarrier2", oWP2);
                object oBar3 = GetNearestObjectByTag("KobBarrier3", oWP3);
                object oBar4 = GetNearestObjectByTag("KobBarrier4", oWP4);
                object oBar5 = GetNearestObjectByTag("KobBarrier5", oWP5);
                object oBar6 = GetNearestObjectByTag("KobBarrier6", oWP6);
                object oBar7 = GetNearestObjectByTag("KobBarrier7", oWP7);
                object oBar8 = GetNearestObjectByTag("KobBarrier8", oWP8);

                DestroyObject(oBar1);
                DestroyObject(oBar2);
                DestroyObject(oBar3);
                DestroyObject(oBar4);
                DestroyObject(oBar5);
                DestroyObject(oBar6);
                DestroyObject(oBar7);
                DestroyObject(oBar8);
            }
    }
}
