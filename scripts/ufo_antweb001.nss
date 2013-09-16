#include "engine"

//void GlowOn();
void ResetWeb();

void main()
{
    object oPC = GetEnteringObject();
    int nFired = GetLocalInt(OBJECT_SELF, "IsFired");

    if(nFired == 0 && GetIsPC(oPC))
    {
        int nCount = 1;
        string sTrgTag = GetTag(OBJECT_SELF);
        string sTrgNum = GetStringRight(sTrgTag, 3); //This is the number of the encounter (001, 002, etc)
        string sWayTag = "ufo_plc_web" + sTrgNum;
        string sNewWeb = "ufo_ant_web" + sTrgNum;

        effect eSplash = EffectVisualEffect(257);

        while(nCount < 4)
        {
            object oWP = GetNearestObjectByTag(sWayTag, oPC, nCount);
            location lWP = GetLocation(oWP);

            CreateObject(OBJECT_TYPE_PLACEABLE, "ufo_ant_web001", lWP, FALSE, sNewWeb);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eSplash, lWP);
            nCount ++;
        }

        SetLocalInt(OBJECT_SELF, "IsFired", 1);
        DelayCommand(2400.0f, ResetWeb());
    }
}


void ResetWeb()
{
    SetLocalInt(OBJECT_SELF, "IsFired", 0);
}

//void GlowOn()
//{
//    string sNewWeb;
//    object oGlow = GetObjectByTag(sNewWeb);
//    effect eGlow = EffectVisualEffect(558);
//
//    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGlow, oGlow);
//}
