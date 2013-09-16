#include "chessinc"

void main()
{
    int x,y,z;
    string sTemp;
    location lLoc;
    object oTemp, oArea, oCenterPoint;
    vector vLoc;
    float fxCenter, fyCenter, fSpacing, fFacing, fx, fy;

    SetLocalInt(OBJECT_SELF, "Turn", 1);
    SetLocalInt(OBJECT_SELF, "GameState", 1);
    SetLocalInt(OBJECT_SELF, "piecefight", 0);
    SetLocalInt(OBJECT_SELF, "enpassant", 0);
    SetLocalInt(OBJECT_SELF, "enpassantpos", 0);

    oArea = GetArea(OBJECT_SELF);

    oCenterPoint = GetNearestObjectByTag("centerpoint");
    vLoc = GetPosition(oCenterPoint);
    fxCenter = vLoc.x;
    fyCenter = vLoc.y;
    fFacing = GetFacing(oCenterPoint);
    // workaround to deal with bug in GetFacing
    if (fFacing > 360.0)
    {
        fFacing = 720 - fFacing;
    }
    SetLocalFloat(OBJECT_SELF, "facing", fFacing);

    fSpacing = 2.5;
    vLoc.z = 0.0;
    z = 0;
    for (x = 0; x < 8; x++)
    {
        fx = fSpacing * (x-4) + fSpacing/2;
        for (y = 7; y >= 0; y--)
        {
            fy = fSpacing * (y-4) + fSpacing/2;
            vLoc.x = fx*cos(fFacing) - fy*sin(fFacing) + fxCenter;
            vLoc.y = fy*cos(fFacing) + fx*sin(fFacing) + fyCenter;
            lLoc = Location(oArea, vLoc, 0.0);
            SetLocationArray(OBJECT_SELF, "lSquare", z, lLoc);
            SetIntArray(OBJECT_SELF, "nSquare", z, 0);
            SetObjectArray(OBJECT_SELF, "oSquare", z, OBJECT_SELF);
            z++;
        }
    }

    // set up white pawns
    for (x = 8; x < 16; x++)
    {
        lLoc = GetLocationArray(OBJECT_SELF, "lSquare", x);
        oTemp = CreateObject(OBJECT_TYPE_CREATURE, "pawn_w", lLoc);
        SetLocalInt(oTemp, "nPosition", x);
        SetIntArray(OBJECT_SELF, "nSquare", x, 1);
        SetObjectArray(OBJECT_SELF, "oSquare", x, oTemp);
    }

    // set up black pawns
    for (x = 48; x < 56; x++)
    {
        lLoc = GetLocationArray(OBJECT_SELF, "lSquare", x);
        oTemp = CreateObject(OBJECT_TYPE_CREATURE, "pawn_b", lLoc);
        SetLocalInt(oTemp, "nPosition", x);
        SetIntArray(OBJECT_SELF, "nSquare", x, -1);
        SetObjectArray(OBJECT_SELF, "oSquare", x, oTemp);
    }

    // set up white rooks
    lLoc = GetLocationArray(OBJECT_SELF, "lSquare", 0);
    oTemp = CreateObject(OBJECT_TYPE_CREATURE, "rook_w", lLoc);
    SetLocalInt(oTemp, "nPosition", 0);
    SetIntArray(OBJECT_SELF, "nSquare", 0, 2);
    SetObjectArray(OBJECT_SELF, "oSquare", 0, oTemp);
    lLoc = GetLocationArray(OBJECT_SELF, "lSquare", 7);
    oTemp = CreateObject(OBJECT_TYPE_CREATURE, "rook_w", lLoc);
    SetLocalInt(oTemp, "nPosition", 7);
    SetIntArray(OBJECT_SELF, "nSquare", 7, 2);
    SetObjectArray(OBJECT_SELF, "oSquare", 7, oTemp);

    // set up black rooks
    lLoc = GetLocationArray(OBJECT_SELF, "lSquare", 56);
    oTemp = CreateObject(OBJECT_TYPE_CREATURE, "rook_b", lLoc);
    SetLocalInt(oTemp, "nPosition", 56);
    SetIntArray(OBJECT_SELF, "nSquare", 56, -2);
    SetObjectArray(OBJECT_SELF, "oSquare", 56, oTemp);
    lLoc = GetLocationArray(OBJECT_SELF, "lSquare", 63);
    oTemp = CreateObject(OBJECT_TYPE_CREATURE, "rook_b", lLoc);
    SetLocalInt(oTemp, "nPosition", 63);
    SetIntArray(OBJECT_SELF, "nSquare", 63, -2);
    SetObjectArray(OBJECT_SELF, "oSquare", 63, oTemp);

    // set up white knights
    lLoc = GetLocationArray(OBJECT_SELF, "lSquare", 1);
    oTemp = CreateObject(OBJECT_TYPE_CREATURE, "knight_w", lLoc);
    SetLocalInt(oTemp, "nPosition", 1);
    SetIntArray(OBJECT_SELF, "nSquare", 1, 3);
    SetObjectArray(OBJECT_SELF, "oSquare", 1, oTemp);
    lLoc = GetLocationArray(OBJECT_SELF, "lSquare", 6);
    oTemp = CreateObject(OBJECT_TYPE_CREATURE, "knight_w", lLoc);
    SetLocalInt(oTemp, "nPosition", 6);
    SetIntArray(OBJECT_SELF, "nSquare", 6, 3);
    SetObjectArray(OBJECT_SELF, "oSquare", 6, oTemp);

    // set up black knights
    lLoc = GetLocationArray(OBJECT_SELF, "lSquare", 57);
    oTemp = CreateObject(OBJECT_TYPE_CREATURE, "knight_b", lLoc);
    SetLocalInt(oTemp, "nPosition", 57);
    SetIntArray(OBJECT_SELF, "nSquare", 57, -3);
    SetObjectArray(OBJECT_SELF, "oSquare", 57, oTemp);
    lLoc = GetLocationArray(OBJECT_SELF, "lSquare", 62);
    oTemp = CreateObject(OBJECT_TYPE_CREATURE, "knight_b", lLoc);
    SetLocalInt(oTemp, "nPosition", 62);
    SetIntArray(OBJECT_SELF, "nSquare", 62, -3);
    SetObjectArray(OBJECT_SELF, "oSquare", 62, oTemp);

    // set up white bishops
    lLoc = GetLocationArray(OBJECT_SELF, "lSquare", 2);
    oTemp = CreateObject(OBJECT_TYPE_CREATURE, "bishop_w", lLoc);
    SetLocalInt(oTemp, "nPosition", 2);
    SetIntArray(OBJECT_SELF, "nSquare", 2, 4);
    SetObjectArray(OBJECT_SELF, "oSquare", 2, oTemp);
    lLoc = GetLocationArray(OBJECT_SELF, "lSquare", 5);
    oTemp = CreateObject(OBJECT_TYPE_CREATURE, "bishop_w", lLoc);
    SetLocalInt(oTemp, "nPosition", 5);
    SetIntArray(OBJECT_SELF, "nSquare", 5, 4);
    SetObjectArray(OBJECT_SELF, "oSquare", 5, oTemp);

    // set up black bishops
    lLoc = GetLocationArray(OBJECT_SELF, "lSquare", 58);
    oTemp = CreateObject(OBJECT_TYPE_CREATURE, "bishop_b", lLoc);
    SetLocalInt(oTemp, "nPosition", 58);
    SetIntArray(OBJECT_SELF, "nSquare", 58, -4);
    SetObjectArray(OBJECT_SELF, "oSquare", 58, oTemp);
    lLoc = GetLocationArray(OBJECT_SELF, "lSquare", 61);
    oTemp = CreateObject(OBJECT_TYPE_CREATURE, "bishop_b", lLoc);
    SetLocalInt(oTemp, "nPosition", 61);
    SetIntArray(OBJECT_SELF, "nSquare", 61, -4);
    SetObjectArray(OBJECT_SELF, "oSquare", 61, oTemp);

    // set up white queen and king
    lLoc = GetLocationArray(OBJECT_SELF, "lSquare", 3);
    oTemp = CreateObject(OBJECT_TYPE_CREATURE, "queen_w", lLoc);
    SetLocalInt(oTemp, "nPosition", 3);
    SetIntArray(OBJECT_SELF, "nSquare", 3, 5);
    SetObjectArray(OBJECT_SELF, "oSquare", 3, oTemp);
    lLoc = GetLocationArray(OBJECT_SELF, "lSquare", 4);
    oTemp = CreateObject(OBJECT_TYPE_CREATURE, "king_w", lLoc);
    SetLocalInt(oTemp, "nPosition", 4);
    SetIntArray(OBJECT_SELF, "nSquare", 4, 6);
    SetObjectArray(OBJECT_SELF, "oSquare", 4, oTemp);

    // set up black queen and king
    lLoc = GetLocationArray(OBJECT_SELF, "lSquare", 59);
    oTemp = CreateObject(OBJECT_TYPE_CREATURE, "queen_b", lLoc);
    SetLocalInt(oTemp, "nPosition", 59);
    SetIntArray(OBJECT_SELF, "nSquare", 59, -5);
    SetObjectArray(OBJECT_SELF, "oSquare", 59, oTemp);
    lLoc = GetLocationArray(OBJECT_SELF, "lSquare", 60);
    oTemp = CreateObject(OBJECT_TYPE_CREATURE, "king_b", lLoc);
    SetLocalInt(oTemp, "nPosition", 60);
    SetIntArray(OBJECT_SELF, "nSquare", 60, -6);
    SetObjectArray(OBJECT_SELF, "oSquare", 60, oTemp);

    // set up array for notation
    z=0;
    for(y=1;y<9;y++) {
        for(x=1;x<9;x++) {
            switch(x) {
                case 1: sTemp="a"; break;
                case 2: sTemp="b"; break;
                case 3: sTemp="c"; break;
                case 4: sTemp="d"; break;
                case 5: sTemp="e"; break;
                case 6: sTemp="f"; break;
                case 7: sTemp="g"; break;
                case 8: sTemp="h"; break;
            }
            sTemp=sTemp+IntToString(y);
            SetStringArray(OBJECT_SELF, "sNotation", z, sTemp);
            z++;
        }
    }
}
