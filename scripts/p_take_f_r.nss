#include "chessinc"

void main()
{
    int nSide, nPosition, nNewPosition;

    nSide=GetLocalInt(GetNearestObjectByTag("gamemaster"), "Turn");

    nPosition = GetLocalInt(OBJECT_SELF, "nPosition");
    nNewPosition = nPosition + 9*nSide;
    TakePiece(nPosition, nNewPosition);
    if (GetLocalInt(OBJECT_SELF, "nPosition") == nNewPosition)
    {
        if (nNewPosition > 55 || nNewPosition < 8) SetLocalInt(OBJECT_SELF, "promote", 1);
    }
}
