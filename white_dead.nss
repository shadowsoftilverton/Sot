void main()
{
    object attacker=GetLocalObject(OBJECT_SELF, "attacker");
    SetLocalInt(GetObjectByTag("gamemaster"), "piecefight", 0);
    SetLocalInt(attacker, "fighting", 0);
    AssignCommand(attacker, ClearAllActions());

    // Place a flag in the flag area...
    object oArea = GetArea(OBJECT_SELF);
    int nSpot = GetLocalInt(oArea, "FLAG_NUM");
    string sString = "FlagHolder" + IntToString(nSpot);
    object oObject = GetObjectByTag(sString);
    location lLoc = GetLocation(oObject);

    CreateObject(OBJECT_TYPE_PLACEABLE, "blackflag", lLoc);

    nSpot++;
    SetLocalInt(oArea, "FLAG_NUM", nSpot);

    object oBlackPillar = GetObjectByTag("BlackPillar");
    object oWhitePillar = GetObjectByTag("WhitePillar");

    int nBlackCount = GetLocalInt(oArea, "BLACK_COUNT");
    int nWhiteCount = GetLocalInt(oArea, "WHITE_COUNT");
    nBlackCount++;

    SetLocalInt(oArea, "BLACK_COUNT", nBlackCount);

    if (nWhiteCount < nBlackCount)
    {
        if (GetLocalInt(oBlackPillar, "ACTIVATED") != 1)
        {
            AssignCommand(oBlackPillar,  PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
            SetLocalInt(oBlackPillar, "ACTIVATED", 1);
        }
        if (GetLocalInt(oWhitePillar, "ACTIVATED") != 0)
        {
            AssignCommand(oWhitePillar,  PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
            SetLocalInt(oWhitePillar, "ACTIVATED", 0);
        }
    }
    else if (nWhiteCount == nBlackCount)
    {
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
    }
}
