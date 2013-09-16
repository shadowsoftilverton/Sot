#include "chessinc"

void main()
{
    // Clean everything up.

    int x;
    object oPiece,oTarget;
    for (x=0;x<64;x++)
    {
        oPiece = GetObjectArray(OBJECT_SELF, "oSquare", x);
        oTarget = GetLocalObject(oPiece, "target");
        if(GetIsObjectValid(oTarget)) DestroyObject(oTarget);
        if(oPiece!=OBJECT_SELF && GetIsObjectValid(oPiece)) DestroyObject(oPiece);
    }

    int i;
    object oFlag;
    for ( i = 0; i < 16; i++ )
    {
        oFlag = GetObjectByTag("blackflag", i);
        if (GetIsObjectValid(oFlag)) DestroyObject(oFlag);
        oFlag = GetObjectByTag("whiteflag", i);
        if (GetIsObjectValid(oFlag)) DestroyObject(oFlag);
    }

    object oDragon = GetObjectByTag("WhiteDragon");
    if (GetIsObjectValid(oDragon)) DestroyObject(oDragon);

    oDragon = GetObjectByTag("BlackDragon");
    if (GetIsObjectValid(oDragon)) DestroyObject(oDragon);

    object oArea = GetArea(OBJECT_SELF);

    // Turn off fire pillars if they are on
    object oBlackPillar = GetObjectByTag("BlackPillar");
    object oWhitePillar = GetObjectByTag("WhitePillar");

    if (GetLocalInt(oBlackPillar, "ACTIVATED") != 0)
    {
        AssignCommand(oBlackPillar,  PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
        SetLocalInt(oBlackPillar, "ACTIVATED", 0);
    }

    if (GetLocalInt(oWhitePillar, "ACTIVATED") != 0)
    {
        AssignCommand(oWhitePillar,  PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
        SetLocalInt(oWhitePillar, "ACTIVATED", 0);
    }

    SetLocalInt(oArea, "BLACK_COUNT", 0);
    SetLocalInt(oArea, "WHITE_COUNT", 0);
    SetLocalInt(oArea, "FLAG_NUM", 0);
    SetLocalInt(OBJECT_SELF, "GameState", 0);
    SetLocalInt(OBJECT_SELF, "nWhiteAssigned", 0);
    SetLocalObject(OBJECT_SELF, "oWhitePlayer", OBJECT_INVALID);
    SetLocalInt(OBJECT_SELF, "nBlackAssigned", 0);
    SetLocalObject(OBJECT_SELF, "oBlackPlayer", OBJECT_INVALID);

    // in theory I should delete all the locals, but I'm lazy
}
